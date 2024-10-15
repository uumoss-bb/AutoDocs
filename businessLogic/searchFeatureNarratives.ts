import shell from 'shelljs'
import { selectTruthyItems } from '../shared/selectors'
import { normalizeNarrative } from '../shared/normalizers';

type FullLineNarrative = { path: string, fileName: string, lineNumber: number, narrative: string }
type ExtractedNarrativeDetails = { [fileName: string]: FullLineNarrative[] }

const extractNarrativeDetails = (details: string) => {
  const regex = /^([^\/]+)\/([^:]+):(\d+)$/;
  const match = details.match(regex);
  if(match) {
    return {
      path: match[1],
      fileName:  match[2],
      lineNumber:  Number(match[3])
    }
  } else {
    console.log("Failed to extract narrative details: ", details)
  }
}

const searchFeatureNarratives = () => {
  shell.config.silent = true
  shell.config.fatal = true

  const narrativeSearchResult = shell.exec('grep -r -n --include="*.feature" -E "Scenario|Given|And|When|Then" .').stdout
  const narrativeLinesInArray = narrativeSearchResult.split('./testEnv/').filter(selectTruthyItems)
  const extractedNarrativeDetails = narrativeLinesInArray.reduce((prevValue, line) => {
    const lineDetailsAndString = line.split(': ')
    const lineDetails = extractNarrativeDetails(lineDetailsAndString[0])
    if(lineDetails) {
      const { path, fileName, lineNumber } = lineDetails
      const narrative = normalizeNarrative(lineDetailsAndString[1])
      const fullLineNarrative = { path, fileName, lineNumber, narrative }
      const prevFileNarrative = prevValue[fileName]
      const fileNarrative = prevFileNarrative ? [ ...prevFileNarrative, fullLineNarrative ] : [ fullLineNarrative ]
      return {
        ...prevValue,
        [fileName]: fileNarrative
      }
    }
    return prevValue
  }, {} as ExtractedNarrativeDetails)
  console.log(extractedNarrativeDetails)
}

export default searchFeatureNarratives

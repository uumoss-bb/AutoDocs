import shell from 'shelljs'
import { selectTruthyItems } from '../shared/selectors'

type FullLineNarrative = { path: string, fileName: string, lineNumber: number, narrative: string }
type ExtractedNarrativeDetails = { [fileName: string]: FullLineNarrative[] }

const normalizeNarrative = (narrative: string, lineDetails: string) =>
  narrative.replace(lineDetails, '')
  .replace(/[^a-zA-Z\s]/g, '')
  .trim()


export const getLineDetail = (line: string) => {
  //This needs to be tested to see what happens with deeply nested features
  const regex = /^([a-zA-Z0-9_\-/]+\.feature:\d+):\s/;
  const match = line.match(regex);
  if(match) {
    return match[1]
  } else {
    console.warn("Failed to getLinDetails: ", line)
  }
}

export const getSpecificDetails = (details: string) => {
  //This needs to be tested to see what happens with deeply nested features
  const regex = /^([^\/]+)\/((?:.+\/)*)\/?([^\/]+\.feature):(\d+)$/;
  const match = details.match(regex);
  if(match) {
    return {
      repoName: match[1],
      path: `${match[1]}/${match[2]}`,
      fileName:  match[3],
      lineNumber:  Number(match[4])
    }
  } else {
    console.warn("Failed to getSpecificDetails: ", details)
    return {
      path: 'missing',
      fileName:  'missing',
      lineNumber:  -1
    }
  }
}

const searchFeatureNarratives = () => {
  shell.config.silent = true
  shell.config.fatal = true

  const narrativeSearchResult = shell.exec('grep -r -n --include="*.feature" -E "Scenario|Given|And|When|Then" .').stdout
  const narrativeLinesInArray = narrativeSearchResult.split('./testEnv/').filter(selectTruthyItems)
  const extractedNarrativeDetails = narrativeLinesInArray.reduce((prevValue, line) => {
    const lineDetails = getLineDetail(line)
    if(lineDetails) {
      const { fileName, ...otherDetails } = getSpecificDetails(lineDetails)
      const narrative = normalizeNarrative(line, lineDetails)
      const fullLineNarrative = { fileName, narrative, ...otherDetails }
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

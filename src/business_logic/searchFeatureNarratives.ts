import shell from 'shelljs'
import { selectTruthyItems } from '../shared/selectors'
import { parseGrepResult, prettyJSON } from '../shared/normalizers'

type LineNarrative = { repoName: string, path: string, fileName: string, lineNumber: number|string, fileLine: string }
type narrativeDetails = { [fileName: string]: LineNarrative[] }

const grepCommand = 'grep -r -n --include="*.feature" --exclude-dir=node_modules -E "Scenario|Given|And|When|Then" .'

const getNarrativeDetails = (searchResultInArray: string[]) => searchResultInArray.reduce((prevValue, line) => {
  const { fileName, ...otherDetails } = parseGrepResult(line)
  const lineNarrative =  { fileName, ...otherDetails }
  const prevFileNarrative = prevValue[fileName]
  const fileNarrative = prevFileNarrative ? [ ...prevFileNarrative, lineNarrative ] : [ lineNarrative ]
  return {
    ...prevValue,
    [fileName]: fileNarrative
  }
}, {} as narrativeDetails)

const searchFeatureNarratives = () => {
  shell.config.silent = true
  shell.config.fatal = true

  const narrativeSearchResult = shell.exec(grepCommand).stdout
  const searchResultInArray = narrativeSearchResult.split('./').filter(selectTruthyItems)
  const narrativeDetails = getNarrativeDetails(searchResultInArray)
  return narrativeDetails
}

export default searchFeatureNarratives

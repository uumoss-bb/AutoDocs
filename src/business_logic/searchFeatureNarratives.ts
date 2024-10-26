import shell from 'shelljs'
import { selectTruthyItems } from '../shared/selectors'
import { prettyJSON } from '../shared/normalizers'

type LineNarrative = { path: string, fileName: string, lineNumber: number, narrative: string }
type narrativeDetails = { [fileName: string]: LineNarrative[] }

const normalizeNarrative = (narrative: string) =>
  narrative.trim()

const normalizeParsedData = (data: RegExpMatchArray|null) => data ? data[1] : 'missing'

export const parseLine = (line: string) => {
  const repoRegex = /^([^/]+)/;
  const pathRegex = /\/((?:[^/]+\/)*)[^/]+\.feature/;
  const fileNameRegex = /([^/]+\.feature)/;
  const lineNumberRegex = /:(\d+):/;
  const narrativeRegex = /(?<=:\d+:\s)(.+)/;

  const repoMatch = line.match(repoRegex);
  const pathMatch = line.match(pathRegex);
  const fileNameMatch = line.match(fileNameRegex);
  const lineNumberMatch = line.match(lineNumberRegex);
  const narrativeMatch = line.match(narrativeRegex);

  return {
    repoName: normalizeParsedData(repoMatch),
    path: normalizeParsedData(pathMatch),
    fileName: normalizeParsedData(fileNameMatch),
    lineNumber: Number(
      normalizeParsedData(lineNumberMatch)
    ),
    narrative: normalizeNarrative(
      normalizeParsedData(narrativeMatch)
    )
  };
};

const getNarrativeDetails = (searchResultInArray: string[]) => searchResultInArray.reduce((prevValue, line) => {
  const { fileName, ...otherDetails } = parseLine(line)
  const lineNarrative =  { fileName, ...otherDetails }
  const prevFileNarrative = prevValue[fileName]
  const fileNarrative = prevFileNarrative ? [ ...prevFileNarrative, lineNarrative ] : [ lineNarrative ]
  return {
    ...prevValue,
    [fileName]: fileNarrative
  }
}, {} as narrativeDetails)

const searchFeatureNarratives = (rootFolder: string) => {
  shell.config.silent = true
  shell.config.fatal = true

  const narrativeSearchResult = shell.exec('grep -r -n --include="*.feature" -E "Scenario|Given|And|When|Then" .').stdout
  const searchResultInArray = narrativeSearchResult.split(rootFolder).filter(selectTruthyItems)
  const narrativeDetails = getNarrativeDetails(searchResultInArray)
  return narrativeDetails
}

export default searchFeatureNarratives

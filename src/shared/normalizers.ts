
const dateOptions: any = {
  weekday: 'short',
  year: 'numeric',
  month: 'long',
  day: "2-digit",
};

const replaceSpacesWithUnderscores = (text: string = 'missing text') => text.replace(/\s+/g, '_');

const convertDate = {
  'milliseconds': (date: string) => new Date(date).getTime(),
  'full': (date: number) => new Date(date).toLocaleDateString('en-us', dateOptions)
}

const prettyJSON = (data: object) => JSON.stringify(data, null, 2)

const parseGrepResult = (line: string) => {
  const normalizeParsedData = (data: RegExpMatchArray|null) => data ? data[1] : 'missing'
  const normalizeFileLine = (narrative: string) => narrative.trim()

  const repoRegex = /^([^/]+)/;
  const pathRegex = /\/((?:[^/]+\/)*)[^/]+(?:\.features|\.graphql)?/;
  const fileNameRegex = /([^/]+(?:\.features|\.graphql)?)/;
  const lineNumberRegex = /:(\d+):/;
  const fileLineRegex = /(?<=:\d+:\s)(.+)/;

  const repoMatch = line.match(repoRegex);
  const pathMatch = line.match(pathRegex);
  const fileNameMatch = line.match(fileNameRegex);
  const lineNumberMatch = line.match(lineNumberRegex);
  const fileLineMatch = line.match(fileLineRegex);

  return {
    repoName: normalizeParsedData(repoMatch),
    path: normalizeParsedData(pathMatch),
    fileName: normalizeParsedData(fileNameMatch),
    lineNumber: Number( normalizeParsedData(lineNumberMatch) ),
    fileLine: normalizeFileLine( normalizeParsedData(fileLineMatch) )
  };
};

export {
  replaceSpacesWithUnderscores,
  convertDate,
  prettyJSON,
  parseGrepResult
}

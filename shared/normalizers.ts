
const dateOptions: any = {
  weekday: 'short',
  year: 'numeric',
  month: 'long',
  day: "2-digit",
};

const normalizeNarrative = (text: string = 'missing text') => text.trim().replace('\n', '')

const replaceSpacesWithUnderscores = (text: string = 'missing text') => text.replace(/\s+/g, '_');

const convertDate = {
  'milliseconds': (date: string) => new Date(date).getTime(),
  'full': (date: number) => new Date(date).toLocaleDateString('en-us', dateOptions)
}

const prettyJSON = (data: object) => JSON.stringify(data, null, 2)

export {
  replaceSpacesWithUnderscores,
  normalizeNarrative,
  convertDate,
  prettyJSON
}

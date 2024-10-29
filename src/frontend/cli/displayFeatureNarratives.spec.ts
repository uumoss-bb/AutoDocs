import shell from 'shelljs'
import extractFeatureNarratives from '../../workers/extractFeatureNarratives'

it("ALPHA PROTOCOL", () => {
  const narrativeDetails = extractFeatureNarratives()

  const narrativeDetailsArray = Object.keys(narrativeDetails)
  narrativeDetailsArray.forEach(fileName => {
    shell.echo(`\n\tThe story behind ${fileName}`)
    narrativeDetails[fileName].forEach(lineNarrative => {
      const { fileLine, lineNumber } = lineNarrative
      if(fileLine.includes('Scenario')) {
        shell.echo(`\n\t${lineNumber}: ${fileLine}`)
      } else {
        shell.echo(`\t\t${lineNumber}: ${fileLine}`)
      }
    })
  })
})


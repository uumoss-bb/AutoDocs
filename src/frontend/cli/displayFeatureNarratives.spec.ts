import shell from 'shelljs'
import extractFeatureNarratives from '../../workers/extractFeatureNarratives'

it("ALPHA PROTOCOL", () => {
  const narrativeDetails = extractFeatureNarratives('./testEnv/')

  const narrativeDetailsArray = Object.keys(narrativeDetails)
  narrativeDetailsArray.forEach(fileName => {
    shell.echo(`\n\tThe story behind ${fileName}`)
    narrativeDetails[fileName].forEach(lineNarrative => {
      const { narrative, lineNumber } = lineNarrative
      if(narrative.includes('Scenario')) {
        shell.echo(`\n\t${lineNumber}: ${narrative}`)
      } else {
        shell.echo(`\t\t${lineNumber}: ${narrative}`)
      }
    })
  })
})

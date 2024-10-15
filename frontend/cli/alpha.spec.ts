import searchFeatureNarratives from '../../businessLogic/searchFeatureNarratives'
import shell from 'shelljs'

it("ALPHA PROTOCOL", () => {
  const narrativeDetails = searchFeatureNarratives()
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

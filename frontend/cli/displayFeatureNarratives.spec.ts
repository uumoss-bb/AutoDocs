import searchFeatureNarratives from '../../business_logic/searchFeatureNarratives'
import shell from 'shelljs'
import FileSystem from '../../backend/FileSystem'

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

  const writeNarrativeFileResult = FileSystem.writePersonalFile('feature_narratives', narrativeDetails)
  if(writeNarrativeFileResult.error) {
    console.log("FAILED TO WRITE NARRATIVE FILE")
  }
})

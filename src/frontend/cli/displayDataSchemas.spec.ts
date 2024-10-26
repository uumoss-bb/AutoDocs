import searchDataSchemas from "../../business_logic/searchDataSchemas";
import shell from 'shelljs'
import { prettyJSON } from "../../shared/normalizers";

it('Display Data Schema', () => {
  const dataSchemas = searchDataSchemas()
  const fileNames = Object.keys(dataSchemas)
  shell.echo(prettyJSON(fileNames))
  for (const [fileName, schema] of Object.entries(dataSchemas)) {
    shell.echo('---------------------------')
    shell.echo(`\n\t${fileName}`)
    shell.echo(`\n${schema}`)
  }
})

import extractDataSchemas from "../../workers/extractDataSchemas";
import shell from 'shelljs'
import { prettyJSON } from "../../shared/normalizers";

it('Display Data Schema', () => {
  const dataSchemas = extractDataSchemas()
  const fileNames = Object.keys(dataSchemas)
  shell.echo(prettyJSON(fileNames))
  for (const [fileName, fileInfo] of Object.entries(dataSchemas)) {
    const { schema } = fileInfo
    shell.echo('---------------------------')
    shell.echo(`\n\t${fileName}`)
    shell.echo(`\n${schema}`)
  }
})

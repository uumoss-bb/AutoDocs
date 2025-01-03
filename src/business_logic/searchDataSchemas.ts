import shell from 'shelljs'
import { selectTruthyItems } from '../shared/selectors'
import { parseGrepResult } from '../shared/normalizers'

type DataSchema = { repoName: string, path: string, fileName: string, schema: string }
type DataSchemaFiles = { [fileName: string]: DataSchema }

const findCommand = 'find . -type f -name "*.graphql"'

const getDataSchemasByFileName = (filePaths: string[]) =>
  filePaths.reduce((prevValue, filePath) => {
    if(filePath.includes('.graphql')) {
      const schema = shell.cat(filePath).stdout
      const { fileName, repoName, path,} = parseGrepResult(filePath)

      return {
        ...prevValue,
        [`${repoName}/${path}/${fileName}`]: {
          fileName,
          repoName,
          path,
          schema
        }
      }
    }
    return prevValue
  }, {} as DataSchemaFiles)

const searchDataSchemas = () => {
  shell.config.silent = true
  shell.config.fatal = true

  const findCommandResult  = shell.exec(findCommand).stdout
  const filePaths = findCommandResult.split('./').filter(selectTruthyItems)
  const dataSchemas = getDataSchemasByFileName(filePaths)
  return dataSchemas
}

export default searchDataSchemas

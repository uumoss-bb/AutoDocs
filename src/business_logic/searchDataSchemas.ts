import shell from 'shelljs'
import { selectTruthyItems } from '../shared/selectors'

type DataSchemaFiles = { [fileName: string]: string }

const sourceOfTruth = './testEnv/titan/monoql/app/graphql/schema/types'

const getDataSchemasByFileName = (filePaths: string[]) =>
  filePaths.reduce((prevValue, fileName) => {
    if(fileName.includes('.graphql')) {
      const typeDefs = shell.cat(filePaths).stdout
      return {
        ...prevValue,
        [fileName]: typeDefs
      }
    }
    return prevValue
  }, {} as DataSchemaFiles)

const getSchemaFilePaths = () => {
  const filesInSourceOfTruth  = shell.exec(`find . -type f -name "*.graphql" `).stdout
  const filePaths = filesInSourceOfTruth.split('./').filter(selectTruthyItems)
  return filePaths
}

const searchDataSchemas = () => {
  shell.config.silent = true
  shell.config.fatal = true

  const filePaths = getSchemaFilePaths()
  const dataSchemas = getDataSchemasByFileName(filePaths)
  return dataSchemas
}

export default searchDataSchemas

import shell from 'shelljs'
import { selectTruthyItems } from '../shared/selectors'

type DataSchemaFiles = { [fileName: string]: string }

const sourceOfTruth = './testEnv/titan/monoql/app/graphql/schema/types'

const getDataSchemasByFileName = (fileNames: string[]) =>
  fileNames.reduce((prevValue, fileName) => {
    if(fileName.includes('.graphql')) {
      const typeDefs = shell.cat(`${sourceOfTruth}/${fileName}`).stdout
      return {
        ...prevValue,
        [fileName]: typeDefs
      }
    }
    return prevValue
  }, {} as DataSchemaFiles)

const getFileNamesFromSources = () => {
  const filesInSourceOfTruth  = shell.exec(`cd ${sourceOfTruth} && ls`).stdout
  const fileNames = filesInSourceOfTruth.split('\n').filter(selectTruthyItems)
  return fileNames
}

const searchDataSchemas = () => {
  shell.config.silent = true
  shell.config.fatal = true

  const fileNames = getFileNamesFromSources()
  const dataSchemas = getDataSchemasByFileName(fileNames)
  return dataSchemas
}

export default searchDataSchemas

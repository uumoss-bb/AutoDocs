import { makeExecutableSchema } from '@graphql-tools/schema'
import { addMocksToSchema } from '@graphql-tools/mock'
import shell from 'shelljs'
import { selectTruthyItems } from '../shared/selectors'

type DataSchemaFiles = { [fileName: string]: string }

const getSpecificDetails = (fileSegment: string) => {
  const regex = /\/([^:]+):(.+)/;
  const match = fileSegment.match(regex);

  if (match) {
    return {
      fileName: match[1],
      line: match[2]
    }
  } else {
    console.log('Failed to getSpecificDetails', fileSegment);
    return {
      fileName: 'missing',
      line: 'missing'
    }
  }
}

// const searchDataSchemas = () => {
  // shell.config.silent = true
  // shell.config.fatal = true

//   const sourceOfTruth = './testEnv/titan/monoql/app/graphql/schema/types'
//   const searchResult = shell.exec(`grep -r --include="*.graphql" -E ".*" ${sourceOfTruth}`).stdout
//   const searchResultArray = searchResult.split(sourceOfTruth).filter(selectTruthyItems)
//   const dataSchemaFiles = searchResultArray.reduce((prevValue, fileSegment) => {
//     console.log("seg", fileSegment)
//     const { fileName, line } = getSpecificDetails(fileSegment)
//     const prevFileLines = prevValue[fileName]
//     const fileLines = prevFileLines ? prevFileLines.concat(line) : line

//     if(fileName === 'missing') {
//       return prevValue
//     }

//     return {
//       ...prevValue,
//       [fileName] : fileLines
//     }
//   }, {} as DataSchemaFiles)
//   console.log(JSON.stringify(dataSchemaFiles['campaign.graphql']))
//   const schema = makeExecutableSchema({ typeDefs: dataSchemaFiles['campaign.graphql'] });
// }

const searchDataSchemas = () => {
  shell.config.silent = true
  shell.config.fatal = true

  const sourceOfTruth = './testEnv/titan/monoql/app/graphql/schema/types'
  const filesInSourceOfTruth  = shell.exec(`cd ${sourceOfTruth} && ls`).stdout
  const fileNames = filesInSourceOfTruth.split('\n').filter(selectTruthyItems)
  fileNames.reduce((prevValue, fileName, index) => {
    if(fileName.includes('.graphql') && index === 0) {
      const typeDefs = shell.cat(`${sourceOfTruth}/${fileName}`).stdout
      console.log(typeDefs)
      const schema = makeExecutableSchema({ typeDefs });
    }
    return prevValue
  }, {})
}

export default searchDataSchemas

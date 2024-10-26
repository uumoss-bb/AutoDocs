import searchFeatureNarratives from "../business_logic/searchFeatureNarratives"
import FileSystem from "../backend/FileSystem"
import shell from 'shelljs'
import { prettyJSON } from "../shared/normalizers"

const extractFeatureNarratives = (rootFolder: string = './') => {
  const narrativeDetails = searchFeatureNarratives(rootFolder)

  const { error } = FileSystem.writePersonalFile('feature_narratives', narrativeDetails)
  if(error) {
    throw new Error("FAILED TO WRITE NARRATIVE FILE: " + error)
  }

  return narrativeDetails
}

export default extractFeatureNarratives

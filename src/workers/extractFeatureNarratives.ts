import searchFeatureNarratives from "../business_logic/searchFeatureNarratives"
import FileSystem from "../backend/FileSystem"

const extractFeatureNarratives = () => {
  const featureNarratives = searchFeatureNarratives()
  const narrativeKeys = Object.keys(featureNarratives)

  const { error: writeNarrativesError } = FileSystem.writePersonalFile('feature_narratives', featureNarratives)
  if(writeNarrativesError) {
    throw new Error("FAILED TO WRITE NARRATIVE FILE: " + writeNarrativesError)
  }

  const { error: writeKeysError } = FileSystem.writePersonalFile('feature_narratives_keys', narrativeKeys)
  if(writeKeysError) {
    throw new Error("FAILED TO WRITE NARRATIVE KEY FILE: " + writeKeysError)
  }

  return featureNarratives
}

export default extractFeatureNarratives

import searchDataSchemas from "../business_logic/searchDataSchemas"
import FileSystem from "../backend/FileSystem"

const extractDataSchemas = () => {
  const dataSchemas = searchDataSchemas()
  const dataSchemaKeys = Object.keys(dataSchemas)

  const { error: writeSchemaError } = FileSystem.writePersonalFile('data_schema', dataSchemas)
  if(writeSchemaError) {
    throw new Error("FAILED TO WRITE SCHEMA FILE: " + writeSchemaError)
  }

  const { error: writeKeysError } = FileSystem.writePersonalFile('data_schema_keys', dataSchemaKeys)
  if(writeKeysError) {
    throw new Error("FAILED TO WRITE SCHEMA KEY FILE: " + writeKeysError)
  }

  return dataSchemas
}

export default extractDataSchemas

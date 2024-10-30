#!/usr/bin/env node
import extractDataSchemas from "../../workers/extractDataSchemas";

const schema = async () => {
  console.log("...extracting data")
  const dataSchemas = await extractDataSchemas()
  console.log("complete")
}

(async () => await schema())();

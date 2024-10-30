#!/usr/bin/env node
import extractFeatureNarratives from "../../workers/extractFeatureNarratives";

const narratives = async () => {
  console.log("...extracting narrative")
  const featureNarratives = await extractFeatureNarratives()
  console.log("complete")
}

(async () => await narratives())();

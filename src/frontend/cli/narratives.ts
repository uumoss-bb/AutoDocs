import extractFeatureNarratives from "../../workers/extractFeatureNarratives";

const narratives = () => {
  const featureNarratives = extractFeatureNarratives('./')
  console.log(featureNarratives)
}

narratives();

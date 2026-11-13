import SFT.Materials.FerroelectricMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-functional-electronic-materials.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  FerroelectricMaterialExperiment.validateSpec
  let registration := FerroelectricMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields FerroelectricMaterialExperiment.programFields
  let inputs ← FerroelectricMaterialValidation.inputValues "sha256:ef628d9500041fc15235cead76d758f020d176941cd5d430ebe65297b1743ded"
  let (label,digest) ← FerroelectricMaterialSource.extractRequirements files
  let result ← FerroelectricMaterialValidation.runComparison (identity registration) "sha256:ef628d9500041fc15235cead76d758f020d176941cd5d430ebe65297b1743ded" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

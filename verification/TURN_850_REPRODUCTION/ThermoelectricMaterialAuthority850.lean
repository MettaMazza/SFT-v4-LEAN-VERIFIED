import SFT.Materials.ThermoelectricMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-transport-thermoelectric.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  ThermoelectricMaterialExperiment.validateSpec
  let registration := ThermoelectricMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields ThermoelectricMaterialExperiment.programFields
  let inputs ← ThermoelectricMaterialValidation.inputValues "sha256:c69227640b4f632d464b50d4fc84e0d4939d69d0a6e6b16524713488351299b9"
  let (label,digest) ← ThermoelectricMaterialSource.extractRequirements files
  let result ← ThermoelectricMaterialValidation.runComparison (identity registration) "sha256:c69227640b4f632d464b50d4fc84e0d4939d69d0a6e6b16524713488351299b9" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

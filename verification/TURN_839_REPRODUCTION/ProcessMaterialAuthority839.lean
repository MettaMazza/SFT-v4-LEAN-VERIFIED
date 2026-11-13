import SFT.Materials.ProcessMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-fatigue-fracture.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  ProcessMaterialExperiment.validateSpec
  let registration := ProcessMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields ProcessMaterialExperiment.programFields
  let inputs ← ProcessMaterialValidation.inputValues "sha256:312143595b45305345caf80c066a165c76717ebf862484642f585c17da76d7b0"
  let (label,digest) ← ProcessMaterialSource.extractRequirements files
  let result ← ProcessMaterialValidation.runComparison (identity registration) "sha256:312143595b45305345caf80c066a165c76717ebf862484642f585c17da76d7b0" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

import SFT.Materials.PiezoMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-functional-electronic-materials.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  PiezoMaterialExperiment.validateSpec
  let registration := PiezoMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields PiezoMaterialExperiment.programFields
  let inputs ← PiezoMaterialValidation.inputValues "sha256:547f1b7e16cc64f027648fe550992e558b98cf72922daabbe62b8c633caf7e4c"
  let (label,digest) ← PiezoMaterialSource.extractRequirements files
  let result ← PiezoMaterialValidation.runComparison (identity registration) "sha256:547f1b7e16cc64f027648fe550992e558b98cf72922daabbe62b8c633caf7e4c" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

import SFT.Materials.CorrosionMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-metal-additive-corrosion.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  CorrosionMaterialExperiment.validateSpec
  let registration := CorrosionMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields CorrosionMaterialExperiment.programFields
  let inputs ← CorrosionMaterialValidation.inputValues "sha256:b0a0f3013abf48e42a9f42cafaced3f55c5f665254d5e1205e2b4bb629adfc44"
  let (label,digest) ← CorrosionMaterialSource.extractRequirements files
  let result ← CorrosionMaterialValidation.runComparison (identity registration) "sha256:b0a0f3013abf48e42a9f42cafaced3f55c5f665254d5e1205e2b4bb629adfc44" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

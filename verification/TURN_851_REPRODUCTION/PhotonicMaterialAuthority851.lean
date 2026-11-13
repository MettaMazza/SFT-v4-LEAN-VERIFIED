import SFT.Materials.PhotonicMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-optical-materials.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  PhotonicMaterialExperiment.validateSpec
  let registration := PhotonicMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields PhotonicMaterialExperiment.programFields
  let inputs ← PhotonicMaterialValidation.inputValues "sha256:e96f747b8ad3c7fbbd977d5f5ec04830b3a67d86d4c95d100fd002fea91aeacf"
  let (label,digest) ← PhotonicMaterialSource.extractRequirements files
  let result ← PhotonicMaterialValidation.runComparison (identity registration) "sha256:e96f747b8ad3c7fbbd977d5f5ec04830b3a67d86d4c95d100fd002fea91aeacf" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

import SFT.Materials.SolidificationMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-solidification.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  SolidificationMaterialExperiment.validateSpec
  let registration := SolidificationMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields SolidificationMaterialExperiment.programFields
  let inputs ← SolidificationMaterialValidation.inputValues "sha256:dcd86dc70b9df09c00caa215bbc057072dbcfac1d9e7966682ee5e64d9e3e09a"
  let (label,digest) ← SolidificationMaterialSource.extractRequirements files
  let result ← SolidificationMaterialValidation.runComparison (identity registration) "sha256:dcd86dc70b9df09c00caa215bbc057072dbcfac1d9e7966682ee5e64d9e3e09a" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

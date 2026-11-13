import SFT.Materials.WearMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-nanotribology.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  WearMaterialExperiment.validateSpec
  let registration := WearMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields WearMaterialExperiment.programFields
  let inputs ← WearMaterialValidation.inputValues "sha256:0dfb3a64d7d266800e3d81bd4a10b95a2bdf1578dbcbb6c8a50dc9892c730c58"
  let (label,digest) ← WearMaterialSource.extractRequirements files
  let result ← WearMaterialValidation.runComparison (identity registration) "sha256:0dfb3a64d7d266800e3d81bd4a10b95a2bdf1578dbcbb6c8a50dc9892c730c58" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

import SFT.Materials.SinteringMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-ceramic-additive.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  SinteringMaterialExperiment.validateSpec
  let registration := SinteringMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields SinteringMaterialExperiment.programFields
  let inputs ← SinteringMaterialValidation.inputValues "sha256:71561b44bafa3f50e9b283da502fca4aca42812bb902468ce99195da646b97af"
  let (label,digest) ← SinteringMaterialSource.extractRequirements files
  let result ← SinteringMaterialValidation.runComparison (identity registration) "sha256:71561b44bafa3f50e9b283da502fca4aca42812bb902468ce99195da646b97af" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

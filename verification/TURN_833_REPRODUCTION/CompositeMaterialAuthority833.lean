import SFT.Materials.CompositeMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-polymer-composites.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  CompositeMaterialExperiment.validateSpec
  let registration := CompositeMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields CompositeMaterialExperiment.programFields
  let inputs ← CompositeMaterialValidation.inputValues "sha256:3bfdcf2c416834eb5d38076926fec6a6fd99b48741a006854cf101e17f718639"
  let (label,digest) ← CompositeMaterialSource.extractRequirements files
  let result ← CompositeMaterialValidation.runComparison (identity registration) "sha256:3bfdcf2c416834eb5d38076926fec6a6fd99b48741a006854cf101e17f718639" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

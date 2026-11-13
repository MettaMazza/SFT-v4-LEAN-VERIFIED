import SFT.Materials.PorousMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-multiscale-materials.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  PorousMaterialExperiment.validateSpec
  let registration := PorousMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields PorousMaterialExperiment.programFields
  let inputs ← PorousMaterialValidation.inputValues "sha256:fdad234f0043774b524beaa815005e76f3852494dd4e2646fef327e80da10f22"
  let (label,digest) ← PorousMaterialSource.extractRequirements files
  let result ← PorousMaterialValidation.runComparison (identity registration) "sha256:fdad234f0043774b524beaa815005e76f3852494dd4e2646fef327e80da10f22" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

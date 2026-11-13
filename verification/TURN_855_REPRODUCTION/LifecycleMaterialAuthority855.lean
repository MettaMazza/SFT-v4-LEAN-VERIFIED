import SFT.Materials.LifecycleMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-materials-division.html", "experiments/external_sources/materials/snapshots/nist-nano-protocols.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  LifecycleMaterialExperiment.validateSpec
  let registration := LifecycleMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields LifecycleMaterialExperiment.programFields
  let inputs ← LifecycleMaterialValidation.inputValues "sha256:5999dda81185a5879ba40f2f719e01bdd144ada5f7d185a192dbd75abe05e417"
  let (label,digest) ← LifecycleMaterialSource.extractRequirements files
  let result ← LifecycleMaterialValidation.runComparison (identity registration) "sha256:5999dda81185a5879ba40f2f719e01bdd144ada5f7d185a192dbd75abe05e417" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

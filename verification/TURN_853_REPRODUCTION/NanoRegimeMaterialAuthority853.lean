import SFT.Materials.NanoRegimeMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-nano-protocols.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  NanoRegimeMaterialExperiment.validateSpec
  let registration := NanoRegimeMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields NanoRegimeMaterialExperiment.programFields
  let inputs ← NanoRegimeMaterialValidation.inputValues "sha256:7d56225f5d4eac04cdc6aa9d0f8ce5b8f7319dd45f3e55d5927847c8b4c310c6"
  let (label,digest) ← NanoRegimeMaterialSource.extractRequirements files
  let result ← NanoRegimeMaterialValidation.runComparison (identity registration) "sha256:7d56225f5d4eac04cdc6aa9d0f8ce5b8f7319dd45f3e55d5927847c8b4c310c6" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

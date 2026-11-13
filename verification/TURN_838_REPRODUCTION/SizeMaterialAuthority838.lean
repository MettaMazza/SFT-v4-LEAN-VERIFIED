import SFT.Materials.SizeMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-surface-damage.html", "experiments/external_sources/materials/snapshots/nist-nano-protocols.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  SizeMaterialExperiment.validateSpec
  let registration := SizeMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields SizeMaterialExperiment.programFields
  let inputs ← SizeMaterialValidation.inputValues "sha256:1c55eba37a5a437745e99fdad4ab635b301db1e5b6f578d1bb8ea048fa9da1f4"
  let (label,digest) ← SizeMaterialSource.extractRequirements files
  let result ← SizeMaterialValidation.runComparison (identity registration) "sha256:1c55eba37a5a437745e99fdad4ab635b301db1e5b6f578d1bb8ea048fa9da1f4" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

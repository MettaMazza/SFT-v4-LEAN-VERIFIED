import SFT.Materials.GlassMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-glass-transition.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  GlassMaterialExperiment.validateSpec
  let registration := GlassMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields GlassMaterialExperiment.programFields
  let inputs ← GlassMaterialValidation.inputValues "sha256:847b0e584868964976b755dce28434b62729070f8dbb6822a35ffa020fbbcd41"
  let (label,digest) ← GlassMaterialSource.extractRequirements files
  let result ← GlassMaterialValidation.runComparison (identity registration) "sha256:847b0e584868964976b755dce28434b62729070f8dbb6822a35ffa020fbbcd41" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

import SFT.Materials.AnisotropyMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-texture-phase-fraction.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  AnisotropyMaterialExperiment.validateSpec
  let registration := AnisotropyMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields AnisotropyMaterialExperiment.programFields
  let inputs ← AnisotropyMaterialValidation.inputValues "sha256:6e8aa2f6cd313425b2e82436d6956d64b875846f03a1eec5ec1dff40761a837c"
  let (label,digest) ← AnisotropyMaterialSource.extractRequirements files
  let result ← AnisotropyMaterialValidation.runComparison (identity registration) "sha256:6e8aa2f6cd313425b2e82436d6956d64b875846f03a1eec5ec1dff40761a837c" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

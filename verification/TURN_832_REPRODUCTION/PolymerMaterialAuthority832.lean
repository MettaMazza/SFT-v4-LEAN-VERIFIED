import SFT.Materials.PolymerMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-polymer-processing.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  PolymerMaterialExperiment.validateSpec
  let registration := PolymerMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields PolymerMaterialExperiment.programFields
  let inputs ← PolymerMaterialValidation.inputValues "sha256:ac9f81b1d29a001fa7066bf4975f1b01870c1c20f89972500793427268f44c5f"
  let (label,digest) ← PolymerMaterialSource.extractRequirements files
  let result ← PolymerMaterialValidation.runComparison (identity registration) "sha256:ac9f81b1d29a001fa7066bf4975f1b01870c1c20f89972500793427268f44c5f" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

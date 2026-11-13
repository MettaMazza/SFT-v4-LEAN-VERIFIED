import SFT.Materials.HeatMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-multiscale-materials.html", "experiments/external_sources/materials/snapshots/nist-metal-additive-corrosion.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  HeatMaterialExperiment.validateSpec
  let registration := HeatMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields HeatMaterialExperiment.programFields
  let inputs ← HeatMaterialValidation.inputValues "sha256:e357da4a2f6132a4700751ad5d330682b74421eefaa241c8d68ad615d80f1535"
  let (label,digest) ← HeatMaterialSource.extractRequirements files
  let result ← HeatMaterialValidation.runComparison (identity registration) "sha256:e357da4a2f6132a4700751ad5d330682b74421eefaa241c8d68ad615d80f1535" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

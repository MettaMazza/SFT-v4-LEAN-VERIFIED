import SFT.Materials.PhaseMapMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-transport-thermoelectric.html", "experiments/external_sources/materials/snapshots/nist-texture-phase-fraction.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  PhaseMapMaterialExperiment.validateSpec
  let registration := PhaseMapMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields PhaseMapMaterialExperiment.programFields
  let inputs ← PhaseMapMaterialValidation.inputValues "sha256:a87e10c18ba7fc491e27816a6c14228ab3cfe02de206468f87735910579bcb04"
  let (label,digest) ← PhaseMapMaterialSource.extractRequirements files
  let result ← PhaseMapMaterialValidation.runComparison (identity registration) "sha256:a87e10c18ba7fc491e27816a6c14228ab3cfe02de206468f87735910579bcb04" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

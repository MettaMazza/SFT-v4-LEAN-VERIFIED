import SFT.Materials.BiomaterialMaterialValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := ["experiments/external_sources/materials/snapshots/nist-nano-protocols.html", "experiments/external_sources/materials/snapshots/nist-polymer-composites.html"]
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ("/Volumes/One Touch/ernos-labs-sft-platform" ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  BiomaterialMaterialExperiment.validateSpec
  let registration := BiomaterialMaterialExperiment.registration "sha256:da97a6cb6a001964a069b45a5a3698e7ea90f334a08d69c62bd09c46d8112035"
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields BiomaterialMaterialExperiment.programFields
  let inputs ← BiomaterialMaterialValidation.inputValues "sha256:852ac5fa4fe30e1cd8785df983d62a20fc1743af7d0ccd8488a85a821eda35db"
  let (label,digest) ← BiomaterialMaterialSource.extractRequirements files
  let result ← BiomaterialMaterialValidation.runComparison (identity registration) "sha256:852ac5fa4fe30e1cd8785df983d62a20fc1743af7d0ccd8488a85a821eda35db" "Darwin" "CPython" label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)

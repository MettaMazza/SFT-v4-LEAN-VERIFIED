import SFT.Physics.CosmoSpatialFlatnessValidation
import Lean
open SFT.Physics SFT.Host.Canonical
 def field (v : Lean.Json) (key : String) : IO Lean.Json := IO.ofExcept (v.getObjVal? key)
 def textField (v : Lean.Json) (key : String) : IO String := do
  let value ← field v key
  IO.ofExcept value.getStr?
 def main (args : List String) : IO Unit := do
  let bytes ← IO.FS.readBinFile (args[0]!)
  let payload ← IO.ofExcept (Lean.Json.parse (String.fromUTF8! bytes))
  let source : CosmoSpatialFlatnessIntervals.CurvatureRecord := ⟨← textField payload "source_id",
   ← textField payload "central_orientation",← textField payload "confidence_region",← textField payload "data_combination",
   ← textField payload "equation_reference",← textField payload "central_magnitude",← textField payload "reported_standard_uncertainty_magnitude"⟩
  let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
  match CosmoSpatialFlatnessValidation.validateExternal source bytes (args[1]!) (args[2]!) (args[3]!) before before with
  | .error e => throw (IO.userError e)
  | .ok result => IO.println (render result.value)

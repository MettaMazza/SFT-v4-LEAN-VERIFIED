import SFT.Physics.DarkBaryonValidation
import Lean
open SFT.Physics SFT.Host.Canonical
 def field (v : Lean.Json) (key : String) : IO Lean.Json := IO.ofExcept (v.getObjVal? key)
 def textField (v : Lean.Json) (key : String) : IO String := do
  let value ← field v key
  IO.ofExcept value.getStr?
 def row (v : Lean.Json) : IO CosmicIntervals.MeasuredRow := do
  return ⟨← textField v "central",← textField v "standard_uncertainty"⟩
 def main (args : List String) : IO Unit := do
  let bytes ← IO.FS.readBinFile (args[0]!)
  let payload ← IO.ofExcept (Lean.Json.parse (String.fromUTF8! bytes))
  let parameters ← field payload "reported_parameters"
  let baryon ← field parameters "baryon_density_omega_b_h2"
  let dark ← field parameters "cold_dark_matter_density_omega_c_h2"
  let source : CosmicIntervals.DensityRecord := ⟨← textField payload "source_id",← textField payload "confidence_region",← row baryon,← row dark⟩
  let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
  match DarkBaryonValidation.validateExternal source bytes (args[1]!) (args[2]!) (args[3]!) before before with
  | .error e => throw (IO.userError e)
  | .ok result => IO.println (render result.value)

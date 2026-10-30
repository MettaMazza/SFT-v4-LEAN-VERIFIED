import SFT.Physics.HubbleValidation
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
  let publications ← field payload "publications"
  let early ← field publications "early_route"
  let late ← field publications "late_route"
  let source : CosmicIntervals.HubbleRecord := ⟨← textField payload "source_id",← textField early "route",← textField late "route",← textField early "unit",← textField late "unit",← row early,← row late⟩
  let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
  match HubbleValidation.validateExternal source bytes (args[1]!) (args[2]!) (args[3]!) before before with
  | .error e => throw (IO.userError e)
  | .ok result => IO.println (render result.value)

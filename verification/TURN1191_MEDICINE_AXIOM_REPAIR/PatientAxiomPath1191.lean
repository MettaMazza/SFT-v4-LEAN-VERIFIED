import SFT.Medicine.PatientIdentitySource
import Lean
open Lean Elab Command
run_cmd do
 let env ← getEnv
 let mut name := `SFT.Medicine.PatientIdentitySource.validateSources
 for _ in [:20] do
  logInfo m!"{name}"
  if name == `propext then break
  let some info := env.find? name | throwError "missing constant"
  let deps := info.type.getUsedConstants ++ (info.value?.getD (.sort .zero)).getUsedConstants
  let mut next := none
  for d in deps do
   if (← Lean.collectAxioms d).contains `propext then
    next := some d
    break
  let some d := next | throwError "no dependent body found"
  name := d

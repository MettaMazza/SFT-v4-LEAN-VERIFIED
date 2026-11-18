import SFT.Chemistry.MolecularCorrespondenceDerivation
import Lean
open Lean Elab Command
run_cmd do
 let env ← getEnv
 let mut name := `SFT.Chemistry.MolecularCorrespondenceDerivation.constructedExecution
 for _ in [:20] do
  logInfo m!"{name}"
  if name == `Classical.choice then break
  let some info := env.find? name | throwError "missing constant"
  let deps := info.type.getUsedConstants ++ ((info.value? true).getD (.sort .zero)).getUsedConstants
  let mut next := none
  for d in deps do
   if (← Lean.collectAxioms d).contains `Classical.choice then
    next := some d
    break
  let some d := next | throwError "no dependent body found"
  name := d

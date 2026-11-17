import SFT.Chemistry.EquilibriumIsotopeFractionation
open SFT.Chemistry.EquilibriumIsotopeFractionation
open SFT.Physics.CapabilityValues
def emitCase (la ha lb hb : Nat) : IO Unit := do
 let out := match partition la ha lb hb with
 | .error e => "error:" ++ e
 | .ok s =>
  let ra := ratioA s; let rb := ratioB s; let f := factor s
  let o := match orientation s with
   | .ok (.emptyOne _) => "empty-One"
   | .ok (.label l) => l.label
   | _ => "unexpected"
  s!"{ra.1}/{ra.2},{rb.1}/{rb.2},{f.1}/{f.2},{o}"
 IO.println s!"{la},{ha},{lb},{hb}:{out}"
def main : IO Unit := do
 for la in [1,2,3,4] do
  for ha in [1,2,3,4] do
   for lb in [1,2,3,4] do
    for hb in [1,2,3,4] do emitCase la ha lb hb

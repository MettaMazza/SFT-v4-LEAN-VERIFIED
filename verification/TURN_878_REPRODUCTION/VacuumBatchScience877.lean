import SFT.Physics.VacuumCycle
import SFT.Host.Canonical
open SFT.Physics SFT.Host.Canonical
def pair (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def transfer (t : VacuumBeat.Transfer) : Value := .object [
 ("vacuum_before",pair t.vacuumBefore),("vacuum_after",pair t.vacuumAfter),("local_work",pair t.localWork)]
def result : Except String Rat → Value
 | .ok q => .object [("value",pair q)]
 | .error e => .object [("error",.text e)]
def main : IO Unit := do
 let cycle ← IO.ofExcept VacuumCycle.completeReturnedCycle
 let a : FoldFirstReturn.Input := .fraction ⟨1,2,by decide,by decide⟩
 let b : FoldFirstReturn.Input := .fraction ⟨1,3,by decide,by decide⟩
 let one : FoldFirstReturn.Input := .fraction ⟨1,1,by decide,by decide⟩
 let z : FoldFirstReturn.Input := .fraction LeptonIntervals.zero
 let two : FoldFirstReturn.Input := .fraction ⟨2,1,by decide,by decide⟩
 let cases := [(a,b),(one,b),(.nonFraction,b),(a,.nonFraction),(z,b),(a,z),(a,a),(b,a),(two,b)]
 let guards := cases.map fun (x,y) => result (VacuumBeat.positiveGap x y)
 IO.println (render (.object [("outward",transfer cycle.outward),
  ("restoration_cost",pair cycle.restorationCost),("restored_vacuum",pair cycle.restoredVacuum),
  ("residual_work",.array (cycle.residualWork.map pair))]))
 IO.println (render (.array guards))

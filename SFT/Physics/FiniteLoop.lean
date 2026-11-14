import SFT.Physics.AlphaCovers
import SFT.Physics.VacuumLedgerProofs
import SFT.Mathematics.DyadicClosure
namespace SFT.Physics.FiniteLoop
open SFT.Foundation ExactOperations ExactPartCarrier
open GeneratorOperations LeptonIntervals VacuumLedgerProofs

def appendTerms (binary : Rat) : Nat → Rat → Rat → Except String (Rat × Rat)
 | 0,total,term => .ok (total,term)
 | n+1,total,term => do
   let prior ← appendTerms binary n total term
   let next ← LeptonRatios.divide prior.2 binary
   pure (add prior.1 next,next)

def finiteLoopSum (depth : CountInput) : Except String Rat := do
 let n ← match depth with
  | .boolean _ => .error "loop depth must be a positive generated count"
  | .integer (.negSucc _) => .error "loop depth must be a positive generated count"
  | .integer (.ofNat 0) => .error "loop depth must be a positive generated count"
  | .integer (.ofNat (n+1)) => .ok (n+1)
 let binary ← AlphaCovers.binaryCount
 let half ← LeptonRatios.divide (asFraction one) (wholeRatio binary)
 let record ← appendTerms (wholeRatio binary) (n-1) half half
 let total := record.1
 if zero.blt total && total.blt (asFraction one) then .ok total
 else .error "finite Fold loop sum left its exact sub-One boundary"

theorem originalDepths :
 (List.range 6).map (fun n => finiteLoopSum (.integer (.ofNat (n+1)))) =
 [.ok ⟨1,2,by decide,by decide⟩,.ok ⟨3,4,by decide,by decide⟩,
  .ok ⟨7,8,by decide,by decide⟩,.ok ⟨15,16,by decide,by decide⟩,
  .ok ⟨31,32,by decide,by decide⟩,.ok ⟨63,64,by decide,by decide⟩] := by
 unfold finiteLoopSum
 rw [AlphaCovers.binaryCountTwo]
 rfl
end SFT.Physics.FiniteLoop

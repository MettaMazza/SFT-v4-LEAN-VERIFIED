import SFT.Physics.StellarTides
namespace SFT.Physics.StellarTidalClosure
open StellarTides
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalStrictBeforeLock (base excess : Nat) (direction : Bool) :
 ((traceFrom base direction excess).dropLast.all (fun row=>row.mismatchAfter<row.mismatchBefore))=true := by
 induction excess with
 | zero=>rfl
 | succ n ih=>
  cases n with
  | zero=>
   cases direction <;> rfl
  | succ k=>
   change (decide ((surplusRow base (k+1) direction).mismatchAfter < (surplusRow base (k+1) direction).mismatchBefore) && ((traceFrom base direction (k+1)).dropLast.all (fun row=>row.mismatchAfter<row.mismatchBefore)))=true
   rw [decide_eq_true (everySurplusStrictlyDecreases base (k+1) direction),ih]
   rfl
#print axioms originalStrictBeforeLock
end SFT.Physics.StellarTidalClosure

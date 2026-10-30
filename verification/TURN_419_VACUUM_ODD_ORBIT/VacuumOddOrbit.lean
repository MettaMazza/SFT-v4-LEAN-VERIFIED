import SFT.Physics.VacuumOddRecurrence
import SFT.Physics.AlphaCovers
namespace SFT.Physics.VacuumOddOrbit
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Physics.GeneratorOperations SFT.Physics.FoldFirstReturn
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000

def denominatorError : String := "ValueError: a live vacuum orbit requires a positive denominator beyond the One"
def oddError : String := "ValueError: a live vacuum orbit requires an odd denominator"
def domainError : String := "ValueError: the live vacuum orbit left the exact positive domain"

def outside (p : Part) : Bool := p.numerator == 0 || p.denominator < p.numerator

def checkedTrace (trace : List Part) : Except String (List Part) :=
 if trace.isEmpty || trace.any outside then .error domainError else .ok trace

def unit (n : Nat) : Part := normalizePart 1 (n+2) (by decide)
 (Nat.succ_le_succ (Nat.zero_le (n+1)))

def oddDenominatorOrbit : CountInput → Except String (List Part)
 | .boolean _ => .error denominatorError
 | .integer (.negSucc _) => .error denominatorError
 | .integer (.ofNat 0) => .error denominatorError
 | .integer (.ofNat 1) => .error denominatorError
 | .integer (.ofNat (n+2)) => do
   let binary ← AlphaCovers.binaryCount
   if (n+2)/binary*binary == n+2 then .error oddError
   else
     let trace ← firstReturn (unit n)
     checkedTrace trace

theorem booleanRejected (b : Bool) : oddDenominatorOrbit (.boolean b) = .error denominatorError := rfl
theorem negativeRejected (n : Nat) : oddDenominatorOrbit (.integer (.negSucc n)) = .error denominatorError := rfl
theorem zeroRejected : oddDenominatorOrbit (.integer 0) = .error denominatorError := rfl
theorem oneRejected : oddDenominatorOrbit (.integer 1) = .error denominatorError := rfl

theorem exactBinaryGuard (n : Nat) : oddDenominatorOrbit (.integer (.ofNat (n+2))) =
 (if (n+2)/2*2 == n+2 then .error oddError else do
   let trace ← firstReturn (unit n)
   checkedTrace trace) := by
 unfold oddDenominatorOrbit
 rw [AlphaCovers.binaryCountTwo]
 rfl

theorem outsideFalse (p : Part) : outside p = false := by
 unfold outside
 have nz : (p.numerator == 0) = false := by
   cases h : p.numerator == 0 with
   | false => rfl
   | true => exact False.elim (Nat.ne_of_gt p.positive (Nat.eq_of_beq_eq_true h))
 rw [nz]
 have no : ¬ p.denominator < p.numerator := Nat.not_lt_of_ge p.throughOne
 rw [decide_eq_false no]
 rfl

theorem noOutside (trace : List Part) : trace.any outside = false := by
 induction trace with
 | nil => rfl
 | cons p rest ih =>
   change (outside p || rest.any outside) = false
   rw [outsideFalse,ih]
   rfl

theorem nonemptyTracePreserved (p : Part) (rest : List Part) : checkedTrace (p::rest) = .ok (p::rest) := by
 unfold checkedTrace
 rw [noOutside]
 rfl

def pairs (trace : List Part) : List (Nat × Nat) := trace.map (fun p => (p.numerator,p.denominator))
def outputPairs : Except String (List Part) → Except String (List (Nat × Nat))
 | .error e => .error e
 | .ok trace => .ok (pairs trace)

theorem threeTrace : outputPairs (oddDenominatorOrbit (.integer 3)) = .ok [(2,3),(1,3)] := rfl
theorem fiveTrace : outputPairs (oddDenominatorOrbit (.integer 5)) = .ok [(2,5),(4,5),(3,5),(1,5)] := rfl
theorem sevenTrace : outputPairs (oddDenominatorOrbit (.integer 7)) = .ok [(2,7),(4,7),(1,7)] := rfl
theorem nineTrace : outputPairs (oddDenominatorOrbit (.integer 9)) = .ok [(2,9),(4,9),(8,9),(7,9),(5,9),(1,9)] := rfl
end SFT.Physics.VacuumOddOrbit

#print axioms SFT.Physics.VacuumOddOrbit.denominatorError
#print axioms SFT.Physics.VacuumOddOrbit.oddError
#print axioms SFT.Physics.VacuumOddOrbit.domainError
#print axioms SFT.Physics.VacuumOddOrbit.outside
#print axioms SFT.Physics.VacuumOddOrbit.checkedTrace
#print axioms SFT.Physics.VacuumOddOrbit.unit
#print axioms SFT.Physics.VacuumOddOrbit.oddDenominatorOrbit
#print axioms SFT.Physics.VacuumOddOrbit.booleanRejected
#print axioms SFT.Physics.VacuumOddOrbit.negativeRejected
#print axioms SFT.Physics.VacuumOddOrbit.zeroRejected
#print axioms SFT.Physics.VacuumOddOrbit.oneRejected
#print axioms SFT.Physics.VacuumOddOrbit.exactBinaryGuard
#print axioms SFT.Physics.VacuumOddOrbit.outsideFalse
#print axioms SFT.Physics.VacuumOddOrbit.noOutside
#print axioms SFT.Physics.VacuumOddOrbit.nonemptyTracePreserved
#print axioms SFT.Physics.VacuumOddOrbit.pairs
#print axioms SFT.Physics.VacuumOddOrbit.outputPairs
#print axioms SFT.Physics.VacuumOddOrbit.threeTrace
#print axioms SFT.Physics.VacuumOddOrbit.fiveTrace
#print axioms SFT.Physics.VacuumOddOrbit.sevenTrace
#print axioms SFT.Physics.VacuumOddOrbit.nineTrace

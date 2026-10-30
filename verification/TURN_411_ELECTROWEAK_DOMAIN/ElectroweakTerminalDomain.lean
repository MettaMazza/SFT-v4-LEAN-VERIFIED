import SFT.Physics.ElectroweakTerminalRatio
namespace SFT.Physics.ElectroweakTerminalDomain
open GeneratorOperations ElectroweakTerminalSupport ElectroweakTerminalRatio
open SFT.Foundation.ExactOperations

def takeCount : CountInput → Option Nat
 | .boolean _ => none
 | .integer (.negSucc _) => none
 | .integer (.ofNat 0) => none
 | .integer (.ofNat 1) => none
 | .integer (.ofNat (n+2)) => some (n+2)

def takeDepth : CountInput → Option Nat
 | .boolean _ => none
 | .integer (.negSucc _) => none
 | .integer (.ofNat 0) => none
 | .integer (.ofNat (n+1)) => some (n+1)

def positiveTake (count taken : CountInput) : Except String Nat :=
 match takeCount count with
 | none => .error "ValueError: positive take requires generated positive counts"
 | some c => match takeDepth taken with
   | none => .error "ValueError: positive take requires generated positive counts"
   | some t => predecessorSteps c t

theorem validInputs (count taken : Nat) :
 positiveTake (.integer (.ofNat (count+2))) (.integer (.ofNat (taken+1)))=
 predecessorSteps (count+2) (taken+1) := rfl

theorem retainedPositive (remaining taken : Nat) :
 positiveTake (.integer (.ofNat (remaining+taken+2))) (.integer (.ofNat (taken+1)))=
 .ok (remaining+1) := predecessorStepsExact remaining (taken+1)

theorem exhaustedPredecessor (steps : Nat) : predecessorSteps 1 (steps+1)=
 .error "ValueError: a positive predecessor requires a count beyond the One" := rfl

theorem booleanCountRejected (b : Bool) (taken : CountInput) : positiveTake (.boolean b) taken=
 .error "ValueError: positive take requires generated positive counts" := rfl

theorem zeroCountRejected (taken : CountInput) : positiveTake (.integer 0) taken=
 .error "ValueError: positive take requires generated positive counts" := rfl

theorem oneCountRejected (taken : CountInput) : positiveTake (.integer 1) taken=
 .error "ValueError: positive take requires generated positive counts" := rfl

theorem booleanDepthRejected (count : Nat) (b : Bool) :
 positiveTake (.integer (.ofNat (count+2))) (.boolean b)=
 .error "ValueError: positive take requires generated positive counts" := rfl

theorem zeroDepthRejected (count : Nat) : positiveTake (.integer (.ofNat (count+2))) (.integer 0)=
 .error "ValueError: positive take requires generated positive counts" := rfl

theorem originalLevel : positiveTake (.integer 16) (.integer 3)=runningLevel := by
 rw [runningLevelExact]
 rfl

theorem runningShareAllPositive (n : Nat) :
 runningShare (.integer (.ofNat (n+1)))=.ok
 (normalizePositive ((n+3)*(n+3)) (4*(n+2)*(n+2)+(n+3)*(n+3))
  (Nat.mul_pos (Nat.zero_lt_succ _) (Nat.zero_lt_succ _))
  (Nat.add_pos_right _ (Nat.mul_pos (Nat.zero_lt_succ _) (Nat.zero_lt_succ _)))) := by
 unfold runningShare
 rw [FoldFirstReturn.generatorPeriodThree]
 rfl

#print axioms takeCount
#print axioms takeDepth
#print axioms positiveTake
#print axioms validInputs
#print axioms retainedPositive
#print axioms exhaustedPredecessor
#print axioms booleanCountRejected
#print axioms zeroCountRejected
#print axioms oneCountRejected
#print axioms booleanDepthRejected
#print axioms zeroDepthRejected
#print axioms originalLevel
#print axioms runningShareAllPositive
end SFT.Physics.ElectroweakTerminalDomain

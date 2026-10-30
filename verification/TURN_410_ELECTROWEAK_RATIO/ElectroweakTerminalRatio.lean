import SFT.Physics.ElectroweakTerminalSupport
import SFT.Physics.LeptonTake
namespace SFT.Physics.ElectroweakTerminalRatio
open SFT.Foundation.ExactOperations
open GeneratorOperations AlphaCovers FoldFirstReturn ElectroweakTerminalSupport
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000

def runningShare : CountInput → Except String PositiveFraction
 | .boolean _ => .error "ValueError: electroweak running requires a positive level"
 | .integer (.negSucc _) => .error "ValueError: electroweak running requires a positive level"
 | .integer (.ofNat 0) => .error "ValueError: electroweak running requires a positive level"
 | .integer (.ofNat (n+1)) => do
   let g ← generatorPeriod
   let b ← positivePredecessor (.integer (.ofNat g))
   let pairs ← positivePower (.integer (.ofNat b)) (.integer (.ofNat b))
   let charged := (n+1+b)*(n+1+b)
   let neutral := pairs*(n+1+1)*(n+1+1)
   have cp : 0<charged := Nat.mul_pos (Nat.add_pos_left (Nat.zero_lt_succ n) b)
     (Nat.add_pos_left (Nat.zero_lt_succ n) b)
   .ok (normalizePositive charged (neutral+charged) cp (Nat.add_pos_right neutral cp))

def terminalAlpha : Except String PositiveFraction := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let alpha := AlphaRatio.reciprocal inverse
 if alpha.numerator < alpha.denominator then .ok alpha
 else .error "ValueError: terminal alpha must be a strict positive part of the One"

def selfReturn : Except String PositiveFraction :=
 match hd : returnDivisor with
 | .error e => .error e
 | .ok d =>
  have dp : 0<d := by
   have eq := Except.ok.inj (hd.symm.trans returnDivisorExact)
   rw [eq]; decide
  do
   let alpha ← terminalAlpha
   .ok (AlphaRatio.divide alpha (AlphaRatio.whole d dp))

def sinSquared : Except String PositiveFraction := do
 let level ← runningLevel
 let base ← runningShare (.integer (.ofNat level))
 let correction ← selfReturn
 let result := AlphaRatio.add base correction
 if result.numerator < result.denominator then .ok result
 else .error "ValueError: terminal electroweak share left the One"

def cosSquared : Except String PositiveFraction := do
 let share ← sinSquared
 match LeptonTake.positiveTake (BoundaryGrowth.asFraction AlphaRatio.one) (BoundaryGrowth.asFraction share) with
 | .ok result => .ok result
 | .error _ => .error "ValueError: electroweak complement must remain a positive part"

theorem runningShareExact : AlphaRatio.outputPair (runningShare (.integer 13))=.ok (225,1009) := rfl

theorem terminalAlphaExact : AlphaRatio.outputPair terminalAlpha=.ok (3676744786,503846395469) := rfl

theorem selfReturnExact : AlphaRatio.outputPair selfReturn=.ok (3676744786,8565388722973) := rfl

theorem sinSquaredExact : AlphaRatio.outputPair sinSquared=.ok (1930922298157999,8642477221479757) := rfl

theorem cosSquaredExact : AlphaRatio.outputPair cosSquared=.ok (6711554923321758,8642477221479757) := rfl

def completeShare : Except String PositiveFraction := do
 let s ← sinSquared
 let c ← cosSquared
 .ok (AlphaRatio.add s c)

theorem completeShareOne : AlphaRatio.outputPair completeShare=.ok (1,1) := rfl

theorem booleanRejected (b : Bool) : runningShare (.boolean b)=
 .error "ValueError: electroweak running requires a positive level" := rfl

theorem zeroRejected : runningShare (.integer 0)=
 .error "ValueError: electroweak running requires a positive level" := rfl

theorem negativeRejected (n : Nat) : runningShare (.integer (.negSucc n))=
 .error "ValueError: electroweak running requires a positive level" := rfl

#print axioms runningShare
#print axioms terminalAlpha
#print axioms selfReturn
#print axioms sinSquared
#print axioms cosSquared
#print axioms runningShareExact
#print axioms terminalAlphaExact
#print axioms selfReturnExact
#print axioms sinSquaredExact
#print axioms cosSquaredExact
#print axioms completeShare
#print axioms completeShareOne
#print axioms booleanRejected
#print axioms zeroRejected
#print axioms negativeRejected
end SFT.Physics.ElectroweakTerminalRatio

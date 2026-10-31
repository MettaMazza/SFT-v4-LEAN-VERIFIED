import SFT.Physics.AlphaRatio
namespace SFT.Physics.ElectroweakTerminalSupport
open GeneratorOperations AlphaCovers AlphaPromotion FoldFirstReturn
set_option maxRecDepth 20000

def promotionCount : Except String Nat := do
 let rungs ← promotionRungs
 let g ← generatorPeriod
 if rungs.length == g+1 then .ok rungs.length
 else .error "promotion termination and generator successor did not cross-lock"

theorem promotionCountExact : promotionCount=.ok 4 := by
 unfold promotionCount
 rw [forcedRungs,FoldFirstReturn.generatorPeriodThree]
 rfl

def binarySupport : Except String Nat := do
 let g ← generatorPeriod
 let binary ← positivePredecessor (.integer (.ofNat g))
 let count ← promotionCount
 positivePower (.integer (.ofNat binary)) (.integer (.ofNat count))

theorem binarySupportExact : binarySupport=.ok 16 := by
 unfold binarySupport
 rw [FoldFirstReturn.generatorPeriodThree,promotionCountExact]
 rfl

def predecessorSteps : Nat → Nat → Except String Nat
 | count,0 => .ok count
 | count,n+1 => do
   let next ← positivePredecessor (.integer (.ofNat count))
   predecessorSteps next n

theorem predecessorStepsExact (remaining taken : Nat) :
 predecessorSteps (remaining+taken+1) taken=.ok (remaining+1) := by
 induction taken generalizing remaining with
 | zero => rfl
 | succ n ih =>
  change (do
   let next ← positivePredecessor (.integer (.ofNat ((remaining+n)+2)))
   predecessorSteps next n)=_
  change predecessorSteps (remaining+n+1) n=_
  exact ih remaining

def runningLevel : Except String Nat := do
 let count ← binarySupport
 let g ← generatorPeriod
 predecessorSteps count g

theorem runningLevelExact : runningLevel=.ok 13 := by
 unfold runningLevel
 rw [binarySupportExact,FoldFirstReturn.generatorPeriodThree]
 rfl

def supportWords := SFT.Foundation.FoldAssembly.supportAfterExtensions 4

theorem completeSupportCardinality : supportWords.length=16 := rfl

theorem supportMatchesPower : binarySupport=.ok supportWords.length := by
 rw [binarySupportExact,completeSupportCardinality]

def channelCounts : Except String (Nat × Nat) := do
 let level ← runningLevel
 let g ← generatorPeriod
 let binary ← positivePredecessor (.integer (.ofNat g))
 let pairs ← positivePower (.integer (.ofNat binary)) (.integer (.ofNat binary))
 .ok ((level+binary)*(level+binary),pairs*(level+1)*(level+1))

theorem channelCountsExact : channelCounts=.ok (225,784) := by
 unfold channelCounts
 rw [runningLevelExact,FoldFirstReturn.generatorPeriodThree]
 rfl

def returnDivisor : Except String Nat := do
 let support ← binarySupport
 .ok (support+1)

theorem returnDivisorExact : returnDivisor=.ok 17 := by
 unfold returnDivisor
 rw [binarySupportExact]
 rfl

theorem countsAsSquares : 15*15=225 ∧ 4*14*14=784 ∧ 225+784=1009 := ⟨rfl,rfl,rfl⟩

#print axioms promotionCount
#print axioms promotionCountExact
#print axioms binarySupport
#print axioms binarySupportExact
#print axioms predecessorSteps
#print axioms predecessorStepsExact
#print axioms runningLevel
#print axioms runningLevelExact
#print axioms supportWords
#print axioms completeSupportCardinality
#print axioms supportMatchesPower
#print axioms channelCounts
#print axioms channelCountsExact
#print axioms returnDivisor
#print axioms returnDivisorExact
#print axioms countsAsSquares
end SFT.Physics.ElectroweakTerminalSupport

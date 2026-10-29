import SFT.Physics.LeptonLedger
namespace SFT.Physics.LeptonWitnesses
open LeptonInvariants FoldFirstReturn
set_option maxRecDepth 20000
structure Witness where
 name : String
 statement : String
 passed : Bool

def pairCheck (result : Except String (Nat × Nat)) (expected : Nat × Nat) : Bool := match result with
 | .error _ => false
 | .ok value => value == expected

def invariantsCheck : Bool := match invariantPairs with
 | .error _ => false
 | .ok value => value == ((1,1),(1,6),(1,485),(3,1454))

def channelsCheck : Bool := pairCheck (sharpenedPair (.integer 2)) (2,969) &&
 pairCheck (sharpenedPair (.integer 3)) (3,1454) && pairCheck (sharpenedPair (.integer 4)) (4,1939)

def identityCheck : Bool := match generatorPeriod with
 | .error _ => false
 | .ok colour => colour == 3 && pairCheck (sharpenedPair (.integer (.ofNat colour))) (3,1454)

def witnesses : List Witness := [⟨"exact-invariants","The four independently constructed invariants equal 1, 1/6, 1/485 and 3/1454.",invariantsCheck⟩,⟨"channel-census","The complete channels two, three and four produce distinct exact sharpenings.",channelsCheck⟩,⟨"colour-identity","The unique retained sharpening channel equals the independently forced generator.",identityCheck⟩]

theorem invariantsCheckPassed : invariantsCheck = true := by
 unfold invariantsCheck
 rw [exactInvariants]
 rfl

theorem channelsCheckPassed : channelsCheck = true := by
 unfold channelsCheck
 rw [binaryChannel,colourChannel,successorChannel]
 rfl

theorem identityCheckPassed : identityCheck = true := by
 unfold identityCheck
 rw [generatorPeriodThree]
 rfl

theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (invariantsCheck && (channelsCheck && (identityCheck && true))) = true
 rw [invariantsCheckPassed,channelsCheckPassed,identityCheckPassed]
 rfl
end SFT.Physics.LeptonWitnesses

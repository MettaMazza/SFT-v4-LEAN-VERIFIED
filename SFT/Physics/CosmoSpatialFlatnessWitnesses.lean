import SFT.Physics.CosmoSpatialFlatness
namespace SFT.Physics.CosmoSpatialFlatnessWitnesses
open CosmoSpatialFlatness
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def base : List Rat := [LeptonIntervals.normalize 1 3 (by decide),LeptonIntervals.normalize 2 3 (by decide)]
def refined := refinePartition base (.integer (.ofNat 1)) (LeptonIntervals.normalize 1 6 (by decide)) (LeptonIntervals.normalize 1 2 (by decide))
def isAbsence : Except String SFT.Mathematics.FoldScalar.Scalar → Bool
 | .error _ => false
 | .ok scalar => match scalar with
   | .emptyOne => true
   | .positive _ _ => false
def check0 : Bool := isAbsence (closedPartition base)
def check1 : Bool := match refined with
 | .error _ => false
 | .ok ps => isAbsence (closedPartition ps)
def check2 : Bool := match refined with
 | .error _ => false
 | .ok ps => match ps with
   | [] => false
   | _::rest => match rest with
     | [] => false
     | a::rest => match rest with
       | [] => false
       | b::tail => tail.isEmpty &&
         (LeptonIntervals.add a b == LeptonIntervals.normalize 2 3 (by decide) &&
          decide ((total [LeptonIntervals.normalize 1 3 (by decide),a,b]).1=(total [LeptonIntervals.normalize 1 3 (by decide),a,b]).2))
def witnesses : List Witness := [⟨"base-closure","The exact one-third/two-thirds partition leaves only structural absence.",check0⟩,⟨"refinement-closure","A positive split of one component preserves structural absence.",check1⟩,⟨"parent-preserved","The refined children exactly reconstruct their parent and the total One.",check2⟩]
theorem check0Passed : check0=true := rfl
theorem check1Passed : check1=true := rfl
theorem check2Passed : check2=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (check0 && check1 && check2 && true)=true
 rw [check0Passed,check1Passed,check2Passed]
 rfl
end SFT.Physics.CosmoSpatialFlatnessWitnesses

import SFT.Mathematics.SelfSimilarConvergence
import SFT.InformationScience.CompressionSupport
import SFT.Physics.GeneratorOperations
namespace SFT.Physics.LyapunovKSCorrespondence
open GeneratorOperations
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def positiveWhole (value : CountInput) (minimum : Int := 1) : Except String Int :=
 match value with
 | .boolean _ => .error "a generated positive whole is required"
 | .integer n => if n<minimum then .error "a generated positive whole is required" else .ok n
-- Original itertools.product order: the rightmost coordinate advances first.
def words (labels : List Nat) : Nat → List (List Nat)
 | 0 => [[]]
 | depth+1 => labels.flatMap (fun label => (words labels depth).map (List.cons label))
def completeWordSupport (labelCount depth : CountInput) : Except String (List (List Nat)) := do
 let m ← positiveWhole labelCount 2
 let d ← positiveWhole depth
 pure (words ((List.range m.toNat).map (fun i => i+1)) d.toNat)
def exactSupportCount (labelCount depth : CountInput) : Except String Nat := do
 pure (← completeWordSupport labelCount depth).length
def separationCarrier (labelCount separationParts : CountInput) : Except String Int := do
 let m ← positiveWhole labelCount 2
 let parts ← positiveWhole separationParts
 pure (m*parts)
private theorem productLength (labels : List Nat) (tails : List (List Nat)) :
 (labels.flatMap (fun label => tails.map (List.cons label))).length=labels.length*tails.length := by
 induction labels with
 | nil => exact (Nat.zero_mul _).symm
 | cons a labels ih =>
  change (tails.map (List.cons a) ++ labels.flatMap (fun label => tails.map (List.cons label))).length=(labels.length+1)*tails.length
  rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.mapLength,ih,Nat.succ_mul,Nat.add_comm]
theorem completeEnumerationCount (labels : List Nat) (depth : Nat) : (words labels depth).length=labels.length^depth := by
 induction depth with
 | zero => rfl
 | succ n ih =>
  change (labels.flatMap (fun label => (words labels n).map (List.cons label))).length=_
  rw [productLength,ih,Nat.pow_succ,Nat.mul_comm]
end SFT.Physics.LyapunovKSCorrespondence

import SFT.Physics.BoundarySupport
namespace SFT.Physics.BoundaryPairs
open SFT.Foundation SFT.Foundation.Count.TraceDerivation SpatialStability BoundarySupport

theorem eachPairOnce (left right : List String) (hl : left.Nodup) (hr : right.Nodup) :
 (pairCells left right).Nodup := by
 induction left with
 | nil => exact .nil
 | cons a left ih =>
   cases hl with
   | cons fresh rest =>
     apply FoldAssembly.disjointAppendNodup
     · exact nodupMapInjective (fun b => (a,b)) (fun _ _ h => congrArg Prod.snd h) right hr
     · exact ih rest
     · intro pair member other
       obtain ⟨b,hb,same⟩ := memMapPreimage (fun b => (a,b)) pair right member
       cases same
       exact fresh a ((pairCellMembership left right a b).mp other).1 rfl

theorem completeEquivalentSupport (left right : List String) (hl : left.Nodup) (hr : right.Nodup)
 (scale : Nat) (first : left.length = scale) (second : right.length = scale) :
 (pairCells left right).Nodup ∧ (pairCells left right).length = scale*scale ∧
 ∀ a b, (a,b) ∈ pairCells left right ↔ a ∈ left ∧ b ∈ right :=
 ⟨eachPairOnce left right hl hr,scaledPairCount left right scale first second,pairCellMembership left right⟩
end SFT.Physics.BoundaryPairs

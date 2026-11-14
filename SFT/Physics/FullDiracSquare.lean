import SFT.Physics.AlphaCovers
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.FullDiracSquare
open SFT.Foundation ExactOperations ExactPartCarrier LeptonIntervals
inductive Difference where
 | empty
 | left (magnitude : Rat)
 | right (magnitude : Rat)

def heldDifference (left right : Rat) : Difference :=
 if !left.blt right && !right.blt left then .empty
 else if right.blt left then .left (subtract left right)
 else .right (subtract right left)

structure Result where
 components : List Rat
 directSquare : Rat
 heldEqualDifferences : List Difference
 polarizedSquare : Rat

def fullDiracSquare : Except String Result := do
 let binary ← AlphaCovers.binaryCount
 let carrier ← fromPair 1 (.ofNat binary)
 let half := asFraction carrier
 let components := [half,half,half,half]
 let direct := [half,half,half].foldl (fun sum value => add sum (multiply value value)) (multiply half half)
 let differences := [heldDifference half half,heldDifference half half]
 let pair := add half half
 let present := add (multiply pair pair) (multiply pair pair)
 let polarized := multiply present half
 let absent := differences.all (fun x => match x with | .empty => true | .left _ => false | .right _ => false)
 if (!direct.blt (asFraction one) && !(asFraction one).blt direct) &&
    (!polarized.blt (asFraction one) && !(asFraction one).blt polarized) && absent then
  pure ⟨components,direct,differences,polarized⟩
 else throw "full Dirac square failed one of its exact closure routes"

theorem sourceAssembly : fullDiracSquare=.ok ⟨
 [⟨1,2,by decide,by decide⟩,⟨1,2,by decide,by decide⟩,⟨1,2,by decide,by decide⟩,⟨1,2,by decide,by decide⟩],
 ⟨1,1,by decide,by decide⟩,[.empty,.empty],⟨1,1,by decide,by decide⟩⟩ := by
 unfold fullDiracSquare
 rw [AlphaCovers.binaryCountTwo]
 rfl

theorem everyCompleteCell (result : Result) (returned : fullDiracSquare=.ok result) :
 result.components.length=4 ∧ result.directSquare=asFraction one ∧
 result.polarizedSquare=asFraction one ∧ result.heldEqualDifferences=[.empty,.empty] := by
 rw [sourceAssembly] at returned
 cases returned
 exact ⟨rfl,rfl,rfl,rfl⟩
end SFT.Physics.FullDiracSquare

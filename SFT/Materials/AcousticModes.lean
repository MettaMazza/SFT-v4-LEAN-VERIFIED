import SFT.Materials.CubicCoordination
namespace SFT.Materials.AcousticModes
structure AcousticBranch where
 orientation : String
 generator : String
 deriving Repr

def branches : List AcousticBranch :=
 [⟨"longitudinal","propagation-axis"⟩,
  ⟨"transverse","first-cross-axis"⟩,
  ⟨"transverse","second-cross-axis"⟩]

def acousticBranchCensus : Except String (List AcousticBranch) := do
 let coordination ← CubicCoordination.simpleCubicCoordination
 if branches.length == coordination / 2 then .ok branches
 else .error "acoustic orientation count does not equal spatial generator rank"

theorem exactThreeBranches : branches.length=3 := rfl
theorem sourceCoordinationRelation : branches.length=6/2 := rfl
theorem originalGuardPassed : acousticBranchCensus=.ok branches := rfl
theorem oneLongitudinal : (branches.filter (fun b => SFT.Host.Text.equal b.orientation "longitudinal")).length=1 := rfl
theorem twoTransverse : (branches.filter (fun b => SFT.Host.Text.equal b.orientation "transverse")).length=2 := rfl

theorem completeOrientationMembership (row : AcousticBranch) : row∈branches ↔
 row=⟨"longitudinal","propagation-axis"⟩ ∨
 row=⟨"transverse","first-cross-axis"⟩ ∨ row=⟨"transverse","second-cross-axis"⟩ := by
 constructor
 · intro h
   cases h with
   | head => exact Or.inl rfl
   | tail _ h => cases h with
     | head => exact Or.inr (Or.inl rfl)
     | tail _ h => cases h with
       | head => exact Or.inr (Or.inr rfl)
       | tail _ impossible => cases impossible
 · intro h
   cases h with
   | inl h => cases h; exact .head _
   | inr h => cases h with
     | inl h => cases h; exact .tail _ (.head _)
     | inr h => cases h; exact .tail _ (.tail _ (.head _))
end SFT.Materials.AcousticModes

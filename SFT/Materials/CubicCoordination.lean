import SFT.Materials.Lattice
namespace SFT.Materials.CubicCoordination
open SFT.Mathematics.DiscreteObjects
structure OrientedNeighbour where
 generator : String
 orientation : String
 deriving DecidableEq

def neighbours : List String → List OrientedNeighbour
 | [] => []
 | g::rest => ⟨g,"first-fibre"⟩ :: ⟨g,"second-fibre"⟩ :: neighbours rest

def simpleCubicNeighbours (generators : List String) : Except String (List OrientedNeighbour) :=
 if generators.isEmpty || !(distinct generators) then
   .error "directions must be a nonempty distinct generated carrier"
 else .ok (neighbours generators)

theorem neighbourCount (generators : List String) :
 (neighbours generators).length = generators.length * 2 := by
 induction generators with
 | nil => rfl
 | cons g rest ih =>
   change (neighbours rest).length+1+1 = (rest.length+1)*2
   rw [ih,Nat.succ_mul]

def simpleCubicCoordination : Except String Nat := do
 let rows ← simpleCubicNeighbours ["axis-one","axis-two","axis-three"]
 .ok rows.length

theorem coordinationSix : simpleCubicCoordination = .ok 6 := rfl

theorem emptyRejected : simpleCubicNeighbours [] =
 .error "directions must be a nonempty distinct generated carrier" := rfl
end SFT.Materials.CubicCoordination

import SFT.InformationScience.QuantumBasis
namespace SFT.InformationScience.QuantumJoint
open QuantitySupport SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

abbrev Cell := Word × Word × Word

def jointCells (left right : List Word) : List Cell :=
  left.flatMap (fun a => right.map (fun b => (a,b,a++b)))

def jointSupport (left right : List Word) : Except String (List Cell) :=
  if left.isEmpty || right.isEmpty || !distinct left || !distinct right then
    .error "ValueError: joint support requires two canonical nonempty supports"
  else .ok (jointCells left right)

theorem jointMeaning (left right : List Word) (cells : List Cell) :
    jointSupport left right = .ok cells ↔
      left.isEmpty = false ∧ right.isEmpty = false ∧ distinct left = true ∧ distinct right = true ∧ cells = jointCells left right := by
  unfold jointSupport
  cases le : left.isEmpty <;> cases re : right.isEmpty <;> cases ld : distinct left <;> cases rd : distinct right
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { cases h.2.1 }
  all_goals try { cases h.2.2.1 }
  all_goals try { cases h.2.2.2.1 }
  · exact ⟨rfl,rfl,rfl,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2.2.2]; rfl

theorem cellMembership (left right : List Word) (a b combined : Word) :
    (a,b,combined) ∈ jointCells left right ↔ a ∈ left ∧ b ∈ right ∧ combined = a++b := by
  constructor
  · intro h
    obtain ⟨x,hx,hm⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨y,hy,eq⟩ := memMapPreimage _ _ _ hm
    cases eq
    exact ⟨hx,hy,rfl⟩
  · intro ⟨ha,hb,eq⟩
    cases eq
    exact memFlatMap _ _ a _ ha (memMap _ b _ hb)

theorem cellCoordinates (a b c d : Word) (h : (a,b,a++b) = (c,d,c++d)) : a=c ∧ b=d :=
  ⟨congrArg Prod.fst h,congrArg (fun row : Cell => row.2.1) h⟩

theorem jointLeftSuccessor (a : Word) (left right : List Word) :
    jointCells (a::left) right = right.map (fun b => (a,b,a++b)) ++ jointCells left right := rfl

end SFT.InformationScience.QuantumJoint

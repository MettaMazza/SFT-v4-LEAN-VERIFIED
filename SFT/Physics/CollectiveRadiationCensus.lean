import SFT.Physics.CollectiveRadiation
import SFT.Mathematics.DiscreteComplement
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CollectiveRadiationCensus
open CollectiveRadiation SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement SFT.Mathematics.DiscreteObjects
inductive CoordinateTrace : List (List Nat) → List Nat → Prop where
  | nil : CoordinateTrace [] []
  | cons {axis : List Nat} {axes : List (List Nat)} {value : Nat} {row : List Nat} :
      value ∈ axis → CoordinateTrace axes row → CoordinateTrace (axis :: axes) (value :: row)

theorem completeProduct (axes : List (List Nat)) (row : List Nat) :
    row ∈ occupationProduct axes ↔ CoordinateTrace axes row := by
  induction axes generalizing row with
  | nil =>
    constructor
    · intro member
      cases member with
      | head => exact .nil
      | tail _ impossible => cases impossible
    · intro trace
      cases trace
      exact List.Mem.head []
  | cons axis axes ih =>
    constructor
    · intro member
      obtain ⟨value,held,mapped⟩ := memFlatMapOrigin _ axis row member
      obtain ⟨tail,tailMember,equal⟩ := memMapPreimage (List.cons value) row _ mapped
      cases equal
      exact .cons held ((ih tail).mp tailMember)
    · intro trace
      cases trace with
      | cons held tail => exact memFlatMap _ axis _ _ held (memMap _ _ _ ((ih _).mpr tail))

theorem coordinateCount (axes : List (List Nat)) (row : List Nat)
    (trace : CoordinateTrace axes row) : row.length = axes.length := by
  induction trace with
  | nil => rfl
  | cons _ _ ih => exact congrArg Nat.succ ih


theorem originalCompleteCensus (costs word : List Nat) (total : Nat) :
 word ∈ completeWords costs total ↔
 CoordinateTrace (costs.map (fun c => List.range (total/c+1))) word ∧ wordEnergy costs word=total := by
 constructor
 · intro h
   have kept := (filterMemberIff _ _ _).mp h
   exact ⟨(completeProduct _ _).mp kept.1,Nat.eq_of_beq_eq_true kept.2⟩
 · intro h
   apply (filterMemberIff _ _ _).mpr
   exact ⟨(completeProduct _ _).mpr h.1, by rw [h.2]; exact naturalEqualityReflexive _⟩

theorem originalEnergyPreserved (costs word : List Nat) (total : Nat)
 (held : word ∈ completeWords costs total) : wordEnergy costs word=total :=
 ((originalCompleteCensus costs word total).mp held).2

theorem originalCoordinateCount (costs word : List Nat) (total : Nat)
 (held : word ∈ completeWords costs total) : word.length=costs.length := by
 have shape := ((originalCompleteCensus costs word total).mp held).1
 exact (coordinateCount _ _ shape).trans (mapLength _ _)
end SFT.Physics.CollectiveRadiationCensus

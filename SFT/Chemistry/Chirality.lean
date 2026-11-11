import SFT.Chemistry.MolecularIsomer
namespace SFT.Chemistry.Chirality
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GraphOperations
open SFT.Mathematics.CombinatorialArrangements
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
-- Exact OrientedStructure constructor domain; no distinctness or endpoint guard is added.
structure Raw where
 composition : List PositiveCount
 adjacency : List (PositiveCount × PositiveCount)
 orientation : HeldLabel
 deriving DecidableEq

def admit (r : Raw) : Except String Raw :=
 if r.composition.isEmpty || r.adjacency.isEmpty ||
 !(SFT.Host.Text.equal r.orientation.family "molecular-orientation") then
 .error "oriented molecular structure is incomplete" else .ok r

theorem emptyCompositionRejected (a : List (PositiveCount × PositiveCount)) (o : HeldLabel) :
 admit ⟨[],a,o⟩=.error "oriented molecular structure is incomplete" := rfl

theorem emptyAdjacencyRejected (c : List PositiveCount) (o : HeldLabel) :
 admit ⟨c,[],o⟩=.error "oriented molecular structure is incomplete" := by
 unfold admit
 cases c <;> rfl

theorem nonemptyAccepted (c : PositiveCount) (cs : List PositiveCount)
 (a : PositiveCount × PositiveCount) (ads : List (PositiveCount × PositiveCount))
 (o : HeldLabel) (family : SFT.Host.Text.equal o.family "molecular-orientation"=true) :
 admit ⟨c::cs,a::ads,o⟩=.ok ⟨c::cs,a::ads,o⟩ := by
 unfold admit
 rw [family]
 rfl

-- Complete map traces retain each generated order, including failed comparisons.
-- The entry-specific orientation and reflection construction binds the comparison.
def mapTrace (carrier : List String) (comparison : List String → Bool) :=
 (arrangementsCore carrier).map (fun order => (order,comparison order))

def superposable (carrier : List String) (comparison : List String → Bool) : Bool :=
 (arrangementsCore carrier).any comparison

theorem exhaustiveSuperposition (carrier : List String)
 (nonempty : carrier≠[]) (unique : distinct carrier=true)
 (comparison : List String → Bool) :
 superposable carrier comparison=true ↔
 ∃ order, List.Perm order carrier ∧ comparison order=true := by
 constructor
 · intro found
   obtain ⟨order,held,passed⟩ := (anyTrueWitness _ _).mp found
   exact ⟨order,everyArrangementPermutesCarrier carrier unique order held,passed⟩
 · intro found
   obtain ⟨order,perm,passed⟩ := found
   exact (anyTrueWitness _ _).mpr
    ⟨order,everyPermutationGenerated carrier nonempty unique order perm,passed⟩

theorem noSuperpositionExactly (carrier : List String)
 (nonempty : carrier≠[]) (unique : distinct carrier=true)
 (comparison : List String → Bool) :
 superposable carrier comparison=false ↔
 ∀ order, List.Perm order carrier → comparison order=false := by
 constructor
 · intro rejected order perm
   cases h : comparison order with
   | false => rfl
   | true =>
     have accepted := (exhaustiveSuperposition carrier nonempty unique comparison).mpr ⟨order,perm,h⟩
     rw [rejected] at accepted
     cases accepted
 · intro every
   cases h : superposable carrier comparison with
   | false => rfl
   | true =>
     obtain ⟨order,perm,passed⟩ := (exhaustiveSuperposition carrier nonempty unique comparison).mp h
     rw [every order perm] at passed
     cases passed

end SFT.Chemistry.Chirality

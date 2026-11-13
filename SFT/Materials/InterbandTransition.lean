import SFT.Materials.CarrierAccess
import SFT.Physics.CollectiveBand
import SFT.Host.Canonical

namespace SFT.Materials.InterbandTransition
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects

-- SEMI-OPTICAL's declared carrier retains the material-specific probe and
-- selection relation. These supplied records do not define a universal gap
-- magnitude or introduce an additional constitutive equation.
structure Boundary where
 band : SFT.Physics.CollectiveBand.Boundary
 occupied : List String
 accessible : List String
 occupiedBand : ∀ label, label ∈ occupied → ∃ trace,
   trace ∈ SFT.Physics.CollectiveBand.support band ∧ band.observedClass trace = label
 accessibleBand : ∀ label, label ∈ accessible → ∃ trace,
   trace ∈ SFT.Physics.CollectiveBand.support band ∧ band.observedClass trace = label
 probeCompatible : List Edge
 selected : List Edge
 probeRecord : SFT.Host.Canonical.Value
 occupationGapMomentum : SFT.Host.Canonical.Value
 selectionResolution : SFT.Host.Canonical.Value

def transitions (b : Boundary) : List Edge :=
 (CarrierAccess.pairs b.occupied b.accessible).filter
  (fun edge => has b.probeCompatible edge && has b.selected edge)

theorem transitionExactly (b : Boundary) (source target : String) :
 (source,target) ∈ transitions b ↔ source ∈ b.occupied ∧ target ∈ b.accessible ∧
 (source,target) ∈ b.probeCompatible ∧ (source,target) ∈ b.selected := by
 constructor
 · intro held
   have h := (filterMemberIff _ _ _).mp held
   have pair := (CarrierAccess.pairMembership _ _ _ _).mp h.1
   have checks := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp h.2
   exact ⟨pair.1,pair.2,(hasIff _ _).mp checks.1,(hasIff _ _).mp checks.2⟩
 · intro ⟨sourceHeld,targetHeld,probe,selection⟩
   exact (filterMemberIff _ _ _).mpr
    ⟨(CarrierAccess.pairMembership _ _ _ _).mpr ⟨sourceHeld,targetHeld⟩,
     (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
      ⟨(hasIff _ _).mpr probe,(hasIff _ _).mpr selection⟩⟩

theorem endpointsAreBandStates (b : Boundary) (source target : String)
 (held : (source,target) ∈ transitions b) :
 (∃ trace, trace ∈ SFT.Physics.CollectiveBand.support b.band ∧ b.band.observedClass trace = source) ∧
 (∃ trace, trace ∈ SFT.Physics.CollectiveBand.support b.band ∧ b.band.observedClass trace = target) := by
 have h := (transitionExactly b source target).mp held
 exact ⟨b.occupiedBand source h.1,b.accessibleBand target h.2.1⟩

theorem incompatibleExcluded (b : Boundary) (source target : String)
 (absent : (source,target) ∉ b.probeCompatible) : (source,target) ∉ transitions b := by
 intro held
 exact absent ((transitionExactly b source target).mp held).2.2.1

theorem selectionExcluded (b : Boundary) (source target : String)
 (absent : (source,target) ∉ b.selected) : (source,target) ∉ transitions b := by
 intro held
 exact absent ((transitionExactly b source target).mp held).2.2.2

-- Full boundary records, not just endpoint labels, survive finite extension.
def records (history : List Boundary) := history.map (fun b => (b,transitions b))

theorem rowHasOriginalBoundary (history : List Boundary) (row : Boundary × List Edge)
 (held : row ∈ records history) :
 ∃ b, b ∈ history ∧ row = (b,transitions b) := by
 obtain ⟨b,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage
  (fun b : Boundary => (b,transitions b)) row history held
 exact ⟨b,member,same.symm⟩

theorem base (b : Boundary) : records [b] = [(b,transitions b)] := rfl

theorem appendExactly (left right : List Boundary) :
 records (left ++ right) = records left ++ records right := by
 induction left with
 | nil => rfl
 | cons first rest ih => exact congrArg (List.cons (first,transitions first)) ih

theorem successor (history : List Boundary) (next : Boundary) :
 records (history ++ [next]) = records history ++ [(next,transitions next)] :=
 appendExactly history [next]

theorem earlierBoundaryRetained (history : List Boundary) (next b : Boundary)
 (held : b ∈ history) : (b,transitions b) ∈ records (history ++ [next]) := by
 rw [successor]
 exact SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _
  (SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held)

end SFT.Materials.InterbandTransition

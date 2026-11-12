import SFT.Materials.Lattice
import SFT.Physics.WaveDiffraction
namespace SFT.Materials.ReciprocalSupport
open SFT.Physics SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations
open SFT.Foundation.CommonRefinement

-- MATERIALS_OBLIGATIONS[14]: the labels and phase traces are the probe
-- carrier. The return test is computed over every site, not supplied as a
-- premise asserting that a probe is coherent. Phase is a representation type.
structure Probe (Phase : Type) where
 label : String
 source : MechanicalEvents.Event Phase
 arrival : String → MechanicalEvents.Event Phase
 path : (site : String) → MechanicalEvents.Path source (arrival site)
 support : String → PositiveFraction

variable {Phase : Type}

def returnsAt (p : Probe Phase) (site : String) : Prop :=
 (p.arrival site).carrier = p.source.carrier

def completeReturn (p : Probe Phase) (sites : List String) : Prop :=
 ∀ site, site ∈ sites → returnsAt p site

def returnTest [DecidableEq Phase] (p : Probe Phase) : List String → Bool
 | [] => true
 | site::rest => if (p.arrival site).carrier = p.source.carrier then returnTest p rest else false

theorem returnTestExactly [DecidableEq Phase] (p : Probe Phase) (sites : List String) :
 returnTest p sites = true ↔ completeReturn p sites := by
 induction sites with
 | nil =>
   constructor
   · intro _ site h; cases h
   · intro _; rfl
 | cons site rest ih =>
   unfold returnTest
   split
   · rename_i same
     constructor
     · intro h a ha
       cases ha with
       | head => exact same
       | tail _ held => exact ih.mp h a held
     · intro h; exact ih.mpr (fun a ha => h a (.tail _ ha))
   · rename_i different
     constructor
     · intro h; cases h
     · intro h; exact False.elim (different (h site (.head _)))

def reciprocalSupport [DecidableEq Phase] (sites : List String) (probes : List (Probe Phase)) :=
 WaveDiffraction.retained (fun p => returnTest p sites) probes

theorem exactReciprocalClass [DecidableEq Phase] (sites : List String)
 (probes : List (Probe Phase)) (p : Probe Phase) :
 p ∈ reciprocalSupport sites probes ↔ p ∈ probes ∧ completeReturn p sites := by
 constructor
 · intro h
   have row := (WaveDiffraction.retainedMember _ _ _).mp h
   exact ⟨row.1,(returnTestExactly p sites).mp row.2⟩
 · intro h
   exact (WaveDiffraction.retainedMember _ _ _).mpr ⟨h.1,(returnTestExactly p sites).mpr h.2⟩

theorem nonreturningSiteExcluded [DecidableEq Phase] (sites : List String)
 (probes : List (Probe Phase)) (p : Probe Phase) (site : String)
 (present : site ∈ sites) (different : ¬ returnsAt p site) :
 p ∉ reciprocalSupport sites probes :=
 fun h => different (((exactReciprocalClass sites probes p).mp h).2 site present)

theorem successorReturnExactly (p : Probe Phase) (sites : List String) (site : String) :
 completeReturn p (sites ++ [site]) ↔ completeReturn p sites ∧ returnsAt p site := by
 constructor
 · intro h
   exact ⟨fun a ha => h a (SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ ha),
    h site (SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head _))⟩
 · intro h a ha
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases a sites [site] ha with
   | inl old => exact h.1 a old
   | inr last => cases last with
     | head => exact h.2
     | tail _ impossible => cases impossible

def completePaths (p : Probe Phase) (sites : List String) :=
 sites.map (fun site => (site,MechanicalEvents.changes (p.path site)))

theorem completePathCount (p : Probe Phase) (sites : List String) :
 (completePaths p sites).length = sites.length := mapLength _ sites

theorem earlierPathsRetained (p : Probe Phase) (sites : List String) (site : String) :
 completePaths p (sites ++ [site]) = completePaths p sites ++ [(site,MechanicalEvents.changes (p.path site))] :=
 ReferenceRealization.mapAppendOne _ _ _

def closedPath (p : Probe Phase) (site : String) (returned : returnsAt p site)
 (positive : 0 < MechanicalEvents.count (p.path site)) : MechanicalDuration.Recurrence Phase :=
 ⟨p.source,p.arrival site,p.path site,returned,positive⟩

-- Once the endpoint returns to the source phase, both support contributions
-- have the same held orientation. This invokes the original interference law.
theorem coherentMergeRetainsSupport (p : Probe Phase) (site : String)
 (observedOrientation : Phase → Orientation) (returned : returnsAt p site)
 (sourceSupport : PositiveFraction) :
 add (.positive (observedOrientation (p.arrival site).carrier) (p.support site))
     (.positive (observedOrientation p.source.carrier) sourceSupport) =
 .positive (observedOrientation p.source.carrier) (sumMagnitude (p.support site) sourceSupport) := by
 unfold returnsAt at returned
 rw [returned]
 exact WaveInterference.matchingLabelsRetainSupport _ _ _

-- Complete predecessor merging, rather than merely accepting a label.
def mergedObservation (p : Probe Phase) (orientation : Phase → Orientation) : List String → Scalar
 | [] => .emptyOne
 | site::rest => add (.positive (orientation (p.arrival site).carrier) (p.support site))
     (mergedObservation p orientation rest)

def coherentMagnitude (p : Probe Phase) (first : String) : List String → PositiveFraction
 | [] => p.support first
 | site::rest => sumMagnitude (p.support first) (coherentMagnitude p site rest)

theorem completeCoherentMerge (p : Probe Phase) (orientation : Phase → Orientation)
 (first : String) (rest : List String) (returned : completeReturn p (first::rest)) :
 mergedObservation p orientation (first::rest) =
 .positive (orientation p.source.carrier) (coherentMagnitude p first rest) := by
 induction rest generalizing first with
 | nil =>
   have eq := returned first (.head _)
   unfold returnsAt at eq
   change add (.positive (orientation (p.arrival first).carrier) (p.support first)) .emptyOne = _
   rw [eq]
   cases orientation p.source.carrier <;> rfl
 | cons site rest ih =>
   have eq := returned first (.head _)
   unfold returnsAt at eq
   have tail := ih site (fun a ha => returned a (.tail _ ha))
   change add (.positive (orientation (p.arrival first).carrier) (p.support first))
     (mergedObservation p orientation (site::rest)) = _
   rw [eq,tail]
   exact WaveInterference.matchingLabelsRetainSupport _ _ _

theorem coherentPeakPresent (p : Probe Phase) (orientation : Phase → Orientation)
 (first : String) (rest : List String) (returned : completeReturn p (first::rest)) :
 mergedObservation p orientation (first::rest) ≠ .emptyOne := by
 rw [completeCoherentMerge p orientation first rest returned]
 intro absent
 cases absent

theorem completeOrganizationReturn [DecidableEq Phase]
 (organization : CollectiveCoarseGrain.NetworkObservation) (probes : List (Probe Phase))
 (p : Probe Phase) (retained : p ∈ reciprocalSupport organization.graph.nodes probes)
 (site : String) (generated : site ∈ organization.graph.nodes) : returnsAt p site :=
 ((exactReciprocalClass _ _ p).mp retained).2 site generated
end SFT.Materials.ReciprocalSupport

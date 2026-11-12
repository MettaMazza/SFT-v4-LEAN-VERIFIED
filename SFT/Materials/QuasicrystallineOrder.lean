import SFT.Materials.ReciprocalSupport
import SFT.Materials.RotationClosure
namespace SFT.Materials.QuasicrystallineOrder
open ReciprocalSupport RotationTotient SFT.Physics
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[15]: coherent recurrence and retained diffraction
-- across every generated finite depth. Periods below reuse the actual
-- site/word/adjacency translation records of the registered lattice dependency.
-- A family supplies each finite successor; no completed infinite list is used.
-- The word and probe are retained carrier data, not fitted model constants.
structure Organization (Phase : Type) where
 site : Nat → String
 probe : Probe Phase
 orientation : Phase → SFT.Mathematics.FoldScalar.Orientation
 observationBoundary : String
 rotationalOrder : PositiveCount

variable {Phase : Type}
def laterSites (o : Organization Phase) : Nat → List String
 | 0 => []
 | n+1 => laterSites o n ++ [o.site (n+1)]
def sites (o : Organization Phase) (n : Nat) : List String := o.site 0 :: laterSites o n

def coherentRecurrence (o : Organization Phase) : Prop :=
 ∀ n, completeReturn o.probe (sites o n)
-- The material word and adjacency remain attached to the complete site carrier.
structure MaterialFamily (Phase : Type) extends Organization Phase where
 word : String → List String
 network : Nat → CollectiveCoarseGrain.NetworkObservation
 completeSites : ∀ n, (network n).graph.nodes = sites toOrganization n

-- A period uses one held translation action at every finite depth. Each
-- component is the original lattice translation, including word and adjacency
-- recurrence. Structural identity is excluded by a moved held site.
structure TranslationPeriod (o : MaterialFamily Phase) where
 shift : String → String
 translation : Nat → Lattice.Record
 sameGraph : ∀ n, (translation n).cells.graph = (o.network n).graph
 sameWord : ∀ n site, (translation n).word site = o.word site
 sameShift : ∀ n site, (translation n).shift site = shift site
 nontrivial : ∃ n site, site ∈ (o.network n).graph.nodes ∧ shift site ≠ site

def noFiniteTranslation (o : MaterialFamily Phase) : Prop :=
 ¬ Nonempty (TranslationPeriod o)
def quasicrystalline (o : MaterialFamily Phase) : Prop :=
 coherentRecurrence o.toOrganization ∧ noFiniteTranslation o

theorem periodRetainsEveryGeneratedWord (o : MaterialFamily Phase)
 (period : TranslationPeriod o) (n repeats : Nat) (site : String)
 (held : site ∈ (o.network n).graph.nodes) :
 o.word (Lattice.translate (period.translation n) repeats site) = o.word site := by
 have supported : site ∈ (period.translation n).cells.graph.nodes := by
   rw [period.sameGraph]; exact held
 exact (period.sameWord n _).symm.trans
   ((Lattice.everyLocalWordRecurs _ repeats site supported).trans (period.sameWord n site))

theorem periodRetainsEveryGeneratedAdjacency (o : MaterialFamily Phase)
 (period : TranslationPeriod o) (n repeats : Nat) (a b : String)
 (ha : a ∈ (o.network n).graph.nodes) (hb : b ∈ (o.network n).graph.nodes) :
 (Lattice.translate (period.translation n) repeats a,
  Lattice.translate (period.translation n) repeats b) ∈ (o.network n).graph.edges ↔
 (a,b) ∈ (o.network n).graph.edges := by
 have ga : a ∈ (period.translation n).cells.graph.nodes := by rw [period.sameGraph]; exact ha
 have gb : b ∈ (period.translation n).cells.graph.nodes := by rw [period.sameGraph]; exact hb
 have h := Lattice.everyAdjacencyRecurs (period.translation n) repeats a b ga gb
 rw [period.sameGraph] at h
 exact h

theorem periodActionAtEveryDepth (o : MaterialFamily Phase) (period : TranslationPeriod o)
 (n : Nat) (site : String) : Lattice.translate (period.translation n) 1 site = period.shift site :=
 period.sameShift n site

theorem noPeriodExactly (o : MaterialFamily Phase) :
 noFiniteTranslation o ↔ ∀ period : TranslationPeriod o, False := by
 constructor
 · intro h period; exact h ⟨period⟩
 · intro h ⟨period⟩; exact h period

theorem siteSuccessor (o : Organization Phase) (n : Nat) :
 sites o (n+1)=sites o n ++ [o.site (n+1)] := rfl

theorem finiteCarrierCount (o : Organization Phase) (n : Nat) : (sites o n).length=n+1 := by
 have later : ∀ k, (laterSites o k).length=k := by
   intro k; induction k with
   | zero => rfl
   | succ k ih =>
     unfold laterSites
     rw [appendLength,ih]
     rfl
 change (laterSites o n).length+1=n+1
 rw [later]

theorem appendedSiteHeld (o : Organization Phase) (n : Nat) : o.site n ∈ sites o n := by
 cases n with
 | zero => exact .head _
 | succ n =>
   rw [siteSuccessor]
   exact memAppendRight _ _ _ (.head _)

theorem recurrentExactlyEverySite (o : Organization Phase) :
 coherentRecurrence o ↔ ∀ n, returnsAt o.probe (o.site n) := by
 constructor
 · intro h n; exact h n _ (appendedSiteHeld o n)
 · intro h n
   induction n with
   | zero =>
     intro site held
     cases held with
     | head => exact h 0
     | tail _ impossible => cases impossible
   | succ n ih =>
     rw [siteSuccessor]
     exact (successorReturnExactly o.probe (sites o n) (o.site (n+1))).mpr ⟨ih,h (n+1)⟩

theorem coherentPeakEveryDepth (o : Organization Phase) (held : coherentRecurrence o) (n : Nat) :
 mergedObservation o.probe o.orientation (sites o n) ≠ .emptyOne :=
 coherentPeakPresent o.probe o.orientation (o.site 0) (laterSites o n) (held n)

theorem exactMergedSupportEveryDepth (o : Organization Phase) (held : coherentRecurrence o) (n : Nat) :
 mergedObservation o.probe o.orientation (sites o n) =
 .positive (o.orientation o.probe.source.carrier)
   (coherentMagnitude o.probe (o.site 0) (laterSites o n)) :=
 completeCoherentMerge o.probe o.orientation (o.site 0) (laterSites o n) (held n)

theorem completeProbeTraceCount (o : Organization Phase) (n : Nat) :
 (completePaths o.probe (sites o n)).length=n+1 :=
 (completePathCount _ _).trans (finiteCarrierCount o n)

theorem successorPreservesPaths (o : Organization Phase) (n : Nat) :
 completePaths o.probe (sites o (n+1)) = completePaths o.probe (sites o n) ++
 [(o.site (n+1),MechanicalEvents.changes (o.probe.path (o.site (n+1))))] := by
 rw [siteSuccessor]
 exact earlierPathsRetained _ _ _

theorem sourceCharacterization (o : MaterialFamily Phase) :
 quasicrystalline o ↔
 (∀ n, returnsAt o.probe (o.site n)) ∧ (∀ period : TranslationPeriod o, False) := by
 constructor
 · intro h
   exact ⟨(recurrentExactlyEverySite o.toOrganization).mp h.1,(noPeriodExactly o).mp h.2⟩
 · intro h
   exact ⟨(recurrentExactlyEverySite o.toOrganization).mpr h.1,(noPeriodExactly o).mpr h.2⟩

theorem quasicrystalHasCoherentPeaks (o : MaterialFamily Phase) (held : quasicrystalline o) (n : Nat) :
 mergedObservation o.probe o.orientation (sites o.toOrganization n) ≠ .emptyOne :=
 coherentPeakEveryDepth o.toOrganization held.1 n

-- The periodic-lattice restriction is reused exactly; no replacement angular
-- rule is imposed on the aperiodic carrier.
theorem fivefoldOutsidePeriodicClosure (order : PositiveCount) (fivefold : order.val=5) :
 crystallographicRotationAdmitted order = false := by
 obtain ⟨n,h⟩ := order
 change n=5 at fivefold
 cases fivefold
 exact RotationClosure.fiveExcluded

end SFT.Materials.QuasicrystallineOrder

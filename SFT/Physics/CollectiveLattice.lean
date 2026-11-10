import SFT.Physics.CollectiveMagnetofluid
namespace SFT.Physics.CollectiveLattice
open SFT.Mathematics.GraphOperations

-- The source's translation record retains the complete graph and local word.
-- Iteration below is the generated finite translation history, not a supplied
-- continuum coordinate or dispersion relation.
structure Translation where
 cells : CollectiveCoarseGrain.NetworkObservation
 word : String → List String
 shift : String → String
 supported : ∀ x, x ∈ cells.graph.nodes → shift x ∈ cells.graph.nodes
 wordRecurs : ∀ x, x ∈ cells.graph.nodes → word (shift x) = word x
 neighborsRecur : ∀ a b, a ∈ cells.graph.nodes → b ∈ cells.graph.nodes →
   ((shift a,shift b) ∈ cells.graph.edges ↔ (a,b) ∈ cells.graph.edges)

def translate (t : Translation) : Nat → String → String
 | 0,x => x
 | n+1,x => t.shift (translate t n x)

theorem everyTranslatedCellGenerated (t : Translation) (n : Nat) (x : String)
 (held : x ∈ t.cells.graph.nodes) : translate t n x ∈ t.cells.graph.nodes := by
 induction n with
 | zero => exact held
 | succ n ih => exact t.supported _ ih

theorem constituentWordRecurs (t : Translation) (n : Nat) (x : String)
 (held : x ∈ t.cells.graph.nodes) : t.word (translate t n x) = t.word x := by
 induction n with
 | zero => rfl
 | succ n ih => exact (t.wordRecurs _ (everyTranslatedCellGenerated t n x held)).trans ih

theorem neighborRelationRecurs (t : Translation) (n : Nat) (a b : String)
 (ha : a ∈ t.cells.graph.nodes) (hb : b ∈ t.cells.graph.nodes) :
 (translate t n a,translate t n b) ∈ t.cells.graph.edges ↔ (a,b) ∈ t.cells.graph.edges := by
 induction n with
 | zero => exact Iff.rfl
 | succ n ih => exact (t.neighborsRecur _ _ (everyTranslatedCellGenerated t n a ha)
     (everyTranslatedCellGenerated t n b hb)).trans ih

def translationTrace (t : Translation) : Nat → String → List String
 | 0,x => [x]
 | n+1,x => translationTrace t n x ++ [translate t (n+1) x]

theorem completeTranslationCensus (t : Translation) (n : Nat) (x : String) :
 (translationTrace t n x).length = n+1 := by
 induction n with
 | zero => rfl
 | succ n ih =>
   change (translationTrace t n x ++ [translate t (n+1) x]).length = _
   rw [SFT.Foundation.CommonRefinement.appendLength,ih]
   rfl

theorem earlierTranslationRetained (t : Translation) (n : Nat) (x y : String)
 (held : y ∈ translationTrace t n x) : y ∈ translationTrace t (n+1) x :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

structure Excitation (t : Translation) where
 source : String
 generated : source ∈ t.cells.graph.nodes
 changedWord : List String
 departure : changedWord ≠ t.word source
 sourceIdentity : String
 actionRecord : SFT.Host.Canonical.Value

def propagated {t : Translation} (e : Excitation t) (n : Nat) :=
 (translate t n e.source,e.changedWord,e.sourceIdentity,e.actionRecord)

theorem excitationRetainsDeparture {t : Translation} (e : Excitation t) (n : Nat) :
 e.changedWord ≠ t.word (translate t n e.source) := by
 rw [constituentWordRecurs t n e.source e.generated]
 exact e.departure

theorem excitationRemainsOnSupport {t : Translation} (e : Excitation t) (n : Nat) :
 (propagated e n).1 ∈ t.cells.graph.nodes := everyTranslatedCellGenerated t n e.source e.generated

theorem excitationRetainsSource {t : Translation} (e : Excitation t) (n : Nat) :
 (propagated e n).2.2.1 = e.sourceIdentity ∧ (propagated e n).2.2.2 = e.actionRecord := ⟨rfl,rfl⟩

theorem translatedNeighborExcitation {t : Translation} (e : Excitation t) (neighbor : String)
 (present : neighbor ∈ t.cells.graph.nodes) (adjacent : (e.source,neighbor) ∈ t.cells.graph.edges)
 (n : Nat) : (translate t n e.source,translate t n neighbor) ∈ t.cells.graph.edges :=
 (neighborRelationRecurs t n e.source neighbor e.generated present).mpr adjacent

abbrev completeCellProvenance := CollectiveCoarseGrain.completeNetworkRetained
end SFT.Physics.CollectiveLattice

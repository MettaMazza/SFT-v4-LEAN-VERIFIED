import SFT.Materials.CrystalTranslationOrientation
import SFT.Physics.SpatialStability
namespace SFT.Materials.CrystalTranslationBasis
open Lattice CrystalTranslationOrientation
-- The registered spatial dependency supplies the generator-count window.
-- Each generated direction retains the same complete site/word carrier.
structure Basis (carrier : Record) where
 directions : List Record
 stable : directions.length ∈ SFT.Physics.SpatialStability.stableCounts 2
 sameGraph : ∀ direction, direction ∈ directions → direction.cells.graph = carrier.cells.graph
 sameWord : ∀ direction, direction ∈ directions → ∀ site, direction.word site = carrier.word site

variable {carrier : Record} {basis : Basis carrier}

theorem directionCount (basis : Basis carrier) : basis.directions.length = 3 :=
 (SFT.Physics.SpatialStability.onlySpatialCount _).mp basis.stable

inductive Step (basis : Basis carrier) : Pair → Pair → Prop where
 | generated (direction : Record) (held : direction ∈ basis.directions)
     (step : CrystalTranslationOrientation.Step direction p q) : Step basis p q

theorem stepInvariant (basis : Basis carrier) (step : Step basis p q) :
 Invariant carrier p q := by
 cases step with
 | generated direction held original =>
   have h := CrystalTranslationOrientation.stepInvariant original
   refine ⟨(basis.sameWord direction held p.1).symm.trans
      (h.1.trans (basis.sameWord direction held q.1)),
     (basis.sameWord direction held p.2).symm.trans
      (h.2.1.trans (basis.sameWord direction held q.2)),?_⟩
   have adjacency := h.2.2
   rw [basis.sameGraph direction held] at adjacency
   exact adjacency

inductive Trace (basis : Basis carrier) : Pair → Pair → Prop where
 | initial (p : Pair) : Trace basis p p
 | append : Trace basis p q → Step basis q r → Trace basis p r

theorem allGeneratedTraversals (trace : Trace basis p q) : Invariant carrier p q := by
 induction trace with
 | initial => exact ⟨rfl,rfl,Iff.rfl⟩
 | append previous step ih =>
   have h := stepInvariant _ step
   exact ⟨ih.1.trans h.1,ih.2.1.trans h.2.1,ih.2.2.trans h.2.2⟩

theorem compose (first : Trace basis p q) (second : Trace basis q r) : Trace basis p r := by
 induction second with
 | initial => exact first
 | append previous step ih => exact .append ih step

theorem reverseStep (step : Step basis p q) : Step basis q p := by
 cases step with
 | generated direction held original =>
   exact .generated direction held (CrystalTranslationOrientation.reverseStep original)

theorem reverseTrace (trace : Trace basis p q) : Trace basis q p := by
 induction trace with
 | initial => exact .initial _
 | append previous step ih => exact compose (.append (.initial _) (reverseStep step)) ih

theorem traversalClassIndependent (first : Trace basis p q) (second : Trace basis p r) :
 Invariant carrier q r := allGeneratedTraversals (compose (reverseTrace first) second)

theorem leastGenerated (relation : Pair → Pair → Prop)
 (base : ∀ p, relation p p)
 (next : ∀ {p q r}, relation p q → Step basis q r → relation p r)
 (trace : Trace basis p q) : relation p q := by
 induction trace with
 | initial => exact base _
 | append previous step ih => exact next ih step
end SFT.Materials.CrystalTranslationBasis

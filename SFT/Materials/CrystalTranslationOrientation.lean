import SFT.Materials.CrystalTranslationAction
namespace SFT.Materials.CrystalTranslationOrientation
open Lattice
abbrev Pair := String × String
-- MATERIALS_OBLIGATIONS[9]: simultaneous translation of both retained sites.
-- An opposed traversal retains the same source/target relation in reverse.
inductive Step (record : Record) : Pair → Pair → Prop where
 | forward (a b : String) (ha : a ∈ record.cells.graph.nodes)
     (hb : b ∈ record.cells.graph.nodes) :
     Step record (a,b) (record.shift a,record.shift b)
 | opposed (a b : String) (ha : a ∈ record.cells.graph.nodes)
     (hb : b ∈ record.cells.graph.nodes) :
     Step record (record.shift a,record.shift b) (a,b)

def Invariant (record : Record) (p q : Pair) : Prop :=
 record.word p.1 = record.word q.1 ∧ record.word p.2 = record.word q.2 ∧
 (p ∈ record.cells.graph.edges ↔ q ∈ record.cells.graph.edges)

theorem stepInvariant (step : Step record p q) : Invariant record p q := by
 cases step with
 | forward a b ha hb =>
   exact ⟨(record.wordRecurs a ha).symm,(record.wordRecurs b hb).symm,
     (record.neighborsRecur a b ha hb).symm⟩
 | opposed a b ha hb =>
   exact ⟨record.wordRecurs a ha,record.wordRecurs b hb,
     record.neighborsRecur a b ha hb⟩

theorem reverseStep (step : Step record p q) : Step record q p := by
 cases step with
 | forward a b ha hb => exact .opposed a b ha hb
 | opposed a b ha hb => exact .forward a b ha hb

inductive Trace (record : Record) : Pair → Pair → Prop where
 | initial (p : Pair) : Trace record p p
 | append : Trace record p q → Step record q r → Trace record p r

theorem traceInvariant (trace : Trace record p q) : Invariant record p q := by
 induction trace with
 | initial => exact ⟨rfl,rfl,Iff.rfl⟩
 | append previous step ih =>
   have h := stepInvariant step
   exact ⟨ih.1.trans h.1,ih.2.1.trans h.2.1,ih.2.2.trans h.2.2⟩

theorem compose (first : Trace record p q) (second : Trace record q r) :
 Trace record p r := by
 induction second with
 | initial => exact first
 | append previous step ih => exact .append ih step

theorem reverseTrace (trace : Trace record p q) : Trace record q p := by
 induction trace with
 | initial => exact .initial _
 | append previous step ih =>
   exact compose (.append (.initial _) (reverseStep step)) ih

theorem generatedIteration (record : Record) (n : Nat) (a b : String)
 (ha : a ∈ record.cells.graph.nodes) (hb : b ∈ record.cells.graph.nodes) :
 Trace record (a,b) (translate record n a,translate record n b) := by
 induction n with
 | zero => exact .initial _
 | succ n ih => exact .append ih (.forward _ _
     (everyTranslationHeld record n a ha) (everyTranslationHeld record n b hb))

theorem leastGenerated (relation : Pair → Pair → Prop)
 (base : ∀ p, relation p p)
 (next : ∀ {p q r}, relation p q → Step record q r → relation p r)
 (trace : Trace record p q) : relation p q := by
 induction trace with
 | initial => exact base _
 | append previous step ih => exact next ih step
end SFT.Materials.CrystalTranslationOrientation

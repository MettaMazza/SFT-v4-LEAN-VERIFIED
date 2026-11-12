import SFT.Materials.Lattice
namespace SFT.Materials.CrystalTranslationAction
-- MATERIALS_OBLIGATIONS[9], generated translation composition and declared depth.
-- Reuses the registered condensed-lattice operation without changing its domain.
open Lattice

theorem generatedComposition (record : Record) (m n : Nat) (site : String) :
 translate record (m+n) site = translate record n (translate record m site) := by
 induction n with
 | zero => rfl
 | succ n ih =>
   change record.shift (translate record (m+n) site) =
     record.shift (translate record n (translate record m site))
   exact congrArg record.shift ih

theorem composedWord (record : Record) (m n : Nat) (site : String)
 (held : site ∈ record.cells.graph.nodes) :
 record.word (translate record n (translate record m site)) = record.word site :=
 (everyLocalWordRecurs record n _ (everyTranslationHeld record m site held)).trans
   (everyLocalWordRecurs record m site held)

theorem composedAdjacency (record : Record) (m n : Nat) (a b : String)
 (ha : a ∈ record.cells.graph.nodes) (hb : b ∈ record.cells.graph.nodes) :
 (translate record n (translate record m a),translate record n (translate record m b))
   ∈ record.cells.graph.edges ↔ (a,b) ∈ record.cells.graph.edges :=
 (everyAdjacencyRecurs record n _ _ (everyTranslationHeld record m a ha)
   (everyTranslationHeld record m b hb)).trans (everyAdjacencyRecurs record m a b ha hb)

theorem declaredDepth (record : Record) (depth : Nat) (site : String) :
 (translationTrace record depth site).length = depth+1 :=
 completeFiniteTrace record depth site
end SFT.Materials.CrystalTranslationAction

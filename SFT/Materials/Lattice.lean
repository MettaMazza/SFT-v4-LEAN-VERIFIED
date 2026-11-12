import SFT.Physics.CollectiveLattice
namespace SFT.Materials.Lattice
open SFT.Physics
-- MATERIALS_OBLIGATIONS[7]: exact existing site/word/adjacency translation.
abbrev Record := CollectiveLattice.Translation
abbrev translate := CollectiveLattice.translate
abbrev translationTrace := CollectiveLattice.translationTrace

theorem completeSiteCarrier (record : Record) :
 record.cells.graph=⟨record.cells.nodes,record.cells.edges⟩ :=
 CollectiveCoarseGrain.completeNetworkRetained record.cells

theorem everyTranslationHeld (record : Record) (n : Nat) (site : String)
 (held : site∈record.cells.graph.nodes) : translate record n site∈record.cells.graph.nodes :=
 CollectiveLattice.everyTranslatedCellGenerated record n site held

theorem everyLocalWordRecurs (record : Record) (n : Nat) (site : String)
 (held : site∈record.cells.graph.nodes) : record.word (translate record n site)=record.word site :=
 CollectiveLattice.constituentWordRecurs record n site held

theorem everyAdjacencyRecurs (record : Record) (n : Nat) (a b : String)
 (ha : a∈record.cells.graph.nodes) (hb : b∈record.cells.graph.nodes) :
 (translate record n a,translate record n b)∈record.cells.graph.edges ↔ (a,b)∈record.cells.graph.edges :=
 CollectiveLattice.neighborRelationRecurs record n a b ha hb

theorem completeFiniteTrace (record : Record) (n : Nat) (site : String) :
 (translationTrace record n site).length=n+1 := CollectiveLattice.completeTranslationCensus record n site

theorem priorTranslationRetained (record : Record) (n : Nat) (site prior : String)
 (held : prior∈translationTrace record n site) : prior∈translationTrace record (n+1) site :=
 CollectiveLattice.earlierTranslationRetained record n site prior held

theorem oneBase (record : Record) (site : String) : translationTrace record 0 site=[site] := rfl
end SFT.Materials.Lattice

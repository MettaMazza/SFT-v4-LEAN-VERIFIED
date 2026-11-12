import SFT.Materials.UnitCellRelationSupport
namespace SFT.Materials.UnitCellSourceChoices
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GraphOperations
open SFT.Foundation.Count.TraceDerivation

def siteChoices (l : Lattice.Record) (target : String) : List String :=
 l.cells.graph.nodes.filter (fun seed => reachable (UnitCellTranslationSupport.shiftGraph l) seed target)

theorem siteChoicesMeaning (l : Lattice.Record) (seed target : String) :
 seed∈siteChoices l target ↔ seed∈l.cells.graph.nodes ∧
 ∃ n, Lattice.translate l n seed=target := by
 constructor
 · intro held
   have h := (filterMemberIff _ _ _).mp held
   exact ⟨h.1,(UnitCellTranslationSupport.completeTranslationDecision l seed target h.1).mp h.2⟩
 · intro h
   exact (filterMemberIff _ _ _).mpr
     ⟨h.1,(UnitCellTranslationSupport.completeTranslationDecision l seed target h.1).mpr h.2⟩

def relationChoicesFrom (l : Lattice.Record) (target : Edge)
 (seeds : List Edge) (held : ∀ e, e∈seeds → e∈l.cells.graph.edges) : List Edge :=
 match seeds with
 | [] => []
 | first::rest =>
   let tail := relationChoicesFrom l target rest (fun e h => held e (List.Mem.tail first h))
   if has (UnitCellRelationSupport.support l first (held first (List.Mem.head rest))) target
   then first::tail else tail

theorem relationChoicesFromMeaning (l : Lattice.Record) (target : Edge)
 (seeds : List Edge) (held : ∀ e, e∈seeds → e∈l.cells.graph.edges) (seed : Edge) :
 seed∈relationChoicesFrom l target seeds held ↔ seed∈seeds ∧
 ∃ n, UnitCellRelationSupport.iterate l n seed=target := by
 induction seeds with
 | nil =>
   constructor
   · intro h; cases h
   · intro h; cases h.1
 | cons first rest ih =>
   change seed∈(if has (UnitCellRelationSupport.support l first (held first (List.Mem.head rest))) target
     then first::relationChoicesFrom l target rest _ else relationChoicesFrom l target rest _) ↔ _
   cases h : has (UnitCellRelationSupport.support l first (held first (List.Mem.head rest))) target with
   | true =>
     constructor
     · intro member
       cases member with
       | head => exact ⟨List.Mem.head _,(UnitCellRelationSupport.supportMeaning l seed target (held seed (List.Mem.head rest))).mp ((hasIff _ _).mp h)⟩
       | tail _ hm =>
         have p := ih _ |>.mp hm
         exact ⟨List.Mem.tail _ p.1,p.2⟩
     · intro p
       cases p.1 with
       | head => exact List.Mem.head _
       | tail _ hm => exact List.Mem.tail _ ((ih _).mpr ⟨hm,p.2⟩)
   | false =>
     constructor
     · intro hm
       have p := (ih _).mp hm
       exact ⟨List.Mem.tail _ p.1,p.2⟩
     · intro p
       cases p.1 with
       | head =>
         have yes := (hasIff _ _).mpr ((UnitCellRelationSupport.supportMeaning l seed target (held seed (List.Mem.head rest))).mpr p.2)
         rw [h] at yes; cases yes
       | tail _ hm => exact (ih _).mpr ⟨hm,p.2⟩

def relationChoices (l : Lattice.Record) (target : Edge) : List Edge :=
 relationChoicesFrom l target l.cells.graph.edges (fun _ h => h)

theorem relationChoicesMeaning (l : Lattice.Record) (seed target : Edge) :
 seed∈relationChoices l target ↔ seed∈l.cells.graph.edges ∧
 ∃ n, UnitCellRelationSupport.iterate l n seed=target :=
 relationChoicesFromMeaning l target l.cells.graph.edges (fun _ h => h) seed
end SFT.Materials.UnitCellSourceChoices

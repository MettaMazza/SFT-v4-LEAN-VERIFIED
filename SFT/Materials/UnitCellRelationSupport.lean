import SFT.Materials.UnitCellTranslationSupport
import SFT.InformationScience.EntropyPairs
namespace SFT.Materials.UnitCellRelationSupport
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

def shift (l : Lattice.Record) (e : Edge) : Edge := (l.shift e.1,l.shift e.2)
def iterate (l : Lattice.Record) (n : Nat) (e : Edge) : Edge :=
 (Lattice.translate l n e.1,Lattice.translate l n e.2)

theorem shiftSupported (l : Lattice.Record) (e : Edge)
 (held : e∈l.cells.graph.edges) : shift l e∈l.cells.graph.edges := by
 have ends := acceptedGraphEndpoints l.cells.nodes l.cells.edges l.cells.graph l.cells.generated e held
 exact (Lattice.everyAdjacencyRecurs l 1 e.1 e.2 ends.1 ends.2).mpr held

structure State (l : Lattice.Record) where
 remaining : List Edge
 seen : List Edge
 next : Edge
 held : next∈l.cells.graph.edges
 covered : ∀ e, e∈l.cells.graph.edges → e∈remaining ∨ e∈seen

def advance (l : Lattice.Record) (s : State l) : State l where
 remaining := s.remaining.filter (fun e => decide (e≠s.next))
 seen := s.seen ++ [s.next]
 next := shift l s.next
 held := shiftSupported l s.next s.held
 covered := by
   intro e held
   by_cases same : e=s.next
   · cases same; exact Or.inr (memAppendRight _ _ _ (List.Mem.head []))
   · cases s.covered e held with
     | inl h => exact Or.inl ((filterMemberIff _ _ _).mpr ⟨h,decide_eq_true same⟩)
     | inr h => exact Or.inr (memAppendLeft _ _ _ h)

def order (l : Lattice.Record) : WellFoundedRelation (State l) :=
 invImage (fun s => s.remaining.length) Nat.lt_wfRel

theorem advanceDecreases (l : Lattice.Record) (s : State l)
 (fresh : has s.seen s.next≠true) : (order l).rel (advance l s) s := by
 apply SFT.InformationScience.EntropyPairs.pairRemovalShorter
 cases s.covered s.next s.held with
 | inl h => exact h
 | inr h => exact False.elim (fresh ((hasIff _ _).mpr h))

def body (l : Lattice.Record) (s : State l)
 (recur : (n : State l) → (order l).rel n s → List Edge) : List Edge :=
 if h : has s.seen s.next=true then s.seen
 else recur (advance l s) (advanceDecreases l s h)

def orbit (l : Lattice.Record) : State l → List Edge := (order l).wf.fix (body l)

theorem orbitEquation (l : Lattice.Record) (s : State l) :
 orbit l s=body l s (fun n _ => orbit l n) := by
 unfold orbit
 rw [WellFounded.fix_eq]

def Good (l : Lattice.Record) (seed : Edge) (s : State l) : Prop :=
 (seed∈s.seen ∨ seed=s.next) ∧
 (∀ e, e∈s.seen → ∃ n, iterate l n seed=e) ∧
 (∃ n, iterate l n seed=s.next) ∧
 (∀ e, e∈s.seen → shift l e∈s.seen ∨ shift l e=s.next)

theorem advanceGood (l : Lattice.Record) (seed : Edge) (s : State l)
 (good : Good l seed s) : Good l seed (advance l s) := by
 refine ⟨?_,?_,?_,?_⟩
 · cases good.1 with
   | inl h => exact Or.inl (memAppendLeft _ _ _ h)
   | inr h => rw [h]; exact Or.inl (memAppendRight _ _ _ (List.Mem.head []))
 · intro e held
   cases memAppendCases e s.seen [s.next] held with
   | inl h => exact good.2.1 e h
   | inr h =>
     cases h with
     | head => exact good.2.2.1
     | tail _ h => cases h
 · obtain ⟨n,h⟩ := good.2.2.1
   exact ⟨n+1,congrArg (shift l) h⟩
 · intro e held
   cases memAppendCases e s.seen [s.next] held with
   | inl h =>
     cases good.2.2.2 e h with
     | inl h => exact Or.inl (memAppendLeft _ _ _ h)
     | inr h => rw [h]; exact Or.inl (memAppendRight _ _ _ (List.Mem.head []))
   | inr h =>
     cases h with
     | head => exact Or.inr rfl
     | tail _ h => cases h

def Complete (l : Lattice.Record) (seed : Edge) (result : List Edge) : Prop :=
 seed∈result ∧ (∀ e, e∈result → ∃ n, iterate l n seed=e) ∧
 (∀ e, e∈result → shift l e∈result)

theorem orbitComplete (l : Lattice.Record) (seed : Edge) (s : State l) :
 Good l seed s → Complete l seed (orbit l s) := by
 apply (order l).wf.induction s
 intro current ih good
 rw [orbitEquation]
 unfold body
 split
 · rename_i repeated
   have held := (hasIff _ _).mp repeated
   refine ⟨?_,good.2.1,?_⟩
   · cases good.1 with
     | inl h => exact h
     | inr h => rw [h]; exact held
   · intro e he
     cases good.2.2.2 e he with
     | inl h => exact h
     | inr h => rw [h]; exact held
 · rename_i fresh
   exact ih (advance l current) (advanceDecreases l current fresh) (advanceGood l seed current good)

def initial (l : Lattice.Record) (seed : Edge) (held : seed∈l.cells.graph.edges) : State l :=
 ⟨l.cells.graph.edges,[],seed,held,fun _ h => Or.inl h⟩

theorem initialGood (l : Lattice.Record) (seed : Edge) (held : seed∈l.cells.graph.edges) :
 Good l seed (initial l seed held) :=
 ⟨Or.inr rfl,(fun _ h => by cases h),⟨0,rfl⟩,(fun _ h => by cases h)⟩

def support (l : Lattice.Record) (seed : Edge) (held : seed∈l.cells.graph.edges) : List Edge :=
 orbit l (initial l seed held)

theorem supportMeaning (l : Lattice.Record) (seed e : Edge) (held : seed∈l.cells.graph.edges) :
 e∈support l seed held ↔ ∃ n, iterate l n seed=e := by
 have complete := orbitComplete l seed (initial l seed held) (initialGood l seed held)
 constructor
 · exact complete.2.1 e
 · intro ⟨n,eq⟩
   rw [←eq]
   clear eq e
   induction n with
   | zero => exact complete.1
   | succ n ih => exact complete.2.2 _ ih
end SFT.Materials.UnitCellRelationSupport

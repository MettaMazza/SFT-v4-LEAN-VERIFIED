import SFT.Materials.UnitCellReconstruction
import SFT.Mathematics.GraphPathCompleteness
import SFT.Mathematics.AlgebraInduction
namespace SFT.Materials.UnitCellTranslationSupport
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

-- This is the existing translation's transition graph, not a new physical
-- adjacency relation. Its finite edge list is generated from the held sites.
def shiftGraph (l : Lattice.Record) : GeneratedGraph :=
 ⟨l.cells.graph.nodes,l.cells.graph.nodes.map (fun x => (x,l.shift x))⟩

theorem shiftEdgeMeaning (l : Lattice.Record) (a b : String) :
 (a,b)∈(shiftGraph l).edges ↔ a∈l.cells.graph.nodes ∧ b=l.shift a := by
 constructor
 · intro held
   obtain ⟨x,hx,eq⟩ := memMapPreimage (fun x => (x,l.shift x)) (a,b) l.cells.graph.nodes held
   have first := congrArg Prod.fst eq
   have second := congrArg Prod.snd eq
   change x=a at first
   cases first
   exact ⟨hx,second.symm⟩
 · intro h
   have member := memMap (fun x => (x,l.shift x)) a l.cells.graph.nodes h.1
   rw [h.2]
   exact member

theorem iterationPath (l : Lattice.Record) (x : String)
 (held : x∈l.cells.graph.nodes) (n : Nat) :
 PathWitness (shiftGraph l) x (Lattice.translate l n x) := by
 induction n with
 | zero => exact identityPathWitness (shiftGraph l) x held
 | succ n ih =>
   exact extendPathWitness (shiftGraph l) x (Lattice.translate l n x)
     (Lattice.translate l (n+1) x) ih
     ((shiftEdgeMeaning l _ _).mpr ⟨Lattice.everyTranslationHeld l n x held,rfl⟩)
     (Lattice.everyTranslationHeld l (n+1) x held)

theorem finiteReachabilityOfIteration (l : Lattice.Record) (x : String)
 (held : x∈l.cells.graph.nodes) (n : Nat) :
 reachable (shiftGraph l) x (Lattice.translate l n x)=true :=
 pathWitnessReachable (shiftGraph l) x _ (iterationPath l x held n)

theorem reachedIsIteration (l : Lattice.Record) (x y : String)
 (reached : reachable (shiftGraph l) x y=true) :
 ∃ n, Lattice.translate l n x=y := by
 unfold reachable at reached
 by_cases same : x=y
 · cases same; exact ⟨0,rfl⟩
 · rw [ite_eq_right same] at reached
   apply searchPreservesProperty (shiftGraph l).edges y
     (fun z => ∃ n, Lattice.translate l n x=z) ?_
     (initialSearch (shiftGraph l).edges x) ?_ reached
   · intro a b edge prior
     obtain ⟨n,eq⟩ := prior
     have next := ((shiftEdgeMeaning l a b).mp edge).2
     refine ⟨n+1,?_⟩
     change l.shift (Lattice.translate l n x)=b
     exact (congrArg l.shift eq).trans next.symm
   · intro z hz
     cases hz with
     | head => exact ⟨0,rfl⟩
     | tail _ h => cases h

theorem completeTranslationDecision (l : Lattice.Record) (x y : String)
 (held : x∈l.cells.graph.nodes) :
 reachable (shiftGraph l) x y=true ↔ ∃ n, Lattice.translate l n x=y := by
 constructor
 · exact reachedIsIteration l x y
 · intro ⟨n,eq⟩
   rw [←eq]
   exact finiteReachabilityOfIteration l x held n

def completeSitePairs (l : Lattice.Record) : List (String × String) :=
 (SFT.Mathematics.AlgebraOperations.pairSupport l.cells.graph.nodes).filter
   (fun p => reachable (shiftGraph l) p.1 p.2)

theorem completeSitePairMeaning (l : Lattice.Record) (x y : String) :
 (x,y)∈completeSitePairs l ↔ x∈l.cells.graph.nodes ∧
 y∈l.cells.graph.nodes ∧ ∃ n, Lattice.translate l n x=y := by
 constructor
 · intro held
   have h := (filterMemberIff _ _ _).mp held
   have pair := (SFT.Mathematics.AlgebraOperations.pairSupportMember _ x y).mp h.1
   exact ⟨pair.1,pair.2,reachedIsIteration l x y h.2⟩
 · intro h
   apply (filterMemberIff _ _ _).mpr
   exact ⟨(SFT.Mathematics.AlgebraOperations.pairSupportMember _ x y).mpr ⟨h.1,h.2.1⟩,
     (completeTranslationDecision l x y h.1).mpr h.2.2⟩

theorem everyStepRepresented (l : Lattice.Record) (x : String)
 (held : x∈l.cells.graph.nodes) (n : Nat) :
 (x,Lattice.translate l n x)∈completeSitePairs l :=
 (completeSitePairMeaning l x _).mpr
   ⟨held,Lattice.everyTranslationHeld l n x held,⟨n,rfl⟩⟩
end SFT.Materials.UnitCellTranslationSupport

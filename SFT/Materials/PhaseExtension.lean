import SFT.Materials.Phase
namespace SFT.Materials.PhaseExtension
open SFT.Materials.Phase SFT.Mathematics.GraphOperations
open SFT.Foundation.Count.TraceDerivation
open SFT.Physics.CollectivePhaseOrder

theorem successor (system : System) (root anchor next : String)
 (prior : InPhase system root anchor) (edge : (anchor,next)∈system.graph.edges)
 (held : next∈system.graph.nodes)
 (same : stableObservation (system.region root) (system.region next)) : InPhase system root next := by
 obtain ⟨priorNodes,valid,starts,classes⟩ := prior
 have anchorHeld := (pathMeaning system.graph _).mp valid |>.2.1 anchor (memAppendRight _ _ _ (.head _))
 have transition : pathIsValid system.graph [anchor,next]=true := by
  apply (pathMeaning system.graph _).mpr
  refine ⟨rfl,?_,?_⟩
  · intro node member
    cases member with
    | head => exact anchorHeld
    | tail _ h =>
      cases h with
      | head => exact held
      | tail _ h => cases h
  · intro e he
    cases he with
    | head => exact edge
    | tail _ h => cases h
 refine ⟨priorNodes++[anchor],?_,?_,?_⟩
 · rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative]
   exact (pathCompositionIff system.graph priorNodes [next] anchor).mpr ⟨valid,transition⟩
 · cases priorNodes with
   | nil => exact starts
   | cons first rest => exact starts
 · intro x hx
   cases memAppendCases x (priorNodes++[anchor]) [next] hx with
   | inl old => exact classes x old
   | inr added =>
     cases added with
     | head => exact same
     | tail _ h => cases h

inductive History (system : System) (root : String) : String → Prop where
 | base (held : root∈system.graph.nodes) : History system root root
 | next {anchor cell : String} (prior : History system root anchor)
   (edge : (anchor,cell)∈system.graph.edges) (held : cell∈system.graph.nodes)
   (same : stableObservation (system.region root) (system.region cell)) : History system root cell

theorem everyFiniteSuccessor (system : System) (root cell : String)
 (history : History system root cell) : InPhase system root cell := by
 induction history with
 | base held => exact Phase.base system root held
 | next prior edge held same ih => exact successor system root _ _ ih edge held same
end SFT.Materials.PhaseExtension

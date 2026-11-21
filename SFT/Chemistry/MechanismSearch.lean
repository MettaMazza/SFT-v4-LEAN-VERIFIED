import SFT.Chemistry.MolecularGraphRefinement
namespace SFT.Chemistry.MechanismSearch
open SFT.Host
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
-- Original computational_chemistry_laws_v1.py:mechanism_paths.
-- α encodes the held source state; equality is the encoding of source equality.
structure Transition (α : Type) where
 source : α
 destination : α
 label : String
-- A simple path uses each edge occurrence at most once: reusing an edge
-- repeats its destination, which the original visited-state test excludes.
-- The public operation derives its recursion depth from the full edge list.
def pathsAt [BEq α] (terminal : α) (transitions : List (Transition α)) :
 Nat → α → List α → List String → List (List String)
 | 0,state,_,trace => if state==terminal then [trace] else []
 | n+1,state,visited,trace =>
  if state==terminal then [trace]
  else transitions.reverse.flatMap fun edge=>
   if edge.source==state && !(visited.any (fun prior=>edge.destination==prior)) then
    pathsAt terminal transitions n edge.destination (visited++[edge.destination]) (trace++[edge.label])
   else []
def mechanismPaths [BEq α] (start terminal : α) (transitions : List (Transition α)) : List (List String) :=
 MolecularGraphRefinement.sortedRows MolecularGraphEnumeration.stringListLE
  (pathsAt terminal transitions transitions.length start [start] [])
theorem zeroDepthTerminal [BEq α] (terminal state : α) (transitions : List (Transition α))
 (visited : List α) (trace : List String) (h : (state==terminal)=true) :
 pathsAt terminal transitions 0 state visited trace=[trace] := by
 unfold pathsAt
 rw [h]
 rfl
theorem successorTerminal [BEq α] (terminal state : α) (transitions : List (Transition α))
 (visited : List α) (trace : List String) (depth : Nat) (h : (state==terminal)=true) :
 pathsAt terminal transitions (depth+1) state visited trace=[trace] := by
 unfold pathsAt
 rw [h]
 rfl
def witnessTransitions : List (Transition Nat) := [⟨1,2,"first"⟩,⟨2,3,"second"⟩,⟨1,3,"direct"⟩,⟨2,1,"cycle"⟩]
theorem allRoutesRetained : mechanismPaths 1 3 witnessTransitions=[["direct"],["first","second"]] := rfl
theorem duplicateTracesRetained : mechanismPaths 1 2 [⟨1,2,"same"⟩,⟨1,2,"same"⟩]=[["same"],["same"]] := rfl
theorem terminalNotExpanded : mechanismPaths 1 1 witnessTransitions=[[]] := rfl
theorem noRouteRetainedAsEmpty : mechanismPaths 3 1 witnessTransitions=[] := rfl
theorem selfLoopExcluded : mechanismPaths 1 2 [⟨1,1,"self"⟩,⟨1,2,"exit"⟩]=[["exit"]] := rfl
end SFT.Chemistry.MechanismSearch

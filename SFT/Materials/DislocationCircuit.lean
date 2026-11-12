import SFT.Materials.CrystalTranslationAction
import SFT.Mathematics.GraphPathSoundness
namespace SFT.Materials.DislocationCircuit
open SFT.Mathematics.GraphOperations
open SFT.Foundation.CommonRefinement

-- Obligation20: retain the complete circuit and each held lattice translation.
-- Edge/site labels, provenance and boundary are observation records.
structure Move (reference : Lattice.Record) where
 translation : Lattice.Record
 sameGraph : translation.cells.graph = reference.cells.graph
 sameWord : ∀ site, translation.word site = reference.word site
 provenance : SFT.Host.Canonical.Value

inductive Trace (reference : Lattice.Record) : String → String → Type where
 | initial (site : String) : Trace reference site site
 | append {a b c : String} (prior : Trace reference a b)
     (edge : (b,c) ∈ reference.cells.graph.edges) (move : Move reference) : Trace reference a c

variable {reference : Lattice.Record} {a b c : String}

def transport {a b : String} : Trace reference a b → String → String
 | .initial _,site => site
 | .append prior _ move,site => move.translation.shift (transport prior site)

def moves {a b : String} : Trace reference a b → List (Move reference)
 | .initial _ => []
 | .append prior _ move => moves prior ++ [move]

def vertices {a : String} : {b : String} → Trace reference a b → List String
 | _, .initial _ => [a]
 | c, .append prior _ _ => vertices prior ++ [c]

theorem completeCircuitCount (trace : Trace reference a b) :
 (vertices trace).length = (moves trace).length + 1 := by
 induction trace with
 | initial => rfl
 | append prior edge move ih =>
   change (vertices prior ++ [_]).length = (moves prior ++ [move]).length + 1
   rw [appendLength,appendLength,ih]
   rfl

def priorVertices {a : String} : {b : String} → Trace reference a b → List String
 | _, .initial _ => []
 | _, .append prior _ _ => vertices prior

theorem verticesEnd (trace : Trace reference a b) : vertices trace = priorVertices trace ++ [b] := by
 cases trace <;> rfl

theorem completeAdjacentCircuit (trace : Trace reference a b)
 (start : a ∈ reference.cells.graph.nodes) : pathIsValid reference.cells.graph (vertices trace) = true := by
 induction trace with
 | initial => exact (identityPathIff _ _).mpr start
 | @append b c prior edge move ih =>
   have endpoints := acceptedGraphEndpoints reference.cells.nodes reference.cells.edges
     reference.cells.graph reference.cells.generated (b,c) edge
   have pair : pathIsValid reference.cells.graph [b,c] = true := by
     apply (pathMeaning _ _).mpr
     refine ⟨rfl,?_,?_⟩
     · intro node member
       cases member with
       | head => exact endpoints.1
       | tail _ h =>
         cases h with
         | head => exact endpoints.2
         | tail _ h => cases h
     · intro e member
       cases member with
       | head => exact edge
       | tail _ h => cases h
   change pathIsValid reference.cells.graph (vertices prior ++ [c]) = true
   rw [verticesEnd prior, SFT.Mathematics.ExactTraceArithmetic.appendAssociative]
   exact (pathCompositionIff _ (priorVertices prior) [c] b).mpr ⟨verticesEnd prior ▸ ih,pair⟩

theorem transportHeld (trace : Trace reference a b) (site : String)
 (held : site ∈ reference.cells.graph.nodes) : transport trace site ∈ reference.cells.graph.nodes := by
 induction trace with
 | initial => exact held
 | append prior edge move ih =>
   change move.translation.shift (transport prior site) ∈ _
   have source : transport prior site ∈ move.translation.cells.graph.nodes := move.sameGraph.symm ▸ ih
   exact move.sameGraph ▸ move.translation.supported _ source

theorem transportWord (trace : Trace reference a b) (site : String)
 (held : site ∈ reference.cells.graph.nodes) : reference.word (transport trace site) = reference.word site := by
 induction trace with
 | initial => rfl
 | append prior edge move ih =>
   have source : transport prior site ∈ move.translation.cells.graph.nodes :=
     move.sameGraph.symm ▸ transportHeld prior site held
   exact (move.sameWord _).symm.trans ((move.translation.wordRecurs _ source).trans
     ((move.sameWord _).trans ih))

theorem transportAdjacency (trace : Trace reference a b) (x y : String)
 (hx : x ∈ reference.cells.graph.nodes) (hy : y ∈ reference.cells.graph.nodes) :
 (transport trace x,transport trace y) ∈ reference.cells.graph.edges ↔ (x,y) ∈ reference.cells.graph.edges := by
 induction trace with
 | initial => exact Iff.rfl
 | append prior edge move ih =>
   have px : transport prior x ∈ move.translation.cells.graph.nodes :=
     move.sameGraph.symm ▸ transportHeld prior x hx
   have py : transport prior y ∈ move.translation.cells.graph.nodes :=
     move.sameGraph.symm ▸ transportHeld prior y hy
   have step := move.translation.neighborsRecur _ _ px py
   rw [move.sameGraph] at step
   exact step.trans ih

def wholeTranslation (trace : Trace reference a b) : Lattice.Record where
 cells := reference.cells
 word := reference.word
 shift := transport trace
 supported := transportHeld trace
 wordRecurs := transportWord trace
 neighborsRecur := transportAdjacency trace

def nonclosing (circuit : Trace reference a a) (held : String) : Prop :=
 transport circuit held ≠ held

theorem nonclosureExactly (circuit : Trace reference a a) (held : String) :
 nonclosing circuit held ↔ (wholeTranslation circuit).shift held ≠ held := Iff.rfl

theorem emptyCircuitCloses (site held : String) :
 ¬ nonclosing (Trace.initial (reference:=reference) site) held := fun h => h rfl

theorem nonclosingHasStep (circuit : Trace reference a a) (site : String)
 (mismatch : nonclosing circuit site) : moves circuit ≠ [] := by
 cases circuit with
 | initial => exact False.elim (mismatch rfl)
 | append prior edge move =>
   intro empty
   have lengths := congrArg List.length empty
   change (moves prior ++ [move]).length = 0 at lengths
   rw [appendLength] at lengths
   exact Nat.noConfusion lengths

def compose (left : Trace reference a b) : {c : String} → Trace reference b c → Trace reference a c
 | _, .initial _ => left
 | _, .append prior edge move => .append (compose left prior) edge move

theorem compositionTransport (left : Trace reference a b) (right : Trace reference b c) (held : String) :
 transport (compose left right) held = transport right (transport left held) := by
 induction right with
 | initial => rfl
 | append prior edge move ih => exact congrArg move.translation.shift ih

-- The complete held line, its circuit at each site, and its declared boundary.
structure Line (reference : Lattice.Record) where
 support : List String
 validLine : pathIsValid reference.cells.graph support = true
 circuit : (site : String) → site ∈ support → Trace reference site site
 mismatch : ∀ site (member : site ∈ support), nonclosing (circuit site member) site
 provenance : SFT.Host.Canonical.Value
 boundary : String

theorem lineSitesHeld (line : Line reference) (site : String) (member : site ∈ line.support) :
 site ∈ reference.cells.graph.nodes := (pathMeaning _ _).mp line.validLine |>.2.1 site member

def slipHistory (line : Line reference) (site : String) (member : site ∈ line.support) (depth : Nat) :=
 Lattice.translationTrace (wholeTranslation (line.circuit site member)) depth site

theorem firstSlipIsNonclosing (line : Line reference) (site : String) (member : site ∈ line.support) :
 Lattice.translate (wholeTranslation (line.circuit site member)) 1 site ≠ site :=
 line.mismatch site member

theorem everySlipOnCarrier (line : Line reference) (site : String) (member : site ∈ line.support) (depth : Nat) :
 Lattice.translate (wholeTranslation (line.circuit site member)) depth site ∈ reference.cells.graph.nodes :=
 Lattice.everyTranslationHeld _ _ _ (lineSitesHeld line site member)

theorem everySlipRetainsWord (line : Line reference) (site : String) (member : site ∈ line.support) (depth : Nat) :
 reference.word (Lattice.translate (wholeTranslation (line.circuit site member)) depth site) = reference.word site :=
 Lattice.everyLocalWordRecurs (wholeTranslation (line.circuit site member)) depth site (lineSitesHeld line site member)

theorem everySlipRetainsAdjacency (line : Line reference) (site : String) (member : site ∈ line.support)
 (depth : Nat) (x y : String) (hx : x ∈ reference.cells.graph.nodes) (hy : y ∈ reference.cells.graph.nodes) :
 (Lattice.translate (wholeTranslation (line.circuit site member)) depth x,
  Lattice.translate (wholeTranslation (line.circuit site member)) depth y) ∈ reference.cells.graph.edges ↔
 (x,y) ∈ reference.cells.graph.edges :=
 Lattice.everyAdjacencyRecurs (wholeTranslation (line.circuit site member)) depth x y hx hy

theorem slipHistoryComplete (line : Line reference) (site : String) (member : site ∈ line.support) (depth : Nat) :
 (slipHistory line site member depth).length = depth + 1 := Lattice.completeFiniteTrace _ _ _

theorem previousSlipRetained (line : Line reference) (site : String) (member : site ∈ line.support)
 (depth : Nat) (prior : String) (held : prior ∈ slipHistory line site member depth) :
 prior ∈ slipHistory line site member (depth+1) := Lattice.priorTranslationRetained _ _ _ _ held
end SFT.Materials.DislocationCircuit

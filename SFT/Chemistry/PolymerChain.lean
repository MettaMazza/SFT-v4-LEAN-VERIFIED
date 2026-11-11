import SFT.Chemistry.Functional
import SFT.Mathematics.GraphInduction
namespace SFT.Chemistry.PolymerChain
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.GraphOperations
open SFT.Mathematics.DiscreteObjects

structure Occurrence (unit : Functional.Group) where
 identity : String
 embedding : Functional.Embedding unit

structure Connection (unit : Functional.Group) (Word Cell : Type) where
 left : Occurrence unit
 right : Occurrence unit
 covalent : CovalentSharing.BoundChannels Word Cell
 leftAtomHeld : covalent.bond.support.raw.left∈Functional.imageSupport left.embedding
 rightAtomHeld : covalent.bond.support.raw.right∈Functional.imageSupport right.embedding

def connectionEdge {unit : Functional.Group} {Word Cell : Type} (c : Connection unit Word Cell) : Edge :=
 (c.left.identity,c.right.identity)

def copyTrace {unit : Functional.Group} (first : Occurrence unit) (middle : List (Occurrence unit))
 (last : Occurrence unit) := first::middle++[last]

def names {unit : Functional.Group} (copies : List (Occurrence unit)) := copies.map Occurrence.identity

structure Incidence (unit : Functional.Group) (Word Cell : Type) where
 first : Occurrence unit
 middle : List (Occurrence unit)
 last : Occurrence unit
 unique : distinct (names (copyTrace first middle last))=true
 connections : List (Connection unit Word Cell)
 completeOrder : connections.map connectionEdge=adjacentPairs (names (copyTrace first middle last))
 allCopies : ∀ c∈connections, c.left∈copyTrace first middle last ∧ c.right∈copyTrace first middle last

def copies {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) := copyTrace c.first c.middle c.last

def extent {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) := (copies c).length

def graph {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) : GeneratedGraph :=
 ⟨names (copies c),c.connections.map connectionEdge⟩

theorem positiveExtent {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) : 0<extent c :=
 Nat.zero_lt_succ _

theorem completeOrderedPath {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) :
 pathIsValid (graph c) (names (copies c))=true := by
 apply (pathMeaning _ _).mpr
 refine ⟨?_,fun _ held => held,?_⟩
 · rfl
 · intro edge held
   change edge∈c.connections.map connectionEdge
   rw [c.completeOrder]
   exact held

theorem everyNeighborIsCovalent {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (edge : Edge) (held : edge∈adjacentPairs (names (copies c))) :
 ∃ bond∈c.connections, connectionEdge bond=edge := by
 change edge∈adjacentPairs (names (copyTrace c.first c.middle c.last)) at held
 rw [←c.completeOrder] at held
 exact memMapPreimage _ _ _ held

theorem everyConnectionOnTrace {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (bond : Connection unit Word Cell) (held : bond∈c.connections) :
 connectionEdge bond∈adjacentPairs (names (copies c)) := by
 change connectionEdge bond∈adjacentPairs (names (copyTrace c.first c.middle c.last))
 rw [←c.completeOrder]
 exact memMap _ _ _ held

theorem covalentRecurrenceRetained {unit : Functional.Group} {Word Cell : Type}
 (bond : Connection unit Word Cell) :
 SFT.QuantumComputation.ReversibleModel.phaseAction bond.covalent.bond.recurrence.prepared.state
 (bond.covalent.bond.interactionTrace.flatMap Prod.snd)=.ok bond.covalent.bond.recurrence.prepared.state :=
 CovalentSharing.boundSourceRecurs bond.covalent

theorem appendedCopies {unit : Functional.Group} (first last next : Occurrence unit)
 (middle : List (Occurrence unit)) :
 copyTrace first (middle++[last]) next=copyTrace first middle last++[next] := by
 change first::((middle++[last])++[next])=first::(middle++[last]++[next])
 rfl

theorem appendedNames {unit : Functional.Group} (first last next : Occurrence unit)
 (middle : List (Occurrence unit)) :
 names (copyTrace first (middle++[last]) next)=names (copyTrace first middle last)++[next.identity] := by
 rw [appendedCopies]
 exact SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem appendedEdges {unit : Functional.Group} (first last next : Occurrence unit)
 (middle : List (Occurrence unit)) :
 adjacentPairs (names (copyTrace first (middle++[last]) next))=
 adjacentPairs (names (copyTrace first middle last))++[(last.identity,next.identity)] := by
 have split : names (copyTrace first (middle++[last]) next)=
  (first.identity::names middle)++[last.identity,next.identity] := by
   change first.identity::((middle++[last]++[next]).map Occurrence.identity)=_
   rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend]
   exact congrArg (List.cons first.identity) (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _)
 have old : names (copyTrace first middle last)=(first.identity::names middle)++[last.identity] := by
   unfold names copyTrace
   rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend]
   rfl
 rw [split,old]
 exact adjacentPairsComposition _ _ _

def append {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (next : Occurrence unit) (bond : Connection unit Word Cell)
 (fresh : ¬next.identity∈names (copies c)) (left : bond.left=c.last) (right : bond.right=next) :
 Incidence unit Word Cell where
 first := c.first
 middle := c.middle++[c.last]
 last := next
 unique := by
  rw [appendedNames]
  exact Chirality.appendFreshDistinct _ _ c.unique fresh
 connections := c.connections++[bond]
 completeOrder := by
  rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,c.completeOrder,appendedEdges]
  change _++[(bond.left.identity,bond.right.identity)]=_
  rw [left,right]
 allCopies := by
  intro old held
  rw [appendedCopies]
  cases memAppendCases old c.connections [bond] held with
  | inl previous =>
    have bound := c.allCopies old previous
    exact ⟨memAppendLeft _ _ _ bound.1,memAppendLeft _ _ _ bound.2⟩
  | inr added => cases added with
    | head =>
      rw [left,right]
      exact ⟨memAppendLeft _ _ _ (.tail _ (memAppendRight _ _ _ (.head []))),memAppendRight _ _ _ (.head [])⟩
    | tail _ impossible => cases impossible

theorem successorExtent {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (next : Occurrence unit) (bond : Connection unit Word Cell)
 (fresh : ¬next.identity∈names (copies c)) (left : bond.left=c.last) (right : bond.right=next) :
 extent (append c next bond fresh left right)=extent c+1 := by
 change (copyTrace c.first (c.middle++[c.last]) next).length=(copies c).length+1
 rw [appendedCopies,SFT.Foundation.CommonRefinement.appendLength]
 rfl

theorem successorEnds {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (next : Occurrence unit) (bond : Connection unit Word Cell)
 (fresh : ¬next.identity∈names (copies c)) (left : bond.left=c.last) (right : bond.right=next) :
 (append c next bond fresh left right).first=c.first ∧ (append c next bond fresh left right).last=next := ⟨rfl,rfl⟩


def base {unit : Functional.Group} {Word Cell : Type} (bond : Connection unit Word Cell)
 (fresh : ¬bond.right.identity∈[bond.left.identity]) : Incidence unit Word Cell where
 first := bond.left
 middle := []
 last := bond.right
 unique := Chirality.appendFreshDistinct [bond.left.identity] bond.right.identity rfl fresh
 connections := [bond]
 completeOrder := rfl
 allCopies := by
  intro c held
  cases held with
  | head => exact ⟨.head _,.tail _ (.head _)⟩
  | tail _ impossible => cases impossible

theorem baseExtent {unit : Functional.Group} {Word Cell : Type} (bond : Connection unit Word Cell)
 (fresh : ¬bond.right.identity∈[bond.left.identity]) : extent (base bond fresh)=2 := rfl

theorem pathToEveryMember (network : GeneratedGraph) (tail : List String) :
 ∀ first, (∀ x∈first::tail, x∈network.nodes) →
 (∀ e∈adjacentPairs (first::tail), e∈network.edges) →
 ∀ target∈first::tail, PathWitness network first target := by
 induction tail with
 | nil =>
   intro first nodes edges target held
   cases held with
   | head => exact identityPathWitness network first (nodes first (.head []))
   | tail _ impossible => cases impossible
 | cons second tail ih =>
   intro first nodes edges target held
   cases held with
   | head => exact identityPathWitness network first (nodes first (.head _))
   | tail _ rest =>
     have bridge := extendPathWitness network first first second
      (identityPathWitness network first (nodes first (.head _)))
      (edges (first,second) (.head _)) (nodes second (.tail _ (.head _)))
     have remaining := ih second (fun x h => nodes x (.tail _ h))
      (fun e h => edges e (.tail _ h)) target rest
     exact composePathWitnesses network first second target bridge remaining

theorem everyRepeatReachable {unit : Functional.Group} {Word Cell : Type}
 (c : Incidence unit Word Cell) (name : String) (held : name∈names (copies c)) :
 reachable (graph c) c.first.identity name=true := by
 apply pathWitnessReachable
 apply pathToEveryMember (graph c) (names (c.middle++[c.last])) c.first.identity
 · intro x h; exact h
 · intro e h
   change e∈c.connections.map connectionEdge
   rw [c.completeOrder]
   exact h
 · exact held

theorem priorOccurrenceRetained {unit : Functional.Group} {Word Cell : Type}
 (c : Incidence unit Word Cell) (next old : Occurrence unit) (bond : Connection unit Word Cell)
 (fresh : ¬next.identity∈names (copies c)) (left : bond.left=c.last) (right : bond.right=next)
 (held : old∈copies c) : old∈copies (append c next bond fresh left right) := by
 change old∈copyTrace c.first (c.middle++[c.last]) next
 rw [appendedCopies]
 exact memAppendLeft _ _ _ held

end SFT.Chemistry.PolymerChain

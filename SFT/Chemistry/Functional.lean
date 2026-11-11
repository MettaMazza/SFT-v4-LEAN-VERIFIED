import SFT.Chemistry.Diastereomer
import SFT.Chemistry.ReactionNetwork
namespace SFT.Chemistry.Functional
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation
open Chirality

-- A local atom-or-group support need not itself be a whole admitted molecule.
structure Group where
 fragment : OrientedMolecule
 positive : fragment.carrier.occurrences≠[]
 namesDistinct : distinct fragment.carrier.occurrences=true
 width : fragment.carrier.occurrences.length=fragment.carrier.elements.length
 endpoints : ∀ edge∈fragment.carrier.bonds,
  edge.1∈fragment.carrier.occurrences ∧ edge.2∈fragment.carrier.occurrences

def bonded (edges : List Edge) (a b : String) : Prop := (a,b)∈edges ∨ (b,a)∈edges

structure Embedding (g : Group) where
 molecule : OrientedMolecule
 admitted : MolecularCarrier.admit molecule.carrier=.ok molecule.carrier
 image : String → String
 held : ∀ a∈g.fragment.carrier.occurrences, image a∈molecule.carrier.occurrences
 injectiveOn : ∀ a∈g.fragment.carrier.occurrences, ∀ b∈g.fragment.carrier.occurrences, image a=image b → a=b
 elements : ∀ a∈g.fragment.carrier.occurrences,
  MolecularIsomer.lookup a (g.fragment.carrier.occurrences.zip g.fragment.carrier.elements)=
  MolecularIsomer.lookup (image a) (molecule.carrier.occurrences.zip molecule.carrier.elements)
 orientations : ∀ a∈g.fragment.carrier.occurrences,
  wordAt a g.fragment.orientations=wordAt (image a) molecule.orientations
 internal : ∀ a∈g.fragment.carrier.occurrences, ∀ b∈g.fragment.carrier.occurrences,
  bonded g.fragment.carrier.bonds a b ↔ bonded molecule.carrier.bonds (image a) (image b)

def imageSupport {g : Group} (e : Embedding g) := g.fragment.carrier.occurrences.map e.image

def crosses {g : Group} (e : Embedding g) (bond : Edge) : Bool :=
 (has (imageSupport e) bond.1 && !has (imageSupport e) bond.2) ||
 (!has (imageSupport e) bond.1 && has (imageSupport e) bond.2)

def boundary {g : Group} (e : Embedding g) := e.molecule.carrier.bonds.filter (crosses e)


theorem completeBoundary {g : Group} (e : Embedding g) (bond : Edge) :
 bond∈boundary e ↔ bond∈e.molecule.carrier.bonds ∧ crosses e bond=true :=
 filterMemberIff _ _ _

theorem everyBoundaryBondRetained {g : Group} (e : Embedding g) (bond : Edge)
 (held : bond∈e.molecule.carrier.bonds) (crossing : crosses e bond=true) : bond∈boundary e :=
 (completeBoundary e bond).mpr ⟨held,crossing⟩

-- The role is selected from an actual generated reaction's retained change ledger.
structure ReactionRole where
 reaction : ReactionIdentity.Reaction
 change : ReactionIdentity.RelationChange
 registered : change∈reaction.firstChange::reaction.furtherChanges

def roleTrace (role : ReactionRole) := (role.change.label,role.change.before,role.change.after)

theorem roleActuallyChanges (role : ReactionRole) : role.change.before≠role.change.after := role.change.changed

theorem roleRegistered (role : ReactionRole) : role.change.label∈role.reaction.trace.raw.changedRelations := by
 rw [←role.reaction.allChanges]
 exact memMap _ _ _ role.registered

structure Occurrence (g : Group) where
 embedding : Embedding g
 role : ReactionRole
 context : SFT.Host.Canonical.Value
 source : SFT.Host.Canonical.Value
 moleculeIdentity : String
 participates : moleculeIdentity∈role.reaction.trace.raw.reactants ∨ moleculeIdentity∈role.reaction.trace.raw.products
 atomPlacements : List (String × ReactionIdentity.Placement)
 completeAtoms : atomPlacements.map Prod.fst=g.fragment.carrier.occurrences
 placementsHeld : ∀ row∈atomPlacements, row.2∈role.reaction.placements
 occurrenceIdentity : ∀ row∈atomPlacements, row.2.carrier.label=embedding.image row.1
 moleculeBound : ∀ row∈atomPlacements, row.2.reactant=moleculeIdentity ∨ row.2.product=moleculeIdentity

theorem everyGroupAtomHasRetainedFlow {g : Group} (o : Occurrence g)
 (atom : String) (held : atom∈g.fragment.carrier.occurrences) :
 ∃ row∈o.atomPlacements, row.1=atom ∧ row.2∈o.role.reaction.placements ∧
 row.2.carrier.label=o.embedding.image atom ∧
 row.2.product∈o.role.reaction.trace.raw.products := by
 rw [←o.completeAtoms] at held
 obtain ⟨row,member,equal⟩ := memMapPreimage _ _ _ held
 refine ⟨row,member,equal,o.placementsHeld row member,?_,
  o.role.reaction.outputBound row.2 (o.placementsHeld row member)⟩
 rw [←equal]
 exact o.occurrenceIdentity row member

theorem groupFlowConservation {g : Group} (o : Occurrence g)
 (test : ReactionIdentity.HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (ReactionIdentity.flows (o.atomPlacements.map Prod.snd))=
 SFT.Physics.MatterConservedLabels.outputCount test (ReactionIdentity.flows (o.atomPlacements.map Prod.snd)) :=
 ReactionIdentity.noCarrierLoss _ test

structure Recurrence where
 group : Group
 first : Occurrence group
 second : Occurrence group
 differentMolecules : first.moleculeIdentity≠second.moleculeIdentity
 sameRole : roleTrace first.role=roleTrace second.role
 further : List (Occurrence group)
 allRoles : ∀ o∈further, roleTrace o.role=roleTrace first.role

def occurrences (r : Recurrence) := r.first::r.second::r.further

def extend (r : Recurrence) (next : Occurrence r.group)
 (sameRole : roleTrace next.role=roleTrace r.first.role) : Recurrence where
 group := r.group
 first := r.first
 second := r.second
 differentMolecules := r.differentMolecules
 sameRole := r.sameRole
 further := r.further++[next]
 allRoles := by
  intro o held
  cases memAppendCases o r.further [next] held with
  | inl old => exact r.allRoles o old
  | inr added => cases added with
    | head => exact sameRole
    | tail _ impossible => cases impossible

theorem extensionPreservesGroup (r : Recurrence) (next : Occurrence r.group)
 (same : roleTrace next.role=roleTrace r.first.role) : (extend r next same).group=r.group := rfl

theorem extensionHistory (r : Recurrence) (next : Occurrence r.group)
 (same : roleTrace next.role=roleTrace r.first.role) : occurrences (extend r next same)=occurrences r++[next] := rfl

theorem retainsOccurrence (r : Recurrence) (next old : Occurrence r.group)
 (same : roleTrace next.role=roleTrace r.first.role) (held : old∈occurrences r) :
 old∈occurrences (extend r next same) := memAppendLeft _ _ _ held

theorem addsContextBoundOccurrence (r : Recurrence) (next : Occurrence r.group)
 (same : roleTrace next.role=roleTrace r.first.role) : next∈occurrences (extend r next same) :=
 (show next∈occurrences r++[next] from memAppendRight next (occurrences r) [next] (.head []))

def base (g : Group) (first second : Occurrence g)
 (different : first.moleculeIdentity≠second.moleculeIdentity)
 (same : roleTrace first.role=roleTrace second.role) : Recurrence :=
 ⟨g,first,second,different,same,[],by intro o h; cases h⟩

theorem baseOccurrences (g : Group) (first second : Occurrence g)
 (different : first.moleculeIdentity≠second.moleculeIdentity)
 (same : roleTrace first.role=roleTrace second.role) :
 occurrences (base g first second different same)=[first,second] := rfl


theorem roleTraceExactlyLocalChange (a b : ReactionRole) :
 roleTrace a=roleTrace b ↔ a.change.label=b.change.label ∧
 a.change.before=b.change.before ∧ a.change.after=b.change.after := by
 constructor
 · intro h
   exact ⟨congrArg Prod.fst h,congrArg (fun p => p.2.1) h,congrArg (fun p => p.2.2) h⟩
 · intro h
   unfold roleTrace
   rw [h.1,h.2.1,h.2.2]

theorem independentReactionsSameLocalRole (a b : ReactionRole)
 (same : a.change=b.change) : roleTrace a=roleTrace b := by
 unfold roleTrace
 rw [same]

theorem independentEmbeddingsSameLocalRole {g : Group} (a b : Occurrence g)
 (same : a.role.change=b.role.change) : roleTrace a.role=roleTrace b.role :=
 independentReactionsSameLocalRole a.role b.role same

theorem everyOccurrenceRetainsRole (r : Recurrence) (o : Occurrence r.group)
 (held : o∈occurrences r) : roleTrace o.role=roleTrace r.first.role := by
 cases held with
 | head => rfl
 | tail _ held => cases held with
   | head => exact r.sameRole.symm
   | tail _ held => exact r.allRoles o held

theorem everyOccurrenceHasGeneratedChange (r : Recurrence) (o : Occurrence r.group)
 (held : o∈occurrences r) :
 o.role.change.label∈o.role.reaction.trace.raw.changedRelations ∧
 o.role.change.before≠o.role.change.after ∧ roleTrace o.role=roleTrace r.first.role :=
 ⟨roleRegistered o.role,roleActuallyChanges o.role,everyOccurrenceRetainsRole r o held⟩

theorem extensionRetainsBoundary (r : Recurrence) (next old : Occurrence r.group)
 (same : roleTrace next.role=roleTrace r.first.role) (held : old∈occurrences r) :
 ∃ occurrence∈occurrences (extend r next same),
 boundary occurrence.embedding=boundary old.embedding ∧ occurrence.context=old.context ∧ occurrence.source=old.source :=
 ⟨old,retainsOccurrence r next old same held,rfl,rfl,rfl⟩

end SFT.Chemistry.Functional

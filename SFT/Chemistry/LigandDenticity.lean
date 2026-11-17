import SFT.Chemistry.CoordinationNumber
namespace SFT.Chemistry.LigandDenticity
open SFT.Host SFT.Physics.CapabilityValues
open MulticentreSupport (sameLabel sameWord distinct)
open CoordinationEntity (Entity Attachment)
-- Pinned V3 ligand_denticity_chelation_law_v1.py, exact accepted typed domain.
structure Topology where
 carrier : HeldLabel
 group : HeldLabel
 central : HeldLabel
 donors : List HeldLabel
 attachments : List HeldLabel
 internalConnections : List HeldLabel

def construct (t : Topology) : Except String Topology := do
 if !Text.equal t.carrier.family "coordination-ligand-carrier-occurrence" then
  throw "denticity requires one retained ligand carrier occurrence"
 if !Text.equal t.group.family "coordination-ligand-group" then
  throw "denticity requires one retained ligand group identity"
 if !Text.equal t.central.family "coordination-central-occurrence" then
  throw "denticity requires one retained central occurrence"
 if t.donors.isEmpty then throw "a ligand carrier requires positive donor-site support"
 if !(t.donors.all fun x => Text.equal x.family "coordination-ligand-occurrence") then
  throw "every donor site must retain its occurrence"
 if !distinct t.donors then throw "distinct donor sites cannot collapse"
 if t.attachments.length != t.donors.length then
  throw "every donor site requires one central attachment trace"
 if !(t.attachments.all fun x => Text.equal x.family "positive-coordination-incidence") || !distinct t.attachments then
  throw "central attachment traces must be positive and distinct"
 if t.internalConnections.length != t.donors.length-1 then
  throw "donor sites must retain one complete gap-free internal path"
 if !(t.internalConnections.all fun x => Text.equal x.family "positive-ligand-internal-incidence") || !distinct t.internalConnections then
  throw "internal ligand path traces must be positive and distinct"
 pure t

structure Record where
 carrier : HeldLabel
 central : HeldLabel
 denticity : PositiveCount
 donors : List HeldLabel
 attachments : List HeldLabel
 internalConnections : List HeldLabel
 state : HeldLabel
 closedTrace : List HeldLabel

def sameBinding (a b : HeldLabel × HeldLabel × HeldLabel) : Bool :=
 sameLabel a.1 b.1 && sameLabel a.2.1 b.2.1 && sameLabel a.2.2 b.2.2

def uniqueBindings (xs : List (HeldLabel × HeldLabel × HeldLabel)) : List (HeldLabel × HeldLabel × HeldLabel) :=
 xs.foldl (fun acc x => if acc.any (sameBinding x) then acc else acc++[x]) []

def forced (entity : Entity) (topology : Topology) : Except String Record := do
 if !sameLabel topology.central entity.centralOccurrence then
  throw "ligand topology cannot change the retained central occurrence"
 let entityBindings := entity.orderedAttachments.map fun row => (row.ligandOccurrence,row.ligandGroupIdentity,row.attachmentTrace)
 let bindings := uniqueBindings ((topology.donors.zip topology.attachments).map fun (d,a) => (d,topology.group,a))
 if bindings.length != topology.donors.length then throw "ligand donor bindings cannot collapse"
 if !(bindings.all fun b => entityBindings.any (sameBinding b)) then
  throw "ligand topology contains an attachment outside the complete entity"
 let denticity ← count topology.donors.length
 let single := topology.donors.length == 1
 let state ← heldLabel "chelation-state" (if single then "single-site-open-topology" else "multiple-separate-sites-one-ligand-one-centre-closed-topology")
 let closed ← if single then pure [] else do
  let first ← match topology.attachments.head? with
   | none => throw "tuple index out of range"
   | some x => pure x
  let last ← match topology.attachments.getLast? with
   | none => throw "tuple index out of range"
   | some x => pure x
  pure ([first]++topology.internalConnections++[last])
 pure ⟨topology.carrier,topology.central,denticity,topology.donors,topology.attachments,topology.internalConnections,state,closed⟩

def appendSite (entity : Entity) (topology : Topology) (donor attachment internalConnection : HeldLabel) : Except String Bool := do
 let before ← forced entity topology
 let extended ← construct ⟨topology.carrier, topology.group, topology.central, topology.donors++[donor],
  topology.attachments++[attachment], topology.internalConnections++[internalConnection]⟩
 let after ← forced entity extended
 let width := before.donors.length
 pure (sameLabel after.carrier before.carrier && sameLabel after.central before.central &&
  after.denticity.value == before.denticity.value+1 && sameWord (after.donors.take width) before.donors &&
  sameWord (after.attachments.take width) before.attachments &&
  sameWord (after.internalConnections.take (after.internalConnections.length-1)) before.internalConnections)
def entity (width : Nat) : Except String Entity := do
 let central ← heldLabel "coordination-central-occurrence" "M-one"
 let group ← heldLabel "coordination-ligand-group" "given-ligand-group"
 let rows ← (List.range width).mapM fun i => do
  let n := i+1
  CoordinationEntity.attachment (← count n) central
   (← heldLabel "coordination-ligand-occurrence" (Text.append "donor-" (toString n))) group
   (← heldLabel "positive-coordination-incidence" (Text.append "central-donor-" (toString n)))
 CoordinationEntity.construct (← heldLabel "coordination-entity" (Text.append "entity-" (toString width)))
  (← heldLabel "coordination-central-element" "M") central rows

def topology (width : Nat) : Except String Topology := do
 let e ← entity width
 let internalConnections ← (List.range (width-1)).mapM fun i =>
  heldLabel "positive-ligand-internal-incidence" (Text.intercalate "" ["donor-",toString (i+1),"-to-",toString (i+2)])
 construct ⟨← heldLabel "coordination-ligand-carrier-occurrence" "ligand-one",
  ← heldLabel "coordination-ligand-group" "given-ligand-group", e.centralOccurrence,
  e.orderedAttachments.map Attachment.ligandOccurrence,
  e.orderedAttachments.map Attachment.attachmentTrace,internalConnections⟩

def twoWitness : Bool := match (do forced (← entity 2) (← topology 2)) with
 | .error _ => false
 | .ok r => r.denticity.value == 2
def closedWitness : Bool := match (do forced (← entity 2) (← topology 2)) with
 | .error _ => false
 | .ok r => r.closedTrace.length == 3
def openWitness : Bool := match (do forced (← entity 1) (← topology 1)) with
 | .error _ => false
 | .ok r => Text.equal r.state.label "single-site-open-topology"
def successorWitness : Bool := match (do
 let e ← entity 3
 let t ← topology 2
 let site ← heldLabel "coordination-ligand-occurrence" "donor-3"
 let attach ← heldLabel "positive-coordination-incidence" "central-donor-3"
 let internalTrace ← heldLabel "positive-ligand-internal-incidence" "donor-2-to-3"
 appendSite e t site attach internalTrace) with
 | .error _ => false
 | .ok b => b

theorem twoWitnessPassed : twoWitness = true := rfl
theorem closedWitnessPassed : closedWitness = true := rfl
theorem openWitnessPassed : openWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl
end SFT.Chemistry.LigandDenticity


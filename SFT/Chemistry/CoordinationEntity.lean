import SFT.Chemistry.MulticentreSupport
namespace SFT.Chemistry.CoordinationEntity
open SFT.Host SFT.Physics.CapabilityValues
open MulticentreSupport (sameLabel distinct sameWord)
structure Attachment where
 sourceOccurrence : PositiveCount
 centralOccurrence : HeldLabel
 ligandOccurrence : HeldLabel
 ligandGroupIdentity : HeldLabel
 attachmentTrace : HeldLabel

def attachment (source : PositiveCount) (central ligand group trace : HeldLabel) : Except String Attachment := do
 if !Text.equal central.family "coordination-central-occurrence" then throw "coordination attachment must retain its central occurrence"
 if !Text.equal ligand.family "coordination-ligand-occurrence" then throw "coordination attachment must retain its ligand occurrence"
 if !Text.equal group.family "coordination-ligand-group" then throw "coordination attachment must retain its ligand group identity"
 if !Text.equal trace.family "positive-coordination-incidence" then throw "coordination attachment requires a positive incidence trace"
 return ⟨source,central,ligand,group,trace⟩
structure Entity where
 entityIdentity : HeldLabel
 centralElementIdentity : HeldLabel
 centralOccurrence : HeldLabel
 orderedAttachments : List Attachment

def completeSequence : Nat → List Attachment → Bool
 | _,[] => true
 | n,a::as => a.sourceOccurrence.value==n && completeSequence (n+1) as

def construct (entity element central : HeldLabel) (rows : List Attachment) : Except String Entity := do
 if !Text.equal entity.family "coordination-entity" then throw "coordination entity must retain one complete entity identity"
 if !Text.equal element.family "coordination-central-element" then throw "coordination entity must retain the central element identity"
 if !Text.equal central.family "coordination-central-occurrence" then throw "coordination entity must retain the central occurrence"
 if rows.isEmpty then throw "a coordination entity requires positive ligand attachment support"
 if !completeSequence 1 rows then throw "coordination attachment support must be complete and gap-free"
 if !(rows.all fun row => sameLabel row.centralOccurrence central) then throw "every ligand attachment must retain the same central occurrence"
 if !distinct (rows.map Attachment.ligandOccurrence) then throw "distinct ligand occurrences cannot be collapsed"
 if !distinct (rows.map Attachment.attachmentTrace) then throw "distinct central-ligand incidences cannot be collapsed"
 return ⟨entity,element,central,rows⟩
structure IdentityRecord where
 entityIdentity : HeldLabel
 centralElementIdentity : HeldLabel
 centralOccurrence : HeldLabel
 orderedLigandOccurrences : List HeldLabel
 orderedLigandGroupIdentities : List HeldLabel
 orderedAttachmentTraces : List HeldLabel

def forcedIdentity (entity : Entity) : IdentityRecord :=
 ⟨entity.entityIdentity,entity.centralElementIdentity,entity.centralOccurrence,
  entity.orderedAttachments.map Attachment.ligandOccurrence,
  entity.orderedAttachments.map Attachment.ligandGroupIdentity,
  entity.orderedAttachments.map Attachment.attachmentTrace⟩

def appendLigand (entity : Entity) (successor : Attachment) : Except String Entity := do
 if successor.sourceOccurrence.value != entity.orderedAttachments.length+1 then
  throw "coordination successor must be the next positive occurrence"
 if !sameLabel successor.centralOccurrence entity.centralOccurrence then
  throw "coordination successor cannot replace the central occurrence"
 construct entity.entityIdentity entity.centralElementIdentity entity.centralOccurrence (entity.orderedAttachments++[successor])

def appendPreservesIdentity (entity : Entity) (successor : Attachment) : Except String Bool := do
 let prior := forcedIdentity entity
 let extended ← appendLigand entity successor
 let result := forcedIdentity extended
 let width := prior.orderedLigandOccurrences.length
 return sameLabel result.entityIdentity prior.entityIdentity &&
  sameLabel result.centralElementIdentity prior.centralElementIdentity &&
  sameLabel result.centralOccurrence prior.centralOccurrence &&
  sameWord (result.orderedLigandOccurrences.take width) prior.orderedLigandOccurrences &&
  sameWord (result.orderedLigandGroupIdentities.take width) prior.orderedLigandGroupIdentities &&
  sameWord (result.orderedAttachmentTraces.take width) prior.orderedAttachmentTraces

def generatedAttachment (n : Nat) (central : HeldLabel) (group : String) : Except String Attachment := do
 attachment (← count n) central
  (← heldLabel "coordination-ligand-occurrence" (Text.append "ligand-" (toString n)))
  (← heldLabel "coordination-ligand-group" group)
  (← heldLabel "positive-coordination-incidence" (Text.append "central-to-ligand-" (toString n)))
def central : HeldLabel := ⟨"coordination-central-occurrence","Fe-one",by rfl,by rfl⟩
def base : Except String Entity := do
 construct (← heldLabel "coordination-entity" "example-entity")
  (← heldLabel "coordination-central-element" "Fe") central
  [← generatedAttachment 1 central "ligand-group-a",← generatedAttachment 2 central "ligand-group-a"]
def retainedCentralWitness : Bool := match base with
 | .error _ => false
 | .ok entity => sameLabel (forcedIdentity entity).centralOccurrence central
def retainedLigandsWitness : Bool := match base with
 | .error _ => false
 | .ok entity => let rows := (forcedIdentity entity).orderedLigandOccurrences
                 distinct rows && rows.length==2
def positiveIncidencesWitness : Bool := match base with
 | .error _ => false
 | .ok entity => let rows := (forcedIdentity entity).orderedAttachmentTraces
                 distinct rows && rows.length==2
def mismatchWitness : Bool := match (do
 let entity ← base
 let other ← heldLabel "coordination-central-occurrence" "different-central"
 construct entity.entityIdentity entity.centralElementIdentity entity.centralOccurrence
  [← generatedAttachment 1 other "ligand-group-a"]) with
 | .error _ => true
 | .ok _ => false
def successorWitness : Bool := match (do appendPreservesIdentity (← base) (← generatedAttachment 3 central "ligand-group-b")) with
 | .error _ => false
 | .ok b => b
set_option maxRecDepth 10000
set_option maxHeartbeats 20000000
theorem retainedCentralWitnessPassed : retainedCentralWitness = true := rfl
theorem retainedLigandsWitnessPassed : retainedLigandsWitness = true := rfl
theorem positiveIncidencesWitnessPassed : positiveIncidencesWitness = true := rfl
theorem mismatchWitnessPassed : mismatchWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl
end SFT.Chemistry.CoordinationEntity

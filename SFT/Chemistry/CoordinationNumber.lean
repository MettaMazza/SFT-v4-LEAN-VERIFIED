import SFT.Chemistry.CoordinationEntity
namespace SFT.Chemistry.CoordinationNumber
open SFT.Host SFT.Physics.CapabilityValues
open CoordinationEntity (Entity Attachment)
open MulticentreSupport (distinct sameLabel sameWord)
structure Record where
 entityIdentity : HeldLabel
 centralOccurrence : HeldLabel
 positiveDirectIncidenceCount : PositiveCount
 orderedIncidenceTraces : List HeldLabel

def forcedNumber (entity : Entity) : Except String Record := do
 let traces := entity.orderedAttachments.map Attachment.attachmentTrace
 if !distinct traces then throw "coordination incidence traces must remain distinct"
 let number ← count traces.length
 return ⟨entity.entityIdentity,entity.centralOccurrence,number,traces⟩

def appendIncrements (entity : Entity) (successor : Attachment) : Except String Bool := do
 if successor.sourceOccurrence.value != entity.orderedAttachments.length+1 ||
  !sameLabel successor.centralOccurrence entity.centralOccurrence then
  throw "coordination-number successor must be the next incidence on the retained centre"
 let before ← forcedNumber entity
 let extended ← CoordinationEntity.construct entity.entityIdentity entity.centralElementIdentity entity.centralOccurrence
  (entity.orderedAttachments++[successor])
 let after ← forcedNumber extended
 return after.positiveDirectIncidenceCount.value == before.positiveDirectIncidenceCount.value+1 &&
  sameWord (after.orderedIncidenceTraces.take (after.orderedIncidenceTraces.length-1)) before.orderedIncidenceTraces

def central : HeldLabel := ⟨"coordination-central-occurrence","central",by rfl,by rfl⟩
def generatedAttachment (n : Nat) : Except String Attachment := do
 CoordinationEntity.attachment (← count n) central
  (← heldLabel "coordination-ligand-occurrence" (Text.append "L-" (toString n)))
  (← heldLabel "coordination-ligand-group" "L")
  (← heldLabel "positive-coordination-incidence" (Text.append "edge-" (toString n)))
def generatedEntity (width : Nat) : Except String Entity := do
 let rows ← (List.range width).mapM fun i => generatedAttachment (i+1)
 CoordinationEntity.construct (← heldLabel "coordination-entity" (Text.append "entity-" (toString width)))
  (← heldLabel "coordination-central-element" "M") central rows

def threeWitness : Bool := match (do forcedNumber (← generatedEntity 3)) with
 | .error _ => false
 | .ok r => r.positiveDirectIncidenceCount.value == 3
def fourWitness : Bool := match (do forcedNumber (← generatedEntity 4)) with
 | .error _ => false
 | .ok r => r.positiveDirectIncidenceCount.value == 4
def fiveWitness : Bool := match (do forcedNumber (← generatedEntity 5)) with
 | .error _ => false
 | .ok r => r.positiveDirectIncidenceCount.value == 5
def successorWitness : Bool := match (do appendIncrements (← generatedEntity 3) (← generatedAttachment 4)) with
 | .error _ => false
 | .ok b => b

theorem threeWitnessPassed : threeWitness = true := rfl
theorem fourWitnessPassed : fourWitness = true := rfl
theorem fiveWitnessPassed : fiveWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl

theorem forcedNumberExact (entity : Entity) (out : Record) (accepted : forcedNumber entity = .ok out) :
 out.entityIdentity = entity.entityIdentity ∧ out.centralOccurrence = entity.centralOccurrence ∧
 out.positiveDirectIncidenceCount.value = (entity.orderedAttachments.map Attachment.attachmentTrace).length ∧
 out.orderedIncidenceTraces = entity.orderedAttachments.map Attachment.attachmentTrace := by
 unfold forcedNumber at accepted
 dsimp only at accepted
 cases unique : distinct (entity.orderedAttachments.map Attachment.attachmentTrace) with
 | false => rw [unique] at accepted; cases accepted
 | true =>
  rw [unique] at accepted
  cases width : (entity.orderedAttachments.map Attachment.attachmentTrace).length with
  | zero => rw [width] at accepted; cases accepted
  | succ n =>
   rw [width] at accepted
   cases accepted
   exact ⟨rfl,rfl,rfl,rfl⟩
end SFT.Chemistry.CoordinationNumber

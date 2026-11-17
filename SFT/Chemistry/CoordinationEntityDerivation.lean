import SFT.Chemistry.CoordinationEntity
namespace SFT.Chemistry.CoordinationEntityDerivation
open SFT.Physics.CapabilityValues
open CoordinationEntity

theorem constructedIdentity (entity element central : HeldLabel) (rows : List Attachment) (result : Entity)
 (accepted : construct entity element central rows = .ok result) :
 result = ⟨entity,element,central,rows⟩ := by
 unfold construct at accepted
 cases guard0 : (!SFT.Host.Text.equal entity.family "coordination-entity") with
 | true => rw [guard0] at accepted; cases accepted
 | false =>
  rw [guard0] at accepted
  cases guard1 : (!SFT.Host.Text.equal element.family "coordination-central-element") with
  | true => rw [guard1] at accepted; cases accepted
  | false =>
   rw [guard1] at accepted
   cases guard2 : (!SFT.Host.Text.equal central.family "coordination-central-occurrence") with
   | true => rw [guard2] at accepted; cases accepted
   | false =>
    rw [guard2] at accepted
    cases guard3 : (rows.isEmpty) with
    | true => rw [guard3] at accepted; cases accepted
    | false =>
     rw [guard3] at accepted
     cases guard4 : (!completeSequence 1 rows) with
     | true => rw [guard4] at accepted; cases accepted
     | false =>
      rw [guard4] at accepted
      cases guard5 : (!(rows.all fun row => MulticentreSupport.sameLabel row.centralOccurrence central)) with
      | true => rw [guard5] at accepted; cases accepted
      | false =>
       rw [guard5] at accepted
       cases guard6 : (!MulticentreSupport.distinct (rows.map Attachment.ligandOccurrence)) with
       | true => rw [guard6] at accepted; cases accepted
       | false =>
        rw [guard6] at accepted
        cases guard7 : (!MulticentreSupport.distinct (rows.map Attachment.attachmentTrace)) with
        | true => rw [guard7] at accepted; cases accepted
        | false =>
         rw [guard7] at accepted
         exact (Except.ok.inj accepted).symm

theorem appendedEntity (entity : Entity) (successor : Attachment) (result : Entity)
 (accepted : appendLigand entity successor = .ok result) :
 result = ⟨entity.entityIdentity,entity.centralElementIdentity,entity.centralOccurrence,entity.orderedAttachments++[successor]⟩ := by
 unfold appendLigand at accepted
 cases guard0 : (successor.sourceOccurrence.value != entity.orderedAttachments.length+1) with
 | true => rw [guard0] at accepted; cases accepted
 | false =>
  rw [guard0] at accepted
  cases guard1 : (!MulticentreSupport.sameLabel successor.centralOccurrence entity.centralOccurrence) with
  | true => rw [guard1] at accepted; cases accepted
  | false =>
   rw [guard1] at accepted
   exact constructedIdentity _ _ _ _ _ accepted

theorem retainedAttachmentPrefix (rows : List Attachment) (next : Attachment) (projection : Attachment → HeldLabel) :
 ((rows++[next]).map projection).take rows.length = rows.map projection := by
 induction rows with
 | nil => rfl
 | cons row rows ih =>
  change projection row :: ((rows++[next]).map projection).take rows.length = projection row :: rows.map projection
  exact congrArg (List.cons (projection row)) ih

theorem entirePriorIdentityRetained (entity : Entity) (successor : Attachment) (result : Entity)
 (accepted : appendLigand entity successor = .ok result) :
 (forcedIdentity result).entityIdentity = (forcedIdentity entity).entityIdentity ∧
 (forcedIdentity result).centralElementIdentity = (forcedIdentity entity).centralElementIdentity ∧
 (forcedIdentity result).centralOccurrence = (forcedIdentity entity).centralOccurrence ∧
 (forcedIdentity result).orderedLigandOccurrences.take entity.orderedAttachments.length = (forcedIdentity entity).orderedLigandOccurrences ∧
 (forcedIdentity result).orderedLigandGroupIdentities.take entity.orderedAttachments.length = (forcedIdentity entity).orderedLigandGroupIdentities ∧
 (forcedIdentity result).orderedAttachmentTraces.take entity.orderedAttachments.length = (forcedIdentity entity).orderedAttachmentTraces := by
 rw [appendedEntity entity successor result accepted]
 exact ⟨rfl,rfl,rfl,retainedAttachmentPrefix _ _ _,retainedAttachmentPrefix _ _ _,retainedAttachmentPrefix _ _ _⟩
end SFT.Chemistry.CoordinationEntityDerivation

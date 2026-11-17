import SFT.Chemistry.CoordinationNumber
import SFT.Chemistry.CoordinationEntityDerivation
namespace SFT.Chemistry.CoordinationNumberDerivation
open SFT.Chemistry.CoordinationNumber SFT.Chemistry.CoordinationEntity

theorem successorCountAndPrefix (entity extended : Entity) (next : Attachment) (before after : Record)
 (built : construct entity.entityIdentity entity.centralElementIdentity entity.centralOccurrence
  (entity.orderedAttachments++[next]) = .ok extended)
 (beforeAccepted : forcedNumber entity = .ok before)
 (afterAccepted : forcedNumber extended = .ok after) :
 after.positiveDirectIncidenceCount.value = before.positiveDirectIncidenceCount.value+1 ∧
 after.orderedIncidenceTraces.take (after.orderedIncidenceTraces.length-1) = before.orderedIncidenceTraces := by
 have extendedExact := CoordinationEntityDerivation.constructedIdentity _ _ _ _ _ built
 have beforeExact := forcedNumberExact entity before beforeAccepted
 have afterExact := forcedNumberExact extended after afterAccepted
 rw [extendedExact] at afterExact
 have priorCount := beforeExact.2.2.1
 have nextCount := afterExact.2.2.1
 have priorTraces := beforeExact.2.2.2
 have nextTraces := afterExact.2.2.2
 constructor
 · rw [nextCount,priorCount]
   change ((entity.orderedAttachments++[next]).map Attachment.attachmentTrace).length =
    (entity.orderedAttachments.map Attachment.attachmentTrace).length+1
   generalize entity.orderedAttachments = rows
   induction rows with
   | nil => rfl
   | cons row rows ih => exact congrArg Nat.succ ih
 · rw [nextTraces,priorTraces]
   change ((entity.orderedAttachments++[next]).map Attachment.attachmentTrace).take
    (((entity.orderedAttachments++[next]).map Attachment.attachmentTrace).length-1) =
     entity.orderedAttachments.map Attachment.attachmentTrace
   have size : ((entity.orderedAttachments++[next]).map Attachment.attachmentTrace).length = entity.orderedAttachments.length+1 := by
    generalize entity.orderedAttachments = rows
    induction rows with
    | nil => rfl
    | cons row rows ih => exact congrArg Nat.succ ih
   rw [size]
   exact CoordinationEntityDerivation.retainedAttachmentPrefix _ _ _
end SFT.Chemistry.CoordinationNumberDerivation

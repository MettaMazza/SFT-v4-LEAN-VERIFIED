import SFT.Chemistry.LigandDenticity
namespace SFT.Chemistry.LigandDenticityDerivation
open SFT.Chemistry.LigandDenticity SFT.Chemistry.CoordinationEntity
open SFT.Physics.CapabilityValues
-- The returned record is the original source's eight-field record.
theorem retainedRecord (entity : Entity) (topology : Topology) (out : Record)
 (accepted : forced entity topology = .ok out) :
 out.carrier = topology.carrier ∧ out.central = topology.central ∧
 out.denticity.value = topology.donors.length ∧ out.donors = topology.donors ∧
 out.attachments = topology.attachments ∧ out.internalConnections = topology.internalConnections := by
 unfold forced at accepted
 dsimp only at accepted
 split at accepted
 · cases accepted
 · split at accepted
   · cases accepted
   · split at accepted
     · cases accepted
     · cases width : topology.donors.length with
       | zero => rw [width] at accepted; cases accepted
       | succ n =>
         rw [width] at accepted
         cases n with
         | zero =>
           cases accepted
           exact ⟨rfl,rfl,rfl,rfl,rfl,rfl⟩
         | succ n =>
           cases first : topology.attachments.head? with
           | none => rw [first] at accepted; cases accepted
           | some a =>
             rw [first] at accepted
             cases last : topology.attachments.getLast? with
             | none => rw [last] at accepted; cases accepted
             | some b =>
               rw [last] at accepted
               cases accepted
               exact ⟨rfl,rfl,rfl,rfl,rfl,rfl⟩
theorem closedTraceEmptyExactlyAtOne (entity : Entity) (topology : Topology) (out : Record)
 (accepted : forced entity topology = .ok out) :
 out.closedTrace.isEmpty = (topology.donors.length == 1) := by
 unfold forced at accepted
 dsimp only at accepted
 split at accepted
 · cases accepted
 · split at accepted
   · cases accepted
   · split at accepted
     · cases accepted
     · cases width : topology.donors.length with
       | zero => rw [width] at accepted; cases accepted
       | succ n =>
         rw [width] at accepted
         cases n with
         | zero =>
           cases accepted
           rfl
         | succ n =>
           cases first : topology.attachments.head? with
           | none => rw [first] at accepted; cases accepted
           | some a =>
             rw [first] at accepted
             cases last : topology.attachments.getLast? with
             | none => rw [last] at accepted; cases accepted
             | some b =>
               rw [last] at accepted
               cases accepted
               rfl
-- Original append operation, conditional only on its accepted before/after records.
theorem successorPreservesAndIncrements (entity : Entity) (t : Topology)
 (donor attachment internalConnection : HeldLabel) (before after : Record)
 (hb : forced entity t = .ok before)
 (ha : forced entity ⟨t.carrier,t.group,t.central,t.donors++[donor],
  t.attachments++[attachment],t.internalConnections++[internalConnection]⟩ = .ok after) :
 after.carrier = before.carrier ∧ after.central = before.central ∧
 after.denticity.value = before.denticity.value+1 ∧
 after.donors.take before.donors.length = before.donors ∧
 after.attachments.take before.attachments.length = before.attachments ∧
 after.internalConnections.take before.internalConnections.length = before.internalConnections := by
 have b := retainedRecord entity t before hb
 have a := retainedRecord entity _ after ha
 rcases b with ⟨bc,bm,bn,bd,ba,bi⟩
 rcases a with ⟨ac,am,an,ad,aa,ai⟩
 dsimp only at ac am an ad aa ai
 rw [ac,am,an,ad,aa,ai,bc,bm,bn,bd,ba,bi]
 refine ⟨rfl,rfl,?_,?_,?_,?_⟩
 · induction t.donors with
   | nil => rfl
   | cons x xs ih => exact congrArg Nat.succ ih
 · induction t.donors with
   | nil => rfl
   | cons x xs ih => exact congrArg (List.cons x) ih
 · induction t.attachments with
   | nil => rfl
   | cons x xs ih => exact congrArg (List.cons x) ih
 · induction t.internalConnections with
   | nil => rfl
   | cons x xs ih => exact congrArg (List.cons x) ih

#print axioms closedTraceEmptyExactlyAtOne
#print axioms retainedRecord
#print axioms successorPreservesAndIncrements
end SFT.Chemistry.LigandDenticityDerivation

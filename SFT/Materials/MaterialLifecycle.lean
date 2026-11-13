import SFT.Materials.MaterialCarrier
import SFT.Physics.MechanicalEvents
import SFT.Physics.MechanicalConservation
namespace SFT.Materials.MaterialLifecycle
open SFT.Physics.MechanicalEvents SFT.Physics.MechanicalConservation SFT.Host.Canonical

-- SUST-LIFECYCLE: complete source/process/use paths and an explicitly
-- recorded recovery path when present. A recovery claim is checked, not assumed.
structure Recovery {Composition : Type} (used : Event (MaterialCarrier.Record Composition)) where
 recovered : Event (MaterialCarrier.Record Composition)
 path : Path used recovered

structure Record (Composition Flow Loss : Type) where
 source : Event (MaterialCarrier.Record Composition)
 processed : Event (MaterialCarrier.Record Composition)
 used : Event (MaterialCarrier.Record Composition)
 processing : Path source processed
 usePath : Path processed used
 recovery : Option (Recovery used)
 flows : Row (MaterialCarrier.Record Composition) → Network String Flow
 losses : Row (MaterialCarrier.Record Composition) → Network String Loss
 quality : Event (MaterialCarrier.Record Composition) → Value
 systemBoundary : Value
 provenance : Value

variable {Composition Flow Loss : Type}

def recoveryChanges (r : Record Composition Flow Loss) : List (Row (MaterialCarrier.Record Composition)) :=
 match r.recovery with
 | none => []
 | some rec => changes rec.path

def transitions (r : Record Composition Flow Loss) := changes r.processing ++ changes r.usePath ++ recoveryChanges r

def ledger (r : Record Composition Flow Loss) := (transitions r).map (fun t => (t,r.flows t,r.losses t,r.quality t.before,r.quality t.after))

theorem everyTransitionRetained (r : Record Composition Flow Loss) : (ledger r).map Prod.fst = transitions r := by
 unfold ledger
 generalize transitions r = ts
 induction ts with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons h) ih

theorem transitionLedgerExactly (r : Record Composition Flow Loss) (t : Row (MaterialCarrier.Record Composition))
 (h : t ∈ transitions r) : (t,r.flows t,r.losses t,r.quality t.before,r.quality t.after) ∈ ledger r :=
 SFT.Foundation.Count.TraceDerivation.memMap _ _ _ h

theorem processingHistoryComplete (r : Record Composition Flow Loss) :
 (events r.processing).length = count r.processing + 1 := completeEventCount _

theorem useHistoryComplete (r : Record Composition Flow Loss) :
 (events r.usePath).length = count r.usePath + 1 := completeEventCount _

theorem recoveryHistoryComplete (r : Record Composition Flow Loss) (rec : Recovery r.used) :
 (events rec.path).length = count rec.path + 1 := completeEventCount _

theorem processingSourcesRetained (r : Record Composition Flow Loss) :
 (changes r.processing).map (fun t => (t.sourceIdentity,t.actionRecord)) = sourceRecords r.processing :=
 allSourceRecordsRetained _

def allFlows (r : Record Composition Flow Loss) := (transitions r).flatMap r.flows
def allLosses (r : Record Composition Flow Loss) := (transitions r).flatMap r.losses

theorem completeFlowBalance (r : Record Composition Flow Loss) : outgoingSupport (allFlows r) = incomingSupport (allFlows r) := completeConservation _
theorem lossesRemainInLedger (r : Record Composition Flow Loss) : outgoingSupport (allLosses r) = incomingSupport (allLosses r) := completeConservation _

def recyclable (r : Record Composition Flow Loss) : Prop :=
 ∃ rec, r.recovery = some rec ∧ MaterialCarrier.sameIdentity r.source.carrier rec.recovered.carrier

theorem requiresExplicitRecovery (r : Record Composition Flow Loss) (h : recyclable r) :
 ∃ rec : Recovery r.used, r.recovery = some rec ∧ MaterialCarrier.sameIdentity r.source.carrier rec.recovered.carrier := h

theorem absentRecoveryRejected (r : Record Composition Flow Loss) (h : r.recovery = none) : ¬ recyclable r := by
 intro ⟨rec,held,_⟩
 rw [h] at held
 cases held

theorem recoveryIdentityExactly (r : Record Composition Flow Loss) (rec : Recovery r.used)
 (h : r.recovery = some rec) : recyclable r ↔
 r.source.carrier.constituents = rec.recovered.carrier.constituents ∧
 r.source.carrier.bonding = rec.recovered.carrier.bonding ∧
 r.source.carrier.boundary = rec.recovered.carrier.boundary ∧
 r.source.carrier.observations = rec.recovered.carrier.observations := by
 constructor
 · intro ⟨other,held,same⟩
   have equal : other = rec := Option.some.inj (held.symm.trans h)
   cases equal
   exact (MaterialCarrier.identityExactly _ _).mp same
 · intro fields
   exact ⟨rec,h,(MaterialCarrier.identityExactly _ _).mpr fields⟩

def record (r : Record Composition Flow Loss) := (r,ledger r,allFlows r,allLosses r)

theorem fullInputRetained (r : Record Composition Flow Loss) : (record r).1 = r := rfl

theorem lossQualityRetained (r : Record Composition Flow Loss) (t : Row (MaterialCarrier.Record Composition)) :
 (t,r.flows t,r.losses t,r.quality t.before,r.quality t.after).2.2 =
 (r.losses t,r.quality t.before,r.quality t.after) := rfl

def records (rs : List (Record Composition Flow Loss)) := rs.map record

theorem base (r : Record Composition Flow Loss) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Composition Flow Loss)) (r : Record Composition Flow Loss) :
 records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.MaterialLifecycle

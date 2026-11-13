import SFT.Physics.CollectivePhaseOrder
namespace SFT.Materials.PhaseHistory
open SFT.Physics

structure Record (Carrier : Type) where
 first : MechanicalEvents.Event CollectivePhaseOrder.OrderedRegion
 last : MechanicalEvents.Event CollectivePhaseOrder.OrderedRegion
 path : MechanicalEvents.Path first last
 initialRecurrence : MechanicalDuration.Recurrence (String × List String)
 finalRecurrence : MechanicalDuration.Recurrence (String × List String)
 initialClass : initialRecurrence.first.carrier = CollectivePhaseOrder.fibreView first.carrier
 finalClass : finalRecurrence.first.carrier = CollectivePhaseOrder.fibreView last.carrier
 changed : CollectivePhaseOrder.fibreView first.carrier ≠ CollectivePhaseOrder.fibreView last.carrier
 content : MechanicalConservation.Network String Carrier
 conditions : SFT.Host.Canonical.Value
 hysteresisBoundary : SFT.Host.Canonical.Value

variable {Carrier : Type}

theorem initialStableClass (r : Record Carrier) :
 r.initialRecurrence.last.carrier = CollectivePhaseOrder.fibreView r.first.carrier :=
 r.initialRecurrence.returnsToCarrier.trans r.initialClass

theorem finalStableClass (r : Record Carrier) :
 r.finalRecurrence.last.carrier = CollectivePhaseOrder.fibreView r.last.carrier :=
 r.finalRecurrence.returnsToCarrier.trans r.finalClass

theorem distinctMacroClasses (r : Record Carrier) :
 ¬ CollectivePhaseOrder.stableObservation r.first.carrier r.last.carrier := fun same => r.changed same.1

theorem completeContentLedger (r : Record Carrier) :
 MechanicalConservation.outgoingSupport r.content = MechanicalConservation.incomingSupport r.content :=
 MechanicalConservation.completeConservation r.content

theorem allPathEvents (r : Record Carrier) :
 (MechanicalEvents.events r.path).length = MechanicalEvents.count r.path + 1 :=
 MechanicalEvents.completeEventCount r.path

theorem allSourceActions (r : Record Carrier) :
 (MechanicalEvents.changes r.path).map (fun row => (row.sourceIdentity,row.actionRecord)) =
 MechanicalEvents.sourceRecords r.path := MechanicalEvents.allSourceRecordsRetained r.path

theorem symmetryChangeRecorded (r : Record Carrier) (f g : String → String)
 (before : CollectivePhaseOrder.symmetry r.first.carrier f g)
 (after : ¬ CollectivePhaseOrder.symmetry r.last.carrier f g) :
 ¬ CollectivePhaseOrder.sameSymmetryClass r.first.carrier r.last.carrier :=
 CollectivePhaseOrder.changedSymmetryWitness r.first.carrier r.last.carrier f g before after

def record (r : Record Carrier) :=
 (r,CollectivePhaseOrder.fibreView r.first.carrier,CollectivePhaseOrder.fibreView r.last.carrier,
 MechanicalEvents.events r.path,MechanicalEvents.changes r.path,r.content)

theorem bothPhaseRecords (r : Record Carrier) :
 (record r).1.first = r.first ∧ (record r).1.last = r.last := ⟨rfl,rfl⟩

theorem changedPathDistinguished (r s : Record Carrier)
 (different : MechanicalEvents.sourceRecords r.path ≠ MechanicalEvents.sourceRecords s.path) :
 record r ≠ record s := by
 intro same
 exact different (congrArg (fun x => MechanicalEvents.sourceRecords x.1.path) same)

theorem conditionsAndHysteresis (r : Record Carrier) :
 (record r).1.conditions = r.conditions ∧ (record r).1.hysteresisBoundary = r.hysteresisBoundary := ⟨rfl,rfl⟩

def records (rs : List (Record Carrier)) := rs.map record

theorem base (r : Record Carrier) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Carrier)) (r : Record Carrier) :
 records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.PhaseHistory

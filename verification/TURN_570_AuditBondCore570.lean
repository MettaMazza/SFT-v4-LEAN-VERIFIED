import SFT.Chemistry.SourceText
import SFT.Chemistry.EntityIdentity
import SFT.Physics.QuantumPhysicalSpin
namespace SFT.Chemistry.BondClosure
open SFT.Mathematics.GeometryTopology
structure Channel where
 family : String
 label : String
 familyHeld : SourceText.nonblank family = true
 labelHeld : SourceText.nonblank label = true
structure Raw where
 left : String
 right : String
 channels : List Channel
 stable : Bool

def admitted (raw : Raw) : Bool :=
 SourceText.nonblank raw.left && SourceText.nonblank raw.right && decide (raw.left ≠ raw.right) &&
 !raw.channels.isEmpty && raw.stable
structure Support where
 raw : Raw
 valid : admitted raw = true

def makeSupport (raw : Raw) : Except String Support :=
 if valid : admitted raw=true then .ok ⟨raw,valid⟩
 else .error "bond support requires distinct carrier occurrences, joining channels and stable recurrence"

theorem admittedExactly (raw : Raw) : admitted raw=true ↔
 SourceText.nonblank raw.left=true ∧ SourceText.nonblank raw.right=true ∧ raw.left ≠ raw.right ∧
 raw.channels.isEmpty=false ∧ raw.stable=true := by
 constructor
 · intro h
   have a := (andTrue _ _).mp h
   have b := (andTrue _ _).mp a.1
   have c := (andTrue _ _).mp b.1
   have d := (andTrue _ _).mp c.1
   have nonempty : raw.channels.isEmpty=false := by
    cases e : raw.channels.isEmpty with
    | false => rfl
    | true => rw [e] at b; cases b.2
   exact ⟨d.1,d.2,of_decide_eq_true c.2,nonempty,a.2⟩
 · intro h
   have nonempty : (!raw.channels.isEmpty)=true := by rw [h.2.2.2.1]; rfl
   exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨h.1,h.2.1⟩,decide_eq_true h.2.2.1⟩,nonempty⟩,h.2.2.2.2⟩

def joiningMultiplicity (support : Support) : Nat := support.raw.channels.length

theorem joiningMultiplicityPositive (support : Support) : 0 < joiningMultiplicity support := by
 have nonempty := ((admittedExactly _).mp support.valid).2.2.2.1
 cases h : support.raw.channels with
 | nil => rw [h] at nonempty; cases nonempty
 | cons first rest => change 0 < support.raw.channels.length; rw [h]; exact Nat.zero_lt_succ _

theorem makeAdmitted (raw : Raw) (valid : admitted raw=true) : makeSupport raw=.ok ⟨raw,valid⟩ := by
 unfold makeSupport
 rw [dite_eq_left valid]

theorem makeRejected (raw : Raw) (invalid : admitted raw≠true) : makeSupport raw=
 .error "bond support requires distinct carrier occurrences, joining channels and stable recurrence" := by
 unfold makeSupport
 rw [dite_eq_right invalid]

theorem transientRejected (raw : Raw) (transient : raw.stable=false) : admitted raw=false := by
 unfold admitted
 rw [transient]
 cases (SourceText.nonblank raw.left && SourceText.nonblank raw.right && decide (raw.left ≠ raw.right) && !raw.channels.isEmpty) <;> rfl

def initial (left right : String) (channel : Channel) : Raw := ⟨left,right,[channel],true⟩
theorem initialAdmitted (left right : String) (channel : Channel)
 (hl : SourceText.nonblank left=true) (hr : SourceText.nonblank right=true) (different : left≠right) :
 admitted (initial left right channel)=true := (admittedExactly _).mpr ⟨hl,hr,different,rfl,rfl⟩

def appendChannel (raw : Raw) (channel : Channel) (stable : Bool) : Raw :=
 {raw with channels := raw.channels++[channel], stable := stable}

theorem appendedNonempty (channels : List Channel) (channel : Channel) : (channels++[channel]).isEmpty=false := by
 cases channels <;> rfl

theorem extensionExactly (support : Support) (channel : Channel) (stable : Bool) :
 admitted (appendChannel support.raw channel stable)=true ↔ stable=true := by
 have old := (admittedExactly _).mp support.valid
 constructor
 · intro h; exact ((admittedExactly _).mp h).2.2.2.2
 · intro h
   exact (admittedExactly _).mpr ⟨old.1,old.2.1,old.2.2.1,appendedNonempty _ _,h⟩

theorem completeChannelsRetained (raw : Raw) (channel old : Channel) (stable : Bool) (held : old ∈ raw.channels) :
 old ∈ (appendChannel raw channel stable).channels := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem constituentIdentitiesRetained (raw : Raw) (channel : Channel) (stable : Bool) :
 (appendChannel raw channel stable).left=raw.left ∧ (appendChannel raw channel stable).right=raw.right := ⟨rfl,rfl⟩

def opening (support : Support) := (support.raw.left,support.raw.right,support.raw.channels)

theorem openingRetainsSource (support : Support) :
 (opening support).1=support.raw.left ∧ (opening support).2.1=support.raw.right ∧
 (opening support).2.2=support.raw.channels := ⟨rfl,rfl,rfl⟩

theorem closingAfterOpening (support : Support) :
 makeSupport ⟨(opening support).1,(opening support).2.1,(opening support).2.2,support.raw.stable⟩=.ok support := by
 cases support with
 | mk raw valid => exact makeAdmitted raw valid

-- The retained physical phase action supplies the actual recurrence witness;
-- the Boolean in the original source remains its constructor admission field.
structure Recurrence where
 prepared : SFT.Physics.QuantumPhysicalState.Prepared
 steps : List String
 completePeriod : steps.length=prepared.state.phaseCycle.length

theorem jointReturn (recurrence : Recurrence) :
 SFT.QuantumComputation.ReversibleModel.phaseAction recurrence.prepared.state recurrence.steps = .ok recurrence.prepared.state :=
 SFT.Physics.QuantumPhysicalSpin.fullOrientationRecurrenceReturns _ _ recurrence.completePeriod

structure Record where
 support : Support
 recurrence : Recurrence
 entity : EntityIdentity.Entity
 leftCarrier : EntityIdentity.Entity
 rightCarrier : EntityIdentity.Entity
 leftOccurrence : leftCarrier.carrier = support.raw.left
 rightOccurrence : rightCarrier.carrier = support.raw.right
 independent : ¬ EntityIdentity.sameIdentity entity leftCarrier ∧ ¬ EntityIdentity.sameIdentity entity rightCarrier
 interactionTrace : List (Channel × List String)
 completeChannels : interactionTrace.map Prod.fst = support.raw.channels
 completeAction : interactionTrace.flatMap Prod.snd = recurrence.steps
 observationBoundary : SFT.Host.Canonical.Value
 measuredStability : SFT.Host.Canonical.Value
 transfers : List SFT.Host.Canonical.Value

def structuralClass (record : Record) : Bool := admitted record.support.raw

theorem measuredEnergyDoesNotSelect (record : Record) (measurement : SFT.Host.Canonical.Value) :
 structuralClass {record with measuredStability := measurement}=structuralClass record := rfl

theorem recordHasJointReturn (record : Record) :
 SFT.QuantumComputation.ReversibleModel.phaseAction record.recurrence.prepared.state record.recurrence.steps =
 .ok record.recurrence.prepared.state := jointReturn record.recurrence

theorem completeSourceInteractions (record : Record) :
 record.interactionTrace.map Prod.fst = record.support.raw.channels := record.completeChannels

theorem sourceInteractionReturns (record : Record) :
 SFT.QuantumComputation.ReversibleModel.phaseAction record.recurrence.prepared.state
 (record.interactionTrace.flatMap Prod.snd) = .ok record.recurrence.prepared.state := by
 rw [record.completeAction]
 exact recordHasJointReturn record

def openedRecord (record : Record) := (opening record.support,record.interactionTrace,record.transfers,record.observationBoundary)

theorem openingRetainsTransfersAndBoundary (record : Record) :
 (openedRecord record).2.1=record.interactionTrace ∧ (openedRecord record).2.2.1=record.transfers ∧
 (openedRecord record).2.2.2=record.observationBoundary := ⟨rfl,rfl,rfl⟩

theorem independentJointIdentity (record : Record) :
 ¬ EntityIdentity.sameIdentity record.entity record.leftCarrier ∧
 ¬ EntityIdentity.sameIdentity record.entity record.rightCarrier := record.independent

theorem identityDistinctionRetained (a b : Record) (different : ¬ EntityIdentity.sameIdentity a.entity b.entity) : a≠b := by
 intro same
 cases same
 exact different rfl
end SFT.Chemistry.BondClosure

#print axioms SFT.Chemistry.BondClosure.admitted
#print axioms SFT.Chemistry.BondClosure.makeSupport
#print axioms SFT.Chemistry.BondClosure.admittedExactly
#print axioms SFT.Chemistry.BondClosure.joiningMultiplicity
#print axioms SFT.Chemistry.BondClosure.joiningMultiplicityPositive
#print axioms SFT.Chemistry.BondClosure.makeAdmitted
#print axioms SFT.Chemistry.BondClosure.makeRejected
#print axioms SFT.Chemistry.BondClosure.transientRejected
#print axioms SFT.Chemistry.BondClosure.initial
#print axioms SFT.Chemistry.BondClosure.initialAdmitted
#print axioms SFT.Chemistry.BondClosure.appendChannel
#print axioms SFT.Chemistry.BondClosure.appendedNonempty
#print axioms SFT.Chemistry.BondClosure.extensionExactly
#print axioms SFT.Chemistry.BondClosure.completeChannelsRetained
#print axioms SFT.Chemistry.BondClosure.constituentIdentitiesRetained
#print axioms SFT.Chemistry.BondClosure.opening
#print axioms SFT.Chemistry.BondClosure.openingRetainsSource
#print axioms SFT.Chemistry.BondClosure.closingAfterOpening
#print axioms SFT.Chemistry.BondClosure.jointReturn
#print axioms SFT.Chemistry.BondClosure.structuralClass
#print axioms SFT.Chemistry.BondClosure.measuredEnergyDoesNotSelect
#print axioms SFT.Chemistry.BondClosure.recordHasJointReturn
#print axioms SFT.Chemistry.BondClosure.completeSourceInteractions
#print axioms SFT.Chemistry.BondClosure.sourceInteractionReturns
#print axioms SFT.Chemistry.BondClosure.openedRecord
#print axioms SFT.Chemistry.BondClosure.openingRetainsTransfersAndBoundary
#print axioms SFT.Chemistry.BondClosure.independentJointIdentity
#print axioms SFT.Chemistry.BondClosure.identityDistinctionRetained

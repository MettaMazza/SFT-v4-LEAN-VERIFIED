import SFT.Chemistry.MolecularGeometry
import SFT.Physics.MechanicalDuration
import SFT.Mathematics.DiscreteComposition
namespace SFT.Chemistry.Infrared
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects
abbrev Value := SFT.Host.Canonical.Value
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel

structure Molecule where
 carrier : MolecularCarrier.Carrier
 orientations : List MolecularGeometry.Relation
 complete : MolecularGeometry.completeGeometry carrier.raw orientations=true

structure State (molecule : Molecule) where
 identity : HeldLabel
 internalRecurrence : SFT.Physics.MechanicalDuration.Recurrence Value
 displacementRecord : Value
 interaction : List String
 sourceRecord : Value

structure Transition (molecule : Molecule) where
 before : State molecule
 after : State molecule
 incident : SFT.Physics.MechanicalDuration.Recurrence Value
 response : SFT.Physics.CapabilityValues.PositiveCount
 sourceRecord : Value

def coupled {m : Molecule} (row : Transition m) : Bool :=
 decide (row.before.interaction ≠ row.after.interaction)

theorem coupledExactly {m : Molecule} (row : Transition m) :
 coupled row=true ↔ row.before.interaction≠row.after.interaction :=
 ⟨of_decide_eq_true,decide_eq_true⟩

theorem unchangedExcluded {m : Molecule} (row : Transition m)
 (same : row.before.interaction=row.after.interaction) : coupled row=false :=
 decide_eq_false (fun different => different same)

def visible {m : Molecule} (rows : List (Transition m)) := rows.filter coupled
def noncoupled {m : Molecule} (rows : List (Transition m)) := rows.filter (fun row => !coupled row)

theorem visibleExactly {m : Molecule} (rows : List (Transition m)) (row : Transition m) :
 row∈visible rows ↔ row∈rows ∧ row.before.interaction≠row.after.interaction := by
 constructor
 · intro held
   have h := (filterMemberIff coupled rows row).mp held
   exact ⟨h.1,(coupledExactly row).mp h.2⟩
 · intro h
   exact (filterMemberIff coupled rows row).mpr ⟨h.1,(coupledExactly row).mpr h.2⟩

theorem noncoupledExactly {m : Molecule} (rows : List (Transition m)) (row : Transition m) :
 row∈noncoupled rows ↔ row∈rows ∧ row.before.interaction=row.after.interaction := by
 constructor
 · intro held
   have h := (filterMemberIff (fun row => !coupled row) rows row).mp held
   by_cases same : row.before.interaction=row.after.interaction
   · exact ⟨h.1,same⟩
   · have yes := (coupledExactly row).mpr same
     rw [yes] at h
     have impossible : false=true := h.2
     cases impossible
 · intro h
   apply (filterMemberIff (fun row => !coupled row) rows row).mpr
   exact ⟨h.1,by rw [unchangedExcluded row h.2]; rfl⟩

theorem completeDecision {m : Molecule} (rows : List (Transition m)) (row : Transition m)
 (held : row∈rows) : row∈visible rows ∨ row∈noncoupled rows := by
 by_cases same : row.before.interaction=row.after.interaction
 · exact .inr ((noncoupledExactly rows row).mpr ⟨held,same⟩)
 · exact .inl ((visibleExactly rows row).mpr ⟨held,same⟩)

theorem separatedDecisions {m : Molecule} (rows : List (Transition m)) (row : Transition m) :
 ¬(row∈visible rows ∧ row∈noncoupled rows) := by
 intro both
 exact ((visibleExactly rows row).mp both.1).2 ((noncoupledExactly rows row).mp both.2).2

structure Spectrum (molecule : Molecule) where
 states : List (State molecule)
 transitions : List (Transition molecule)
 endpoints : ∀ row∈transitions, row.before∈states ∧ row.after∈states
 method : HeldLabel
 conditions : Value

-- Every declared pair is retained, including the pairs without a changed interaction.
def decisionTrace {m : Molecule} (spectrum : Spectrum m) :=
 spectrum.transitions.map (fun row => (row,coupled row))

def frequency {m : Molecule} (row : Transition m)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) :=
 SFT.Mathematics.ExactRatioRelations.ratio
  (SFT.Physics.MechanicalEvents.count reference.path)
  (SFT.Physics.MechanicalEvents.count row.incident.path)
  reference.hasTransition row.incident.hasTransition

theorem frequencyExact {m : Molecule} (row : Transition m)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) :
 SFT.Physics.MechanicalEvents.count reference.path*(frequency row reference).denominator=
 (frequency row reference).numerator*SFT.Physics.MechanicalEvents.count row.incident.path :=
 SFT.Foundation.ExactOperations.normalizedValuePreserved _ _ reference.hasTransition row.incident.hasTransition

def pattern {m : Molecule} (spectrum : Spectrum m)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) :=
 (visible spectrum.transitions).map (fun row => (frequency row reference,row.response.value))

theorem patternComplete {m : Molecule} (spectrum : Spectrum m)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) (pair : SFT.Foundation.ExactOperations.PositiveFraction×Nat) :
 pair∈pattern spectrum reference ↔ ∃ row∈spectrum.transitions,
 row.before.interaction≠row.after.interaction ∧ (frequency row reference,row.response.value)=pair := by
 constructor
 · intro held
   obtain ⟨row,member,equal⟩ := memMapPreimage _ _ _ held
   have h := (visibleExactly _ row).mp member
   exact ⟨row,h.1,h.2,equal⟩
 · intro ⟨row,held,changed,equal⟩
   exact equal ▸ memMap _ _ _ ((visibleExactly _ row).mpr ⟨held,changed⟩)

def append {m : Molecule} (spectrum : Spectrum m) (state : State m)
 (added : List (Transition m))
 (ends : ∀ row∈added, row.before∈spectrum.states++[state] ∧ row.after∈spectrum.states++[state]) : Spectrum m where
 states := spectrum.states++[state]
 transitions := spectrum.transitions++added
 endpoints := by
  intro row held
  cases memAppendCases row spectrum.transitions added held with
  | inl old => exact ⟨memAppendLeft _ _ _ (spectrum.endpoints row old).1,
    memAppendLeft _ _ _ (spectrum.endpoints row old).2⟩
  | inr new => exact ends row new
 method := spectrum.method
 conditions := spectrum.conditions

theorem visibleAppend {m : Molecule} (before added : List (Transition m)) :
 visible (before++added)=visible before++visible added := filterAppendExact _ _ _

theorem noncoupledAppend {m : Molecule} (before added : List (Transition m)) :
 noncoupled (before++added)=noncoupled before++noncoupled added := filterAppendExact _ _ _

theorem appendPattern {m : Molecule} (spectrum : Spectrum m) (state : State m)
 (added : List (Transition m))
 (ends : ∀ row∈added, row.before∈spectrum.states++[state] ∧ row.after∈spectrum.states++[state])
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) :
 pattern (append spectrum state added ends) reference=pattern spectrum reference++
 (visible added).map (fun row => (frequency row reference,row.response.value)) := by
 unfold pattern
 change (visible (spectrum.transitions++added)).map _ = _
 rw [visibleAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend]

theorem priorTransitionRetained {m : Molecule} (before added : List (Transition m))
 (row : Transition m) (held : row∈before) : row∈before++added := memAppendLeft _ _ _ held

theorem priorNoncoupledRetained {m : Molecule} (before added : List (Transition m))
 (row : Transition m) (held : row∈noncoupled before) : row∈noncoupled (before++added) := by
 rw [noncoupledAppend]
 exact memAppendLeft _ _ _ held

theorem allNewCoupledRetained {m : Molecule} (before added : List (Transition m))
 (row : Transition m) (held : row∈added) (changed : row.before.interaction≠row.after.interaction) :
 row∈visible (before++added) :=
 (visibleExactly _ row).mpr ⟨memAppendRight _ _ _ held,changed⟩

def base {m : Molecule} (row : Transition m) (method : HeldLabel) (conditions : Value) : Spectrum m where
 states := [row.before,row.after]
 transitions := [row]
 endpoints := by
  intro r held
  cases held with
  | head => exact ⟨.head _,.tail _ (.head _)⟩
  | tail _ impossible => cases impossible
 method := method
 conditions := conditions

theorem firstCoupledLine {m : Molecule} (row : Transition m) (method : HeldLabel) (conditions : Value)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value)
 (changed : row.before.interaction≠row.after.interaction) :
 pattern (base row method conditions) reference=[(frequency row reference,row.response.value)] := by
 unfold pattern visible base
 rw [List.filter_cons_of_pos ((coupledExactly row).mpr changed)]
 rfl

def signature {m : Molecule} (spectrum : Spectrum m)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) :=
 (pattern spectrum reference).map (fun p => (p.1.numerator,p.1.denominator,p.2))

def samePattern {m n : Molecule} (left : Spectrum m) (right : Spectrum n)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) : Bool :=
 decide (signature left reference=signature right reference)

theorem wholePatternExactly {m n : Molecule} (left : Spectrum m) (right : Spectrum n)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) :
 samePattern left right reference=true ↔ signature left reference=signature right reference :=
 ⟨of_decide_eq_true,decide_eq_true⟩

theorem recurrenceReturns {m : Molecule} (state : State m) :
 state.internalRecurrence.last.carrier=state.internalRecurrence.first.carrier :=
 state.internalRecurrence.returnsToCarrier

theorem decisionTraceComplete {m : Molecule} (spectrum : Spectrum m) (row : Transition m)
 (held : row∈spectrum.transitions) : (row,coupled row)∈decisionTrace spectrum := memMap _ _ _ held

theorem appendBoundary {m : Molecule} (spectrum : Spectrum m) (state : State m)
 (added : List (Transition m))
 (ends : ∀ row∈added, row.before∈spectrum.states++[state] ∧ row.after∈spectrum.states++[state]) :
 (append spectrum state added ends).method=spectrum.method ∧
 (append spectrum state added ends).conditions=spectrum.conditions := ⟨rfl,rfl⟩

end SFT.Chemistry.Infrared

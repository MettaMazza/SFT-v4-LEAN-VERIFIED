import SFT.Chemistry.ChemicalEquilibrium
import SFT.Chemistry.ChemicalPhase
import SFT.Chemistry.SolutionSupport
namespace SFT.Chemistry.SolutionEquilibrium
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
structure Raw where
 dissolvedEvents : PositiveCount
 returnedEvents : PositiveCount
 solutionBoundary : HeldLabel

def admit (r : Raw) : Except String Raw :=
 if SFT.Host.Text.equal r.solutionBoundary.family "solution-boundary" then .ok r
 else .error "solution boundary is invalid"

structure Organization where
 solution : SolutionSupport.Record
 valid : SolutionSupport.admitted solution=true
 phase : ChemicalPhase.Record
 phaseBinding : solution.phase=phase.raw.identity
 sourceRecord : SFT.Host.Canonical.Value

structure Record where
 raw : Raw
 accepted : admit raw=.ok raw
 organization : Organization
 recurrence : ChemicalEquilibrium.Recurrence
 dissolutionCount : raw.dissolvedEvents=recurrence.raw.forwardEvents
 returnCount : raw.returnedEvents=recurrence.raw.reverseEvents
 sameBoundary : raw.solutionBoundary=recurrence.boundary
 phaseConditions : recurrence.conditions=SFT.Host.Canonical.Value.array
  [.text organization.phase.boundary.temperature.label,.text organization.phase.boundary.pressure.label,
   .text organization.phase.raw.identity]
 capacitySupport : List HeldLabel
 dissolvedTest : String → HeldLabel → Bool
 saturation : ChemicalEquilibrium.stateCount dissolvedTest recurrence.beforeState=capacitySupport.length

theorem solventAndSoluteRetained (r : Record) :
 (∃ row∈r.organization.solution.rows, row.role=SolutionSupport.Role.solvent) ∧
 (∃ row∈r.organization.solution.rows, row.role=SolutionSupport.Role.solute) := by
 have h := (SolutionSupport.admittedExactly _).mp r.organization.valid
 exact ⟨(SolutionSupport.hasRoleExactly _ _).mp h.2.2.2.1,
 (SolutionSupport.hasRoleExactly _ _).mp h.2.2.2.2⟩

theorem everyComponentInHeldPhase (r : Record) (row : SolutionSupport.Row)
 (held : row∈r.organization.solution.rows) : row.phase=r.organization.phase.raw.identity :=
 (SolutionSupport.sourcePhaseRetained _ r.organization.valid row held).trans r.organization.phaseBinding

def capacity (r : Record) := r.capacitySupport.length

theorem bothPathsRemainActive (r : Record) :
 0<r.raw.dissolvedEvents.value ∧ 0<r.raw.returnedEvents.value :=
 ⟨r.raw.dissolvedEvents.positive,r.raw.returnedEvents.positive⟩

theorem dissolutionReturnBalance (r : Record) : r.raw.dissolvedEvents.value=r.raw.returnedEvents.value := by
 rw [r.dissolutionCount,r.returnCount]
 exact ChemicalEquilibrium.completePairedCounts _

theorem equalRatesAtSaturation (r : Record) (clock : PositiveCount) :
 SFT.Mathematics.ExactRatioRelations.ratio r.raw.dissolvedEvents.value clock.value r.raw.dissolvedEvents.positive clock.positive=
 SFT.Mathematics.ExactRatioRelations.ratio r.raw.returnedEvents.value clock.value r.raw.returnedEvents.positive clock.positive := by
 rw [r.dissolutionCount,r.returnCount]
 exact ChemicalEquilibrium.pairedRatesEqual _ _

theorem dissolvedCompositionRecurs (r : Record) :
 r.recurrence.raw.composition=r.recurrence.compositionClass
  (ChemicalEquilibrium.compositionSignature r.recurrence.tests r.recurrence.afterState) :=
 ChemicalEquilibrium.retainedCompositionClass _

theorem completeDissolvedCountRecurs (r : Record) :
 ChemicalEquilibrium.stateCount r.dissolvedTest r.recurrence.beforeState=
 ChemicalEquilibrium.stateCount r.dissolvedTest r.recurrence.afterState :=
 ChemicalEquilibrium.closedStateRecurs _ _ _ r.recurrence.closedAccounting _

theorem finiteSaturationRetained (r : Record) :
 ChemicalEquilibrium.stateCount r.dissolvedTest r.recurrence.afterState=capacity r :=
 (completeDissolvedCountRecurs r).symm.trans r.saturation

theorem noPostRecurrenceExcess (r : Record)
 (excess : capacity r<ChemicalEquilibrium.stateCount r.dissolvedTest r.recurrence.afterState) : False := by
 rw [finiteSaturationRetained] at excess
 exact Nat.lt_irrefl _ excess

def sourceRecord (r : Record) :=
 (r.raw,r.organization.solution,r.organization.phase.raw,
  r.organization.phase.boundary.temperature,r.organization.phase.boundary.pressure,
  r.organization.sourceRecord,r.capacitySupport,
  ChemicalEquilibrium.history (r.recurrence.first::r.recurrence.rest))

theorem allOpposedCarrierChangesPair (r : Record) (test : String → HeldLabel → Bool) :
 ChemicalEquilibrium.departing test (ChemicalEquilibrium.completeTransfers (r.recurrence.first::r.recurrence.rest))=
 ChemicalEquilibrium.arriving test (ChemicalEquilibrium.completeTransfers (r.recurrence.first::r.recurrence.rest)) :=
 ChemicalEquilibrium.everyFiniteRecurrenceNoDrift _ _

theorem base (pair : ChemicalEquilibrium.Pair) :
 ChemicalEquilibrium.history [pair]=[(pair.forward.trace,pair.backward.trace)] :=
 ChemicalEquilibrium.baseTrace _

theorem successorRetainsEveryPair (r : Record) (next : ChemicalEquilibrium.Pair) :
 ChemicalEquilibrium.history ((r.recurrence.first::r.recurrence.rest)++[next])=
 ChemicalEquilibrium.history (r.recurrence.first::r.recurrence.rest)++[(next.forward.trace,next.backward.trace)] :=
 ChemicalEquilibrium.successorTrace _ _

theorem successorBalance (r : Record) (next : ChemicalEquilibrium.Pair) (test : String → HeldLabel → Bool) :
 ChemicalEquilibrium.departing test (ChemicalEquilibrium.completeTransfers ((r.recurrence.first::r.recurrence.rest)++[next]))=
 ChemicalEquilibrium.arriving test (ChemicalEquilibrium.completeTransfers ((r.recurrence.first::r.recurrence.rest)++[next])) :=
 ChemicalEquilibrium.successorNoDrift _ _ _

theorem successorDissolvedClass (r : Record) (next : ChemicalEquilibrium.Pair)
 (after : List (String × HeldLabel))
 (accounting : ∀ test, ChemicalEquilibrium.stateCount test r.recurrence.beforeState+
  ChemicalEquilibrium.arriving test (ChemicalEquilibrium.completeTransfers ((r.recurrence.first::r.recurrence.rest)++[next]))=
  ChemicalEquilibrium.stateCount test after+
  ChemicalEquilibrium.departing test (ChemicalEquilibrium.completeTransfers ((r.recurrence.first::r.recurrence.rest)++[next]))) :
 r.recurrence.compositionClass (ChemicalEquilibrium.compositionSignature r.recurrence.tests r.recurrence.beforeState)=
 r.recurrence.compositionClass (ChemicalEquilibrium.compositionSignature r.recurrence.tests after) :=
 ChemicalEquilibrium.successorStateClass _ _ _ _ accounting _ _

theorem successorSaturation (r : Record) (next : ChemicalEquilibrium.Pair)
 (after : List (String × HeldLabel))
 (accounting : ∀ test, ChemicalEquilibrium.stateCount test r.recurrence.beforeState+
  ChemicalEquilibrium.arriving test (ChemicalEquilibrium.completeTransfers ((r.recurrence.first::r.recurrence.rest)++[next]))=
  ChemicalEquilibrium.stateCount test after+
  ChemicalEquilibrium.departing test (ChemicalEquilibrium.completeTransfers ((r.recurrence.first::r.recurrence.rest)++[next]))) :
 ChemicalEquilibrium.stateCount r.dissolvedTest after=capacity r :=
 (ChemicalEquilibrium.closedStateRecurs _ _ _ accounting _).symm.trans r.saturation

def originalRaw : Raw := ⟨⟨2,by decide⟩,⟨2,by decide⟩,⟨"solution-boundary","vessel-one",rfl,rfl⟩⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl
end SFT.Chemistry.SolutionEquilibrium

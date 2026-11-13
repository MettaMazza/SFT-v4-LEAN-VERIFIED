import SFT.Physics.WaveDispersion
import SFT.Physics.CollectivePhaseOrder
namespace SFT.Materials.OpticalDelay
open SFT.Physics SFT.Mathematics.FoldScalar

structure Record (Support State Clock : Type) where
 excitation : ThermoTemperature.Macrostate
 probe : WaveDispersion.Response Support State Clock String
 material : WaveDispersion.Response Support State Clock String
 coherentCycle : material.spatial.wave.cycle = probe.spatial.wave.cycle
 clock : MechanicalDuration.Recurrence Clock
 accessibleEvents : ∀ e, e ∈ MechanicalEvents.events (FieldLocality.trace material.arrival.propagation) → e.carrier ∈ excitation.members
 losses : MechanicalConservation.Network String Scalar
 spectralConditions : SFT.Host.Canonical.Value

variable {Support State Clock : Type}

def timeScalar : MechanicalDuration.Duration → Scalar
 | .emptyOne => .emptyOne
 | .positive x => .positive .forward x

def timing (r : Record Support State Clock) (response : WaveDispersion.Response Support State Clock String) :=
 timeScalar (MechanicalDuration.elapsed (FieldLocality.trace response.arrival.propagation) r.clock)

def delay (r : Record Support State Clock) := subtract (timing r r.material) (timing r r.probe)

def phaseChange (r : Record Support State Clock) :=
 subtract (MechanicalAngularMotion.phase r.material.phase) (MechanicalAngularMotion.phase r.probe.phase)

theorem commonPhaseCycle (r : Record Support State Clock) :
 r.material.spatial.wave.cycle = r.probe.spatial.wave.cycle := r.coherentCycle

theorem exactPositiveTiming (r : Record Support State Clock)
 (response : WaveDispersion.Response Support State Clock String)
 (present : 0 < MechanicalEvents.count (FieldLocality.trace response.arrival.propagation)) :
 timing r response = .positive .forward
 (MechanicalDuration.positiveRatio (FieldLocality.trace response.arrival.propagation) r.clock present) := by
 unfold timing
 rw [MechanicalDuration.presentIsPositive _ _ present]
 rfl

theorem actualAdjacentPropagation (r : Record Support State Clock) :
 ∀ row ∈ MechanicalEvents.changes (FieldLocality.trace r.material.arrival.propagation),
 r.material.adjacent row.before row.after := WaveDispersion.responseIsCausal r.material

theorem wholeMaterialPhase (r : Record Support State Clock) :
 MechanicalEvents.changes r.material.phase.initialPath ++ MechanicalEvents.changes r.material.phase.remainingPath =
 MechanicalEvents.changes r.material.spatial.wave.cycle.recurrence.path :=
 WaveDispersion.phaseRetainsWholeRecurrence r.material

theorem excitationClassHeld (r : Record Support State Clock) (e : MechanicalEvents.Event String)
 (held : e ∈ MechanicalEvents.events (FieldLocality.trace r.material.arrival.propagation)) :
 SFT.Mathematics.GeometryTopology.image r.excitation.observation e.carrier = some r.excitation.label := by
 have h := r.accessibleEvents e held
 have fibre := ThermoEntropy.exactHeldFibre r.excitation
 change r.excitation.members = SFT.Mathematics.ProbabilityObservations.fibre r.excitation.support r.excitation.observation r.excitation.label at fibre
 rw [fibre] at h
 exact ((SFT.Mathematics.ProbabilityObservations.fibreMembership _ _ _ _).mp h).2

theorem lossLedgerConserved (r : Record Support State Clock) :
 MechanicalConservation.outgoingSupport r.losses = MechanicalConservation.incomingSupport r.losses :=
 MechanicalConservation.completeConservation r.losses

theorem completeDispersionRelation (r : Record Support State Clock) :
 WaveSpeedRelation.speed r.material.spatial =
 SFT.Mathematics.ExactRatioRelations.compose (WaveSpeedRelation.wavelength r.material.spatial)
 (WavePeriodFrequency.frequency r.material.spatial.wave) := rfl

def record (r : Record Support State Clock) :=
 (r,phaseChange r,delay r,WavePeriodFrequency.frequency r.material.spatial.wave,
 WaveSpeedRelation.speed r.material.spatial,r.losses)

theorem separateLossRecord (r : Record Support State Clock) : (record r).2.2.2.2.2 = r.losses := rfl

theorem completeInputRetained (r : Record Support State Clock) : (record r).1 = r := rfl

def records (rs : List (Record Support State Clock)) := rs.map record

theorem base (r : Record Support State Clock) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Support State Clock)) (r : Record Support State Clock) :
 records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.OpticalDelay

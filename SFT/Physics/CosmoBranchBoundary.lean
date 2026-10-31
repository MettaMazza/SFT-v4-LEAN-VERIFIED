import SFT.Physics.CosmoStructureGrowth
namespace SFT.Physics.CosmoBranchBoundary

-- cosmological_boundary_laws.py:BRANCH_BOUNDARY. These are the three
-- source-declared external input roles, not additional physical laws.
inductive ExternalKind where
 | objectCensus | historicalInitialState | inferredChronology

structure MeasuredInputs where
 objectCensus : List String
 historicalInitialState : List String
 inferredChronology : List String

def externalRows (inputs : MeasuredInputs) : ExternalKind → List String
 | .objectCensus => inputs.objectCensus
 | .historicalInitialState => inputs.historicalInitialState
 | .inferredChronology => inputs.inferredChronology

structure PhysicsRelations (Emission Observation SourceClock ObserverClock Cell Carrier : Type) where
 evolution : CosmoStructureGrowth.Evolution
 observations : List (CosmoRedshift.Record Emission Observation SourceClock ObserverClock Cell Carrier)

structure Handoff (Emission Observation SourceClock ObserverClock Cell Carrier : Type) where
 physics : PhysicsRelations Emission Observation SourceClock ObserverClock Cell Carrier
 measured : MeasuredInputs

variable {Emission Observation SourceClock ObserverClock Cell Carrier : Type}
local notation "Transfer" => Handoff Emission Observation SourceClock ObserverClock Cell Carrier

def replaceMeasured (held : Transfer) (inputs : MeasuredInputs) : Transfer :=
 ⟨held.physics,inputs⟩

theorem externalInputsDoNotSelectPhysics (held : Transfer) (inputs : MeasuredInputs) :
 (replaceMeasured held inputs).physics=held.physics := rfl

theorem everyMeasuredRoleRemainsExplicit (held : Transfer) (inputs : MeasuredInputs) (kind : ExternalKind) :
 externalRows (replaceMeasured held inputs).measured kind=externalRows inputs kind := rfl

theorem allObservationRecordsRetained (held : Transfer) (inputs : MeasuredInputs) :
 (replaceMeasured held inputs).physics.observations=held.physics.observations := rfl

theorem registeredEvolutionRetained (held : Transfer) (inputs : MeasuredInputs) :
 (replaceMeasured held inputs).physics.evolution=held.physics.evolution := rfl

theorem finiteEvolutionStillDeterministic (held : Transfer) {initial first second : String} {n : Nat}
 (a : CosmoStructureGrowth.History held.physics.evolution initial n first)
 (b : CosmoStructureGrowth.History held.physics.evolution initial n second) :
 first=second ∧ CosmoStructureGrowth.states a=CosmoStructureGrowth.states b :=
 CosmoStructureGrowth.finiteHistoryDeterministic a b

theorem sourcePathAndClockSupportRetained
 (held : Transfer) (inputs : MeasuredInputs) :
 ((replaceMeasured held inputs).physics.observations.map CosmoDistance.supportAndClocks)=
 (held.physics.observations.map CosmoDistance.supportAndClocks) := rfl

end SFT.Physics.CosmoBranchBoundary

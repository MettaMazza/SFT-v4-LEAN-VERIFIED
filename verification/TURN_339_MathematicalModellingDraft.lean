import SFT.Mathematics.DiscreteRelations
import SFT.Mathematics.GeometryTopology
import SFT.Engine.RegistrationGate
import SFT.Foundation.MeasurementProtocol
namespace SFT.Computation.MathematicalModelling
open SFT.Mathematics.DiscreteObjects

structure Model where
  registration : SFT.Engine.ClaimRegistration
  dependencyReceipts : String → Bool
  executedManifest : Option String
  admitted : SFT.Engine.registrationViolations dependencyReceipts registration executedManifest = []

theorem noDeclaredAxioms (model : Model) : model.registration.axioms = [] :=
  SFT.Engine.passingRegistrationHasNoAxioms _ _ _ model.admitted

theorem noFreeParameters (model : Model) : model.registration.freeParameters = [] :=
  SFT.Engine.passingRegistrationHasNoFreeParameters _ _ _ model.admitted

theorem dependencyClosure (model : Model) :
    SFT.Engine.missingDependencies model.dependencyReceipts model.registration = [] :=
  SFT.Engine.passingRegistrationNoMissingDependencies _ _ _ model.admitted

structure ComparisonProtocol where
  targetBeforeSeal : Bool
  measurementChangesLaw : Bool
  allRows : Bool
  sourceIdentified : Bool
  admitted : SFT.Foundation.MeasurementProtocol.accepts targetBeforeSeal measurementChangesLaw allRows sourceIdentified = true

theorem sealedComparisonBoundary (protocol : ComparisonProtocol) :
    protocol.targetBeforeSeal = false ∧ protocol.measurementChangesLaw = false ∧
    protocol.allRows = true ∧ protocol.sourceIdentified = true :=
  (SFT.Foundation.MeasurementProtocol.acceptanceIff _ _ _ _).mp protocol.admitted

-- Retain the source protocol's full canonical-value domain and returned operand.
def comparisonRecord (pre mutation rows source : SFT.Host.Canonical.Value) :
    SFT.Host.Canonical.Value :=
  SFT.Foundation.MeasurementProtocol.acceptsValue pre mutation rows source

theorem comparisonExpression (pre mutation rows source : SFT.Host.Canonical.Value) :
    comparisonRecord pre mutation rows source =
      SFT.Foundation.MeasurementProtocol.andValue
        (SFT.Foundation.MeasurementProtocol.andValue
          (SFT.Foundation.MeasurementProtocol.andValue
            (.boolean (!SFT.Foundation.MeasurementProtocol.truthy pre))
            (.boolean (!SFT.Foundation.MeasurementProtocol.truthy mutation))) rows) source :=
  SFT.Foundation.MeasurementProtocol.sourceExpression pre mutation rows source

theorem comparisonPreservesSource (pre mutation rows source : SFT.Host.Canonical.Value)
    (hp : SFT.Foundation.MeasurementProtocol.truthy pre = false)
    (hm : SFT.Foundation.MeasurementProtocol.truthy mutation = false)
    (hr : SFT.Foundation.MeasurementProtocol.truthy rows = true) :
    comparisonRecord pre mutation rows source = source :=
  SFT.Foundation.MeasurementProtocol.sourceOperandReturned pre mutation rows source hp hm hr

theorem comparisonRejectsMutation (pre mutation rows source : SFT.Host.Canonical.Value)
    (hm : SFT.Foundation.MeasurementProtocol.truthy mutation = true) :
    comparisonRecord pre mutation rows source = .boolean false :=
  SFT.Foundation.MeasurementProtocol.mutationOperandRejected pre mutation rows source hm

-- Exact state/order and identity-set guards of engine/empirical.py.
structure PredictionSeal where
  experimentId : String
  predictionHash : String
  traceHash : String
  envelopeHash : String
  sealHash : String
  deriving Repr

def assembleSeal (experiment prediction trace envelope : String) : PredictionSeal :=
  ⟨experiment, prediction, trace, envelope,
    SFT.Host.Canonical.identity (.object [
      ("experiment_id", .text experiment), ("prediction_hash", .text prediction),
      ("trace_hash", .text trace), ("envelope_hash", .text envelope)])⟩

def sealPrediction (existing : Option PredictionSeal) (fresh : PredictionSeal) :
    Except String PredictionSeal :=
  match existing with
  | some _ => .error "prediction is already sealed and cannot be replaced"
  | none => .ok fresh

theorem unsealedAccepts (fresh : PredictionSeal) :
    sealPrediction none fresh = .ok fresh := rfl

theorem resealRejected (old fresh : PredictionSeal) :
    sealPrediction (some old) fresh =
      .error "prediction is already sealed and cannot be replaced" := rfl

def identitiesMatch (supplied registered : List String) : Bool :=
  supplied.all (SFT.Mathematics.DiscreteObjects.has registered) &&
  registered.all (SFT.Mathematics.DiscreteObjects.has supplied)

theorem identitiesExactly (supplied registered : List String) :
    identitiesMatch supplied registered = true ↔ ∀ name, name ∈ supplied ↔ name ∈ registered := by
  constructor
  · intro accepted name
    have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp accepted
    exact ⟨fun member => (hasIff _ _).mp ((allTrueIffMembers _ _).mp both.1 name member),
      fun member => (hasIff _ _).mp ((allTrueIffMembers _ _).mp both.2 name member)⟩
  · intro equal
    apply (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
    exact ⟨(allTrueIffMembers _ _).mpr (fun name member => (hasIff _ _).mpr ((equal name).mp member)),
      (allTrueIffMembers _ _).mpr (fun name member => (hasIff _ _).mpr ((equal name).mpr member))⟩

def measurementContext (savedSeal : Option PredictionSeal) (registered supplied : List String)
    (material : SFT.Host.Canonical.Value) : Except String (PredictionSeal × SFT.Host.Canonical.Value) :=
  match savedSeal with
  | none => .error "target material cannot be opened before prediction seal"
  | some sealed => if identitiesMatch supplied registered then .ok (sealed, material)
      else .error "post-seal target identities do not match the registration"

theorem preSealTargetRejected (registered supplied : List String) (material : SFT.Host.Canonical.Value) :
    measurementContext none registered supplied material =
      .error "target material cannot be opened before prediction seal" := rfl

theorem registeredTargetPreserved (sealed : PredictionSeal) (registered supplied : List String)
    (material : SFT.Host.Canonical.Value) (h : identitiesMatch supplied registered = true) :
    measurementContext (some sealed) registered supplied material = .ok (sealed, material) := by
  unfold measurementContext
  rw [h]
  rfl

theorem unregisteredTargetRejected (sealed : PredictionSeal) (registered supplied : List String)
    (material : SFT.Host.Canonical.Value) (h : identitiesMatch supplied registered = false) :
    measurementContext (some sealed) registered supplied material =
      .error "post-seal target identities do not match the registration" := by
  unfold measurementContext
  rw [h]
  rfl

-- The source obtains supplied identities from the mapping keys.
def openTargets (savedSeal : Option PredictionSeal) (registered : List String)
    (material : List (String × SFT.Host.Canonical.Value)) :=
  measurementContext savedSeal registered (material.map Prod.fst) (.object material)

theorem exactTargetOpening (sealed : PredictionSeal) (registered : List String)
    (material : List (String × SFT.Host.Canonical.Value))
    (h : ∀ name, name ∈ material.map Prod.fst ↔ name ∈ registered) :
    openTargets (some sealed) registered material = .ok (sealed, .object material) :=
  registeredTargetPreserved sealed registered _ _ ((identitiesExactly _ _).mpr h)

end SFT.Computation.MathematicalModelling

import SFT.Mathematics.DiscreteRelations
import SFT.Mathematics.GeometryTopology
import SFT.Computation.InverseProblem
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

theorem classifiedProvenance (model : Model) : model.registration.provenance.isEmpty = false :=
  SFT.Engine.collectEmptyHeadFalse _ _ _
    (SFT.Engine.collectEmptyTail _ _ _ (SFT.Engine.collectEmptyTail _ _ _
      (SFT.Engine.collectEmptyTail _ _ _ (SFT.Engine.collectEmptyTail _ _ _
        (SFT.Engine.passingRegistrationCore _ _ _ model.admitted)))))

-- Finite formal/observational carriers use the original generated relation;
-- no totality or uniqueness condition is added to the model relation.
structure Correspondence where
  registration : Model
  phenomenon : String
  relation : SFT.Computation.InverseProblem.Model

structure Comparison (model : Correspondence) where
  formal : Form
  observed : Form
  formalHeld : formal ∈ model.relation.sources
  observedHeld : observed ∈ model.relation.observations
  protocol : ComparisonProtocol

def comparisonAgrees (model : Correspondence) (row : Comparison model) : Bool :=
  has model.relation.forward (row.formal,row.observed)

theorem comparisonAgreementExactly (model : Correspondence) (row : Comparison model) :
    comparisonAgrees model row = true ↔ (row.formal,row.observed) ∈ model.relation.forward :=
  hasIff _ _

def comparisonLedger (model : Correspondence) (rows : List (Comparison model)) :
    List ((Form × Form) × Bool) :=
  rows.map (fun row => ((row.formal,row.observed),comparisonAgrees model row))

theorem allComparisonRowsRetained (model : Correspondence) (rows : List (Comparison model)) :
    (comparisonLedger model rows).length = rows.length :=
  SFT.Foundation.CommonRefinement.mapLength _ _

theorem comparisonLedgerComposition (model : Correspondence) (left right : List (Comparison model)) :
    comparisonLedger model (left ++ right) = comparisonLedger model left ++ comparisonLedger model right := by
  induction left with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons ((row.formal,row.observed),comparisonAgrees model row)) ih

theorem comparisonLedgerSuccessor (model : Correspondence) (rows : List (Comparison model))
    (row : Comparison model) :
    comparisonLedger model (rows ++ [row]) = comparisonLedger model rows ++
      [((row.formal,row.observed),comparisonAgrees model row)] :=
  comparisonLedgerComposition _ _ _

def falsifyingRows (model : Correspondence) (rows : List (Comparison model)) : List (Comparison model) :=
  rows.filter (fun row => !comparisonAgrees model row)

theorem falsificationExactly (model : Correspondence) (rows : List (Comparison model))
    (row : Comparison model) : row ∈ falsifyingRows model rows ↔
      row ∈ rows ∧ comparisonAgrees model row = false := by
  constructor
  · intro h
    have pair := (filterMemberIff _ _ _).mp h
    refine ⟨pair.1, ?_⟩
    cases e : comparisonAgrees model row with
    | false => rfl
    | true => rw [e] at pair; cases pair.2
  · intro h
    apply (filterMemberIff _ _ _).mpr
    exact ⟨h.1, by rw [h.2]; rfl⟩

-- A revision retains the preceding comparison ledger with its original model.
-- Revising a model cannot retrospectively overwrite that recorded ledger.
structure Revision (previous next : Correspondence) where
  priorRows : List (Comparison previous)
  nextRows : List (Comparison next)

def revisionLedger (previous next : Correspondence) (revision : Revision previous next) :=
  (comparisonLedger previous revision.priorRows, comparisonLedger next revision.nextRows)

theorem revisionPreservesPrior (previous next : Correspondence) (revision : Revision previous next) :
    (revisionLedger previous next revision).1 = comparisonLedger previous revision.priorRows := rfl

theorem relationEndpoints (model : Correspondence) (formal observed : Form)
    (h : (formal,observed) ∈ model.relation.forward) :
    formal ∈ model.relation.sources ∧ observed ∈ model.relation.observations :=
  generatedRelationContained _ _ _ _ model.relation.relationAdmission _ h

inductive OperationTrace (model : Correspondence) : Form → Relation → Form → Prop where
  | identity (form : Form) : OperationTrace model form [] form
  | step (first middle last : Form) (rest : Relation)
      (registered : (first,middle) ∈ model.relation.forward)
      (tail : OperationTrace model middle rest last) :
      OperationTrace model first ((first,middle)::rest) last

def replayOperations (model : Correspondence) (initial : Form) : Relation → Option Form
  | [] => some initial
  | (first,next)::rest =>
      if has [initial] first && has model.relation.forward (first,next)
      then replayOperations model next rest else none

theorem traceReplay (model : Correspondence) (initial terminal : Form) (rows : Relation)
    (trace : OperationTrace model initial rows terminal) :
    replayOperations model initial rows = some terminal := by
  induction trace with
  | identity => rfl
  | step first middle last rest registered tail ih =>
    unfold replayOperations
    have a := (hasIff [first] first).mpr (List.Mem.head [])
    have b := (hasIff model.relation.forward (first,middle)).mpr registered
    rw [a,b]
    exact ih

theorem traceReconstruction (model : Correspondence) (initial terminal : Form) (rows : Relation)
    (accepted : replayOperations model initial rows = some terminal) :
    OperationTrace model initial rows terminal := by
  induction rows generalizing initial with
  | nil => cases accepted; exact .identity _
  | cons row rest ih =>
    obtain ⟨first,next⟩ := row
    unfold replayOperations at accepted
    split at accepted
    · rename_i guard
      have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp guard
      have member := (hasIff [initial] first).mp both.1
      have eq : first = initial := by
        cases member with
        | head => rfl
        | tail _ impossible => cases impossible
      cases eq
      exact .step _ _ _ _ ((hasIff _ _).mp both.2) (ih _ accepted)
    · cases accepted

theorem traceComposition (model : Correspondence) (first middle last : Form) (left right : Relation)
    (a : OperationTrace model first left middle) (b : OperationTrace model middle right last) :
    OperationTrace model first (left ++ right) last := by
  induction a with
  | identity => exact b
  | step first middle terminal rest registered tail ih => exact .step _ _ _ _ registered (ih b)

theorem traceSuccessor (model : Correspondence) (first terminal next : Form) (rows : Relation)
    (trace : OperationTrace model first rows terminal)
    (registered : (terminal,next) ∈ model.relation.forward) :
    OperationTrace model first (rows ++ [(terminal,next)]) next :=
  traceComposition _ _ _ _ _ _ trace (.step _ _ _ _ registered (.identity _))

theorem traceRowsRegistered (model : Correspondence) (initial terminal : Form) (rows : Relation)
    (trace : OperationTrace model initial rows terminal) :
    ∀ row, row ∈ rows → row ∈ model.relation.forward := by
  induction trace with
  | identity => intro row member; cases member
  | step first middle last rest registered tail ih =>
    intro row member
    cases member with
    | head => exact registered
    | tail _ member => exact ih row member

def executeOperations (model : Correspondence) (initial : Form) (rows : Relation) : Option Form :=
  if has model.relation.sources initial then replayOperations model initial rows else none

theorem executionExactly (model : Correspondence) (initial terminal : Form) (rows : Relation) :
    executeOperations model initial rows = some terminal ↔
      initial ∈ model.relation.sources ∧ OperationTrace model initial rows terminal := by
  constructor
  · intro accepted
    unfold executeOperations at accepted
    split at accepted
    · rename_i held
      exact ⟨(hasIff _ _).mp held,traceReconstruction _ _ _ _ accepted⟩
    · cases accepted
  · intro accepted
    unfold executeOperations
    rw [(hasIff _ _).mpr accepted.1]
    exact traceReplay _ _ _ _ accepted.2

theorem identityExecution (model : Correspondence) (initial : Form)
    (held : initial ∈ model.relation.sources) : executeOperations model initial [] = some initial :=
  (executionExactly _ _ _ _).mpr ⟨held,.identity _⟩

theorem traceExtension (original extended : Correspondence)
    (retained : ∀ row, row ∈ original.relation.forward → row ∈ extended.relation.forward)
    (initial terminal : Form) (rows : Relation)
    (trace : OperationTrace original initial rows terminal) :
    OperationTrace extended initial rows terminal := by
  induction trace with
  | identity => exact .identity _
  | step first middle last rest registered tail ih => exact .step _ _ _ _ (retained _ registered) ih

theorem executionExtension (original extended : Correspondence)
    (sources : ∀ form, form ∈ original.relation.sources → form ∈ extended.relation.sources)
    (relations : ∀ row, row ∈ original.relation.forward → row ∈ extended.relation.forward)
    (initial terminal : Form) (rows : Relation)
    (accepted : executeOperations original initial rows = some terminal) :
    executeOperations extended initial rows = some terminal := by
  have prior := (executionExactly _ _ _ _).mp accepted
  exact (executionExactly _ _ _ _).mpr
    ⟨sources _ prior.1, traceExtension _ _ relations _ _ _ prior.2⟩

end SFT.Computation.MathematicalModelling

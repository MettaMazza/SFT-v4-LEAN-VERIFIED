import SFT.Computation.ExactApproximate
import SFT.Computation.SearchPlanning
namespace SFT.Computation.Stability
open StateTransition NumericalError
open SFT.InformationScience.EncodingMaps
open SFT.Mathematics.DiscreteObjects

structure Perturbation where
  referenceStart : String
  changedStart : String
  referenceActions : List String
  changedActions : List String
  deriving DecidableEq

structure Observation where
  referenceTrace : List String
  changedTrace : List String
  inputLedger : List NumericalError.Row
  outputLedger : List NumericalError.Row

def differences (table : List (String × List Number)) (left right : String) : Option (List NumericalError.Row) :=
  match lookupFirst table left,lookupFirst table right with
  | some a,some b => match exactErrorLedger a b with
    | .ok rows => some rows
    | .error _ => none
  | none,none | none,some _ | some _,none => none

def observe (system : System) (table : List (String × List Number))
    (registered : List Perturbation) (request : Perturbation) : Option Observation :=
  if !has registered request then none
  else match run system request.referenceStart request.referenceActions with
  | .error _ => none
  | .ok first => match run system request.changedStart request.changedActions with
    | .error _ => none
    | .ok second =>
      match differences table request.referenceStart request.changedStart,
          differences table (SearchPlanning.terminal request.referenceStart first)
            (SearchPlanning.terminal request.changedStart second) with
      | some inputs,some outputs => some ⟨first,second,inputs,outputs⟩
      | none,none | none,some _ | some _,none => none

theorem unregisteredRejected (system : System) (table : List (String × List Number))
    (registered : List Perturbation) (request : Perturbation) (h : has registered request = false) :
    observe system table registered request = none := by
  unfold observe
  rw [h]
  rfl

theorem exactDifferences (table : List (String × List Number)) (left right : String)
    (a b : List Number) (rows : List NumericalError.Row)
    (ha : lookupFirst table left = some a) (hb : lookupFirst table right = some b)
    (compared : exactErrorLedger a b = .ok rows) : differences table left right = some rows := by
  unfold differences
  rw [ha,hb]
  dsimp only
  rw [compared]

theorem exactObservation (system : System) (table : List (String × List Number))
    (registered : List Perturbation) (request : Perturbation) (first second : List String)
    (inputs outputs : List NumericalError.Row) (admitted : has registered request = true)
    (referenceRun : run system request.referenceStart request.referenceActions = .ok first)
    (changedRun : run system request.changedStart request.changedActions = .ok second)
    (input : differences table request.referenceStart request.changedStart = some inputs)
    (output : differences table (SearchPlanning.terminal request.referenceStart first)
      (SearchPlanning.terminal request.changedStart second) = some outputs) :
    observe system table registered request = some ⟨first,second,inputs,outputs⟩ := by
  unfold observe
  rw [admitted]
  rw [referenceRun]
  dsimp only
  rw [changedRun]
  dsimp only
  rw [input,output]
  rfl
theorem differenceMeaning (table : List (String × List Number)) (left right : String)
    (rows : List NumericalError.Row) : differences table left right = some rows ↔
    ∃ a b, lookupFirst table left = some a ∧ lookupFirst table right = some b ∧
      exactErrorLedger a b = .ok rows := by
  constructor
  · intro accepted
    unfold differences at accepted
    cases ha : lookupFirst table left with
    | none => rw [ha] at accepted; cases hb : lookupFirst table right <;> rw [hb] at accepted <;> cases accepted
    | some a =>
      rw [ha] at accepted
      cases hb : lookupFirst table right with
      | none => rw [hb] at accepted; cases accepted
      | some b =>
        rw [hb] at accepted
        dsimp only at accepted
        cases hc : exactErrorLedger a b with
        | error e => rw [hc] at accepted; cases accepted
        | ok actual => rw [hc] at accepted; cases accepted; exact ⟨a,b,rfl,rfl,hc⟩
  · intro h
    obtain ⟨a,b,ha,hb,hc⟩ := h
    exact exactDifferences _ _ _ _ _ _ ha hb hc

theorem observationSource (system : System) (table : List (String × List Number))
    (registered : List Perturbation) (request : Perturbation) (obs : Observation)
    (accepted : observe system table registered request = some obs) :
    has registered request = true ∧
    run system request.referenceStart request.referenceActions = .ok obs.referenceTrace ∧
    run system request.changedStart request.changedActions = .ok obs.changedTrace ∧
    differences table request.referenceStart request.changedStart = some obs.inputLedger ∧
    differences table (SearchPlanning.terminal request.referenceStart obs.referenceTrace)
      (SearchPlanning.terminal request.changedStart obs.changedTrace) = some obs.outputLedger := by
  unfold observe at accepted
  cases hr : has registered request with
  | false => rw [hr] at accepted; cases accepted
  | true =>
    rw [hr] at accepted
    cases hf : run system request.referenceStart request.referenceActions with
    | error e => rw [hf] at accepted; cases accepted
    | ok first =>
      rw [hf] at accepted
      dsimp only at accepted
      cases hg : run system request.changedStart request.changedActions with
      | error e => rw [hg] at accepted; cases accepted
      | ok second =>
        rw [hg] at accepted
        dsimp only at accepted
        cases hi : differences table request.referenceStart request.changedStart with
        | none =>
          rw [hi] at accepted
          cases ho : differences table (SearchPlanning.terminal request.referenceStart first)
            (SearchPlanning.terminal request.changedStart second) <;> rw [ho] at accepted <;> cases accepted
        | some inputs =>
          rw [hi] at accepted
          cases ho : differences table (SearchPlanning.terminal request.referenceStart first)
            (SearchPlanning.terminal request.changedStart second) with
          | none => rw [ho] at accepted; cases accepted
          | some outputs =>
            rw [ho] at accepted
            cases accepted
            exact ⟨rfl,rfl,rfl,rfl,ho⟩

abbrev LedgerForm := List (String × Nat × Nat × String)
def ledgerForm (rows : List NumericalError.Row) : LedgerForm :=
  rows.map (fun row => (row.1,row.2.1.numerator,row.2.1.denominator,row.2.2))
structure Amplification where
  inputForm : LedgerForm
  outputForm : LedgerForm
  deriving DecidableEq

def amplification (obs : Observation) : Amplification := ⟨ledgerForm obs.inputLedger,ledgerForm obs.outputLedger⟩

-- Classification is relative to the registered exact relation, without an imported epsilon or norm.
def stable (relation : List Amplification) (obs : Observation) : Bool := has relation (amplification obs)

theorem stableMeaning (relation : List Amplification) (obs : Observation) :
    stable relation obs = true ↔ amplification obs ∈ relation := hasIff _ _

theorem outsideRelationRejected (relation : List Amplification) (obs : Observation)
    (outside : amplification obs ∉ relation) : stable relation obs = false := by
  cases h : stable relation obs with
  | false => rfl
  | true => exact False.elim (outside ((stableMeaning _ _).mp h))

theorem registeredExtension (system : System) (table : List (String × List Number))
    (old extended : List Perturbation) (request : Perturbation) (obs : Observation)
    (retained : ∀ p, p ∈ old → p ∈ extended)
    (accepted : observe system table old request = some obs) :
    observe system table extended request = some obs := by
  have h := observationSource _ _ _ _ _ accepted
  have registered := (hasIff extended request).mpr (retained _ ((hasIff old request).mp h.1))
  exact exactObservation _ _ _ _ _ _ _ _ registered h.2.1 h.2.2.1 h.2.2.2.1 h.2.2.2.2

theorem classificationRetained (old extended : List Amplification) (obs : Observation)
    (retained : ∀ p, p ∈ old → p ∈ extended) (accepted : stable old obs = true) :
    stable extended obs = true :=
  (stableMeaning _ _).mpr (retained _ ((stableMeaning _ _).mp accepted))

theorem systemExtension (old extended : System) (table : List (String × List Number))
    (registered : List Perturbation) (request : Perturbation) (obs : Observation)
    (admitted : create extended.states extended.actions extended.transitions = .ok extended)
    (states : ∀ state, state ∈ old.states → state ∈ extended.states)
    (transitions : ∀ row, row ∈ old.transitions → row ∈ extended.transitions)
    (accepted : observe old table registered request = some obs) :
    observe extended table registered request = some obs := by
  have h := observationSource _ _ _ _ _ accepted
  exact exactObservation _ _ _ _ _ _ _ _ h.1
    (StateExtension.extendRun old extended admitted states transitions _ _ _ h.2.1)
    (StateExtension.extendRun old extended admitted states transitions _ _ _ h.2.2.1)
    h.2.2.2.1 h.2.2.2.2

inductive Outcome where | rejected | stable | unstable
  deriving DecidableEq

def classify (relation : List Amplification) : Option Observation → Outcome
 | none => .rejected
 | some obs => if stable relation obs then .stable else .unstable

def completeObservations (system : System) (table : List (String × List Number))
    (registered : List Perturbation) : List (Perturbation × Option Observation) :=
  registered.map (fun request => (request,observe system table registered request))

theorem perturbationRetained (system : System) (table : List (String × List Number))
    (registered : List Perturbation) (request : Perturbation) (held : request ∈ registered) :
    (request,observe system table registered request) ∈ completeObservations system table registered :=
  SFT.Foundation.Count.TraceDerivation.memMap _ request _ held

theorem stableClassification (relation : List Amplification) (obs : Observation)
    (held : amplification obs ∈ relation) : classify relation (some obs) = .stable := by
  dsimp only [classify]
  rw [(stableMeaning _ _).mpr held]
  rfl

theorem unstableClassification (relation : List Amplification) (obs : Observation)
    (outside : amplification obs ∉ relation) : classify relation (some obs) = .unstable := by
  dsimp only [classify]
  rw [outsideRelationRejected _ _ outside]
  rfl

theorem rejectedClassification (relation : List Amplification) : classify relation none = .rejected := rfl

structure Model where
  system : System
  admission : create system.states system.actions system.transitions = .ok system
  values : List (String × List Number)
  perturbations : List Perturbation
  amplificationRelation : List Amplification

def evaluate (model : Model) (request : Perturbation) : Option Observation :=
  observe model.system model.values model.perturbations request

def outcome (model : Model) (request : Perturbation) : Outcome :=
  classify model.amplificationRelation (evaluate model request)

theorem modelAdmitted (model : Model) :
    create model.system.states model.system.actions model.system.transitions = .ok model.system := model.admission

end SFT.Computation.Stability

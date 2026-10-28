import SFT.InformationScience.ClassicalLedger
namespace SFT.InformationScience.ClassicalResolution
open ClassicalLedger
open SFT.Mathematics.ProbabilityObservations
open SFT.Foundation.ExactOperations

inductive Resolution where
  | classicalState : String → Resolution
  | unresolvedClass : List String → Resolution
  deriving DecidableEq

def resolveMembers (members : List String) : Resolution :=
  match members with
  | [] => .unresolvedClass []
  | state :: rest => match rest with
    | [] => .classicalState state
    | next :: tail => .unresolvedClass (state :: next :: tail)

def resolveRows (rows : List ProbabilityRow) (observed : String) : Except String Resolution :=
  match rows.filter (fun row => row.observedLabel == observed) with
  | [] => .error "ValueError: the observed label is outside registered observation support"
  | row :: rest => match rest with
    | [] => .ok (resolveMembers row.microstates)
    | _ :: _ => .error "ValueError: the observed label is outside registered observation support"

def resolveObservation (support : List String) (observation : Observation) (observed : String) : Except String Resolution :=
  match probabilityLedger support observation with
  | .error e => .error e
  | .ok rows => resolveRows rows observed

structure RealizationRow where
  observedLabel : String
  members : List (String × String)
  exactSupportPart : PositiveFraction

def realizationRow (row : ProbabilityRow) : RealizationRow :=
  ⟨row.observedLabel,row.microstates.map (fun state => (state,"deterministic-member")),row.exactSupportPart⟩

def deterministicRealization (support : List String) (observation : Observation) : Except String (List RealizationRow) :=
  match probabilityLedger support observation with
  | .error e => .error e
  | .ok rows => .ok (rows.map realizationRow)

theorem singletonResolution (members : List String) (state : String) :
    resolveMembers members = .classicalState state ↔ members = [state] := by
  cases members with
  | nil => constructor <;> intro h <;> cases h
  | cons first rest =>
    cases rest with
    | nil => constructor <;> intro h <;> cases h <;> rfl
    | cons next tail => constructor <;> intro h <;> cases h

theorem unresolvedExact (members : List String) (retained : List String)
    (h : resolveMembers members = .unresolvedClass retained) : retained = members := by
  cases members with
  | nil => cases h; rfl
  | cons first rest =>
    cases rest with
    | nil => cases h
    | cons next tail => cases h; rfl

theorem matchingResolution (rows : List ProbabilityRow) (observed : String) (row : ProbabilityRow)
    (h : rows.filter (fun row => row.observedLabel == observed) = [row]) :
    resolveRows rows observed = .ok (resolveMembers row.microstates) := by
  unfold resolveRows
  rw [h]

theorem resolutionOutput (support : List String) (observation : Observation) (observed : String)
    (rows : List ProbabilityRow) (h : probabilityLedger support observation = .ok rows) :
    resolveObservation support observation observed = resolveRows rows observed := by
  unfold resolveObservation
  rw [h]

theorem realizationOutput (support : List String) (observation : Observation)
    (rows : List ProbabilityRow) (h : probabilityLedger support observation = .ok rows) :
    deterministicRealization support observation = .ok (rows.map realizationRow) := by
  unfold deterministicRealization
  rw [h]

theorem realizationProvenance (row : ProbabilityRow) :
    (realizationRow row).observedLabel = row.observedLabel ∧
    (realizationRow row).exactSupportPart = row.exactSupportPart ∧
    (realizationRow row).members.map Prod.fst = row.microstates := by
  refine ⟨rfl,rfl,?_⟩
  change (row.microstates.map (fun state => (state,"deterministic-member"))).map Prod.fst = row.microstates
  induction row.microstates with
  | nil => rfl
  | cons state rest ih => exact congrArg (List.cons state) ih

end SFT.InformationScience.ClassicalResolution

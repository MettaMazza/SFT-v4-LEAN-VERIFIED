import SFT.Computation.ProgramCorrectness
import SFT.Mathematics.DiscreteRelations
namespace SFT.Computation.FormalSpecification
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

structure RelationSpecification where
  inputs : Collection
  outputs : Collection
  allowed : Relation
  generated : generatedRelation inputs outputs allowed = .ok allowed

def accepts (spec : RelationSpecification) (input output : Form) : Bool := has spec.allowed (input,output)

theorem exactAllowedRow (spec : RelationSpecification) (input output : Form) :
    accepts spec input output = true ↔ (input,output) ∈ spec.allowed := hasIff _ _

theorem carrierBoundary (spec : RelationSpecification) (input output : Form)
    (accepted : accepts spec input output = true) : input ∈ spec.inputs ∧ output ∈ spec.outputs :=
  generatedRelationContained _ _ _ _ spec.generated _ ((exactAllowedRow _ _ _).mp accepted)

def falsifications (spec : RelationSpecification) (observed : Relation) : Relation :=
  observed.filter (fun row => !has spec.allowed row)

theorem falsificationMeaning (spec : RelationSpecification) (observed : Relation) (row : Form × Form) :
    row ∈ falsifications spec observed ↔ row ∈ observed ∧ ¬ row ∈ spec.allowed := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    refine ⟨p.1,?_⟩
    intro member
    have present := (hasIff _ _).mpr member
    rw [present] at p; cases p.2
  · intro h
    apply (filterMemberIff _ _ _).mpr
    refine ⟨h.1,?_⟩
    cases present : has spec.allowed row with
    | false => rfl
    | true => exact False.elim (h.2 ((hasIff _ _).mp present))

def certificate (spec : RelationSpecification) (observed : Relation) : Bool :=
  observed.all (fun row => has spec.allowed row)

theorem exactCertificate (spec : RelationSpecification) (observed : Relation) :
    certificate spec observed = true ↔ ∀ row, row ∈ observed → row ∈ spec.allowed := by
  constructor
  · intro h row member; exact (hasIff _ _).mp ((allTrueIffMembers _ _).mp h row member)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun row member => (hasIff _ _).mpr (h row member))

theorem failureRefutes (spec : RelationSpecification) (observed : Relation) (row : Form × Form)
    (failed : row ∈ falsifications spec observed) : certificate spec observed ≠ true := by
  intro passed
  have h := (falsificationMeaning _ _ _).mp failed
  exact h.2 ((exactCertificate _ _).mp passed row h.1)

def Refines (narrow broad : RelationSpecification) : Prop :=
  ∀ row, row ∈ narrow.allowed → row ∈ broad.allowed

theorem refinementIdentity (spec : RelationSpecification) : Refines spec spec := fun _ h => h

theorem refinementComposition (first middle last : RelationSpecification)
    (a : Refines first middle) (b : Refines middle last) : Refines first last := fun row h => b row (a row h)

theorem refinementPreserves (narrow broad : RelationSpecification) (observed : Relation)
    (refines : Refines narrow broad) (passed : certificate narrow observed = true) : certificate broad observed = true :=
  (exactCertificate _ _).mpr (fun row held => refines row ((exactCertificate _ _).mp passed row held))

theorem removedRowFalsifies (narrow broad : RelationSpecification) (row : Form × Form)
    (old : row ∈ broad.allowed) (removed : ¬ row ∈ narrow.allowed) :
    certificate broad [row] = true ∧ row ∈ falsifications narrow [row] := by
  refine ⟨?_,(falsificationMeaning _ _ _).mpr ⟨List.Mem.head _,removed⟩⟩
  apply (exactCertificate _ _).mpr
  intro item held
  cases held with
  | head => exact old
  | tail _ h => cases h

theorem assembly (spec : RelationSpecification) (first second : Relation)
    (left : certificate spec first = true) (right : certificate spec second = true) :
    certificate spec (first ++ second) = true := by
  apply (exactCertificate _ _).mpr
  intro row held
  cases memAppendCases _ _ _ held with
  | inl h => exact (exactCertificate _ _).mp left row h
  | inr h => exact (exactCertificate _ _).mp right row h

theorem falsificationSuccessor (spec : RelationSpecification) (first second : Relation) (row : Form × Form)
    (old : row ∈ falsifications spec first) : row ∈ falsifications spec (first ++ second) := by
  have h := (falsificationMeaning _ _ _).mp old
  exact (falsificationMeaning _ _ _).mpr ⟨memAppendLeft _ _ _ h.1,h.2⟩

open StateTransition StateComposition MachineExecution

def invariantChecks (invariant : String → Bool) (trace : List String) : Bool := trace.all invariant

theorem invariantMeaning (invariant : String → Bool) (trace : List String) :
    invariantChecks invariant trace = true ↔ ∀ state, state ∈ trace → invariant state = true :=
  allTrueIffMembers _ _

theorem invariantPreservation (system : System) (invariant : String → Bool)
    (preserve : ∀ state action target, step system state action = .ok target → invariant state = true → invariant target = true)
    (initial terminal : String) (actions before : List String)
    (path : Path system initial actions before terminal) (base : invariant initial = true) :
    invariantChecks invariant (before ++ [terminal]) = true := by
  induction path with
  | identity state => change (invariant state && true) = true; rw [base]; rfl
  | next state action target actions before terminal edge rest ih =>
    have tail := ih (preserve _ _ _ edge base)
    change (invariant state && invariantChecks invariant (before ++ [terminal])) = true
    rw [base,tail]; rfl

theorem invariantAssembly (invariant : String → Bool) (first second : List String)
    (left : invariantChecks invariant first = true) (right : invariantChecks invariant second = true) :
    invariantChecks invariant (first ++ second) = true := by
  apply (invariantMeaning _ _).mpr
  intro state held
  cases memAppendCases _ _ _ held with
  | inl h => exact (invariantMeaning _ _).mp left state h
  | inr h => exact (invariantMeaning _ _).mp right state h

def Live (system : System) (initial : String) (goals : List String) : Prop :=
  initial ∈ system.states ∧ ∃ actions before terminal goal, Path system initial actions before terminal ∧
    goal ∈ (before ++ [terminal]) ∧ goal ∈ goals

def Terminal (system : System) (initial : String) (goals : List String) : Prop :=
  ∃ actions before terminal, Halted system initial terminal actions before ∧ terminal ∈ goals

theorem terminalImpliesLive (system : System) (initial : String) (goals : List String)
    (terminal : Terminal system initial goals) : Live system initial goals := by
  obtain ⟨actions,before,last,halted,goal⟩ := terminal
  exact ⟨halted.1,actions,before,last,last,halted.2.1,memAppendRight _ _ _ (List.Mem.head _),goal⟩

theorem terminalReconstruction (system : System) (initial : String) (goals : List String)
    (terminal : Terminal system initial goals) :
    ∃ actions before last, run system initial actions = .ok (before ++ [last]) ∧
      BindingTrace.Normal system last ∧ last ∈ goals := by
  obtain ⟨actions,before,last,halted,goal⟩ := terminal
  exact ⟨actions,before,last,(haltReconstructs _ _ _ _ _ halted).1,halted.2.2,goal⟩

theorem livenessSuccessor (system : System) (initial middle terminal : String)
    (left right before after : List String) (goals : List String)
    (input : initial ∈ system.states) (a : Path system initial left before middle) (b : Path system middle right after terminal)
    (goal : String) (visited : goal ∈ before) (admitted : goal ∈ goals) : Live system initial goals :=
  ⟨input,left ++ right,before ++ after,terminal,goal,pathSerial _ _ _ _ _ _ _ _ a b,
   memAppendLeft _ _ _ (memAppendLeft _ _ _ visited),admitted⟩

theorem liveReconstruction (system : System) (initial : String) (goals : List String)
    (live : Live system initial goals) :
    ∃ actions trace goal, run system initial actions = .ok trace ∧ goal ∈ trace ∧ goal ∈ goals := by
  obtain ⟨input,actions,before,terminal,goal,path,visited,admitted⟩ := live
  exact ⟨actions,before ++ [terminal],goal,
    (runAdmission _ _ _ _).mpr ⟨input,(runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ path)⟩,
    visited,admitted⟩

-- This is the explicit registered relation used by the correctness checker.
def relationPost (spec : RelationSpecification)
    (input : SymbolicEvaluation.Environment → Form)
    (output : EvaluationTrace.Result × List EvaluationTrace.Event → Form)
    (env : SymbolicEvaluation.Environment) (execution : EvaluationTrace.Result × List EvaluationTrace.Event) : Bool :=
  accepts spec (input env) (output execution)

theorem relationPostMeaning (spec : RelationSpecification)
    (input : SymbolicEvaluation.Environment → Form)
    (output : EvaluationTrace.Result × List EvaluationTrace.Event → Form)
    (env : SymbolicEvaluation.Environment) (execution : EvaluationTrace.Result × List EvaluationTrace.Event) :
    relationPost spec input output env execution = true ↔ (input env,output execution) ∈ spec.allowed :=
  exactAllowedRow _ _ _

def asSpecification (spec : RelationSpecification) (mode : ProgramCorrectness.Mode)
    (pre : SymbolicEvaluation.Environment → Bool)
    (input : SymbolicEvaluation.Environment → Form)
    (output : EvaluationTrace.Result × List EvaluationTrace.Event → Form) : ProgramCorrectness.Specification :=
  ⟨mode,pre,relationPost spec input output⟩

theorem verifiedCarrier (spec : RelationSpecification) (mode : ProgramCorrectness.Mode)
    (pre : SymbolicEvaluation.Environment → Bool)
    (input : SymbolicEvaluation.Environment → Form)
    (output : EvaluationTrace.Result × List EvaluationTrace.Event → Form)
    (support : List SymbolicEvaluation.Environment) (program : SymbolicEvaluation.Expr)
    (passed : ProgramCorrectness.certificate support (asSpecification spec mode pre input output) program = true)
    (env : SymbolicEvaluation.Environment) (held : env ∈ support) (required : pre env = true)
    (result : EvaluationTrace.Result) (rows : List EvaluationTrace.Event)
    (execution : EvaluationTrace.Execution env program result rows) :
    (input env,output (result,rows)) ∈ spec.allowed ∧ input env ∈ spec.inputs ∧ output (result,rows) ∈ spec.outputs := by
  have h := ProgramCorrectness.certificateSound _ _ _ passed env held required result rows execution
  exact ⟨(exactAllowedRow _ _ _).mp h,carrierBoundary _ _ _ h⟩

end SFT.Computation.FormalSpecification

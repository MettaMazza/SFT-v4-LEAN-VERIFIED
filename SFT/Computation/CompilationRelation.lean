import SFT.Computation.ProgramTransformation
import SFT.Computation.ProgramEquivalence
namespace SFT.Computation.CompilationRelation
open SymbolicEvaluation ProgramEquivalence
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology

-- The original generated finite relation retains both frozen grammar carriers.
abbrev Languages := FormalSpecification.RelationSpecification

def Compiles (languages : Languages) (source target : Form) : Prop :=
  (source,target) ∈ languages.allowed

def coverageCheck (languages : Languages) : Bool :=
  languages.inputs.all (fun source => languages.allowed.any (fun row => decide (row.1 = source)))

theorem coverageMeaning (languages : Languages) : coverageCheck languages = true ↔
    ∀ source, source ∈ languages.inputs → ∃ target, Compiles languages source target := by
  constructor
  · intro h source held
    have found := (allTrueIffMembers _ _).mp h source held
    obtain ⟨row,member,same⟩ := (anyTrueIff _ _).mp found
    have eq := of_decide_eq_true same
    exact ⟨row.2,by change (source,row.2) ∈ languages.allowed; rw [← eq]; exact member⟩
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro source held
    obtain ⟨target,member⟩ := h source held
    exact (anyTrueIff _ _).mpr ⟨(source,target),member,decide_eq_true rfl⟩

theorem total (languages : Languages) (coverage : coverageCheck languages = true)
    (source : Form) (held : source ∈ languages.inputs) : ∃ target, Compiles languages source target :=
  (coverageMeaning _).mp coverage source held

theorem grammarBoundary (languages : Languages) (source target : Form)
    (compiled : Compiles languages source target) : source ∈ languages.inputs ∧ target ∈ languages.outputs :=
  generatedRelationContained _ _ _ _ languages.generated _ compiled

theorem outsideSourceRejected (languages : Languages) (source target : Form)
    (outside : ¬ source ∈ languages.inputs) : ¬ Compiles languages source target :=
  fun compiled => outside (grammarBoundary _ _ _ compiled).1

theorem outsideTargetRejected (languages : Languages) (source target : Form)
    (outside : ¬ target ∈ languages.outputs) : ¬ Compiles languages source target :=
  fun compiled => outside (grammarBoundary _ _ _ compiled).2

structure Runtime where
  inputs : List Environment
  sourceExpression : Form → Expr
  targetExpression : Form → Expr
  observe : Observation

def checked (runtime : Runtime) (source target : Form) : Bool :=
  certificate runtime.inputs runtime.observe (runtime.sourceExpression source) (runtime.targetExpression target)

theorem checkedMeaning (runtime : Runtime) (source target : Form) :
    checked runtime source target = true ↔ Equivalent runtime.inputs runtime.observe
      (runtime.sourceExpression source) (runtime.targetExpression target) := exactCertificate _ _ _ _

def observations (runtime : Runtime) (source target : Form) : List ProgramEquivalence.Row :=
  ledger runtime.inputs runtime.observe (runtime.sourceExpression source) (runtime.targetExpression target)

theorem completeExecutionRows (runtime : Runtime) (source target : Form)
    (row : ProgramEquivalence.Row) (held : row ∈ observations runtime source target) :
    EvaluationTrace.Execution row.input (runtime.sourceExpression source) row.left.1 row.left.2 ∧
    EvaluationTrace.Execution row.input (runtime.targetExpression target) row.right.1 row.right.2 ∧
    row.leftObservation = runtime.observe row.left ∧ row.rightObservation = runtime.observe row.right :=
  completeExecutions _ _ _ _ _ held

theorem resultCorrespondence (runtime : Runtime) (source target : Form)
    (passed : checked runtime source target = true) (env : Environment) (held : env ∈ runtime.inputs) :
    runtime.observe (EvaluationTrace.run env (runtime.sourceExpression source)) =
    runtime.observe (EvaluationTrace.run env (runtime.targetExpression target)) :=
  (checkedMeaning _ _ _).mp passed env held

-- A failed semantic check is not admitted as a successful compilation certificate.
def Verified (languages : Languages) (runtime : Runtime) (source target : Form) : Prop :=
  Compiles languages source target ∧ checked runtime source target = true

theorem failureRejected (languages : Languages) (runtime : Runtime) (source target : Form)
    (failed : checked runtime source target = false) : ¬ Verified languages runtime source target := by
  intro accepted
  have passed := accepted.2
  rw [failed] at passed
  cases passed

theorem verifiedTotal (languages : Languages) (runtime : Runtime)
    (checks : ∀ source target, Compiles languages source target → checked runtime source target = true)
    (source : Form) (coverage : coverageCheck languages = true) (held : source ∈ languages.inputs) :
    ∃ target, Verified languages runtime source target := by
  obtain ⟨target,compiled⟩ := total languages coverage source held
  exact ⟨target,compiled,checks source target compiled⟩

def compilerCheck (languages : Languages) (runtime : Runtime) : Bool :=
  coverageCheck languages && languages.allowed.all (fun row => checked runtime row.1 row.2)

theorem completeCompilerCheck (languages : Languages) (runtime : Runtime)
    (passed : compilerCheck languages runtime = true) :
    ∀ source, source ∈ languages.inputs → ∃ target, Verified languages runtime source target := by
  have h := (andTrue _ _).mp passed
  intro source held
  exact verifiedTotal languages runtime (fun source target compiled =>
    (allTrueIffMembers _ _).mp h.2 (source,target) compiled) source h.1 held

theorem everyRelationRowChecked (languages : Languages) (runtime : Runtime)
    (passed : compilerCheck languages runtime = true) (source target : Form)
    (compiled : Compiles languages source target) : checked runtime source target = true :=
  (allTrueIffMembers _ _).mp ((andTrue _ _).mp passed).2 (source,target) compiled

theorem serialCorrespondence (first second : Runtime) (source middle target : Form)
    (inputs : first.inputs = second.inputs)
    (interface : first.targetExpression middle = second.sourceExpression middle)
    (observation : first.observe = second.observe)
    (one : checked first source middle = true) (two : checked second middle target = true) :
    Equivalent first.inputs first.observe (first.sourceExpression source) (second.targetExpression target) := by
  have a := (checkedMeaning _ _ _).mp one
  have b := (checkedMeaning _ _ _).mp two
  rw [← inputs,← observation,← interface] at b
  exact composition _ _ _ _ _ a b

theorem identityCorrespondence (inputs : List Environment) (observe : Observation) (program : Expr) :
    certificate inputs observe program program = true := certificateComplete _ _ _ _ (identity _ _ _)

theorem inputSuccessor (first extra : List Environment) (observe : Observation) (source target : Expr)
    (old : certificate first observe source target = true)
    (new : certificate extra observe source target = true) :
    certificate (first ++ extra) observe source target = true :=
  certificateComplete _ _ _ _ (supportAssembly _ _ _ _ _ (certificateSound _ _ _ _ old)
    (certificateSound _ _ _ _ new))

theorem observationSuccessor (first extra : List Environment) (observe : Observation) (source target : Expr) :
    ledger (first ++ extra) observe source target = ledger first observe source target ++ ledger extra observe source target :=
  ledgerAssembly _ _ _ _ _

-- Overhead retains two complete ledgers, not a claimed improvement or signed cost.
theorem executionResources (row : ProgramEquivalence.Row) (label : EvaluationTrace.Event → String)
    (sourceSpace targetSpace : List String) (sourceLedger targetLedger : ResourceRecord.Ledger)
    (left : ResourceRecord.resourceLedger (row.left.2.map label) sourceSpace = .ok sourceLedger)
    (right : ResourceRecord.resourceLedger (row.right.2.map label) targetSpace = .ok targetLedger) :
    sourceLedger.timeTrace.map Prod.snd = row.left.2.map label ∧
    targetLedger.timeTrace.map Prod.snd = row.right.2.map label ∧
    sourceLedger.timeCount = row.left.2.length ∧ targetLedger.timeCount = row.right.2.length ∧
    sourceLedger.spaceSupport = sourceSpace ∧ targetLedger.spaceSupport = targetSpace := by
  have a := ResourceRecord.recordReconstructs _ _ _ left
  have b := ResourceRecord.recordReconstructs _ _ _ right
  have mapLength : ∀ xs : List EvaluationTrace.Event, (xs.map label).length = xs.length := by
    intro xs
    induction xs with
    | nil => rfl
    | cons x xs ih => exact congrArg Nat.succ ih
  exact ⟨a.1,b.1,a.2.2.1.trans (mapLength _),b.2.2.1.trans (mapLength _),a.2.1,b.2.1⟩

end SFT.Computation.CompilationRelation

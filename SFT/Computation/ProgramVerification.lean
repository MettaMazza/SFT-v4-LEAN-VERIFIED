import SFT.Computation.CompilationRelation
import SFT.Computation.ProofBoundary
namespace SFT.Computation.ProgramVerification
open SFT.Mathematics LogicForms LogicInference DiscreteObjects GeometryTopology
open SymbolicEvaluation

structure Boundary where
  sourceIdentity : String
  programIdentity : String
  program : Expr
  specification : ProgramCorrectness.Specification
  inputs : List Environment
  premises : List Proposition
  rules : List Rule
  conclusion : Proposition

structure ProofObject where
  sourceIdentity : String
  programIdentity : String
  steps : List ProofStep

def bindingCheck (boundary : Boundary) (proof : ProofObject) : Bool :=
  decide (proof.sourceIdentity = boundary.sourceIdentity) && decide (proof.programIdentity = boundary.programIdentity)

def check (boundary : Boundary) (proof : ProofObject) : Bool :=
  bindingCheck boundary proof && (proofIsValid boundary.premises proof.steps boundary.rules &&
    has (afterSteps boundary.premises proof.steps) boundary.conclusion)

theorem bindingMeaning (boundary : Boundary) (proof : ProofObject) : bindingCheck boundary proof = true ↔
    proof.sourceIdentity = boundary.sourceIdentity ∧ proof.programIdentity = boundary.programIdentity := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; exact ⟨of_decide_eq_true p.1,of_decide_eq_true p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨decide_eq_true h.1,decide_eq_true h.2⟩

theorem exactChecker (boundary : Boundary) (proof : ProofObject) : check boundary proof = true ↔
    proof.sourceIdentity = boundary.sourceIdentity ∧ proof.programIdentity = boundary.programIdentity ∧
    AcceptedTrace boundary.rules boundary.premises proof.steps ∧
    boundary.conclusion ∈ afterSteps boundary.premises proof.steps := by
  constructor
  · intro h
    have a := (andTrue _ _).mp h
    have binding := (bindingMeaning _ _).mp a.1
    have b := (andTrue _ _).mp a.2
    exact ⟨binding.1,binding.2,(checkerIffTrace _ _ _).mp b.1,(hasIff _ _).mp b.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(bindingMeaning _ _).mpr ⟨h.1,h.2.1⟩,
      (andTrue _ _).mpr ⟨(checkerIffTrace _ _ _).mpr h.2.2.1,(hasIff _ _).mpr h.2.2.2⟩⟩

-- The registered interpretation retains proofs of rule soundness and premises.
-- A conclusion label alone supplies no correctness proof.
structure Interpretation (boundary : Boundary) where
  meaning : Proposition → Prop
  rulesSound : ∀ record, record ∈ boundary.rules →
    (∀ premise, premise ∈ record.2.1 → meaning premise) → meaning record.2.2
  premisesSound : ∀ premise, premise ∈ boundary.premises → meaning premise
  conclusionMeaning : meaning boundary.conclusion →
    ProgramCorrectness.Correct boundary.inputs boundary.specification boundary.program

theorem correctness (boundary : Boundary) (interpretation : Interpretation boundary) (proof : ProofObject)
    (passed : check boundary proof = true) :
    ProgramCorrectness.Correct boundary.inputs boundary.specification boundary.program := by
  have h := (exactChecker _ _).mp passed
  exact interpretation.conclusionMeaning (traceSound _ _ interpretation.rulesSound _ _ h.2.2.1
    interpretation.premisesSound boundary.conclusion h.2.2.2)

theorem completeBoundary (boundary : Boundary) (interpretation : Interpretation boundary) (proof : ProofObject)
    (passed : check boundary proof = true) :
    ProgramCorrectness.certificate boundary.inputs boundary.specification boundary.program = true :=
  (ProgramCorrectness.exactCertificate _ _ _).mpr (correctness boundary interpretation proof passed)

theorem sourceTamperRejected (boundary : Boundary) (proof : ProofObject)
    (changed : proof.sourceIdentity ≠ boundary.sourceIdentity) : check boundary proof ≠ true :=
  fun h => changed ((exactChecker _ _).mp h).1

theorem programTamperRejected (boundary : Boundary) (proof : ProofObject)
    (changed : proof.programIdentity ≠ boundary.programIdentity) : check boundary proof ≠ true :=
  fun h => changed ((exactChecker _ _).mp h).2.1

theorem invalidProofRejected (boundary : Boundary) (proof : ProofObject)
    (invalid : ¬ AcceptedTrace boundary.rules boundary.premises proof.steps) : check boundary proof ≠ true :=
  fun h => invalid ((exactChecker _ _).mp h).2.2.1

theorem missingConclusionRejected (boundary : Boundary) (proof : ProofObject)
    (missing : ¬ boundary.conclusion ∈ afterSteps boundary.premises proof.steps) : check boundary proof ≠ true :=
  fun h => missing ((exactChecker _ _).mp h).2.2.2

theorem identityProof (boundary : Boundary) (held : boundary.conclusion ∈ boundary.premises) :
    check boundary ⟨boundary.sourceIdentity,boundary.programIdentity,[]⟩ = true :=
  (exactChecker _ _).mpr ⟨rfl,rfl,.done _,held⟩

theorem composedProof (boundary : Boundary) (first second : List ProofStep)
    (prior : AcceptedTrace boundary.rules boundary.premises first)
    (later : AcceptedTrace boundary.rules (afterSteps boundary.premises first) second)
    (conclusion : boundary.conclusion ∈ afterSteps (afterSteps boundary.premises first) second) :
    check boundary ⟨boundary.sourceIdentity,boundary.programIdentity,first ++ second⟩ = true := by
  apply (exactChecker _ _).mpr
  refine ⟨rfl,rfl,ProofBoundary.traceComposition _ _ _ _ prior later,?_⟩
  rw [ProofBoundary.finalStateComposition]
  exact conclusion

theorem earlierStepRetained (first second : List ProofStep) (step : ProofStep) (held : step ∈ first) :
    step ∈ first ++ second := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

end SFT.Computation.ProgramVerification

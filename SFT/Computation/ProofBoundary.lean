import SFT.Computation.DiagonalTrace
import SFT.Computation.EnumerationTrace
import SFT.Mathematics.LogicInference
namespace SFT.Computation.ProofBoundary
open SFT.Mathematics LogicForms LogicInference DiscreteObjects
open RecognitionDomain EnumerationTrace UniversalInterpretation
open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder

-- A proof record retains the original checker and its original consistency
-- test, not a truth oracle or an imported arithmetic proof system.
def CheckedRecord (available : List Proposition) (steps : List ProofStep) (rules : List Rule) : Prop :=
  proofIsValid available steps rules = true ∧ consistent (afterSteps available steps) = true

theorem externalTrace (available : List Proposition) (steps : List ProofStep) (rules : List Rule)
    (checked : CheckedRecord available steps rules) :
    AcceptedTrace rules available steps ∧
      ∀ proposition, proposition ∈ afterSteps available steps →
        ¬ denied proposition ∈ afterSteps available steps :=
  ⟨(checkerIffTrace _ _ _).mp checked.1,(consistentMeaning _).mp checked.2⟩

theorem opposingProofExcluded (available : List Proposition) (steps : List ProofStep) (rules : List Rule)
    (proposition : Proposition) (affirmed : proposition ∈ afterSteps available steps)
    (opposed : denied proposition ∈ afterSteps available steps) :
    ¬ CheckedRecord available steps rules := by
  intro checked
  exact (externalTrace _ _ _ checked).2 proposition affirmed opposed

theorem identityRecord (available : List Proposition) (rules : List Rule)
    (admitted : consistent available = true) : CheckedRecord available [] rules :=
  ⟨rfl,admitted⟩

-- Every accepted enumerated proof retains its exact positional name,
-- original proof steps and complete native verifier trace.
theorem enumeratedProofRecord (descriptions : List String) (rows : List (String × String))
    (enumerated : completeEnumeration descriptions = .ok rows)
    (index : Nat) (name : String) (found : atPosition descriptions index = some name)
    (registry : List (String × List ProofStep)) (steps : List ProofStep)
    (selected : lookupFirst registry name = some steps)
    (available : List Proposition) (rules : List Rule)
    (checked : CheckedRecord available steps rules) :
    atPosition rows index = some (SFT.Host.Text.append "position-" (toString (1+index)),name) ∧
      (name,steps) ∈ registry ∧ AcceptedTrace rules available steps ∧
      consistent (afterSteps available steps) = true := by
  have position := positionReconstruction descriptions 1 index name found
  rw [← ((enumerationMeaning _ _).mp enumerated).2.2] at position
  exact ⟨position,lookupRow _ _ _ selected,(checkerIffTrace _ _ _).mp checked.1,checked.2⟩

theorem traceComposition (rules : List Rule) (available : List Proposition)
    (first second : List ProofStep)
    (prior : AcceptedTrace rules available first)
    (later : AcceptedTrace rules (afterSteps available first) second) :
    AcceptedTrace rules available (first ++ second) := by
  induction prior with
  | done available => exact later
  | @step available entry rest premises registered tail ih =>
    exact .step premises registered (ih later)

theorem finalStateComposition (available : List Proposition) (first second : List ProofStep) :
    afterSteps available (first ++ second) = afterSteps (afterSteps available first) second := by
  induction first generalizing available with
  | nil => rfl
  | cons entry rest ih => exact ih (available ++ [entry.conclusion])

theorem checkedComposition (available : List Proposition) (first second : List ProofStep)
    (rules : List Rule) (prior : proofIsValid available first rules = true)
    (later : CheckedRecord (afterSteps available first) second rules) :
    CheckedRecord available (first ++ second) rules := by
  refine ⟨(checkerIffTrace _ _ _).mpr
    (traceComposition _ _ _ _ ((checkerIffTrace _ _ _).mp prior)
      ((checkerIffTrace _ _ _).mp later.1)),?_⟩
  rw [finalStateComposition]
  exact later.2

-- The missing decision is witnessed at the retained self-description itself.
-- This is the computational boundary inherited from the previous entry.
theorem missingSelfDecision (registry : List (String × Request)) (decoder : Decoder)
    (predictor : Codeword → Except String String)
    (supported : DiagonalTrace.SelfSupport registry decoder predictor)
    (correct : DiagonalTrace.Correct registry decoder predictor) :
    ∃ code name, decode code decoder = .ok name ∧
      ∀ answer, HaltingBoundary.Verdict answer → predictor code ≠ .ok answer := by
  obtain ⟨code,name,decoded,diagonal⟩ := supported
  refine ⟨code,name,decoded,?_⟩
  intro answer held answered
  obtain ⟨request,constructed,selected⟩ := diagonal answer answered
  exact DiagonalTrace.contradictionTrace _ _ _ _ _ _ _ decoded answered held constructed selected correct

theorem noCompleteInternalVerification (registry : List (String × Request)) (decoder : Decoder)
    (predictor : Codeword → Except String String)
    (supported : DiagonalTrace.SelfSupport registry decoder predictor)
    (correct : DiagonalTrace.Correct registry decoder predictor) :
    ¬ DiagonalTrace.Total decoder predictor := by
  intro total
  obtain ⟨code,name,decoded,missing⟩ := missingSelfDecision _ _ _ supported correct
  obtain ⟨answer,held,answered⟩ := total code name decoded
  exact missing answer held answered

-- A verifier returning only answers supported by retained valid proof records
-- cannot fill the missing class when those records preserve execution answers.
theorem noProofBackedTotality (registry : List (String × Request)) (decoder : Decoder)
    (predictor : Codeword → Except String String)
    (available : List Proposition) (rules : List Rule)
    (supported : DiagonalTrace.SelfSupport registry decoder predictor)
    (proofBacked : ∀ code answer, predictor code = .ok answer →
      ∃ steps, CheckedRecord available steps rules)
    (answerPreserving : ∀ code answer steps before terminal,
      predictor code = .ok answer → CheckedRecord available steps rules →
      interpret registry decoder code = some (.ok (before ++ [terminal])) →
      HaltingBoundary.Verdict terminal → answer = terminal) :
    ¬ DiagonalTrace.Total decoder predictor := by
  apply noCompleteInternalVerification _ _ _ supported
  intro code answer before terminal answered observed held
  obtain ⟨steps,checked⟩ := proofBacked code answer answered
  exact answerPreserving code answer steps before terminal answered checked observed held
end SFT.Computation.ProofBoundary

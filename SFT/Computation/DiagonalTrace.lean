import SFT.Computation.UniversalMachineTrace
import SFT.Computation.HaltingBoundary
namespace SFT.Computation.DiagonalTrace
open StateTransition StateComposition MachineExecution UniversalInterpretation
open RecognitionDomain HaltingBoundary
open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder

-- Exact complementary verdict, realized by an original identity-halt machine.
-- Errors of the original complement operation are retained unchanged.
def diagonalRequest (prediction : String) : Except String Request :=
  match selfNegatingBoundary prediction with
  | .error reason => .error reason
  | .ok opposite => .ok ⟨⟨[opposite],["fold"],[]⟩,opposite,[]⟩

theorem constructionTrace (prediction : String) (request : Request)
    (constructed : diagonalRequest prediction = .ok request) :
    ∃ opposite, selfNegatingBoundary prediction = .ok opposite ∧
      request = ⟨⟨[opposite],["fold"],[]⟩,opposite,[]⟩ := by
  unfold diagonalRequest at constructed
  cases result : selfNegatingBoundary prediction with
  | error reason => rw [result] at constructed; cases constructed
  | ok opposite =>
    rw [result] at constructed
    exact ⟨opposite,rfl,(Except.ok.inj constructed).symm⟩

theorem nativeDiagonal (prediction : String) (request : Request)
    (constructed : diagonalRequest prediction = .ok request) :
    ∃ opposite, selfNegatingBoundary prediction = .ok opposite ∧
      create request.machine.states request.machine.actions request.machine.transitions = .ok request.machine ∧
      Halted request.machine request.initial opposite request.actions [] ∧
      run request.machine request.initial request.actions = .ok [opposite] := by
  obtain ⟨opposite,complement,eq⟩ := constructionTrace _ _ constructed
  cases eq
  refine ⟨opposite,complement,?_,?_,?_⟩
  · simp only [create]; rfl
  · refine ⟨.head [],.identity opposite,.head [],?_⟩
    intro action target impossible
    cases impossible
  · exact (runAdmission _ _ _ _).mpr ⟨.head [],rfl⟩

theorem complementSupported (prediction : String) (held : Verdict prediction) :
    ∃ request, diagonalRequest prediction = .ok request := by
  cases held with
  | inl accepted => cases accepted; exact ⟨_,rfl⟩
  | inr rejected => cases rejected; exact ⟨_,rfl⟩

theorem originalComplementFailure (prediction reason : String)
    (failure : selfNegatingBoundary prediction = .error reason) :
    diagonalRequest prediction = .error reason := by
  unfold diagonalRequest
  rw [failure]

-- The source boundary requires the same generated code to select the
-- complementary request constructed from the decider's own answer there.
def SelfSupport (registry : List (String × Request)) (decoder : Decoder)
    (predictor : Codeword → Except String String) : Prop :=
  ∃ code name, decode code decoder = .ok name ∧
    ∀ answer, predictor code = .ok answer → ∃ request,
      diagonalRequest answer = .ok request ∧ lookupFirst registry name = some request

def Total (decoder : Decoder) (predictor : Codeword → Except String String) : Prop :=
  ∀ code name, decode code decoder = .ok name →
    ∃ answer, Verdict answer ∧ predictor code = .ok answer

def Correct (registry : List (String × Request)) (decoder : Decoder)
    (predictor : Codeword → Except String String) : Prop :=
  ∀ code answer before terminal, predictor code = .ok answer →
    interpret registry decoder code = some (.ok (before ++ [terminal])) →
    Verdict terminal → answer = terminal

theorem complementaryAnswer (prediction opposite : String) (held : Verdict prediction)
    (result : selfNegatingBoundary prediction = .ok opposite) : Verdict opposite := by
  cases held with
  | inl accepted =>
    cases accepted
    have eq : "reject" = opposite := Except.ok.inj result
    exact .inr eq.symm
  | inr rejected =>
    cases rejected
    have eq : "accept" = opposite := Except.ok.inj result
    exact .inl eq.symm

theorem contradictionTrace (registry : List (String × Request)) (decoder : Decoder)
    (predictor : Codeword → Except String String) (code : Codeword) (name answer : String)
    (request : Request) (decoded : decode code decoder = .ok name)
    (answered : predictor code = .ok answer) (held : Verdict answer)
    (constructed : diagonalRequest answer = .ok request)
    (selected : lookupFirst registry name = some request)
    (correct : Correct registry decoder predictor) : False := by
  obtain ⟨opposite,complement,admitted,halted,replay⟩ := nativeDiagonal _ _ constructed
  have observed := (UniversalMachineTrace.exactObservation _ _ _ _ _ decoded selected _).mpr replay
  have same := correct code answer [] opposite answered observed
    (complementaryAnswer _ _ held complement)
  exact complementHasNoFixedPoint answer held (by rw [← same] at complement; exact complement)

theorem noTotalInternalDecider (registry : List (String × Request)) (decoder : Decoder)
    (predictor : Codeword → Except String String)
    (supported : SelfSupport registry decoder predictor)
    (total : Total decoder predictor) : ¬ Correct registry decoder predictor := by
  intro correct
  obtain ⟨code,name,decoded,diagonal⟩ := supported
  obtain ⟨answer,held,answered⟩ := total code name decoded
  obtain ⟨request,constructed,selected⟩ := diagonal answer answered
  exact contradictionTrace _ _ _ _ _ _ _ decoded answered held constructed selected correct

theorem selfSupportRetained (old extended : List (String × Request)) (decoder next : Decoder)
    (predictor : Codeword → Except String String)
    (sameDecode : ∀ code, decode code next = decode code decoder)
    (retained : ∀ name request, lookupFirst old name = some request →
      lookupFirst extended name = some request)
    (supported : SelfSupport old decoder predictor) : SelfSupport extended next predictor := by
  obtain ⟨code,name,decoded,diagonal⟩ := supported
  refine ⟨code,name,(sameDecode code).trans decoded,?_⟩
  intro answer answered
  obtain ⟨request,constructed,selected⟩ := diagonal answer answered
  exact ⟨request,constructed,retained name request selected⟩
end SFT.Computation.DiagonalTrace

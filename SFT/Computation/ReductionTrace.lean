import SFT.Computation.EnumerationTrace
namespace SFT.Computation.ReductionTrace
open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder
open StateTransition MachineExecution

-- Every map retains its actual source finite encoding and answer decoder.
structure Mapping where
  encoding : Encoding
  decoder : Decoder

def Mapped (mapping : Mapping) (source target : String) : Prop :=
  ModelEncoding.Translates mapping.encoding mapping.decoder source target

def TotalOn (mapping : Mapping) (source target : List String) : Prop :=
  ∀ input, input ∈ source → ∃ output, output ∈ target ∧ Mapped mapping input output

def ProcedureAnswer (registry : List (String × UniversalInterpretation.Request)) (input answer : String) : Prop :=
  ∃ request before, lookupFirst registry input = some request ∧
    Halted request.machine request.initial answer request.actions before

-- The source's explicit bidirectional correctness trace, on its registered
-- domains and supplied encoders/decoders. It is not inferred from a map alone.
def PreservesAnswers (inputs : List String) (inputMap answerMap : Mapping)
    (sourceAnswers targetAnswers : String → String → Prop) : Prop :=
  ∀ input, input ∈ inputs → ∀ target, Mapped inputMap input target → ∀ answer,
    sourceAnswers input answer ↔ ∃ targetAnswer,
      targetAnswers target targetAnswer ∧ Mapped answerMap targetAnswer answer

theorem registeredTotal (source target : List String) (support : List Codeword)
    (first second : Encoding) (sourceDecoder targetDecoder : Decoder)
    (sourceValid : validateEncoding source support first = true)
    (targetValid : validateEncoding target support second = true)
    (sourceInverse : exactDecoder source first = some sourceDecoder)
    (targetInverse : exactDecoder target second = some targetDecoder)
    (covered : ∀ word, word ∈ first.map Prod.snd → word ∈ second.map Prod.snd) :
    TotalOn ⟨first,targetDecoder⟩ source target := by
  intro input held
  obtain ⟨output,bound,forward,reverse⟩ := ModelEncoding.registeredTranslation _ _ _ _ _ _ _
    sourceValid targetValid sourceInverse targetInverse covered input held
  exact ⟨output,bound,forward⟩

theorem identityTotal (source : List String) (support : List Codeword) (encoding : Encoding)
    (decoder : Decoder) (valid : validateEncoding source support encoding = true)
    (inverse : exactDecoder source encoding = some decoder) : TotalOn ⟨encoding,decoder⟩ source source := by
  intro input held
  obtain ⟨word,bound,lookup,decoded⟩ := ModelEncoding.finiteRoundTrip _ _ _ valid _ inverse input held
  exact ⟨input,held,word,lookup,decoded⟩

theorem decodedProcedureTrace (registry : List (String × UniversalInterpretation.Request))
    (input terminal answer : String) (mapping : Mapping)
    (procedure : ProcedureAnswer registry input terminal) (decoded : Mapped mapping terminal answer) :
    ∃ request before word, lookupFirst registry input = some request ∧
      run request.machine request.initial request.actions = .ok (before ++ [terminal]) ∧
      BindingTrace.Normal request.machine terminal ∧
      lookupFirst mapping.encoding terminal = some word ∧ decode word mapping.decoder = .ok answer := by
  obtain ⟨request,before,selected,halted⟩ := procedure
  obtain ⟨word,lookup,result⟩ := decoded
  exact ⟨request,before,word,selected,(haltReconstructs _ _ _ _ _ halted).1,halted.2.2,lookup,result⟩

theorem forwardTrace (source target : List String) (inputMap answerMap : Mapping)
    (sourceAnswers : String → String → Prop)
    (registry : List (String × UniversalInterpretation.Request))
    (total : TotalOn inputMap source target)
    (preserved : PreservesAnswers source inputMap answerMap sourceAnswers (ProcedureAnswer registry))
    (input answer : String) (held : input ∈ source) (sourceResult : sourceAnswers input answer) :
    ∃ translated terminal request before word, translated ∈ target ∧ Mapped inputMap input translated ∧
      lookupFirst registry translated = some request ∧
      run request.machine request.initial request.actions = .ok (before ++ [terminal]) ∧
      BindingTrace.Normal request.machine terminal ∧
      lookupFirst answerMap.encoding terminal = some word ∧ decode word answerMap.decoder = .ok answer := by
  obtain ⟨translated,bound,encoded⟩ := total input held
  obtain ⟨terminal,procedure,decoded⟩ := (preserved input held translated encoded answer).mp sourceResult
  obtain ⟨request,before,word,selected,trace,normal,lookup,result⟩ := decodedProcedureTrace _ _ _ _ _ procedure decoded
  exact ⟨translated,terminal,request,before,word,bound,encoded,selected,trace,normal,lookup,result⟩

theorem reverseAnswer (source : List String) (inputMap answerMap : Mapping)
    (sourceAnswers targetAnswers : String → String → Prop)
    (preserved : PreservesAnswers source inputMap answerMap sourceAnswers targetAnswers)
    (input translated answer terminal : String) (held : input ∈ source)
    (encoded : Mapped inputMap input translated) (result : targetAnswers translated terminal)
    (decoded : Mapped answerMap terminal answer) : sourceAnswers input answer :=
  (preserved input held translated encoded answer).mpr ⟨terminal,result,decoded⟩

-- Composition retains both encodings, both reverse answer decodings and the
-- intermediate description. No opaque replacement of the interface is made.
theorem composition (source middle target : List String)
    (firstInput secondInput firstAnswer secondAnswer : Mapping)
    (sourceAnswers middleAnswers targetAnswers : String → String → Prop)
    (firstTotal : TotalOn firstInput source middle) (secondTotal : TotalOn secondInput middle target)
    (firstCorrect : PreservesAnswers source firstInput firstAnswer sourceAnswers middleAnswers)
    (secondCorrect : PreservesAnswers middle secondInput secondAnswer middleAnswers targetAnswers)
    (input : String) (held : input ∈ source) :
    ∃ intermediate translated, intermediate ∈ middle ∧ translated ∈ target ∧
      Mapped firstInput input intermediate ∧ Mapped secondInput intermediate translated ∧
      ∀ answer, sourceAnswers input answer ↔ ∃ finalAnswer intermediateAnswer,
        targetAnswers translated finalAnswer ∧ Mapped secondAnswer finalAnswer intermediateAnswer ∧
        Mapped firstAnswer intermediateAnswer answer := by
  obtain ⟨intermediate,middleHeld,first⟩ := firstTotal input held
  obtain ⟨translated,targetHeld,second⟩ := secondTotal intermediate middleHeld
  refine ⟨intermediate,translated,middleHeld,targetHeld,first,second,?_⟩
  intro answer
  constructor
  · intro result
    obtain ⟨middleAnswer,middleResult,decodedFirst⟩ := (firstCorrect input held intermediate first answer).mp result
    obtain ⟨finalAnswer,finalResult,decodedSecond⟩ :=
      (secondCorrect intermediate middleHeld translated second middleAnswer).mp middleResult
    exact ⟨finalAnswer,middleAnswer,finalResult,decodedSecond,decodedFirst⟩
  · intro ⟨finalAnswer,middleAnswer,result,decodedSecond,decodedFirst⟩
    have middleResult := (secondCorrect intermediate middleHeld translated second middleAnswer).mpr
      ⟨finalAnswer,result,decodedSecond⟩
    exact (firstCorrect input held intermediate first answer).mpr ⟨middleAnswer,middleResult,decodedFirst⟩

theorem domainSuccessor (mapping : Mapping) (source target : List String) (input : String) :
    TotalOn mapping (input :: source) target ↔
      (∃ output, output ∈ target ∧ Mapped mapping input output) ∧ TotalOn mapping source target := by
  constructor
  · intro total; exact ⟨total input (.head source),fun item member => total item (.tail input member)⟩
  · intro both item member
    cases member with
    | head => exact both.1
    | tail _ held => exact both.2 item held

theorem identityMappingExact (domain : List String) (support : List Codeword) (encoding : Encoding)
    (decoder : Decoder) (valid : validateEncoding domain support encoding = true)
    (inverse : exactDecoder domain encoding = some decoder) (input output : String)
    (held : input ∈ domain) (mapped : Mapped ⟨encoding,decoder⟩ input output) : output = input := by
  obtain ⟨word,bound,lookup,decoded⟩ := ModelEncoding.finiteRoundTrip _ _ _ valid _ inverse input held
  exact ModelEncoding.translationUnique _ _ _ _ _ mapped ⟨word,lookup,decoded⟩

theorem identityPreserves (inputs answers : List String) (inputSupport answerSupport : List Codeword)
    (inputEncoding answerEncoding : Encoding) (inputDecoder answerDecoder : Decoder)
    (inputValid : validateEncoding inputs inputSupport inputEncoding = true)
    (answerValid : validateEncoding answers answerSupport answerEncoding = true)
    (inputInverse : exactDecoder inputs inputEncoding = some inputDecoder)
    (answerInverse : exactDecoder answers answerEncoding = some answerDecoder)
    (result : String → String → Prop)
    (answerHeld : ∀ input answer, result input answer → answer ∈ answers) :
    PreservesAnswers inputs ⟨inputEncoding,inputDecoder⟩ ⟨answerEncoding,answerDecoder⟩ result result := by
  intro input held translated encoded answer
  have inputEq := identityMappingExact _ _ _ _ inputValid inputInverse input translated held encoded
  cases inputEq
  constructor
  · intro actual
    obtain ⟨word,bound,lookup,decoded⟩ := ModelEncoding.finiteRoundTrip _ _ _ answerValid _ answerInverse
      answer (answerHeld input answer actual)
    exact ⟨answer,actual,word,lookup,decoded⟩
  · intro ⟨returned,actual,decoded⟩
    have answerEq := identityMappingExact _ _ _ _ answerValid answerInverse returned answer
      (answerHeld input returned actual) decoded
    cases answerEq
    exact actual

end SFT.Computation.ReductionTrace

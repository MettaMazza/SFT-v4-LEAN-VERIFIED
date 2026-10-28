import SFT.Computation.ModelSimulation
import SFT.InformationScience.EncodingMaps
namespace SFT.Computation.ModelEncoding
open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder
open SFT.Foundation.Count.TraceDerivation

-- The source encoding/decoding operations composed as a relation on held
-- descriptions. This introduces no replacement executable encoding algorithm.
def Translates (encoding : Encoding) (decoder : Decoder) (source target : String) : Prop :=
  ∃ word, lookupFirst encoding source = some word ∧ decode word decoder = .ok target

theorem finiteRoundTrip (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (decoder : Decoder)
    (inverse : exactDecoder source encoding = some decoder) (item : String) (held : item ∈ source) :
    ∃ word, word ∈ support ∧ lookupFirst encoding item = some word ∧ decode word decoder = .ok item := by
  obtain ⟨word,lookup,bound⟩ := admittedSourceCode _ _ _ valid item held
  exact ⟨word,bound,lookup,decoderLeftInverse _ _ _ valid _ inverse _ _ (lookupRow _ _ _ lookup)⟩

theorem registeredTranslation (left right : List String) (support : List Codeword)
    (first second : Encoding) (leftDecoder rightDecoder : Decoder)
    (leftValid : validateEncoding left support first = true)
    (rightValid : validateEncoding right support second = true)
    (leftInverse : exactDecoder left first = some leftDecoder)
    (rightInverse : exactDecoder right second = some rightDecoder)
    (covered : ∀ word, word ∈ first.map Prod.snd → word ∈ second.map Prod.snd)
    (item : String) (held : item ∈ left) :
    ∃ target, target ∈ right ∧ Translates first rightDecoder item target ∧
      Translates second leftDecoder target item := by
  obtain ⟨word,lookup,bound⟩ := admittedSourceCode _ _ _ leftValid item held
  have row := lookupRow _ _ _ lookup
  have used : word ∈ first.map Prod.snd := memMap Prod.snd (item,word) first row
  obtain ⟨pair,member,eq⟩ := memMapPreimage Prod.snd word second (covered word used)
  obtain ⟨target,code⟩ := pair
  dsimp only at eq
  cases eq
  have targetHeld := (sourceProvenance _ _ _ rightValid _ _ member).1
  have forward := decoderLeftInverse _ _ _ rightValid _ rightInverse _ _ member
  have backward := decoderLeftInverse _ _ _ leftValid _ leftInverse _ _ row
  have targetLookup := admittedRowLookup _ _ _ rightValid _ _ member
  exact ⟨target,targetHeld,⟨word,lookup,forward⟩,⟨word,targetLookup,backward⟩⟩

theorem translationUnique (encoding : Encoding) (decoder : Decoder) (source first second : String)
    (one : Translates encoding decoder source first) (two : Translates encoding decoder source second) :
    first = second := by
  obtain ⟨word,lookup,result⟩ := one
  obtain ⟨other,lookupOther,resultOther⟩ := two
  rw [lookup] at lookupOther
  cases lookupOther
  rw [result] at resultOther
  cases resultOther
  rfl

-- Registered table translation determines both the held target description
-- and its exact reverse decoding; no extra reconstruction premise is needed.
theorem registeredReconstruction (left right : List String) (support : List Codeword)
    (first second : Encoding) (leftDecoder rightDecoder : Decoder)
    (leftValid : validateEncoding left support first = true)
    (rightValid : validateEncoding right support second = true)
    (leftInverse : exactDecoder left first = some leftDecoder)
    (rightInverse : exactDecoder right second = some rightDecoder)
    (covered : ∀ word, word ∈ first.map Prod.snd → word ∈ second.map Prod.snd)
    (item target : String) (held : item ∈ left)
    (translation : Translates first rightDecoder item target) :
    target ∈ right ∧ Translates second leftDecoder target item := by
  obtain ⟨actual,bound,forward,reverse⟩ := registeredTranslation _ _ _ _ _ _ _
    leftValid rightValid leftInverse rightInverse covered item held
  have eq := translationUnique _ _ _ _ _ forward translation
  cases eq
  exact ⟨bound,reverse⟩

open StateTransition StateComposition ModelSimulation

-- Connect the actual native run to the registered finite description tables,
-- complete simulated observation, reverse decoder and retained overhead ledger.
theorem registeredExecution (source target : System)
    (admitted : create source.states source.actions source.transitions = .ok source)
    (support : List Codeword) (first second : Encoding) (leftDecoder rightDecoder : Decoder)
    (leftValid : validateEncoding source.states support first = true)
    (rightValid : validateEncoding target.states support second = true)
    (leftInverse : exactDecoder source.states first = some leftDecoder)
    (rightInverse : exactDecoder target.states second = some rightDecoder)
    (covered : ∀ word, word ∈ first.map Prod.snd → word ∈ second.map Prod.snd)
    (encode : String → String)
    (registered : ∀ item, item ∈ source.states → Translates first rightDecoder item (encode item))
    (simulation : StepSimulation source target encode)
    (initial : String) (actions trace : List String)
    (observed : run source initial actions = .ok trace) :
    ∃ before terminal ledger targetBefore,
      trace = before ++ [terminal] ∧ ledger.length = actions.length ∧
      run target (encode initial) (flattened ledger) = .ok (targetBefore ++ [encode terminal]) ∧
      Translates second leftDecoder (encode terminal) terminal := by
  obtain ⟨held,before,terminal,traceEq,path⟩ := nativePath _ _ _ _ observed
  have terminalHeld := executionStates _ _ _ _ admitted initial held _ _
    (pathExecution _ _ _ _ _ path) terminal
    (memAppendRight terminal before [terminal] (.head []))
  have initialTarget := (registeredReconstruction _ _ _ _ _ _ _ leftValid rightValid
    leftInverse rightInverse covered initial (encode initial) held (registered initial held)).1
  have reverse := (registeredReconstruction _ _ _ _ _ _ _ leftValid rightValid
    leftInverse rightInverse covered terminal (encode terminal) terminalHeld
    (registered terminal terminalHeld)).2
  obtain ⟨ledger,targetBefore,length,result⟩ := simulatedObservation _ _ _ simulation _ _ _ _ path initialTarget
  exact ⟨before,terminal,ledger,targetBefore,traceEq,length,result,reverse⟩

end SFT.Computation.ModelEncoding

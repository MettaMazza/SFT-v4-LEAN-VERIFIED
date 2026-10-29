import SFT.Computation.ParameterizedResources
import SFT.InformationScience.CompressionSupport
namespace SFT.Computation.DescriptiveResources
open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder CompressionSupport
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

-- The census retains every generated nonempty description through its depth.
def decodesTo (decoder : Decoder) (objectName : String) (code : Codeword) : Bool :=
  match decode code decoder with
  | .error _ => false
  | .ok actual => decide (actual = objectName)

theorem decodingMeaning (decoder : Decoder) (objectName : String) (code : Codeword) :
    decodesTo decoder objectName code = true ↔ decode code decoder = .ok objectName := by
  unfold decodesTo
  cases h : decode code decoder with
  | error e => constructor <;> intro impossible <;> cases impossible
  | ok actual =>
    constructor
    · intro held; have eq := of_decide_eq_true held; cases eq; rfl
    · intro eq; cases eq; exact decide_eq_true rfl

def descriptions (alphabet : List String) (depth : Nat) (decoder : Decoder) (objectName : String) : List Codeword :=
  (shortThrough alphabet depth).filter (decodesTo decoder objectName)

theorem completeDescriptions (alphabet : List String) (depth : Nat) (decoder : Decoder)
    (objectName : String) (code : Codeword) :
    code ∈ descriptions alphabet depth decoder objectName ↔
      (∃ width, 0 < width ∧ width ≤ depth ∧ code ∈ SFT.InformationScience.QuantitySupport.words alphabet width) ∧
      decode code decoder = .ok objectName := by
  constructor
  · intro held
    have parts := (filterMemberIff _ _ _).mp held
    exact ⟨(shortMembership _ _ _).mp parts.1,(decodingMeaning _ _ _).mp parts.2⟩
  · intro parts
    exact (filterMemberIff _ _ _).mpr
      ⟨(shortMembership _ _ _).mpr parts.1,(decodingMeaning _ _ _).mpr parts.2⟩

def shortestFrom (best : Codeword) : List Codeword → Codeword
 | [] => best
 | next :: rest => shortestFrom (if next.length ≤ best.length then next else best) rest

theorem shortestFromMeaning (best : Codeword) (rest : List Codeword) :
    shortestFrom best rest ∈ best :: rest ∧
      ∀ code, code ∈ best :: rest → (shortestFrom best rest).length ≤ code.length := by
  induction rest generalizing best with
  | nil =>
    refine ⟨.head [],?_⟩
    intro code held
    cases held with
    | head => exact Nat.le_refl _
    | tail _ impossible => cases impossible
  | cons next rest ih =>
    by_cases better : next.length ≤ best.length
    · change shortestFrom (if next.length ≤ best.length then next else best) rest ∈ best :: next :: rest ∧
        ∀ code, code ∈ best :: next :: rest → (shortestFrom (if next.length ≤ best.length then next else best) rest).length ≤ code.length
      rw [ite_eq_left better]
      have small := ih next
      refine ⟨.tail best small.1,?_⟩
      intro code held
      cases held with
      | head => exact Nat.le_trans (small.2 next (.head _)) better
      | tail _ member => exact small.2 code member
    · change shortestFrom (if next.length ≤ best.length then next else best) rest ∈ best :: next :: rest ∧
        ∀ code, code ∈ best :: next :: rest → (shortestFrom (if next.length ≤ best.length then next else best) rest).length ≤ code.length
      rw [ite_eq_right better]
      have small := ih best
      constructor
      · have lift : ∀ code, code ∈ best :: rest → code ∈ best :: next :: rest := by
          intro code held
          cases held with
          | head => exact .head _
          | tail _ member => exact .tail _ (.tail _ member)
        exact lift _ small.1
      · intro code held
        cases held with
        | head => exact small.2 best (.head _)
        | tail _ member =>
          cases member with
          | head => exact Nat.le_trans (small.2 best (.head _)) (Nat.le_of_lt (Nat.lt_of_not_ge better))
          | tail _ old => exact small.2 code (.tail _ old)

def minimalClass (codes : List Codeword) : List Codeword :=
  match codes with
  | [] => []
  | head :: rest => codes.filter fun code => decide (code.length = (shortestFrom head rest).length)

theorem allMinimalTies (head : Codeword) (rest : List Codeword) (code : Codeword) :
    code ∈ minimalClass (head :: rest) ↔ code ∈ head :: rest ∧
      ∀ other, other ∈ head :: rest → code.length ≤ other.length := by
  have least := shortestFromMeaning head rest
  constructor
  · intro held
    have parts := (filterMemberIff _ _ _).mp held
    have eq := of_decide_eq_true parts.2
    refine ⟨parts.1,?_⟩
    intro other member
    rw [eq]
    exact least.2 other member
  · intro parts
    exact (filterMemberIff _ _ _).mpr ⟨parts.1,decide_eq_true
      (Nat.le_antisymm (parts.2 _ least.1) (least.2 code parts.1))⟩

theorem attainedMinimum (head : Codeword) (rest : List Codeword) :
    shortestFrom head rest ∈ minimalClass (head :: rest) :=
  (allMinimalTies _ _ _).mpr (shortestFromMeaning _ _)

theorem minimumReconstructs (alphabet : List String) (depth : Nat) (decoder : Decoder)
    (objectName : String) (head : Codeword) (rest : List Codeword)
    (census : descriptions alphabet depth decoder objectName = head :: rest)
    (code : Codeword) (held : code ∈ minimalClass (head :: rest)) : decode code decoder = .ok objectName := by
  have member := ((allMinimalTies _ _ _).mp held).1
  rw [← census] at member
  exact ((completeDescriptions _ _ _ _ _).mp member).2

theorem minimumNativeReconstruction (alphabet : List String) (depth : Nat) (decoder : Decoder)
    (objectName : String) (head : Codeword) (rest : List Codeword)
    (census : descriptions alphabet depth decoder objectName = head :: rest)
    (code : Codeword) (held : code ∈ minimalClass (head :: rest))
    (registry : List (String × UniversalInterpretation.Request)) (request : UniversalInterpretation.Request)
    (selected : lookupFirst registry objectName = some request) :
    UniversalInterpretation.interpret registry decoder code =
      some (StateTransition.run request.machine request.initial request.actions) :=
  UniversalInterpretation.exactRequest _ _ _ _ _ (minimumReconstructs _ _ _ _ _ _ census _ held) selected

theorem retainedDepth (alphabet : List String) (small large : Nat) (decoder : Decoder)
    (objectName : String) (bound : small ≤ large) (code : Codeword)
    (held : code ∈ descriptions alphabet small decoder objectName) :
    code ∈ descriptions alphabet large decoder objectName := by
  obtain ⟨⟨width,positive,old,generated⟩,decoded⟩ := (completeDescriptions _ _ _ _ _).mp held
  exact (completeDescriptions _ _ _ _ _).mpr ⟨⟨width,positive,Nat.le_trans old bound,generated⟩,decoded⟩

theorem singletonMinimum (code : Codeword) : minimalClass [code] = [code] := by
  change ([code].filter fun c => decide (c.length = code.length)) = [code]
  rw [List.filter_cons_of_pos (p := fun c : Codeword => decide (c.length = code.length)) (decide_eq_true rfl)]
  rfl

-- Each change of description language retains its actual encoder and decoder.
theorem invarianceLedger (mapping : ReductionTrace.Mapping) (source target : String)
    (translated : ReductionTrace.Mapped mapping source target) :
    ∃ code, (source,code) ∈ mapping.encoding ∧ decode code mapping.decoder = .ok target := by
  obtain ⟨code,selected,decoded⟩ := translated
  exact ⟨code,lookupRow _ _ _ selected,decoded⟩

theorem lengthLedgerComposition (first second : Codeword) :
    (first ++ second).length = first.length + second.length :=
  CommunicationResources.countAppend _ _

theorem declaredDepthBoundary (alphabet : List String) (depth : Nat) (decoder : Decoder)
    (objectName : String) (code : Codeword) (beyond : depth < code.length) :
    ¬ code ∈ descriptions alphabet depth decoder objectName := by
  intro held
  obtain ⟨⟨width,positive,bound,generated⟩,decoded⟩ := (completeDescriptions _ _ _ _ _).mp held
  have length := ((QuantitySupport.wordCharacterization _ _ _).mp generated).1
  rw [length] at beyond
  exact Nat.not_lt_of_ge bound beyond

-- The compiler overhead is an explicit retained trace, not a fitted constant.
theorem translatedMinimumBound (targetHead : Codeword) (targetRest : List Codeword)
    (source translated overhead : Codeword)
    (held : translated ∈ targetHead :: targetRest)
    (ledger : translated.length ≤ source.length + overhead.length) :
    (shortestFrom targetHead targetRest).length ≤ source.length + overhead.length :=
  Nat.le_trans ((shortestFromMeaning _ _).2 translated held) ledger

end SFT.Computation.DescriptiveResources

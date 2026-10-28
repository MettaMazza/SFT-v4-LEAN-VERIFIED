import SFT.Computation.UniversalInterpretation
import SFT.Computation.RecognitionTrace
import SFT.InformationScience.CompressionPrefix
namespace SFT.Computation.UniversalMachineTrace
open UniversalInterpretation StateTransition StateComposition MachineExecution
open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder
open SFT.Mathematics.DiscreteObjects

-- The encoded request retains the machine, initial input and every action.
-- A successful finite replay alone is not a terminal decision.
theorem exactObservation (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name : String) (request : Request)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some request) (observation : Except String (List String)) :
    interpret registry decoder code = some observation ↔
      run request.machine request.initial request.actions = observation := by
  rw [exactRequest _ _ _ _ _ decoded selected]
  constructor
  · exact Option.some.inj
  · intro h; rw [h]

theorem haltOutput (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name : String) (request : Request)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some request) (before : List String) (terminal : String)
    (halt : Halted request.machine request.initial terminal request.actions before) :
    interpret registry decoder code = some (.ok (before ++ [terminal])) ∧
      before.length = request.actions.length ∧
      ∀ action target, step request.machine terminal action ≠ .ok target := by
  exact ⟨(exactObservation _ _ _ _ _ decoded selected _).mpr
    (haltReconstructs _ _ _ _ _ halt).1,
    (haltReconstructs _ _ _ _ _ halt).2,haltHasNoContinuation _ _ _ _ _ halt⟩

theorem recoverHalt (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name : String) (request : Request)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some request) (trace : List String)
    (observed : interpret registry decoder code = some (.ok trace))
    (terminalBoundary : ∀ before terminal, trace = before ++ [terminal] →
      BindingTrace.Normal request.machine terminal) :
    ∃ before terminal, trace = before ++ [terminal] ∧
      Halted request.machine request.initial terminal request.actions before := by
  have replay := (exactObservation _ _ _ _ _ decoded selected _).mp observed
  obtain ⟨held,before,terminal,eq,path⟩ := nativePath _ _ _ _ replay
  exact ⟨before,terminal,eq,held,path,terminalBoundary _ _ eq⟩

theorem acceptedOrRejected (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name : String) (request : Request)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some request) (before : List String) (terminal : String)
    (decision : RecognitionTrace.Decision request.machine request.initial request.actions before terminal) :
    interpret registry decoder code = some (.ok (before ++ [terminal])) ∧
      (terminal = "accept" ∨ terminal = "reject") :=
  ⟨(haltOutput _ _ _ _ _ decoded selected _ _ decision.1).1,decision.2⟩

theorem unresolvedReplay (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name : String) (request : Request)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some request) (before : List String) (current : String)
    (unresolved : RecognitionTrace.Unresolved request.machine request.initial request.actions before current) :
    interpret registry decoder code = some (.ok (before ++ [current])) ∧
      ¬ RecognitionTrace.Decision request.machine request.initial request.actions before current :=
  ⟨(exactObservation _ _ _ _ _ decoded selected _).mpr
    (RecognitionTrace.unresolvedReplays _ _ _ _ _ unresolved),
    RecognitionTrace.unresolvedIsNotDecision _ _ _ _ _ unresolved⟩

theorem originalFailure (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name : String) (request : Request)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some request) (reason : String)
    (failure : run request.machine request.initial request.actions = .error reason) :
    interpret registry decoder code = some (.error reason) :=
  (exactObservation _ _ _ _ _ decoded selected _).mpr failure

-- Exact prefix-free description streams retain their complete parse.
theorem descriptionParse (support : List Codeword)
    (prefixFree : CompressionPrefix.prefixFree support = true)
    (left right : List Codeword)
    (leftHeld : ∀ word, word ∈ left → word ∈ support)
    (rightHeld : ∀ word, word ∈ right → word ∈ support)
    (same : CompressionPrefix.concatenate left = CompressionPrefix.concatenate right) :
    left = right := CompressionPrefix.uniqueParse _ prefixFree _ _ leftHeld rightHeld same

-- Successor preservation keeps all earlier selections and exact decoding.
theorem retainedInterpretation (old extended : List (String × Request))
    (decoder nextDecoder : Decoder) (code : Codeword)
    (sameDecode : decode code nextDecoder = decode code decoder)
    (retained : ∀ name request, lookupFirst old name = some request →
      lookupFirst extended name = some request)
    (observation : Except String (List String))
    (prior : interpret old decoder code = some observation) :
    interpret extended nextDecoder code = some observation := by
  obtain ⟨name,request,decoded,selected,member,replay⟩ := interpretationOrigin _ _ _ _ prior
  apply (exactObservation _ _ _ _ _ (sameDecode.trans decoded) (retained _ _ selected) _).mpr
  exact replay

-- The original generated loop supplies arbitrary finite unresolved prefixes.
theorem noOracleFromReplay (depth : Nat) :
    RecognitionTrace.Unresolved RecognitionTrace.loop "held"
      (List.replicate depth "fold") (List.replicate depth "held") "held" ∧
    ¬ RecognitionTrace.Decides RecognitionTrace.loop [("held",List.replicate depth "fold")] :=
  ⟨RecognitionTrace.loopPrefix depth,RecognitionTrace.loopNotTotal _⟩
end SFT.Computation.UniversalMachineTrace

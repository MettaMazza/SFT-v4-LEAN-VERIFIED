import SFT.Computation.ModelEncoding
import SFT.Computation.MachineExecution
namespace SFT.Computation.UniversalInterpretation
open StateTransition StateComposition
open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

-- A held description retains exactly the original machine and run arguments.
-- The finite registry/decoder is the source's frozen description interface.
structure Request where
  machine : System
  initial : String
  actions : List String

-- Correspondence adapter for the declared interpreter process: decode the
-- held description, recover its complete request, execute the unchanged run.
-- none is absence of a registered interpretation, not a new source error.
def interpret (registry : List (String × Request)) (decoder : Decoder) (code : Codeword) :
    Option (Except String (List String)) :=
  match decode code decoder with
  | .error _ => none
  | .ok name => match lookupFirst registry name with
    | none => none
    | some request => some (run request.machine request.initial request.actions)

theorem exactRequest (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name : String) (request : Request)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some request) :
    interpret registry decoder code = some (run request.machine request.initial request.actions) := by
  unfold interpret
  rw [decoded]
  dsimp only
  rw [selected]

theorem completeFrozenGrammar (registry : List (String × Request))
    (unique : distinct (registry.map Prod.fst) = true)
    (support : List Codeword) (encoding : Encoding) (decoder : Decoder)
    (valid : validateEncoding (registry.map Prod.fst) support encoding = true)
    (inverse : exactDecoder (registry.map Prod.fst) encoding = some decoder)
    (name : String) (request : Request) (member : (name,request) ∈ registry) :
    ∃ code, code ∈ support ∧ lookupFirst encoding name = some code ∧
      interpret registry decoder code = some (run request.machine request.initial request.actions) := by
  obtain ⟨code,bound,lookup,decoded⟩ := ModelEncoding.finiteRoundTrip _ _ _ valid _ inverse name
    (memMap Prod.fst (name,request) registry member)
  exact ⟨code,bound,lookup,exactRequest _ _ _ _ _ decoded (lookupUnique _ _ _ unique member)⟩

theorem interpretationOrigin (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (observation : Except String (List String))
    (result : interpret registry decoder code = some observation) :
    ∃ name request, decode code decoder = .ok name ∧
      lookupFirst registry name = some request ∧ (name,request) ∈ registry ∧
      run request.machine request.initial request.actions = observation := by
  unfold interpret at result
  cases hd : decode code decoder with
  | error reason => rw [hd] at result; cases result
  | ok name =>
    rw [hd] at result
    dsimp only at result
    cases hl : lookupFirst registry name with
    | none => rw [hl] at result; cases result
    | some request =>
      rw [hl] at result
      exact ⟨name,request,rfl,hl,lookupRow _ _ _ hl,Option.some.inj result⟩

theorem rejectedDescription (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (reason : String) (failed : decode code decoder = .error reason) :
    interpret registry decoder code = none := by
  unfold interpret; rw [failed]

theorem unregisteredDescription (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name : String) (decoded : decode code decoder = .ok name)
    (absent : lookupFirst registry name = none) : interpret registry decoder code = none := by
  unfold interpret; rw [decoded]
  dsimp only
  rw [absent]

theorem completeTrace (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (trace : List String)
    (result : interpret registry decoder code = some (.ok trace)) :
    ∃ name request before terminal, (name,request) ∈ registry ∧
      trace = before ++ [terminal] ∧
      Path request.machine request.initial request.actions before terminal ∧
      before.length = request.actions.length := by
  obtain ⟨name,request,decoded,lookup,member,observed⟩ := interpretationOrigin _ _ _ _ result
  obtain ⟨held,before,terminal,eq,path⟩ := nativePath _ _ _ _ observed
  exact ⟨name,request,before,terminal,member,eq,path,pathTraceLength _ _ _ _ _ path⟩

theorem observationUnique (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (first second : Except String (List String))
    (one : interpret registry decoder code = some first)
    (two : interpret registry decoder code = some second) : first = second := by
  rw [one] at two
  exact Option.some.inj two

theorem identityTrace (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name : String) (request : Request)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some request)
    (held : request.initial ∈ request.machine.states) (empty : request.actions = []) :
    interpret registry decoder code = some (.ok [request.initial]) := by
  rw [exactRequest _ _ _ _ _ decoded selected]
  apply congrArg some
  apply (runAdmission _ _ _ _).mpr
  exact ⟨held,by rw [empty]; rfl⟩

end SFT.Computation.UniversalInterpretation

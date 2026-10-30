import SFT.QuantumComputation.ReversibleExecution
import SFT.Computation.ModelEncoding
namespace SFT.QuantumComputation.ReversibleInterpretation
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleApplication
open SFT.QuantumComputation.ReversibleExecution
open SFT.InformationScience.EncodingClasses SFT.InformationScience.EncodingMaps SFT.InformationScience.EncodingDecoder
open SFT.Mathematics.DiscreteObjects SFT.Foundation.Count.TraceDerivation

-- Compositional interpretation of the source's finite gate descriptions.
-- Every local operation is the unchanged source apply_gate operation.
def evaluate (state : State) : List Gate → Except String (List State × State)
  | [] => .ok ([],state)
  | gate::rest => match applyGate state gate false with
    | .error error => .error error
    | .ok result => match evaluate result rest with
      | .error error => .error error
      | .ok (states,terminal) => .ok (state::states,terminal)

theorem forwardExecutes (initial terminal : State) (gates : List Gate) (states : List State)
    (trace : Forward initial gates states terminal) : evaluate initial gates = .ok (states,terminal) := by
  induction trace with
  | identity => rfl
  | next state result terminal gate gates states admitted valid applied rest ih =>
    rw [evaluate,applied]
    change (match evaluate result gates with
      | .error error => .error error
      | .ok (rows,last) => .ok (state::rows,last) : Except String (List State × State)) = _
    rw [ih]

structure Request where
  initial : State
  gates : List Gate

def interpret (registry : List (String × Request)) (decoder : Decoder) (code : Codeword) :
    Option (Except String (List State × State)) :=
  match decode code decoder with
  | .error _ => none
  | .ok name => match lookupFirst registry name with
    | none => none
    | some request => some (evaluate request.initial request.gates)

theorem exactRequest (registry : List (String × Request)) (decoder : Decoder) (code : Codeword)
    (name : String) (request : Request) (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some request) :
    interpret registry decoder code = some (evaluate request.initial request.gates) := by
  unfold interpret
  rw [decoded]
  dsimp only
  rw [selected]

theorem completeFrozenGrammar (registry : List (String × Request))
    (unique : distinct (registry.map Prod.fst) = true) (support : List Codeword)
    (encoding : Encoding) (decoder : Decoder)
    (valid : validateEncoding (registry.map Prod.fst) support encoding = true)
    (inverse : exactDecoder (registry.map Prod.fst) encoding = some decoder)
    (name : String) (request : Request) (member : (name,request) ∈ registry) :
    ∃ code, code ∈ support ∧ lookupFirst encoding name = some code ∧
      interpret registry decoder code = some (evaluate request.initial request.gates) := by
  obtain ⟨code,bound,lookup,decoded⟩ := SFT.Computation.ModelEncoding.finiteRoundTrip _ _ _ valid _ inverse name
    (memMap Prod.fst (name,request) registry member)
  exact ⟨code,bound,lookup,exactRequest _ _ _ _ _ decoded (lookupUnique _ _ _ unique member)⟩

theorem interpretedInverse (registry : List (String × Request)) (decoder : Decoder) (code : Codeword)
    (name : String) (request : Request) (terminal : State) (states : List State)
    (decoded : decode code decoder = .ok name) (selected : lookupFirst registry name = some request)
    (trace : Forward request.initial request.gates states terminal) :
    interpret registry decoder code = some (.ok (states,terminal)) ∧
    Backward terminal (reverseOrder request.gates) request.initial ∧
    states.length = request.gates.length ∧ terminal.branches.length = request.initial.branches.length := by
  have execution := exactRequest registry decoder code name request decoded selected
  rw [forwardExecutes _ _ _ _ trace] at execution
  exact ⟨execution,exactInverseTrace _ _ _ _ trace,retainedPredecessorCount _ _ _ _ trace,
    fullSupportRetained _ _ _ _ trace⟩
end SFT.QuantumComputation.ReversibleInterpretation

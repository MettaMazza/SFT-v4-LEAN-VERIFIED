import SFT.InformationScience.EncodingExtension
namespace SFT.InformationScience.EncodingWitnesses
open EncodingClasses EncodingDecoder EncodingMaps EncodingLoss
structure Witness where
  name : String
  statement : String
  passed : Bool

def source : List String := ["a","b","c"]
def support : List Codeword := [["held-a"],["held-b"],["held-c"]]
def lossless : Encoding := [("a",["held-a"]),("b",["held-b"]),("c",["held-c"])]
def lossy : Encoding := [("a",["held-a"]),("b",["held-a"]),("c",["held-c"])]
def leftInverseCheck : Bool := match exactDecoder source lossless with
  | none => false
  | some decoder => lossless.all (fun row => match decode row.2 decoder with
    | .error _ => false
    | .ok item => decide (item = row.1))
def lossCheck : Bool := match exactDecoder source lossy with
  | some _ => false
  | none => match closedDistinctions source lossy with
    | .error _ => false
    | .ok pairs => decide (pairs = [("a","b")])
def classCheck : Bool := match sourceClasses source lossy with
  | [] => false
  | row :: _ => decide (row = (["held-a"],["a","b"]))
def compositionCheck : Bool := match composeEncodings lossless (support.map (fun word => (word,word ++ ["next"]))) with
  | .error _ => false
  | .ok rows => match rows with
    | [] => false
    | row :: _ => decide (row = ("a",["held-a","next"]))
def witnesses : List Witness := [
  ⟨"lossless-total","The witness lossless relation maps every source once into generated support.",validateEncoding source support lossless⟩,
  ⟨"left-inverse","The exact decoder reconstructs every lossless source.",leftInverseCheck⟩,
  ⟨"loss-detected","The lossy relation has no exact decoder and retains the merged a/b class.",lossCheck⟩,
  ⟨"class-ledger","Every used lossy codeword retains its exact source members.",classCheck⟩,
  ⟨"composition","Complete code interface composition preserves each source relation.",compositionCheck⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl

end SFT.InformationScience.EncodingWitnesses

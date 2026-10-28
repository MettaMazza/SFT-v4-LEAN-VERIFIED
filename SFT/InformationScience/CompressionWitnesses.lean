import SFT.InformationScience.CompressionSupport
namespace SFT.InformationScience.CompressionWitnesses
open CompressionDescription CompressionPrefix CompressionSupport
structure Witness where
  name : String
  statement : String
  passed : Bool

def message : Word := ["a","b","a","b","a","b"]
def dictionary : Dictionary := [("held-block",["a","b"])]
def tokens : List String := ["held-block","held-block","held-block"]
def reconstructionCheck : Bool := match isLosslessDescription message dictionary tokens with
  | .error _ => false
  | .ok result => result
def resourceCheck : Bool := match descriptionResourceTrace dictionary tokens with
  | .error _ => false
  | .ok result => decide (result.dictionary.length = 1) && decide (result.tokens.length = 3)
def provenanceCheck : Bool := match redundantPositions message dictionary tokens with
  | .error _ => false
  | .ok result => decide (result.length = message.length)
def prefixCheck : Bool := prefixFree [["a"],["b","a"],["b","b"]] && !prefixFree [["a"],["a","b"]]
def universalCheck : Bool := match universalShorteningImpossible ["a","b"] ["p1","p2","p3"] with
  | .error _ => false
  | .ok result => result

def witnesses : List Witness := [
  ⟨"exact-reconstruction","Three retained block tokens reconstruct the six-cell message exactly.",reconstructionCheck⟩,
  ⟨"resource-accounting","The description retains one dictionary entry and all three token occurrences.",resourceCheck⟩,
  ⟨"redundancy-provenance","Every reconstructed raw cell retains the token and dictionary block that supplied it.",provenanceCheck⟩,
  ⟨"prefix-control","The witness prefix family parses uniquely while a prefix-containing family fails.",prefixCheck⟩,
  ⟨"universal-bound","Complete two-label width-three support cannot inject into all shorter nonempty words.",universalCheck⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.InformationScience.CompressionWitnesses

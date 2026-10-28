import SFT.InformationScience.ChannelExtension
namespace SFT.InformationScience.ChannelWitnesses
open ChannelRelation ChannelCapacity ChannelComposition
structure Witness where
  name : String
  statement : String
  passed : Bool

def clean : FiniteChannel := ⟨["a","b","c"],["x","y","z"],[("a","x"),("b","y"),("c","z")]⟩
def merged : FiniteChannel := ⟨["a","b","c"],["x","z"],[("a","x"),("b","x"),("c","z")]⟩
def second : FiniteChannel := ⟨["x","y","z"],["u","v","w"],[("x","u"),("y","v"),("z","w")]⟩
theorem cleanAdmitted : makeChannel clean.inputs clean.outputs clean.relation = .ok clean := rfl
theorem mergedAdmitted : makeChannel merged.inputs merged.outputs merged.relation = .ok merged := rfl
theorem secondAdmitted : makeChannel second.inputs second.outputs second.relation = .ok second := rfl

def cleanCheck : Bool := match capacityFamily clean with
  | .error _ => false
  | .ok family => decide (family = [["a","b","c"]])
def truth : Except String Bool → Bool
  | .error _ => false
  | .ok value => value
def confusabilityCheck : Bool := truth (confusable merged "a" "b") && !truth (confusable merged "a" "c")
def tiedCheck : Bool := match capacityFamily merged with
  | .error _ => false
  | .ok family => decide (family = [["a","c"],["b","c"]])
def codeCheck : Bool := !distinguishableCode merged ["a","b"] && distinguishableCode merged ["a","c"]
def compositionCheck : Bool := match composeChannels clean second with
  | .error _ => false
  | .ok channel => decide (channel.relation = [("a","u"),("b","v"),("c","w")])

def witnesses : List Witness := [
  ⟨"clean-capacity","Disjoint clean outputs retain all three inputs as one greatest code.",cleanCheck⟩,
  ⟨"merged-confusability","Inputs a and b are confusable exactly through shared output x.",confusabilityCheck⟩,
  ⟨"tied-capacity","The merged channel retains both greatest two-input alternatives rather than tie-breaking.",tiedCheck⟩,
  ⟨"code-control","The a/b selection fails zero-error distinction while a/c passes.",codeCheck⟩,
  ⟨"composition","Composing two clean identity-interface channels preserves exact source/output paths.",compositionCheck⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.InformationScience.ChannelWitnesses

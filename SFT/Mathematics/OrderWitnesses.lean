import SFT.Mathematics.OrderMaps
namespace SFT.Mathematics.OrderWitnesses
open OrderOperations
def diamondCarrier : List String := ["One","left","right","whole"]
def diamondRelation : Relation := [("One","One"),("left","left"),("right","right"),("whole","whole"),("One","left"),("One","right"),("One","whole"),("left","whole"),("right","whole")]
def chainRelation : Relation := [("a","a"),("b","b"),("c","c"),("a","b"),("b","c"),("a","c")]

structure Witness where
  name : String
  statement : String
  passed : Bool

def partialOrder : Witness where
  name := "partial-order"
  statement := "The diamond relation passes all three partial-order obligations."
  passed := isPartialOrder diamondCarrier diamondRelation

theorem partialOrderPassed : partialOrder.passed = true := rfl

def incomparabilityRetained : Witness where
  name := "incomparability-retained"
  statement := "The diamond retains left and right as incomparable."
  passed := !comparable diamondRelation "left" "right"

theorem incomparabilityRetainedPassed : incomparabilityRetained.passed = true := rfl

def conditionalTotality : Witness where
  name := "conditional-totality"
  statement := "The explicit chain is total while the diamond is not."
  passed := isTotal ["a","b","c"] chainRelation && !isTotal diamondCarrier diamondRelation

theorem conditionalTotalityPassed : conditionalTotality.passed = true := rfl

def meetWitness : Witness where
  name := "meet"
  statement := "The two incomparable diamond arms have structural One as their unique meet."
  passed := match meet diamondCarrier diamondRelation ["left","right"] with
    | .error _ => false
    | .ok none => false
    | .ok (some value) => SFT.Host.Text.equal value "One"

theorem meetWitnessPassed : meetWitness.passed = true := rfl

def joinWitness : Witness where
  name := "join"
  statement := "The two incomparable diamond arms have whole as their unique join."
  passed := match join diamondCarrier diamondRelation ["left","right"] with
    | .error _ => false
    | .ok none => false
    | .ok (some value) => SFT.Host.Text.equal value "whole"

theorem joinWitnessPassed : joinWitness.passed = true := rfl

def monotoneIdentity : Witness where
  name := "monotone-identity"
  statement := "The canonical identity map preserves every diamond comparison."
  passed := isMonotone diamondRelation diamondRelation (diamondCarrier.map fun item => (item,item))

theorem monotoneIdentityPassed : monotoneIdentity.passed = true := rfl

def witnesses : List Witness := [partialOrder,incomparabilityRetained,conditionalTotality,meetWitness,joinWitness,monotoneIdentity]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl

end SFT.Mathematics.OrderWitnesses

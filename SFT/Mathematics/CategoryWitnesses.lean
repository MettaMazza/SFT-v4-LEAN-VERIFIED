import SFT.Mathematics.CategoryTransport
import SFT.Mathematics.CategoryTypes
namespace SFT.Mathematics.CategoryWitnesses
open CategoryPaths CategoryTypes CategoryTransport
structure Witness where
  name : String
  statement : String
  passed : Bool

def f : Arrow := ⟨"f","A","B",["f"]⟩
def g : Arrow := ⟨"g","B","C",["g"]⟩
def h : Arrow := ⟨"h","C","D",["h"]⟩
def checkArrow (result : Except String Arrow) (expected : Arrow) : Bool := match result with
  | .error _ => false
  | .ok value => decide (value = expected)
def identityCheck : Bool := match identity "A" with
  | .error _ => false
  | .ok i => match compose i f with
    | .error _ => false
    | .ok result => decide (result.source = "A") && decide (result.target = "B") && decide (canonicalPath result = ["f"])
def associationCheck : Bool := match compose f g with
  | .error _ => false
  | .ok fg => match compose g h with
    | .error _ => false
    | .ok gh => match compose fg h with
      | .error _ => false
      | .ok left => match compose f gh with
        | .error _ => false
        | .ok right => decide (canonicalPath left = canonicalPath right)
def typeCheck : Bool := match typeMembers ["a","b","c"] [("a",true),("b",false),("c",true)] with
  | .error _ => false
  | .ok result => decide (result = ["a","c"])
def naturalityCheck : Bool := match naturalityCommutes [f,g] [⟨"fg","A","C",["f","g"]⟩] with
  | .error _ => false
  | .ok result => result
def witnesses : List Witness := [
  ⟨"interface-composition","f then g composes from A to C with both traces retained.",(checkArrow (compose f g) ⟨"g∘f","A","C",["f","g"]⟩)⟩,
  ⟨"identity","Empty-One return preserves the interface and adds no elementary transition.",(identityCheck)⟩,
  ⟨"association","Both groupings of f, g and h flatten to the same complete path.",(associationCheck)⟩,
  ⟨"type-predicate","The witness predicate retains exactly its admitted carrier forms.",(typeCheck)⟩,
  ⟨"product-sum","Joint products and held sums retain both source coordinates.",((productForms ["a","b"] ["x","y"]).length == 4 && decide (sumForms ["a"] ["b"] = [("left-held","a"),("right-held","b")]))⟩,
  ⟨"functor-interface","The identity transport preserves the witness arrow interface.",(functorPreserves [f] [("A","A"),("B","B")] [("f",f)])⟩,
  ⟨"naturality-path","Two independently assembled routes with the same elementary trace commute.",(naturalityCheck)⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl

end SFT.Mathematics.CategoryWitnesses

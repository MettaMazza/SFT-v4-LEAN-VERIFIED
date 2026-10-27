import SFT
open SFT.Host.Canonical SFT.Mathematics SFT.Mathematics.CombinatorialSelections

def labels : List String := ["a","b","empty-One",""]
def inputs : Nat → List (List String)
 | 0 => [[]]
 | n+1 => (inputs n).flatMap fun xs => labels.map fun x => xs ++ [x]
def formValue (xs : List String) : Value := .array (xs.map Value.text)
def formsValue (xs : List (List String)) : Value := .array (xs.map formValue)
def resultValue : Except String (List (List String)) → Value
 | .error e => .object [("error",.text e)]
 | .ok xs => .object [("ok",formsValue xs)]
def main : IO Unit := do
  let carriers := (List.range 5).flatMap inputs
  let previous := [[],[[]],[DiscreteObjects.emptyOne],[["a"]],[["a"],["a"]],
    [DiscreteObjects.emptyOne,["a"]],[["empty-One","a"],["b"]],[[""],["a"]]]
  IO.println (render (.object [
    ("selections",.array (carriers.map fun xs => .object [("input",formValue xs),("result",resultValue (selections xs))])),
    ("extensions",.array (previous.flatMap fun xs => labels.map fun fresh => .object [
      ("previous",formsValue xs),("fresh",.text fresh),("result",resultValue (recurrenceExtend xs fresh))]))]))

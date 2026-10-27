import SFT.Mathematics.OrderOperations
import SFT.Host.Canonical
open SFT.Mathematics.OrderOperations SFT.Host.Canonical

def texts (xs : List String) : Value := .array (xs.map Value.text)
def optionValue : Option String → Value
  | none => .null
  | some s => .text s
def listResult : Except String (List String) → Value
  | .error e => .object [("error",.text e)]
  | .ok xs => .object [("ok",texts xs)]
def optionValueResult : Except String (Option String) → Value
  | .error e => .object [("error",.text e)]
  | .ok x => .object [("ok",optionValue x)]
def carriers : List (List String) := [[],["a"],["a","b"],["b","a"],["a","a"],["a","b","z"]]
def relations : List Relation := [[],[("a","a")],[("a","b")],[("a","a"),("a","b")],[("b","a")],[("a","a"),("b","a")],[("a","b"),("b","a")],[("a","a"),("a","b"),("b","a")],[("b","b")],[("a","a"),("b","b")],[("a","b"),("b","b")],[("a","a"),("a","b"),("b","b")],[("b","a"),("b","b")],[("a","a"),("b","a"),("b","b")],[("a","b"),("b","a"),("b","b")],[("a","a"),("a","b"),("b","a"),("b","b")],[("a","a"),("a","a")],[("a","z")]]
def selections : List (List String) := [[],["a"],["b"],["z"],["a","a"],["a","b"],["a","z"],["b","a"],["b","b"],["b","z"],["z","a"],["z","b"],["z","z"]]
def mappings : List Relation := [[],[("a","a")],[("a","b")],[("b","a")],[("b","b")],[("z","a")],[("z","b")],[("a","a"),("a","a")],[("a","a"),("a","b")],[("a","a"),("b","a")],[("a","a"),("b","b")],[("a","a"),("z","a")],[("a","a"),("z","b")],[("a","b"),("a","a")],[("a","b"),("a","b")],[("a","b"),("b","a")],[("a","b"),("b","b")],[("a","b"),("z","a")],[("a","b"),("z","b")],[("b","a"),("a","a")],[("b","a"),("a","b")],[("b","a"),("b","a")],[("b","a"),("b","b")],[("b","a"),("z","a")],[("b","a"),("z","b")],[("b","b"),("a","a")],[("b","b"),("a","b")],[("b","b"),("b","a")],[("b","b"),("b","b")],[("b","b"),("z","a")],[("b","b"),("z","b")],[("z","a"),("a","a")],[("z","a"),("a","b")],[("z","a"),("b","a")],[("z","a"),("b","b")],[("z","a"),("z","a")],[("z","a"),("z","b")],[("z","b"),("a","a")],[("z","b"),("a","b")],[("z","b"),("b","a")],[("z","b"),("b","b")],[("z","b"),("z","a")],[("z","b"),("z","b")]]
def main : IO Unit := do
  for carrier in carriers do
    for relation in relations do
      for held in selections do
        IO.println (render (.array [.boolean (isPartialOrder carrier relation),.boolean (isTotal carrier relation),
          listResult (lowerBounds carrier relation held),listResult (upperBounds carrier relation held),
          optionValueResult (meet carrier relation held),optionValueResult (join carrier relation held),
          optionValue (uniqueGreatest held relation),optionValue (uniqueLeast held relation),
          .array (["a","b","z"].flatMap fun a => ["a","b","z"].map fun b => .boolean (comparable relation a b))]))
  for source in relations do
    for target in relations do
      for mapping in mappings do
        IO.println (render (.boolean (isMonotone source target mapping)))

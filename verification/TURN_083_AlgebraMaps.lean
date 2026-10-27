import SFT.Mathematics.AlgebraMaps
open SFT.Mathematics.AlgebraOperations
def choices : List (String × String) := [("a","a"),("a","b"),("b","a"),("b","b"),("outside","a"),("a","outside")]
def mappingsAt : Nat → List (List (String × String))
  | 0 => [[]]
  | n+1 => choices.flatMap (fun x => (mappingsAt n).map (List.cons x))
def xorTable : OperationTable := ⟨["a","b"],[("a","a","a"),("a","b","b"),("b","a","b"),("b","b","a")]⟩
def projectionTable : OperationTable := ⟨["a","b"],[("a","a","a"),("a","b","a"),("b","a","b"),("b","b","b")]⟩
def render : Except String Bool → String
  | .ok true => "true"
  | .ok false => "false"
  | .error e => e
def main : IO Unit := do
  let mappings := (List.range 5).flatMap mappingsAt
  for (mapping,i) in mappings.zipIdx do
    IO.println (toString i ++ ":dict\t" ++ String.intercalate ";" ((buildImages mapping).map (fun p => p.1 ++ "=" ++ p.2)))
    for (source,si) in [xorTable,projectionTable].zipIdx do
      for (target,ti) in [xorTable,projectionTable].zipIdx do
        IO.println (toString i ++ ":" ++ toString si ++ ":" ++ toString ti ++ "\t" ++ render (preservesOperation source target mapping))

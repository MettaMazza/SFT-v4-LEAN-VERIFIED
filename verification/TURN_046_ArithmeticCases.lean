import SFT
open SFT.Mathematics.ExactTraceArithmetic SFT.Host.Canonical
def traceValue (t : Trace) : Value := .array (t.map fun a => .array (a.map Value.text))
def resultValue (r : Except String Trace) : Value := match r with
  | .ok t => .object [("ok",traceValue t)]
  | .error e => .object [("error",.text e)]
def cases : List (Trace × Trace) := [
([],[]),
([],[["a"]]),
([],[["b"]]),
([],[["a"], ["b"]]),
([],[["a"], ["b"], ["c"]]),
([],[["a"], ["a"]]),
([],[["a", "b"]]),
([],[[]]),
([],[[""], ["x"]]),
([["a"]],[]),
([["a"]],[["a"]]),
([["a"]],[["b"]]),
([["a"]],[["a"], ["b"]]),
([["a"]],[["a"], ["b"], ["c"]]),
([["a"]],[["a"], ["a"]]),
([["a"]],[["a", "b"]]),
([["a"]],[[]]),
([["a"]],[[""], ["x"]]),
([["b"]],[]),
([["b"]],[["a"]]),
([["b"]],[["b"]]),
([["b"]],[["a"], ["b"]]),
([["b"]],[["a"], ["b"], ["c"]]),
([["b"]],[["a"], ["a"]]),
([["b"]],[["a", "b"]]),
([["b"]],[[]]),
([["b"]],[[""], ["x"]]),
([["a"], ["b"]],[]),
([["a"], ["b"]],[["a"]]),
([["a"], ["b"]],[["b"]]),
([["a"], ["b"]],[["a"], ["b"]]),
([["a"], ["b"]],[["a"], ["b"], ["c"]]),
([["a"], ["b"]],[["a"], ["a"]]),
([["a"], ["b"]],[["a", "b"]]),
([["a"], ["b"]],[[]]),
([["a"], ["b"]],[[""], ["x"]]),
([["a"], ["b"], ["c"]],[]),
([["a"], ["b"], ["c"]],[["a"]]),
([["a"], ["b"], ["c"]],[["b"]]),
([["a"], ["b"], ["c"]],[["a"], ["b"]]),
([["a"], ["b"], ["c"]],[["a"], ["b"], ["c"]]),
([["a"], ["b"], ["c"]],[["a"], ["a"]]),
([["a"], ["b"], ["c"]],[["a", "b"]]),
([["a"], ["b"], ["c"]],[[]]),
([["a"], ["b"], ["c"]],[[""], ["x"]]),
([["a"], ["a"]],[]),
([["a"], ["a"]],[["a"]]),
([["a"], ["a"]],[["b"]]),
([["a"], ["a"]],[["a"], ["b"]]),
([["a"], ["a"]],[["a"], ["b"], ["c"]]),
([["a"], ["a"]],[["a"], ["a"]]),
([["a"], ["a"]],[["a", "b"]]),
([["a"], ["a"]],[[]]),
([["a"], ["a"]],[[""], ["x"]]),
([["a", "b"]],[]),
([["a", "b"]],[["a"]]),
([["a", "b"]],[["b"]]),
([["a", "b"]],[["a"], ["b"]]),
([["a", "b"]],[["a"], ["b"], ["c"]]),
([["a", "b"]],[["a"], ["a"]]),
([["a", "b"]],[["a", "b"]]),
([["a", "b"]],[[]]),
([["a", "b"]],[[""], ["x"]]),
([[]],[]),
([[]],[["a"]]),
([[]],[["b"]]),
([[]],[["a"], ["b"]]),
([[]],[["a"], ["b"], ["c"]]),
([[]],[["a"], ["a"]]),
([[]],[["a", "b"]]),
([[]],[[]]),
([[]],[[""], ["x"]]),
([[""], ["x"]],[]),
([[""], ["x"]],[["a"]]),
([[""], ["x"]],[["b"]]),
([[""], ["x"]],[["a"], ["b"]]),
([[""], ["x"]],[["a"], ["b"], ["c"]]),
([[""], ["x"]],[["a"], ["a"]]),
([[""], ["x"]],[["a", "b"]]),
([[""], ["x"]],[[]]),
([[""], ["x"]],[[""], ["x"]])]
def main : IO Unit := do
  for (a,b) in cases do
    let pairing := match exactPairing a b with
      | none => Value.null
      | some ps => .array (ps.map fun p => .array [traceValue [p.1] |> fun v => match v with | .array [x] => x | _ => v, traceValue [p.2] |> fun v => match v with | .array [x] => x | _ => v])
    let rem := orientedRemainder a b
    IO.println (render (.object [("junction",resultValue (disjointJunction a b)),("product",resultValue (pairCellProduct a b)),("pairing",pairing),("remainder",.array [.text rem.1,traceValue rem.2])]))
  IO.println (render (resultValue (trace [])))
  IO.println (render (resultValue (trace ["a"])))
  IO.println (render (resultValue (trace ["a", "b"])))
  IO.println (render (resultValue (trace ["a", "a"])))
  IO.println (render (resultValue (trace [""])))
  IO.println (render (resultValue (trace ["", ""])))
  IO.println (render (resultValue (trace ["a", "b", "c"])))
  IO.println (render (resultValue (trace ["a", "b", "a"])))

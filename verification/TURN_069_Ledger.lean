import SFT
open SFT.Host.Canonical SFT.Mathematics.CombinatorialLedger

def inputs : Nat → List (List String)
 | 0 => [[]]
 | n+1 => (inputs n).flatMap fun xs => ["a","b","empty-One",""].map fun x => xs ++ [x]
def classifier (mode : Nat) (item : String) : String :=
  if mode = 0 then item else if mode = 1 then "single-class"
  else if item = "a" then "a-class" else "other-class"
def formValue (xs : List String) : Value := .array (xs.map Value.text)
def ledgerValue (xs : Ledger) : Value := .array (xs.map fun p => .array [.text p.1,formValue p.2])
def main : IO Unit := do
  let carriers := ((List.range 5).flatMap inputs) ++ [["a","b","c"]]
  IO.println (render (.array (carriers.flatMap fun xs => (List.range 3).map fun mode => .object [
    ("input",formValue xs),("mode",.integer (Int.ofNat mode)),
    ("result",ledgerValue (disjointClassLedger xs (classifier mode)))])))

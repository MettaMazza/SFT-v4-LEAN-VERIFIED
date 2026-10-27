import SFT.Mathematics.AlgebraWitnesses
open SFT.Mathematics.AlgebraWitnesses
def main : IO Unit := do
  for w in witnesses do
    IO.println (w.name ++ "\t" ++ w.statement ++ "\t" ++ toString w.passed)

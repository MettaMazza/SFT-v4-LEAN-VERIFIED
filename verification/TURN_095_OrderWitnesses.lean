import SFT.Mathematics.OrderWitnesses
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Mathematics.OrderWitnesses
def main : IO Unit := do
  for w in witnesses do
    IO.println (render (.array [.text w.name,.text w.statement,.boolean w.passed]))

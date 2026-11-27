import SFT.Chemistry.AdditionWitnesses
import SFT.Host.Canonical
open SFT.Chemistry.AdditionWitnesses SFT.Host.Canonical
def main : IO Unit := do
 let result ← IO.ofExcept witnesses
 IO.println (render (.array (result.map Value.boolean)))

import Lean
import SFT.Chemistry.StateEnergyInscription
open SFT.Host SFT.Chemistry.StateEnergyInscription
def main : IO Unit := do
 let inp ← IO.getStdin
 let out ← IO.getStdout
 repeat
  let line ← inp.getLine
  if line.isEmpty then break
  let text ← match Lean.Json.parse line >>= Lean.Json.getStr? with
   | .ok s => pure s
   | .error e => throw (IO.userError e)
  let value : Canonical.Value := match exactValue text with
   | .ok (n,d) => .object [("ok",.array [.integer (.ofNat n),.integer (.ofNat d)])]
   | .error e => .object [("error",.text e)]
  out.putStrLn (Canonical.render value)

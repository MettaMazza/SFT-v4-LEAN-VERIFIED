import SFT.Physics.LeptonTerminal
open SFT.Physics.LeptonTerminal
def main : IO Unit := do
 for result in [correctionPair,terminalPair] do
  match result with
  | .error e => throw (IO.userError e)
  | .ok (n,d) => IO.println s!"{n}/{d}"

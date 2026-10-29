import SFT.Physics.LeptonSource
open SFT.Physics.LeptonSource
def cases : List String := ["", "muon-electron mass ratio                                    206.768 2827             0.000 0046               \nmuon-electron mass ratio                                    206.768 2827             0.000 0046               ", "muon-electron mass ratio                                    206.768 2827             0.000 0046              ", "muon-electron mass ratio                                    2                        3                        ", "muon-electron mass ratio                                    2                        0                        ", "muon-electron mass ratio                                    bad                      1                        ", "muon-electron mass ratio                                    2                        1                        ", "unmatched                                                   206.768 2827             0.000 0046               "]
def main : IO Unit := do
 for text in cases do
  match sourceInterval text "muon-electron mass ratio" with
  | .error e => IO.println ("error:" ++ e)
  | .ok (a,b,c) => IO.println s!"{a.num}/{a.den} {b.num}/{b.den} {c.num}/{c.den}"

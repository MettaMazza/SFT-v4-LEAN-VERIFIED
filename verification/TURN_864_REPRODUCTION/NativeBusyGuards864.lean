import SFT.Computation.NativeClosing
open SFT.Computation.NativeClosing

def main : IO Unit := do
 for n in ([-2,0,1,4] : List Int) do
  IO.println (reprStr (n,wordsAtDepth n,admittedBusyBeaver n,recurrentLabelTrace n))
 for word in ([[],["foreign"],["held-lower","held-upper"]] : List (List String)) do
  IO.println (reprStr (word,closingTrace word))

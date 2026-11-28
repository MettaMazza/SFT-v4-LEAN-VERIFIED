import SFT.Applications.FoldChess.Demonstrations
open SFT.Applications.FoldChess
#print axioms protocolIntegers
#print axioms protocolDecision
#print axioms startIsAtTheLock
#print axioms foolsMateSetup
#print axioms findsFoolsMate
#print axioms foolsMateIsSeenAsMate
#print axioms foolsMateIsReal
#print axioms selfPlayPlies

def main : IO Unit := do
 let kqk ← loadPackedTable "work/engine_sources1594/chess-winning-d0b1996/data/kqk_packed.txt"
 let krk ← loadPackedTable "work/engine_sources1594/chess-winning-d0b1996/data/krk_packed.txt"
 for input in ["2\n8888\n","2\n853\n3364\n926\n8888\n","2\n853\n3364\n926\n3807\n8888\n"] do
  IO.println s!"protocol {(protocolDecision (protocolIntegers input.toUTF8) kqk krk).getD (-999)}"
 IO.println s!"lock {startIsAtTheLock}"
 let (move,ctx) := findsFoolsMate {}
 IO.println s!"find {move}"
 let (seen,ctx) := foolsMateIsSeenAsMate ctx
 IO.println s!"seen {seen}"
 let (real,ctx) := foolsMateIsReal ctx
 IO.println s!"real {real}"
 for n in ([-1,0,1,2] : List Int) do
  let (played,_) := selfPlayPlies n ctx
  IO.println s!"self {n} {played}"

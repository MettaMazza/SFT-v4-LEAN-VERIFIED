import SFT.Applications.FoldGo.Board
open SFT.Applications.FoldGo
#print axioms emptyBoard
#print axioms copyBoard
#print axioms neighbors
#print axioms insertSquare
#print axioms groupWalk
#print axioms getGroup
#print axioms boardKey
#print axioms captureAfterPlacement
#print axioms isLegal
#print axioms retainHistory
#print axioms playMove
#print axioms legalMoves

def nums (ns : List Nat) : String := String.intercalate "," (ns.map toString)
def emit (tag : String) (b : GoBoard) : IO Unit := do
 IO.println (tag ++ " board " ++ boardKey b)
 for idx in List.range (b.size*b.size) do
  let (group,libs) := getGroup b idx
  IO.println (tag ++ s!" group {idx} " ++ nums (group.mergeSort) ++ "/" ++ nums (libs.mergeSort))
 for color in [1,2] do
  IO.println (tag ++ s!" legal {color} " ++ nums (legalMoves b color))
  for idx in (List.range (b.size*b.size)).map some ++ [none] do
   let (ok,next) := playMove b idx color
   IO.println (tag ++ s!" move {color} {idx.getD 999} {if ok then 1 else 0} " ++ boardKey next ++ " " ++ String.intercalate "," (next.history.mergeSort))
def main : IO Unit := do
 for size in [1,2] do
  for code in List.range (3^(size*size)) do
   let cells := ((List.range (size*size)).map fun i => (code/3^i)%3).toArray
   let board : GoBoard := {size,cells}
   emit s!"enum {size} {code}" board
   let (_,passed) := playMove board none 1
   emit s!"history {size} {code}" passed
   emit s!"ko {size} {code}" {board with koSquare := some 0}
 for size in [3,9,19] do
  let mut board := emptyBoard size
  for step in List.range 12 do
   emit s!"walk {size} {step}" board
   let color := step%2+1
   let moves := legalMoves board color
   let move := if moves.isEmpty then none else some (moves[(step*17+3)%moves.length]!)
   board := (playMove board move color).2

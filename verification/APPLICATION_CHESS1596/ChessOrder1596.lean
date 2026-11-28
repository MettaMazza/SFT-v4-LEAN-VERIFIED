import SFT.Applications.FoldChess.Ordering
open SFT.Applications.FoldChess
#print axioms moveIsCapture
#print axioms orderedMoves
#print axioms couldCheckFrom
def emit (tag : String) (state : Board) : IO Unit := do
 IO.println (tag ++ " ordered " ++ String.intercalate "," ((orderedMoves state).toList.map toString))
 IO.println (tag ++ " captures " ++ String.intercalate "," ((legalMoves state).toList.map (fun m => if moveIsCapture state m then "1" else "0")))
def main : IO Unit := do
 for kind in List.range 8 do
  for sq in List.range 65 do
   for king in List.range 65 do
    for side in ([0,1] : List Int) do
     IO.println s!"check {kind} {sq} {king} {side} {if couldCheckFrom (Int.ofNat kind) (Int.ofNat sq) (Int.ofNat king) side then 1 else 0}"
 emit "fixture 0" #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
 emit "fixture 1" #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
 emit "fixture 2" #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
 emit "fixture 3" #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
 emit "fixture 4" #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
 emit "fixture 5" #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
 emit "fixture 6" #[0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,4,0,0,0,7,0,12,6,1,0,0,0,0,0,10,0,0,0,7,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0]
 emit "fixture 7" #[0,0,0,0,0,2,0,2,0,0,0,0,6,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,12,0,0,0,0,8,0,8,0,0,0,0,0,1,0,0,0,0,64,0]
 let mut state := startingState
 for step in List.range 160 do
  emit s!"walk {step}" state
  let moves := legalMoves state
  if moves.size > 0 then state := makeMove state (moves.getD ((step*17+3)%moves.size) 0)

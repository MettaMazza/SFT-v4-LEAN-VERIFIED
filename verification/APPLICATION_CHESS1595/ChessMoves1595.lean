import SFT.Applications.FoldChess.Moves
open SFT.Applications.FoldChess

def emit (tag : String) (state : Board) (move : Int) : IO Unit := do
 let child := makeMove state move
 IO.println (tag ++ " " ++ String.intercalate "," (child.toList.map toString))

def main : IO Unit := do
 for fromSq in List.range 64 do
  for toSq in List.range 64 do
   let move : Int := fromSq * 64 + toSq
   emit s!"start {move}" startingState move
 for code in List.range 12 do
  for fromSq in List.range 64 do
   let s := writeSquare (writeSquare emptyState fromSq (code+1)) 64 (if code < 6 then 0 else 1)
   for toSq in [0,7,8,16,47,48,56,63] do
    for promo in [0,2,3,4,5] do
     let move : Int := promo * 4096 + fromSq * 64 + toSq
     let s := writeSquare s 69 toSq
     emit s!"sparse {code+1} {fromSq} {toSq} {promo}" s move
 for side in [0,1] do
  for target in List.range 64 do
   let moves := pushPawnMove #[] 12 target side
   IO.println s!"pawn {side} {target} {String.intercalate "," (moves.toList.map toString)}"
 IO.println s!"king {kingSquare startingState 0} {kingSquare startingState 1} {kingSquare emptyState 0}"
#print axioms readSquare
#print axioms writeSquare
#print axioms makeMove
#print axioms pushMove
#print axioms pushPawnMove
#print axioms kingSquare

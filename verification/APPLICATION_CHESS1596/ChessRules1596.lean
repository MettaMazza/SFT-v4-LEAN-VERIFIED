import SFT.Applications.FoldChess.LegalMoves
open SFT.Applications.FoldChess
def fixture0 : Board := #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
def fixture1 : Board := #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
def fixture2 : Board := #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
def fixture3 : Board := #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
def fixture4 : Board := #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
def fixture5 : Board := #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
def fixture6 : Board := #[0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,4,0,0,0,7,0,12,6,1,0,0,0,0,0,10,0,0,0,7,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0]
def fixture7 : Board := #[0,0,0,0,0,2,0,2,0,0,0,0,6,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,12,0,0,0,0,8,0,8,0,0,0,0,0,1,0,0,0,0,64,0]
def emitMoves (name : String) (b : Board) : IO Unit := do
 IO.println (name ++ " pseudo " ++ String.intercalate "," ((pseudoMoves b).toList.map toString))
 IO.println (name ++ " legal " ++ String.intercalate "," ((legalMoves b).toList.map toString))
def main : IO Unit := do
 IO.println s!"perft state 1 {perft fixture0 1}"
 emitMoves "state" fixture0
 for move in (legalMoves fixture0).toList do
  emitMoves s!"state child {move}" (makeMove fixture0 move)
 IO.println s!"perft state_two 2 {perft fixture1 2}"
 emitMoves "state_two" fixture1
 for move in (legalMoves fixture1).toList do
  emitMoves s!"state_two child {move}" (makeMove fixture1 move)
 IO.println s!"perft state_three 3 {perft fixture2 3}"
 emitMoves "state_three" fixture2
 for move in (legalMoves fixture2).toList do
  emitMoves s!"state_three child {move}" (makeMove fixture2 move)
 IO.println s!"perft kiwi 1 {perft fixture3 1}"
 emitMoves "kiwi" fixture3
 for move in (legalMoves fixture3).toList do
  emitMoves s!"kiwi child {move}" (makeMove fixture3 move)
 IO.println s!"perft kiwi_two 2 {perft fixture4 2}"
 emitMoves "kiwi_two" fixture4
 for move in (legalMoves fixture4).toList do
  emitMoves s!"kiwi_two child {move}" (makeMove fixture4 move)
 IO.println s!"perft kiwi_three 3 {perft fixture5 3}"
 emitMoves "kiwi_three" fixture5
 for move in (legalMoves fixture5).toList do
  emitMoves s!"kiwi_three child {move}" (makeMove fixture5 move)
 IO.println s!"perft endgame 4 {perft fixture6 4}"
 emitMoves "endgame" fixture6
 for move in (legalMoves fixture6).toList do
  emitMoves s!"endgame child {move}" (makeMove fixture6 move)
 IO.println s!"perft promo_pos 3 {perft fixture7 3}"
 emitMoves "promo_pos" fixture7
 for move in (legalMoves fixture7).toList do
  emitMoves s!"promo_pos child {move}" (makeMove fixture7 move)
 let mut state := startingState
 for step in List.range 160 do
  emitMoves s!"walk {step}" state
  let moves := legalMoves state
  if moves.size > 0 then state := makeMove state (moves.getD ((step*17+3)%moves.size) 0)

import SFT.Applications.FoldChess.Quiescence
open SFT.Applications.FoldChess
#print axioms ttKey
#print axioms ttEnsure
#print axioms quiescenceBounded
#print axioms quiescence
def emit (tag : String) (state : Board) : IO Unit := do
 IO.println s!"{tag} key {ttKey state}"
 for budget in ([-1,0,1,16,256] : List Int) do
  for fresh in ([0,1] : List Int) do
   for window in ([(0,1,1,1),(1,2,1,2),(3,4,1,4)] : List (Int×Int×Int×Int)) do
    let (an,ad,bn,bd) := window
    let (value,ctx) := quiescence state an ad bn bd fresh {nodesLeft := budget}
    IO.println s!"{tag} q {budget} {fresh} {an} {ad} {bn} {bd} {value} {ctx.nodesLeft} {ctx.passAborted}"
def main : IO Unit := do
 let ctx := ttEnsure {}
 IO.println s!"ensure {ctx.ttKeys.size} {ctx.ttMoves.size} {ctx.ttStamp.size} {ctx.killerA.size} {ctx.killerB.size} {readSquare ctx.killerA 63}"
 let ctx := ttEnsure ctx
 IO.println s!"ensure2 {ctx.ttKeys.size} {ctx.killerA.size}"
 emit "fixture 0" #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
 emit "fixture 1" #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
 emit "fixture 2" #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
 emit "fixture 3" #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
 emit "fixture 4" #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
 emit "fixture 5" #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
 emit "fixture 6" #[0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,4,0,0,0,7,0,12,6,1,0,0,0,0,0,10,0,0,0,7,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0]
 emit "fixture 7" #[0,0,0,0,0,2,0,2,0,0,0,0,6,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,12,0,0,0,0,8,0,8,0,0,0,0,0,1,0,0,0,0,64,0]
 let mut state := startingState
 for step in List.range 12 do
  emit s!"walk {step}" state
  let moves := legalMoves state
  if moves.size > 0 then state := makeMove state (moves.getD ((step*17+3)%moves.size) 0)
 emit "clock" (writeSquare startingState 70 100)

import SFT.Applications.FoldChess.Evaluation
open SFT.Applications.FoldChess
#print axioms evaluationMine
#print axioms evaluationEnemy
#print axioms safeReach
#print axioms mobilityRay
#print axioms mobilityCount
#print axioms promotionPathClear
#print axioms promotionLaneClear
#print axioms pawnPromotionPotential
#print axioms sideUnits
#print axioms shareNumerator
#print axioms shareDenominator
def emit (tag : String) (state : Board) : IO Unit := do
 for side in ([0,1] : List Int) do
  IO.println s!"{tag} side {side} {mobilityCount state side (attackMinReachMap state (1-side))} {sideUnits state side}"
  IO.println (tag ++ s!" pawn {side} " ++ String.intercalate "," ((List.range 64).map (fun n => toString (pawnPromotionPotential state (Int.ofNat n) side))))
 IO.println s!"{tag} share {shareNumerator state} {shareDenominator state}"
def main : IO Unit := do
 for code in List.range 12 do
  for sq in List.range 64 do
   emit s!"piece {code+1} {sq}" (writeSquare emptyState (Int.ofNat sq) (Int.ofNat (code+1)))
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

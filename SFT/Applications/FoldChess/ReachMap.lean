import SFT.Applications.FoldChess.LegalMoves
namespace SFT.Applications.FoldChess

def lesserRay (state : Board) (side defender dr df : Int) : Nat → Int → Int → Int → Bool
 | 0, _, _, _ => false
 | n+1, r, f, steps =>
  bif onBoard r f then
   let code := readSquare state (r*8+f)
   if code = 0 then lesserRay state side defender dr df n (r+dr) (f+df) (steps+1)
   else bif attackerColour code side then
    let kind := pieceKind code
    decide ((kind = 5 ∨ (dr ≠ 0 ∧ df ≠ 0 ∧ kind = 3) ∨
      ((dr = 0 ∨ df = 0) ∧ kind = 4) ∨
      (steps = 1 ∧ (kind = 6 ∨ (dr ≠ 0 ∧ df ≠ 0 ∧ kind = 1 ∧
       ((side = 1 ∧ dr = 1) ∨ (side = 0 ∧ dr = -1)))))) ∧
      countedReach kind (r*8+f) side < defender)
   else false
  else false

def lesserAttackerExists (state : Board) (square defenderReach byBlack : Int) : Bool :=
 let rank := square.tdiv 8
 let file := square-rank*8
 let knights := ([-2,-1,0,1,2] : List Int).any fun dr =>
  ([-2,-1,0,1,2] : List Int).any fun df =>
   let a := if dr < 0 then -dr else dr
   let b := if df < 0 then -df else df
   let r := rank+dr
   let f := file+df
   if a+b = 3 ∧ a > 0 ∧ b > 0 then
    bif onBoard r f then
     let code := readSquare state (r*8+f)
     if pieceKind code = 2 then
      attackerColour code byBlack && decide (countedReach 2 (r*8+f) byBlack < defenderReach)
     else false
    else false
   else false
 knights || ([-1,0,1] : List Int).any (fun dr =>
  ([-1,0,1] : List Int).any (fun df =>
   if dr = 0 ∧ df = 0 then false
   else lesserRay state byBlack defenderReach dr df 8 (rank+dr) (file+df) 1))

def recordReach (m : Board) (target reach : Int) : Board :=
 let old := readSquare m target
 if old = 0 ∨ reach < old then writeSquare m target reach else m

def reachRay (state : Board) (reach dr df : Int) : Nat → Int → Int → Board → Board
 | 0, _, _, m => m
 | n+1, r, f, m =>
  bif onBoard r f then
   let target := r*8+f
   let next := recordReach m target reach
   if readSquare state target = 0 then reachRay state reach dr df n (r+dr) (f+df) next
   else next
  else m

-- The source's reused colour buffers are represented as explicit values.
-- Each call resets all 64 entries before accumulating the same minimum reaches.
def attackMinReachMap (state : Board) (byBlack : Int) : Board :=
 (List.range 64).foldl (fun m n =>
  let sq := Int.ofNat n
  let code := readSquare state sq
  let mine := if byBlack = 1 then pieceIsBlack code else pieceIsWhite code
  if mine then Id.run do
   let kind := pieceKind code
   let rank := sq.tdiv 8
   let file := sq-rank*8
   let reach := countedReach kind sq byBlack
   let mut result := m
   if kind = 1 then
    let r := rank + (if byBlack = 1 then -1 else 1)
    result := ([-1,1] : List Int).foldl (fun acc df => Id.run do
     let mut result := acc
     if onBoard r (file+df) then
      result := recordReach result (r*8+file+df) reach
     else pure ()
     return result) result
   if kind = 2 then
    result := ([-2,-1,0,1,2] : List Int).foldl (fun acc dr => Id.run do
     let mut result := acc
     result := ([-2,-1,0,1,2] : List Int).foldl (fun acc df => Id.run do
      let mut result := acc
      let a := if dr < 0 then -dr else dr
      let b := if df < 0 then -df else df
      if a+b = 3 ∧ a > 0 ∧ b > 0 then
       if onBoard (rank+dr) (file+df) then
        result := recordReach result ((rank+dr)*8+file+df) reach
       else pure ()
      return result) result
     return result) result
   if kind > 2 ∧ kind < 6 then
    result := ([-1,0,1] : List Int).foldl (fun acc dr => Id.run do
     let mut result := acc
     result := ([-1,0,1] : List Int).foldl (fun acc df => Id.run do
      let mut result := acc
      let ray := if dr = 0 ∧ df = 0 then false
        else if dr = 0 ∨ df = 0 then decide (kind > 3)
        else decide (kind = 3 ∨ kind = 5)
      if ray then result := reachRay state reach dr df 8 (rank+dr) (file+df) result
      else pure ()
      return result) result
     return result) result
   if kind = 6 then
    result := ([-1,0,1] : List Int).foldl (fun acc dr => Id.run do
     let mut result := acc
     result := ([-1,0,1] : List Int).foldl (fun acc df => Id.run do
      let mut result := acc
      if dr ≠ 0 ∨ df ≠ 0 then
       if onBoard (rank+dr) (file+df) then
        result := recordReach result ((rank+dr)*8+file+df) reach
       else pure ()
      return result) result
     return result) result
   return result
  else m) ((List.replicate 64 (0 : Int)).toArray)
end SFT.Applications.FoldChess

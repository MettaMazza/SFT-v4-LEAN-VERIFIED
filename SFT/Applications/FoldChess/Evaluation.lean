import SFT.Applications.FoldChess.ReachMap
namespace SFT.Applications.FoldChess

def evaluationMine (code side : Int) : Bool :=
 if side = 1 then pieceIsBlack code else pieceIsWhite code

def evaluationEnemy (code side : Int) : Bool :=
 if side = 1 then pieceIsWhite code else pieceIsBlack code

def safeReach (enemyMap : Board) (target own : Int) : Bool :=
 let threat := readSquare enemyMap target
 decide (¬ (threat > 0 ∧ threat < own))

def mobilityRay (state enemyMap : Board) (side own dr df : Int) : Nat → Int → Int → Int
 | 0, _, _ => 0
 | n+1, r, f =>
  bif onBoard r f then
   let target := r*8+f
   let victim := readSquare state target
   let count := if safeReach enemyMap target own then 1 else 0
   if victim = 0 then count + mobilityRay state enemyMap side own dr df n (r+dr) (f+df)
   else if evaluationEnemy victim side then count else 0
  else 0

def mobilityCount (state : Board) (forBlack : Int) (enemyMap : Board) : Int :=
 (List.range 64).foldl (fun total n =>
  let sq := Int.ofNat n
  let code := readSquare state sq
  if evaluationMine code forBlack then Id.run do
   let mut kind := pieceKind code
   let rank := sq.tdiv 8
   let file := sq-rank*8
   let mut own := 0
   let mut result := total
   if kind < 6 ∧ kind > 1 then
    own := countedReach kind sq forBlack
    if !(safeReach enemyMap sq own) then kind := 0
   if kind = 1 then
    let forward := if forBlack = 1 then -8 else 8
    let home := if forBlack = 1 then 6 else 1
    let targetRank := rank+forward.tdiv 8
    let fan := if targetRank = 7 ∨ targetRank = 0 then 4 else 1
    let ahead := sq+forward
    if ahead > -1 ∧ ahead < 64 then
     if readSquare state ahead = 0 then
      result := result+fan
      if rank = home ∧ readSquare state (ahead+forward) = 0 then result := result+1
    result := ([-1,1] : List Int).foldl (fun acc df => Id.run do
     let mut result := acc
     let f := file+df
     let target := rank*8+f+forward
     if f > -1 ∧ f < 8 ∧ target > -1 ∧ target < 64 then
      if evaluationEnemy (readSquare state target) forBlack then result := result+fan
     return result) result
   if kind = 2 then
    result := ([-2,-1,0,1,2] : List Int).foldl (fun acc dr => Id.run do
     let mut result := acc
     result := ([-2,-1,0,1,2] : List Int).foldl (fun acc df => Id.run do
      let mut result := acc
      let a := if dr < 0 then -dr else dr
      let b := if df < 0 then -df else df
      let r := rank+dr
      let f := file+df
      if a+b = 3 ∧ a > 0 ∧ b > 0 then
       if onBoard r f then
        if !(evaluationMine (readSquare state (r*8+f)) forBlack) && safeReach enemyMap (r*8+f) own then
         result := result+1
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
      if ray then result := result+mobilityRay state enemyMap forBlack own dr df 8 (rank+dr) (file+df)
      return result) result
     return result) result
   if kind = 6 then
    result := ([-1,0,1] : List Int).foldl (fun acc dr => Id.run do
     let mut result := acc
     result := ([-1,0,1] : List Int).foldl (fun acc df => Id.run do
      let mut result := acc
      let r := rank+dr
      let f := file+df
      if dr ≠ 0 ∨ df ≠ 0 then
       if onBoard r f then
        if !(evaluationMine (readSquare state (r*8+f)) forBlack) then
         if readSquare enemyMap (r*8+f) ≤ 0 then result := result+1
      return result) result
     return result) result
   return result
  else total) 0

def promotionPathClear (state : Board) (step promoRank : Int) : Nat → Int → Bool
 | 0, _ => true
 | n+1, probe =>
  if probe > -1 ∧ probe < 64 then
   if readSquare state probe > 0 then false
   else if probe.tdiv 8 = promoRank then true
   else promotionPathClear state step promoRank n (probe+step)
  else true

def promotionLaneClear (state : Board) (step enemy lane : Int) : Nat → Int → Bool
 | 0, _ => true
 | n+1, r =>
  if r > 0 ∧ r < 7 then
   if readSquare state (r*8+lane) = enemy then false
   else promotionLaneClear state step enemy lane n (r+step)
  else true

def pawnPromotionPotential (state : Board) (sq forBlack : Int) : Int :=
 let rank := sq.tdiv 8
 let file := sq-rank*8
 let step := if forBlack = 1 then -8 else 8
 let promoRank := if forBlack = 1 then 0 else 7
 if !(promotionPathClear state step promoRank 8 (sq+step)) then 0
 else
  let enemy := if forBlack = 1 then 1 else 7
  let passed := ([-1,0,1] : List Int).all fun df =>
   let lane := file+df
   if lane > -1 ∧ lane < 8 then
    promotionLaneClear state (step.tdiv 8) enemy lane 8 (rank+step.tdiv 8)
   else true
  if passed then countedReach 5 (promoRank*8+file) forBlack else 0

def sideUnits (state : Board) (forBlack : Int) : Int :=
 let units := (List.range 64).foldl (fun total n =>
  let sq := Int.ofNat n
  let code := readSquare state sq
  if evaluationMine code forBlack then
   let kind := pieceKind code
   total+countedReach kind sq forBlack+
    (if kind = 1 then pawnPromotionPotential state sq forBlack else 0)
  else total) 0
 units+mobilityCount state forBlack (attackMinReachMap state (1-forBlack))

def shareNumerator (state : Board) : Int := sideUnits state (readSquare state 64)
def shareDenominator (state : Board) : Int :=
 sideUnits state (readSquare state 64)+sideUnits state (1-readSquare state 64)
end SFT.Applications.FoldChess

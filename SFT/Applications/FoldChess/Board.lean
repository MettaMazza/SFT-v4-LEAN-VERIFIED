namespace SFT.Applications.FoldChess
-- Original winning v14: SFT-v3 d0b1996c09fd0b27be5a6016324f83ed578c5c94.
-- constants/fold_chess_bot.ep:106–184,960–1050,1355–1360,1987–1994.
abbrev Board := Array Int

def pieceIsWhite (code : Int) : Bool := code > 0 && code < 7
def pieceIsBlack (code : Int) : Bool := code > 6
def pieceKind (code : Int) : Int := if code > 6 then code - 6 else code

def startingState : Board :=
 #[4,2,3,5,6,3,2,4] ++ Array.replicate 8 1 ++ Array.replicate 32 0 ++
 Array.replicate 8 7 ++ #[10,8,9,11,12,9,8,10] ++ #[0,1,1,1,1,64,0]

def emptyState : Board := Array.replicate 64 0 ++ #[0,0,0,0,0,64,0]

-- Source get_list returns zero for out-of-range indices; copy_state copies 71 slots.
def copyState (state : Board) : Board := ((List.range 71).map (state.getD · 0)).toArray

def countedReach (kind sq isBlack : Int) : Int :=
 let rank := sq.tdiv 8
 let file := sq - rank * 8
 if kind = 1 then
  if isBlack = 1 then
   if rank > 0 then (if rank = 6 then 2 else 1) else 0
  else if rank < 7 then (if rank = 1 then 2 else 1) else 0
 else if kind = 2 then
  ([-2,-1,0,1,2] : List Int).foldl (fun reach dr =>
   ([-2,-1,0,1,2] : List Int).foldl (fun count df =>
    let drSize := if dr < 0 then -dr else dr
    let dfSize := if df < 0 then -df else df
    let r := rank + dr
    let f := file + df
    if drSize + dfSize = 3 ∧ drSize > 0 ∧ dfSize > 0 ∧
      r > -1 ∧ r < 8 ∧ f > -1 ∧ f < 8 then count + 1 else count) reach) 0
 else if kind = 6 then
  ([-1,0,1] : List Int).foldl (fun reach dr =>
   ([-1,0,1] : List Int).foldl (fun count df =>
    let r := rank + dr
    let f := file + df
    if ¬ (dr = 0 ∧ df = 0) ∧ r > -1 ∧ r < 8 ∧ f > -1 ∧ f < 8
     then count + 1 else count) reach) 0
 else
  let up := 7 - rank
  let down := rank
  let rightSide := 7 - file
  let leftSide := file
  let rookReach := up + down + rightSide + leftSide
  let ne := if rightSide < up then rightSide else up
  let nw := if leftSide < up then leftSide else up
  let se := if rightSide < down then rightSide else down
  let sw := if leftSide < down then leftSide else down
  let bishopReach := ne + nw + se + sw
  if kind = 3 then bishopReach else if kind = 4 then rookReach else rookReach + bishopReach

def flipRank (sq : Int) : Int :=
 let rank := sq.tdiv 8
 let file := sq - rank * 8
 (7 - rank) * 8 + file

def thinkingBudget : Int := (List.range 22).foldl (fun budget _ => budget * 2) 1
end SFT.Applications.FoldChess

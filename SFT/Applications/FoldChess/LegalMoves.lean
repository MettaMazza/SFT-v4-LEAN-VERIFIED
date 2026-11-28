import SFT.Applications.FoldChess.Attacks
namespace SFT.Applications.FoldChess

def sameSide (code side : Int) : Bool :=
 if side = 0 then pieceIsWhite code else pieceIsBlack code

def enemySide (code side : Int) : Bool :=
 if side = 0 then pieceIsBlack code else pieceIsWhite code

def knightOffsets : List (Int × Int) := [(2,1),(2,-1),(-2,1),(-2,-1),(1,2),(1,-2),(-1,2),(-1,-2)]
def rayOffsets : List (Int × Int) := [(1,1),(1,-1),(-1,1),(-1,-1),(1,0),(-1,0),(0,1),(0,-1)]

def sliderMoves (state : Board) (side origin dr df : Int) : Nat → Int → Int → Array Int → Array Int
 | 0, _, _, moves => moves
 | n+1, r, f, moves =>
  bif onBoard r f then
   let victim := readSquare state (r*8+f)
   if victim = 0 then sliderMoves state side origin dr df n (r+dr) (f+df) (pushMove moves origin (r*8+f))
   else bif enemySide victim side then pushMove moves origin (r*8+f) else moves
  else moves

def pawnMoves (state : Board) (side sq : Int) (moves : Array Int) : Array Int := Id.run do
 let rank := sq.tdiv 8
 let file := sq-rank*8
 let forward := if side = 1 then -8 else 8
 let homeRank := if side = 1 then 6 else 1
 let ahead := sq+forward
 let mut result := moves
 if ahead > -1 ∧ ahead < 64 then
  if readSquare state ahead = 0 then
   result := pushPawnMove result sq ahead side
   if rank = homeRank then
    let twoAhead := ahead+forward
    if readSquare state twoAhead = 0 then result := pushMove result sq twoAhead
 return ([-1,0,1] : List Int).foldl (fun acc delta =>
  let captureFile := file+delta
  if captureFile > -1 ∧ captureFile < 8 ∧ captureFile ≠ file then
   let target := rank*8+captureFile+forward
   if target > -1 ∧ target < 64 then
    bif enemySide (readSquare state target) side || decide (target = readSquare state 69)
    then pushPawnMove acc sq target side else acc
   else acc
  else acc) result

def castleMoves (state : Board) (side sq : Int) (moves : Array Int) : Array Int := Id.run do
 let home := if side = 1 then 60 else 4
 let shortRight := readSquare state (if side = 1 then 67 else 65)
 let longRight := readSquare state (if side = 1 then 68 else 66)
 let enemy := 1-side
 let mut result := moves
 if sq = home then
  if shortRight = 1 ∧ readSquare state (home+1) = 0 ∧ readSquare state (home+2) = 0 then
   if !(squareAttacked state home enemy) ∧ !(squareAttacked state (home+1) enemy) ∧ !(squareAttacked state (home+2) enemy) then
    result := pushMove result sq (home+2)
  if longRight = 1 ∧ readSquare state (home-1) = 0 ∧ readSquare state (home-2) = 0 ∧ readSquare state (home-3) = 0 then
   if !(squareAttacked state home enemy) ∧ !(squareAttacked state (home-1) enemy) ∧ !(squareAttacked state (home-2) enemy) then
    result := pushMove result sq (home-2)
 return result

def pieceMoves (state : Board) (side sq : Int) (moves : Array Int) : Array Int :=
 let code := readSquare state sq
 bif sameSide code side then
  let kind := pieceKind code
  let rank := sq.tdiv 8
  let file := sq-rank*8
  if kind = 1 then pawnMoves state side sq moves
  else if kind = 2 then
   knightOffsets.foldl (fun acc (dr,df) =>
    let r := rank+dr
    let f := file+df
    bif onBoard r f then
     bif sameSide (readSquare state (r*8+f)) side then acc else pushMove acc sq (r*8+f)
    else acc) moves
  else if kind > 2 ∧ kind < 6 then
   let rays := if kind = 3 then rayOffsets.take 4 else if kind = 4 then rayOffsets.drop 4 else rayOffsets
   rays.foldl (fun acc (dr,df) => sliderMoves state side sq dr df 8 (rank+dr) (file+df) acc) moves
  else if kind = 6 then
   let result := ([-1,0,1] : List Int).foldl (fun acc dr =>
    ([-1,0,1] : List Int).foldl (fun acc df =>
     if dr = 0 ∧ df = 0 then acc
     else
      let r := rank+dr
      let f := file+df
      bif onBoard r f then
       bif sameSide (readSquare state (r*8+f)) side then acc else pushMove acc sq (r*8+f)
      else acc) acc) moves
   castleMoves state side sq result
  else moves
 else moves

def pseudoMoves (state : Board) : Array Int :=
 (List.range 64).foldl (fun moves sq => pieceMoves state (readSquare state 64) (Int.ofNat sq) moves) #[]

def legalMoves (state : Board) : Array Int :=
 let side := readSquare state 64
 (pseudoMoves state).toList.foldl (fun legal move =>
  let child := makeMove state move
  bif squareAttacked child (kingSquare child side) (1-side) then legal else legal.push move) #[]

-- Perft depth is the nonnegative ply count used by the original callers.
def perft (state : Board) : Nat → Int
 | 0 => 1
 | n+1 =>
  let moves := legalMoves state
  if n = 0 then Int.ofNat moves.size
  else moves.toList.foldl (fun total move => total + perft (makeMove state move) n) 0
end SFT.Applications.FoldChess

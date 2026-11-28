import SFT.Applications.FoldChess.Moves
namespace SFT.Applications.FoldChess

def onBoard (rank file : Int) : Bool := rank > -1 && rank < 8 && file > -1 && file < 8

def attackerColour (code side : Int) : Bool :=
 if side = 1 then pieceIsBlack code else if side = 0 then pieceIsWhite code else false

-- Each source ray stops at its first occupied square or at the board edge.
-- Eight steps include the source's missing-king sentinel at square 64.
def attackRay (state : Board) (side dr df : Int) : Nat → Int → Int → Int → Bool
 | 0, _, _, _ => false
 | n+1, r, f, steps =>
  bif onBoard r f then
   let code := readSquare state (r*8+f)
   if code = 0 then attackRay state side dr df n (r+dr) (f+df) (steps+1)
   else bif attackerColour code side then
    let kind := pieceKind code
    decide (kind = 5 ∨ (dr ≠ 0 ∧ df ≠ 0 ∧ kind = 3) ∨
      ((dr = 0 ∨ df = 0) ∧ kind = 4) ∨
      (steps = 1 ∧ (kind = 6 ∨
       (dr ≠ 0 ∧ df ≠ 0 ∧ kind = 1 ∧ ((side = 1 ∧ dr = 1) ∨ (side = 0 ∧ dr = -1))))))
   else false
  else false

def squareAttacked (state : Board) (square byBlack : Int) : Bool :=
 let rank := square.tdiv 8
 let file := square - rank*8
 let knights := ([-2,-1,0,1,2] : List Int).any (fun dr =>
  ([-2,-1,0,1,2] : List Int).any (fun df =>
   let drSize := if dr < 0 then -dr else dr
   let dfSize := if df < 0 then -df else df
   let r := rank+dr
   let f := file+df
   if drSize+dfSize = 3 ∧ drSize > 0 ∧ dfSize > 0 then
    bif onBoard r f then
     let code := readSquare state (r*8+f)
     if pieceKind code = 2 then attackerColour code byBlack else false
    else false
   else false))
 knights || ([-1,0,1] : List Int).any (fun dr =>
  ([-1,0,1] : List Int).any (fun df =>
   if dr = 0 ∧ df = 0 then false
   else attackRay state byBlack dr df 8 (rank+dr) (file+df) 1))

def sideInCheck (state : Board) : Bool :=
 let side := readSquare state 64
 squareAttacked state (kingSquare state side) (1-side)
end SFT.Applications.FoldChess

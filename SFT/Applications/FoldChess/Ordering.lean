import SFT.Applications.FoldChess.Evaluation
namespace SFT.Applications.FoldChess

def moveIsCapture (state : Board) (move : Int) : Bool :=
 let promo := move.tdiv 4096
 if promo > 0 then true
 else
  let rest := move-promo*4096
  let fromSq := rest.tdiv 64
  let toSq := rest-fromSq*64
  if readSquare state toSq > 0 then true
  else decide (pieceKind (readSquare state fromSq) = 1 ∧ toSq = readSquare state 69)

def orderedMoves (state : Board) : Array Int :=
 let moves := legalMoves state
 ([0,1,2] : List Int).foldl (fun result bucket =>
  moves.toList.foldl (fun acc move =>
   let rest := move-move.tdiv 4096*4096
   let toSq := rest-rest.tdiv 64*64
   let victim := readSquare state toSq
   let taking := moveIsCapture state move
   let heavy := decide (victim > 0 ∧ countedReach (pieceKind victim) toSq 0 > 8)
   let wanted := if bucket = 0 then taking && heavy
     else if bucket = 1 then taking && !heavy else !taking
   bif wanted then acc.push move else acc) result) #[]

def couldCheckFrom (kind toSq enemyKing forBlack : Int) : Bool :=
 let dr := enemyKing.tdiv 8-toSq.tdiv 8
 let df := (enemyKing-enemyKing.tdiv 8*8)-(toSq-toSq.tdiv 8*8)
 let adr := if dr < 0 then -dr else dr
 let adf := if df < 0 then -df else df
 if kind = 2 then decide (adr+adf = 3 ∧ adr > 0 ∧ adf > 0)
 else if kind = 3 then decide (adr = adf)
 else if kind = 4 then decide (adr = 0 ∨ adf = 0)
 else if kind = 5 then decide (adr = adf ∨ adr = 0 ∨ adf = 0)
 else if kind = 1 ∧ adf = 1 then
  if forBlack = 1 then decide (dr = -1) else decide (dr = 1)
 else false
end SFT.Applications.FoldChess

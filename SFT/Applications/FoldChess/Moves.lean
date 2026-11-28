import SFT.Applications.FoldChess.Board
namespace SFT.Applications.FoldChess

def readSquare (state : Board) (i : Int) : Int :=
 if i < 0 then 0 else state.getD i.toNat 0

def writeSquare (state : Board) (i value : Int) : Board :=
 if i < 0 then state else state.setIfInBounds i.toNat value

-- Original make_move; all writes occur in their source order on a fresh 71-slot copy.
def makeMove (state : Board) (move : Int) : Board := Id.run do
 let mut fresh := copyState state
 let promo := move.tdiv 4096
 let rest := move - promo * 4096
 let fromSq := rest.tdiv 64
 let toSq := rest - fromSq * 64
 let code := readSquare fresh fromSq
 let side := readSquare fresh 64
 let kind := pieceKind code
 let epSquare := readSquare fresh 69
 let mut clock := readSquare fresh 70 + 1
 if kind = 1 then clock := 0
 if readSquare fresh toSq > 0 then clock := 0
 fresh := writeSquare fresh 70 clock
 if kind = 1 then
  if toSq = epSquare then
   if side = 0 then fresh := writeSquare fresh (toSq - 8) 0
   else fresh := writeSquare fresh (toSq + 8) 0
 fresh := writeSquare fresh fromSq 0
 fresh := writeSquare fresh toSq code
 if kind = 1 then
  let toRank := toSq.tdiv 8
  let landed := if promo = 0 then 5 else promo
  if side = 0 then
   if toRank = 7 then fresh := writeSquare fresh toSq landed
  else
   if toRank = 0 then fresh := writeSquare fresh toSq (landed + 6)
 if kind = 6 then
  let fromFile := fromSq - fromSq.tdiv 8 * 8
  let toFile := toSq - toSq.tdiv 8 * 8
  if toFile = fromFile + 2 then
   fresh := writeSquare fresh (toSq - 1) (readSquare fresh (toSq + 1))
   fresh := writeSquare fresh (toSq + 1) 0
  if fromFile = toFile + 2 then
   fresh := writeSquare fresh (toSq + 1) (readSquare fresh (toSq - 2))
   fresh := writeSquare fresh (toSq - 2) 0
 if code = 6 then
  fresh := writeSquare fresh 65 0
  fresh := writeSquare fresh 66 0
 if code = 12 then
  fresh := writeSquare fresh 67 0
  fresh := writeSquare fresh 68 0
 if fromSq = 7 then fresh := writeSquare fresh 65 0
 if fromSq = 0 then fresh := writeSquare fresh 66 0
 if fromSq = 63 then fresh := writeSquare fresh 67 0
 if fromSq = 56 then fresh := writeSquare fresh 68 0
 if toSq = 7 then fresh := writeSquare fresh 65 0
 if toSq = 0 then fresh := writeSquare fresh 66 0
 if toSq = 63 then fresh := writeSquare fresh 67 0
 if toSq = 56 then fresh := writeSquare fresh 68 0
 fresh := writeSquare fresh 69 64
 if kind = 1 then
  if side = 0 then
   if toSq = fromSq + 16 then fresh := writeSquare fresh 69 (fromSq + 8)
  else
   if toSq + 16 = fromSq then fresh := writeSquare fresh 69 (fromSq - 8)
 fresh := writeSquare fresh 64 (1 - side)
 return fresh

def pushMove (moves : Array Int) (fromSq toSq : Int) : Array Int :=
 moves.push (fromSq * 64 + toSq)

def pushPawnMove (moves : Array Int) (fromSq toSq side : Int) : Array Int :=
 let toRank := toSq.tdiv 8
 let promotes := if side = 0 then decide (toRank = 7) else decide (toRank = 0)
 bif promotes then
  ([2,3,4,5] : List Int).foldl (fun acc promo => acc.push (promo * 4096 + fromSq * 64 + toSq)) moves
 else pushMove moves fromSq toSq

def kingSquare (state : Board) (blackKing : Int) : Int :=
 let wanted := if blackKing = 1 then 12 else 6
 match (List.range 64).find? (fun sq => decide (state.getD sq 0 = wanted)) with
 | none => 64
 | some sq => Int.ofNat sq
end SFT.Applications.FoldChess

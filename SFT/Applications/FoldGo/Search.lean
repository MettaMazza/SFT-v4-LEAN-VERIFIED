import SFT.Applications.FoldGo.SearchState
namespace SFT.Applications.FoldGo

structure ScoredMove where
 heuristic : Int
 numerator : Nat
 distance : Nat
 move : Nat

def scoredBefore (a b : ScoredMove) : Bool :=
 if a.heuristic = b.heuristic then
  if a.numerator = b.numerator then decide (a.distance ≤ b.distance)
  else decide (a.numerator > b.numerator)
 else decide (a.heuristic > b.heuristic)

def insertScored (move : ScoredMove) : List ScoredMove → List ScoredMove
 | [] => [move]
 | first::rest => bif scoredBefore move first then move::first::rest else first::insertScored move rest

def sortScored : List ScoredMove → List ScoredMove
 | [] => []
 | first::rest => insertScored first (sortScored rest)

def scoreMoves (board : GoBoard) (depth : Int) (color : Nat) (ctx : SearchContext) (candidates : List Nat) : List ScoredMove :=
 let scored := candidates.map fun move =>
  let score := if depth > 0 then
    let (k1,k2) := ctx.killers.getD depth.toNat (-1,-1)
    (if Int.ofNat move = k1 then 1000000 else if Int.ofNat move = k2 then 500000 else 0)+ctx.history.getD move 0
   else 0
  let child := (playMove board (some move) color).2
  let (black,white) := countedCommand child
  let num := if color = 1 then black else white
  let dr := Int.ofNat (move/board.size)-Int.ofNat (board.size/2)
  let dc := Int.ofNat (move%board.size)-Int.ofNat (board.size/2)
  {heuristic := score,numerator := num,distance := (dr*dr+dc*dc).toNat,move : ScoredMove}
 sortScored scored

structure SearchScan where
 context : SearchContext
 best : Int := valueFloor
 alpha : Int
 cutoff : Bool := false

def alphaBetaBounded : Nat → GoBoard → Int → Int → Int → Nat → Bool → SearchContext → Int × SearchContext
 | 0, _, _, _, _, _, _, ctx => (valueDraw,ctx)
 | fuel+1, board, depth, alpha, beta, color, lastPassed, ctx =>
  let ctx := {ctx with nodesLeft := ctx.nodesLeft-1}
  if ctx.nodesLeft < 0 then (valueDraw,{ctx with passAborted := 1})
  else
   let key := foldHash board color
   match ttProbe ctx key depth with
   | some value => (value,ctx)
   | none =>
    let stand := if depth ≤ 0 then
      let (black,white) := countedCommand board
      packValue (Int.ofNat (if color = 1 then black else white)) (Int.ofNat (black+white))
     else valueFloor
    if depth ≤ 0 ∧ (depth ≤ -8 ∨ valueGreater stand beta ∨ stand = beta) then (stand,ctx)
    else
     let alpha := if depth ≤ 0 ∧ valueGreater stand alpha then stand else alpha
     let candidates := dynamicSparseMoves board color (legalMoves board color) (decide (depth ≤ 0))
     if depth ≤ 0 ∧ candidates.isEmpty then (stand,ctx)
     else
      let moves := scoreMoves board depth color ctx candidates
      let scan : SearchScan := {context := ctx,alpha}
      let result := moves.foldl (fun acc scored =>
       if acc.cutoff ∨ acc.context.passAborted = 1 then acc
       else
        let child := (playMove board (some scored.move) color).2
        let (childVal,nextCtx) := alphaBetaBounded fuel child (depth-1) (invertValue beta) (invertValue acc.alpha) (3-color) false acc.context
        if nextCtx.passAborted = 1 then {acc with context := nextCtx}
        else
         let mine := invertValue childVal
         let best := bif valueGreater mine acc.best then mine else acc.best
         let a := bif valueGreater mine acc.alpha then mine else acc.alpha
         if valueGreater a beta ∨ a = beta then
          let ctx := if depth > 0 then
            let history := nextCtx.history.setIfInBounds scored.move (nextCtx.history.getD scored.move 0+Int.ofNat (2^depth.toNat))
            let (k1,_) := nextCtx.killers.getD depth.toNat (-1,-1)
            let killers := if k1 ≠ Int.ofNat scored.move then nextCtx.killers.setIfInBounds depth.toNat (Int.ofNat scored.move,k1) else nextCtx.killers
            {nextCtx with history,killers}
           else nextCtx
          {context := ttStore ctx key depth best,best,alpha := a,cutoff := true}
         else {acc with context := nextCtx,best,alpha := a}) scan
      bif result.cutoff then (result.best,result.context)
      else
       let (best,ctx) := if moves.isEmpty then
         bif lastPassed then
          let (black,white) := countedCommand board
          (packValue (Int.ofNat (if color = 1 then black else white)) (Int.ofNat (black+white)),result.context)
         else
          let (child,ctx) := alphaBetaBounded fuel board (depth-1) (invertValue beta) (invertValue result.alpha) (3-color) true result.context
          let mine := invertValue child
          if ctx.passAborted = 0 ∧ valueGreater mine result.best then (mine,ctx) else (result.best,ctx)
        else (result.best,result.context)
       (best,ttStore ctx key depth best)

def alphaBeta (board : GoBoard) (depth alpha beta : Int) (color : Nat) (lastPassed : Bool) (ctx : SearchContext) : Int × SearchContext :=
 alphaBetaBounded ((depth+8).toNat+1) board depth alpha beta color lastPassed ctx
end SFT.Applications.FoldGo

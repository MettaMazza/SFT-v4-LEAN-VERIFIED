import SFT.Applications.FoldChess.Quiescence
namespace SFT.Applications.FoldChess

structure SearchScan extends QScan where
 bestMove : Int := -1

def storeTT (ctx : SearchContext) (key slot move : Int) : SearchContext :=
 {ctx with ttKeys := writeSquare ctx.ttKeys slot key, ttMoves := writeSquare ctx.ttMoves slot move, ttStamp := writeSquare ctx.ttStamp slot ctx.ttGen}

def searchValueBounded : Nat → Board → Int → Int → Int → Int → Int → SearchContext → Int × SearchContext
 | 0, _, _, _, _, _, _, ctx =>
  (65538,{ctx with nodesLeft := ctx.nodesLeft-1,passAborted := 1})
 | fuel+1, state, depth, alphaNum, alphaDen, betaNum, betaDen, ctx =>
  let ctx := {ctx with nodesLeft := ctx.nodesLeft-1}
  if ctx.nodesLeft < 0 then (65538,{ctx with passAborted := 1})
  else if readSquare state 70 > 99 then (65538,ctx)
  else if depth = 0 then quiescence state alphaNum alphaDen betaNum betaDen 1 ctx
  else
   let side := readSquare state 64
   let kingFrom := kingSquare state side
   let pseudo := pseudoMoves state
   let useTT := decide (depth > 1 ∧ ctx.ttGen > 0)
   let key := bif useTT then ttKey state else 0
   let slot := key-key.tdiv 262144*262144
   let ttMove := if useTT ∧ readSquare ctx.ttStamp slot = ctx.ttGen ∧ readSquare ctx.ttKeys slot = key
      then readSquare ctx.ttMoves slot else -1
   let k1 := if ctx.killerA.size > 63 then readSquare ctx.killerA depth else -1
   let k2 := if ctx.killerA.size > 63 then readSquare ctx.killerB depth else -1
   let initial : SearchScan := {context := ctx,alphaNum,alphaDen}
   let result := ([-1,0,1,2,3] : List Int).foldl (fun scan bucket =>
    pseudo.toList.foldl (fun acc move =>
     bif acc.stopped then acc else
      let rest := move-move.tdiv 4096*4096
      let fromSq := rest.tdiv 64
      let toSq := rest-fromSq*64
      let victim := readSquare state toSq
      let taking := moveIsCapture state move
      let heavy := decide (victim > 0 ∧ countedReach (pieceKind victim) toSq 0 > 8)
      let wanted := if bucket = -1 then decide (ttMove > -1 ∧ move = ttMove)
       else if move = ttMove then false
       else if bucket = 0 then taking && heavy
       else if bucket = 1 then taking && !heavy
       else if bucket = 2 then !taking && decide (move = k1 ∨ move = k2)
       else !taking && decide (move ≠ k1 ∧ move ≠ k2)
      bif wanted then
       let child := makeMove state move
       let kingNow := if fromSq = kingFrom then toSq else kingFrom
       bif squareAttacked child kingNow (1-side) then acc
       else
        let acc : SearchScan := {acc with legalSeen := acc.legalSeen+1}
        let (deeper,nextCtx) := if acc.legalSeen = 1 then
          searchValueBounded fuel child (depth-1) (betaDen-betaNum) betaDen
           (acc.alphaDen-acc.alphaNum) acc.alphaDen acc.context
         else
          let (probe,probeCtx) := searchValueBounded fuel child (depth-1)
           (acc.alphaDen-acc.alphaNum) acc.alphaDen (acc.alphaDen-acc.alphaNum) acc.alphaDen acc.context
          let probeNum := (probe-probe.tdiv 65536*65536)-probe.tdiv 65536
          let probeDen := probe-probe.tdiv 65536*65536
          if probeNum*acc.alphaDen > acc.alphaNum*probeDen then
           searchValueBounded fuel child (depth-1) (betaDen-betaNum) betaDen
            (acc.alphaDen-acc.alphaNum) acc.alphaDen probeCtx
          else (probe,probeCtx)
        let childNum := deeper.tdiv 65536
        let childDen := deeper-childNum*65536
        let myNum := childDen-childNum
        let myDen := childDen
        let improved := decide (myNum*acc.bestDen > acc.bestNum*myDen)
        let acc : SearchScan := {acc with context := nextCtx, bestNum := bif improved then myNum else acc.bestNum, bestDen := bif improved then myDen else acc.bestDen, bestMove := bif improved then move else acc.bestMove}
        if myNum*betaDen > betaNum*myDen then
         let ctx := bif useTT then storeTT acc.context key slot move else acc.context
         let ctx := if !taking ∧ ctx.killerA.size > 63 ∧ move ≠ k1 then
           {ctx with killerB := writeSquare ctx.killerB depth k1, killerA := writeSquare ctx.killerA depth move}
          else ctx
         {acc with context := ctx,stopped := true}
        else if myNum*acc.alphaDen > acc.alphaNum*myDen then
         {acc with alphaNum := myNum,alphaDen := myDen}
        else acc
      else acc) scan) initial
   bif result.stopped then (result.bestNum*65536+result.bestDen,result.context)
   else
    let ctx := if useTT ∧ result.bestMove > -1 then storeTT result.context key slot result.bestMove else result.context
    if result.legalSeen = 0 then
     bif sideInCheck state then (66560+depth,ctx) else (65538,ctx)
    else (result.bestNum*65536+result.bestDen,ctx)

def searchValue (state : Board) (depth alphaNum alphaDen betaNum betaDen : Int)
 (ctx : SearchContext) : Int × SearchContext :=
 searchValueBounded (ctx.nodesLeft.toNat+1) state depth alphaNum alphaDen betaNum betaDen ctx
end SFT.Applications.FoldChess

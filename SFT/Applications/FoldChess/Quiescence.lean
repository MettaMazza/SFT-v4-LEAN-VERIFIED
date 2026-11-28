import SFT.Applications.FoldChess.Endgame
namespace SFT.Applications.FoldChess

structure SearchContext where
 nodesLeft : Int := 0
 passAborted : Int := 0
 ttKeys : Board := #[]
 ttMoves : Board := #[]
 ttStamp : Board := #[]
 ttGen : Int := 0
 killerA : Board := #[]
 killerB : Board := #[]

def ttKey (state : Board) : Int :=
 (List.range 70).foldl (fun k i =>
  let next := k*131+readSquare state (Int.ofNat i)
  next-next.tdiv 36028797018963913*36028797018963913) 0

def ttEnsure (ctx : SearchContext) : SearchContext :=
 let sized := (List.range (262144-ctx.ttKeys.size)).foldl (fun c _ =>
  {c with ttKeys := c.ttKeys.push 0, ttMoves := c.ttMoves.push 0, ttStamp := c.ttStamp.push 0}) ctx
 (List.range (64-sized.killerA.size)).foldl (fun c _ =>
  {c with killerA := c.killerA.push (-1), killerB := c.killerB.push (-1)}) sized

structure QScan where
 context : SearchContext
 bestNum : Int := 0
 bestDen : Int := 1
 alphaNum : Int
 alphaDen : Int
 legalSeen : Int := 0
 stopped : Bool := false

-- The recursion index comes from the source's remaining node counter, never
-- from a new search setting. Each descent consumes a source node first.
def quiescenceBounded : Nat → Board → Int → Int → Int → Int → Int → SearchContext → Int × SearchContext
 | 0, _, _, _, _, _, _, ctx =>
  (65538, {ctx with nodesLeft := ctx.nodesLeft-1, passAborted := 1})
 | fuel+1, state, alphaNum, alphaDen, betaNum, betaDen, fresh, ctx =>
  let ctx := {ctx with nodesLeft := ctx.nodesLeft-1}
  if ctx.nodesLeft < 0 then (65538,{ctx with passAborted := 1})
  else if readSquare state 70 > 99 then (65538,ctx)
  else
   let side := readSquare state 64
   let kingFrom := kingSquare state side
   let checked := squareAttacked state kingFrom (1-side)
   let enemyKing := kingSquare state (1-side)
   let initial : QScan :=
    bif checked then {context := ctx, alphaNum, alphaDen}
    else
     let standNum := sideUnits state side
     let standDen := standNum+sideUnits state (1-side)
     let improves := decide (standNum*alphaDen > alphaNum*standDen)
     {context := ctx, bestNum := standNum, bestDen := standDen,
      alphaNum := bif improves then standNum else alphaNum,
      alphaDen := bif improves then standDen else alphaDen,
      stopped := decide (standNum*betaDen > betaNum*standDen)}
   let pseudo := pseudoMoves state
   let buckets := bif checked || decide (fresh = 1) then [0,1,2] else [0,1]
   let result := (buckets : List Int).foldl (fun scan bucket =>
    pseudo.toList.foldl (fun acc move =>
     bif acc.stopped then acc else
      let taking := moveIsCapture state move
      bif taking || checked || decide (fresh = 1) then
       let rest := move-move.tdiv 4096*4096
       let fromSq := rest.tdiv 64
       let toSq := rest-fromSq*64
       let victim := readSquare state toSq
       let heavy := decide (victim > 0 ∧ countedReach (pieceKind victim) toSq 0 > 8)
       let wanted := if bucket = 0 then taking && heavy
         else if bucket = 1 then taking && !heavy else !taking
       let worth := taking || checked || couldCheckFrom (pieceKind (readSquare state fromSq)) toSq enemyKing side
       bif wanted && worth then
        let child := makeMove state move
        let kingNow := if fromSq = kingFrom then toSq else kingFrom
        bif squareAttacked child kingNow (1-side) then acc
        else
         let acc := {acc with legalSeen := acc.legalSeen+1}
         bif taking || checked || squareAttacked child enemyKing side then
          let (deeper,nextCtx) := quiescenceBounded fuel child (betaDen-betaNum) betaDen
            (acc.alphaDen-acc.alphaNum) acc.alphaDen 0 acc.context
          let childNum := deeper.tdiv 65536
          let childDen := deeper-childNum*65536
          let myNum := childDen-childNum
          let myDen := childDen
          let improved := decide (myNum*acc.bestDen > acc.bestNum*myDen)
          let cut := decide (myNum*betaDen > betaNum*myDen)
          let raises := !cut && decide (myNum*acc.alphaDen > acc.alphaNum*myDen)
          {acc with context := nextCtx, bestNum := bif improved then myNum else acc.bestNum, bestDen := bif improved then myDen else acc.bestDen, alphaNum := bif raises then myNum else acc.alphaNum, alphaDen := bif raises then myDen else acc.alphaDen, stopped := cut}
         else acc
       else acc
      else acc) scan) initial
   bif result.stopped then (result.bestNum*65536+result.bestDen,result.context)
   else if checked ∧ result.legalSeen = 0 then (66560,result.context)
   else (result.bestNum*65536+result.bestDen,result.context)

def quiescence (state : Board) (alphaNum alphaDen betaNum betaDen fresh : Int)
 (ctx : SearchContext) : Int × SearchContext :=
 quiescenceBounded (ctx.nodesLeft.toNat+1) state alphaNum alphaDen betaNum betaDen fresh ctx
end SFT.Applications.FoldChess

import SFT.Applications.FoldChess.Search
namespace SFT.Applications.FoldChess

def decimalDigits : Nat → Nat → List Char → List Char
 | 0, _, acc => acc
 | fuel+1, n, acc =>
  let acc := Char.ofNat (48+n%10)::acc
  if n < 10 then acc else decimalDigits fuel (n/10) acc

def integerText (n : Int) : String :=
 let chars := decimalDigits (n.natAbs+1) n.natAbs []
 String.ofList (if n < 0 then '-'::chars else chars)

def stateSignature (state : Board) : String :=
 (List.range 70).foldl (fun text i => SFT.Host.Text.append text
  (SFT.Host.Text.append (integerText (readSquare state (Int.ofNat i))) ".")) "|"

def rootPass (state : Board) (depth : Int) (seen : String) (preMove : Int)
 (ctx : SearchContext) : Board × SearchContext :=
 let leftAtEntry := ctx.nodesLeft
 let moves := orderedMoves state
 if moves.size = 0 then
  (#[ -1,1,(bif sideInCheck state then 1024+depth else 2),1],ctx)
 else
  let sequence := (if preMove < 0 then [] else [preMove]) ++
    moves.toList.filter (fun move => decide (move ≠ preMove))
  let (bestMove,bestNum,bestDen,ctx) := sequence.foldl (fun (bm,bn,bd,c) move =>
   let child := makeMove state move
   let (myNum,myDen,nextCtx) := bif SFT.Host.Text.contains seen (stateSignature child) then (1,2,c)
    else
     let (deeper,nextCtx) := searchValue child (depth-1) 0 1 (bd-bn) bd c
     let cn := deeper.tdiv 65536
     let cd := deeper-cn*65536
     (cd-cn,cd,nextCtx)
   if myNum*bd > bn*myDen then (move,myNum,myDen,nextCtx)
   else (bm,bn,bd,nextCtx)) ((moves.getD 0 0,0,1,ctx) : Int×Int×Int×SearchContext)
  (#[bestMove,bestNum,bestDen,1+leftAtEntry-ctx.nodesLeft],ctx)

structure DeepeningState where
 context : SearchContext
 remaining : Int
 preMove : Int := -1
 finalMove : Int := -1
 finalNum : Int := 1
 finalDen : Int := 2
 depth : Int := 2
 climbing : Bool := true

def deepen (state : Board) (ceiling : Int) (seen : String) : Nat → DeepeningState → DeepeningState
 | 0, d => d
 | n+1, d =>
  bif d.climbing then
   let ctx := {d.context with nodesLeft := d.remaining,passAborted := 0}
   let (result,ctx) := rootPass state d.depth seen d.preMove ctx
   let d : DeepeningState := {d with context := ctx,remaining := ctx.nodesLeft}
   if ctx.passAborted = 1 then
    if d.finalMove < 0 then
     {d with finalMove := readSquare result 0,finalNum := readSquare result 1,finalDen := readSquare result 2,climbing := false}
    else {d with climbing := false}
   else
    let move := readSquare result 0
    let next : DeepeningState := {d with finalMove := move, finalNum := readSquare result 1, finalDen := readSquare result 2, preMove := move, depth := d.depth+1, climbing := decide (d.depth+1 ≤ ceiling ∧ ctx.nodesLeft ≥ 1 ∧ move ≥ 0)}
    deepen state ceiling seen n next
  else d

def searchBestSeen (state : Board) (ceiling : Int) (seen : String) (ctx : SearchContext) : Board × SearchContext :=
 let ctx := ttEnsure ctx
 let ctx := {ctx with ttGen := ctx.ttGen+1}
 let result := deepen state ceiling seen (ceiling.toNat+2) {context := ctx, remaining := thinkingBudget}
 (#[result.finalMove,result.finalNum,result.finalDen],result.context)

def searchBest (state : Board) (depth : Int) (ctx : SearchContext) : Board × SearchContext :=
 let ctx := {ctx with nodesLeft := 1152921504606846976,passAborted := 0}
 let (result,ctx) := rootPass state depth "" (-1) ctx
 (#[readSquare result 0,readSquare result 1,readSquare result 2],ctx)
end SFT.Applications.FoldChess

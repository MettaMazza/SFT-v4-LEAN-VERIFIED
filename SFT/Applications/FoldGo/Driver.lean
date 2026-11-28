import SFT.Applications.FoldGo.Search
namespace SFT.Applications.FoldGo

structure RootPassState where
 context : SearchContext
 move : Option Nat := none
 value : Int := valueFloor
 alpha : Int := valueFloor

def rootPass (board : GoBoard) (color : Nat) (depth : Int) (candidates : List Nat) (ctx : SearchContext) : RootPassState :=
 candidates.foldl (fun pass move =>
  if pass.context.passAborted = 1 then pass
  else
   let child := (playMove board (some move) color).2
   let (childValue,ctx) := alphaBeta child (depth-1) (invertValue valueCeiling) (invertValue pass.alpha) (3-color) false pass.context
   if ctx.passAborted = 1 then {pass with context := ctx}
   else
    let mine := invertValue childValue
    let improves := valueGreater mine pass.value
    {context := ctx, move := bif improves then some move else pass.move, value := bif improves then mine else pass.value, alpha := bif valueGreater mine pass.alpha then mine else pass.alpha}) {context := ctx}

structure RootState where
 context : SearchContext
 move : Nat
 value : Int := valueFloor

def selectMoveWithContext (board : GoBoard) (color : Nat) (ceiling : Int) (ctx : SearchContext) : Option Nat × SearchContext :=
 let legal := legalMoves board color
 match legal with
 | [] => (none,ctx)
 | single::rest =>
  if rest.isEmpty then (some single,ctx)
  else
   let candidates := dynamicSparseMoves board color legal
   let ctx := {ctx with generation := ctx.generation+1, nodesLeft := 524288, passAborted := 0, history := (List.replicate 1024 0).toArray, killers := (List.replicate 64 (-1,-1)).toArray}
   let result := (List.range ceiling.toNat).foldl (fun state n =>
    if state.context.passAborted = 1 then state
    else
     let pass := rootPass board color (Int.ofNat (n+1)) candidates state.context
     if pass.context.passAborted = 0 then
      match pass.move with
      | some move => {context := pass.context,move,value := pass.value}
      | none => {state with context := pass.context}
     else {state with context := pass.context}) ({context := ctx,move := candidates.headD 0} : RootState)
   (some result.move,result.context)

def selectMove (board : GoBoard) (color : Nat) (ceiling : Int := 8) : Option Nat :=
 (selectMoveWithContext board color ceiling {}).1
end SFT.Applications.FoldGo

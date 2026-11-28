import SFT.Applications.FoldGo.Selection
namespace SFT.Applications.FoldGo

structure SearchContext where
 keys : Array Nat := (List.replicate 262144 0).toArray
 values : Array Int := (List.replicate 262144 0).toArray
 depths : Array Int := (List.replicate 262144 0).toArray
 stamps : Array Nat := (List.replicate 262144 0).toArray
 generation : Nat := 1
 history : Array Int := (List.replicate 1024 0).toArray
 killers : Array (Int×Int) := (List.replicate 64 (-1,-1)).toArray
 nodesLeft : Int := 524288
 passAborted : Int := 0

def ttProbe (ctx : SearchContext) (key : Nat) (depth : Int) : Option Int :=
 let slot := key%262144
 if ctx.stamps.getD slot 0 = ctx.generation ∧ ctx.keys.getD slot 0 = key ∧ ctx.depths.getD slot 0 ≥ depth
 then some (ctx.values.getD slot 0) else none

def ttStore (ctx : SearchContext) (key : Nat) (depth value : Int) : SearchContext :=
 let slot := key%262144
 {ctx with keys := ctx.keys.setIfInBounds slot key, values := ctx.values.setIfInBounds slot value, depths := ctx.depths.setIfInBounds slot depth, stamps := ctx.stamps.setIfInBounds slot ctx.generation}

def areaScore (board : GoBoard) : Nat × Nat :=
 let black := board.cells.toList.foldl (fun n c => if c = 1 then n+1 else n) 0
 let white := board.cells.toList.foldl (fun n c => if c = 2 then n+1 else n) 0
 let (_,black,white) := (List.range (board.size*board.size)).foldl (fun (visited,black,white) i =>
  if board.cells.getD i 0 = 0 ∧ !(visited.contains i) then
   let region := regionWalk board (board.size*board.size) {region := [i],queue := [i]}
   let visited := region.region.foldl insertSquare visited
   if region.borders.length = 1 then
    let color := region.borders.headD 0
    if color = 1 then (visited,black+region.region.length,white)
    else if color = 2 then (visited,black,white+region.region.length)
    else (visited,black,white)
   else (visited,black,white)
  else (visited,black,white)) (([],black,white) : List Nat×Nat×Nat)
 (black,white)
end SFT.Applications.FoldGo

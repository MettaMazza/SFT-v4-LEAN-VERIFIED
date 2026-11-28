import SFT.Applications.FoldGo.Hashing
namespace SFT.Applications.FoldGo

structure RegionWalk where
 region : List Nat
 queue : List Nat
 borders : List Nat := []

def regionWalk (board : GoBoard) : Nat → RegionWalk → RegionWalk
 | 0, r => r
 | n+1, r =>
  match r.queue with
  | [] => r
  | curr::rest =>
   let next := (neighbors board curr).foldl (fun acc p =>
    let color := board.cells.getD p 0
    if color = 0 then
     if acc.region.contains p then acc
     else {acc with region := acc.region++[p],queue := acc.queue++[p]}
    else {acc with borders := insertSquare acc.borders color}) {r with queue := rest}
   regionWalk board n next

def countedCommand (board : GoBoard) : Nat × Nat :=
 let (_,black,white) := (List.range (board.size*board.size)).foldl (fun (visited,black,white) i =>
  if board.cells.getD i 0 ≠ 0 ∧ !(visited.contains i) then
   let (group,libs) := getGroup board i
   let visited := group.foldl insertSquare visited
   let units := group.length+libs.length
   if board.cells.getD i 0 = 1 then (visited,black+units,white)
   else (visited,black,white+units)
  else (visited,black,white)) (([],0,0) : List Nat×Nat×Nat)
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
 if black = 0 ∧ white = 0 then (1,1) else (black,white)

def packBase : Int := 65536

def packValue (num den : Int) : Int := num*packBase+den

def unpackValue (packed : Int) : Int × Int := (packed/packBase,packed%packBase)

def valueGreater (a b : Int) : Bool :=
 let (an,ad) := unpackValue a
 let (bn,bd) := unpackValue b
 decide (an*bd > bn*ad)

def valueFloor : Int := packValue 0 1
def valueCeiling : Int := packValue 1 1
def valueDraw : Int := packValue 1 2

def invertValue (packed : Int) : Int :=
 let (num,den) := unpackValue packed
 packValue (den-num) den
end SFT.Applications.FoldGo

import SFT.Applications.FoldChess.Driver
namespace SFT.Applications.FoldGo

structure GoBoard where
 size : Nat := 9
 cells : Array Nat := (List.replicate 81 0).toArray
 koSquare : Option Nat := none
 history : List String := []

def emptyBoard (size : Nat := 9) : GoBoard :=
 {size,cells := (List.replicate (size*size) 0).toArray}

def copyBoard (board : GoBoard) : GoBoard := board

def neighbors (board : GoBoard) (idx : Nat) : List Nat :=
 let row := Int.ofNat (idx/board.size)
 let col := Int.ofNat (idx%board.size)
 ([(-1,0),(1,0),(0,-1),(0,1)] : List (Int×Int)).filterMap fun (dr,dc) =>
  let nr := row+dr
  let nc := col+dc
  if 0 ≤ nr ∧ nr < Int.ofNat board.size ∧ 0 ≤ nc ∧ nc < Int.ofNat board.size then
   some (nr.toNat*board.size+nc.toNat)
  else none

def insertSquare (xs : List Nat) (n : Nat) : List Nat :=
 if xs.contains n then xs else xs++[n]

structure GroupWalk where
 group : List Nat
 liberties : List Nat := []
 queue : List Nat

-- One queued visit per board square; newly encountered stones are recorded
-- before enqueueing, exactly as in the source's visited set.
def groupWalk (board : GoBoard) (color : Nat) : Nat → GroupWalk → GroupWalk
 | 0, g => g
 | n+1, g =>
  match g.queue with
  | [] => g
  | curr::rest =>
   let next := (neighbors board curr).foldl (fun a square =>
    let cell := board.cells.getD square 0
    if cell = 0 then {a with liberties := insertSquare a.liberties square}
    else if cell = color ∧ !(a.group.contains square) then
     {a with group := a.group++[square],queue := a.queue++[square]}
    else a) {g with queue := rest}
   groupWalk board color n next

def getGroup (board : GoBoard) (start : Nat) : List Nat × List Nat :=
 let color := board.cells.getD start 0
 if color = 0 then ([],[])
 else
  let g := groupWalk board color (board.size*board.size) {group := [start],queue := [start]}
  (g.group,g.liberties)

def boardKey (board : GoBoard) : String :=
 SFT.Host.Text.join (board.cells.toList.map fun n => SFT.Applications.FoldChess.integerText (Int.ofNat n))

def captureAfterPlacement (board : GoBoard) (idx color : Nat) : GoBoard :=
 let opponent := 3-color
 let captured := (neighbors board idx).foldl (fun captured square =>
  if board.cells.getD square 0 = opponent then
   let (group,libs) := getGroup board square
   if libs.isEmpty then captured++group else captured
  else captured) []
 let cells := captured.foldl (fun cells square => cells.setIfInBounds square 0) board.cells
 {board with cells}

def isLegal (board : GoBoard) (idx color : Nat) : Bool :=
 if board.cells.getD idx 0 ≠ 0 then false
 else if board.koSquare = some idx then false
 else
  let test := captureAfterPlacement {board with cells := board.cells.setIfInBounds idx color} idx color
  let (_,libs) := getGroup test idx
  if libs.isEmpty then false
  else !(board.history.any fun old => SFT.Host.Text.equal old (boardKey test))

def retainHistory (board : GoBoard) : GoBoard :=
 let key := boardKey board
 if board.history.any (fun old => SFT.Host.Text.equal old key) then board
 else {board with history := board.history++[key]}

def playMove (board : GoBoard) (idx : Option Nat) (color : Nat) : Bool × GoBoard :=
 match idx with
 | none => (true,{retainHistory board with koSquare := none})
 | some square =>
  if !(isLegal board square color) then (false,board)
  else
   let placed := {board with cells := board.cells.setIfInBounds square color}
   let captured := captureAfterPlacement placed square color
   (true,retainHistory {captured with koSquare := none})

def legalMoves (board : GoBoard) (color : Nat) : List Nat :=
 (List.range (board.size*board.size)).filter fun idx => isLegal board idx color
end SFT.Applications.FoldGo

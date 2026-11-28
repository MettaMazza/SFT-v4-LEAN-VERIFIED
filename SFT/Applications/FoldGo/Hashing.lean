import SFT.Applications.FoldGo.Board
namespace SFT.Applications.FoldGo

def transformedIndex (p size t : Nat) : Nat :=
 let row := p/size
 let col := p%size
 let (r,c) := if t = 0 then (row,col)
  else if t = 1 then (size-1-row,col)
  else if t = 2 then (row,size-1-col)
  else if t = 3 then (size-1-row,size-1-col)
  else if t = 4 then (col,row)
  else if t = 5 then (size-1-col,row)
  else if t = 6 then (col,size-1-row)
  else (size-1-col,size-1-row)
 r*size+c

def lexLess : List Nat → List Nat → Bool
 | [], [] => false
 | [], _::_ => true
 | _::_, [] => false
 | a::as, b::bs => if a = b then lexLess as bs else decide (a < b)

def canonicalState (cells : Array Nat) (size : Nat) (ko : Option Nat) : Array Nat × Option Nat :=
 ([1,2,3,4,5,6,7] : List Nat).foldl (fun (best,bestKo) t =>
  let arr := (List.range (size*size)).foldl (fun acc i =>
   acc.setIfInBounds (transformedIndex i size t) (cells.getD i 0)) ((List.replicate (size*size) 0).toArray)
  bif lexLess arr.toList best.toList then (arr,ko.map fun p => transformedIndex p size t)
  else (best,bestKo)) (cells,ko)

def foldHash (board : GoBoard) (color : Nat) : Nat :=
 let (cells,ko) := canonicalState board.cells board.size board.koSquare
 let k := (List.range (board.size*board.size)).foldl (fun k i => (k*131+cells.getD i 0)%36028797018963913) 0
 let k := (k*131+color)%36028797018963913
 match ko with
 | none => k
 | some p => (k*131+p+1)%36028797018963913

def boardSymmetries (cells : Array Nat) (size : Nat) : List Nat :=
 0::([1,2,3,4,5,6,7] : List Nat).filter (fun t =>
  (List.range (size*size)).all fun i => decide (cells.getD i 0 = cells.getD (transformedIndex i size t) 0))

def orbitRepresentative (p size : Nat) (allowed : List Nat) : Nat :=
 allowed.foldl (fun rep t => min rep (transformedIndex p size t)) p
end SFT.Applications.FoldGo

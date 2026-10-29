import SFT.Physics.LeptonIntervals
open SFT.Physics.LeptonIntervals
def mk (n : Int) (d : Nat) : Rat := if h : 0 < d then normalize n d h else zero
def emit (x : Rat) : IO Unit := if x.den == 1 then IO.println s!"{x.num}" else IO.println s!"{x.num}/{x.den}"
def points : List Rat := [mk (-3) 1,mk (-3) 2,mk (-1) 1,mk (-3) 4,mk (-2) 1,mk (-1) 1,mk (-2) 3,mk (-1) 2,mk (-1) 1,mk (-1) 2,mk (-1) 3,mk (-1) 4,mk (0) 1,mk (0) 1,mk (0) 1,mk (0) 1,mk (1) 1,mk (1) 2,mk (1) 3,mk (1) 4,mk (2) 1,mk (1) 1,mk (2) 3,mk (1) 2,mk (3) 1,mk (3) 2,mk (1) 1,mk (3) 4]
def products : List Rat := [mk (3) 1454,mk (15659709397871168801443815466454510956837000584115) 7590004776733382935404977537704409308185713931574254]
def main : IO Unit := do
 for a in points do
  for b in points do
   emit (add a b)
   emit (subtract a b)
   emit (multiply a b)
 for p in products do
  for a in points do
   emit (cubic a (mk 1 6) p)
  for a in points do
   for b in points do
    if !a.blt zero && !b.blt a && !(mk 1 1).blt b then
     let bracket := bisectRoot (a,b) (mk 1 6) p
     emit bracket.1
     emit bracket.2

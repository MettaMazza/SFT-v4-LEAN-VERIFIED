import SFT.Physics.LeptonRefinement
open SFT.Physics LeptonIntervals LeptonRatios LeptonIsolation LeptonRefinement
def mk (n : Int) (d : Nat) : Rat := if h : 0 < d then normalize n d h else zero
def value (x : Rat) : String := s!"{x.num}/{x.den}"
def emitPair (result : Except String (Rat × Rat)) : IO Unit := match result with
 | .error _ => IO.println "error"
 | .ok (a,b) => IO.println (value a ++ " " ++ value b)
def points : List Rat := [mk (-3) 1,mk (-3) 2,mk (-1) 1,mk (-2) 1,mk (-1) 1,mk (-2) 3,mk (-1) 1,mk (-1) 2,mk (-1) 3,mk (0) 1,mk (0) 1,mk (0) 1,mk (1) 1,mk (1) 2,mk (1) 3,mk (2) 1,mk (1) 1,mk (2) 3,mk (3) 1,mk (3) 2,mk (1) 1]
def brackets : List (Rat × Rat) := [(mk (-1) 1,mk (0) 1),(mk (0) 1,mk (1) 1),(mk (1) 1,mk (0) 1),(mk (1) 1,mk (-1) 1),(mk (1) 1,mk (1) 1),(mk (1) 1,mk (2) 1),(mk (2) 1,mk (1) 1),(mk (2) 1,mk (3) 1),(mk (3) 1,mk (2) 1)]
def indices : List Int := [-5,-4,-3,-2,-1,0,1,2,3,4,5]
def main : IO Unit := do
 for a in points do
  for b in points do
   match divide a b with
   | .error _ => IO.println "error"
   | .ok x => IO.println (value x)
 for a in brackets do
  for b in brackets do
   emitPair (squaredRatio a b)
 for i in indices do
  match pythonIndex [0,1,2] i with
  | .error _ => IO.println "error"
  | .ok n => IO.println s!"{n}"
 let product ← match LeptonTerminal.terminalProduct with
  | .error e => throw (IO.userError e)
  | .ok x => pure (BoundaryGrowth.asFraction x)
 let initial ← match terminalSearch with
  | .error e => throw (IO.userError e)
  | .ok none => throw (IO.userError "incomplete isolation")
  | .ok (some b) => pure b
 for (denominator,steps) in [(0,27),(2,15)] do
  let mut current := initial
  for _ in List.range steps do
   emitPair (prediction 1 denominator current)
   current := refine pairSum product current

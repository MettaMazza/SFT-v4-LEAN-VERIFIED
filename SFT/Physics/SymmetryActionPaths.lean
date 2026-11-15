import SFT.Physics.SymmetryAction
import SFT.Physics.LeptonIntervals
import SFT.Mathematics.LimitComputations
namespace SFT.Physics.SymmetryActionPaths
open SymmetryAction LeptonIntervals
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
inductive Orientation where | lower | upper
def orientationName : Orientation → String
 | .lower => "toward-lower-carrier"
 | .upper => "toward-upper-carrier"
inductive Magnitude where | empty | step (orientation : Orientation) (value : Rat)
def positiveCoordinate : Input → Except String Rat
 | .nonFraction => .error "path coordinates must be exact positive carriers"
 | .fraction x => if zero.blt x then .ok x else .error "path coordinates must be exact positive carriers"
def orientedMagnitude (source target : Input) : Except String Magnitude := do
 let a ← positiveCoordinate source
 let b ← positiveCoordinate target
 if equalRat a b then pure .empty
 else if b.blt a then pure (.step .lower (subtract a b))
 else pure (.step .upper (subtract b a))
def stepValue (source target : Input) : Except String Rat := do
 match ← orientedMagnitude source target with
 | .empty => .error "an empty repeated-state act is not a path transition"
 | .step _ value => pure value
def appendAction : Input → List Input → Rat → Except String Rat
 | _,[],total => if zero.blt total then .ok total else .error "path action must retain a positive carrier"
 | source,target::rest,total => do
  let step ← stepValue source target
  appendAction target rest (add total step)
def pathAction : List Input → Except String Rat
 | [] => .error "an action path requires two generated endpoints"
 | [_] => .error "an action path requires two generated endpoints"
 | source::target::rest => do
  let first ← stepValue source target
  appendAction target rest first
def endpointSeparation : List Input → Except String Rat
 | [] => .error "IndexError: tuple index out of range"
 | source::rest => do
  match ← orientedMagnitude source (rest.foldl (fun _ x => x) source) with
  | .empty => .error "distinct endpoints are required"
  | .step _ value => pure value
def isMonotoneDescent : List Input → Except String Bool
 | [] => .ok true
 | [_] => .ok true
 | source::target::rest => do
  match ← orientedMagnitude source target with
  | .empty => .error "IndexError: tuple index out of range"
  | .step .upper _ => pure false
  | .step .lower _ => isMonotoneDescent (target::rest)
def descentTelescopes (path : List Input) : Except String Bool := do
 if ← isMonotoneDescent path then
  let action ← pathAction path
  let distance ← endpointSeparation path
  pure (equalRat action distance)
 else pure false
def detourCannotLowerAction (path : List Input) : Except String Bool := do
 let action ← pathAction path
 let distance ← endpointSeparation path
 pure (!(action.blt distance))
end SFT.Physics.SymmetryActionPaths

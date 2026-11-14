import SFT.Physics.VacuumOddRecurrence
import SFT.Physics.LeptonIntervals
import SFT.Physics.GeneratorOperations
namespace SFT.Physics.OddLatticeAllRegion
open GeneratorOperations LeptonIntervals
open SFT.Host
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def requirePositiveWhole (value : CountInput) (name : String) : Except String Nat :=
 match value with
 | .integer (.ofNat (n+1)) => .ok (n+1)
 | .integer (.ofNat 0) | .integer (.negSucc _) | .boolean _ => .error (Text.append name " must be a positive generated count")
def countInteger : CountInput → Int
 | .integer n => n
 | .boolean true => 1
 | .boolean false => 0
def isOdd (value : CountInput) : Except String Bool := do
 let n ← requirePositiveWhole value "lattice count"
 let pairs := n/2
 pure (pairs+pairs+1==n)
def completeLattice (memberCount : CountInput) : Except String (List Rat) := do
 let n ← requirePositiveWhole memberCount "lattice member count"
 if h : 0<n then pure ((List.range n).map (fun i => normalize (.ofNat (i+1)) n h))
 else throw "lattice member count must be a positive generated count"
def foldLatticeIndex (index memberCount : CountInput) : Except String Nat := do
 let n ← requirePositiveWhole memberCount "lattice member count"
 let odd ← isOdd memberCount
 let i := countInteger index
 if !odd || i<1 || Int.ofNat n<i then throw "Fold permutation requires an odd complete lattice and a member index"
 let doubled := i.toNat+i.toNat
 pure (if doubled≤n then doubled else doubled-n)
def foldIndexTrace (index memberCount stepCount : CountInput) : Except String (List Nat) := do
 let steps ← requirePositiveWhole stepCount "Fold step count"
 let (_,trace) ← (List.range steps).foldlM (fun (current,trace) _ => do
  let next ← foldLatticeIndex current memberCount
  pure (.integer (.ofNat next),trace++[next])) (index,[])
 pure trace
def foldedLattice (memberCount stepCount : CountInput) : Except String (List Rat) := do
 let _ ← requirePositiveWhole stepCount "Fold step count"
 let n := (countInteger memberCount).toNat
 let indices ← (List.range n).mapM (fun i => do
  let trace ← foldIndexTrace (.integer (.ofNat (i+1))) memberCount stepCount
  match trace.reverse with | last::_ => pure last | [] => throw "IndexError")
 if h : 0<n then pure (indices.map (fun i => normalize (.ofNat i) n h))
 else pure []
def positiveRegionLabel (part : Rat) (regionCount : CountInput) : Except String Nat := do
 let r ← requirePositiveWhole regionCount "region count"
 if !zero.blt part || (normalize 1 1 (by decide)).blt part then throw "region observation requires an exact positive Fold part"
 let quotient := (part.num.toNat*r)/part.den
 pure (if quotient==r then 1 else quotient+1)
def occupancyVector (memberCount stepCount regionCount : CountInput) : Except String (List Nat) := do
 let r ← requirePositiveWhole regionCount "region count"
 if countInteger memberCount<Int.ofNat r then throw "all-region occupancy requires no more regions than members"
 let parts ← foldedLattice memberCount stepCount
 let labels ← parts.mapM (fun p => positiveRegionLabel p regionCount)
 pure ((List.range r).map (fun i => (labels.filter (fun label => label==i+1)).length))
end SFT.Physics.OddLatticeAllRegion

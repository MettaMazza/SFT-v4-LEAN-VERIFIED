import SFT.Physics.OddLatticeAllRegion
namespace SFT.Physics.OddLatticeMeasurement
open LeptonIntervals GeneratorOperations
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def legacyFold (part : Rat) : Except String Rat := do
 let one := normalize 1 1 (by decide)
 if !zero.blt part || one.blt part then throw "legacy replication requires an exact positive part"
 let doubled := add part part
 pure (if one.blt doubled then subtract doubled one else doubled)
def observationCount : CountInput → Except String Nat
 | .integer (.ofNat (n+1)) => .ok (n+1)
 | .integer (.ofNat 0) | .integer (.negSucc _) | .boolean _ => .error "released observation inputs must be positive whole counts"
def independentObservation (memberCount stepCount regionCount : CountInput) : Except String (List Nat) := do
 let n ← observationCount memberCount
 let steps ← observationCount stepCount
 let r ← observationCount regionCount
 if h : 0<n then
  let initial := (List.range n).map (fun i => normalize (.ofNat (i+1)) n h)
  let points ← (List.range steps).foldlM (fun points _ => points.mapM legacyFold) initial
  let labels := points.map (fun p => let q := p.num.toNat*r/p.den; if q==r then 1 else q+1)
  pure ((List.range r).map (fun i => (labels.filter (fun label => label==i+1)).length))
 else throw "released observation inputs must be positive whole counts"
structure Analysis where
 memberCount : Int
 stepCount : Int
 regionCount : Int
 completeRecurrenceVector : List Nat
 firstStepVector : List Nat
 depthInvariant : Bool
 allRegionsOccupied : Bool
 completeMemberTotalRetained : Bool
 exactBalanceSpanIsOne : Bool
 legacyAcceptanceRulePassed : Bool
def exactMeasurementAnalysis (members steps regions : Int) : Except String Analysis := do
 let vector ← independentObservation (.integer members) (.integer steps) (.integer regions)
 let first ← independentObservation (.integer members) (.integer 1) (.integer regions)
 match vector with
 | [] => throw "ValueError"
 | a::tail =>
  let occupied := vector.all (fun n => 1≤n)
  pure ⟨members,steps,regions,vector,first,vector==first,occupied,
   decide (Int.ofNat (vector.foldl (·+·) 0)=members),
   tail.foldl Nat.max a == tail.foldl Nat.min a + 1,occupied⟩
end SFT.Physics.OddLatticeMeasurement

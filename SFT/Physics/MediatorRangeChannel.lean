import SFT.Physics.ScatteringPartitionPath
import SFT.Physics.NuclearResidualForceProofs
namespace SFT.Physics.MediatorRangeChannel
open LeptonIntervals
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := normalize 1 1 (by decide)
inductive MassRecord where
 | emptyOne
 | positive (mass : Rat)
def preservedMassRecord : FoldFirstReturn.Input → Except String MassRecord
 | .nonFraction => .error "channel sum must be one exact positive part"
 | .fraction value =>
  if !zero.blt value || one.blt value then .error "channel sum must be one exact positive part"
  else if equalRat value one then .ok .emptyOne else .ok (.positive (subtract one value))
def brokenChannelMass (channel : FoldFirstReturn.Input) : Except String Rat := do
 let record ← preservedMassRecord channel
 match record with
 | .emptyOne => .error "the preserved One has no positive mass shortfall"
 | .positive mass => pure mass
-- Exact subtraction on the common denominator of the original positive share.
-- The numerator strictly decreases; no caller-selected stopping depth is introduced.
def forwardCountsLoop (mass : Nat) : Nat → Nat → List Nat
 | 0,current => [current]
 | fuel+1,current => current :: if 0 < mass ∧ mass < current then forwardCountsLoop mass fuel (current-mass) else []
def forwardCounts (mass current : Nat) : List Nat := forwardCountsLoop mass current current
def positiveForwardTrace : FoldFirstReturn.Input → Except String (List Rat)
 | .nonFraction => .error "massive transport requires a proper positive mass share"
 | .fraction mass =>
  if !zero.blt mass || !mass.blt one then .error "massive transport requires a proper positive mass share"
  else .ok ((forwardCounts mass.num.toNat mass.den).map (fun n => normalize (.ofNat n) mass.den (Nat.pos_of_ne_zero mass.den_nz)))
def finiteReachCount (mass : FoldFirstReturn.Input) : Except String Nat := do
 let trace ← positiveForwardTrace mass
 pure (trace.length-1)
def forwardRestLedger (mass : FoldFirstReturn.Input) : Except String (List (Rat × MassRecord)) := do
 let trace ← positiveForwardTrace mass
 match trace with
 | [] => pure []
 | first::rest => pure ((first,.emptyOne)::rest.map (fun forward => (forward,.positive (subtract one forward))))
def rowConserves : Rat × MassRecord → Bool
 | (forward,.emptyOne) => equalRat forward one
 | (forward,.positive rest) => equalRat (add forward rest) one
def ledgerConservesOne (mass : FoldFirstReturn.Input) : Except String Bool := do
 let rows ← forwardRestLedger mass
 match rows with
 | [] => pure false
 | (forward,record)::tail =>
  let initial := match record with | .emptyOne => equalRat forward one | .positive _ => false
  pure (initial && tail.all rowConserves)
def reciprocalRangeScale (mass : FoldFirstReturn.Input) : Except String Rat :=
 (NuclearResidualForce.mediatorRange mass).mapError (fun _ => "reciprocal range requires one positive mass carrier")
def largerMassShorterRange (smaller larger : ScatteringPartitionPath.OrderedInput) : Except String Bool :=
 if zero.blt (ScatteringPartitionPath.orderedValue smaller) &&
    (ScatteringPartitionPath.orderedValue smaller).blt (ScatteringPartitionPath.orderedValue larger) then do
  let short ← reciprocalRangeScale (ScatteringPartitionPath.exactInput larger)
  let long ← reciprocalRangeScale (ScatteringPartitionPath.exactInput smaller)
  pure (short.blt long)
 else .error "ordered positive mass carriers are required"
def masslessForwardTrace : GeneratorOperations.CountInput → Except String (List Rat)
 | .boolean _ => .error "massless trace requires a positive finite depth"
 | .integer (.negSucc _) => .error "massless trace requires a positive finite depth"
 | .integer (.ofNat 0) => .error "massless trace requires a positive finite depth"
 | .integer (.ofNat (n+1)) => .ok (List.replicate (n+2) one)
def masslessInverseSquare (source radius : FoldFirstReturn.Input) : Except String Rat := do
 let s ← (SymmetryActionPaths.positiveCoordinate source).mapError (fun _ => "inverse-square transport requires positive exact carriers")
 let r ← (SymmetryActionPaths.positiveCoordinate radius).mapError (fun _ => "inverse-square transport requires positive exact carriers")
 LeptonRatios.divide s (multiply r r)
theorem preservedOne : preservedMassRecord (.fraction one)=.ok .emptyOne := rfl
end SFT.Physics.MediatorRangeChannel

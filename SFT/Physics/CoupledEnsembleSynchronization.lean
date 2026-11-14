import SFT.Physics.OddLatticeMeasurement
import SFT.Physics.VacuumScaleProofs
import SFT.Foundation.HalfOneDerivation
namespace SFT.Physics.CoupledEnsembleSynchronization
open LeptonIntervals GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def positiveTake (larger smaller : Rat) : Except String Rat := do
 if !zero.blt smaller || !smaller.blt larger then throw "exact positive take requires ordered positive parts"
 pure (subtract larger smaller)
def pairSeparation (lower upper : Rat) : Except String Rat := do
 if !zero.blt lower || !lower.blt upper || (normalize 1 1 (by decide)).blt upper then
  throw "pair synchronization requires two ordered positive parts"
 positiveTake upper lower
def pairedMove (lower upper coupling : Rat) : Except String (Rat × Rat) := do
 if !zero.blt coupling || !coupling.blt (normalize 1 1 (by decide)) then
  throw "coupling must be one exact proper positive part"
 let separation ← pairSeparation lower upper
 let move := multiply coupling separation
 pure (add lower move,← positiveTake upper move)
def residualRecord (lower upper coupling : Rat) : Except String (List Rat) := do
 let (a,b) ← pairedMove lower upper coupling
 if a==b then pure [] else
  pure [← positiveTake (if a.blt b then b else a) (if a.blt b then a else b)]
def halfOneValue : Rat := SFT.Foundation.ExactPartCarrier.asFraction SFT.Foundation.HalfOneDerivation.halfOne
def uniquePairSynchronizingCoupling : Except String Rat := do
 let candidates := [normalize 1 3 (by decide),halfOneValue,normalize 2 3 (by decide)]
 let rows ← candidates.mapM (fun coupling => do pure (coupling,(← residualRecord (normalize 1 4 (by decide)) (normalize 3 4 (by decide)) coupling).isEmpty))
 let survivors := (rows.filter Prod.snd).map Prod.fst
 if survivors != [normalize 1 2 (by decide)] then throw "complete coupling alternatives did not force the half-One"
 match survivors with | first::_ => pure first | [] => throw "IndexError"
inductive Scale where
 | empty
 | positive (value : Rat)
def residualScale (coupling : Rat) : Except String Scale := do
 let half := halfOneValue
 if coupling==half then pure .empty else
  let doubled := add coupling coupling
  let one := normalize 1 1 (by decide)
  pure (.positive (← if doubled.blt one then positiveTake one doubled else positiveTake doubled one))
def synchronizedEnsembleSuccessor (point : Rat) (memberCount : CountInput) : Except String (List Rat) := do
 if !zero.blt point || (normalize 1 1 (by decide)).blt point then
  throw "synchronized ensemble point must be an exact positive part"
 let n ← match memberCount with
  | .integer (.ofNat (n+2)) => pure (n+2)
  | .integer (.ofNat 0) | .integer (.ofNat 1) | .integer (.negSucc _) | .boolean _ => throw "synchronized ensemble requires a paired positive member count"
 let doubled := add point point
 let folded := if (normalize 1 1 (by decide)).blt doubled then subtract doubled (normalize 1 1 (by decide)) else doubled
 pure ((List.range n).map (fun _ => folded))
theorem halfOneValueExact : halfOneValue=normalize 1 2 (by decide) := rfl
end SFT.Physics.CoupledEnsembleSynchronization

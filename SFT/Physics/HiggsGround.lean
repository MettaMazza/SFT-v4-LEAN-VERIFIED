import SFT.Foundation.HalfOneDerivation
import SFT.Physics.ElectroweakMixing
import SFT.Physics.LeptonRatios
import SFT.Physics.VacuumLedgerProofs
namespace SFT.Physics.HiggsGround
open SFT.Foundation ExactPartCarrier ExactOperations FoldUniformCheck
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Ground where
 | emptyOne
 | part (value : Part)
structure Row where
 form : Ground
 positiveCarrier : Bool
 properPart : Bool
 selfAntipodal : Bool
 foldsToOne : Bool
 displacedGround : Bool
def samePart (a b : Part) : Bool := a.numerator==b.numerator && a.denominator==b.denominator
def vacuumGroundCensus : Except String (List Row) := do
 let half ← ElectroweakMixing.halfOne
 let antipodal := match HalfOneDerivation.complement half with | .error _=>false | .ok other=>samePart other half
 .ok [⟨.emptyOne,false,false,false,false,false⟩,
  ⟨.part half,true,true,antipodal,samePart (foldPart half) one,true⟩,
  ⟨.part one,true,false,false,samePart (foldPart one) one,false⟩]
def accepted (row : Row) : Bool := row.positiveCarrier && row.properPart && row.selfAntipodal && row.foldsToOne && row.displacedGround
def displacedGround : Except String Part := do
 let survivors := (← vacuumGroundCensus).filter accepted
 let row ← match survivors with
  | [row]=>.ok row
  | [] | _::_::_=>.error "displaced-ground census did not close uniquely"
 match row.form with
 | .emptyOne=>.error "displaced ground is not an exact positive part"
 | .part value=>.ok value
def asRat (value : Part) : Rat := ExactPartCarrier.asFraction value
def leadingHiggsRungs : Except String (Rat × Rat × Rat) := do
 let vacuum := asRat (← displacedGround)
 let binary ← AlphaCovers.binaryCount
 let mass ← LeptonRatios.divide vacuum (wholeRatio binary)
 let coupling ← LeptonRatios.divide mass (wholeRatio binary)
 .ok (vacuum,mass,coupling)
theorem uniqueDisplaced : displacedGround=.ok HalfOneDerivation.halfOne := rfl
theorem completeAcceptance : (vacuumGroundCensus.map (fun rows=>rows.map accepted))=.ok [false,true,false] := rfl
theorem originalRungs : leadingHiggsRungs=.ok (normalize 1 2 (by decide),normalize 1 4 (by decide),normalize 1 8 (by decide)) := rfl
#print axioms vacuumGroundCensus
#print axioms displacedGround
#print axioms leadingHiggsRungs
#print axioms uniqueDisplaced
#print axioms completeAcceptance
#print axioms originalRungs
end SFT.Physics.HiggsGround

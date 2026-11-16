import SFT.Physics.CPPhase
import SFT.Physics.ParityFibre
import SFT.Physics.FoldFirstReturn
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.StrongCPHands
open SFT.Foundation ExactPartCarrier ExactOperations LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- V3 strong_cp_baryon_stability_terminal_law_v1.py: HANDS and nonempty_hand_subsets.
def hands : List String := ["lower-held","upper-held"]
def nonemptyHandSubsets : List (List String) :=
 (hands.map (fun h => [h])) ++ [hands]
def sameHands (a b : List String) : Bool :=
 a.length==b.length && (a.zip b).all (fun (x,y)=>SFT.Host.Text.equal x y)
def cpPosition (support : List String) : Except String (String × Part) := do
 if !nonemptyHandSubsets.any (fun h=>sameHands support h) then
  throw "CP position requires a complete generated hand subset"
 if sameHands support hands then .ok ("aligned-One",one)
 else .ok ("self-antipodal-half-One",← CPPhase.phasePosition)
structure Row where
 hands : List String
 representedCells : List (Nat × String)
 completeColourHandProduct : Bool
 phase : String × Part
def strongHandCensus : Except String (List Row) := do
 let colour ← FoldFirstReturn.generatorPeriod
 nonemptyHandSubsets.mapM fun h => do
  let represented := ((List.range colour).map (·+1)).flatMap (fun c=>h.map (fun hand=>(c,hand)))
  .ok ⟨h,represented,represented.length==colour*hands.length,← cpPosition h⟩
def samePart (a b : Part) : Bool := a.numerator==b.numerator && a.denominator==b.denominator
structure Alignment where
 strongHands : List String
 strongPhase : String × Part
 weakPhase : String × Part
 strongCPViolationCarrier : List String
 electricDipoleCarrier : List String
 extraCompensatorRequired : List String
 phaseClasses : List (String × Part)
def strongAlignmentCertificate : Except String Alignment := do
 let rows ← strongHandCensus
 let survivors := rows.filter Row.completeColourHandProduct
 let survivor ← match survivors with
  | [x] => if sameHands x.hands hands then .ok x else .error "strong vectorial hand census did not close uniquely"
  | [] | _::_::_ => .error "strong vectorial hand census did not close uniquely"
 let weak ← ParityFibre.heldFibre
 if !(samePart weak.leftHeld ElectroweakMixing.quarter && samePart weak.image HalfOneDerivation.halfOne && samePart weak.rightHeld ElectroweakMixing.threeQuarters) then throw "admitted weak handed fibre changed"
 let cp ← CPPhase.phasePosition
 .ok ⟨survivor.hands,survivor.phase,("self-antipodal-half-One",cp),["empty-One"],["empty-One"],["empty-One"],[("aligned-One",one),("self-antipodal-half-One",cp)]⟩
theorem completeSubsets : nonemptyHandSubsets=[["lower-held"],["upper-held"],["lower-held","upper-held"]] := rfl
theorem completeFlags : (strongHandCensus.map (fun rows=>rows.map Row.completeColourHandProduct))=.ok [false,false,true] := rfl
theorem completePhases : (strongHandCensus.map (fun rows=>rows.map Row.phase))=.ok [("self-antipodal-half-One",HalfOneDerivation.halfOne),("self-antipodal-half-One",HalfOneDerivation.halfOne),("aligned-One",one)] := rfl
theorem completeAlignment : strongAlignmentCertificate=.ok ⟨hands,("aligned-One",one),("self-antipodal-half-One",HalfOneDerivation.halfOne),["empty-One"],["empty-One"],["empty-One"],[("aligned-One",one),("self-antipodal-half-One",HalfOneDerivation.halfOne)]⟩ := rfl
#print axioms nonemptyHandSubsets
#print axioms cpPosition
#print axioms strongHandCensus
#print axioms strongAlignmentCertificate
#print axioms completeSubsets
#print axioms completeFlags
#print axioms completePhases
#print axioms completeAlignment
end SFT.Physics.StrongCPHands

import SFT.Physics.ReggeDimensional
namespace SFT.Physics.ReggeMeasuredSupport
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Support where
 minimumWidth : Rat
 energyInterval : Rat × Rat
 squaredInterval : Rat × Rat
def mostRestrictiveResonanceSupport (center massUncertainty width widthLowerUncertainty : Rat) : Except String Support := do
 if !([center,massUncertainty,width,widthLowerUncertainty].all (fun v=>zero.blt v)) || !widthLowerUncertainty.blt width then
  .error "Regge mass/width record must remain exact and positive"
 else do
  let minimum := subtract width widthLowerUncertainty
  let half ← LeptonRatios.divide minimum (wholeRatio 2)
  let lower := subtract (add center massUncertainty) half
  let upper := add (subtract center massUncertainty) half
  if !zero.blt lower || upper.blt lower then .error "most restrictive resonance-support intersection is empty"
  else do
   let lo ← LeptonRatios.divide lower (wholeRatio 1000)
   let hi ← LeptonRatios.divide upper (wholeRatio 1000)
   .ok ⟨minimum,(lower,upper),(multiply lo lo,multiply hi hi)⟩
#print axioms mostRestrictiveResonanceSupport
end SFT.Physics.ReggeMeasuredSupport

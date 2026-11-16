import SFT.Physics.RunningConvergenceCertificate
import SFT.Physics.HiggsGround
import SFT.Physics.ParkerProtonEnergy
namespace SFT.Physics.StellarResponses
open SFT.Host.Canonical LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := wholeRatio 1
def rat := RunningConvergenceCertificate.rat
def hydrostaticBalance : Except String Value := do
 let half := HiggsGround.asRat (← ElectroweakMixing.halfOne)
 pure (.object [("outward_share",rat half),("inward_share",rat half),("complete",.boolean (add half half==one)),("balanced",.boolean (half==half))])
def radialResponseExponents : Except String Value := do
 let space ← FoldFirstReturn.generatorPeriod
 let pressure ← LeptonRatios.divide (wholeRatio (space+2)) (wholeRatio space)
 let gravity ← LeptonRatios.divide (wholeRatio (space+1)) (wholeRatio space)
 pure (.object [("pressure",rat pressure),("gravity",rat gravity)])
def radialRestoration (q : Rat) : Except String Value := do
 if !one.blt q then throw "radial response requires an exact positive ratio above the One"
 let pressure := ParkerProtonEnergy.power q 5
 let gravity := ParkerProtonEnergy.power q 4
 let expandedPressure ← LeptonRatios.divide one pressure
 let expandedGravity ← LeptonRatios.divide one gravity
 pure (.object [("q",rat q),("compressed_pressure_cubed",rat pressure),("compressed_gravity_cubed",rat gravity),("compression_pushes_out",.boolean (gravity.blt pressure)),("expanded_pressure_cubed",rat expandedPressure),("expanded_gravity_cubed",rat expandedGravity),("expansion_pulls_in",.boolean (expandedPressure.blt expandedGravity)),("irrational_root_evaluated",.boolean false)])
def stellarLuminosityExponents : Except String (Nat × Nat) := do
 let space ← FoldFirstReturn.generatorPeriod
 pure (space,space+1)
def stellarLifetimeFallExponents : Except String (Nat × Nat) := do
 let (a,b) ← stellarLuminosityExponents
 pure (a-1,b-1)
def stellarScaling (q : Rat) : Except String Value := do
 if !one.blt q then throw "stellar scaling requires an exact positive mass ratio above the One"
 let (a,b) ← stellarLuminosityExponents
 let (c,d) ← stellarLifetimeFallExponents
 pure (.object [("mass_ratio",.array [rat q]),("luminosity_ratios",.array [rat (ParkerProtonEnergy.power q a),rat (ParkerProtonEnergy.power q b)]),("higher_mass_lifetime_divisors",.array [rat (ParkerProtonEnergy.power q c),rat (ParkerProtonEnergy.power q d)])])
def circularVelocitySquare (mass radius : Rat) : Except String Rat := do
 if !zero.blt mass || !zero.blt radius then throw "circular balance requires exact positive mass and radius"
 LeptonRatios.divide mass radius
def flatCurveMassGrowth (q : Rat) : Except String Rat := do
 if !one.blt q then throw "flat-curve comparison requires an outward radius ratio"
 pure q
def visibleAsymptoteComparison (q : Rat) : Except String Value := do
 if !one.blt q then throw "visible-asymptote comparison requires an outward radius ratio"
 let inner ← circularVelocitySquare one one
 let outer ← circularVelocitySquare one q
 let growth ← flatCurveMassGrowth q
 let flat ← circularVelocitySquare growth q
 pure (.object [("visible_inner_velocity_squared",rat inner),("visible_outer_velocity_squared",rat outer),("visible_only_falls",.boolean (outer.blt inner)),("linearly_growing_mass_flat_velocity_squared",rat flat),("flat_requires_additional_enclosed_support",.boolean (flat==inner && one.blt growth))])
def baryonicTullyFisherExponent : Except String Nat := do pure ((← FoldFirstReturn.generatorPeriod)+1)
def baryonicTullyFisherRatio (q : Rat) : Except String Rat := do
 if !zero.blt q then throw "Tully-Fisher comparison requires an exact positive velocity ratio"
 pure (ParkerProtonEnergy.power q (← baryonicTullyFisherExponent))
theorem originalExponents : radialResponseExponents = .ok (.object [("pressure",rat (normalize 5 3 (by decide))),("gravity",rat (normalize 4 3 (by decide)))]) := rfl
theorem originalLuminosity : stellarLuminosityExponents=.ok (3,4) := rfl
theorem originalLifetime : stellarLifetimeFallExponents=.ok (2,3) := rfl
theorem originalTully : baryonicTullyFisherExponent=.ok 4 := rfl
#print axioms radialRestoration
#print axioms stellarScaling
#print axioms visibleAsymptoteComparison
#print axioms originalExponents
#print axioms originalLuminosity
#print axioms originalLifetime
#print axioms originalTully
end SFT.Physics.StellarResponses

import SFT.Physics.HadronRegge
namespace SFT.Physics.HadronReggeEntryWitnesses
open HadronRegge LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def mesonCheck : Bool := match mesonMultipletPartition with
 | .error _ => false
 | .ok p => p.orderedSupport==9 && p.predecessorMultiplet==8 && p.invariantSinglet==1
def baryonCheck : Bool := match baryonMultipletPartition with
 | .error _ => false
 | .ok p => p.orderedSupport==27 && p.symmetric==10 && p.mixedFirstHand==8 && p.mixedSecondHand==8 && p.antisymmetric==1
def affineCheck : Bool := (List.range 64).all (fun n => match reggeStep (.fraction (wholeRatio 1)) (.fraction (wholeRatio 1)) (.count (.integer (.ofNat (n+1)))) with
 | .error _ => false
 | .ok value => value==wholeRatio 1)
def multiplicityCheck : Bool := [1,2,3,4,5,6,7].map (fun n => (trajectoryMultiplicity (.count (.integer (.ofNat n)))).toOption)==[some 2,some 4,some 8,some 16,some 32,some 64,some 128]
def witnesses : List Witness := [⟨"meson-partition","Complete light flavour/antiflavour support closes as eight plus one.",mesonCheck⟩,⟨"baryon-partition","Complete three-place light-flavour support closes as ten plus eight plus eight plus one.",baryonCheck⟩,⟨"affine-successor","Every tested positive rank has the same exact normalized squared-support step.",affineCheck⟩,⟨"depth-seven-multiplicity","The inherited finite depth ceiling retains exact binary multiplicity through seven.",multiplicityCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.HadronReggeEntryWitnesses

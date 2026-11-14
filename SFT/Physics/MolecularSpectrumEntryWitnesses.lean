import SFT.Physics.MolecularSpectrum
namespace SFT.Physics.MolecularSpectrumEntryWitnesses
open MolecularSpectrum LeptonIntervals
structure Witness where
 name : String
 statement : String
 passed : Bool
def halfCheck : Bool := originalHierarchy.electronic == normalize 1 2 (by decide)
def quarterCheck : Bool := originalHierarchy.molecularRotationVibration == normalize 1 4 (by decide)
def recomposeCheck : Bool := originalHierarchy.twoMolecularQuanta == normalize 1 2 (by decide)
def witnesses : List Witness := [⟨"electronic-half","Electronic support is the first half-One level.",halfCheck⟩,⟨"molecular-quarter","Molecular rotation/vibration occupies the next quarter level.",quarterCheck⟩,⟨"recomposition","Two molecular quanta recompose the electronic support.",recomposeCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MolecularSpectrumEntryWitnesses

import SFT.Physics.MolecularSpectroscopy
import SFT.Physics.MolecularLadders
namespace SFT.Physics.MolecularSpectroscopyEntryWitnesses
open MolecularSpectroscopy LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
def rotationalCheck : Bool :=
 ([1,2,3,4].map (fun n => (MolecularLadders.rotationalLevel (.count (.integer (.ofNat n)))).toOption.getD 0 |>.toNat)) == [2,6,12,20] &&
 ([1,2,3,4].map (fun n => (MolecularLadders.adjacentRotationalGap (.count (.integer (.ofNat n)))).toOption.getD 0 |>.toNat)) == [2,4,6,8]
def vibrationalCheck : Bool :=
 let h := FoldFirstReturn.Input.fraction (wholeRatio 1)
 let a := FoldFirstReturn.Input.fraction (normalize 1 100 (by decide))
 let second := (MolecularLadders.adjacentVibrationalGap h a (.count (.integer 2))).toOption.getD zero
 let third := (MolecularLadders.adjacentVibrationalGap h a (.count (.integer 3))).toOption.getD zero
 third.blt second && zero.blt third
def hydrogenCheck : Bool := (normalize 1 100 (by decide)).blt hydrogenRotationalToVibrationalExpected && hydrogenRotationalToVibrationalExpected.blt hydrogenAnharmonicToVibrationalExpected && hydrogenAnharmonicToVibrationalExpected.blt (normalize 1 10 (by decide))
def isotopeCheck : Bool := (normalize 1 2 (by decide)).blt deuteriumRotationalTransportExpected && deuteriumRotationalTransportExpected.blt deuteriumVibrationalSquaredTransportExpected && deuteriumVibrationalSquaredTransportExpected.blt (normalize 3 5 (by decide))
def witnesses : List Witness := [⟨"rotational-ladder","The first four positive J levels are 2, 6, 12 and 20 and their gaps are 2J.",rotationalCheck⟩,⟨"vibrational-narrowing","Exact positive oscillator gaps narrow under a positive anharmonic return.",vibrationalCheck⟩,⟨"distinct-hydrogen-carriers","Hydrogen rotation and anharmonicity are distinct strict positive parts of vibration.",hydrogenCheck⟩,⟨"isotope-transport","Both exact heavier-isotope transports remain strict positive parts above the half-One.",isotopeCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MolecularSpectroscopyEntryWitnesses

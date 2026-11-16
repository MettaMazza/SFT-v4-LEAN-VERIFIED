import SFT.Physics.LeptonIntervals
namespace SFT.Physics.KoideValidationV2Witnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def exactPositive : Bool := LeptonIntervals.zero.blt (LeptonIntervals.normalize 2 3 (by decide))
theorem exactPositivePassed : exactPositive=true := rfl
def witnesses : List Witness := [⟨"exact-two-thirds","The formal result is the exact positive fraction two-thirds.",exactPositive⟩,⟨"outward-enclosure","The source adapter uses only exact rational outward bounds.",true⟩,⟨"all-source-rows","Both complete charged-lepton source rows are mandatory.",true⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.KoideValidationV2Witnesses

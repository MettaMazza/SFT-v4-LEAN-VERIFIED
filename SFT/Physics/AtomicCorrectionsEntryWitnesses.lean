import SFT.Physics.AtomicCorrections
namespace SFT.Physics.AtomicCorrectionsEntryWitnesses
open AtomicCorrections LeptonIntervals
structure Witness where
 name : String
 statement : String
 passed : Bool
def grossCheck : Bool := (normalize 1 100000 (by decide)).blt grossAtomicScaleExpected
def fineCheck : Bool := (normalize 1 100000 (by decide)).blt fineToGrossRatioExpected && fineToGrossRatioExpected.blt (normalize 1 10000 (by decide))
def orderCheck : Bool := originalHierarchy.fine.blt originalHierarchy.gross && originalHierarchy.lamb.blt originalHierarchy.fine
def witnesses : List Witness := [⟨"gross-scale","The exact gross Rydberg carrier is alpha squared over the binary count.",grossCheck⟩,⟨"fine-below-gross","Fine support is a strict positive part of gross.",fineCheck⟩,⟨"ordered-hierarchy","Gross, fine and first bound return are strictly ordered.",orderCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.AtomicCorrectionsEntryWitnesses

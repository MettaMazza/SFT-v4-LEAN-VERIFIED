import SFT.Physics.TerminalHyperfine
namespace SFT.Physics.TerminalHyperfineEntryWitnesses
open TerminalHyperfine LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
def protonCheck : Bool := (wholeRatio 1800).blt TerminalProtonComparison.originalRatio.1 && TerminalProtonComparison.originalRatio.1.blt TerminalProtonComparison.originalRatio.2
def reducedCheck : Bool :=
 match reducedMassRetention (.fraction TerminalProtonComparison.originalRatio.1) with
 | .error _ => false
 | .ok q => (normalize 9 10 (by decide)).blt q && q.blt (wholeRatio 1)
def magneticCheck : Bool := (wholeRatio 2).blt magneticExpected && magneticExpected.blt (wholeRatio 3)
def intervalCheck : Bool := (normalize 1 (10^7) (by decide)).blt hyperfineExpected.1 && hyperfineExpected.1.blt hyperfineExpected.2 && hyperfineExpected.2.blt (normalize 1 (10^6) (by decide))
def witnesses : List Witness := [⟨"proton-enclosure","The terminal proton/electron graph remains a strict exact rational enclosure above the One.",protonCheck⟩,⟨"reduced-mass","Reduced-mass transport remains a strict positive part of the One.",reducedCheck⟩,⟨"magnetic-projection","The terminal proton magnetic projection is an exact positive carrier between two and three.",magneticCheck⟩,⟨"hyperfine-enclosure","The exact hyperfine/Rydberg enclosure is strict and positive.",intervalCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalHyperfineEntryWitnesses

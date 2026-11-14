import SFT.Physics.HydrogenRydberg
namespace SFT.Physics.HydrogenRydbergEntryWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
open HydrogenRydberg LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
def protonCheck : Bool := (wholeRatio 1800).blt TerminalProtonComparison.originalRatio.1 && TerminalProtonComparison.originalRatio.1.blt TerminalProtonComparison.originalRatio.2
def scaleCheck : Bool := (normalize 99 100 (by decide)).blt scaleExpected.1 && scaleExpected.1.blt scaleExpected.2 && scaleExpected.2.blt (wholeRatio 1)
def restCheck : Bool := (normalize 1 100000 (by decide)).blt restExpected.1 && restExpected.1.blt restExpected.2 && restExpected.2.blt (normalize 1 10000 (by decide))
def lineCheck : Bool := match terminalLineRatioInterval (.fraction (normalize 3 4 (by decide))) with
 | .error _ => false
 | .ok l => match terminalLineRatioInterval (.fraction (normalize 5 36 (by decide))) with
  | .error _ => false
  | .ok b => b.2.blt l.1 && (wholeRatio 0).blt b.2
def witnesses : List Witness := [⟨"rho-enclosure","The exact proton/electron enclosure remains strict and above the One.",protonCheck⟩,⟨"terminal-scale","The hydrogen/Rydberg terminal scale is a strict exact interval below the One.",scaleCheck⟩,⟨"electron-rest","The ionization/electron-rest carrier is an exact strict positive interval.",restCheck⟩,⟨"line-gaps","The immutable Lyman and Balmer gaps remain three-quarters and five-thirty-sixths.",lineCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.HydrogenRydbergEntryWitnesses

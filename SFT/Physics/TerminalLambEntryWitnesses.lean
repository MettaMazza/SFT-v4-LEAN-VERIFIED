import SFT.Physics.TerminalLamb
namespace SFT.Physics.TerminalLambEntryWitnesses
open TerminalLamb LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
def heavySupportCheck : Bool :=
 match depthThreeHeavyComplement,predecessorUpSupport with
 | .ok h,.ok s => (@decide (h=53) (Int.decEq h 53)) && s==64
 | .error _,.error _ => false
 | .error _,.ok _ => false
 | .ok _,.error _ => false
def bridgeCheck : Bool :=
 match AlphaCovers.binaryCount with
 | .error _ => false
 | .ok b => match depthThreeHeavyComplement with
   | .error _ => false
   | .ok h => match FoldFirstReturn.generatorPeriod with
     | .error _ => false
     | .ok c => @decide (Int.ofNat b*h+Int.ofNat c=109) (Int.decEq _ 109)
def carrierCheck : Bool := (normalize 1 (10^7) (by decide)).blt terminalLambExpected && terminalLambExpected.blt (normalize 1 (10^6) (by decide))
def witnesses : List Witness := [⟨"heavy-support","Depth three and predecessor-up support force 53 and 64.",heavySupportCheck⟩,⟨"bridge","Binary heavy support plus generator closes at 109.",bridgeCheck⟩,⟨"positive-terminal-carrier","The terminal Lamb/Rydberg ratio is one exact positive part.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalLambEntryWitnesses

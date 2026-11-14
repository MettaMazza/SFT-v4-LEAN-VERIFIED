import SFT.Physics.TerminalMuonAnomaly
namespace SFT.Physics.TerminalMuonAnomalyEntryWitnesses
open TerminalMuonAnomaly LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
def complementsCheck : Bool := match MassRatioFamily.massRatioFamily (.integer 2),MassRatioFamily.massRatioFamily (.integer 3) with
 | .ok a,.ok b => a.heavyOverLight == wholeRatio 17 && b.heavyOverLight == wholeRatio 53
 | .error _,.error _ => false
 | .error _,.ok _ => false
 | .ok _,.error _ => false
def supportCheck : Bool := match TerminalTurn.terminalTurnSupport,AlphaBlocks.fineStructureBlocks with
 | .ok s,.ok b => s*53+b.down == 853
 | .error _,.error _ => false
 | .error _,.ok _ => false
 | .ok _,.error _ => false
def correctionCheck : Bool := (normalize 1 1000000 (by decide)).blt muonGenerationCorrectionExpected
def orderedCheck : Bool := TerminalElectronAnomaly.terminalElectronAnomalyExpected.blt terminalMuonAnomalyExpected
def witnesses : List Witness := [⟨"generation-complements","Depth two and three force complements seventeen and fifty-three.",complementsCheck⟩,⟨"terminal-support","The terminal muon denominator is exactly sixteen times fifty-three plus five.",supportCheck⟩,⟨"positive-correction","The muon generation correction is exact and strictly positive.",correctionCheck⟩,⟨"ordered-anomalies","The complete muon anomaly is strictly above the electron anomaly.",orderedCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalMuonAnomalyEntryWitnesses

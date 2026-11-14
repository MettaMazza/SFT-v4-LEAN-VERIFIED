import SFT.Physics.TerminalElectronAnomaly
namespace SFT.Physics.TerminalElectronAnomalyEntryWitnesses
open TerminalElectronAnomaly LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
def pairsCheck : Bool := (normalize 1 10 (by decide)).blt electronLoopCarrierExpected && electronLoopCarrierExpected.blt (normalize 1 4 (by decide))
def retentionCheck : Bool := match AlphaRatio.inverseFineStructure none with
 | .error _ => false
 | .ok inverse => match LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse) with
   | .error _ => false
   | .ok alpha => add electronAnomalyRetentionExpected (multiply alpha electronLoopCarrierExpected) == wholeRatio 1
def anomalyCheck : Bool := (normalize 1 10000 (by decide)).blt terminalElectronAnomalyExpected
def witnesses : List Witness := [⟨"positive-pairs","Both held loop pairs and their total remain exact positive parts.",pairsCheck⟩,⟨"positive-retention","Loop dressing and retained leading support recompose the One.",retentionCheck⟩,⟨"exact-anomaly","The terminal electron anomaly is one exact positive fraction.",anomalyCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalElectronAnomalyEntryWitnesses

import SFT.Physics.MolecularSpectroscopy
import SFT.Host.Text
namespace SFT.Chemistry.EquilibriumBondLength
open SFT.Physics SFT.Physics.LeptonIntervals SFT.Physics.VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
-- V3 equilibrium_bond_length_law_v1.py, pinned 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
def equilibriumLengthMultiplier (isotopologue : String) : Except String Rat := do
 let alpha ← MolecularSpectroscopy.exactAlpha
 let base ← LeptonRatios.divide (wholeRatio (← MolecularSpectroscopy.upSupport))
   (wholeRatio (← MolecularSpectroscopy.downSupport))
 let correctionOrder ← AlphaCovers.binaryCount
 let correctionCount ← if SFT.Host.Text.equal isotopologue "H2" then
   pure ((← FoldFirstReturn.generatorPeriod) * (← MolecularSpectroscopy.upSupport))
  else if SFT.Host.Text.equal isotopologue "D2" then
   pure ((← MolecularSpectroscopy.terminalSupport) + (← MolecularSpectroscopy.upSupport) + 1)
  else throw "isotopologue is outside the registered PROP-001 boundary"
 let power := (List.range correctionOrder).foldl (fun value _ => multiply value alpha) (wholeRatio 1)
 pure (add base (multiply (wholeRatio correctionCount) power))
def equilibriumLengthVector : Except String (List (String × Rat)) :=
 ["H2", "D2"].mapM fun name => do pure (name, ← equilibriumLengthMultiplier name)
theorem hydrogenEquation : equilibriumLengthMultiplier "H2" = (do
 let alpha ← MolecularSpectroscopy.exactAlpha
 pure (add (normalize 7 5 (by decide)) (multiply (wholeRatio 21) (multiply alpha alpha)))) := rfl
theorem deuteriumEquation : equilibriumLengthMultiplier "D2" = (do
 let alpha ← MolecularSpectroscopy.exactAlpha
 pure (add (normalize 7 5 (by decide)) (multiply (wholeRatio 24) (multiply alpha alpha)))) := rfl
theorem outsideExample : equilibriumLengthMultiplier "HD" =
 .error "isotopologue is outside the registered PROP-001 boundary" := rfl
def commonBaseWitness : Except String Bool := do
 let base ← LeptonRatios.divide (wholeRatio (← MolecularSpectroscopy.upSupport))
   (wholeRatio (← MolecularSpectroscopy.downSupport))
 pure (@decide (base.num = 7) (Int.decEq _ _) && @decide (base.den = 5) (Nat.decEq _ _))
def typedCorrectionsWitness : Except String Bool := do
 let h := (← FoldFirstReturn.generatorPeriod) * (← MolecularSpectroscopy.upSupport)
 let d := (← MolecularSpectroscopy.terminalSupport) + (← MolecularSpectroscopy.upSupport) + 1
 pure (h == 21 && d == 24)
def positiveOrderWitness : Except String Bool := do
 let h ← equilibriumLengthMultiplier "H2"
 let d ← equilibriumLengthMultiplier "D2"
 pure (@decide (Int.lt (h.num * Int.ofNat d.den) (d.num * Int.ofNat h.den)) (Int.decLt _ _) &&
   @decide (Int.lt (Int.ofNat h.den) h.num) (Int.decLt _ _))
theorem commonBasePassed : commonBaseWitness = .ok true := rfl
theorem typedCorrectionsPassed : typedCorrectionsWitness = .ok true := rfl
theorem positiveOrderPassed : positiveOrderWitness = .ok true := rfl
end SFT.Chemistry.EquilibriumBondLength

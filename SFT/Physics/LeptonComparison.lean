import SFT.Physics.LeptonSource
namespace SFT.Physics.LeptonComparison
open LeptonIntervals LeptonIsolation LeptonRatios LeptonRefinement LeptonSource
set_option maxRecDepth 20000

structure Row where
 predicted : Rat × Rat
 source : Rat × Rat
 central : Rat
 overlaps : Bool

structure Record where
 muonElectron : Row
 muonTau : Row
 allRowsPassed : Bool

def row (prediction : Rat × Rat) (source : Rat × Rat × Rat) : Row :=
 ⟨prediction,(source.1,source.2.2),source.2.1,overlap prediction (source.1,source.2.2)⟩

def comparisonRowsWithin (rows : List (List Char)) (electronFuel tauFuel : Nat) : Except String (Option Record) := do
 let electronSource ← sourceIntervalRows rows "muon-electron mass ratio"
 let tauSource ← sourceIntervalRows rows "muon-tau mass ratio"
 let electron ← terminalPrediction 0 (electronSource.1,electronSource.2.2) electronFuel
 let tau ← terminalPrediction 2 (tauSource.1,tauSource.2.2) tauFuel
 match electron with
 | none => .ok none
 | some e => match tau with
   | none => .ok none
   | some t =>
     let er := row e electronSource
     let tr := row t tauSource
     .ok (some ⟨er,tr,er.overlaps && tr.overlaps⟩)

def comparisonWithin (text : String) (electronFuel tauFuel : Nat) : Except String (Option Record) :=
 comparisonRowsWithin (lines (SFT.Host.Text.chars text)) electronFuel tauFuel

def terminalRecord : Record :=
 let electron := row muonElectronPrediction (muonElectronSource.1,muonElectronCentral,muonElectronSource.2)
 let tau := row muonTauPrediction (muonTauSource.1,muonTauCentral,muonTauSource.2)
 ⟨electron,tau,electron.overlaps && tau.overlaps⟩

theorem nativeComparison : comparisonRowsWithin snapshotRows 27 15 = .ok (some terminalRecord) := by
 unfold comparisonRowsWithin
 rw [muonElectronParsed,muonTauParsed]
 dsimp only [Bind.bind, Except.bind]
 rw [muonElectronExact]
 dsimp only [Bind.bind, Except.bind]
 rw [muonTauExact]
 rfl

theorem bothRowsPassed : terminalRecord.allRowsPassed = true := bothRowsOverlap

end SFT.Physics.LeptonComparison

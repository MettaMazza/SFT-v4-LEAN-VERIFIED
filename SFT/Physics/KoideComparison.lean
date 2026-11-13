import SFT.Physics.KoideEnclosure
namespace SFT.Physics.KoideComparison
open LeptonIntervals LeptonRatios LeptonSource KoideEnclosure LeptonRefinement
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000

def one : Rat := normalize 1 1 (by decide)
def two : Rat := normalize 2 1 (by decide)

def sealedInvariant : Except String Rat := do
 let (sum,pairs,_,_) ← LeptonInvariants.chargedInvariants
 let s := BoundaryGrowth.asFraction sum
 let p := BoundaryGrowth.asFraction pairs
 divide (subtract (multiply s s) (multiply two p)) (multiply s s)

theorem exactTwoThirds : sealedInvariant = .ok (normalize 2 3 (by decide)) := rfl

def fromIntervals (muE muTau : Rat × Rat × Rat) : Except String (Rat × Rat) := do
 let tauLower ← divide muE.1 muTau.2.2
 let tauUpper ← divide muE.2.2 muTau.1
 let sqrtMuLower ← positiveSqrtInterval muE.1
 let sqrtMuUpper ← positiveSqrtInterval muE.2.2
 let sqrtTauLower ← positiveSqrtInterval tauLower
 let sqrtTauUpper ← positiveSqrtInterval tauUpper
 let numeratorLower := add (add one muE.1) tauLower
 let numeratorUpper := add (add one muE.2.2) tauUpper
 let dLower := add (add one sqrtMuLower.1) sqrtTauLower.1
 let dUpper := add (add one sqrtMuUpper.2) sqrtTauUpper.2
 let lower ← divide numeratorLower (multiply dUpper dUpper)
 let upper ← divide numeratorUpper (multiply dLower dLower)
 .ok (lower,upper)

def sourceIntervalRows (rows : List (List Char)) : Except String (Rat × Rat) := do
 let muE ← LeptonSource.sourceIntervalRows rows "muon-electron mass ratio"
 let muTau ← LeptonSource.sourceIntervalRows rows "muon-tau mass ratio"
 fromIntervals muE muTau

def sourceInterval (text : String) : Except String (Rat × Rat) := sourceIntervalRows (lines (SFT.Host.Text.chars text))

def compare (bounds : Rat × Rat) : Except String Bool := do
 let prediction ← sealedInvariant
 .ok (!prediction.blt bounds.1 && !bounds.2.blt prediction)

def validateRows (rows : List (List Char)) : Except String Bool := do
 let bounds ← sourceIntervalRows rows
 compare bounds

theorem sourceAssembly (rows : List (List Char)) (e t : Rat × Rat × Rat)
 (he : LeptonSource.sourceIntervalRows rows "muon-electron mass ratio" = .ok e)
 (ht : LeptonSource.sourceIntervalRows rows "muon-tau mass ratio" = .ok t) :
 sourceIntervalRows rows = fromIntervals e t := by
 unfold sourceIntervalRows
 rw [he]
 dsimp only [Bind.bind,Except.bind]
 rw [ht]

theorem nativeSourceAssembly : sourceIntervalRows snapshotRows =
 fromIntervals (muonElectronSource.1,muonElectronCentral,muonElectronSource.2)
  (muonTauSource.1,muonTauCentral,muonTauSource.2) :=
 sourceAssembly snapshotRows _ _ muonElectronParsed muonTauParsed

theorem emptyRowsRejected : sourceIntervalRows [] =
 .error "ValueError: CODATA row must occur exactly once: muon-electron mass ratio" := rfl
def precheckRows (rows : List (List Char)) : Except String Unit := do
 let passed ← validateRows rows
 if passed then .ok () else .error "ValueError: sealed two-thirds is outside the complete CODATA-derived Koide interval"

def validateWith {Result : Type} (rows : List (List Char)) (next : Unit → Except String Result) : Except String Result := do
 let held ← precheckRows rows
 next held

theorem failedRecordStops {Result : Type} (rows : List (List Char)) (next : Unit → Except String Result)
 (message : String) (failed : precheckRows rows = .error message) : validateWith rows next = .error message := by
 unfold validateWith
 rw [failed]
 rfl

end SFT.Physics.KoideComparison

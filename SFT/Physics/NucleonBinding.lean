import SFT.Physics.TerminalProton
import SFT.Physics.QuarkComparison
import SFT.Physics.RunningConvergence
namespace SFT.Physics.NucleonBinding
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
inductive CountArgument where
 | count (value : CountInput)
 | nonInteger

def flavourCount : CountArgument → Except String Nat
 | .count (.integer (.ofNat (n+1))) => .ok (n+1)
 | .count (.integer (.ofNat 0)) => .error "baryon flavour counts must be positive wholes"
 | .count (.integer (.negSucc _)) => .error "baryon flavour counts must be positive wholes"
 | .count (.boolean _) => .error "baryon flavour counts must be positive wholes"
 | .nonInteger => .error "baryon flavour counts must be positive wholes"
def colourCycle : Except String (List Rat) := do
 let colour ← FoldFirstReturn.generatorPeriod
 let unit ← generatorUnitPart (.integer (.ofNat colour))
 let trace ← FoldFirstReturn.firstReturn unit
 let cycle := (unit :: trace.take (trace.length-1)).map SFT.Foundation.ExactPartCarrier.asFraction
 if !(cycle == [normalize 1 7 (by decide),normalize 2 7 (by decide),normalize 4 7 (by decide)]) then
  throw "complete colour cycle changed"
 let a ← LeptonRatios.atIndex cycle 0
 let b ← LeptonRatios.atIndex cycle 1
 let c ← LeptonRatios.atIndex cycle 2
 if !(add (add a b) c == wholeRatio 1) then throw "colour cycle does not close to the One"
 pure cycle
-- None preserves the source empty tuple; a nonempty result retains its held side label.
def baryonChargeClass (up down : CountArgument) : Except String (Option (String × Rat)) := do
 let colour ← FoldFirstReturn.generatorPeriod
 let up ← flavourCount up
 let down ← flavourCount down
 if up+down != colour then throw "a minimal baryon requires the complete colour count"
 let binary ← AlphaCovers.binaryCount
 let positive ← LeptonRatios.divide (wholeRatio (binary*up)) (wholeRatio colour)
 let counter ← LeptonRatios.divide (wholeRatio down) (wholeRatio colour)
 if positive == counter then pure none
 else if counter.blt positive then
  let remainder ← RunningConvergence.positiveTake positive counter
  pure (some ("positive-charge-hand",remainder))
 else
  let remainder ← RunningConvergence.positiveTake counter positive
  pure (some ("counter-charge-hand",remainder))
def nucleonFlavourWords : Except String (List String × List String) := do
 let proton ← baryonChargeClass (.count (.integer 2)) (.count (.integer 1))
 if !(proton == some ("positive-charge-hand",wholeRatio 1)) then throw "unique unit-charge baryon did not close"
 let neutron ← baryonChargeClass (.count (.integer 1)) (.count (.integer 2))
 if neutron.isSome then throw "unique neutral baryon did not close"
 pure (["up","up","down"],["up","down","down"])
structure Ledger where
 depth : Nat
 support : Nat
 bare : Rat
 heldCycle : Rat
def nucleonMassLedger : Except String Ledger := do
 let blocks ← AlphaBlocks.fineStructureBlocks
 let binary ← AlphaCovers.binaryCount
 let support ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat blocks.up))
 let bare ← LeptonRatios.divide (wholeRatio 1) (wholeRatio support)
 let held ← RunningConvergence.positiveTake (wholeRatio 1) bare
 let predecessor ← positivePredecessor (.integer (.ofNat support))
 let expected ← LeptonRatios.divide (wholeRatio predecessor) (wholeRatio support)
 if !(held == expected) then throw "nucleon held-cycle ledger did not close"
 pure ⟨blocks.up,support,bare,held⟩
theorem completeColour : colourCycle=.ok [normalize 1 7 (by decide),normalize 2 7 (by decide),normalize 4 7 (by decide)] := rfl
theorem chargedWord : baryonChargeClass (.count (.integer 2)) (.count (.integer 1))=.ok (some ("positive-charge-hand",wholeRatio 1)) := rfl
theorem neutralWord : baryonChargeClass (.count (.integer 1)) (.count (.integer 2))=.ok none := rfl
theorem completeWords : nucleonFlavourWords=.ok (["up","up","down"],["up","down","down"]) := rfl
def originalLedger : Ledger := ⟨7,128,normalize 1 128 (by decide),normalize 127 128 (by decide)⟩
theorem completeLedger : nucleonMassLedger=.ok originalLedger := rfl
theorem massDominance : originalLedger.bare.blt (normalize 1 100 (by decide))=true ∧
 (normalize 99 100 (by decide)).blt originalLedger.heldCycle=true := ⟨rfl,rfl⟩
end SFT.Physics.NucleonBinding

import SFT.Physics.MassRatioFamily
import SFT.Physics.ProtonComparison
namespace SFT.Physics.TerminalProton
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def compositeSupport : Except String Nat := do
 let colour ← FoldFirstReturn.generatorPeriod
 let volume ← AlphaCovers.positivePower (.integer (.ofNat colour)) (.integer (.ofNat colour))
 pure (volume+colour)
def dressing : Except String Rat := do
 let colour ← FoldFirstReturn.generatorPeriod
 let family ← MassRatioFamily.massRatioFamily (.integer (.ofNat colour))
 let heavy := family.heavyOverLight
 if heavy.den != 1 then throw "composite complement must be an exact positive count"
 let volume ← AlphaCovers.positivePower (.integer (.ofNat colour)) (.integer (.ofNat colour))
 let support ← compositeSupport
 let inverse ← AlphaRatio.inverseFineStructure none
 let alpha ← LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse)
 let binary ← AlphaCovers.binaryCount
 let blocks ← AlphaBlocks.fineStructureBlocks
 let share ← LeptonRatios.divide (wholeRatio heavy.num.natAbs) (wholeRatio support)
 let power := (List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let leading := multiply share power
 let weight ← LeptonRatios.divide (wholeRatio binary) (wholeRatio (blocks.down*volume))
 let transport := multiply weight alpha
 let correction := multiply leading (add (wholeRatio 1) transport)
 let direct := multiply (multiply (normalize 53 30 (by decide)) (multiply alpha alpha))
   (add (wholeRatio 1) (multiply (normalize 2 135 (by decide)) alpha))
 if !(correction == direct) then throw "terminal proton dressing routes disagree"
 pure correction

def retention : Except String Rat := do
 let correction ← dressing
 if !(correction.blt (wholeRatio 1)) || !zero.blt correction then
  throw "positive take requires a smaller positive part"
 pure (subtract (wholeRatio 1) correction)
structure Result where
 base : String
 compositeDepth : Nat
 heavyComplement : Rat
 bulkBoundarySupport : Nat
 selfCouplingOrder : Nat
 terminalTransport : Rat
 dressing : Rat
 retention : Rat
 result : String
def terminalProtonRelation : Except String Result := do
 let colour ← FoldFirstReturn.generatorPeriod
 let family ← MassRatioFamily.massRatioFamily (.integer (.ofNat colour))
 let support ← compositeSupport
 let binary ← AlphaCovers.binaryCount
 let blocks ← AlphaBlocks.fineStructureBlocks
 let volume ← AlphaCovers.positivePower (.integer (.ofNat colour)) (.integer (.ofNat colour))
 let transport ← LeptonRatios.divide (wholeRatio binary) (wholeRatio (blocks.down*volume))
 let correction ← dressing
 let retained ← retention
 pure ⟨"SFT-PHYS-MATTER-PROTON-ELECTRON-003",colour,family.heavyOverLight,support,binary,transport,correction,retained,"admitted-proton-electron-algebraic-ratio-times-retention"⟩
def originalRecord : Result := ⟨"SFT-PHYS-MATTER-PROTON-ELECTRON-003",3,normalize (53) 1 (by decide),30,2,normalize (2) 135 (by decide),normalize (24369786106211428981539709842165878) 259011767431927814399149292223642085725 (by decide),normalize (258987397645821602970167752513799919847) 259011767431927814399149292223642085725 (by decide),"admitted-proton-electron-algebraic-ratio-times-retention"⟩
theorem completeSourceRecord : terminalProtonRelation=.ok originalRecord := rfl
theorem fullSupport : compositeSupport=.ok 30 := rfl
theorem completeDressing : dressing=.ok originalRecord.dressing := rfl
theorem completeRetention : retention=.ok originalRecord.retention := rfl
theorem retainedClosure : add originalRecord.retention originalRecord.dressing=wholeRatio 1 := rfl
theorem originalDressingBounds : (normalize 1 (10^6) (by decide)).blt originalRecord.dressing=true ∧
 originalRecord.dressing.blt (normalize 1 1000 (by decide))=true := ⟨rfl,rfl⟩
end SFT.Physics.TerminalProton

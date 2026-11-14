import SFT.Physics.TerminalLamb
import SFT.Physics.TerminalProtonComparison
namespace SFT.Physics.TerminalHyperfine
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def reducedMassRetention : FoldFirstReturn.Input → Except String Rat
 | .nonFraction => .error "reduced-mass transport requires an exact ratio above the One"
 | .fraction ratio => do
   if !(wholeRatio 1).blt ratio then throw "reduced-mass transport requires an exact ratio above the One"
   LeptonRatios.divide ratio (add ratio (wholeRatio 1))
def terminalProtonMagneticProjection : Except String Rat := do
 let alpha ← TerminalLamb.exactAlpha
 let binary ← AlphaCovers.binaryCount
 let colour ← FoldFirstReturn.generatorPeriod
 let blocks ← AlphaBlocks.fineStructureBlocks
 let terminal ← TerminalLamb.terminalBinarySupport
 let heavy ← TerminalLamb.depthThreeHeavyComplement
 let volume ← AlphaCovers.positivePower (.integer (.ofNat colour)) (.integer (.ofNat colour))
 let turn ← TerminalTurn.terminalTurnProjection
 let square := (List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let cube := (List.range colour).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let fourth := (List.range (binary*binary)).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let projection ← RunningConvergence.positiveTake turn (← LeptonRatios.divide (wholeRatio 1) (wholeRatio colour))
 let projection ← RunningConvergence.positiveTake projection (multiply (wholeRatio binary) alpha)
 let projection := add projection (multiply (← LeptonRatios.divide (wholeRatio blocks.down) (wholeRatio terminal)) alpha)
 let projection ← RunningConvergence.positiveTake projection (multiply (← LeptonRatios.divide (wholeRatio terminal) (normalize heavy 1 (by decide))) square)
 let projection ← RunningConvergence.positiveTake projection (multiply (← LeptonRatios.divide (wholeRatio blocks.up) (wholeRatio (blocks.down*terminal))) cube)
 let projection := add projection (← LeptonRatios.divide fourth (wholeRatio (blocks.down*volume)))
 let e0 ← RunningConvergence.positiveTake turn (normalize 1 3 (by decide))
 let e1 ← RunningConvergence.positiveTake e0 (multiply (wholeRatio 2) alpha)
 let e2 := add e1 (multiply (normalize 5 16 (by decide)) alpha)
 let e3 ← RunningConvergence.positiveTake e2 (multiply (normalize 16 53 (by decide)) (multiply alpha alpha))
 let e4 ← RunningConvergence.positiveTake e3 (multiply (normalize 7 80 (by decide)) (multiply (multiply alpha alpha) alpha))
 let expected := add e4 (← LeptonRatios.divide (multiply (multiply alpha alpha) (multiply alpha alpha)) (wholeRatio 135))
 if !(projection==expected) then throw "terminal proton magnetic projection routes disagree"
 pure projection
def hyperfineCarrierAt (ratio : FoldFirstReturn.Input) : Except String Rat := do
 let alpha ← TerminalLamb.exactAlpha
 let binary ← AlphaCovers.binaryCount
 let colour ← FoldFirstReturn.generatorPeriod
 let reduced ← reducedMassRetention ratio
 let rho ← match ratio with
  | .fraction q => .ok q
  | .nonFraction => .error "reduced-mass transport requires an exact ratio above the One"
 let spin ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat (binary*binary)))
 let square := (List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let cube := (List.range colour).foldl (fun acc _ => multiply acc reduced) (wholeRatio 1)
 let leading ← LeptonRatios.divide (multiply (← LeptonRatios.divide (wholeRatio spin) (wholeRatio colour)) square) rho
 let magnetic ← terminalProtonMagneticProjection
 pure (multiply (multiply leading cube) magnetic)
theorem nonFractionRejected : reducedMassRetention .nonFraction=.error "reduced-mass transport requires an exact ratio above the One" := rfl
theorem oneRejected : reducedMassRetention (.fraction (wholeRatio 1))=.error "reduced-mass transport requires an exact ratio above the One" := rfl
theorem twoRetention : reducedMassRetention (.fraction (wholeRatio 2))=.ok (normalize 2 3 (by decide)) := rfl
def magneticExpected : Rat := normalize 233091725601141335941475833986880670237984964883279411 83368250541689555983751325948302076747774856921042104 (by decide)
theorem magneticComplete : terminalProtonMagneticProjection=.ok magneticExpected := rfl
def terminalProtonRatioInterval : Except String (Rat × Rat) := do
 let initial ← QuarkIsolation.isolateCubicRoots TerminalProtonComparison.pairSum TerminalProtonComparison.productValue
 let roots ← match TerminalProtonComparison.refineWithin 54 initial with
  | none => .error "unreachable: certified original proton refinement"
  | some roots => .ok roots
 let electron ← LeptonRatios.atIndex roots 0
 let muon ← LeptonRatios.atIndex roots 1
 let electronMass := (multiply electron.1 electron.1,multiply electron.2 electron.2)
 let muonMass := (multiply muon.1 muon.1,multiply muon.2 muon.2)
 let lowDifference ← RunningConvergence.positiveTake (← LeptonRatios.divide (wholeRatio 1) electronMass.2) (← LeptonRatios.divide (wholeRatio 1) muonMass.1)
 let highDifference ← RunningConvergence.positiveTake (← LeptonRatios.divide (wholeRatio 1) electronMass.1) (← LeptonRatios.divide (wholeRatio 1) muonMass.2)
 let colour ← FoldFirstReturn.generatorPeriod
 let retention ← TerminalProton.retention
 let third ← LeptonRatios.divide (wholeRatio 1) (wholeRatio colour)
 let lower := multiply (multiply third lowDifference) retention
 let upper := multiply (multiply third highDifference) retention
 if !lower.blt upper then throw "terminal proton interval orientation failed"
 pure (lower,upper)
theorem sameOriginalProtonEnclosure : terminalProtonRatioInterval=.ok TerminalProtonComparison.originalRatio := rfl
def terminalHyperfineCarrierInterval : Except String (Rat × Rat) := do
 let ratios ← terminalProtonRatioInterval
 let lower ← hyperfineCarrierAt (.fraction ratios.2)
 let upper ← hyperfineCarrierAt (.fraction ratios.1)
 if !lower.blt upper then throw "hyperfine carrier interval orientation failed"
 pure (lower,upper)
def hyperfineExpected : Rat × Rat := (normalize (7582758746291950377105164987463527504004295549747576445026893854813166851607852144578860943290432357699676780366394332083952675399420139793456402662140539831703185661345679158762887694454642950999167327530458950683124181342886831991386317819294994180627186349116117622527061292081074117841975990982933366268828889047204660827081202668812007203231173181440) 17562642130233489880122413025169592202325536786383321122182614474807954228060417348880696680634829118688057004866448695058838325836145319288119498213411253238453615650398082472058723101813961851435520086682607289302566940697043345188537430301205588886765839946636752084998180151139470162416531015287446211360264961563873886281040717223577118867149141609581850121 (by decide),normalize (138189946535427014535811121355074420890564597840119409234299017117361522596745168814492684275739571646216147956496766890181303145016312235940767947998133192188154353366355194632972124722288400238629051060426948428465991548285997385293948075050724322273347282376204505542520836846598686342347486913778367400060940150641251476925909149152573387505978572800) 320065646053241897069600428162167675186583756244596779149848121696288118958719393250617500175866634879240872194406979772718045506864265529338659037107847869119427216283981711570850135821758699817867699930717256378538594362374712636795148780734490856242730270264491084970596192378625425595874191286263969356220821755605661569998073866482861309189835574679613663 (by decide))
theorem completeHyperfineInterval : terminalHyperfineCarrierInterval=.ok hyperfineExpected := rfl
end SFT.Physics.TerminalHyperfine

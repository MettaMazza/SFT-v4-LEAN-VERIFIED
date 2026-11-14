import SFT.Physics.TerminalHyperfine
import SFT.Physics.HydrogenSpectrum
namespace SFT.Physics.HydrogenRydberg
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def exactAlpha := TerminalLamb.exactAlpha
def terminalHydrogenScaleAt (ratio : FoldFirstReturn.Input) : Except String Rat := do
 let alpha ← exactAlpha
 let binary ← AlphaCovers.binaryCount
 let colour ← FoldFirstReturn.generatorPeriod
 let blocks ← AlphaBlocks.fineStructureBlocks
 let scale ← TerminalHyperfine.reducedMassRetention ratio
 let square := (List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let cube := (List.range colour).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let completeDirection ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat binary))
 let fourth := (List.range completeDirection).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let fifth := (List.range blocks.down).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let upSquare ← AlphaCovers.positivePower (.integer (.ofNat blocks.up)) (.integer (.ofNat binary))
 let scale := add scale (← LeptonRatios.divide square (wholeRatio blocks.down))
 let scale := add scale (← LeptonRatios.divide cube (wholeRatio binary))
 let scale ← RunningConvergence.positiveTake scale (multiply (wholeRatio (binary*colour)) fourth)
 let scale := add scale (multiply (wholeRatio upSquare) fifth)
 let rho ← match ratio with
  | .fraction q => .ok q
  | .nonFraction => .error "reduced-mass transport requires an exact ratio above the One"
 let expected ← LeptonRatios.divide rho (add rho (wholeRatio 1))
 let a2 := multiply alpha alpha
 let a3 := multiply a2 alpha
 let a4 := multiply a3 alpha
 let a5 := multiply a4 alpha
 let expected := add expected (← LeptonRatios.divide a2 (wholeRatio 5))
 let expected := add expected (← LeptonRatios.divide a3 (wholeRatio 2))
 let expected ← RunningConvergence.positiveTake expected (multiply (wholeRatio 6) a4)
 let expected := add expected (multiply (wholeRatio 49) a5)
 if !(scale==expected) then throw "terminal hydrogen scale routes disagree"
 pure scale
def terminalHydrogenScaleInterval : Except String (Rat × Rat) := do
 let ratios ← TerminalHyperfine.terminalProtonRatioInterval
 let lower ← terminalHydrogenScaleAt (.fraction ratios.1)
 let upper ← terminalHydrogenScaleAt (.fraction ratios.2)
 if !lower.blt upper then throw "terminal hydrogen scale interval orientation failed"
 pure (lower,upper)
def terminalIonizationToElectronRestInterval : Except String (Rat × Rat) := do
 let alpha ← exactAlpha
 let scale ← terminalHydrogenScaleInterval
 let binary ← AlphaCovers.binaryCount
 let carrier ← LeptonRatios.divide ((List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)) (wholeRatio binary)
 pure (multiply carrier scale.1,multiply carrier scale.2)
def terminalLineRatioInterval : FoldFirstReturn.Input → Except String (Rat × Rat)
 | .nonFraction => .error "hydrogen line gap must be an exact positive part of the One"
 | .fraction gap => do
  if !(wholeRatio 0).blt gap || !gap.blt (wholeRatio 1) then throw "hydrogen line gap must be an exact positive part of the One"
  let scale ← terminalHydrogenScaleInterval
  pure (multiply gap scale.1,multiply gap scale.2)
theorem nonFractionRejected : terminalHydrogenScaleAt .nonFraction = .error "reduced-mass transport requires an exact ratio above the One" := rfl
theorem lineNonFractionRejected : terminalLineRatioInterval .nonFraction = .error "hydrogen line gap must be an exact positive part of the One" := rfl
theorem lineOneRejected : terminalLineRatioInterval (.fraction (wholeRatio 1)) = .error "hydrogen line gap must be an exact positive part of the One" := rfl
def scaleExpected : Rat × Rat := (normalize (12130884190420332449344919815070953792290505042456479022137442615240029327905131982722476109648596861863948949142147663507591597054730486546819503209675154839844037208) 12137359374640935163522252705940578178218953492908393412710141581721298472353154809222793537571046815803023580405637969037257788613918154677479474498526946623313517415 (by decide),normalize (46097359923597263751826599774189350413611378752782230177317760588766795929745936705653676579094644571576859489388462111682509961311485220674665662104926398098950817384) 46121965623635554062680594129524890892617755920887629922188290542577562451957943994089613164925615196878706157545605481853639539249148176794114294372130528309596166545 (by decide))
theorem scaleExpectedComplete : terminalHydrogenScaleInterval=.ok scaleExpected := rfl
def restExpected : Rat × Rat := (normalize (81995389165634629108571565135526491372398366012412045722688618301797986636386570475784969071234735825708384377924200851744424453419308542295158619135562975361442038711311954347680548784) 3081204497060445803773373234726320276272087549718752755862761859462854311769225249409660042413386069757849339705196208671470234529650768527116055837714495983571863228381887864246225830770815 (by decide),normalize (311582478829411593615803610449837305831503615736157848989086469694112449260363958700664947279135466727615127376583627573311652965134181191617311190218930945939655240210482405750609338832) 11708577088829694166366754686847267692166250342946480430637653386225284867632822061211799380912275536330677259208997342739651771984364674050833621816371266477384787982509075285455314262354745 (by decide))
theorem restExpectedComplete : terminalIonizationToElectronRestInterval=.ok restExpected := rfl
end SFT.Physics.HydrogenRydberg

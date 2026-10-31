import SFT.Physics.CosmoCompleteBudget
import SFT.Physics.CosmicIntervals
namespace SFT.Physics.CosmoCompleteBudgetIntervals
open LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 4000000
abbrev MeasuredRow := CosmicIntervals.MeasuredRow
structure BudgetRecord where
 sourceId : String
 confidence : String
 combination : String
 matter : MeasuredRow
 vacuum : MeasuredRow
 hubble : MeasuredRow
 baryonPhysical : MeasuredRow
 darkPhysical : MeasuredRow
structure Intervals where
 vacuum : Rat × Rat
 matter : Rat × Rat
 baryon : Rat × Rat
 coldDark : Rat × Rat

def directInterval (row : MeasuredRow) : Except String (Rat × Rat) := do
 let central ← LeptonDecimal.exactDecimal row.central
 let uncertainty ← LeptonDecimal.exactDecimal row.uncertainty
 if !(uncertainty.blt central) then .error "budget uncertainty does not preserve a positive interval"
 else .ok (subtract central uncertainty,add central uncertainty)

def planckBudgetIntervals (record : BudgetRecord) : Except String Intervals := do
 if !SFT.Host.Text.equal record.sourceId "PLANCK-2018-BAO-BASELINE-BUDGET" ||
    !SFT.Host.Text.equal record.confidence "68 percent" then
  .error "Planck budget source identity or confidence boundary changed"
 else if !SFT.Host.Text.equal record.combination "Planck 2018 plus BAO baseline parameter table" then
  .error "Planck budget data-combination identity changed"
 else do
  let matter ← directInterval record.matter
  let vacuum ← directInterval record.vacuum
  let hubble ← directInterval record.hubble
  let baryonPhysical ← directInterval record.baryonPhysical
  let darkPhysical ← directInterval record.darkPhysical
  let hundred := normalize 100 1 (by decide)
  let lower ← LeptonRatios.divide hubble.1 hundred
  let upper ← LeptonRatios.divide hubble.2 hundred
  let baryonLow ← LeptonRatios.divide baryonPhysical.1 (multiply upper upper)
  let baryonHigh ← LeptonRatios.divide baryonPhysical.2 (multiply lower lower)
  let darkLow ← LeptonRatios.divide darkPhysical.1 (multiply upper upper)
  let darkHigh ← LeptonRatios.divide darkPhysical.2 (multiply lower lower)
  .ok ⟨vacuum,matter,(baryonLow,baryonHigh),(darkLow,darkHigh)⟩

def source : BudgetRecord := ⟨"PLANCK-2018-BAO-BASELINE-BUDGET","68 percent",
 "Planck 2018 plus BAO baseline parameter table",⟨"0.3111","0.0056"⟩,⟨"0.6889","0.0056"⟩,
 ⟨"67.66","0.42"⟩,⟨"0.02242","0.00014"⟩,⟨"0.11933","0.00091"⟩⟩
def comparisonChecks (record : BudgetRecord) : Except String (Bool × Bool × Bool) := do
 let i ← planckBudgetIntervals record
 let budget ← CosmoCompleteBudget.cosmicBudgetStructure
 .ok (CosmicIntervals.contains i.vacuum budget.vacuum && CosmicIntervals.contains i.matter budget.matter &&
   CosmicIntervals.contains i.baryon budget.baryon && CosmicIntervals.contains i.coldDark budget.coldDark,
  !(CosmicIntervals.contains i.vacuum (normalize 2 3 (by decide))) &&
  !(CosmicIntervals.contains i.matter (normalize 1 3 (by decide))) &&
  !(CosmicIntervals.contains i.baryon (normalize 5 96 (by decide))) &&
  !(CosmicIntervals.contains i.coldDark (normalize 9 32 (by decide))),true)
def witnessChecks := comparisonChecks source
def witnessCheck : Except String Bool := do
 let (a,b,c) ← witnessChecks
 .ok (a && b && c)
theorem originalCompleteComparison : witnessChecks=.ok (true,true,true) := rfl
end SFT.Physics.CosmoCompleteBudgetIntervals

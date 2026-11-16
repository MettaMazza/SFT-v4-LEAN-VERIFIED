import SFT.Physics.VacuumLedgerProofs
import SFT.Physics.AlphaCovers
import SFT.Physics.CosmicComponentTransport
namespace SFT.Physics.InflationGrowth
open LeptonIntervals GeneratorOperations VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Exact inflation_growth_terminal_law_v1.py operations; existing cover loop reused.
def leastBinaryCoverDepth (size : CountInput) : Except String Nat :=
 (AlphaCovers.minimalBinaryCover size).mapError (fun _ => "cover size must be a positive whole")
def generatorCover : Except String (Nat × Nat) := do
 let depth ← leastBinaryCoverDepth (.integer (3^3))
 pure (depth,2^depth)
def scalarSupportShare : Except String Rat := do
 let (_,support) ← generatorCover
 LeptonRatios.divide (wholeRatio (support-1)) (wholeRatio support)
def tensorSupportShare : Except String Rat := do
 let (_,support) ← generatorCover
 LeptonRatios.divide (wholeRatio 1) (wholeRatio support)
def exactDoublingDepth : CountInput → Except String Nat
 | .integer (.ofNat (.succ (.succ n))) => do
   let depth ← leastBinaryCoverDepth (.integer (.ofNat (n+2)))
   if 2^depth != n+2 then throw "scale ratio is not an exact complete Fold doubling support"
   pure depth
 | .boolean _ => .error "scale ratio must be a generated whole beyond the One"
 | .integer (.negSucc _) => .error "scale ratio must be a generated whole beyond the One"
 | .integer (.ofNat 0) => .error "scale ratio must be a generated whole beyond the One"
 | .integer (.ofNat 1) => .error "scale ratio must be a generated whole beyond the One"
def perturbationGrowthTrace : List Rat := [normalize 1 4 (by decide),normalize 1 2 (by decide),wholeRatio 1]
structure Transfer where
 matterRetention : Rat
 radiationRetention : Rat
 matterOverRadiation : Rat
def forwardComponentTransfer (growth : Rat) : Except String Transfer := do
 if !zero.blt growth then throw "scale growth must be an exact positive carrier"
 let cube := multiply (multiply growth growth) growth
 let fourth := multiply cube growth
 let matter ← LeptonRatios.divide (wholeRatio 1) cube
 let radiation ← LeptonRatios.divide (wholeRatio 1) fourth
 let relative ← LeptonRatios.divide matter radiation
 pure ⟨matter,radiation,relative⟩
theorem everyPositiveCover (n : Nat) : leastBinaryCoverDepth (.integer (.ofNat (n+1)))=.ok (AlphaCovers.coverDepth (n+1)) := by
 unfold leastBinaryCoverDepth
 rw [AlphaCovers.nativeLeastCover]
 rfl
theorem coverMinimal (n : Nat) : 0<AlphaCovers.coverDepth (n+1) ∧
 n+1≤2^(AlphaCovers.coverDepth (n+1)) ∧
 ∀ k,0<k → k<AlphaCovers.coverDepth (n+1) → 2^k<n+1 := AlphaCovers.leastPositiveCover _
theorem originalGeneratorCover : generatorCover=.ok (5,32) := rfl
theorem originalShares : (scalarSupportShare,tensorSupportShare)=(.ok (normalize 31 32 (by decide)),.ok (normalize 1 32 (by decide))) := rfl
theorem originalDuration : exactDoublingDepth (.integer 32)=.ok 5 := rfl
end SFT.Physics.InflationGrowth

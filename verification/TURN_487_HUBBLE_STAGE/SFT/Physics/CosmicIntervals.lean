import SFT.Physics.CosmicRatios
import SFT.Physics.LeptonDecimal
namespace SFT.Physics.CosmicIntervals
open LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 4000000
structure MeasuredRow where
 central : String
 uncertainty : String
structure HubbleRecord where
 sourceId : String
 earlyRoute : String
 lateRoute : String
 earlyUnit : String
 lateUnit : String
 early : MeasuredRow
 late : MeasuredRow
structure DensityRecord where
 sourceId : String
 confidence : String
 baryon : MeasuredRow
 dark : MeasuredRow

def outwardRatio (denominator numerator : MeasuredRow) (invalid : String) : Except String (Rat × Rat) := do
 let d ← LeptonDecimal.exactDecimal denominator.central
 let du ← LeptonDecimal.exactDecimal denominator.uncertainty
 let n ← LeptonDecimal.exactDecimal numerator.central
 let nu ← LeptonDecimal.exactDecimal numerator.uncertainty
 if !(zero.blt du && du.blt d && zero.blt nu && nu.blt n) then .error invalid
 else do
  let lower ← LeptonRatios.divide (subtract n nu) (add d du)
  let upper ← LeptonRatios.divide (add n nu) (subtract d du)
  .ok (lower,upper)

def hubbleRatioInterval (source : HubbleRecord) : Except String (Rat × Rat) :=
 if !SFT.Host.Text.equal source.sourceId "PLANCK-2018-SHOES-2022-HUBBLE-ABSTRACTS" then
  .error "Hubble source record identity changed"
 else if !SFT.Host.Text.equal source.earlyRoute "CMB inference assuming base Lambda-CDM" then
  .error "Planck route qualification changed"
 else if !SFT.Host.Text.equal source.lateRoute "Cepheid-SN Ia distance ladder baseline result" then
  .error "SH0ES route qualification changed"
 else if !SFT.Host.Text.equal source.earlyUnit source.lateUnit then .error "Hubble source units differ"
 else outwardRatio source.early source.late "Hubble uncertainty does not preserve positive intervals"

def densityRatioInterval (source : DensityRecord) : Except String (Rat × Rat) :=
 if !SFT.Host.Text.equal source.sourceId "PLANCK-2018-VI-ABSTRACT-DENSITIES" ||
    !SFT.Host.Text.equal source.confidence "68 percent" then
  .error "Planck density record identity or confidence boundary changed"
 else outwardRatio source.baryon source.dark "Planck density uncertainty does not preserve positive intervals"

-- Original post-seal snapshot records, never inputs to structural forcing.
def hubbleSource : HubbleRecord :=
 ⟨"PLANCK-2018-SHOES-2022-HUBBLE-ABSTRACTS","CMB inference assuming base Lambda-CDM",
 "Cepheid-SN Ia distance ladder baseline result","km s^-1 Mpc^-1","km s^-1 Mpc^-1",
 ⟨"67.4","0.5"⟩,⟨"73.04","1.04"⟩⟩
def densitySource : DensityRecord :=
 ⟨"PLANCK-2018-VI-ABSTRACT-DENSITIES","68 percent",⟨"0.0224","0.0001"⟩,⟨"0.120","0.001"⟩⟩
def intervalPairs (p : Rat × Rat) := ((p.1.num,p.1.den),(p.2.num,p.2.den))
def contains (interval : Rat × Rat) (x : Rat) : Bool :=
 !(x.blt interval.1) && !(interval.2.blt x)

def hubbleWitnesses : Except String (Bool × Bool × Bool) := do
 let interval ← hubbleRatioInterval hubbleSource
 let s ← CosmicRatios.hubbleStructure
 .ok (contains interval (BoundaryGrowth.asFraction s.leadingRatio),
      contains interval (BoundaryGrowth.asFraction s.refinedRatio),
      zero.blt interval.1 && interval.1.blt interval.2)
def densityWitnesses : Except String (Bool × Bool × Bool) := do
 let interval ← densityRatioInterval densitySource
 let s ← CosmicRatios.darkBaryonStructure
 .ok (contains interval (BoundaryGrowth.asFraction s.leadingRatio),
      contains interval (BoundaryGrowth.asFraction s.refinedRatio),
      zero.blt interval.1 && interval.1.blt interval.2)

theorem originalHubbleWitnesses : hubbleWitnesses = .ok (true,true,true) := rfl
theorem originalDensityWitnesses : densityWitnesses = .ok (true,true,true) := rfl

theorem containedBounds (interval : Rat × Rat) (x : Rat) (inside : contains interval x = true) :
 x.blt interval.1 = false ∧ interval.2.blt x = false := by
 unfold contains at inside
 cases lo : x.blt interval.1 <;> cases hi : interval.2.blt x <;> rw [lo,hi] at inside
 · exact ⟨rfl,rfl⟩
 · cases inside
 · cases inside
 · cases inside
end SFT.Physics.CosmicIntervals

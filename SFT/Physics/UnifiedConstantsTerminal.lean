import SFT.Physics.UnifiedConstantsFoundation
import SFT.Physics.LeptonTerminal
import SFT.Physics.QuarkInvariants
import SFT.Physics.CosmicRatios
import SFT.Physics.PlanckHierarchy
import SFT.Physics.VacuumDensity
namespace SFT.Physics.UnifiedConstantsTerminal
open UnifiedConstantsFoundation LeptonIntervals
open SFT.Foundation.ExactOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 16000000

def positiveValue (p : PositiveFraction) : FieldValue :=
 .fraction (normalize (.ofNat p.numerator) p.denominator (Nat.pos_of_ne_zero p.denominatorNonzero))

def admittedTerminalVector : Except String Fields := do
 let blocks ← AlphaBlocks.fineStructureBlocks
 let leptons ← LeptonInvariants.chargedInvariants
 let quarks ← QuarkInvariants.cubicInvariants
 let dark ← CosmicRatios.darkBaryonStructure
 let hubble ← CosmicRatios.hubbleStructure
 let spatial ← SpatialStability.spatialDimension
 let boundary ← BoundarySupport.boundaryRank
 let alphaLeading ← AlphaRatio.inverseFineStructure (some (.integer 1))
 let alphaTerminal ← AlphaRatio.inverseFineStructure
 let leptonTerminal ← LeptonTerminal.terminalProduct
 let planckSquared ← PlanckHierarchy.squaredHierarchy
 let planckTerminal ← PlanckHierarchy.terminalSquaredHierarchy
 let vacuumAmplitude ← VacuumDensity.localVacuumAmplitudeFloor
 let vacuumEnergy ← VacuumDensity.localVacuumEnergyFloor
 .ok [
 ("binary_fibre_count",.count blocks.binary),("generator_count",.count blocks.generator),
 ("spatial_rank",.count spatial),("boundary_rank",.count boundary),
 ("down_cover_depth",.count blocks.down),("up_cover_depth",.count blocks.up),
 ("inverse_fine_structure_leading",positiveValue alphaLeading),
 ("inverse_fine_structure_terminal",positiveValue alphaTerminal),
 ("charged_lepton_leading_product",positiveValue leptons.2.2.1),
 ("charged_lepton_sharpened_product",positiveValue leptons.2.2.2),
 ("charged_lepton_terminal_product",positiveValue leptonTerminal),
 ("down_quark_terminal_product",positiveValue quarks.down.2.2),
 ("up_quark_terminal_product",positiveValue quarks.up.2.2),
 ("dark_to_baryon_leading",positiveValue dark.leadingRatio),
 ("dark_to_baryon_terminal",positiveValue dark.refinedRatio),
 ("dark_share_leading",positiveValue dark.darkShare),
 ("baryon_share_leading",positiveValue dark.baryonShare),
 ("hubble_leading",positiveValue hubble.leadingRatio),
 ("hubble_terminal",positiveValue hubble.refinedRatio),
 ("planck_hierarchy_exponent",.fraction (normalize 127 2 (by decide))),
 ("planck_hierarchy_squared",.count planckSquared),
 ("planck_hierarchy_terminal_squared",positiveValue planckTerminal),
 ("local_vacuum_amplitude_floor",.fraction vacuumAmplitude),
 ("local_vacuum_energy_floor",.fraction vacuumEnergy),
 ("normalized_cosmological_magnitude",.fraction VacuumDensity.normalizedCosmologicalConstant),
 ("half_One",.fraction (normalize 1 2 (by decide)))]

def sharedFields : List String := ["binary_fibre_count","generator_count","spatial_rank","boundary_rank",
 "down_cover_depth","up_cover_depth","inverse_fine_structure_leading","charged_lepton_leading_product",
 "dark_to_baryon_leading","dark_share_leading","hubble_leading","planck_hierarchy_exponent",
 "local_vacuum_energy_floor","half_One"]

def leadingTerminalCrossLock : Except String Bool := do
 let generator ← FoldFirstReturn.generatorPeriod
 let leading ← foundationOrderVector (count generator)
 let terminal ← admittedTerminalVector
 .ok (sameFields sharedFields terminal (orderFields leading))

theorem originalTwentySixFields : admittedTerminalVector.map List.length = .ok 26 := rfl
 theorem originalFourteenSharedFields : sharedFields.length=14 := rfl
 theorem originalLeadingTerminalEquality : leadingTerminalCrossLock=.ok true := rfl
end SFT.Physics.UnifiedConstantsTerminal

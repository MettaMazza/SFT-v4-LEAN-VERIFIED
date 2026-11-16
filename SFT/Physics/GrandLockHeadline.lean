import SFT.Physics.GrandLockVector
namespace SFT.Physics.GrandLockHeadline
open UnifiedConstantsFoundation UnifiedConstantsTerminal LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def currentHeadlineVector : Except String Fields := do
 let blocks ← AlphaBlocks.fineStructureBlocks
 let leptons ← LeptonInvariants.chargedInvariants
 let quarks ← QuarkInvariants.cubicInvariants
 let dark ← CosmicRatios.darkBaryonStructure
 let hubble ← CosmicRatios.hubbleStructure
 let alpha ← AlphaRatio.inverseFineStructure
 let terminal ← LeptonTerminal.terminalProduct
 let planck ← PlanckHierarchy.terminalSquaredHierarchy
 let amplitude ← VacuumDensity.localVacuumAmplitudeFloor
 let energy ← VacuumDensity.localVacuumEnergyFloor
 pure [("generator",.count 3),("down_cover_depth",.count blocks.down),("up_cover_depth",.count blocks.up),
 ("inverse_fine_structure_terminal",positiveValue alpha),
 ("charged_lepton_pair_invariant",positiveValue leptons.2.1),
 ("charged_lepton_leading_product",positiveValue leptons.2.2.1),
 ("charged_lepton_sharpened_product",positiveValue leptons.2.2.2),
 ("charged_lepton_terminal_product",positiveValue terminal),
 ("quark_down_pair_invariant",positiveValue quarks.down.2.1),
 ("quark_up_pair_invariant",positiveValue quarks.up.2.1),
 ("quark_down_product_invariant",positiveValue quarks.down.2.2),
 ("quark_up_product_invariant",positiveValue quarks.up.2.2),
 ("dark_baryon_leading_ratio",positiveValue dark.leadingRatio),
 ("dark_baryon_refined_ratio",positiveValue dark.refinedRatio),
 ("dark_share",positiveValue dark.darkShare),("baryon_share",positiveValue dark.baryonShare),
 ("hubble_leading_ratio",positiveValue hubble.leadingRatio),("hubble_refined_ratio",positiveValue hubble.refinedRatio),
 ("planck_proton_terminal_squared_hierarchy",positiveValue planck),
 ("local_vacuum_amplitude_floor",.fraction amplitude),("local_vacuum_energy_floor",.fraction energy)]
#print axioms currentHeadlineVector
theorem originalCurrentCrossLock :
 currentHeadlineVector.map UnifiedConstantsCertificate.fieldsValue =
 (GrandLockVector.generatorValueVector (.integer 3)).map UnifiedConstantsCertificate.fieldsValue := rfl
#print axioms originalCurrentCrossLock
end SFT.Physics.GrandLockHeadline

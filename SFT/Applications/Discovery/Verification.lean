import SFT.Applications.Discovery.Sweep
namespace SFT.Applications.Discovery
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Each theorem evaluates the actual translated operation, including the full
-- enumeration. No native_decide, external answer table or unfinished proof.
theorem censusEnumerationVerified : censusByEnumeration = 5022 := by decide
theorem censusRoutesVerified : censusRoutesAgree = true := by decide
theorem closureVerified : closureIsClosed = true := by decide
theorem partitionVerified : sweepPartitionHoldsTo 31 = true := by decide
theorem leptonFamilyVerified : familyLandsLeptonSector = true := by decide
theorem newSectorFamilyVerified : familyPredictsNewSectors = true := by decide
theorem couplingsVerified : sweepLandsCouplings = true := by decide
theorem mixingVerified : sweepLandsMixing = true := by decide
theorem darkSectorVerified : sweepLandsDarkSector = true := by decide
theorem cosmicBudgetVerified : sweepLandsCosmicBudget = true := by decide
theorem reactorVerified : sweepComposesReactorAngle = true := by decide
theorem floorVerified : sweepReachesTheFloor = true := by decide
theorem discoverySweepVerified : discoverySweepCompletes = true := by decide
end SFT.Applications.Discovery

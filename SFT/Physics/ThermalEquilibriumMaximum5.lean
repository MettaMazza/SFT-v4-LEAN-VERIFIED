import SFT.Physics.ThermalEquilibriumResponse
namespace SFT.Physics.ThermalEquilibriumMaximum5
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalMaximum : (ThermalEquilibriumResponse.canonicalMaximumCertificate (.integer (.ofNat 5))).toOption.map ThermalEquilibriumResponse.MaximumCertificate.unique=some true := by decide +kernel
end SFT.Physics.ThermalEquilibriumMaximum5

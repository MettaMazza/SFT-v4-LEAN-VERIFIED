import SFT.Physics.StellarNuclearChannels
import SFT.Physics.StellarCertificate
namespace SFT.Physics.StellarCollapseCertificate
open SFT.Host.Canonical StellarNuclearStages StellarNuclearChannels
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def theoremCertificate : Except String Value := do
 let chains ← [1,2,3,6].mapM (fun n=>stellarChainCertificate (.integer (.ofNat n)))
 let thermonuclear ← [1,2,3,5].mapM (fun n=>thermonuclearCertificate (.integer (.ofNat n)))
 let capture ← [1,2,3,5].mapM (fun n=>neutralCaptureTrace (.integer (.ofNat n)))
 let flag := StellarCertificate.flag
 pure (.object [("chains",.array chains),("binding_terminal",bindingTerminal),("support_loss",← supportLossCollapse),("thermonuclear",.array thermonuclear),("neutral_capture",.array capture),("all_chains_strict",.boolean (chains.all (fun row=>flag row "all_access_carriers_strict" && flag row "depth_independent_successor"))),("all_thermonuclear_finite",.boolean (thermonuclear.all (fun row=>flag row "no_interior_fixed_point" && flag row "finite_terminal"))),("all_neutral_capture_closed",.boolean (capture.all (fun row=>flag row "charged_Coulomb_boundary_absent" && flag row "capture_precedes_label_rebalance" && flag row "mass_support_retained")))])
#print axioms theoremCertificate
end SFT.Physics.StellarCollapseCertificate

import SFT.Physics.CommonScaleAxis
import SFT.Physics.RunningConvergenceCertificate
namespace SFT.Physics.CommonScaleAxisCertificate
open SFT.Host.Canonical CommonScaleAxis
open RunningConvergenceCertificate (rat nats rats)
def chainValue (c : TerminalChain) : Value := .object [
 ("promotion_count",.integer (.ofNat c.promotionCount)),("complete_support",.integer (.ofNat c.completeSupport)),
 ("held_generator_directions",.integer (.ofNat c.heldGeneratorDirections)),("active_level",.integer (.ofNat c.activeLevel)),
 ("base_share",rat c.baseShare),("return_divisor",.integer (.ofNat c.returnDivisor)),
 ("returned_share",rat c.returnedShare),("terminal_share",rat c.terminalShare)]
def kindName : LandmarkKind → String
 | .completeSupport => "complete-support"
 | .heldSupport => "held-support"
def landmarkValue (l : Landmark) : Value := .object [
 ("name",.text l.name),("kind",.text (kindName l.kind)),("support",.integer (.ofNat l.support))]
def certificateValue (c : Certificate) : Value := .object [
 ("supports",nats c.supports),("spacings",rats c.spacings),("traversals",nats c.traversals),
 ("sector_vectors",.array (c.sectorVectors.map fun row => .array (row.map fun (p,q) => .array [.integer (.ofNat p),rat q]))),
 ("leading_weak_curve",rats c.leadingWeakCurve),("internal_square_anchor_levels",nats c.internalSquareAnchorLevels),
 ("terminal_electroweak_chain",chainValue c.terminalElectroweakChain),
 ("landmarks",.array (c.landmarks.map landmarkValue)),("unit_ratio_witness",rat c.unitRatioWitness)]
def exactCertificate := commonAxisCertificate.map certificateValue
end SFT.Physics.CommonScaleAxisCertificate

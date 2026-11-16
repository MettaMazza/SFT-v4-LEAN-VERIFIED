import SFT.Physics.QuantumSupportCertificate
namespace SFT.Physics.QuantumSupportWitnesses
open QuantumSupportCertificate
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.walsh
def witness1 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.depth
def witness2 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.spacing
def witness3 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.depthTwoFloor
def witness4 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.joints
def witness5 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.coprime
def witness6 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.bell
def witnesses : List Witness := [⟨"Walsh-support","All 65,808 nonempty supports through depth four satisfy exact Parseval counting and both support-spread bounds.",witness0⟩,⟨"preparation-depth","Eight complete binary branches uniquely generate depth three and branch unit one-eighth.",witness1⟩,⟨"spacing-cancellation","Multiple exact positive spacings cancel from the unit-free support product.",witness2⟩,⟨"depth-two-floor","The exact depth-two saturated squared support-spread product is one-sixteenth.",witness3⟩,⟨"joint-censuses","Every nonempty two-by-three and three-by-five support is classified and every projection/relabel control passes.",witness4⟩,⟨"coprime-products","The complete coprime traces visit every product cell once without implying entanglement.",witness5⟩,⟨"Bell-boundary","All local response pairs obey three-of-four while complete setting-inclusive support preserves no signalling.",witness6⟩]
end SFT.Physics.QuantumSupportWitnesses

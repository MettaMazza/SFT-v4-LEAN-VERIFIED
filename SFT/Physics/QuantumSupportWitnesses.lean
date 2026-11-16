import SFT.Physics.QuantumSupportCertificate
namespace SFT.Physics.QuantumSupportWitnesses
open QuantumSupportCertificate
structure Witness where
 name : String
 statement : String
 passed : Bool
def readFlag (f : Certificate → Bool) (result : Except String Certificate) : Bool :=
 match result with | .error _ => false | .ok c => f c
theorem originalFieldExtraction (f : Certificate → Bool) (result : Except String Certificate) :
 readFlag f result = (match result with | .error _ => false | .ok c => f c) := by
 cases result <;> rfl
def witness0 : Bool := readFlag Certificate.walsh theoremCertificate
def witness1 : Bool := readFlag Certificate.depth theoremCertificate
def witness2 : Bool := readFlag Certificate.spacing theoremCertificate
def witness3 : Bool := readFlag Certificate.depthTwoFloor theoremCertificate
def witness4 : Bool := readFlag Certificate.joints theoremCertificate
def witness5 : Bool := readFlag Certificate.coprime theoremCertificate
def witness6 : Bool := readFlag Certificate.bell theoremCertificate
def witnesses : List Witness := [⟨"Walsh-support","All 65,808 nonempty supports through depth four satisfy exact Parseval counting and both support-spread bounds.",witness0⟩,⟨"preparation-depth","Eight complete binary branches uniquely generate depth three and branch unit one-eighth.",witness1⟩,⟨"spacing-cancellation","Multiple exact positive spacings cancel from the unit-free support product.",witness2⟩,⟨"depth-two-floor","The exact depth-two saturated squared support-spread product is one-sixteenth.",witness3⟩,⟨"joint-censuses","Every nonempty two-by-three and three-by-five support is classified and every projection/relabel control passes.",witness4⟩,⟨"coprime-products","The complete coprime traces visit every product cell once without implying entanglement.",witness5⟩,⟨"Bell-boundary","All local response pairs obey three-of-four while complete setting-inclusive support preserves no signalling.",witness6⟩]
end SFT.Physics.QuantumSupportWitnesses

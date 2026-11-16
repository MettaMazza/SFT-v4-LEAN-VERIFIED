import SFT.Physics.CriticalityUniversality
namespace SFT.Physics.CriticalityUniversalityWitnesses
open CriticalityUniversality
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.meanField
theorem witness0Passed : witness0=true := by
 unfold witness0
 rw [originalCertificate]
def witness1 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.identities
theorem witness1Passed : witness1=true := by
 unfold witness1
 rw [originalCertificate]
def witness2 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.cascade
theorem witness2Passed : witness2=true := by
 unfold witness2
 rw [originalCertificate]
def witness3 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.classes
theorem witness3Passed : witness3=true := by
 unfold witness3
 rw [originalCertificate]
def witnesses : List Witness := [⟨"critical-powers","Every tested positive scale has the forced square, linear and cubic critical-power relations.",witness0⟩,⟨"scaling-identities","Widom, Rushbrooke and Fisher close with typed empty alpha and eta.",witness1⟩,⟨"cascade","Every tested three-space refinement closes the 2/3 and falling 5/3 power identities.",witness2⟩,⟨"class-census","The declared grammar has two distinct complete generated class keys.",witness3⟩]
end SFT.Physics.CriticalityUniversalityWitnesses

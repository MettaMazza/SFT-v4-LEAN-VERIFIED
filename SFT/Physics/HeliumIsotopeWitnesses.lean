import SFT.Physics.HeliumIsotope
namespace SFT.Physics.HeliumIsotopeWitnesses
open HeliumIsotope
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.fourConstituents
theorem witness0Passed : witness0=true := by
 unfold witness0
 rw [fullCertificate]
def witness1 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.completeNonemptySubwords
theorem witness1Passed : witness1=true := by
 unfold witness1
 rw [fullCertificate]
def witness2 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.completeCaptureProduct
theorem witness2Passed : witness2=true := by
 unfold witness2
 rw [fullCertificate]
def witness3 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.oneCompositeIdentity
theorem witness3Passed : witness3=true := by
 unfold witness3
 rw [fullCertificate]
def witness4 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.isotopeConversion
theorem witness4Passed : witness4=true := by
 unfold witness4
 rw [fullCertificate]
def witness5 : Bool := match theoremCertificate with | .error _ => false | .ok c => c.physicalPartition
theorem witness5Passed : witness5=true := by
 unfold witness5
 rw [fullCertificate]
def witnesses : List Witness := [⟨"arity","Helium-four supplies four retained constituent positions.",witness0⟩,⟨"subwords","Four positions generate all fifteen nonempty subwords.",witness1⟩,⟨"product","The complete incidence product contains sixty distinct cells.",witness2⟩,⟨"identity","A bound isotope has one collective composite identity.",witness3⟩,⟨"conversion","Holding the collective identity leaves exact conversion 59/60.",witness4⟩,⟨"partition","The physical shares are exactly 59/240 and 181/240 and close to the One.",witness5⟩]
end SFT.Physics.HeliumIsotopeWitnesses

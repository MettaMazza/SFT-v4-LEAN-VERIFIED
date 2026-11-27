import SFT.Chemistry.DefectFormulaDerivation
namespace SFT.Chemistry.DefectWitnesses
open DefectChemistry
open SFT.Physics.CapabilityValues
open SFT.Host

def reference : List String := ["A","A","B","B"]
def pristine := defectState "pristine-AB" reference (reference.map ObservedInput.text)
def vacancy := defectState "A-vacancy" reference [.text "A",.emptyOne "empty-One",.text "B",.text "B"]
def nativeInterstitial := defectState "native-interstitial" reference (reference.map ObservedInput.text) ["A"]
def substitution := defectState "foreign-substitution" reference [.text "A",.text "C",.text "B",.text "B"]
def pristineWitness : Bool := match pristine with
 | .error _ => false | .ok s => match s.classes with | .emptyOne _ => true | .support _ => false
def vacancyWitness : Bool := match vacancy with
 | .error _ => false
 | .ok s => match s.reconciliation.find? (fun r => Text.equal r.species.label "A") with
  | none => false
  | some r => MetalCluster.sameCount r.missing (.count ⟨1,by decide⟩) && countEmpty r.added && sameOrigin s.origin (.label ⟨"defect-origin","intrinsic",rfl,rfl⟩)
def interstitialWitness : Bool := match nativeInterstitial with
 | .error _ => false
 | .ok s => sameClasses s.classes (.support [⟨"defect-class","interstitial",rfl,rfl⟩]) && sameOrigin s.origin (.label ⟨"defect-origin","intrinsic",rfl,rfl⟩)
def substitutionWitness : Bool := match substitution with
 | .error _ => false
 | .ok s => sameClasses s.classes (.support [⟨"defect-class","substitution",rfl,rfl⟩]) && sameOrigin s.origin (.label ⟨"defect-origin","extrinsic",rfl,rfl⟩)
set_option maxRecDepth 10000
set_option maxHeartbeats 20000000
theorem pristinePassed : pristineWitness=true := by decide
theorem vacancyPassed : vacancyWitness=true := by decide
theorem interstitialPassed : interstitialWitness=true := by decide
theorem substitutionPassed : substitutionWitness=true := by decide
end SFT.Chemistry.DefectWitnesses

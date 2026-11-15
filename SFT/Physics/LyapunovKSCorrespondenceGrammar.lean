import SFT.Physics.LyapunovKSCorrespondenceCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.LyapunovKSCorrespondenceGrammar
open LyapunovKSCorrespondenceCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Label where
 | c0
 | c1
 | c2
def labelName : Label → String
 | .c0 => "complete-generated-m-label-domain"
 | .c1 => "selected-two-label-domain"
 | .c2 => "target-assigned-label-domain"
def labelPassed : Label → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Separation where
 | c0
 | c1
 | c2
def separationName : Separation → String
 | .c0 => "uncast-local-separation-multiplied-by-m"
 | .c1 => "free-separation-exponent"
 | .c2 => "target-assigned-expansion"
def separationPassed : Separation → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Support where
 | c0
 | c1
 | c2
def supportName : Support → String
 | .c0 => "complete-depth-support-m-to-d"
 | .c1 => "fixed-binary-support"
 | .c2 => "selected-support-subset"
def supportPassed : Support → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Carrier where
 | c0
 | c1
 | c2
def carrierName : Carrier → String
 | .c0 => "same-m-carries-separation-and-support-growth"
 | .c1 => "independent-rate-parameters"
 | .c2 => "measurement-equated-carriers"
def carrierPassed : Carrier → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Information where
 | c0
 | c1
 | c2
def informationName : Information → String
 | .c0 => "one-m-label-distinction-per-depth"
 | .c1 => "untyped-information-increment"
 | .c2 => "target-assigned-bit-rate"
def informationPassed : Information → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Analytic where
 | c0
 | c1
 | c2
def analyticName : Analytic → String
 | .c0 => "exact-carrier-only-symbolic-external-translation"
 | .c1 => "imported-analytic-proof-value"
 | .c2 => "decimal-rate-as-proof"
def analyticPassed : Analytic → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Target where
 | c0
 | c1
def targetName : Target → String
 | .c0 => "sealed-before-observation-release"
 | .c1 => "observation-readable-before-seal"
def targetPassed : Target → Bool
 | .c0 => true
 | .c1 => false
inductive Extension where
 | c0
 | c1
def extensionName : Extension → String
 | .c0 => "empty-extension"
 | .c1 => "free-rate-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 label : Label
 separation : Separation
 support : Support
 carrier : Carrier
 information : Information
 analytic : Analytic
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [labelName c.label,separationName c.separation,supportName c.support,carrierName c.carrier,informationName c.information,analyticName c.analytic,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let exactFacts ← certificateFacts
 pure [("label-domain",(labelPassed c.label && (exactFacts))),("separation-law",(separationPassed c.separation && (exactFacts))),("support-law",(supportPassed c.support && (exactFacts))),("common-carrier",(carrierPassed c.carrier && (exactFacts))),("information-step",(informationPassed c.information && (exactFacts))),("analytic-boundary",(analyticPassed c.analytic && (exactFacts))),("target-custody",targetPassed c.target),("extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("label-domain",labelPassed c.label),("separation-law",separationPassed c.separation),("support-law",supportPassed c.support),("common-carrier",carrierPassed c.carrier),("information-step",informationPassed c.information),("analytic-boundary",analyticPassed c.analytic),("target-custody",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalComputedFacts]
 cases c with
 | mk label separation support carrier information analytic target extension =>
  cases label <;> cases separation <;> cases support <;> cases carrier <;> cases information <;> cases analytic <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun label =>
 [.c0,.c1,.c2].flatMap (fun separation =>
 [.c0,.c1,.c2].flatMap (fun support =>
 [.c0,.c1,.c2].flatMap (fun carrier =>
 [.c0,.c1,.c2].flatMap (fun information =>
 [.c0,.c1,.c2].flatMap (fun analytic =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨label,separation,support,carrier,information,analytic,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨label,separation,support,carrier,information,analytic,target,extension⟩
 cases label <;> cases separation <;> cases support <;> cases carrier <;> cases information <;> cases analytic <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨label,separation,support,carrier,information,analytic,target,extension⟩
 have hlabel : label∈[Label.c0,Label.c1,Label.c2] := by
  cases label <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hseparation : separation∈[Separation.c0,Separation.c1,Separation.c2] := by
  cases separation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hsupport : support∈[Support.c0,Support.c1,Support.c2] := by
  cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcarrier : carrier∈[Carrier.c0,Carrier.c1,Carrier.c2] := by
  cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hinformation : information∈[Information.c0,Information.c1,Information.c2] := by
  cases information <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hanalytic : analytic∈[Analytic.c0,Analytic.c1,Analytic.c2] := by
  cases analytic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ label _ hlabel
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ separation _ hseparation
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ support _ hsupport
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ carrier _ hcarrier
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ information _ hinformation
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ analytic _ hanalytic
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every complete, selected or target-assigned label domain; every exact, free or target-assigned separation law; every complete, fixed or selected support law; every common, independent or measurement-equated carrier relation; every exact, untyped or target-assigned information step; every exact-symbolic, imported-analytic or decimal proof boundary; both target-custody states; and both extension states."
def grammarBoundary : String := "Every positive finite complete generated label count m of at least two, every positive Fold depth d, every positive local separation, complete m-label word support and its successor. The exact theorem returns the shared positive-whole carrier m; analytic logarithmic notation remains solely an external comparison label."
end SFT.Physics.LyapunovKSCorrespondenceGrammar

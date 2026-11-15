import SFT.Physics.SymmetricSourceConservationCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.SymmetricSourceConservationGrammar
open SymmetricSourceConservationCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Components where
 | c0
 | c1
 | c2
def componentsName : Components → String
 | .c0 => "complete-ten-symmetric-source-slots"
 | .c1 => "scalar-source-only"
 | .c2 => "target-assigned-components"
def componentsPassed : Components → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Pairing where
 | c0
 | c1
 | c2
def pairingName : Pairing → String
 | .c0 => "one-curvature-slot-to-one-source-slot"
 | .c1 => "aggregate-source-equation"
 | .c2 => "target-assigned-pairing"
def pairingPassed : Pairing → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Derivative where
 | c0
 | c1
 | c2
def derivativeName : Derivative → String
 | .c0 => "commuting-generated-shift-differences"
 | .c1 => "imported-continuum-derivatives"
 | .c2 => "target-assigned-operator"
def derivativePassed : Derivative → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Conservation where
 | c0
 | c1
 | c2
def conservationName : Conservation → String
 | .c0 => "four-exact-opposed-ledger-identities"
 | .c1 => "asserted-conservation-only"
 | .c2 => "target-assigned-conservation"
def conservationPassed : Conservation → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Source where
 | c0
 | c1
 | c2
def sourceName : Source → String
 | .c0 => "energy-one-momentum-three-stress-six"
 | .c1 => "unlabelled-ten-slots"
 | .c2 => "target-assigned-source-meaning"
def sourcePassed : Source → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Leak where
 | c0
 | c1
 | c2
def leakName : Leak → String
 | .c0 => "missing-flow-breaks-exact-balance"
 | .c1 => "leak-ignored"
 | .c2 => "target-assigned-leak"
def leakPassed : Leak → Bool
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
 | .c1 => "free-conservation-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 components : Components
 pairing : Pairing
 derivative : Derivative
 conservation : Conservation
 source : Source
 leak : Leak
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [componentsName c.components,pairingName c.pairing,derivativeName c.derivative,conservationName c.conservation,sourceName c.source,leakName c.leak,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let exactFacts := certificateFacts
 pure [("components",(componentsPassed c.components && (exactFacts))),("pairing",(pairingPassed c.pairing && (exactFacts))),("derivative",(derivativePassed c.derivative && (exactFacts))),("conservation",(conservationPassed c.conservation && (exactFacts))),("source",(sourcePassed c.source && (exactFacts))),("leak",(leakPassed c.leak && (exactFacts))),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("components",componentsPassed c.components),("pairing",pairingPassed c.pairing),("derivative",derivativePassed c.derivative),("conservation",conservationPassed c.conservation),("source",sourcePassed c.source),("leak",leakPassed c.leak),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalCertificateFacts]
 cases c with
 | mk components pairing derivative conservation source leak target extension =>
  cases components <;> cases pairing <;> cases derivative <;> cases conservation <;> cases source <;> cases leak <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun components =>
 [.c0,.c1,.c2].flatMap (fun pairing =>
 [.c0,.c1,.c2].flatMap (fun derivative =>
 [.c0,.c1,.c2].flatMap (fun conservation =>
 [.c0,.c1,.c2].flatMap (fun source =>
 [.c0,.c1,.c2].flatMap (fun leak =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨components,pairing,derivative,conservation,source,leak,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨components,pairing,derivative,conservation,source,leak,target,extension⟩
 cases components <;> cases pairing <;> cases derivative <;> cases conservation <;> cases source <;> cases leak <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨components,pairing,derivative,conservation,source,leak,target,extension⟩
 have hcomponents : components∈[Components.c0,Components.c1,Components.c2] := by
  cases components <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hpairing : pairing∈[Pairing.c0,Pairing.c1,Pairing.c2] := by
  cases pairing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hderivative : derivative∈[Derivative.c0,Derivative.c1,Derivative.c2] := by
  cases derivative <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hconservation : conservation∈[Conservation.c0,Conservation.c1,Conservation.c2] := by
  cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hsource : source∈[Source.c0,Source.c1,Source.c2] := by
  cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hleak : leak∈[Leak.c0,Leak.c1,Leak.c2] := by
  cases leak <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ components _ hcomponents
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ pairing _ hpairing
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ derivative _ hderivative
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ conservation _ hconservation
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ source _ hsource
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ leak _ hleak
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every complete, scalar-only or target-assigned component organization; every componentwise, aggregate or target-assigned field pairing; every generated-shift, imported-continuum or target-assigned derivative algebra; every exact, asserted or target-assigned conservation identity; every complete, unlabelled or target-assigned source ledger; every detecting, ignored or target-assigned leak test; both target custody states; and both extension states."
def grammarBoundary : String := "Every exact symmetric rank-two carrier over four generated coordinate labels, its complete one-energy/three-momentum/six-stress source ledger, and every finite product-lattice depth whose held coordinate shifts commute. This theorem is the generated commuting-difference curvature channel, not an assertion that every nonlinear lattice discretization has the same operator form."
end SFT.Physics.SymmetricSourceConservationGrammar

import SFT.Physics.StrongCarrierMasslessConfinedCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.StrongCarrierMasslessConfinedGrammar
open StrongCarrierMasslessConfinedCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Sector where
 | c0
 | c1
 | c2
def sectorName : Sector → String
 | .c0 => "generated-colour-three-sector-with-eight-nonsinglet-carriers"
 | .c1 => "free-sector-or-mediator-count"
 | .c2 => "target-assigned-sector"
def sectorPassed : Sector → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Mass where
 | c0
 | c1
 | c2
def massName : Mass → String
 | .c0 => "empty-mass-label-with-no-rest-capture"
 | .c1 => "numerical-zero-or-positive-fitted-mass"
 | .c2 => "target-assigned-mass"
def massPassed : Mass → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Causal where
 | c0
 | c1
 | c2
def causalName : Causal → String
 | .c0 => "One-support-cell-per-tick-with-retained-phase"
 | .c1 => "free-sub-or-super-One-speed"
 | .c2 => "target-assigned-speed"
def causalPassed : Causal → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Selfsource where
 | c0
 | c1
 | c2
def selfSourceName : Selfsource → String
 | .c0 => "colour-carrying-mediator-resources-its-own-channel"
 | .c1 => "chargeless-linear-carrier"
 | .c2 => "target-assigned-self-source"
def selfSourcePassed : Selfsource → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Confinement where
 | c0
 | c1
 | c2
def confinementName : Confinement → String
 | .c0 => "fixed-half-One-tube-and-two-thirds-work-successor"
 | .c1 => "spreading-flux-or-bounded-separation-work"
 | .c2 => "target-assigned-confinement"
def confinementPassed : Confinement → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Composition where
 | c0
 | c1
 | c2
def compositionName : Composition → String
 | .c0 => "local-massless-One-speed-and-asymptotic-confined-records-coexist"
 | .c1 => "masslessness-and-confinement-treated-as-exclusive"
 | .c2 => "target-assigned-composition"
def compositionPassed : Composition → Bool
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
 | .c1 => "free-carrier-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 sector : Sector
 mass : Mass
 causal : Causal
 selfSource : Selfsource
 confinement : Confinement
 composition : Composition
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [sectorName c.sector,massName c.mass,causalName c.causal,selfSourceName c.selfSource,confinementName c.confinement,compositionName c.composition,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let exactFacts ← certificateFacts
 pure [("sector",(sectorPassed c.sector && (exactFacts))),("mass",(massPassed c.mass && (exactFacts))),("causal",(causalPassed c.causal && (exactFacts))),("self_source",(selfSourcePassed c.selfSource && (exactFacts))),("confinement",(confinementPassed c.confinement && (exactFacts))),("composition",(compositionPassed c.composition && (exactFacts))),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("sector",sectorPassed c.sector),("mass",massPassed c.mass),("causal",causalPassed c.causal),("self_source",selfSourcePassed c.selfSource),("confinement",confinementPassed c.confinement),("composition",compositionPassed c.composition),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalComputedFacts]
 cases c with
 | mk sector mass causal selfSource confinement composition target extension =>
  cases sector <;> cases mass <;> cases causal <;> cases selfSource <;> cases confinement <;> cases composition <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun sector =>
 [.c0,.c1,.c2].flatMap (fun mass =>
 [.c0,.c1,.c2].flatMap (fun causal =>
 [.c0,.c1,.c2].flatMap (fun selfSource =>
 [.c0,.c1,.c2].flatMap (fun confinement =>
 [.c0,.c1,.c2].flatMap (fun composition =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨sector,mass,causal,selfSource,confinement,composition,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨sector,mass,causal,selfSource,confinement,composition,target,extension⟩
 cases sector <;> cases mass <;> cases causal <;> cases selfSource <;> cases confinement <;> cases composition <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨sector,mass,causal,selfSource,confinement,composition,target,extension⟩
 have hsector : sector∈[Sector.c0,Sector.c1,Sector.c2] := by
  cases sector <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hmass : mass∈[Mass.c0,Mass.c1,Mass.c2] := by
  cases mass <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcausal : causal∈[Causal.c0,Causal.c1,Causal.c2] := by
  cases causal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hselfSource : selfSource∈[Selfsource.c0,Selfsource.c1,Selfsource.c2] := by
  cases selfSource <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hconfinement : confinement∈[Confinement.c0,Confinement.c1,Confinement.c2] := by
  cases confinement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcomposition : composition∈[Composition.c0,Composition.c1,Composition.c2] := by
  cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ sector _ hsector
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ mass _ hmass
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ causal _ hcausal
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ selfSource _ hselfSource
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ confinement _ hconfinement
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ composition _ hcomposition
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every generated, free or target-assigned colour sector; every empty, numeric/fitted or target-assigned mass law; every One-speed, free-speed or target-assigned causal law; every colour self-source, chargeless or target-assigned carrier law; every fixed-tube, spreading/bounded or target-assigned confinement law; every simultaneous, exclusive or target-assigned composition; both target custody states; and both extension states."
def grammarBoundary : String := "The generated colour-three carrier at every positive finite causal tick and separation depth. Masslessness is the empty mass/rest-capture record and One-cell-per-tick local phase propagation; confinement is fixed-width self-sourced colour transport whose positive separation work exceeds every nominated positive exact bound at a finite witness. No completed infinity or claim about an observable isolated colour carrier enters."
end SFT.Physics.StrongCarrierMasslessConfinedGrammar

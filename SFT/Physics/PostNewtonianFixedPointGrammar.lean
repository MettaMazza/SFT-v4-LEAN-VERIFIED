import SFT.Physics.PostNewtonianFixedPointCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.PostNewtonianFixedPointGrammar
open PostNewtonianFixedPointCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Source where
 | c0
 | c1
 | c2
def sourceName : Source → String
 | .c0 => "binary-colour-source-seven-sixteenths"
 | .c1 => "free-matter-source"
 | .c2 => "target-assigned-source"
def sourcePassed : Source → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Coupling where
 | c0
 | c1
 | c2
def couplingName : Coupling → String
 | .c0 => "forced-half-One"
 | .c1 => "free-coupling"
 | .c2 => "target-assigned-coupling"
def couplingPassed : Coupling → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Action where
 | c0
 | c1
 | c2
def actionName : Action → String
 | .c0 => "matter-plus-field-square"
 | .c1 => "linear-no-self-source"
 | .c2 => "target-assigned-correction"
def actionPassed : Action → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Fixed where
 | c0
 | c1
 | c2
def fixedName : Fixed → String
 | .c0 => "unique-admissible-quarter-One"
 | .c1 => "select-larger-root"
 | .c2 => "measurement-selected-fixed-point"
def fixedPassed : Fixed → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Convergence where
 | c0
 | c1
 | c2
def convergenceName : Convergence → String
 | .c0 => "exact-error-and-correction-contraction"
 | .c1 => "finite-prefix-only"
 | .c2 => "assumed-series-convergence"
def convergencePassed : Convergence → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Scope where
 | c0
 | c1
 | c2
def scopeName : Scope → String
 | .c0 => "exact-Fold-scalar-self-source-channel"
 | .c1 => "universal-general-relativity-convergence"
 | .c2 => "historical-sequence-only"
def scopePassed : Scope → Bool
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
 | .c1 => "free-convergence-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 source : Source
 coupling : Coupling
 action : Action
 fixed : Fixed
 convergence : Convergence
 scope : Scope
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [sourceName c.source,couplingName c.coupling,actionName c.action,fixedName c.fixed,convergenceName c.convergence,scopeName c.scope,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let exactFacts ← certificateFacts
 pure [("source",(sourcePassed c.source && (exactFacts))),("coupling",(couplingPassed c.coupling && (exactFacts))),("action",(actionPassed c.action && (exactFacts))),("fixed",(fixedPassed c.fixed && (exactFacts))),("convergence",(convergencePassed c.convergence && (exactFacts))),("scope",(scopePassed c.scope && (exactFacts))),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("source",sourcePassed c.source),("coupling",couplingPassed c.coupling),("action",actionPassed c.action),("fixed",fixedPassed c.fixed),("convergence",convergencePassed c.convergence),("scope",scopePassed c.scope),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalComputedFacts]
 cases c with
 | mk source coupling action fixed convergence scope target extension =>
  cases source <;> cases coupling <;> cases action <;> cases fixed <;> cases convergence <;> cases scope <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun source =>
 [.c0,.c1,.c2].flatMap (fun coupling =>
 [.c0,.c1,.c2].flatMap (fun action =>
 [.c0,.c1,.c2].flatMap (fun fixed =>
 [.c0,.c1,.c2].flatMap (fun convergence =>
 [.c0,.c1,.c2].flatMap (fun scope =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨source,coupling,action,fixed,convergence,scope,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨source,coupling,action,fixed,convergence,scope,target,extension⟩
 cases source <;> cases coupling <;> cases action <;> cases fixed <;> cases convergence <;> cases scope <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨source,coupling,action,fixed,convergence,scope,target,extension⟩
 have hsource : source∈[Source.c0,Source.c1,Source.c2] := by
  cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcoupling : coupling∈[Coupling.c0,Coupling.c1,Coupling.c2] := by
  cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have haction : action∈[Action.c0,Action.c1,Action.c2] := by
  cases action <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hfixed : fixed∈[Fixed.c0,Fixed.c1,Fixed.c2] := by
  cases fixed <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hconvergence : convergence∈[Convergence.c0,Convergence.c1,Convergence.c2] := by
  cases convergence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hscope : scope∈[Scope.c0,Scope.c1,Scope.c2] := by
  cases scope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ source _ hsource
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ coupling _ hcoupling
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ action _ haction
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ fixed _ hfixed
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ convergence _ hconvergence
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ scope _ hscope
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every structural, free or target-assigned source; every forced, free or measured coupling; every quadratic, linear or target-assigned action; every admissible, larger-root or measured fixed point; every exact, finite-only or assumed convergence law; every Fold-scalar, universal-GR or historical-only scope; both target custody states; and both extension states."
def grammarBoundary : String := "The exact self-source scalar channel generated by binary support, generator-three colour, half-One coupling, positive Fold parts, quadratic field-energy feedback and every positive iteration depth. The theorem does not claim numerical convergence of every post-Newtonian expansion for every physical source."
end SFT.Physics.PostNewtonianFixedPointGrammar

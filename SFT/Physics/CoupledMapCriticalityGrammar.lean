import SFT.Physics.CoupledMapCriticalityCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CoupledMapCriticalityGrammar
open CoupledMapCriticalityCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Expansion where
 | c0
 | c1
 | c2
def expansionName : Expansion → String
 | .c0 => "complete-generated-m-expansion"
 | .c1 => "selected-binary-expansion"
 | .c2 => "target-assigned-expansion"
def expansionPassed : Expansion → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Action where
 | c0
 | c1
 | c2
def actionName : Action → String
 | .c0 => "retain-one-minus-coupling-share"
 | .c1 => "free-residual-action"
 | .c2 => "target-assigned-residual"
def actionPassed : Action → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Threshold where
 | c0
 | c1
 | c2
def thresholdName : Threshold → String
 | .c0 => "unique-m-minus-one-over-m-boundary"
 | .c1 => "fixed-half-One-for-all-m"
 | .c2 => "measurement-selected-threshold"
def thresholdPassed : Threshold → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Regime where
 | c0
 | c1
 | c2
def regimeName : Regime → String
 | .c0 => "below-expands-boundary-neutral-above-contracts"
 | .c1 => "boundary-declared-contracting"
 | .c2 => "unclassified-criticality"
def regimePassed : Regime → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Scope where
 | c0
 | c1
 | c2
def scopeName : Scope → String
 | .c0 => "normalized-drive-response-transverse-channel"
 | .c1 => "arbitrary-topology-universal-threshold"
 | .c2 => "finite-example-only"
def scopePassed : Scope → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Analytic where
 | c0
 | c1
 | c2
def analyticName : Analytic → String
 | .c0 => "exact-rational-carrier-symbolic-external-translation"
 | .c1 => "imported-exponential-proof-value"
 | .c2 => "decimal-criticality-proof"
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
 | .c1 => "free-threshold-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 expansion : Expansion
 action : Action
 threshold : Threshold
 regime : Regime
 scope : Scope
 analytic : Analytic
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [expansionName c.expansion,actionName c.action,thresholdName c.threshold,regimeName c.regime,scopeName c.scope,analyticName c.analytic,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let exactFacts ← certificateFacts
 pure [("expansion-domain",(expansionPassed c.expansion && (exactFacts))),("coupling-action",(actionPassed c.action && (exactFacts))),("threshold",(thresholdPassed c.threshold && (exactFacts))),("regimes",(regimePassed c.regime && (exactFacts))),("scope",(scopePassed c.scope && (exactFacts))),("analytic-boundary",(analyticPassed c.analytic && (exactFacts))),("target-custody",targetPassed c.target),("extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("expansion-domain",expansionPassed c.expansion),("coupling-action",actionPassed c.action),("threshold",thresholdPassed c.threshold),("regimes",regimePassed c.regime),("scope",scopePassed c.scope),("analytic-boundary",analyticPassed c.analytic),("target-custody",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalComputedFacts]
 cases c with
 | mk expansion action threshold regime scope analytic target extension =>
  cases expansion <;> cases action <;> cases threshold <;> cases regime <;> cases scope <;> cases analytic <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun expansion =>
 [.c0,.c1,.c2].flatMap (fun action =>
 [.c0,.c1,.c2].flatMap (fun threshold =>
 [.c0,.c1,.c2].flatMap (fun regime =>
 [.c0,.c1,.c2].flatMap (fun scope =>
 [.c0,.c1,.c2].flatMap (fun analytic =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨expansion,action,threshold,regime,scope,analytic,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨expansion,action,threshold,regime,scope,analytic,target,extension⟩
 cases expansion <;> cases action <;> cases threshold <;> cases regime <;> cases scope <;> cases analytic <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨expansion,action,threshold,regime,scope,analytic,target,extension⟩
 have hexpansion : expansion∈[Expansion.c0,Expansion.c1,Expansion.c2] := by
  cases expansion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have haction : action∈[Action.c0,Action.c1,Action.c2] := by
  cases action <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hthreshold : threshold∈[Threshold.c0,Threshold.c1,Threshold.c2] := by
  cases threshold <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hregime : regime∈[Regime.c0,Regime.c1,Regime.c2] := by
  cases regime <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hscope : scope∈[Scope.c0,Scope.c1,Scope.c2] := by
  cases scope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hanalytic : analytic∈[Analytic.c0,Analytic.c1,Analytic.c2] := by
  cases analytic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ expansion _ hexpansion
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ action _ haction
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ threshold _ hthreshold
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ regime _ hregime
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ scope _ hscope
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ analytic _ hanalytic
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every complete, selected or target-assigned expansion domain; every exact, free or target-assigned residual action; every forced, fixed or measured threshold; every exact, mislabeled or absent regime partition; every normalized, universalized or finite-only scope; every exact-symbolic, imported-analytic or decimal proof boundary; both target custody states; and both extension states."
def grammarBoundary : String := "Every complete generated positive label count m of at least two, every exact proper positive coupling g, the normalized drive-response transverse channel with retained share One-minus-g, and every positive successor depth. Arbitrary coupling topologies retain their separate transverse eigenvalue factors and are not assigned this threshold universally."
end SFT.Physics.CoupledMapCriticalityGrammar

import SFT.Physics.CoupledEnsembleSynchronizationCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CoupledEnsembleSynchronizationGrammar
open CoupledEnsembleSynchronizationCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Coupling where
 | c0
 | c1
 | c2
def couplingName : Coupling → String
 | .c0 => "complete-generated-coupling-alternatives"
 | .c1 => "selected-half-One-only"
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
 | .c0 => "both-members-move-equal-coupled-shares"
 | .c1 => "one-member-moves"
 | .c2 => "target-assigned-update"
def actionPassed : Action → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Balance where
 | c0
 | c1
 | c2
def balanceName : Balance → String
 | .c0 => "two-equal-moves-reassemble-complete-separation"
 | .c1 => "unequal-free-moves"
 | .c2 => "measurement-selected-balance"
def balancePassed : Balance → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Residual where
 | c0
 | c1
 | c2
def residualName : Residual → String
 | .c0 => "half-One-gives-empty-residual-off-half-stays-positive"
 | .c1 => "numerical-null-synchrony"
 | .c2 => "one-region-result-as-premise"
def residualPassed : Residual → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Terminal where
 | c0
 | c1
 | c2
def terminalName : Terminal → String
 | .c0 => "synchronized-class-remains-synchronized-under-successor"
 | .c1 => "universal-collapse-without-condition"
 | .c2 => "target-recurrence-as-law"
def terminalPassed : Terminal → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Closure where
 | c0
 | c1
 | c2
def closureName : Closure → String
 | .c0 => "arbitrary-positive-pair-and-successor-closure"
 | .c1 => "historical-ensemble-only"
 | .c2 => "finite-prefix-without-generality"
def closurePassed : Closure → Bool
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
 | .c1 => "free-coupling-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 coupling : Coupling
 action : Action
 balance : Balance
 residual : Residual
 terminal : Terminal
 closure : Closure
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [couplingName c.coupling,actionName c.action,balanceName c.balance,residualName c.residual,terminalName c.terminal,closureName c.closure,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let exactFacts ← certificateFacts
 pure [("coupling-domain",(couplingPassed c.coupling && (exactFacts))),("paired-action",(actionPassed c.action && (exactFacts))),("balance",(balancePassed c.balance && (exactFacts))),("residual",(residualPassed c.residual && (exactFacts))),("ensemble-terminal",(terminalPassed c.terminal && (exactFacts))),("closure",(closurePassed c.closure && (exactFacts))),("target-custody",targetPassed c.target),("extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("coupling-domain",couplingPassed c.coupling),("paired-action",actionPassed c.action),("balance",balancePassed c.balance),("residual",residualPassed c.residual),("ensemble-terminal",terminalPassed c.terminal),("closure",closurePassed c.closure),("target-custody",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalComputedFacts]
 cases c with
 | mk coupling action balance residual terminal closure target extension =>
  cases coupling <;> cases action <;> cases balance <;> cases residual <;> cases terminal <;> cases closure <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun coupling =>
 [.c0,.c1,.c2].flatMap (fun action =>
 [.c0,.c1,.c2].flatMap (fun balance =>
 [.c0,.c1,.c2].flatMap (fun residual =>
 [.c0,.c1,.c2].flatMap (fun terminal =>
 [.c0,.c1,.c2].flatMap (fun closure =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨coupling,action,balance,residual,terminal,closure,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨coupling,action,balance,residual,terminal,closure,target,extension⟩
 cases coupling <;> cases action <;> cases balance <;> cases residual <;> cases terminal <;> cases closure <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨coupling,action,balance,residual,terminal,closure,target,extension⟩
 have hcoupling : coupling∈[Coupling.c0,Coupling.c1,Coupling.c2] := by
  cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have haction : action∈[Action.c0,Action.c1,Action.c2] := by
  cases action <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hbalance : balance∈[Balance.c0,Balance.c1,Balance.c2] := by
  cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hresidual : residual∈[Residual.c0,Residual.c1,Residual.c2] := by
  cases residual <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hterminal : terminal∈[Terminal.c0,Terminal.c1,Terminal.c2] := by
  cases terminal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hclosure : closure∈[Closure.c0,Closure.c1,Closure.c2] := by
  cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ coupling _ hcoupling
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ action _ haction
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ balance _ hbalance
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ residual _ hresidual
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ terminal _ hterminal
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ closure _ hclosure
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every complete, selected or target-assigned coupling domain; every paired, one-sided or target-assigned movement; every exact balance, unequal or measurement-selected relation; every empty-record, numerical-null or result-as-premise residual semantics; every conditional terminal, universal collapse or target-recurrence ensemble law; every general, historical-only or uncertified closure; both target custody states; and both extension states."
def grammarBoundary : String := "Every ordered pair of exact positive Fold parts, the complete generated coupling alternatives around the forced half-One, equal coupled movement by a part of exact separation, empty structural equality records, every already synchronized finite positive ensemble and every positive successor depth. Arbitrary ensemble convergence is not assumed; it must be separately measured or proven for its registered recurrence."
end SFT.Physics.CoupledEnsembleSynchronizationGrammar

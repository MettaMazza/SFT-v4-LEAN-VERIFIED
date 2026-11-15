import SFT.Physics.StrongFieldNonlinearFixedPointCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.StrongFieldNonlinearFixedPointGrammar
open StrongFieldNonlinearFixedPointCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Source where
 | c0
 | c1
 | c2
def sourceName : Source → String
 | .c0 => "colour-carrier-retained-inside-its-own-source-update"
 | .c1 => "external-matter-source-only"
 | .c2 => "target-assigned-source-composition"
def sourcePassed : Source → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Update where
 | c0
 | c1
 | c2
def updateName : Update → String
 | .c0 => "each-successor-retains-prior-source-and-appends-complete-binary-carrier"
 | .c1 => "free-linear-contracted-or-oscillatory-update"
 | .c2 => "target-assigned-update"
def updatePassed : Update → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Correction where
 | c0
 | c1
 | c2
def correctionName : Correction → String
 | .c0 => "persistent-exact-binary-correction-at-every-successor"
 | .c1 => "shrinking-or-free-correction"
 | .c2 => "target-assigned-correction"
def correctionPassed : Correction → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Fixed where
 | c0
 | c1
 | c2
def fixedName : Fixed → String
 | .c0 => "empty-positive-finite-fixed-point-record-by-F-plus-two-order"
 | .c1 => "selected-finite-strong-fixed-point"
 | .c2 => "target-assigned-fixed-point"
def fixedPassed : Fixed → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Comparator where
 | c0
 | c1
 | c2
def comparatorName : Comparator → String
 | .c0 => "neutral-hold-gravity-contraction-strong-persistence-three-way-discriminator"
 | .c1 => "conflate-all-self-source-iterations"
 | .c2 => "target-assigned-comparator"
def comparatorPassed : Comparator → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Confinement where
 | c0
 | c1
 | c2
def confinementName : Confinement → String
 | .c0 => "finite-witness-above-every-positive-exact-bound"
 | .c1 => "bounded-prefix-or-completed-infinity"
 | .c2 => "target-assigned-confinement"
def confinementPassed : Confinement → Bool
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
 | .c1 => "free-strong-field-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 source : Source
 update : Update
 correction : Correction
 fixed : Fixed
 comparator : Comparator
 confinement : Confinement
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [sourceName c.source,updateName c.update,correctionName c.correction,fixedName c.fixed,comparatorName c.comparator,confinementName c.confinement,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let exactFacts ← certificateFacts
 pure [("source",(sourcePassed c.source && (exactFacts))),("update",(updatePassed c.update && (exactFacts))),("correction",(correctionPassed c.correction && (exactFacts))),("fixed",(fixedPassed c.fixed && (exactFacts))),("comparator",(comparatorPassed c.comparator && (exactFacts))),("confinement",(confinementPassed c.confinement && (exactFacts))),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("source",sourcePassed c.source),("update",updatePassed c.update),("correction",correctionPassed c.correction),("fixed",fixedPassed c.fixed),("comparator",comparatorPassed c.comparator),("confinement",confinementPassed c.confinement),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalComputedFacts]
 cases c with
 | mk source update correction fixed comparator confinement target extension =>
  cases source <;> cases update <;> cases correction <;> cases fixed <;> cases comparator <;> cases confinement <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun source =>
 [.c0,.c1,.c2].flatMap (fun update =>
 [.c0,.c1,.c2].flatMap (fun correction =>
 [.c0,.c1,.c2].flatMap (fun fixed =>
 [.c0,.c1,.c2].flatMap (fun comparator =>
 [.c0,.c1,.c2].flatMap (fun confinement =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨source,update,correction,fixed,comparator,confinement,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨source,update,correction,fixed,comparator,confinement,target,extension⟩
 cases source <;> cases update <;> cases correction <;> cases fixed <;> cases comparator <;> cases confinement <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨source,update,correction,fixed,comparator,confinement,target,extension⟩
 have hsource : source∈[Source.c0,Source.c1,Source.c2] := by
  cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hupdate : update∈[Update.c0,Update.c1,Update.c2] := by
  cases update <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcorrection : correction∈[Correction.c0,Correction.c1,Correction.c2] := by
  cases correction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hfixed : fixed∈[Fixed.c0,Fixed.c1,Fixed.c2] := by
  cases fixed <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcomparator : comparator∈[Comparator.c0,Comparator.c1,Comparator.c2] := by
  cases comparator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hconfinement : confinement∈[Confinement.c0,Confinement.c1,Confinement.c2] := by
  cases confinement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ source _ hsource
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ update _ hupdate
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ correction _ hcorrection
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ fixed _ hfixed
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ comparator _ hcomparator
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ confinement _ hconfinement
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every colour-self-sourced, external-only or target-assigned source; every binary-successor, free or target-assigned update; every persistent, shrinking/free or target-assigned correction; every empty, selected or target-assigned finite fixed-point law; every exact three-way, conflated or target-assigned comparator; every arbitrary-bound, finite-prefix/completed-infinity or target-assigned confinement law; both target custody states; and both extension states."
def grammarBoundary : String := "Every positive finite iteration depth of the admitted colour self-source successor, every positive exact finite fixed-point candidate and work/source bound, the admitted gravitational scalar self-source channel, and the chargeless held-source control. The result distinguishes structural source recursion from polynomial degree and does not claim a conventional renormalized Yang-Mills solution."
end SFT.Physics.StrongFieldNonlinearFixedPointGrammar

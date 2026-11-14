import SFT.Physics.FusionFissionYieldThresholdProofs
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.FusionFissionYieldThresholdGrammar
open FusionFissionYieldThreshold FusionFissionYieldThresholdProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive PerNucleon where
 | c0
 | c1
 | c2
def perNucleonName : PerNucleon → String
 | .c0 => "fusion-greater-per-nucleon"
 | .c1 => "equal-per-nucleon"
 | .c2 => "fission-greater-per-nucleon"
def perNucleonPassed : PerNucleon → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem perNucleonComputed (x : PerNucleon) : perNucleonRelationIsForced (perNucleonName x) = .ok (perNucleonPassed x) := by
 cases x with
 | c0 => exact FusionFissionYieldThresholdProofs.perNucleon0
 | c1 => exact FusionFissionYieldThresholdProofs.perNucleon1
 | c2 => exact FusionFissionYieldThresholdProofs.perNucleon2
inductive Total where
 | c0
 | c1
 | c2
def totalName : Total → String
 | .c0 => "fusion-greater-total"
 | .c1 => "equal-total"
 | .c2 => "fission-greater-total"
def totalPassed : Total → Bool
 | .c0 => false
 | .c1 => false
 | .c2 => true
theorem totalComputed (x : Total) : totalReleaseRelationIsForced (totalName x) = .ok (totalPassed x) := by
 cases x with
 | c0 => exact FusionFissionYieldThresholdProofs.total0
 | c1 => exact FusionFissionYieldThresholdProofs.total1
 | c2 => exact FusionFissionYieldThresholdProofs.total2
inductive FusionCarrier where
 | c0
 | c1
 | c2
def fusionCarrierName : FusionCarrier → String
 | .c0 => "charged-boundary-approach"
 | .c1 => "neutral-capture-approach"
 | .c2 => "single-parent-internal-surface"
def fusionCarrierPassed : FusionCarrier → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem fusionCarrierComputed (x : FusionCarrier) : fusionThresholdCarrierIsForced (fusionCarrierName x) = .ok (fusionCarrierPassed x) := by
 cases x with
 | c0 => exact FusionFissionYieldThresholdProofs.fusionCarrier0
 | c1 => exact FusionFissionYieldThresholdProofs.fusionCarrier1
 | c2 => exact FusionFissionYieldThresholdProofs.fusionCarrier2
inductive FissionCarrier where
 | c0
 | c1
 | c2
def fissionCarrierName : FissionCarrier → String
 | .c0 => "charged-boundary-approach"
 | .c1 => "neutral-capture-or-internal-surface"
 | .c2 => "carrier-free-decomposition"
def fissionCarrierPassed : FissionCarrier → Bool
 | .c0 => false
 | .c1 => true
 | .c2 => false
theorem fissionCarrierComputed (x : FissionCarrier) : fissionThresholdCarrierIsForced (fissionCarrierName x) = .ok (fissionCarrierPassed x) := by
 cases x with
 | c0 => exact FusionFissionYieldThresholdProofs.fissionCarrier0
 | c1 => exact FusionFissionYieldThresholdProofs.fissionCarrier1
 | c2 => exact FusionFissionYieldThresholdProofs.fissionCarrier2
inductive Scope where
 | c0
 | c1
 | c2
def scopeName : Scope → String
 | .c0 => "one-universal-dimensional-threshold"
 | .c1 => "normalized-structure-with-reaction-specific-dimensions"
 | .c2 => "no-threshold-distinction"
def scopePassed : Scope → Bool
 | .c0 => false
 | .c1 => true
 | .c2 => false
theorem scopeComputed (x : Scope) : thresholdScopeIsForced (scopeName x) = .ok (scopePassed x) := by
 cases x with
 | c0 => exact FusionFissionYieldThresholdProofs.scope0
 | c1 => exact FusionFissionYieldThresholdProofs.scope1
 | c2 => exact FusionFissionYieldThresholdProofs.scope2
inductive Access where
 | c0
 | c1
 | c2
def accessName : Access → String
 | .c0 => "thermal-or-directed-energy-support"
 | .c1 => "one-universal-temperature-value"
 | .c2 => "no-access-support"
def accessPassed : Access → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem accessComputed (x : Access) : accessCarrierIsForced (accessName x) = .ok (accessPassed x) := by
 cases x with
 | c0 => exact FusionFissionYieldThresholdProofs.access0
 | c1 => exact FusionFissionYieldThresholdProofs.access1
 | c2 => exact FusionFissionYieldThresholdProofs.access2
inductive Metric where
 | c0
 | c1
def metricName : Metric → String
 | .c0 => "retain-per-nucleon-and-total-separately"
 | .c1 => "conflate-per-nucleon-with-total"
def metricPassed : Metric → Bool
 | .c0 => true
 | .c1 => false
theorem metricComputed (x : Metric) : metricRetentionIsForced (metricName x) = .ok (metricPassed x) := by
 cases x with
 | c0 => exact FusionFissionYieldThresholdProofs.metric0
 | c1 => exact FusionFissionYieldThresholdProofs.metric1
inductive Target where
 | c0
 | c1
def targetName : Target → String
 | .c0 => "sealed-before-release"
 | .c1 => "readable-before-seal"
def targetPassed : Target → Bool
 | .c0 => true
 | .c1 => false
theorem targetComputed (x : Target) : targetBoundaryIsForced (targetName x) = .ok (targetPassed x) := by
 cases x with
 | c0 => exact FusionFissionYieldThresholdProofs.target0
 | c1 => exact FusionFissionYieldThresholdProofs.target1
inductive Extension where
 | c0
 | c1
def extensionName : Extension → String
 | .c0 => "empty-extension"
 | .c1 => "free-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
theorem extensionComputed (x : Extension) : extensionIsForced (extensionName x) = .ok (extensionPassed x) := by
 cases x with
 | c0 => exact FusionFissionYieldThresholdProofs.extension0
 | c1 => exact FusionFissionYieldThresholdProofs.extension1
structure Candidate where
 perNucleon : PerNucleon
 total : Total
 fusionCarrier : FusionCarrier
 fissionCarrier : FissionCarrier
 scope : Scope
 access : Access
 metric : Metric
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [perNucleonName c.perNucleon,totalName c.total,fusionCarrierName c.fusionCarrier,fissionCarrierName c.fissionCarrier,scopeName c.scope,accessName c.access,metricName c.metric,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let perNucleon ← perNucleonRelationIsForced (perNucleonName c.perNucleon)
 let total ← totalReleaseRelationIsForced (totalName c.total)
 let fusionCarrier ← fusionThresholdCarrierIsForced (fusionCarrierName c.fusionCarrier)
 let fissionCarrier ← fissionThresholdCarrierIsForced (fissionCarrierName c.fissionCarrier)
 let scope ← thresholdScopeIsForced (scopeName c.scope)
 let access ← accessCarrierIsForced (accessName c.access)
 let metric ← metricRetentionIsForced (metricName c.metric)
 let target ← targetBoundaryIsForced (targetName c.target)
 let extension ← extensionIsForced (extensionName c.extension)
 pure [("per_nucleon_relation",perNucleon),("total_release_relation",total),("fusion_threshold_carrier",fusionCarrier),("fission_threshold_carrier",fissionCarrier),("threshold_scope",scope),("access_carrier",access),("metric_retention",metric),("target_boundary",target),("extension",extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("per_nucleon_relation",perNucleonPassed c.perNucleon),("total_release_relation",totalPassed c.total),("fusion_threshold_carrier",fusionCarrierPassed c.fusionCarrier),("fission_threshold_carrier",fissionCarrierPassed c.fissionCarrier),("threshold_scope",scopePassed c.scope),("access_carrier",accessPassed c.access),("metric_retention",metricPassed c.metric),("target_boundary",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c = .ok (computedFacts c) := by
 unfold candidateFacts
 rw [perNucleonComputed,totalComputed,fusionCarrierComputed,fissionCarrierComputed,scopeComputed,accessComputed,metricComputed,targetComputed,extensionComputed]
 rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do
 pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c = .ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun perNucleon =>
 [.c0,.c1,.c2].flatMap (fun total =>
 [.c0,.c1,.c2].flatMap (fun fusionCarrier =>
 [.c0,.c1,.c2].flatMap (fun fissionCarrier =>
 [.c0,.c1,.c2].flatMap (fun scope =>
 [.c0,.c1,.c2].flatMap (fun access =>
 [.c0,.c1].flatMap (fun metric =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨perNucleon,total,fusionCarrier,fissionCarrier,scope,access,metric,target,extension⟩)))))))))
def survivor : Candidate := ⟨.c0,.c2,.c0,.c1,.c1,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length = 5832 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c = true → c = survivor := by
 rcases c with ⟨perNucleon,total,fusionCarrier,fissionCarrier,scope,access,metric,target,extension⟩
 cases perNucleon <;> cases total <;> cases fusionCarrier <;> cases fissionCarrier <;> cases scope <;> cases access <;> cases metric <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor = true := rfl
theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
 rcases c with ⟨perNucleon,total,fusionCarrier,fissionCarrier,scope,access,metric,target,extension⟩
 have hperNucleon : perNucleon ∈ [PerNucleon.c0,PerNucleon.c1,PerNucleon.c2] := by
  cases perNucleon <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htotal : total ∈ [Total.c0,Total.c1,Total.c2] := by
  cases total <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hfusionCarrier : fusionCarrier ∈ [FusionCarrier.c0,FusionCarrier.c1,FusionCarrier.c2] := by
  cases fusionCarrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hfissionCarrier : fissionCarrier ∈ [FissionCarrier.c0,FissionCarrier.c1,FissionCarrier.c2] := by
  cases fissionCarrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hscope : scope ∈ [Scope.c0,Scope.c1,Scope.c2] := by
  cases scope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have haccess : access ∈ [Access.c0,Access.c1,Access.c2] := by
  cases access <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hmetric : metric ∈ [Metric.c0,Metric.c1] := by
  cases metric <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target ∈ [Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension ∈ [Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ perNucleon _ hperNucleon
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ total _ htotal
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ fusionCarrier _ hfusionCarrier
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ fissionCarrier _ hfissionCarrier
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ scope _ hscope
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ access _ haccess
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ metric _ hmetric
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of all three exact per-nucleon orders, all three total-release orders, all generated fusion and fission threshold-carrier classes, all threshold scopes, all access-carrier classes, both metric-retention states, both target-custody states and both extension states."
def grammarBoundary : String := "The least light binary junction D+D to He-4 and the registered symmetric heavy decomposition U-238 to two Pd-119 words; every strict or equal ordering of their exact binding-score enclosures; every incident charged, neutral or internal boundary class; normalized versus dimensional threshold scope; thermal or directed access support; separate versus conflated release metrics; sealed or exposed target custody; and empty or free extension.  The certificate is not bounded by a Fold search depth."
end SFT.Physics.FusionFissionYieldThresholdGrammar

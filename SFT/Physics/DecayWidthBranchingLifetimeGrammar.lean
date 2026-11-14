import SFT.Physics.DecayWidthBranchingLifetimeProofs
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.DecayWidthBranchingLifetimeGrammar
open DecayWidthBranchingLifetime DecayWidthBranchingLifetimeCertificate DecayWidthBranchingLifetimeProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Width where
 | c0
 | c1
 | c2
def widthName : Width → String
 | .c0 => "paired-transition-weight-times-output-support-per-action"
 | .c1 => "unpaired-transition-leg-times-output-support"
 | .c2 => "target-assigned-partial-width"
def widthPassed : Width → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem widthComputed (x : Width) : partialWidthCarrierIsForced (widthName x) = .ok (widthPassed x) := by
 cases x with
 | c0 => exact DecayWidthBranchingLifetimeProofs.partialWidthCarrier0
 | c1 => exact DecayWidthBranchingLifetimeProofs.partialWidthCarrier1
 | c2 => exact DecayWidthBranchingLifetimeProofs.partialWidthCarrier2
inductive Domain where
 | c0
 | c1
 | c2
def domainName : Domain → String
 | .c0 => "positive-open-channels-closed-as-empty"
 | .c1 => "numeric-null-closed-channels"
 | .c2 => "indistinguishable-overlapping-channel-list"
def domainPassed : Domain → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem domainComputed (x : Domain) : channelDomainIsForced (domainName x) = .ok (domainPassed x) := by
 cases x with
 | c0 => exact DecayWidthBranchingLifetimeProofs.channelDomain0
 | c1 => exact DecayWidthBranchingLifetimeProofs.channelDomain1
 | c2 => exact DecayWidthBranchingLifetimeProofs.channelDomain2
inductive Total where
 | c0
 | c1
 | c2
def totalName : Total → String
 | .c0 => "ordered-positive-sum-of-partial-widths"
 | .c1 => "largest-partial-width-only"
 | .c2 => "arithmetic-mean-of-partial-widths"
def totalPassed : Total → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem totalComputed (x : Total) : totalWidthLawIsForced (totalName x) = .ok (totalPassed x) := by
 cases x with
 | c0 => exact DecayWidthBranchingLifetimeProofs.totalWidthLaw0
 | c1 => exact DecayWidthBranchingLifetimeProofs.totalWidthLaw1
 | c2 => exact DecayWidthBranchingLifetimeProofs.totalWidthLaw2
inductive Branch where
 | c0
 | c1
 | c2
def branchName : Branch → String
 | .c0 => "partial-width-over-total-width"
 | .c1 => "total-width-over-partial-width"
 | .c2 => "unnormalized-partial-width"
def branchPassed : Branch → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem branchComputed (x : Branch) : branchingLawIsForced (branchName x) = .ok (branchPassed x) := by
 cases x with
 | c0 => exact DecayWidthBranchingLifetimeProofs.branchingLaw0
 | c1 => exact DecayWidthBranchingLifetimeProofs.branchingLaw1
 | c2 => exact DecayWidthBranchingLifetimeProofs.branchingLaw2
inductive Partition where
 | c0
 | c1
 | c2
def partitionName : Partition → String
 | .c0 => "complete-exclusive-partition-of-one"
 | .c1 => "incomplete-open-channel-subset"
 | .c2 => "overlapping-double-counted-channels"
def partitionPassed : Partition → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem partitionComputed (x : Partition) : partitionLawIsForced (partitionName x) = .ok (partitionPassed x) := by
 cases x with
 | c0 => exact DecayWidthBranchingLifetimeProofs.partitionLaw0
 | c1 => exact DecayWidthBranchingLifetimeProofs.partitionLaw1
 | c2 => exact DecayWidthBranchingLifetimeProofs.partitionLaw2
inductive Lifetime where
 | c0
 | c1
 | c2
def lifetimeName : Lifetime → String
 | .c0 => "action-over-total-width"
 | .c1 => "total-width-over-action"
 | .c2 => "action-times-total-width"
def lifetimePassed : Lifetime → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem lifetimeComputed (x : Lifetime) : lifetimeLawIsForced (lifetimeName x) = .ok (lifetimePassed x) := by
 cases x with
 | c0 => exact DecayWidthBranchingLifetimeProofs.lifetimeLaw0
 | c1 => exact DecayWidthBranchingLifetimeProofs.lifetimeLaw1
 | c2 => exact DecayWidthBranchingLifetimeProofs.lifetimeLaw2
inductive Ordering where
 | c0
 | c1
 | c2
def orderingName : Ordering → String
 | .c0 => "greater-width-shorter-lifetime"
 | .c1 => "greater-width-longer-lifetime"
 | .c2 => "width-independent-lifetime"
def orderingPassed : Ordering → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem orderingComputed (x : Ordering) : orderingLawIsForced (orderingName x) = .ok (orderingPassed x) := by
 cases x with
 | c0 => exact DecayWidthBranchingLifetimeProofs.orderingLaw0
 | c1 => exact DecayWidthBranchingLifetimeProofs.orderingLaw1
 | c2 => exact DecayWidthBranchingLifetimeProofs.orderingLaw2
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
 | c0 => exact DecayWidthBranchingLifetimeProofs.targetBoundary0
 | c1 => exact DecayWidthBranchingLifetimeProofs.targetBoundary1
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
 | c0 => exact DecayWidthBranchingLifetimeProofs.extension0
 | c1 => exact DecayWidthBranchingLifetimeProofs.extension1
structure Candidate where
 width : Width
 domain : Domain
 total : Total
 branch : Branch
 partition : Partition
 lifetime : Lifetime
 ordering : Ordering
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [widthName c.width,domainName c.domain,totalName c.total,branchName c.branch,partitionName c.partition,lifetimeName c.lifetime,orderingName c.ordering,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let width ← partialWidthCarrierIsForced (widthName c.width)
 let domain ← channelDomainIsForced (domainName c.domain)
 let total ← totalWidthLawIsForced (totalName c.total)
 let branch ← branchingLawIsForced (branchName c.branch)
 let partition ← partitionLawIsForced (partitionName c.partition)
 let lifetime ← lifetimeLawIsForced (lifetimeName c.lifetime)
 let ordering ← orderingLawIsForced (orderingName c.ordering)
 let target ← targetBoundaryIsForced (targetName c.target)
 let extension ← extensionIsForced (extensionName c.extension)
 pure [("partial_width_carrier",width),("channel_domain",domain),("total_width_law",total),("branching_law",branch),("partition_law",partition),("lifetime_law",lifetime),("ordering_law",ordering),("target_boundary",target),("extension",extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("partial_width_carrier",widthPassed c.width),("channel_domain",domainPassed c.domain),("total_width_law",totalPassed c.total),("branching_law",branchPassed c.branch),("partition_law",partitionPassed c.partition),("lifetime_law",lifetimePassed c.lifetime),("ordering_law",orderingPassed c.ordering),("target_boundary",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c = .ok (computedFacts c) := by
 unfold candidateFacts
 rw [widthComputed,domainComputed,totalComputed,branchComputed,partitionComputed,lifetimeComputed,orderingComputed,targetComputed,extensionComputed]
 rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do
 pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c = .ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun width =>
 [.c0,.c1,.c2].flatMap (fun domain =>
 [.c0,.c1,.c2].flatMap (fun total =>
 [.c0,.c1,.c2].flatMap (fun branch =>
 [.c0,.c1,.c2].flatMap (fun partition =>
 [.c0,.c1,.c2].flatMap (fun lifetime =>
 [.c0,.c1,.c2].flatMap (fun ordering =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨width,domain,total,branch,partition,lifetime,ordering,target,extension⟩)))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length = 8748 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c = true → c = survivor := by
 rcases c with ⟨width,domain,total,branch,partition,lifetime,ordering,target,extension⟩
 cases width <;> cases domain <;> cases total <;> cases branch <;> cases partition <;> cases lifetime <;> cases ordering <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor = true := rfl
theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
 rcases c with ⟨width,domain,total,branch,partition,lifetime,ordering,target,extension⟩
 have hwidth : width ∈ [Width.c0,Width.c1,Width.c2] := by
  cases width <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hdomain : domain ∈ [Domain.c0,Domain.c1,Domain.c2] := by
  cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htotal : total ∈ [Total.c0,Total.c1,Total.c2] := by
  cases total <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hbranch : branch ∈ [Branch.c0,Branch.c1,Branch.c2] := by
  cases branch <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hpartition : partition ∈ [Partition.c0,Partition.c1,Partition.c2] := by
  cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hlifetime : lifetime ∈ [Lifetime.c0,Lifetime.c1,Lifetime.c2] := by
  cases lifetime <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hordering : ordering ∈ [Ordering.c0,Ordering.c1,Ordering.c2] := by
  cases ordering <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target ∈ [Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension ∈ [Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ width _ hwidth
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ domain _ hdomain
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ total _ htotal
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ branch _ hbranch
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ partition _ hpartition
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ lifetime _ hlifetime
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ ordering _ hordering
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every paired or unpaired transition carrier, every open/closed channel domain, every total-width aggregator, every branching normalization, every completeness partition, every width-lifetime relation, every induced ordering, both target-custody states and both extension states."
def grammarBoundary : String := "Every nonempty finite generated family of mutually distinguishable open decay channels; exact positive rational overlap, available-output, action, partial-width and duration carriers; structurally empty closed channels; complete channel composition; sealed or exposed targets; and empty or free extension. The base and successor certificates are independent of a finite Fold depth and introduce no numerical null state."
end SFT.Physics.DecayWidthBranchingLifetimeGrammar

import SFT.Physics.DecayWidthBranchingLifetimeCertificate
namespace SFT.Physics.DecayWidthBranchingLifetimeProofs
open DecayWidthBranchingLifetimeCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem partialWidthCarrier0 : partialWidthCarrierIsForced "paired-transition-weight-times-output-support-per-action" = .ok true := rfl
theorem partialWidthCarrier1 : partialWidthCarrierIsForced "unpaired-transition-leg-times-output-support" = .ok false := rfl
theorem partialWidthCarrier2 : partialWidthCarrierIsForced "target-assigned-partial-width" = .ok false := rfl
theorem channelDomain0 : channelDomainIsForced "positive-open-channels-closed-as-empty" = .ok true := rfl
theorem channelDomain1 : channelDomainIsForced "numeric-null-closed-channels" = .ok false := rfl
theorem channelDomain2 : channelDomainIsForced "indistinguishable-overlapping-channel-list" = .ok false := rfl
theorem totalWidthLaw0 : totalWidthLawIsForced "ordered-positive-sum-of-partial-widths" = .ok true := rfl
theorem totalWidthLaw1 : totalWidthLawIsForced "largest-partial-width-only" = .ok false := rfl
theorem totalWidthLaw2 : totalWidthLawIsForced "arithmetic-mean-of-partial-widths" = .ok false := rfl
theorem branchingLaw0 : branchingLawIsForced "partial-width-over-total-width" = .ok true := rfl
theorem branchingLaw1 : branchingLawIsForced "total-width-over-partial-width" = .ok false := rfl
theorem branchingLaw2 : branchingLawIsForced "unnormalized-partial-width" = .ok false := rfl
theorem partitionLaw0 : partitionLawIsForced "complete-exclusive-partition-of-one" = .ok true := rfl
theorem partitionLaw1 : partitionLawIsForced "incomplete-open-channel-subset" = .ok false := rfl
theorem partitionLaw2 : partitionLawIsForced "overlapping-double-counted-channels" = .ok false := rfl
theorem lifetimeLaw0 : lifetimeLawIsForced "action-over-total-width" = .ok true := rfl
theorem lifetimeLaw1 : lifetimeLawIsForced "total-width-over-action" = .ok false := rfl
theorem lifetimeLaw2 : lifetimeLawIsForced "action-times-total-width" = .ok false := rfl
theorem orderingLaw0 : orderingLawIsForced "greater-width-shorter-lifetime" = .ok true := rfl
theorem orderingLaw1 : orderingLawIsForced "greater-width-longer-lifetime" = .ok false := rfl
theorem orderingLaw2 : orderingLawIsForced "width-independent-lifetime" = .ok false := rfl
theorem targetBoundary0 : targetBoundaryIsForced "sealed-before-release" = .ok true := rfl
theorem targetBoundary1 : targetBoundaryIsForced "readable-before-seal" = .ok false := rfl
theorem extension0 : extensionIsForced "empty-extension" = .ok true := rfl
theorem extension1 : extensionIsForced "free-correction" = .ok false := rfl
end SFT.Physics.DecayWidthBranchingLifetimeProofs

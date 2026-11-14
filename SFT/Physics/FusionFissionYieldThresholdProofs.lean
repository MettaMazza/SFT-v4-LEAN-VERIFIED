import SFT.Physics.FusionFissionYieldThreshold
namespace SFT.Physics.FusionFissionYieldThresholdProofs
open FusionFissionYieldThreshold LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem perNucleon0 : perNucleonRelationIsForced "fusion-greater-per-nucleon" = .ok true := rfl
theorem perNucleon1 : perNucleonRelationIsForced "equal-per-nucleon" = .ok false := rfl
theorem perNucleon2 : perNucleonRelationIsForced "fission-greater-per-nucleon" = .ok false := rfl
theorem total0 : totalReleaseRelationIsForced "fusion-greater-total" = .ok false := rfl
theorem total1 : totalReleaseRelationIsForced "equal-total" = .ok false := rfl
theorem total2 : totalReleaseRelationIsForced "fission-greater-total" = .ok true := rfl
theorem fusionCarrier0 : fusionThresholdCarrierIsForced "charged-boundary-approach" = .ok true := rfl
theorem fusionCarrier1 : fusionThresholdCarrierIsForced "neutral-capture-approach" = .ok false := rfl
theorem fusionCarrier2 : fusionThresholdCarrierIsForced "single-parent-internal-surface" = .ok false := rfl
theorem fissionCarrier0 : fissionThresholdCarrierIsForced "charged-boundary-approach" = .ok false := rfl
theorem fissionCarrier1 : fissionThresholdCarrierIsForced "neutral-capture-or-internal-surface" = .ok true := rfl
theorem fissionCarrier2 : fissionThresholdCarrierIsForced "carrier-free-decomposition" = .ok false := rfl
theorem scope0 : thresholdScopeIsForced "one-universal-dimensional-threshold" = .ok false := rfl
theorem scope1 : thresholdScopeIsForced "normalized-structure-with-reaction-specific-dimensions" = .ok true := rfl
theorem scope2 : thresholdScopeIsForced "no-threshold-distinction" = .ok false := rfl
theorem access0 : accessCarrierIsForced "thermal-or-directed-energy-support" = .ok true := rfl
theorem access1 : accessCarrierIsForced "one-universal-temperature-value" = .ok false := rfl
theorem access2 : accessCarrierIsForced "no-access-support" = .ok false := rfl
theorem metric0 : metricRetentionIsForced "retain-per-nucleon-and-total-separately" = .ok true := rfl
theorem metric1 : metricRetentionIsForced "conflate-per-nucleon-with-total" = .ok false := rfl
theorem target0 : FusionFissionYieldThreshold.targetBoundaryIsForced "sealed-before-release" = .ok true := rfl
theorem target1 : FusionFissionYieldThreshold.targetBoundaryIsForced "readable-before-seal" = .ok false := rfl
theorem extension0 : FusionFissionYieldThreshold.extensionIsForced "empty-extension" = .ok true := rfl
theorem extension1 : FusionFissionYieldThreshold.extensionIsForced "free-correction" = .ok false := rfl
theorem oppositeOrders : (do pure (← exactReleaseOrder).ordersAreDistinct) = Except.ok true := rfl
end SFT.Physics.FusionFissionYieldThresholdProofs

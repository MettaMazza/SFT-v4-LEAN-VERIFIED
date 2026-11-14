import SFT.Physics.DeuteronDinucleon
namespace SFT.Physics.DeuteronDinucleonProofs
open DeuteronDinucleon LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem partition0 : exchangePartitionIsForced "three-preserving-one-alternating" = .ok true := rfl
theorem partition1 : exchangePartitionIsForced "two-preserving-two-alternating" = .ok false := rfl
theorem partition2 : exchangePartitionIsForced "one-preserving-three-alternating" = .ok false := rfl
theorem ground0 : groundExchangeLedgerIsForced "pn-preserving-spin-ppnn-alternating-spin" = .ok true := rfl
theorem ground1 : groundExchangeLedgerIsForced "pn-alternating-spin-ppnn-preserving-spin" = .ok false := rfl
theorem ground2 : groundExchangeLedgerIsForced "all-pairs-preserving-spin" = .ok false := rfl
theorem residual0 : residualDiscriminatorIsForced "preserving-leaves-half-alternating-empty" = .ok true := rfl
theorem residual1 : residualDiscriminatorIsForced "quarter-act-binds-both-spin-hands" = .ok false := rfl
theorem residual2 : residualDiscriminatorIsForced "neither-spin-hand-retains-support" = .ok false := rfl
theorem binding0 : bindingTableIsForced "pn-only-bound" = .ok true := rfl
theorem binding1 : bindingTableIsForced "all-pairs-bound" = .ok false := rfl
theorem binding2 : bindingTableIsForced "no-pair-bound" = .ok false := rfl
theorem binding3 : bindingTableIsForced "identical-pairs-only-bound" = .ok false := rfl
theorem spin0 : compositeSpinIsForced "complete-One-with-three-readings" = .ok true := rfl
theorem spin1 : compositeSpinIsForced "empty-spin-with-one-reading" = .ok false := rfl
theorem spin2 : compositeSpinIsForced "spin-unresolved" = .ok false := rfl
theorem charged0 : chargedPairRoleIsForced "pp-positive-opposition-secondary-to-singlet-exclusion" = .ok true := rfl
theorem charged1 : chargedPairRoleIsForced "charged-path-selects-both-identical-outcomes" = .ok false := rfl
theorem target0 : targetBoundaryIsForced "sealed-before-release" = .ok true := rfl
theorem target1 : targetBoundaryIsForced "readable-before-seal" = .ok false := rfl
theorem extension0 : extensionIsForced "empty-extension" = .ok true := rfl
theorem extension1 : extensionIsForced "free-correction" = .ok false := rfl
theorem preservingSupport : spinSupport preserving = .ok (normalize 3 4 (by decide)) := rfl
theorem alternatingSupport : spinSupport alternating = .ok (normalize 1 4 (by decide)) := rfl
theorem preservingRetained : retainedAfterResidual preserving = .ok (some (normalize 1 2 (by decide))) := rfl
theorem alternatingExhausted : retainedAfterResidual alternating = .ok none := rfl
theorem completeBindingOutcomes : bindingOutcomes = .ok [("proton-neutron",true),("proton-proton",false),("neutron-neutron",false)] := rfl
end SFT.Physics.DeuteronDinucleonProofs

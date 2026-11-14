import SFT.Physics.ScatteringRutherfordCompton
namespace SFT.Physics.ScatteringRutherfordComptonProofs
open ScatteringRutherfordCompton
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem amplitudeCarrier0 : amplitudeCarrierIsForced "paired-phase-compatible-overlap-legs" = .ok true := rfl
theorem amplitudeCarrier1 : amplitudeCarrierIsForced "single-unpaired-channel-count" = .ok false := rfl
theorem amplitudeCarrier2 : amplitudeCarrierIsForced "imported-complex-amplitude" = .ok false := rfl
theorem crossSectionMeasure0 : crossSectionMeasureIsForced "paired-weight-per-incident-boundary-support" = .ok true := rfl
theorem crossSectionMeasure1 : crossSectionMeasureIsForced "unnormalized-outgoing-count" = .ok false := rfl
theorem crossSectionMeasure2 : crossSectionMeasureIsForced "target-fitted-area" = .ok false := rfl
theorem coulombAngularLaw0 : coulombAngularLawIsForced "inverse-transfer-part-squared" = .ok true := rfl
theorem coulombAngularLaw1 : coulombAngularLawIsForced "inverse-transfer-part-first-power" = .ok false := rfl
theorem coulombAngularLaw2 : coulombAngularLawIsForced "angle-independent-response" = .ok false := rfl
theorem coulombScaleLaw0 : coulombScaleLawIsForced "charge-product-squared-energy-inverse-squared" = .ok true := rfl
theorem coulombScaleLaw1 : coulombScaleLawIsForced "charge-product-linear-energy-inverse" = .ok false := rfl
theorem coulombScaleLaw2 : coulombScaleLawIsForced "free-dimensional-scale" = .ok false := rfl
theorem photonShiftLaw0 : photonShiftLawIsForced "two-transfer-parts-times-action-over-inertia-speed" = .ok true := rfl
theorem photonShiftLaw1 : photonShiftLawIsForced "one-transfer-part-times-action-over-inertia-speed" = .ok false := rfl
theorem photonShiftLaw2 : photonShiftLawIsForced "angle-independent-wavelength-change" = .ok false := rfl
theorem photonEnergyLaw0 : photonEnergyLawIsForced "rest-over-rest-plus-two-energy-transfer-parts" = .ok true := rfl
theorem photonEnergyLaw1 : photonEnergyLawIsForced "incident-energy-preserved" = .ok false := rfl
theorem photonEnergyLaw2 : photonEnergyLawIsForced "outgoing-energy-greater-than-incident" = .ok false := rfl
theorem targetBoundary0 : targetBoundaryIsForced "sealed-before-release" = .ok true := rfl
theorem targetBoundary1 : targetBoundaryIsForced "readable-before-seal" = .ok false := rfl
theorem extension0 : extensionIsForced "empty-extension" = .ok true := rfl
theorem extension1 : extensionIsForced "free-correction" = .ok false := rfl
end SFT.Physics.ScatteringRutherfordComptonProofs

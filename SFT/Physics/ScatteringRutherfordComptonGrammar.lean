import SFT.Physics.ScatteringRutherfordComptonProofs
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ScatteringRutherfordComptonGrammar
open ScatteringRutherfordCompton ScatteringRutherfordComptonProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Amplitude where
 | c0
 | c1
 | c2
def amplitudeName : Amplitude → String
 | .c0 => "paired-phase-compatible-overlap-legs"
 | .c1 => "single-unpaired-channel-count"
 | .c2 => "imported-complex-amplitude"
def amplitudePassed : Amplitude → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem amplitudeComputed (x : Amplitude) : amplitudeCarrierIsForced (amplitudeName x) = .ok (amplitudePassed x) := by
 cases x with
 | c0 => exact ScatteringRutherfordComptonProofs.amplitudeCarrier0
 | c1 => exact ScatteringRutherfordComptonProofs.amplitudeCarrier1
 | c2 => exact ScatteringRutherfordComptonProofs.amplitudeCarrier2
inductive Measure where
 | c0
 | c1
 | c2
def measureName : Measure → String
 | .c0 => "paired-weight-per-incident-boundary-support"
 | .c1 => "unnormalized-outgoing-count"
 | .c2 => "target-fitted-area"
def measurePassed : Measure → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem measureComputed (x : Measure) : crossSectionMeasureIsForced (measureName x) = .ok (measurePassed x) := by
 cases x with
 | c0 => exact ScatteringRutherfordComptonProofs.crossSectionMeasure0
 | c1 => exact ScatteringRutherfordComptonProofs.crossSectionMeasure1
 | c2 => exact ScatteringRutherfordComptonProofs.crossSectionMeasure2
inductive Angular where
 | c0
 | c1
 | c2
def angularName : Angular → String
 | .c0 => "inverse-transfer-part-squared"
 | .c1 => "inverse-transfer-part-first-power"
 | .c2 => "angle-independent-response"
def angularPassed : Angular → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem angularComputed (x : Angular) : coulombAngularLawIsForced (angularName x) = .ok (angularPassed x) := by
 cases x with
 | c0 => exact ScatteringRutherfordComptonProofs.coulombAngularLaw0
 | c1 => exact ScatteringRutherfordComptonProofs.coulombAngularLaw1
 | c2 => exact ScatteringRutherfordComptonProofs.coulombAngularLaw2
inductive Scale where
 | c0
 | c1
 | c2
def scaleName : Scale → String
 | .c0 => "charge-product-squared-energy-inverse-squared"
 | .c1 => "charge-product-linear-energy-inverse"
 | .c2 => "free-dimensional-scale"
def scalePassed : Scale → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem scaleComputed (x : Scale) : coulombScaleLawIsForced (scaleName x) = .ok (scalePassed x) := by
 cases x with
 | c0 => exact ScatteringRutherfordComptonProofs.coulombScaleLaw0
 | c1 => exact ScatteringRutherfordComptonProofs.coulombScaleLaw1
 | c2 => exact ScatteringRutherfordComptonProofs.coulombScaleLaw2
inductive Shift where
 | c0
 | c1
 | c2
def shiftName : Shift → String
 | .c0 => "two-transfer-parts-times-action-over-inertia-speed"
 | .c1 => "one-transfer-part-times-action-over-inertia-speed"
 | .c2 => "angle-independent-wavelength-change"
def shiftPassed : Shift → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem shiftComputed (x : Shift) : photonShiftLawIsForced (shiftName x) = .ok (shiftPassed x) := by
 cases x with
 | c0 => exact ScatteringRutherfordComptonProofs.photonShiftLaw0
 | c1 => exact ScatteringRutherfordComptonProofs.photonShiftLaw1
 | c2 => exact ScatteringRutherfordComptonProofs.photonShiftLaw2
inductive Energy where
 | c0
 | c1
 | c2
def energyName : Energy → String
 | .c0 => "rest-over-rest-plus-two-energy-transfer-parts"
 | .c1 => "incident-energy-preserved"
 | .c2 => "outgoing-energy-greater-than-incident"
def energyPassed : Energy → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem energyComputed (x : Energy) : photonEnergyLawIsForced (energyName x) = .ok (energyPassed x) := by
 cases x with
 | c0 => exact ScatteringRutherfordComptonProofs.photonEnergyLaw0
 | c1 => exact ScatteringRutherfordComptonProofs.photonEnergyLaw1
 | c2 => exact ScatteringRutherfordComptonProofs.photonEnergyLaw2
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
 | c0 => exact ScatteringRutherfordComptonProofs.targetBoundary0
 | c1 => exact ScatteringRutherfordComptonProofs.targetBoundary1
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
 | c0 => exact ScatteringRutherfordComptonProofs.extension0
 | c1 => exact ScatteringRutherfordComptonProofs.extension1
structure Candidate where
 amplitude : Amplitude
 measure : Measure
 angular : Angular
 scale : Scale
 shift : Shift
 energy : Energy
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [amplitudeName c.amplitude,measureName c.measure,angularName c.angular,scaleName c.scale,shiftName c.shift,energyName c.energy,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let amplitude ← amplitudeCarrierIsForced (amplitudeName c.amplitude)
 let measure ← crossSectionMeasureIsForced (measureName c.measure)
 let angular ← coulombAngularLawIsForced (angularName c.angular)
 let scale ← coulombScaleLawIsForced (scaleName c.scale)
 let shift ← photonShiftLawIsForced (shiftName c.shift)
 let energy ← photonEnergyLawIsForced (energyName c.energy)
 let target ← targetBoundaryIsForced (targetName c.target)
 let extension ← extensionIsForced (extensionName c.extension)
 pure [("amplitude_carrier",amplitude),("cross_section_measure",measure),("coulomb_angular_law",angular),("coulomb_scale_law",scale),("photon_shift_law",shift),("photon_energy_law",energy),("target_boundary",target),("extension",extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("amplitude_carrier",amplitudePassed c.amplitude),("cross_section_measure",measurePassed c.measure),("coulomb_angular_law",angularPassed c.angular),("coulomb_scale_law",scalePassed c.scale),("photon_shift_law",shiftPassed c.shift),("photon_energy_law",energyPassed c.energy),("target_boundary",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c = .ok (computedFacts c) := by
 unfold candidateFacts
 rw [amplitudeComputed,measureComputed,angularComputed,scaleComputed,shiftComputed,energyComputed,targetComputed,extensionComputed]
 rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do
 pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c = .ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun amplitude =>
 [.c0,.c1,.c2].flatMap (fun measure =>
 [.c0,.c1,.c2].flatMap (fun angular =>
 [.c0,.c1,.c2].flatMap (fun scale =>
 [.c0,.c1,.c2].flatMap (fun shift =>
 [.c0,.c1,.c2].flatMap (fun energy =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨amplitude,measure,angular,scale,shift,energy,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length = 2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c = true → c = survivor := by
 rcases c with ⟨amplitude,measure,angular,scale,shift,energy,target,extension⟩
 cases amplitude <;> cases measure <;> cases angular <;> cases scale <;> cases shift <;> cases energy <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor = true := rfl
theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
 rcases c with ⟨amplitude,measure,angular,scale,shift,energy,target,extension⟩
 have hamplitude : amplitude ∈ [Amplitude.c0,Amplitude.c1,Amplitude.c2] := by
  cases amplitude <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hmeasure : measure ∈ [Measure.c0,Measure.c1,Measure.c2] := by
  cases measure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hangular : angular ∈ [Angular.c0,Angular.c1,Angular.c2] := by
  cases angular <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hscale : scale ∈ [Scale.c0,Scale.c1,Scale.c2] := by
  cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hshift : shift ∈ [Shift.c0,Shift.c1,Shift.c2] := by
  cases shift <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have henergy : energy ∈ [Energy.c0,Energy.c1,Energy.c2] := by
  cases energy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target ∈ [Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension ∈ [Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ amplitude _ hamplitude
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ measure _ hmeasure
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ angular _ hangular
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ scale _ hscale
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ shift _ hshift
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ energy _ henergy
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every exact overlap-leg account, every cross-section measure, every Coulomb angular power, every Coulomb charge/energy scale, every photon wavelength-transfer law, every photon energy-transfer law, both target-custody states and both extension states."
def grammarBoundary : String := "Every exact positive rational nonforward direction-transfer part not exceeding the One; the structural empty forward class; phase-compatible incoming/transfer/outgoing legs; source-normalized differential boundary support; conserved charged-source and incident-energy carriers; one photon, one initially held inertial word and closed energy-direction transfer; sealed or exposed targets; and empty or free extension. The induction certificates are independent of a finite Fold depth."
end SFT.Physics.ScatteringRutherfordComptonGrammar

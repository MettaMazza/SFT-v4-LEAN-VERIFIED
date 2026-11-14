import SFT.Physics.ScatteringRutherfordComptonGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ScatteringRutherfordComptonEvidence
open SFT.Host SFT.Host.Canonical ScatteringRutherfordComptonGrammar ScatteringRutherfordComptonProofs
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def formValue (c : Candidate) : Value := .object [("amplitude_carrier",.text (amplitudeName c.amplitude)),("cross_section_measure",.text (measureName c.measure)),("coulomb_angular_law",.text (angularName c.angular)),("coulomb_scale_law",.text (scaleName c.scale)),("photon_shift_law",.text (shiftName c.shift)),("photon_energy_law",.text (energyName c.energy)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "; " [Text.append "amplitude=" (amplitudeName c.amplitude),Text.append "cross_section=" (measureName c.measure),Text.append "coulomb_angle=" (angularName c.angular),Text.append "coulomb_scale=" (scaleName c.scale),Text.append "photon_shift=" (shiftName c.shift),Text.append "photon_energy=" (energyName c.energy),Text.append "target=" (targetName c.target),Text.append "extension=" (extensionName c.extension)]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Two phase-compatible overlap legs force exact self-pairing. Rank-two Coulomb transfer gives the inverse square of the direction-transfer part with charge-product-squared and incident-energy-inverse-squared scale. Closed photon-electron transfer gives a wavelength increase of two transfer parts and the unique energy-conserving denominator."
def completenessRecord : Value := .object [("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("axis_cardinalities",.array ([3,3,3,3,3,3,2,2].map (fun n => Value.integer (.ofNat n)))),("candidate_count",.integer (.ofNat candidates.length)),("candidate_ids",.array (candidates.map (fun c => .text (candidateId c))))]
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := admissionIdentity (.object [("generator",.text generationRule),("form",formValue c),("computed_facts",factsValue c)])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := admissionIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census := SFT.Engine.censusValue censusData
def decisionData (c : Candidate) (traceHash : String) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := admissionIdentity (.object [("candidate_trace",.text traceHash),("form",formValue c),("facts",factsValue c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
def decideCandidate (c : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun f => Text.equal (candidateId f) c.candidateId) with
 | none => .error "KeyError"
 | some f => .ok (decisionData f c.traceHash)
def fractionValue (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def gainValue (p : Rat × Rat) : Value := .array [fractionValue p.1,fractionValue p.2]
def optionalValue : Option Rat → Value
 | none => .array [] | some q => fractionValue q
def pairs (xs : List (Rat × Rat)) : Value := .array (xs.map (fun (a,b) => .array [fractionValue a,fractionValue b]))
def certificateValue (c : ScatteringRutherfordCompton.Certificate) : Value := .object [
 ("forward_transfer",.array (c.forwardTransfer.map fractionValue)),("transfer_parts",.array (c.transferParts.map fractionValue)),
 ("coulomb_normalized_angular_density",pairs c.angularDensity),
 ("coulomb_cumulative_impact_area",.array (c.cumulativeArea.map (fun (a,b) => .array [fractionValue a,optionalValue b]))),
 ("coulomb_annular_interval_density",.array (c.annularDensity.map (fun (a,b,d) => .array [fractionValue a,fractionValue b,fractionValue d]))),
 ("coulomb_annular_product_identity",.array (c.annularIdentity.map Value.boolean)),
 ("coulomb_charge_doubling_ratio",fractionValue c.chargeDoublingRatio),("coulomb_energy_doubling_ratio",fractionValue c.energyDoublingRatio),
 ("photon_shift_in_compton_carriers",pairs c.photonShifts),("photon_outgoing_over_incident_at_equal_rest_energy",pairs c.photonEnergy),
 ("photon_conservation_transfer_at_equal_rest_energy",pairs c.conservationTransfer),
 ("right_angle_high_energy_ceiling",fractionValue c.rightAngleCeiling),("backscatter_high_energy_ceiling",fractionValue c.backscatterCeiling),
 ("positive_successor_steps",.array (c.successorSteps.map fractionValue)),("positive_ceiling_gaps",.array (c.ceilingGaps.map fractionValue))]
def generality : Value := .object [("all_positive_rational_transfer_parts",.array [.text "paired_density(u)=1/(u*u)",.text "shift_in_compton_carriers(u)=2*u",.text "outgoing_over_incident(x,u)=1/(1+2*x*u)"]),("positive_successor_step",.text "1/[(1+2*u*n)*(1+2*u*(n+1))]"),("positive_ceiling_gap",.text "1/[2*u*(1+2*u*n)]"),("finite_annular_identity",.text "[C(a) take C(b)]/[b take a]=1/(a*b), where C(u)=(One take u)/u"),("compton_conservation_identity",.text "[1/(x*r) take 1/x]=2*u uniquely gives r=1/(1+2*x*u)"),("forward_class",.array []),("target_absent_from_formal_module",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← ScatteringRutherfordCompton.formalCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors_computed",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← ScatteringRutherfordCompton.formalCertificate
 let minimal := (decisions.filter SFT.Engine.CandidateDecision.survives).length==1 && cert.forwardTransfer.isEmpty && cert.angularDensity.map Prod.snd==[VacuumLedgerProofs.wholeRatio 16,VacuumLedgerProofs.wholeRatio 4,LeptonIntervals.normalize 16 9 (by decide),VacuumLedgerProofs.wholeRatio 1] && cert.photonShifts.map Prod.snd==[LeptonIntervals.normalize 1 2 (by decide),VacuumLedgerProofs.wholeRatio 1,LeptonIntervals.normalize 3 2 (by decide),VacuumLedgerProofs.wholeRatio 2] && cert.rightAngleCeiling==VacuumLedgerProofs.wholeRatio 1 && cert.backscatterCeiling==LeptonIntervals.normalize 1 2 (by decide)
 pure { scope := .depthIndependent
        exactBoundary := grammarBoundary
        minimalityPassed := minimal
        namedShapeUniquenessPassed := minimal && (← ScatteringRutherfordCompton.extensionIsForced "empty-extension")
        proofHash := admissionIdentity (← closureRecord decisions)
        generalityCertificateHash := some (admissionIdentity generality) }
def control (kind : SFT.Engine.ControlKind) (passed : Bool) (expected observed : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := expected
 observedBehavior := observed
 receiptHash := admissionIdentity (.object [("kind",.text (SFT.Engine.kindName kind)),("passed",.boolean passed),("expected",.text expected),("observed",.text observed)])
def controlData (sourceHash : String) : Except String (List SFT.Engine.ControlResult) := do
 let survivors := candidates.filter survives
 let held ← match survivors with
  | [c] => .ok c
  | [] => .error "controls require exactly one computed form"
  | _::_::_ => .error "controls require exactly one computed form"
 let ids := candidates.map candidateId
 let duplicated := (ids ++ ids.take 1).map (fun id => id.toUTF8.data.toList.map UInt8.toNat)
 pure [
 control .falsePremise (!survives {held with angular:=.c2}) "Reject an angle-independent Coulomb response and elastic photon energy." "Exact transfer-part and conservation predicates reject the false angular law.",
 control .tamperedSource (!(Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject any changed claimant source identity." "The changed identity differs from the registered source manifest.",
 control .tamperedArtifact (duplicated.eraseDups.length != ids.length+1) "Reject a duplicated or incomplete candidate census." "The deliberate duplicate fails complete candidate identity.",
 control .boundary (ScatteringRutherfordCompton.forwardTransfer.isEmpty && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject a numerical forward null, pre-seal target access and free correction." "Forward transfer is structural absence; sealed custody and empty extension are required."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006"
 title := "Terminal Fold scattering, Rutherford angular law and Compton transfer"
 branch := "physics"
 statement := "A scattering amplitude carrier is the exact phase-compatible overlap support of one transition leg; an observed differential channel pairs the preparation-to-transfer and transfer-to-record legs, so its weight is their exact self-composition without an imported complex magnitude. For a conserved Coulomb source the rank-two transfer boundary forces differential support proportional to the inverse square of the exact direction-transfer part, with charge-product-squared and incident-energy-inverse-squared scale. At the comparison boundary this is the Rutherford inverse fourth-power half-angle law. For closed photon-electron transfer, wavelength increases by two direction-transfer parts of the action-over-inertia-speed carrier; outgoing energy is incident energy divided by One plus twice the incident/rest-energy ratio times that transfer part. Right-angle and backscatter high-energy ceilings are respectively one and half-One electron rest-energy support. Forward nondeflection remains the structural empty transfer class."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-MATTER-SCATTERING-001", "SFT-PHYS-QUANTUM-PHYSICAL-STATE-001", "SFT-PHYS-QUANTUM-WEIGHT-001", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-PHYS-FIELD-INVERSE-SQUARE-001", "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003", "SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001", "SFT-PHYS-MATTER-MASS-ENERGY-001", "SFT-PHYS-SPACETIME-LIMIT-SPEED-001", "SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001", "SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001", "SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.ScatteringRutherfordComptonEvidence

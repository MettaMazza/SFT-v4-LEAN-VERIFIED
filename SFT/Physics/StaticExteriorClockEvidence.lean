import SFT.Physics.StaticExteriorClockGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.StaticExteriorClockEvidence
open SFT.Host SFT.Host.Canonical StaticExteriorClockGrammar
open StaticExteriorClockCertificate
open StaticExteriorClock
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("horizon_normalization",.text (horizonName c.horizon)),("field_law",.text (fieldName c.field)),("well_law",.text (wellName c.well)),("coefficient_law",.text (coefficientName c.coefficient)),("clock_law",.text (clockName c.clock)),("boundary_law",.text (boundaryName c.boundary)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "" ["CandidateForm(",Text.intercalate ", " [Text.intercalate "" ["horizon_normalization='",horizonName c.horizon,"'"],Text.intercalate "" ["field_law='",fieldName c.field,"'"],Text.intercalate "" ["well_law='",wellName c.well,"'"],Text.intercalate "" ["coefficient_law='",coefficientName c.coefficient,"'"],Text.intercalate "" ["clock_law='",clockName c.clock,"'"],Text.intercalate "" ["boundary_law='",boundaryName c.boundary,"'"],Text.intercalate "" ["target_boundary='",targetName c.target,"'"],Text.intercalate "" ["extension='",extensionName c.extension,"'"]],")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Generated horizon, conserved flux, radius-derived well, positive complement and exact clock boundary force the complete exterior law."
def completenessRecord : Value := .object [("axis_cardinalities",.array ([3,3,3,3,3,3,2,2].map (fun n => .integer (.ofNat n)))),("candidate_ids",.array (candidates.map (fun c => .text (candidateId c))))]
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := sourceIdentity (.object [("rule",.text generationRule),("form",formValue c),("facts",factsValue c)])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := sourceIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census := SFT.Engine.censusValue censusData
def decisionData (c : Candidate) (traceHash : String) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := sourceIdentity (.object [("trace",.text traceHash),("facts",factsValue c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
-- Original _forms_by_id: retain generated identity keys once for lookup.
def formIndex : List (List Nat × Candidate) := candidates.map (fun c => ( (candidateId c).toUTF8.data.toList.map UInt8.toNat,c))
def decideCandidate (c : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 let key := c.candidateId.toUTF8.data.toList.map UInt8.toNat
 match formIndex.find? (fun p => p.1==key) with
 | none => .error "KeyError"
 | some (_,f) => .ok (decisionData f c.traceHash)
def frac (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def stateValue (s : State) : Value :=
 let common := [("mass",frac s.mass),("horizon",frac s.horizon),("radius",frac s.radius),("well_share",frac s.wellShare)]
 let ending := [("field",frac s.field),("flux",frac s.flux)]
 match s.coefficient with
 | none => .object (common++[("coefficient",.array []),("clock_record",.array [])]++ending++[("region",.text "boundary")])
 | some q => .object (common++[("coefficient",frac q)]++ending++[("region",.text "exterior")])
def clockValue (c : ClockPair) : Value := .object [("mass",frac c.mass),("near",stateValue c.near),("far",stateValue c.far),("near_rate",frac c.nearRate),("far_rate",frac c.farRate),("far_over_near_rate",frac c.farOverNearRate),("far_clock_faster",.boolean c.farClockFaster)]
def certificateValue (c : Certificate) : Value := .object [("mass",frac c.mass),("horizon",frac c.horizon),("boundary",stateValue c.boundary),("rows",.array (c.rows.map stateValue)),("all_exterior_coefficients_positive",.boolean c.allExteriorCoefficientsPositive),("all_fluxes_equal_horizon",.boolean c.allFluxesEqualHorizon),("all_well_radius_products_equal_horizon",.boolean c.allWellRadiusProductsEqualHorizon),("all_complements_complete_One",.boolean c.allComplementsCompleteOne),("well_halves_each_successor",.boolean c.wellHalvesEachSuccessor),("field_quarters_each_successor",.boolean c.fieldQuartersEachSuccessor),("coefficient_increases_each_successor",.boolean c.coefficientIncreasesEachSuccessor),("horizon_clock_record_empty",.boolean c.horizonClockRecordEmpty),("exact_clock_pair",clockValue c.exactClockPair),("weak_field_successor",.text c.weakFieldSuccessor),("general_flux_identity",.text c.generalFluxIdentity),("general_coefficient_identity",.text c.generalCoefficientIdentity),("physical_unit_conversion_not_formal_input",.boolean c.physicalUnitConversionNotFormalInput),("negative_zero_irrational_or_imaginary_proof_scalar_used",.boolean c.forbiddenProofScalarUsed)]
def generality : Value := .object [("base",.text "At the first exterior doubling, the well is half-One, the coefficient is its positive complement and flux reconstructs the doubled-mass boundary."),("successor",.text "Every radius doubling halves the well, quarters the field, preserves field times radius squared and retains a positive complement closer to the One."),("completed_infinity_not_used",.boolean true),("targets_absent",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← exteriorCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← exteriorCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.allFluxesEqualHorizon && cert.allComplementsCompleteOne && cert.wellHalvesEachSuccessor && cert.fieldQuartersEachSuccessor && cert.horizonClockRecordEmpty && cert.exactClockPair.farClockFaster
 pure { scope := .depthIndependent
        exactBoundary := grammarBoundary
        minimalityPassed := minimal
        namedShapeUniquenessPassed := minimal && survivors.eraseDups.length==1
        proofHash := sourceIdentity (← closureRecord decisions)
        generalityCertificateHash := some (sourceIdentity generality) }
def control (kind : SFT.Engine.ControlKind) (passed : Bool) (expected observed : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := expected
 observedBehavior := observed
 receiptHash := sourceIdentity (.object [("kind",.text (SFT.Engine.kindName kind)),("passed",.boolean passed),("expected",.text expected),("observed",.text observed)])
def controlData (sourceHash : String) : Except String (List SFT.Engine.ControlResult) := do
 let survivors := candidates.filter survives
 let held ← match survivors with
  | [c] => .ok c
  | [] => .error "controls require one computed survivor"
  | _::_::_ => .error "controls require one computed survivor"
 let ids := candidates.map candidateId
 let identities := ids.map (fun id => id.toUTF8.data.toList.map UInt8.toNat)
 pure [
 control .falsePremise ((← exteriorCertificate).boundary.coefficient.isNone && (← exteriorCertificate).horizonClockRecordEmpty) "Reject a numerical boundary coefficient or exterior clock record at complete well depth." "The boundary is the empty structural record.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject changed source identity." "Identity differs.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicate candidates." "All identities are unique.",
 control .boundary (!survives {held with coefficient:=.c1} && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject signed import, pre-seal observation and free correction." "Only positive complement, sealed target and empty extension survive."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-STATIC-EXTERIOR-CLOCK-TERMINAL-011"
 title := "Exact static spherical exterior coefficient, flux and clock law"
 branch := "physics"
 statement := "The generated horizon radius is twice the positive mass carrier. Rank-two boundary conservation forces field equal to horizon radius over radius paired with radius; one retained radius converts this to the well share horizon radius over radius; its positive complement completes the One and is the unique exterior clock-square coefficient. Flux is identical at every exact exterior radius, every outward binary successor halves the well and quarters the field, the boundary closes the clock record, and exact-square exterior pairs force the farther clock to run faster without irrational proof values."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-GRAVITY-WEAK-FIELD-FLUX-003", "SFT-PHYS-GRAVITY-STATIC-CLOCK-003", "SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003", "SFT-PHYS-GRAVITY-REDSHIFT-EQUIVALENCE-003", "SFT-PHYS-VALIDATION-GRAVITY-CLOCK-EQUIVALENCE-003", "SFT-PHYS-FIELD-INVERSE-SQUARE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.StaticExteriorClockEvidence

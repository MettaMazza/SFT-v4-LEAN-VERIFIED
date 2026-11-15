import SFT.Physics.PostNewtonianFixedPointEvidence
import SFT.Physics.StrongFieldNonlinearFixedPointGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.StrongFieldNonlinearFixedPointEvidence
open SFT.Host SFT.Host.Canonical StrongFieldNonlinearFixedPointGrammar
open StrongFieldNonlinearFixedPointCertificate
open StrongFieldNonlinearFixedPoint
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("source_composition",.text (sourceName c.source)),("update_law",.text (updateName c.update)),("correction_law",.text (correctionName c.correction)),("fixed_point_law",.text (fixedName c.fixed)),("comparator_law",.text (comparatorName c.comparator)),("confinement_law",.text (confinementName c.confinement)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "" ["CandidateForm(",Text.intercalate ", " [Text.intercalate "" ["source_composition='",sourceName c.source,"'"],Text.intercalate "" ["update_law='",updateName c.update,"'"],Text.intercalate "" ["correction_law='",correctionName c.correction,"'"],Text.intercalate "" ["fixed_point_law='",fixedName c.fixed,"'"],Text.intercalate "" ["comparator_law='",comparatorName c.comparator,"'"],Text.intercalate "" ["confinement_law='",confinementName c.confinement,"'"],Text.intercalate "" ["target_boundary='",targetName c.target,"'"],Text.intercalate "" ["extension='",extensionName c.extension,"'"]],")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Colour self-source, exact binary successor, persistent correction, empty finite fixed point and arbitrary-bound witnesses force the three-way iteration discriminator."
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
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (x : Rat) : Value := .object [("numerator",.integer x.num),("denominator",nv x.den)]
def rs (xs : List Rat) : Value := .array (xs.map frac)
def strongValue (x : Strong) : Value := .object [("sources",rs x.sources),("corrections",rs x.corrections),("source_strictly_grows",.boolean x.sourceStrictlyGrows),("correction",frac x.correction),("all_corrections_binary",.boolean x.allCorrectionsBinary),("corrections_do_not_shrink",.boolean x.correctionsDoNotShrink),("field_appears_in_its_source_update",.boolean x.fieldAppearsInItsSourceUpdate),("carrier_self_source_record",.array (x.carrierSelfSourceRecord.map Value.text))]
def neutralValue (x : Neutral) : Value := .object [("sources",rs x.sources),("self_source_record",rs x.selfSourceRecord),("correction_record",rs x.correctionRecord),("source_held",.boolean x.sourceHeld),("fixed_point",frac x.fixedPoint),("field_absent_from_source_update",.boolean x.fieldAbsentFromSourceUpdate)]
def fixedValue (x : FixedPointTest) : Value := .object [("candidate",frac x.candidate),("successor",frac x.successor),("successor_strictly_above_candidate",.boolean x.successorStrictlyAboveCandidate),("is_fixed_point",.boolean x.isFixedPoint),("finite_candidate",.boolean x.finiteCandidate)]
def boundValue (x : BoundWitness) : Value := .object [("bound",frac x.bound),("witness_successors",nv x.witnessSuccessors),("witness_source",frac x.witnessSource),("source_exceeds_bound",.boolean x.sourceExceedsBound),("finite_witness",.boolean x.finiteWitness)]
def certificateValue (c : Certificate) : Value := .object [("neutral",neutralValue c.neutral),("gravity",SFT.Physics.PostNewtonianFixedPointEvidence.certificateValue c.gravity),("strong",strongValue c.strong),("fixed_point_candidates",.array (c.fixedPointCandidates.map fixedValue)),("bound_witnesses",.array (c.boundWitnesses.map boundValue)),("neutral_linear_hold",.boolean c.neutralLinearHold),("gravity_self_source_contracts",.boolean c.gravitySelfSourceContracts),("strong_self_source_persists",.boolean c.strongSelfSourcePersists),("strong_has_no_positive_finite_fixed_point",.boolean c.strongHasNoPositiveFiniteFixedPoint),("all_registered_bounds_exceeded",.boolean c.allRegisteredBoundsExceeded),("general_fixed_point_identity",.text c.generalFixedPointIdentity),("general_bound_identity",.text c.generalBoundIdentity),("structural_nonlinearity",.text c.structuralNonlinearity),("strong_finite_fixed_point_record",rs c.strongFiniteFixedPointRecord),("completed_infinity_used",.boolean c.completedInfinityUsed),("negative_zero_irrational_or_imaginary_proof_value_used",.boolean c.forbiddenProofScalarUsed)]
def generality : Value := .object [("base",.text "The bare strong row is the One and its first colour successor appends both Fold labels; the neutral row holds and the admitted gravity row lies below quarter-One."),("strong_successor",.text "Every strong successor retains its prior positive exact source and appends the same complete binary carrier."),("fixed_point_boundary",.text "For every positive exact finite F, adding the positive binary carrier produces a strictly larger record, so equality is impossible."),("arbitrary_bound",.text "The successor whole after exact B divided by two supplies a finite source witness above every positive exact finite B."),("completed_infinity_not_used",.boolean true),("targets_absent",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← fieldIterationCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← fieldIterationCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.neutralLinearHold && cert.gravitySelfSourceContracts && cert.strongSelfSourcePersists && cert.strongHasNoPositiveFiniteFixedPoint && cert.allRegisteredBoundsExceeded
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
 control .falsePremise ((← fieldIterationCertificate).neutral.correctionRecord.isEmpty && (← fieldIterationCertificate).gravity.correctionsStrictlyShrink && (← fieldIterationCertificate).strong.correctionsDoNotShrink) "Reject conflating empty, shrinking and persistent correction records." "Neutral, gravity and strong updates retain distinct exact correction classes.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject changed source identity." "Identity differs.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicate candidates." "All identities are unique.",
 control .boundary (!survives {held with fixed:=.c1} && !survives {held with confinement:=.c1} && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject selected fixed point, finite-prefix/completed-infinity inference, target access and free correction." "Only universal positive-order exclusion, finite witnesses, sealed custody and empty extension survive."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014"
 title := "Strong self-source iteration and finite fixed-point boundary"
 branch := "physics"
 statement := "A chargeless carrier has an empty self-source correction and holds its matter source. The admitted gravitational scalar self-source has one admissible quarter-One fixed point with shrinking corrections. A colour-bearing carrier instead remains inside its own source update: every successor retains the prior source and appends the complete binary carrier, so the correction is exact two and never shrinks. For every positive exact finite F, F plus two is strictly above F, leaving the strong finite fixed-point record empty; the same successor law exceeds every positive exact finite bound at a generated finite witness. This is the depth-independent confinement boundary."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-STRONG-RUNNING-DIRECTION-002", "SFT-PHYS-POST-NEWTONIAN-FIXED-POINT-TERMINAL-009", "SFT-PHYS-FIELD-SOURCE-RESPONSE-001", "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003", "SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.StrongFieldNonlinearFixedPointEvidence

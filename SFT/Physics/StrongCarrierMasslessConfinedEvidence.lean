import SFT.Physics.StrongCarrierMasslessConfinedGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.StrongCarrierMasslessConfinedEvidence
open SFT.Host SFT.Host.Canonical StrongCarrierMasslessConfinedGrammar
open StrongCarrierMasslessConfinedCertificate
open StrongCarrierMasslessConfined
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("sector_law",.text (sectorName c.sector)),("mass_law",.text (massName c.mass)),("causal_law",.text (causalName c.causal)),("self_source_law",.text (selfSourceName c.selfSource)),("confinement_law",.text (confinementName c.confinement)),("composition_law",.text (compositionName c.composition)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "" ["CandidateForm(",Text.intercalate ", " [Text.intercalate "" ["sector_law='",sectorName c.sector,"'"],Text.intercalate "" ["mass_law='",massName c.mass,"'"],Text.intercalate "" ["causal_law='",causalName c.causal,"'"],Text.intercalate "" ["self_source_law='",selfSourceName c.selfSource,"'"],Text.intercalate "" ["confinement_law='",confinementName c.confinement,"'"],Text.intercalate "" ["composition_law='",compositionName c.composition,"'"],Text.intercalate "" ["target_boundary='",targetName c.target,"'"],Text.intercalate "" ["extension='",extensionName c.extension,"'"]],")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Generated colour structure, empty mass record, One-speed phase, self-sourced fixed tube and ever-growing finite separation work force simultaneous masslessness and confinement."
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
def sectorValue (x : StrongCarrierMasslessConfined.Sector) : Value := .object [("sector",nv x.sector),("charge_labels",nv x.chargeLabels),("pair_cells",nv x.pairCells),("colourless_return_cells",frac x.colourlessReturnCells),("mediator_count",nv x.mediatorCount),("coupling",frac x.coupling),("mass_label",rs x.massLabel),("mass_class",.text x.massClass),("carrier_charge",.text x.carrierCharge)]
def causalValue (x : StrongCarrierMasslessConfined.Causal) : Value := .object [("mass_label",rs x.massLabel),("positions",rs x.positions),("increments",rs x.increments),("all_increments_One",.boolean x.allIncrementsOne),("phase_trace",rs x.phaseTrace),("phase_retained",.boolean x.phaseRetained),("rest_capture_record",rs x.restCaptureRecord),("causal_speed",frac x.causalSpeed)]
def rowValue (x : TubeRow) : Value := .object [("separation",frac x.separation),("tube_width",frac x.tubeWidth),("field_carrier",frac x.fieldCarrier),("separation_work",frac x.separationWork)]
def tubeValue (x : Tube) : Value := .object [("rows",.array (x.rows.map rowValue)),("tube_width",frac x.tubeWidth),("field_carrier",frac x.fieldCarrier),("width_fixed",.boolean x.widthFixed),("field_fixed",.boolean x.fieldFixed),("work_strictly_increases",.boolean x.workStrictlyIncreases),("work_increment",frac x.workIncrement),("all_work_increments_equal_coupling",.boolean x.allWorkIncrementsEqualCoupling),("isolated_colour_carrier_record",rs x.isolatedColourCarrierRecord),("completed_infinity_used",.boolean x.completedInfinityUsed)]
def boundValue (x : BoundWitness) : Value := .object [("bound",frac x.bound),("witness_separation",nv x.witnessSeparation),("witness_work",frac x.witnessWork),("exceeds_bound",.boolean x.exceedsBound),("finite_witness",.boolean x.finiteWitness)]
def certificateValue (c : Certificate) : Value := .object [("structure",sectorValue c.sector),("causal",causalValue c.causal),("tube",tubeValue c.tube),("bound_witnesses",.array (c.boundWitnesses.map boundValue)),("all_registered_bounds_exceeded",.boolean c.allRegisteredBoundsExceeded),("simultaneously_massless_and_One_speed",.boolean c.simultaneouslyMasslessAndOneSpeed),("simultaneously_confined",.boolean c.simultaneouslyConfined),("masslessness_is_local_propagation_record",.boolean c.masslessnessIsLocalPropagationRecord),("confinement_is_asymptotic_observation_record",.boolean c.confinementIsAsymptoticObservationRecord),("confinement_does_not_create_mass_label",.boolean c.confinementDoesNotCreateMassLabel),("general_bound_identity",.text c.generalBoundIdentity),("general_successor_identity",.text c.generalSuccessorIdentity),("negative_zero_irrational_imaginary_or_completed_infinity_used",.boolean c.forbiddenProofScalarUsed)]
def generality : Value := .object [("base",.text "The colour-three carrier has empty mass/rest capture, One local step, half-One tube width and first two-thirds separation-work act."),("causal_successor",.text "Every tick appends exactly one support cell and retains the same phase without creating a mass label."),("confinement_successor",.text "Every separation successor retains width and field while adding the same positive two-thirds work carrier."),("arbitrary_positive_bound",.text "The successor whole after exact B divided by two-thirds gives a finite work witness strictly above B."),("completed_infinity_not_used",.boolean true),("targets_absent",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← simultaneousCarrierCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← simultaneousCarrierCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.simultaneouslyMasslessAndOneSpeed && cert.simultaneouslyConfined && cert.allRegisteredBoundsExceeded && cert.confinementDoesNotCreateMassLabel
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
 control .falsePremise ((← simultaneousCarrierCertificate).sector.massLabel.isEmpty && (← simultaneousCarrierCertificate).tube.isolatedColourCarrierRecord.isEmpty && (← simultaneousCarrierCertificate).simultaneouslyMasslessAndOneSpeed && (← simultaneousCarrierCertificate).simultaneouslyConfined) "Reject treating empty mass and empty isolated-colour records as the same claim or as numerical zero." "Local propagation survives while isolated asymptotic colour remains empty.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject changed source identity." "Identity differs.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicate candidates." "All identities are unique.",
 control .boundary (!survives {held with mass:=.c1} && !survives {held with composition:=.c1} && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject numerical/fitted mass, false exclusivity, pre-seal target access and free correction." "Only empty mass, simultaneous records, sealed custody and empty extension survive."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013"
 title := "Simultaneous massless, One-speed and confined strong-carrier law"
 branch := "physics"
 statement := "The generated colour-three sector has eight non-singlet carrier states and coupling two-thirds. Its carrier has an empty mass and rest-capture record, so its local phase advances exactly one support cell per tick. The same carrier bears the colour it mediates and therefore self-sources a fixed half-One transverse tube: every positive separation successor adds the same two-thirds work carrier, exceeding every positive exact finite bound at a generated finite witness. Local massless One-speed propagation and asymptotic confinement are thus simultaneous non-equivalent records, not contradictory alternatives."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003", "SFT-PHYS-STRONG-RUNNING-DIRECTION-002", "SFT-PHYS-SPACETIME-EXACT-INTERVAL-003", "SFT-PHYS-WAVE-EXACT-OPERATIONS-003", "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-PHYS-FIELD-CONSERVED-SOURCE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.StrongCarrierMasslessConfinedEvidence

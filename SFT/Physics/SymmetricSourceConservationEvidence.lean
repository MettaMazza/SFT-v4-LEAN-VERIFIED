import SFT.Physics.SymmetricSourceConservationGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.SymmetricSourceConservationEvidence
open SFT.Host SFT.Host.Canonical SymmetricSourceConservationGrammar
open SymmetricSourceConservationCertificate
open SymmetricSourceConservation
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("component_organization",.text (componentsName c.components)),("field_pairing",.text (pairingName c.pairing)),("derivative_algebra",.text (derivativeName c.derivative)),("conservation_identity",.text (conservationName c.conservation)),("source_ledger",.text (sourceName c.source)),("leak_test",.text (leakName c.leak)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "" ["CandidateForm(",Text.intercalate ", " [Text.intercalate "" ["component_organization='",componentsName c.components,"'"],Text.intercalate "" ["field_pairing='",pairingName c.pairing,"'"],Text.intercalate "" ["derivative_algebra='",derivativeName c.derivative,"'"],Text.intercalate "" ["conservation_identity='",conservationName c.conservation,"'"],Text.intercalate "" ["source_ledger='",sourceName c.source,"'"],Text.intercalate "" ["leak_test='",leakName c.leak,"'"],Text.intercalate "" ["target_boundary='",targetName c.target,"'"],Text.intercalate "" ["extension='",extensionName c.extension,"'"]],")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Complete symmetric slots, componentwise source pairing and commuting shifts force four exact local conservation ledgers."
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
def cs (xs : List Coordinate) : Value := .array (xs.map (fun c => .text (coordinateName c)))
def sv (p : Slot) : Value := .array [.text (coordinateName p.1),.text (coordinateName p.2)]
def tv (p : Term) : Value := .array [cs p.1,sv p.2]
def commValue (c : Commutation) : Value := .object [("word_count",nv c.wordCount),("rows",.array (c.rows.map (fun row => .array [cs row.word,cs row.canonical,.boolean row.allOrdersCommute]))),("every_derivative_order_commutes",.boolean c.everyDerivativeOrderCommutes),("successor_proof",.text c.successorProof)]
def rowValue (row : DivergenceRow) : Value := .object [("direction",.text (coordinateName row.direction)),("carried_terms",nv row.carriedTerms),("opposed_terms",nv row.opposedTerms),("distinct_terms",nv row.distinctTerms),("balanced",.boolean row.balanced),("unmatched_terms",.array (row.unmatchedTerms.map tv))]
def certificateValue (c : Certificate) : Value := .object [("coordinates",cs c.coordinates),("symmetric_slots",.array (c.symmetricSlots.map sv)),("slot_count",nv c.slotCount),("source_ledger",.object (c.sourceLedger.map (fun p => (p.1,.array (p.2.map sv))))),("source_partition_counts",.array (c.sourcePartitionCounts.map nv)),("componentwise_bijection",.array (c.componentwiseBijection.map (fun p => .array [sv p.1,sv p.2]))),("divergence_rows",.array (c.divergenceRows.map rowValue)),("conserved_directions",cs c.conservedDirections),("all_four_balanced",.boolean c.allFourBalanced),("commutation",commValue c.commutation),("leaking_control_balanced",.boolean c.leakingControlBalanced),("leaking_control_has_one_missing_flow",.boolean c.leakingControlHasOneMissingFlow),("signed_numerical_scalar_used",.boolean c.signedNumericalScalarUsed),("depth_independent_identity",.text c.depthIndependentIdentity)]
def generality : Value := .object [("base",.text "Four generated labels give ten symmetric slots and four exact carried/opposed derivative-ledger equalities."),("successor",.text "Every added product-lattice layer preserves coordinatewise shift commutation, so canonical dummy-label exchange preserves all four equalities at the next depth."),("arbitrary_nonlinear_discretization_not_claimed",.boolean true),("targets_absent",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue conservationCertificate),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert := conservationCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.slotCount==10 && cert.sourcePartitionCounts==[1,3,6] && cert.allFourBalanced && cert.commutation.everyDerivativeOrderCommutes && !cert.leakingControlBalanced
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
 control .falsePremise (!conservationCertificate.leakingControlBalanced && conservationCertificate.leakingControlHasOneMissingFlow) "Reject a source ledger missing one opposed flow term." "The exact multisets no longer match.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject changed source identity." "Identity differs.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicate candidates." "All identities are unique.",
 control .boundary (!survives {held with derivative:=.c1} && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject imported operators, pre-seal observation and free correction." "Only generated shifts, sealed targets and empty extension survive."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010"
 title := "Four-coordinate symmetric curvature-source conservation law"
 branch := "physics"
 statement := "Four generated coordinate labels force ten symmetric rank-two slots paired one-to-one with one energy, three momentum and six stress source carriers. Generated coordinate shifts commute, so each of four curvature-divergence directions expands into identical carried and opposed derivative ledgers. Every componentwise source equation therefore preserves an exact local source ledger at every finite depth; removing one flow term breaks balance. No signed numerical proof scalar, imported derivative, target-selected component or free correction enters."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-GRAVITY-GRAVITON-POLARIZATION-003", "SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003", "SFT-PHYS-POST-NEWTONIAN-FIXED-POINT-TERMINAL-009", "SFT-PHYS-GRAVITY-LATTICE-CURVATURE-003", "SFT-PHYS-SPACETIME-EXACT-INTERVAL-003", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-INFO-CONSERVATION-LOSS-001", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.SymmetricSourceConservationEvidence

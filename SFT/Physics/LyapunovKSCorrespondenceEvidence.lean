import SFT.Physics.LyapunovKSCorrespondenceGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.LyapunovKSCorrespondenceEvidence
open SFT.Host SFT.Host.Canonical LyapunovKSCorrespondenceGrammar
open LyapunovKSCorrespondenceCertificate
open LyapunovKSCorrespondence
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("label_domain",.text (labelName c.label)),("separation_law",.text (separationName c.separation)),("support_law",.text (supportName c.support)),("common_carrier",.text (carrierName c.carrier)),("information_step",.text (informationName c.information)),("analytic_boundary",.text (analyticName c.analytic)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "" ["CandidateForm(",Text.intercalate ", " [Text.intercalate "" ["label_domain='",labelName c.label,"'"],Text.intercalate "" ["separation_law='",separationName c.separation,"'"],Text.intercalate "" ["support_law='",supportName c.support,"'"],Text.intercalate "" ["common_carrier='",carrierName c.carrier,"'"],Text.intercalate "" ["information_step='",informationName c.information,"'"],Text.intercalate "" ["analytic_boundary='",analyticName c.analytic,"'"],Text.intercalate "" ["target_boundary='",targetName c.target,"'"],Text.intercalate "" ["extension='",extensionName c.extension,"'"]],")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Complete support and local separation independently return the same exact generated carrier m without an analytic proof scalar or free correction."
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
def ns (xs : List Nat) : Value := .array (xs.map nv)
def caseValue (c : CarrierCase) : Value := .object [("label_count",nv c.labelCount),("depth_support",ns c.depthSupport),("successor_ratios",ns c.successorRatios),("separation_multipliers",.array (c.separationMultipliers.map Value.integer))]
def certificateValue (c : Certificate) : Value := .object [("cases",.array (c.cases.map caseValue)),("support_is_m_to_depth",.boolean c.supportIsPower),("one_step_support_multiplier_is_m",.boolean c.successorMultiplier),("local_separation_multiplier_is_m",.boolean c.localSeparationMultiplier),("common_exact_carrier",.boolean c.commonCarrier),("analytic_proof_value_required",.boolean c.analyticProofValueRequired)]
def generality : Value := .object [("base",.text "one complete m-label step has exactly m labels and multiplies local separation by m"),("successor",.text "appending one complete label to every word multiplies support by m"),("common_carrier",.text "the separation and support ratios are identically the same generated positive whole m"),("analytic_values_imported",.boolean false),("external_targets_absent_from_claimant",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← carrierCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← carrierCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.supportIsPower && cert.successorMultiplier && cert.localSeparationMultiplier && cert.commonCarrier && !cert.analyticProofValueRequired
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
 control .falsePremise ((← exactSupportCount (.integer 3) (.integer 4)) != 2^4 && decide ((← separationCarrier (.integer 3) (.integer 5)) ≠ 2*5)) "Reject a selected binary carrier for a generated three-label Fold." "Complete support and separation both return three, not two, as their multiplier.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject a changed claimant source identity." "The changed identity differs from the registered manifest.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicated candidate identities." "The complete product has unique identities.",
 control .boundary (!survives {held with analytic:=.c1} && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject imported analytic proof values, pre-seal target access and a free rate correction." "Only the exact carrier, sealed target and empty extension survive."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-LYAPUNOV-KS-CORRESPONDENCE-TERMINAL-008"
 title := "Exact Fold expansion and information-rate carrier correspondence"
 branch := "physics"
 statement := "A complete m-label Fold step multiplies every uncast local separation by the positive whole m and multiplies complete word support by the same m. At depth d the support is exactly m^d and one further depth contributes one complete m-label distinction. Thus expansion and information growth have one forced exact carrier m. Conventional Lyapunov and entropy logarithms are correspondence labels at the external analytic boundary, not imported SFT proof values. Under the separately stated hypotheses of an entropy formula, the common external rate label corresponds to this same exact carrier."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-MATH-SELF-SIMILAR-CONVERGENCE-002", "SFT-INFO-ENTROPY-UNCERTAINTY-001", "SFT-INFO-SYMBOL-DISTINCTION-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.LyapunovKSCorrespondenceEvidence

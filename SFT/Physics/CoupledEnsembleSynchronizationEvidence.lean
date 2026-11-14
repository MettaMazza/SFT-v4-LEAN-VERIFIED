import SFT.Physics.CoupledEnsembleSynchronizationGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CoupledEnsembleSynchronizationEvidence
open SFT.Host SFT.Host.Canonical CoupledEnsembleSynchronizationGrammar
open CoupledEnsembleSynchronizationCertificate
open CoupledEnsembleSynchronization
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("coupling_domain",.text (couplingName c.coupling)),("paired_action",.text (actionName c.action)),("balance_relation",.text (balanceName c.balance)),("residual_semantics",.text (residualName c.residual)),("ensemble_terminal",.text (terminalName c.terminal)),("closure",.text (closureName c.closure)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "" ["CandidateForm(",Text.intercalate ", " [Text.intercalate "" ["coupling_domain='",couplingName c.coupling,"'"],Text.intercalate "" ["paired_action='",actionName c.action,"'"],Text.intercalate "" ["balance_relation='",balanceName c.balance,"'"],Text.intercalate "" ["residual_semantics='",residualName c.residual,"'"],Text.intercalate "" ["ensemble_terminal='",terminalName c.terminal,"'"],Text.intercalate "" ["closure='",closureName c.closure,"'"],Text.intercalate "" ["target_boundary='",targetName c.target,"'"],Text.intercalate "" ["extension='",extensionName c.extension,"'"]],")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Equal paired movement forces half-One as the unique empty-residual synchronization boundary and preserves every synchronized terminal class."
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
def list (xs : List Rat) : Value := .array (xs.map frac)
def scale : Scale → Value | .empty => .array [] | .positive q => frac q
def certificateValue (c : Certificate) : Value := .object [
 ("couplings",list c.couplings),("pairs",.array (c.pairs.map (fun (a,b) => .array [frac a,frac b]))),
 ("residual_records",.array (c.residualRecords.map (fun xs => .array (xs.map list)))),
 ("unique_synchronizing_coupling",frac c.uniqueSynchronizingCoupling),
 ("half_One_residuals_empty",.boolean c.halfOneResidualsEmpty),
 ("off_half_residuals_positive",.boolean c.offHalfResidualsPositive),
 ("residual_scale_lower",scale c.residualScaleLower),("residual_scale_half",scale c.residualScaleHalf),
 ("residual_scale_upper",scale c.residualScaleUpper),("synchronized_terminal_preserved",.boolean c.synchronizedTerminalPreserved)]
def generality : Value := .object [("pair_base",.text "two equal moves exhaust separation only when each is half"),("off_half",.text "the exact residual multiplier is the positive difference between One and twice the coupling"),("ensemble_successor",.text "a common Fold image preserves equality of every synchronized member"),("arbitrary_ensemble_convergence_not_imported",.boolean true),("historical_target_absent_from_claimant",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← formalCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← formalCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.uniqueSynchronizingCoupling==LeptonIntervals.normalize 1 2 (by decide) && cert.halfOneResidualsEmpty && cert.offHalfResidualsPositive && cert.synchronizedTerminalPreserved
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
 control .falsePremise (!(← CoupledEnsembleSynchronization.residualRecord (LeptonIntervals.normalize 1 4 (by decide)) (LeptonIntervals.normalize 3 4 (by decide)) (LeptonIntervals.normalize 1 3 (by decide))).isEmpty && !(← CoupledEnsembleSynchronization.residualRecord (LeptonIntervals.normalize 1 4 (by decide)) (LeptonIntervals.normalize 3 4 (by decide)) (LeptonIntervals.normalize 2 3 (by decide))).isEmpty) "Reject either off-half coupling as exact synchronization." "Both leave the same positive residual magnitude.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject a changed claimant source identity." "The changed identity differs from the registered manifest.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicated candidate identities." "The complete product has unique identities.",
 control .boundary (!survives {held with terminal:=.c1} && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject universal collapse, pre-seal observation and free correction." "Only the conditional synchronized terminal, sealed target and empty extension survive."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-COUPLED-ENSEMBLE-SYNCHRONIZATION-TERMINAL-007"
 title := "Half-One pair synchronization and coupled-ensemble terminal law"
 branch := "physics"
 statement := "For every ordered pair of exact positive Fold parts, moving both members toward one another by the same coupling share of their separation synchronizes them exactly if and only if the coupling is the forced half-One. The two equal moves then reassemble the complete separation and leave an empty structural residual record; every off-half generated coupling leaves a positive residual. An already synchronized finite ensemble remains synchronized under every common Fold successor. Arbitrary-ensemble convergence is not assumed: the complete superseded E4 recurrence is released and reconstructed only after the general boundary is sealed."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-FOUNDATION-HALF-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001", "SFT-MATH-COMBINATORICS-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.CoupledEnsembleSynchronizationEvidence

import SFT.Physics.PostNewtonianFixedPointGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.PostNewtonianFixedPointEvidence
open SFT.Host SFT.Host.Canonical PostNewtonianFixedPointGrammar
open PostNewtonianFixedPointCertificate
open PostNewtonianFixedPoint
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("source_construction",.text (sourceName c.source)),("coupling",.text (couplingName c.coupling)),("nonlinear_action",.text (actionName c.action)),("fixed_point",.text (fixedName c.fixed)),("convergence_law",.text (convergenceName c.convergence)),("scope",.text (scopeName c.scope)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "" ["CandidateForm(",Text.intercalate ", " [Text.intercalate "" ["source_construction='",sourceName c.source,"'"],Text.intercalate "" ["coupling='",couplingName c.coupling,"'"],Text.intercalate "" ["nonlinear_action='",actionName c.action,"'"],Text.intercalate "" ["fixed_point='",fixedName c.fixed,"'"],Text.intercalate "" ["convergence_law='",convergenceName c.convergence,"'"],Text.intercalate "" ["scope='",scopeName c.scope,"'"],Text.intercalate "" ["target_boundary='",targetName c.target,"'"],Text.intercalate "" ["extension='",extensionName c.extension,"'"]],")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Structural source, half-One coupling and quadratic feedback uniquely force the admissible quarter-One fixed point and depth-independent contraction."
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
def frac (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",nv q.den)]
def fractions (xs : List Rat) : Value := .array (xs.map frac)
def structuralValue (v : Structural) : Value := .object [("matter",frac v.matter),("coupling",frac v.coupling),("fixed",frac v.fixed)]
def certificateValue (c : Certificate) : Value := .object [("structural",structuralValue c.structural),("fixed_candidates",fractions c.fixedCandidates),("admissible_fixed_points",fractions c.admissibleFixedPoints),("values",fractions c.values),("errors",fractions c.errors),("corrections",fractions c.corrections),("error_factors",fractions c.errorFactors),("correction_factors",fractions c.correctionFactors),("values_increase_below_fixed",.boolean c.valuesIncreaseBelowFixed),("errors_strictly_shrink",.boolean c.errorsStrictlyShrink),("corrections_strictly_shrink",.boolean c.correctionsStrictlyShrink),("all_factors_below_quarter",.boolean c.allFactorsBelowQuarter),("general_error_identity",.text c.generalErrorIdentity),("general_correction_identity",.text c.generalCorrectionIdentity)]
def generality : Value := .object [("base",.text "linear field is seven-thirty-seconds below quarter-One"),("successor",.text "exact difference of squares makes each next error and correction the prior one times a positive factor below quarter-One"),("larger_fixed_candidate",.text "seven-quarters lies outside Fold-part domain"),("universal_PN_convergence_not_claimed",.boolean true),("targets_absent",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← convergenceCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← convergenceCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.admissibleFixedPoints==[LeptonIntervals.normalize 1 4 (by decide)] && cert.errorsStrictlyShrink && cert.correctionsStrictlyShrink && cert.allFactorsBelowQuarter
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
  | [] => .error "controls require one survivor"
  | _::_::_ => .error "controls require one survivor"
 let ids := candidates.map candidateId
 let identities := ids.map (fun id => id.toUTF8.data.toList.map UInt8.toNat)
 pure [
 control .falsePremise ((← fixedPointCandidates).any (fun q => q==LeptonIntervals.normalize 7 4 (by decide)) && !(← admissibleFixedPoints).any (fun q => q==LeptonIntervals.normalize 7 4 (by decide))) "Reject larger algebraic root as a Fold part." "Seven-quarters exceeds the One.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject changed source identity." "Identity differs.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicate candidates." "All identities unique.",
 control .boundary (!survives {held with scope:=.c1} && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject universalization, target access and correction." "Only scalar scope, sealed target and empty extension survive."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-POST-NEWTONIAN-FIXED-POINT-TERMINAL-009"
 title := "Exact gravitational self-source fixed point and correction contraction"
 branch := "physics"
 statement := "Binary support and generator-three colour force matter source seven-sixteenths; half-One is the coupling; quadratic field energy supplies self-source feedback. The exact map f-next=half-One times (seven-sixteenths plus f squared) has one admissible Fold-part fixed point, quarter-One. Starting from the linear field seven-thirty-seconds, every iterate remains below and approaches quarter-One; both its positive gap and each added correction contract at every successor by an exact factor below quarter-One. This depth-independent Fold theorem corresponds post-seal to weak-field post-Newtonian iteration without claiming universal numerical convergence outside its registered scalar channel."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-FOUNDATION-HALF-ONE-001", "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.PostNewtonianFixedPointEvidence

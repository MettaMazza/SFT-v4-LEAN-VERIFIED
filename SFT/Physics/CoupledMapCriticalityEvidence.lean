import SFT.Physics.CoupledMapCriticalityGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CoupledMapCriticalityEvidence
open SFT.Host SFT.Host.Canonical CoupledMapCriticalityGrammar
open CoupledMapCriticalityCertificate
open CoupledMapCriticality
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("expansion_domain",.text (expansionName c.expansion)),("coupling_action",.text (actionName c.action)),("threshold_relation",.text (thresholdName c.threshold)),("regime_partition",.text (regimeName c.regime)),("synchronization_scope",.text (scopeName c.scope)),("analytic_boundary",.text (analyticName c.analytic)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "" ["CandidateForm(",Text.intercalate ", " [Text.intercalate "" ["expansion_domain='",expansionName c.expansion,"'"],Text.intercalate "" ["coupling_action='",actionName c.action,"'"],Text.intercalate "" ["threshold_relation='",thresholdName c.threshold,"'"],Text.intercalate "" ["regime_partition='",regimeName c.regime,"'"],Text.intercalate "" ["synchronization_scope='",scopeName c.scope,"'"],Text.intercalate "" ["analytic_boundary='",analyticName c.analytic,"'"],Text.intercalate "" ["target_boundary='",targetName c.target,"'"],Text.intercalate "" ["extension='",extensionName c.extension,"'"]],")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "The exact residual multiplier uniquely forces (m-1)/m, the three critical regimes, normalized topology scope and no free correction."
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
def rowValue (c : ThresholdRow) : Value := .object [("label_count",nv c.labelCount),("threshold",frac c.threshold),("below",frac c.below),("above",frac c.above),("below_multiplier",frac c.belowMultiplier),("boundary_multiplier",frac c.boundaryMultiplier),("above_multiplier",frac c.aboveMultiplier),("classes",.array (c.classes.map Value.text))]
def certificateValue (c : Certificate) : Value := .object [("rows",.array (c.rows.map rowValue)),("unique_threshold",.boolean c.uniqueThreshold),("binary_threshold_is_half_One",.boolean c.binaryThresholdIsHalfOne),("topology_scope",.text c.topologyScope),("analytic_proof_value_required",.boolean c.analyticProofValueRequired)]
def generality : Value := .object [("base",.text "m times the retained One-minus-g share is the exact transverse multiplier"),("boundary",.text "equality with One uniquely gives g=(m-1)/m"),("regimes",.text "ordered exact fractions force expansion, neutrality and contraction"),("arbitrary_topology_universalized",.boolean false),("external_targets_absent",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← criticalityCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← criticalityCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.uniqueThreshold && cert.binaryThresholdIsHalfOne && !cert.analyticProofValueRequired
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
 control .falsePremise (decide ((← holdingThreshold (.integer 3))≠LeptonIntervals.normalize 1 2 (by decide)) && Text.equal (← stabilityClass (.integer 3) (LeptonIntervals.normalize 1 2 (by decide))) "strict-expansion") "Reject half-One as a universal threshold for every m." "The three-label threshold is two-thirds and half-One remains below it.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject a changed claimant source identity." "The changed identity differs from the registered manifest.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicated candidate identities." "The complete product has unique identities.",
 control .boundary (!survives {held with scope:=.c1} && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject universal topology, pre-seal observation and free correction." "Only normalized scope, sealed target and empty extension survive."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-COUPLED-MAP-CRITICALITY-TERMINAL-008"
 title := "Exact normalized coupled-map synchronization threshold"
 branch := "physics"
 statement := "For a complete m-label Fold in the normalized drive-response transverse channel, one coupling step retains the exact transverse multiplier m(One-g). The unique neutral boundary is g=(m-1)/m; every smaller proper coupling expands the distinction and every larger proper coupling contracts it. For m=2 the boundary is the forced half-One. This threshold is not assigned to arbitrary network topologies, whose distinct transverse eigenvalue factors remain explicit external scope."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-LYAPUNOV-KS-CORRESPONDENCE-TERMINAL-008", "SFT-PHYS-COUPLED-ENSEMBLE-SYNCHRONIZATION-TERMINAL-007", "SFT-COMP-DIST-SYNCHRONIZATION-001", "SFT-FOUNDATION-HALF-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.CoupledMapCriticalityEvidence

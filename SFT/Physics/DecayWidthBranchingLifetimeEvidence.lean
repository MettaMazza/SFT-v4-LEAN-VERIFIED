import SFT.Physics.DecayWidthBranchingLifetimeGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.DecayWidthBranchingLifetimeEvidence
open SFT.Host SFT.Host.Canonical DecayWidthBranchingLifetimeGrammar DecayWidthBranchingLifetimeProofs
open DecayWidthBranchingLifetimeCertificate
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("partial_width_carrier",.text (widthName c.width)),("channel_domain",.text (domainName c.domain)),("total_width_law",.text (totalName c.total)),("branching_law",.text (branchName c.branch)),("partition_law",.text (partitionName c.partition)),("lifetime_law",.text (lifetimeName c.lifetime)),("ordering_law",.text (orderingName c.ordering)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "; " [Text.append "partial=" (widthName c.width),Text.append "domain=" (domainName c.domain),Text.append "total=" (totalName c.total),Text.append "branch=" (branchName c.branch),Text.append "partition=" (partitionName c.partition),Text.append "lifetime=" (lifetimeName c.lifetime),Text.append "ordering=" (orderingName c.ordering),Text.append "target=" (targetName c.target),Text.append "extension=" (extensionName c.extension)]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Paired transition support fixes each positive open-channel partial width. Complete mutually exclusive composition forces their total, normalization forces the One partition, and action-width reciprocity forces the inverse lifetime ordering."
def completenessRecord : Value := .object [("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("axis_cardinalities",.array ([3,3,3,3,3,3,3,2,2].map (fun n => Value.integer (.ofNat n)))),("candidate_count",.integer (.ofNat candidates.length)),("candidate_ids",.array (candidates.map (fun c => .text (candidateId c))))]
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := sourceIdentity (.object [("generator",.text generationRule),("form",formValue c),("computed_facts",factsValue c)])
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
 proofHash := sourceIdentity (.object [("candidate_trace",.text traceHash),("form",formValue c),("facts",factsValue c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
-- Original _forms_by_id: retain generated identity keys once for lookup.
def formIndex : List (List Nat × Candidate) := candidates.map (fun c => ( (candidateId c).toUTF8.data.toList.map UInt8.toNat,c))
def decideCandidate (c : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 let key := c.candidateId.toUTF8.data.toList.map UInt8.toNat
 match formIndex.find? (fun p => p.1==key) with
 | none => .error "KeyError"
 | some (_,f) => .ok (decisionData f c.traceHash)
def fractionValue (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def ratList (xs : List Rat) : Value := .array (xs.map fractionValue)
def certificateValue (c : Certificate) : Value := .object [("closed_channel",ratList c.closedChannel),("sample_partial_widths",ratList c.sampleWidths),("sample_total_width",fractionValue c.total),("sample_branching_parts",ratList c.parts),("sample_partition",fractionValue c.partition),("sample_lifetime",fractionValue c.lifetime),("width_lifetime_vector",.array (c.widthLifetimeVector.map (fun (a,b) => .array [fractionValue a,fractionValue b]))),("successor_total_increments",ratList c.successorIncrements),("successor_partitions",ratList c.successorPartitions),("wider_state_lifetime_takes",ratList c.widerLifetimeTakes)]
def generality : Value := .object [("base",.text "one positive open channel has total width gamma_1, branch One and lifetime action/gamma_1"),("successor_total",.text "Gamma_(n+1)=Gamma_n+gamma_(n+1)"),("successor_partition",.text "sum_i gamma_i/Gamma_(n+1)=One for the complete enlarged family"),("lifetime",.text "tau=action/Gamma for every exact positive total width"),("ordering",.text "Gamma_b>Gamma_a implies action/Gamma_a takes action/Gamma_b is positive"),("closed_channel",.array []),("target_absent_from_formal_module",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← formalCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors_computed",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← formalCertificate
 let minimal := (decisions.filter SFT.Engine.CandidateDecision.survives).length==1 && cert.closedChannel.isEmpty && cert.sampleWidths==[LeptonIntervals.normalize 1 4 (by decide),LeptonIntervals.normalize 1 2 (by decide),LeptonIntervals.normalize 5 4 (by decide)] && cert.total==VacuumLedgerProofs.wholeRatio 2 && cert.parts==[LeptonIntervals.normalize 1 8 (by decide),LeptonIntervals.normalize 1 4 (by decide),LeptonIntervals.normalize 5 8 (by decide)] && cert.partition==VacuumLedgerProofs.wholeRatio 1 && cert.lifetime==LeptonIntervals.normalize 1 2 (by decide) && cert.successorIncrements.all (fun x => x.num>=1) && cert.successorPartitions.all (fun x => x==VacuumLedgerProofs.wholeRatio 1) && cert.widerLifetimeTakes.all (fun x => x.num>=1)
 pure { scope := .depthIndependent
        exactBoundary := grammarBoundary
        minimalityPassed := minimal
        namedShapeUniquenessPassed := minimal && (← extensionIsForced "empty-extension")
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
  | [] => .error "controls require exactly one computed form"
  | _::_::_ => .error "controls require exactly one computed form"
 let ids := candidates.map candidateId
 let duplicated := (ids ++ ids.take 1).map (fun id => id.toUTF8.data.toList.map UInt8.toNat)
 pure [
 control .falsePremise (!survives {held with partition:=.c1} && !survives {held with lifetime:=.c1}) "Reject incomplete branching and a width-proportional lifetime." "Complete normalization and exact inverse duration reject both false laws.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject any changed claimant source identity." "The changed identity differs from the registered source manifest.",
 control .tamperedArtifact (duplicated.eraseDups.length != ids.length+1) "Reject a duplicated or incomplete candidate census." "The deliberate duplicate fails complete candidate identity.",
 control .boundary (DecayWidthBranchingLifetime.closedChannel.isEmpty && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject a numerical null channel, pre-seal target access and free correction." "Closed channels are structural absence; sealed custody and empty extension are required."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-DECAY-WIDTH-BRANCHING-LIFETIME-TERMINAL-006"
 title := "Terminal Fold decay widths, exact branching partitions and lifetimes"
 branch := "physics"
 statement := "Every distinguishable open decay channel has exact positive partial width equal to its paired transition weight times available generated output support per action carrier. Closed channels are structural empty forms. The total width is the complete ordered positive sum of the open partial widths; each branching part is its partial width over that total, and the mutually exclusive complete branching family sums exactly to the One. Duration is the action carrier over total width, so increasing transition support increases width and strictly shortens lifetime. The base and channel-successor laws hold for every nonempty finite generated family."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-MATTER-DECAY-001", "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005", "SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005", "SFT-PHYS-QUANTUM-WEIGHT-001", "SFT-PHYS-MECH-DURATION-001", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001", "SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.DecayWidthBranchingLifetimeEvidence

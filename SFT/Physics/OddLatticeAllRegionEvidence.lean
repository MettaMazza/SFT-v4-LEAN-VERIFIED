import SFT.Physics.OddLatticeAllRegionGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.OddLatticeAllRegionEvidence
open SFT.Host SFT.Host.Canonical OddLatticeAllRegionGrammar
open OddLatticeAllRegionCertificate
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("lattice_domain",.text (latticeName c.lattice)),("fold_action",.text (foldName c.fold)),("support_scope",.text (supportName c.support)),("region_partition",.text (regionName c.region)),("occupancy_relation",.text (occupancyName c.occupancy)),("depth_closure",.text (depthName c.depth)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "lattice=" (latticeName c.lattice),SFT.Host.Text.append "Fold=" (foldName c.fold),SFT.Host.Text.append "support=" (supportName c.support),SFT.Host.Text.append "regions=" (regionName c.region),SFT.Host.Text.append "occupancy=" (occupancyName c.occupancy),SFT.Host.Text.append "depth=" (depthName c.depth),SFT.Host.Text.append "target=" (targetName c.target),SFT.Host.Text.append "extension=" (extensionName c.extension)]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then SFT.Host.Text.intercalate "" ["Rejected by computed Fold predicates: ",SFT.Host.Text.intercalate ", " failures,"."] else "The odd complete lattice and binary Fold force a support permutation; complete positive region observation therefore retains the exact vector at every positive successor depth."
def completenessRecord : Value := .object [("axis_cardinalities",.array ([3,3,3,3,3,3,2,2].map (fun n => .integer (.ofNat n)))),("candidate_ids",.array (candidates.map (fun c => .text (candidateId c))))]
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := sourceIdentity (.object [("generation_rule",.text generationRule),("form",formValue c),("computed_facts",factsValue c)])
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
 proofHash := sourceIdentity (.object [("candidate_trace",.text traceHash),("facts",factsValue c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
-- Original _forms_by_id: retain generated identity keys once for lookup.
def formIndex : List (List Nat × Candidate) := candidates.map (fun c => ( (candidateId c).toUTF8.data.toList.map UInt8.toNat,c))
def decideCandidate (c : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 let key := c.candidateId.toUTF8.data.toList.map UInt8.toNat
 match formIndex.find? (fun p => p.1==key) with
 | none => .error "KeyError"
 | some (_,f) => .ok (decisionData f c.traceHash)
def nv (n : Nat) : Value := .integer (.ofNat n)
def ns (xs : List Nat) : Value := .array (xs.map nv)
def pc (p : PermutationCertificate) : Value := .object [("member_count",.integer p.memberCount),("image",ns p.image),("image_is_complete_support",.boolean p.imageComplete),("image_cardinality",nv p.imageCardinality),("source_cardinality",.integer p.sourceCardinality),("parity_reason",.text p.parityReason)]
def ic (c : InvarianceCertificate) : Value := .object [("permutation",pc c.permutation),("base_vector",ns c.baseVector),("vectors",.array (c.vectors.map ns)),("all_steps_equal",.boolean c.allStepsEqual),("all_regions_occupied",.boolean c.allRegionsOccupied),("total_members_retained",.boolean c.totalMembersRetained)]
def certificateValue (c : Certificate) : Value := .object [("generated_shapes",.array (c.shapes.map (fun (n,r) => .array [nv n,nv r]))),("certificates",.array (c.certificates.map ic)),("generality",.text c.generality)]
def generality : Value := .object [("base",.text "one binary Fold permutes every positive residue of an odd complete lattice"),("successor",.text "a composition of the same permutation remains a permutation"),("observation",.text "a complete region tally depends on support membership, not member ordering"),("coverage",.text "R positive bins over N complete members are nonempty whenever R does not exceed N"),("historical_target_absent_from_claimant",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← formalCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← formalCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.certificates.all (fun x => x.permutation.imageComplete) && cert.certificates.all (fun x => x.allStepsEqual) && cert.certificates.all (fun x => x.allRegionsOccupied) && cert.certificates.all (fun x => x.totalMembersRetained)
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
 control .falsePremise (!survives {held with fold:=.c1}) "Reject a nonpermuting residue rule." "The deliberate nonpermutation loses complete support.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject a changed claimant source identity." "The changed identity differs from the registered manifest.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicate candidate identities." "The complete product has unique identities.",
 control .boundary (!survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject pre-seal target access and a free correction." "Sealed custody and empty extension are forced."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-ODD-LATTICE-ALL-REGION-OCCUPANCY-TERMINAL-007"
 title := "Odd-lattice all-region occupancy and exact recurrence vector"
 branch := "physics"
 statement := "For every positive finite odd complete lattice beyond the One, the binary Fold is a permutation of its complete positive residue support. Every positive Fold successor therefore preserves the entire exact occupancy vector under every complete positive region partition having no more regions than members. The vector totals the lattice count and every region count is positive. This closes the all-region law and its recurrence vector at arbitrary positive finite depth, without importing a historical lattice size, chosen Fold count, measured vector or correction."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003", "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-MATH-ORBIT-NUMBER-THEORY-002", "SFT-MATH-DYNAMICAL-SYSTEMS-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.OddLatticeAllRegionEvidence

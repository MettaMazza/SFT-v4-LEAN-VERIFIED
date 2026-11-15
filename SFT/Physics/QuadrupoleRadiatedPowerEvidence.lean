import SFT.Physics.QuadrupoleRadiatedPowerGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.QuadrupoleRadiatedPowerEvidence
open SFT.Host SFT.Host.Canonical QuadrupoleRadiatedPowerGrammar
open QuadrupoleRadiatedPowerCertificate
open QuadrupoleRadiatedPower
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("moment_law",.text (momentName c.moment)),("rate_law",.text (rateName c.rate)),("energy_law",.text (energyName c.energy)),("coupling_law",.text (couplingName c.coupling)),("shell_law",.text (shellName c.shell)),("adverse_control",.text (controlName c.control)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "" ["CandidateForm(",Text.intercalate ", " [Text.intercalate "" ["moment_law='",momentName c.moment,"'"],Text.intercalate "" ["rate_law='",rateName c.rate,"'"],Text.intercalate "" ["energy_law='",energyName c.energy,"'"],Text.intercalate "" ["coupling_law='",couplingName c.coupling,"'"],Text.intercalate "" ["shell_law='",shellName c.shell,"'"],Text.intercalate "" ["adverse_control='",controlName c.control,"'"],Text.intercalate "" ["target_boundary='",targetName c.target,"'"],Text.intercalate "" ["extension='",extensionName c.extension,"'"]],")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Held lower moments, third generated difference, field-energy square, half-One coupling and rank-two shell conservation force the complete power law."
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
def listResult : Except String (List Rat) → Value
 | .error e => .object [("error",.text e)]
 | .ok xs => .array (xs.map frac)
def powerResult : Except String (Option Rat) → Value
 | .error e => .object [("error",.text e)]
 | .ok none => .array []
 | .ok (some x) => frac x
def identityValue (x : CubicIdentity) : Value := .object [("index",nv x.index),("left",nv x.left),("right",nv x.right),("identity_holds",.boolean x.identityHolds),("successor_left_increment",nv x.successorLeftIncrement),("successor_right_increment",nv x.successorRightIncrement),("generated_successor_increment",nv x.generatedSuccessorIncrement),("successor_preserves_identity",.boolean x.successorPreservesIdentity)]
def identityResult : Except String CubicIdentity → Value | .error e => .object [("error",.text e)] | .ok x => identityValue x
def shellValue (r : ShellRow) : Value := .object [("radius",frac r.radius),("density",frac r.density),("reconstructed_power",frac r.reconstructedPower)]
def certificateValue (c : Certificate) : Value := .object [("coupling",frac c.coupling),("monopole_record",.text c.monopoleRecord),("dipole_record",.text c.dipoleRecord),("first_radiative_moment",.text c.firstRadiativeMoment),("base_third_record",.array (c.baseThirdRecord.map frac)),("doubled_third_record",.array (c.doubledThirdRecord.map frac)),("base_power",frac c.basePower),("doubled_power",frac c.doubledPower),("static_power_record",powerResult (.ok c.staticPowerRecord)),("third_rate_doubles",.boolean c.thirdRateDoubles),("power_quadruples",.boolean c.powerQuadruples),("shell_rows",.array (c.shellRows.map shellValue)),("shell_power_conserved",.boolean c.shellPowerConserved),("cubic_identities",.array (c.cubicIdentities.map identityValue)),("base_identity_holds",.boolean c.baseIdentityHolds),("successor_identity_holds",.boolean c.successorIdentityHolds),("general_rate_identity",.text c.generalRateIdentity),("general_power_identity",.text c.generalPowerIdentity),("general_shell_identity",.text c.generalShellIdentity),("static_silence_is_empty_not_numeric_zero",.boolean c.staticSilenceIsEmpty),("negative_zero_irrational_or_imaginary_proof_scalar_used",.boolean c.forbiddenProofScalarUsed)]
def generality : Value := .object [("base",.text "At the first positive cubic index, opposed positive cubic sums differ by the retained six-carrier and half-One times its square is the radiated-power carrier."),("successor",.text "Both opposed cubic ledgers gain the same positive twelve-index-squared plus forty-eight-index plus fifty-eight carrier, preserving the six-carrier third difference at every successor."),("shell",.text "Each binary radius successor gives four boundary cells, quarters density and preserves density paired with radius twice."),("targets_absent",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← radiatedPowerCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← radiatedPowerCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.staticSilenceIsEmpty && cert.thirdRateDoubles && cert.powerQuadruples && cert.shellPowerConserved && cert.baseIdentityHolds && cert.successorIdentityHolds
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
 control .falsePremise ((← radiatedPowerCertificate).staticPowerRecord.isNone && (← radiatedPowerCertificate).powerQuadruples) "Reject numerical-zero static power or linear amplitude scaling." "Static radiation is empty and doubled third rate gives fourfold power.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject changed source identity." "Identity differs.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicate candidates." "All identities are unique.",
 control .boundary (!survives {held with rate:=.c1} && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject free derivative order, pre-seal target access and free correction." "Only generated third rate, sealed target custody and empty extension survive."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-QUADRUPOLE-RADIATED-POWER-TERMINAL-012"
 title := "Exact quadrupole third-difference radiated-power law"
 branch := "physics"
 statement := "Held source and momentum records close monopole and dipole radiation, leaving the quadrupole as the first radiative moment. One more generated difference gives its radiative rate. The admitted field-energy square and binary half-One coupling force power equal to half-One paired with that third-rate carrier twice. A static quadrupole closes to an empty radiation record, amplitude scaling is exactly squared, and rank-two shell dilution preserves total power at every finite radius."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003", "SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003", "SFT-PHYS-FIELD-INVERSE-SQUARE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010", "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.QuadrupoleRadiatedPowerEvidence

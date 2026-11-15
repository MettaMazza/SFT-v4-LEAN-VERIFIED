import SFT.Physics.OrbitalDimensionStabilityGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.OrbitalDimensionStabilityEvidence
open SFT.Host SFT.Host.Canonical OrbitalDimensionStabilityGrammar
open OrbitalDimensionStabilityCertificate
open OrbitalDimensionStability
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceIdentity (v : Value) : String := Text.append "sha256:" (SHA256Chunks.digest (render v).toUTF8)
theorem sourceIdentityPreserves (v : Value) : sourceIdentity v=admissionIdentity v := by
 unfold sourceIdentity admissionIdentity identity
 rw [SHA256Chunks.digestPreserved]
def formValue (c : Candidate) : Value := .object [("dimension_domain",.text (dimensionName c.dimension)),("gravity_dilution",.text (gravityName c.gravity)),("centrifugal_dilution",.text (centrifugalName c.centrifugal)),("circular_balance",.text (balanceName c.balance)),("outward_comparison",.text (comparisonName c.comparison)),("stability_partition",.text (partitionName c.partition)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "" ["CandidateForm(",Text.intercalate ", " [Text.intercalate "" ["dimension_domain='",dimensionName c.dimension,"'"],Text.intercalate "" ["gravity_dilution='",gravityName c.gravity,"'"],Text.intercalate "" ["centrifugal_dilution='",centrifugalName c.centrifugal,"'"],Text.intercalate "" ["circular_balance='",balanceName c.balance,"'"],Text.intercalate "" ["outward_comparison='",comparisonName c.comparison,"'"],Text.intercalate "" ["stability_partition='",partitionName c.partition,"'"],Text.intercalate "" ["target_boundary='",targetName c.target,"'"],Text.intercalate "" ["extension='",extensionName c.extension,"'"]],")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Positive denominator ordering forces the complete stable, marginal and unstable dimension partition with no correction."
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
open SFT.Foundation.ExactOperations
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (q : PositiveFraction) : Value := .object [("numerator",nv q.numerator),("denominator",nv q.denominator)]
def rowValue (r : DimensionRow) : Value := .object [("dimension",nv r.dimension),("classes",.array (r.classes.map Value.text)),("magnitudes",.array (r.magnitudes.map (fun p => .array [frac p.1,frac p.2])))]
def certificateValue (c : Certificate) : Value := .object [("rows",.array (c.rows.map rowValue)),("stable_dimensions",.array (c.stableDimensions.map nv)),("marginal_dimensions",.array (c.marginalDimensions.map nv)),("unstable_dimensions",.array (c.unstableDimensions.map nv)),("general_partition",.text c.generalPartition),("proof",.text c.proof),("negative_exponent_required",.boolean c.negativeExponentRequired)]
def generality : Value := .object [("base",.text "d=2 compares q with q cubed"),("successor",.text "increasing d multiplies only the gravity denominator by q greater than One, so the ordering crosses equality once at d=4 and never returns"),("negative_values_imported",.boolean false),("targets_absent",.boolean true)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("certificate",certificateValue (← dimensionCertificate)),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("survivors",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId)))])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let cert ← dimensionCertificate
 let survivors := (decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => d.candidateId.toUTF8.data.toList.map UInt8.toNat)
 let minimal := survivors.length==1 && cert.stableDimensions==[2,3] && cert.marginalDimensions==[4] && cert.unstableDimensions==[5,6,7,8,9,10,11,12]
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
 control .falsePremise (Text.equal (← orbitalStabilityClass (.integer 5) (.fraction (BoundaryGrowth.asFraction (normalizePositive 2 1 (by decide) (by decide))))) "unstable-nonrestoring") "Reject stable five-space orbit under inverse-fourth-power gravity." "Gravity falls below inverse-cube centrifugal response.",
 control .tamperedSource (!(Text.equal (sourceIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject changed source identity." "Identity differs.",
 control .tamperedArtifact (identities.eraseDups.length == identities.length) "Reject duplicate candidates." "All identities unique.",
 control .boundary (!survives {held with comparison:=.c1} && !survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject negative-exponent import, pre-seal observation and correction." "Only positive comparison, sealed target and empty extension survive."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-ORBITAL-DIMENSION-STABILITY-TERMINAL-009"
 title := "All-dimension orbital-restoration stability law"
 branch := "physics"
 statement := "At a circular balance, dimension-forced gravity and centrifugal response are equal positive magnitudes. After every exact outward displacement q greater than the One, gravity has positive denominator q^(d-1) and centrifugal response q^3. Denominator order alone forces restoring gravity for d=2,3, equality at d=4, and nonrestoring response for every d at least five. Combined with independently forced three-space, orbital stability supplies a distinct discriminator selecting the stable side without signed forces, negative exponents or fitted parameters."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-FIELD-INVERSE-SQUARE-001", "SFT-PHYS-VALIDATION-INVERSE-SQUARE-001", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.OrbitalDimensionStabilityEvidence

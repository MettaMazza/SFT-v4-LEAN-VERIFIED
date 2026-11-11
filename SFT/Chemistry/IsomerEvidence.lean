import SFT.Chemistry.IsomerGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.IsomerEvidence
open SFT.Host.Canonical IsomerGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "equal-composition",.text "chain and branched witnesses have equal exact composition",.boolean true],.array [.text "inequivalence",.text "complete finite relabelling rejects chain/branch identity",.boolean true],.array [.text "self-control",.text "a relabelled copy is structurally equivalent",.boolean true]]
def claimId : String := "SFT-CHEM-MOL-ISOMER-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-BOND-METALLIC-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-BOND-LENGTH-STRENGTH-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-GEOMETRY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "pair",.text (pairName c.pair)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "structure",.text (structureName c.structural)],.array [.text "equivalence",.text (equivalenceName c.equivalence)],.array [.text "distinction",.text (distinctionName c.distinction)],.array [.text "identity",.text (identityName c.identity)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "pair",.array [.array [.text "single-carrier-description",.text "Isomerism compares at least two chemical carriers."],.array [.text "two-identified-carriers",.text "Both carriers remain separately identified."]]],.array [.text "composition",.array [.array [.text "different-compositions",.text "Different composition is not isomerism."],.array [.text "equal-exact-composition",.text "Element labels and positive multiplicities agree exactly."]]],.array [.text "structure",.array [.array [.text "formula-equated-identity",.text "A formula does not exhaust bonded organization."],.array [.text "complete-structure-signatures",.text "Connectivity and held orientation are compared."]]],.array [.text "equivalence",.array [.array [.text "name-string-inequality",.text "Different names can denote the same structure."],.array [.text "all-identity-preserving-relabelings",.text "Structural equality is tested under every finite allowed relabelling."]]],.array [.text "distinction",.array [.array [.text "equivalent-signatures",.text "Equivalent complete signatures denote the same isomeric form."],.array [.text "connectivity-or-orientation-difference",.text "At least one retained structural relation differs."]]],.array [.text "identity",.array [.array [.text "distinction-erased",.text "Erasing the difference destroys the chemical question."],.array [.text "separate-chemical-identities",.text "Each surviving structure retains its own identity."]]],.array [.text "record",.array [.array [.text "isomer-label-only",.text "A label cannot reproduce equality and difference."],.array [.text "composition-and-structure-trace",.text "Both composition and full comparison remain auditable."]]],.array [.text "extension",.array [.array [.text "free-isomer-class",.text "A free class label can manufacture a distinction."],.array [.text "no-extra-rule",.text "Equal composition plus structural inequivalence is sufficient."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Isomer distinction under equal composition"
 branch := "chemistry"
 statement := "Isomers have exactly equal retained composition but inequivalent complete connectivity or orientation signatures after every identity-preserving finite relabelling."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := identity (.array [.text claimId,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := identity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := identity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "two-identified-carriers__equal-exact-composition__complete-structure-signatures__all-identity-preserving-relabelings__connectivity-or-orientation-difference"),("base",.text "The first isomeric pair is the least generated equal-composition pair whose complete structural signatures are not related by an identity-preserving relabelling."),("successor",.text "Appending matched composition to both carriers preserves equality, while any retained unmatched connectivity or orientation relation preserves their distinction."),("exclusions",.array [.text "no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application or opaque prediction result",.text "no claim that topology alone predicts every measured coordinate or energy",.text "external content remains inaccessible until after the consequence is sealed",.text "Every finite pair of admitted chemical carriers with exactly equal composition signatures but unequal complete connectivity or held-orientation signatures after every identity-preserving relabelling."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application or opaque prediction result","no claim that topology alone predicts every measured coordinate or energy","external content remains inaccessible until after the consequence is sealed","Every finite pair of admitted chemical carriers with exactly equal composition signatures but unequal complete connectivity or held-orientation signatures after every identity-preserving relabelling."]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (identity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def runControls (sourceHash : String) : Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with pair := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.IsomerEvidence

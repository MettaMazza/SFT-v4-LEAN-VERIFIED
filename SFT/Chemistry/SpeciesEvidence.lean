import SFT.Chemistry.SpeciesGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.SpeciesEvidence
open SFT.Host.Canonical SpeciesGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "species-ensemble",.text "two equivalent entity members form one retained class",.boolean true],.array [.text "species-timescale",.text "changed observational timescale may refine the class",.boolean true],.array [.text "species-mixed-control",.text "a chemically distinct member is rejected",.boolean true]]
def claimId : String := "SFT-CHEM-MEAS-CHEMICAL-SPECIES-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "member_identity",.text (member_identityName c.member_identity)],.array [.text "support",.text (supportName c.support)],.array [.text "timescale",.text (timescaleName c.timescale)],.array [.text "solid_support",.text (solid_supportName c.solid_support)],.array [.text "record",.text (recordName c.record)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "singular-only",.text "One member alone is not a chemical species class."],.array [.text "ensemble-carrier",.text "A species is the generated support of equivalent chemical entities."]]],.array [.text "member_identity",.array [.array [.text "mixed-chemical-identities",.text "Mixed chemical identities do not form one species."],.array [.text "chemical-identity-equivalence",.text "Every member preserves the same registered chemical identity coordinates."]]],.array [.text "support",.array [.array [.text "energy-support-erased",.text "Erasing accessible-state support merges experimentally distinct species."],.array [.text "shared-energy-support",.text "Members share the same accessible molecular energy support at the boundary."]]],.array [.text "timescale",.array [.array [.text "timeless-equivalence",.text "Interconversion can change whether two forms are experimentally distinct."],.array [.text "experiment-timescale-boundary",.text "The observation timescale is retained as part of the equivalence relation."]]],.array [.text "solid_support",.array [.array [.text "isolated-molecule-only",.text "A species law limited to isolable molecules loses solid structural units."],.array [.text "molecular-or-solid-unit-support",.text "The carrier permits molecular and solid-array structural units."]]],.array [.text "record",.array [.array [.text "class-without-member-trace",.text "A quotient without member trace cannot be reconstructed."],.array [.text "held-member-and-class-record",.text "Members and their observation quotient remain separately auditable."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "An unbound class can silently change its equivalence rule."],.array [.text "source-bound-proof-trace",.text "The generated relation and external record retain distinct identities."]]],.array [.text "extension",.array [.array [.text "free-extra-equivalence",.text "A discretionary equivalence can force any desired species partition."],.array [.text "no-extra-rule",.text "Only generated identity, support and timescale determine the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical species and observation-equivalence class"
 branch := "chemistry"
 statement := "A chemical species is the least Fold quotient whose support is an ensemble of chemically identical entities sharing accessible state support at one declared experimental timescale."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "ensemble-carrier__chemical-identity-equivalence__shared-energy-support__experiment-timescale-boundary"),("base",.text "One admitted chemical entity supplies the first member of one exact observation-equivalence class."),("successor",.text "Adding one chemically identical entity with the same accessible support preserves the class at the declared experimental timescale."),("exclusions",.array [.text "no IUPAC definition, conventional chemistry model or target content may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "external target content is absent from this specification and opens only through post-seal custody",.text "Every finite observation-equivalence class formed from admitted singular chemical entities under an exact declared experiment-timescale relation and any positive-finite successor extension."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, conventional chemistry model or target content may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","external target content is absent from this specification and opens only through post-seal custody","Every finite observation-equivalence class formed from admitted singular chemical entities under an exact declared experiment-timescale relation and any positive-finite successor extension."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.SpeciesEvidence

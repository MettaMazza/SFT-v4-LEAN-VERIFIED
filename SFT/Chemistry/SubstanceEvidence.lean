import SFT.Chemistry.SubstanceGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.SubstanceEvidence
open SFT.Host.Canonical SubstanceGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "substance-composition",.text "constant constituent composition reconstructs the carrier",.boolean true],.array [.text "substance-property",.text "a registered property refines characterization without selecting the law",.boolean true],.array [.text "substance-variable-control",.text "unrecorded variable composition is rejected",.boolean true]]
def claimId : String := "SFT-CHEM-MEAS-SUBSTANCE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "composition",.text (compositionName c.composition)],.array [.text "constituents",.text (constituentsName c.constituents)],.array [.text "properties",.text (propertiesName c.properties)],.array [.text "source",.text (sourceName c.source)],.array [.text "phase",.text (phaseName c.phase)],.array [.text "record",.text (recordName c.record)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "composition",.array [.array [.text "variable-unrecorded-composition",.text "Unrecorded variable composition cannot identify one substance."],.array [.text "constant-composition",.text "The constituent relation is held constant at the declared identity boundary."]]],.array [.text "constituents",.array [.array [.text "anonymous-matter",.text "Matter without retained constituent entities loses chemical identity."],.array [.text "constituent-entity-support",.text "Atoms, molecules or formula units remain the composition carriers."]]],.array [.text "properties",.array [.array [.text "composition-only-answer",.text "Composition alone can leave observation-equivalent candidates unresolved."],.array [.text "property-characterization",.text "Registered physical-property observations characterize the substance carrier."]]],.array [.text "source",.array [.array [.text "source-free-substance-label",.text "A source-free label cannot distinguish sample and convention boundaries."],.array [.text "source-bounded-substance-identity",.text "The substance identity retains its sample/reference source boundary."]]],.array [.text "phase",.array [.array [.text "phase-silently-collapsed",.text "Silently collapsing phase can erase an observed substance distinction."],.array [.text "phase-record-retained",.text "Phase is retained whenever it participates in the registered observation class."]]],.array [.text "record",.array [.array [.text "property-selection-only",.text "Selecting one favorable property is not a complete characterization record."],.array [.text "complete-property-record",.text "Every registered favorable and unfavorable property row is retained."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound composition and property claims cannot be audited."],.array [.text "source-bound-proof-trace",.text "Derivation and external characterization remain separately source-bound."]]],.array [.text "extension",.array [.array [.text "free-extra-substance-rule",.text "A discretionary rule can split or merge substances after observation."],.array [.text "no-extra-rule",.text "Generated composition and observation distinctions alone determine the carrier."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical substance and composition identity"
 branch := "chemistry"
 statement := "A chemical substance is the least source-bounded Fold carrier that retains constant composition, its constituent entity support and the complete registered property characterization."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "constant-composition__constituent-entity-support__property-characterization__source-bounded-substance-identity"),("base",.text "One constant-composition entity support with one registered property record supplies a substance carrier."),("successor",.text "Adding one generated constituent or property observation preserves composition and source identity while retaining every earlier row."),("exclusions",.array [.text "no IUPAC definition, conventional chemistry model or target content may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "external target content is absent from this specification and opens only through post-seal custody",.text "Every finite chemical substance carrier formed from one generated constant-composition support of chemical entities plus any positive-finite extension of its source-bound property record."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, conventional chemistry model or target content may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","external target content is absent from this specification and opens only through post-seal custody","Every finite chemical substance carrier formed from one generated constant-composition support of chemical entities plus any positive-finite extension of its source-bound property record."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with composition := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.SubstanceEvidence

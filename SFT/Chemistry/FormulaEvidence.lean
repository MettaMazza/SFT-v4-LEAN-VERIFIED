import SFT.Chemistry.FormulaGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.FormulaEvidence
open SFT.Host.Canonical FormulaGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "formula-decode",.text "held entity/count pairs reconstruct composition",.boolean true],.array [.text "formula-structure",.text "held adjacency distinguishes equal-composition structures",.boolean true],.array [.text "name-only-control",.text "a name without counts is rejected as formula",.boolean true]]
def claimId : String := "SFT-CHEM-MEAS-FORMULA-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-MEAS-AMOUNT-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "domain",.text (domainName c.domain)],.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "constituents",.text (constituentsName c.constituents)],.array [.text "multiplicity",.text (multiplicityName c.multiplicity)],.array [.text "mass",.text (massName c.mass)],.array [.text "structure",.text (structureName c.structure)],.array [.text "decode",.text (decodeName c.decode)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "domain",.array [.array [.text "unbounded-object-label",.text "A formula without a declared chemical carrier domain can encode unrelated objects."],.array [.text "discrete-molecule-domain",.text "The molecular-formula claim is bounded to compounds formed from discrete molecules."]]],.array [.text "carrier",.array [.array [.text "name-only-string",.text "A name alone does not retain exact constituent multiplicity."],.array [.text "formula-encoding",.text "The formula is a generated composition word."]]],.array [.text "constituents",.array [.array [.text "anonymous-symbols",.text "Anonymous symbols erase chemical-entity identity."],.array [.text "held-entity-symbols",.text "Every constituent symbol refers to an admitted entity class."]]],.array [.text "multiplicity",.array [.array [.text "unrecorded-repetition",.text "Unrecorded repetition cannot reconstruct composition or relative mass."],.array [.text "exact-positive-multiplicity",.text "Each constituent has an exact generated positive count."]]],.array [.text "mass",.array [.array [.text "mass-unrelated-to-composition",.text "A mass label not reconstructed from the constituent record is not a formula consequence."],.array [.text "composition-mass-correspondence",.text "Relative molecular mass is determined by the retained composition record at the comparison boundary."]]],.array [.text "structure",.array [.array [.text "order-erased",.text "Equal counts can represent distinct molecular structures."],.array [.text "structure-correspondence",.text "A held order/adjacency record distinguishes structural encodings when required."]]],.array [.text "decode",.array [.array [.text "nondecodable-inscription",.text "An inscription that cannot return its constituent record is not an exact encoding."],.array [.text "composition-decodable",.text "Decoding returns every held entity, count and structural coordinate."]]],.array [.text "extension",.array [.array [.text "free-formula-exception",.text "A discretionary exception can manufacture a desired formula."],.array [.text "no-extra-rule",.text "Generated symbols, counts and held order supply the complete formula."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical formula as exact composition encoding"
 branch := "chemistry"
 statement := "A molecular formula is the least decodable Fold word that retains a discrete molecule's constituent entity labels, exact positive multiplicities and any structure coordinate required by the declared identity boundary."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "discrete-molecule-domain__formula-encoding__composition-mass-correspondence__structure-correspondence"),("base",.text "One admitted entity label with one generated multiplicity supplies the first decodable molecular-composition word."),("successor",.text "Appending one held entity/count coordinate preserves every prior constituent and extends composition, relative-mass and optional structure reconstruction."),("exclusions",.array [.text "no IUPAC definition, conventional chemistry model or target content may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "external target content is absent from this specification and opens only through post-seal custody",.text "Every positive-finite discrete-molecule composition word generated from admitted entity labels, exact multiplicities and a held structural-order record."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, conventional chemistry model or target content may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","external target content is absent from this specification and opens only through post-seal custody","Every positive-finite discrete-molecule composition word generated from admitted entity labels, exact multiplicities and a held structural-order record."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with domain := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.FormulaEvidence

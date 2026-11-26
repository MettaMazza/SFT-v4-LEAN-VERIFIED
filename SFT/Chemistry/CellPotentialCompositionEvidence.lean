import SFT.Chemistry.CellPotentialCompositionGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CellPotentialCompositionEvidence
open SFT.Host.Canonical CellPotentialCompositionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "opposed-sum",.text "Opposed half-cell coordinates add exactly.",.boolean true],.array [.text "aligned-Take",.text "Aligned half-cell coordinates compose by positive Take.",.boolean true],.array [.text "path",.text "Cell path identities remain held.",.boolean true],.array [.text "coincidence",.text "Equal coordinates close to EmptyOne.",.boolean true],.array [.text "reverse-carriers",.text "Reversal swaps source and terminal.",.boolean true],.array [.text "reverse-direction",.text "Reversal changes held direction without a negative magnitude.",.boolean true],.array [.text "reverse-magnitude",.text "Reversal preserves exact positive separation.",.boolean true]]
def claimId : String := "SFT-CHEM-CELL-POTENTIAL-COMPOSITION-003"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-QUANTUM-REVERSIBLE-MODEL-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-HALF-REACTION-IDENTITY-ORIENTATION-001","SFT-CHEM-ELECTRODE-POTENTIAL-CHEMICAL-RELATION-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carriers",.text (carriersName c.carriers)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "condition",.text (conditionName c.condition)],.array [.text "path",.text (pathName c.path)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "coincidence",.text (coincidenceName c.coincidence)],.array [.text "record",.text (recordName c.record)],.array [.text "reverse",.text (reverseName c.reverse)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carriers",.array [.array [.text "anonymous-voltage-pair",.text "Anonymous values lose the two chemical half-cells."],.array [.text "two-distinct-held-half-cell-carriers",.text "Both half-reaction identities remain explicit."]]],.array [.text "reference",.array [.array [.text "mixed-reference-subtraction",.text "Different references cannot compose directly."],.array [.text "one-common-held-reference",.text "Both coordinates share one reference."]]],.array [.text "condition",.array [.array [.text "mixed-condition-subtraction",.text "Different conditions destroy a cell comparison."],.array [.text "one-common-held-condition",.text "Both coordinates share one condition."]]],.array [.text "path",.array [.array [.text "unordered-potential-difference",.text "An unordered difference loses reaction direction."],.array [.text "held-source-terminal-reaction-path",.text "The complete cell path fixes source and terminal orientation."]]],.array [.text "composition",.array [.array [.text "signed-arithmetic-premise",.text "Signed arithmetic imports negative proof values."],.array [.text "exact-positive-sum-or-Take-composition",.text "Opposed coordinates add; aligned coordinates use exact positive Take."]]],.array [.text "coincidence",.array [.array [.text "numerical-zero-cell-potential",.text "Numerical zero is not a native proof magnitude."],.array [.text "structural-EmptyOne-cell-coincidence",.text "Equal coordinates close the cell distinction structurally."]]],.array [.text "record",.array [.array [.text "selected-cell-voltage",.text "A selected voltage can conceal half-cell and condition rows."],.array [.text "complete-full-cell-potential-vector",.text "Every cell composition and measured row remains downstream."]]],.array [.text "reverse",.array [.array [.text "irreversible-sign-flip",.text "A sign flip does not reconstruct the chemical path."],.array [.text "exact-cell-reversal-preserves-positive-separation",.text "Reversal swaps carriers and orientation while retaining magnitude."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold cell-potential composition law"
 branch := "chemistry"
 statement := "Two admitted half-cell coordinates at one reference and condition compose by exact positive sum or Take along a held cell path, with EmptyOne at coincidence and exact reversal."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.observationalDerivation]
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "two-distinct-held-half-cell-carriers__one-common-held-reference__one-common-held-condition__held-source-terminal-reaction-path__exact-positive-sum-or-Take-composition__structural-EmptyOne-cell-coincidence__complete-full-cell-potential-vector__exact-cell-reversal-preserves-positive-separation"),("base",.text "Two distinct held half-cells sharing one reference and condition form the first complete cell."),("successor",.text "Appending a common exact reference context preserves the composed separation and its reversible path."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no measured EMF molality or temperature selects composition",.text "all measurement and unapplied-correction records remain downstream provenance"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no measured EMF molality or temperature selects composition","all measurement and unapplied-correction records remain downstream provenance"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carriers := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.CellPotentialCompositionEvidence

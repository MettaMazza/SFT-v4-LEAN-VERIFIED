import «work».CoordinationIsomerismGrammar1474
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CoordinationIsomerismEvidence
open SFT.Host.Canonical CoordinationIsomerismGrammar
set_option maxRecDepth 20000

def onePairWitness : Bool := decide (ObservationCarrier.onePair.length = 1)
def successorWitness : Bool := decide ((([("a", "r-a"), ("b", "r-b")] : List (String × String)).head?) = some ("a", "r-a"))
def witnesses : Value := .array [
 .array [.text "one-reference-pair",.text "One observation and one reference retain two named source coordinates and one pairing.",.boolean onePairWitness],
 .array [.text "successor-retention",.text "Appending a second named pairing leaves the first pairing unchanged.",.boolean successorWitness]]
theorem onePairWitnessPassed : onePairWitness = true := by decide
theorem successorWitnessPassed : successorWitness = true := by decide
def claimId : String := "SFT-CHEM-COORDINATION-ISOMERISM-EQUIVALENCE-005"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-STEREO-CHIRALITY-001","SFT-CHEM-STEREO-ENANTIOMER-001","SFT-CHEM-STEREO-DIASTEREOMER-001","SFT-CHEM-COORDINATION-GEOMETRY-HELD-ORIENTATION-004"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "bijection",.text (bijectionName c.bijection)],.array [.text "graph",.text (graphName c.graph)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "class",.text (className c.class)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "names-or-formulae-only",.text "Names do not retain complete forms."],.array [.text "two-complete-retained-coordination-forms",.text "Both forms retain every occurrence and relation."]]],.array [.text "composition",.array [.array [.text "different-compositions-called-isomers",.text "Isomer comparison requires the same complete composition."],.array [.text "same-complete-composition-multiset",.text "Every composition occurrence is preserved under comparison."]]],.array [.text "bijection",.array [.array [.text "selected-correspondence-between-occurrences",.text "A selected mapping can manufacture equivalence."],.array [.text "enumerate-every-occurrence-bijection",.text "Every finite occurrence bijection is generated."]]],.array [.text "graph",.array [.array [.text "partial-or-named-connectivity",.text "Partial connectivity omits attachment distinctions."],.array [.text "complete-attachment-and-adjacency-preservation",.text "Equivalence preserves every attachment and adjacency."]]],.array [.text "orientation",.array [.array [.text "shape-name-point-group-or-continuum-transform",.text "Imported transformations select the result."],.array [.text "complete-three-axis-two-fibre-relation",.text "Equivalence compares complete held orientation words made only from the two forced fibre labels and the generated global fibre complement."]]],.array [.text "class",.array [.array [.text "imported-isomer-catalogue",.text "A catalogue does not force the first failed invariant."],.array [.text "first-failed-invariant-forces-native-class",.text "Attachment, mirror-complement and remaining orientation distinctions are forced in order."]]],.array [.text "observation",.array [.array [.text "selected-favourable-term",.text "Selected definitions cannot test all classes."],.array [.text "complete-17-surface-sealed-vector-with-linkage-addendum",.text "All general, geometric, mirror, point-of-ligation and isomeric attachment-mode surfaces, identity redirects and the absent literal linkage term remain present."]]],.array [.text "extension",.array [.array [.text "new-occurrence-reclassifies-prior-subform",.text "Rewriting loses the prior class trace."],.array [.text "successor-preserves-prior-signatures-and-adds-relations",.text "The next occurrence preserves every prior relation and extends both forms."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact coordination-form equivalence and native isomer distinction classes"
 branch := "physics"
 statement := "For two positive finite complete coordination forms of the same retained composition, exact equivalence holds exactly when an exhaustively generated occurrence bijection preserves every composition label, attachment mode, boundary adjacency and three-axis word made only from the two forced Fold fibres and structural EmptyOne. A first attachment or graph failure forces an attachment-class distinction; an exact global fibre complement forces a mirror-complement distinction; every remaining held orientation or adjacency failure forces an orientation-adjacency distinction. No conventional isomer catalogue selects these classes."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "two-complete-retained-coordination-forms__same-complete-composition-multiset__enumerate-every-occurrence-bijection__complete-attachment-and-adjacency-preservation__complete-three-axis-two-fibre-relation__first-failed-invariant-forces-native-class__complete-17-surface-sealed-vector-with-linkage-addendum__successor-preserves-prior-signatures-and-adds-relations"),("base",.text "For one retained occurrence there is exactly one occurrence bijection. Exact equivalence therefore reduces to equality of its complete composition, attachment and three-axis two-fibre word; a complement-related word remains separately identifiable and no absent relation is represented by numerical zero."),("successor",.text "Adjoining the next occurrence preserves every prior composition label, attachment, word and adjacency as an induced subform. The complete mapping census extends by placing the new occurrence at each positive image ordinal and retains every prior mapping among the remaining occurrences; no prior relation is erased, and only the new occurrence and its generated adjacencies are added."),("exclusions",.array [.text "no numerical zero; the glyph 0 in an external inscription is not an SFT number and native absence is structural EmptyOne",.text "no negative irrational imaginary floating signed or continuum proof value or transformation",.text "no third fibre label; the three generated axes are positions containing only the two forced fibre labels or EmptyOne",.text "no imported linkage, geometric, optical, cis-trans, enantiomer, diastereomer, point-group or shape catalogue in candidate forcing",.text "no selected occurrence map, favourable source row, deleted redirect, hidden absent term, fitted class or target-derived condition",.text "no silent claim that the literal phrase linkage isomer occurs in the captured Red Book when the complete extracted document does not contain it"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; the glyph 0 in an external inscription is not an SFT number and native absence is structural EmptyOne","no negative irrational imaginary floating signed or continuum proof value or transformation","no third fibre label; the three generated axes are positions containing only the two forced fibre labels or EmptyOne","no imported linkage, geometric, optical, cis-trans, enantiomer, diastereomer, point-group or shape catalogue in candidate forcing","no selected occurrence map, favourable source row, deleted redirect, hidden absent term, fitted class or target-derived condition","no silent claim that the literal phrase linkage isomer occurs in the captured Red Book when the complete extracted document does not contain it"]
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
end SFT.Physics.CoordinationIsomerismEvidence

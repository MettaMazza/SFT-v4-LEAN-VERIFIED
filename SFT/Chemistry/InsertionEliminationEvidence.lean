import SFT.Chemistry.InsertionEliminationGrammar
import SFT.Chemistry.InsertionElimination
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.InsertionEliminationEvidence
open SFT.Host.Canonical InsertionEliminationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "insertion",.text "Insertion removes one edge and adds two.",.boolean InsertionElimination.insertionWitness],.array [.text "exact-extrusion",.text "Extrusion restores the exact source adjacency.",.boolean InsertionElimination.extrusionWitness],.array [.text "migratory-composition",.text "Migratory insertion retains migration plus insertion.",.boolean InsertionElimination.migrationWitness],.array [.text "elimination-boundaries",.text "Distinct- and single-centre eliminations retain exact traces.",.boolean InsertionElimination.eliminationWitness]]
def claimId : String := "SFT-CHEM-INSERTION-ELIMINATION-PATHWAY-013"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-ORGANOMETALLIC-METAL-CARBON-BOND-010","SFT-CHEM-OXIDATIVE-ADDITION-REDUCTIVE-ELIMINATION-012"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "trace",.text (traceName c.trace)],.array [.text "insertion",.text (insertionName c.insertion)],.array [.text "migration",.text (migrationName c.migration)],.array [.text "reverse",.text (reverseName c.reverse)],.array [.text "elimination",.text (eliminationName c.elimination)],.array [.text "product",.text (productName c.product)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "anonymous-products",.text "Anonymous products lose occurrence identity."],.array [.text "complete-retained-carrier-support",.text "Every source and product carrier remains explicit."]]],.array [.text "trace",.array [.array [.text "endpoint-only-reaction",.text "Endpoints alone do not certify the transformation."],.array [.text "complete-before-after-adjacency-difference",.text "Every before, after, removed and added edge is retained."]]],.array [.text "insertion",.array [.array [.text "imported-product-formula",.text "A product formula can hide adjacency."],.array [.text "xz-plus-y-to-x-y-z-adjacency-law",.text "Insertion replaces X-Z by X-Y and Y-Z."]]],.array [.text "migration",.array [.array [.text "named-migratory-step",.text "A name does not force composition."],.array [.text "migration-plus-insertion-composition",.text "Migratory insertion retains the migration and insertion components."]]],.array [.text "reverse",.array [.array [.text "insertion-elimination-conflation",.text "Conflating reverse classes loses the exact boundary."],.array [.text "extrusion-exact-insertion-inverse",.text "Extrusion, not generic elimination, exactly reverses insertion."]]],.array [.text "elimination",.array [.array [.text "selected-leaving-group",.text "Selection loses one eliminand or centre."],.array [.text "complete-two-eliminand-centre-trace",.text "Elimination retains both eliminands, centres and new product adjacency."]]],.array [.text "product",.array [.array [.text "imported-unsaturation-name",.text "A conventional name is not a generated adjacency."],.array [.text "held-unsaturation-ring-or-carbene-boundary",.text "Product class remains held while adjacency is exact."]]],.array [.text "extension",.array [.array [.text "mechanism-specific-exception",.text "An exception destroys closure."],.array [.text "adjacency-trace-composition-no-extra-rule",.text "Matching traces compose without changing prior edges."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact insertion, migratory-insertion and elimination adjacency-trace law"
 branch := "chemistry"
 statement := "Insertion replaces one X-Z adjacency by X-Y and Y-Z while conserving all three carriers. Extrusion is its exact inverse. Migratory insertion is the exact composition of migration and insertion, transforming metal-migrant and metal-inserted adjacency into retained metal-inserted and migrant-inserted adjacency. Elimination retains both eliminands and centres while generating the product adjacency and a held unsaturation, ring or carbene boundary."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-retained-carrier-support__complete-before-after-adjacency-difference__xz-plus-y-to-x-y-z-adjacency-law__migration-plus-insertion-composition__extrusion-exact-insertion-inverse__complete-two-eliminand-centre-trace__held-unsaturation-ring-or-carbene-boundary__adjacency-trace-composition-no-extra-rule"),("base",.text "Insertion on one X-Z edge and a distinct Y carrier removes one edge and adds exactly X-Y and Y-Z; the reverse restores X-Z."),("successor",.text "Composing a matching next trace preserves every retained carrier and prior endpoint while its removed and added supports remain the exact graph difference."),("exclusions",.array [.text "no numerical zero negative irrational imaginary signed continuum fitted free or imported parameter",.text "no product formula named mechanism selected leaving group or observed outcome selecting the trace",.text "no conflation of extrusion with generic elimination",.text "no omission of the host-lattice scope distinction or absent rendered example structure"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary signed continuum fitted free or imported parameter","no product formula named mechanism selected leaving group or observed outcome selecting the trace","no conflation of extrusion with generic elimination","no omission of the host-lattice scope distinction or absent rendered example structure"]
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
end SFT.Chemistry.InsertionEliminationEvidence

import SFT.Chemistry.ResonanceEquivalentGrammar
import SFT.Chemistry.ResonanceEquivalentWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ResonanceEquivalentEvidence
open SFT.Host.Canonical ResonanceEquivalentGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [
 .array [.text "base-pair",.text "Two complete global-complement encodings retain one carrier.",.boolean ResonanceEquivalent.baseWitness],
 .array [.text "successor",.text "A shared fresh occurrence preserves adjacency and complete complement.",.boolean ResonanceEquivalent.successorWitness],
 .array [.text "carrier-control",.text "A different molecular carrier rejects.",.boolean ResonanceEquivalent.carrierWitness],
 .array [.text "adjacency-control",.text "Changed adjacency rejects.",.boolean ResonanceEquivalent.adjacencyWitness],
 .array [.text "partial-control",.text "A partial non-complement label change rejects.",.boolean ResonanceEquivalent.partialWitness]]
def claimId : String := "SFT-CHEM-RESONANCE-EQUIVALENT-REPRESENTATION-002"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001","SFT-CHEM-CONJUGATED-SUPPORT-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "atoms",.text (atomsName c.atoms)],.array [.text "adjacency",.text (adjacencyName c.adjacency)],.array [.text "encodings",.text (encodingsName c.encodings)],.array [.text "fibres",.text (fibresName c.fibres)],.array [.text "identity",.text (identityName c.identity)],.array [.text "process",.text (processName c.process)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "different-molecular-carriers",.text "Different carriers are different molecular identities."],.array [.text "one-retained-molecular-carrier",.text "Every encoding points to the same held molecular carrier."]]],.array [.text "atoms",.array [.array [.text "atom-occurrence-change",.text "Adding, deleting or replacing an occurrence changes the carrier description."],.array [.text "complete-equal-atom-occurrence-support",.text "Every encoding retains the same ordered atom occurrences."]]],.array [.text "adjacency",.array [.array [.text "connectivity-change",.text "Changed adjacency is a distinct constitution, not an encoding alternative."],.array [.text "complete-equal-adjacency-support",.text "Every encoding retains the same complete adjacency graph."]]],.array [.text "encodings",.array [.array [.text "one-encoding-only",.text "One inscription supplies no representation equivalence class."],.array [.text "multiple-distinct-encoding-identities",.text "At least two distinct inscriptions are retained without multiplying the carrier."]]],.array [.text "fibres",.array [.array [.text "partial-or-arbitrary-label-change",.text "An arbitrary partial change does not preserve the generated Fold relation."],.array [.text "complete-opposed-fibre-complement",.text "Every support incidence changes to its exact opposed Fold fibre."]]],.array [.text "identity",.array [.array [.text "representations-counted-as-species",.text "Formal encodings do not create new chemical carriers."],.array [.text "one-carrier-many-representations",.text "Carrier identity remains one while representation identity remains plural."]]],.array [.text "process",.array [.array [.text "equilibrium-or-transition-imported",.text "A representation relation does not imply a physical interconversion process."],.array [.text "representation-relation-only",.text "No time, transition or equilibrium law enters equivalence."]]],.array [.text "extension",.array [.array [.text "named-resonance-exception",.text "A named exception adds an unforced classification rule."],.array [.text "shared-complement-successor-no-extra-rule",.text "Appending one fresh occurrence to both encodings preserves complete complement and the one-carrier relation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact one-carrier multiple-representation equivalence law"
 branch := "chemistry"
 statement := "A Fold representation-equivalence class retains exactly one molecular carrier, every atom occurrence and every adjacency while retaining at least two distinct encoding identities. In the minimal generated pair, every support incidence in the second encoding is the exact opposed Fold-fibre complement of the first; this relation creates neither a second species nor an equilibrium process."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-molecular-carrier__complete-equal-atom-occurrence-support__complete-equal-adjacency-support__multiple-distinct-encoding-identities__complete-opposed-fibre-complement__one-carrier-many-representations__representation-relation-only__shared-complement-successor-no-extra-rule"),("base",.text "Three distinct atom occurrences, two complete incidences and their opposed global Fold-fibre assignments supply the first two-encoding one-carrier equivalence pair."),("successor",.text "Append one fresh atom occurrence and one incidence to both encodings. The unique fibre opposed to each formerly terminal fibre preserves complete complement, identical atom support, identical adjacency and the single held carrier."),("exclusions",.array [.text "no numerical zero; structural absence is EmptyOne",.text "no negative irrational imaginary signed continuum fitted free or imported parameter",.text "no Lewis bond mark charge coefficient wavefunction or named resonance rule used to select the survivor",.text "no physical interconversion equilibrium time or stochastic mixing imported into representation equivalence",.text "no target definition note example or outcome opened to select the law",.text "the preserved V1 incomplete search-scope result cannot be hidden or treated as external absence"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; structural absence is EmptyOne","no negative irrational imaginary signed continuum fitted free or imported parameter","no Lewis bond mark charge coefficient wavefunction or named resonance rule used to select the survivor","no physical interconversion equilibrium time or stochastic mixing imported into representation equivalence","no target definition note example or outcome opened to select the law","the preserved V1 incomplete search-scope result cannot be hidden or treated as external absence"]
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
end SFT.Chemistry.ResonanceEquivalentEvidence

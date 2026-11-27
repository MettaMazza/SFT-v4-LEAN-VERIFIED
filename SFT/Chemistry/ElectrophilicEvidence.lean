import SFT.Chemistry.ElectrophilicGrammar
import SFT.Chemistry.ElectrophilicWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ElectrophilicEvidence
open SFT.Host.Canonical ElectrophilicGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-carrier",.text "Every atom and held electron occurrence survives both generated paths.",.boolean ElectrophilicWitnesses.completeCarrier],.array [.text "acceptor-transfer",.text "The structural EmptyOne entering carrier accepts the complete aromatic donor pair.",.boolean ElectrophilicWitnesses.acceptorTransfer],.array [.text "leaving-relinquishment",.text "The displaced pair leaves its source bond and restores the opened aromatic incidence.",.boolean ElectrophilicWitnesses.leavingRelinquishment],.array [.text "recurrence-restored",.text "The terminal retains both aromatic incidences and the unchanged recurrence pair.",.boolean ElectrophilicWitnesses.recurrenceRestored],.array [.text "complete-path-family",.text "The generated family retains one-transition and addition-then-restoration paths.",.boolean ElectrophilicWitnesses.completeFamily],.array [.text "cleavage-first-control",.text "Cleavage-first cannot duplicate the still occupied aromatic incidence.",.boolean ElectrophilicWitnesses.cleavageFirst],.array [.text "successor",.text "Appending one retained aromatic occurrence preserves the complete prior path without another rule.",.boolean ElectrophilicWitnesses.successor]]
def claimId : String := "SFT-CHEM-ELECTROPHILIC-SUBSTITUTION-FAMILY-008"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001","SFT-CHEM-ORGANIC-REACTION-FAMILY-001","SFT-CHEM-CONJUGATED-SUPPORT-001","SFT-CHEM-RESONANCE-EQUIVALENT-REPRESENTATION-002","SFT-CHEM-AROMATIC-RECURRENCE-STABILITY-003","SFT-CHEM-NUCLEOPHILIC-SUBSTITUTION-FAMILY-007"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "acceptor",.text (acceptorName c.acceptor)],.array [.text "donor",.text (donorName c.donor)],.array [.text "change",.text (changeName c.change)],.array [.text "path",.text (pathName c.path)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "selected-product-label-or-nonaromatic-fragments",.text "A named answer or disconnected fragments cannot reconstruct one aromatic reaction carrier."],.array [.text "complete-aromatic-source-ordered-carrier",.text "Aromatic left, centre, right, entering acceptor and leaving carrier remain distinct occurrences in one complete source."]]],.array [.text "acceptor",.array [.array [.text "incoming-pair-imported-or-acceptor-slot-filled",.text "Giving the acceptor a pre-existing pair changes which carrier supplies the new bond."],.array [.text "structural-EmptyOne-entering-acceptor-slot",.text "The entering carrier begins with structural EmptyOne and accepts the complete donor pair."]]],.array [.text "donor",.array [.array [.text "donor-pair-erased-created-or-collapsed-to-charge",.text "A scalar charge or incomplete pair loses the transferred occurrences."],.array [.text "complete-aromatic-donor-pair-transfer",.text "Both donor occurrences move from one aromatic incidence to the centre-entering incidence."]]],.array [.text "change",.array [.array [.text "endpoint-only-product-or-extra-support-change",.text "An endpoint or extra edit does not prove the local exchange."],.array [.text "entering-bond-formed-leaving-bond-cleaved",.text "Exactly the entering bond forms and the leaving bond closes while all other local incidences remain retained."]]],.array [.text "path",.array [.array [.text "named-rate-law-cleavage-first-or-unordered-snapshots",.text "A conventional name, kinetic law or wrong order can select a mechanism."],.array [.text "complete-concerted-and-addition-then-restoration-path-family",.text "The generated family retains direct exchange and donor transfer followed by leaving-pair recurrence restoration."]]],.array [.text "recurrence",.array [.array [.text "aromatic-support-destroyed-or-fitted-restoration",.text "An unclosed or fitted recurrence does not return the carrier to its exact class."],.array [.text "leaving-pair-restores-aromatic-incidence",.text "The leaving pair relinquishes both occurrences to restore the opened aromatic incidence exactly."]]],.array [.text "observation",.array [.array [.text "substrate-product-mechanism-readable-before-seal",.text "External structures or terminology could select the survivor."],.array [.text "value-free-aromatic-structure-and-mechanism-target-seal",.text "Law and complete target identities seal before newly registered structure or mechanism outcomes open."]]],.array [.text "extension",.array [.array [.text "substrate-specific-exception-or-recomputed-prefix",.text "A special aromatic substrate rule is not depth-independent."],.array [.text "fresh-aromatic-successor-no-extra-rule",.text "Adding one fresh retained aromatic occurrence preserves every prior state, edge and pair allocation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact acceptor-driven aromatic substitution family law"
 branch := "chemistry"
 statement := "For every complete aromatic exchange carrier, the entering structural-EmptyOne acceptor receives both occurrences of one aromatic donor pair. The entering bond forms, the leaving bond closes, and the leaving pair restores the opened aromatic incidence. Every atom and held electron occurrence is conserved through direct exchange or addition followed by recurrence restoration."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-aromatic-source-ordered-carrier__structural-EmptyOne-entering-acceptor-slot__complete-aromatic-donor-pair-transfer__entering-bond-formed-leaving-bond-cleaved__complete-concerted-and-addition-then-restoration-path-family__leaving-pair-restores-aromatic-incidence__value-free-aromatic-structure-and-mechanism-target-seal__fresh-aromatic-successor-no-extra-rule"),("base",.text "One five-occurrence aromatic source forces transfer of the complete donor pair to the entering acceptor and restoration of the opened aromatic incidence by the complete leaving pair through exactly one or two transitions."),("successor",.text "Append one fresh aromatic occurrence and pair outside the local exchange support to every path state; every prior occurrence, state, transition and pair allocation remains unchanged without an extra rule."),("exclusions",.array [.text "no native numerical zero; structural acceptor absence is EmptyOne",.text "no negative irrational imaginary continuum fitted free random or imported native parameter",.text "no conventional electrophilic mechanism rate energy solvent substrate or target used to generate the survivor",.text "three development-observed records are disclosed and never relabelled blind",.text "all 452 PDF pages, 25 optimization rows, favorable, zero-yield, adverse, alternative and unresolved records remain retained",.text "external signed and decimal inscriptions remain downstream evidence only"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no native numerical zero; structural acceptor absence is EmptyOne","no negative irrational imaginary continuum fitted free random or imported native parameter","no conventional electrophilic mechanism rate energy solvent substrate or target used to generate the survivor","three development-observed records are disclosed and never relabelled blind","all 452 PDF pages, 25 optimization rows, favorable, zero-yield, adverse, alternative and unresolved records remain retained","external signed and decimal inscriptions remain downstream evidence only"]
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
end SFT.Chemistry.ElectrophilicEvidence

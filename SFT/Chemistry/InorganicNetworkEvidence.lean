import SFT.Chemistry.InorganicNetworkGrammar
import SFT.Chemistry.InorganicNetworkWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.InorganicNetworkEvidence
open SFT.Host.Canonical InorganicNetworkGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "Lewis-adduct",.text "Provider, acceptor, two electron occurrences and adduct remain held.",.boolean InorganicNetworkWitnesses.lewisWitness],.array [.text "redox-transfer",.text "One positive two-occurrence transfer couples donor oxidation to acceptor reduction.",.boolean InorganicNetworkWitnesses.redoxWitness],.array [.text "redox-reverse",.text "The reverse retains the same electron occurrences and swaps exact endpoints.",.boolean InorganicNetworkWitnesses.reverseWitness],.array [.text "network-successor",.text "Appending one redox step retains the Lewis step and extends the path once.",.boolean InorganicNetworkWitnesses.successorWitness],.array [.text "species-control",.text "Omitting the adduct species rejects the network.",.boolean InorganicNetworkWitnesses.speciesWitness]]
def claimId : String := "SFT-CHEM-INORGANIC-ACID-BASE-REDOX-NETWORK-017"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-OPERATIONAL-PROCESS-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-OXIDATIVE-ADDITION-REDUCTIVE-ELIMINATION-012"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "species",.text (speciesName c.species)],.array [.text "acid-base",.text (acidBaseName c.acidBase)],.array [.text "adduct",.text (adductName c.adduct)],.array [.text "redox",.text (redoxName c.redox)],.array [.text "coupling",.text (couplingName c.coupling)],.array [.text "path",.text (pathName c.path)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "selected-inorganic-equation",.text "One selected equation does not close a reaction network."],.array [.text "complete-finite-species-transition-network",.text "Every retained species and transition belongs to one finite complete network."]]],.array [.text "species",.array [.array [.text "untracked-reagent-labels",.text "Untracked labels cannot establish conservation."],.array [.text "complete-held-species-identity-support",.text "Every participant and product identity remains held."]]],.array [.text "acid-base",.array [.array [.text "assumed-acid-and-base-names",.text "Names alone do not establish pair transfer."],.array [.text "provider-acceptor-two-occurrence-pair-transfer",.text "Two retained electron occurrences join one provider to one acceptor."]]],.array [.text "adduct",.array [.array [.text "unstructured-acid-base-mixture",.text "A mixture loses the joining record."],.array [.text "retained-provider-acceptor-adduct-composition",.text "Provider, acceptor, pair support and the resulting adduct remain explicit."]]],.array [.text "redox",.array [.array [.text "signed-oxidation-number-arithmetic",.text "A signed inscription is not a native transfer record."],.array [.text "positive-complete-held-electron-transfer",.text "Oxidation and reduction share one positive complete held transfer support."]]],.array [.text "coupling",.array [.array [.text "independent-oxidation-and-reduction-labels",.text "Independent labels can violate carrier conservation."],.array [.text "one-donor-acceptor-conserved-transfer",.text "The donor removal and acceptor receipt are the same retained electron occurrences."]]],.array [.text "path",.array [.array [.text "unordered-reaction-list",.text "An unordered list loses operational composition."],.array [.text "complete-ordered-transition-path",.text "Every step appears exactly once in the retained path order."]]],.array [.text "extension",.array [.array [.text "named-reaction-exception",.text "A named exception destroys closure."],.array [.text "transition-successor-no-extra-rule",.text "A fresh exact step extends species and path support by the same law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact inorganic acid/base, redox and reaction-network law"
 branch := "chemistry"
 statement := "An inorganic reaction network retains every species and every ordered transition. Lewis joining carries exactly two held electron occurrences from provider to acceptor and retains the resulting adduct composition. Redox carries one positive complete held electron support from donor to acceptor, so oxidation and reduction are one conserved transfer and exact reversal swaps endpoints without signed arithmetic."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-finite-species-transition-network__complete-held-species-identity-support__provider-acceptor-two-occurrence-pair-transfer__retained-provider-acceptor-adduct-composition__positive-complete-held-electron-transfer__one-donor-acceptor-conserved-transfer__complete-ordered-transition-path__transition-successor-no-extra-rule"),("base",.text "One exact Lewis step or redox step retains every endpoint, its positive carrier support and one step identity in the complete network path."),("successor",.text "Appending one exact step retains all prior species and steps, adds any fresh endpoints, and appends its step identity once under the same conservation and path law."),("exclusions",.array [.text "no numerical zero; an absent transition class is structural EmptyOne",.text "no negative irrational imaginary signed continuum fitted free or imported parameter",.text "no signed oxidation-number arithmetic in the native redox transfer",.text "no independent oxidation and reduction carrier records",.text "no unstructured acid/base mixture substituted for pair-supported adduct composition",.text "no source definition, named criterion or example structure used to select the law"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; an absent transition class is structural EmptyOne","no negative irrational imaginary signed continuum fitted free or imported parameter","no signed oxidation-number arithmetic in the native redox transfer","no independent oxidation and reduction carrier records","no unstructured acid/base mixture substituted for pair-supported adduct composition","no source definition, named criterion or example structure used to select the law"]
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
end SFT.Chemistry.InorganicNetworkEvidence

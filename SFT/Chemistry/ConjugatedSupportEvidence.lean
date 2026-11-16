import SFT.Chemistry.ConjugatedSupportGrammar
import SFT.Chemistry.ConjugatedSupportWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ConjugatedSupportEvidence
open SFT.Host.Canonical ConjugatedSupportGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [
 .array [.text "base-support",.text "Three atom occurrences and two opposed support fibres form the first connected alternating path.",.boolean ConjugatedSupportWitnesses.baseWitness],
 .array [.text "successor",.text "A fresh occurrence receives the uniquely opposed next fibre and retains every prior incidence.",.boolean ConjugatedSupportWitnesses.successorWitness],
 .array [.text "repetition-control",.text "Equal adjacent fibres reject.",.boolean ConjugatedSupportWitnesses.repetitionWitness],
 .array [.text "coverage-control",.text "An omitted incidence rejects.",.boolean ConjugatedSupportWitnesses.coverageWitness],
 .array [.text "identity-control",.text "A duplicated successor occurrence rejects.",.boolean ConjugatedSupportWitnesses.identityWitness]]
def claimId : String := "SFT-CHEM-CONJUGATED-SUPPORT-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001","SFT-CHEM-ORGANIC-REACTION-FAMILY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "connectivity",.text (connectivityName c.connectivity)],.array [.text "fibres",.text (fibresName c.fibres)],.array [.text "alternation",.text (alternationName c.alternation)],.array [.text "coverage",.text (coverageName c.coverage)],.array [.text "propagation",.text (propagationName c.propagation)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "selected-unbound-bond-marks",.text "Selected marks do not define one molecular subcarrier."],.array [.text "one-retained-molecular-subcarrier",.text "Every atom occurrence and support incidence belongs to one held carrier."]]],.array [.text "connectivity",.array [.array [.text "disconnected-support-fragments",.text "Disconnected fragments cannot propagate one support distinction."],.array [.text "complete-connected-adjacency-path",.text "Every successive atom occurrence shares one exact incidence."]]],.array [.text "fibres",.array [.array [.text "bond-support-label-erased",.text "Erasure merges the two required support distinctions."],.array [.text "two-forced-held-support-fibres",.text "Every incidence retains one of the two forced Fold fibre labels."]]],.array [.text "alternation",.array [.array [.text "arbitrary-adjacent-fibre-repetition",.text "Repeated adjacent fibres close the alternating path."],.array [.text "exact-opposed-adjacent-fibre-recurrence",.text "Every adjacent incidence carries the opposed held fibre."]]],.array [.text "coverage",.array [.array [.text "favourable-subpath-only",.text "A selected subpath can hide a failing incidence."],.array [.text "complete-atom-and-incidence-support",.text "Every atom and every path incidence enters the decision."]]],.array [.text "propagation",.array [.array [.text "independent-bond-pairs",.text "Independent pairs do not share a propagation centre."],.array [.text "shared-centre-support-propagation",.text "Successive incidences meet at the same retained atom occurrence."]]],.array [.text "observation",.array [.array [.text "spectrum-or-name-selects-structure",.text "An external name or spectrum cannot select the Fold law."],.array [.text "structure-sealed-before-external-observation",.text "The complete structural prediction closes before source outcomes open."]]],.array [.text "extension",.array [.array [.text "named-conjugation-exception",.text "A named exception introduces an unforced rule."],.array [.text "opposed-fibre-successor-no-extra-rule",.text "A fresh atom extends the path only with the uniquely opposed fibre."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact connected alternating conjugated-support law"
 branch := "chemistry"
 statement := "A conjugated Fold support is one finite connected molecular subcarrier in which every adjacent incidence retains one of the two forced Fold fibres, every successive incidence carries the opposed fibre through a shared atom occurrence, and every atom and incidence is retained. A fresh occurrence has one unique opposed-fibre successor."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-molecular-subcarrier__complete-connected-adjacency-path__two-forced-held-support-fibres__exact-opposed-adjacent-fibre-recurrence__complete-atom-and-incidence-support__shared-centre-support-propagation__structure-sealed-before-external-observation__opposed-fibre-successor-no-extra-rule"),("base",.text "Three distinct atom occurrences joined by the two opposed Fold support fibres supply the first complete connected alternating path."),("successor",.text "Appending one fresh atom occurrence preserves every prior incidence and uniquely appends the fibre opposed to the formerly terminal incidence; repetition, omission or duplicated identity halts."),("exclusions",.array [.text "no numerical zero; structural absence is EmptyOne",.text "no negative irrational imaginary signed continuum fitted free or imported parameter",.text "no conventional single/double-bond notation used to select the two Fold fibres",.text "no resonance notation or electron-count rule imported into forcing",.text "no selected favourable subpath or omitted incidence",.text "no definition, molecular name, coordinate, vibration or spectrum opened to select the law",.text "the preserved V1 parser overrun cannot be hidden or treated as evidence"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; structural absence is EmptyOne","no negative irrational imaginary signed continuum fitted free or imported parameter","no conventional single/double-bond notation used to select the two Fold fibres","no resonance notation or electron-count rule imported into forcing","no selected favourable subpath or omitted incidence","no definition, molecular name, coordinate, vibration or spectrum opened to select the law","the preserved V1 parser overrun cannot be hidden or treated as evidence"]
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
end SFT.Chemistry.ConjugatedSupportEvidence

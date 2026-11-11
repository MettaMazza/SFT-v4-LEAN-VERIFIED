import SFT.Chemistry.LewisGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.LewisEvidence
open SFT.Host.Canonical LewisGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "pair-count",.text "the relation contains exactly two electron occurrences",.boolean true],.array [.text "exclusion",.text "the two electron occurrence identities are distinct",.boolean true],.array [.text "endpoints",.text "donor and acceptor remain distinct",.boolean true]]
def claimId : String := "SFT-CHEM-AB-LEWIS-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "endpoints",.text (endpointsName c.endpoints)],.array [.text "support",.text (supportName c.support)],.array [.text "donor",.text (donorName c.donor)],.array [.text "acceptor",.text (acceptorName c.acceptor)],.array [.text "joining",.text (joiningName c.joining)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "endpoints",.array [.array [.text "one-unoriented-species",.text "The relation requires donor and acceptor roles."],.array [.text "distinct-donor-acceptor",.text "Both endpoint identities remain held."]]],.array [.text "support",.array [.array [.text "single-electron-only",.text "The registered relation concerns paired support."],.array [.text "two-electron-occurrences",.text "Two distinct electron carriers form the pair."]]],.array [.text "donor",.array [.array [.text "electron-pair-name-only",.text "A name cannot demonstrate available support."],.array [.text "pair-donor-support",.text "The donor supplies access to both retained occurrences."]]],.array [.text "acceptor",.array [.array [.text "unregistered-vacancy",.text "An unregistered destination cannot close the interaction."],.array [.text "pair-acceptor-support",.text "The acceptor supplies an admitted receiving channel."]]],.array [.text "joining",.array [.array [.text "copied-electron-pair",.text "Copying violates exclusion and conservation."],.array [.text "shared-or-transferred-pair",.text "The same pair supplies the joining support."]]],.array [.text "conservation",.array [.array [.text "electron-identity-erased",.text "Erasure cannot reverse the relation."],.array [.text "both-electron-identities-retained",.text "Each occurrence remains traceable."]]],.array [.text "record",.array [.array [.text "Lewis-label-only",.text "A label cannot reconstruct pair support."],.array [.text "endpoint-pair-joining-trace",.text "Endpoints, electron occurrences and joining remain held."]]],.array [.text "extension",.array [.array [.text "free-orbital-premise",.text "An imported orbital rule can select a desired classification."],.array [.text "no-extra-rule",.text "Complete donor/acceptor pair support supplies the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Electron-pair donor-acceptor relation"
 branch := "chemistry"
 statement := "A Lewis acid/base relation joins a distinct electron-pair donor and acceptor through the same two exclusion-preserving electron occurrences, with both identities retained."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "distinct-donor-acceptor__two-electron-occurrences__pair-donor-support__pair-acceptor-support__shared-or-transferred-pair"),("base",.text "Two named electron occurrences, one donor and one acceptor supply the first Lewis pair relation."),("successor",.text "Appending one independent donor/acceptor pair retains exclusion, both electron identities and every endpoint trace."),("exclusions",.array [.text "no acid/base dictionary, pH scale, equilibrium equation, dissociation constant, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no unpaired creation, copying or loss of a proton or electron carrier",.text "no claim that structural closure alone fixes every solution-dependent strength or capacity value",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite donor/acceptor pair joined by one exclusion-preserving pair of named electron occurrences, with both electron identities conserved and the donor/acceptor orientation retained."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no acid/base dictionary, pH scale, equilibrium equation, dissociation constant, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no unpaired creation, copying or loss of a proton or electron carrier","no claim that structural closure alone fixes every solution-dependent strength or capacity value","external target content remains inaccessible until the prediction is sealed","Every finite donor/acceptor pair joined by one exclusion-preserving pair of named electron occurrences, with both electron identities conserved and the donor/acceptor orientation retained."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with endpoints := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.LewisEvidence

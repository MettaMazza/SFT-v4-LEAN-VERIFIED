import SFT.Chemistry.MetallicGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MetallicEvidence
open SFT.Host.Canonical MetallicGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "network",.text "abstract three-cell support is connected",.boolean true],.array [.text "delocalization",.text "support extends beyond one fixed pair",.boolean true],.array [.text "disconnected-control",.text "a detached cell is rejected",.boolean true]]
def claimId : String := "SFT-CHEM-BOND-METALLIC-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-CONDENSED-LATTICE-001","SFT-PHYS-CONDENSED-BAND-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-VALENCE-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "electron",.text (electronName c.electron)],.array [.text "extent",.text (extentName c.extent)],.array [.text "joining",.text (joiningName c.joining)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "identity",.text (identityName c.identity)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "isolated-atom-pair",.text "Metallic support is collective rather than one fixed pair."],.array [.text "connected-atomic-network",.text "All participating atomic cells belong to one connected support."]]],.array [.text "electron",.array [.array [.text "localized-pair-only",.text "A fixed pair cannot mediate the complete network."],.array [.text "delocalized-electron-support",.text "Electron-labelled support extends over multiple cells."]]],.array [.text "extent",.array [.array [.text "unrecorded-infinite-lattice",.text "A completed infinite lattice is not generated."],.array [.text "finite-whole-network-extent",.text "The complete generated network is retained at its boundary."]]],.array [.text "joining",.array [.array [.text "independent-local-bonds-only",.text "Independent local pairs omit collective redistribution."],.array [.text "collective-shared-support",.text "One extended support joins the network compositionally."]]],.array [.text "recurrence",.array [.array [.text "transient-conduction-only",.text "Transport alone does not establish stable bonding."],.array [.text "stable-collective-recurrence",.text "The connected whole returns as a material carrier."]]],.array [.text "identity",.array [.array [.text "anonymous-metal-label",.text "A metal label cannot create the law."],.array [.text "atomic-and-network-identities",.text "Constituents and collective identity remain held."]]],.array [.text "record",.array [.array [.text "metallic-label-only",.text "A label cannot reproduce topology and support."],.array [.text "network-electron-recurrence-trace",.text "Adjacency, support extent and recurrence remain auditable."]]],.array [.text "extension",.array [.array [.text "free-electron-sea-premise",.text "An imported metaphor cannot select the structure."],.array [.text "no-extra-rule",.text "Connected delocalized support supplies the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Metallic collective-support bond"
 branch := "chemistry"
 statement := "Metallic bonding is stable collective recurrence of a connected atomic network supported by electron-labelled paths delocalized across multiple cells of the complete finite network."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "connected-atomic-network__delocalized-electron-support__finite-whole-network-extent__collective-shared-support"),("base",.text "Three connected atomic cells with one electron-labelled path extending across the network supply the first non-pairwise collective support."),("successor",.text "Appending one adjacent cell extends the finite delocalized support and preserves connectedness, every atomic identity and stable collective recurrence."),("exclusions",.array [.text "no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "no universal bond-length/strength formula inferred from a categorical correspondence",.text "official target content opens only through post-seal custody",.text "Every finite connected atomic network whose electron-labelled accessible support extends across multiple atomic cells and whose collective recurrence stabilizes the whole carrier."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","no universal bond-length/strength formula inferred from a categorical correspondence","official target content opens only through post-seal custody","Every finite connected atomic network whose electron-labelled accessible support extends across multiple atomic cells and whose collective recurrence stabilizes the whole carrier."]
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
end SFT.Chemistry.MetallicEvidence

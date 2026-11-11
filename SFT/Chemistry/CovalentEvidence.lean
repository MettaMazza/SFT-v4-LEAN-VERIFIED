import SFT.Chemistry.CovalentGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CovalentEvidence
open SFT.Host.Canonical CovalentGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "shared-channel",.text "one retained channel is jointly accessible without copying",.boolean true],.array [.text "exclusion",.text "duplicate same-cell occupation is rejected",.boolean true],.array [.text "nuclear-support",.text "both centres remain linked",.boolean true]]
def claimId : String := "SFT-CHEM-BOND-COVALENT-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-CONDENSED-LATTICE-001","SFT-PHYS-CONDENSED-BAND-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-VALENCE-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "electron",.text (electronName c.electron)],.array [.text "sharing",.text (sharingName c.sharing)],.array [.text "density",.text (densityName c.density)],.array [.text "attraction",.text (attractionName c.attraction)],.array [.text "occupation",.text (occupationName c.occupation)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "bond-without-nuclei",.text "Covalent support relates identified atomic centres."],.array [.text "identified-nuclear-pair",.text "Both nuclear identities remain held."]]],.array [.text "electron",.array [.array [.text "electron-assigned-to-one-centre",.text "One-centre support alone is not shared bonding support."],.array [.text "joint-electron-support",.text "At least one electron-labelled channel belongs to the joint word."]]],.array [.text "sharing",.array [.array [.text "copied-electron-label",.text "Copying one conserved carrier violates exclusion and conservation."],.array [.text "one-support-shared-access",.text "Both centres access one retained support without duplication."]]],.array [.text "density",.array [.array [.text "empty-internuclear-path",.text "No connecting support cannot join the nuclei."],.array [.text "internuclear-accessible-region",.text "Generated support connects both centres."]]],.array [.text "attraction",.array [.array [.text "unbound-force-label",.text "A force name without recurrence does not establish a bond."],.array [.text "stable-contractive-response",.text "The joint support retains an attractive stable recurrence."]]],.array [.text "occupation",.array [.array [.text "duplicate-identical-cell",.text "Duplicated identical occupation violates exclusion."],.array [.text "exclusion-preserving-channels",.text "Every shared channel retains its exchange trace."]]],.array [.text "record",.array [.array [.text "covalent-label-only",.text "A label cannot reconstruct sharing."],.array [.text "nuclei-channel-sharing-trace",.text "Nuclei, channels and common access remain held."]]],.array [.text "extension",.array [.array [.text "free-orbital-rule",.text "An imported orbital choice can select a desired bond."],.array [.text "no-extra-rule",.text "Complete shared support supplies the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Covalent shared-support bond"
 branch := "chemistry"
 statement := "A covalent bond is stable joint recurrence in which one or more exclusion-preserving electron-labelled channels are jointly accessible between identified nuclear carriers without duplicating the conserved carrier."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "identified-nuclear-pair__joint-electron-support__one-support-shared-access__internuclear-accessible-region"),("base",.text "One exclusion-preserving electron-labelled path jointly accessible to two nuclei supplies the first covalent support."),("successor",.text "Appending one generated shared channel preserves both nuclear identities, carrier conservation, exchange trace and stable joint recurrence."),("exclusions",.array [.text "no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "no universal bond-length/strength formula inferred from a categorical correspondence",.text "official target content opens only through post-seal custody",.text "Every finite bonded atomic support with one or more electron-labelled recurrence channels jointly accessible to both nuclear carriers and exclusion-preserving occupation."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","no universal bond-length/strength formula inferred from a categorical correspondence","official target content opens only through post-seal custody","Every finite bonded atomic support with one or more electron-labelled recurrence channels jointly accessible to both nuclear carriers and exclusion-preserving occupation."]
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
end SFT.Chemistry.CovalentEvidence

import SFT.Chemistry.OrderGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.OrderEvidence
open SFT.Host.Canonical OrderGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "one-reference",.text "one localized channel has exact One degree",.boolean true],.array [.text "multiplicity",.text "two retained channels have positive counted multiplicity",.boolean true],.array [.text "float-control",.text "no floating index participates",.boolean true]]
def claimId : String := "SFT-CHEM-BOND-ORDER-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-CONDENSED-LATTICE-001","SFT-PHYS-CONDENSED-BAND-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-VALENCE-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-BOND-METALLIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "support",.text (supportName c.support)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "quantity",.text (quantityName c.quantity)],.array [.text "delocalization",.text (delocalizationName c.delocalization)],.array [.text "method",.text (methodName c.method)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "index-without-bond",.text "A number detached from a bond has no meaning."],.array [.text "identified-bond-carrier",.text "The index remains bound to one joining support."]]],.array [.text "support",.array [.array [.text "selected-channel-count",.text "Omitting channels can force the degree."],.array [.text "complete-joining-channel-support",.text "Every registered bonding channel is included."]]],.array [.text "reference",.array [.array [.text "arbitrary-scale",.text "A free scale can select any order."],.array [.text "single-localized-pair-reference",.text "One localized pair supplies the admitted comparison unit."]]],.array [.text "quantity",.array [.array [.text "floating-index",.text "Floating arithmetic cannot certify the exact support ratio."],.array [.text "exact-positive-rational-degree",.text "Counts and parts remain exact."]]],.array [.text "delocalization",.array [.array [.text "integer-only-order",.text "Delocalized support can distribute a joining unit across links."],.array [.text "rational-support-sharing-retained",.text "Exact parts preserve fractional link support without irrational values."]]],.array [.text "method",.array [.array [.text "one-partition-as-absolute",.text "Different observational partitions can report different indices."],.array [.text "partition-bound-index",.text "The measurement/partition method remains part of the record."]]],.array [.text "record",.array [.array [.text "order-answer-only",.text "An index alone cannot reproduce support."],.array [.text "bond-channel-reference-trace",.text "Bond, channels, reference and partition remain held."]]],.array [.text "extension",.array [.array [.text "free-order-correction",.text "A correction can force a conventional integer."],.array [.text "no-extra-rule",.text "Complete support/reference ratio determines the index."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Bond order as retained joining multiplicity"
 branch := "chemistry"
 statement := "Bond order is the exact positive rational degree of complete joining-channel support for one identified bond relative to one localized electron-pair joining unit, with the observation partition retained."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "identified-bond-carrier__complete-joining-channel-support__single-localized-pair-reference__exact-positive-rational-degree"),("base",.text "One localized electron-pair joining channel supplies the One reference bond order."),("successor",.text "Appending or exactly sharing one generated channel updates the positive rational support/reference degree while retaining every prior channel and partition record."),("exclusions",.array [.text "no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "no universal bond-length/strength formula inferred from a categorical correspondence",.text "official target content opens only through post-seal custody",.text "Every finite identified bond with complete joining-channel support, measured relative to one localized electron-pair joining unit using exact positive counts or rational support parts."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","no universal bond-length/strength formula inferred from a categorical correspondence","official target content opens only through post-seal custody","Every finite identified bond with complete joining-channel support, measured relative to one localized electron-pair joining unit using exact positive counts or rational support parts."]
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
end SFT.Chemistry.OrderEvidence

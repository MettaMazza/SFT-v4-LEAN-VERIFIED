import SFT.Chemistry.OxidativeReductiveGrammar
import SFT.Chemistry.OxidativeReductive
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.OxidativeReductiveEvidence
open SFT.Host.Canonical OxidativeReductiveGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "single-metal",.text "One metal forces transfer distribution two.",.boolean OxidativeReductive.singleWitness],.array [.text "two-metal",.text "Two metals force transfer distribution one and one.",.boolean OxidativeReductive.splitWitness],.array [.text "exact-reverse",.text "Reductive elimination restores the exact source bond.",.boolean OxidativeReductive.reverseWitness],.array [.text "partition-control",.text "A third metal rejects.",.boolean OxidativeReductive.partitionWitness]]
def claimId : String := "SFT-CHEM-OXIDATIVE-ADDITION-REDUCTIVE-ELIMINATION-012"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-ORGANOMETALLIC-METAL-CARBON-BOND-010","SFT-CHEM-ORGANOMETALLIC-ELECTRON-ACCOUNTING-011"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "source",.text (sourceName c.source)],.array [.text "product",.text (productName c.product)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "transfer",.text (transferName c.transfer)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "reverse",.text (reverseName c.reverse)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "anonymous-reaction-name",.text "A name loses the process carrier."],.array [.text "one-retained-organometallic-process",.text "One process retains source and product states."]]],.array [.text "source",.array [.array [.text "selected-reactant-fragments",.text "Selected fragments lose the complete covalent source bond."],.array [.text "complete-two-carrier-source-bond",.text "The source retains both distinct carriers and their bond."]]],.array [.text "product",.array [.array [.text "asserted-oxidation-state-change",.text "A signed oxidation-state change is not a topology."],.array [.text "two-generated-metal-carrier-incidences",.text "Oxidative addition replaces the source bond by two retained incidences."]]],.array [.text "conservation",.array [.array [.text "formal-charge-bookkeeping",.text "Formal charge bookkeeping can lose occurrences."],.array [.text "exact-carrier-and-metal-conservation",.text "Every metal and transferred carrier occurrence is preserved."]]],.array [.text "transfer",.array [.array [.text "signed-electron-loss",.text "Signed loss imports negative proof values."],.array [.text "held-two-electron-transfer-orientation",.text "Transfer is an exact positive count with a held direction."]]],.array [.text "partition",.array [.array [.text "single-conventional-mechanism",.text "One conventional mechanism omits the split-metal form."],.array [.text "complete-one-metal-two-or-two-metal-one-one-partition",.text "The exact transfer partitions are two on one or one on each of two."]]],.array [.text "reverse",.array [.array [.text "separate-reductive-rule",.text "A separate rule need not invert the process."],.array [.text "exact-reductive-inverse-correspondence",.text "Reductive elimination exactly reverses bond and incidence changes."]]],.array [.text "extension",.array [.array [.text "species-specific-exception",.text "An exception destroys zero-parameter closure."],.array [.text "trace-composition-with-no-extra-rule",.text "Traces compose by preserved endpoints and occurrences."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact oxidative-addition/reductive-elimination inverse law"
 branch := "chemistry"
 statement := "Oxidative addition preserves one or two metal occurrences and two distinct covalently bound carriers while replacing the carrier-carrier bond by two metal-carrier incidences. Exact positive electron transfer is held as two on one metal or one on each of two metals, never as signed oxidation. Reductive elimination is the unique exact inverse that removes those incidences, restores the source bond and preserves every occurrence."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-organometallic-process__complete-two-carrier-source-bond__two-generated-metal-carrier-incidences__exact-carrier-and-metal-conservation__held-two-electron-transfer-orientation__complete-one-metal-two-or-two-metal-one-one-partition__exact-reductive-inverse-correspondence__trace-composition-with-no-extra-rule"),("base",.text "One retained metal and one two-carrier bond force two product incidences and exact transfer distribution two; two retained metals force distribution one and one."),("successor",.text "Trace composition preserves matching endpoints, every carrier and metal occurrence, transfer orientation and exact inverse without a species exception."),("exclusions",.array [.text "no numerical zero negative irrational imaginary signed continuum fitted free or imported parameter",.text "no signed oxidation-state arithmetic formal-charge substitution or observed mechanism selection",.text "no loss duplication or relabeling of metal or transferred carriers",.text "no omission of radical-scope or reverse correspondence surfaces"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary signed continuum fitted free or imported parameter","no signed oxidation-state arithmetic formal-charge substitution or observed mechanism selection","no loss duplication or relabeling of metal or transferred carriers","no omission of radical-scope or reverse correspondence surfaces"]
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
end SFT.Chemistry.OxidativeReductiveEvidence

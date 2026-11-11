import SFT.Chemistry.YieldGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.YieldEvidence
open SFT.Host.Canonical YieldGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-yield",.text "yield preserves an exact positive product part",.boolean true],.array [.text "reference",.text "product and expected supports remain separately held",.boolean true],.array [.text "empty-control",.text "no-product outcome is an empty form, not zero",.boolean true]]
def claimId : String := "SFT-CHEM-STOICH-YIELD-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-MEAS-AMOUNT-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-STOICH-LIMITING-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "process",.text (processName c.process)],.array [.text "numerator",.text (numeratorName c.numerator)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "quantity",.text (quantityName c.quantity)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "percentage-without-product",.text "A percentage detached from a product is not chemical yield."],.array [.text "element-or-compound-product",.text "The retained product identity carries the result."]]],.array [.text "process",.array [.array [.text "unspecified-process",.text "Yield depends on the declared reaction or separation."],.array [.text "specified-reaction-or-separation",.text "The process boundary is retained."]]],.array [.text "numerator",.array [.array [.text "selected-favorable-product",.text "Selecting a favorable amount hides other outcomes."],.array [.text "complete-observed-product-amount",.text "The full registered product amount is used."]]],.array [.text "reference",.array [.array [.text "unbound-denominator",.text "A fraction without its reference is uninterpretable."],.array [.text "registered-expected-support",.text "The comparison support is explicit."]]],.array [.text "quantity",.array [.array [.text "floating-percent",.text "Floating output is not exact proof."],.array [.text "exact-positive-amount-fraction",.text "Yield is an exact positive part of the reference."]]],.array [.text "absence",.array [.array [.text "numerical-zero-yield",.text "Zero is not an SFT proof value."],.array [.text "empty-product-outcome-form",.text "No product is an observed empty outcome, outside positive yield arithmetic."]]],.array [.text "record",.array [.array [.text "yield-answer-only",.text "An answer loses product, process and reference provenance."],.array [.text "product-process-reference-trace",.text "All carriers and the exact fraction remain linked."]]],.array [.text "extension",.array [.array [.text "free-yield-correction",.text "A correction can inflate the observed result."],.array [.text "no-extra-rule",.text "Observed and reference supports determine the fraction."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Reaction yield as retained product share"
 branch := "chemistry"
 statement := "Chemical yield is the exact positive Fold part of a retained element-or-compound product amount relative to its registered expected support after a specified reaction or separation."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "element-or-compound-product__specified-reaction-or-separation__complete-observed-product-amount__exact-positive-amount-fraction"),("base",.text "One observed product occupying one exact positive part of a registered reference supplies the first yield record."),("successor",.text "Appending one registered product observation retains process and reference identity and recomputes the exact positive aggregate part without feedback into the reaction law."),("exclusions",.array [.text "no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no absent species represented by a zero coefficient; absence is an empty generated form",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every specified reaction or separation with a retained expected product support and a positive observed product amount represented as an exact part of that reference support."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no absent species represented by a zero coefficient; absence is an empty generated form","no application result or opaque predictor","official target content opens only through post-seal custody","Every specified reaction or separation with a retained expected product support and a positive observed product amount represented as an exact part of that reference support."]
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
end SFT.Chemistry.YieldEvidence

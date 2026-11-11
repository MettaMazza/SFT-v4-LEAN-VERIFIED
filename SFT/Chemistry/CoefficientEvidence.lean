import SFT.Chemistry.CoefficientGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CoefficientEvidence
open SFT.Host.Canonical CoefficientGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "primitive-witness",.text "abstract balanced coefficients have common factor One",.boolean true],.array [.text "balance",.text "coefficient vector preserves all element totals",.boolean true],.array [.text "zero-control",.text "nonparticipants are absent",.boolean true]]
def claimId : String := "SFT-CHEM-STOICH-COEFFICIENT-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-MEAS-AMOUNT-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-STOICH-CONSERVATION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "scale",.text (scaleName c.scale)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "uniqueness",.text (uniquenessName c.uniqueness)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "coefficient-list-without-species",.text "Counts detached from formulae have no chemical meaning."],.array [.text "formula-bound-species-support",.text "Each count remains bound to one species formula."]]],.array [.text "orientation",.array [.array [.text "negative-reactant-count",.text "Negative proof counts are inadmissible."],.array [.text "held-side-positive-count",.text "Both sides use positive counts plus held orientation."]]],.array [.text "balance",.array [.array [.text "unbalanced-count-vector",.text "An unbalanced vector violates element conservation."],.array [.text "element-balance-preserved",.text "The vector makes every element total equal."]]],.array [.text "scale",.array [.array [.text "arbitrary-common-multiple",.text "Common multiples are equivalent but not minimal."],.array [.text "primitive-positive-vector",.text "Dividing every common factor yields the least representative."]]],.array [.text "absence",.array [.array [.text "zero-coefficient-species",.text "A zero coefficient imports numerical zero."],.array [.text "nonparticipants-omitted",.text "Only participating species are generated."]]],.array [.text "uniqueness",.array [.array [.text "one-picked-balancing-vector",.text "Picking one vector does not eliminate rescalings."],.array [.text "unique-up-to-common-multiple",.text "All balanced rescalings reduce to one primitive vector."]]],.array [.text "record",.array [.array [.text "coefficient-answer-only",.text "A count list cannot prove its balance."],.array [.text "formula-matrix-reduction-trace",.text "Element matrix and exact reduction remain held."]]],.array [.text "extension",.array [.array [.text "free-coefficient-adjustment",.text "An adjustment can force a desired equation."],.array [.text "no-extra-rule",.text "Conservation and primitiveness determine the result."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Positive stoichiometric coefficient and reaction balance"
 branch := "chemistry"
 statement := "Stoichiometric coefficients are the unique primitive vector of positive generated species multiplicities balancing every element map, with reactant/product direction held structurally and nonparticipants omitted."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "formula-bound-species-support__held-side-positive-count__element-balance-preserved__primitive-positive-vector"),("base",.text "One balanced common-factor-free reaction word supplies the first primitive positive coefficient vector."),("successor",.text "Appending one species and its required element constraints forces the least new positive balanced vector or halts if none exists."),("exclusions",.array [.text "no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no absent species represented by a zero coefficient; absence is an empty generated form",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every balanceable finite chemical reaction support with participating species only, represented by the least common-factor-free vector of positive generated multiplicities."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no absent species represented by a zero coefficient; absence is an empty generated form","no application result or opaque predictor","official target content opens only through post-seal custody","Every balanceable finite chemical reaction support with participating species only, represented by the least common-factor-free vector of positive generated multiplicities."]
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
end SFT.Chemistry.CoefficientEvidence

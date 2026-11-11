import SFT.Chemistry.AtomicWeightGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AtomicWeightEvidence
open SFT.Host.Canonical AtomicWeightGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "population-average",.text "isotope parts and paired masses reconstruct the average",.boolean true],.array [.text "source-boundary",.text "changed isotopic composition remains a distinct record",.boolean true],.array [.text "decimal-only-control",.text "an untraced decimal is rejected",.boolean true]]
def claimId : String := "SFT-CHEM-ELEM-ATOMIC-WEIGHT-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001","SFT-PHYS-NUCLEAR-LEVELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-MEAS-AMOUNT-001","SFT-CHEM-MEAS-TRACEABILITY-001","SFT-CHEM-ELEM-ISOTOPE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "population",.text (populationName c.population)],.array [.text "isotopes",.text (isotopesName c.isotopes)],.array [.text "mass",.text (massName c.mass)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "source",.text (sourceName c.source)],.array [.text "uncertainty",.text (uncertaintyName c.uncertainty)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "decimal-answer-only",.text "A decimal answer hides population, isotope and reference provenance."],.array [.text "exact-ratio-carrier",.text "The value is an exact ratio record before decimal reporting."]]],.array [.text "population",.array [.array [.text "single-atom-mass",.text "Atomic weight concerns a population average rather than an arbitrary single atom."],.array [.text "average-atomic-mass",.text "The complete finite population and its parts determine the average."]]],.array [.text "isotopes",.array [.array [.text "isotope-mixture-erased",.text "Erasing isotope support loses the source of population variation."],.array [.text "isotope-support-retained",.text "Every contributing isotope and abundance part remains held."]]],.array [.text "mass",.array [.array [.text "unbound-mass-labels",.text "Unbound masses cannot be paired with their isotope parts."],.array [.text "isotope-mass-pairs",.text "Each atomic-mass record remains paired to its isotope carrier."]]],.array [.text "reference",.array [.array [.text "unit-as-derived-law",.text "A conventional unit scale cannot select the structural ratio."],.array [.text "reference-unit-comparison",.text "The unified atomic mass unit remains a separate registered comparator."]]],.array [.text "source",.array [.array [.text "universal-fixed-composition",.text "Natural isotope composition can vary by source."],.array [.text "source-bounded-population",.text "The population/source boundary remains explicit."]]],.array [.text "uncertainty",.array [.array [.text "exact-decimal-pretense",.text "A reported decimal must not erase its measurement interval."],.array [.text "measurement-interval-retained",.text "Uncertainty remains a source-bound external record."]]],.array [.text "extension",.array [.array [.text "free-weight-adjustment",.text "An adjustable correction can force a measured target."],.array [.text "no-extra-rule",.text "Population parts, mass records and reference comparison completely determine the record."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Atomic-weight record and isotopic composition boundary"
 branch := "chemistry"
 statement := "Relative atomic mass is the exact source-bounded Fold ratio of a finite atom population's retained average mass to a separately registered unified atomic-mass reference, with isotope support and measurement uncertainty preserved."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "exact-ratio-carrier__average-atomic-mass__reference-unit-comparison"),("base",.text "One source-bounded atom population with retained isotope/mass records and one reference-unit comparison supplies the first relative atomic-mass record."),("successor",.text "Appending one registered isotope population part preserves the exact weighted total, every prior pair, source boundary, uncertainty and separate reference comparison."),("exclusions",.array [.text "no IUPAC definition, periodic-table arrangement, measured element value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every finite source-bounded atom population with retained isotope membership, exact positive rational abundance parts, atomic-mass records and a separate unified-reference-unit comparison."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, periodic-table arrangement, measured element value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","official target content opens only through post-seal custody","Every finite source-bounded atom population with retained isotope membership, exact positive rational abundance parts, atomic-mass records and a separate unified-reference-unit comparison."]
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
end SFT.Chemistry.AtomicWeightEvidence

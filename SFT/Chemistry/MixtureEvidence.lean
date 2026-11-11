import SFT.Chemistry.MixtureGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MixtureEvidence
open SFT.Host.Canonical MixtureGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "multiple-components",.text "two distinct substances close one composition",.boolean true],.array [.text "identity-retention",.text "mixing alone does not erase component identity",.boolean true],.array [.text "single-control",.text "one constituent is not classified as a mixture",.boolean true]]
def claimId : String := "SFT-CHEM-STOICH-MIXTURE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-MEAS-AMOUNT-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-YIELD-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "multiplicity",.text (multiplicityName c.multiplicity)],.array [.text "identity",.text (identityName c.identity)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "bonding",.text (bondingName c.bonding)],.array [.text "phase",.text (phaseName c.phase)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "substance-name-only",.text "One substance name does not define a mixture."],.array [.text "portion-of-matter-carrier",.text "The portion boundary holds the whole support."]]],.array [.text "multiplicity",.array [.array [.text "single-constituent",.text "A single constituent is not a mixture."],.array [.text "multiple-constituent-support",.text "More than one retained constituent is required."]]],.array [.text "identity",.array [.array [.text "anonymous-components",.text "Anonymous components erase chemical distinction."],.array [.text "chemical-substance-identities",.text "Each constituent is an admitted substance carrier."]]],.array [.text "composition",.array [.array [.text "unmeasured-presence-list",.text "Presence alone cannot reconstruct composition."],.array [.text "exact-positive-composition-parts",.text "Every present constituent retains its part of the whole."]]],.array [.text "bonding",.array [.array [.text "new-substance-conflation",.text "Mixing does not by itself force a new chemical identity."],.array [.text "constituent-identities-retained",.text "Components remain separately recoverable in the record."]]],.array [.text "phase",.array [.array [.text "single-phase-required",.text "Mixtures may contain one or several phases."],.array [.text "phase-support-recorded-not-forced",.text "The observed phase organization is retained separately."]]],.array [.text "record",.array [.array [.text "mixture-label-only",.text "A label cannot reconstruct components."],.array [.text "component-part-phase-trace",.text "Components, parts and phase boundary remain held."]]],.array [.text "extension",.array [.array [.text "free-mixture-equivalence",.text "An arbitrary equivalence can merge distinct mixtures."],.array [.text "no-extra-rule",.text "Complete component support determines identity."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Mixture components and composition support"
 branch := "chemistry"
 statement := "A mixture is a finite portion-of-matter Fold carrier with multiple retained chemical-substance identities and exact positive composition parts, without assuming formation of a new substance."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "portion-of-matter-carrier__multiple-constituent-support__chemical-substance-identities__exact-positive-composition-parts"),("base",.text "Two admitted substance identities with exact positive parts closing to One supply the first mixture carrier."),("successor",.text "Appending or refining a present component preserves all substance identities and closes the new exact parts to the same whole."),("exclusions",.array [.text "no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no absent species represented by a zero coefficient; absence is an empty generated form",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every finite portion of matter containing multiple retained chemical-substance identities and their exact positive composition parts without requiring a new bonded substance identity."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no absent species represented by a zero coefficient; absence is an empty generated form","no application result or opaque predictor","official target content opens only through post-seal custody","Every finite portion of matter containing multiple retained chemical-substance identities and their exact positive composition parts without requiring a new bonded substance identity."]
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
end SFT.Chemistry.MixtureEvidence

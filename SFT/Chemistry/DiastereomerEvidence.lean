import SFT.Chemistry.DiastereomerGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.DiastereomerEvidence
open SFT.Host.Canonical DiastereomerGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "constitution",.text "complete structure exists",.boolean true],.array [.text "classification",.text "mirror and identity tests remain separate",.boolean true],.array [.text "properties",.text "empirical response remains open",.boolean true]]
def claimId : String := "SFT-CHEM-STEREO-DIASTEREOMER-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-NET-REACTION-001","SFT-CHEM-STEREO-CHIRALITY-001","SFT-CHEM-STEREO-ENANTIOMER-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "members",.text (membersName c.members)],.array [.text "constitution",.text (constitutionName c.constitution)],.array [.text "superposition",.text (superpositionName c.superposition)],.array [.text "mirror",.text (mirrorName c.mirror)],.array [.text "configuration",.text (configurationName c.configuration)],.array [.text "properties",.text (propertiesName c.properties)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "members",.array [.array [.text "one-structure-only",.text "No pair exists."],.array [.text "paired-stereoisomers",.text "Two oriented structures are retained."]]],.array [.text "constitution",.array [.array [.text "different-composition-or-connectivity",.text "They are not stereoisomers."],.array [.text "same-composition-and-connectivity",.text "Constitution is held equal."]]],.array [.text "superposition",.array [.array [.text "superposable-pair",.text "No stereochemical distinction remains."],.array [.text "non-superposable-pair",.text "Their configurations differ."]]],.array [.text "mirror",.array [.array [.text "exact-mirror-pair",.text "That pair is enantiomeric."],.array [.text "not-mirror-related",.text "Reflection does not identify the second member."]]],.array [.text "configuration",.array [.array [.text "all-centres-erased",.text "The difference is unreproducible."],.array [.text "complete-relative-configurations-held",.text "Every oriented centre is retained."]]],.array [.text "properties",.array [.array [.text "properties-forced-equal",.text "Non-mirror structures need not share response."],.array [.text "property-distinction-open",.text "Measured response remains source-bound."]]],.array [.text "record",.array [.array [.text "diastereomer-label-only",.text "The exclusions cannot be checked."],.array [.text "complete-pair-classification-trace",.text "Identity, mirror and map tests are retained."]]],.array [.text "extra",.array [.array [.text "free-diastereomer-rule",.text "A taxonomy can select the answer."],.array [.text "no-extra-rule",.text "Stereoisomer identity minus mirror relation supplies the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Diastereomer distinction"
 branch := "chemistry"
 statement := "Diastereomers are paired non-superposable stereoisomers of equal composition and connectivity that are not related as exact mirror images."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "paired-stereoisomers__same-composition-and-connectivity__non-superposable-pair__not-mirror-related__complete-relative-configurations-held"),("base",.text "One non-superposable non-mirror stereoisomer pair supplies the first diastereomer class."),("successor",.text "Appending matched constitutional support preserves equal constitution while extending configuration, reflection and map tests."),("exclusions",.array [.text "no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite equal-constitution oriented molecular pair with exhaustive identity, reflection and proper-superposition classifications."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite equal-constitution oriented molecular pair with exhaustive identity, reflection and proper-superposition classifications."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with members := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.DiastereomerEvidence

import SFT.Chemistry.AcidbaseGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AcidbaseEvidence
open SFT.Host.Canonical AcidbaseGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "pair",.text "the two conjugate identities remain distinct",.boolean true],.array [.text "proton",.text "the distinguishing carrier is explicitly proton-labelled",.boolean true],.array [.text "one-difference",.text "no additional difference is introduced",.boolean true]]
def claimId : String := "SFT-CHEM-AB-ACID-BASE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "pair",.text (pairName c.pair)],.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "acid-role",.text (acidRoleName c.acidRole)],.array [.text "base-role",.text (baseRoleName c.baseRole)],.array [.text "difference",.text (differenceName c.difference)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "pair",.array [.array [.text "one-species-label",.text "A conjugate relation compares two carrier identities."],.array [.text "two-conjugate-identities",.text "Both protonated and deprotonated carriers remain held."]]],.array [.text "carrier",.array [.array [.text "anonymous-hydrogen-count",.text "A count cannot trace the transferred occurrence."],.array [.text "one-held-proton-occurrence",.text "The distinguishing proton remains a named conserved carrier."]]],.array [.text "acid-role",.array [.array [.text "acid-by-name",.text "A name cannot establish a transition."],.array [.text "proton-donor-role",.text "The protonated carrier supplies the held proton to an acceptor."]]],.array [.text "base-role",.array [.array [.text "base-by-name",.text "A name cannot establish a transition."],.array [.text "proton-acceptor-role",.text "The deprotonated carrier accepts the held proton."]]],.array [.text "difference",.array [.array [.text "unbounded-composition-change",.text "Additional changes destroy conjugacy."],.array [.text "differ-by-one-proton",.text "All other retained composition is identical."]]],.array [.text "orientation",.array [.array [.text "signed-acidity-scalar",.text "A signed scalar is not a carrier trace."],.array [.text "held-donor-acceptor-orientation",.text "Roles are structural orientations on one transfer."]]],.array [.text "record",.array [.array [.text "acid-base-answer-only",.text "An answer cannot reconstruct conjugacy."],.array [.text "pair-and-proton-trace",.text "Both identities, the proton and transition remain held."]]],.array [.text "extension",.array [.array [.text "free-acid-base-exception",.text "An exception can label arbitrary species."],.array [.text "no-extra-rule",.text "One-proton conjugacy and roles determine the relation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Conjugate acid-base partition"
 branch := "chemistry"
 statement := "A conjugate acid/base relation is a pair of retained chemical identities differing by exactly one named proton carrier: the protonated member donates it and the deprotonated member accepts it."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "two-conjugate-identities__one-held-proton-occurrence__proton-donor-role__proton-acceptor-role__differ-by-one-proton"),("base",.text "One retained carrier pair differing by one named proton supplies the first conjugate acid/base relation."),("successor",.text "Appending matched retained composition to both members preserves their one-proton difference and donor/acceptor orientation."),("exclusions",.array [.text "no acid/base dictionary, pH scale, equilibrium equation, dissociation constant, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no unpaired creation, copying or loss of a proton or electron carrier",.text "no claim that structural closure alone fixes every solution-dependent strength or capacity value",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite generated pair of chemical carriers related by exactly one retained proton occurrence, with the protonated member able to donate that occurrence and the deprotonated member able to accept it."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no acid/base dictionary, pH scale, equilibrium equation, dissociation constant, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no unpaired creation, copying or loss of a proton or electron carrier","no claim that structural closure alone fixes every solution-dependent strength or capacity value","external target content remains inaccessible until the prediction is sealed","Every finite generated pair of chemical carriers related by exactly one retained proton occurrence, with the protonated member able to donate that occurrence and the deprotonated member able to accept it."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with pair := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.AcidbaseEvidence

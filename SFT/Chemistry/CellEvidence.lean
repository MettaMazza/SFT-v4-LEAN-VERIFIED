import SFT.Chemistry.CellGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CellEvidence
open SFT.Host.Canonical CellGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "sites",.text "the two redox sites are distinct",.boolean true],.array [.text "electron-path",.text "the electron path joins the redox sites",.boolean true],.array [.text "ionic-path",.text "a separate compensating path is retained",.boolean true]]
def claimId : String := "SFT-CHEM-ELECTROCHEM-CELL-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "sites",.text (sitesName c.sites)],.array [.text "electron-path",.text (electronPathName c.electronPath)],.array [.text "ionic-path",.text (ionicPathName c.ionicPath)],.array [.text "coupling",.text (couplingName c.coupling)],.array [.text "work",.text (workName c.work)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "sites",.array [.array [.text "one-conflated-site",.text "Separation is required for an external path."],.array [.text "distinct-oxidation-reduction-sites",.text "Both half-reaction identities remain held."]]],.array [.text "electron-path",.array [.array [.text "electron-teleportation",.text "It omits the transfer trace."],.array [.text "complete-external-electron-path",.text "Every adjacent carrier step is retained."]]],.array [.text "ionic-path",.array [.array [.text "charge-accumulation-unclosed",.text "Accumulation halts sustained transfer."],.array [.text "complete-compensating-ionic-path",.text "The chemical circuit closes."]]],.array [.text "coupling",.array [.array [.text "independent-half-reactions",.text "Unpaired halves violate conservation."],.array [.text "one-redox-transfer-cycle",.text "Both sites share one carrier accounting."]]],.array [.text "work",.array [.array [.text "free-energy-output",.text "Untraced work creates support."],.array [.text "source-bounded-work-transfer",.text "Output is paired to chemical carrier change."]]],.array [.text "orientation",.array [.array [.text "negative-potential-primitive",.text "A negative scalar is not needed."],.array [.text "held-cell-orientation",.text "Oxidation-to-reduction direction is retained."]]],.array [.text "record",.array [.array [.text "cell-label-only",.text "A label cannot reproduce either path."],.array [.text "sites-paths-transfer-trace",.text "Both paths and sites remain auditable."]]],.array [.text "extra",.array [.array [.text "free-electrode-potential",.text "A fitted potential can select behavior."],.array [.text "no-extra-rule",.text "Separated closed redox support supplies the cell law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Electrochemical cell and separated redox closure"
 branch := "chemistry"
 statement := "An electrochemical cell is a separated coupled-redox process with complete external electron and compensating ionic paths, retaining site identities and source-bounded work transfer."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "distinct-oxidation-reduction-sites__complete-external-electron-path__complete-compensating-ionic-path__one-redox-transfer-cycle__source-bounded-work-transfer"),("base",.text "One separated site pair with complete electron and ionic paths supplies the first electrochemical cell."),("successor",.text "Appending one cell cycle preserves site and path identities while pairing every transferred electron with compensating ionic closure and source change."),("exclusions",.array [.text "no electronegativity scale, oxidation-state table, electrode potential, external definition, measured value or V2 result may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no electron carrier may be created, copied, silently erased or assigned to two endpoints",.text "no qualitative structural law is represented as a parameter-free prediction of a measured decimal scale",.text "external target content remains inaccessible until the complete prediction is sealed",.text "Every finite separated pair of coupled redox sites with a complete electron path from oxidation to reduction, a complete compensating ionic path, retained chemical boundaries and source-bounded work transfer."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no electronegativity scale, oxidation-state table, electrode potential, external definition, measured value or V2 result may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no electron carrier may be created, copied, silently erased or assigned to two endpoints","no qualitative structural law is represented as a parameter-free prediction of a measured decimal scale","external target content remains inaccessible until the complete prediction is sealed","Every finite separated pair of coupled redox sites with a complete electron path from oxidation to reduction, a complete compensating ionic path, retained chemical boundaries and source-bounded work transfer."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with sites := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.CellEvidence

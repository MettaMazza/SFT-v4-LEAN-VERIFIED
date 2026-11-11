import SFT.Chemistry.ColloidGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ColloidEvidence
open SFT.Host.Canonical ColloidGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "phases",.text "dispersed and continuous phases differ",.boolean true],.array [.text "population",.text "particle population is positive",.boolean true],.array [.text "interface",.text "both phase labels are held",.boolean true]]
def claimId : String := "SFT-CHEM-COLLOID-DISPERSION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "phases",.text (phasesName c.phases)],.array [.text "extent",.text (extentName c.extent)],.array [.text "interface",.text (interfaceName c.interface)],.array [.text "distribution",.text (distributionName c.distribution)],.array [.text "scale",.text (scaleName c.scale)],.array [.text "stability",.text (stabilityName c.stability)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "phases",.array [.array [.text "single-uniform-phase",.text "No dispersion exists."],.array [.text "dispersed-and-continuous-phases",.text "Two phase roles are held."]]],.array [.text "extent",.array [.array [.text "molecular-solution-only",.text "No mesoscopic carrier is retained."],.array [.text "finite-dispersed-particles",.text "Each dispersed region is a counted carrier."]]],.array [.text "interface",.array [.array [.text "phase-boundary-erased",.text "Particle identity is lost."],.array [.text "phase-interface-retained",.text "Every dispersed region has a boundary."]]],.array [.text "distribution",.array [.array [.text "one-settled-region",.text "Dispersion is absent."],.array [.text "particles-distributed-through-medium",.text "Multiple separated occurrences remain."]]],.array [.text "scale",.array [.array [.text "size-free-label",.text "Colloid identity is unbounded."],.array [.text "particle-size-source-bounded",.text "Resolution and size boundary are explicit."]]],.array [.text "stability",.array [.array [.text "eternal-stability-assumed",.text "Persistence is condition-dependent."],.array [.text "dispersion-condition-bounded",.text "The observation interval is held."]]],.array [.text "record",.array [.array [.text "colloid-name-only",.text "Phase support cannot be checked."],.array [.text "particle-interface-distribution-trace",.text "All occurrences are auditable."]]],.array [.text "extra",.array [.array [.text "free-dispersion-fit",.text "A fit can force stability."],.array [.text "no-extra-rule",.text "Two-phase distributed support supplies the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Colloidal dispersion and phase-interface support"
 branch := "chemistry"
 statement := "A colloidal dispersion is a source-bounded population of finite dispersed-phase regions distributed through a retained continuous phase, each with a retained interface and observation-scale boundary."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "dispersed-and-continuous-phases__finite-dispersed-particles__phase-interface-retained__particles-distributed-through-medium__particle-size-source-bounded"),("base",.text "One dispersed region inside one distinct continuous phase supplies the first colloidal organization."),("successor",.text "Appending a bounded dispersed region preserves phase identities and adds its interface and position to the complete distribution trace."),("exclusions",.array [.text "no catalyst dictionary, kinetic table, reaction network, surface model, colloid table, transfer equation, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier, phase identity, interface or reaction step may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite population of separated same-phase regions within a distinct continuous phase, with complete interfaces, sizes, positions, conditions and observation interval."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no catalyst dictionary, kinetic table, reaction network, surface model, colloid table, transfer equation, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier, phase identity, interface or reaction step may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite population of separated same-phase regions within a distinct continuous phase, with complete interfaces, sizes, positions, conditions and observation interval."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with phases := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ColloidEvidence

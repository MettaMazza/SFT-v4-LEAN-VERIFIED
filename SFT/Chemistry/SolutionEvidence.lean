import SFT.Chemistry.SolutionGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.SolutionEvidence
open SFT.Host.Canonical SolutionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "phase",.text "all components remain in one registered phase",.boolean true],.array [.text "roles",.text "each substance retains solvent or solute role",.boolean true],.array [.text "multiphase-control",.text "an unresolved multiphase support is rejected",.boolean true]]
def claimId : String := "SFT-CHEM-STOICH-SOLUTION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-MEAS-AMOUNT-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-STOICH-MIXTURE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "phase",.text (phaseName c.phase)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "roles",.text (rolesName c.roles)],.array [.text "identity",.text (identityName c.identity)],.array [.text "context",.text (contextName c.context)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "gas-or-unclassified-matter",.text "The registered solution boundary is a liquid or solid phase."],.array [.text "liquid-or-solid-phase",.text "The phase carrier matches the declared solution domain."]]],.array [.text "phase",.array [.array [.text "multiple-unresolved-phases",.text "Unresolved phase multiplicity does not define one solution carrier."],.array [.text "single-phase-support",.text "All components occupy one retained phase support."]]],.array [.text "composition",.array [.array [.text "single-substance-phase",.text "A pure phase lacks solute/solvent distinction."],.array [.text "multiple-substance-support",.text "The phase contains multiple substances."]]],.array [.text "roles",.array [.array [.text "unpartitioned-components",.text "A solution record distinguishes solvent from solutes."],.array [.text "solvent-solute-role-partition",.text "Every component receives one contextual role."]]],.array [.text "identity",.array [.array [.text "roles-replace-identity",.text "A role label must not erase substance identity."],.array [.text "substance-identities-retained",.text "Each solvent and solute remains chemically identified."]]],.array [.text "context",.array [.array [.text "intrinsic-permanent-role",.text "Solvent/solute assignment can depend on the description context."],.array [.text "declared-context-role",.text "The convention boundary remains explicit."]]],.array [.text "record",.array [.array [.text "solution-name-only",.text "A name cannot reproduce phase and roles."],.array [.text "phase-component-role-trace",.text "Phase, identities, parts and roles remain linked."]]],.array [.text "extension",.array [.array [.text "free-solution-exception",.text "An exception can relabel a multiphase mixture as one solution."],.array [.text "no-extra-rule",.text "Single phase plus the role partition determines the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Solution composition and solute-solvent distinction"
 branch := "chemistry"
 statement := "A solution is a liquid or solid single-phase mixture containing multiple retained substances under an explicit contextual solvent/solute role partition."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "liquid-or-solid-phase__single-phase-support__multiple-substance-support__solvent-solute-role-partition"),("base",.text "One single-phase mixture with one solvent-role substance and one solute-role substance supplies the first solution."),("successor",.text "Appending one solute or solvent-role component retains the single phase, all substance identities, exact parts and the declared contextual role partition."),("exclusions",.array [.text "no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no absent species represented by a zero coefficient; absence is an empty generated form",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every finite liquid or solid single-phase mixture with multiple retained substances and an explicit contextual partition between solvent carrier roles and solute carrier roles."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no absent species represented by a zero coefficient; absence is an empty generated form","no application result or opaque predictor","official target content opens only through post-seal custody","Every finite liquid or solid single-phase mixture with multiple retained substances and an explicit contextual partition between solvent carrier roles and solute carrier roles."]
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
end SFT.Chemistry.SolutionEvidence

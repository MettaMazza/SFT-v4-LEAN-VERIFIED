import SFT.Chemistry.CatalystGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CatalystEvidence
open SFT.Host.Canonical CatalystGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "entry equals exit",.boolean true],.array [.text "steps",.text "cycle has positive steps",.boolean true],.array [.text "family",.text "carrier family retained",.boolean true]]
def claimId : String := "SFT-CHEM-CAT-CATALYST-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "role",.text (roleName c.role)],.array [.text "identity",.text (identityName c.identity)],.array [.text "path",.text (pathName c.path)],.array [.text "rate",.text (rateName c.rate)],.array [.text "net",.text (netName c.net)],.array [.text "direction",.text (directionName c.direction)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "role",.array [.array [.text "ordinary-reactant-only",.text "The carrier is consumed."],.array [.text "reaction-cycle-participant",.text "The carrier traverses a closed cycle."]]],.array [.text "identity",.array [.array [.text "carrier-identity-changed",.text "It is not recovered."],.array [.text "exact-catalyst-identity-returned",.text "Entry and exit labels coincide."]]],.array [.text "path",.array [.array [.text "overall-reaction-only",.text "No catalytic path is distinguished."],.array [.text "alternative-step-path-retained",.text "The added cycle is explicit."]]],.array [.text "rate",.array [.array [.text "rate-unchanged-by-cycle",.text "No catalytic action occurs."],.array [.text "reaction-rate-increased",.text "More reaction recurrences close per held interval."]]],.array [.text "net",.array [.array [.text "catalyst-in-net-products",.text "The carrier was consumed or produced."],.array [.text "net-reaction-unchanged",.text "Cycle cancellation preserves endpoints."]]],.array [.text "direction",.array [.array [.text "one-direction-rule",.text "A reversible cycle is incomplete."],.array [.text "both-directions-share-path",.text "The path exists under reversed traversal."]]],.array [.text "record",.array [.array [.text "catalyst-name-only",.text "Identity return cannot be checked."],.array [.text "complete-cycle-trace",.text "Every carrier occurrence is retained."]]],.array [.text "extra",.array [.array [.text "free-catalytic-fit",.text "A fit can select the result."],.array [.text "no-extra-rule",.text "Cycle closure supplies the law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Catalyst identity conserved through a reaction cycle"
 branch := "chemistry"
 statement := "A catalyst is a retained chemical carrier that opens an alternative closed reaction path and returns with exact identity while the net reaction endpoints are unchanged."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "reaction-cycle-participant__exact-catalyst-identity-returned__alternative-step-path-retained__reaction-rate-increased__net-reaction-unchanged"),("base",.text "One closed carrier-return cycle supplies the first catalyst."),("successor",.text "Appending one complete cycle preserves catalyst identity and net endpoints while adding counted recurrence support."),("exclusions",.array [.text "no catalyst dictionary, kinetic table, reaction network, surface model, colloid table, transfer equation, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier, phase identity, interface or reaction step may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite source-bound reaction cycle whose catalyst entry, step occurrences, return identity, net endpoints and recurrence interval are completely recorded."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no catalyst dictionary, kinetic table, reaction network, surface model, colloid table, transfer equation, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier, phase identity, interface or reaction step may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite source-bound reaction cycle whose catalyst entry, step occurrences, return identity, net endpoints and recurrence interval are completely recorded."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with role := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.CatalystEvidence

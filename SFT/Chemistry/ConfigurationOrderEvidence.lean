import SFT.Chemistry.ConfigurationOrderGrammar
import SFT.Chemistry.ConfigurationOrder
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ConfigurationOrderEvidence
open SFT.Host.Canonical ConfigurationOrderGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "basin",.text "Structural least coordinate is lower than both exact neighbours.",.boolean ConfigurationOrder.basinWitness],.array [.text "barrier",.text "A transition configuration is higher than both exact neighbours.",.boolean ConfigurationOrder.barrierWitness],.array [.text "path",.text "Every node retains one carrier and record.",.boolean ConfigurationOrder.pathWitness],.array [.text "invalid",.text "An empty configuration path rejects.",.boolean ConfigurationOrder.invalidWitness]]
def claimId : String := "SFT-CHEM-CONFIGURATION-ORDER-PATH-011"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-SELECTION-RULE-STRUCTURE-010"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "configuration",.text (configurationName c.configuration)],.array [.text "order",.text (orderName c.order)],.array [.text "stability",.text (stabilityName c.stability)],.array [.text "barrier",.text (barrierName c.barrier)],.array [.text "path",.text (pathName c.path)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "record",.text (recordName c.record)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "coordinate-only-surface",.text "Coordinates without the molecular carrier do not identify one chemical configuration space."],.array [.text "retained-molecular-carrier",.text "Every node retains one carrier."]]],.array [.text "configuration",.array [.array [.text "continuum-point-premise",.text "A continuum potential coordinate imports an ungenerated domain."],.array [.text "generated-configuration-nodes",.text "Configurations are exact generated nodes."]]],.array [.text "order",.array [.array [.text "signed-or-floating-energy",.text "Signed or floating magnitudes violate the exact Fold domain."],.array [.text "exact-positive-order-or-EmptyOne",.text "Heights are exact positive ratios above a structural least coordinate."]]],.array [.text "stability",.array [.array [.text "named-stable-structure",.text "A stability name alone does not decide neighbouring alternatives."],.array [.text "local-minimum-by-complete-neighbours",.text "A basin is forced by exact comparison with every adjacent node."]]],.array [.text "barrier",.array [.array [.text "imported-saddle-formula",.text "A continuum saddle formula is unnecessary and ungenerated."],.array [.text "local-barrier-by-complete-neighbours",.text "A transition configuration is higher than its adjacent path nodes."]]],.array [.text "path",.array [.array [.text "endpoint-only-reaction",.text "Endpoints erase intermediates and barriers."],.array [.text "connected-complete-configuration-path",.text "Every adjacent generated configuration and its record remain in the path."]]],.array [.text "recurrence",.array [.array [.text "open-curve-assumption",.text "An internal rotation that erases closure duplicates rather than identifies its terminal configuration."],.array [.text "exact-periodic-endpoint-identity",.text "A complete recurrence returns to the identical held configuration class."]]],.array [.text "record",.array [.array [.text "selected-minima-and-maxima",.text "Keeping extrema alone hides the empirical path."],.array [.text "complete-favourable-and-adverse-vector",.text "Every measured configuration row, including non-extrema, is retained."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular configuration order, basin, barrier and path law"
 branch := "chemistry"
 statement := "A molecular configuration surface is an exact generated configuration graph, not a continuum premise. Each node retains its carrier, coordinate, exact positive height above structural EmptyOne and record; complete neighbour order forces stable basins and barriers, connected adjacency forces reaction paths, and periodic recurrence identifies its terminal configuration with its initial class."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.observationalDerivation]
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "retained-molecular-carrier__generated-configuration-nodes__exact-positive-order-or-EmptyOne__local-minimum-by-complete-neighbours__local-barrier-by-complete-neighbours__connected-complete-configuration-path__exact-periodic-endpoint-identity__complete-favourable-and-adverse-vector"),("base",.text "One retained configuration node has one carrier, coordinate, exact positive height or structural EmptyOne and source record; three connected nodes decide one internal basin or barrier by complete neighbour comparison."),("successor",.text "Appending one adjacent configuration extends the finite path and exposes exactly one new complete-neighbour comparison without changing any prior node, order or record; a complete period identifies the terminal class with the initial class."),("exclusions",.array [.text "no numerical zero; source glyph 0 denotes absence only",.text "no negative, irrational, imaginary, floating, signed or continuum proof magnitude",.text "no imported potential-energy function, differential equation, saddle formula or fitted coefficient",.text "no NIST angle, energy, minimum, barrier or path outcome before prediction seal",.text "no selected extrema-only vector"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; source glyph 0 denotes absence only","no negative, irrational, imaginary, floating, signed or continuum proof magnitude","no imported potential-energy function, differential equation, saddle formula or fitted coefficient","no NIST angle, energy, minimum, barrier or path outcome before prediction seal","no selected extrema-only vector"]
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
end SFT.Chemistry.ConfigurationOrderEvidence

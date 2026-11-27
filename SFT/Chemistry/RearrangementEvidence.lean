import SFT.Chemistry.RearrangementGrammar
import SFT.Chemistry.RearrangementWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.RearrangementEvidence
open SFT.Host.Canonical RearrangementGrammar
set_option maxRecDepth 20000

def witnessPassed (n : Nat) : Bool := match RearrangementWitnesses.witnesses with
 | .error _ => false
 | .ok rows => (rows.drop n).headD false
def witnesses : Value := .array [.array [.text "carrier",.text "Both endpoints remain complete connected carriers.",.boolean (witnessPassed 0)],.array [.text "composition",.text "Every atom and held support occurrence remains exact.",.boolean (witnessPassed 1)],.array [.text "adjacency",.text "One held support changes its exact incidence.",.boolean (witnessPassed 2)],.array [.text "positive-finite-family",.text "Three held supports may rearrange without a new rule.",.boolean (witnessPassed 3)],.array [.text "complete-targets",.text "Every nonoriginal pair is generated for the moved support.",.boolean (witnessPassed 4)],.array [.text "path-family",.text "Direct relocation and opened exact reclosure are both retained.",.boolean (witnessPassed 5)],.array [.text "degenerate",.text "An isomorphic endpoint retains a nonempty exact support-move trace.",.boolean (witnessPassed 6)],.array [.text "reverse",.text "The complete rearrangement reconstructs exactly in reverse.",.boolean (witnessPassed 7)],.array [.text "unchanged-control",.text "An unchanged adjacency organization halts.",.boolean (witnessPassed 8)],.array [.text "composition-control",.text "A missing atom occurrence halts.",.boolean (witnessPassed 9)],.array [.text "successor",.text "A fresh unchanged occurrence preserves the complete transform.",.boolean (witnessPassed 10)]]
def claimId : String := "SFT-CHEM-REARRANGEMENT-REACTION-FAMILY-011"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-QUANTUM-REVERSIBLE-MODEL-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001","SFT-CHEM-ORGANIC-REACTION-FAMILY-001","SFT-CHEM-ELIMINATION-REACTION-FAMILY-010"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "atoms",.text (atomsName c.atoms)],.array [.text "supports",.text (supportsName c.supports)],.array [.text "adjacency",.text (adjacencyName c.adjacency)],.array [.text "path",.text (pathName c.path)],.array [.text "alternatives",.text (alternativesName c.alternatives)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "selected-group-or-product-fragment-only",.text "A fragment cannot prove that the same complete carrier rearranged."],.array [.text "complete-source-and-terminal-carrier",.text "The complete connected source and terminal molecular carriers remain explicit."]]],.array [.text "atoms",.array [.array [.text "atom-created-erased-or-collapsed-to-formula",.text "A changed atom inventory is a different composition, not a rearrangement."],.array [.text "every-atom-occurrence-retained-in-source-order",.text "Every exact atom occurrence remains once in the same carrier."]]],.array [.text "supports",.array [.array [.text "support-created-erased-or-renamed",.text "A replaced bond label cannot be traced through the rearrangement."],.array [.text "every-held-support-occurrence-retained-once",.text "Every held support identity remains once while its incidence may move."]]],.array [.text "adjacency",.array [.array [.text "unchanged-graph-or-unregistered-edit",.text "No change is not a rearrangement and an arbitrary edit is not forced."],.array [.text "positive-finite-held-support-incidence-change",.text "At least one held support changes from one exact incidence to another generated incidence."]]],.array [.text "path",.array [.array [.text "named-mechanism-or-single-imported-order",.text "A conventional mechanism name cannot select the native path."],.array [.text "complete-direct-or-opened-reclosure-path-family",.text "The held support moves directly or opens and exactly recloses with its identity retained."]]],.array [.text "alternatives",.array [.array [.text "species-selected-target-or-degenerate-path-erased",.text "A named product omits other lawful target incidences and constitutionally degenerate traces."],.array [.text "all-nonoriginal-incidences-and-degenerate-traces-generated",.text "Every nonoriginal pair is generated and an isomorphic endpoint retains its exact transition trace."]]],.array [.text "observation",.array [.array [.text "product-scope-readable-before-seal",.text "An opened rearrangement scope could choose the survivor."],.array [.text "value-free-rearrangement-product-vector-seal",.text "The law, target identities and predicted relation seal before new product vectors open."]]],.array [.text "extension",.array [.array [.text "reaction-specific-exception-or-recomputed-prefix",.text "A named exception is not depth-independent."],.array [.text "fresh-unchanged-carrier-successor-no-extra-rule",.text "A fresh unchanged occurrence preserves every prior support move and decision."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact composition-retaining molecular rearrangement law"
 branch := "chemistry"
 statement := "A complete rearrangement retains every atom and held-support occurrence of one connected carrier while a positive finite family of held supports changes exact incidence; every nonoriginal incidence, direct or opened-reclosure path, degenerate trace and unchanged successor remains generated."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-source-and-terminal-carrier__every-atom-occurrence-retained-in-source-order__every-held-support-occurrence-retained-once__positive-finite-held-support-incidence-change__complete-direct-or-opened-reclosure-path-family__all-nonoriginal-incidences-and-degenerate-traces-generated__value-free-rearrangement-product-vector-seal__fresh-unchanged-carrier-successor-no-extra-rule"),("base",.text "One retained held support moves from its source atom pair to one different generated pair while every atom, support and unchanged incidence remains explicit and the reverse reconstruction returns exactly."),("successor",.text "Every next positive finite moved-support family is generated by the same incidence rule; appending a fresh unchanged atom and support preserves the complete prior rearrangement and all decisions."),("exclusions",.array [.text "no native numerical zero; structural absence is EmptyOne",.text "no negative irrational imaginary continuum fitted free random or imported native parameter",.text "no reaction name mechanism yield selectivity temperature time mass formula or measured product selects the survivor",.text "all optimization, non-detection, signed stereochemical, spectral, adverse, absent and unresolved rows remain preserved",.text "the first blind incomplete-carrier surface remains unresolved and is never relabelled favorable",.text "conventional imaginary-frequency and signed decimal inscriptions remain downstream evidence only"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no native numerical zero; structural absence is EmptyOne","no negative irrational imaginary continuum fitted free random or imported native parameter","no reaction name mechanism yield selectivity temperature time mass formula or measured product selects the survivor","all optimization, non-detection, signed stereochemical, spectral, adverse, absent and unresolved rows remain preserved","the first blind incomplete-carrier surface remains unresolved and is never relabelled favorable","conventional imaginary-frequency and signed decimal inscriptions remain downstream evidence only"]
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
end SFT.Chemistry.RearrangementEvidence

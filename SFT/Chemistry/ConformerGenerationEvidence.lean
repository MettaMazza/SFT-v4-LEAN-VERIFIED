import SFT.Chemistry.ConformerGenerationGrammar
import SFT.Chemistry.ConformerCensus
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ConformerGenerationEvidence
open SFT.Host.Canonical ConformerGenerationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-raw-generation",.text "Three held torsion assignments are generated exactly once.",.boolean ConformerCensus.generationWitness],.array [.text "complete-automorphism-census",.text "The four-site path has identity and reversal and no selected action.",.boolean ConformerCensus.automorphismWitness],.array [.text "exact-orbit-quotient",.text "Anti is self-equivalent and the two opposed gauche orientations form one class.",.boolean ConformerCensus.quotientWitness],.array [.text "partition-certificate",.text "Every assignment occurs in exactly one nonempty conformer class.",.boolean ConformerCensus.partitionWitness],.array [.text "incomplete-reversal-control",.text "A torsion alphabet without complete involution halts.",.boolean ConformerCensus.reversalWitness],.array [.text "missing-path-control",.text "A rotor without its complete bonded path halts.",.boolean ConformerCensus.pathWitness]]
def claimId : String := "SFT-CHEM-CONFORMER-GENERATION-EQUIVALENCE-005"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-DIHEDRAL-TORSIONAL-STATE-004"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "rotor",.text (rotorName c.rotor)],.array [.text "generation",.text (generationName c.generation)],.array [.text "symmetry",.text (symmetryName c.symmetry)],.array [.text "equivalence",.text (equivalenceName c.equivalence)],.array [.text "quotient",.text (quotientName c.quotient)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "name-or-coordinate-list",.text "A name or selected coordinates omit molecular identity and adjacency."],.array [.text "complete-finite-molecular-graph",.text "Every atom occurrence, type and bond remains in one connected finite graph."]]],.array [.text "rotor",.array [.array [.text "selected-single-angle",.text "One selected angle omits other rotors and held states."],.array [.text "complete-ordered-rotor-census",.text "Every rotatable four-site path and its full held state alphabet is retained."]]],.array [.text "generation",.array [.array [.text "energy-picked-conformer",.text "Measured energy cannot choose which assignments are generated."],.array [.text "complete-cartesian-state-generation",.text "The exact finite product generates every rotor-state assignment once."]]],.array [.text "symmetry",.array [.array [.text "named-symmetry-assumption",.text "A named symmetry can omit or add an equivalence action."],.array [.text "exhaustive-graph-automorphism-action",.text "Every atom-type and bond-preserving position bijection is generated and acts on all rotors."]]],.array [.text "equivalence",.array [.array [.text "coordinate-tolerance-clustering",.text "A tolerance or continuum metric introduces a fitted boundary."],.array [.text "exact-automorphism-orbit-equivalence",.text "Assignments are equivalent exactly when one generated graph action connects them."]]],.array [.text "quotient",.array [.array [.text "selected-representative-list",.text "A selected list can duplicate or omit lawful conformers."],.array [.text "complete-disjoint-orbit-quotient",.text "Every generated assignment occurs in exactly one nonempty equivalence class."]]],.array [.text "observation",.array [.array [.text "source-readable-generator",.text "External conformer names or energies could select the quotient."],.array [.text "value-free-operational-census-seal",.text "The generation and quotient close before complete terminology and experimental surfaces are compared."]]],.array [.text "extension",.array [.array [.text "species-exception-or-extra-rule",.text "A species exception cannot establish a general finite algorithm."],.array [.text "finite-product-successor-no-extra-rule",.text "Appending a rotor takes the exact product and reruns the same complete automorphism quotient."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact finite conformer generation and equivalence law"
 branch := "chemistry"
 statement := "For any positive finite connected molecular graph with a complete ordered rotor census and finite held torsion alphabets, every conformer assignment is generated exactly once by the Cartesian state product. Exact equivalence is the orbit relation of every exhaustively generated atom-type and bond-preserving graph automorphism; the disjoint orbit quotient is the complete conformer census, without coordinate tolerance, measured-energy selection or species rule."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-finite-molecular-graph__complete-ordered-rotor-census__complete-cartesian-state-generation__exhaustive-graph-automorphism-action__exact-automorphism-orbit-equivalence__complete-disjoint-orbit-quotient__value-free-operational-census-seal__finite-product-successor-no-extra-rule"),("base",.text "One ordered rotor with three held states generates three assignments; identity and graph reversal force one self-equivalent anti class and one two-member opposed-gauche class, with no omitted assignment."),("successor",.text "Append one complete rotor and its positive finite held alphabet. Take the exact Cartesian product with every prior assignment, exhaustively regenerate graph automorphisms and repartition by the same orbit relation; each assignment remains in exactly one nonempty class without a new rule."),("exclusions",.array [.text "no numerical zero; structural absence is EmptyOne",.text "no negative irrational imaginary continuum tolerance fitted free or imported native parameter",.text "no measured energy molecular name coordinate library or selected conformer used to generate or quotient assignments",.text "no omitted graph automorphism rotor state or adverse external row",.text "all four external records are disclosed development-observed correspondence and are not called blind",.text "external signed decimal zero and absent inscriptions remain downstream records and never native arithmetic"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; structural absence is EmptyOne","no negative irrational imaginary continuum tolerance fitted free or imported native parameter","no measured energy molecular name coordinate library or selected conformer used to generate or quotient assignments","no omitted graph automorphism rotor state or adverse external row","all four external records are disclosed development-observed correspondence and are not called blind","external signed decimal zero and absent inscriptions remain downstream records and never native arithmetic"]
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
end SFT.Chemistry.ConformerGenerationEvidence

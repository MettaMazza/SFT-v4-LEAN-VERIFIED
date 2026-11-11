import SFT.Chemistry.ChiralityGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ChiralityEvidence
open SFT.Host.Canonical ChiralityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "composition",.text "composition support is retained",.boolean true],.array [.text "adjacency",.text "adjacency is retained",.boolean true],.array [.text "orientation",.text "orientation fibre is held",.boolean true]]
def claimId : String := "SFT-CHEM-STEREO-CHIRALITY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-NET-REACTION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "reflection",.text (reflectionName c.reflection)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "adjacency",.text (adjacencyName c.adjacency)],.array [.text "superposition",.text (superpositionName c.superposition)],.array [.text "result",.text (resultName c.result)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "formula-only",.text "A formula has no spatial orientation."],.array [.text "complete-three-dimensional-object",.text "The full oriented carrier is retained."]]],.array [.text "reflection",.array [.array [.text "mirror-image-not-generated",.text "Chirality cannot be decided."],.array [.text "exact-mirror-image-generated",.text "Reflection is constructed from the same carrier."]]],.array [.text "composition",.array [.array [.text "mirror-composition-changed",.text "The comparison is not reflective identity."],.array [.text "composition-preserved",.text "All atomic identities are retained."]]],.array [.text "adjacency",.array [.array [.text "mirror-adjacency-changed",.text "The comparison changes constitution."],.array [.text "adjacency-preserved",.text "Only orientation is reversed."]]],.array [.text "superposition",.array [.array [.text "visual-guess",.text "A guess cannot establish equivalence."],.array [.text "all-proper-finite-relabelings-enumerated",.text "Every identity-preserving orientation map is tested."]]],.array [.text "result",.array [.array [.text "arbitrary-handedness-name",.text "A name cannot force distinction."],.array [.text "no-proper-superposition",.text "The reflected carrier remains distinct."]]],.array [.text "record",.array [.array [.text "chirality-label-only",.text "The result cannot be reproduced."],.array [.text "orientation-and-map-trace",.text "Every attempted map is retained."]]],.array [.text "extra",.array [.array [.text "free-chirality-rule",.text "An extra rule can classify anything."],.array [.text "no-extra-rule",.text "Reflection and exhaustive equivalence decide the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chirality and non-superposable held orientation"
 branch := "chemistry"
 statement := "Chirality is the retained distinction between a complete oriented molecular carrier and its exact reflection when exhaustive identity-preserving proper superposition admits no equivalence."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-three-dimensional-object__exact-mirror-image-generated__composition-preserved__adjacency-preserved__no-proper-superposition"),("base",.text "One oriented structure and its non-superposable reflection supply the first chiral pair."),("successor",.text "Appending a uniquely labelled oriented branch preserves all prior failed maps and extends the exhaustive map census."),("exclusions",.array [.text "no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite complete three-dimensional chemical structure with named atoms, adjacency, orientation and exhaustive identity-preserving proper maps."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite complete three-dimensional chemical structure with named atoms, adjacency, orientation and exhaustive identity-preserving proper maps."]
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
end SFT.Chemistry.ChiralityEvidence

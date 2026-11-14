import SFT.Foundation.AdmissionControls
import SFT.Physics.NucleonBindingEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.NucleonBindingEntryEvidence
open SFT.Host.Canonical NucleonBindingEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "colour",.text (colourName c.colour)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "depth",.text (depthName c.depth)],.array [.text "ledger",.text (ledgerName c.ledger)],.array [.text "binding",.text (bindingName c.binding)],.array [.text "flavour",.text (flavourName c.flavour)],.array [.text "electromagnetic",.text (electromagneticName c.electromagnetic)],.array [.text "ordering",.text (orderingName c.ordering)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "How are admitted colour, confinement and quark laws used?"),("choices",.array [.array [.text "rewrite-predecessor-laws",.text "A successor cannot alter admitted receipts."],.array [.text "compose-immutable-predecessors",.text "The new law composes the exact admitted colour, depth, quark-root and proton-dressing carriers."]])],.object [("key",.text "colour"),("question",.text "What closes internal colour?"),("choices",.array [.array [.text "listed-three-colour-names",.text "Names do not prove a closed orbit."],.array [.text "complete-period-three-One-cycle",.text "The generated 1/7, 2/7, 4/7 cycle uses every colour position and sums exactly to the One."]])],.object [("key",.text "composition"),("question",.text "Which minimal words produce charged and neutral nucleons?"),("choices",.array [.array [.text "import-proton-neutron-labels",.text "Imported particle labels would select the result."],.array [.text "enumerate-complete-three-flavour-charge-words",.text "Among complete positive u/d count splits, two-up/one-down uniquely has unit positive charge and one-up/two-down uniquely closes to the empty neutral form."]])],.object [("key",.text "depth"),("question",.text "Which support bounds the nucleon ledger?"),("choices",.array [.array [.text "selected-binding-depth",.text "A chosen depth can tune a mass share."],.array [.text "admitted-upper-quark-depth-seven",.text "The already forced upper-quark cover supplies depth seven without nucleon data."]])],.object [("key",.text "ledger"),("question",.text "How are bare and held mass support partitioned?"),("choices",.array [.array [.text "free-binding-percentage",.text "A percentage read from observation is a parameter."],.array [.text "one-cell-and-complete-positive-predecessor",.text "Complete depth-seven binary support has one explicit cell and its unique 127-cell held predecessor."]])],.object [("key",.text "binding"),("question",.text "What mass-dominance statement follows?"),("choices",.array [.array [.text "qualitative-most-without-bound",.text "An unbounded slogan is not falsifiable."],.array [.text "bare-below-one-percent-held-above-ninety-nine",.text "Exact 1/128 is below 1/100 and exact 127/128 is above 99/100."]])],.object [("key",.text "flavour"),("question",.text "How is down/up ordering obtained?"),("choices",.array [.array [.text "borrowed-quark-mass-order",.text "Borrowing a measured ordering reverses the derivation."],.array [.text "exact-light-root-enclosure-order",.text "The admitted down/up cubic invariants give disjoint rational enclosures with a positive down-minus-up surplus."]])],.object [("key",.text "electromagnetic"),("question",.text "Can proton self-energy reverse that ordering?"),("choices",.array [.array [.text "ignore-or-fit-electromagnetic-effect",.text "Ignoring or fitting the competing carrier cannot close the sign."],.array [.text "compare-admitted-terminal-proton-dressing",.text "The exact lower flavour surplus exceeds the complete admitted proton electromagnetic dressing."]])],.object [("key",.text "ordering"),("question",.text "What follows for the nucleons?"),("choices",.array [.array [.text "assert-measured-mass-order",.text "An asserted ordering has no Fold certificate."],.array [.text "one-down-replacement-forces-neutron-heavier",.text "Common held support cancels; replacing one up by one down leaves a strictly positive net neutron surplus."]])],.object [("key",.text "target"),("question",.text "May PDG or NIST values enter execution?"),("choices",.array [.array [.text "external-target-readable",.text "Target access cannot seal a prediction."],.array [.text "target-inaccessible-until-seal",.text "No nucleon or measured quark mass is accessible to the executable law."]])],.object [("key",.text "provenance"),("question",.text "How is prior observation used?"),("choices",.array [.array [.text "conceal-observational-development",.text "Concealment misstates the derivation history."],.array [.text "registered-observational-prediction-protocol",.text "Observation informs the explicit law, then capability-closed execution seals before target release."]])],.object [("key",.text "extension"),("question",.text "May another mass term or percentage be added?"),("choices",.array [.array [.text "free-mass-term-or-percentage",.text "An ungenerated term is a parameter."],.array [.text "no-extra-rule",.text "Colour closure, depth support, exact roots and admitted electromagnetic dressing exhaust the declared grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005"
  title := "Terminal nucleon composition, binding dominance and mass ordering"
  branch := "physics"
  statement := "The generated period-three colour cycle closes as 1/7+2/7+4/7=One. Complete positive u/d count enumeration then uniquely gives the unit-charged word uud and empty-neutral word udd. At the admitted upper-quark depth seven, one of 128 cells is the explicit valence share and the positive predecessor 127/128 is the held-cycle share. Exact light-quark root enclosures place down above up by more than the admitted terminal proton electromagnetic dressing, so replacing one up by one down forces the neutron above the proton."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001", "SFT-PHYS-MATTER-QUARK-CUBICS-003", "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003", "SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := SFT.Foundation.AdmissionControls.admissionIdentity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [NucleonBindingEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity NucleonBindingEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.NucleonBindingEntryEvidence

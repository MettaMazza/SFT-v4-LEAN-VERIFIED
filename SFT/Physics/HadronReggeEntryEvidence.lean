import SFT.Foundation.AdmissionControls
import SFT.Physics.HadronReggeEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.HadronReggeEntryEvidence
open SFT.Host.Canonical HadronReggeEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "flavour",.text (flavourName c.flavour)],.array [.text "meson",.text (mesonName c.meson)],.array [.text "meson-partition",.text (mesonPartitionName c.mesonPartition)],.array [.text "baryon",.text (baryonName c.baryon)],.array [.text "exchange",.text (exchangeName c.exchange)],.array [.text "tube",.text (tubeName c.tube)],.array [.text "Regge",.text (ReggeName c.Regge)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "How are admitted colour and confinement results used?"),("choices",.array [.array [.text "rewrite-hadron-predecessors",.text "A successor cannot alter admitted receipts."],.array [.text "compose-immutable-hadron-predecessors",.text "The exact three-cycle, minimal singlets and confinement carrier remain immutable dependencies."]])],.object [("key",.text "flavour"),("question",.text "How is light-flavour support obtained?"),("choices",.array [.array [.text "import-named-flavour-table",.text "Names do not generate a support."],.array [.text "complete-generator-three-flavour-support",.text "The already forced generator three supplies every position of one complete light-flavour support."]])],.object [("key",.text "meson"),("question",.text "How is the light meson organization counted?"),("choices",.array [.array [.text "assert-nonet",.text "A conventional name does not prove its size."],.array [.text "enumerate-three-by-three-ordered-pairs",.text "Every flavour/antiflavour position is generated exactly once, forcing nine cells."]])],.object [("key",.text "meson-partition"),("question",.text "How does the nine-cell support split?"),("choices",.array [.array [.text "import-octet-singlet-representation",.text "An imported representation would select the answer."],.array [.text "one-invariant-and-positive-predecessor",.text "The unique complete diagonal invariant uses one cell class; its positive predecessor has eight classes."]])],.object [("key",.text "baryon"),("question",.text "How is the light baryon organization counted?"),("choices",.array [.array [.text "assert-octet-and-decuplet",.text "Named multiplets are not a derivation."],.array [.text "enumerate-three-place-flavour-words",.text "The complete three-place support over three flavours contains twenty-seven ordered words."]])],.object [("key",.text "exchange"),("question",.text "How is baryon support partitioned?"),("choices",.array [.array [.text "import-SU-three-decomposition",.text "A conventional group decomposition cannot be a premise."],.array [.text "enumerate-exchange-symmetry-classes",.text "Ten symmetric multisets, one fully antisymmetric class and two Fold hands of the remaining sixteen force ten, eight, eight and one."]])],.object [("key",.text "tube"),("question",.text "What does one fixed confinement-tube act contribute?"),("choices",.array [.array [.text "chosen-spin-dependent-increment",.text "A different free increment at each rank destroys structural closure."],.array [.text "one-retained-step-per-spin-successor",.text "Each rank successor adds the same held positive tube carrier exactly once."]])],.object [("key",.text "Regge"),("question",.text "What squared-support law follows?"),("choices",.array [.array [.text "fitted-mass-polynomial",.text "A fitted polynomial is not forced."],.array [.text "depth-independent-affine-successor",.text "Anchor plus one common positive carrier per successor forces exact affine squared support at every positive rank."]])],.object [("key",.text "target"),("question",.text "May PDG multiplets or resonance masses enter execution?"),("choices",.array [.array [.text "external-target-readable",.text "Target access cannot seal a prediction."],.array [.text "target-inaccessible-until-seal",.text "No external count, particle name, mass, uncertainty or source is accessible to the executable law."]])],.object [("key",.text "extension"),("question",.text "May residuals, slopes or correction terms be fitted?"),("choices",.array [.array [.text "free-residual-or-tension-fit",.text "An ungenerated correction would be a parameter."],.array [.text "no-extra-rule",.text "Generated flavour support, exchange class and one fixed tube act exhaust the declared grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-HADRON-REGGE-TERMINAL-005"
  title := "Terminal light-hadron multiplets and depth-independent Regge support"
  branch := "physics"
  statement := "Generator-three flavour support forces nine ordered flavour/antiflavour cells, partitioned as one invariant cell class and its eight-class positive predecessor.  Complete three-place flavour support forces twenty-seven cells; direct exchange enumeration partitions them as ten symmetric, two eight-cell mixed hands and one antisymmetric class.  Independently, one retained fixed-tube act per positive spin successor forces exact affine squared support.  The exact theorem governs normalized fixed-carrier support; whether physical resonance masses realize literal equal spacing is a separate post-seal measurement."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001", "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-HADRON-REGGE-TERMINAL-005",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-HADRON-REGGE-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [HadronReggeEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity HadronReggeEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.HadronReggeEntryEvidence

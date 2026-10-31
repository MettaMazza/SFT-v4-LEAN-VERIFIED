import SFT.Physics.VacuumDensityControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.VacuumDensityEvidence
open SFT.Host.Canonical VacuumDensityGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "volume",.text (volumeName c.volume)],.array [.text "cover",.text (coverName c.cover)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "observable",.text (observableName c.observable)],.array [.text "floor",.text (floorName c.floor)],.array [.text "radiative",.text (radiativeName c.radiative)],.array [.text "cosmic",.text (cosmicName c.cosmic)],.array [.text "geometry",.text (geometryName c.geometry)],.array [.text "typing",.text (typingName c.typing)],.array [.text "transport",.text (transportName c.transport)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "volume"),("question",.text "What fixes the spatial support?"),("choices",.array [.array [.text "borrowed-cosmic-volume",.text "A borrowed volume imports a model."],.array [.text "generator-three-cubed-volume",.text "The independently admitted generator and stable space rank force twenty-seven."]])],.object [("key",.text "cover"),("question",.text "Which binary depth covers that volume?"),("choices",.array [.array [.text "selected-depth-ten-or-twenty",.text "Selecting the desired exponent is circular."],.array [.text "least-cover-depth-five",.text "Explicit binary succession first covers twenty-seven at thirty-two."]])],.object [("key",.text "boundary"),("question",.text "Which labels must a complete local record retain?"),("choices",.array [.array [.text "one-label-per-depth",.text "One label omits half the Fold fibre."],.array [.text "both-held-labels-per-depth",.text "The Fold has exactly two distinct held labels at every depth."]])],.object [("key",.text "observable"),("question",.text "Is the claimed quantity amplitude or energy?"),("choices",.array [.array [.text "amplitude-relabeled-as-energy",.text "A one-leg support is not a complete energy observation."],.array [.text "two-leg-energy-self-composition",.text "Preparation-to-record energy support pairs the exact amplitude with itself."]])],.object [("key",.text "floor"),("question",.text "What is the least nonempty local energy support?"),("choices",.array [.array [.text "named-one-over-two-to-twenty",.text "Naming the prior value does not force it."],.array [.text "complete-boundary-energy-floor",.text "Depth five times two labels times two observation legs uniquely gives exponent twenty."]])],.object [("key",.text "radiative"),("question",.text "How is the zero-point mode ledger closed?"),("choices",.array [.array [.text "unbounded-mode-sum-as-local-density",.text "An unbounded sum erases finite support, common scale and quantity type."],.array [.text "complete-finite-ledger-and-half-One-mean",.text "Every finite complete odd-numerator spectrum sums exactly to support/2 and normalizes to the half-One."]])],.object [("key",.text "cosmic"),("question",.text "What is the cosmic vacuum density fraction?"),("choices",.array [.array [.text "local-floor-equals-cosmic-fraction",.text "The quantities have different supports and types."],.array [.text "terminal-eleven-sixteenths-share",.text "The admitted complete cosmic budget fixes the global fraction."]])],.object [("key",.text "geometry"),("question",.text "What normalizes the cosmological magnitude?"),("choices",.array [.array [.text "borrowed-continuum-coefficient",.text "A conventional field equation cannot be a premise."],.array [.text "three-space-squared-rate-carrier",.text "Three generated spatial source directions multiply the admitted squared expansion rate."]])],.object [("key",.text "typing"),("question",.text "May floor, fraction and dimensional Lambda be interchanged or the prior label rubber-stamped?"),("choices",.array [.array [.text "untyped-number-identification-or-rubber-stamp",.text "Equal-looking numbers without scale carriers are not one quantity, and preserving an old label cannot excuse a type error."],.array [.text "distinct-typed-quantities-and-prior-correction",.text "Each quantity retains its support, dimension and transport trace; the exact prior floor is retained while its unscaled cosmological relabeling is rejected."]])],.object [("key",.text "transport"),("question",.text "How does Lambda receive units?"),("choices",.array [.array [.text "fitted-dimensional-value",.text "A fitted unit magnitude is a parameter."],.array [.text "postseal-rate-squared-over-speed-squared",.text "A held rate and limiting speed transport the sealed normalized relation covariantly."]])],.object [("key",.text "measurement"),("question",.text "May a dark-energy value select the law?"),("choices",.array [.array [.text "measurement-readable-before-seal",.text "That would fit the magnitude."],.array [.text "postseal-only-comparison",.text "Floor, share and normalized Lambda seal before external cosmology is opened."]])],.object [("key",.text "extension"),("question",.text "May another scale or coefficient enter?"),("choices",.array [.array [.text "free-vacuum-scale",.text "A second vacuum ruler violates the one-axis law."],.array [.text "no-extra-rule",.text "Cover, labels, observation legs, cosmic share and held transport exhaust the grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035"
  title := "Terminal vacuum floor, cosmic density and scale-transport law"
  branch := "physics"
  statement := "Generator-three space has volume twenty-seven and unique least binary covering depth five. Both held Fold labels at every covering level force a complete boundary-record depth ten. Its least nonempty local vacuum amplitude is One/2^10; energy is the complete two-leg self-composition, uniquely forcing the local energy floor One/2^20. This local dimensionless cell floor is not the cosmological density fraction. The terminal cosmic vacuum share is 11/16, and three-space rate geometry forces the separately typed normalized cosmological magnitude Lambda(c/H)^2=3(11/16)=33/16. A dimensional Lambda follows only after a held external rate and speed reference: Lambda=(33/16)H^2/c^2."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-EXACT-OPERATIONS-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003", "SFT-PHYS-COSMO-COMPLETE-BUDGET-001", "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032", "SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030", "SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [VacuumDensityControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity VacuumDensityControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.VacuumDensityEvidence

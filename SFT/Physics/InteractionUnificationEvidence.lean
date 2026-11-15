import SFT.Physics.InteractionUnificationControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.InteractionUnificationEvidence
open SFT.Host.Canonical InteractionUnificationGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "sector",.text (sectorName c.sector)],.array [.text "standing",.text (standingName c.standing)],.array [.text "table",.text (tableName c.table)],.array [.text "mass",.text (massName c.mass)],.array [.text "support",.text (supportName c.support)],.array [.text "order",.text (orderName c.order)],.array [.text "coincidence",.text (coincidenceName c.coincidence)],.array [.text "period",.text (periodName c.period)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "sector"),("question",.text "Which interaction sectors enter?"),("choices",.array [.array [.text "selected-familiar-sectors",.text "Selection omits generated prime sectors or the exclusion boundary."],.array [.text "complete-prime-ladder-through-seven",.text "The forced cover ceiling retains exactly two, three, five and seven."]])],.object [("key",.text "standing"),("question",.text "What unifies odd sectors?"),("choices",.array [.array [.text "named-unification-point",.text "A name does not prove membership or uniqueness."],.array [.text "unique-self-antipodal-half-One-mode",.text "Complete interior-mode enumeration places half-One in every odd sector and nowhere else as a self-antipode."]])],.object [("key",.text "table"),("question",.text "How are sector relations generated?"),("choices",.array [.array [.text "independent-fitted-couplings",.text "Independent values violate the one-generator law."],.array [.text "single-m-indexed-exact-table",.text "Coupling, mixing, mass shortfall and mediator count are all exact functions of m."]])],.object [("key",.text "mass"),("question",.text "What is the rest carrier?"),("choices",.array [.array [.text "inserted-mass-parameter",.text "An inserted mass is not forced by the holding relation."],.array [.text "positive-shortfall-from-unison",.text "The mass carrier is exactly the positive share required to reassemble the One."]])],.object [("key",.text "support"),("question",.text "How do sectors run together?"),("choices",.array [.array [.text "independent-scale-axes",.text "Independent axes cannot define exact separation or convergence."],.array [.text "common-positive-binary-support",.text "Every sector receives the same generated support R and keeps its identity m."]])],.object [("key",.text "order"),("question",.text "What orders sector shares?"),("choices",.array [.array [.text "target-named-physical-order",.text "A physical label cannot choose an inequality."],.array [.text "exact-positive-m-difference-gap",.text "For lower m and upper n the gap is (n-m)/((m+R)(n+R)), always positive."]])],.object [("key",.text "coincidence"),("question",.text "Can finite sectors exactly coincide?"),("choices",.array [.array [.text "asserted-unification-crossing",.text "A crossing contradicts the positive pair-gap identity."],.array [.text "finite-triple-coincidence-forbidden",.text "Every finite pair gap is positive although all gaps shrink by successor."]])],.object [("key",.text "period"),("question",.text "How are gravity, EM and strong recurrences related?"),("choices",.array [.array [.text "selected-force-periods",.text "Selected labels provide no Fold traces."],.array [.text "complete-one-two-three-period-dictionary",.text "Exact first-return traces give periods one, two and three and joint recurrence six."]])],.object [("key",.text "comparison"),("question",.text "Which physical running record is retained?"),("choices",.array [.array [.text "flat-EM-and-inconsistent-slope-bundle",.text "It conflicts internally and with admitted electromagnetic running."],.array [.text "terminal-carrier-specific-running-and-anchors",.text "The sealed strong/EM directions and complete force-sector anchors replace the adverse bundle."]])],.object [("key",.text "extension"),("question",.text "May another unification rule enter?"),("choices",.array [.array [.text "free-group-or-crossing-scale",.text "An added group or fitted crossing scale is a free premise."],.array [.text "no-extra-rule",.text "Standing modes, sector table, support and period traces exhaust the grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025"
  title := "Prime-sector standing-mode, interaction and period unification"
  branch := "physics"
  statement := "The complete prime-sector ladder two, three, five and seven is governed by one exact table.  Sector m has holding coupling (m-1)/m, positive mass shortfall 1/m, mixing share 1/(m-1), m-squared take One mediators and interior standing modes j/(m-1).  Half-One is the unique self-antipodal standing mode common to every odd prime sector and is absent from the fundamental two-sector interior.  On common positive support R, every sector has holding share (m+R-1)/(m+R); exact positive pair gaps preserve strict sector order and forbid finite triple coincidence while shrinking under every support successor.  The Fold period dictionary is gravity one, electromagnetism two, strong three and joint recurrence six.  The prior bundle claiming both slope m-1 and an abelian slope of zero is internally inconsistent and is rejected; the admitted terminal running laws replace it."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002", "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003", "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002", "SFT-PHYS-STRONG-RUNNING-DIRECTION-002", "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003", "SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006", "SFT-PHYS-VALIDATION-FORCE-SECTOR-ANCHORS-003", "SFT-PHYS-VALIDATION-VACUUM-POLARIZATION-003", "SFT-MATH-ORBIT-NUMBER-THEORY-002", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [InteractionUnificationControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity InteractionUnificationControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.InteractionUnificationEvidence

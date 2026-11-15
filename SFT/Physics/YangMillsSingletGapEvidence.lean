import SFT.Physics.YangMillsSingletGapControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.YangMillsSingletGapEvidence
open SFT.Host.Canonical YangMillsSingletGapGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "sector",.text (sectorName c.sector)],.array [.text "support",.text (supportName c.support)],.array [.text "vacuum",.text (vacuumName c.vacuum)],.array [.text "gap",.text (gapName c.gap)],.array [.text "confinement",.text (confinementName c.confinement)],.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "orbit",.text (orbitName c.orbit)],.array [.text "depth",.text (depthName c.depth)],.array [.text "prior",.text (priorName c.prior)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "sector"),("question",.text "Which interaction sector is tested?"),("choices",.array [.array [.text "named-Yang-Mills-sector",.text "A conventional name does not generate colour structure."],.array [.text "generated-colour-three-sector",.text "The forced prime ladder supplies the complete colour-three fibre and eight non-return pair cells."]])],.object [("key",.text "support"),("question",.text "Which states are physically observable?"),("choices",.array [.array [.text "isolated-colour-carrier",.text "The admitted confinement law leaves the isolated-colour observation record empty."],.array [.text "complete-colour-singlet-support",.text "An antipodal pair or complete colour fibre closes every colour label into a physical singlet."]])],.object [("key",.text "vacuum"),("question",.text "How is the vacuum represented?"),("choices",.array [.array [.text "numerical-zero-vacuum",.text "Numerical zero is outside the Fold proof domain."],.array [.text "empty-excitation-record",.text "The vacuum is the empty physical-excitation record, not a proof scalar."]])],.object [("key",.text "gap"),("question",.text "What separates the first physical singlet from the vacuum?"),("choices",.array [.array [.text "massless-or-fitted-gap",.text "A fitted value or an empty mass label conflates local carrier and physical singlet."],.array [.text "exact-positive-one-third-complement",.text "The strong two-thirds holding share leaves one-third as the unique positive complement to the One."]])],.object [("key",.text "confinement"),("question",.text "What prevents an isolated colour state?"),("choices",.array [.array [.text "bounded-or-free-separation-work",.text "Bounded or free work permits an unrecorded free colour state."],.array [.text "fixed-two-thirds-positive-work-successor",.text "Every separation successor adds the retained two-thirds colour work while the tube width remains fixed."]])],.object [("key",.text "carrier"),("question",.text "Does local masslessness imply a gapless physical spectrum?"),("choices",.array [.array [.text "conflate-local-carrier-with-physical-singlet",.text "The local carrier is not an observable isolated colour state."],.array [.text "retain-local-massless-physical-gapped-distinction",.text "The empty local mass label coexists with a positive least singlet excitation record."]])],.object [("key",.text "orbit"),("question",.text "How are gap and coupling related?"),("choices",.array [.array [.text "selected-gap-coupling-pair",.text "A selected pair does not prove closure or recurrence."],.array [.text "complete-period-two-Fold-partition",.text "One-third folds to two-thirds, two-thirds folds to one-third and the pair reassembles the One."]])],.object [("key",.text "depth"),("question",.text "Does positivity hold beyond a finite sample?"),("choices",.array [.array [.text "bounded-depth-census-or-completed-infinity",.text "A bounded sample or completed infinity cannot certify every finite successor."],.array [.text "positive-finite-successor-induction",.text "Sector identity preserves one-third while each successor adds positive two-thirds confinement work."]])],.object [("key",.text "prior"),("question",.text "How is the earlier broad masslessness statement handled?"),("choices",.array [.array [.text "repeat-no-massless-strong-excitation",.text "That wording contradicts the admitted locally massless strong carrier."],.array [.text "correct-free-singlet-spectrum-boundary",.text "The exact claim is no free massless colour-singlet excitation, not no locally massless colour carrier."]])],.object [("key",.text "extension"),("question",.text "May an extra mass scale or continuum law enter?"),("choices",.array [.array [.text "free-scale-action-or-continuum-limit",.text "An added scale or action is a new premise."],.array [.text "no-extra-rule",.text "The normalized finite Fold theorem ends at its declared colour-singlet boundary."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-YANG-MILLS-SINGLET-GAP-TERMINAL-026"
  title := "Finite Fold colour-singlet positive excitation gap"
  branch := "physics"
  statement := "The generated colour-three sector holds two-thirds of the One and leaves the exact positive one-third complement.  The two parts form a complete period-two Fold orbit.  Colour observation admits only a nonempty closed singlet, with an antipodal pair as the least support, while the isolated colour record is empty and separation work increases by two-thirds at every positive finite successor.  Consequently the normalized least physical colour-singlet excitation has the depth-invariant positive gap one-third.  The locally propagating colour carrier nevertheless retains an empty mass label and One-cell causal motion: local carrier masslessness and physical colour-singlet gaplessness are not the same proposition."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003", "SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013", "SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014", "SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-YANG-MILLS-SINGLET-GAP-TERMINAL-026",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-YANG-MILLS-SINGLET-GAP-TERMINAL-026",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [YangMillsSingletGapControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity YangMillsSingletGapControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.YangMillsSingletGapEvidence

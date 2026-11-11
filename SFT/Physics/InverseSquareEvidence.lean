import SFT.Physics.InverseSquareControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.InverseSquareEvidence
open SFT.Host.Canonical InverseSquareGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "source",.text (sourceName c.source)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "rank",.text (rankName c.rank)],.array [.text "coverage",.text (coverageName c.coverage)],.array [.text "scale",.text (scaleName c.scale)],.array [.text "allocation",.text (allocationName c.allocation)],.array [.text "profile",.text (profileName c.profile)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "source"),("question",.text "What is diluted?"),("choices",.array [.array [.text "unbound-response-number",.text "A detached number has no conserved source identity."],.array [.text "one-retained-source-carrier",.text "Every response share retains the same localized source trace."]])],.object [("key",.text "conservation"),("question",.text "Does source support change with distance?"),("choices",.array [.array [.text "distance-created-or-lost-source",.text "Changing total support violates the admitted conserved-source law."],.array [.text "same-complete-source-at-every-boundary",.text "Every complete boundary carries the same total source support."]])],.object [("key",.text "rank"),("question",.text "What fixes support growth?"),("choices",.array [.array [.text "free-or-measured-exponent",.text "A free or measured exponent reverses forcing."],.array [.text "forced-rank-two-boundary",.text "The already admitted boundary law fixes two retained scale coordinates."]])],.object [("key",.text "coverage"),("question",.text "Which cells receive source support?"),("choices",.array [.array [.text "selected-boundary-cells",.text "Selection breaks equivalence and conservation accounting."],.array [.text "all-equivalent-pair-cells",.text "Every generated pair cell receives one exact equal share."]])],.object [("key",.text "scale"),("question",.text "How does distance transport boundary cells?"),("choices",.array [.array [.text "unlabelled-scale-factor",.text "An unlabelled factor loses one boundary coordinate."],.array [.text "distance-ratio-paired-with-itself",.text "Rank two pairs the exact distance ratio once along each retained direction."]])],.object [("key",.text "allocation"),("question",.text "What is response per cell?"),("choices",.array [.array [.text "fitted-response-profile",.text "A fit can select the target falloff."],.array [.text "source-over-complete-boundary",.text "Conservation and equivalence force equal exact source shares."]])],.object [("key",.text "profile"),("question",.text "Which distance profile follows?"),("choices",.array [.array [.text "inverse-linear",.text "Linear falloff omits one retained boundary coordinate."],.array [.text "inverse-square",.text "Rank-two pair support grows as r paired with r, so equal response is divided by r squared."],.array [.text "inverse-cubic",.text "Cubic falloff adds a third boundary coordinate already held normal."],.array [.text "target-fitted-power",.text "A fitted power is target-selected."]])],.object [("key",.text "generality"),("question",.text "What closes every positive distance scale?"),("choices",.array [.array [.text "finite-distance-table",.text "A table has no successor proof."],.array [.text "pair-product-successor-induction",.text "Every added scale cell generates its complete pairs and preserves source division."]])],.object [("key",.text "measurement"),("question",.text "What is the direction of empirical testing?"),("choices",.array [.array [.text "measurement-to-exponent",.text "A measured exponent cannot become the law premise."],.array [.text "sealed-exponent-to-blind-measurement",.text "The forced profile is sealed before target release and may be falsified but not rewritten."]])],.object [("key",.text "record"),("question",.text "What evidence remains?"),("choices",.array [.array [.text "reported-exponent-only",.text "A label alone cannot reproduce conservation, cells or comparison."],.array [.text "source-bound-cell-and-measurement-trace",.text "Source, rank, pair cells, response, seal and every target row remain held."]])],.object [("key",.text "extension"),("question",.text "Is a geometric constant added?"),("choices",.array [.array [.text "extra-shape-or-scale",.text "An added coefficient or shape is not supplied by complete equivalent support."],.array [.text "no-extra-rule",.text "Conservation, rank two and equal allocation force the full relation."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-FIELD-INVERSE-SQUARE-001"
  title := "Inverse-square dilution from rank-two boundary support"
  branch := "physics"
  statement := "For one conserved source distributed without preference over every equivalent cell of the forced rank-two boundary, increasing source distance by an exact positive ratio r increases complete boundary support by r paired with r and therefore forces response per cell to be the source divided by r squared. The exponent is derived before and independently of measurement."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-FIELD-SOURCE-RESPONSE-001", "SFT-PHYS-FIELD-CONSERVED-SOURCE-001", "SFT-PHYS-FIELD-GEOMETRIC-DILUTION-001", "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-HOSTILE-PACKAGE-001", "SFT-PHYS-MEAS-VALUE-RECORD-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-FIELD-INVERSE-SQUARE-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-FIELD-INVERSE-SQUARE-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [InverseSquareControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity InverseSquareControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.InverseSquareEvidence

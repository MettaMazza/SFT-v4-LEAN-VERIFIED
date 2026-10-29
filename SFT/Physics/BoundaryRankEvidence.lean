import SFT.Physics.BoundaryRankControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.BoundaryRankEvidence
open SFT.Host.Canonical BoundaryRankGrammar

def candidateRecord (c : Candidate) : SFT.Host.Canonical.Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "normal",.text (normalName c.normal)],.array [.text "incidence",.text (incidenceName c.incidence)],.array [.text "rank",.text (rankName c.rank)],.array [.text "value",.text (valueName c.value)],.array [.text "scale",.text (scaleName c.scale)],.array [.text "coverage",.text (coverageName c.coverage)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : SFT.Host.Canonical.Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "Which spatial carrier is bounded?"),("choices",.array [.array [.text "unbound-coordinate-space",.text "An unbound coordinate collection has no forced dimension identity."],.array [.text "forced-three-direction-carrier",.text "The admitted three-space result supplies the complete independent-direction support."]])],.object [("key",.text "normal"),("question",.text "What distinguishes boundary from interior?"),("choices",.array [.array [.text "no-held-source-normal",.text "Without a held normal relation the boundary is not source-relative."],.array [.text "one-held-source-normal",.text "A localized source-to-boundary path holds exactly one normal direction."]])],.object [("key",.text "incidence"),("question",.text "Which directions remain on the boundary?"),("choices",.array [.array [.text "selected-tangent-subset",.text "A selected subset can omit a free boundary direction."],.array [.text "all-nonnormal-directions-retained",.text "Every independent direction not held normal remains in boundary incidence."]])],.object [("key",.text "rank"),("question",.text "How is rank counted without signed subtraction?"),("choices",.array [.array [.text "signed-dimension-minus-one",.text "A signed scalar expression is not the positive proof witness."],.array [.text "unique-positive-predecessor",.text "The boundary rank is the positive count whose successor by the held normal reassembles space."]])],.object [("key",.text "value"),("question",.text "Which boundary rank reassembles three-space?"),("choices",.array [.array [.text "rank-one",.text "One plus the held normal does not exhaust three directions."],.array [.text "rank-two",.text "Two followed by the held normal successor reassembles the forced count three."],.array [.text "rank-three",.text "Three plus the held normal exceeds the carrier."],.array [.text "target-selected-rank",.text "A measured exponent cannot select boundary rank."]])],.object [("key",.text "scale"),("question",.text "How does equivalent support scale?"),("choices",.array [.array [.text "linear-or-unlabelled-repetition",.text "Unlabelled repetition loses one retained boundary coordinate."],.array [.text "complete-pair-cell-product",.text "Each scale cell on one boundary direction pairs once with each cell on the other."]])],.object [("key",.text "coverage"),("question",.text "Which boundary cells are counted?"),("choices",.array [.array [.text "partial-boundary-sample",.text "A sample cannot establish complete geometric dilution."],.array [.text "complete-equivalent-boundary-support",.text "Every pair cell on the boundary is retained once."]])],.object [("key",.text "generality"),("question",.text "What closes arbitrary positive scale?"),("choices",.array [.array [.text "fixed-scale-table",.text "A finite table does not prove the next scale."],.array [.text "pair-product-successor-closure",.text "Adding a scale cell appends its pair with every cell on both retained directions."]])],.object [("key",.text "measurement"),("question",.text "May measured falloff select rank?"),("choices",.array [.array [.text "measured-rank-input",.text "That reverses the derivation-to-measurement boundary."],.array [.text "rank-sealed-before-measurement",.text "Physical response tests only after structural rank is sealed."]])],.object [("key",.text "extension"),("question",.text "Is another geometric rule added?"),("choices",.array [.array [.text "extra-boundary-rule",.text "An added shape or exponent is not supplied by the dependencies."],.array [.text "no-extra-rule",.text "Three-space, one held normal and complete incidence force rank two."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001"
  title := "Rank-two boundary of three-space"
  branch := "physics"
  statement := "For a complete boundary surrounding a localized source in the forced three-direction spatial carrier, holding one source-normal direction leaves exactly the unique positive predecessor rank two as free boundary organization; scaled equivalent boundary support is therefore the complete pair-cell product."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-EQUIVALENCE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-MATH-GEOMETRY-TOPOLOGY-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : SFT.Host.Canonical.Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := identity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : SFT.Host.Canonical.Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := identity (.array [.text "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001",.array ((registrationData "").dependencies.map SFT.Host.Canonical.Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : SFT.Host.Canonical.Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.array [BoundaryRankControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity BoundaryRankControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : SFT.Host.Canonical.Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.BoundaryRankEvidence

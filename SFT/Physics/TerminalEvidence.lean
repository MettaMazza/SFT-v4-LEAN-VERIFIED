import SFT.Physics.TerminalControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.TerminalEvidence
open SFT.Host.Canonical TerminalGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "base",.text (baseName c.base)],.array [.text "order",.text (orderName c.order)],.array [.text "support",.text (supportName c.support)],.array [.text "down",.text (downName c.down)],.array [.text "up",.text (upName c.up)],.array [.text "channel",.text (channelName c.channel)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "base"),("question",.text "Which product is refined?"),("choices",.array [.array [.text "replace-cubic-product",.text "Replacement erases the admitted cubic."],.array [.text "retain-admitted-sharpened-product",.text "The terminal law refines and preserves the admitted 3/1454 carrier."]])],.object [("key",.text "order"),("question",.text "Which self-coupling order acts on the product?"),("choices",.array [.array [.text "selected-linear-or-square-order",.text "A lower selected order does not act once on every root."],.array [.text "one-alpha-per-three-root",.text "The cubic product carries one self-coupling factor per generated root, forcing alpha cubed."]])],.object [("key",.text "support"),("question",.text "Across what support is that action distributed?"),("choices",.array [.array [.text "single-channel-support",.text "One channel omits the complete three-root carrier."],.array [.text "complete-generator-volume",.text "Three roots across three generated channels force the complete three-cubed support."]])],.object [("key",.text "down"),("question",.text "What is the unswept depth weight?"),("choices",.array [.array [.text "free-depth-coefficient",.text "A free coefficient is a parameter."],.array [.text "forced-down-cover-depth",.text "The admitted terminal fine-structure construction independently forces down depth five."]])],.object [("key",.text "up"),("question",.text "How does the successor cover contribute?"),("choices",.array [.array [.text "bare-up-depth",.text "A bare successor depth ignores transport between orders."],.array [.text "one-alpha-transported-up-depth",.text "The forced up depth seven enters the next self-coupling order through one alpha transport."]])],.object [("key",.text "channel"),("question",.text "How is transported up-depth shared?"),("choices",.array [.array [.text "undistributed-up-depth",.text "An undistributed successor counts every colour channel as one."],.array [.text "one-complete-colour-share",.text "One transported contribution per complete colour carrier forces division by three."]])],.object [("key",.text "orientation"),("question",.text "How does a retained self-coupling alter the product?"),("choices",.array [.array [.text "append-unheld-product",.text "Appending creates an unaccounted product carrier."],.array [.text "hold-correction-from-product",.text "The interaction is retained inside the existing normalized product and is held from its available part."]])],.object [("key",.text "target"),("question",.text "May lepton measurements enter the executable relation?"),("choices",.array [.array [.text "measurement-readable-relation",.text "That would fit the failed target."],.array [.text "measurement-inaccessible-until-seal",.text "Only admitted exact V3 dependencies enter before the seal."]])],.object [("key",.text "provenance"),("question",.text "How is this post-failure refinement classified?"),("choices",.array [.array [.text "mislabel-as-blind-forward-discovery",.text "The failed comparison was already observed."],.array [.text "observational-derivation-disclosed",.text "The development observation is disclosed while executable inputs remain source-closed."]])],.object [("key",.text "extension"),("question",.text "May another correction be added?"),("choices",.array [.array [.text "extra-fit-term",.text "An additional term is a free parameter."],.array [.text "no-extra-rule",.text "The first complete terminal self-coupling exhausts the registered grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001"
  title := "Terminal self-coupling refinement of the charged-lepton cubic"
  branch := "physics"
  statement := "The admitted charged-lepton cubic is refined by the complete terminal electromagnetic self-coupling of its three-root product: alpha to the generator-three order is distributed over the complete three-cubed carrier and weighted once by the forced cover-depth pair five and seven, with the up-depth transported through one alpha and one colour channel.  The exact correction is held from 3/1454."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-ALGEBRA-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [TerminalControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity TerminalControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.TerminalEvidence

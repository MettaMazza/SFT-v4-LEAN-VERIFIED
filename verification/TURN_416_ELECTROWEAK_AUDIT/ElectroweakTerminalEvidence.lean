import SFT.Physics.ElectroweakTerminalControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ElectroweakTerminalEvidence
open SFT.Host.Canonical ElectroweakTerminalGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "terminal",.text (terminalName c.terminal)],.array [.text "support",.text (supportName c.support)],.array [.text "relation",.text (relationName c.relation)],.array [.text "correction",.text (correctionName c.correction)],.array [.text "sign",.text (signName c.sign)],.array [.text "enumeration",.text (enumerationName c.enumeration)],.array [.text "minimality",.text (minimalityName c.minimality)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries the precision successor?"),("choices",.array [.array [.text "detached-measured-number",.text "A measured number has no forward Fold dependency trace."],.array [.text "admitted-lower-law-carrier",.text "The already admitted lower law supplies the typed carrier."]])],.object [("key",.text "terminal"),("question",.text "Which finite structural stage is used?"),("choices",.array [.array [.text "selected-intermediate-stage",.text "An intermediate stage chosen for agreement is a fit."],.array [.text "complete-promotion-termination",.text "The finite direction-promotion object ends after its generator-successor rung count."]])],.object [("key",.text "support"),("question",.text "How is terminal support formed?"),("choices",.array [.array [.text "free-scale-support",.text "A free scale is a parameter."],.array [.text "complete-binary-terminal-support",.text "Complete binary words at the forced terminal rung count supply all support cells."]])],.object [("key",.text "relation"),("question",.text "Which typed relation is retained?"),("choices",.array [.array [.text "free-running-level-or-imported-renormalization",.text "The alternative loses a required carrier or adds an unforced operation."],.array [.text "level-thirteen-charged-over-four-neutral-pairs-plus-alpha-over-seventeen",.text "Complete terminal support fixes the level and return divisor; charged and neutral labelled pair supports fix the base share."]])],.object [("key",.text "correction"),("question",.text "How is the terminal self-coupling transported?"),("choices",.array [.array [.text "fitted-additive-offset",.text "A fitted offset reads the target."],.array [.text "single-typed-terminal-alpha-transport",.text "The already sealed terminal self-coupling crosses the uniquely typed return or charged-colour carrier once."]])],.object [("key",.text "sign"),("question",.text "Which orientation preserves the typed whole?"),("choices",.array [.array [.text "target-selected-orientation",.text "A target-selected sign is not structural."],.array [.text "orientation-fixed-by-share-or-retention",.text "A channel share receives its positive return; retained hierarchy support is the positive complement of transported support."]])],.object [("key",.text "enumeration"),("question",.text "Are all declared forms generated?"),("choices",.array [.array [.text "selected-neighbourhood",.text "A selected neighbourhood cannot prove uniqueness."],.array [.text "complete-registered-product",.text "Every coordinate is paired with every coordinate on every other registered axis."]])],.object [("key",.text "minimality"),("question",.text "Are shorter forms retained as controls?"),("choices",.array [.array [.text "successor-without-lower-controls",.text "A terminal answer alone hides whether the lower form was necessary."],.array [.text "bare-and-intermediate-forms-preserved",.text "The admitted bare form and every omitted-carrier predecessor remain explicit rejected or lower-order controls."]])],.object [("key",.text "measurement"),("question",.text "Can an external target select the survivor?"),("choices",.array [.array [.text "target-visible-before-seal",.text "That reverses empirical direction."],.array [.text "exact-result-sealed-before-target-release",.text "The exact fraction, census and source manifest seal before comparison."]])],.object [("key",.text "extension"),("question",.text "May another term be added?"),("choices",.array [.array [.text "free-extra-correction",.text "An extra term is a free parameter."],.array [.text "no-extra-rule",.text "The completed promotion, support, typed transport and return exhaust this grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003"
  title := "Terminal exact on-shell electroweak Fold share"
  branch := "physics"
  statement := "The four-rung terminal alpha object generates complete binary support sixteen. Holding the three generator directions leaves running level thirteen. At that level the charged squared support is fifteen squared and the four neutral pair channels carry fourteen squared each, forcing 225/1009. The sole terminal self-return crosses the complete support successor seventeen once, adding exact alpha/17 and forcing the terminal on-shell share before measurement."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [ElectroweakTerminalControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity ElectroweakTerminalControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.ElectroweakTerminalEvidence

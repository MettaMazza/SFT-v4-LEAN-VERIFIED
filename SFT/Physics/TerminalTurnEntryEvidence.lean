import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalTurnEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.TerminalTurnEntryEvidence
open SFT.Host.Canonical TerminalTurnEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "sectors",.text (sectorsName c.sectors)],.array [.text "return",.text (returnName c.«return»)],.array [.text "depth",.text (depthName c.depth)],.array [.text "support",.text (supportName c.support)],.array [.text "join",.text (joinName c.join)],.array [.text "domain",.text (domainName c.domain)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What represents a finite turn?"),("choices",.array [.array [.text "imported-continuum-circle",.text "A continuum circle imports an ungenerated object."],.array [.text "exact-generated-turn-carrier",.text "The turn is represented by exact complete sectors and one held return."]])],.object [("key",.text "sectors"),("question",.text "How many complete sectors occur?"),("choices",.array [.array [.text "selected-sector-count",.text "A selected count is a parameter."],.array [.text "generator-three-complete-sectors",.text "The admitted generator supplies exactly three complete sectors."]])],.object [("key",.text "return"),("question",.text "What remains beyond the complete sectors?"),("choices",.array [.array [.text "free-decimal-remainder",.text "A decimal remainder is fitted."],.array [.text "one-positive-return",.text "The exact incomplete residue is the sole returning One carrier."]])],.object [("key",.text "depth"),("question",.text "Through which depth does the return pass?"),("choices",.array [.array [.text "selected-return-depth",.text "A selected depth can tune the projection."],.array [.text "forced-up-cover-depth-seven",.text "The terminal promotion object already forces up-depth seven."]])],.object [("key",.text "support"),("question",.text "What terminates the return?"),("choices",.array [.array [.text "unbounded-or-selected-support",.text "An unbounded or selected support has no closure."],.array [.text "four-rung-binary-support-sixteen",.text "Four promotion rungs force complete binary support sixteen."]])],.object [("key",.text "join"),("question",.text "How are the typed carriers composed?"),("choices",.array [.array [.text "untyped-sum-or-product",.text "Untyped composition loses return order."],.array [.text "nested-positive-return-ratio",.text "The unique typed order is generator plus One over up-depth plus One over terminal support."]])],.object [("key",.text "domain"),("question",.text "May an irrational turn value enter?"),("choices",.array [.array [.text "irrational-or-floating-turn",.text "That violates the exact Fold domain."],.array [.text "exact-rational-projection",.text "The finite continued ratio remains an exact positive fraction."]])],.object [("key",.text "provenance"),("question",.text "How is the observed rotational question handled?"),("choices",.array [.array [.text "target-readable-shortcut",.text "A shortcut cannot seal a generated prediction."],.array [.text "registered-observational-prediction-protocol",.text "Observation informs the explicit question; target-free execution enumerates and seals the relation."]])],.object [("key",.text "extension"),("question",.text "May another remainder be appended?"),("choices",.array [.array [.text "extra-turn-term",.text "The four-rung object is terminal."],.array [.text "no-extra-rule",.text "No promotion direction or return support remains."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004"
  title := "Terminal exact finite turn projection"
  branch := "physics"
  statement := "A diameter-normalized finite turn has three complete generator sectors.  Its sole remaining return passes through the forced up-depth seven and the complete binary support sixteen of the four-rung terminal promotion object, forcing the exact continued ratio 3 + 1/(7 + 1/16) = 355/113.  This is an exact rational Fold projection, not an imported irrational proof value."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-EXACT-OPERATIONS-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [TerminalTurnEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity TerminalTurnEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.TerminalTurnEntryEvidence

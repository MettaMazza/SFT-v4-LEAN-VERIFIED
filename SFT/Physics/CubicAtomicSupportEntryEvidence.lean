import SFT.Foundation.AdmissionControls
import SFT.Physics.CubicAtomicSupportEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CubicAtomicSupportEntryEvidence
open SFT.Host.Canonical CubicAtomicSupportEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "support",.text (supportName c.support)],.array [.text "operation",.text (operationName c.operation)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "depth",.text (depthName c.depth)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "trace",.text (traceName c.trace)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries the cubic atomic support?"),("choices",.array [.array [.text "untyped-observed-label",.text "A label alone is not a generated law."],.array [.text "generated-exact-Fold-carrier",.text "The carrier is constructed from admitted exact Fold counts and relations."]])],.object [("key",.text "support"),("question",.text "Which support is used?"),("choices",.array [.array [.text "selected-partial-support",.text "A selected subset can tune the result."],.array [.text "complete-typed-support",.text "Every support cell named by the law is generated and retained."]])],.object [("key",.text "operation"),("question",.text "Which operation composes the relation?"),("choices",.array [.array [.text "imported-continuum-operation",.text "An imported continuum operation violates the exact domain."],.array [.text "exact-positive-Fold-operation",.text "Only exact positive composition, ratio and guarded Take occur."]])],.object [("key",.text "orientation"),("question",.text "How is direction retained?"),("choices",.array [.array [.text "signed-or-erased-direction",.text "Signed proof values or erased direction violate the domain."],.array [.text "held-label-orientation",.text "Direction is represented by retained labels and ordered positive Take."]])],.object [("key",.text "depth"),("question",.text "How is depth chosen?"),("choices",.array [.array [.text "selected-depth",.text "A chosen depth is a parameter."],.array [.text "forced-counted-depth",.text "The binary, generator-three and already admitted covering counts force the depth."]])],.object [("key",.text "provenance"),("question",.text "May measured atomic data enter the law?"),("choices",.array [.array [.text "measurement-readable-relation",.text "A measured target cannot construct or select the survivor."],.array [.text "target-inaccessible-formal-relation",.text "The formal module contains no measured energy or wavelength."]])],.object [("key",.text "trace"),("question",.text "What evidence is retained?"),("choices",.array [.array [.text "result-without-dependency-trace",.text "An untraced result cannot be admitted."],.array [.text "complete-root-directed-trace",.text "The result retains its dependency chain to the foundational theorem."]])],.object [("key",.text "extension"),("question",.text "May an extra term or rule be appended?"),("choices",.array [.array [.text "free-extra-rule",.text "An extra rule introduces a choice."],.array [.text "no-extra-rule",.text "The declared typed grammar is exhausted."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004"
  title := "Cubic atomic support and exact neighbour balance"
  branch := "physics"
  statement := "Three-space supplies three axes and the binary Fold supplies the two held directions on each axis, forcing six nearest neighbours.  Dividing the half-One balance equally over those complete neighbours forces weight one-twelfth per neighbour and their exact sum is the half-One."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-FOUNDATION-HALF-ONE-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [CubicAtomicSupportEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity CubicAtomicSupportEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.CubicAtomicSupportEntryEvidence

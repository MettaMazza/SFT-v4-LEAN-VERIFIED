import SFT.Foundation.AssemblyControls
import SFT.Engine.RegistrationGate
namespace SFT.Foundation.AssemblyEvidence
open SFT.Host.Canonical FoldAssemblyGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),("coverage",.text (coverageName c.coverage)),
  ("length",.text (lengthName c.length)),("support",.text (supportName c.support)),
  ("unique",.text (uniqueName c.unique)),("transitions",.text (transitionsName c.transitions)),
  ("returns",.text (returnsName c.returns)),("extra",.text (extraName c.extra)),("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator",.text generationRule),("boundary",.text grammarBoundary),
  ("domains",.array (([
    ["none","proper","complete"],["inconsistent-length","consistent-length"],
    ["support-incomplete","support-complete"],["words-duplicated","words-unique"],
    ["transitions-absent","transitions-present"],["returns-absent","returns-present"],
    ["no-extra","has-extra"]] : List (List String)).map fun xs => .array (xs.map Value.text))),
  ("candidates",.array (candidates.map candidateRecord)),
  ("recursion",.text "Begin with the structural empty One word. At each generated Fold successor, append held-a and held-b once to every prior word.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-FOLD-ASSEMBLY-001"
  title := "Complete finite Fold-word assembly"
  branch := "foundation"
  statement := "Every generated finite succession of Folds has one exact complete support: begin with the structural empty One word and at each Fold append each of the two held fibre labels once to every prior word, retaining unique word, transition and return traces."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-FOLD-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("record",candidateRecord c),("survives",.boolean (survives c)),
    ("reason",.text (decisionReason c)),("dependencies",.array [.text "SFT-FOUNDATION-COUNT-001",.text "SFT-FOUNDATION-FOLD-001"])])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error (SFT.Host.Text.append "KeyError: " candidate.candidateId)

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.object [("closure",AssemblyControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("structural_recursion",.boolean true),("closure",AssemblyControls.closureValue)]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Foundation.AssemblyEvidence

import SFT.InformationScience.SymbolControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.SymbolEvidence
open SFT.Host.Canonical SymbolGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "alphabet",.text (alphabetName c.alphabet)],.array [.text "identity",.text (identityName c.identity)],.array [.text "label",.text (labelName c.label)],.array [.text "observation",.text (observationName c.observation)],.array [.text "image",.text (imageName c.image)],.array [.text "distinction",.text (distinctionName c.distinction)],.array [.text "closure",.text (closureName c.closure)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "alphabet"),("question",.text "What fixes the symbol carrier?"),("choices",.array [.array [.text "partial-or-duplicated-alphabet",.text "Omission or duplication changes the possible symbol family."],.array [.text "complete-canonical-alphabet",.text "Every generated symbol form occurs once."]])],.object [("key",.text "identity"),("question",.text "What fixes symbol identity?"),("choices",.array [.array [.text "presentation-token",.text "A presentation token may alias distinct generated forms."],.array [.text "canonical-form-identity",.text "The complete construction trace fixes exact symbol identity."]])],.object [("key",.text "label"),("question",.text "How is a symbol held apart?"),("choices",.array [.array [.text "unlabelled-form",.text "Without a retained label the selected fibre identity is unavailable."],.array [.text "retained-held-label",.text "The symbol carries its exact held fibre label."]])],.object [("key",.text "observation"),("question",.text "What fixes observation coverage?"),("choices",.array [.array [.text "partial-observation",.text "A missing symbol has no declared observation class."],.array [.text "total-source-bound-observation",.text "Every alphabet member has one retained observation row."]])],.object [("key",.text "image"),("question",.text "How many images may one symbol have?"),("choices",.array [.array [.text "multivalued-image",.text "Multiple unheld images do not identify the observation made."],.array [.text "single-retained-image",.text "Each source symbol has exactly one held observation label."]])],.object [("key",.text "distinction"),("question",.text "What makes two symbols distinguishable?"),("choices",.array [.array [.text "assumed-or-visual-difference",.text "Presentation difference does not establish retained observational separation."],.array [.text "different-observation-labels",.text "The observation relation retains distinct images for the two source forms."]])],.object [("key",.text "closure"),("question",.text "What happens when images merge?"),("choices",.array [.array [.text "source-identity-erased",.text "Erasing sources prevents an exact account of closed distinctions."],.array [.text "closed-class-with-microforms",.text "Merged symbols remain as exact source members of one observation class."]])],.object [("key",.text "generality"),("question",.text "What closes every finite alphabet?"),("choices",.array [.array [.text "sampled-alphabets",.text "Examples do not establish extension to a fresh symbol."],.array [.text "alphabet-successor",.text "A fresh canonical symbol adds one row and all new distinction pairs."]])],.object [("key",.text "addition"),("question",.text "Is another symbol rule added?"),("choices",.array [.array [.text "extra-symbol-semantics",.text "Imported meaning or frequency is not supplied by form and observation."],.array [.text "no-extra-symbol-semantics",.text "Identity and distinction use only generated forms, labels and observation."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-SYMBOL-DISTINCTION-001"
  title := "Exact symbols, observation classes and distinguishability"
  branch := "information_science"
  statement := "An admitted symbol is a canonical generated form with a retained held label inside a complete canonical alphabet. Observation is a total single-valued source-bound classification. Two symbols are distinguishable exactly when their retained observation labels differ; symbols sharing one observation image remain distinct microforms but belong to one closed observation class. Every retained and closed distinction is recorded."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-DISCRETE-001","SFT-MATH-LOGIC-PROOF-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-SYMBOL-DISTINCTION-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-SYMBOL-DISTINCTION-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-FORM-ENFORCEMENT-001",.text "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001",.text "SFT-MATH-DISCRETE-001",.text "SFT-MATH-LOGIC-PROOF-001"]),
    ("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])

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
  proofHash := identity (.object [("closure",SymbolControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-SYMBOL-DISTINCTION-001"),
    ("base",.text "One canonical symbol has one observation row and no nonidentity pair distinction."),
    ("successor",.text "Adding one fresh canonical symbol adds exactly one source-bound observation row and one pair with every prior symbol. Each new pair is classified once as retained or closed by equality of its two observation labels."),
    ("laws",.array (SymbolControls.laws.map Value.text)),
    ("witnesses",.array (SymbolWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Information cannot be quantified before the model derives what a symbol is and exactly when two possible forms remain distinguishable to an observation. Imported alphabets or meanings would select that boundary."

def derivation : String := "Canonical form enforcement supplies exact identity; discrete relations supply total classification; logic supplies distinguished held orientations; the measurement boundary fixes one-way observation. Exhausting nine structural questions forces the symbol/observation-class kernel."

def check : String := "Execute all 512 symbol kernels, verify totality, fine and coarse ledgers, symmetry, irreflexivity and retained microforms, run four adverse controls and independently regenerate the product."

def limitations : String := "This theorem closes finite structural symbols and observation-relative distinction. It does not assign linguistic meaning, occurrence frequency or information quantity; those require downstream laws."

def correspondenceTerms : List String := ["symbol","alphabet","observation","equivalence class","distinguishability"]

end SFT.InformationScience.SymbolEvidence

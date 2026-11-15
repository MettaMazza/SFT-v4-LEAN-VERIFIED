import SFT.Physics.BaryogenesisDependencyControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.BaryogenesisDependencyEvidence
open SFT.Host.Canonical BaryogenesisDependencyGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "tally",.text (tallyName c.tally)],.array [.text "conjugacy",.text (conjugacyName c.conjugacy)],.array [.text "reverse",.text (reverseName c.reverse)],.array [.text "ledger",.text (ledgerName c.ledger)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "enumeration",.text (enumerationName c.enumeration)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What is the initial matter carrier?"),("choices",.array [.array [.text "preloaded-unpaired-residue",.text "A preloaded residue assumes the result."],.array [.text "exact-paired-particle-antiparticle-carrier",.text "One positive carrier in each held orientation supplies no initial residue."]])],.object [("key",.text "tally"),("question",.text "May the baryon tally change?"),("choices",.array [.array [.text "every-transition-preserves-baryon-tally",.text "A preserving transition cannot create a tally difference from paired support."],.array [.text "one-explicit-tally-changing-transition",.text "A positive appended carrier makes a residue logically possible without importing its measured size."]])],.object [("key",.text "conjugacy"),("question",.text "How are conjugate paths related?"),("choices",.array [.array [.text "exactly-paired-conjugate-paths",.text "Equal conjugate appends preserve the paired tally."],.array [.text "CP-carrier-distinguishes-conjugate-paths",.text "The admitted CP carrier retains one transition orientation from its conjugate."]])],.object [("key",.text "reverse"),("question",.text "Does the reverse process complete?"),("choices",.array [.array [.text "complete-reverse-recurrence",.text "Complete reversal closes every newly appended carrier."],.array [.text "nonequilibrium-reverse-completion-held",.text "A retained process orientation prevents exact reverse cancellation of the new distinction."]])],.object [("key",.text "ledger"),("question",.text "How is the result recorded?"),("choices",.array [.array [.text "signed-or-unrecorded-net-number",.text "A signed or missing ledger violates positive exact accounting."],.array [.text "positive-oriented-residue-or-empty-One",.text "Equal sides return structural emptiness; an ordered difference is retained as one positive oriented carrier."]])],.object [("key",.text "composition"),("question",.text "How are the three requirements related?"),("choices",.array [.array [.text "named-independent-conditions",.text "Names alone do not prove their joint necessity."],.array [.text "single-three-condition-process-composition",.text "The complete process trace tests every condition jointly from the same paired source."]])],.object [("key",.text "enumeration"),("question",.text "How is necessity established?"),("choices",.array [.array [.text "selected-successful-combination",.text "Selecting the familiar triple is not uniqueness."],.array [.text "all-eight-presence-absence-combinations",.text "The complete Boolean product proves that exactly one combination retains a residue."]])],.object [("key",.text "comparison"),("question",.text "How does physical abundance enter?"),("choices",.array [.array [.text "abundance-selects-dependency-law",.text "A measured abundance cannot choose the formal conditions."],.array [.text "inherit-sealed-CKM-and-baryon-photon-records",.text "The physical CP carrier and abundance test were admitted separately and enter only as downstream correspondence."]])],.object [("key",.text "provenance"),("question",.text "How is the known historical target disclosed?"),("choices",.array [.array [.text "mislabel-as-blind-discovery",.text "The dependency triple was known before this V3 reconstruction."],.array [.text "observational-reconstruction-explicit",.text "The law is an independently executed reconstruction, not a claim of blind historical discovery."]])],.object [("key",.text "extension"),("question",.text "May an efficiency or extra mechanism be inserted?"),("choices",.array [.array [.text "free-efficiency-or-extra-condition",.text "An inserted efficiency or condition is a free parameter."],.array [.text "no-extra-rule",.text "The minimal complete process grammar is exhausted by the three distinctions and retained ledger."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-BARYOGENESIS-DEPENDENCY-TERMINAL-021"
  title := "Fold baryogenesis dependency and retained-residue law"
  branch := "physics"
  statement := "Beginning from one exactly paired particle/antiparticle carrier, a positive retained baryon residue occurs in the complete minimal Fold process grammar if and only if three independently held distinctions co-occur: a transition changes the baryon tally, conjugate transition paths are distinguished by the admitted CP carrier, and reverse completion is held by a nonequilibrium process record.  Complete enumeration of all eight presence/absence combinations leaves exactly one residue-bearing process.  The already sealed terminal CKM and baryon-to-photon claims supply the post-derivation physical carrier and abundance comparison; they do not select this dependency law."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-FOUNDATION-PART-EQUIVALENCE-001", "SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001", "SFT-PHYS-THERMO-IRREVERSIBILITY-001", "SFT-PHYS-MATTER-CKM-TERMINAL-004", "SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-BARYOGENESIS-DEPENDENCY-TERMINAL-021",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-BARYOGENESIS-DEPENDENCY-TERMINAL-021",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [BaryogenesisDependencyControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity BaryogenesisDependencyControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.BaryogenesisDependencyEvidence

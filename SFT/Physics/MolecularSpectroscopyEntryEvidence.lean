import SFT.Foundation.AdmissionControls
import SFT.Physics.MolecularSpectroscopyEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.MolecularSpectroscopyEntryEvidence
open SFT.Host.Canonical MolecularSpectroscopyEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "ladder",.text (ladderName c.ladder)],.array [.text "operation",.text (operationName c.operation)],.array [.text "isotope",.text (isotopeName c.isotope)],.array [.text "order",.text (orderName c.order)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "trace",.text (traceName c.trace)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "What happens to the immutable hierarchy and adverse comparison?"),("choices",.array [.array [.text "replace-or-erase-predecessor",.text "A versioned successor cannot rewrite an admitted receipt or delete an adverse row."],.array [.text "retain-and-version-predecessor",.text "The valid hierarchy and its unfavorable universal reading remain visible while distinct carriers are added."]])],.object [("key",.text "carrier"),("question",.text "How are rotation and vibration represented?"),("choices",.array [.array [.text "one-universal-quarter-carrier",.text "One numerical carrier repeats the already rejected equality."],.array [.text "distinct-generated-rotational-and-vibrational-carriers",.text "Rotation, harmonic vibration and anharmonic return retain separate exact roles."]])],.object [("key",.text "ladder"),("question",.text "Which finite ladders are generated?"),("choices",.array [.array [.text "imported-continuum-spectrum",.text "A continuum spectrum is outside the exact finite Fold grammar."],.array [.text "counted-JJplusOne-and-odd-oscillator-ladders",.text "Positive ordinals force J(J+1), 2J gaps and odd half-step oscillator carriers."]])],.object [("key",.text "operation"),("question",.text "How is anharmonic narrowing represented?"),("choices",.array [.array [.text "signed-floating-series",.text "Signed or floating proof scalars violate the permitted domain."],.array [.text "ordered-positive-held-Takes",.text "Every narrowing term is an exact positive Take with orientation retained."]])],.object [("key",.text "isotope"),("question",.text "How is the first heavier isotope transported?"),("choices",.array [.array [.text "free-isotope-factor",.text "A chosen scale factor is a parameter."],.array [.text "count-refined-linear-and-squared-transport",.text "Rotation is transported directly and vibration in the squared domain, avoiding an irrational root."]])],.object [("key",.text "order"),("question",.text "Where do the terminal relations stop?"),("choices",.array [.array [.text "selected-or-open-correction-order",.text "A selected truncation or open correction list is not closed."],.array [.text "finite-typed-carrier-exhaustion",.text "Each generated binary, colour, down, up, heavy and terminal carrier acts once in its typed slot."]])],.object [("key",.text "target"),("question",.text "May a molecular measurement enter execution?"),("choices",.array [.array [.text "measurement-readable-execution",.text "A target-readable execution cannot issue a sealed empirical prediction."],.array [.text "target-inaccessible-until-seal",.text "The formal module contains no molecular inscription or source access."]])],.object [("key",.text "provenance"),("question",.text "How is data-informed development disclosed?"),("choices",.array [.array [.text "concealed-development-provenance",.text "Concealing prior observation would misstate the empirical protocol."],.array [.text "disclosed-observational-prediction-protocol",.text "Observation informs the explicit law; capability closure, enumeration and sealing precede release."]])],.object [("key",.text "trace"),("question",.text "What proof chain is retained?"),("choices",.array [.array [.text "result-without-root-trace",.text "An untraced numerical relation is inadmissible."],.array [.text "complete-root-directed-trace",.text "Every carrier returns through admitted dependencies to the foundational theorem."]])],.object [("key",.text "extension"),("question",.text "May another coefficient be appended?"),("choices",.array [.array [.text "free-extra-term",.text "An ungenerated extra term is a parameter."],.array [.text "no-extra-rule",.text "The declared typed grammar is exhausted and halted."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005"
  title := "Terminal exact molecular rotational, vibrational and isotope spectroscopy"
  branch := "physics"
  statement := "The preserved Fold hierarchy separates molecular rotation, harmonic vibration and anharmonic return. Positive rotational ordinals force E_J/B=J(J+1) and adjacent gap 2J; positive vibrational ordinals force the odd half-step oscillator ladder and ordered anharmonic narrowing.  The exact alpha carrier then closes distinct hydrogen rotational/vibrational and anharmonic/vibrational ratios and first-isotope rotational and squared-vibrational transports without importing a molecular measurement."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004", "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003", "SFT-PHYS-WAVE-RESONANCE-001", "SFT-CHEM-BOND-COVALENT-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [MolecularSpectroscopyEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity MolecularSpectroscopyEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.MolecularSpectroscopyEntryEvidence

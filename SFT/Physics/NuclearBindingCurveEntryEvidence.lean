import SFT.Foundation.AdmissionControls
import SFT.Physics.NuclearBindingCurveEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.NuclearBindingCurveEntryEvidence
open SFT.Host.Canonical NuclearBindingCurveEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "bulk",.text (bulkName c.bulk)],.array [.text "surface",.text (surfaceName c.surface)],.array [.text "coulomb",.text (coulombName c.coulomb)],.array [.text "asymmetry",.text (asymmetryName c.asymmetry)],.array [.text "pairing",.text (pairingName c.pairing)],.array [.text "radius",.text (radiusName c.radius)],.array [.text "maximum",.text (maximumName c.maximum)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "How are admitted nuclear and field laws used?"),("choices",.array [.array [.text "rewrite-predecessor-laws",.text "A successor cannot alter admitted receipts."],.array [.text "compose-immutable-predecessors",.text "Binding, residual order, exact alpha, spatial rank and mass-energy closure remain immutable dependencies."]])],.object [("key",.text "bulk"),("question",.text "What is the interior binding carrier?"),("choices",.array [.array [.text "unbounded-pairwise-bulk-growth",.text "Short-range saturation forbids growth with every distant constituent."],.array [.text "one-saturating-bulk-support",.text "Every completed interior word retains one normalized saturated binding support."]])],.object [("key",.text "surface"),("question",.text "How is the surface deficit fixed?"),("choices",.array [.array [.text "fitted-surface-coefficient",.text "A fitted coefficient is a parameter."],.array [.text "one-over-binary-plus-generator-interface",.text "One missing boundary act is shared over the forced binary-plus-generator interface carrier 2+3=5."]])],.object [("key",.text "coulomb"),("question",.text "How is proton repulsion counted?"),("choices",.array [.array [.text "import-semi-empirical-coulomb-term",.text "An imported mass formula cannot select the law."],.array [.text "exact-alpha-times-ordered-charge-paths",.text "Every source-to-distinct-target proton path carries the admitted exact electromagnetic share."]])],.object [("key",.text "asymmetry"),("question",.text "How is neutron/proton imbalance retained?"),("choices",.array [.array [.text "chosen-asymmetry-penalty",.text "A chosen coefficient is not forced."],.array [.text "quarter-order-unmatched-label-square",.text "The residual quarter-order weights the complete unmatched-label pair support."]])],.object [("key",.text "pairing"),("question",.text "How are even and odd compositions distinguished?"),("choices",.array [.array [.text "fitted-pairing-term",.text "A fitted parity correction is a parameter."],.array [.text "quarter-order-paired-gain-unpaired-loss",.text "The residual quarter-order is retained for complete pairs, held for mixed words and charged against two unpaired classes."]])],.object [("key",.text "radius"),("question",.text "May an irrational cube root enter proof values?"),("choices",.array [.array [.text "evaluate-irrational-radius",.text "Irrational values are outside the exact proof domain."],.array [.text "rational-enclosures-until-order-separates",.text "Boundary-rank-two over volume-rank-three is compared only through exact rational cube enclosures."]])],.object [("key",.text "maximum"),("question",.text "How is the peak closed beyond a finite scan?"),("choices",.array [.array [.text "selected-isotope-window",.text "A chosen neighborhood cannot prove a global maximum."],.array [.text "complete-concave-census-plus-forced-tail-induction",.text "Every possible integer/parity maximizer below 2^(5+7) is enumerated and both unbounded tail cases are closed."]])],.object [("key",.text "target"),("question",.text "May mass-evaluation data select the peak?"),("choices",.array [.array [.text "external-target-readable",.text "Target access would fit the isotope coordinate."],.array [.text "target-inaccessible-until-seal",.text "The complete structural ledger and unique coordinate seal before the authoritative table opens."]])],.object [("key",.text "extension"),("question",.text "May another coefficient or correction be appended?"),("choices",.array [.array [.text "free-coefficient-or-residual",.text "An ungenerated correction destroys zero-parameter closure."],.array [.text "no-extra-rule",.text "Bulk, surface, Coulomb, asymmetry and pairing exhaust the declared grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005"
  title := "Terminal zero-parameter nuclear binding curve and stability maximum"
  branch := "physics"
  statement := "Short-range quarter-order residual recurrence and exact electromagnetic opposition force one positive bulk/surface/Coulomb/asymmetry/pairing ledger with no fitted coefficient. The surface share is exactly One over the binary-plus-generator interface carrier five; Coulomb loss is the admitted exact alpha over every ordered distinct proton path; asymmetry and pairing carry the admitted quarter-order. Exact rational radius enclosures, complete concave integer/parity enumeration below the forced mass 2^(5+7), and a two-case tail induction uniquely maximize normalized binding at mass count 62, charge count 28 and neutron count 34. No nuclide name or measured binding value enters execution."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-NUCLEAR-BINDING-001", "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005", "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-MATTER-MASS-ENERGY-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [NuclearBindingCurveEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity NuclearBindingCurveEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.NuclearBindingCurveEntryEvidence

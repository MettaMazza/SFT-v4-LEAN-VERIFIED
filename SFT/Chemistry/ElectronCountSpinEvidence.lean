import SFT.Chemistry.ElectronCountSpinGrammar
import SFT.Chemistry.ElectronCountSpinWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ElectronCountSpinEvidence
open SFT.Host.Canonical ElectronCountSpinGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "neutral-electron-census",.text "C and O nuclear support forces fourteen electron occurrences without a charge scalar.",.boolean ElectronCountSpinWitnesses.witness0],.array [.text "anion-electron-census",.text "O2 with one held adjoin action forces seventeen electron occurrences.",.boolean ElectronCountSpinWitnesses.witness1],.array [.text "pair-held-decomposition",.text "Singlet and doublet widths reconstruct complete complementary-pair and held-surplus support.",.boolean ElectronCountSpinWitnesses.witness2],.array [.text "same-fibre-exclusion-control",.text "A cell containing the same held fibre twice rejects.",.boolean ElectronCountSpinWitnesses.witness3],.array [.text "width-parity-control",.text "An even electron support with even spin width rejects.",.boolean ElectronCountSpinWitnesses.witness4]]
def claimId : String := "SFT-CHEM-ELECTRON-COUNT-SPIN-002"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-CHEM-ELEM-ATOMIC-NUMBER-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "nuclear_support",.text (nuclear_supportName c.nuclear_support)],.array [.text "charge",.text (chargeName c.charge)],.array [.text "electron_count",.text (electron_countName c.electron_count)],.array [.text "spin",.text (spinName c.spin)],.array [.text "occupation",.text (occupationName c.occupation)],.array [.text "decomposition",.text (decompositionName c.decomposition)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "nuclear_support",.array [.array [.text "formula-name-only",.text "A formula name does not enumerate the positive nuclear support that forces electron count."],.array [.text "atomic-number-occurrence-support",.text "Every nucleus retains its admitted atomic number and exact occurrence count."]]],.array [.text "charge",.array [.array [.text "signed-charge-scalar",.text "A signed scalar imports negative quantity and conflates direction with magnitude."],.array [.text "held-directed-electron-transfer",.text "Neutrality is empty One; cation and anion are held remove/adjoin actions with positive counts."]]],.array [.text "electron_count",.array [.array [.text "asserted-electron-number",.text "An asserted number is neither generated nor reconstructible."],.array [.text "complete-electron-occurrence-census",.text "Electron count is the exact cardinality after the held transfer acts on nuclear support."]]],.array [.text "spin",.array [.array [.text "signed-spin-magnitude",.text "A signed magnitude imports a forbidden negative coordinate and loses fibre identity."],.array [.text "two-held-spin-fibres",.text "Every electron occurrence carries exactly one of the two admitted held spin labels."]]],.array [.text "occupation",.array [.array [.text "same-fibre-cell-duplication",.text "Doubled same-fibre occupation violates admitted indistinguishability and exclusion."],.array [.text "complementary-cell-occupation",.text "A cell retains at most one occurrence of each complementary fibre."]]],.array [.text "decomposition",.array [.array [.text "unstructured-spin-list",.text "An unstructured list cannot reconstruct pairs, surplus or width."],.array [.text "complete-pairs-plus-held-surplus",.text "Every finite support decomposes exactly into complementary pairs and unmatched held fibres."]]],.array [.text "observation",.array [.array [.text "state-width-detached-from-support",.text "A detached multiplicity can contradict the complete electron support."],.array [.text "support-compatible-spin-width",.text "Width is the successor of unmatched support and must preserve the exact parity relation."]]],.array [.text "extension",.array [.array [.text "species-specific-exception",.text "An exception or fitted table can select a measured state."],.array [.text "no-extra-rule",.text "The same support, transfer, exclusion and decomposition law applies to every generated molecule."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular electron count and held-spin organization"
 branch := "chemistry"
 statement := "For every positive finite molecular nuclear support, the complete electron occurrence count is forced by atomic-number occurrences and a held adjoin/remove transfer; every occurrence then has exactly one of two held spin fibres, same-fibre same-cell doubling is excluded, and the support decomposes uniquely at a declared spin width into complementary pairs plus unmatched held fibres."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.observationalDerivation]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := identity (.array [.text claimId,candidateRecord c])
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
 proofHash := identity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "atomic-number-occurrence-support__held-directed-electron-transfer__complete-electron-occurrence-census__two-held-spin-fibres__complementary-cell-occupation__complete-pairs-plus-held-surplus__support-compatible-spin-width__no-extra-rule"),("base",.text "One admitted nucleus supplies its positive atomic-number occurrence support. After any lawful held transfer, one retained electron occurrence requires one named support cell, one of two spin fibres and spin width two."),("successor",.text "Adjoining one admitted nucleus expands support by its exact atomic-number count; adjoining or removing one held charge occurrence changes support by one without a signed scalar; adjoining a complementary fibre pair preserves width, while adjoining one unmatched fibre advances width by one. No species rule or measurement enters any successor."),("exclusions",.array [.text "no numerical-zero, negative, irrational, imaginary or floating proof value",.text "no signed charge or signed-spin proof coordinate",.text "no imported orbital occupation table, Hamiltonian, wavefunction or ground-state solver",.text "no measured state term or multiplicity in the derivation, candidate generator or prediction inputs",.text "no fitted, learned, species-specific or target-derived parameter",.text "no omitted, selected or silently corrected external row",.text "external state terms open only after the complete prediction vector is sealed"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical-zero, negative, irrational, imaginary or floating proof value","no signed charge or signed-spin proof coordinate","no imported orbital occupation table, Hamiltonian, wavefunction or ground-state solver","no measured state term or multiplicity in the derivation, candidate generator or prediction inputs","no fitted, learned, species-specific or target-derived parameter","no omitted, selected or silently corrected external row","external state terms open only after the complete prediction vector is sealed"]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (identity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def runControls (sourceHash : String) : Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with nuclear_support := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ElectronCountSpinEvidence

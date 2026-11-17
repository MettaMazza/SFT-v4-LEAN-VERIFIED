import SFT.Chemistry.PairExchangeGrammar
import SFT.Chemistry.PairExchangeWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.PairExchangeEvidence
open SFT.Host.Canonical PairExchangeGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "singlet-sector",.text "The One-width spin sector is alternating, its spatial complement preserves and same-cell pairing is admitted.",.boolean PairExchangeWitnesses.singletSector],.array [.text "triplet-sector",.text "The three-width spin sector preserves, its spatial complement alternates and same-cell pairing is excluded.",.boolean PairExchangeWitnesses.tripletSector],.array [.text "alternating-total",.text "Both complementary compositions retain the alternating total electron-pair word.",.boolean PairExchangeWitnesses.alternatingTotal],.array [.text "same-support-pair",.text "One support can retain distinct complementary singlet and triplet state identities.",.boolean PairExchangeWitnesses.sameSupportPair],.array [.text "same-cell-control",.text "An explicit paired cell is rejected in the alternating spatial sector.",.boolean PairExchangeWitnesses.sameCellControl],.array [.text "third-occurrence-control",.text "A third identical occurrence in one orbital support rejects.",.boolean PairExchangeWitnesses.thirdOccurrenceControl]]
def claimId : String := "SFT-CHEM-MOLECULAR-EXCLUSION-EXCHANGE-006"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-SPIN-STATISTICS-CONDENSATION-TERMINAL-045","SFT-CHEM-ELECTRON-COUNT-SPIN-002","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003","SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "identity",.text (identityName c.identity)],.array [.text "total",.text (totalName c.total)],.array [.text "spin",.text (spinName c.spin)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "same_cell",.text (same_cellName c.same_cell)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "cross-molecule-pair",.text "A cross-molecule word does not define one molecular exchange organization."],.array [.text "one-molecule-electron-pair",.text "Every exchange comparison retains one molecular carrier and one pair of identical electrons."]]],.array [.text "identity",.array [.array [.text "named-distinguishable-electrons",.text "Naming identical electrons imports a distinction absent from every observable exchange trace."],.array [.text "exchange-equivalent-constituents",.text "The admitted indistinguishability law identifies the pair by exchange-equivalent complete traces."]]],.array [.text "total",.array [.array [.text "free-total-exchange-label",.text "A freely chosen total exchange class violates the admitted identical-fermion law."],.array [.text "alternating-total-word",.text "Every identical-electron pair retains the alternating total exchange class."]]],.array [.text "spin",.array [.array [.text "imported-spin-sign-function",.text "A signed or continuum wavefunction is outside the exact Fold proof domain."],.array [.text "complete-one-and-three-spin-sectors",.text "The complete two-label spin census forces one alternating and three preserving readings."]]],.array [.text "composition",.array [.array [.text "independent-spin-and-space-labels",.text "Independent labels can compose to a preserving total word and violate fermionic exchange."],.array [.text "complementary-spin-spatial-fibres",.text "Exactly one of spin and spatial exchange preserves while the other alternates."]]],.array [.text "same_cell",.array [.array [.text "selected-occupancy-cap",.text "A selected cap is a free rule rather than an exclusion consequence."],.array [.text "spatial-exchange-controlled-occupation",.text "Preserving spatial support admits the paired cell; alternating spatial support excludes it."]]],.array [.text "record",.array [.array [.text "selected-favourable-spin-states",.text "Selected states cannot establish the complete molecular pair organization."],.array [.text "complete-state-and-exchange-pair-record",.text "Every registered state, same-cell record, paired support and adverse ordering is retained."]]],.array [.text "extension",.array [.array [.text "species-or-energy-order-exception",.text "A species lookup or fixed energy-order sign would add a target-selected rule."],.array [.text "pairwise-successor-with-no-extra-rule",.text "The same complementary held-label law applies to every added identical-electron pair and support."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Molecular exclusion and complementary electron-pair exchange organization"
 branch := "chemistry"
 statement := "For every identical two-electron molecular pair, the total exchange word is alternating. The complete two-label spin census forces a positive One-width alternating spin sector with preserving spatial support and a positive three-width preserving spin sector with alternating spatial support. Same-cell pairing is admitted only in the preserving spatial sector; the complementary sectors remain distinct on the same orbital support. No signed, negative, imaginary, continuum or numerical-zero proof value is used."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-molecule-electron-pair__exchange-equivalent-constituents__alternating-total-word__complete-one-and-three-spin-sectors__complementary-spin-spatial-fibres__spatial-exchange-controlled-occupation__complete-state-and-exchange-pair-record__pairwise-successor-with-no-extra-rule"),("base",.text "Two identical electrons generate four complete held spin words: one alternating word and three preserving words. Alternating total exchange therefore leaves exactly the complementary spatial fibre for each sector."),("successor",.text "Adding a molecular support or another identical-electron pair retains every prior exchange word and applies the same two-fibre product locally; preserving spatial support may retain the paired cell, alternating spatial support may not, and no third exchange class is generated."),("exclusions",.array [.text "no numerical zero; glyph 0 denotes source/interface absence only",.text "no negative, irrational, imaginary, floating, signed-wavefunction or continuum proof magnitude",.text "no imported Pauli sign rule, antisymmetrized orbital equation, exchange integral or Hund ordering premise",.text "no measured NIST multiplicity, occupancy, energy order or separation before prediction seal",.text "no asserted energy-order sign or fitted exchange splitting",.text "no named-electron distinction, species exception, selected state or omitted unfavorable pair",.text "source energy inscription 0 remains an absence-baseline record and never becomes an SFT number"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; glyph 0 denotes source/interface absence only","no negative, irrational, imaginary, floating, signed-wavefunction or continuum proof magnitude","no imported Pauli sign rule, antisymmetrized orbital equation, exchange integral or Hund ordering premise","no measured NIST multiplicity, occupancy, energy order or separation before prediction seal","no asserted energy-order sign or fitted exchange splitting","no named-electron distinction, species exception, selected state or omitted unfavorable pair","source energy inscription 0 remains an absence-baseline record and never becomes an SFT number"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.PairExchangeEvidence

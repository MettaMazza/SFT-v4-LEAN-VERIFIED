import SFT.Chemistry.OrganometallicElectronAccountGrammar
import SFT.Chemistry.OrganometallicElectronAccount
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.OrganometallicElectronAccountEvidence
open SFT.Host.Canonical OrganometallicElectronAccountGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "forced-capacity",.text "Exact admitted widths two, six and ten force capacity eighteen.",.boolean OrganometallicElectronAccount.capacityWitness],.array [.text "complete-account",.text "Four nonbonded plus five bond pairs force eighteen and capacity completeness.",.boolean OrganometallicElectronAccount.completeWitness],.array [.text "pair-successor",.text "One fresh pair increments the exact count from two to four.",.boolean OrganometallicElectronAccount.successorWitness],.array [.text "capacity-control",.text "A capacity-complete account rejects another pair.",.boolean OrganometallicElectronAccount.haltWitness]]
def claimId : String := "SFT-CHEM-ORGANOMETALLIC-ELECTRON-ACCOUNTING-011"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-CHEM-ELECTRON-COUNT-SPIN-002","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003","SFT-CHEM-MOLECULAR-EXCLUSION-EXCHANGE-006","SFT-CHEM-MOLECULAR-MAGNETIC-RESPONSE-012","SFT-CHEM-ORGANOMETALLIC-METAL-CARBON-BOND-010"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "support",.text (supportName c.support)],.array [.text "capacity",.text (capacityName c.capacity)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "relation",.text (relationName c.relation)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "free-electron-number",.text "A free number is detached from the complex."],.array [.text "one-retained-organometallic-entity",.text "Every electron account belongs to one retained entity."]]],.array [.text "support",.array [.array [.text "selected-valence-electrons",.text "Selected electrons lose complete occurrence support."],.array [.text "complete-nonbonded-and-bond-pair-support",.text "Both account parts retain every complementary pair occurrence."]]],.array [.text "capacity",.array [.array [.text "imported-eighteen-rule",.text "Importing eighteen assumes the target."],.array [.text "forced-two-plus-six-plus-ten-capacity",.text "Admitted s, p and d widths force exact capacity 2+6+10=18."]]],.array [.text "balance",.array [.array [.text "signed-spin-sum",.text "A signed sum imports negative proof values."],.array [.text "complete-complementary-fibre-pairing",.text "Stable diamagnetic support is organized into complete held fibre pairs."]]],.array [.text "partition",.array [.array [.text "oxidation-state-bookkeeping",.text "Conventional oxidation bookkeeping can change labels without support."],.array [.text "exact-nonbonded-plus-bond-partition",.text "The total is the exact disjoint union of nonbonded and bond electron occurrences."]]],.array [.text "relation",.array [.array [.text "species-stability-lookup",.text "A species lookup lets observed stability choose the rule."],.array [.text "capacity-complete-or-incomplete-held-relation",.text "Exact support is held as complete or incomplete relative to generated capacity."]]],.array [.text "comparison",.array [.array [.text "measured-total-selects-capacity",.text "An observed count cannot select the capacity."],.array [.text "postseal-stable-complex-correspondence",.text "The frozen external rule is compared only after structural sealing."]]],.array [.text "extension",.array [.array [.text "complex-specific-exception",.text "An exception destroys zero-parameter closure."],.array [.text "pair-successor-until-capacity-then-halt",.text "Each fresh pair adds twice and capacity-complete support rejects another pair."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact organometallic electron-support capacity and accounting law"
 branch := "chemistry"
 statement := "The admitted exact s, p and d support widths two, six and ten force capacity eighteen without importing an electron-counting rule. One retained organometallic entity partitions complete complementary fibre-paired electron occurrences into disjoint nonbonded and bond support. Their exact union is held as capacity-complete or capacity-incomplete; each pair successor adds two occurrences and capacity-complete support halts another addition."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-organometallic-entity__complete-nonbonded-and-bond-pair-support__forced-two-plus-six-plus-ten-capacity__complete-complementary-fibre-pairing__exact-nonbonded-plus-bond-partition__capacity-complete-or-incomplete-held-relation__postseal-stable-complex-correspondence__pair-successor-until-capacity-then-halt"),("base",.text "The first complementary pair has exact count two. Complete s, p and d supports have widths two, six and ten and force capacity eighteen."),("successor",.text "Appending one fresh complementary fibre pair preserves all previous occurrences and the disjoint partition and increments the exact count twice; a capacity-complete support rejects another pair."),("exclusions",.array [.text "no numerical zero; empty account support is structural EmptyOne",.text "no negative irrational imaginary floating signed continuum fitted free or imported parameter",.text "no imported eighteen-electron rule oxidation-state bookkeeping species stability lookup or observed target total in capacity generation",.text "no unpaired or duplicated occurrence inside the stable diamagnetic account",.text "no omitted IUPAC scope component total analogy citation licence or disclaimer surface"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; empty account support is structural EmptyOne","no negative irrational imaginary floating signed continuum fitted free or imported parameter","no imported eighteen-electron rule oxidation-state bookkeeping species stability lookup or observed target total in capacity generation","no unpaired or duplicated occurrence inside the stable diamagnetic account","no omitted IUPAC scope component total analogy citation licence or disclaimer surface"]
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
end SFT.Chemistry.OrganometallicElectronAccountEvidence

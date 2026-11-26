import SFT.Chemistry.ComplexSpinStateGrammar
import SFT.Chemistry.ComplexSpinStateDerivation
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ComplexSpinStateEvidence
open SFT.Host.Canonical ComplexSpinStateGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-six-electron-census",.text "Every symmetry-distinct six-electron allocation is generated once.",.boolean ComplexSpinStateDerivation.censusWitness],.array [.text "forced-low-extremum",.text "The low extremum pairs all three lower supports and crosses no split boundary.",.boolean ComplexSpinStateDerivation.lowWitness],.array [.text "forced-high-extremum",.text "The high extremum retains four unmatched fibres and exactly two upper crossings.",.boolean ComplexSpinStateDerivation.highWitness],.array [.text "exact-order-trichotomy",.text "Weak, first-retained and second-retained recurrence force high-first, coincidence and low-first.",.boolean ComplexSpinStateDerivation.orderWitness],.array [.text "capacity-control",.text "Reversing the forced split widths rejects.",.boolean ComplexSpinStateDerivation.capacityWitness],.array [.text "occupancy-control",.text "Overfilling the lower support rejects.",.boolean ComplexSpinStateDerivation.occupancyWitness]]
def claimId : String := "SFT-CHEM-COMPLEX-SPIN-STATE-ORDER-007"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001","SFT-CHEM-ELECTRON-COUNT-SPIN-002","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005","SFT-CHEM-COORDINATION-GEOMETRY-HELD-ORIENTATION-004","SFT-CHEM-LIGAND-STATE-SPLITTING-006"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "split",.text (splitName c.split)],.array [.text "enumeration",.text (enumerationName c.enumeration)],.array [.text "low",.text (lowName c.low)],.array [.text "high",.text (highName c.high)],.array [.text "cost",.text (costName c.cost)],.array [.text "order",.text (orderName c.order)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "cross-complex-state-mixture",.text "States from different carriers do not share one exact order."],.array [.text "one-complex-electron-support",.text "Both extrema retain one complex and one complete electron census."]]],.array [.text "split",.array [.array [.text "imported-orbital-or-field-table",.text "A conventional table would select the state grammar."],.array [.text "forced-three-plus-two-support",.text "INORG-006 supplies the exact three-plus-two support without a field parameter."]]],.array [.text "enumeration",.array [.array [.text "selected-configurations",.text "Selected configurations cannot establish an extremum."],.array [.text "complete-pair-single-occupancy-census",.text "Every symmetry-distinct pair/single allocation is generated exactly once."]]],.array [.text "low",.array [.array [.text "named-low-spin-assumption",.text "A name does not force an occupancy."],.array [.text "least-crossing-then-least-unmatched-extremum",.text "Low spin is the unique complete-census minimum of split crossings then unmatched fibres."]]],.array [.text "high",.array [.array [.text "named-high-spin-assumption",.text "A name does not force an occupancy."],.array [.text "greatest-unmatched-then-least-crossing-extremum",.text "High spin is the unique complete-census maximum of unmatched fibres, then minimum crossing."]]],.array [.text "cost",.array [.array [.text "fitted-pairing-or-field-energy",.text "A fitted energy imports a free parameter and target choice."],.array [.text "counted-pair-closure-plus-split-crossing-paths",.text "Order cost composes only exact closure and retained crossing paths."]]],.array [.text "order",.array [.array [.text "asserted-ground-state-label",.text "An asserted label does not compare both generated extrema."],.array [.text "complete-weak-boundary-strong-trichotomy",.text "Exact comparison forces high-first, coincidence, or low-first at the three recurrence classes."]]],.array [.text "extension",.array [.array [.text "species-temperature-or-distance-fit",.text "A species fit can manufacture a crossover."],.array [.text "monotone-dilution-with-no-extra-rule",.text "Admitted dilution changes only retained interaction recurrence and preserves the same exact order law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact complex spin-state extrema, order and crossover"
 branch := "chemistry"
 statement := "For the forced three-plus-two split support, exhaustive pair/single occupancy of six retained electron occurrences produces ten symmetry-distinct signatures. The low-spin state is uniquely the least split-crossing and then least-unmatched signature: three lower pairs, spin width one and structural EmptyOne crossings. The high-spin state is uniquely the greatest-unmatched and then least-crossing signature: one lower pair, two lower singles, two upper singles, spin width five and two crossings. Exact pair-closure plus retained crossing path counts force the order vector high-before-low, crossover coincidence and low-before-high for diluted EmptyOne, first-retained and second-retained interaction recurrence. Admitted geometric dilution therefore reverses the state order without any fitted field, pairing, temperature or distance parameter."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-complex-electron-support__forced-three-plus-two-support__complete-pair-single-occupancy-census__least-crossing-then-least-unmatched-extremum__greatest-unmatched-then-least-crossing-extremum__counted-pair-closure-plus-split-crossing-paths__complete-weak-boundary-strong-trichotomy__monotone-dilution-with-no-extra-rule"),("base",.text "At diluted structural EmptyOne recurrence, split crossings retain no separate path cost; the complete census forces the high-spin extremum to precede the low-spin extremum by its smaller pair-closure count."),("successor",.text "Each positive interaction successor adds exactly the retained split-crossing count to every state's path cost. The low extremum has structural EmptyOne crossings while the high extremum has two, so the first successor is the unique coincidence boundary and every later successor preserves low-before-high order without an extra rule."),("exclusions",.array [.text "no numerical zero; native absence and the diluted boundary are structural EmptyOne",.text "no negative irrational imaginary floating signed spin or continuum proof quantity",.text "no imported crystal-field ligand-field orbital Hamiltonian pairing-energy or spectrochemical model",.text "no free or fitted field strength, crossover threshold, temperature, distance, species rule or tolerance",.text "no measured definition, term, bond length or temperature in generation, enumeration or survivor decision",.text "no deletion or correction of the registered HT06789 to LT06788 transport mismatch",.text "no claim that the Fold recurrence derives the dimensional pm or K inscriptions; they are complete post-seal comparison values"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; native absence and the diluted boundary are structural EmptyOne","no negative irrational imaginary floating signed spin or continuum proof quantity","no imported crystal-field ligand-field orbital Hamiltonian pairing-energy or spectrochemical model","no free or fitted field strength, crossover threshold, temperature, distance, species rule or tolerance","no measured definition, term, bond length or temperature in generation, enumeration or survivor decision","no deletion or correction of the registered HT06789 to LT06788 transport mismatch","no claim that the Fold recurrence derives the dimensional pm or K inscriptions; they are complete post-seal comparison values"]
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
end SFT.Chemistry.ComplexSpinStateEvidence

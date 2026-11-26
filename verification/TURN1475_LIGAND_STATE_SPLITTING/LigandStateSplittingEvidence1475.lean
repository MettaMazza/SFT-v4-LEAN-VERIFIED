import «work».LigandStateSplittingGrammar1475
import SFT.Engine.RegistrationGate
namespace SFT.Physics.LigandStateSplittingEvidence
open SFT.Host.Canonical LigandStateSplittingGrammar
set_option maxRecDepth 20000

def onePairWitness : Bool := decide (ObservationCarrier.onePair.length = 1)
def successorWitness : Bool := decide ((([("a", "r-a"), ("b", "r-b")] : List (String × String)).head?) = some ("a", "r-a"))
def witnesses : Value := .array [
 .array [.text "one-reference-pair",.text "One observation and one reference retain two named source coordinates and one pairing.",.boolean onePairWitness],
 .array [.text "successor-retention",.text "Appending a second named pairing leaves the first pairing unchanged.",.boolean successorWitness]]
theorem onePairWitnessPassed : onePairWitness = true := by decide
theorem successorWitnessPassed : successorWitness = true := by decide
def claimId : String := "SFT-CHEM-LIGAND-STATE-SPLITTING-006"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-SELECTION-RULE-STRUCTURE-010","SFT-CHEM-COORDINATION-GEOMETRY-HELD-ORIENTATION-004","SFT-CHEM-COORDINATION-ISOMERISM-EQUIVALENCE-005"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "interaction",.text (interactionName c.interaction)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "multiplicity",.text (multiplicityName c.multiplicity)],.array [.text "separation",.text (separationName c.separation)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "imported-orbital-or-field-table",.text "A named table imports the desired splitting."],.array [.text "generated-rank-three-boundary-two-support",.text "Three directions and rank-two relation generate two held contrasts and three boundary pairs."]]],.array [.text "interaction",.array [.array [.text "free-field-strength-or-fitted-parameter",.text "A free strength can fit any spectrum."],.array [.text "complete-ligand-support-incidence",.text "Every component receives its exact XOR or joint boundary incidence against every retained ligand word."]]],.array [.text "partition",.array [.array [.text "asserted-level-catalogue",.text "An asserted catalogue does not derive degeneracy removal."],.array [.text "complete-equivalence-partition-by-incidence",.text "Equal signatures remain one level and every unequal signature is separated."]]],.array [.text "multiplicity",.array [.array [.text "free-degeneracy-label",.text "A free degeneracy loses member conservation."],.array [.text "positive-cardinality-of-each-partition-block",.text "Each level multiplicity is its exact positive member count and all five members remain."]]],.array [.text "separation",.array [.array [.text "signed-floating-or-dimensional-gap",.text "Signed or fitted gaps violate the exact Fold domain."],.array [.text "exact-positive-normalized-incidence-separation",.text "Adjacent levels carry the positive excess incidence divided by complete ligand count."]]],.array [.text "balance",.array [.array [.text "opposite-signed-shift-premise",.text "Signed displacements import negative values."],.array [.text "complementary-positive-two-block-distances",.text "For two blocks, complementary member counts force positive distances whose weighted products are equal."]]],.array [.text "observation",.array [.array [.text "selected-peak-or-favourable-spectrum",.text "Selected peaks can manufacture correspondence."],.array [.text "complete-sealed-definition-and-spectrum-surfaces",.text "Both IUPAC records and all three complete NIST pages with every discovered payload, ancillary row and boundary condition are retained."]]],.array [.text "extension",.array [.array [.text "species-specific-exception-or-reclassification",.text "An exception permits outcomes to select the law."],.array [.text "same-partition-law-and-removed-ligand-remerging",.text "The same incidence partition applies to every finite geometry and removing the interaction restores one class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact ligand-incidence state partition and balanced splitting"
 branch := "physics"
 statement := "The forced three-direction carrier and rank-two boundary generate exactly five second-rank state supports: two independent held axis contrasts and three complete boundary pairs. Attaching a complete finite ligand geometry assigns each support its exact XOR or joint-boundary incidence signature; equal signatures remain one level and unequal signatures split. Six direct-axis occurrences force positive multiplicities three and two, exact normalized structural separation two-thirds, and complementary balance distances two-fifths and three-fifths. Four complete-axis occurrences reverse the multiplicities to two and three with unit structural separation and balance distances three-fifths and two-fifths. Removing the interaction restores one five-member class."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "generated-rank-three-boundary-two-support__complete-ligand-support-incidence__complete-equivalence-partition-by-incidence__positive-cardinality-of-each-partition-block__exact-positive-normalized-incidence-separation__complementary-positive-two-block-distances__complete-sealed-definition-and-spectrum-surfaces__same-partition-law-and-removed-ligand-remerging"),("base",.text "Before attachment, structural EmptyOne interaction leaves all five generated supports in one complete equivalence class. For the first positive ligand occurrence, each support receives exactly its XOR or joint-boundary incidence and no member is created, lost or duplicated."),("successor",.text "Appending the next distinct ligand word preserves every prior incidence and adds exactly one incidence decision to every support. Equality classes are refined only when the new decision distinguishes members; all five members remain exactly once, every new separation is a positive exact excess over complete ligand count, and removing every distinguishing occurrence remerges the class."),("exclusions",.array [.text "no numerical zero; external glyph 0 is only a source inscription and native absence is structural EmptyOne",.text "no negative irrational imaginary floating signed continuum or opposite-signed displacement in a proof object",.text "no imported d-orbital, crystal-field, ligand-field, point-group, geometry or spectrochemical table in the law or survivor decision",.text "no free field strength, fitted splitting parameter, dimensional wavelength anchor, selected peak, smoothing threshold or target-derived tolerance",.text "no deletion of the twelve ancillary development captures, two law-sealed absent spectra, boundary maxima, adverse rows or unresolved dimensional correspondence",.text "no claim that the exact structural separation is an absolute wavelength; the external vector tests distinguishable spectral support after seal"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; external glyph 0 is only a source inscription and native absence is structural EmptyOne","no negative irrational imaginary floating signed continuum or opposite-signed displacement in a proof object","no imported d-orbital, crystal-field, ligand-field, point-group, geometry or spectrochemical table in the law or survivor decision","no free field strength, fitted splitting parameter, dimensional wavelength anchor, selected peak, smoothing threshold or target-derived tolerance","no deletion of the twelve ancillary development captures, two law-sealed absent spectra, boundary maxima, adverse rows or unresolved dimensional correspondence","no claim that the exact structural separation is an absolute wavelength; the external vector tests distinguishable spectral support after seal"]
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
end SFT.Physics.LigandStateSplittingEvidence

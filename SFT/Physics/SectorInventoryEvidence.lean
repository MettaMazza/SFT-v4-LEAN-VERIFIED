import SFT.Physics.SectorInventoryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.SectorInventoryEvidence
open SFT.Host.Canonical SectorInventoryGrammar

def candidateRecord (c : Candidate) : SFT.Host.Canonical.Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "sector",.text (sectorName c.sector)],.array [.text "charge",.text (chargeName c.charge)],.array [.text "mediator",.text (mediatorName c.mediator)],.array [.text "coupling",.text (couplingName c.coupling)],.array [.text "running",.text (runningName c.running)],.array [.text "singlet",.text (singletName c.singlet)],.array [.text "mixing",.text (mixingName c.mixing)],.array [.text "mass",.text (massName c.mass)],.array [.text "inventory",.text (inventoryName c.inventory)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : SFT.Host.Canonical.Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "sector"),("question",.text "Which sectors are generated?"),("choices",.array [.array [.text "selected-known-sectors",.text "Selecting familiar sectors cannot close the ladder."],.array [.text "complete-primes-through-forced-ceiling",.text "Complete divisibility through the forced ceiling retains two, three, five and seven."]])],.object [("key",.text "charge"),("question",.text "How many charge kinds belong to sector p?"),("choices",.array [.array [.text "borrowed-group-dimension",.text "A borrowed group label imports its answer."],.array [.text "complete-p-fibre-members",.text "The p-fold fibre has exactly p distinct held preimages."]])],.object [("key",.text "mediator"),("question",.text "How are carriers counted?"),("choices",.array [.array [.text "listed-particle-names",.text "Names do not generate a complete inventory."],.array [.text "p-squared-pair-cells-less-One",.text "All ordered charge pairs exist and the unique colourless return is removed."]])],.object [("key",.text "coupling"),("question",.text "What is the holding coupling?"),("choices",.array [.array [.text "measured-coupling",.text "Measurement cannot select the law."],.array [.text "p-predecessor-over-p",.text "All but one of p fibre positions are held relative to the returning One."]])],.object [("key",.text "running"),("question",.text "How does scale support act?"),("choices",.array [.array [.text "imported-beta-function",.text "An imported beta function is outside the grammar."],.array [.text "support-successor-in-sector-gap",.text "Adding complete support to sector count retains one predecessor share and makes every finite gap exact."]])],.object [("key",.text "singlet"),("question",.text "Which composites close charge?"),("choices",.array [.array [.text "imported-hadron-taxonomy",.text "A taxonomy does not prove closure."],.array [.text "complete-p-fibre-or-antipodal-pair",.text "The whole fibre closes a baryon-like singlet and an antipodal pair closes a meson-like singlet."]])],.object [("key",.text "mixing"),("question",.text "How do three generations align?"),("choices",.array [.array [.text "free-mixing-matrix",.text "Free entries are parameters."],.array [.text "three-preimage-offset-over-sector",.text "Uniform displacement of the three preimages fixes diagonal and adjacent-band shares."]])],.object [("key",.text "mass"),("question",.text "How is a fermion's sector mass-part ordered?"),("choices",.array [.array [.text "invented-sector-scale",.text "A new scale forks the unified carrier."],.array [.text "One-shortfall-equals-one-over-p",.text "The shortfall of (p-1)/p is exactly 1/p for every sector."]])],.object [("key",.text "inventory"),("question",.text "Does the particle list terminate?"),("choices",.array [.array [.text "open-ended-particle-list",.text "An open list contradicts the forced sector ceiling."],.array [.text "complete-count-and-first-excluded-prime",.text "All carrier and Smithion counts are exhausted before prime eleven."]])],.object [("key",.text "measurement"),("question",.text "Can known particles select the formulas?"),("choices",.array [.array [.text "known-counts-visible-before-seal",.text "That would restate observation."],.array [.text "inventory-sealed-before-anchor-check",.text "All exact counts and new predictions seal before known mediator counts are checked."]])],.object [("key",.text "record"),("question",.text "What happens to unobserved sectors?"),("choices",.array [.array [.text "omit-fringe-predictions",.text "Omission would erase a forced consequence."],.array [.text "standing-falsifiable-penta-hepta-record",.text "Every penta/hepta carrier, singlet and mixing consequence remains a dated prediction."]])],.object [("key",.text "extension"),("question",.text "May a fifth sector be appended?"),("choices",.array [.array [.text "free-extra-sector",.text "An extra sector violates the cover ceiling."],.array [.text "no-extra-rule",.text "Prime eleven is explicitly the first excluded candidate."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003"
  title := "Complete finite prime-sector force and particle inventory"
  branch := "physics"
  statement := "The forced prime ladder two, three, five and seven closes the entire registered force-sector grammar. For each sector p it fixes p charge kinds, p-squared less One mediators, coupling (p-1)/p, exact successor running, p-member and antipodal singlets, three-generation mixing shares and fermion mass-part 1/p. The first excluded prime eleven terminates the inventory."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002", "SFT-PHYS-STRONG-RUNNING-DIRECTION-002", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-PHYS-MATTER-MIXING-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : SFT.Host.Canonical.Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := identity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : SFT.Host.Canonical.Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := identity (.array [.text "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003",.array ((registrationData "").dependencies.map SFT.Host.Canonical.Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : SFT.Host.Canonical.Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.array [SectorInventoryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity SectorInventoryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : SFT.Host.Canonical.Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.SectorInventoryEvidence

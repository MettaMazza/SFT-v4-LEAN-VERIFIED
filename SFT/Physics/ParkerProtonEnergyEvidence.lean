import SFT.Physics.ParkerProtonEnergyControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ParkerProtonEnergyEvidence
open SFT.Host.Canonical ParkerProtonEnergyGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "particle",.text (particleName c.particle)],.array [.text "alpha",.text (alphaName c.alpha)],.array [.text "channels",.text (channelsName c.channels)],.array [.text "power",.text (powerName c.power)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "scale",.text (scaleName c.scale)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "particle"),("question",.text "Which object carries the predicted share?"),("choices",.array [.array [.text "named-proton-without-composition",.text "A name does not generate its interaction support."],.array [.text "admitted-three-colour-proton",.text "The admitted proton word closes three colour labels while retaining internal colour interaction channels."]])],.object [("key",.text "alpha"),("question",.text "Which exact electromagnetic carrier is current?"),("choices",.array [.array [.text "selected-leading-alpha-rung",.text "The leading rung is retained as a historical control but is not the completed promotion object."],.array [.text "complete-terminal-alpha-rung",.text "The admitted finite promotion ladder fixes the terminal exact alpha before measurement."]])],.object [("key",.text "channels"),("question",.text "How many internal channels contribute?"),("choices",.array [.array [.text "weak-three-channels",.text "The binary-sector mediator count does not match proton colour."],.array [.text "colour-eight-channels",.text "The proton's admitted colour-three sector uniquely supplies eight mediator channels."],.array [.text "penta-twenty-four-channels",.text "The penta-sector count belongs to a different forced sector."],.array [.text "hepta-forty-eight-channels",.text "The hepta-sector count belongs to a different forced sector."]])],.object [("key",.text "power"),("question",.text "How does coupling become energy?"),("choices",.array [.array [.text "linear-alpha-amplitude",.text "A single amplitude is not an energy self-composition."],.array [.text "alpha-squared-energy",.text "The admitted amplitude-to-energy relation uses exactly two copies of alpha."],.array [.text "alpha-cubed-extra-interaction",.text "A third coupling is an unforced extra interaction."]])],.object [("key",.text "composition"),("question",.text "How do channels and energy share compose?"),("choices",.array [.array [.text "add-or-average-channel-shares",.text "Addition or averaging changes the complete channel multiplicity."],.array [.text "complete-channel-count-times-energy-share",.text "Every one of the eight channels carries the same alpha-squared energy part exactly once."]])],.object [("key",.text "scale"),("question",.text "What dimensionful scale may later translate the ratio?"),("choices",.array [.array [.text "local-plasma-fit-or-free-energy",.text "A local field or density would be a fitted environmental parameter."],.array [.text "proton-own-rest-energy-postseal",.text "The predicted dimensionless proton share can act on the proton's own registered rest-energy carrier only after sealing."]])],.object [("key",.text "target"),("question",.text "Can Parker data select the formula?"),("choices",.array [.array [.text "Parker-range-readable-before-seal",.text "That would permit formula selection by the observation."],.array [.text "capability-closed-before-Parker-release",.text "The exact fraction and complete formula census seal without filesystem or target access."]])],.object [("key",.text "provenance"),("question",.text "Was the historical target already known?"),("choices",.array [.array [.text "claim-new-blind-discovery",.text "V2 and the Parker report were already known during V3 reconstruction."],.array [.text "observational-derivation-explicit",.text "The reconstruction is target-inaccessible within execution but is not relabelled as historically blind."]])],.object [("key",.text "comparison"),("question",.text "What constitutes the external test?"),("choices",.array [.array [.text "treat-approximately-400-as-exact-cutoff",.text "The paper reports an approximate energy reach and no uncertainty on 400 keV."],.array [.text "complete-reported-range-and-limitations",.text "The entire 67-527 keV spectrum range, approximate wording, provenance and adverse formulas are retained."]])],.object [("key",.text "extension"),("question",.text "May another coefficient or local input enter?"),("choices",.array [.array [.text "free-local-factor-or-correction",.text "A free local factor would fit the event."],.array [.text "no-extra-rule",.text "Colour channels, terminal alpha square and proton scale exhaust the registered relation."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-PARKER-PROTON-ENERGY-TERMINAL-028"
  title := "Terminal colour-channel alpha-squared proton-energy fraction"
  branch := "physics"
  statement := "The admitted proton colour sector has exactly three charge labels and three-squared Take One non-return channels, hence eight carrier channels. The admitted field-energy composition pairs the electromagnetic amplitude with itself, so the dimensionless proton energy share is eight times alpha squared.  At the historical leading alpha rung this is exactly 500000/1173679081; at the complete terminal alpha rung it is exactly 108147617771025486368/253861190227103943729961.  No proton rest-energy value or Parker observation enters this derivation."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003", "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005", "SFT-PHYS-MECH-WORK-ENERGY-001", "SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-PARKER-PROTON-ENERGY-TERMINAL-028",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-PARKER-PROTON-ENERGY-TERMINAL-028",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [ParkerProtonEnergyControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity ParkerProtonEnergyControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.ParkerProtonEnergyEvidence

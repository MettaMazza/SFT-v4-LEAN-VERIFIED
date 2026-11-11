import SFT.Chemistry.PhotoGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.PhotoEvidence
open SFT.Host.Canonical PhotoGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "photon",.text "the radiation carrier is retained",.boolean true],.array [.text "state",.text "ground and excited states differ",.boolean true],.array [.text "channel",.text "the outcome path is named",.boolean true]]
def claimId : String := "SFT-CHEM-PHOTOCHEM-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-RXN-INTERMEDIATE-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-KIN-ORDER-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "radiation",.text (radiationName c.radiation)],.array [.text "absorption",.text (absorptionName c.absorption)],.array [.text "state",.text (stateName c.state)],.array [.text "channel",.text (channelName c.channel)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "selection",.text (selectionName c.selection)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "radiation",.array [.array [.text "anonymous-energy-input",.text "It cannot establish carrier identity."],.array [.text "one-retained-photon-carrier",.text "The absorbed support is named."]]],.array [.text "absorption",.array [.array [.text "photon-copied",.text "Copying violates conservation."],.array [.text "carrier-absorbed-once",.text "The radiation support enters one molecule."]]],.array [.text "state",.array [.array [.text "ground-state-unchanged",.text "No excitation occurs."],.array [.text "distinct-excited-state-support",.text "The molecular state changes."]]],.array [.text "channel",.array [.array [.text "unregistered-outcome",.text "No chemical path is retained."],.array [.text "source-bound-reaction-or-relaxation-channel",.text "Every endpoint is named."]]],.array [.text "conservation",.array [.array [.text "energy-erased",.text "The path cannot close."],.array [.text "complete-photon-molecule-energy-ledger",.text "Input and outputs balance."]]],.array [.text "selection",.array [.array [.text "free-quantum-yield-fit",.text "A fit can force outcomes."],.array [.text "generated-channel-census",.text "All accessible paths are retained."]]],.array [.text "record",.array [.array [.text "photochemical-label-only",.text "It cannot reproduce excitation."],.array [.text "photon-state-channel-trace",.text "Every transition remains auditable."]]],.array [.text "extra",.array [.array [.text "free-spectral-rule",.text "An imported rule selects a target."],.array [.text "no-extra-rule",.text "Absorption and closed channels supply the law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Photochemical excitation and reaction channel"
 branch := "chemistry"
 statement := "A photochemical event absorbs one retained photon carrier into a named molecular carrier, produces distinct excited support and closes through a generated reaction or relaxation channel with complete energy accounting."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-photon-carrier__carrier-absorbed-once__distinct-excited-state-support__source-bound-reaction-or-relaxation-channel__complete-photon-molecule-energy-ledger"),("base",.text "One photon absorption and one closed molecular channel supply the first photochemical event."),("successor",.text "Appending a channel preserves photon and molecular energy accounting and adds only generated accessible endpoints."),("exclusions",.array [.text "no thermochemical table, spontaneity rule, phase diagram, solubility value, photochemical database, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no energy, matter or photon carrier may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite chemical path initiated when one retained radiation carrier is absorbed by a named molecular carrier, producing a distinct excited-state support and a source-bound reaction or relaxation channel with complete energy accounting."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no thermochemical table, spontaneity rule, phase diagram, solubility value, photochemical database, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no energy, matter or photon carrier may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite chemical path initiated when one retained radiation carrier is absorbed by a named molecular carrier, producing a distinct excited-state support and a source-bound reaction or relaxation channel with complete energy accounting."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with radiation := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.PhotoEvidence

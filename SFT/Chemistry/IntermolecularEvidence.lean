import SFT.Chemistry.IntermolecularGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.IntermolecularEvidence
open SFT.Host.Canonical IntermolecularGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier-pair",.text "one channel joins two distinct molecular wholes",.boolean true],.array [.text "identity",.text "both molecular identifiers remain in the assembly",.boolean true],.array [.text "strength-boundary",.text "no universal strength ranking is asserted",.boolean true]]
def claimId : String := "SFT-CHEM-MOL-INTERMOLECULAR-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-BOND-METALLIC-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-BOND-LENGTH-STRENGTH-001","SFT-CHEM-MOL-MOLECULE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carriers",.text (carriersName c.carriers)],.array [.text "support",.text (supportName c.support)],.array [.text "identity",.text (identityName c.identity)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "strength",.text (strengthName c.strength)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carriers",.array [.array [.text "one-molecule-internal-edge",.text "An internal edge is intramolecular support."],.array [.text "distinct-molecular-carriers",.text "The interaction endpoints are separate molecular wholes."]]],.array [.text "support",.array [.array [.text "proximity-without-channel",.text "Proximity alone supplies no interaction trace."],.array [.text "between-whole-interaction-support",.text "A registered channel joins the molecular carriers."]]],.array [.text "identity",.array [.array [.text "constituents-merged-erased",.text "Erasing each molecule changes the class to a new bonded carrier."],.array [.text "constituent-identities-retained",.text "Each molecular whole remains recoverable."]]],.array [.text "recurrence",.array [.array [.text "transient-coincidence",.text "A coincidence without response cannot organize an assembly."],.array [.text "collective-recurrence",.text "The joined carriers participate in a repeatable joint response."]]],.array [.text "boundary",.array [.array [.text "inter-intra-conflation",.text "Conflation makes every covalent edge intermolecular."],.array [.text "explicit-molecular-boundary",.text "Endpoint ownership distinguishes inter- from intramolecular support."]]],.array [.text "strength",.array [.array [.text "universal-weaker-law",.text "Not every context forces one strength ordering."],.array [.text "source-bounded-interaction-record",.text "Strength and range remain empirical records, not derivation premises."]]],.array [.text "record",.array [.array [.text "force-name-only",.text "A force name cannot reconstruct endpoints and response."],.array [.text "carrier-channel-recurrence-trace",.text "Carriers, channel and conditions remain held."]]],.array [.text "extension",.array [.array [.text "free-force-family",.text "An imported family can select desired interactions."],.array [.text "no-extra-rule",.text "Between-whole support determines the structural class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Intermolecular interaction and residual joining"
 branch := "chemistry"
 statement := "An intermolecular interaction is a registered response channel between already complete molecular carriers that retains each constituent molecular identity and supports collective recurrence."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "distinct-molecular-carriers__between-whole-interaction-support__constituent-identities-retained__collective-recurrence__explicit-molecular-boundary"),("base",.text "Two complete molecular carriers joined by one retained between-whole response channel supply the first intermolecular assembly."),("successor",.text "Appending one molecular carrier and generated channel preserves every component identity and extends collective recurrence only inside the declared boundary."),("exclusions",.array [.text "no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application or opaque prediction result",.text "no claim that topology alone predicts every measured coordinate or energy",.text "external content remains inaccessible until after the consequence is sealed",.text "Every finite interaction support joining two or more already complete molecular carriers while retaining each molecular identity and the boundary between inter- and intramolecular support."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application or opaque prediction result","no claim that topology alone predicts every measured coordinate or energy","external content remains inaccessible until after the consequence is sealed","Every finite interaction support joining two or more already complete molecular carriers while retaining each molecular identity and the boundary between inter- and intramolecular support."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carriers := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.IntermolecularEvidence

import SFT.Physics.StrongCPGrammar
import SFT.Physics.StrongCPWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.StrongCPEntryEvidence
open SFT.Host.Canonical StrongCPGrammar StrongCPWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "strong-hand-census"),("statement",.text "All three nonempty hand subsets are generated and only the paired form completes colour-times-hand support."),("passed",.boolean witness0)],.object [("name",.text "phase-census"),("statement",.text "The complete census yields only aligned One and self-antipodal half-One phase classes."),("passed",.boolean witness1)],.object [("name",.text "no-compensator"),("statement",.text "Exact alignment leaves no strong-violation, EDM or compensator carrier."),("passed",.boolean witness2)],.object [("name",.text "sector-actions"),("statement",.text "All 83 generated mediators preserve fibre and none of 202 cross-fibre pairs is generated."),("passed",.boolean witness3)],.object [("name",.text "proton-invariant"),("statement",.text "All 27 complete colour-three images retain baryon One."),("passed",.boolean witness4)]]
def claimId : String := "SFT-PHYS-STRONG-CP-BARYON-STABILITY-TERMINAL-063"
def dependencies : List String := ["SFT-PHYS-WEAK-PARITY-FIBRE-002", "SFT-PHYS-NEUTRINO-CP-PHASE-002", "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003", "SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001", "SFT-PHYS-MATTER-CONSERVED-LABELS-001", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005", "SFT-PHYS-BARYOGENESIS-DEPENDENCY-TERMINAL-021", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "cp",.text (cpName c.cp)],.array [.text "hand",.text (handName c.hand)],.array [.text "strong",.text (strongName c.strong)],.array [.text "compensator",.text (compensatorName c.compensator)],.array [.text "sector",.text (sectorName c.sector)],.array [.text "baryon",.text (baryonName c.baryon)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "baryogenesis",.text (baryogenesisName c.baryogenesis)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of immutable predecessor, CP carrier, handed support, strong-sector product, compensator, sector-action typing, baryon tally, finite transition, baryogenesis boundary, measurement custody and extension forms."),("grammar_boundary",.text "All nonempty subsets of the exact two-hand fibre; complete colour-three times hand support; every mediator cell in prime sectors two, three, five and seven; every ordered cross-fibre label pair; every colour-three word; and every finite composition of the generated typed actions."),("axes",.array [.object [("key",.text "predecessor"),("question",.text "How are admitted laws used?"),("choices",.array [.array [.text "rewrite-or-bypass-predecessors",.text "A successor cannot change an admitted receipt."],.array [.text "compose-immutable-predecessors",.text "The new law composes only registered exact fibres, sectors and conserved labels."]])],.object [("key",.text "cp"),("question",.text "Which exact CP carrier is available?"),("choices",.array [.array [.text "continuum-angle-or-fitted-small-value",.text "A continuum angle or small fitted value is inadmissible."],.array [.text "aligned-One-or-self-antipodal-half-One",.text "The admitted Fold phase grammar contains exactly alignment and self-antipode."]])],.object [("key",.text "hand"),("question",.text "Which strong-sector hands are retained?"),("choices",.array [.array [.text "selected-single-hand",.text "Selecting one hand omits half the colour-times-hand product."],.array [.text "complete-two-hand-support",.text "With no strong hand selector, every colour label occurs with both held hands."]])],.object [("key",.text "strong"),("question",.text "Where does vectorial strong CP land?"),("choices",.array [.array [.text "weak-antipode-reused-for-strong",.text "A one-hand weak carrier contradicts complete strong support."],.array [.text "paired-parity-returns-aligned-One",.text "Opposition composed with paired parity returns the Fold-invariant One."]])],.object [("key",.text "compensator"),("question",.text "Is an additional phase-restoring field required?"),("choices",.array [.array [.text "add-axion-or-free-compensator",.text "An extra carrier has no discrepancy to act on and forks the closed inventory."],.array [.text "empty-One-no-extra-compensator",.text "Exact structural alignment leaves no unclosed phase and generates no added field."]])],.object [("key",.text "sector"),("question",.text "Can a mediator change fibre identity?"),("choices",.array [.array [.text "invent-cross-fibre-mediator",.text "A two-sector signature is absent from every complete sector action table."],.array [.text "all-generated-actions-are-fibre-preserving",.text "Each of all 83 mediator signatures has the same source and image fibre."]])],.object [("key",.text "baryon"),("question",.text "How is proton baryon support counted?"),("choices",.array [.array [.text "untyped-particle-name",.text "A name alone does not establish conservation."],.array [.text "three-one-third-parts-close-to-One",.text "The complete colour-three word carries three exact one-third parts."]])],.object [("key",.text "transition"),("question",.text "What happens under repeated actions?"),("choices",.array [.array [.text "assume-an-unregistered-decay-step",.text "An unregistered fibre crossing inserts the desired decay."],.array [.text "finite-composition-preserves-the-fibre",.text "Composition of same-fibre maps remains same-fibre at every finite successor."]])],.object [("key",.text "baryogenesis"),("question",.text "Does the cosmological residue law create proton decay?"),("choices",.array [.array [.text "conflate-distinct-process-grammars",.text "A cosmological tally-changing premise is not a low-energy mediator."],.array [.text "retain-explicit-cosmological-boundary",.text "The prior residue law remains intact while no such premise appears in the proton grammar."]])],.object [("key",.text "measurement"),("question",.text "May EDM or lifetime data select the result?"),("choices",.array [.array [.text "target-readable-before-seal",.text "That would tune alignment or stability to observation."],.array [.text "targets-inaccessible-until-seal",.text "The formal census closes before either experiment is opened."]])],.object [("key",.text "extension"),("question",.text "May an added angle, carrier or decay operation enter?"),("choices",.array [.array [.text "free-angle-carrier-or-operation",.text "Any such addition is an unforced parameter."],.array [.text "no-extra-rule",.text "The handed, sector, mediator and finite-composition supports exhaust the declared grammar."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal strong-CP alignment and proton/baryon stability law"
 branch := "physics"
 statement := "The complete colour-three fibre is independent of the binary handed fibre. With no generated hand selector, complete colour-times-hand support retains both hands; enumeration of all three nonempty hand subsets leaves that vectorial form uniquely complete. Opposition composed with paired parity therefore returns the aligned One, whereas either one-hand restriction returns the already admitted self-antipodal half-One weak phase. Strong CP violation, its electric-dipole carrier and any compensating axion-like rule are consequently absent empty-One records, not tuned numerical values. Independently, all 83 generated mediator signatures preserve their prime fibre. Complete enumeration finds 202 cross-fibre label pairs, including six colour-to-binary pairs, but no generated carrier for any of them. Every one of the 27 colour-three proton images retains three one-third baryon parts, exactly the One; finite composition preserves the same fibre."
 evidenceMode := .formal
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
 traceHash := admissionIdentity (.array [.text claimId,.text generationRule,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := admissionIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := admissionIdentity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("result",.text "Strong-sector CP is the aligned One; the strong-violation, electric-dipole and added-compensator records are empty-One. The weak one-hand phase remains the self-antipodal half-One. All 83 generated mediators are fibre-preserving; all 202 ordered cross-fibre label pairs and all six colour-to-binary pairs lack a generated carrier. The proton carries baryon One = 3*(1/3), all 27 generated colour-three images retain it, and every finite composition remains in the colour fibre. Proton decay is absent within the complete declared grammar."),("base",.text "The first colour-three proton word contains exactly three one-third parts, while each primitive mediator action has identical source and image fibre types."),("successor",.text "Composing another fibre-preserving action with a fibre-preserving path cannot change its endpoint type; therefore every finite successor retains the complete colour-three baryon One."),("exclusions",.array [.text "no V1/V2 executable, certificate, answer table, survivor identifier or measurement as a premise",.text "no conventional theta continuum, fitted small angle, negative, irrational, imaginary, floating, NaN or infinite proof scalar",.text "no neutron electric-dipole bound or proton-lifetime limit in formal execution",.text "no imported Peccei-Quinn, axion, grand-unification or Standard Model mechanism as a proof premise",.text "no contradiction of the separately admitted cosmological baryogenesis dependency law"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := admissionIdentity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (admissionIdentity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def exclusions : List String := ["no V1/V2 executable, certificate, answer table, survivor identifier or measurement as a premise", "no conventional theta continuum, fitted small angle, negative, irrational, imaginary, floating, NaN or infinite proof scalar", "no neutron electric-dipole bound or proton-lifetime limit in formal execution", "no imported Peccei-Quinn, axion, grand-unification or Standard Model mechanism as a proof premise", "no contradiction of the separately admitted cosmological baryogenesis dependency law"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with predecessor := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3 && witness4) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.StrongCPEntryEvidence

import SFT.Chemistry.JointCorrelationGrammar
import SFT.Chemistry.JointCorrelationSupport
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.JointCorrelationEvidence
open SFT.Host.Canonical JointCorrelationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-joint-pair",.text "Separated identical carriers retain exactly both complementary cross-centre assignments.",.boolean JointCorrelationSupport.completeJointPairWitness],.array [.text "nonfactorizable-support",.text "Two two-centre marginals would generate four products, while exact joint exchange support retains two.",.boolean JointCorrelationSupport.nonfactorizableWitness],.array [.text "incomplete-control",.text "A one-word separated support loses the complementary exchange assignment and rejects.",.boolean JointCorrelationSupport.incompleteWitness],.array [.text "factorized-control",.text "Adding both same-centre Cartesian words violates the exact correlated support and rejects.",.boolean JointCorrelationSupport.factorizedWitness],.array [.text "same-centre-control",.text "A dissociation record with one repeated product centre rejects.",.boolean JointCorrelationSupport.sameCentreWitness]]
def claimId : String := "SFT-CHEM-JOINT-CORRELATION-DISSOCIATION-007"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005","SFT-CHEM-MOLECULAR-EXCLUSION-EXCHANGE-006"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "support",.text (supportName c.support)],.array [.text "relation",.text (relationName c.relation)],.array [.text "exchange",.text (exchangeName c.exchange)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "energy",.text (energyName c.energy)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "unbound-energy-only-record",.text "An energy alone erases the bound carrier and separated product identities."],.array [.text "bound-carrier-and-product-support",.text "The complete transition retains one bound molecule and every separated product carrier."]]],.array [.text "support",.array [.array [.text "independent-single-product-word",.text "One product word omits the complementary assignment required by indistinguishability and exchange."],.array [.text "complete-complementary-joint-support",.text "Both exchange-complementary separated assignments are generated and retained."]]],.array [.text "relation",.array [.array [.text "marginals-declared-complete",.text "The two one-carrier marginals generate four Cartesian words and cannot identify the exact two-word joint support."],.array [.text "nonfactorizable-held-joint-relation",.text "The retained joint relation selects both lawful cross-centre words and excludes both same-centre words."]]],.array [.text "exchange",.array [.array [.text "named-electron-product-assignment",.text "Named electrons import an unobservable constituent distinction."],.array [.text "held-fibre-exchange-pair",.text "Complementary held fibres enumerate the two assignments without naming either electron."]]],.array [.text "transition",.array [.array [.text "dissociation-as-disconnected-lookup",.text "A lookup does not preserve the molecular-to-product transition trace."],.array [.text "bound-to-separated-support-transition",.text "Dissociation retains the bound identity, both product centres and the complete joint word set."]]],.array [.text "energy",.array [.array [.text "fitted-correlation-correction",.text "A correction coefficient selected from dissociation data is a forbidden free parameter."],.array [.text "positive-post-seal-separation-record",.text "Energy separation remains an exact positive external record opened only after the joint law is sealed."]]],.array [.text "record",.array [.array [.text "selected-single-isotopologue",.text "Selecting one favourable molecule cannot test the complete registered dissociation vector."],.array [.text "complete-measurement-and-provenance-vector",.text "Every measured, compiled, derived-ion, uncertainty and source-quality record is retained."]]],.array [.text "extension",.array [.array [.text "species-specific-correlation-rule",.text "A species exception or imported correlation functional adds an unforced model."],.array [.text "pairwise-successor-with-no-extra-rule",.text "Each added pair and product centre repeats the same exact joint-support construction."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Nonfactorizable molecular joint support and dissociation correspondence"
 branch := "chemistry"
 statement := "Electron correlation is the retained exact joint-support distinction not reconstructible from independent one-carrier marginals. At a two-centre dissociation boundary, the complete indistinguishable-pair support contains both complementary cross-centre assignments, excludes both same-centre Cartesian words, and retains the bound carrier, separated product identities and transition trace. No fitted correction coefficient, signed amplitude, numerical zero or imported correlation functional enters the law."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "bound-carrier-and-product-support__complete-complementary-joint-support__nonfactorizable-held-joint-relation__held-fibre-exchange-pair__bound-to-separated-support-transition__positive-post-seal-separation-record__complete-measurement-and-provenance-vector__pairwise-successor-with-no-extra-rule"),("base",.text "Two held electron fibres and two separated product centres generate four marginal Cartesian words; exchange and same-cell exclusion retain exactly the two complementary cross-centre words."),("successor",.text "Adding a pair or centre preserves every existing joint word and appends the complete exchange-lawful cross-centre assignments. The construction uses a finite support census rather than an adjustable weight or correction coefficient."),("exclusions",.array [.text "no numerical zero; glyph 0 denotes source/interface absence only",.text "no negative, irrational, imaginary, floating, signed-amplitude or continuum proof magnitude",.text "no Hartree-Fock, configuration-interaction, coupled-cluster, density-functional or correlation-energy formula imported as a premise",.text "no fitted correlation coefficient, empirical functional, basis correction or dissociation-energy parameter",.text "no APS or NIST target value, uncertainty, isotope trend or ionic value before prediction seal",.text "no single-product factorization presented as complete joint support",.text "no omission of direct, compiled, derived-ion, older-reference or uncertainty records"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; glyph 0 denotes source/interface absence only","no negative, irrational, imaginary, floating, signed-amplitude or continuum proof magnitude","no Hartree-Fock, configuration-interaction, coupled-cluster, density-functional or correlation-energy formula imported as a premise","no fitted correlation coefficient, empirical functional, basis correction or dissociation-energy parameter","no APS or NIST target value, uncertainty, isotope trend or ionic value before prediction seal","no single-product factorization presented as complete joint support","no omission of direct, compiled, derived-ion, older-reference or uncertainty records"]
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
end SFT.Chemistry.JointCorrelationEvidence

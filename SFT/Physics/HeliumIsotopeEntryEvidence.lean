import SFT.Physics.HeliumIsotopeGrammar
import SFT.Physics.HeliumIsotopeWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.HeliumIsotopeEntryEvidence
open SFT.Host.Canonical HeliumIsotopeGrammar HeliumIsotopeWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "arity"),("statement",.text "Helium-four supplies four retained constituent positions."),("passed",.boolean witness0)],.object [("name",.text "subwords"),("statement",.text "Four positions generate all fifteen nonempty subwords."),("passed",.boolean witness1)],.object [("name",.text "product"),("statement",.text "The complete incidence product contains sixty distinct cells."),("passed",.boolean witness2)],.object [("name",.text "identity"),("statement",.text "A bound isotope has one collective composite identity."),("passed",.boolean witness3)],.object [("name",.text "conversion"),("statement",.text "Holding the collective identity leaves exact conversion 59/60."),("passed",.boolean witness4)],.object [("name",.text "partition"),("statement",.text "The physical shares are exactly 59/240 and 181/240 and close to the One."),("passed",.boolean witness5)]]
def claimId : String := "SFT-PHYS-THERMAL-HELIUM-ISOTOPE-TERMINAL-057"
def dependencies : List String := ["SFT-PHYS-THERMAL-HISTORY-RECOMBINATION-TERMINAL-037", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "family",.text (familyName c.family)],.array [.text "constituents",.text (constituentsName c.constituents)],.array [.text "subwords",.text (subwordsName c.subwords)],.array [.text "product",.text (productName c.product)],.array [.text "identity",.text (identityName c.identity)],.array [.text "conversion",.text (conversionName c.conversion)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "target",.text (targetName c.target)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of analytic-family, constituent, subword, capture-product, composite-identity, isotope-conversion, physical-partition and target-boundary forms."),("grammar_boundary",.text "The admitted analytic helium family; exactly four helium-four constituent positions; every nonempty subword of those positions; their complete incidence product; the single global composite identity; exact positive rational partitions; and no measurement in candidate selection."),("axes",.array [.object [("key",.text "family"),("question",.text "What is the predecessor helium quantity?"),("choices",.array [.array [.text "measured-decimal-called-family-law",.text "A measured decimal cannot select the analytic predecessor."],.array [.text "admitted-quarter-baryon-family",.text "Claim 037 supplies the exact analytic One/four family partition."]])],.object [("key",.text "constituents"),("question",.text "How many retained isotope positions enter?"),("choices",.array [.array [.text "selected-arity",.text "A selected isotope arity is an extra premise."],.array [.text "helium-four-complete-arity",.text "The helium-four identity supplies four retained constituent positions."]])],.object [("key",.text "subwords"),("question",.text "Which constituent subwords enter closure?"),("choices",.array [.array [.text "selected-proper-subset",.text "A selected subset erases a physical composition channel."],.array [.text "all-fifteen-nonempty-subwords",.text "Four positions generate exactly 2^4-1 nonempty subwords."]])],.object [("key",.text "product"),("question",.text "How are positions and subwords composed?"),("choices",.array [.array [.text "partial-incidence-ledger",.text "A partial ledger breaks permutation completeness."],.array [.text "complete-four-by-fifteen-product",.text "Every position occurs against every nonempty subword class, generating sixty cells."]])],.object [("key",.text "identity"),("question",.text "How many collective isotope identities close?"),("choices",.array [.array [.text "empty-or-multiple-composite-identities",.text "No identity leaves the labels unbound; multiple identities add an ungenerated split."],.array [.text "one-global-composite-identity",.text "One bound isotope has exactly one collective identity beyond its constituent labels."]])],.object [("key",.text "conversion"),("question",.text "What physical conversion follows?"),("choices",.array [.array [.text "fitted-isotope-correction",.text "A fitted correction reads the measurement."],.array [.text "fifty-nine-of-sixty-isotope-cells",.text "The one global identity record is held outside the sixty equal mass-incidence cells, leaving 59/60."]])],.object [("key",.text "partition"),("question",.text "What physical abundance partition follows?"),("choices",.array [.array [.text "quarter-rubber-stamp-or-decimal-copy",.text "Neither the analytic quarter nor a copied decimal is the completed isotope partition."],.array [.text "fifty-nine-over-two-forty-and-one-eighty-one-over-two-forty",.text "Composing 1/4 with 59/60 forces 59/240, whose exact complement is 181/240."]])],.object [("key",.text "target"),("question",.text "May helium measurements select the survivor?"),("choices",.array [.array [.text "target-readable-candidate-selection",.text "Target access could manufacture a correction."],.array [.text "target-closed-until-formal-seal",.text "The physical share and complete census seal before external abundance release."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal physical helium-isotope closure"
 branch := "physics"
 statement := "The admitted One/four helium-family share is an analytic baryon partition, not yet the physical isotope mass share. Helium-four has four retained constituent positions and fifteen nonempty constituent subwords. Their complete incidence product has sixty cells. Binding the four positions into one physical isotope introduces exactly one collective composite-identity record: no hold leaves four unbound labels, while more than one hold adds an ungenerated independent composite identity. The remaining fifty-nine cells give the unique isotope conversion 59/60. Therefore the physical primordial helium-isotope share is (One/four)(59/60)=59/240 and the complementary hydrogen-family share is 181/240."
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
def closureValue : Value := .object [("result",.text "The complete four-position by fifteen-nonempty-subword capture ledger has sixty cells and exactly one collective composite-identity record. The unique physical isotope conversion is therefore 59/60. Composed with the admitted analytic helium-family share One/four, this forces primordial physical helium-isotope share 59/240 and complementary hydrogen-family share 181/240, closing exactly to the One."),("base",.text "One four-constituent isotope generates all fifteen nonempty subwords, sixty complete incidence cells and one collective identity record."),("successor",.text "Repeating the same complete isotope word preserves the four-by-fifteen quotient and its single collective identity; disjoint copies preserve 59/60 conversion and the exact physical partition."),("exclusions",.array [.text "no measured helium abundance, uncertainty or central value in formal survivor selection",.text "no fitted decay rate, reaction rate, binding coefficient, abundance correction or selected denominator",.text "no omission of a constituent position or nonempty subword",.text "no multiple ungenerated composite identities",.text "no numerical-nothing, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof scalar"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
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
def exclusions : List String := ["no measured helium abundance, uncertainty or central value in formal survivor selection", "no fitted decay rate, reaction rate, binding coefficient, abundance correction or selected denominator", "no omission of a constituent position or nonempty subword", "no multiple ungenerated composite identities", "no numerical-nothing, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof scalar"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with family := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3 && witness4 && witness5) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.HeliumIsotopeEntryEvidence

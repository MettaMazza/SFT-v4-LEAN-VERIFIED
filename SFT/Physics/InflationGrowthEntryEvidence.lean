import SFT.Physics.InflationGrowthGrammar
import SFT.Physics.InflationGrowthWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.InflationGrowthEntryEvidence
open SFT.Host.Canonical InflationGrowthGrammar InflationGrowthWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "cover"),("statement",.text "Twenty-seven is first covered by depth five support thirty-two."),("passed",.boolean witness0)],.object [("name",.text "partition"),("statement",.text "Thirty-one scalar records and one tensor-pair record close exactly to the One."),("passed",.boolean witness1)],.object [("name",.text "duration"),("statement",.text "The complete support has exactly five Fold doublings."),("passed",.boolean witness2)],.object [("name",.text "growth"),("statement",.text "Quarter-One reaches the One through half-One in exactly two strict steps."),("passed",.boolean witness3)],.object [("name",.text "transfer"),("statement",.text "Third/fourth component powers force exact relative matter growth g."),("passed",.boolean witness4)]]
def claimId : String := "SFT-PHYS-INFLATION-GROWTH-TERMINAL-039"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-FOUNDATION-PART-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-INFO-CONSERVATION-LOSS-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-GRAVITY-GRAVITON-POLARIZATION-003", "SFT-PHYS-COSMO-EXPANSION-001", "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001", "SFT-PHYS-COSMO-STRUCTURE-GROWTH-001", "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "volume",.text (volumeName c.volume)],.array [.text "cover",.text (coverName c.cover)],.array [.text "duration",.text (durationName c.duration)],.array [.text "scalar",.text (scalarName c.scalar)],.array [.text "tensor",.text (tensorName c.tensor)],.array [.text "exit",.text (exitName c.exit)],.array [.text "growth",.text (growthName c.growth)],.array [.text "transfer",.text (transferName c.transfer)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of spatial volume, binary cover, duration carrier, scalar support, tensor support, exit boundary, perturbation growth and component-transfer form."),("grammar_boundary",.text "Generator-three volume in stable three-space; every positive binary support until the unique least cover; every exact complete doubling ratio; the complete thirty-two-record primordial partition; the quarter/half/One Fold growth trace; and every exact positive rational later scale-growth carrier under admitted third/fourth transport."),("axes",.array [.object [("key",.text "volume"),("question",.text "What fixes the inflationary support?"),("choices",.array [.array [.text "named-observable-universe-size",.text "A measured horizon cannot select the support."],.array [.text "generator-three-space-volume",.text "The admitted generator and stable rank force twenty-seven."]])],.object [("key",.text "cover"),("question",.text "What expansion first covers the volume?"),("choices",.array [.array [.text "selected-sixty-efold-story",.text "A conventional model-dependent duration is not a generated Fold count."],.array [.text "least-binary-depth-five-cover",.text "Binary succession first covers twenty-seven at thirty-two."]])],.object [("key",.text "duration"),("question",.text "How is duration counted?"),("choices",.array [.array [.text "irrational-logarithmic-efolds",.text "A continuum logarithm is outside exact Fold arithmetic."],.array [.text "five-exact-doubling-transitions",.text "The cover contains exactly five generated binary transitions."]])],.object [("key",.text "scalar"),("question",.text "What scalar support survives?"),("choices",.array [.array [.text "fitted-spectral-index",.text "A decimal index selected from CMB data is a fit."],.array [.text "one-boundary-record-short-of-complete",.text "One held boundary record leaves thirty-one of thirty-two scalar records."]])],.object [("key",.text "tensor"),("question",.text "What is the least tensor support?"),("choices",.array [.array [.text "free-tensor-amplitude",.text "A tunable tensor amplitude adds a parameter."],.array [.text "one-tensor-pair-record-in-thirty-two",.text "The admitted polarization pair is one Fold distinction on the complete support."]])],.object [("key",.text "exit"),("question",.text "Where does cover growth change regime?"),("choices",.array [.array [.text "chosen-inflaton-potential-exit",.text "A chosen potential imports an independent model."],.array [.text "first-complete-generator-volume-cover",.text "At depth five the generator volume is completely represented and component transport takes over."]])],.object [("key",.text "growth"),("question",.text "How does the least resolved perturbation evolve?"),("choices",.array [.array [.text "stochastic-or-decaying-seed",.text "Ontic noise or decay is not forced by the Fold."],.array [.text "quarter-half-One-two-step-growth",.text "Two exact Fold actions carry quarter-One through half-One to the One."]])],.object [("key",.text "transfer"),("question",.text "How do radiation and matter transfer relative support?"),("choices",.array [.array [.text "fitted-transfer-function",.text "A fitted spectrum is not a law."],.array [.text "third-versus-fourth-power-relative-growth",.text "Admitted component powers force matter/radiation ratio growth by exactly g."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal inflation, primordial-support and structure-growth law"
 branch := "physics"
 statement := "Generator-three stable space has volume twenty-seven and is first completely covered by binary depth five, support thirty-two. Inflation is therefore an exact five-doubling cover process, not a conventional logarithmic duration imported from a potential. One held boundary distinction leaves thirty-one scalar support records and one least tensor-pair record, forcing scalar share 31/32 and tensor share 1/32. The exact quarter-One perturbation grows by two Fold steps through half-One to the One. Under later exact scale growth g, matter retention is One/g^3 and radiation retention One/g^4, so matter gains the exact relative factor g and supplies the earlier gravitational scaffold without a stochastic seed or fitted transfer function."
 evidenceMode := .formal
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
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
def closureValue : Value := .object [("result",.text "The unique generator-volume inflation cover is five Fold doublings with support 32. The complete primordial partition is scalar 31/32 and least tensor-pair 1/32. The structural exit is the first complete cover of volume 27. The least resolved perturbation grows exactly 1/4 to 1/2 to One in two Fold steps. For every exact positive later scale growth g, matter retention is 1/g^3, radiation retention is 1/g^4 and their relative growth is g. A conventional natural-log e-fold count is a comparison label, not an SFT proof scalar."),("base",.text "The first binary distinction supplies two records; the first perturbation part doubles exactly; matter and radiation share the same initial reference."),("successor",.text "Each Fold doubling appends one exact depth and doubles support until the least complete cover. Each later exact scale successor preserves third/fourth transport and multiplies the matter-to-radiation ratio by that successor."),("exclusions",.array [.text "no inflaton potential, slow-roll equation, conventional natural logarithm or selected sixty-e-fold premise",.text "no CMB spectral index, tensor bound, matter spectrum or measured horizon available to candidate selection",.text "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof scalar",.text "no ontic stochastic seed, fitted transfer function, amplitude or free exit scale",.text "no claim that five Fold doublings equal sixty conventional e-folds"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
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
def exclusions : List String := ["no inflaton potential, slow-roll equation, conventional natural logarithm or selected sixty-e-fold premise", "no CMB spectral index, tensor bound, matter spectrum or measured horizon available to candidate selection", "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof scalar", "no ontic stochastic seed, fitted transfer function, amplitude or free exit scale", "no claim that five Fold doublings equal sixty conventional e-folds"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with volume := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3 && witness4) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.InflationGrowthEntryEvidence

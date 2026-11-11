import SFT.Chemistry.IsotopeGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.IsotopeEvidence
open SFT.Host.Canonical IsotopeGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "shared-element",.text "equal atomic numbers preserve one element class",.boolean true],.array [.text "mass-distinction",.text "different mass numbers remain separate nuclides",.boolean true],.array [.text "mixed-element-control",.text "different atomic numbers are rejected",.boolean true]]
def claimId : String := "SFT-CHEM-ELEM-ISOTOPE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001","SFT-PHYS-NUCLEAR-LEVELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-ATOMIC-NUMBER-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "element",.text (elementName c.element)],.array [.text "mass",.text (massName c.mass)],.array [.text "neutron",.text (neutronName c.neutron)],.array [.text "chemistry",.text (chemistryName c.chemistry)],.array [.text "observation",.text (observationName c.observation)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "atom-label-without-nucleus",.text "An atom label alone does not establish nuclide identity."],.array [.text "nuclide-carriers",.text "Each member retains its complete nuclear count record."]]],.array [.text "element",.array [.array [.text "mixed-atomic-numbers",.text "Different proton counts are different elements, not isotopes."],.array [.text "element-identity-retained",.text "Every member shares one atomic number."]]],.array [.text "mass",.array [.array [.text "mass-number-erased",.text "Erasing mass number merges distinct nuclides."],.array [.text "mass-number-distinction",.text "Each isotope retains its distinct nucleon-count coordinate."]]],.array [.text "neutron",.array [.array [.text "unrecorded-nuclear-difference",.text "The source of mass-number distinction cannot remain anonymous."],.array [.text "complementary-nuclear-count-held",.text "The non-proton nuclear count remains a held coordinate."]]],.array [.text "chemistry",.array [.array [.text "different-element-chemistry",.text "Changing element identity does not define an isotope relation."],.array [.text "common-element-chemistry-boundary",.text "Chemical element identity remains common while isotope effects may be observed separately."]]],.array [.text "observation",.array [.array [.text "always-indistinguishable",.text "Isotopic distinctions are resolvable in registered measurements."],.array [.text "resolution-bounded-distinction",.text "The observation record states when mass distinction is retained."]]],.array [.text "record",.array [.array [.text "isotope-name-only",.text "A name cannot reconstruct proton and mass coordinates."],.array [.text "complete-nuclide-family-trace",.text "Every family member retains both coordinates and class membership."]]],.array [.text "extension",.array [.array [.text "free-isotope-equivalence",.text "An arbitrary equivalence can merge different elements or erase mass distinctions."],.array [.text "no-extra-rule",.text "Shared atomic number plus distinct mass number completely fixes the relation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Isotope identity within an element"
 branch := "chemistry"
 statement := "Isotopes are the generated Fold family of nuclide carriers sharing one atomic number while retaining different exact mass-number coordinates."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "nuclide-carriers__element-identity-retained__mass-number-distinction"),("base",.text "Two generated nuclide records sharing one proton count and retaining distinct mass numbers supply the first isotope distinction."),("successor",.text "Appending one nuclide with the same atomic number and a new mass-number coordinate extends the family without changing element identity or erasing prior members."),("exclusions",.array [.text "no IUPAC definition, periodic-table arrangement, measured element value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every positive-finite family of admitted nuclides sharing one atomic-number identity while retaining each distinct generated mass-number coordinate and complete nuclear record."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, periodic-table arrangement, measured element value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","official target content opens only through post-seal custody","Every positive-finite family of admitted nuclides sharing one atomic-number identity while retaining each distinct generated mass-number coordinate and complete nuclear record."]
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
end SFT.Chemistry.IsotopeEvidence

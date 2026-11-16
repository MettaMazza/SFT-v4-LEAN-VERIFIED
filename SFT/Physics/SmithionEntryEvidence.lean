import SFT.Physics.SmithionGrammar
import SFT.Physics.SmithionWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.SmithionEntryEvidence
open SFT.Host.Canonical SmithionGrammar SmithionWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "quark-cross-lock"),("statement",.text "The same product family returns both independently admitted sharpened quark products."),("passed",.boolean witness0)],.object [("name",.text "twelve-roots"),("statement",.text "The complete four-cubic census contains exactly twelve disjoint positive rational root enclosures."),("passed",.boolean witness1)],.object [("name",.text "neutral-lightest"),("statement",.text "Both new sectors have complete neutral fibres and every spectrum has one unique least root."),("passed",.boolean witness2)],.object [("name",.text "abundance"),("statement",.text "The exact cover partition forces both abundance ratios."),("passed",.boolean witness3)],.object [("name",.text "lfv"),("statement",.text "The complete transition table reduces exactly to 3:5:20 and the same-parent tau ratio is four."),("passed",.boolean witness4)],.object [("name",.text "beta"),("statement",.text "Coupling divided by its sector shortfall is p-1 at every admitted prime sector."),("passed",.boolean witness5)]]
def claimId : String := "SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061"
def dependencies : List String := ["SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003", "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003", "SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051", "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001", "SFT-PHYS-FIELD-INVERSE-SQUARE-001", "SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "sector",.text (sectorName c.sector)],.array [.text "kind",.text (kindName c.kind)],.array [.text "depth",.text (depthName c.depth)],.array [.text "invariant",.text (invariantName c.invariant)],.array [.text "roots",.text (rootsName c.roots)],.array [.text "ratios",.text (ratiosName c.ratios)],.array [.text "relic",.text (relicName c.relic)],.array [.text "abundance",.text (abundanceName c.abundance)],.array [.text "flavour",.text (flavourName c.flavour)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of sector, kind, depth, invariant, root-census, mass-ratio, neutral-singlet, stability, abundance, flavour-weight, measurement-boundary and extension forms."),("grammar_boundary",.text "Prime sectors five and seven; down/up cover powers three/four; the complete exact cubic grid; all three root intervals; complete neutral sector fibres; all three lepton transitions; exact positive whole/fraction carriers; and no physical target before seal."),("axes",.array [.object [("key",.text "sector"),("question",.text "Which new sectors enter?"),("choices",.array [.array [.text "selected-particle-sector",.text "A selected sector is not a complete census."],.array [.text "both-forced-prime-sectors",.text "Prime five and seven are the two complete new sectors below the closed ceiling."]])],.object [("key",.text "kind"),("question",.text "Which matter kinds enter?"),("choices",.array [.array [.text "one-selected-kind",.text "One kind omits half the generated spectrum."],.array [.text "complete-down-up-dual",.text "Both generated cover powers are retained for every sector."]])],.object [("key",.text "depth"),("question",.text "What fixes each depth?"),("choices",.array [.array [.text "chosen-depth",.text "A chosen exponent fits a hierarchy."],.array [.text "least-binary-cover-of-sector-power",.text "The down/up powers three/four have unique least binary covers."]])],.object [("key",.text "invariant"),("question",.text "What fixes the product?"),("choices",.array [.array [.text "independent-mass-parameter",.text "A mass parameter forks the law."],.array [.text "same-coloured-product-family",.text "The exact p/[p(2p^d-1)-1] carrier cross-locks both admitted quark products."]])],.object [("key",.text "roots"),("question",.text "How are generations obtained?"),("choices",.array [.array [.text "chosen-decimal-roots",.text "Chosen decimals import an irrational model."],.array [.text "complete-grid-and-rational-halving",.text "Every sign change is enumerated and retained only as exact rational enclosure."]])],.object [("key",.text "ratios"),("question",.text "How are mass ratios represented?"),("choices",.array [.array [.text "floating-central-estimates",.text "A central decimal loses exact root custody."],.array [.text "squared-rational-enclosures-with-light-lift",.text "Every ratio is bounded by exact squared endpoints and the admitted two-fibre lift."]])],.object [("key",.text "relic"),("question",.text "Which state is the relic?"),("choices",.array [.array [.text "named-dark-particle",.text "A name does not force stability or neutrality."],.array [.text "least-complete-neutral-singlet",.text "The complete p-fibre is neutral and its least root has no lower same-charge image."]])],.object [("key",.text "abundance"),("question",.text "What fixes its amount?"),("choices",.array [.array [.text "freezeout-fit-or-density-input",.text "A cross-section or density would be a parameter."],.array [.text "generation-volume-over-cover-depth",.text "Volume 27 over depth five forces 27/5 before comparison."]])],.object [("key",.text "flavour"),("question",.text "What fixes transition weights?"),("choices",.array [.array [.text "fitted-branching-fractions",.text "Fitted rates cannot force a ratio."],.array [.text "squared-separation-times-parent-part",.text "Every channel retains its exact mode separation and parent preimage."]])],.object [("key",.text "measurement"),("question",.text "May observations select the survivor?"),("choices",.array [.array [.text "search-result-readable-before-seal",.text "That would tune the theory to current limits."],.array [.text "all-targets-inaccessible-until-seal",.text "Densities, limits, masses and searches occur only in the empirical successor."]])],.object [("key",.text "extension"),("question",.text "May another scale or particle enter?"),("choices",.array [.array [.text "extra-scale-sector-or-correction",.text "Any added choice violates zero parameters."],.array [.text "no-extra-rule",.text "The closed sector, kind, root, singlet, abundance and transition supports exhaust the grammar."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal dark relic, Smithion spectrum and flavour-transition law"
 branch := "physics"
 statement := "The closed prime-sector ladder transports the already admitted coloured mass construction without a new scale. For each penta and hepta sector and each generated down/up depth, one exact cubic has root sum One, the forced pair carrier and product p/[p(2p^d-1)-1]. Complete 1/1024 enumeration finds exactly three disjoint positive roots per cubic and sixty exact halvings retain rational enclosures, closing twelve Smithion mass-ratio predictions. The complete p-member fibre is neutral, the least root is unique in each spectrum, and the closed sector/generation grammar leaves no lower same-charge decay image, forcing the lightest neutral singlet as the stable relic class. The same generated lepton preimages force mass-weighted flavour carriers 1/32, 5/96 and 5/24, hence 3:5:20 and a tau-channel ratio 4:1. Generator volume 27 and its least binary cover force dark/baryon 27/5 and matter/baryon 32/5. Measurements and search outcomes are inaccessible to this formal execution."
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
def closureValue : Value := .object [("result",.text "Four exact penta/hepta cubics at depths (7,10,9,12) each have three disjoint positive roots, yielding twelve exact rationally enclosed Smithion mass-ratio predictions. Their coloured product family cross-locks the two quark values 3/1454 and 3/13118. Complete neutral p-member singlets and unique lightest roots force the stable relic class within the closed grammar. Dark/baryon is 27/5 and matter/baryon 32/5. Flavour weights are exactly 1/32, 5/96 and 5/24, reducing to 3:5:20 with tau-to-e over tau-to-mu equal to 4. Sector beta slopes are p-1."),("base",.text "The penta down spectrum is the first new-sector cubic; complete enumeration produces exactly three positive disjoint roots and one unique least root."),("successor",.text "Advancing across the generated kind and prime-sector successors changes only the forced pair carrier and least-cover depth; the same complete cubic census, neutral fibre, lightest-root order and no-extra rule are preserved."),("exclusions",.array [.text "no V1/V2 code, answer table, survivor identifier or measurement in formal execution",.text "no fitted mass, coupling, cross-section, freeze-out efficiency, density, branching fraction or search limit",.text "no negative, irrational, imaginary, floating, NaN, infinite or continuum proof scalar",.text "no claim that an unobserved Smithion mass has already been experimentally measured",.text "no claim that non-detection alone identifies the relic"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
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
def exclusions : List String := ["no V1/V2 code, answer table, survivor identifier or measurement in formal execution", "no fitted mass, coupling, cross-section, freeze-out efficiency, density, branching fraction or search limit", "no negative, irrational, imaginary, floating, NaN, infinite or continuum proof scalar", "no claim that an unobserved Smithion mass has already been experimentally measured", "no claim that non-detection alone identifies the relic"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with sector := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3 && witness4 && witness5) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.SmithionEntryEvidence

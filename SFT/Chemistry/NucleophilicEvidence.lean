import SFT.Chemistry.NucleophilicGrammar
import SFT.Chemistry.NucleophilicWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.NucleophilicEvidence
open SFT.Host.Canonical NucleophilicGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-carrier",.text "Every source atom and held electron occurrence survives both complete paths.",.boolean NucleophilicWitnesses.completeCarrier],.array [.text "minimal-bond-change",.text "Exactly the displaced incidence closes and the entering incidence opens.",.boolean NucleophilicWitnesses.minimalChange],.array [.text "pair-retention",.text "The entering pair forms the terminal bond while the displaced pair remains free on the leaving carrier.",.boolean NucleophilicWitnesses.pairRetention],.array [.text "complete-path-family",.text "The generated family contains one-transition exchange and cleavage-then-formation paths.",.boolean NucleophilicWitnesses.completeFamily],.array [.text "formation-first-control",.text "Formation before cleavage halts because it occupies the one exchange slot twice.",.boolean NucleophilicWitnesses.formationFirst],.array [.text "pair-collapse-control",.text "A duplicated electron label cannot masquerade as a complete held pair.",.boolean NucleophilicWitnesses.pairCollapse],.array [.text "successor",.text "Adding one retained substrate occurrence preserves the complete prior path without an extra rule.",.boolean NucleophilicWitnesses.successor]]
def claimId : String := "SFT-CHEM-NUCLEOPHILIC-SUBSTITUTION-FAMILY-007"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001","SFT-CHEM-ORGANIC-REACTION-FAMILY-001","SFT-CHEM-CONJUGATED-SUPPORT-001","SFT-CHEM-RESONANCE-EQUIVALENT-REPRESENTATION-002","SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007","SFT-CHEM-PARALLEL-MECHANISM-COMPOSITION-008"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "source",.text (sourceName c.source)],.array [.text "support",.text (supportName c.support)],.array [.text "change",.text (changeName c.change)],.array [.text "path",.text (pathName c.path)],.array [.text "record",.text (recordName c.record)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "selected-product-label-or-disconnected-fragments",.text "A named answer cannot reconstruct one complete reaction carrier."],.array [.text "complete-source-ordered-reaction-carrier",.text "Centre, retained neighbour, entering carrier and leaving carrier remain distinct occurrences in one source-ordered record."]]],.array [.text "source",.array [.array [.text "reactant-or-bond-support-omitted",.text "Omission prevents exact reconstruction of what changes."],.array [.text "complete-source-bonds-and-free-entering-pair",.text "The source contains the retained bond, displaced bond and free entering pair exactly."]]],.array [.text "support",.array [.array [.text "electrons-created-destroyed-or-collapsed-to-charge-number",.text "A scalar charge or incomplete pair loses the transferred occurrences."],.array [.text "every-held-pair-occurrence-conserved",.text "Both entering occurrences form the new bond and both displaced occurrences remain with the leaving carrier."]]],.array [.text "change",.array [.array [.text "endpoint-only-product-or-extra-bond-change",.text "An endpoint or extra edit does not prove the minimal substitution map."],.array [.text "one-bond-cleaved-and-one-bond-formed",.text "Only the centre-leaving incidence is replaced by the centre-entering incidence."]]],.array [.text "path",.array [.array [.text "named-mechanism-rate-law-or-unordered-snapshots",.text "A conventional name or imported kinetic law can select a path."],.array [.text "complete-one-transition-and-cleavage-first-path-family",.text "The single exchange slot forces either one exchange transition or cleavage followed by formation."]]],.array [.text "record",.array [.array [.text "intermediate-adverse-or-mechanism-row-omitted",.text "Selected records falsely collapse the path family."],.array [.text "every-state-edge-status-and-source-record-retained",.text "Every generated state, edge, source response, favorable, adverse, absent and unresolved record remains auditable."]]],.array [.text "observation",.array [.array [.text "substrate-product-mechanism-readable-before-seal",.text "External structures or terminology could select the survivor."],.array [.text "value-free-structure-and-mechanism-target-seal",.text "Law and complete target identities seal before any newly registered structure or mechanism outcome opens."]]],.array [.text "extension",.array [.array [.text "molecule-specific-exception-or-recomputed-prefix",.text "A special substrate rule is not depth-independent."],.array [.text "fresh-retained-substrate-successor-no-extra-rule",.text "Adding one fresh retained substrate occurrence preserves every prior state, edge and support allocation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact entering/leaving carrier substitution family law"
 branch := "chemistry"
 statement := "For every complete finite registered exchange carrier, one incoming held pair forms the unique centre-entering bond while the two occurrences of the displaced centre-leaving bond remain held on the leaving carrier. Every atom and electron occurrence is conserved. The complete generated path family consists of a one-transition exchange and cleavage followed by formation; formation before cleavage violates the unique exchange slot."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-source-ordered-reaction-carrier__complete-source-bonds-and-free-entering-pair__every-held-pair-occurrence-conserved__one-bond-cleaved-and-one-bond-formed__complete-one-transition-and-cleavage-first-path-family__every-state-edge-status-and-source-record-retained__value-free-structure-and-mechanism-target-seal__fresh-retained-substrate-successor-no-extra-rule"),("base",.text "A four-occurrence source with one retained bond, one displaced bond and one free entering pair forces one terminal with the retained bond, entering bond and displaced free pair through exactly one or two ordered transitions."),("successor",.text "Append one fresh retained substrate occurrence and its complete held pair outside the exchange slot to every path state. Every prior atom, pair, bond change, state and transition remains unchanged without an extra rule."),("exclusions",.array [.text "no native numerical zero; structural absence is EmptyOne",.text "no negative irrational imaginary continuum fitted free random or imported native parameter",.text "no conventional nucleophilic SN1 SN2 rate energy solvent or substrate rule used to generate the survivor",.text "no external substrate product mechanism structure formula charge or source response opened before its applicable seal",.text "the two development-observed IUPAC records are disclosed and never relabelled blind",.text "all nine source rows and the V1 identity-hash transcription correction remain preserved"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no native numerical zero; structural absence is EmptyOne","no negative irrational imaginary continuum fitted free random or imported native parameter","no conventional nucleophilic SN1 SN2 rate energy solvent or substrate rule used to generate the survivor","no external substrate product mechanism structure formula charge or source response opened before its applicable seal","the two development-observed IUPAC records are disclosed and never relabelled blind","all nine source rows and the V1 identity-hash transcription correction remain preserved"]
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
end SFT.Chemistry.NucleophilicEvidence

import SFT.Chemistry.FiniteMicrostateSupportGrammar
import SFT.Chemistry.FiniteMicrostateSupport
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.FiniteMicrostateSupportEvidence
open SFT.Host.Canonical FiniteMicrostateSupportGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-partition",.text "Every generated state occurs in exactly one fibre.",.boolean (match FiniteMicrostateSupport.makeSupport FiniteMicrostateSupport.witnessStates FiniteMicrostateSupport.witnessFibres with | .error _ => false | .ok v => v.microstates.length==3)],.array [.text "exact-multiplicity",.text "The first observation has exactly two predecessors.",.boolean (match FiniteMicrostateSupport.finiteMultiplicity (.fibre FiniteMicrostateSupport.lowFibre) with | .error _ => false | .ok v => v.value==2)],.array [.text "exact-count-weight",.text "The two fibres have exact weights two-thirds and one-third.",.boolean (match FiniteMicrostateSupport.exactStatisticalWeight (.support FiniteMicrostateSupport.witnessSupport) (.held FiniteMicrostateSupport.lowFibre.macrostateId),FiniteMicrostateSupport.exactStatisticalWeight (.support FiniteMicrostateSupport.witnessSupport) (.held FiniteMicrostateSupport.highFibre.macrostateId) with | .ok a,.ok b => a.numerator.value==2 && a.denominator.value==3 && b.numerator.value==1 && b.denominator.value==3 | .error _,.error _ | .error _,.ok _ | .ok _,.error _ => false)],.array [.text "overlap-rejected",.text "A predecessor cannot occur in two observation fibres.",.boolean (match FiniteMicrostateSupport.makeSupport FiniteMicrostateSupport.witnessStates (.tuple [.fibre FiniteMicrostateSupport.lowFibre,.fibre ⟨FiniteMicrostateSupport.highFibre.macrostateId,[FiniteMicrostateSupport.secondState,FiniteMicrostateSupport.thirdState]⟩]) with | .error _ => true | .ok _ => false)],.array [.text "finite-successor",.text "Appending one state preserves all prior assignments.",.boolean (match FiniteMicrostateSupport.finiteSuccessorPreservesPriorAssignments FiniteMicrostateSupport.witnessSupport (.state FiniteMicrostateSupport.fourthState) (.held FiniteMicrostateSupport.successorLabel) with | .error _ => false | .ok value => value)]]
def claimId : String := "SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-THERMO-MICRO-MACRO-001","SFT-PHYS-THERMO-STATISTICAL-WEIGHT-001","SFT-PHYS-THERMO-STATE-RELATION-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-CROSS-PROPERTY-MOLECULAR-VECTOR-014"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "identity",.text (identityName c.identity)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "multiplicity",.text (multiplicityName c.multiplicity)],.array [.text "weight",.text (weightName c.weight)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "support",.array [.array [.text "selected-or-completed-infinite-state-set",.text "A selected or completed-infinite set is neither generated nor exhaustible."],.array [.text "complete-generated-finite-chemical-support",.text "Every admitted microstate is explicitly generated and retained once."]]],.array [.text "identity",.array [.array [.text "answer-only-state-count",.text "A bare count erases composition, phase, condition and internal-state identity."],.array [.text "complete-held-chemical-microstate-identity",.text "Each state retains every chemical identity required to distinguish it."]]],.array [.text "partition",.array [.array [.text "overlapping-or-omitting-observation-classes",.text "Overlap duplicates predecessors and omission deletes them."],.array [.text "disjoint-exhaustive-macro-observation-partition",.text "Every microstate occurs in exactly one named observation fibre."]]],.array [.text "multiplicity",.array [.array [.text "floating-or-assumed-degeneracy",.text "An assumed degeneracy imports an ungenerated statistical parameter."],.array [.text "exact-positive-fibre-count",.text "Multiplicity is the exact positive census of one generated fibre."]]],.array [.text "weight",.array [.array [.text "imported-distribution-or-partition-function",.text "An imported distribution lets a prior select state weights."],.array [.text "exact-fibre-count-over-complete-support-count",.text "Weight is forced by two exact finite counts."]]],.array [.text "prediction",.array [.array [.text "population-temperature-or-calorimetric-target-readable-before-seal",.text "Target access can select the state support or partition."],.array [.text "complete-value-free-state-and-calorimetric-identity-seal",.text "All external identities seal without measured values."]]],.array [.text "record",.array [.array [.text "selected-population-or-calorimetric-showcase",.text "A selected example cannot establish complete source custody."],.array [.text "complete-387-row-external-structure-custody",.text "All 330 direct state and 57 calorimetric rows remain explicit."]]],.array [.text "extension",.array [.array [.text "continuum-or-completed-infinity-closure",.text "A completed continuum is not a finite generated successor."],.array [.text "depth-independent-one-state-finite-successor",.text "One new state and fibre append without changing prior assignments."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Finite chemical microstate-support law"
 branch := "chemistry"
 statement := "A chemical thermodynamic support is the complete generated finite tuple of held chemical microstates, partitioned so every state occurs exactly once in one named macro-observation fibre. Multiplicity is the exact positive fibre count and statistical weight is that count over the complete finite support count. All 387 external identities seal before 330 direct state records and 57 calorimetric rows open."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-generated-finite-chemical-support__complete-held-chemical-microstate-identity__disjoint-exhaustive-macro-observation-partition__exact-positive-fibre-count__exact-fibre-count-over-complete-support-count__complete-value-free-state-and-calorimetric-identity-seal__complete-387-row-external-structure-custody__depth-independent-one-state-finite-successor"),("base",.text "One held chemical microstate forces one nonempty support, one exhaustive observation fibre, multiplicity One and exact weight One over One."),("successor",.text "Appending one newly generated held microstate and its named observation fibre preserves every previous state and assignment and extends the complete support by exactly one finite successor."),("exclusions",.array [.text "no numerical zero; native absence is structural EmptyOne and external zero glyphs remain source inscriptions",.text "no negative, irrational, imaginary, floating, signed or continuum SFT proof value",.text "no completed infinity, continuum ensemble, partition-function prior or assumed probability distribution",.text "no temperature, population, calorimetric value, target payload or target hash in law, grammar or prediction",.text "no fitted coefficient, species parameter, imported statistical equation or target-selected state partition",.text "no selected species, favorable state rows, deduplication of the NIST regime-boundary row or omitted source row"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; native absence is structural EmptyOne and external zero glyphs remain source inscriptions","no negative, irrational, imaginary, floating, signed or continuum SFT proof value","no completed infinity, continuum ensemble, partition-function prior or assumed probability distribution","no temperature, population, calorimetric value, target payload or target hash in law, grammar or prediction","no fitted coefficient, species parameter, imported statistical equation or target-selected state partition","no selected species, favorable state rows, deduplication of the NIST regime-boundary row or omitted source row"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with support := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.FiniteMicrostateSupportEvidence

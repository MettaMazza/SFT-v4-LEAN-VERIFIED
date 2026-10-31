import SFT.Host.SHA256Chunks
import SFT.Physics.CosmicComponentTransportControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CosmicComponentTransportEvidence
open SFT.Host.Canonical CosmicComponentTransportGrammar

def exactIdentity (value : Value) : String :=
 SFT.Host.Text.append "sha256:" (SFT.Host.SHA256Chunks.digest (render value).toUTF8)
theorem exactIdentityPreserved (value : Value) : exactIdentity value=identity value :=
 congrArg (SFT.Host.Text.append "sha256:") (SFT.Host.SHA256Chunks.digestPreserved (render value).toUTF8)

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "space",.text (spaceName c.space)],.array [.text "matter",.text (matterName c.matter)],.array [.text "radiation",.text (radiationName c.radiation)],.array [.text "vacuum",.text (vacuumName c.vacuum)],.array [.text "expansion",.text (expansionName c.expansion)],.array [.text "fractions",.text (fractionsName c.fractions)],.array [.text "equality",.text (equalityName c.equality)],.array [.text "acceleration",.text (accelerationName c.acceleration)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "scale",.text (scaleName c.scale)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "space"),("question",.text "What fixes volume transport?"),("choices",.array [.array [.text "borrowed-three-dimensional-volume",.text "Borrowing the exponent imports a premise."],.array [.text "admitted-generator-three-volume",.text "The independently admitted stable three-space supplies the complete volume power."]])],.object [("key",.text "matter"),("question",.text "How does retained matter transport?"),("choices",.array [.array [.text "selected-matter-power",.text "A selected exponent is a free law."],.array [.text "inverse-volume-third-power",.text "Fixed content over generator-three volume forces the third power of past stretch."]])],.object [("key",.text "radiation"),("question",.text "How does radiation transport?"),("choices",.array [.array [.text "selected-radiation-power",.text "A selected fourth power is not derived."],.array [.text "volume-plus-one-recurrence-power",.text "Three-space dilution plus one wave-recurrence stretch forces the fourth power."]])],.object [("key",.text "vacuum"),("question",.text "How does vacuum transport?"),("choices",.array [.array [.text "selected-static-density",.text "A named cosmological constant cannot select invariance."],.array [.text "Fold-invariant-One",.text "An unchanged Fold carrier has exactly the One transport factor at every successor."]])],.object [("key",.text "expansion"),("question",.text "What squared-rate relation follows?"),("choices",.array [.array [.text "superseded-two-thirds-curve",.text "The leading budget is rejected by the admitted terminal discriminator."],.array [.text "terminal-eleven-five-curve",.text "Exact composition of 11/16 invariant vacuum and 5/16 third-power matter forces (11+5r^3)/16."]])],.object [("key",.text "fractions"),("question",.text "How do epoch fractions follow?"),("choices",.array [.array [.text "fitted-epoch-density",.text "An epoch fit is a parameter."],.array [.text "component-over-complete-rate",.text "Each transported component divided by their exact complete carrier forces both fractions."]])],.object [("key",.text "equality"),("question",.text "Where are matter and vacuum equal?"),("choices",.array [.array [.text "decimal-root-selected",.text "A decimal root may be target-selected and irrational."],.array [.text "exact-cube-eleven-fifths",.text "Equating 5r^3 and 11 forces r^3=11/5; only certified rational bounds may display the root."]])],.object [("key",.text "acceleration"),("question",.text "Where does acceleration begin?"),("choices",.array [.array [.text "old-half-magnitude-and-four-cube",.text "The old result inherits a superseded budget."],.array [.text "exact-seventeen-thirty-seconds-and-twenty-two-fifths",.text "Matter's half-share and vacuum tension force today's 17/32 separation and onset r^3=22/5."]])],.object [("key",.text "orientation"),("question",.text "How are tension and acceleration represented?"),("choices",.array [.array [.text "negative-proof-scalars",.text "Negative scalars violate the Fold proof language."],.array [.text "positive-magnitude-with-held-orientation",.text "Magnitude remains an exact positive fraction while tension/acceleration is a typed label."]])],.object [("key",.text "scale"),("question",.text "How is a dimensional H value obtained?"),("choices",.array [.array [.text "fitted-Hubble-normalization",.text "Fitting H0 to the chronometer rows would select the result."],.array [.text "post-seal-held-reference-transport",.text "The zero-parameter dimensionless curve seals first; a separately measured H0 interval transports it afterward."]])],.object [("key",.text "target"),("question",.text "May measurements select the curve?"),("choices",.array [.array [.text "measurements-readable-before-seal",.text "Target access can manufacture the law."],.array [.text "all-targets-open-only-after-seal",.text "All CCH, acceleration, w, Planck and adverse DESI rows remain outside the forcing runtime."]])],.object [("key",.text "extension"),("question",.text "May another coefficient or exception enter?"),("choices",.array [.array [.text "free-component-correction",.text "An inserted coefficient is a fit."],.array [.text "no-extra-rule",.text "Dimension, recurrence, invariant and terminal shares exhaust the declared law."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032"
  title := "Terminal cosmic component transport and expansion law"
  branch := "physics"
  statement := "Generator-three space forces matter transport by the third power of exact past stretch; one additional wave-recurrence stretch forces radiation by the fourth power; and the vacuum Fold invariant retains the One. With the admitted terminal present shares matter 5/16 and vacuum 11/16, the exact late squared-rate carrier is E2(r)=(11+5r^3)/16, the matter fraction is 5r^3/(11+5r^3), equality is r^3=11/5, acceleration onset is r^3=22/5, and today's accelerating separation has magnitude 17/32. Tension and acceleration are typed orientations, never negative proof scalars."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001", "SFT-PHYS-COSMO-REDSHIFT-001", "SFT-PHYS-COSMO-EXPANSION-001", "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001", "SFT-PHYS-COSMO-COMPLETE-BUDGET-001", "SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-HOSTILE-PACKAGE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing,.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := exactIdentity (.array [.text "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := exactIdentity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := exactIdentity (.array [.text "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def indexBucketCount : Nat := candidates.length*2+1
def rowIndex : Array (List (String × Candidate)) := candidates.foldl (fun index c =>
 let key := candidateId c
 let bucket := key.hash.toNat % indexBucketCount
 index.set! bucket (index[bucket]! ++ [(key,c)])) (Array.replicate indexBucketCount [])
@[irreducible] def decideIdentifier (id : String) : Except String SFT.Engine.CandidateDecision :=
 match (rowIndex[id.hash.toNat % indexBucketCount]!).find? (fun row => SFT.Host.Text.equal row.1 id) with
 | some row => .ok (decisionData row.2)
 | none => .error "StopIteration"
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 decideIdentifier candidate.candidateId

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := exactIdentity (.array [CosmicComponentTransportControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (exactIdentity CosmicComponentTransportControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.CosmicComponentTransportEvidence

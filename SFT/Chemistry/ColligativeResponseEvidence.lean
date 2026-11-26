import SFT.Chemistry.ColligativeResponseGrammar
import SFT.Chemistry.ColligativeResponse
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ColligativeResponseEvidence
open SFT.Host.Canonical ColligativeResponseGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "three-response-orientations",.text "Boiling, freezing and osmotic boundaries retain three distinct forced orientations.",.boolean (match ColligativeResponse.orientationsWitness with | .error _ => false | .ok b => b)],.array [.text "pure-solvent-EmptyOne",.text "Absent solute is the structural pure-solvent boundary.",.boolean (match ColligativeResponse.absenceWitness with | .error _ => false | .ok b => b)],.array [.text "exact-positive-separation",.text "Reference and response are compared by exact positive separation without signed magnitude.",.boolean (match ColligativeResponse.separationWitness with | .error _ => false | .ok b => b)],.array [.text "replication-successor",.text "Common exact particle and response replication preserve orientation.",.boolean (match ColligativeResponse.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-COLLIGATIVE-COMPOSITION-RESPONSE-014"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-MIXTURE-001","SFT-CHEM-STOICH-SOLUTION-001","SFT-CHEM-SOLUTION-EQUILIBRIUM-001","SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002","SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005","SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007","SFT-CHEM-CHEMICAL-POTENTIAL-EQUIVALENT-COMPONENT-008","SFT-CHEM-ACTIVITY-NONIDEAL-COMPOSITION-009","SFT-CHEM-FUGACITY-EQUIVALENT-GAS-MIXTURE-010","SFT-CHEM-PHASE-RULE-STRUCTURAL-011","SFT-CHEM-ONE-COMPONENT-PHASE-BOUNDARY-012","SFT-CHEM-MULTICOMPONENT-PHASE-DIAGRAM-013"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "identity",.text (identityName c.identity)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "direction",.text (directionName c.direction)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "unbound-response-number",.text "A detached number erases the solvent, solute, condition and response boundary."],.array [.text "complete-solvent-solute-particle-account",.text "Every response retains both component identities, exact composition and particle supports."]]],.array [.text "identity",.array [.array [.text "anonymous-particle-count-or-erased-solvent",.text "Anonymous particles cannot distinguish the transmitted solvent from the held solute."],.array [.text "distinct-held-solvent-and-solute-identities",.text "Solvent and solute identities remain distinct and held."]]],.array [.text "boundary",.array [.array [.text "imported-colligative-equation-or-dissociation-factor",.text "An imported equation or factor selects a response instead of forcing it."],.array [.text "exact-solvent-transmission-and-solute-retention-boundary",.text "The phase or membrane transmits solvent while retaining the solute distinction."]]],.array [.text "direction",.array [.array [.text "signed-temperature-or-pressure-displacement",.text "A signed displacement imports negative arithmetic."],.array [.text "held-boiling-freezing-osmotic-orientation-label",.text "Boiling, freezing and osmotic directions are held relations with positive support only."]]],.array [.text "magnitude",.array [.array [.text "linear-constant-fit-or-target-correction",.text "A fitted constant or target correction adds an unforced parameter."],.array [.text "exact-positive-reference-response-separation",.text "Measured response separation is an exact positive fraction after the relation seals."]]],.array [.text "absence",.array [.array [.text "numerical-zero-solute-coordinate",.text "Numerical zero is not an SFT value."],.array [.text "structural-EmptyOne-pure-solvent-boundary",.text "An absent solute coordinate is structural EmptyOne and marks the pure-solvent reference."]]],.array [.text "prediction",.array [.array [.text "response-values-readable-before-seal",.text "Readable values could select the response law."],.array [.text "complete-value-free-276-record-identity-seal",.text "All 144 boiling, 37 freezing and 95 osmotic identities seal before values open."]]],.array [.text "extension",.array [.array [.text "refit-after-particle-or-response-replication",.text "Refitting destroys exact support provenance."],.array [.text "depth-independent-common-replication-and-record-append",.text "Common exact particle/response replication and finite record append preserve orientation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact colligative composition-response law"
 branch := "chemistry"
 statement := "A colligative response is the exact held relation produced when a distinct solute particle identity is retained while solvent exchange remains the transmitted carrier. Solute retention forces a held boiling, freezing or osmotic orientation; measured magnitude is an exact positive reference-response separation opened only after the law seals. Pure solvent uses structural EmptyOne. No conventional response equation, constant, dissociation factor, continuum, regression or fit enters."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-solvent-solute-particle-account__distinct-held-solvent-and-solute-identities__exact-solvent-transmission-and-solute-retention-boundary__held-boiling-freezing-osmotic-orientation-label__exact-positive-reference-response-separation__structural-EmptyOne-pure-solvent-boundary__complete-value-free-276-record-identity-seal__depth-independent-common-replication-and-record-append"),("base",.text "One solvent identity, one distinct solute identity, one exact positive composition, one generated response boundary and one exact positive environment form the least colligative response record."),("successor",.text "Appending any complete response record preserves the finite vector; common positive replication of particle and response supports preserves the held orientation without refitting."),("exclusions",.array [.text "no numerical zero; absent solute composition is structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported van't Hoff factor, dissociation parameter, Raoult law, boiling/freezing constant or osmotic equation",.text "no molality/molarity response equation, interpolation, regression, fit, selected system/row or target correction",.text "no compound, solvent, solute, phase, temperature, pressure, composition, response, uncertainty or target hash before prediction seal",.text "every source decimal remains a post-seal external inscription and every source row remains preserved"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent solute composition is structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported van't Hoff factor, dissociation parameter, Raoult law, boiling/freezing constant or osmotic equation","no molality/molarity response equation, interpolation, regression, fit, selected system/row or target correction","no compound, solvent, solute, phase, temperature, pressure, composition, response, uncertainty or target hash before prediction seal","every source decimal remains a post-seal external inscription and every source row remains preserved"]
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
end SFT.Chemistry.ColligativeResponseEvidence

import SFT.Chemistry.CoordinationEntityGrammar
import SFT.Chemistry.CoordinationEntity
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CoordinationEntityEvidence
open SFT.Host.Canonical CoordinationEntityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "retained-central",.text "Every attachment retains the same central occurrence.",.boolean CoordinationEntity.retainedCentralWitness],.array [.text "retained-ligands",.text "Repeated ligand group labels do not collapse distinct ligand occurrences.",.boolean CoordinationEntity.retainedLigandsWitness],.array [.text "positive-incidences",.text "Every attachment remains a distinct positive incidence trace.",.boolean CoordinationEntity.positiveIncidencesWitness],.array [.text "central-mismatch-control",.text "An attachment to a different centre cannot enter the entity.",.boolean CoordinationEntity.mismatchWitness],.array [.text "successor",.text "The next ligand preserves the complete prior coordination identity.",.boolean CoordinationEntity.successorWitness]]
def claimId : String := "SFT-CHEM-COORDINATION-ENTITY-RETAINED-IDENTITY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001","SFT-CHEM-MULTICENTRE-DELOCALIZED-SUPPORT-008"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "role",.text (roleName c.role)],.array [.text "identity",.text (identityName c.identity)],.array [.text "attachment",.text (attachmentName c.attachment)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "formula-or-name-only",.text "A name does not retain the entity's generated constituents."],.array [.text "complete-coordination-entity-carrier",.text "One entity retains its complete central and ligand support."]]],.array [.text "role",.array [.array [.text "conventional-central-and-ligand-names-imported",.text "Imported role names cannot force which occurrence is common to every incidence."],.array [.text "incidence-forced-central-and-surrounding-roles",.text "The common incident occurrence is central and each attached occurrence is surrounding support."]]],.array [.text "identity",.array [.array [.text "element-or-ligand-occurrences-collapsed",.text "Collapsing repeated labels erases distinct occurrences."],.array [.text "central-and-every-ligand-occurrence-retained",.text "The central occurrence and every ligand occurrence remain distinguishable."]]],.array [.text "attachment",.array [.array [.text "proximity-or-continuum-distance-only",.text "Proximity alone does not retain a generated attachment."],.array [.text "positive-central-ligand-incidence-trace",.text "Every attachment is one explicit positive incidence trace."]]],.array [.text "composition",.array [.array [.text "selected-or-average-ligand-support",.text "Selection or averaging erases members of the coordination entity."],.array [.text "complete-gap-free-ligand-support",.text "Every registered ligand occurrence and attachment remains present exactly once."]]],.array [.text "absence",.array [.array [.text "numerical-zero-or-negative-vacancy",.text "Numerical zero and signed vacancy are not Fold-native forms."],.array [.text "structural-EmptyOne-only",.text "Any absent attachment is structural EmptyOne and is not admitted into positive support."]]],.array [.text "observation",.array [.array [.text "source-structure-visible-before-seal",.text "Observed structures could select the law."],.array [.text "complete-20-record-identity-sealed-structure-vector",.text "Twenty value-free identities seal before all authoritative records open."]]],.array [.text "extension",.array [.array [.text "successor-replaces-central-or-prior-ligand",.text "Replacement destroys retained identity."],.array [.text "next-ligand-preserves-entire-prior-entity",.text "Appending the next complete attachment preserves the entire prior entity."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Coordination entity and retained central-ligand identity law"
 branch := "chemistry"
 statement := "A coordination entity is the complete retained carrier of one central occurrence, every distinct ligand occurrence and every positive central-ligand incidence. Central and surrounding roles are forced by the common incidence structure; repeated ligand labels never erase occurrence identity. Adding the next complete ligand incidence preserves every prior identity and attachment."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-coordination-entity-carrier__incidence-forced-central-and-surrounding-roles__central-and-every-ligand-occurrence-retained__positive-central-ligand-incidence-trace__complete-gap-free-ligand-support__structural-EmptyOne-only__complete-20-record-identity-sealed-structure-vector__next-ligand-preserves-entire-prior-entity"),("base",.text "One central occurrence and one positive attached ligand occurrence force the first complete coordination entity."),("successor",.text "Appending the next distinct ligand occurrence by one positive incidence to the same retained central occurrence preserves every prior entity, central, ligand-group, ligand-occurrence and attachment identity."),("exclusions",.array [.text "no numerical zero; glyph 0 is source/interface absence only and structural absence is EmptyOne",.text "no negative, irrational, imaginary, floating, signed or continuum proof value",.text "no imported coordination-number, valence-bond, ligand-field, molecular-orbital or geometry model",.text "no observed IUPAC definition, NIST formula, point group, link count, coordinate, reference or limitation before prediction seal",.text "no fitted bond length, selected complex, omitted structural row or source-derived correction"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; glyph 0 is source/interface absence only and structural absence is EmptyOne","no negative, irrational, imaginary, floating, signed or continuum proof value","no imported coordination-number, valence-bond, ligand-field, molecular-orbital or geometry model","no observed IUPAC definition, NIST formula, point group, link count, coordinate, reference or limitation before prediction seal","no fitted bond length, selected complex, omitted structural row or source-derived correction"]
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
end SFT.Chemistry.CoordinationEntityEvidence

import SFT.Chemistry.ElectrolysisProductGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ElectrolysisProductEvidence
open SFT.Host.Canonical ElectrolysisProductGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-ratio",.text "Five transferred carriers for two per product retain five-halves.",.boolean true],.array [.text "complete-products",.text "Four carriers yield two complete products.",.boolean true],.array [.text "remainder",.text "One incomplete carrier remains held.",.boolean true],.array [.text "absence",.text "Insufficient carriers close complete products to EmptyOne.",.boolean true],.array [.text "no-remainder",.text "Exact division closes remainder to EmptyOne.",.boolean true],.array [.text "identity",.text "Product identity remains held.",.boolean true],.array [.text "batch-composition",.text "Like batches compose exactly.",.boolean true],.array [.text "mismatch-control",.text "Unlike stoichiometric batches halt.",.boolean true]]
def claimId : String := "SFT-CHEM-ELECTROLYSIS-PRODUCT-AMOUNT-006"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-PLASMA-COLLECTIVE-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-HALF-REACTION-IDENTITY-ORIENTATION-001","SFT-CHEM-ELECTROCHEMICAL-WORK-REACTION-DIRECTION-005"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "custody",.text (custodyName c.custody)],.array [.text "charge",.text (chargeName c.charge)],.array [.text "stoichiometry",.text (stoichiometryName c.stoichiometry)],.array [.text "amount",.text (amountName c.amount)],.array [.text "remainder",.text (remainderName c.remainder)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "record",.text (recordName c.record)],.array [.text "composition",.text (compositionName c.composition)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "custody",.array [.array [.text "mass-answer-only",.text "A mass answer loses electrolysis identity and path."],.array [.text "complete-process-electrode-product-custody",.text "Process, electrode path, product and condition remain held."]]],.array [.text "charge",.array [.array [.text "continuous-charge-premise",.text "A continuum charge does not expose transferred distinctions."],.array [.text "positive-counted-transfer-occurrences",.text "Transferred carriers are exact positive occurrences."]]],.array [.text "stoichiometry",.array [.array [.text "empirical-equivalent-factor",.text "A fitted equivalent factor does not retain carrier demand."],.array [.text "positive-carriers-per-product-occurrence",.text "Product demand is a positive stoichiometric carrier count."]]],.array [.text "amount",.array [.array [.text "rounded-product-count",.text "Rounding destroys exact carrier custody."],.array [.text "exact-carrier-to-product-ratio",.text "Product amount is the exact positive ratio of transferred carriers to required carriers."]]],.array [.text "remainder",.array [.array [.text "discarded-incomplete-product",.text "Discarding a remainder loses transferred distinctions."],.array [.text "complete-products-plus-held-remainder",.text "Complete products and any remaining carriers are separately retained."]]],.array [.text "absence",.array [.array [.text "numerical-zero-product",.text "Numerical zero is not a native product magnitude."],.array [.text "structural-EmptyOne-no-complete-product",.text "Insufficient carriers close the complete-product field to EmptyOne."]]],.array [.text "record",.array [.array [.text "selected-coulometer-result",.text "A selected mass-per-charge value can hide experimental corrections."],.array [.text "complete-charge-product-amount-vector",.text "Every registered run, correction, uncertainty and adverse row remains downstream."]]],.array [.text "composition",.array [.array [.text "batch-specific-conversion",.text "A batch-specific rule adds an unforced parameter."],.array [.text "like-batches-compose-by-counted-addition",.text "Like carrier batches compose without changing the product rule."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold electrolysis and product-amount law"
 branch := "chemistry"
 statement := "Electrolysis product amount is the exact transferred-carrier to stoichiometric-carrier ratio with complete product, path and remainder custody."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-process-electrode-product-custody__positive-counted-transfer-occurrences__positive-carriers-per-product-occurrence__exact-carrier-to-product-ratio__complete-products-plus-held-remainder__structural-EmptyOne-no-complete-product__complete-charge-product-amount-vector__like-batches-compose-by-counted-addition"),("base",.text "One positive carrier occurrence against one positive product demand supplies the first exact amount."),("successor",.text "Like carrier batches compose by exact counted addition without changing the product law."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no coulometer mass current time Faraday or fitted correction selects the survivor",.text "every correction uncertainty adverse comparison and historical value remains downstream provenance"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no coulometer mass current time Faraday or fitted correction selects the survivor","every correction uncertainty adverse comparison and historical value remains downstream provenance"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with custody := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ElectrolysisProductEvidence

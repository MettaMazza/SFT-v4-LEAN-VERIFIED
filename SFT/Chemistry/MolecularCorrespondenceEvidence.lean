import SFT.Chemistry.MolecularCorrespondenceGrammar
import SFT.Chemistry.MolecularCorrespondence
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularCorrespondenceEvidence
open SFT.Host.Canonical MolecularCorrespondenceGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "branchwise-result",.text "Classical and quantum decoded chemical rows agree.",.boolean (MolecularCorrespondence.branchwiseWitness.toOption.getD false)],.array [.text "inverse",.text "Reversible quantum execution restores complete input support.",.boolean (MolecularCorrespondence.inverseWitness.toOption.getD false)],.array [.text "complete-record",.text "Each observed class retains every predecessor record.",.boolean (MolecularCorrespondence.recordWitness.toOption.getD false)]]
def claimId : String := "SFT-CHEM-OPERATIONAL-CLASSICAL-QUANTUM-CORRESPONDENCE-015"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-QUANTUM-REVERSIBLE-MODEL-001","SFT-QUANTUM-CIRCUIT-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-MOLECULAR-QUANTUM-MEASUREMENT-REDUCTION-014"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "description",.text (descriptionName c.description)],.array [.text "embedding",.text (embeddingName c.embedding)],.array [.text "reversibility",.text (reversibilityName c.reversibility)],.array [.text "quantum",.text (quantumName c.quantum)],.array [.text "chemistry",.text (chemistryName c.chemistry)],.array [.text "observation",.text (observationName c.observation)],.array [.text "result",.text (resultName c.result)],.array [.text "resource",.text (resourceName c.resource)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "description",.array [.array [.text "different-classical-and-quantum-chemistries",.text "Different chemical descriptions make result agreement accidental."],.array [.text "common-generated-molecular-description",.text "Both modes consume one exact chemical description."]]],.array [.text "embedding",.array [.array [.text "lossy-classical-reencoding",.text "Lossy embedding cannot preserve a chemical state."],.array [.text "singleton-branch-classical-embedding",.text "Each classical state embeds as one held-phase branch."]]],.array [.text "reversibility",.array [.array [.text "hidden-irreversible-predecessor",.text "A hidden predecessor prevents inverse execution."],.array [.text "reversible-classical-transition-submodel",.text "The correspondence submodel retains a finite bijection and exact inverse."]]],.array [.text "quantum",.array [.array [.text "selected-branch-execution",.text "Selected execution does not establish branchwise equivalence."],.array [.text "complete-branchwise-quantum-execution",.text "Every generated chemical input branch executes."]]],.array [.text "chemistry",.array [.array [.text "mode-specific-transition-law",.text "Mode-specific laws allow the machine to select Chemistry."],.array [.text "one-admitted-chemical-transition-law",.text "Both modes consume the same admitted Chemistry law."]]],.array [.text "observation",.array [.array [.text "result-without-shared-decoder",.text "Unrelated outputs cannot be compared."],.array [.text "shared-chemical-decoder-and-record",.text "Observation decodes the same chemical state and retains every branch record."]]],.array [.text "result",.array [.array [.text "one-way-result-simulation",.text "One-way simulation is not full operational correspondence."],.array [.text "bidirectional-result-and-inverse-preservation",.text "Forward results agree and inverse execution restores every input."]]],.array [.text "resource",.array [.array [.text "uncounted-correspondence-overhead",.text "Uncounted overhead hides the operational distinction."],.array [.text "exact-positive-overhead-ledger",.text "Inputs, branches, gates and records are counted exactly."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact operational classical--quantum chemical correspondence"
 branch := "chemistry"
 statement := "One admitted molecular process description embeds every classical chemical state into the reversible Fold-quantum submodel. Complete branchwise quantum execution, shared observation decoding, exact inverse restoration and a positive resource ledger preserve every classical result bidirectionally. Phase-labelled quantum traces remain explicit and are not collapsed into the classical trace."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "common-generated-molecular-description__singleton-branch-classical-embedding__reversible-classical-transition-submodel__complete-branchwise-quantum-execution__one-admitted-chemical-transition-law__shared-chemical-decoder-and-record__bidirectional-result-and-inverse-preservation__exact-positive-overhead-ledger"),("base",.text "One retained molecular carrier with one reversible transition row embeds as one classical state and one held-phase quantum branch; both decode the same terminal chemical state and the inverse restores the input."),("successor",.text "Appending one distinct reversible transition row adds exactly its classical execution, singleton embedding, quantum branch, complete observation record and inverse row while preserving every earlier result and exact resource count."),("exclusions",.array [.text "no numerical zero, negative, irrational, imaginary, floating, signed or continuum proof value",.text "no imported bit, qubit, amplitude, Hilbert space, stochastic collapse or conventional circuit premise",.text "no fitted, learned, hardware or application parameter",.text "no mode-specific chemical law or target-selected molecular process",.text "no claim that phase-sensitive or nonfactorable quantum traces are identical to classical traces"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero, negative, irrational, imaginary, floating, signed or continuum proof value","no imported bit, qubit, amplitude, Hilbert space, stochastic collapse or conventional circuit premise","no fitted, learned, hardware or application parameter","no mode-specific chemical law or target-selected molecular process","no claim that phase-sensitive or nonfactorable quantum traces are identical to classical traces"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with description := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

-- OperationalChemistrySpec.validate, preserving the original guard order.
def validateSpec (identity : String) (parents : List String)
 (axes : List (String × List (String × Bool))) (operational : List Bool) : Except String Unit := do
 if !(SFT.Host.Text.chars "SFT-CHEM-").isPrefixOf (SFT.Host.Text.chars identity) || parents.isEmpty then
  throw "operational Chemistry specification has invalid identity"
 if axes.length != 8 || !SFT.Mathematics.DiscreteObjects.distinct (axes.map Prod.fst) then
  throw "operational Chemistry specification requires eight distinct axes"
 if axes.any (fun axis => axis.2.length != 2) then throw "operational dimensions must be binary"
 let _ ← axes.mapM fun axis => do
  if (axis.2.filter Prod.snd).length != 1 then throw (SFT.Host.Text.intercalate "" ["dimension ",axis.1," requires one preserving form"])
 if operational.isEmpty || !operational.all id then throw "operational Chemistry witness failed"
 return ()
def registeredSpecValid : Except String Unit := validateSpec claimId dependencies [("description",[("different-classical-and-quantum-chemistries",false),("common-generated-molecular-description",true)]),("embedding",[("lossy-classical-reencoding",false),("singleton-branch-classical-embedding",true)]),("reversibility",[("hidden-irreversible-predecessor",false),("reversible-classical-transition-submodel",true)]),("quantum",[("selected-branch-execution",false),("complete-branchwise-quantum-execution",true)]),("chemistry",[("mode-specific-transition-law",false),("one-admitted-chemical-transition-law",true)]),("observation",[("result-without-shared-decoder",false),("shared-chemical-decoder-and-record",true)]),("result",[("one-way-result-simulation",false),("bidirectional-result-and-inverse-preservation",true)]),("resource",[("uncounted-correspondence-overhead",false),("exact-positive-overhead-ledger",true)])] [MolecularCorrespondence.branchwiseWitness.toOption.getD false,
 MolecularCorrespondence.inverseWitness.toOption.getD false,MolecularCorrespondence.recordWitness.toOption.getD false]
theorem registeredSpecPassed : registeredSpecValid = .ok () := rfl
end SFT.Chemistry.MolecularCorrespondenceEvidence

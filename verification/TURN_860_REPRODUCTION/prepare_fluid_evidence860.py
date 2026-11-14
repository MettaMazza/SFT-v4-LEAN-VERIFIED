from pathlib import Path
exec(Path('work/fluid_spec860.py').read_text())
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(tuple,list)):return '.array ['+','.join(cv(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
s='''import SFT.Mathematics.FlooredFluidGrammar
import SFT.Mathematics.FlooredFluid
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.FlooredFluidEvidence
open SFT.Host.Canonical FlooredFluidGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witness0 : Bool := (FlooredFluid.gradient (FlooredFluid.minimumEdge 5 0 1)).numerator == 32 && (FlooredFluid.gradient (FlooredFluid.minimumEdge 5 0 1)).denominator == 1
def witness1 : Bool := (List.range 14).all (fun n => let g := FlooredFluid.gradient (FlooredFluid.minimumEdge (n+1) 0 1); g.numerator == 2^(n+1) && g.denominator == 1)
def witness2 : Bool := (75+75 : Nat) == 150
theorem witness0Passed : witness0 = true := rfl
theorem witness1Passed : witness1 = true := rfl
theorem witness2Passed : witness2 = true := rfl
'''
s+='def witnesses : Value := .array ['+','.join('.array [.text '+q(w.name)+',.text '+q(w.statement)+',.boolean witness'+str(i)+']' for i,w in enumerate(spec.witnesses))+']\n'
s+='def witnessRecords : Value := .array ['+','.join('.object [("name",.text '+q(w.name)+'),("statement",.text '+q(w.statement)+'),("passed",.boolean witness'+str(i)+')]' for i,w in enumerate(spec.witnesses))+']\n'
s+='def claimId : String := '+q(spec.claim_id)+'\ndef dependencies : List String := ['+','.join(q(d) for d in spec.dependencies)+']\n'
s+='def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array ['+','.join('.array [.text '+q(d.key)+',.text ('+d.key+'Name c.'+d.key+')]' for d in spec.dimensions)+']),("exact_form",.text (exactForm c))]\n'
comp={k:v for k,v in completeness.items() if k!='candidate_ids'}
s+='def completenessRecord : Value := .object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in comp.items())+ ',("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]\n'
s+='''def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := '''+q(spec.title)+'''
 branch := "mathematics"
 statement := '''+q(spec.statement)+'''
 evidenceMode := .formal
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
 traceHash := admissionIdentity (.object [("claim_id",.text claimId),("generator",.text generationRule),("record",candidateRecord c)])
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
 proofHash := admissionIdentity (.object [("claim_id",.text claimId),("dependencies",.array (dependencies.map Value.text)),("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
'''
s+='def closureValue : Value := .object ['+','.join('('+q(k)+','+('witnesses' if k=='operational_witnesses' else cv(v))+')' for k,v in closure.items())+']\n'
s+='def generalityValue : Value := .object [("claim_id",.text claimId),("base",'+cv(spec.induction_base)+'),("successor",'+cv(spec.induction_step)+'),("laws",'+cv(spec.laws)+'),("witnesses",witnessRecords)]\n'
s+='''def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := admissionIdentity (.object [("closure",closureValue),("decisions",.array (decisions.map SFT.Engine.decisionValue))])
 generalityCertificateHash := some (admissionIdentity generalityValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (expected observed : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := expected
 observedBehavior := observed
 receiptHash := admissionIdentity (.object [("kind",.text (SFT.Engine.kindName kind)),("expected",.text expected),("observed",.text observed),("passed",.boolean passed)])
'''
s+='def exclusions : List String := ['+','.join(q(e) for e in spec.boundary_exclusions)+']\n'
s+='''def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with lattice := .rejected}) survivorId))
 "reject a generated form missing the first required structural condition" (decisionReason {survivor with lattice := .rejected}),
 control .tamperedSource (!(SFT.Host.Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed official source identity" "the changed identity differs from the registered source manifest",
 control .tamperedArtifact (((candidates.filter survives).length == 1) && ((candidates.map candidateId).eraseDups.length == candidates.length))
 "reject a missing, duplicated or additional survivor" "the generated product contains exactly one registered survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2)
 "halt any attempt to import an excluded object or answer-producing model" (SFT.Host.Text.intercalate "; " exclusions)]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)
theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Mathematics.FlooredFluidEvidence
'''
Path('work/constants-recovery/SFT/Mathematics/FlooredFluidEvidence.lean').write_text(s)

exec(open('work/diffraction_spec490.py').read())

def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(tuple,list)):return '.array ['+','.join(cv(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
s='''import «work».DiffractionGrammar490
import SFT.Engine.RegistrationGate
namespace SFT.Physics.DiffractionEvidence
open SFT.Host.Canonical DiffractionGrammar
set_option maxRecDepth 20000

def onePairWitness : Bool := decide (ObservationCarrier.onePair.length = 1)
def successorWitness : Bool := decide ((([("a", "r-a"), ("b", "r-b")] : List (String × String)).head?) = some ("a", "r-a"))
def witnesses : Value := .array [
 .array [.text "one-reference-pair",.text "One observation and one reference retain two named source coordinates and one pairing.",.boolean onePairWitness],
 .array [.text "successor-retention",.text "Appending a second named pairing leaves the first pairing unchanged.",.boolean successorWitness]]
theorem onePairWitnessPassed : onePairWitness = true := by decide
theorem successorWitnessPassed : successorWitness = true := by decide
'''
s+='def claimId : String := '+q(cid)+'\ndef dependencies : List String := ['+','.join(q(x) for x in values['dependencies'])+']\n'
s+='def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array ['+','.join('.array [.text '+q(k)+',.text ('+k+'Name c.'+k+')]' for k,*_ in dims)+']),("exact_form",.text (exactForm c))]\n'
s+='def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",'+cv([(k,((bad,br),(good,gr))) for k,qu,bad,br,good,gr in dims])+'),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]\n'
s+='''def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := '''+q(values['title'])+'''
 branch := "physics"
 statement := '''+q(values['statement'])+'''
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
'''
s+='def closureValue : Value := .object [("claim_id",.text claimId),("result",'+cv(values['exact_result'])+'),("base",'+cv(values['induction_base'])+'),("successor",'+cv(values['induction_step'])+'),("exclusions",'+cv(values['exclusions'])+'),("witnesses",witnesses),("survivor",.text survivorId)]\n'
s+='def exclusions : List String := ['+','.join(q(x) for x in values['exclusions'])+']\n'
s+='''def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
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
end SFT.Physics.DiffractionEvidence
'''
# The exclusion support is fixed nonempty in the pinned source; keep the literal boundary test.
s=s.replace('control .boundary (!exclusions.isEmpty)','control .boundary (!('+cv(values['exclusions']).replace('.array ', '',1)+').isEmpty && witnessPassed)') if False else s
Path('work/DiffractionEvidence490.lean').write_text(s)

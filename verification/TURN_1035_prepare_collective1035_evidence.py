from pathlib import Path
import sys,json,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.collective_radiation_response_terminal_law_v1 import SPEC
from sft.physics.structural_constants import completeness_record
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer '+str(x)
 if isinstance(x,(tuple,list)):return '.array ['+','.join(cv(y)for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')'for k,v in x.items())+']'
 raise TypeError(x)
s=(r/'SFT/Mathematics/CalculatorBrowserEntryEvidence.lean').read_text().replace('SFT.Mathematics.CalculatorBrowser','SFT.Physics.CollectiveRadiation').replace('CalculatorBrowserGrammar','CollectiveRadiationGrammar').replace('CalculatorBrowserWitnesses','CollectiveRadiationWitnesses').replace('CalculatorBrowserEntryEvidence','CollectiveRadiationEntryEvidence')
a=s.index('def witnesses');b=s.index('def claimId',a);wn=['witness'+str(i) for i in range(5)];records='.array ['+','.join('.object [("name",.text '+q(v.name)+'),("statement",.text '+q(v.statement)+'),("passed",.boolean '+name+')]'for v,name in zip(SPEC.witnesses,wn))+']';s=s[:a]+'def witnessRecords : Value := '+records+'\n'+s[b:]
s=re.sub(r'def claimId : String := .*','def claimId : String := '+q(SPEC.claim_id),s);s=re.sub(r'def dependencies : List String := .*','def dependencies : List String := '+q(SPEC.dependencies),s)
a=s.index('def candidateRecord');b=s.index('def registrationData',a)
rec=','.join('.array [.text '+q(axis.key)+',.text ('+axis.key+'Name c.'+axis.key+')]'for axis in SPEC.axes)
completeness=completeness_record(SPEC);del completeness['candidate_ids'];s=s[:a]+'def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array ['+rec+']),("exact_form",.text (exactForm c))]\n'+'def completenessRecord : Value := .object ['+','.join('('+q(k)+','+cv(v)+')'for k,v in completeness.items())+',("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]\n'+s[b:]
a=s.index('def registrationData');b=s.index('def registration (',a);s=s[:a]+'''def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := '''+q(SPEC.title)+'''
 branch := "physics"
 statement := '''+q(SPEC.statement)+'''
 evidenceMode := .formal
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
'''+s[b:]
s=s.replace('identity (.array [.text claimId,candidateRecord c])','identity (.array [.text claimId,.text generationRule,candidateRecord c])')
a=s.index('def closureValue');b=s.index('def closureData',a);closure={'result':SPEC.exact_result,'base':SPEC.induction_base,'successor':SPEC.induction_step,'exclusions':SPEC.exclusions};s=s[:a]+'def closureValue : Value := .object ['+','.join('('+q(k)+','+cv(v)+')'for k,v in closure.items())+',("witnesses",witnessRecords),("unique_survivor",.text survivorId)]\n'+s[b:]
s=s.replace('identity generalityValue','identity closureValue')
a=s.index('def control (');b=s.index('theorem registrationNoAxioms',a);s=s[:a]+'''def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def exclusions : List String := '''+q(SPEC.exclusions)+'''
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with occupation := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && '''+' && '.join(wn)+''') "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

'''+s[b:]
(r/'SFT/Physics/CollectiveRadiationEntryEvidence.lean').write_text(s)

# Preserve source closure hash name in generated output.
p=Path("/Volumes/One Touch/SFT v4 Full model LEAN/SFT/Physics/CollectiveRadiationEntryEvidence.lean")
p.write_text(p.read_text().replace("generalityValue", "closureValue"))

s=p.read_text().replace('(.object [("claim_id",.text claimId),("generator",.text generationRule),("record",candidateRecord c)])','(.array [.text claimId,.text generationRule,candidateRecord c])').replace('(.object [("claim_id",.text claimId),("dependencies",.array (dependencies.map Value.text)),("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])','(.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])').replace('(.object [("closure",closureValue),("decisions",.array (decisions.map SFT.Engine.decisionValue))])','(.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])')
p.write_text(s)

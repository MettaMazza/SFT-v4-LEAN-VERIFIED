from pathlib import Path
import ast,json,subprocess
w=Path('work');r=w/'constants-recovery';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-FOUNDATION-ADMISSION-ENFORCEMENT-001'
def raw(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
tree=ast.parse(raw('sft/foundation/admission_enforcement.py'));q=lambda x:json.dumps(x,ensure_ascii=False)
domains=ast.literal_eval(next(n.value for n in tree.body if isinstance(n,ast.Assign) and n.targets[0].id=='DOMAINS'));survivor='__'.join(x[0 if i==10 else 1] for i,x in enumerate(domains));ns={'SURVIVOR':survivor};exec(compile(ast.Module(body=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='closure_record'],type_ignores=[]),'source','exec'),ns)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,(tuple,list)):return '.array ['+','.join(cv(v) for v in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
s='import SFT.Foundation.AdmissionGrammar\nimport SFT.Foundation.FoldControls\nnamespace SFT.Foundation.AdmissionControls\nopen SFT.Host.Canonical AdmissionAcceptance\nset_option maxRecDepth 20000\n'
s+='def closureValue : Value := '+cv(ns['closure_record']())+'\n'
controls=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='control_records').body[0].value.elts
exprs=['!(admissionAccepts [("parameter_free",false)])','!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash) && !(admissionAccepts [("root_bound",false)])','!(admissionAccepts [("unique",false)]) && !(admissionAccepts [("preserved",false)])','!(admissionAccepts [("postseal",false)]) && !(admissionAccepts [("admitted_dependency",false)]) && admissionAccepts []']
for i,(name,kind) in enumerate([('falsePremise','falsePremise'),('tamperedSource','tamperedSource'),('tamperedArtifact','tamperedArtifact'),('boundary','boundary')]):
 row={ast.literal_eval(k):v for k,v in zip(controls[i].keys,controls[i].values)};s+='def '+name+(' (sourceHash : String)' if i==1 else '')+' : FoldControls.ControlRecord where\n kind := .'+kind+'\n passed := '+exprs[i]+'\n expected := '+q(ast.literal_eval(row['expected']))+'\n observed := '+q(ast.literal_eval(row['observed']))+'\n'
 if i!=1:s+='theorem '+name+'Passed : '+name+'.passed = true := rfl\n'
s+='def controlRecords (sourceHash : String) := [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]\ndef runControls (sourceHash : String) : Value := .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))\nend SFT.Foundation.AdmissionControls\n';(r/'SFT/Foundation/AdmissionControls.lean').write_text(s)
s=(r/'SFT/Foundation/FormEnforcementEvidence.lean').read_text().replace('FormEnforcement','Admission');a=s.index('def candidateRecord');b=s.index('def registrationData',a)
gates=('registration','enumeration','forcing','form closure','controls','seal','independent validation','post-seal empirical validation when registered','model admission','immutable receipt')
s=s[:a]+'''def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generator",.text generationRule),("boundary",.text grammarBoundary),("domains",'''+cv(domains)+'''),("candidates",.array (candidates.map candidateRecord)),("gate_order",'''+cv(gates)+''')]

'''+s[b:]
reg=json.loads(raw('claims/'+cid+'/registration.json'));a=s.index('def registrationData');b=s.index('def registration (',a)
s=s[:a]+'''def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := '''+q(cid)+'''
 title := '''+q(reg['title'])+'''
 branch := "foundation"
 statement := '''+q(reg['statement'])+'''
 evidenceMode := .formal
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := '''+q(reg['dependencies'])+'''
 axioms := []
 freeParameters := []
 provenance := [.constitutionalRelation]
 sourceHash := sourceHash

'''+s[b:]
s=s.replace(',("dependency",.text "SFT-FOUNDATION-FORM-GRAMMAR-001")','').replace('"canonical_structural_induction"','"branch_and_host_independent_gate_relation"');(r/'SFT/Foundation/AdmissionEvidence.lean').write_text(s)
print(cid)

from pathlib import Path
import sys,os,json,re,subprocess,tempfile,hashlib
from types import SimpleNamespace
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_complete import evidence as e,expression_census as c
from sft.mathematics.calculator_complete.machine import Calculator
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def q(s):return json.dumps(s,ensure_ascii=False)
def run(name,code):
 p=w/(name+'.lean');p.write_text(code);x=subprocess.run([lean,'-j1','-M12288',str(p)],env=env,capture_output=True,text=True);(w/(name+'.log')).write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-4000:];return x.stdout
head='''import SFT.Mathematics.CalculatorCompleteEvidence
import SFT.Mathematics.CalculatorExpressionCensus
open SFT.Mathematics SFT.Host.Canonical
open CalculatorCompleteEvidence
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => .object [("ok",v)] | .error e => .object [("error",.text e)]
def evidence (s : String) (rows : Option (List CensusRow)) : Except String Value := do
 let x ← CalculatorCompleteMachine.calculate s 3 10000 "rad"
 let v ← calculationEvidence x rows
 let j ← calculationEvidenceJSON x rows
 pure (.array [v,.text j])
'''
exprs=['1-1','1+1=','1-2','1/3','sqrt(2)','sqrt(-4)','complex(1,-2)','sin(1)','cos(10)','ln(2)','exp(1)','ncr(8,3)','2^(1/2)']
rowcases=[None,[],[{'claim_id':'other','receipt_hash':'wrong'}],[{'claim_id':e.CALCULATOR_CLAIM_ID,'receipt_hash':'first'},{'claim_id':e.CALCULATOR_CLAIM_ID,'receipt_hash':'second'}],[{'claim_id':e.CALCULATOR_CLAIM_ID}]]
expected=[];codes=[]
with tempfile.TemporaryDirectory() as d:
 root=Path(d);(root/'census').mkdir()
 for rows in rowcases:
  path=root/'census/claims.json'
  if rows is None:
   if path.exists():path.unlink()
  else:path.write_text(json.dumps({'claims':rows}))
  lr='none' if rows is None else '(some ['+','.join('⟨'+q(x['claim_id'])+','+('.text '+q(x['receipt_hash']) if 'receipt_hash'in x else '.null')+',false⟩' for x in rows)+'])'
  for expr in exprs:
   calc=Calculator(places=3,operation_limit=10000,angle_mode='rad').calculate(expr)
   expected.append({'ok':[json.loads(json.dumps(e.calculation_evidence(calc,root))),e.calculation_evidence_json(calc,root)]});codes.append('result (evidence '+q(expr)+' '+lr+')')
actual=json.loads(run('calculator1024_evidence_check',head+'#eval IO.println (render (.array ['+','.join(codes)+']))\n'));assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:2]
original=c.SPECS;ids=[x.claim_id for x in original];cases=[ids,[],[ids[0]],ids[::-1],ids+[ids[0]],['unknown'],[e.CALCULATOR_CLAIM_ID]];expected=[];codes=[]
for case in cases:
 c.SPECS=[SimpleNamespace(claim_id=x)for x in case]
 try:expected.append({'ok':[{'claim_id':f.claim_id,'interaction':f.interaction,'operations':list(f.operations)}for f in c.expression_families()]})
 except RuntimeError as ex:expected.append({'error':str(ex)})
 codes.append('result ((CalculatorExpressionCensus.expressionFamiliesFor ['+','.join(q(x)for x in case)+']).map (fun xs => .array (xs.map CalculatorExpressionCensus.familyValue)))')
c.SPECS=original
code=head+'#eval IO.println (render (.array ['+','.join(codes)+']))\n#eval IO.println (render (result (CalculatorExpressionCensus.expressionCensusJSON.map Value.text)))\n'
actual=[json.loads(x)for x in run('calculator1024_census_check',code).splitlines()];assert actual[0]==expected;assert actual[1]=={'ok':c.expression_census_json()}
names=[];audit=''
for module in ['CalculatorCompleteJSON','CalculatorCompleteEvidence','CalculatorExpressionCensus']:
 s=(r/f'SFT/Mathematics/{module}.lean').read_text();audit+='import SFT.Mathematics.'+module+'\n'
 names += ['SFT.Mathematics.'+module+'.'+n for n in re.findall(r'^\s*(?:def|theorem) (\w+)',s,re.M)]
audit+=''.join('#print axioms '+n+'\n'for n in names)
out=run('calculator1024_evidence_audit',audit);assert out.count('does not depend on any axioms')==len(names),out
report=dict(status='PASS',complete_evidence_outputs=len(codes) if False else len(exprs)*len(rowcases),census_domains=len(cases),exact_pretty_JSON=True,axioms=[],declarations=names)
(w/'calculator1024_evidence_report.json').write_text(json.dumps(report,indent=2));print(report)

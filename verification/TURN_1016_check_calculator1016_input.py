from pathlib import Path
import sys,json,os,subprocess,ast,hashlib,unicodedata
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.mathematics.calculator.machine_v3 import Calculator
from sft.mathematics.calculator import values as v
extra=[(i,chr(i).lower()) for i in range(128,0x110000) if chr(i).lower().isascii()];assert extra==[(0x212a,'k')]
cases=[(expr,symbols) for expr in ['k','K','kpi','i','ss','ans'] for symbols in [[('K',3)],[('K',3),('k',4)],[('k',4),('K',3)],[('KPI',5),('ANS',2)],[('İ',7),('ẞ',8)]]]
def canon(x):
 if isinstance(x,v.CertifiedInterval):return {'interval':[v.exact_text(x.lower),v.exact_text(x.upper),list(x.certificate)]}
 if isinstance(x,v.ComplexFibre):return {'complex':[v.exact_text(x.real),v.exact_text(x.orthogonal)]}
 return {'scalar':v.exact_text(x)}
expected=[]
for expr,symbols in cases:
 try:
  x=Calculator(places=3,symbols={k:v.forward(n) for k,n in symbols}).calculate(expr);expected.append({'ok':dict(expression=x.expression,value=canon(x.value),trace=list(x.trace),tokens_read=x.tokens_read,operations_executed=x.operations_executed,render=x.render(3))})
 except v.CalculatorHalt as e:expected.append({'error':str(e)})
tree=ast.parse((w/'check_calculator1015_machine.py').read_text());header=ast.literal_eval(next(n.value for n in tree.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='header' for t in n.targets)));header=header.replace('import SFT.Mathematics.CalculatorMachineV3','import SFT.Mathematics.CalculatorInputV3').replace('(mode : String) : Except','(mode : String) (symbols : List (String × CalculatorValues.Value)) : Except');a=header.index(' let x ←');b=header.index('\n',a);header=header[:a]+' let x ← CalculatorInputV3.calculate s p limit mode symbols'+header[b:]
header+='#eval IO.println (render (.array ['+','.join('result (do evaluate '+json.dumps(expr)+' 3 10000 "rad" ['+','.join('('+json.dumps(k,ensure_ascii=False)+',.scalar (← CalculatorValues.forward (CalculatorSeries.natural '+str(n)+')))' for k,n in symbols)+'])' for expr,symbols in cases)+']))\n#print axioms SFT.Mathematics.CalculatorInputV3.calculate\n';p=w/'constants-recovery/CalculatorInput1016.lean';p.write_text(header);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';x=subprocess.run([lean,'-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'calculator1016_input_output.log').write_text(x.stdout+x.stderr);assert x.returncode==0,(x.returncode,x.stdout[-2000:]);assert 'does not depend on any axioms' in x.stdout;actual=json.loads(x.stdout.splitlines()[0]);assert actual==expected,[(c,a,e) for c,a,e in zip(cases,actual,expected) if a!=e][:3]
report=dict(status='PASS',cases=len(cases),unicode_codepoints_checked=0x110000-128,unicode_database=unicodedata.unidata_version,non_ascii_preimages_of_ascii=extra,axioms=[],module='SFT/Mathematics/CalculatorInputV3.lean',source_sha256=hashlib.sha256((r/'SFT/Mathematics/CalculatorInputV3.lean').read_bytes()).hexdigest(),scope='Originalclasssymbol-keynormalizationandlast-keyoverride at the originalASCIIlexer-nameboundary. ExistingfixedASCII session bindings unchanged.');(w/'calculator1016_input_report.json').write_text(json.dumps(report,indent=2));print('PASS',len(cases),'originalsymbolcalculations;completeUnicodeASCII-preimagecheck;zeroaxioms')

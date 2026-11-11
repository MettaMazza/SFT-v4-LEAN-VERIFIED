from pathlib import Path
import ast,json,subprocess,os
ns={};exec(Path('work/bond_spec570.py').read_text(),ns);tree=ast.parse(ns['raw']('sft/chemistry/generated_goldbook_extended_law.py'));scope={};exec(compile(ast.Module(body=[n for n in tree.body if getattr(n,'name',None)=='_definition_and_notes'],type_ignores=[]),'source','exec'),scope)
cases=[{}, {'definitions':None},{'definitions':[None]}, {'definitions':[]},{'definitions':[{}]}, {'definitions':[{'text':'main','notes':{'2':'second','10':'tenth','1':'first'}}]}, {'definitions':[{'text':None,'notes':['one',True,False,None,17,-3,[],{},['a',"b'",'c"',"both'\"",'\n\x00\u200b'],{'k':[1,2]}]}]}]
for note in ['',0,False,None,True,1,'invalid',[],{}]:cases.append({'definitions':[{'text':'x','notes':note}]})
cases += [{'definitions':[{'text':'first','notes':['a']},{'text':'second','notes':{'z':'last','a':'start'}}]}]
def cv(v):
 if v is None:return '.null'
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,str):return '.text '+json.dumps(v,ensure_ascii=False)
 if isinstance(v,int):return '.integer ('+str(v)+')'
 if isinstance(v,list):return '.array ['+','.join(map(cv,v))+']'
 return '.object ['+','.join('('+json.dumps(k)+','+cv(x)+')' for k,x in v.items())+']'
expected=[]
for term in cases:
 try:expected.append({'text':scope['_definition_and_notes'](term)})
 except ValueError as e:expected.append({'error':str(e)})
s='import SFT.Chemistry.ExtendedExtraction\nopen SFT.Chemistry.ExtendedExtraction SFT.Host.Canonical\ndef result (v : Value) : Value := match definitionAndNotes v with\n | .error e => .object [("error",.text e)]\n | .ok text => .object [("text",.text text)]\ndef main : IO Unit := do\n'+'\n'.join(' IO.println (render (result ('+cv(x)+')))' for x in cases)+'\n'
r=Path('work/constants-recovery').resolve();(r/'ExtendedOperations570.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run','ExtendedOperations570.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/extended570_operations.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=[json.loads(x) for x in p.stdout.splitlines()];assert actual==expected,(actual,expected);Path('work/extended570_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),results=actual,source=ns['pin'],compares='original _definition_and_notes including ordering, primitive stringification, nested representations and invalid/empty note guards'),indent=2));print('PASS',len(cases),'notes-aware source extraction cases')

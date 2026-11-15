from pathlib import Path
import sys,json,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import static_exterior_clock_terminal_validation_v1 as src
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
def replace(s):return s.replace('SymmetricSourceConservation','StaticExteriorClock').replace('symmetric_source_conservation','static_exterior_clock').replace('Symmetric','Static').replace('symmetric','static').replace('981','983').replace('SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010','STATIC-EXTERIOR-CLOCK-TERMINAL-011').replace('static980_program_output.json','static982_program_output.json').replace('original6input','original7input')
for old,new in [('prepare_symmetric981_empirical_native.py','prepare_static983_empirical_native.py'),('check_symmetric981_empirical.py','check_static983_empirical.py'),('check_symmetric981_original_empirical.py','check_static983_original_empirical.py'),('check_symmetric981_independent.py','check_static983_independent.py')]:
 (w/new).write_text(replace((w/old).read_text()))
s=replace((w/'constants-recovery/SymmetricEmpirical981.lean').read_text());a=s.index(' let payload : Value :=');b=s.index(' let v1text ←',a);s=s[:a]+' let payload : Value := '+val(json.load(open(w/'v3-runtime500'/src.SOURCE_RECORD_PATH)))+'\n'+s[b:]
a=s.index(' let v2text ←');b=s.index(' let result ←',a)
s=s[:a]+''' let v1 ← IO.ofExcept (do convert (v1text.utf8ByteSize+1) (← Lean.Json.parse v1text))
 let prerequisites ← StaticRecords.prerequisiteClaims.mapM fun (relative,_) => do
  let body ← IO.FS.readFile (System.FilePath.mk (root ++ "/" ++ relative))
  let value ← IO.ofExcept (do convert (body.utf8ByteSize+1) (← Lean.Json.parse body))
  pure (relative,value)
 let v2 := Value.object prerequisites
'''+s[b:];(w/'constants-recovery/StaticEmpirical983.lean').write_text(s)
mods=['StaticExteriorClock'+x for x in ['', 'Certificate','General','Grammar','Evidence']]+['StaticPrediction','StaticRecords','StaticExperiment','StaticMeasurement','StaticValidation'];audit=''.join('import SFT.Physics.'+m+'\n' for m in mods);decl=[]
for m in mods:
 p=r/('SFT/Physics/'+m+'.lean');text=p.read_text();(w/'constants-recovery/SFT/Physics'/p.name).write_text(text)
 for n in re.findall(r'^(?:def|theorem|abbrev) (\w+)',text,re.M):
  name='SFT.Physics.'+m+'.'+n;decl.append(name);audit+='#print axioms '+name+'\n'
(w/'static983_audit.lean').write_text(audit);(w/'static983_declarations.json').write_text(json.dumps(decl,indent=2)+'\n');print('Prepared actual10file native pipeline and',len(decl),'declaration audit')

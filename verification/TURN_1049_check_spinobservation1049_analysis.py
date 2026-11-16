from pathlib import Path
import ast,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');source=(w/'spinobservation1049_validation.py').read_text();tree=ast.parse(source);fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='exact_spin_statistics_analysis');ns={};exec(compile(ast.Module(body=[fn],type_ignores=[]),'original-spin-analysis','exec'),ns)
fields=json.loads((w/'spinobservation1049_fields.json').read_text());keys=[b for a,b in fields['ints']];flags=[b for a,b in fields['flags']];base=json.load(open('/Volumes/One Touch/ernos-labs-sft-platform/experiments/external_sources/physics/snapshots/spin-statistics-condensation-postseal-source-record.json'))['registered_target'];cases=[base]
for k in keys:
 for v in [-1,0,1,2,600,720]:cases.append({**base,k:v})
for k in flags:
 for v in [True,False,1,0,'true',None]:cases.append({**base,k:v})
lines=['import SFT.Physics.SpinCondensationMeasurement','open SFT.Physics.SpinCondensationMeasurement SFT.Host.Canonical']
def lean(v):
 if v is None:return '.null'
 if type(v)==bool:return '.boolean '+str(v).lower()
 if type(v)==int:return '.integer ('+str(v)+')'
 if type(v)==str:return '.text '+json.dumps(v)
 if type(v)==dict:return '.object ['+','.join('('+json.dumps(k)+','+lean(x)+')' for k,x in v.items())+']'
for t in cases:lines.append('#eval (exactSpinStatisticsAnalysis ('+lean(t)+')).map render')
p=w/'spinobservation1049_analysis_cases.lean';p.write_text('\n'.join(lines)+'\n');env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=env,capture_output=True,text=True);(w/'spinobservation1049_analysis_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:]
actual=[json.loads(json.loads(line[len('Except.ok '):])) for line in x.stdout.splitlines() if line.startswith('Except.ok ')];expected=[json.loads(json.dumps(ns['exact_spin_statistics_analysis'](t))) for t in cases];assert actual==expected,(len(actual),len(expected),x.stdout[:500])
mods=['SpinCondensationAnalysis','SpinCondensationMeasurement'];names=[];hashes={}
for m in mods:
 body=(r/f'SFT/Physics/{m}.lean').read_text();names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M)];hashes[m]=hashlib.sha256(body.encode()).hexdigest()
p=w/'spinobservation1049_analysis_audit.lean';p.write_text('import SFT.Physics.SpinCondensationMeasurement\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=env,capture_output=True,text=True);(w/'spinobservation1049_analysis_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and all("'"+n+"' does not depend on any axioms" in x.stdout for n in names)
(w/'spinobservation1049_analysis_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),fields=15,declarations=names,axioms=[],source_sha256=hashes,original_analysis_sha256=hashlib.sha256(source.encode()).hexdigest(),scope='Actual source integer conversion and singleton Boolean identity; all 15 output fields and numeric and non-Boolean adverse cases'),indent=2));print('PASS',len(cases),'complete15fieldsourceoutputs;',len(names),'zeroaxiomdeclarations')

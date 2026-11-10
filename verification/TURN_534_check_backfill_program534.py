from pathlib import Path
import json,subprocess,os,ast,re,concurrent.futures,copy
w=Path('work').resolve();r=w/'constants-recovery';canonical=Path('/Volumes/One Touch/SFT v4 Full model LEAN');repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'),LEAN_NUM_THREADS='1',LEAN_HOST_STACK_SIZE='8192')
ns={'Path':Path}
for node in ast.parse((w/'run_matter493.py').read_text()).body:
 if isinstance(node,(ast.Assign,ast.AugAssign)) and getattr(node.targets[0] if isinstance(node,ast.Assign) else node.target,'id',None) in ['common','toolchain','flags','libs']:exec(compile(ast.Module(body=[node],type_ignores=[]),'existing-link','exec'),ns)
objs=[r/'.lake/build/ir'/(n+'.c.o.export') for n in ns['common'] if (r/'.lake/build/ir'/(n+'.c.o.export')).exists()]+[r/'.lake/build/ir/SFT/Physics'/(n+'.c.o.export') for n in ['UnitGrammar','UnitEvidence','UnitExperiment','UnitValidation']]
def check(item):
 stem=item['stem'];m=item['module'];logs=[]
 def run(cmd):
  p=subprocess.run(cmd,cwd=r,env=env,capture_output=True,text=True);logs.append({'command':cmd,'exit':p.returncode,'output':p.stdout+p.stderr});(w/(stem+'Program534_commands.json')).write_text(json.dumps(logs,indent=2));assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 names=[]
 for tail in ['Grammar','Evidence']:
  module=stem+tail;source=(r/'SFT/Physics'/(module+'.lean')).read_text();namespace=re.search(r'^namespace (\S+)',source,re.M)[1];names += [namespace+'.'+n for n in re.findall(r'^(?:def|theorem|abbrev|inductive|structure) (\w+)',source,re.M)];assert not re.search(r'\bsorry\b|^\s*axiom\b',source,re.M)
 p=w/(stem+'GrammarAudit534.lean');p.write_text('import SFT.Physics.'+stem+'Evidence\n'+'\n'.join('#print axioms '+n for n in names)+'\n');out=run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)]);assert all("'"+n+"' does not depend on any axioms" in out for n in names);(w/(stem+'GrammarAudit534.log')).write_text(out)
 p=r/(stem+'Program534.lean');p.write_text((r/'UnitProgram480.lean').read_text().replace('UnitEvidence',stem+'Evidence').replace('UnitGrammar',stem+'Grammar'));c=w/(stem+'Program534.c');run(['/Users/dolltrading/.elan/bin/lean','-j1','-c',str(c),str(p)])
 extra=[]
 for tail in ['Grammar','Evidence']:
  obj=w/(stem+tail+'534.o');run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(r/'.lake/build/ir/SFT/Physics'/(stem+tail+'.c')),'-o',str(obj)]);extra.append(obj)
 exe=w/(stem+'Program534');run([str(ns['toolchain']/'bin/clang'),*ns['flags'],str(c),*[str(x) for x in extra+objs],str(w/(m+'534.o')),str(w/'field493_initializer_bridge.o'),str(w/'LeastCommonReturn490.o'),*[str(w/'native491'/(n+'.o')) for n in ['LeptonDecimal','EvolutionMeasuredSource']],str(w/'native483/CanonicalPackaged.o'),str(canonical/'.lake/build/lib/libsft__v4_SFT.a'),*ns['libs'],'-Wl,-stack_size,0x10000000','-o',str(exe)])
 s=(w/'unit_program480.py').read_text().replace('UnitProgram480',stem+'Program534').replace('unit_program480',stem.lower()+'_program534').replace('SFT-PHYS-MEAS-UNIT-COMPARISON-001',item['claim_id']);p=w/(stem.lower()+'_program534.py');p.write_text(s);pout=subprocess.run(['python3',str(p)],cwd=w.parent,env=env,text=True,capture_output=True);assert pout.returncode==0,pout.stdout+pout.stderr
 actual=json.loads((w/(stem.lower()+'_program534_output.json')).read_text());ind=w/(stem+'Independent534.py');ind.write_bytes(subprocess.check_output(['git','-C',repo,'show',pin+':claims/'+item['claim_id']+'/independent_validator.py']));cases=[]
 for case in ['original','omitted_candidate','additional_survivor','failed_control']:
  val=copy.deepcopy(actual);val.update(claim_id=item['claim_id'],seal_hash='native-'+stem+'-534')
  if case=='omitted_candidate':val['census']['candidates']=val['census']['candidates'][1:]
  if case=='additional_survivor':val['decisions'][0]['survives']=True
  if case=='failed_control':val['controls'][0]['passed']=False
  p=w/(stem+'_'+case+'534.json');p.write_text(json.dumps(val));res=json.loads(subprocess.check_output(['python3',str(ind),str(p)],text=True));assert res['passed']==(case=='original');cases.append(dict(case=case,result=res))
 result=dict(stem=stem,status='PASS',audited_declarations=names,axiom_dependencies=[],independent_cases=cases);(w/(stem+'Program534_report.json')).write_text(json.dumps(result,indent=2));print(stem,'full program and controls PASS',flush=True);return result
with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:results=list(pool.map(check,json.loads((w/'backfill534_metadata.json').read_text())))
(w/'backfill534_program_report.json').write_text(json.dumps(results,indent=2))

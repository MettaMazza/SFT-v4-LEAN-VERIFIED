from pathlib import Path
import subprocess,json,os,re,concurrent.futures,hashlib,ast
w=Path('work').resolve();r=w/'constants-recovery';canonical=Path('/Volumes/One Touch/SFT v4 Full model LEAN');repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'),LEAN_NUM_THREADS='1',LEAN_HOST_STACK_SIZE='8192');items=json.loads((w/'density536_numeric_metadata.json').read_text())
snapshot=w/'backfill536_source.bin';data=subprocess.check_output(['git','-C',repo,'show',pin+':experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt']);assert hashlib.sha256(data).hexdigest()=='77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67';snapshot.write_bytes(data)
linkns={'Path':Path}
for node in ast.parse((w/'run_matter493.py').read_text()).body:
 if isinstance(node,(ast.Assign,ast.AugAssign)) and getattr(node.targets[0] if isinstance(node,ast.Assign) else node.target,'id',None) in ['common','toolchain','flags','libs']:
  exec(compile(ast.Module(body=[node],type_ignores=[]),'existing-link-recipe','exec'),linkns)
objs=[r/'.lake/build/ir'/(n+'.c.o.export') for n in linkns['common'] if (r/'.lake/build/ir'/(n+'.c.o.export')).exists()]
objs += [r/'.lake/build/ir/SFT/Physics'/(n+'.c.o.export') for n in ['UnitGrammar','UnitEvidence','UnitExperiment','UnitValidation']]
def check(item):
 m=item['module'];log=[]
 def run(cmd):
  p=subprocess.run(cmd,cwd=r,env=env,capture_output=True,text=True);log.append({'command':cmd,'exit':p.returncode,'output':p.stdout+p.stderr});(w/(m+'536_commands.json')).write_text(json.dumps(log,indent=2));assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 source=(r/'SFT/Physics'/(m+'.lean')).read_text();ns=re.search(r'^namespace (\S+)',source,re.M)[1];names=[ns+'.'+n for n in re.findall(r'^(?:def|theorem|abbrev) (\w+)',source,re.M)];assert not re.search(r'\bsorry\b|^\s*axiom\b',source,re.M)
 audit=w/(m+'Audit536.lean');audit.write_text('import SFT.Physics.'+m+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n');out=run(['/Users/dolltrading/.elan/bin/lean','-j1',str(audit)]);assert all("'"+n+"' does not depend on any axioms" in out for n in names);(w/(m+'Audit536.log')).write_text(out)
 wrapper=r/(m+'Validation536.lean');wrapper.write_text((r/'EvolutionValidationProgram491.lean').read_text().replace('EvolutionMeasured',m));c=w/(m+'Validation536.c');obj=w/(m+'536.o');exe=w/(m+'Validation536')


 run(['/Users/dolltrading/.elan/bin/lean','-j1','-c',str(c),str(wrapper)])
 run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(r/'.lake/build/ir/SFT/Physics'/(m+'.c')),'-o',str(obj)])
 run([str(linkns['toolchain']/'bin/clang'),*linkns['flags'],str(c),str(obj),*[str(x) for x in objs],str(w/'field493_initializer_bridge.o'),str(w/'LeastCommonReturn490.o'),*[str(w/'native491'/(n+'.o')) for n in ['LeptonDecimal','EvolutionMeasuredSource']],str(w/'native483/CanonicalPackaged.o'),str(canonical/'.lake/build/lib/libsft__v4_SFT.a'),*linkns['libs'],'-Wl,-stack_size,0x10000000','-o',str(exe)])
 expected=json.loads(subprocess.check_output(['git','-C',repo,'show',pin+':claims/'+item['claim_id']+'/empirical_validation.json']));expected.pop('claim_id');out=run([str(exe),str(snapshot),expected['validated_seal_hash'],expected['isolation_certificate']['host_platform'],expected['isolation_certificate']['python_implementation']]);actual=json.loads(out);(w/(m+'536_output.json')).write_text(json.dumps(actual,indent=2));assert actual==expected,[(k,actual.get(k),v) for k,v in expected.items() if actual.get(k)!=v]
 result=dict(module=m,status='PASS',source_sha256=hashlib.sha256(source.encode()).hexdigest(),audited_declarations=names,axiom_dependencies=[],full_empirical_output_matches=True);(w/(m+'536_report.json')).write_text(json.dumps(result,indent=2));print(m,'PASS',flush=True);return result
with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:
 results=list(pool.map(check,items))
(w/'backfill536_numeric_report.json').write_text(json.dumps(results,indent=2))

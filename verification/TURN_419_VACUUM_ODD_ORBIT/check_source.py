from pathlib import Path
import ast,subprocess,json,hashlib,os
from fractions import Fraction
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform';ns={'Fraction':Fraction};hashes={}
selected={
'sft/physics/structural_constants.py':['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three'],
'sft/physics/atomic_constants.py':['binary_count'],
'sft/physics/vacuum_lineage_laws_v1.py':['odd_denominator_orbit']}
for path,names in selected.items():
 raw=subprocess.check_output(['git','-C',repo,'show',pin+':'+path]);hashes[path]=hashlib.sha256(raw).hexdigest();nodes=[n for n in ast.parse(raw).body if isinstance(n,ast.FunctionDef) and n.name in names];assert len(nodes)==len(names)
 module=ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0)]+nodes,type_ignores=[]);exec(compile(ast.fix_missing_locations(module),path,'exec'),ns)
def result(x):
 try:return 'ok:'+','.join(str(v.numerator)+'/'+str(v.denominator) for v in ns['odd_denominator_orbit'](x))
 except ValueError as e:return 'error:ValueError: '+str(e)
inputs=list(range(-2,32))+[False,True]
expected=[result(x) for x in inputs]
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
fresh=subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','2048','--run',str(r/'VacuumOddSource419.lean')],env=env,text=True);actual=fresh.splitlines();Path('work/vacuum_odd_source419_output.txt').write_text(fresh)
assert actual==expected,next(((i,a,b) for i,(a,b) in enumerate(zip(actual,expected)) if a!=b),('lengths',len(actual),len(expected)))
report=dict(status='PASS',source_commit=pin,source_sha256=hashes,fresh_native_execution=True,cases=len(inputs),scope='Original odd_denominator_orbit and original dependency functions against fresh Lean: both Booleans, integers -2 through31, all exact ordered trace fractions and original errors.')
Path('work/vacuum_odd_source419_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))

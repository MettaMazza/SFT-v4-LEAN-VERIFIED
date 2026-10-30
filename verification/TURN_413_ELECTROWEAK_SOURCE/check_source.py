from pathlib import Path
import ast,subprocess,json,hashlib,os
from fractions import Fraction
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform';ns={'Fraction':Fraction};hashes={}
selected={
'sft/physics/structural_constants.py':['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three'],
'sft/physics/atomic_constants.py':['binary_count','positive_power','minimal_binary_cover','fine_structure_blocks','promotion_rungs','effective_cover','inverse_fine_structure'],
'sft/physics/precision_value_laws_v1.py':['terminal_alpha','positive_take','terminal_promotion_count','terminal_binary_support','electroweak_running_level','electroweak_running_share','terminal_return_divisor','terminal_electroweak_sin_squared','terminal_electroweak_cos_squared']}
for path,names in selected.items():
 raw=subprocess.check_output(['git','-C',repo,'show',pin+':'+path]);hashes[path]=hashlib.sha256(raw).hexdigest();nodes=[n for n in ast.parse(raw).body if isinstance(n,ast.FunctionDef) and n.name in names];assert len(nodes)==len(names)
 module=ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0)]+nodes,type_ignores=[]);exec(compile(ast.fix_missing_locations(module),path,'exec'),ns)
def result(fn,*args):
 try:
  x=fn(*args)
  return 'ok:'+ (str(x.numerator)+'/'+str(x.denominator) if isinstance(x,Fraction) else str(x))
 except ValueError as e:return 'error:ValueError: '+str(e)
inputs=list(range(-2,21))+[False,True]
expected=[result(ns['positive_take'],c,t) for c in inputs for t in inputs]+[result(ns['electroweak_running_share'],l) for l in inputs]
expected += [result(ns[k]) for k in ['terminal_promotion_count','terminal_binary_support','electroweak_running_level','terminal_return_divisor']]
expected += [result(ns['terminal_alpha']),result(lambda:ns['terminal_alpha']()/ns['terminal_return_divisor']()),result(ns['terminal_electroweak_sin_squared']),result(ns['terminal_electroweak_cos_squared']),result(lambda:ns['terminal_electroweak_sin_squared']()+ns['terminal_electroweak_cos_squared']())]
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
fresh=subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','2048','--run',str(r/'ElectroweakSource413.lean')],env=env,text=True);actual=fresh.splitlines();Path('work/electroweak_source413_output.txt').write_text(fresh)
assert actual==expected,next(((i,a,b) for i,(a,b) in enumerate(zip(actual,expected)) if a!=b),('lengths',len(actual),len(expected)))
report=dict(status='PASS',source_commit=pin,source_sha256=hashes,fresh_native_execution=True,positive_take_cases=625,running_share_cases=25,derived_outputs=9,scope='Unchanged pinned Python functions and dependency functions compared against fresh Lean,including original domain/predecessor errors and all exact derived output fractions. Source used only as verification oracle.')
Path('work/electroweak_source413_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))

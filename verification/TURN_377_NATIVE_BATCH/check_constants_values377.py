from pathlib import Path
from fractions import Fraction
from itertools import product
import ast,json,subprocess,hashlib
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def raw(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
def load(path,names,ns):
 tree=ast.parse(raw(path));nodes=[n for n in tree.body if getattr(n,'name',None) in names or (isinstance(n,ast.Assign) and getattr(n.targets[0],'id',None) in names)];exec(compile(ast.fix_missing_locations(ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0)]+nodes,type_ignores=[])),path,'exec'),ns)
def norm(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return [norm(v) for v in x]
 if isinstance(x,dict):return {k:norm(v) for k,v in x.items()}
 return x
actual=[json.loads(s) for s in Path('work/constants_values377.jsonl').read_text().splitlines()]
intervals={}
for name,file,fn,snapshot in [('hubble','hubble_calibration_validation','hubble_ratio_interval','planck-shoes-hubble-abstract-record.json'),('density','cosmology_prior_value_validation','density_ratio_interval','planck-2018-density-abstract-record.json')]:
 ns={'Fraction':Fraction,'Path':Path,'json':json};load('sft/physics/measured_value.py',{'exact_decimal'},ns);load('sft/physics/'+file+'.py',{'SOURCE_ID',fn},ns);intervals[name]=norm(ns[fn](Path('work/pinned-constants')/snapshot))
assert actual[0]==intervals,(actual[0],intervals)
ns={'Fraction':Fraction,'product':product};load('sft/physics/vacuum_density_scale_terminal_law_v1.py',{'BINARY','GENERATOR','SPACE_RANK','TERMINAL_VACUUM_SHARE','least_binary_cover_depth','generation_volume','boundary_record_depth','local_vacuum_amplitude_floor','local_vacuum_energy_floor','finite_zero_point_ledger','local_floor_candidates','normalized_cosmological_constant','cosmological_constant_scale_transport'},ns)
for k in range(1,9):assert actual[k]==norm(ns['finite_zero_point_ledger'](k)),k
assert actual[9]==norm(ns['local_floor_candidates']())
scales=[]
for a,b,t in product((Fraction(1,3),Fraction(2,3),Fraction(1)),(Fraction(1,2),Fraction(3,4),Fraction(1)),(Fraction(1,4),Fraction(2),Fraction(3))):
 f=ns['cosmological_constant_scale_transport'];scales.append(norm((f(a,b),f(a*t,b*t))))
assert actual[10]==scales
report=dict(status='PASS',source_commit=pin,fresh_native_execution=True,source_functions_executed_unchanged=True,intervals=intervals,complete_finite_ledgers=8,mode_rows=510,local_floor_candidates=4,scale_transport_pairs=27)
Path('work/constants_values377_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))

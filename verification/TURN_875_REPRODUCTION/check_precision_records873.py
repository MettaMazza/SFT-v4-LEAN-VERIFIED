from pathlib import Path
from fractions import Fraction
import ast,subprocess,json,hashlib,os,__future__,sys
v3=Path('/Volumes/One Touch/ernos-labs-sft-platform');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';w=Path('work');r=(w/'constants-recovery').resolve();ns={'Fraction':Fraction};digests={}
for name in ['structural_constants.py','atomic_constants.py','lineage_particle_laws.py','precision_value_laws_v1.py','measured_value.py','precision_value_validation_v1.py']:
 rel='sft/physics/'+name;raw=subprocess.check_output(['git','-C',str(v3),'show',pin+':'+rel]);assert raw==(v3/rel).read_bytes();digests[rel]=hashlib.sha256(raw).hexdigest();tree=ast.parse(raw);nodes=[]
 for node in tree.body:
  if isinstance(node,ast.FunctionDef):nodes.append(node)
  if isinstance(node,ast.Assign):
   try:ast.literal_eval(node.value);nodes.append(node)
   except (ValueError,TypeError):pass
 exec(compile(ast.Module(body=nodes,type_ignores=[]),rel,'exec',flags=__future__.annotations.compiler_flag),ns)

ns.update(Path=Path,json=json,hashlib=hashlib)
rel='sft/engine/source.py';raw=subprocess.check_output(['git','-C',str(v3),'show',pin+':'+rel]);assert raw==(v3/rel).read_bytes();digests[rel]=hashlib.sha256(raw).hexdigest();node=next(n for n in ast.parse(raw).body if isinstance(n,ast.FunctionDef) and n.name=='hash_file');exec(compile(ast.Module(body=[node],type_ignores=[]),rel,'exec',flags=__future__.annotations.compiler_flag),ns)
expected=dict(electroweak=ns['electroweak_comparison'](v3),hierarchy_interval=list(map(str,ns['codata_hierarchy_interval'](v3))));expected=json.loads(json.dumps(expected))
actual=json.loads(subprocess.check_output(([sys.argv[1],str(v3)] if len(sys.argv)>1 else ['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'PrecisionRecords873.lean'),str(v3)]),text=True,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))));assert actual==expected,(actual,expected)
report=dict(status='PASS',source_commit=pin,source_sha256=digests,actual=actual,scope='Fresh full original PDG source-document hashes and complete row parsing/classification, CODATA exact unique fixed-width mass rows and outward interval; original protocol/custody integration remains separate')
(w/'precision873_records_report.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))

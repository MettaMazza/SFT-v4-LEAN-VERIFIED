from pathlib import Path
from fractions import Fraction
import ast,subprocess,json,hashlib,os,__future__
v3=Path('/Volumes/One Touch/ernos-labs-sft-platform');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';w=Path('work');r=(w/'constants-recovery').resolve();ns={'Fraction':Fraction};digests={}
for name in ['structural_constants.py','atomic_constants.py','lineage_particle_laws.py','precision_value_laws_v1.py','measured_value.py','precision_value_validation_v1.py']:
 rel='sft/physics/'+name;raw=subprocess.check_output(['git','-C',str(v3),'show',pin+':'+rel]);assert raw==(v3/rel).read_bytes();digests[rel]=hashlib.sha256(raw).hexdigest();tree=ast.parse(raw);nodes=[]
 for node in tree.body:
  if isinstance(node,ast.FunctionDef):nodes.append(node)
  if isinstance(node,ast.Assign):
   try:ast.literal_eval(node.value);nodes.append(node)
   except (ValueError,TypeError):pass
 exec(compile(ast.Module(body=nodes,type_ignores=[]),rel,'exec',flags=__future__.annotations.compiler_flag),ns)
I=ns['interval'];Q=ns['squared_ratio_interval'];weak=ns['terminal_electroweak_sin_squared']();cosine=ns['terminal_electroweak_cos_squared']();on=I('0.22342','0.00009');z=I('91.1880','0.0020');allw=Q(I('80.395','0.012'),z);compatible=Q(I('80.3692','0.0133'),z);hi=Q(I('2.176 434 e-8','0.000 024 e-8'),I('1.672 621 925 95 e-27','0.000 000 000 52 e-27'));hp=ns['terminal_proton_planck_squared_ratio']();pair=lambda q:[q.numerator,q.denominator];iv=lambda p:list(map(pair,p))
expected=dict(weak=pair(weak),cosine=pair(cosine),on_shell_interval=iv(on),compatible_interval=iv(compatible),all_input_interval=iv(allw),outcomes=[on[0]<=weak<=on[1],compatible[0]<=cosine<=compatible[1],allw[0]<=cosine<=allw[1]],hierarchy_interval=iv(hi),hierarchy_prediction=pair(hp),hierarchy_pass=hi[0]<=hp<=hi[1])
actual=json.loads(subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'PrecisionScience873.lean')],text=True,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))));assert actual==expected,(actual,expected)
report=dict(status='PASS',source_commit=pin,source_sha256=digests,actual=actual,scope='Fresh exact original function bodies including original generated terminal dependencies, all interval endpoints and complete outcome vectors; full entry custody/program still pending')
(w/'precision873_science_report.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))

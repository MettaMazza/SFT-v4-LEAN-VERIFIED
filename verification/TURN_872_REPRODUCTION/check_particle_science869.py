from pathlib import Path
import subprocess,json,os,hashlib,ast
from fractions import Fraction
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';v3=Path('/Volumes/One Touch/ernos-labs-sft-platform');r=Path('work/constants-recovery').resolve()
paths=['sft/physics/lineage_particle_laws.py','sft/physics/atomic_constants.py','sft/physics/structural_constants.py'];digests={}
for rel in paths:
 expected=subprocess.check_output(['git','-C',str(v3),'show',pin+':'+rel]);assert expected==(v3/rel).read_bytes();digests[rel]=hashlib.sha256(expected).hexdigest()
ns={'Fraction':Fraction}
selected={
 'sft/physics/structural_constants.py':['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three'],
 'sft/physics/atomic_constants.py':['binary_count','positive_power'],
 'sft/physics/lineage_particle_laws.py':['half_one','fold_preimages','half_one_preimages','electroweak_mixing','wz_squared_ratio','cp_phase_position','dirac_g_factor','parity_fibre']}
for rel,names in selected.items():
 text=subprocess.check_output(['git','-C',str(v3),'show',pin+':'+rel],text=True);tree=ast.parse(text);nodes=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in names];assert len(nodes)==len(names);exec(compile(ast.Module(body=nodes,type_ignores=[]),rel,'exec',flags=__import__('__future__').annotations.compiler_flag),ns)
def pair(q):return [q.numerator,q.denominator]
original=dict(wz=pair(ns['wz_squared_ratio']()),cp=pair(ns['cp_phase_position']()),dirac=ns['dirac_g_factor'](),parity={k:pair(v) for k,v in ns['parity_fibre']().items()})

actual=json.loads(subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'ParticleScience869.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True));assert actual==original,(actual,original)
report=dict(status='PASS',source_commit=pin,source_sha256=digests,actual=actual,source_functions=['wz_squared_ratio','cp_phase_position','dirac_g_factor','parity_fibre','half_one_preimages','electroweak_mixing'],scope='All original W/Z,CP,Dirac and parity output fields from fresh pinned original dependency functions and native Lean execution')
Path('work/particle869_science_report.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))

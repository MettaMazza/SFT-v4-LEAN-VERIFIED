from pathlib import Path
import subprocess,os,sys,json,hashlib
from fractions import Fraction as F
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';rel='sft/physics/common_scale_axis_terminal_law_v1.py';raw=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);runtime=Path('work/v3-runtime500');assert (runtime/rel).read_bytes()==raw;sys.path.insert(0,str(runtime.resolve()));from sft.physics import common_scale_axis_terminal_law_v1 as v3
from sft.engine.canonical import canonical_value
inputs=[-1,0,False,True,1,2,3,4,8,12,16]
def outcome(f,*args):
 try:return {'ok':canonical_value(f(*args))}
 except ValueError as e:return {'error':str(e)}
expected={'certificate':outcome(v3.common_axis_certificate)}
for name in ['scale_spacing','traversal_count','is_binary_support','electroweak_source','internal_square_anchor_levels','leading_electroweak_share_at_support','leading_electroweak_share','leading_curve_strictly_descends']:expected[name]=[outcome(getattr(v3,name),x) for x in inputs]
expected['common_rational_rescaling_ratio']=[outcome(v3.common_rational_rescaling_ratio,*args) for args in [(F(7,5),F(11,3),F(13,17)),(F(0),F(1),F(1)),(F(-1,2),F(1),F(1)),(F(1),F(0),F(1)),(F(1),F(1),1),(F(1),F(1),F(0))]]
env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));r=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M4096','--run','work/constants-recovery/CommonAxisSource515.lean'],env=env,text=True,capture_output=True);Path('work/common_source515.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr;actual=json.loads(r.stdout);Path('work/common_source515_output.json').write_text(json.dumps(actual,indent=2)+'\n');assert actual==expected,[k for k in actual if actual[k]!=expected.get(k)]
report=dict(status='PASS',source_commit=pin,source_path=rel,source_sha256=hashlib.sha256(raw).hexdigest(),certificate_fields=9,terminal_chain_fields=8,typed_landmarks=8,operation_cases=94,scope='Fresh current Lean outputs compared directly with all original certificate fields, full registered ranges, typed landmarks, unit witness and94 admitted/rejected source operation cases.')
Path('work/common_source515_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS complete certificate and94 operation cases')

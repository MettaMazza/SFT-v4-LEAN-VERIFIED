from pathlib import Path
import json,os,subprocess,sys,hashlib
sys.dont_write_bytecode=True;runtime=Path('work/v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.physics import unified_constants_object_law_v1 as v3
from sft.engine.canonical import canonical_value
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';source='sft/physics/unified_constants_object_law_v1.py';raw=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+source]);assert raw==(runtime/source).read_bytes()
inputs=[-2,-1,0,False,True,1,2,3,4,5,8]
def outcome(f,*a):
 try:return {'ok':canonical_value(f(*a))}
 except ValueError as e:return {'error':str(e)}
expected=dict(predecessor=[outcome(v3.positive_predecessor,x) for x in inputs],power=[outcome(v3.positive_power,x,y) for x in inputs for y in inputs],cover=[outcome(v3.minimal_binary_cover,x,y) for x in inputs for y in inputs],foundation=[outcome(v3.foundation_order_vector,x) for x in inputs])
r=Path('work/constants-recovery').resolve();p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run','UnifiedFoundationSource515.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True,capture_output=True);Path('work/unified_foundation515_source.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr
actual=json.loads(p.stdout);Path('work/unified_foundation515_source_output.json').write_text(json.dumps(actual,indent=2)+'\n');assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
report=dict(status='PASS',source_commit=pin,source_path=source,source_sha256=hashlib.sha256(raw).hexdigest(),operation_cases=sum(map(len,expected.values())),foundation_fields=16,generators=[3,4,5,8],checks='Fresh Lean and original V3 outputs including all error messages, Boolean guards, binary cover argument, generators3 and4 plus accepted generators5 and8.')
Path('work/unified_foundation515_source_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)

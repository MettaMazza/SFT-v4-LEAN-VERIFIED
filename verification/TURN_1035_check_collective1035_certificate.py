from pathlib import Path
import json,subprocess,os,sys
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.collective_radiation_response_terminal_law_v1 import theorem_certificate
s='''import SFT.Physics.CollectiveRadiationCertificate
import SFT.Host.Canonical
open SFT.Physics.CollectiveRadiationCertificate SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def output : Value := match certificate with
 | .error e => .text e
 | .ok c => .object [("occupation_count",.integer (.ofNat c.occupationCount)),("energy_exact",.boolean c.energyExact),("uv_closed",.boolean c.uvClosed),("scale_covariant",.boolean c.scaleCovariant),("fourth_power",.boolean c.fourthPower),("acoustic",.boolean c.acoustic),("laser",.boolean c.laser),("plasma",.boolean c.plasma),("alfven",.boolean c.alfven)]
#eval IO.println (render output)
'''
p=w/'collective1035_certificate.lean';p.write_text(s);x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'collective1035_certificate.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout;assert json.loads(x.stdout)==theorem_certificate();(w/'collective1035_certificate_report.json').write_text(json.dumps(dict(status='PASS',fields=9,entire_original_certificate=True,output=json.loads(x.stdout)),indent=2));print('PASS all nine original certificate fields')

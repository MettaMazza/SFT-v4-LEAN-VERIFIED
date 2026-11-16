from pathlib import Path
from unittest.mock import Mock,patch
import sys,json,subprocess,os,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_browser import app as a
cases=[('192.168.1.6',False,'192.168.1.7',False,False),('',True,'192.168.1.7',False,False),('',True,'127.0.0.1',False,False),('',True,'',True,False),('192.168.1.6',False,'',False,True),('',True,'',True,True)]
expected=[];code='''import SFT.Mathematics.CalculatorBrowserLaunch
open SFT.Mathematics.CalculatorBrowserLaunch SFT.Host
'''
for address,probeFailed,dns,dnsFailed,closeFailed in cases:
 sock=Mock();sock.getsockname.return_value=(address,0)
 if probeFailed:sock.connect.side_effect=OSError('offline')
 if closeFailed:sock.close.side_effect=OSError('close failed')
 with patch.object(a.socket,'socket',return_value=sock),patch.object(a.socket,'gethostname',return_value='machine'),patch.object(a.socket,'gethostbyname',side_effect=OSError('dns failed')if dnsFailed else None,return_value=dns):
  try:out={'address':a._local_network_address()}
  except (OSError,a.CalculatorHalt)as e:out={'error':str(e)}
  sock.close.assert_called_once()
 expected.append(out)
 probe='.error "offline"'if probeFailed else '.ok '+json.dumps(address);dnsresult='.error "dns failed"'if dnsFailed else '.ok '+json.dumps(dns);close='.error "close failed"'if closeFailed else '.ok ()'
 code+='#eval IO.println (Canonical.render (match (resolveAddress ('+probe+') ('+dnsresult+') ('+close+')).2 with | .ok a => .object [("address",.text a)] | .error e => .object [("error",.text e)]))\n'
p=w/'calculator1027_address_check.lean';p.write_text(code);x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'calculator1027_address_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout;assert [json.loads(s)for s in x.stdout.splitlines()]==expected;(w/'calculator1027_address_report.json').write_text(json.dumps(dict(status='PASS',cases=6,source='app.py:_local_network_address',native='CalculatorBrowserLaunch.resolveAddress',scope='Probe success/OSError, DNS fallback/failure, loopback rejection, finally-close and overriding close failure; host socket creation exceptions remain host exceptions.'),indent=2));print('PASS six address/finally cases')

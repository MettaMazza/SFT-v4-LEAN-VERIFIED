from pathlib import Path
from fractions import Fraction
from math import comb,factorial
import ast,json,subprocess,os,re,concurrent.futures,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');env={'Fraction':Fraction,'comb':comb,'factorial':factorial};src=(w/'equilibrium1035_law.py').read_text();exec(compile(ast.Module(body=[n for n in ast.parse(src).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'original-equilibrium-functions','exec'),env)
s='''import SFT.Physics.ThermalEquilibriumResponseCertificate
import SFT.Host.Canonical
open SFT.Physics.ThermalEquilibriumResponseCertificate SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def output : Value := match certificate with
 | .error e => .text e
 | .ok c => .object [("temperature",.boolean c.temperature),("equilibrium",.boolean c.equilibrium),("canonical",.boolean c.canonical),("weights",.boolean c.weights),("fluctuation",.boolean c.fluctuation),("noise",.boolean c.noise)]
#eval IO.println (render output)
''';p=w/'equilibrium1035_certificate.lean';p.write_text(s);envlean={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=envlean,capture_output=True,text=True);(w/'equilibrium1035_certificate.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1500:];assert json.loads(x.stdout)==env['theorem_certificate']();print('PASS all six original certificate fields',flush=True)
(w/'equilibrium1035_certificate_report.json').write_text(json.dumps(dict(status='PASS',fields=6,all_original_ranges=True,output=json.loads(x.stdout)),indent=2))
def run(level):
 m=f'ThermalEquilibriumMaximum{level}';p=r/f'SFT/Physics/{m}.lean';p.write_text('import SFT.Physics.ThermalEquilibriumResponse\nnamespace SFT.Physics.'+m+'\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\ntheorem originalMaximum : (ThermalEquilibriumResponse.canonicalMaximumCertificate (.integer (.ofNat '+str(level)+'))).toOption.map ThermalEquilibriumResponse.MaximumCertificate.unique=some true := by decide +kernel\nend SFT.Physics.'+m+'\n');x=subprocess.run(['/Users/dolltrading/.elan/bin/lake','build','SFT.Physics.'+m],cwd=r,capture_output=True,text=True);(w/f'equilibrium1035_maximum{level}_build.log').write_text(x.stdout+x.stderr);print('level',level,'build',x.returncode,flush=True);return {'level':level,'exit':x.returncode,'module':m,'source_sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
with concurrent.futures.ThreadPoolExecutor(max_workers=4)as pool:results=list(pool.map(run,[2,3,4,5]))
(w/'equilibrium1035_maximum_build_report.json').write_text(json.dumps(results,indent=2));assert all(x['exit']==0 for x in results)
p=w/'equilibrium1035_maximum_audit.lean';p.write_text(''.join('import SFT.Physics.'+x['module']+'\n'for x in results)+''.join('#print axioms SFT.Physics.'+x['module']+'.originalMaximum\n'for x in results));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=envlean,capture_output=True,text=True);(w/'equilibrium1035_maximum_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==4,x.stdout
(w/'equilibrium1035_maximum_report.json').write_text(json.dumps(dict(status='PASS',levels=[2,3,4,5],axioms=[],full_original_enumeration=True,modules=results),indent=2));print('PASS four complete maximum proofs with empty axioms',flush=True)

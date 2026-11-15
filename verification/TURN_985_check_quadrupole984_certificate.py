from pathlib import Path
import sys,json,subprocess,os,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import quadrupole_radiated_power_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
inputs=[False,True,-2,0,1,2,3,5,12,20,32];expected=[]
for n in inputs:
 try:expected.append(canonical_value(src.radiated_power_certificate(n)))
 except ValueError as e:expected.append({'error':str(e)})
base=(w/'constants-recovery/QuadrupoleCore984.lean').read_text();helpers=base[base.index('def nv'):base.index('set_option')]
s='''import SFT.Physics.QuadrupoleRadiatedPowerCertificate
import SFT.Host.Canonical
open SFT.Physics.QuadrupoleRadiatedPower SFT.Physics.QuadrupoleRadiatedPowerCertificate SFT.Host.Canonical
'''+helpers+'''def shellValue (r : ShellRow) : Value := .object [("radius",frac r.radius),("density",frac r.density),("reconstructed_power",frac r.reconstructedPower)]
def certificateValue (c : Certificate) : Value := .object [("coupling",frac c.coupling),("monopole_record",.text c.monopoleRecord),("dipole_record",.text c.dipoleRecord),("first_radiative_moment",.text c.firstRadiativeMoment),("base_third_record",.array (c.baseThirdRecord.map frac)),("doubled_third_record",.array (c.doubledThirdRecord.map frac)),("base_power",frac c.basePower),("doubled_power",frac c.doubledPower),("static_power_record",powerResult (.ok c.staticPowerRecord)),("third_rate_doubles",.boolean c.thirdRateDoubles),("power_quadruples",.boolean c.powerQuadruples),("shell_rows",.array (c.shellRows.map shellValue)),("shell_power_conserved",.boolean c.shellPowerConserved),("cubic_identities",.array (c.cubicIdentities.map identityValue)),("base_identity_holds",.boolean c.baseIdentityHolds),("successor_identity_holds",.boolean c.successorIdentityHolds),("general_rate_identity",.text c.generalRateIdentity),("general_power_identity",.text c.generalPowerIdentity),("general_shell_identity",.text c.generalShellIdentity),("static_silence_is_empty_not_numeric_zero",.boolean c.staticSilenceIsEmpty),("negative_zero_irrational_or_imaginary_proof_scalar_used",.boolean c.forbiddenProofScalarUsed)]
def result : Except String Certificate → Value | .error e => .object [("error",.text e)] | .ok c => certificateValue c
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
#eval IO.println (render (.array [
'''+',\n'.join('result (radiatedPowerCertificate ('+('.boolean '+str(n).lower() if isinstance(n,bool) else '.integer ('+str(n)+')')+'))' for n in inputs)+']))\n';p=w/'constants-recovery/QuadrupoleCertificate984.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};proc=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True,capture_output=True);(w/'quadrupole984_certificate_lean.log').write_text(proc.stdout+proc.stderr);assert proc.returncode==0,proc.stdout[:2000];actual=json.loads(proc.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:1]
mods=['QuadrupoleRadiatedPower','QuadrupoleRadiatedPowerCertificate'];decl=[]
for m in mods:
 decl += ['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/f'SFT/Physics/{m}.lean').read_text(),re.M)]
p=w/'quadrupole984_certificate_audit.lean';p.write_text('import SFT.Physics.QuadrupoleRadiatedPowerCertificate\n'+''.join('#print axioms '+n+'\n' for n in decl));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env=env,text=True);(w/'quadrupole984_certificate_audit.log').write_text(out);assert all("'"+n+"' does not depend on any axioms" in out for n in decl);(w/'quadrupole984_certificate_report.json').write_text(json.dumps(dict(status='PASS',cases=len(inputs),all21fields=True,declarations=decl,axioms=[],source_sha256={m:hashlib.sha256((r/f'SFT/Physics/{m}.lean').read_bytes()).hexdigest() for m in mods}),indent=2));print('PASS',len(inputs),'complete21fieldcertificates/domaincases;',len(decl),'empty declarations')

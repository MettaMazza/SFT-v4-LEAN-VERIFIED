from pathlib import Path
import sys,json,os,subprocess,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import post_newtonian_fixed_point_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
s='''import SFT.Physics.PostNewtonianFixedPointCertificate
import SFT.Host.Canonical
open SFT.Physics PostNewtonianFixedPointCertificate PostNewtonianFixedPoint SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",nv q.den)]
def fractions (xs : List Rat) : Value := .array (xs.map frac)
def structuralValue (v : Structural) : Value := .object [("matter",frac v.matter),("coupling",frac v.coupling),("fixed",frac v.fixed)]
def certificateValue (c : Certificate) : Value := .object [("structural",structuralValue c.structural),("fixed_candidates",fractions c.fixedCandidates),("admissible_fixed_points",fractions c.admissibleFixedPoints),("values",fractions c.values),("errors",fractions c.errors),("corrections",fractions c.corrections),("error_factors",fractions c.errorFactors),("correction_factors",fractions c.correctionFactors),("values_increase_below_fixed",.boolean c.valuesIncreaseBelowFixed),("errors_strictly_shrink",.boolean c.errorsStrictlyShrink),("corrections_strictly_shrink",.boolean c.correctionsStrictlyShrink),("all_factors_below_quarter",.boolean c.allFactorsBelowQuarter),("general_error_identity",.text c.generalErrorIdentity),("general_correction_identity",.text c.generalCorrectionIdentity)]
def result : Except String Certificate → Value | .ok c => certificateValue c | .error e => .text e
#eval IO.println (render (.array ([1,2,3,4,5,6,7,8].map (fun n => result (convergenceCertificate (.integer (.ofNat n)))))))
''';p=w/'constants-recovery/PostNewtonianCertificate978.lean';p.write_text(s);out=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);assert json.loads(out)==[canonical_value(src.convergence_certificate(i)) for i in range(1,9)]
mods=['PostNewtonianFixedPoint','PostNewtonianFixedPointCertificate'];ds=[];hashes={}
for m in mods:
 p=r/f'SFT/Physics/{m}.lean';hashes[m]=hashlib.sha256(p.read_bytes()).hexdigest();ds+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive) (\w+)',p.read_text(),re.M)]
p=w/'constants-recovery/PostNewtonianAudit978.lean';p.write_text('import SFT.Physics.PostNewtonianFixedPointCertificate\n'+'\n'.join('#print axioms '+d for d in ds));out=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'postnewtonian978_staged_audit.log').write_text(out);assert all("'"+d+"' does not depend on any axioms" in out for d in ds)
(w/'postnewtonian978_certificate_report.json').write_text(json.dumps(dict(status='PASS',entire_original_certificate=True,depths=list(range(1,9)),fields=14,source_sha256=hashes,declarations=ds,axioms=[]),indent=2));print('PASS eight entire14field certificates;',len(ds),'empty declarations')

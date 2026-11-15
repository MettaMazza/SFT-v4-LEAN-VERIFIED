from pathlib import Path
import sys,json,os,subprocess,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import orbital_dimension_stability_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
s='''import SFT.Physics.OrbitalDimensionStabilityGeneral
import SFT.Physics.OrbitalDimensionStabilityGrammar
import SFT.Host.Canonical
open SFT.Physics OrbitalDimensionStabilityCertificate SFT.Host.Canonical SFT.Foundation.ExactOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (q : PositiveFraction) : Value := .object [("numerator",nv q.numerator),("denominator",nv q.denominator)]
def rowValue (r : DimensionRow) : Value := .object [("dimension",nv r.dimension),("classes",.array (r.classes.map Value.text)),("magnitudes",.array (r.magnitudes.map (fun p => .array [frac p.1,frac p.2])))]
def certificateValue (c : Certificate) : Value := .object [("rows",.array (c.rows.map rowValue)),("stable_dimensions",.array (c.stableDimensions.map nv)),("marginal_dimensions",.array (c.marginalDimensions.map nv)),("unstable_dimensions",.array (c.unstableDimensions.map nv)),("general_partition",.text c.generalPartition),("proof",.text c.proof),("negative_exponent_required",.boolean c.negativeExponentRequired)]
#eval IO.println (render (match dimensionCertificate with | .ok c => certificateValue c | .error e => .text e))
''';p=w/'constants-recovery/OrbitalCertificate977.lean';p.write_text(s);out=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);assert json.loads(out)==canonical_value(src.dimension_certificate())
mods=['OrbitalDimensionStability','OrbitalDimensionStabilityCertificate','OrbitalDimensionStabilityGeneral','OrbitalDimensionStabilityGrammar'];ds=[];hashes={}
for m in mods:
 p=r/f'SFT/Physics/{m}.lean';hashes[m]=hashlib.sha256(p.read_bytes()).hexdigest();ds+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive) (\w+)',p.read_text(),re.M)]
p=w/'constants-recovery/OrbitalAudit977.lean';p.write_text('import SFT.Physics.OrbitalDimensionStabilityGeneral\nimport SFT.Physics.OrbitalDimensionStabilityGrammar\n'+'\n'.join('#print axioms '+d for d in ds));out=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'orbital977_staged_audit.log').write_text(out);assert all("'"+d+"' does not depend on any axioms" in out for d in ds)
(w/'orbital977_certificate_report.json').write_text(json.dumps(dict(status='PASS',entire_original_certificate=True,fields=7,source_sha256=hashes,declarations=ds,axioms=[]),indent=2));print('PASS seven-field certificate;',len(ds),'empty declarations')

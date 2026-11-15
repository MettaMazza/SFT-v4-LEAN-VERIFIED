from pathlib import Path
import sys,json,os,subprocess,re,hashlib
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import lyapunov_ks_correspondence_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
s='''import SFT.Physics.LyapunovKSCorrespondenceGeneral
import SFT.Host.Canonical
open SFT.Physics LyapunovKSCorrespondenceCertificate SFT.Host.Canonical
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def nv (n : Nat) : Value := .integer (.ofNat n)
def ns (xs : List Nat) : Value := .array (xs.map nv)
def caseValue (c : CarrierCase) : Value := .object [("label_count",nv c.labelCount),("depth_support",ns c.depthSupport),("successor_ratios",ns c.successorRatios),("separation_multipliers",.array (c.separationMultipliers.map Value.integer))]
def certificateValue (c : Certificate) : Value := .object [("cases",.array (c.cases.map caseValue)),("support_is_m_to_depth",.boolean c.supportIsPower),("one_step_support_multiplier_is_m",.boolean c.successorMultiplier),("local_separation_multiplier_is_m",.boolean c.localSeparationMultiplier),("common_exact_carrier",.boolean c.commonCarrier),("analytic_proof_value_required",.boolean c.analyticProofValueRequired)]
#eval IO.println (render (match carrierCertificate with | .ok c => certificateValue c | .error e => .text e))
''';p=w/'constants-recovery/LyapunovCertificate975.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};binary='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);assert json.loads(out)==canonical_value(src.carrier_certificate())
mods=['LyapunovKSCorrespondence','LyapunovKSCorrespondenceCertificate','LyapunovKSCorrespondenceGeneral','LyapunovKSCorrespondenceGrammar','LyapunovKSCorrespondenceEvidence','LyapunovPrediction','LyapunovRecords','LyapunovExperiment','LyapunovMeasurement','LyapunovValidation'];ds=[];hashes={}
for mod in mods:
 p=c/f'SFT/Physics/{mod}.lean';hashes[mod]=hashlib.sha256(p.read_bytes()).hexdigest();ds+=['SFT.Physics.'+mod+'.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive) (\w+)',p.read_text(),re.M)]
p=w/'constants-recovery/LyapunovAudit975.lean';p.write_text('import SFT.Physics.LyapunovKSCorrespondenceGeneral\nimport SFT.Physics.LyapunovValidation\n'+'\n'.join('#print axioms '+d for d in ds));out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);(w/'lyapunov975_staged_audit.log').write_text(out);assert all("'"+d+"' does not depend on any axioms" in out for d in ds)
(w/'lyapunov975_certificate_report.json').write_text(json.dumps(dict(status='PASS',entire_original_certificate=True,fields=6,source_sha256=hashes,declarations=ds,axioms=[]),indent=2));print('PASS full six-field certificate;',len(ds),'empty declarations')

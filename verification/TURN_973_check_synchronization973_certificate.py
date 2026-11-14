from pathlib import Path
import json,sys,subprocess,os,re,hashlib
from fractions import Fraction
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import coupled_ensemble_synchronization_terminal_law_v1 as src
def enc(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return list(map(enc,x))
 if isinstance(x,dict):return {k:enc(v) for k,v in x.items()}
 return x
s='''import SFT.Physics.CoupledEnsembleSynchronizationGrammar
import SFT.Host.Canonical
open SFT.Physics CoupledEnsembleSynchronization CoupledEnsembleSynchronizationCertificate SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def list (xs : List Rat) : Value := .array (xs.map frac)
def scale : Scale → Value | .empty => .array [] | .positive q => frac q
def cert (c : Certificate) : Value := .object [
 ("couplings",list c.couplings),("pairs",.array (c.pairs.map (fun (a,b) => .array [frac a,frac b]))),
 ("residual_records",.array (c.residualRecords.map (fun xs => .array (xs.map list)))),
 ("unique_synchronizing_coupling",frac c.uniqueSynchronizingCoupling),
 ("half_One_residuals_empty",.boolean c.halfOneResidualsEmpty),
 ("off_half_residuals_positive",.boolean c.offHalfResidualsPositive),
 ("residual_scale_lower",scale c.residualScaleLower),("residual_scale_half",scale c.residualScaleHalf),
 ("residual_scale_upper",scale c.residualScaleUpper),("synchronized_terminal_preserved",.boolean c.synchronizedTerminalPreserved)]
#eval IO.println (render (match formalCertificate with | .ok c => cert c | .error e => .text e))
'''
p=w/'constants-recovery/SynchronizationCertificate973.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};binary='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);assert json.loads(out)==enc(src.formal_certificate())
ds=[];hashes={}
for module in ['CoupledEnsembleSynchronization','CoupledEnsembleSynchronizationCertificate','CoupledEnsembleSynchronizationGrammar','CoupledEnsembleSynchronizationEvidence','CoupledEnsembleSynchronizationGeneral','CoupledEnsembleSynchronizationMeasurement','SynchronizationPrediction']:
 m=c/f'SFT/Physics/{module}.lean';hashes[str(m.relative_to(c))]=hashlib.sha256(m.read_bytes()).hexdigest();ds+=['SFT.Physics.'+module+'.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive) (\w+)',m.read_text(),re.M)]
p=w/'constants-recovery/SynchronizationAudit973.lean';p.write_text('import SFT.Physics.CoupledEnsembleSynchronizationEvidence\nimport SFT.Physics.CoupledEnsembleSynchronizationGeneral\nimport SFT.Physics.CoupledEnsembleSynchronizationMeasurement\nimport SFT.Physics.SynchronizationPrediction\n'+'\n'.join('#print axioms '+d for d in ds));audit=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);(w/'synchronization973_staged_audit.log').write_text(audit);assert all("'"+d+"' does not depend on any axioms" in audit for d in ds)
(w/'synchronization973_certificate_report.json').write_text(json.dumps(dict(status='PASS',entire_original_certificate=True,fields=10,declarations=ds,axioms=[],sha256=hashes),indent=2));print('PASS full ten-field certificate;',len(ds),'empty declarations')

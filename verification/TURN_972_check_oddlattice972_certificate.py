from pathlib import Path
import json,sys,subprocess,os,re,hashlib
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import odd_lattice_all_region_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
s='''import SFT.Physics.OddLatticeAllRegionCertificate
import SFT.Host.Canonical
open SFT.Physics OddLatticeAllRegionCertificate SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def nv (n : Nat) : Value := .integer (.ofNat n)
def ns (xs : List Nat) : Value := .array (xs.map nv)
def pc (p : PermutationCertificate) : Value := .object [("member_count",.integer p.memberCount),("image",ns p.image),("image_is_complete_support",.boolean p.imageComplete),("image_cardinality",nv p.imageCardinality),("source_cardinality",.integer p.sourceCardinality),("parity_reason",.text p.parityReason)]
def ic (c : InvarianceCertificate) : Value := .object [("permutation",pc c.permutation),("base_vector",ns c.baseVector),("vectors",.array (c.vectors.map ns)),("all_steps_equal",.boolean c.allStepsEqual),("all_regions_occupied",.boolean c.allRegionsOccupied),("total_members_retained",.boolean c.totalMembersRetained)]
def cert (c : Certificate) : Value := .object [("generated_shapes",.array (c.shapes.map (fun (n,r) => .array [nv n,nv r]))),("certificates",.array (c.certificates.map ic)),("generality",.text c.generality)]
def result (f : α → Value) : Except String α → Value | .ok x => f x | .error e => .object [("error",.text e)]
#eval IO.println (render (result cert formalCertificate))
'''
p=w/'constants-recovery/OddLatticeCertificateCompare972.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};bin='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([bin,'-j1',str(p)],env=env,text=True);actual=json.loads(out);expected=canonical_value(src.formal_certificate());assert actual==expected
m=c/'SFT/Physics/OddLatticeAllRegionCertificate.lean';ds=['SFT.Physics.OddLatticeAllRegionCertificate.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',m.read_text(),re.M)];p=w/'constants-recovery/OddLatticeCertificateAudit972.lean';p.write_text('import SFT.Physics.OddLatticeAllRegionCertificate\n'+'\n'.join('#print axioms '+d for d in ds));audit=subprocess.check_output([bin,'-j1',str(p)],env=env,text=True);(w/'oddlattice972_certificate_audit.log').write_text(audit);assert all("'"+d+"' does not depend on any axioms" in audit for d in ds)
(w/'oddlattice972_certificate_report.json').write_text(json.dumps(dict(status='PASS',entire_original_certificate=True,shapes=5,declarations=ds,axioms=[],lean_sha256=hashlib.sha256(m.read_bytes()).hexdigest()),indent=2));print('PASS full five-shape certificate;',len(ds),'empty declarations')

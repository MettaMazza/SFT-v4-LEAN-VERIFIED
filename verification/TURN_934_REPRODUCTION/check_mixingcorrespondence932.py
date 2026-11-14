from pathlib import Path
import json,sys,re,subprocess,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_completion_laws_v1 as src
s=(r/'SFT/Physics/MixingCorrespondence.lean').read_text();names=['SFT.Physics.MixingCorrespondence.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive) (\w+)',s,re.M)];p=r/'MixingCorrespondenceAudit932.lean';p.write_text('import SFT.Physics.MixingCorrespondence\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'mixingcorrespondence932_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'MixingCorrespondenceCompare932.lean';p.write_text('''import SFT.Physics.MixingCorrespondence
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.MixingCorrespondence SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def matrix (m : List (List Rat)) : Value := .array (m.map fun row => .array (row.map fraction))
#eval do
 let result ← IO.ofExcept mixingCorrespondence
 let channels ← IO.ofExcept channelBasis
 let basis ← IO.ofExcept leptonMassBasis
 let values := [LeptonIntervals.normalize (-7) 3 (by decide),LeptonIntervals.zero,LeptonIntervals.normalize 1 6 (by decide),LeptonIntervals.normalize 1 2 (by decide),LeptonIntervals.normalize 5 6 (by decide),LeptonIntervals.normalize 1 1 (by decide),LeptonIntervals.normalize 7 3 (by decide)]
 let folded ← IO.ofExcept (values.mapM triplingFold)
 let alignment ← IO.ofExcept (alignmentMatrix values)
 IO.println (render (.object [("channels",.array (channels.map fraction)),("basis",.array (basis.map fraction)),("tripling",.array (folded.map fraction)),("alignment",matrix alignment),("result",.object [("quark_lock",fraction result.quarkLock),("lepton_lock",fraction result.leptonLock),("quark_matrix",matrix result.quarkMatrix),("lepton_matrix",matrix result.leptonMatrix),("quark_class",.text result.quarkClass),("lepton_class",.text result.leptonClass)])]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(tuple,list)):return [cv(y) for y in x]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 return x
values=[Fraction(-7,3),Fraction(0),Fraction(1,6),Fraction(1,2),Fraction(5,6),Fraction(1),Fraction(7,3)];expected=cv(dict(channels=src.channel_basis(),basis=src.lepton_mass_basis(),tripling=[src.tripling_fold(x) for x in values],alignment=src.alignment_matrix(tuple(values)),result=src.mixing_correspondence()));assert actual==expected
(w/'mixingcorrespondence932_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/matter_flavour_completion_laws_v1.py:channel_basis,lepton_mass_basis,alignment_matrix,mixing_correspondence;matter_flavour_laws_v1.py:tripling_fold',actual=actual,expected=expected,audited_declarations=names,axioms=[]),indent=2));print('PASS complete original six-field record,bases and seven full-domain tripling/alignment cases;',len(names),'empty-axiom declarations')

from pathlib import Path
from fractions import Fraction as F
import sys,json,subprocess,os,shutil,re,itertools
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v=Path('/Volumes/One Touch/ernos-labs-sft-platform')
for part in ['laws','validation','execution']:shutil.copy2(v/f'sft/physics/atomic_field_splitting_successor_{part}_v1.py',w/f'v3-runtime500/sft/physics/atomic_field_splitting_successor_{part}_v1.py')
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_field_splitting_successor_laws_v1 as src
counts=[False,True,None,-1,0,1,2,3,4,5,6,7,17];fractions=[False,True,0,F(-1),F(0),F(1),F(2),F(1,2),F(3,4),F(5,36)];pairs=list(itertools.product(fractions,fractions));triples=list(itertools.product([F(1,3),F(3,2),F(4,7)],[1,2,7],[F(1,5),F(2,5),F(3)]))+[(x,1,F(1)) for x in fractions]+[(F(1),x,F(1)) for x in counts]+[(F(1),1,x) for x in fractions]
def ci(x):
 if isinstance(x,bool):return 'CountArgument.count (.boolean '+str(x).lower()+')'
 if isinstance(x,int):return 'CountArgument.count (.integer ('+str(x)+'))'
 return 'CountArgument.nonInteger'
def fi(x):return f'FoldFirstReturn.Input.fraction (normalize ({x.numerator}) {x.denominator} (by decide))' if isinstance(x,F) else 'FoldFirstReturn.Input.nonFraction'
s='''import SFT.Physics.AtomicFieldSplittingProofs
open SFT.Physics SFT.Host.Canonical AtomicFieldSplitting LeptonIntervals
set_option maxRecDepth 20000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def result : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok q => frac q
def countResult : Except String Nat → Value
 | .error e => .object [("error",.text e)]
 | .ok n => .integer (.ofNat n)
#eval do
 IO.println (render (.object [
'''
s+='("counts",.array ['+','.join('countResult (magneticSublevelCount ('+ci(x)+'))' for x in counts)+']),\n'
s+='("zeeman",.array ['+','.join('result (zeemanShiftMagnitude ('+fi(g)+') ('+ci(m)+') ('+fi(b)+'))' for g,m,b in triples)+']),\n'
for key,fn in [('linear','linearStarkMagnitude'),('quadratic','quadraticStarkMagnitude')]:s+='("'+key+'",.array ['+','.join('result ('+fn+' ('+fi(p)+') ('+fi(b)+'))' for p,b in pairs)+'])'+(',' if key=='linear' else '')+'\n'
s+=']))\n';p=r/'AtomicFieldSplittingCompare958.lean';p.write_text(s);actual=json.loads(subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),text=True))
def call(fn,*args):
 try:
  x=fn(*args);return [x.numerator,x.denominator] if isinstance(x,F) else x
 except ValueError as e:return {'error':str(e)}
expected=dict(counts=[call(src.magnetic_sublevel_count,x) for x in counts],zeeman=[call(src.zeeman_shift_magnitude,*x) for x in triples],linear=[call(src.linear_stark_magnitude,*x) for x in pairs],quadratic=[call(src.quadratic_stark_magnitude,*x) for x in pairs]);assert actual==expected
names=[]
for m in ['AtomicFieldSplitting','AtomicFieldSplittingProofs']:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|inductive) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
p=r/'AtomicFieldSplittingAudit958.lean';p.write_text('import SFT.Physics.AtomicFieldSplittingProofs\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),text=True);(w/'atomicfieldsplitting958_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
(w/'atomicfieldsplitting958_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS',len(names),'empty axioms;',len(counts)+len(triples)+2*len(pairs),'source operation cases')

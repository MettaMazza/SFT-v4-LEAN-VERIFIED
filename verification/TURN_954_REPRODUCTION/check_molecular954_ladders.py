from pathlib import Path
import sys,re,json,subprocess,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import molecular_spectroscopy_successor_laws_v1 as src
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'))
names=['SFT.Physics.MolecularLadders.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics/MolecularLadders.lean').read_text(),re.M)];p=r/'MolecularLaddersAudit954.lean';p.write_text('import SFT.Physics.MolecularLadders\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'molecular954_ladder_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
ordinals=[-2,0,1,2,3,4,10,True,False,'x',Fraction(2)];ratios=[Fraction(-1),Fraction(0),Fraction(1),Fraction(1,100),Fraction(2,3),1,True]
def ordinal(x):
 if isinstance(x,bool):return '.count (.boolean '+str(x).lower()+')'
 if isinstance(x,int):return '.count (.integer ('+str(x)+'))'
 return '.nonInteger'
def ratio(x):return '.fraction (LeptonIntervals.normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))' if isinstance(x,Fraction) else '.nonFraction'
p=r/'MolecularLaddersCompare954.lean';p.write_text('''import SFT.Physics.MolecularLadders
open SFT.Physics SFT.Host.Canonical MolecularLadders
set_option maxRecDepth 20000
def ri : Except String Int → Value
 | .error e => .object [("error",.text e)]
 | .ok x => .integer x
def rq : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok x => .array [.integer x.num,.integer (.ofNat x.den)]
#eval do
 let ordinals : List OrdinalInput := ['''+','.join(ordinal(x) for x in ordinals)+''']
 let ratios : List FoldFirstReturn.Input := ['''+','.join(ratio(x) for x in ratios)+''']
 let rows : List Value := ratios.flatMap fun h => ratios.flatMap fun a => ordinals.map fun n => .array [rq (vibrationalLevel h a n),rq (adjacentVibrationalGap h a n)]
 IO.println (render (.object [("empty",.array (emptyRotationalGround.map (fun _ => .null))),("rotation",.array (ordinals.map (fun n => ri (rotationalLevel n)))),("gaps",.array (ordinals.map (fun n => ri (adjacentRotationalGap n)))),("odd",.array (ordinals.map (fun n => ri (oddVibrationalCarrier n)))),("vibration",.array rows)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def result(fn,*args):
 try:
  q=fn(*args);return [q.numerator,q.denominator] if isinstance(q,Fraction) else q
 except ValueError as e:return {'error':str(e)}
expected={'empty':list(src.empty_rotational_ground()),'rotation':[result(src.rotational_level,n) for n in ordinals],'gaps':[result(src.adjacent_rotational_gap,n) for n in ordinals],'odd':[result(src.odd_vibrational_carrier,n) for n in ordinals],'vibration':[[result(src.vibrational_level,h,a,n),result(src.adjacent_vibrational_gap,h,a,n)] for h in ratios for a in ratios for n in ordinals]};assert actual==expected
(w/'molecular954_ladder_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names,vibrational_cases=len(ratios)**2*len(ordinals)),indent=2));print('PASS original ground,33ordinal calls and539vibration/gap pairs;',len(names),'empty axioms including universal odd carrier')

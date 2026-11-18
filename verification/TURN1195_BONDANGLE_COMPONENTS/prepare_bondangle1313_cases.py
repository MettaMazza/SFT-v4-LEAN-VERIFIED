from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1313/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.bond_angle_law_v1 import equal_sector_turn_fraction,molecular_angle_vector
from sft.engine.exact import HeldLabel,PositiveCount
q=lambda x:json.dumps(x,ensure_ascii=False)
pc=lambda n:'⟨'+str(n)+',by decide⟩'
hl=lambda x:'⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
p=w/'turn1064_recovery/SFT/Chemistry/MolecularBondAngle.lean';s=p.read_text();s=s.replace('end SFT.Chemistry.MolecularBondAngle','')
s+='\ndef molecularAngleVector : List MolecularAngleCarrier := [\n'
s+=',\n'.join('⟨'+q(c.target_id)+','+','.join(hl(getattr(c,k))for k in ['species','molecular_state','geometry','coordinate','angle_role'])+','+pc(c.sector_count.value)+','+pc(c.sector_separation.value)+'⟩' for c in molecular_angle_vector())+']\nend SFT.Chemistry.MolecularBondAngle\n';p.write_text(s)
expected=[];calls=[]
geometries=[None,HeldLabel('wrong','linear-equal-two-sector'),HeldLabel('molecular-geometry','unsupported')]+[c.geometry for c in molecular_angle_vector()[:3]]
for g in geometries:
 for n in [None,1,2,3,4,5]:
  for k in [None,1,2,3,4]:
   try:
    out=equal_sector_turn_fraction(g,PositiveCount(n)if n else None,PositiveCount(k)if k else None);result={'ok':[out.numerator,out.denominator]}
   except Exception as e:result={'error':str(e)}
   expected.append(result)
   gl='.other'if g is None else '(.held '+hl(g)+')';nn='.other'if n is None else '(.count '+pc(n)+')';kk='.other'if k is None else '(.count '+pc(k)+')'
   calls.append('out (equalSectorTurnFraction '+gl+' '+nn+' '+kk+')')
header='''import SFT.Chemistry.MolecularBondAngle
open SFT.Chemistry.MolecularBondAngle SFT.Host.Canonical SFT.Foundation.ExactOperations
def out : Except String PositiveFraction → Value
 | .error error => .object [("error",.text error)]
 | .ok ratio => .object [("ok",.array [.integer ratio.numerator,.integer ratio.denominator])]
def main : IO Unit := IO.println (render (.array [
'''
(w/'MolecularBondAngleCases1313.lean').write_text(header+',\n'.join(calls)+']))\n');(w/'bondangle1313_cases_expected.json').write_text(json.dumps(expected,indent=2)+'\n');print('Prepared four exact carriers and',len(expected),'original law-domain cases')

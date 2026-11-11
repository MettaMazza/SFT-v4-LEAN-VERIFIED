from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/alpha_interval_spec650.py').read_text(),ns)
source=ns['raw'](ns['values']['source_snapshot_path']);original=ns['namespace']['codata_inverse_alpha_interval'];ratio=ns['namespace']['inverse_fine_structure']()
def row(c,u,label='inverse fine-structure constant'):return label.ljust(60)+c.ljust(25)+u.ljust(25)
class Input:
 def __init__(self,text):self.text=text
 def read_text(self,**kw):return self.text
texts=[source,'',row('137.035999177','0.000000021'),row('137.035999177','0.000000021')+'\n'+row('137.035999177','0.000000021'),row('137','137'),row('137','138'),row('137','0'),row('-137','1'),row('137...','1'),row('138','0.001'),row('136','0.001'),row('137.035999177','0.000000021','another quantity'),row('137.035999177','0.000000021')[:109],row('137.035999177','0.000000021')+'\r\n',row('137.035999177','0.000000021')+'\u2028unrelated',row('137.035999177e0','0.000000021e0')]
expected=[]
for text in texts:
 try:
  lo,ce,hi=original(Input(text));expected.append('|'.join(f'{v.numerator}/{v.denominator}' for v in (lo,ce,hi))+'|'+str(lo<=ratio<=hi).lower())
 except ValueError as e:expected.append('ValueError: '+str(e))
q=lambda x:json.dumps(x,ensure_ascii=False)
s='''import SFT.Physics.AlphaInterval
open SFT.Physics.AlphaInterval
set_option maxRecDepth 1000000
def display (r : Rat) : String := s!"{r.num}/{r.den}"
def cases : List (String × String) := [
'''+','.join('('+q(t)+','+q(e)+')' for t,e in zip(texts,expected))+''']
def main : IO Unit := do
 for (text,expected) in cases do
  let actual := match sourceInterval text with
   | .error e => e
   | .ok (lo,ce,hi) => match inInterval lo hi with
     | .error e => e
     | .ok b => display lo ++ "|" ++ display ce ++ "|" ++ display hi ++ "|" ++ toString b
  if actual != expected then throw (IO.userError s!"actual {actual}, expected {expected}")
 IO.println "PASS16 actual pinned source parser/comparison cases"
'''
r=Path('work/constants-recovery').resolve();(r/'AlphaSourceCases650.lean').write_text(s)
p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run','AlphaSourceCases650.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True,capture_output=True)
Path('work/alpha_source650_cases.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr
Path('work/alpha_source650_report.json').write_text(json.dumps(dict(status='PASS',source_commit=ns['pin'],cases=len(texts),scope='Complete original CODATA snapshot; missing/duplicate/wrong/short rows; invalid decimal/uncertainty; changed interval; CRLF and Unicode line boundaries; original decimal exponent'),indent=2));print(p.stdout)

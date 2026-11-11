from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/alpha_interval_spec650.py').read_text(),ns)
parse=ns['namespace']['iaea_magic_sequence'];derived=ns['namespace']['nuclear_closure_prefix'](8)
source='IAEA-INDC-NDS-0452-MAGIC-NUMBERS';key='reported_positive_magic_number_sequence'
base={'source_id':source,key:list(derived)}
cases=[json.loads(ns['raw'](ns['namespace']['IAEA_PATH'])),base,{},dict(base,source_id='changed'),dict(base,source_id=3),{'source_id':source},dict(base,**{key:[]}),dict(base,**{key:'2'}),dict(base,**{key:[True]}),dict(base,**{key:[0]}),dict(base,**{key:[-1]}),dict(base,**{key:[2.0]}),dict(base,**{key:['2']}),dict(base,**{key:[1]}),dict(base,**{key:[2,2]}),dict(base,**{key:list(reversed(derived))}),dict(base,**{key:list(derived)+[200]})]
class Input:
 def __init__(self,p):self.p=p
 def read_text(self,**kw):return json.dumps(self.p)
q=lambda x:json.dumps(x,ensure_ascii=False)
rows=[]
for p in cases:
 try:
  seq=parse(Input(p));expected='|'.join(map(str,seq))+'|'+str(seq==derived).lower()
 except ValueError as e:expected='ValueError: '+str(e)
 identity='some '+q(p['source_id']) if isinstance(p.get('source_id'),str) else 'none'
 seq=p.get(key)
 raw='some ['+','.join('(Coordinate.integer ('+str(v)+'))' if isinstance(v,int) and not isinstance(v,bool) else '.other' for v in seq)+']' if isinstance(seq,list) else 'none'
 rows.append('(⟨'+identity+','+raw+'⟩,'+q(expected)+')')
s='''import SFT.Physics.NuclearSequenceSource
open SFT.Physics.NuclearSequenceSource SFT.Physics
def cases : List (Record × String) := [
'''+','.join(rows)+''']
def main : IO Unit := do
 for (record,expected) in cases do
  let actual := match magicSequence record with
   | .error e => e
   | .ok observed => match NuclearClosure.closurePrefix (.integer 8) with
     | .error e => e
     | .ok generated => SFT.Host.Text.intercalate "|" (observed.map toString) ++ "|" ++ toString (orderedEqual observed generated)
  if actual != expected then throw (IO.userError s!"actual {actual}; expected {expected}")
 IO.println "PASS17 original source guard/sequence/comparison cases"
'''
r=Path('work/constants-recovery').resolve();(r/'NuclearSequenceCases650.lean').write_text(s)
p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run','NuclearSequenceCases650.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True,capture_output=True)
Path('work/nuclear_sequence650_cases.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr
Path('work/nuclear_sequence650_cases_report.json').write_text(json.dumps(dict(status='PASS',source_commit=ns['pin'],cases=len(cases),source_operation='iaea_magic_sequence and NuclearExternalValidator sequence comparison',scope='Original arbitrary positive list domain retained; source identity, missing/wrong/empty list, noninteger/boolean/nonpositive elements, duplicate and reordered/additional coordinates'),indent=2));print(p.stdout)

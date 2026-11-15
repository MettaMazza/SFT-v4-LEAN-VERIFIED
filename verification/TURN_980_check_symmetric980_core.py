from pathlib import Path
import sys,json,subprocess,os,itertools,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import symmetric_source_conservation_terminal_law_v1 as src
q=json.dumps;rows=[];expected=[]
for a,b in itertools.product(src.COORDINATES+('unknown',''),repeat=2):
 rows.append('slotResult (symmetricSlot '+q(a)+' '+q(b)+')')
 try:expected.append(list(src.symmetric_slot(a,b)))
 except ValueError as e:expected.append({'error':str(e)})
for word in [(),('unknown',),*itertools.product(src.COORDINATES,repeat=3),('time',)*9]:
 for a,b in [('time','axis-two'),('axis-three','axis-one'),('bad','time')]:
  rows.append('termResult (derivativeTerm '+q(list(word))+' '+q(a)+' '+q(b)+')')
  try:expected.append(src.derivative_term(word,a,b))
  except ValueError as e:expected.append({'error':str(e)})
for direction in src.COORDINATES+('bad',''):
 rows.append('ledgerResult (divergenceLedgers '+q(direction)+')')
 try:expected.append([[ [term,count] for term,count in ledger.items()] for ledger in src.divergence_ledgers(direction)])
 except ValueError as e:expected.append({'error':str(e)})
rows+=['.array (symmetricSlots.map sv)','.object (sourceComponentLedger.map (fun p => (p.1,.array (p.2.map sv))))'];expected+=[src.symmetric_slots(),src.source_component_ledger()]
s='''import SFT.Physics.SymmetricSourceConservationGeneral
import SFT.Host.Canonical
open SFT.Physics.SymmetricSourceConservation SFT.Host.Canonical
def sv (p : Slot) : Value := .array [.text (coordinateName p.1),.text (coordinateName p.2)]
def tv (p : Term) : Value := .array [.array (p.1.map (fun c => .text (coordinateName c))),sv p.2]
def slotResult : Except String Slot → Value | .error e => .object [("error",.text e)] | .ok p => sv p
def termResult : Except String Term → Value | .error e => .object [("error",.text e)] | .ok p => tv p
def cv (xs : List (Term × Nat)) : Value := .array (xs.map (fun p => .array [tv p.1,.integer (.ofNat p.2)]))
def ledgerResult : Except String (List (Term × Nat) × List (Term × Nat)) → Value | .error e => .object [("error",.text e)] | .ok p => .array [cv p.1,cv p.2]
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval IO.println (render (.array [
'''+',\n'.join(rows)+']))\n';p=w/'constants-recovery/SymmetricCore980.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(expected));assert actual==expected,[i for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
audit='';names=[];hashes={}
for m in ['SymmetricSourceConservation','SymmetricSourceConservationGeneral']:
 p=r/('SFT/Physics/'+m+'.lean');s=p.read_text();hashes[m]=hashlib.sha256(s.encode()).hexdigest();audit+='import SFT.Physics.'+m+'\n';names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|abbrev) (\w+)',s,re.M)];(w/'constants-recovery/SFT/Physics'/p.name).write_text(s)
audit+=''.join('#print axioms '+n+'\n' for n in names);p=w/'symmetric980_audit.lean';p.write_text(audit);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);(w/'symmetric980_audit.log').write_text(out);assert all("'"+n+"' does not depend on any axioms" in out for n in names)
(w/'symmetric980_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(rows),declarations=names,axioms=[],source_sha256=hashes),indent=2));print('PASS',len(rows),'core cases and',len(names),'empty declarations')

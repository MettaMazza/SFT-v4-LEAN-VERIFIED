from pathlib import Path
import itertools,json,subprocess,os,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rows=json.loads((w/'quantumsupport1051_walsh_expected.json').read_text())[:273];expected=[];cases=[];idx=0
for d in range(1,4):
 ws=list(itertools.product(['held','returned'],repeat=d))
 for size in range(1,len(ws)+1):
  for selected in itertools.combinations(ws,size):
   original=rows[idx]['ok'];idx+=1
   expected.append([original['parseval_sum'],original['frequency_support'],[[a[1],a[2]] for a in original['mode_rows']]])
   cases.append('('+str(d)+','+json.dumps(selected)+')')
p=w/'quantumsupport1053_cases.lean';p.write_text('''import SFT.Physics.QuantumSupportParseval
import Lean
open SFT.Physics.QuantumSupportPreparation SFT.Physics.QuantumSupportParseval
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def cases : List (Nat × List Word) := ['''+','.join(cases)+''']
#eval IO.println (Lean.Json.compress (Lean.toJson (cases.map fun (d,s) =>
 (energySum s (words d),frequencySupport s (words d),(words d).map (fun k=>[heldAt s k,returnedAt s k])))))
''')
ev={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288',str(p)];x=subprocess.run(cmd,env=ev,capture_output=True,text=True);(w/'quantumsupport1053_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=[[v[0],v[1][0],v[1][1]] for v in json.loads(x.stdout)]
# Decode Lean's nested Prod representation before comparing the three source fields.
assert actual==expected,[(i,a,b) for i,(a,b) in enumerate(zip(actual,expected)) if a!=b][:1]
body=(r/'SFT/Physics/QuantumSupportParseval.lean').read_text();names=['SFT.Physics.QuantumSupportParseval.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',body,re.M)]
p=w/'quantumsupport1053_full_audit.lean';p.write_text('import SFT.Physics.QuantumSupportParseval\n'+''.join('#print axioms '+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=ev,capture_output=True,text=True);(w/'quantumsupport1053_full_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and all("'"+n+"' does not depend on any axioms"in x.stdout for n in names),x.stdout[-2000:]
report=dict(status='PASS',source_claim='SFT-PHYS-QUANTUM-SUPPORT-UNCERTAINTY-TERMINAL-049',source_operation='walsh_support_certificate',source_reference_output_sha256=hashlib.sha256((w/'quantumsupport1051_walsh_expected.json').read_bytes()).hexdigest(),cases=idx,declarations=names,axioms=[],lean_source_sha256=hashlib.sha256(body.encode()).hexdigest(),scope='Every-depth source phase-count Parseval and nonempty unique support-product bound;273complete original support energy/frequency/allmodecount rows compared. Entry049 not yet registered.')
(w/'quantumsupport1053_report.json').write_text(json.dumps(report,indent=2));print('PASS',idx,'completecounts;',len(names),'emptyaxiomdeclarations')

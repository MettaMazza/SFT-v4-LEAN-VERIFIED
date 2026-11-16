from pathlib import Path
import sys,os,json,subprocess,hashlib,copy
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.physics.grand_lock_terminal_law_v1 as source
from sft.engine.canonical import canonical_value
s=(w/'check_chirpobservation1063_analysis.py').read_text();exec(s[s.index('def val(x):'):s.index("s='import")])
original=source.frozen_input();cases=[('original',original)]
def add(name,change):
 d=copy.deepcopy(original);change(d);cases.append((name,d))
add('missingOwner',lambda d:d['physics_claims'].pop())
add('missingEvidence',lambda d:d['physics_claims'][0].update(receipt_hash=''))
add('declaredClosure',lambda d:d.update(transitive_claim_count=533))
add('orphan',lambda d:d['physics_claim_ids'].append('UNKNOWN'))
add('cycle',lambda d:d['dependency_dictionary'].append(dict(claim_id=d['physics_claim_ids'][0],dependencies=[d['physics_claim_ids'][0]])))
add('duplicateOwner',lambda d:d['physics_claim_ids'].append(d['physics_claim_ids'][0]))
head='import SFT.Physics.GrandLockDependency\nopen SFT.Physics.GrandLockDependency SFT.Host.Canonical\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\n'
code=head;expected=[];proof=head+'namespace SFT.Physics.GrandLockDependencyProofs\n'
for i,(name,d)in enumerate(cases):
 source.frozen_input=lambda:d
 try:out=source.dependency_certificate();expected.append(canonical_value(out));expr='.ok ('+val(out)+')'
 except ValueError as e:expected.append(str(e));expr='.error '+json.dumps(str(e))
 # Reuse full immutable input as a single definition; modified cases use full originals.
 code+='def target'+str(i)+' : Value := '+val(d)+'\n#eval IO.println (render (match dependencyCertificate target'+str(i)+' with | .ok v=>v | .error e=>.text e))\n'
 if i==0:proof+='def originalTarget : Value := '+val(d)+'\ntheorem originalComplete : dependencyCertificate originalTarget='+expr+' := rfl\n#print axioms originalComplete\n'
p=w/'grandlock1064_dependency_cases.lean';p.write_text(code);None if os.environ.get('SFT_PRESERVE_PROOFS') else (r/'SFT/Physics/GrandLockDependencyProofs.lean').write_text(proof+'end SFT.Physics.GrandLockDependencyProofs\n')
x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'grandlock1064_dependency_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=[json.loads(l)for l in x.stdout.splitlines()if l.startswith(('{','"'))];assert actual==expected
report=dict(status='PASS',complete_outputs=len(cases),fields=8,source_sha256=hashlib.sha256((w/'v3-runtime500/sft/physics/grand_lock_terminal_law_v1.py').read_bytes()).hexdigest(),lean_sha256=hashlib.sha256((r/'SFT/Physics/GrandLockDependency.lean').read_bytes()).hexdigest());(w/'grandlock1064_dependency_report.json').write_text(json.dumps(report,indent=2));print(report)

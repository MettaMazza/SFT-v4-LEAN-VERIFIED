from pathlib import Path
import re,json
entries=json.load(open('work/quantum491_entries.json'))+[['Incompatibility','INCOMPATIBILITY','QuantumPhysicalIncompatibility'],['Spin','SPIN','QuantumPhysicalSpin']]
scopes=json.load(open('work/quantum491_scopes.json'));scopes.update(Incompatibility='Complete finite source support and original generated joint-refinement family; row-wise preservation of both full phase/action records, constructive failed-row witness, exact absence-of-refinement equivalence and proof that resolving either side necessarily loses a required record of the other.',Spin='Actual admitted finite phase action from the existing Fold state, complete cyclic label shift, full-cycle recurrence return, all held labels remain inside the original cycle, word support and complete source/preparation/action records retained.')
p=Path('work/prepare_quantum491.py');s=p.read_text();s=re.sub(r'entries=\[.*?\];metadata=\{\}','entries='+repr(entries)+';metadata={}',s,count=1);p.write_text(s)
p=Path('work/register_quantum491.py');s=p.read_text();s=re.sub(r"key=\{.*?\}\[stem\];component=\{.*?\}\[stem\]",'key='+repr({s:k for s,k,c in entries})+'[stem];component='+repr({s:c for s,k,c in entries})+'[stem]',s,count=1);a=s.index('scopes=');b=s.index('\nfor rel in modules:',a);s=s[:a]+'scopes='+repr(scopes)+s[b:];p.write_text(s)
Path('work/quantum491_scopes.json').write_text(json.dumps(scopes,indent=2));Path('work/quantum491_entries.json').write_text(json.dumps(entries))
p=Path('work/run_quantum491.py');s=p.read_text();a=s.index("subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c'");s=s[:a]+"common += "+repr(['SFT/Physics/'+c for _,_,c in entries[-2:]]+[p[:-5] for p in json.load(open('work/quantum491_recovery_sources.json'))])+"\n"+s[a:];s=s.replace('for stem,key,component in entries:\n','''for stem,key,component in entries:
 required=[r/'.lake/build/lib/lean/SFT/Physics'/(stem+'ValidationProofs.olean')]+[ir/('SFT/Physics/'+m+'.c.o.export') for m in [component]+[stem+t for t in ['Grammar','Evidence','Experiment','Validation']]]
 while not all(p.exists() for p in required):
  time.sleep(2)
''',1)
# Retained already compiled least-common-return object supplies the existing wave dependency.
s=s.replace("str(Path('work/field491_initializer_bridge.o').resolve()),","str(Path('work/field491_initializer_bridge.o').resolve()),str(Path('work/LeastCommonReturn490.o').resolve()),")
p.write_text(s)
s=Path('work/build_quantum491.py').read_text().replace("entries=json.load(open('work/quantum491_entries.json'));targets=['SFT.Physics.FieldMagneticOrientation:c.o']","entries=json.load(open('work/quantum491_entries.json'))[4:];targets=[p[:-5].replace('/','.')+':c.o' for p in json.load(open('work/quantum491_recovery_sources.json'))]")
s=s.replace('build_quantum491.log','build_quantum491_tail.log');Path('work/build_quantum491_tail.py').write_text(s)

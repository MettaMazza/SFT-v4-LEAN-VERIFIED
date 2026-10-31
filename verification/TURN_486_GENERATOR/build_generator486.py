from pathlib import Path
import re,itertools,subprocess,os,json,hashlib,time
r=Path('work/constants-recovery').resolve();out=Path('work/generator486').resolve();out.mkdir(exist_ok=True);p=r/'SFT/Physics/GeneratorThreeGrammar.lean';old=Path('work/GeneratorThreeGrammar_before485.lean').read_text();assert p.read_text()==old
cut=old.index('set_option maxHeartbeats 20000000 in\ntheorem sourceDecisionMatchesCriteria');base=old[:cut]+'end SFT.Physics.GeneratorThreeGrammar\n';(r/'SFT/Physics/GeneratorThreeGrammarBase.lean').write_text(base)
fields=['carrier','action','recurrence','binary','successor','unit','orbit','order','measurement','extension'];types=[x.title() for x in fields];mods=['GeneratorThreeGrammarBase'];names=[]
for index,bits in enumerate(itertools.product([0,1],repeat=4)):
 m='GeneratorThreeCensus'+str(index);mods.append(m);name='decisionCensus'+str(index);names.append(name);vals=['.admitted' if bit else '.rejected' for bit in bits]+fields[4:];cand='⟨'+','.join(vals)+'⟩';args=' '.join('('+f+' : '+t+')' for f,t in zip(fields[4:],types[4:]));s='import SFT.Physics.GeneratorThreeGrammarBase\nnamespace SFT.Physics.GeneratorThreeGrammar\nset_option maxRecDepth 20000\nset_option maxHeartbeats 20000000\ntheorem '+name+' '+args+' :\n    survives '+cand+' = criteriaDecision '+cand+' := by\n  '+' <;> '.join('cases '+f for f in fields[4:])+'\n  all_goals rfl\nend SFT.Physics.GeneratorThreeGrammar\n';(r/'SFT/Physics'/f'{m}.lean').write_text(s)
source='set_option maxHeartbeats 20000000 in\ntheorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by\n  cases c with\n  | mk '+' '.join(fields)+' =>\n'
def branch(depth,bits,indent):
 if depth==4:return ' '*indent+'exact decisionCensus'+str(int(''.join(map(str,bits)),2))+' '+' '.join(fields[4:])+'\n'
 s=' '*indent+'cases '+fields[depth]+' with\n'
 for bit,label in [(0,'rejected'),(1,'admitted')]:s+=' '*indent+'| '+label+' =>\n'+branch(depth+1,bits+[bit],indent+2)
 return s
source+=branch(0,[],4)
failed=Path('work/GeneratorThreeGrammar_grouped485_failed.lean').read_text();a=failed.index('set_option maxHeartbeats 10000000 in\ntheorem uniqueCriteriaSurvivor');b=failed.index('\ntheorem uniqueSurvivor',a);unique=failed[a:b]
s='\n'.join('import SFT.Physics.'+m for m in mods[1:])+'\nnamespace SFT.Physics.GeneratorThreeGrammar\nopen SFT.Foundation\nset_option maxRecDepth 20000\n'+source+'\n'+unique+old[old.index('\ntheorem uniqueSurvivor'):];p.write_text(s);mods.append('GeneratorThreeGrammar')
oldtypes=re.findall(r'^theorem\s+(.*?)\s*:=',old,re.M|re.S);newtypes=re.findall(r'^theorem\s+(.*?)\s*:=',base+s,re.M|re.S);assert oldtypes==newtypes
assert base[:base.index('end SFT.Physics.GeneratorThreeGrammar')]==old[:cut]
plan=dict(original_sha256=hashlib.sha256(old.encode()).hexdigest(),all_scientific_definitions_identical=True,all_original_public_theorem_statements_identical=True,complete_cases=1024,census_modules=16,cases_per_module=64,modules=mods);(out/'plan.json').write_text(json.dumps(plan,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/bin/lean'
for i,m in enumerate(mods):
 start=time.monotonic()
 with (out/(m+'.log')).open('w') as f:subprocess.run([lean,'-j','1','-M','2048','-o',str(r/'.lake/build/lib/lean/SFT/Physics'/f'{m}.olean'),str(r/'SFT/Physics'/f'{m}.lean')],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
 print('BUILT',i+1,len(mods),m,round(time.monotonic()-start,2),flush=True)
allnames=[]
for m in mods:allnames += ['SFT.Physics.GeneratorThreeGrammar.'+n for _,n in re.findall(r'^(def|theorem|structure|inductive) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
audit=out/'Audit.lean';audit.write_text('import SFT.Physics.GeneratorThreeGrammar\n'+'\n'.join('#print axioms '+n for n in allnames)+'\n');a=subprocess.run([lean,'-j','1','-M','1024',str(audit)],env=env,capture_output=True,text=True);(out/'audit.log').write_text(a.stdout+a.stderr);assert a.returncode==0;assert all("'"+n+"' does not depend on any axioms" in a.stdout for n in allnames)
(out/'report.json').write_text(json.dumps(dict(status='PASS',**plan,audited_declarations=allnames,axiom_dependencies=[]),indent=2)+'\n');print('GENERATOR COMPLETE BUILD/AUDIT PASS',flush=True)
# Existing native Hubble worker starts only after the actual successful kernel build and audit.
s=Path('work/native_hubble485.py').read_text();a=s.index('# Wait on');b=s.index("cs=re.findall",a);s=s[:a]+"assert json.load(open('work/generator486/report.json'))['status']=='PASS'\n"+s[b:];s=s.replace('native485','native486').replace('hubble485','hubble486').replace('hubble_native485','hubble_native486');Path('work/native_hubble486.py').write_text(s)
subprocess.run(['python3','-u','work/native_hubble486.py'],check=True)

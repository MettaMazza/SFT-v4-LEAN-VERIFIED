from pathlib import Path
import re,itertools,subprocess,os,json,time
r=Path('work/constants-recovery').resolve();out=Path('work/generator486').resolve();plan=json.loads((out/'plan.json').read_text());fields=['carrier','action','recurrence','binary','successor','unit','orbit','order','measurement','extension'];types=[f.title() for f in fields];new=[]
for index in range(12,16):
 bits=list(map(int,f'{index:04b}'));subs=[]
 for j,more in enumerate(itertools.product([0,1],repeat=2)):
  name=f'decisionCensus{index}Part{j}';m=f'GeneratorThreeCensus{index}Part{j}';subs.append(m);new.append(m)
  vals=['.admitted' if b else '.rejected' for b in bits+list(more)]+fields[6:];cand='⟨'+','.join(vals)+'⟩';args=' '.join(f'({f} : {t})' for f,t in zip(fields[6:],types[6:]))
  (r/'SFT/Physics'/f'{m}.lean').write_text('import SFT.Physics.GeneratorThreeGrammarBase\nnamespace SFT.Physics.GeneratorThreeGrammar\nset_option maxRecDepth 20000\nset_option maxHeartbeats 20000000\ntheorem '+name+' '+args+' : survives '+cand+' = criteriaDecision '+cand+' := by\n  '+' <;> '.join('cases '+f for f in fields[6:])+'\n  all_goals rfl\nend SFT.Physics.GeneratorThreeGrammar\n')
  # new helper statements preserve every original candidate case.
 s=(r/'SFT/Physics'/f'GeneratorThreeCensus{index}.lean').read_text();s=s.replace('import SFT.Physics.GeneratorThreeGrammarBase','\n'.join('import SFT.Physics.'+m for m in subs));a=s.index(' := by');s=s[:a]+' := by\n  cases successor with\n  | rejected =>\n    cases unit with\n    | rejected => exact decisionCensus'+str(index)+'Part0 orbit order measurement extension\n    | admitted => exact decisionCensus'+str(index)+'Part1 orbit order measurement extension\n  | admitted =>\n    cases unit with\n    | rejected => exact decisionCensus'+str(index)+'Part2 orbit order measurement extension\n    | admitted => exact decisionCensus'+str(index)+'Part3 orbit order measurement extension\nend SFT.Physics.GeneratorThreeGrammar\n';(r/'SFT/Physics'/f'GeneratorThreeCensus{index}.lean').write_text(s);new.append(f'GeneratorThreeCensus{index}')
mods=plan['modules'];mods=mods[:13]+new+['GeneratorThreeGrammar'];plan.update(modules=mods,case_partition='12 groups of64; four groups each partitioned into four16-case modules; 1024 total retained');(out/'plan.json').write_text(json.dumps(plan,indent=2)+'\n');env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/bin/lean'
for m in new+['GeneratorThreeGrammar']:
 t=time.monotonic()
 with (out/(m+'_resume.log')).open('w') as f:subprocess.run([lean,'-j','1','-M','2048','-o',str(r/'.lake/build/lib/lean/SFT/Physics'/f'{m}.olean'),str(r/'SFT/Physics'/f'{m}.lean')],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
 print('BUILT',m,round(time.monotonic()-t,2),flush=True)
s=Path('work/build_generator486.py').read_text();exec(s[s.index('allnames=[]'):])

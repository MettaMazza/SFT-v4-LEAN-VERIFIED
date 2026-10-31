from pathlib import Path
import re,itertools,subprocess,os,json,time
r=Path('work/constants-recovery').resolve();out=Path('work/generator486').resolve();plan=json.loads((out/'plan.json').read_text());fields=['orbit','order','measurement','extension'];names=[];mods=[];env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/bin/lean'
for index,bits in enumerate(itertools.product([0,1],repeat=4)):
 m=f'GeneratorThreeFinalCase{index}';mods.append(m);name=f'decisionFinalCase{index}';names.append(name);cand='⟨'+','.join(['.admitted']*6+['.admitted' if b else '.rejected' for b in bits])+'⟩'
 (r/'SFT/Physics'/f'{m}.lean').write_text('import SFT.Physics.GeneratorThreeGrammarBase\nnamespace SFT.Physics.GeneratorThreeGrammar\nset_option maxRecDepth 20000\nset_option maxHeartbeats 20000000\ntheorem '+name+' : survives '+cand+' = criteriaDecision '+cand+' := rfl\nend SFT.Physics.GeneratorThreeGrammar\n')
p=r/'SFT/Physics/GeneratorThreeCensus15Part3.lean';s=p.read_text();a=s.index(' := by');s=s[:a]+' := by\n'
def branch(d,bits,indent):
 if d==4:return ' '*indent+'exact decisionFinalCase'+str(int(''.join(map(str,bits)),2))+'\n'
 t=' '*indent+'cases '+fields[d]+' with\n'
 for bit,label in [(0,'rejected'),(1,'admitted')]:t+=' '*indent+'| '+label+' =>\n'+branch(d+1,bits+[bit],indent+2)
 return t
s+=branch(0,[],2)+'end SFT.Physics.GeneratorThreeGrammar\n';s=s.replace('import SFT.Physics.GeneratorThreeGrammarBase','\n'.join('import SFT.Physics.'+m for m in mods));p.write_text(s)
new=mods+['GeneratorThreeCensus15Part3','GeneratorThreeCensus15','GeneratorThreeGrammar'];plan['modules']=plan['modules'][:-3]+mods+plan['modules'][-3:];plan['case_partition']+='; final16-case block partitioned into16single-case modules';(out/'plan.json').write_text(json.dumps(plan,indent=2)+'\n')
for m in new:
 t=time.monotonic()
 with (out/(m+'_finish.log')).open('w') as f:subprocess.run([lean,'-j','1','-M','2048','-o',str(r/'.lake/build/lib/lean/SFT/Physics'/f'{m}.olean'),str(r/'SFT/Physics'/f'{m}.lean')],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
 print('BUILT',m,round(time.monotonic()-t,2),flush=True)
mods=plan['modules'];s=Path('work/build_generator486.py').read_text();exec(s[s.index('allnames=[]'):])

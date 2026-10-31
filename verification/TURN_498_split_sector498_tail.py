from pathlib import Path
import itertools,json
r=Path('work/constants-recovery/SFT/Physics');fields=['sector','charge','mediator','coupling','running','singlet','mixing','mass','inventory','measurement','record','extension'];types=[x.capitalize() for x in fields]
for i,bits in enumerate(itertools.product([0,1],repeat=6)):
 if i < 56: continue
 m='SectorInventoryCensus'+str(i);s='import SFT.Physics.SectorInventoryGrammarBase\nnamespace SFT.Physics.SectorInventoryGrammar\nset_option maxRecDepth 20000\nset_option maxHeartbeats 20000000\n'
 for j,extra in enumerate(itertools.product([0,1],repeat=4)):
  cand='⟨'+','.join(['.admitted' if b else '.rejected' for b in bits+extra]+fields[10:])+'⟩';args=' '.join('('+f+' : '+t+')' for f,t in zip(fields[10:],types[10:]));cases=' <;> '.join('cases '+f for f in fields[10:])
  s+='theorem decisionCensus'+str(i)+'Part'+str(j)+' '+args+' : survives '+cand+' = criteriaDecision '+cand+' := by\n '+cases+'\n all_goals rfl\n'
  s+='theorem uniqueCensus'+str(i)+'Part'+str(j)+' '+args+' : criteriaDecision '+cand+' = true ↔ ('+cand+' : Candidate) = survivor := by\n '+cases+'\n all_goals constructor <;> intro h <;> first | rfl | cases h\n'
 cand='⟨'+','.join(['.admitted' if b else '.rejected' for b in bits]+fields[6:])+'⟩';args=' '.join('('+f+' : '+t+')' for f,t in zip(fields[6:],types[6:]))
 for prefix,ty in [('decision','survives '+cand+' = criteriaDecision '+cand),('unique','criteriaDecision '+cand+' = true ↔ ('+cand+' : Candidate) = survivor')]:
  s+='theorem '+prefix+'Census'+str(i)+' '+args+' : '+ty+' := by\n cases mixing <;> cases mass <;> cases inventory <;> cases measurement\n'+''.join(' · exact '+prefix+'Census'+str(i)+'Part'+str(j)+' '+' '.join(fields[10:])+'\n' for j in range(16))
 s+='end SFT.Physics.SectorInventoryGrammar\n';(r/(m+'.lean')).write_text(s)

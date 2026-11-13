from pathlib import Path
import itertools
r=Path('work/constants-recovery/SFT/Foundation');p=r/'AdmissionGrammar.lean';backup=Path('work/AdmissionGrammar857_unsplit.lean')
if not backup.exists():backup.write_text(p.read_text())
s=backup.read_text();a=s.rfind('set_option maxHeartbeats',0,s.index('theorem sourceDecisionMatchesCriteria'));b=s.index('theorem uniqueSurvivor');core=s[:a]+'end SFT.Foundation.AdmissionGrammar\n';(r/'AdmissionGrammarCore.lean').write_text(core)
fields=['registration','premises','census','forcing','closure','controls','validation','measurement','receipts','dependency','extra'];types=[x.capitalize() for x in fields];suffix=fields[5:];args=' '.join('('+f+' : '+t+')' for f,t in zip(suffix,types[5:]));passed=' '.join(suffix)
for i,bits in enumerate(itertools.product(['rejected','admitted'],repeat=5)):
 c='(⟨'+','.join(['.'+x for x in bits]+suffix)+'⟩ : Candidate)';cases=' <;> '.join('cases '+x for x in suffix)
 out='import SFT.Foundation.AdmissionGrammarCore\nnamespace SFT.Foundation.AdmissionGrammar\nset_option maxRecDepth 20000\nset_option maxHeartbeats 100000000\n'
 out+=f'theorem sourceDecisionBlock{i} {args} : survives {c} = criteriaDecision {c} := by\n {cases}\n all_goals rfl\n'
 out+=f'theorem uniqueCriteriaBlock{i} {args} : criteriaDecision {c} = true ↔ {c} = survivor := by\n {cases}\n all_goals constructor <;> intro h <;> first | rfl | cases h\n'
 out+='end SFT.Foundation.AdmissionGrammar\n';(r/f'AdmissionGrammarBlock{i}.lean').write_text(out)
def dispatch(depth,prefix,indent,label):
 if depth==5:
  i=sum((v=='admitted')*2**(4-j) for j,v in enumerate(prefix));return ' '*indent+'exact '+label+str(i)+' '+passed+'\n'
 out=' '*indent+'cases '+fields[depth]+' with\n'
 for choice in ['rejected','admitted']:out+=' '*indent+'| '+choice+' =>\n'+dispatch(depth+1,prefix+[choice],indent+2,label)
 return out
out=''.join(f'import SFT.Foundation.AdmissionGrammarBlock{i}\n' for i in range(32))+'namespace SFT.Foundation.AdmissionGrammar\nset_option maxRecDepth 20000\n'
for name,prop,label in [('sourceDecisionMatchesCriteria','survives c = criteriaDecision c','sourceDecisionBlock'),('uniqueCriteriaSurvivor','criteriaDecision c = true ↔ c = survivor','uniqueCriteriaBlock')]:
 out+=f'theorem {name} (c : Candidate) : {prop} := by\n cases c with\n | mk '+' '.join(fields)+' =>\n'+dispatch(0,[],3,label)+'\n'
out+=s[b:];p.write_text(out);print('Preserved all2048 alternatives in32 exhaustive64-case blocks')

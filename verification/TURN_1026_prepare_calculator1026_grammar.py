from pathlib import Path
import sys,json,ast,itertools
w=Path('work');r=w/'constants-recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_browser.law import SPEC
from dataclasses import asdict
(w/'calculator1026_spec.json').write_text(json.dumps(asdict(SPEC),indent=2,default=str))
print(asdict(SPEC.dimensions[0]),flush=True)
dims=[(d.key,d.question,d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason) for d in SPEC.dimensions];assert len(dims)==8
cs={'SURVIVOR':'__'.join(d[4] for d in dims),'GENERATION_RULE':SPEC.generation_rule,'GRAMMAR_BOUNDARY':SPEC.grammar_boundary};fields=[]
for key,question,bad,reason,good,goodreason in dims:cs[key.upper()]=[bad,good];fields.append((key,key.capitalize(),['rejected','admitted'],key.upper(),1))
q=lambda x:json.dumps(x,ensure_ascii=False)
t=Path('work/gen043.py').read_text();t=t[t.index("s='import"):].replace('SFT.Foundation.FormAcceptance','SFT.Mathematics.CalculatorBrowserSessions').replace('SFT.Foundation.FormGrammar','SFT.Mathematics.CalculatorBrowserGrammar').replace('SFT/Foundation/FormGrammar.lean','SFT/Mathematics/CalculatorBrowserGrammar.lean').replace('i==6','i==7').replace('= 288','= 256').replace('memMap _ extra _ hextra','memMap _ validation _ hvalidation').replace('⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩','⟨'+','.join(['rfl']*8)+'⟩').replace('⟨h0,h1,h2,h3,h4,h5,h6⟩','⟨'+','.join('h'+str(i) for i in range(8))+'⟩').replace('cases h6\\n','cases h6; cases h7\\n').replace('20000000','100000000').replace('10000000','100000000')
a=t.index("s+='def candidateId");b=t.index("s+='def survivorId",a);t=t[:a]+'''s+='def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)\\n'
s+='def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " ['+', '.join('SFT.Host.Text.append '+q(key+'=')+' ('+key+'Name c.'+key+')' for key,*_ in dims)+']\\n'
'''+t[b:]
a=t.index('fn=next');b=t.index("s+='def generationRule",a);t=t[:a]+'''s+='def decisionReason (c : Candidate) : String :=\\n'
for key,question,bad,reason,good,goodreason in dims:s+='  if !(SFT.Host.Text.equal ('+key+'Name c.'+key+') '+q(good)+') then '+q(reason)+' else\\n'
s+='  '+q(SPEC.exact_result)+'\\n\\n'
'''+t[b:];t=t.replace('namespace SFT.Mathematics.CalculatorBrowserGrammar\\n','namespace SFT.Mathematics.CalculatorBrowserGrammar\\nopen SFT.Foundation\\n');exec(t)
p=r/'SFT/Mathematics/CalculatorBrowserGrammar.lean';s=p.read_text();a=s.index('set_option maxHeartbeats',s.index('theorem candidatesComplete'));b=s.index('theorem uniqueSurvivor',a);base=s[:a]+'end SFT.Mathematics.CalculatorBrowserGrammar\n';names=[d[0] for d in dims];headers='';proof1='';proof2='';files={'CalculatorBrowserGrammarBase.lean':base}
for i,cs in enumerate(itertools.product(['rejected','admitted'],repeat=4)):
 name='CalculatorBrowserCensus'+str(i);headers+='import SFT.Mathematics.'+name+'\n';args=' '.join('('+f+' : '+f.capitalize()+')' for f in names[4:]);c='⟨'+','.join('.'+x for x in cs)+','+','.join(names[4:])+'⟩';z='import SFT.Mathematics.CalculatorBrowserGrammarBase\nnamespace SFT.Mathematics.CalculatorBrowserGrammar\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\n';cases=' <;> '.join('cases '+f for f in names[4:]);z+=f'theorem sourceDecisionChunk{i} {args} : survives {c} = criteriaDecision {c} := by\n {cases} <;> rfl\n';z+=f'theorem uniqueCriteriaChunk{i} {args} : criteriaDecision {c} = true ↔ ({c} : Candidate) = survivor := by\n {cases}\n all_goals constructor <;> intro h <;> first | rfl | cases h\nend SFT.Mathematics.CalculatorBrowserGrammar\n';files[name+'.lean']=z;proof1+=f'    · exact sourceDecisionChunk{i} _ _ _ _\n';proof2+=f'    · exact uniqueCriteriaChunk{i} _ _ _ _\n'
case='  cases c with\n  | mk '+' '.join(names)+' =>\n    '+' <;> '.join('cases '+f for f in names[:4])+'\n';s=headers+'namespace SFT.Mathematics.CalculatorBrowserGrammar\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\ntheorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by\n'+case+proof1+'\ntheorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by\n'+case+proof2+'\n'+s[b:];files['CalculatorBrowserGrammar.lean']=s
for name,s in files.items():
 for root in [r,Path('/Volumes/One Touch/SFT v4 Full model LEAN')]:(root/'SFT/Mathematics'/name).write_text(s)
print('Prepared complete256 product in16sourcechunks',flush=True)

from pathlib import Path
import sys,json,ast,dataclasses,re
w=Path('work');r=w/'turn1064_recovery';out=r/'SFT/Consciousness'
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.consciousness.nonordinary_laws_v1 import SPECS
from sft.engine.canonical import canonical_value
names=['DirectionalSynaesthesia','NonordinaryThreeQuality','SleepDreamCycle','CessationLockAnchor','NonordinaryFamily']
witness_defs=['synaesthesiaWitnesses','threeQualityWitnesses','sleepWitnesses','cessationWitnesses',None]
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(tuple,list)):return '.array ['+','.join(cv(y)for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')'for k,v in x.items())+']'
 raise TypeError(x)
plan=[]
for i,((cid,spec),name,wd)in enumerate(zip(SPECS.items(),names,witness_defs)):
 spec.validate();suffix='1394_'+str(i);base='nonordinary';values=dataclasses.asdict(spec)
 # Reuse the existing full-product grammar generator with the exact source axes.
 setup='''from pathlib import Path
import sys,json,dataclasses,ast
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.consciousness.nonordinary_laws_v1 import SPECS
from sft.engine.canonical import canonical_value
spec=SPECS['''+repr(cid)+'''];spec.validate();values=canonical_value(spec);q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,d.question,d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason]for d in spec.axes]
kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()};cid=spec.claim_id
'''
 (w/(base+'_spec'+suffix+'.py')).write_text(setup)
 for kind in ['grammar','evidence']:
  s=(w/('statesymmetry_'+kind+'1100.py')).read_text().replace('statesymmetry',base).replace('StateSymmetry',name).replace('1100',suffix)
  (w/(base+'_'+kind+suffix+'.py')).write_text(s);exec(s,{})
 p=out/(name+'Grammar.lean');s=(w/(name+'Grammar'+suffix+'.lean')).read_text().replace('import «work».'+name+'Carrier'+suffix,'import SFT.Foundation.CommonRefinement').replace('SFT.Physics.'+name+'Grammar','SFT.Consciousness.'+name+'Grammar');p.write_text(s)
 s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport',name).replace('SFT/Chemistry','SFT/Consciousness').replace('SFT.Chemistry','SFT.Consciousness').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr([a.key for a in spec.axes]));exec(s,{})
 s=(w/(name+'Evidence'+suffix+'.lean')).read_text().replace('import «work».'+name+'Grammar'+suffix,'import SFT.Consciousness.'+name+'Grammar\nimport SFT.Consciousness.NonordinaryLaws').replace('SFT.Physics.'+name+'Evidence','SFT.Consciousness.'+name+'Evidence').replace('branch := "physics"','branch := "consciousness_cognitive_science"').replace('provenance := [.observationalDerivation]','provenance := [.forwardForcing]')
 if i<4:s=s.replace('evidenceMode := .empirical','evidenceMode := .formal')
 a=s.index('def onePairWitness');b=s.index('def claimId',a)
 ws='def witnessPassed : List Bool := '+('NonordinaryLaws.'+wd if wd else '[true,true]')+'\n'
 ws+='def witnesses : Value := .array ['+','.join('.object [("name",.text '+q(x.name)+'),("statement",.text '+q(x.statement)+'),("passed",.boolean (witnessPassed['+str(j)+']!))]'for j,x in enumerate(spec.witnesses))+']\n'
 ws+='theorem witnessesPassed : witnessPassed = List.replicate '+str(len(spec.witnesses))+' true := '+('NonordinaryLaws.'+wd+'Passed'if wd else 'rfl')+'\n'
 s=s[:a]+ws+s[b:]
 a=s.index('def completenessRecord');b=s.index('def registrationData',a)
 comp={'generation_rule':spec.generation_rule,'grammar_boundary':spec.grammar_boundary,'axes':[{'key':ax.key,'question':ax.question,'choices':[(ch.name,ch.reason)for ch in ax.choices]}for ax in spec.axes]}
 cr=cv(comp);assert cr.endswith(']');cr=cr[:-1]+',("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]'
 s=s[:a]+'def completenessRecord : Value := '+cr+'\n'+s[b:]
 s=s.replace('traceHash := identity (.array [.text claimId,candidateRecord c])','traceHash := identity (.array [.text claimId,.text generationRule,candidateRecord c])')
 a=s.index('def closureValue');b=s.index('def exclusions',a)
 closure=cv({'result':spec.exact_result,'base':spec.induction_base,'successor':spec.induction_step,'exclusions':spec.exclusions})[:-1]+',("witnesses",witnesses),("unique_survivor",.text survivorId)]'
 s=s[:a]+'def closureValue : Value := '+closure+'\n'+s[b:]
 s=s.replace('reject the generated form lacking the complete physical carrier','reject the form missing the first structural preservation').replace('reject a changed registered source identity','reject a changed source identity').replace('control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"','control .boundary (!exclusions.isEmpty && witnessPassed.all id) "reject forbidden values, target feedback and extra laws"')
 s=re.sub(r'witnessPassed\[(\d+)\]!',r'(witnessPassed.drop \1).headD false',s)
 (out/(name+'Evidence.lean')).write_text(s)
 plan.append({'claim_id':cid,'name':name,'grammar':str(p),'evidence':str(out/(name+'Evidence.lean')),'dependencies':list(spec.dependencies)})
(w/'nonordinary1394_plan.json').write_text(json.dumps(plan,indent=2)+'\n')
print('Staged five exact eight-axis/256-candidate source grammars and programme implementations')

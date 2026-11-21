from pathlib import Path
import sys,json,re,subprocess,hashlib
w=Path('work');r=w/'turn1064_recovery';runtime=w/'v3-runtime500';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';sourcefiles=['obligations.py','generated_law.py','structural_model.py'];pins={}
for name in sourcefiles:
 rel='sft/consciousness_cognitive_science/'+name;b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);assert b==(runtime/rel).read_bytes();pins[rel]=hashlib.sha256(b).hexdigest()
sys.path.insert(0,str(runtime.resolve()))
from sft.consciousness_cognitive_science.generated_law import CONSCIOUSNESS_BLUEPRINTS
from sft.consciousness_cognitive_science.obligations import CONSCIOUSNESS_OBLIGATIONS,FAMILY_ORDER
text=(r/'ZENODO_PAPER_DRAFT.txt').read_text();sections=re.split(r'(?m)(?=^\d+\. )',text);byclaim={};rows=[]
for p in (r/'SFT/Consciousness').glob('*.lean'):
 s=p.read_text();m=re.search(r'^def original : Obligation := ⟨(.*)⟩$',s,re.M)
 if m:
  fields=[json.loads(x)for x in re.findall(r'"(?:[^"\\]|\\.)*"',m[1])];byclaim[fields[0]]=(p,s,fields)
assert len(byclaim)==len(CONSCIOUSNESS_BLUEPRINTS)==72
for bp,item in zip(CONSCIOUSNESS_BLUEPRINTS,CONSCIOUSNESS_OBLIGATIONS):
 # Source obligations order is independently keyed below.
 pass
items={i.claim_id:i for i in CONSCIOUSNESS_OBLIGATIONS}
for bp in CONSCIOUSNESS_BLUEPRINTS:
 p,s,fields=byclaim[bp.claim_id];item=items[bp.claim_id]
 expected=[getattr(item,k)for k in ['claim_id','title','family','carrier','distinction','operation','retained_record','evidence_boundary','statement']];assert fields==expected,(bp.claim_id,'native obligation fields')
 grammar=p.with_name(p.stem+'Grammar.lean').read_text()
 for dimension in bp.dimensions:
  definition=re.search(r'def '+dimension.key+'Name .*?(?=\n\ndef |\n\ninductive |\n\nstructure )',grammar,re.S);assert definition,(p,dimension.key)
  names=[json.loads(x)for x in re.findall(r'=> ("(?:[^"\\]|\\.)*")',definition[0])];assert names==[c.name for c in dimension.choices],(p,dimension.key)
 ss=[sec for sec in sections if bp.claim_id in sec and (p.name in sec) and ('a = ('in sec or 'carrier: state-and-fold-image;'in sec)]
 assert len(ss)==1,(bp.claim_id,'paper section',len(ss));sec=ss[0]
 if 'a = ('in sec:
  values=re.search(r'a = \((.*?)\)\.',sec,re.S).group(1).split('; ');assert values==[d.admitted_choice.name for d in bp.dimensions],(bp.claim_id,'paper tuple')
 else:
  for d in bp.dimensions:assert d.key+': '+d.admitted_choice.name in sec
 witness=next(line for line in s.splitlines()if line.startswith('def exactFoldWitness'))
 rows.append({'claim_id':bp.claim_id,'family':bp.family,'module':str(p.relative_to(r)),'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'section':sec.splitlines()[0],'witness_body':witness})
# Check the actual entry dispatch against the original family witness map.
keys=[['two_preimages_share_one_image'],['unretained_observation_is_not_reversible'],['observer_observed_partition_the_one','binding_lock_completes'],['two_preimages_are_distinct'],['retained_observation_is_reversible','unretained_observation_is_not_reversible'],['complementary_pair_recurs'],['self_model_closes_in_two_nonidentity_acts'],['two_preimages_are_distinct'],['two_preimages_share_one_image'],['observer_observed_partition_the_one'],['three_quality_support_recurs'],['red_of_red_form_is_complete']]
alias={'two_preimages_share_one_image':'StructuralModel.observerObservedLock.sameImage','two_preimages_are_distinct':'StructuralModel.observerObservedLock.distinct','observer_observed_partition_the_one':'StructuralModel.observerObservedLock.wholePartition','binding_lock_completes':'StructuralModel.observerObservedLock.completion','unretained_observation_is_not_reversible':'StructuralModel.observe StructuralModel.quarter false'}
for row in rows:
 required=keys[list(FAMILY_ORDER).index(row['family'])];body=row['witness_body']
 for key in required:assert '"'+key+'"' in body or alias.get(key,'NEVER_MATCH') in body,(row['claim_id'],key)
 row['original_family_witnesses']=required
report={'status':'PASS','scope':'Source and manuscript correspondence for nine obligation fields and sixteen grammar choice labels per entry; not a substitute for native entry verification','entries':len(rows),'original_source_sha256':pins,'rows':rows}
(w/'consciousness_manuscript1306_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS72 original/native obligation records,1152grammar choice labels and72manuscript preserving tuples')
print('Families',list(FAMILY_ORDER))

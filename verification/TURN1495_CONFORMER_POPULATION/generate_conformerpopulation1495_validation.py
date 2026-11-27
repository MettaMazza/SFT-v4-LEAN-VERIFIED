from pathlib import Path
import sys,json,re,ast
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry';pin=w/'pinned_conformerpopulation1495';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__.insert(0,str((pin/'sft/chemistry').resolve()))
from sft.chemistry import conformer_population_ordering_validation_v1 as v
spec=v.CONFORMER_POPULATION_ORDERING_SPEC
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer '+str(x)
 if isinstance(x,(tuple,list)):return '.array ['+','.join(map(cv,x))+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(val)+')' for k,val in x.items())+']'
 raise TypeError(type(x))
s=(r/'ConformerExperiment.lean').read_text().replace('ConformerGenerationEvidence','ConformerPopulationEvidence').replace('ConformerExperiment','ConformerPopulationExperiment').replace('ConformerPrediction','ConformerPopulationPrediction').replace('import SFT.Chemistry.ConformerCensus','import SFT.Chemistry.ConformerPopulationWitnesses')
rows=json.loads((pin/v.TARGET_PATH).read_text())['rows']
sourceFiles=list(dict.fromkeys([(v.TARGET_PATH,v.TARGET_HASH),(v.PRIMARY_PATH,v.PRIMARY_HASH)]+[(x['opened_snapshot_path'],x['opened_snapshot_sha256'])for x in rows]))
values={'claimId':q(spec.claim_id),'experimentId':q(spec.experiment_id),'expectedLabel':q(spec.expected_observation_label),'falsification':q(spec.falsification_condition),'targetRegistryHash':q(v.TARGET_HASH),'sourceFiles':'['+','.join('('+q(p)+','+q(h)+')'for p,h in sourceFiles)+']','references':'['+','.join('⟨'+','.join(q(getattr(row,k))for k in ['target_id','source_id','source_locator','snapshot_path','snapshot_hash'])+'⟩'for row in spec.target_rows)+']','specDimensions':'['+','.join('('+q(d.key)+',['+','.join(str(c.admitted).lower()for c in d.choices)+'])'for d in spec.dimensions)+']','specWitnesses':'['+','.join('ConformerPopulationWitnesses.'+x for x in ['populationWitness','censusWitness','energyWitness','orderWitness','successorWitness','reverseTakeWitness','foreignWitness'])+']'}
for key,val in values.items():s=re.sub(r'^def '+key+r' (.*?) := .*$',lambda m:'def '+key+' '+m[1]+' := '+val,s,flags=re.M)
reg=v.experiment_registration_record(pin);line='def registration (program : Value) : Value := .object ['+','.join('('+q(k)+','+('program'if k=='prediction_program'else cv(val))+')'for k,val in reg.items())+']'
s=re.sub(r'^def registration .*$',lambda _:line,s,flags=re.M);(r/'ConformerPopulationExperiment.lean').write_text(s)
s=(r/'ConformerValidation.lean').read_text()
for name in ['Experiment','Comparison','Validation','Prediction','Source','Analysis']:s=s.replace('Conformer'+name,'ConformerPopulation'+name)
s=s.replace('ORG-005','ORG-006').replace('exact-conformer-generation-equivalence/1','exact-conditioned-conformer-population-ordering/1').replace('-development-observed-target-custodian','-target-custodian').replace('experiments/external_sources/chemistry/org_005_withheld_targets_v1.json',v.TARGET_PATH).replace('experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/org-005-primary-records-v1.json',v.PRIMARY_PATH)
# Literal measurement messages are taken from the original syntax tree, not rewritten prose.
tree=ast.parse((pin/'sft/chemistry/conformer_population_ordering_validation_v1.py').read_text())
assignment=next(n for n in ast.walk(tree)if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='measurements'for t in n.targets))
messages=assignment.value.left.elts
assert len(messages)==8
assert all(isinstance(n,ast.Constant)for n in messages[:7])
a=s.index(' let rowMessages :=');b=s.index(' let sourceIds',a)
s=s[:a]+' let rowMessages := [\n'+',\n'.join('  '+q(n.value)for n in messages[:7])+',\n  Text.append "complete exact target vector " vectorHash]\n'+s[b:]
(r/'ConformerPopulationValidation.lean').write_text(s)
s=(w/'build_conformerpopulation1495_witnesses.py').read_text().replace("['ConformerPopulationWitnesses']","['ConformerPopulationExperiment','ConformerPopulationValidation']").replace('ConformerPopulationWitnessesAudit1495','ConformerPopulationValidationAudit1495').replace('population_witnesses_audit','population_validation_audit');(w/'build_conformerpopulation1495_validation.py').write_text(s)
print('Generated original registration and full validation with original 20 messages')

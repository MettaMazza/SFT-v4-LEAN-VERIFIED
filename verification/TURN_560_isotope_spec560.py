from pathlib import Path
import ast,json,subprocess,dataclasses
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def raw(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
namespace={'dataclass':dataclasses.dataclass}
for source,names in [('sft/physics/generated_empirical_law.py',{'LawChoice','LawDimension','dimension'}),('sft/chemistry/generated_law.py',{'ChemistryTargetReference','EmpiricalChemistrySpec'})]:
 tree=ast.parse(raw(source));nodes=[n for n in tree.body if getattr(n,'name',None) in names];exec(compile(ast.Module(body=nodes,type_ignores=[]),source,'exec'),namespace)
namespace['SOURCES']={x['source_id']:x for x in json.loads(raw('experiments/external_sources/chemistry/authoritative_sources.json'))['sources']}
source='sft/chemistry/elements_periodicity_batch_1.py';tree=ast.parse(raw(source));names={'SOURCE_RECORDS','OBSERVATION_REGISTRY_PATH','BASE_DEPENDENCIES','_target','_exclusions','ISOTOPE_BOUNDARY','ISOTOPE_DIMENSIONS','ELEMENTS_PERIODICITY_BATCH_1_SPECS'};nodes=[]
for n in tree.body:
 if getattr(n,'name',None) in names or isinstance(n,ast.Assign) and getattr(n.targets[0],'id',None) in names:
  if isinstance(n,ast.Assign) and n.targets[0].id=='ELEMENTS_PERIODICITY_BATCH_1_SPECS':n.value.elts=n.value.elts[2:3]
  nodes.append(n)
exec(compile(ast.Module(body=nodes,type_ignores=[]),source,'exec'),namespace)
spec=namespace['ELEMENTS_PERIODICITY_BATCH_1_SPECS'][0];spec.validate();values=dataclasses.asdict(spec);cid=spec.claim_id;q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason] for d in spec.dimensions];kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}

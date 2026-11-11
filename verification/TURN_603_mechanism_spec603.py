from pathlib import Path
import ast,json,dataclasses
from affinity_spec587 import raw,namespace as redox_namespace
namespace=dict(redox_namespace)
source='sft/chemistry/reaction_kinetics_derivation.py';tree=ast.parse(raw(source));nodes=[n for n in tree.body if not isinstance(n,(ast.Import,ast.ImportFrom)) or isinstance(n,ast.ImportFrom) and n.module=='__future__'];exec(compile(ast.Module(body=nodes,type_ignores=[]),source,'exec'),namespace)
source='sft/chemistry/reaction_kinetics_batch_1.py';tree=ast.parse(raw(source));names={'DERIVATION_PATH','DERIVATION_HASH','PRE_SOURCE_SEAL_PATH','PRE_SOURCE_PAYLOAD_HASH','OBSERVATION_REGISTRY_PATH','SOURCE_RECORDS','_bind'};nodes=[n for n in tree.body if getattr(n,'name',None) in names or isinstance(n,ast.Assign) and getattr(n.targets[0],'id',None) in names];exec(compile(ast.Module(body=nodes,type_ignores=[]),source,'exec'),namespace)
spec=namespace['_bind'](namespace['REACTION_KINETICS_BLUEPRINTS'][1]);spec.validate();values=dataclasses.asdict(spec);cid=spec.claim_id;q=lambda x:json.dumps(x,ensure_ascii=False);pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason] for d in spec.dimensions];kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}

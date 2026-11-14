from pathlib import Path
import ast,subprocess,json,dataclasses,sys,types,itertools,math
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';v3='/Volumes/One Touch/ernos-labs-sft-platform'
def source(p):return subprocess.check_output(['git','-C',v3,'show',pin+':'+p],text=True)
m=types.ModuleType('original_unbounded867');sys.modules[m.__name__]=m;ns=m.__dict__;ns.update(dataclass=dataclasses.dataclass,product=itertools.product,combinations=itertools.combinations,Sequence=list)
generated=ast.parse(source('sft/quantum_computation/generated_law.py'));selected=[n for n in generated.body if isinstance(n,(ast.ClassDef,ast.FunctionDef)) and n.name in ['Choice','Dimension','Witness','LawSpec','binary_dimension','candidate_records','survivor_id','decision_reason','completeness_record','closure_record']];exec(compile(ast.Module(body=selected,type_ignores=[]),'pinned-generated-quantum.py','exec'),ns)
tree=ast.parse(source('sft/quantum_computation/lineage_laws.py'));selected=[n for n in tree.body if isinstance(n,(ast.FunctionDef,ast.Assign))];exec(compile(ast.Module(body=selected,type_ignores=[]),'pinned-quantum-lineage.py','exec',flags=__import__('__future__').annotations.compiler_flag),ns)
spec=ns['UNBOUNDED_FAULT_TOLERANCE'];spec.validate();values=dataclasses.asdict(spec);closure=None;completeness=ns['completeness_record'](spec);q=lambda x:json.dumps(x,ensure_ascii=False)

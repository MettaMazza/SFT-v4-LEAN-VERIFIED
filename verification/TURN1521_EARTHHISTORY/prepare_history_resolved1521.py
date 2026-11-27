from pathlib import Path
import ast,copy,json,sys,hashlib,platform
from types import SimpleNamespace
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.earth_environment import empirical_program as e
from sft.engine.canonical import canonical_value
source=Path(e.__file__);tree=ast.parse(source.read_text());cls=next(x for x in tree.body if isinstance(x,ast.ClassDef) and x.name=='BlindEarthBoundaryValidator');method=next(x for x in cls.body if isinstance(x,ast.FunctionDef) and x.name=='validate')
# Unit-test the exact original continuation, supplying the outputs of separately
# checked source admission. This is NOT an end-to-end empirical validation.
body=copy.deepcopy(method.body[4:]);removed=[];kept=[]
for node in body:
 text=ast.unparse(node)
 if text.startswith('before = snapshot_protected_tree(') or text.startswith('after = snapshot_protected_tree(') or (isinstance(node,ast.Assign) and isinstance(node.value,ast.Call) and isinstance(node.value.func,ast.Name) and node.value.func.id=='validate_external_evidence'):removed.append(text)
 else:kept.append(node)
assert len(removed)==3
fn=ast.FunctionDef(name='resolved_original',args=ast.arguments(posonlyargs=[],args=[ast.arg(arg=n)for n in ['self','sealed','row','extraction_hash','registration','audit','before','after']],vararg=None,kwonlyargs=[],kw_defaults=[],kwarg=None,defaults=[]),body=kept,decorator_list=[])
module=ast.fix_missing_locations(ast.Module(body=[fn],type_ignores=[]));scope=dict(vars(e));exec(compile(module,str(source)+':resolved-test','exec'),scope)
d=json.loads((w/'earth1448_source_inputs.json').read_text())[0];spec=next(x for x in e.EARTH_SPECS if x.claim_id=='SFT-EARTH-EARTH-HISTORY-001');row=next(x for x in d['targets']['targets']if x['claim_id']==spec.claim_id);registration=json.loads((w/'earthhistory1465_registration_constructor.json').read_text());extraction=registration['target_row_hash'];root=w/'v3-runtime500';snapshot=e.snapshot_protected_tree(root);seal='native-earthhistory1465'
expected=canonical_value(scope['resolved_original'](SimpleNamespace(spec=spec,root=root),SimpleNamespace(seal_hash=seal),row,extraction,registration,d['audit'],snapshot,snapshot))
(w/'history_resolved1521_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
(w/'history_resolved1521_input.json').write_text(json.dumps({'row':row,'audit':d['audit'],'registration':registration,'extraction':extraction,'derivation':seal,'host':platform.system(),'implementation':platform.python_implementation(),'before':canonical_value(snapshot),'after':canonical_value(snapshot)},indent=2)+'\n')
(w/'history_resolved1521_source_slice.json').write_text(json.dumps({'scope':'Conditional original continuation only; full original source guard remains unchanged and rejects retained snapshot','source':str(source),'sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'method_start':method.lineno,'supplied_prefix':[ast.unparse(n)for n in method.body[:4]],'supplied_io':removed,'retained_ast':ast.dump(module,include_attributes=False),'fields':len(expected)},indent=2)+'\n')
print('Prepared original conditional continuation',len(expected),'fields')

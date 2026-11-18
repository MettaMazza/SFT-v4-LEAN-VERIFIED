from pathlib import Path
import ast,json,types,sys,copy,hashlib,csv
root=Path(__file__).resolve().parents[1];dest=root;dest.mkdir(parents=True,exist_ok=True)
source=root/'v3';record=json.loads((source/'census/physics_grand_lock_input_v1.json').read_text());emp=json.loads((source/'experiments/external_sources/physics/snapshots/physics-grand-lock-empirical-reconciliation-record.json').read_text())
assert hashlib.sha256((source/'census/physics_grand_lock_input_v1.json').read_bytes()).hexdigest()=='325248e4081b287fbacd125efe18a9d5fbba05f1fbd459eaa2a61a225120b3ca'
assert hashlib.sha256((source/'experiments/external_sources/physics/snapshots/physics-grand-lock-empirical-reconciliation-record.json').read_bytes()).hexdigest()=='e233cd761aa874893d2c2a4e2b09f071297aee1204d531fce3d93429948177a3'
ns={'FOUNDATIONAL_ROOT':'SFT-FOUNDATION-ONE-001','frozen_input':lambda:record}
for rel,names in [('sft/physics/grand_lock_terminal_law_v1.py',{'dependency_certificate','cross_domain_identity_graph'}),('sft/physics/grand_lock_empirical_v1.py',{'record_certificate'})]:
 tree=ast.parse((source/rel).read_text());tree.body=[n for n in tree.body if getattr(n,'name',None) in names or isinstance(n,ast.ImportFrom) and n.module=='__future__'];exec(compile(tree,rel,'exec'),ns)
dep=ns['dependency_certificate']();assert list(dep.values())==[347,534,True,True,True,True,234,14]
rows={r['claim_id']:r for r in record['dependency_dictionary']};reached=set();links=0
for cid in record['physics_claim_ids']:
 todo=[cid];seen=set()
 while todo:
  x=todo.pop()
  if x in seen:continue
  seen.add(x);todo.extend(rows[x]['dependencies'])
 assert 'SFT-FOUNDATION-ONE-001' in seen;reached.update(seen)
assert len(reached)==534
for r in rows.values():links+=len(r['dependencies'])
cert=ns['record_certificate'];assert all(cert(emp).values())
variants={}
for name in ['missing_row','missing_adverse','false_legacy','selector']:
 x=copy.deepcopy(emp)
 if name=='missing_row':x['empirical_claims']=x['empirical_claims'][1:]
 elif name=='missing_adverse':x['unfavorable_or_scope_boundary_ids']=x['unfavorable_or_scope_boundary_ids'][1:]
 elif name=='false_legacy':x['legacy_empirical_materialization_without_separate_measurement_receipt']=[]
 else:x['methodological_boundary']['measurements_select_formal_survivor']=True
 variants[name]=list(cert(x).values())
assert variants=={'missing_row':[False,True,True,True,True,True,True,True],'missing_adverse':[True,True,True,True,False,True,True,True],'false_legacy':[True,True,False,False,True,True,True,True],'selector':[True,True,True,True,True,True,False,True]}
all_sources=sorted(set(s for r in emp['empirical_claims'] for s in r['external_data_source_ids']));assert set(all_sources)==set(emp['unique_external_source_ids']);assert len(all_sources)==147
emp_rows={r['claim_id']:r for r in emp['empirical_claims']};physics={r['claim_id']:r for r in record['physics_claims']}
for label,ids in [('adverse',emp['unfavorable_or_scope_boundary_ids']),('legacy',emp['legacy_empirical_materialization_without_separate_measurement_receipt'])]:
 (dest/(label+'_inventory.json')).write_text(json.dumps([physics[x] for x in ids],indent=2)+'\n')
(dest/'external_source_inventory.json').write_text(json.dumps([{'source_id':s,'claims':[r['claim_id'] for r in emp['empirical_claims'] if s in r['external_data_source_ids']]} for s in all_sources],indent=2)+'\n')
(dest/'dependency_inventory.json').write_text(json.dumps(record['dependency_dictionary'],indent=2)+'\n');(dest/'empirical_inventory.json').write_text(json.dumps(emp['empirical_claims'],indent=2)+'\n')
out={'status':'PASS','physics_claims':len(physics),'dependency_nodes':len(reached),'dependency_links':links,'empirical_rows':len(emp_rows),'source_ids':len(all_sources),'legacy_rows':6,'adverse_rows':14,'dependency_certificate':dep,'empirical_certificate':cert(emp),'mutation_certificates':variants,'all_roots_reachable':True,'frozen_source_hashes_match':True,'new_lean_builds':0};(dest/'arithmetic_check.json').write_text(json.dumps(out,indent=2)+'\n');print({k:v for k,v in out.items() if k not in ['dependency_certificate','empirical_certificate','mutation_certificates']})
from fractions import Fraction
ns.update(Fraction=Fraction,ONE=Fraction(1))
tree=ast.parse((source/'sft/physics/grand_lock_terminal_law_v1.py').read_text());tree.body=[n for n in tree.body if getattr(n,'name',None) in {'least_binary_cover','positive_take','generator_value_vector'} or isinstance(n,ast.ImportFrom) and n.module=='__future__'];exec(compile(tree,'grand_lock_terminal_law_v1.py','exec'),ns)
a=ns['generator_value_vector'](3);b=ns['generator_value_vector'](4);assert len(a)==len(b)==21 and list(a)==list(b) and all(a[k]!=b[k] for k in a);assert a['inverse_fine_structure_terminal']==Fraction(503846395469,3676744786)
(dest/'headline_vectors.json').write_text(json.dumps({'3':{k:str(v) for k,v in a.items()},'4':{k:str(v) for k,v in b.items()}},indent=2)+'\n');out['generator_fields']=21;out['all_21_fields_change']=True;(dest/'arithmetic_check.json').write_text(json.dumps(out,indent=2)+'\n');print('PASS original generator vectors3/4 and all21changed fields')

from pathlib import Path
from dataclasses import dataclass
from itertools import product
import ast,json,hashlib,re
root=Path(__file__).resolve().parents[1];dest=root
g={'dataclass':dataclass,'product':product,'__name__':'__main__'}
def load(n,selected=None):
 tree=ast.parse((root/'v3'/n).read_text());nodes=[x for x in tree.body if not isinstance(x,(ast.Import,ast.ImportFrom)) and (selected is None or getattr(x,'name',None) in selected)]
 exec(compile(ast.Module(body=nodes,type_ignores=[]),n,'exec'),g)
load('sft/physics/generated_empirical_law.py',{'LawChoice','LawDimension','dimension'})
load('sft/biology/obligations.py');load('sft/biology/structural_counts.py');load('sft/biology/derivation.py')
entries=json.loads((root/'entry_index.json').read_text());checks=[]
for e in entries:
 bp=g['BLUEPRINT_BY_CLAIM'][e['claim_id']];forms=g['candidate_forms'](bp);admitted=g['unique_survivor'](bp)
 independent=tuple(tuple(d.choices[(k>>(7-i))&1].name for i,d in enumerate(bp.dimensions)) for k in range(256))
 assert forms==independent and len(set(forms))==256
 decisions=[all(c==d.admitted_choice.name for c,d in zip(f,bp.dimensions)) for f in forms]
 assert sum(decisions)==1 and forms[decisions.index(True)]==admitted
 assert '__'.join(admitted)==e['v3_registration']['candidate_grammar']['unique_survivor']
 assert list(bp.dependencies)==e['v3_registration']['dependencies'] and bp.statement==e['statement']
 assert all(w[2] for w in bp.operational_witnesses)
 reasons=[next((i for i,(c,d) in enumerate(zip(f,bp.dimensions)) if c!=d.admitted_choice.name),None) for f in forms]
 assert [reasons.count(i) for i in range(8)]==[128,64,32,16,8,4,2,1]
 checks.append({'claim_id':e['claim_id'],'forms':len(forms),'survivor':admitted,'first_failure_counts':[reasons.count(i) for i in range(8)],'dependencies':len(bp.dependencies),'witnesses':bp.operational_witnesses})
assert len(g['BIOLOGY_BLUEPRINTS'])==75 and sum(len(g['candidate_forms'](b)) for b in g['BIOLOGY_BLUEPRINTS'])==19200
reports=['TURN_1114_lifeorganization1110_empirical_report.json','TURN_1124_lifeboundary1120_empirical_report.json','TURN_1140_autocatalytic1137_empirical_report.json','TURN_1145_maintenance1144_empirical_report.json'];retained=[]
for n in reports:
 f=root/'v4/verification'/n;d=json.loads(f.read_text());assert d['status']=='PASS' and d['fields']==12 and d['messages']==4 and d.get('all_fields_and_hashes_match',d.get('all_fields_and_hashes',False));retained.append({'file':str(f.relative_to(root)),'sha256':hashlib.sha256(f.read_bytes()).hexdigest(),'fields':12,'messages':4})
r={'status':'PASS','method':'Unchanged pinned V3 class/function bodies; all four exact ordered Cartesian products against independent binary indexing, all decisions, source survivor/dependency/statement identity, all twelve witnesses, complete75claim19200form count; retained full empirical reports inspected. No new native runs.','entries':checks,'retained_empirical_reports':retained,'source_sha256':{str(p.relative_to(root/'v3')):hashlib.sha256(p.read_bytes()).hexdigest() for p in (root/'v3').rglob('*') if p.is_file() and not p.name.startswith('._')}}
dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(r,indent=2)+'\n');print('PASS 1024 exact candidate decisions; four unique survivors; retained 12field comparisons')

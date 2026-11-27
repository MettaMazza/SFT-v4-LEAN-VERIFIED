from pathlib import Path
import json,re,hashlib,datetime,fcntl
w=Path('work');r=w/'turn1064_recovery';cid='SFT-CHEM-ELIMINATION-REACTION-FAMILY-010';now=datetime.datetime.now(datetime.timezone.utc).isoformat();H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
reports=['elimination1503_full_audit_report.json','elimination1503_program_report.json','elimination1503_validation_report.json','elimination1503_graphs_build_report.json','elimination1503_results_build_report.json','elimination1503_analysis_report.json']
for f in reports:assert json.load(open(w/f))['status']=='PASS',f
audit=json.load(open(w/reports[0]));names=audit['declarations']
for rel,h in audit['source_sha256'].items():assert H(r/rel)==h
assert json.load(open(w/'elimination1503_validation_output.json'))==json.load(open(w/'elimination1503_original_empirical.json'))
assert json.load(open(w/'elimination1503_validation_output.json'))['passed']
assert json.load(open(w/'elimination1503_analysis_output.json'))==json.load(open(w/'elimination1503_analysis_expected.json'))
lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
c=json.load(open(r/'COVERAGE.json'));by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status']!='complete';assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();assert old['fully_reconstructed_claims']==1054
law='sft/chemistry/elimination_reaction_law_v1.py';val='sft/chemistry/elimination_reaction_validation_v1.py';batch='sft/chemistry/elimination_reaction_batch_v1.py'
scopeText={
'Elimination':'Exact original ten-field inverse-addition transform with retained ordered atom/support guard, unchanged-product/source successor, original generated witnesses and all original constructor guards.',
'EliminationWitnessProofs':'Kernel equalities for three original inverse results, successor, invalid inverse and complete eight operational witnesses, all empty axioms.',
'EliminationGrammar':'Complete original eight-axis256alternative grammar, exhaustive census and unique preserving survivor.',
'EliminationEvidence':'Original registration,256decisions, eight computed witnesses, closure, four controls and unknown-ID behavior.',
'EliminationAnalysis':'Full original12-field analysis and47target checks:22archive files,117page vector,32ordered products/5unsuccessfulrows/7optimizationtables/6timepoints, exact hashes,32unresolved complete-carrier records and source guards.',
'EliminationSource':'All eleven original authority hashes, preseal payload/order flags and32/5/7complete external row boundary.',
'EliminationExperiment':'Original47source/target references,eightdimensions,eightwitnesses,capabilityclosed prediction,envelope andregistration.',
'EliminationValidation':'Full original sealed capability/audit/custody/release/comparison, omission/tampered-label controls and12-field seven-message empirical report.'}
scopes={}
for rel in audit['source_sha256']:
 m=Path(rel).stem
 if '/EliminationWitnessGraphs/'in rel:source,scope=law,'Exact original '+m+' finite graph execution: every reachability transition, complete component filter/fold and original ordering; source graphs also prove both actual attachment distances.'
 elif '/EliminationAdditionResults/'in rel:source,scope=law,'Kernel equality of the original elimination-specific inverse-addition '+m+' complete ten-field transform result, using the source-bound component and separation proofs.'
 else:source=(batch if m in ['EliminationGrammar','EliminationEvidence']else val if m in ['EliminationAnalysis','EliminationSource','EliminationExperiment','EliminationValidation']else 'sft/chemistry/addition_reaction_law_v1.py'if m=='EliminationCarrier'else law);scope=scopeText[m]
 scopes[rel]=(source,scope)
receipt='verification/TURN1503_ELIMINATION_COMPLETION.json';corr=json.load(open(r/'reference/CORRESPONDENCE.json'));corr['modules']=[z for z in corr['modules']if z.get('v3_claim')!=cid];oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[]
for rel,(source,scope)in scopes.items():
 s=(r/rel).read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1];ths=[ns+'.'+n for n in re.findall(r'^theorem (\w+)',s,re.M)];assert all(n in names for n in ths);newNames +=[n for n in ths if n not in oldNames]
 corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=source,lean_source_sha256=H(r/rel),domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in(r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
record=dict(status='complete',claim_id=cid,registered_at=now,source_commit=c['source_commit'],lean_source_sha256=audit['source_sha256'],audited_declarations=len(names),axiom_dependencies=[],kernel_witness_equality=audit['kernel_witness_equality'],source_component_correspondence={m:dict(source=p,component=t)for m,(p,t)in scopes.items()},dependencies={d:'complete'for d in x['v3_registration']['dependencies']},reports={f:H(w/f)for f in reports},full_empirical_replay_passed=True,remaining=[])
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',remaining=[],completion_evidence=receipt,lean_modules=list(scopes),verified_scope='; '.join(scopeText.values()),artifact_runtime_parity='PASS fresh complete256-candidate programme; three inverse ten-field results/successor/invalid inverse; full12-field analysis/47checks and12-field seven-message empirical report match pinnedV3; original independent controls pass; combined eight-witness kernel equality empty axioms.')
c['summary'].update(fully_reconstructed_claims=1055,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(names));c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for fn in ['README.md','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [('1,054 / 2,781','1,055 / 2,781'),('1054 / 2,781','1055 / 2,781'),('1,054 entries complete','1,055 entries complete'),('1054 entries complete','1055 entries complete'),('1,727 entries remain unfinished.','1,726 entries remain unfinished.')]:s=s.replace(a,b)
 for key in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:s=s.replace(f'{old[key]:,}',f'{c["summary"][key]:,}')
 if fn=='README.md':
  s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s);s=re.sub(r'([0-9,]+) candidate records matched',lambda m:f'{int(m[1].replace(",",""))+256:,} candidate records matched',s)
 p.write_text(s)
nextId=next(z['claim_id']for z in c['claims']if z['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in z['v3_registration']['dependencies']))
s=json.load(open(r/'CONTINUATION_STATE.json'));s['scientific_cursor']={'completed':cid,'next':nextId,'next_milestone':1250,'action':'Continue '+nextId+' from pinned original source. Elimination010 complete:173 public declarations, all original kernel witnesses,256programme and full original empirical report verified. Preserve these results; do not rerun them from old pending prose.'};s['authorized_action']='1055 complete. Continue '+nextId+' in dependency order toward1250; bounded processes; update counts,paper,timeline,push; pause at1250 for review.';s['elimination1503']=record;(r/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n');print('REGISTERED1055; next',nextId,';newtheorems',len(newNames))

from pathlib import Path
import json,re,hashlib,datetime,fcntl
w=Path('work');r=w/'turn1064_recovery';cid='SFT-CHEM-NUCLEOPHILIC-SUBSTITUTION-FAMILY-007';now=datetime.datetime.now(datetime.timezone.utc).isoformat();H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
reports=['nucleophilic1497_full_audit_report.json','nucleophilic1497_program_report.json','nucleophilic1497_analysis_report.json','nucleophilic1497_path_cases_report.json','nucleophilic1497_validation_report.json']
for f in reports:assert json.loads((w/f).read_text())['status']=='PASS',f
audit=json.loads((w/reports[0]).read_text());names=audit['declarations'];assert len(names)==169
for m,h in audit['source_sha256'].items():assert H(r/'SFT/Chemistry'/f'{m}.lean')==h
assert json.loads((w/'nucleophilic1497_validation_output.json').read_text())==json.loads((w/'nucleophilic1497_original_empirical.json').read_text())
assert json.loads((w/'nucleophilic1497_validation_output.json').read_text())['passed']
lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status']!='complete';assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();assert old['fully_reconstructed_claims']==1050
law='sft/chemistry/nucleophilic_substitution_law_v1.py';val='sft/chemistry/nucleophilic_substitution_validation_v1.py';batch='sft/chemistry/nucleophilic_substitution_batch_v1.py'
scopes={
'NucleophilicCarrier':(law,'Ordered held pairs, bond and free-pair records, complete state/carrier/transition validation, distinct atom/electron supports and exact original role classification.'),
'NucleophilicPath':(law,'Original one/two-transition path guards, adjacent states, gap-free occurrence order, exact action and terminal edge-set checks, retained-substrate extension.'),
'NucleophilicConservation':(law,'General successful-transition ordered-atom and electron-support conservation, original returned transition fields and pair-occurrence distinction.'),
'NucleophilicPathProofs':(law,'Successful path has original two/three-state and transition-count shape; retained substrate append length, prefix and original readback identities.'),
'NucleophilicWitnesses':(law,'Seven original operational witnesses derived from native carrier/path operations, including both complete paths, formation-first and collapsed-pair rejection, and successor.'),
'NucleophilicGrammar':(batch,'Eight original binary axes; full256 alternatives and source-preserving survivor.'),
'NucleophilicEvidence':(batch,'Original registration, all256 elimination decisions, seven witnesses, closure, four controls and unknown-candidate rejection; entire fresh programme equals original.'),
'NucleophilicFormula':(val,'Original ASCII formula token grammar, repeated-element accumulation, terminal-charge stripping and signed dictionary sum with sorted output.'),
'NucleophilicAnalysis':(val,'Original23 analysis fields, nine target checks, complete source/terminal formula inventories and exact primary-analysis reconstruction.'),
'NucleophilicSource':(val,'Original identity and target hashes, nine-row boundary, six identity keys, per-row source snapshot then payload hash checks.'),
'NucleophilicExperiment':(val,'Original observational registration, prediction programme, envelope, eight dimensions, references and seven operational witnesses.'),
'NucleophilicValidation':(val,'Actual full capability execution, prediction seal, hostile audit, target custody, nine comparisons, omission/tampering controls and complete12-field seven-message empirical report; fresh original and native results equal and pass.')}
receipt='verification/TURN1497_NUCLEOPHILIC_COMPLETION.json';corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());corr['modules']=[z for z in corr['modules']if z.get('v3_claim')!=cid];oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[]
for m,(source,scope)in scopes.items():
 rel='SFT/Chemistry/'+m+'.lean';ths=['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];assert all(n in names for n in ths);newNames += [n for n in ths if n not in oldNames]
 corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=source,lean_source_sha256=H(r/rel),domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
record=dict(status='complete',claim_id=cid,registered_at=now,source_commit=c['source_commit'],lean_source_sha256={'SFT/Chemistry/'+m+'.lean':H(r/'SFT/Chemistry'/f'{m}.lean')for m in scopes},audited_declarations=169,axiom_dependencies=[],source_component_correspondence={m:dict(source=p,component=t)for m,(p,t)in scopes.items()},dependencies={d:'complete'for d in x['v3_registration']['dependencies']},reports={f:H(w/f)for f in reports},full_empirical_replay_passed=True,remaining=[])
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',remaining=[],completion_evidence=receipt,lean_modules=list(record['lean_source_sha256']),verified_scope='; '.join(t for p,t in scopes.values()),artifact_runtime_parity='PASS fresh complete256-candidate programme and12-field empirical report match pinnedV3; originalindependentvalidator and three tamperingcontrolsPASS.')
c['summary'].update(fully_reconstructed_claims=1051,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+169);c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for fn in ['README.md','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [('1,050 / 2,781','1,051 / 2,781'),('1050 / 2,781','1051 / 2,781'),('1,050 entries complete','1,051 entries complete'),('1050 entries complete','1051 entries complete'),('1,731 entries remain unfinished.','1,730 entries remain unfinished.')]:s=s.replace(a,b)
 for key in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:s=s.replace(f'{old[key]:,}',f'{c["summary"][key]:,}')
 if fn=='README.md':
  s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s);s=re.sub(r'([0-9,]+) candidate records matched',lambda m:f'{int(m[1].replace(",",""))+256:,} candidate records matched',s)
 p.write_text(s)
nextId=next(z['claim_id']for z in c['claims']if z['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in z['v3_registration']['dependencies']))
s=json.loads((r/'CONTINUATION_STATE.json').read_text());s['scientific_cursor'].update(completed=cid,next=nextId,next_milestone=1250,action='Continue '+nextId+' from pinned original source in dependency order. Preserve completed Nucleophilic007 proof,256-candidate and full empirical equality evidence. No pending007 derivation or repeated review.');s['authorized_action']='1051 complete. Continue '+nextId+' toward1250; update counts,paper,timeline,push; pause at1250review.';s['nucleophilic1497']=record;(r/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n');print('REGISTERED1051; next',nextId,';newtheorems',len(newNames))

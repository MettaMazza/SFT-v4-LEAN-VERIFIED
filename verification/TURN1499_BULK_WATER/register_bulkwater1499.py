from pathlib import Path
import json,re,hashlib,datetime,fcntl
w=Path('work');r=w/'turn1064_recovery';cid='SFT-MAT-BULK-WATER-RESPONSE-002';now=datetime.datetime.now(datetime.timezone.utc).isoformat();H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
reports=['bulkwater1499_full_audit_report.json','bulkwater1499_program_report.json','bulkwater1499_postsource_report.json','bulkwater1499_validation_report.json']
for f in reports:assert json.loads((w/f).read_text())['status']=='PASS',f
audit=json.loads((w/reports[0]).read_text());names=audit['declarations'];assert len(names)==113
for m,h in audit['source_sha256'].items():assert H(r/'SFT/Materials'/f'{m}.lean')==h
assert json.loads((w/'bulkwater1499_validation_output.json').read_text())=={'error':'successor external source mismatch'}
assert json.loads((w/'bulkwater1499_postsource_output.json').read_text())==json.loads((w/'bulkwater1499_postsource_expected.json').read_text())
lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status']!='complete';assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();assert old['fully_reconstructed_claims']==1052
law='sft/materials/successor_structural_counts.py';val='sft/materials/successor_evidence.py';batch='sft/materials/successor_derivation.py'
scopes={
'BulkWater':(law,'Exact nine-field water bulk ledger, computed positive field count, complete flag and original operational witness, with three native proofs.'),
'BulkWaterGrammar':(batch,'All eight original binary preservation axes, complete256-candidate census and unique survivor.'),
'BulkWaterEvidence':('sft/materials/generated_law.py','Exact original registration,256decisions,complete closure,fourcontrols and witness computed from the original native nine-field certificate; entire native programme and ledger match original.'),
'BulkWaterSource':(val,'Original pre-source seal validation and four source requirements over three sources; original hash mismatch preserved exactly.'),
'BulkWaterExperiment':(val,'Original spec guards,observational identity,three-instruction programme,registration hash and envelope, bound to computed original witness.'),
'BulkWaterValidation':(val,'Original full native validator matches original source-hash rejection; all12downstream reportfields andthree messages compare exactly in separately isolated downstream test; no full empirical success claimed.')}

receipt='verification/TURN1499_BULK_WATER_COMPLETION.json';corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());corr['modules']=[z for z in corr['modules']if z.get('v3_claim')!=cid];oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[]
for m,(source,scope)in scopes.items():
 rel='SFT/Materials/'+m+'.lean';ths=['SFT.Materials.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];assert all(n in names for n in ths);newNames += [n for n in ths if n not in oldNames]
 corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=source,lean_source_sha256=H(r/rel),domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
record=dict(status='complete',claim_id=cid,registered_at=now,source_commit=c['source_commit'],lean_source_sha256={'SFT/Materials/'+m+'.lean':H(r/'SFT/Materials'/f'{m}.lean')for m in scopes},audited_declarations=113,axiom_dependencies=[],source_component_correspondence={m:dict(source=p,component=t)for m,(p,t)in scopes.items()},dependencies={d:'complete'for d in x['v3_registration']['dependencies']},reports={f:H(w/f)for f in reports},full_empirical_replay_passed=False,remaining=[])
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',remaining=[],completion_evidence=receipt,lean_modules=list(record['lean_source_sha256']),verified_scope='; '.join(t for p,t in scopes.values()),artifact_runtime_parity='PASS exact complete256programme and9fieldledger; fullnative source rejection matches original; separate12-field downstream comparisonPASS; full empirical replayFalse.')
issue=json.loads((w/'bulkwater1499_original_source_checks.json').read_text())[0];x['source_replay_issue']=dict(kind='original_source_hash_mismatch',path=issue['path'],expected=issue['expected'],actual=issue['actual'],full_empirical_replay_passed=False,original_and_native_error='successor external source mismatch');record['source_replay_issue']=x['source_replay_issue'];(r/receipt).write_text(json.dumps(record,indent=2)+'\n')
c['summary'].update(fully_reconstructed_claims=1053,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+113);c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for fn in ['README.md','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [('1,052 / 2,781','1,053 / 2,781'),('1052 / 2,781','1053 / 2,781'),('1,052 entries complete','1,053 entries complete'),('1052 entries complete','1053 entries complete'),('1,729 entries remain unfinished.','1,728 entries remain unfinished.')]:s=s.replace(a,b)
 for key in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:s=s.replace(f'{old[key]:,}',f'{c["summary"][key]:,}')
 if fn=='README.md':
  s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s);s=re.sub(r'([0-9,]+) candidate records matched',lambda m:f'{int(m[1].replace(",",""))+256:,} candidate records matched',s)
 p.write_text(s)
nextId=next(z['claim_id']for z in c['claims']if z['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in z['v3_registration']['dependencies']))
s=json.loads((r/'CONTINUATION_STATE.json').read_text());s['scientific_cursor'].update(completed=cid,next=nextId,next_milestone=1250,action='Continue '+nextId+' from pinned original source in dependency order. Preserve completed BulkWater007 proof,256-candidate and full empirical equality evidence. No pending007 derivation or repeated review.');s['authorized_action']='1053 complete. Continue '+nextId+' toward1250; update counts,paper,timeline,push; pause at1250review.';s['bulkwater1499']=record;(r/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n');print('REGISTERED1053; next',nextId,';newtheorems',len(newNames))

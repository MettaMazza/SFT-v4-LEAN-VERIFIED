from pathlib import Path
import json,re,hashlib,datetime,shutil,fcntl
w=Path('work');r=w/'turn1064_recovery';lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();now=datetime.datetime.now(datetime.timezone.utc).isoformat();cid='SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001'
reports=['elementary1347_analysis_report.json','elementary1347_core_report.json','elementary1347_prediction_report.json','elementary1347_experiment_report.json','elementary1347_full_audit_report.json','elementary1347_program_report.json','elementary1347_empirical_report.json','elementary1347_original_report.json']
for n in reports:assert json.loads((w/n).read_text())['status']=='PASS',n
ind=json.loads((w/'elementary1347_independent_report.json').read_text());assert len(ind)==4 and all(x['result']['passed']==(x['case']=='original')for x in ind)
assert json.loads((w/'elementary1347_empirical_output.json').read_text())==json.loads((w/'elementary1347_original_empirical_current.json').read_text())
audit=json.loads((w/'elementary1347_full_audit_report.json').read_text())
assert len(audit['source_sha256'])==8
auditNames=audit['declarations'];hashes=audit['source_sha256'];assert len(auditNames)==len(set(auditNames))
for p,h in hashes.items():assert H(r/p)==h,p
for name in reports:
 report=json.loads((w/name).read_text())
 for path,h in report.get('source_sha256',{}).items():
  rel=path if path.startswith('SFT/') else 'SFT/Chemistry/'+path+'.lean'
  assert H(r/rel)==h,(name,rel)
assert json.loads((w/'elementary1347_core_report.json').read_text())['cases']==57
assert json.loads((w/'elementary1347_prediction_report.json').read_text())['cases']==11
assert json.loads((w/'elementary1347_experiment_report.json').read_text())['instructions']==463
assert json.loads((w/'elementary1347_analysis_report.json').read_text())['cases']==32
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status'] in ['pending','in_progress'];assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();assert 752 <= old['fully_reconstructed_claims'] < 1250; oldCount=old['fully_reconstructed_claims']; newCount=oldCount+1; oldCandidates=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text()).group(1).replace(',','')); newCandidates=oldCandidates+256
receipt='verification/TURN1347_ELEMENTARY_TRANSITION_RATE_COMPLETION.json';scopes={'ElementaryTransitionRate': ('sft/chemistry/elementary_transition_rate_law_v1.py:ElementaryTransitionAccount/forced_elementary_transition_rate/external_rate_magnitude/common_event_resource_replication_preserves_rate/_account/OPERATIONAL_WITNESSES', 'Original reaction/endpoints/count/condition guards;held orientation,N/(ticks×observation),exact positive external decoder,event/tick replication and four operation-derived witnesses.'), 'ElementaryTransitionRateGrammar': ('sft/chemistry/elementary_transition_rate_law_v1.py:DIMENSIONS', 'Eight original binary axes,all256alternatives,exact elimination and unique survivor.'), 'ElementaryTransitionRateEvidence': ('sft/chemistry/generated_observational_law.py:GeneratedObservationalChemistryProgram;sft/chemistry/elementary_transition_rate_batch_v1.py:ELEMENTARY_TRANSITION_RATE_SPEC', 'Original dependencies,registration,closure,controls and four operation-derived witnesses.'), 'ElementaryTransitionRateExperiment': ('sft/chemistry/elementary_transition_rate_validation_v1.py:_identities/prediction_program_document/experiment_registration_record', '46value-free identities,463instructions,nine-cell words,twelve registration fields,forward-forcing provenance and all raw-source bindings.'), 'ElementaryTransitionRateSource': ('sft/chemistry/elementary_transition_rate_validation_v1.py:_source_rows', 'All byteguards,four source and order counts,four identitybindings,post-seal payload hashes.'), 'ElementaryTransitionRateAnalysis': ('sft/chemistry/elementary_transition_rate_validation_v1.py:exact_elementary_rate_analysis', 'All11fields;complete experimental provenance,source-declared order,original measured/Arrhenius-tabulation disclosure,positive exact rates/temperatures/units,actual native reaction/endpoint/count account,all46records,four sources,order counts and exact ranges.'), 'ElementaryTransitionRatePrediction': ('sft/chemistry/elementary_transition_rate_validation_v1.py:_prediction_map', 'Original46-record nine-cell table,target/word/uniqueness guards;11source-domain cases.'), 'ElementaryTransitionRateValidation': ('sft/chemistry/elementary_transition_rate_validation_v1.py:ElementaryTransitionRateValidator.validate', '46identity/law/post-seal comparisons,negative-rate tamper,sixcontrols,11-fieldanalysis,twelve-field55-message receipt.')}
oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[];corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text())
corr['modules']=[row for row in corr['modules'] if row.get('v3_claim')!=cid]
for m,(src,scope)in scopes.items():
 rel='SFT/Chemistry/'+m+'.lean';names=['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];newNames += [n for n in names if n not in oldNames];assert all(n in auditNames for n in names)
 corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=src,lean_source_sha256=hashes[rel],domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
evidence=reports+['elementary1347_independent_report.json','elementary1347_empirical_output.json','elementary1347_program_output.json'];dest=r/'verification/TURN1347_ELEMENTARY_TRANSITION_RATE';dest.mkdir(exist_ok=True)
for n in evidence:shutil.copyfile(w/n,dest/n)
record=dict(status='complete',registered_at=now,claim_id=cid,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_component_correspondence={m:dict(source=p,component=s)for m,(p,s)in scopes.items()},lean_source_sha256=hashes,dependencies={d:'complete'for d in x['v3_registration']['dependencies']},candidate_rows=256,original_target_rows=46,empirical_fields=12,measurement_messages=55,axiom_dependencies=[],audited_declarations=auditNames,added_registered_theorems=newNames,remaining=[],checks={n:H(w/n)for n in evidence})
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',lean_modules=list(hashes),remaining=[],completion_evidence=receipt,artifact_runtime_parity='PASS all original256candidate programme fields and hashes, original and three adverse independent cases,full twelve-field55-message empirical receipt and complete46-record elementary rate source comparison',verified_scope='; '.join(v[1]for v in scopes.values()))
c['summary'].update(fully_reconstructed_claims=newCount,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(auditNames));c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for fn in ['README.md','ZENODO_PAPER_DRAFT.txt','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [(f'{oldCount} / 2,781',f'{newCount} / 2,781'),(f'{oldCount} entries complete',f'{newCount} entries complete'),(f'{oldCount} completed entries',f'{newCount} completed entries'),(f'{oldCount} V3 entries verified',f'{newCount} V3 entries verified'),(f'{oldCount} model entries complete',f'{newCount} model entries complete'),(f'{oldCount} completed source entries',f'{newCount} completed source entries'),(f'{2781-oldCount:,} entries remain unfinished.',f'{2781-newCount:,} entries remain unfinished.'),(f'{old["axiom_free_exported_results"]:,}',f'{c["summary"]["axiom_free_exported_results"]:,}'),(f'{old["axiom_free_audited_definitions_and_theorems"]:,}',f'{c["summary"]["axiom_free_audited_definitions_and_theorems"]:,}'),(f'{oldCandidates:,}',f'{newCandidates:,}')]:s=s.replace(a,b)
 if fn=='README.md':s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s)
 if fn.endswith('.svg'):s=s.replace(f'{oldCount:,} / 2,781',f'{newCount:,} / 2,781').replace(f'{oldCount} / 2,781',f'{newCount:,} / 2,781')
 if fn=='ZENODO_PAPER_DRAFT.txt':
  s=s.replace('Native verification remains pending. Pinned V3: sft/chemistry/elementary_transition_rate_law_v1.py:','Native verification passes; completion receipt: verification/TURN1347_ELEMENTARY_TRANSITION_RATE_COMPLETION.json. Pinned V3: sft/chemistry/elementary_transition_rate_law_v1.py:')
  s=s.replace('Elementary Transition Rate native empirical verification remains pending.','Elementary Transition Rate native empirical verification passes; completion receipt: verification/TURN1347_ELEMENTARY_TRANSITION_RATE_COMPLETION.json.')

 if fn=='README.md':s=re.sub(r'^## [0-9,]+ / 2,781 V3 entries complete',f'## {newCount:,} / 2,781 V3 entries complete',s,flags=re.M)
 if fn=='ZENODO_PAPER_DRAFT.txt':s=re.sub(r'Current native verification: [0-9,]+ entries complete\.',f'Current native verification: {newCount:,} entries complete.',s)
 p.write_text(s)
with(r/'ZENODO_PAPER_DRAFT.txt').open('a')as f:f.write('\nElementary transition rate verification is complete. All '+str(len(auditNames))+' audited declarations have empty axiom dependencies. All 57 core/domain cases, 32 complete eleven-field analysis cases, eleven prediction cases, 463 instructions, twelve registration fields, 256 programme alternatives and three adverse independent cases agree with V3. The twelve-field, 55-message empirical receipt agrees, including 46 records and six controls. Completion receipt: '+receipt+'. Timeline: TURN1347.\n')
# Keep the completion evidence beside its existing mathematical derivation.
paperPath=r/'ZENODO_PAPER_DRAFT.txt';paperText=paperPath.read_text()
completionParagraph=next(line for line in reversed(paperText.splitlines()) if line.strip())
assert 'complete' in completionParagraph
at=paperText.rfind(completionParagraph);paperText=paperText[:at]+paperText[at+len(completionParagraph):]
completionParagraph=re.sub(r'(?<=\d)(?=(?:original|prediction|instructions|registration|programme|analysis)\b)',' ',completionParagraph)
completionParagraph=re.sub(r',(?=[A-Za-z])',', ',completionParagraph)
section=re.search(r'^1182\. ',paperText,re.M);assert section
following=re.search(r'^\d+\. ',paperText[section.end():],re.M);assert following
end=section.end()+following.start();body=paperText[section.start():end]
body=re.sub(r'^Current native evidence:[^\n]*\n','',body,flags=re.M)
paperText=paperText[:section.start()]+body.rstrip()+'\n\n'+completionParagraph+'\n\n'+paperText[end:]
paperPath.write_text(paperText)
with(r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1347 registration — '+now+' — Elementary Transition Rate complete at '+str(newCount)+'. Checked eight native modules/current hashes,57core/32analysis/11prediction cases,complete programme/empirical receipt and dependencies;updated counts,correspondence,paper and timeline.\n')

nextId=next(y['claim_id']for y in c['claims']if y['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in y['v3_registration']['dependencies']))
p=r/'CONTINUATION_STATE.json';s=json.loads(p.read_text());s.setdefault('elementary1347',{}).update(status='complete',receipt=receipt);s['scientific_cursor'].update(completed=cid,next=nextId,next_milestone=1250,action='Continue '+nextId+' from its actual retained job or source/proof evidence. Preserve live checks; do not repeat completed work.');s['authorized_action']=str(newCount)+'complete. Reconcile actual source and existing implementation for '+nextId+' then continue dependency order toward1250. Reuse existing proofs,keep processes bounded and update paper/timeline/counts/GitHub. Pause only with full1250review package ready.';p.write_text(json.dumps(s,indent=2)+'\n');print(json.dumps(c['summary']))

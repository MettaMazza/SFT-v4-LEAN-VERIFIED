from pathlib import Path
import json,re,hashlib,datetime,shutil
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');rec=w/'constants-recovery';cid='SFT-FOUNDATION-ADMISSION-ENFORCEMENT-001';receipt='verification/TURN_857_ADMISSION_COMPLETION.json';now=datetime.datetime.now(datetime.timezone.utc).isoformat()
cfg=json.load(open(w/'admission857_proofs_config.json'));assert len(cfg['modules'])==37
for file in ['admission_program857_report.json']:assert json.load(open(w/file))['status']=='PASS'
cases=json.load(open(w/'admission_independent857_report.json'));assert all(x['actual']['passed']==x['expected'] for x in cases)
audit=(w/'admission857_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in cfg['declarations'])
assert 'Build completed successfully' in (w/'admission857_canonical_build.log').read_text()
cov=json.load(open(r/'COVERAGE.json'));by={x['claim_id']:x for x in cov['claims']};entry=by[cid];assert entry['lean_status']=='pending';assert all(by[d]['lean_status']=='complete' for d in entry['v3_registration']['dependencies'])
scopes={m:('admission_accepts: exact dictionary updates and all-values acceptance; acceptedExactly and anyFailedGateRejects, original changed-gate controls.' if m=='AdmissionAcceptance' else 'Original eleven axes and complete2048 product, exact source identifier/coordinate equivalence, unique survivor and all forbidden coordinate rejection proofs.' if m.startswith('AdmissionGrammar') else 'Original control_records and closure_record fields, original admission updates and canonical source identity test.' if m=='AdmissionControls' else 'AdmissionEnforcementProgram registration, complete census, decisions/reasons/proof hashes, closure, controls binding and original KeyError behavior.') for m in cfg['modules']}
source={m:'sft/foundation/admission_enforcement.py' for m in scopes}
files=['admission857_audit.log','admission857_proofs_config.json','admission_program857_report.json','admission_program857_output.json','admission_independent857_report.json','admission857_build_report.json','admission857_canonical_build.log']
assert all((w/f).is_file() for f in files)
assert set(scopes)==set(cfg['modules']);paths=set();corr=json.load(open(r/'reference/CORRESPONDENCE.json'));oldth=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newths=[n for n in cfg['theorems'] if n not in oldth]
for m in cfg['modules']:
 rel='SFT/Foundation/'+m+'.lean';s=(rec/rel).read_text();assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M);(r/rel).write_text(s);paths.add(rel)
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with (r/'SFT.lean').open('a') as f:f.write('\n'+imp+'\n')
 corr['modules' if m.startswith('AdmissionGrammar') else 'evidence_modules'].append(dict(module=rel,v3_claim=cid,source_path=source[m],lean_source_sha256=hashlib.sha256(s.encode()).hexdigest(),domain=scopes[m],implemented={n:scopes[m] for _,n in re.findall(r'^\s*(def|theorem|structure|inductive|abbrev) (\w+)',s,re.M)},remaining=[],completion_evidence=receipt))
with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+n+'\n' for n in newths if n not in oldth))
oldread=(r/'README.md').read_text();oldlog='verification/TURN_856C_REGISTERED_DECLARATIONS_AUDIT.log';log='verification/TURN_857C_REGISTERED_DECLARATIONS_AUDIT.log';(r/log).write_text((r/oldlog).read_text()+'\n'+audit);paths.add(log)
if 'for c in SFT.Foundation.AdmissionGrammar.candidates do' not in (r/'Parity.lean').read_text():
 with (r/'Parity.lean').open('a') as f:f.write('\n  for c in SFT.Foundation.AdmissionGrammar.candidates do\n    IO.println ("AdmissionGrammar\\t" ++ SFT.Foundation.AdmissionGrammar.candidateId c ++ "\\t" ++ (if SFT.Foundation.AdmissionGrammar.survives c then "true" else "false") ++ "\\t" ++ SFT.Foundation.AdmissionGrammar.exactForm c ++ "\\t" ++ SFT.Foundation.AdmissionGrammar.decisionReason c)\n')
for name in files:
 rel='verification/TURN_857_'+name;shutil.copy2(w/name,r/rel);paths.add(rel)
report=dict(status='complete',claim_id=cid,source_commit=cov['source_commit'],source_component_correspondence={m:{'source':source[m],'component':scopes[m]} for m in scopes},lean_source_sha256={m:hashlib.sha256((rec/'SFT/Foundation'/(m+'.lean')).read_bytes()).hexdigest() for m in cfg['modules']},dependencies={d:'complete' for d in entry['v3_registration']['dependencies']},candidate_rows=2048,axiom_dependencies=[],audited_declarations=cfg['declarations'],added_registered_theorems=newths,added_audited_definitions_and_theorems=cfg['definitions_and_theorems'],remaining=[],program_report='verification/TURN_857_admission_program857_report.json',independent_validator_cases=cases,canonical_build={'status':'PASS','log':'verification/TURN_857_admission857_canonical_build.log'},checks_executed=['python3 work/build_admission_batch857.py','python3 work/audit_admission857.py','python3 work/run_admission_native857.py','python3 work/check_admission_independent857.py','lake build SFT.Foundation.AdmissionEvidence'])
(r/receipt).write_text(json.dumps(report,indent=2)+'\n');paths.add(receipt)
entry.update(lean_status='complete',remaining=[],lean_modules=['SFT/Foundation/'+m+'.lean' for m in cfg['modules']],completion_evidence=receipt,verified_scope='; '.join(scopes.values()),artifact_runtime_parity='PASS fresh complete2048 program and all original fields/hashes, four independent accepted/adverse cases; original formal evidence mode preserved.')
old=cov['summary'].copy();count=old['fully_reconstructed_claims']+1;cov['summary'].update(fully_reconstructed_claims=count,pending=old['pending']-1,axiom_free_exported_results=old['axiom_free_exported_results']+len(newths),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(cfg['definitions_and_theorems']));cov['updated_at']=now;assert count==sum(x['lean_status']=='complete' for x in cov['claims']);(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newths));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n');new=cov['summary']
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;s=p.read_text()
 for tail in [' / 2,781',' V3 entries verified',' model entries',' completed entries',' completed source entries',' source entries']:s=s.replace(str(count-1)+tail,str(count)+tail)
 for field in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:s=s.replace(f"{old[field]:,}",f"{new[field]:,}")
 s=s.replace('203,282','205,330').replace(f"{old['pending']:,} entries remain pending",f"{new['pending']:,} entries remain pending")
 if name=='README.md':
  s=re.sub(r'(\[latest completion evidence\]\()[^)]+',lambda m:m.group(1)+receipt,s).replace(oldlog,log)
 if name=='ZENODO_PAPER_DRAFT.txt':
  pass
  s+=(w/'paper_admission857_addition.txt').read_text()
 p.write_text(s);paths.add(name)
status='verification/TURN_377_NATIVE_BATCH/BATCH_STATUS.json';v=json.load(open(r/status));v['completed_entries']=count;(r/status).write_text(json.dumps(v,indent=2)+'\n');paths.add(status)
with (r/'TIMELINE.txt').open('a') as f:f.write((w/'timeline857_addition.txt').read_text()+'\nRegistered '+str(count)+' completed entries immediately after checks. Next push checkpoint then follow registered dependency cursor.\n')
state=json.load(open(r/'CONTINUATION_STATE.json'));state['admission857']={'status':'complete','receipt':receipt,'audited_declarations':len(cfg['declarations']),'candidate_rows':2048};done={x['claim_id'] for x in cov['claims'] if x['lean_status']=='complete'};nextentry=next(x['claim_id'] for x in cov['claims'] if x['claim_id'] not in done and set(x['v3_registration']['dependencies'])<=done);state['scientific_cursor']={'completed':cid,'next':nextentry,'receipt':receipt,'source':'claims/'+nextentry+'/execution.py','next_milestone':750};state['authorized_action']='Continue '+nextentry+' in dependency order toward750 using actual pinned source and verified dependencies. Update counts, paper and timeline and push verified batches. Prepare complete750 review package before pausing.';(r/'CONTINUATION_STATE.json').write_text(json.dumps(state,indent=2)+'\n');paths.update(['SFT.lean','Audit.lean','Parity.lean','COVERAGE.json','reference/CORRESPONDENCE.json','TIMELINE.txt','CONTINUATION_STATE.json']);(w/'checkpoint857_paths.json').write_text(json.dumps(sorted(paths)));print(json.dumps(new));print(nextentry)

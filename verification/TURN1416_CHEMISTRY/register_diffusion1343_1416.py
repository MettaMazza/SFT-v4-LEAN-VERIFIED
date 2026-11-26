from pathlib import Path
import json,re,hashlib,datetime,shutil,fcntl
w=Path('work');r=w/'turn1064_recovery';lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();now=datetime.datetime.now(datetime.timezone.utc).isoformat();cid='SFT-CHEM-MOLECULAR-DIFFUSION-RELATION-016'
reports=['diffusion1343_analysis_report.json','diffusion1343_core_report.json','diffusion1343_prediction_report.json','diffusion1343_experiment_report.json','diffusion1343_full_audit_report.json','diffusion1343_program_report.json','diffusion1343_empirical_report.json','diffusion1343_original_report.json']
for n in reports:assert json.loads((w/n).read_text())['status']=='PASS',n
ind=json.loads((w/'diffusion1343_independent_report.json').read_text());assert len(ind)==4 and all(x['result']['passed']==(x['case']=='original')for x in ind)
assert json.loads((w/'diffusion1343_empirical_output.json').read_text())==json.loads((w/'diffusion1343_original_empirical_current.json').read_text())
audit=json.loads((w/'diffusion1343_full_audit_report.json').read_text())
assert len(audit['source_sha256'])==8
auditNames=audit['declarations'];hashes=audit['source_sha256'];assert len(auditNames)==len(set(auditNames))
for p,h in hashes.items():assert H(r/p)==h,p
for name in reports:
 report=json.loads((w/name).read_text())
 for path,h in report.get('source_sha256',{}).items():
  rel=path if path.startswith('SFT/') else 'SFT/Chemistry/'+path+'.lean'
  assert H(r/rel)==h,(name,rel)
assert json.loads((w/'diffusion1343_core_report.json').read_text())['cases']==96
assert json.loads((w/'diffusion1343_prediction_report.json').read_text())['cases']==11
assert json.loads((w/'diffusion1343_experiment_report.json').read_text())['instructions']==1807
assert json.loads((w/'diffusion1343_analysis_report.json').read_text())['cases']==42
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status'] in ['pending','in_progress'];assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();assert 752 <= old['fully_reconstructed_claims'] < 1250; oldCount=old['fully_reconstructed_claims']; newCount=oldCount+1; oldCandidates=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text()).group(1).replace(',','')); newCandidates=oldCandidates+256
receipt='verification/TURN1343_MOLECULAR_DIFFUSION_COMPLETION.json';scopes={'MolecularDiffusion': ('sft/chemistry/molecular_diffusion_law_v1.py:MolecularDiffusionAccount/forced_counted_diffusion/external_diffusion_magnitude/complete_constituent_conservation/transition_replication_preserves_relation/_account/_witnesses', 'Original complete identity/class/phase/positive-count/adjacency/condition guards;held orientation,rawtransition density,positive external magnitude,complete sorted constituent multiset and common transition/tick replication.'), 'MolecularDiffusionGrammar': ('sft/chemistry/molecular_diffusion_law_v1.py:DIMENSIONS', 'Eight original binary axes,all256alternatives,exact elimination and unique survivor.'), 'MolecularDiffusionEvidence': ('sft/chemistry/generated_observational_law.py:GeneratedObservationalChemistryProgram;sft/chemistry/molecular_diffusion_batch_v1.py:MOLECULAR_DIFFUSION_SPEC', 'Original dependencies,registration,closure,controls and five operation-derived witnesses.'), 'MolecularDiffusionExperiment': ('sft/chemistry/molecular_diffusion_validation_v1.py:_identities/prediction_program_document/experiment_registration_record', '164value-free identities;1807instructions,ten-cell words,12registration fields,original forward-forcing provenance and all raw/landing source bindings.'), 'MolecularDiffusionSource': ('sft/chemistry/molecular_diffusion_validation_v1.py:_source_rows', 'Original target/primary/raw/landing-byte guards,class counts,five identity bindings and post-seal complete payload hashes.'), 'MolecularDiffusionAnalysis': ('sft/chemistry/molecular_diffusion_validation_v1.py:_condition_support/_variable_kind/exact_molecular_diffusion_analysis', 'All17fields;actual native count/account/transition/conservation operations,complete variable-key bindings,EmptyOne conditions and original kind extraction;138binary/4self/22tracer,11datasets,methods/phases,26absences,exact class/condition ranges and source/no-fit guards.'), 'MolecularDiffusionPrediction': ('sft/chemistry/molecular_diffusion_validation_v1.py:_prediction_map', 'Original164-record ten-cell table,target/word/uniqueness guards;11source-domain cases.'), 'MolecularDiffusionValidation': ('sft/chemistry/molecular_diffusion_validation_v1.py:MolecularDiffusionValidator.validate', '164identity/law/post-seal target comparisons;original first-row negative-diffusion tamper,seven controls,17-fieldanalysis,twelve-field174-message receipt.')}
oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[];corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text())
corr['modules']=[row for row in corr['modules'] if row.get('v3_claim')!=cid]
for m,(src,scope)in scopes.items():
 rel='SFT/Chemistry/'+m+'.lean';names=['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];newNames += [n for n in names if n not in oldNames];assert all(n in auditNames for n in names)
 corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=src,lean_source_sha256=hashes[rel],domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
evidence=reports+['diffusion1343_independent_report.json','diffusion1343_empirical_output.json','diffusion1343_program_output.json'];dest=r/'verification/TURN1343_MOLECULAR_DIFFUSION';dest.mkdir(exist_ok=True)
for n in evidence:shutil.copyfile(w/n,dest/n)
record=dict(status='complete',registered_at=now,claim_id=cid,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_component_correspondence={m:dict(source=p,component=s)for m,(p,s)in scopes.items()},lean_source_sha256=hashes,dependencies={d:'complete'for d in x['v3_registration']['dependencies']},candidate_rows=256,original_target_rows=164,empirical_fields=12,measurement_messages=174,axiom_dependencies=[],audited_declarations=auditNames,added_registered_theorems=newNames,remaining=[],checks={n:H(w/n)for n in evidence})
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',lean_modules=list(hashes),remaining=[],completion_evidence=receipt,artifact_runtime_parity='PASS all original256candidate programme fields and hashes, original and three adverse independent cases,full twelve-field174-message empirical receipt and complete164-record molecular diffusion source comparison',verified_scope='; '.join(v[1]for v in scopes.values()))
c['summary'].update(fully_reconstructed_claims=newCount,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(auditNames));c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for fn in ['README.md','ZENODO_PAPER_DRAFT.txt','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [(f'{oldCount} / 2,781',f'{newCount} / 2,781'),(f'{oldCount} entries complete',f'{newCount} entries complete'),(f'{oldCount} completed entries',f'{newCount} completed entries'),(f'{oldCount} V3 entries verified',f'{newCount} V3 entries verified'),(f'{oldCount} model entries complete',f'{newCount} model entries complete'),(f'{oldCount} completed source entries',f'{newCount} completed source entries'),(f'{2781-oldCount:,} entries remain unfinished.',f'{2781-newCount:,} entries remain unfinished.'),(f'{old["axiom_free_exported_results"]:,}',f'{c["summary"]["axiom_free_exported_results"]:,}'),(f'{old["axiom_free_audited_definitions_and_theorems"]:,}',f'{c["summary"]["axiom_free_audited_definitions_and_theorems"]:,}'),(f'{oldCandidates:,}',f'{newCandidates:,}')]:s=s.replace(a,b)
 if fn=='README.md':s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s)
 if fn.endswith('.svg'):s=s.replace(f'{oldCount:,} / 2,781',f'{newCount:,} / 2,781').replace(f'{oldCount} / 2,781',f'{newCount:,} / 2,781')
 if fn=='ZENODO_PAPER_DRAFT.txt':
  s=s.replace('Native verification remains pending. Pinned V3: sft/chemistry/molecular_diffusion_law_v1.py:','Native verification passes; completion receipt: verification/TURN1343_MOLECULAR_DIFFUSION_COMPLETION.json. Pinned V3: sft/chemistry/molecular_diffusion_law_v1.py:')
  s=s.replace('Molecular Diffusion native empirical verification remains pending.','Molecular Diffusion native empirical verification passes; completion receipt: verification/TURN1343_MOLECULAR_DIFFUSION_COMPLETION.json.')

 if fn=='README.md':s=re.sub(r'^## [0-9,]+ / 2,781 V3 entries complete',f'## {newCount:,} / 2,781 V3 entries complete',s,flags=re.M)
 if fn=='ZENODO_PAPER_DRAFT.txt':s=re.sub(r'Current native verification: [0-9,]+ entries complete\.',f'Current native verification: {newCount:,} entries complete.',s)
 p.write_text(s)
with(r/'ZENODO_PAPER_DRAFT.txt').open('a')as f:f.write('\nMolecular diffusion verification is complete. All '+str(len(auditNames))+' audited declarations have empty axiom dependencies. All96 core/domain cases,42 complete17-field analysis cases,11 prediction cases,1807instructions,12registration fields,256programme alternatives and three adverse independent cases agree with V3. The full twelve-field174-message receipt agrees,including138binary/4self/22tracer records,11datasets,26EmptyOneconditioncoordinates and seven controls. Completion receipt: '+receipt+'. Timeline: TURN1343.\n')
# Keep the completion evidence beside its existing mathematical derivation.
paperPath=r/'ZENODO_PAPER_DRAFT.txt';paperText=paperPath.read_text()
completionParagraph=next(line for line in reversed(paperText.splitlines()) if line.strip())
assert 'complete' in completionParagraph
at=paperText.rfind(completionParagraph);paperText=paperText[:at]+paperText[at+len(completionParagraph):]
completionParagraph=re.sub(r'(?<=\d)(?=(?:original|prediction|instructions|registration|programme|analysis)\b)',' ',completionParagraph)
completionParagraph=re.sub(r',(?=[A-Za-z])',', ',completionParagraph)
section=re.search(r'^1174\. ',paperText,re.M);assert section
following=re.search(r'^\d+\. ',paperText[section.end():],re.M);assert following
end=section.end()+following.start();body=paperText[section.start():end]
body=re.sub(r'^Current native evidence:[^\n]*\n','',body,flags=re.M)
paperText=paperText[:section.start()]+body.rstrip()+'\n\n'+completionParagraph+'\n\n'+paperText[end:]
paperPath.write_text(paperText)
with(r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1343 registration — '+now+' — Molecular Diffusion complete at '+str(newCount)+'. Checked eight native modules/current hashes,96core/42analysis/11prediction cases,complete programme/empirical receipt and dependencies;updated counts,correspondence,paper and timeline.\n')

nextId=next(y['claim_id']for y in c['claims']if y['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in y['v3_registration']['dependencies']))
p=r/'CONTINUATION_STATE.json';s=json.loads(p.read_text());s.setdefault('diffusion1343',{}).update(status='complete',receipt=receipt);s['scientific_cursor'].update(completed=cid,next=nextId,next_milestone=1250,action='Continue '+nextId+' from its actual retained job or source/proof evidence. Preserve live checks; do not repeat completed work.');s['authorized_action']=str(newCount)+'complete. Reconcile actual source and existing implementation for '+nextId+' then continue dependency order toward1250. Reuse existing proofs,keep processes bounded and update paper/timeline/counts/GitHub. Pause only with full1250review package ready.';p.write_text(json.dumps(s,indent=2)+'\n');print(json.dumps(c['summary']))

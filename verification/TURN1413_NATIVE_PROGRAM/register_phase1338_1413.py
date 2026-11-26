from pathlib import Path
import json,re,hashlib,datetime,shutil,fcntl
w=Path('work');r=w/'turn1064_recovery';lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();now=datetime.datetime.now(datetime.timezone.utc).isoformat();cid='SFT-CHEM-PHASE-RULE-STRUCTURAL-011'
reports=['phase1338_analysis_report.json','phase1338_core_report.json','phase1338_prediction_report.json','phase1338_experiment_report.json','phase1338_full_audit_report.json','phase1338_program_report.json','phase1338_empirical_report.json','phase1338_original_report.json']
for n in reports:assert json.loads((w/n).read_text())['status']=='PASS',n
ind=json.loads((w/'phase1338_independent_report.json').read_text());assert len(ind)==4 and all(x['result']['passed']==(x['case']=='original')for x in ind)
assert json.loads((w/'phase1338_empirical_output.json').read_text())==json.loads((w/'phase1338_original_empirical_current.json').read_text())
audit=json.loads((w/'phase1338_full_audit_report.json').read_text())
assert len(audit['source_sha256'])==8
auditNames=audit['declarations'];hashes=audit['source_sha256'];assert len(auditNames)==len(set(auditNames))
for p,h in hashes.items():assert H(r/p)==h,p
for name in reports:
 report=json.loads((w/name).read_text())
 for path,h in report.get('source_sha256',{}).items():
  rel=path if path.startswith('SFT/') else 'SFT/Chemistry/'+path+'.lean'
  assert H(r/rel)==h,(name,rel)
assert json.loads((w/'phase1338_core_report.json').read_text())['cases']==145
assert json.loads((w/'phase1338_prediction_report.json').read_text())['cases']==11
assert json.loads((w/'phase1338_experiment_report.json').read_text())['instructions']==165
assert json.loads((w/'phase1338_analysis_report.json').read_text())['cases']==21
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status'] in ['pending','in_progress'];assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();assert 752 <= old['fully_reconstructed_claims'] < 1250; oldCount=old['fully_reconstructed_claims']; newCount=oldCount+1; oldCandidates=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text()).group(1).replace(',','')); newCandidates=oldCandidates+256
receipt='verification/TURN1338_PHASE_RULE_COMPLETION.json';scopes={'PhaseRule': ('sft/chemistry/phase_rule_law_v1.py:PhaseRuleAccount/IndependentDegreeSupport/independent_degree_support/joint_component_phase_successor_preserves_degree_support/_account/_witnesses', 'Original identity families, positive unique component/phase supports, two distinct environmental carriers, ordered final-carrier cancellation, complete EmptyOne/positive word and count outputs, generated-name successor guards and four witnesses.'), 'PhaseRuleGrammar': ('sft/chemistry/phase_rule_law_v1.py:DIMENSIONS', 'All eight original binary axes and 256 alternatives, exact elimination, complete census and unique survivor.'), 'PhaseRuleEvidence': ('sft/chemistry/generated_observational_law.py:GeneratedObservationalChemistryProgram;sft/chemistry/phase_rule_batch_v1.py:PHASE_RULE_SPEC', 'Original dependencies, registration, closure, controls and four operation-derived witnesses.'), 'PhaseRuleExperiment': ('sft/chemistry/phase_rule_validation_v1.py:_identities/_account/prediction_program_document/experiment_registration_record', '18 value-free identities, original account construction and carrier cancellation, eight-cell words, 165 instructions and 13 registration fields.'), 'PhaseRuleSource': ('sft/chemistry/phase_rule_validation_v1.py:_source_rows;PhaseRuleValidator.validate:target_values', 'Original identity/target/primary/IUPAC/NIST/NIST-extracted-text byte guards, all 18 bound component/phase records, and exact positive-count/EmptyOne targets.'), 'PhaseRuleAnalysis': ('sft/chemistry/phase_rule_validation_v1.py:exact_phase_rule_analysis', 'All 13 analysis fields, class counts 3/4/5/6,14 positive/four EmptyOne outcomes, original relation inscription, exact cardinal balance, positive identity guards and source/empirical-boundary flags.'), 'PhaseRulePrediction': ('sft/chemistry/phase_rule_validation_v1.py:_prediction_map', 'Original 18-row eight-cell table, identity/word and uniqueness guards; eleven source-domain cases.'), 'PhaseRuleValidation': ('sft/chemistry/phase_rule_validation_v1.py:PhaseRuleValidator.validate', 'All 18 original source/count/degree/law comparisons, first-row degree=9 tamper, six controls, full 13-field analysis and twelve-field 27-message receipt.')}
oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[];corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text())
corr['modules']=[row for row in corr['modules'] if row.get('v3_claim')!=cid]
for m,(src,scope)in scopes.items():
 rel='SFT/Chemistry/'+m+'.lean';names=['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];newNames += [n for n in names if n not in oldNames];assert all(n in auditNames for n in names)
 corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=src,lean_source_sha256=hashes[rel],domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
evidence=reports+['phase1338_independent_report.json','phase1338_empirical_output.json','phase1338_program_output.json'];dest=r/'verification/TURN1338_PHASE_RULE';dest.mkdir(exist_ok=True)
for n in evidence:shutil.copyfile(w/n,dest/n)
record=dict(status='complete',registered_at=now,claim_id=cid,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_component_correspondence={m:dict(source=p,component=s)for m,(p,s)in scopes.items()},lean_source_sha256=hashes,dependencies={d:'complete'for d in x['v3_registration']['dependencies']},candidate_rows=256,original_target_rows=18,empirical_fields=12,measurement_messages=27,axiom_dependencies=[],audited_declarations=auditNames,added_registered_theorems=newNames,remaining=[],checks={n:H(w/n)for n in evidence})
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',lean_modules=list(hashes),remaining=[],completion_evidence=receipt,artifact_runtime_parity='PASS all original256candidate programme fields and hashes, original and three adverse independent cases,full twelve-field 27-message empirical receipt and complete 18-row phase-rule source comparison',verified_scope='; '.join(v[1]for v in scopes.values()))
c['summary'].update(fully_reconstructed_claims=newCount,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(auditNames));c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for fn in ['README.md','ZENODO_PAPER_DRAFT.txt','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [(f'{oldCount} / 2,781',f'{newCount} / 2,781'),(f'{oldCount} entries complete',f'{newCount} entries complete'),(f'{oldCount} completed entries',f'{newCount} completed entries'),(f'{oldCount} V3 entries verified',f'{newCount} V3 entries verified'),(f'{oldCount} model entries complete',f'{newCount} model entries complete'),(f'{oldCount} completed source entries',f'{newCount} completed source entries'),(f'{2781-oldCount:,} entries remain unfinished.',f'{2781-newCount:,} entries remain unfinished.'),(f'{old["axiom_free_exported_results"]:,}',f'{c["summary"]["axiom_free_exported_results"]:,}'),(f'{old["axiom_free_audited_definitions_and_theorems"]:,}',f'{c["summary"]["axiom_free_audited_definitions_and_theorems"]:,}'),(f'{oldCandidates:,}',f'{newCandidates:,}')]:s=s.replace(a,b)
 if fn=='README.md':s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s)
 if fn.endswith('.svg'):s=s.replace(f'{oldCount:,} / 2,781',f'{newCount:,} / 2,781').replace(f'{oldCount} / 2,781',f'{newCount:,} / 2,781')
 if fn=='ZENODO_PAPER_DRAFT.txt':
  s=s.replace('Native builds, axiom audits and these comparisons are queued; this entry is not registered complete.','Native builds, empty-axiom audits and the complete original programme/empirical comparisons pass. Completion receipt: verification/TURN1338_PHASE_RULE_COMPLETION.json. Timeline: TURN1338.')
  s=s.replace('Phase Rule native empirical verification remains pending.','Phase Rule native empirical verification passes; completion receipt: verification/TURN1338_PHASE_RULE_COMPLETION.json.')

 if fn=='README.md':s=re.sub(r'^## [0-9,]+ / 2,781 V3 entries complete',f'## {newCount:,} / 2,781 V3 entries complete',s,flags=re.M)
 if fn=='ZENODO_PAPER_DRAFT.txt':s=re.sub(r'Current native verification: [0-9,]+ entries complete\.',f'Current native verification: {newCount:,} entries complete.',s)
 p.write_text(s)
with(r/'ZENODO_PAPER_DRAFT.txt').open('a')as f:f.write('\nPhase Rule verification is complete. All '+str(len(auditNames))+' audited declarations have empty axiom dependencies. All 145 core/domain cases, 21 complete thirteen-field analysis cases, eleven prediction cases, 165 instructions, thirteen registration fields, 256 programme alternatives and three adverse independent cases agree with V3. The full twelve-field, 27-message empirical result agrees, including eighteen states, fourteen positive outcomes, four EmptyOne boundaries and six controls. Completion receipt: '+receipt+'. Timeline: TURN1338.\n')
# Keep the completion evidence beside its existing mathematical derivation.
paperPath=r/'ZENODO_PAPER_DRAFT.txt';paperText=paperPath.read_text()
completionParagraph=next(line for line in reversed(paperText.splitlines()) if line.strip())
assert 'complete' in completionParagraph
at=paperText.rfind(completionParagraph);paperText=paperText[:at]+paperText[at+len(completionParagraph):]
completionParagraph=re.sub(r'(?<=\d)(?=(?:original|prediction|instructions|registration|programme|analysis)\b)',' ',completionParagraph)
completionParagraph=re.sub(r',(?=[A-Za-z])',', ',completionParagraph)
section=re.search(r'^1164\. ',paperText,re.M);assert section
following=re.search(r'^\d+\. ',paperText[section.end():],re.M);assert following
end=section.end()+following.start();body=paperText[section.start():end]
body=re.sub(r'^Current native evidence:[^\n]*\n','',body,flags=re.M)
paperText=paperText[:section.start()]+body.rstrip()+'\n\n'+completionParagraph+'\n\n'+paperText[end:]
paperPath.write_text(paperText)
with(r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1338 registration — '+now+' — Phase Rule complete at '+str(newCount)+'. Checked eight native modules/current hashes,145 core/21 analysis/11 prediction cases, complete original programme/empirical receipt and registered dependencies; updated counts, correspondence, paper and timeline.\n')

nextId=next(y['claim_id']for y in c['claims']if y['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in y['v3_registration']['dependencies']))
p=r/'CONTINUATION_STATE.json';s=json.loads(p.read_text());s.setdefault('phase1338',{}).update(status='complete',receipt=receipt);s['scientific_cursor'].update(completed=cid,next=nextId,next_milestone=1250,action='Continue '+nextId+' from its actual retained job or source/proof evidence. Preserve live checks; do not repeat completed work.');s['authorized_action']=str(newCount)+'complete. Reconcile actual source and existing implementation for '+nextId+' then continue dependency order toward1250. Reuse existing proofs,keep processes bounded and update paper/timeline/counts/GitHub. Pause only with full1250review package ready.';p.write_text(json.dumps(s,indent=2)+'\n');print(json.dumps(c['summary']))

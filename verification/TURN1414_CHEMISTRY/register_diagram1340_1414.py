from pathlib import Path
import json,re,hashlib,datetime,shutil,fcntl
w=Path('work');r=w/'turn1064_recovery';lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();now=datetime.datetime.now(datetime.timezone.utc).isoformat();cid='SFT-CHEM-MULTICOMPONENT-PHASE-DIAGRAM-013'
reports=['diagram1340_analysis_report.json','diagram1340_core_report.json','diagram1340_prediction_report.json','diagram1340_experiment_report.json','diagram1340_full_audit_report.json','diagram1340_program_report.json','diagram1340_empirical_report.json','diagram1340_original_report.json']
for n in reports:assert json.loads((w/n).read_text())['status']=='PASS',n
ind=json.loads((w/'diagram1340_independent_report.json').read_text());assert len(ind)==4 and all(x['result']['passed']==(x['case']=='original')for x in ind)
assert json.loads((w/'diagram1340_empirical_output.json').read_text())==json.loads((w/'diagram1340_original_empirical_current.json').read_text())
audit=json.loads((w/'diagram1340_full_audit_report.json').read_text())
assert len(audit['source_sha256'])==8
auditNames=audit['declarations'];hashes=audit['source_sha256'];assert len(auditNames)==len(set(auditNames))
for p,h in hashes.items():assert H(r/p)==h,p
for name in reports:
 report=json.loads((w/name).read_text())
 for path,h in report.get('source_sha256',{}).items():
  rel=path if path.startswith('SFT/') else 'SFT/Chemistry/'+path+'.lean'
  assert H(r/rel)==h,(name,rel)
assert json.loads((w/'diagram1340_core_report.json').read_text())['cases']==70
assert json.loads((w/'diagram1340_prediction_report.json').read_text())['cases']==11
assert json.loads((w/'diagram1340_experiment_report.json').read_text())['instructions']==1279
assert json.loads((w/'diagram1340_analysis_report.json').read_text())['cases']==32
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status'] in ['pending','in_progress'];assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();assert 752 <= old['fully_reconstructed_claims'] < 1250; oldCount=old['fully_reconstructed_claims']; newCount=oldCount+1; oldCandidates=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text()).group(1).replace(',','')); newCandidates=oldCandidates+256
receipt='verification/TURN1340_MULTICOMPONENT_DIAGRAM_COMPLETION.json';scopes={'MulticomponentPhaseDiagram': ('sft/chemistry/multicomponent_phase_diagram_law_v1.py:PhaseCompositionCoordinate/_positive_coordinate_sum/ExactPhaseCompositionWord/ComponentExchangeSupport/MulticomponentCoexistencePoint/multicomponent_two_phase_degree_support/FiniteMulticomponentDiagram/append_coexistence_point/common_exchange_replication_preserves_point/_point/_witnesses', 'Exact stored ratios and EmptyOne coordinates, positive sums closing to One, two distinct phase words with identical ordered components/exchange support, exact balance, Phase Rule ranks, finite diagram, append and common replication.'), 'MulticomponentPhaseDiagramGrammar': ('sft/chemistry/multicomponent_phase_diagram_law_v1.py:DIMENSIONS', 'Eight original binary axes, all256 alternatives, original elimination, exhaustive census and unique survivor.'), 'MulticomponentPhaseDiagramEvidence': ('sft/chemistry/generated_observational_law.py:GeneratedObservationalChemistryProgram;sft/chemistry/multicomponent_phase_diagram_batch_v1.py:MULTICOMPONENT_PHASE_DIAGRAM_SPEC', 'Original dependencies, registration, closure, controls and four operation-derived witnesses.'), 'MulticomponentPhaseDiagramExperiment': ('sft/chemistry/multicomponent_phase_diagram_validation_v1.py:_identities/prediction_program_document/experiment_registration_record', '116 value-free identities including65 binary/51 ternary; comma-joined original dataset ordinals,10-cell words,1279 instructions and13 registration fields.'), 'MulticomponentPhaseDiagramSource': ('sft/chemistry/multicomponent_phase_diagram_validation_v1.py:_source_rows', 'Original target/primary/raw/landing-byte guards, separate target-count guard,116 complete identity/target bindings and post-seal payload hashes.'), 'MulticomponentDiagramAnalysis': ('sft/chemistry/multicomponent_phase_diagram_validation_v1.py:_coordinate/_phase_word/exact_multicomponent_analysis', 'All23 fields; actual binary/ternary complements, native phase-word construction/closure/componentwise exchange/Phase Rule rank,566 coordinates,12 EmptyOne,8 equal binary pairs, exact bounds and source/no-fit guards.'), 'MulticomponentPhaseDiagramPrediction': ('sft/chemistry/multicomponent_phase_diagram_validation_v1.py:_prediction_map', 'Original116-record ten-cell table, identity/word and uniqueness guards;11 source-domain cases.'), 'MulticomponentPhaseDiagramValidation': ('sft/chemistry/multicomponent_phase_diagram_validation_v1.py:MulticomponentPhaseDiagramValidator.validate', '116 identity/law/post-seal hash comparisons; original first-ternary-row liquid-coordinate=2 tamper;7 controls; full23-field analysis and twelve-field128-message receipt.')}
oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[];corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text())
corr['modules']=[row for row in corr['modules'] if row.get('v3_claim')!=cid]
for m,(src,scope)in scopes.items():
 rel='SFT/Chemistry/'+m+'.lean';names=['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];newNames += [n for n in names if n not in oldNames];assert all(n in auditNames for n in names)
 corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=src,lean_source_sha256=hashes[rel],domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
evidence=reports+['diagram1340_independent_report.json','diagram1340_empirical_output.json','diagram1340_program_output.json'];dest=r/'verification/TURN1340_MULTICOMPONENT_DIAGRAM';dest.mkdir(exist_ok=True)
for n in evidence:shutil.copyfile(w/n,dest/n)
record=dict(status='complete',registered_at=now,claim_id=cid,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_component_correspondence={m:dict(source=p,component=s)for m,(p,s)in scopes.items()},lean_source_sha256=hashes,dependencies={d:'complete'for d in x['v3_registration']['dependencies']},candidate_rows=256,original_target_rows=116,empirical_fields=12,measurement_messages=128,axiom_dependencies=[],audited_declarations=auditNames,added_registered_theorems=newNames,remaining=[],checks={n:H(w/n)for n in evidence})
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',lean_modules=list(hashes),remaining=[],completion_evidence=receipt,artifact_runtime_parity='PASS all original256candidate programme fields and hashes, original and three adverse independent cases,full twelve-field128-message empirical receipt and complete116-record multicomponent source comparison',verified_scope='; '.join(v[1]for v in scopes.values()))
c['summary'].update(fully_reconstructed_claims=newCount,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(auditNames));c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for fn in ['README.md','ZENODO_PAPER_DRAFT.txt','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [(f'{oldCount} / 2,781',f'{newCount} / 2,781'),(f'{oldCount} entries complete',f'{newCount} entries complete'),(f'{oldCount} completed entries',f'{newCount} completed entries'),(f'{oldCount} V3 entries verified',f'{newCount} V3 entries verified'),(f'{oldCount} model entries complete',f'{newCount} model entries complete'),(f'{oldCount} completed source entries',f'{newCount} completed source entries'),(f'{2781-oldCount:,} entries remain unfinished.',f'{2781-newCount:,} entries remain unfinished.'),(f'{old["axiom_free_exported_results"]:,}',f'{c["summary"]["axiom_free_exported_results"]:,}'),(f'{old["axiom_free_audited_definitions_and_theorems"]:,}',f'{c["summary"]["axiom_free_audited_definitions_and_theorems"]:,}'),(f'{oldCandidates:,}',f'{newCandidates:,}')]:s=s.replace(a,b)
 if fn=='README.md':s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s)
 if fn.endswith('.svg'):s=s.replace(f'{oldCount:,} / 2,781',f'{newCount:,} / 2,781').replace(f'{oldCount} / 2,781',f'{newCount:,} / 2,781')
 if fn=='ZENODO_PAPER_DRAFT.txt':
  s=s.replace('Native verification remains pending. Pinned V3: sft/chemistry/multicomponent_phase_diagram_law_v1.py:','Native verification passes; completion receipt: verification/TURN1340_MULTICOMPONENT_DIAGRAM_COMPLETION.json. Pinned V3: sft/chemistry/multicomponent_phase_diagram_law_v1.py:')
  s=s.replace('Multicomponent Diagram native empirical verification remains pending.','Multicomponent Diagram native empirical verification passes; completion receipt: verification/TURN1340_MULTICOMPONENT_DIAGRAM_COMPLETION.json.')

 if fn=='README.md':s=re.sub(r'^## [0-9,]+ / 2,781 V3 entries complete',f'## {newCount:,} / 2,781 V3 entries complete',s,flags=re.M)
 if fn=='ZENODO_PAPER_DRAFT.txt':s=re.sub(r'Current native verification: [0-9,]+ entries complete\.',f'Current native verification: {newCount:,} entries complete.',s)
 p.write_text(s)
with(r/'ZENODO_PAPER_DRAFT.txt').open('a')as f:f.write('\nMulticomponent phase-diagram verification is complete. All '+str(len(auditNames))+' audited declarations have empty axiom dependencies. All70 core/domain cases,32 complete23-field analysis cases,11 prediction cases,1279 instructions,13 registration fields,256 programme alternatives and three adverse independent cases agree with V3. The full twelve-field128-message receipt agrees, including65 binary/51 ternary records,566 coordinates,12 EmptyOne boundaries and7 controls. Completion receipt: '+receipt+'. Timeline: TURN1340.\n')
# Keep the completion evidence beside its existing mathematical derivation.
paperPath=r/'ZENODO_PAPER_DRAFT.txt';paperText=paperPath.read_text()
completionParagraph=next(line for line in reversed(paperText.splitlines()) if line.strip())
assert 'complete' in completionParagraph
at=paperText.rfind(completionParagraph);paperText=paperText[:at]+paperText[at+len(completionParagraph):]
completionParagraph=re.sub(r'(?<=\d)(?=(?:original|prediction|instructions|registration|programme|analysis)\b)',' ',completionParagraph)
completionParagraph=re.sub(r',(?=[A-Za-z])',', ',completionParagraph)
section=re.search(r'^1168\. ',paperText,re.M);assert section
following=re.search(r'^\d+\. ',paperText[section.end():],re.M);assert following
end=section.end()+following.start();body=paperText[section.start():end]
body=re.sub(r'^Current native evidence:[^\n]*\n','',body,flags=re.M)
paperText=paperText[:section.start()]+body.rstrip()+'\n\n'+completionParagraph+'\n\n'+paperText[end:]
paperPath.write_text(paperText)
with(r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1340 registration — '+now+' — Multicomponent Diagram complete at '+str(newCount)+'. Checked eight native modules/current hashes,70 core/32 analysis/11 prediction cases, complete programme/empirical receipt and dependencies; updated counts, correspondence, paper and timeline.\n')

nextId=next(y['claim_id']for y in c['claims']if y['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in y['v3_registration']['dependencies']))
p=r/'CONTINUATION_STATE.json';s=json.loads(p.read_text());s.setdefault('diagram1340',{}).update(status='complete',receipt=receipt);s['scientific_cursor'].update(completed=cid,next=nextId,next_milestone=1250,action='Continue '+nextId+' from its actual retained job or source/proof evidence. Preserve live checks; do not repeat completed work.');s['authorized_action']=str(newCount)+'complete. Reconcile actual source and existing implementation for '+nextId+' then continue dependency order toward1250. Reuse existing proofs,keep processes bounded and update paper/timeline/counts/GitHub. Pause only with full1250review package ready.';p.write_text(json.dumps(s,indent=2)+'\n');print(json.dumps(c['summary']))

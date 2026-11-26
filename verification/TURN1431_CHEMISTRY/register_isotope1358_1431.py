from pathlib import Path
import json,re,hashlib,datetime,shutil,fcntl
w=Path('work');r=w/'turn1064_recovery';lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();now=datetime.datetime.now(datetime.timezone.utc).isoformat();cid='SFT-CHEM-KINETIC-ISOTOPE-EFFECT-RELATION-012'
reports=['isotope1358_analysis_report.json','isotope1358_core_report.json','isotope1358_prediction_report.json','isotope1358_experiment_report.json','isotope1358_full_audit_report.json','isotope1358_program_report.json','isotope1358_empirical_report.json','isotope1358_original_report.json']
for n in reports:assert json.loads((w/n).read_text())['status']=='PASS',n
ind=json.loads((w/'isotope1358_independent_report.json').read_text());assert len(ind)==4 and all(x['result']['passed']==(x['case']=='original')for x in ind)
assert json.loads((w/'isotope1358_empirical_output.json').read_text())==json.loads((w/'isotope1358_original_empirical_current.json').read_text())
audit=json.loads((w/'isotope1358_full_audit_report.json').read_text())
assert len(audit['source_sha256'])==8
auditNames=audit['declarations'];hashes=audit['source_sha256'];assert len(auditNames)==len(set(auditNames))
for p,h in hashes.items():assert H(r/p)==h,p
for name in reports:
 report=json.loads((w/name).read_text())
 for path,h in report.get('source_sha256',{}).items():
  rel=path if path.startswith('SFT/') else 'SFT/Chemistry/'+path+'.lean'
  assert H(r/rel)==h,(name,rel)
assert json.loads((w/'isotope1358_core_report.json').read_text())['cases']==76
assert json.loads((w/'isotope1358_prediction_report.json').read_text())['cases']==11
assert json.loads((w/'isotope1358_experiment_report.json').read_text())['instructions']==926
assert json.loads((w/'isotope1358_analysis_report.json').read_text())['cases']==28
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status'] in ['pending','in_progress'];assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();assert 752 <= old['fully_reconstructed_claims'] < 1250; oldCount=old['fully_reconstructed_claims']; newCount=oldCount+1; oldCandidates=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text()).group(1).replace(',','')); newCandidates=oldCandidates+256
receipt='verification/TURN1358_KINETIC_ISOTOPE_EFFECT_COMPLETION.json';scopes={'KineticIsotopeEffect': ('sft/chemistry/kinetic_isotope_effect_law_v1.py:ExactPositiveEventRate/RetainedIsotopologuePath/CompleteIsotopologueRatePair/ExactKineticIsotopeEffectRelation/forced_kinetic_isotope_effect_relation/RegisteredIsotopologuePairOccurrence/CompleteKineticIsotopeFamily/append_isotopologue_pair_preserves_complete_family/OPERATIONAL_WITNESSES', 'Exact positive event counts and fractions,seven-field path with distinct ordered roles,distinct isotope pair with identical reaction/path/roles/condition,six-field ordered quotient and held orientation,complete source-family successor.'), 'KineticIsotopeEffectGrammar': ('sft/chemistry/kinetic_isotope_effect_law_v1.py:DIMENSIONS', 'Eight original binary axes,all256alternatives,original elimination and unique survivor.'), 'KineticIsotopeEffectEvidence': ('sft/chemistry/kinetic_isotope_effect_batch_v1.py:KINETIC_ISOTOPE_EFFECT_SPEC;sft/chemistry/generated_observational_law.py:GeneratedObservationalChemistryProgram', 'Original registration,dependencies,closure,controls and four source witnesses.'), 'KineticIsotopeEffectAnalysis': ('sft/chemistry/kinetic_isotope_effect_validation_v1.py:_exact_pair/exact_kinetic_isotope_effect_analysis', 'Twenty original fields,normal/inverse/equal relations,47pages23worksheets923260cells39002rows,90ratio rows3decays,replicate and temperature vectors,all original adverse/provenance boundaries.'), 'KineticIsotopeEffectExperiment': ('sft/chemistry/kinetic_isotope_effect_validation_v1.py:_identities/prediction_program_document/experiment_registration_record', '71value-free identities,twelve forbidden keys,seven coordinates,926instructions,twelve-cellwords,fourteen registration fields and five sourcefiles.'), 'KineticIsotopeEffectSource': ('sft/chemistry/kinetic_isotope_effect_validation_v1.py:_source_rows', 'Target/primary/all five source byte guards;71targets47pages23worksheets,eight identitybindings,nonempty payloads and postseal hashes.'), 'KineticIsotopeEffectPrediction': ('sft/chemistry/kinetic_isotope_effect_validation_v1.py:_prediction_map', '71-row twelve-cell table,target/word/identity uniqueness guards,eleven original-domain cases.'), 'KineticIsotopeEffectValidation': ('sft/chemistry/kinetic_isotope_effect_validation_v1.py:KineticIsotopeEffectValidator.validate', '71identity/law/target comparisons,original custody,omission and actual mismatched-path controls,eight controls,twelve-field84message receipt.')}
oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[];corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text())
corr['modules']=[row for row in corr['modules'] if row.get('v3_claim')!=cid]
for m,(src,scope)in scopes.items():
 rel='SFT/Chemistry/'+m+'.lean';names=['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];newNames += [n for n in names if n not in oldNames];assert all(n in auditNames for n in names)
 corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=src,lean_source_sha256=hashes[rel],domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
evidence=reports+['isotope1358_independent_report.json','isotope1358_empirical_output.json','isotope1358_program_output.json'];dest=r/'verification/TURN1358_KINETIC_ISOTOPE_EFFECT';dest.mkdir(exist_ok=True)
for n in evidence:shutil.copyfile(w/n,dest/n)
record=dict(status='complete',registered_at=now,claim_id=cid,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_component_correspondence={m:dict(source=p,component=s)for m,(p,s)in scopes.items()},lean_source_sha256=hashes,dependencies={d:'complete'for d in x['v3_registration']['dependencies']},candidate_rows=256,original_target_rows=71,empirical_fields=12,measurement_messages=84,axiom_dependencies=[],audited_declarations=auditNames,added_registered_theorems=newNames,remaining=[],checks={n:H(w/n)for n in evidence})
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',lean_modules=list(hashes),remaining=[],completion_evidence=receipt,artifact_runtime_parity='PASS official pinned execution manifest,all256programme alternatives,original/threeadverse independent cases,76core/28analysis/11prediction cases,926instructions/14registration fields and full12field84message empirical receipt',verified_scope='; '.join(v[1]for v in scopes.values()))
c['summary'].update(fully_reconstructed_claims=newCount,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(auditNames));c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for fn in ['README.md','ZENODO_PAPER_DRAFT.txt','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [(f'{oldCount} / 2,781',f'{newCount} / 2,781'),(f'{oldCount} entries complete',f'{newCount} entries complete'),(f'{oldCount} completed entries',f'{newCount} completed entries'),(f'{oldCount} V3 entries verified',f'{newCount} V3 entries verified'),(f'{oldCount} model entries complete',f'{newCount} model entries complete'),(f'{oldCount} completed source entries',f'{newCount} completed source entries'),(f'{2781-oldCount:,} entries remain unfinished.',f'{2781-newCount:,} entries remain unfinished.'),(f'{old["axiom_free_exported_results"]:,}',f'{c["summary"]["axiom_free_exported_results"]:,}'),(f'{old["axiom_free_audited_definitions_and_theorems"]:,}',f'{c["summary"]["axiom_free_audited_definitions_and_theorems"]:,}'),(f'{oldCandidates:,}',f'{newCandidates:,}')]:s=s.replace(a,b)
 if fn=='README.md':s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s)
 if fn.endswith('.svg'):s=s.replace(f'{oldCount:,} / 2,781',f'{newCount:,} / 2,781').replace(f'{oldCount} / 2,781',f'{newCount:,} / 2,781')

 if fn=='README.md':s=re.sub(r'^## [0-9,]+ / 2,781 V3 entries complete',f'## {newCount:,} / 2,781 V3 entries complete',s,flags=re.M)
 if fn=='ZENODO_PAPER_DRAFT.txt':s=re.sub(r'Current native verification: [0-9,]+ entries complete\.',f'Current native verification: {newCount:,} entries complete.',s)
 p.write_text(s)
with(r/'ZENODO_PAPER_DRAFT.txt').open('a')as f:f.write('\nKinetic isotope effect verification is complete. All '+str(len(auditNames))+' audited declarations have empty axiom dependencies. All76core cases,28twenty-field analysis cases,eleven prediction cases,926instructions,fourteen registration fields,256programme alternatives and three independent adverse cases agree with the official pinned V3 execution. The twelve-field84message empirical receipt agrees,including71records and eight controls. Completion receipt: '+receipt+'. Timeline: TURN1358.\n')
# Keep the completion evidence beside its existing mathematical derivation.
paperPath=r/'ZENODO_PAPER_DRAFT.txt';paperText=paperPath.read_text()
completionParagraph=next(line for line in reversed(paperText.splitlines()) if line.strip())
assert 'complete' in completionParagraph
at=paperText.rfind(completionParagraph);paperText=paperText[:at]+paperText[at+len(completionParagraph):]
completionParagraph=re.sub(r'(?<=\d)(?=(?:original|prediction|instructions|registration|programme|analysis)\b)',' ',completionParagraph)
completionParagraph=re.sub(r',(?=[A-Za-z])',', ',completionParagraph)
section=re.search(r'^1205\. ',paperText,re.M);assert section
following=re.search(r'^\d+\. ',paperText[section.end():],re.M);assert following
end=section.end()+following.start();body=paperText[section.start():end]
body=re.sub(r'^Current native evidence:[^\n]*\n','',body,flags=re.M)
paperText=paperText[:section.start()]+body.rstrip()+'\n\n'+completionParagraph+'\n\n'+paperText[end:]
paperPath.write_text(paperText)
with(r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1358 registration — '+now+' — Kinetic isotope effect complete at '+str(newCount)+'. Verified eight native source hashes,76core/28analysis/11prediction cases,official pinned execution programme,full empirical receipt and originaldependencies;updated counts,correspondence,paper and timeline.\n')

nextId=next(y['claim_id']for y in c['claims']if y['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in y['v3_registration']['dependencies']))
p=r/'CONTINUATION_STATE.json';s=json.loads(p.read_text());s.setdefault('isotope1358',{}).update(status='complete',receipt=receipt);s['scientific_cursor'].update(completed=cid,next=nextId,next_milestone=1250,action='Continue '+nextId+' from its actual retained job or source/proof evidence. Preserve live checks; do not repeat completed work.');s['authorized_action']=str(newCount)+'complete. Reconcile actual source and existing implementation for '+nextId+' then continue dependency order toward1250. Reuse existing proofs,keep processes bounded and update paper/timeline/counts/GitHub. Pause only with full1250review package ready.';p.write_text(json.dumps(s,indent=2)+'\n');print(json.dumps(c['summary']))

from pathlib import Path
import json,re,hashlib,datetime,shutil,fcntl,sys
w=Path('work');r=w/'turn1064_recovery';name=sys.argv[1];row=next(x for x in json.loads((w/'nonordinary1394_plan.json').read_text())if x['name']==name);cid=row['claim_id'];lock=(w/'entry_registration.lock').open('a');fcntl.flock(lock,fcntl.LOCK_EX);H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();now=datetime.datetime.now(datetime.timezone.utc).isoformat()
reports=['core1395_audit_report.json','nonordinary1395_records_report.json',name+'1395_audit_report.json',name+'1395_original_report.json',name+'1395_program_report.json']
if name=='NonordinaryFamily':reports+=['external1395_audit_report.json','nonordinary1395_empirical_report.json']
hashes={};auditNames=[]
for n in reports:
 a=json.loads((w/n).read_text());assert a['status']=='PASS',n
 for rel,h in a.get('source_sha256',{}).items():assert H(r/rel)==h,(n,rel);hashes[rel]=h
 if 'declarations'in a:auditNames+=a['declarations']
assert len(auditNames)==len(set(auditNames))
program=json.loads((w/(name+'1395_program_report.json')).read_text());assert program['candidates']==256 and program['all_fields_and_hashes'];assert len(program['independent_cases'])==4 and all(x['result']['passed']==(x['case']=='original')for x in program['independent_cases'])
assert json.loads((w/(name+'1395_program_output.json')).read_text())==json.loads((w/(name+'1395_expected.json')).read_text())
if name=='NonordinaryFamily':assert json.loads((w/'nonordinary1395_empirical_output.json').read_text())==json.loads((w/'nonordinary1395_empirical_expected.json').read_text())
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};entry=by[cid]
if entry['lean_status']=='complete':print('REUSE registered',cid);raise SystemExit(0)
assert all(by[d]['lean_status']=='complete'for d in entry['v3_registration']['dependencies']);old=c['summary'].copy();oldCount=old['fully_reconstructed_claims'];assert oldCount<1000;newCount=oldCount+1
receipt='verification/TURN1395_'+name.upper()+'_COMPLETION.json';dest=r/receipt.replace('_COMPLETION.json','');dest.mkdir(parents=True,exist_ok=True)
scopes={
 'NonordinaryLaws':('sft/consciousness/nonordinary_laws_v1.py:directional_synaesthesia_record/three_quality_orbit/sleep_dream_orbit/cessation_lock_anchor','Four exact records, all31fields, existing complete Fold fibre, two-/three-state transitions, computed partitions, directed routes, original held flags and named operational witnesses.'),
 name+'Grammar':('sft/consciousness/nonordinary_laws_v1.py:axes/make_spec;sft/physics/structural_constants.py:candidate_rows/survivor_id/decision_reason','All eight source binary axes and all256ordered alternatives; full constructor enumeration, source rejection order, completeness and unique preserving tuple.'),
 name+'Evidence':('sft/consciousness/nonordinary_laws_v1.py:StructuralConsciousnessProgram/SPECS;sft/physics/structural_constants.py:StructuralPhysicsProgram','Exact source registration, root/dependency binding, census/completeness hash, every decision, closure, four original controls and unknown-candidate behavior; independently reconstructed source mechanism.')}
if name=='NonordinaryFamily':
 scopes.update({'NonordinaryExternalSource':('sft/consciousness/nonordinary_external_v1.py:normalize/source_target','Original two observation collections, identity-before-content and byte-hash guards, exact source normalization/casefold, all27records, last-record PMID binding, required observations and retained result classes.'),'NonordinaryExternalExperiment':('sft/consciousness/nonordinary_external_v1.py:external_registration_record/prediction_program_document','Exact registration, original four instructions and sealed-input envelope.'),'NonordinaryExternalValidation':('sft/consciousness/nonordinary_external_v1.py:BlindConsciousnessReturnExternalValidator.validate','Native source-derived target, prediction execution/seal, hostile-package audit, target custody/release, exact comparison/tampered control, full12-field7-message original result including every receipt hash.')})
corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());existingModules={x.get('lean_module')for x in corr['modules']};oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[];newAuditNames=[]
for m,(src,scope)in scopes.items():
 rel='SFT/Consciousness/'+m+'.lean';assert rel in hashes
 names=['SFT.Consciousness.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];assert all(n in auditNames for n in names);newNames +=[n for n in names if n not in oldNames]
 if rel not in existingModules:newAuditNames +=[n for n in auditNames if n.startswith('SFT.Consciousness.'+m+'.')]
 corr['modules'].append({'lean_module':rel,'v3_claim':cid,'source_path':src,'lean_source_sha256':hashes[rel],'domain':scope,'remaining':[],'completion_evidence':receipt})
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
evidence=reports+[name+'1395_program_output.json',name+'1395_expected.json','nonordinary1394_source_pin.json','nonordinary1395_original_files.json']
if name=='NonordinaryFamily':evidence+=['nonordinary1395_empirical_output.json','nonordinary1395_empirical_expected.json','nonordinary1395_empirical_files.json']
for n in evidence:shutil.copy2(w/n,dest/n)
record={'status':'complete','registered_at':now,'claim_id':cid,'source_commit':'76f1b34e9e9682989adcbb088797b4ae4ce4fcf1','source_component_correspondence':{m:{'source':p,'component':s}for m,(p,s)in scopes.items()},'lean_source_sha256':hashes,'dependencies':{d:'complete'for d in entry['v3_registration']['dependencies']},'candidate_rows':256,'axiom_dependencies':[],'audited_declarations':auditNames,'added_audited_declarations':newAuditNames,'added_registered_theorems':newNames,'remaining':[],'checks':{n:H(w/n)for n in evidence}}
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');entry.update(lean_status='complete',lean_modules=list(hashes),remaining=[],completion_evidence=receipt,artifact_runtime_parity='PASS pinned original programme, every candidate/decision/receipt field, all31record fields, original independent positive and3adverse cases'+('; full terminal12-field7-message27-source validator'if name=='NonordinaryFamily'else ''),verified_scope='; '.join(s for _,s in scopes.values()))
c['summary'].update(fully_reconstructed_claims=newCount,in_progress=sum(x['lean_status']=='in_progress'for x in c['claims']),pending=sum(x['lean_status']=='pending'for x in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(newAuditNames));c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
oldCandidates=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text())[1].replace(',',''))
for fn in ['README.md','ZENODO_PAPER_DRAFT.txt','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [(f'{oldCount} / 2,781',f'{newCount} / 2,781'),(f'{oldCount} entries complete',f'{newCount} entries complete'),(f'{oldCount} completed entries',f'{newCount} completed entries'),(f'{oldCount} V3 entries verified',f'{newCount} V3 entries verified'),(f'{oldCount} model entries complete',f'{newCount} model entries complete'),(f'{oldCount} completed source entries',f'{newCount} completed source entries'),(f'{2781-oldCount:,} entries remain unfinished.',f'{2781-newCount:,} entries remain unfinished.'),(f'{old["axiom_free_exported_results"]:,}',f'{c["summary"]["axiom_free_exported_results"]:,}'),(f'{old["axiom_free_audited_definitions_and_theorems"]:,}',f'{c["summary"]["axiom_free_audited_definitions_and_theorems"]:,}'),(f'{oldCandidates:,}',f'{oldCandidates+256:,}')]:s=s.replace(a,b)
 if fn=='README.md':s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s)
 if fn.endswith('.svg'):s=s.replace(str(oldCount),str(newCount))
 if fn=='ZENODO_PAPER_DRAFT.txt':
  sections=re.split(r'(?m)(?=^\d+\. )',s)
  plan=json.loads((w/'nonordinary1394_plan.json').read_text())
  for i,section in enumerate(sections):
   needed=plan[:2]if section.startswith('1387. ')else(plan[2:4]if section.startswith('1388. ')else(plan if section.startswith('1389. ')else []))
   if needed and all(by[z['claim_id']]['lean_status']=='complete'for z in needed):
    section=section.replace('The four-record module compiles; entry-level comparison and registration remain pending.','The corresponding native entries are complete: current-source zero-axiom audits, full original record/programme comparisons and independent controls pass; completion receipts are recorded below.')
    section=section.replace('Original programmes and independent controls pass; native entry audits, full-output comparisons and terminal empirical verification remain in progress.','All five native entries are complete, including their current-source zero-axiom audits, full original programme comparisons, independent controls and terminal empirical verification.')
    sections[i]=section
  s=''.join(sections)
 p.write_text(s)
with(r/'ZENODO_PAPER_DRAFT.txt').open('a')as f:f.write('\n'+entry['title']+' is natively verified against its original V3 entry. All source fields,256ordered alternatives, decisions, closure hashes and four original controls match. The native axiom audit is empty for all '+str(len(auditNames))+' audited declarations. Original independent reconstruction accepts the result and rejects the three adverse cases. Derivations and source references: Sections1387–1389. Completion evidence: '+receipt+'. Timeline: TURN1395.\n')
with(r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1395 registration — '+now+' — '+cid+' complete at '+str(newCount)+'. Checked current source hashes, all original source obligations and outputs, full axiom audit and original independent controls; prerequisite registrations complete. Updated correspondence, counters, paper, entry receipt and continuation cursor atomically under registration lock.\n')
p=r/'CONTINUATION_STATE.json';d=json.loads(p.read_text());d.setdefault('nonordinary1395_completions',{})[cid]=receipt;nextId=next((x['claim_id']for x in c['claims']if x['lean_status']!='complete'and all(by[dep]['lean_status']=='complete'for dep in x['v3_registration']['dependencies'])),None);d['scientific_cursor'].update(completed=cid,next=nextId,next_milestone=1000);d['authorized_action']=str(newCount)+'complete. Preserve live original jobs and continue source-bound registration toward1000; retain current nonordinary1395 and chemistry1392 checks. Full cumulative review package before milestone pause.';p.write_text(json.dumps(d,indent=2)+'\n');print(c['summary'],flush=True)

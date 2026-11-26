from pathlib import Path
import json,re,hashlib,datetime,shutil,fcntl
w=Path('work');r=w/'turn1064_recovery';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
reports=['coordisomer1473_core_report.json','coordisomer_grammar1474_entry_audit_report.json','coordisomer1474_interfaces_source_audit_report.json','coordisomer1474_validation_entry_audit_report.json','coordisomer1474_interfaces_comparison_report.json','coordisomer1474_program_report.json','coordisomer1474_empirical_report.json','coordisomer1474_original_report.json']
names=[];hashes={}
for f in reports:
 d=json.loads((w/f).read_text());assert d['status']=='PASS',f
 for m,h in d.get('source_sha256',{}).items():
  rel=m if m.startswith('SFT/')else 'SFT/Chemistry/'+m+'.lean'
  assert H(r/rel)==h,(f,rel);hashes[rel]=h
 names.extend(d.get('declarations',[]))
for log,module,expected in [('coordisomer1473_core_audit.log','CoordinationIsomerism',28),('coordisomer1474_witness_audit.log','CoordinationIsomerismWitnesses',23),('coordisomer1474_derivation_audit.log','CoordinationIsomerismDerivation',6)]:
 s=(w/log).read_text();found=re.findall(r"'([^']+)' does not depend on any axioms",s);assert len(found)==expected,(log,len(found));assert 'depends on axioms:' not in s and 'error:' not in s
 names.extend(found);rel='SFT/Chemistry/'+module+'.lean';hashes[rel]=H(r/rel)
assert len(names)==len(set(names))==184
for rel in hashes:assert not re.search(r'^\s*(axiom|opaque)\s|\b(sorry|admit)\b',re.sub(r'"(?:[^"\\]|\\.)*"|--[^\n]*', '', (r/rel).read_text()),re.M),rel
ind=json.loads((w/'coordisomer1474_independent_report.json').read_text());assert len(ind)==4 and all(x['result']['passed']==(x['case']=='original')for x in ind)
assert json.loads((w/'coordisomer1474_empirical_output.json').read_text())==json.loads((w/'coordisomer1474_original_empirical.json').read_text())
assert json.loads((w/'coordisomer1474_program_report.json').read_text())['candidates']==256
(w/'coordisomer1474_full_audit_report.json').write_text(json.dumps(dict(status='PASS',declarations=names,count=len(names),source_sha256=hashes,axiom_dependencies=[]),indent=2)+'\n')
reports+=['coordisomer1474_full_audit_report.json']
lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
now=datetime.datetime.now(datetime.timezone.utc).isoformat();cid='SFT-CHEM-COORDINATION-ISOMERISM-EQUIVALENCE-005'
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status']!='complete';assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();oldCount=old['fully_reconstructed_claims'];assert oldCount==1033;newCount=oldCount+1
receipt='verification/TURN1474_COORDINATION_ISOMERISM_COMPLETION.json';dest=r/'verification/TURN1474_COORDINATION_ISOMERISM';dest.mkdir(exist_ok=True)
scopes={
'CoordinationIsomerism':('sft/chemistry/coordination_isomerism_law_v1.py','Exact four-word constructor,complete occurrence permutations,lexicographic canonical signature,source guard order,global complement,successor and six-field ordered distinction;37 full source comparisons.'),
'CoordinationIsomerismDerivation':('sft/chemistry/coordination_isomerism_batch_v1.py:induction_base/induction_step','One-occurrence census;every occurrence selection retains all remaining positions;every selected occurrence and remaining mapping enters the census;successful successor retains all four prior components.'),
'CoordinationIsomerismWitnesses':('sft/chemistry/coordination_isomerism_law_v1.py:operational witnesses','Five original equivalence,attachment,mirror,orientation and successor witnesses;five kernel pass proofs.'),
'CoordinationIsomerismGrammar':('sft/chemistry/coordination_isomerism_batch_v1.py:DIMENSIONS','Eight binary axes,all256 candidates,original elimination and complete unique survivor.'),
'CoordinationIsomerismEvidence':('sft/chemistry/generated_observational_law.py:GeneratedObservationalChemistryProgram','Original registration,closure,dependencies,five actual witnesses and four controls.'),
'CoordinationIsomerismPrediction':('sft/chemistry/coordination_isomerism_validation_v1.py:prediction_document','Exact identity guard,seventeen targets,twelve-cell word and original forbidden-key boundary.'),
'CoordinationIsomerismSource':('sft/chemistry/coordination_isomerism_validation_v1.py:source_surface','Seventeen source identities,seven identity bindings,complete source-byte guards and payload hash.'),
'CoordinationIsomerismAnalysis':('sft/chemistry/coordination_isomerism_validation_v1.py:exact_analysis','Actual native relation and successor analysis,complete source-field overwrite semantics,all17 omission tests;20 full interface comparisons.'),
'CoordinationIsomerismComparison':('sft/chemistry/coordination_isomerism_validation_v1.py:compare/controls','Six identity and five law comparisons,eight original adverse controls,two redirects and literal-term absence.'),
'CoordinationIsomerismExperiment':('sft/chemistry/coordination_isomerism_batch_v1.py:COORDINATION_ISOMERISM_SPEC','Twenty registration fields,seventeen references,complete source manifest and original source specification.'),
'CoordinationIsomerismValidation':('sft/chemistry/coordination_isomerism_validation_v1.py:validate','Exact original pre-source seal,custody,comparison identity and full12field14message empirical receipt.')}
oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[];corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());corr['modules']=[z for z in corr['modules']if z.get('v3_claim')!=cid]
for m,(source,scope) in scopes.items():
 rel='SFT/Chemistry/'+m+'.lean';ths=['SFT.Chemistry.'+m+'.'+t for t in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];assert all(t in names for t in ths)
 newNames.extend(t for t in ths if t not in oldNames);corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=source,lean_source_sha256=hashes[rel],domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
evidence=reports+['coordisomer1474_independent_report.json','coordisomer1474_empirical_output.json','coordisomer1474_original_empirical.json','coordisomer1474_program_output.json','coordisomer1474_source_pin.json','coordisomer1474_witness_audit.log','coordisomer1474_derivation_audit.log','coordisomer1474_interfaces_output.json','coordisomer1474_interfaces_expected.json']
for n in evidence:shutil.copyfile(w/n,dest/n)
record=dict(status='complete',registered_at=now,claim_id=cid,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_component_correspondence={m:dict(source=p,component=s)for m,(p,s)in scopes.items()},lean_source_sha256=hashes,dependencies={d:'complete'for d in x['v3_registration']['dependencies']},candidate_rows=256,original_target_rows=17,empirical_fields=12,measurement_messages=14,axiom_dependencies=[],audited_declarations=names,added_registered_theorems=newNames,remaining=[],checks={n:H(w/n)for n in evidence})
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',lean_modules=list(hashes),remaining=[],completion_evidence=receipt,artifact_runtime_parity='PASS pinned full256programme,original/threeadverse independent cases,37core/20interface cases and full12field14message empirical receipt',verified_scope='; '.join(s for p,s in scopes.values()))
c['summary'].update(fully_reconstructed_claims=newCount,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(names));c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
oldCandidates=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text()).group(1).replace(',',''))
for fn in ['README.md','ZENODO_PAPER_DRAFT.txt','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [(f'{oldCount} / 2,781',f'{newCount} / 2,781'),(f'{oldCount:,} / 2,781',f'{newCount:,} / 2,781'),(f'{oldCount} entries complete',f'{newCount} entries complete'),(f'{oldCount:,} entries complete',f'{newCount:,} entries complete'),(f'{2781-oldCount:,} entries remain unfinished.',f'{2781-newCount:,} entries remain unfinished.'),(f'{old["axiom_free_exported_results"]:,}',f'{c["summary"]["axiom_free_exported_results"]:,}'),(f'{old["axiom_free_audited_definitions_and_theorems"]:,}',f'{c["summary"]["axiom_free_audited_definitions_and_theorems"]:,}'),(f'{oldCandidates:,} candidate records matched',f'{oldCandidates+256:,} candidate records matched')]:s=s.replace(a,b)
 if fn=='README.md':s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s)
 p.write_text(s)
with(r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1474 registration — '+now+' — Coordination Isomerism complete at1,034. Checked all11 native source hashes,184 empty-axiom declarations,the original dependency closure,37core/20interface comparisons,256 candidates and full12field14message empirical receipt. Updated completion counts,imports,audit and correspondence.\n')
nextId=next(z['claim_id']for z in c['claims']if z['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in z['v3_registration']['dependencies']))
p=r/'CONTINUATION_STATE.json';s=json.loads(p.read_text());s['scientific_cursor'].update(completed=cid,next=nextId,next_milestone=1250,action='Continue '+nextId+' using retained source-bound work; preserve completed proofs and live process handles.');s['authorized_action']=f'{newCount} complete. Continue {nextId} in dependency order toward1250,update counts,paper,timeline and GitHub;pause at1250 with full review package.';s['coordisomer1474']=dict(status='complete',receipt=receipt);p.write_text(json.dumps(s,indent=2)+'\n');print(json.dumps(dict(count=newCount,next=nextId,declarations=len(names),theorems_added=len(newNames))))

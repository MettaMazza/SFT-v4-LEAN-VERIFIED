from pathlib import Path
import json,re,hashlib,datetime,shutil,sys
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');rec=w/'constants-recovery';tag,low,turn,cid,receipt_tag,section=sys.argv[1:];n=int(turn);section=int(section);receipt=f'verification/TURN_{n}_{receipt_tag}_COMPLETION.json';now=datetime.datetime.now(datetime.timezone.utc).isoformat();cfg=json.load(open(w/f'{low}{n}_all_proofs_config.json'))
assert json.load(open(w/'terminalckmempirical938_empirical_report.json'))['status']=='PASS'
assert (w/'timeline938_addition.txt').is_file()
for file in [f'{low}_program{n}_report.json',''+low+str(n)+'_science_report.json']:assert json.load(open(w/file))['status']=='PASS',file
cases=json.load(open(w/f'{low}_independent{n}_report.json'));assert len(cases)==4 and all(x['actual']['passed']==x['expected'] for x in cases);audit=(w/f'{low}{n}_all_audit.log').read_text();assert all("'"+name+"' does not depend on any axioms" in audit for name in cfg['declarations']);assert 'Build completed successfully' in (w/f'{low}{n}_canonical_build.log').read_text()
cov=json.load(open(r/'COVERAGE.json'));by={x['claim_id']:x for x in cov['claims']};entry=by[cid];assert entry['lean_status']=='pending';assert all(by[d]['lean_status']=='complete' for d in entry['v3_registration']['dependencies']);state=json.load(open(r/'CONTINUATION_STATE.json'));assert state['scientific_cursor']['next']==cid
paths=set();oldlog=f'verification/TURN_{n-1}C_REGISTERED_DECLARATIONS_AUDIT.log';newlog=f'verification/TURN_{n}C_REGISTERED_DECLARATIONS_AUDIT.log';previous=(r/oldlog).read_text();olddefs=set(re.findall("'([^']+)' does not depend on any axioms",previous));oldths=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newths=[x for x in cfg['theorems'] if x not in oldths];newdefs=[x for x in cfg['definitions_and_theorems'] if x not in olddefs]
scopes={
 'TerminalCKM':'Original terminal_ckm_slope_contribution and terminal_ckm_relation;two exact routes,all6 fields and source guards.',
 'TerminalQuarkRoots':'Original refined_quark_roots at1e-15;all six source intervals,exact initial isolation,repeated bisection and source-run termination proofs.',
 'TerminalCKMComparison':'Original terminal_ckm_prediction_intervals;all four exact squared intervals,all guards,full Jarlskog endpoint propagation.',
 'TerminalMatterRecords':'Original authoritative_record,source_rows;complete retained source record,seven custody conditions,two component hashes and rejection branches.',
 'TerminalCKMMeasurement':'Original three_sigma_squared,terminal_ckm_classification;all four rows,full asymmetric uncertainties,exact overlap and original classification.',
 'TerminalCKMEntryWitnesses':'Original two-route operational witness.',
 'TerminalCKMEntryGrammar':'Original complete256 law alternatives and exact elimination decisions.',
 'TerminalCKMEntryControls':'Original law controls,closure and witness bindings.',
 'TerminalCKMEntryEvidence':'Original complete StructuralPhysicsProgram with empirical mode and observational_derivation provenance.',
 'TerminalCKMEmpiricalWitnesses':'Original target-free positive terminal contribution witness.',
 'TerminalCKMEmpiricalGrammar':'Original complete256 post-seal comparison alternatives.',
 'TerminalCKMEmpiricalEvidence':'Original GeneratedEmpiricalPhysicsProgram for this precise comparison spec.',
 'TerminalCKMEmpiricalExperiment':'Original four-row experiment,snapshot identity,prediction program,target vault and complete source metadata.',
 'TerminalCKMEmpiricalValidation':'Original blind external measurement protocol plus exact terminal source classification precheck;complete output equality.'}
assert set(scopes)==set(cfg['modules']);corr=json.load(open(r/'reference/CORRESPONDENCE.json'));source='sft/physics/matter_flavour_terminal_ckm_laws_v1.py';common='sft/physics/structural_constants.py'
for m in cfg['modules']:
 rel='SFT/Physics/'+m+'.lean';p=rec/rel;data=p.read_bytes();assert hashlib.sha256(data).hexdigest()==cfg['source_sha256'][m];text=data.decode();assert not re.search(r'\bsorry\b|^\s*axiom\b',text,re.M);assert (r/rel).read_bytes()==data;paths.add(rel)
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with (r/'SFT.lean').open('a') as f:f.write(imp+'\n')
 found=next((row for key in ['modules','evidence_modules'] for row in corr[key] if row.get('module')==rel),None)
 if found is None:
  found=dict(module=rel,v3_claim=cid,source_path=source,additional_source_paths=[common,'sft/physics/matter_flavour_terminal_ckm_validation_v1.py','sft/physics/matter_flavour_terminal_ckm_execution_v1.py'],lean_source_sha256=cfg['source_sha256'][m],domain=scopes[m],implemented={name:scopes[m] for _,name in re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',text,re.M)},remaining=[],completion_evidence=receipt);corr['modules' if m.endswith('Grammar') else 'evidence_modules'].append(found)
 else:
  assert found['lean_source_sha256']==cfg['source_sha256'][m];found.setdefault('additional_claims',[]).append(cid);found.setdefault('additional_completion_evidence',[]).append(receipt)
with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+name+'\n' for name in newths))
(r/newlog).write_text(previous+'\n'+audit);paths.add(newlog)
if f'for c in SFT.Physics.{tag}Grammar.candidates do' not in (r/'Parity.lean').read_text():
 with (r/'Parity.lean').open('a') as f:f.write(f'\n  for c in SFT.Physics.{tag}Grammar.candidates do\n    IO.println ("{tag}Grammar\\t" ++ SFT.Physics.{tag}Grammar.candidateId c ++ "\\t" ++ (if SFT.Physics.{tag}Grammar.survives c then "true" else "false") ++ "\\t" ++ SFT.Physics.{tag}Grammar.exactForm c ++ "\\t" ++ SFT.Physics.{tag}Grammar.decisionReason c)\n')
files=[f'{low}{n}_all_proofs_config.json',f'{low}{n}_all_audit.log',f'{low}_program{n}_report.json',f'{low}_program{n}_output.json',f'{low}_independent{n}_report.json',f'{low}{n}_original_program.json',''+low+str(n)+'_science_report.json',''+low+str(n)+'_canonical_build.log',''+low+str(n)+'_core_audit.log']
files += ['terminalckm938_core_build.log','terminalckm938_comparison_build.log','terminalckm938_measurement_build.log','terminalckm938_empirical_build.log','terminalckm938_core_audit.log','terminalckmempirical938_empirical_report.json','terminalckmempirical938_empirical_output.json','terminalckmempirical938_original_empirical.json','terminalckm938_refinement_steps.json']
for name in files:
 rel=f'verification/TURN_{n}_'+name;shutil.copy2(w/name,r/rel);paths.add(rel)
report=dict(status='complete',registered_at=now,claim_id=cid,source_commit=cov['source_commit'],empirical_report='verification/TURN_938_terminalckmempirical938_empirical_report.json',evidence_mode='empirical',provenance=['observational_derivation'],source_component_correspondence={m:{'source':source,'shared_protocol_source':common,'component':scopes[m]} for m in cfg['modules']},lean_source_sha256=cfg['source_sha256'],dependencies={d:'complete' for d in entry['v3_registration']['dependencies']},candidate_rows=256,axiom_dependencies=[],audited_declarations=cfg['declarations'],added_registered_theorems=newths,added_audited_definitions_and_theorems=newdefs,remaining=[],program_report=f'verification/TURN_{n}_{low}_program{n}_report.json',independent_validator_cases=cases,canonical_build='PASS affected original source entry',checks_executed=['Retained source-hash-bound kernel audit of all entry declarations','lake build SFT.Physics.'+tag+'Evidence',f'check_{low}_original{n}.py',f'check_{low}{n}.py',f'check_{low}_program{n}.py with native executable',f'check_{low}_independent{n}.py'])
(r/receipt).write_text(json.dumps(report,indent=2)+'\n');paths.add(receipt)
entry.update(lean_status='complete',remaining=[],lean_modules=['SFT/Physics/'+m+'.lean' for m in cfg['modules']],completion_evidence=receipt,verified_scope='; '.join(scopes.values()),artifact_runtime_parity='PASS fresh entire256-form native program matches fresh original and pin;all four original independent-validator cases and exact source scientific outputs pass;original empirical evidence mode and observational-derivation provenance retained;complete source empirical validator output matches.')
old=cov['summary'].copy();count=old['fully_reconstructed_claims']+1;newrows=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text())[1].replace(',',''))+256;oldrows=newrows-256;cov['summary'].update(fully_reconstructed_claims=count,pending=old['pending']-1,axiom_free_exported_results=old['axiom_free_exported_results']+len(newths),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(newdefs));cov['updated_at']=now;assert count==sum(x['lean_status']=='complete' for x in cov['claims']);(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newths));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;s=p.read_text()
 for tail in [' / 2,781',' V3 entries verified',' model entries',' completed entries',' completed source entries',' source entries']:s=s.replace(str(count-1)+tail,str(count)+tail)
 for field in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:s=s.replace(f"{old[field]:,}",f"{cov['summary'][field]:,}")
 s=s.replace(f'{oldrows:,}',f'{newrows:,}').replace(f"{old['pending']:,} entries remain pending",f"{cov['summary']['pending']:,} entries remain pending")
 if name=='README.md':s=re.sub(r'(\[latest completion evidence\]\()[^)]+',lambda m:m.group(1)+receipt,s).replace(oldlog,newlog)
 if name=='ZENODO_PAPER_DRAFT.txt':s+=(w/f'paper_{low}{n}_addition.txt').read_text()
 p.write_text(s);paths.add(name)
status='verification/TURN_377_NATIVE_BATCH/BATCH_STATUS.json';b=json.load(open(r/status));b['completed_entries']=count;(r/status).write_text(json.dumps(b,indent=2)+'\n');paths.add(status)
with (r/'TIMELINE.txt').open('a') as f:f.write((w/f'timeline{n}_addition.txt').read_text()+f'\n{now} — Registered {count} completed entries immediately after source-bound checks;candidate rows {newrows}.\n')
state=json.load(open(r/'CONTINUATION_STATE.json'));state[low+str(n)]={'status':'complete','receipt':receipt,'audited_declarations':len(cfg['declarations']),'candidate_rows':256};done={x['claim_id'] for x in cov['claims'] if x['lean_status']=='complete'};nextentry=next(x['claim_id'] for x in cov['claims'] if x['claim_id'] not in done and set(x['v3_registration']['dependencies'])<=done);state['scientific_cursor']={'completed':cid,'next':nextentry,'receipt':receipt,'source':'claims/'+nextentry+'/execution.py','next_milestone':750};state['authorized_action']='Continue '+nextentry+' in registered dependency order toward750,reusing retained source-specific implementations and checks. Update counts,paper,timeline and push verified work. Pause only at750 with complete review package.';(r/'CONTINUATION_STATE.json').write_text(json.dumps(state,indent=2)+'\n');paths.update(['SFT.lean','Audit.lean','Parity.lean','COVERAGE.json','reference/CORRESPONDENCE.json','TIMELINE.txt','CONTINUATION_STATE.json']);(w/f'checkpoint{n}_paths.json').write_text(json.dumps(sorted(paths)));print(json.dumps(cov['summary']));print(nextentry)

from pathlib import Path
import re,json,hashlib,shutil,datetime,subprocess,sys
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');stem=sys.argv[1];run='515'
settings={'UnifiedConstants':('unified','unified','SFT-PHYS-UNIFIED-CONSTANTS-OBJECT-077','unified_constants_object_law_v1.py',4096,'unified515_source_report.json','unified515_source_report.json')}
low,tag,cid,sourcefile,rowcount,source_report,validation_report=settings[stem];key=component=stem
cfg=json.load(open('work/audit'+tag+'515_config.json'))[stem]
cov=json.loads((r/'COVERAGE.json').read_text());by={e['claim_id']:e for e in cov['claims']};e=by[cid]
if e['lean_status']=='complete':raise SystemExit('Already registered '+cid)
assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
assert json.load(open('work/unified_program515_report.json'))['status']=='PASS'
assert json.load(open('work/'+validation_report))['status']=='PASS'
assert json.load(open('work/'+source_report))['status']=='PASS'
cases=json.load(open('work/unified515_independent_report.json'));assert len(cases)==4 and all(c['actual']['passed']==c['expected'] for c in cases)
audit=Path('work/audit_'+tag+'_entry515.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in cfg['declarations']);assert 'depends on axioms:' not in audit
paths=set();modules=['SFT/Physics/'+m+'.lean' for m in cfg['modules']]+cfg['extra_modules']
for rel in modules:
 k=rel.removeprefix('SFT/Physics/').removesuffix('.lean') if '/Physics/' in rel else '../Host/'+Path(rel).stem
 assert hashlib.sha256((rec/rel).read_bytes()).hexdigest()==cfg['source_sha256'][k],rel
oldths=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));auditrel='verification/TURN_515_REGISTERED_DECLARATIONS_AUDIT.log';prior=(r/(auditrel if (r/auditrel).exists() else 'verification/TURN_514_REGISTERED_DECLARATIONS_AUDIT.log')).read_text();olddefs=set(re.findall("'([^']+)' does not depend on any axioms",prior));newths=[n for n in cfg['theorems'] if n not in oldths];newdefs=[n for n in cfg['definitions_and_theorems'] if n not in olddefs]
source='sft/physics/'+sourcefile;pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';srcsha=hashlib.sha256(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+source])).hexdigest();corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());evidence='verification/TURN_515_'+stem.upper()+'_COMPLETION.json'
scopes={'UnifiedConstants':'Exact pinned positive-predecessor/power/cover helpers including supplied binary and original guards; sixteen-field foundation vector on the original accepted generator domain; twenty-six-field terminal assembly reusing the admitted sector operations; exact ten-row/seventeen-node parent-to-child graph; all seven sector reachability and incoming-incidence checks; all twelve generator changes, four held controls and fourteen common-order equalities. Eight-field certificate, five original witnesses, all twelve grammar axes and4096 alternatives with complete decision/uniqueness proofs, original controls, closure, registration and implementation-distinct validator. No model changes, fitted values or unfinished proofs; all imported axiom dependencies empty.'}
for rel in modules:
 s=(rec/rel).read_text();shutil.copy2(rec/rel,r/rel);paths.add(rel);m=Path(rel).stem;found=next((v for group in ['modules','evidence_modules'] for v in corr[group] if v.get('module')==rel),None)
 if found is None:found=dict(module=rel,v3_claim=cid,source_path=source,source_sha256=srcsha);corr['modules' if m.endswith('Grammar') else 'evidence_modules'].append(found)
 domain=scopes[stem]+' Source-bound module '+m+'.'
 if '/Host/' in rel:
  domain='Constructive linear SHA256 block traversal, proved equal to the existing digest for every ByteArray; implementation optimization only.'
  found['source_path']='sft/engine/canonical.py'
 elif m.endswith(('Measurement','Prediction','Experiment','Comparison','Validation','ValidationProofs')):
  found['source_path']='sft/physics/'+sourcefile.replace('_law_v1.py','_validation_v1.py')
  found['specialisation_source']=dict(path=source,sha256=srcsha,commit=pin)
 found['source_sha256']=hashlib.sha256(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+found['source_path']])).hexdigest()
 found.update(lean_source_sha256=hashlib.sha256(s.encode()).hexdigest(),domain=domain,implemented={n:domain for _,n in re.findall(r'^ *(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M)},remaining=[],completion_evidence=evidence)
 line='import '+rel[:-5].replace('/','.')
 if line not in (r/'SFT.lean').read_text().splitlines():
  with (r/'SFT.lean').open('a') as f:f.write(line+'\n')
with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+n+'\n' for n in newths))
(r/auditrel).write_text(prior+'\n'+'\n'.join("'"+n+"' does not depend on any axioms" for n in newdefs)+'\n');paths.add(auditrel)
ns='SFT.Physics.'+stem+'Grammar';assert 'for c in '+ns+'.candidates' not in (r/'Parity.lean').read_text()
with (r/'Parity.lean').open('a') as f:f.write('\n  for c in '+ns+'.candidates do\n    IO.println ("'+stem+'Grammar\\t" ++ '+ns+'.candidateId c ++ "\\t" ++ (if '+ns+'.survives c then "true" else "false") ++ "\\t" ++ '+ns+'.exactForm c ++ "\\t" ++ '+ns+'.decisionReason c)\n')
evidence_files=[Path('work/'+n) for n in ['unified_program515_report.json','unified_program515_output.json','unified515_independent_report.json','unified515_independent.py','unified515_independent_inputs.json','unified_program515.py','auditunified515_config.json','audit_unified_entry515.log','AuditUnifiedEntry515.lean','unified515_source_report.json','unified515_source_output.json','check_unified_source515.py','unified515_build_status.json','unified515_census_build.log','unified515_native_run.json','unified515_source_metadata.json','unified_core515_audit.json','unified_core515_audit.log','register_unified515.py','finish_unified515_checks.py','build_unified_census515.py','prepare_unified_census515.py','prepare_unified_witnesses515.py','link_unified_program515.py','unified515_initializer_bridge.c']]
evidence_files += [rec/'UnifiedSource515.lean',rec/'UnifiedConstantsProgram515.lean']
for p in evidence_files:
 dest='verification/TURN_515_'+p.name;shutil.copy2(p,r/dest);paths.add(dest)
result=dict(status='complete',claim_id=cid,source_commit=pin,source_path=source,source_sha256=srcsha,derivation=scopes[stem],source_field_comparison=json.load(open('work/'+source_report)),dependencies={d:'complete' for d in e['v3_registration']['dependencies']},candidate_rows=rowcount,full_native_program_comparison=json.load(open('work/unified_program515_report.json')),empirical_boundary='Original formal evidence mode: the object seals before external comparison. Existing sector empirical boundaries remain unchanged. The original independent validator recomputes the foundation probe, graph and original controls using pinned dependency registration/certificate files.',independent_validator_cases=cases,axiom_dependencies=[],audited_declarations=cfg['declarations'],added_registered_theorems=newths,added_audited_definitions_and_theorems=newdefs,remaining=[],build_scope='Targeted current-source Lean build; independent census shards compiled in the authorized 28-worker batch and retained native source-program comparisons; same audited source snapshots verified, no census recompiled, and no new full-model build asserted.')
(r/evidence).write_text(json.dumps(result,indent=2)+'\n');paths.add(evidence);e.update(lean_status='complete',remaining=[],lean_modules=modules,verified_scope=scopes[stem],completion_evidence=evidence,artifact_runtime_parity='PASS retained fresh complete4096-form native program, all fields/hashes/controls and original formal registration; pinned independent validator accepts original and rejects omitted candidate, extra survivor, failed control.')
e.pop('verification_evidence',None)
oldtotal=cov['summary']['fully_reconstructed_claims'];oldtheorems=cov['summary']['axiom_free_exported_results'];olddefcount=cov['summary']['axiom_free_audited_definitions_and_theorems'];oldprogress=cov['summary']['in_progress'];oldpending=cov['summary']['pending'];total=sum(x['lean_status']=='complete' for x in cov['claims']);cov['summary'].update(fully_reconstructed_claims=total,axiom_free_exported_results=len(oldths)+len(newths),axiom_free_audited_definitions_and_theorems=len(olddefs)+len(newdefs))
for k in ['pending','in_progress']:cov['summary'][k]=sum(x['lean_status']==k for x in cov['claims'])
cov['updated_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newths));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
oldrows=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text())[1].replace(',',''));rows=oldrows+rowcount
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;s=p.read_text()
 if name=='ZENODO_PAPER_DRAFT.txt':
  for a,b in [(f'{oldtotal} completed entries',f'{total} completed entries'),(f'{oldtheorems:,} audited theorems',f'{len(oldths)+len(newths):,} audited theorems'),(f'{olddefcount:,} audited definitions',f'{len(olddefs)+len(newdefs):,} audited definitions'),(f'{oldrows:,} records',f'{rows:,} records')]:s=s.replace(a,b)
  s=re.sub(r'(?<=records across )\d+(?= represented entries)',str(total+cov['summary']['in_progress']),s)
 else:
  for a,b in [(f'{oldtotal} / 2,781',f'{total} / 2,781'),(f'{oldtotal} model entries',f'{total} model entries'),(f'{oldtheorems:,}',f'{len(oldths)+len(newths):,}'),(f'{olddefcount:,}',f'{len(olddefs)+len(newdefs):,}'),(f'{oldrows:,}',f'{rows:,}'),(f'{oldtotal+oldprogress} represented',f"{total+cov['summary']['in_progress']} represented"),(f'across {oldtotal+oldprogress} source entries',f"across {total+cov['summary']['in_progress']} source entries"),(f'{oldprogress} entries are in progress and {oldpending:,} remain pending',f"{cov['summary']['in_progress']} entries are in progress and {cov['summary']['pending']:,} remain pending"),('TURN_486_REGISTERED_DECLARATIONS_AUDIT','TURN_515_REGISTERED_DECLARATIONS_AUDIT')]:s=s.replace(a,b)
  if name=='README.md':
   s=re.sub(r'\d+ entr(?:y is|ies are) in progress and [0-9,]+ remain pending',str(cov['summary']['in_progress'])+' entries are in progress and '+format(cov['summary']['pending'],',')+' remain pending',s)
   s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+evidence+')',s)
 p.write_text(s);paths.add(name)
status='verification/TURN_377_NATIVE_BATCH/BATCH_STATUS.json';v=json.loads((r/status).read_text());v['completed_entries']=total;(r/status).write_text(json.dumps(v,indent=2)+'\n');paths.add(status)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+cov['updated_at']+' Turn515 interim completion: '+cid+' complete after actual source derivation, full original source-census program comparison, fresh full native source program, four independent cases and '+str(len(cfg['declarations']))+' zero-axiom declarations. All registered dependencies complete. Count immediately '+str(total)+'/2781; '+str(len(newths))+' newly registered theorems and '+str(len(newdefs))+' audited definitions/theorems. Source domains, arithmetic, controls and empirical boundaries preserved.\n')
paths.update(['SFT.lean','Audit.lean','Parity.lean','reference/CORRESPONDENCE.json','COVERAGE.json','TIMELINE.txt']);Path('work/checkpoint515c_'+stem+'_paths.json').write_text(json.dumps(sorted(paths)));print('REGISTERED',cid,total,len(newths),len(newdefs),flush=True)

state=json.loads((r/'CONTINUATION_STATE.json').read_text());step='S15';nextstep='S17'
for item in state['steps']:
 if item['id'] in ['S15','S16']:item.update(state='complete',completion_receipt=evidence)
 if item['id']==nextstep:item['state']='in_progress'
state.update(active_step=nextstep,live_jobs=[],recorded_at=cov['updated_at'])
for item in state['snapshot']:
 root=r if item['root']=='canonical' else rec
 p=root/item['path']
 if p.exists() and (item['path'] in paths or item['root']=='retained' and item['path'] in modules):item['sha256']=hashlib.sha256(p.read_bytes()).hexdigest()
(r/'CONTINUATION_STATE.json').write_text(json.dumps(state,indent=2)+'\n');paths.add('CONTINUATION_STATE.json')
Path('work/checkpoint515c_'+stem+'_paths.json').write_text(json.dumps(sorted(paths)))

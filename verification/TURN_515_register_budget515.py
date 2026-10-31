from pathlib import Path
import re,json,hashlib,shutil,datetime,subprocess,sys
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');stem=sys.argv[1];run='514';key,component=next((k,c) for name,k,c in json.load(open('work/flatbudget514_entries.json')) if name==stem);low=stem.lower();cid=json.load(open('work/flatbudget514_metadata.json'))[stem]['claim_id'];cfg=json.load(open('work/auditbudget515_config.json'))[stem];cov=json.loads((r/'COVERAGE.json').read_text());by={e['claim_id']:e for e in cov['claims']};e=by[cid]
if e['lean_status']=='complete':raise SystemExit('Already registered '+cid)
assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
for part in ['program','validation']:assert json.load(open('work/'+low+'_'+part+run+'_report.json'))['status']=='PASS'
cases=json.load(open('work/'+low+'_independent'+run+'_report.json'));assert len(cases)==4 and all(c['actual']['passed']==c['expected'] for c in cases)
audit=Path('work/auditflatbudget'+run+'_'+stem+'.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in cfg['declarations']);assert 'depends on axioms:' not in audit
paths=set();modules=['SFT/Physics/'+m+'.lean' for m in cfg['modules']]
oldths=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));auditrel='verification/TURN_515_REGISTERED_DECLARATIONS_AUDIT.log';prior=(r/(auditrel if (r/auditrel).exists() else 'verification/TURN_514_REGISTERED_DECLARATIONS_AUDIT.log')).read_text();olddefs=set(re.findall("'([^']+)' does not depend on any axioms",prior));newths=[n for n in cfg['theorems'] if n not in oldths];newdefs=[n for n in cfg['definitions_and_theorems'] if n not in olddefs]
source='sft/physics/cosmic_budget_law.py';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';srcsha=hashlib.sha256(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+source])).hexdigest();corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());evidence='verification/TURN_515_'+stem.upper()+'_COMPLETION.json'
scopes={'CosmoCompleteBudget':'Original generated ten-field cosmic_budget_structure: inherited depth5 and binary support32, complete boundary-pair count10, free complement22, matter5/16, vacuum11/16, within-matter5/32 and27/32, composed baryon25/512 and cold dark135/512. Constructive boundary-pair count at every depth, exact support/global/matter partition identities and equality to the existing dark/baryon construction. Full original eleven-axis2048 grammar, four witnesses, controls, closure, registration and complete empirical/independent checks; all original measured intervals and boundaries retained.'}
assert json.load(open('work/budget_fields515_report.json'))['status']=='PASS'
for rel in modules:
 s=(rec/rel).read_text();shutil.copy2(rec/rel,r/rel);paths.add(rel);m=Path(rel).stem;found=next((v for group in ['modules','evidence_modules'] for v in corr[group] if v.get('module')==rel),None)
 if found is None:found=dict(module=rel,v3_claim=cid,source_path=source,source_sha256=srcsha);corr['modules' if m.endswith('Grammar') else 'evidence_modules'].append(found)
 domain=scopes[stem] if m==component or m=="MatterExchangeSpin" else 'Exact pinned '+key+' source '+m[len(stem):]+': full eleven-axis 2048-form enumeration, original program/controls/closure or complete blind empirical method.'
 if m.endswith(('Intervals','Experiment','Comparison','Validation','ValidationProofs')):
  found['source_path']='sft/physics/cosmic_budget_validation.py'
  found['source_sha256']=hashlib.sha256(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+found['source_path']])).hexdigest()
  found['specialisation_source']=dict(path=source,sha256=srcsha,commit=pin)
 domains={'Proofs':'Constructive generated support and exact partition identities.', 'Intervals':'Exact original Planck-plus-BAO baseline metadata, five measured rows and positive-interval guards; direct matter/vacuum intervals and outward Hubble-square propagation into baryon/cold-dark intervals, with original refined acceptance and leading rejection checks.', 'Witnesses':'The original forced-support, global-closure, matter-closure and exact-components witnesses, evaluated through the generated ten-field budget.', 'Experiment':'The original pinned source record, target custody, registration, sealing and empirical comparison inputs.', 'Comparison':'Original empirical comparison rows and registered source verdict.', 'Validation':'Complete original numeric source-record checks followed by the retained sealed blind validator, preserving source custody, boundary and original error behavior.', 'ValidationProofs':'Kernel checks of the complete original native validation assembly.'}
 domain=domains.get(m[len(stem):],domain)
 found.update(lean_source_sha256=hashlib.sha256(s.encode()).hexdigest(),domain=domain,implemented={n:domain for _,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M)},remaining=[],completion_evidence=evidence)
 line='import '+rel[:-5].replace('/','.')
 if line not in (r/'SFT.lean').read_text().splitlines():
  with (r/'SFT.lean').open('a') as f:f.write(line+'\n')
with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+n+'\n' for n in newths))
(r/auditrel).write_text(prior+'\n'+'\n'.join("'"+n+"' does not depend on any axioms" for n in newdefs)+'\n');paths.add(auditrel)
ns='SFT.Physics.'+stem+'Grammar';assert 'for c in '+ns+'.candidates' not in (r/'Parity.lean').read_text()
with (r/'Parity.lean').open('a') as f:f.write('\n  for c in '+ns+'.candidates do\n    IO.println ("'+stem+'Grammar\\t" ++ '+ns+'.candidateId c ++ "\\t" ++ (if '+ns+'.survives c then "true" else "false") ++ "\\t" ++ '+ns+'.exactForm c ++ "\\t" ++ '+ns+'.decisionReason c)\n')
for part in ['program','validation','independent']:
 for suffix in ['report.json','output.json']:
  p=Path('work/'+low+'_'+part+run+'_'+suffix)
  if p.exists():dest='verification/TURN_515_'+p.name;shutil.copy2(p,r/dest);paths.add(dest)
 p=Path('work/'+low+'_'+part+run+'.py');dest='verification/TURN_515_'+p.name;shutil.copy2(p,r/dest);paths.add(dest)
for p in [Path('work/auditflatbudget'+run+'_'+stem+'.log'),Path('work/Auditflatbudget'+run+'_'+stem+'.lean'),rec/(stem+'Program'+run+'.lean'),rec/(stem+'ValidationProgram'+run+'.lean')]:
 dest='verification/TURN_515_'+p.name;shutil.copy2(p,r/dest);paths.add(dest)
result=dict(status='complete',claim_id=cid,source_commit=pin,source_path=source,source_sha256=srcsha,derivation=scopes[stem],source_field_comparison=json.load(open('work/budget_fields515_report.json')),dependencies={d:'complete' for d in e['v3_registration']['dependencies']},candidate_rows=2048,full_native_program_comparison='PASS',full_native_empirical_comparison='PASS including all '+str(json.load(open('work/'+low+'_validation'+run+'_report.json'))['source_snapshot_bytes'])+' source bytes and every output field/hash; pinned host metadata and equal protected-tree snapshots as explicit adapter inputs.',independent_validator_cases=cases,axiom_dependencies=[],audited_declarations=cfg['declarations'],added_registered_theorems=newths,added_audited_definitions_and_theorems=newdefs,remaining=[],build_scope='Targeted current-source Lean build; independent census shards compiled in the authorized 28-worker batch and fresh full source-program/empirical comparisons; no new full-model build asserted.')
(r/evidence).write_text(json.dumps(result,indent=2)+'\n');paths.add(evidence);e.update(lean_status='complete',remaining=[],lean_modules=modules,verified_scope=scopes[stem],completion_evidence=evidence,artifact_runtime_parity='PASS fresh complete 2048-form program, all fields/hashes/controls and full original empirical validator; pinned independent validator accepts original and rejects omitted candidate, extra survivor, failed control.')
e.pop('verification_evidence',None)
oldtotal=cov['summary']['fully_reconstructed_claims'];oldtheorems=cov['summary']['axiom_free_exported_results'];olddefcount=cov['summary']['axiom_free_audited_definitions_and_theorems'];oldprogress=cov['summary']['in_progress'];oldpending=cov['summary']['pending'];total=sum(x['lean_status']=='complete' for x in cov['claims']);cov['summary'].update(fully_reconstructed_claims=total,axiom_free_exported_results=len(oldths)+len(newths),axiom_free_audited_definitions_and_theorems=len(olddefs)+len(newdefs))
for k in ['pending','in_progress']:cov['summary'][k]=sum(x['lean_status']==k for x in cov['claims'])
cov['updated_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newths));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
oldrows=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text())[1].replace(',',''));rows=oldrows+2048
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
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+cov['updated_at']+' Turn515 interim completion: '+cid+' complete after actual source derivation, full 2048-form program comparison, complete pinned empirical output, four independent cases and '+str(len(cfg['declarations']))+' zero-axiom declarations. All registered dependencies complete. Count immediately '+str(total)+'/2781; '+str(len(newths))+' newly registered theorems and '+str(len(newdefs))+' audited definitions/theorems. Source domains, arithmetic, controls and empirical boundaries preserved.\n')
paths.update(['SFT.lean','Audit.lean','Parity.lean','reference/CORRESPONDENCE.json','COVERAGE.json','TIMELINE.txt']);Path('work/checkpoint515b_paths.json').write_text(json.dumps(sorted(paths)));print('REGISTERED',cid,total,len(newths),len(newdefs),flush=True)

for source in [Path('work/budget_fields515_report.json'),Path('work/check_budget_fields515.py'),rec/'BudgetFields515.lean',Path('work/budget_fields515.log')]:
 dest='verification/TURN_515_'+source.name;shutil.copy2(source,r/dest);paths.add(dest)
Path('work/checkpoint515b_paths.json').write_text(json.dumps(sorted(paths)))

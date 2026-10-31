from pathlib import Path
import re,json,hashlib,shutil,datetime,subprocess,sys
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');stem=sys.argv[1];run='500';key='COUPLING_RUNNING_CONVERGENCE';component='RunningConvergence';low=stem.lower();cid='SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006';cfg=json.load(open('work/auditrunning'+run+'_config.json'))[stem];cov=json.loads((r/'COVERAGE.json').read_text());by={e['claim_id']:e for e in cov['claims']};e=by[cid]
if e['lean_status']=='complete':raise SystemExit('Already registered '+cid)
assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
for part in ['program','validation']:assert json.load(open('work/running500_'+part+'_report.json'))['status']=='PASS'
cases=json.load(open('work/running500_independent_report.json'));assert len(cases)==4 and all(c['actual']['passed']==c['expected'] for c in cases)
audit=Path('work/auditrunning'+run+'_'+stem+'.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in cfg['declarations']);assert 'depends on axioms:' not in audit
paths=set(json.load(open('work/checkpoint500_paths.json'))) if Path('work/checkpoint500_paths.json').exists() else set();modules=['SFT/Physics/'+m+'.lean' for m in cfg['modules']]
if run=='483':
 for rel in modules:assert (rec/rel).read_bytes()==(r/'verification/TURN_483_MECHANICS_BATCH'/rel).read_bytes(),rel
if stem=='WorkEnergy':
 assert json.load(open('work/scalar500_report.json'))['status']=='PASS';sa=Path('work/energy500_audit.log').read_text();s=(rec/'SFT/Mathematics/FoldScalar.lean').read_text()
 for kind,n in re.findall(r'^(def|theorem|inductive|structure) (\w+)',s,re.M):
  full='SFT.Mathematics.FoldScalar.'+n;assert "'"+full+"' does not depend on any axioms" in sa;cfg['declarations'].append(full)
  if kind=='theorem':cfg['theorems'].append(full)
  if kind in ['theorem','def']:cfg['definitions_and_theorems'].append(full)
 modules.insert(0,'SFT/Mathematics/FoldScalar.lean')
oldths=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));auditrel='verification/TURN_500_REGISTERED_DECLARATIONS_AUDIT.log';prior=(r/(auditrel if (r/auditrel).exists() else 'verification/TURN_499_REGISTERED_DECLARATIONS_AUDIT.log')).read_text();olddefs=set(re.findall("'([^']+)' does not depend on any axioms",prior));newths=[n for n in cfg['theorems'] if n not in oldths];newdefs=[n for n in cfg['definitions_and_theorems'] if n not in olddefs]
source='sft/physics/coupling_running_convergence_terminal_law_v1.py';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';srcsha=hashlib.sha256(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+source])).hexdigest();corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());evidence='verification/TURN_500_'+stem.upper()+'_COMPLETION.json'
scopes={'RunningConvergence':'Exact generated binary support, guarded source operations, complete prime-sector shares and pair gaps, strict successor growth, shortfall and arbitrary positive finite-tolerance convergence witness; carrier-specific energy orientations; all8748 original forms, all public predicate guards, complete certificate/program methods, original controls and complete sealed empirical validation with all four sources and every registered row.'}
for rel in modules:
 s=(rec/rel).read_text();shutil.copy2(rec/rel,r/rel);paths.add(rel);m=Path(rel).stem;found=next((v for group in ['modules','evidence_modules'] for v in corr[group] if v.get('module')==rel),None)
 if found is None:found=dict(module=rel,v3_claim=cid,source_path=source,source_sha256=srcsha);corr['modules' if m.endswith('Grammar') else 'evidence_modules'].append(found)
 domain=scopes[stem] if m==component or m=="MatterExchangeSpin" else 'Exact pinned '+key+' source '+m[len(stem):]+': full nine-axis8748 enumeration, original program/controls/closure or complete blind empirical method.'
 if m=='FoldScalar':
  domain='Pinned values.py Scalar, held orientations, reverse, add_scalar, subtract_scalar, multiply_scalar and divide_scalar specialized to an admitted positive forward duration; complete source domain preserved, exact normalized arithmetic and branch identities kernel proved.';found['source_path']='sft/mathematics/calculator/values.py';found['source_sha256']=json.load(open('work/scalar500_report.json'))['source_sha256']
 if m=='MatterMassEnergyDimension':domain='Original MASS_ENERGY two-transfer necessity and sufficiency: repeated mass-times-speed dimension has length exponent n, equality to the already derived work-energy dimension forces n=2, and the two-transfer path has exactly that energy dimension for every kind.'
 if m in ['MassEnergyMeasured']:
  found['specialisation_source']=dict(path=source,sha256=srcsha,spec='VALUE_SPECS[MASS_ENERGY.claim_id]',commit=pin)
  found['source_path']='sft/physics/measured_value.py';found['source_sha256']=hashlib.sha256(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/measured_value.py'])).hexdigest();domain='Original MASS_ENERGY VALUE_SPECS mass/speed-square interval validator: exact CODATA decimal/prefix/uncertainty parsing, positive interval input construction, original ten-instruction product program, complete custody/sealing/audit, post-release interval overlap and displaced control, original certificates and receipt.'
 if m in ['RunningConvergenceMeasurement','RunningConvergencePrediction','RunningConvergenceValidation','RunningConvergenceMeasurementProofs']:
  found['source_path']='sft/physics/coupling_running_convergence_terminal_validation_v1.py'
  found['source_sha256']=hashlib.sha256(Path('work/v3-runtime500',found['source_path']).read_bytes()).hexdigest()
  domain='Original sealed running-convergence validation: all source records, exact decimal intervals and row counts, prediction inputs and execution, source custody, adverse controls, observed energy directions, complete original output/certificate hashes. '+m
 found.update(lean_source_sha256=hashlib.sha256(s.encode()).hexdigest(),domain=domain,implemented={n:domain for _,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M)},remaining=[],completion_evidence=evidence)
 line='import '+rel[:-5].replace('/','.')
 if line not in (r/'SFT.lean').read_text().splitlines():
  with (r/'SFT.lean').open('a') as f:f.write(line+'\n')
with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+n+'\n' for n in newths))
(r/auditrel).write_text(prior+'\n'+'\n'.join("'"+n+"' does not depend on any axioms" for n in newdefs)+'\n');paths.add(auditrel)
ns='SFT.Physics.'+stem+'Grammar';assert 'for c in '+ns+'.candidates' not in (r/'Parity.lean').read_text()
with (r/'Parity.lean').open('a') as f:f.write('\n  for c in '+ns+'.candidates do\n    IO.println ("'+stem+'Grammar\\t" ++ '+ns+'.candidateId c ++ "\\t" ++ (if '+ns+'.survives c then "true" else "false") ++ "\\t" ++ '+ns+'.exactForm c ++ "\\t" ++ '+ns+'.decisionReason c)\n')
for p in [Path('work/running500_'+part+'_report.json') for part in ['program','validation','independent']]+[Path('work/running500_'+part+'_actual.json') for part in ['validation']]+[Path('work/auditrunning500_RunningConvergence.log'),Path('work/Auditrunning500_RunningConvergence.lean'),rec/'RunningConvergenceProgram500.lean',rec/'RunningValidationProgram500.lean',Path('work/check_running500.py'),Path('work/check_running500_validation.py'),Path('work/finish_running500_comparison_retry.py')]:
 assert p.exists(),p
 dest='verification/TURN_500_'+p.name;shutil.copy2(p,r/dest);paths.add(dest)

result=dict(status='complete',claim_id=cid,source_commit=pin,source_path=source,source_sha256=srcsha,derivation=scopes[stem],dependencies={d:'complete' for d in e['v3_registration']['dependencies']},candidate_rows=8748,full_native_program_comparison='PASS',full_native_empirical_comparison='PASS including all four source snapshots, every registered measurement row, output field and hash; pinned host metadata and equal protected-tree snapshots as explicit adapter inputs.',independent_validator_cases=cases,axiom_dependencies=[],audited_declarations=cfg['declarations'],added_registered_theorems=newths,added_audited_definitions_and_theorems=newdefs,remaining=[],build_scope='Targeted current-source single-worker Lean build and fresh full source-program/empirical comparisons; no new full-model build asserted.')
(r/evidence).write_text(json.dumps(result,indent=2)+'\n');paths.add(evidence);e.update(lean_status='complete',remaining=[],lean_modules=modules,verified_scope=scopes[stem],completion_evidence=evidence,artifact_runtime_parity='PASS fresh complete8748-form program, all fields/hashes/controls and full original empirical validator; pinned independent validator accepts original and rejects omitted candidate, extra survivor, failed control.')
e.pop('verification_evidence',None)
oldtotal=cov['summary']['fully_reconstructed_claims'];oldtheorems=cov['summary']['axiom_free_exported_results'];olddefcount=cov['summary']['axiom_free_audited_definitions_and_theorems'];oldprogress=cov['summary']['in_progress'];oldpending=cov['summary']['pending'];total=sum(x['lean_status']=='complete' for x in cov['claims']);cov['summary'].update(fully_reconstructed_claims=total,axiom_free_exported_results=len(oldths)+len(newths),axiom_free_audited_definitions_and_theorems=len(olddefs)+len(newdefs))
for k in ['pending','in_progress']:cov['summary'][k]=sum(x['lean_status']==k for x in cov['claims'])
cov['updated_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newths));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
oldrows=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text())[1].replace(',',''));rows=oldrows+8748
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;s=p.read_text()
 if name=='ZENODO_PAPER_DRAFT.txt':
  for a,b in [(f'{oldtotal} completed entries',f'{total} completed entries'),(f'{oldtheorems:,} audited theorems',f'{len(oldths)+len(newths):,} audited theorems'),(f'{olddefcount:,} audited definitions',f'{len(olddefs)+len(newdefs):,} audited definitions'),(f'{oldrows:,} records',f'{rows:,} records')]:s=s.replace(a,b)
  s=re.sub(r'(?<=records across )\d+(?= represented entries)',str(total+cov['summary']['in_progress']),s)
 else:
  for a,b in [(f'{oldtotal} / 2,781',f'{total} / 2,781'),(f'{oldtotal} model entries',f'{total} model entries'),(f'{oldtheorems:,}',f'{len(oldths)+len(newths):,}'),(f'{olddefcount:,}',f'{len(olddefs)+len(newdefs):,}'),(f'{oldrows:,}',f'{rows:,}'),(f'{oldtotal+oldprogress} represented',f"{total+cov['summary']['in_progress']} represented"),(f'across {oldtotal+oldprogress} source entries',f"across {total+cov['summary']['in_progress']} source entries"),(f'{oldprogress} entries are in progress and {oldpending:,} remain pending',f"{cov['summary']['in_progress']} entries are in progress and {cov['summary']['pending']:,} remain pending"),('TURN_486_REGISTERED_DECLARATIONS_AUDIT','TURN_500_REGISTERED_DECLARATIONS_AUDIT')]:s=s.replace(a,b)
  if name=='README.md':
   s=re.sub(r'\d+ entr(?:y is|ies are) in progress and [0-9,]+ remain pending',str(cov['summary']['in_progress'])+' entries are in progress and '+format(cov['summary']['pending'],',')+' remain pending',s)
   s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+evidence+')',s)
 p.write_text(s);paths.add(name)
status='verification/TURN_377_NATIVE_BATCH/BATCH_STATUS.json';v=json.loads((r/status).read_text());v['completed_entries']=total;(r/status).write_text(json.dumps(v,indent=2)+'\n');paths.add(status)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+cov['updated_at']+' Turn500 interim completion: '+cid+' complete after actual source derivation, full8748program comparison, complete pinned empirical output, four independent cases and '+str(len(cfg['declarations']))+' zero-axiom declarations. All registered dependencies complete. Count immediately '+str(total)+'/2781; '+str(len(newths))+' newly registered theorems and '+str(len(newdefs))+' audited definitions/theorems. Source domains, arithmetic, controls and empirical boundaries preserved.\n')
paths.update(['SFT.lean','Audit.lean','Parity.lean','reference/CORRESPONDENCE.json','COVERAGE.json','TIMELINE.txt']);Path('work/checkpoint500_paths.json').write_text(json.dumps(sorted(paths)));print('REGISTERED',cid,total,len(newths),len(newdefs),flush=True)

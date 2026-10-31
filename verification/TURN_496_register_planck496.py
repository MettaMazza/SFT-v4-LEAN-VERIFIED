from pathlib import Path
import json,re,hashlib,shutil,subprocess,datetime
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');cfg=json.load(open('work/planck489_current_config.json'));cov=json.loads((r/'COVERAGE.json').read_text());by={e['claim_id']:e for e in cov['claims']};cid='SFT-PHYS-SCALE-PROTON-PLANCK-TERMINAL-003';e=by[cid];assert e['lean_status']=='in_progress';assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
assert json.load(open('work/planck_native489_report.json'))['status']=='PASS';cases=json.load(open('work/planck_independent490_report.json'));assert len(cases)==4 and all(x['actual']['passed']==x['expected'] for x in cases)
for m,h in cfg['source_sha256'].items():assert hashlib.sha256((rec/'SFT/Physics'/(m+'.lean')).read_bytes()).hexdigest()==h,m
modules=cfg['modules']+['PlanckColourCorrespondence'];names=cfg['declarations']+['SFT.Physics.PlanckColourCorrespondence.'+n for n in ['existingShareIsForcedCoupling','existingShareRetainsBothLabelsOverGenerator']];audit=Path('work/planck496_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in names);assert 'depends on axioms:' not in audit and 'error' not in audit
paths=set(json.load(open('work/checkpoint496_paths.json')));corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());oldths=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));alog='verification/TURN_496_REGISTERED_DECLARATIONS_AUDIT.log';prior=(r/alog).read_text();olddefs=set(re.findall("'([^']+)' does not depend on any axioms",prior));ths=[];defs=[];source='sft/physics/precision_value_laws_v1.py';pin=cov['source_commit'];sha=hashlib.sha256(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+source])).hexdigest();ev='verification/TURN_496_PLANCK_TERMINAL_COMPLETION.json'
for m in modules:
 rel='SFT/Physics/'+m+'.lean';s=(rec/rel).read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1];declarations=re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',s,re.M)
 for kind,n in declarations:
  full=ns+'.'+n
  assert full in names,full
  if kind=='theorem':ths.append(full)
  if kind in ['def','theorem']:defs.append(full)
 shutil.copy2(rec/rel,r/rel);paths.add(rel)
 found=next((v for g in ['modules','evidence_modules'] for v in corr[g] if v.get('module')==rel),None)
 domain='Original terminal proton/Planck hierarchy: derived depth7/support128/massive127, original two-thirds times terminal alpha removed once from One, positive exact retained transport and squared hierarchy, complete1024form census with every exhaustive kernel case, original witnesses/controls and all native program fields.'
 if found is None:found=dict(module=rel,v3_claim=cid,source_path=source,source_sha256=sha);corr['evidence_modules'].append(found)
 if m=='PlanckHierarchy':
  found.setdefault('additional_source_components',{})[source]='Terminal source entry complete; exact colour share now connected to the completed independent colour-coupling construction, with all terminal proofs and source-program comparison verified.'
  found['terminal_completion_evidence']=ev
 else:found.update(domain=domain,implemented={n:domain for _,n in declarations},remaining=[],completion_evidence=ev)
 found['lean_source_sha256']=hashlib.sha256(s.encode()).hexdigest()
 line='import '+rel[:-5].replace('/','.')
 if line not in (r/'SFT.lean').read_text().splitlines():
  with (r/'SFT.lean').open('a') as f:f.write(line+'\n')
newths=sorted(set(ths)-oldths);newdefs=sorted(set(defs)-olddefs)
with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+n+'\n' for n in newths))
(r/alog).write_text(prior+'\n'+'\n'.join("'"+n+"' does not depend on any axioms" for n in newdefs)+'\n');paths.add(alog)
if 'for c in SFT.Physics.PlanckTerminalGrammar.candidates' not in (r/'Parity.lean').read_text():
 with (r/'Parity.lean').open('a') as f:f.write('\n  for c in SFT.Physics.PlanckTerminalGrammar.candidates do\n    IO.println ("PlanckTerminalGrammar\\t" ++ SFT.Physics.PlanckTerminalGrammar.candidateId c ++ "\\t" ++ (if SFT.Physics.PlanckTerminalGrammar.survives c then "true" else "false") ++ "\\t" ++ SFT.Physics.PlanckTerminalGrammar.exactForm c ++ "\\t" ++ SFT.Physics.PlanckTerminalGrammar.decisionReason c)\n')
 paths.add('Parity.lean')
for name in ['planck496_audit.log','Planck496Audit.lean','planck_colour496_build.log','planck489_current_config.json','register_planck496.py']:
 rel='verification/TURN_496_'+name;shutil.copy2(Path('work')/name,r/rel);paths.add(rel)
result=dict(status='complete',claim_id=cid,source_commit=pin,source_path=source,source_sha256=sha,dependencies={d:'complete' for d in e['v3_registration']['dependencies']},candidate_rows=1024,native_program_comparison='PASS retained current-source comparison; all70runtime source hashes rechecked unchanged',native_report='verification/TURN_490_planck_native489_report.json',independent_report='verification/TURN_490_planck_independent490_report.json',independent_validator_cases=cases,source_hashes=cfg['source_sha256'],axiom_dependencies=[],fresh_audited_declarations=names,new_registered_theorems=newths,new_audited_definitions_and_theorems=newdefs,colour_correspondence='PlanckColourCorrespondence existingShareIsForcedCoupling and existingShareRetainsBothLabelsOverGenerator kernel checked',remaining=[])
(r/ev).write_text(json.dumps(result,indent=2)+'\n');paths.add(ev)
e.update(lean_status='complete',remaining=[],lean_modules=['SFT/Physics/'+m+'.lean' for m in modules],verified_scope='Complete original terminal hierarchy derivation and1024-form program, all original controls and independent-validator cases; all70runtime sources unchanged from passing comparison,240current declarations freshly audited zeroaxioms, exact coupling correspondence proved; all registered dependencies complete.',completion_evidence=ev,artifact_runtime_parity='PASS complete native1024-form source program and original independent validator; existing source hashes verified unchanged.');e.pop('verification_evidence',None)
oldtotal=cov['summary']['fully_reconstructed_claims'];oldtc=cov['summary']['axiom_free_exported_results'];olddc=cov['summary']['axiom_free_audited_definitions_and_theorems'];oldrows=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text())[1].replace(',',''));total=oldtotal+1;tc=len(oldths)+len(newths);dc=len(olddefs)+len(newdefs);rows=oldrows+1024
cov['summary'].update(fully_reconstructed_claims=total,axiom_free_exported_results=tc,axiom_free_audited_definitions_and_theorems=dc,in_progress=sum(x['lean_status']=='in_progress' for x in cov['claims']));cov['updated_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newths));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;s=p.read_text()
 for a,b in [(f'{oldtotal} / 2,781',f'{total} / 2,781'),(f'{oldtotal} model entries',f'{total} model entries'),(f'{oldtotal} completed entries',f'{total} completed entries'),(f'{oldtc:,}',f'{tc:,}'),(f'{olddc:,}',f'{dc:,}'),(f'{oldrows:,}',f'{rows:,}'),('1 entry is in progress','0 entries are in progress')]:s=s.replace(a,b)
 s=s.replace('Terminal Planck has a separately verified 1,024-form native comparison and original independent-validator checks; its nuclear-coupling dependency remains incomplete.','The terminal Planck entry is complete, including its 1,024-form native comparison, original independent-validator checks and source-derived colour-coupling dependency.')
 if name=='README.md':s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+ev+')',s)
 p.write_text(s);paths.add(name)
status='verification/TURN_377_NATIVE_BATCH/BATCH_STATUS.json';v=json.loads((r/status).read_text());v['completed_entries']=total;(r/status).write_text(json.dumps(v,indent=2)+'\n');paths.add(status)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+cov['updated_at']+' Turn496 interim completion: '+cid+' complete after original remaining colour-coupling dependency passed. Revalidated all70runtime source hashes unchanged, retained the passing complete1024native program and four original independent-validator cases, freshly audited238existing declarations plus2new exact source-coupling correspondence theorems with zeroaxioms. Published current checked source modules, preserving the full exhaustive census. Count immediately '+str(total)+'/2781; '+str(len(newths))+' newly registered theorems and '+str(len(newdefs))+' audited definitions/theorems; no redundant native run.\n')
paths.update(['COVERAGE.json','reference/CORRESPONDENCE.json','Audit.lean','SFT.lean','TIMELINE.txt']);Path('work/checkpoint496_paths.json').write_text(json.dumps(sorted(paths)));print('PLANCK REGISTERED',total,tc,dc,rows,len(newths),len(newdefs))

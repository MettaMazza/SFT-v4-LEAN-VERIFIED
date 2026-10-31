from pathlib import Path
import re,json,hashlib,shutil,datetime,subprocess,os,signal
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001';cfg=json.load(open('work/hubble487_config.json'));cov=json.loads((r/'COVERAGE.json').read_text());assert cov['summary']['fully_reconstructed_claims']==222;by={e['claim_id']:e for e in cov['claims']};e=by[cid];assert e['lean_status']!='complete';assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
for p in ['hubble_native486_report.json','Hubble_validation377_report.json','cosmic_source_report.json','hubble_independent487_report.json','hubble487_source_identity.json']:assert json.load(open('work/'+p))['status']=='PASS'
audit=Path('work/hubble487_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in cfg['declarations']);assert 'depends on axioms:' not in audit
identity=json.load(open('work/hubble487_source_identity.json'));assert identity['retained_empirical_modules_unchanged']
for m in cfg['modules']:assert hashlib.sha256((rec/'SFT/Physics'/f'{m}.lean').read_bytes()).hexdigest()==cfg['source_sha256'][m]
oldths=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));arel='verification/TURN_487_REGISTERED_DECLARATIONS_AUDIT.log';prior=(r/arel).read_text();olddefs=set(re.findall("'([^']+)' does not depend on any axioms",prior));newths=sorted(set(cfg['theorems'])-oldths);newdefs=sorted(set(cfg['definitions_and_theorems'])-olddefs);paths=set(json.load(open('work/checkpoint487_paths.json')));corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());source='sft/physics/cosmology_prior_value_laws.py';sha=hashlib.sha256(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+source])).hexdigest();ev='verification/TURN_487_HUBBLE_COMPLETION.json'
scope='Complete original matter/vacuum partition, leading correction1/12 and ratio13/12, least depth-seven binary cover, complete ordered first-return recurrence and refinement3305/3048; full2048-form program/controls and complete1316-byte blind empirical validator including outward-propagated Planck/SH0ES interval.'
for m in cfg['modules']:
 rel='SFT/Physics/'+m+'.lean';p=rec/rel;shutil.copy2(p,r/rel);paths.add(rel);found=next((v for k in ['modules','evidence_modules'] for v in corr[k] if v.get('module')==rel),None)
 if found is None:found={'module':rel};corr['evidence_modules'].append(found)
 if m in ['CosmicRatios','CosmicIntervals']:
  found['additional_hubble_completion_evidence']=ev;found['shared_scope']='Completed DarkBaryon and Hubble components; original DarkBaryon correspondence retained.'
 else:found.update(v3_claim=cid,source_path=source,source_sha256=sha,lean_source_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),domain=scope,implemented={n:scope for _,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',p.read_text(),re.M)},remaining=[],completion_evidence=ev)
 line='import SFT.Physics.'+m
 if line not in (r/'SFT.lean').read_text().splitlines():
  with (r/'SFT.lean').open('a') as f:f.write(line+'\n')
with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+n+'\n' for n in newths))
(r/arel).write_text(prior+'\n'+''.join("'"+n+"' does not depend on any axioms\n" for n in newdefs));paths.add(arel)
ns='SFT.Physics.HubbleGrammar';assert 'for c in '+ns+'.candidates' not in (r/'Parity.lean').read_text()
with (r/'Parity.lean').open('a') as f:f.write('\n  for c in '+ns+'.candidates do\n    IO.println ("HubbleGrammar\\t" ++ '+ns+'.candidateId c ++ "\\t" ++ (if '+ns+'.survives c then "true" else "false") ++ "\\t" ++ '+ns+'.exactForm c ++ "\\t" ++ '+ns+'.decisionReason c)\n')
files=['hubble_native486_report.json','hubble_native486_output.json','Hubble_validation377_report.json','Hubble_validation377_output.json','cosmic_source_report.json','cosmic_native.jsonl','hubble_independent487_report.json','hubble_independent487_output.json','hubble487_audit.log','Hubble487Audit.lean','hubble487_source_identity.json','hubble487_config.json','check_hubble_independent487.py','hubble_independent_validator487.py','check_hubble_native486.py','link_hubble486.py','native_hubble486.py','leptondecimal487_cache.log','generator486_finish.log']
for name in files:
 dest='verification/TURN_487_'+name;shutil.copy2(Path('work')/name,r/dest);paths.add(dest)
for name in ['HubbleProgram.lean']:
 dest='verification/TURN_487_'+name;shutil.copy2(rec/name,r/dest);paths.add(dest)
result=dict(status='complete',claim_id=cid,source_commit=pin,source_path=source,source_sha256=sha,derivation=scope,dependencies={d:'complete' for d in e['v3_registration']['dependencies']},candidate_rows=2048,full_native_program_comparison='PASS',full_native_empirical_comparison='PASS: all1316sourcebytes and every original output field/hash; retained empirical source modules byte-identical, pinned host metadata and equal protected-tree snapshots are adapter inputs.',independent_validator_cases=json.load(open('work/hubble_independent487_output.json')),axiom_dependencies=[],audited_declarations=cfg['declarations'],added_registered_theorems=newths,added_audited_definitions_and_theorems=newdefs,remaining=[],build_scope='Fresh kernel compilation of original133runtime modules, fresh complete native program and428current declaration axiom checks. Retained empirical builds/output with source identity verified. No fresh full-model build asserted.')
(r/ev).write_text(json.dumps(result,indent=2)+'\n');paths.add(ev);e.update(lean_status='complete',remaining=[],lean_modules=['SFT/Physics/'+m+'.lean' for m in cfg['modules']],verified_scope=scope,completion_evidence=ev,artifact_runtime_parity='PASS: fresh full2048-form native program and original independent cases; retained source-identical complete1316-byte empirical validator output.')
oldtotal=cov['summary']['fully_reconstructed_claims'];oldtheorems=cov['summary']['axiom_free_exported_results'];olddefcount=cov['summary']['axiom_free_audited_definitions_and_theorems'];oldpending=cov['summary']['pending'];oldprogress=cov['summary']['in_progress'];total=sum(x['lean_status']=='complete' for x in cov['claims']);cov['summary'].update(fully_reconstructed_claims=total,axiom_free_exported_results=len(oldths)+len(newths),axiom_free_audited_definitions_and_theorems=len(olddefs)+len(newdefs))
for k in ['pending','in_progress']:cov['summary'][k]=sum(x['lean_status']==k for x in cov['claims'])
cov['updated_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newths));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;s=p.read_text()
 if name=='ZENODO_PAPER_DRAFT.txt':
  split=s.index('\n2.');head=s[:split]
  for a,b in [(f'{oldtotal} completed',f'{total} completed'),(f'{oldtheorems:,}',f'{len(oldths)+len(newths):,}'),(f'{olddefcount:,}',f'{len(olddefs)+len(newdefs):,}')]:head=head.replace(a,b)
  s=head+s[split:]
 else:
  for a,b in [(f'{oldtotal} / 2,781',f'{total} / 2,781'),(f'{oldtotal} model entries',f'{total} model entries'),(f'{oldtheorems:,}',f'{len(oldths)+len(newths):,}'),(f'{olddefcount:,}',f'{len(olddefs)+len(newdefs):,}'),(f'{oldprogress} entries are in progress',f"{cov['summary']['in_progress']} entries are in progress"),('76,902','78,950'),('223 represented','224 represented'),('across 223 source entries','across 224 source entries'),(f'{oldpending:,} remain pending',f"{cov['summary']['pending']:,} remain pending")]:s=s.replace(a,b)
  if name=='README.md':s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+ev+')',s)
 p.write_text(s);paths.add(name)
status='verification/TURN_377_NATIVE_BATCH/BATCH_STATUS.json';v=json.loads((r/status).read_text());v['completed_entries']=total;(r/status).write_text(json.dumps(v,indent=2)+'\n');paths.add(status)
command=subprocess.run(['ps','-p','15302','-o','command='],capture_output=True,text=True).stdout
if 'HubbleProgram.lean' in command:os.kill(15302,signal.SIGTERM)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+cov['updated_at']+' Turn487 interim completion: '+cid+' complete after full2048-form fresh native comparison, source-identical retained cosmic derivations and complete1316-byte empirical output, four independent cases and428zero-axiom declaration checks. All registered dependencies complete. Count immediately '+str(total)+'/2781; '+str(len(newths))+' new registered theorems and '+str(len(newdefs))+' audited definitions/theorems. Stopped original Hubble interpreter15302 only after these actual passing results.\n')
paths.update(['SFT.lean','Audit.lean','Parity.lean','reference/CORRESPONDENCE.json','COVERAGE.json','TIMELINE.txt']);Path('work/checkpoint487_paths.json').write_text(json.dumps(sorted(paths)));print('REGISTERED HUBBLE',total,len(oldths)+len(newths),len(olddefs)+len(newdefs))

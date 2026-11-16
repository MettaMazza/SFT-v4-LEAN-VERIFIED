from pathlib import Path
import json,re,hashlib,datetime,shutil
w=Path('work');r=w/'turn1064_recovery';now=datetime.datetime.now(datetime.timezone.utc).isoformat();digest=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
cid='SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003';receipt='verification/TURN_1078_ORBITAL_SUPPORT_COMPLETION.json'
reports=['orbital1075_report.json','orbital1075_parser_report.json','orbital1075_prediction_report.json','orbital1075_assignments_report.json','orbital1075_program_report.json','orbital1076_targets_report.json','orbital1076_empirical_report.json','orbital1077_derivation_report.json','orbital1077_full_audit_report.json']
for name in reports:assert json.loads((w/name).read_text())['status']=='PASS',name
independent=json.loads((w/'orbital1075_independent_report.json').read_text());assert len(independent)==4 and all(x['result']['passed']==(x['case']=='original')for x in independent)
assert json.loads((w/'orbital1076_empirical_output.json').read_text())==json.loads((w/'orbital1076_original_empirical.json').read_text())
audit=json.loads((w/'orbital1077_full_audit_report.json').read_text());assert audit['count']==165 and audit['axioms']==[]
for rel,sha in audit['source_sha256'].items():assert digest(r/rel)==sha,rel
cov=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in cov['claims']};entry=by[cid];assert entry['lean_status']=='pending';assert len(entry['v3_registration']['dependencies'])==17
assert all(by[d]['lean_status']=='complete'for d in entry['v3_registration']['dependencies'])
pin=json.loads((w/'pinned1075/SOURCE_IDENTITIES.json').read_text());assert pin['commit']==cov['source_commit']
for item in pin['files']:
 p=item['path'];b=(w/'v3-runtime500'/p).read_bytes();assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==item['sha']
law='sft/chemistry/orbital_support_law_v1.py';validation='sft/chemistry/orbital_support_validation_v1.py';batch='sft/chemistry/orbital_support_batch_v1.py'
scopes={
 'OrbitalSupport':(law,'Exact cell, occupied-support and complete-support fields/domains/guards; joining pair, axis ordinal and symbol correspondence, source-assignment construction.'),
 'OrbitalSupportDerivation':(batch,'Source base and arbitrary-depth successor: joining pair for every admitted carrier, single occurrence, radial/axis coordinate separation, complementary-spin admission, exact complete census, distinct occurrences and added-cell census.'),
 'OrbitalSupportWitnesses':(law,'All five original operational witnesses using actual constructors and original rejection trials.'),
 'OrbitalSupportGrammar':(batch,'Original eight binary axes, all256 ordered alternatives, source first-failure decisions, exhaustive grammar and unique survivor.'),
 'OrbitalSupportEvidence':('sft/chemistry/generated_observational_law.py','Original chemistry observational registration, census, decisions, closure, controls and hashes with actual five witnesses.'),
 'OrbitalSourceTables':(validation,'Exact depth-counter source HTML event handlers, source normalization and source row collection; original standard HTML tokenizer retained.'),
 'OrbitalSupportPrediction':(validation,'Original eight conventional rank labels,22 verified electron-count parity rows, two law counts and all67 prediction instructions.'),
 'OrbitalAssignments':(validation,'Original term/configuration regular-expression domains, ASCII boundaries, Unicode whitespace, positive digit runs, optional occupation and non-overlapping traversal.'),
 'OrbitalSupportTargets':(validation,'Original registry/hash admission, duplicate replacement, signed row ordinal selection, source parsing and registered assignment equality; every360 typed target.'),
 'OrbitalSupportComparison':(validation,'Original prediction-map typing and duplicates, every term/configuration comparison, all counts/messages and six adverse controls.'),
 'OrbitalSupportExperiment':(batch,'Exact specification,360 target references, registration/envelope and original spec admission with actual witness values.'),
 'OrbitalSupportValidation':(validation,'Complete source custody/capability execution, prediction seal, hostile-package audit, release/open/identity checks, comparison payload and all12 empirical return fields.')}
old=cov['summary'].copy();names=audit['declarations'];theorems=[]
for module in scopes:
 t=(r/'SFT/Chemistry'/(module+'.lean')).read_text();ns=re.search(r'^namespace (\S+)',t,re.M)[1];theorems.extend(ns+'.'+n for n in re.findall(r'^theorem (\w+)',t,re.M))
oldtheorems=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newtheorems=[n for n in theorems if n not in oldtheorems]
corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text())
for module,(source,scope)in scopes.items():
 rel='SFT/Chemistry/'+module+'.lean';corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=source,lean_source_sha256=audit['source_sha256'][rel],domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with (r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with (r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newtheorems))
evidence=reports+['orbital1075_independent_report.json','orbital1077_derivation6.log','orbital1076_assembly_audit.log','orbital1076_empirical_output.json','orbital1076_original_empirical.json','check_orbital1076_empirical.py','OrbitalValidationProgram1076.lean']
for name in evidence:shutil.copyfile(w/name,r/'verification'/('TURN_1078_'+name))
record=dict(status='complete',registered_at=now,claim_id=cid,source_commit=cov['source_commit'],source_component_correspondence={m:dict(source=a,component=b)for m,(a,b)in scopes.items()},lean_source_sha256=audit['source_sha256'],dependencies={d:'complete'for d in entry['v3_registration']['dependencies']},candidate_rows=256,axiom_dependencies=[],audited_declarations=names,added_registered_theorems=newtheorems,remaining=[],checks={n:digest(w/n)for n in evidence},build_evidence='Pinned Lean4.35.0 native module compilation and165 declaration audits; full256 programme/fresh source and independent validator; all12 empirical fields and hashes match original V3.',source_operation_cases=114,parser_cases=27,assignment_cases=410,target_rows=360,term_assignments=362,configuration_assignments=87,empirical_controls=6,original_operational_witnesses=5,host_primitives=['Original filesystem/JSON decoding and str/int conversions','Original SHA-256 file hashing','Original HTMLParser tokenizer; custom source event handlers native Lean'])
(r/receipt).write_text(json.dumps(record,indent=2)+'\n')
entry.update(lean_status='complete',remaining=[],lean_modules=list(audit['source_sha256']),completion_evidence=receipt,verified_scope='; '.join(scope for _,scope in scopes.values()),artifact_runtime_parity='PASS full256 programme=fresh V3; all12 empirical fields/all certificate and measurement hashes=original; independent original and three adverse cases; all360 targets,362 terms,87 configurations and six empirical controls.')
completed=sum(x['lean_status']=='complete'for x in cov['claims']);assert completed==old['fully_reconstructed_claims']+1
cov['summary'].update(fully_reconstructed_claims=completed,pending=sum(x['lean_status']=='pending'for x in cov['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newtheorems),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(names));cov['updated_at']=now
(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newtheorems));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;t=p.read_text()
 for tail in [' / 2,781',' V3 entries verified',' model entries',' completed entries',' completed source entries',' source entries']:t=t.replace(str(old['fully_reconstructed_claims'])+tail,str(completed)+tail)
 for key in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:t=t.replace(f'{old[key]:,}',f'{cov["summary"][key]:,}')
 t=t.replace(f'{old["pending"]:,} entries remain pending',f'{cov["summary"]["pending"]:,} entries remain pending')
 if name=='README.md':
  m=re.search(r'([0-9,]+) candidate records matched',t)
  if m:t=t.replace(m[1],f'{int(m[1].replace(",",""))+256:,}')
  t=re.sub(r'(\[latest completion evidence\]\()[^)]+',lambda m:m.group(1)+receipt,t)
 p.write_text(t)
with (r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1078 — '+now+'\nRegistered Orbital Support as'+str(completed)+' immediately after retained empirical result passed all12 fields/366messages/hashes and unchanged protected tree; full256 programme/independent validator,165 zero-axiom declarations and17 actual prerequisites reconciled. Updated coverage, correspondence, global imports/audit and all displayed counts. No repeated source derivation or added scientific condition.\n')
with (r/'ZENODO_PAPER_DRAFT.txt').open('a')as f:f.write('\n\nOrbital-support entry closure\n\nThe complete native empirical validator matches the original V3 return in all12 fields, including366 measurement/control messages and every certificate and measurement hash. It retains all360 registered target rows,362 term assignments,87 configuration assignments and six adverse controls. All17 registered prerequisites are complete. The entry is registered as cumulative completion'+str(completed)+' of2,781, with165 declarations having empty axiom dependencies across12 modules. Source: orbital_support_validation_v1.py, OrbitalSupportValidator.validate. Lean: SFT/Chemistry/OrbitalSupportValidation.lean, validate, and its source-bound component modules. Evidence: '+receipt+'; chronological closure: TIMELINE.txt TURN1078.\n')
p=r/'CONTINUATION_STATE.json';s=json.loads(p.read_text());s['orbital1078']=dict(status='complete',completion_receipt=receipt,count=completed,axiom_free_declarations=165);s['orbital1077']['remaining']=[];s['orbital1077']['empirical_status']='PASS';s['authorized_action']='Orbital registered'+str(completed)+'. Continue exact conjugated-support source derivation/validation using existing core108cases/five witnesses and original grammar/entry comparison handle. Retain GrandLock075 PID42298/session81876 and register075 before076 when its own source checks pass. Update paper/timeline/counts and push; pause at750 complete review package. Preserve canonical current_step39335 and sync46012.';s['recorded_at']=now;p.write_text(json.dumps(s,indent=2)+'\n')
print(json.dumps(cov['summary']))

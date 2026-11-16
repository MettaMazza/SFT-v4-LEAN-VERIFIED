from pathlib import Path
import json,re,hashlib,datetime,shutil
w=Path('work');r=w/'turn1064_recovery';now=datetime.datetime.now(datetime.timezone.utc).isoformat()
cid='SFT-CHEM-ROVIBRONIC-COMPOSITION-001';receipt='verification/TURN_1071_ROVIBRONIC_COMPLETION.json'
cov=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in cov['claims']};e=by[cid]
assert e['lean_status']=='pending';assert all(by[x]['lean_status']=='complete' for x in e['v3_registration']['dependencies'])
checks=['rovibronic1070_operations_report.json','rovibronic1070_program_report.json','rovibronic1070_empirical_report.json','rovibronic1070_audit_report.json']
for n in checks:assert json.loads((w/n).read_text())['status']=='PASS'
independent=json.loads((w/'rovibronic1070_independent_report.json').read_text());assert len(independent)==4
assert all(x['result']['passed']==(x['case']=='original') for x in independent)
assert json.loads((w/'rovibronic1070_program_output.json').read_text())['registration']['provenance']==['observational_derivation']
cfg=json.loads((w/'rovibronic1070_audit_report.json').read_text())
for rel,sha in cfg['source_sha256'].items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==sha
scopes={
'MolecularRovibronicState':('sft/chemistry/rovibronic_composition_derivation.py','Exact original state fields, ordered six admission guards, rotational_recurrence, vibrational_recurrence, six-field exact_state_key and same-carrier isotopologue_distinguishable; original input domain and error decisions.'),
'MolecularRovibronicRecurrences':('sft/chemistry/rovibronic_composition_derivation.py','Every positive-ordinal recurrence follows the existing Physics ladder: q(n+1)=2n+1 and R(n+1)=(n+1)(n+2); exact six-field key assembly from both operation results.'),
'MolecularRovibronicWitnesses':('sft/chemistry/rovibronic_composition_derivation.py','All three original operational witnesses, exact H2/D2 electronic/isotope/spin/observation inputs, first positive recurrences and incomplete-isotope rejection; zero-axiom kernel proofs.'),
'MolecularRovibronicGrammar':('sft/chemistry/rovibronic_composition_derivation.py','All eight original binary axes, all256 ordered alternatives, complete enumeration, exact preservation criteria, original first-failure decisions and unique survivor.'),
'MolecularRovibronicEvidence':('sft/chemistry/generated_observational_law.py','Complete original GeneratedObservationalChemistryProgram registration, census, source-bound witnesses, decisions, closure, four controls and unknown-identifier rejection; inherited generated programme operations unchanged.'),
'MolecularRovibronicExperiment':('sft/chemistry/rovibronic_composition_batch.py','Exact fixed Chemistry specification and observational_experiment_registration_record, original target reference, disclosure flags, prediction programme and envelope.'),
'MolecularRovibronicValidation':('sft/chemistry/rovibronic_composition_validation.py','Complete original RovibronicCompositionValidator: authoritative source/component checks, all four exact ratio rows, both hierarchies and isotope direction, post-seal custody, observed and tampered comparisons, six measurement messages and every empirical output/receipt/isolation/custody field. Existing Physics molecular derivation reused.')}
audit=(w/'rovibronic1070_audit.log').read_text()+(w/'rovibronic1070_validation_render_audit.log').read_text()
names=[];theorems=[];hashes={}
for module in scopes:
 rel='SFT/Chemistry/'+module+'.lean';s=(r/rel).read_text();assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M)
 ns=re.search(r'^namespace (\S+)',s,re.M)[1]
 names.extend(ns+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M))
 theorems.extend(ns+'.'+n for n in re.findall(r'^theorem (\w+)',s,re.M))
 hashes[rel]=hashlib.sha256(s.encode()).hexdigest()
assert len(names)==131;assert all("'"+n+"' does not depend on any axioms" in audit for n in names)
for log in ['rovibronic1070_core_linked.log','rovibronic1070_witnesses_monadic.log','rovibronic1070_recurrences.log','rovibronic1070_grammar.log','MolecularRovibronicEvidence1070_build.log','MolecularRovibronicExperiment1070_build.log','rovibronic1070_validation_render_build.log']:
 s=(w/log).read_text();assert '"exit": 0' in s and 'error:' not in s,log
old=cov['summary'].copy();oldth=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newth=[n for n in theorems if n not in oldth]
corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text())
for module,(source,scope) in scopes.items():
 rel='SFT/Chemistry/'+module+'.lean'
 corr['modules' if 'Grammar' in module else 'evidence_modules'].append(dict(module=rel,v3_claim=cid,source_path=source,lean_source_sha256=hashes[rel],domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with (r/'SFT.lean').open('a') as f:f.write('\n'+imp+'\n')
with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+n+'\n'for n in newth))
(r/'verification').mkdir(exist_ok=True)
evidence=checks+['rovibronic1070_independent_report.json','rovibronic1070_audit.log','rovibronic1070_validation_render_audit.log','check_rovibronic1070_operations.py','finish_rovibronic1070_program.py','check_rovibronic1070_empirical_current.py']
for n in evidence:shutil.copyfile(w/n,r/'verification'/('TURN_1071_'+n))
record=dict(status='complete',registered_at=now,claim_id=cid,source_commit=cov['source_commit'],source_component_correspondence={m:dict(source=a,component=b)for m,(a,b)in scopes.items()},lean_source_sha256=hashes,dependencies={d:'complete'for d in e['v3_registration']['dependencies']},candidate_rows=256,axiom_dependencies=[],audited_declarations=names,added_registered_theorems=newth,remaining=[],checks={n:hashlib.sha256((w/n).read_bytes()).hexdigest()for n in evidence},build_evidence='Pinned Lean4.35.0 successful module compilation of all seven targets; all131 declarations empty-axiom audited; current native complete programme and empirical equality, original independent validator and three adverse cases.',source_operation_cases=22,comparison_cases=4,original_operational_witnesses=3)
(r/receipt).write_text(json.dumps(record,indent=2)+'\n')
e.update(lean_status='complete',remaining=[],lean_modules=list(hashes),completion_evidence=receipt,verified_scope='; '.join(b for a,b in scopes.values()),artifact_runtime_parity='PASS native complete256 programme=fresh V3; all empirical fields and hashes=current native=fresh original=pinned; all three original witnesses and26 source-operation cases; independent original/three adverse cases.')
completed=sum(x['lean_status']=='complete'for x in cov['claims']);assert completed==old['fully_reconstructed_claims']+1
cov['summary'].update(fully_reconstructed_claims=completed,pending=sum(x['lean_status']=='pending'for x in cov['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newth),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(names));cov['updated_at']=now
(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newth));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;s=p.read_text()
 for tail in [' / 2,781',' V3 entries verified',' model entries',' completed entries',' completed source entries',' source entries']:s=s.replace(str(old['fully_reconstructed_claims'])+tail,str(completed)+tail)
 for key in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:s=s.replace(f'{old[key]:,}',f'{cov["summary"][key]:,}')
 s=s.replace(f'{old["pending"]:,} entries remain pending',f'{cov["summary"]["pending"]:,} entries remain pending')
 if name=='README.md':
  m=re.search(r'([0-9,]+) candidate records matched',s)
  if m:s=s.replace(m[0],f'{int(m[1].replace(",",""))+256:,} candidate records matched')
  s=re.sub(r'(\[latest completion evidence\]\()[^)]+',lambda m:m.group(1)+receipt,s)
 if name=='ZENODO_PAPER_DRAFT.txt':
  s=s.replace('Full entry registration follows the complete programme and empirical comparisons and prerequisite registration; the source equations and existing Physics derivations are unchanged.','The complete256-candidate programme, original independent validator and three adverse controls, and full current empirical output have passed their source comparisons. All14 registered prerequisites are complete. The entry is verified as cumulative entry713, with131 audited declarations and no axiom dependencies; the source equations and existing Physics derivations are unchanged.')
  s+='\nThe complete rovibronic entry correspondence and verification evidence are recorded in verification/TURN_1071_ROVIBRONIC_COMPLETION.json. Chronological closure: TIMELINE.txt TURN1071.\n'
 p.write_text(s)
with (r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1071 — '+now+'\nCompleted the current zero-axiom rovibronic empirical run: all original/pinned/native fields and hashes matched. The retained256-programme run PID48347 exited0 after1318.14seconds, peak987.48MiB; fresh original outputs and original independent validator plus three adverse cases all passed. All131 declarations and seven module builds have passing applicable evidence. Inspected all14 actual registered prerequisites: each is complete, and075/076 are not prerequisites. Corrected the assistant continuation note that unnecessarily deferred this independent entry, following the same source-dependency reconciliation already applied inTURN1064. Registered rovibronic immediately as713, updated coverage/correspondence, imports/audit, README/banner and paper. Preserved075 runtime and all unchanged source proofs.\n')
p=r/'CONTINUATION_STATE.json';d=json.loads(p.read_text());d['grandlock1070']['rovibronic'].update(registered=True,remaining=[],completion_receipt=receipt);d['scientific_cursor']=dict(completed=cid,next='SFT-PHYS-GRAND-LOCK-TERMINAL-075',receipt=receipt,source='claims/SFT-PHYS-GRAND-LOCK-TERMINAL-075/execution.py',next_milestone=750);d['grandlock1070']['action']='Rovibronic complete713 with all14 own prerequisites closed; do not hold independent completions behind075. Retain075 runtime, register075 then its actual dependant076 after075 original checks pass. Continue source-bound electron-count/spin batch while075 runs.'
d['live_jobs_current'].pop('rovibronic_program',None);d['live_jobs_current'].pop('rovibronic_empirical',None);d['recorded_at']=now;p.write_text(json.dumps(d,indent=2)+'\n')
print(json.dumps(cov['summary']))

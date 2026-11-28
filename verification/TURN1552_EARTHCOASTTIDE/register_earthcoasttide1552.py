from pathlib import Path
import json,re,hashlib,datetime,shutil,fcntl
w=Path('work');r=w/'turn1064_recovery';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();cid='SFT-EARTH-COAST-TIDE-001';receipt='verification/TURN1552_EARTHCOASTTIDE_COMPLETION.json';dest=r/'verification/TURN1552_EARTHCOASTTIDE';dest.mkdir(exist_ok=True)
reports=['earthcoasttide1496_full_entry_audit_report.json','earth1448_structural_comparison_report.json','earth1448_source_report.json','earthcoasttide1496_validation_cases_report.json','earthcoasttide1496_original_report.json','earthcoasttide1496_program_report.json','coasttide_resolved1552_report.json']
audit=json.loads((w/reports[0]).read_text());names=audit['declarations'];hashes={'SFT/EarthEnvironment/'+m+'.lean':h for m,h in audit['source_sha256'].items()};assert len(names)==len(set(names))==156
for rel,h in hashes.items():assert H(r/rel)==h,rel
for n in reports:
 a=json.loads((w/n).read_text());assert a['status']=='PASS',n
 for rel,h in a.get('source_sha256',a.get('lean_source_sha256',{})).items():
  path=rel if rel.startswith('SFT/')else'SFT/EarthEnvironment/'+rel+'.lean';assert H(r/path)==h,(n,path)
ind=json.loads((w/'earthcoasttide1496_independent_report.json').read_text());assert len(ind)==4 and all(x['result']['passed']==(x['case']=='original')for x in ind)
assert json.loads((w/'coasttide_resolved1552_output.json').read_text())==json.loads((w/'coasttide_resolved1552_expected.json').read_text())
expected=json.loads((w/'earthcoasttide1496_validation_expected.json').read_text());guard=expected['validation']['error'];assert guard.startswith('Earth source snapshot changed: ')
for item in json.loads((w/'earthcoasttide1496_program_pin.json').read_text()):assert H(w/'pinned1496'/item['path'])==item['sha256'],item['path']
scopes={
'StructuralModel':('sft/earth_environment/structural_model.py','Original exact partition, transfer, layer, Fold recurrence/fibre, exponent, bounded modes and six-status operations; originalNineWitnesses, complementaryRecurrence, statusSeparation and transferWitness. 80 operation cases and seven complete records.'),
'EarthCoastTide':('sft/earth_environment/obligations.py; generated_law.py:_family_witness/_blueprints','Exact depth-indexed water-mass coasttide obligation, carrier/relation/boundary witnesses and original ocean_coast coupled three-reservoir recurrence and closure witness.'),
'EarthCoastTideGrammar':('sft/earth_environment/generated_law.py:_dimensions/_blueprints','Eight original binary axes, complete ordered 256 alternatives, exact decisions, surviving tuple and exhaustive classification.'),
'EarthCoastTideEvidence':('sft/earth_environment/empirical_program.py:GeneratedEmpiricalEarthProgram; sft/chemistry/generated_observational_law.py:GeneratedObservationalChemistryProgram','Original registration, four operational witnesses, base/successor closure, source identities and four controls; complete programme comparison and original independent validator including three adverse cases.'),
'Source':('sft/earth_environment/empirical_program.py:_verified_payload/validate_pre_source_seal/validate_external_evidence/_target_row','Original identity, pre-source seal, source-byte, retained-adverse-result and target-binding guards; exact retained source-snapshot rejection, unchanged.'),
'EarthCoastTideExperiment':('sft/earth_environment/empirical_program.py:prediction_program_document/experiment_registration_record/EmpiricalEarthSpec.validate','Original four-instruction prediction and 17-field registration constructor, source row bindings and specification guards.'),
'EarthCoastTideValidation':('sft/earth_environment/empirical_program.py:BlindEarthBoundaryValidator.validate','Original prediction execution, hostile-package audit, seals, target custody/release, isolation, four measurement messages and 12-field continuation; conditional source-slice parity. Full original empirical execution retains its source-snapshot rejection and is not relabelled a successful external validation.')}
# Bind inherited implementation to the actual original class, rather than a guessed source name.
import sys
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.earth_environment.empirical_program import GeneratedEmpiricalEarthProgram
mro=[x.__module__+'.'+x.__name__ for x in GeneratedEmpiricalEarthProgram.__mro__]
scopes['EarthCoastTideEvidence']=( 'sft/earth_environment/empirical_program.py:GeneratedEmpiricalEarthProgram; '+ '; '.join(mro[1:-1]),scopes['EarthCoastTideEvidence'][1])
evidence=reports+['earthcoasttide1496_independent_report.json','earthcoasttide1496_program_pin.json','earthcoasttide1496_program_output.json','earthcoasttide1496_original_program.json','earthcoasttide1496_validation_expected.json','coasttide_resolved1552_source_slice.json','coasttide_resolved1552_output.json','coasttide_resolved1552_expected.json','coasttide_resolved1552_input.json','prepare_coasttide_resolved1552.py','run_coasttide1552_checks.py','coasttide_resolved1552_execution.log']
for n in evidence:shutil.copyfile(w/n,dest/n)
with(w/'entry_registration.lock').open('a')as lock:
 fcntl.flock(lock,fcntl.LOCK_EX);c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status']!='complete';assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();assert old['fully_reconstructed_claims']==1103;newCount=old['fully_reconstructed_claims']+1;now=datetime.datetime.now(datetime.timezone.utc).isoformat()
 corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[]
 for m,(src,scope)in scopes.items():
  if m in ['StructuralModel','Source']:continue
  rel='SFT/EarthEnvironment/'+m+'.lean';theorems=['SFT.EarthEnvironment.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];assert all(n in names for n in theorems);newNames +=[n for n in theorems if n not in oldNames];corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=src,lean_source_sha256=hashes[rel],domain=scope,remaining=[],completion_evidence=receipt))
  imp='import '+rel[:-5].replace('/','.')
  if imp not in(r/'SFT.lean').read_text().splitlines():
   with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
 with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
 record=dict(status='complete',registered_at=now,claim_id=cid,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_component_correspondence={m:dict(source=p,component=s)for m,(p,s)in scopes.items()},lean_source_sha256=hashes,dependencies={d:'complete'for d in x['v3_registration']['dependencies']},candidate_rows=256,axiom_dependencies=[],audited_declarations=names,added_registered_theorems=newNames,remaining=[],empirical_outcome={'full_original_and_native':guard,'resolved_continuation_fields':12,'resolved_continuation_scope':'Conditional original continuation only, not a successful end-to-end external validation'},checks={n:H(w/n)for n in evidence})
 (r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',lean_modules=list(hashes),remaining=[],completion_evidence=receipt,artifact_runtime_parity='PASS complete original programme, independent controls, structural operations, source guards and conditional validator continuation; original source-snapshot rejection preserved',verified_scope='; '.join(v[1]for v in scopes.values()))
 c['summary'].update(fully_reconstructed_claims=newCount,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(names));c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
 oldCount=old['fully_reconstructed_claims'];oldCandidates=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text()).group(1).replace(',',''))
 for fn in ['README.md','ZENODO_PAPER_DRAFT.txt','docs/assets/sft-banner.svg']:
  p=r/fn;s=p.read_text()
  for a,b in [(f'{oldCount:,} / 2,781',f'{newCount:,} / 2,781'),(f'{oldCount:,} entries complete',f'{newCount:,} entries complete'),(f'{oldCount} / 2,781',f'{newCount} / 2,781'),(f'{oldCount} entries complete',f'{newCount} entries complete'),(f'{oldCount} completed entries',f'{newCount} completed entries'),(f'{oldCount} V3 entries verified',f'{newCount} V3 entries verified'),(f'{oldCount} model entries complete',f'{newCount} model entries complete'),(f'{oldCount} completed source entries',f'{newCount} completed source entries'),(f'{2781-oldCount:,} entries remain unfinished.',f'{2781-newCount:,} entries remain unfinished.'),(f'{old["axiom_free_exported_results"]:,}',f'{c["summary"]["axiom_free_exported_results"]:,}'),(f'{old["axiom_free_audited_definitions_and_theorems"]:,}',f'{c["summary"]["axiom_free_audited_definitions_and_theorems"]:,}'),(f'{oldCandidates:,}',f'{oldCandidates+256:,}')]:s=s.replace(a,b)
  if fn=='README.md':s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s)
  # Explicit display numerators only; preserve census total and SVG colours.
  p.write_text(s)
 nextId=next(z['claim_id']for z in c['claims']if z['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in z['v3_registration']['dependencies']))
 s=json.loads((r/'CONTINUATION_STATE.json').read_text());s['earthcoasttide1552']=record;s.pop('earthcoasttide1552_live',None);s.pop('turn1552_live_processes',None);s['authorized_action']=str(newCount)+' complete. Continue '+nextId+' toward1250, bounded processes, update paper/timeline/counts and push; pause at1250 for review.';s['scientific_cursor']={'completed':cid,'next':nextId,'next_milestone':1250,'action':s['authorized_action']};(r/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n');print('REGISTERED',newCount,'next',nextId)

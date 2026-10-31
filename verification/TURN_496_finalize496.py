from pathlib import Path
import json,re,shutil,datetime,subprocess
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');c=json.loads((r/'COVERAGE.json').read_text());groups={'matter':json.load(open('work/matter496_all_entries.json'))};entries=[(family,*e) for family,es in groups.items() for e in es];by={e['claim_id']:e for e in c['claims']};paths=set(json.load(open('work/checkpoint496_paths.json')))
assert c['summary']['fully_reconstructed_claims']==276 and len(entries)==3
for family,stem,key,component in entries:
 e=by[json.load(open('work/matter496_all_metadata.json'))[stem]['claim_id']];assert e['lean_status']=='complete' and not e['remaining'];assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
 for part in ['program','validation']:assert json.load(open('work/'+stem.lower()+'_'+part+'496_report.json'))['status']=='PASS'
 cases=json.load(open('work/'+stem.lower()+'_independent496_report.json'));assert len(cases)==4 and all(x['actual']['passed']==x['expected'] for x in cases)
 for rel in e['lean_modules']:assert (r/rel).read_bytes()==(rec/rel).read_bytes(),rel
for log in ['build_matter496.log','build_fusion_program496.log','build_colour496_final.log']:assert 'Build completed successfully' in Path('work/'+log).read_text()
names=['prepare_fusion496.py','prepare_fusion496.log','build_fusion496.log','build_fusion_program496.py','build_fusion_program496.log','build_fusion_program496_coordinator.log','run_fusion496.py','fusion496_run.log','prepare_colour496.py','prepare_colour496.log','colour_witness496.txt','build_colour_derivation496.log','build_colour_derivation496_final.log','build_colour496.log','build_colour496_final.log','run_colour496.py','colour496_run.log','check_colour496.py','register_colour496.py','register_planck496.py','Colour496Audit.lean','colour496_audit.log','colour496_audit_config.json','colour496_program_report.json','colour496_program_output.json','colour496_independent.py','colour496_independent_report.json','planck_colour496_build.log','Planck496Audit.lean','planck496_audit.log','unified_remaining496.json','matter496_all_entries.json','matter496_all_metadata.json','matter496_fusion_metadata.json','finalize496.py']
for family in groups:
 names += [f'prepare_{family}496.py',f'prepare_{family}496.log',f'build_{family}496.py',f'build_{family}496.log',f'build_{family}496_coordinator.log',f'run_{family}496.py',f'{family}496_run.log',f'register_{family}496.py',f'{family}496_entries.json',f'{family}496_metadata.json',f'{family}496_scopes.json',f'audit{family}496_config.json']
for name in names:
 p=Path('work')/name
 if p.exists():rel='verification/TURN_496_'+name;shutil.copy2(p,r/rel);paths.add(rel)
for family in groups:
 for p in Path('work/'+family+'496_source').iterdir():
  rel='verification/TURN_496_SOURCE/'+p.name;(r/rel).parent.mkdir(exist_ok=True);shutil.copy2(p,r/rel);paths.add(rel)
for source in ['sft/physics/matter_nuclear_laws.py','sft/physics/generated_empirical_law.py','sft/physics/atomic_constants.py','sft/physics/structural_constants.py','sft/physics/precision_value_laws_v1.py']:
 rel='verification/TURN_496_SOURCE/'+Path(source).name;(r/rel).write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',c['source_commit']+':'+source]));paths.add(rel)
for _,stem,_,_ in entries:
 for part in ['spec','grammar','evidence','experiment']:
  p=Path('work')/(stem.lower()+'_'+part+'496.py');rel='verification/TURN_496_'+p.name;shutil.copy2(p,r/rel);paths.add(rel)
nextmods=[];nextcount=0
for cid in ['SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001','SFT-PHYS-SCALE-PROTON-PLANCK-TERMINAL-003']:
 e=by[cid];assert e['lean_status']=='complete' and not e['remaining'];assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
 for rel in e['lean_modules']:assert (r/rel).read_bytes()==(rec/rel).read_bytes(),rel
for log in ['colour496_audit.log','planck496_audit.log']:
 audit=Path('work/'+log).read_text();assert 'depends on axioms:' not in audit and 'error' not in audit
assert json.load(open('work/colour496_program_report.json'))['status']=='PASS'
assert all(x['actual']['passed']==x['expected'] for x in json.load(open('work/colour496_independent_report.json')))
assert json.load(open('work/planck_native489_report.json'))['status']=='PASS'
total=c['summary']['fully_reconstructed_claims'];ths=c['summary']['axiom_free_exported_results'];defs=c['summary']['axiom_free_audited_definitions_and_theorems'];rows=92006+3*256+128+1024
assert ths==len(set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M)))
assert defs==len(set(re.findall("'([^']+)' does not depend on any axioms",(r/'verification/TURN_496_REGISTERED_DECLARATIONS_AUDIT.log').read_text())))
p=r/'ZENODO_PAPER_DRAFT.txt';s=p.read_text();assert '\n436.' not in s
s=re.sub(r'The accompanying formalisation contains [0-9,]+ audited theorems; the audit covers [0-9,]+ definitions and theorems and reports zero axiom dependencies\.',f'The accompanying formalisation contains {ths:,} audited theorems; the audit covers {defs:,} definitions and theorems and reports zero axiom dependencies.',s)
s=re.sub(r'The registered formalisation contains [^\n]+',f'The registered formalisation contains {total} completed entries out of 2,781, with {ths:,} audited theorems and {defs:,} audited definitions and theorems, all with zero axiom dependencies. Registered candidate comparisons cover {rows:,} records across {total} completed entries. The terminal Planck entry is complete, including its 1,024-form native comparison, original independent-validator checks and source-derived colour-coupling dependency.',s,count=1)
s=s.replace('TURN_495_BATCH_COMPLETION.json and its referenced evidence record the current continuation results.','TURN_496_BATCH_COMPLETION.json and its referenced evidence record the current continuation results.');s=s.replace('This equation describes the terminal component; completion of that separate source entry is recorded separately from completion of the base hierarchy.','The terminal source entry is complete, including the independent colour-coupling dependency and its exact correspondence to the hierarchy share.');s+=Path('work/paper496_addition.txt').read_text();assert re.findall(r'^(\d+)\. ',s,re.M)==list(map(str,range(1,441)));p.write_text(s)
p=r/'README.md';s=p.read_text();s=re.sub(r'TURN_\d+_REGISTERED_DECLARATIONS_AUDIT.log','TURN_496_REGISTERED_DECLARATIONS_AUDIT.log',s);s=s.replace('1 entries are in progress','1 entry is in progress');s=re.sub(r'(Current registered comparisons cover \*\*[0-9,]+ candidate records across )\d+( source entries)',lambda m:m[1]+str(total)+m[2],s);s=s.replace('State mixing, nuclear binding, nuclear levels and complete-path radioactivity verified.','Nuclear reactions, fission, fusion, exact colour coupling and terminal Planck hierarchy verified.');p.write_text(s)
summary=dict(source_commit=c['source_commit'],completed_entries=total,in_progress=c['summary']['in_progress'],registered_theorems=ths,audited_definitions_and_theorems=defs,registered_candidate_rows=rows,new_completed_entries=5,scientific_component_audits=sum(len([n for n in v["declarations"] if any(n.startswith("SFT.Physics."+m+".") for m in [entry[2] for entry in groups["matter"]]+["ColourCouplingDerivation","PlanckColourCorrespondence"])]) for v in json.load(open("work/auditmatter496_config.json")).values())+sum(n.startswith('SFT.Physics.ColourCouplingDerivation.') for n in json.load(open('work/colour496_audit_config.json'))['declarations'])+2,fresh_terminal_planck_audited_declarations=240,axiom_dependencies=[],remaining_for_completed_entries=[],staged_next_components=nextmods,staged_next_audited_declarations=nextcount,full_model_complete=False);rel='verification/TURN_496_BATCH_COMPLETION.json';(r/rel).write_text(json.dumps(summary,indent=2)+'\n');paths.add(rel)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+Path('work/timeline496_addition.txt').read_text()+f'\nFinal totals {total}/2781 completed, {ths} registered theorems, {defs} audited definitions/theorems, {rows} candidate records and 440 numbered manuscript sections. Next freeze, push and verify this five-entry checkpoint; continue the dependency-ready original vacuum-scale ancestors toward Unified Constants. No milestone reached. No Zenodo publication.\n')
paths.update(['README.md','ZENODO_PAPER_DRAFT.txt','TIMELINE.txt','COVERAGE.json','reference/CORRESPONDENCE.json']);Path('work/checkpoint496_paths.json').write_text(json.dumps(sorted(paths)));print(json.dumps(summary,indent=2))

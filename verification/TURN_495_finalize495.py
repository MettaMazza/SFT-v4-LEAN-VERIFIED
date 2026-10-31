from pathlib import Path
import json,re,shutil,datetime,subprocess
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');c=json.loads((r/'COVERAGE.json').read_text());groups={'matter':json.load(open('work/matter495_all_entries.json'))};entries=[(family,*e) for family,es in groups.items() for e in es];by={e['claim_id']:e for e in c['claims']};paths=set(json.load(open('work/checkpoint495_paths.json')))
assert c['summary']['fully_reconstructed_claims']==271 and len(entries)==4
for family,stem,key,component in entries:
 e=by[json.load(open('work/matter495_all_metadata.json'))[stem]['claim_id']];assert e['lean_status']=='complete' and not e['remaining'];assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
 for part in ['program','validation']:assert json.load(open('work/'+stem.lower()+'_'+part+'495_report.json'))['status']=='PASS'
 cases=json.load(open('work/'+stem.lower()+'_independent495_report.json'));assert len(cases)==4 and all(x['actual']['passed']==x['expected'] for x in cases)
 for rel in e['lean_modules']:assert (r/rel).read_bytes()==(rec/rel).read_bytes(),rel
for log in ['build_matter495.log','build_matter495_all.log']:assert 'Build completed successfully' in Path('work/'+log).read_text()
names=['matter495_namespace_collision.log','prepare_matter496.py','prepare_matter496.log','build_matter496.py','prepare_matter495_tail.py','prepare_matter495_tail.log','build_matter495_all.py','build_matter495_all.log','build_matter495_all_coordinator.log','build_mixing495.log','build_binding495.log','build_levels495.log','build_radioactivity495.log','Matter495Audit.lean','matter495_component_audit.log','matter495_all_entries.json','matter495_all_metadata.json','matter495_tail_metadata.json','finalize495.py']
for family in groups:
 names += [f'prepare_{family}495.py',f'prepare_{family}495.log',f'build_{family}495.py',f'build_{family}495.log',f'build_{family}495_coordinator.log',f'run_{family}495.py',f'{family}495_run.log',f'register_{family}495.py',f'{family}495_entries.json',f'{family}495_metadata.json',f'{family}495_scopes.json',f'audit{family}495_config.json']
for name in names:
 p=Path('work')/name
 if p.exists():rel='verification/TURN_495_'+name;shutil.copy2(p,r/rel);paths.add(rel)
for family in groups:
 for p in Path('work/'+family+'495_source').iterdir():
  rel='verification/TURN_495_SOURCE/'+p.name;(r/rel).parent.mkdir(exist_ok=True);shutil.copy2(p,r/rel);paths.add(rel)
for source in ['sft/physics/matter_nuclear_laws.py','sft/physics/generated_empirical_law.py']:
 rel='verification/TURN_495_SOURCE/'+Path(source).name;(r/rel).write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',c['source_commit']+':'+source]));paths.add(rel)
for _,stem,_,_ in entries:
 for part in ['spec','grammar','evidence','experiment']:
  p=Path('work')/(stem.lower()+'_'+part+'495.py');rel='verification/TURN_495_'+p.name;shutil.copy2(p,r/rel);paths.add(rel)
nextmods=['NuclearReactions','NuclearFission']
for m in nextmods:
 rel='verification/TURN_495_NUCLEAR_STAGE/'+m+'.lean';(r/rel).parent.mkdir(exist_ok=True);shutil.copy2(rec/'SFT/Physics'/(m+'.lean'),r/rel);paths.add(rel)
for name in ['build_nuclear_stage495.log','NuclearStage495Audit.lean','nuclear_stage495_audit.log']:
 rel='verification/TURN_495_'+name;shutil.copy2(Path('work')/name,r/rel);paths.add(rel)
audit=Path('work/matter495_component_audit.log').read_text();assert 'depends on axioms:' not in audit and 'error' not in audit
stage=Path('work/nuclear_stage495_audit.log').read_text();assert 'depends on axioms:' not in stage and 'error' not in stage
nextcount=stage.count('does not depend on any axioms')
total=c['summary']['fully_reconstructed_claims'];ths=c['summary']['axiom_free_exported_results'];defs=c['summary']['axiom_free_audited_definitions_and_theorems'];rows=90982+4*256
assert ths==len(set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M)))
assert defs==len(set(re.findall("'([^']+)' does not depend on any axioms",(r/'verification/TURN_495_REGISTERED_DECLARATIONS_AUDIT.log').read_text())))
p=r/'ZENODO_PAPER_DRAFT.txt';s=p.read_text();assert '\n432.' not in s
s=re.sub(r'The accompanying formalisation contains [0-9,]+ audited theorems; the audit covers [0-9,]+ definitions and theorems and reports zero axiom dependencies\.',f'The accompanying formalisation contains {ths:,} audited theorems; the audit covers {defs:,} definitions and theorems and reports zero axiom dependencies.',s)
s=re.sub(r'The registered formalisation contains [^\n]+',f'The registered formalisation contains {total} completed entries out of 2,781, with {ths:,} audited theorems and {defs:,} audited definitions and theorems, all with zero axiom dependencies. Registered candidate comparisons cover {rows:,} records across {total} completed entries. Terminal Planck has a separately verified 1,024-form native comparison and original independent-validator checks; its nuclear-coupling dependency remains incomplete.',s,count=1)
s=s.replace('TURN_494_BATCH_COMPLETION.json and its referenced evidence record the current continuation results.','TURN_495_BATCH_COMPLETION.json and its referenced evidence record the current continuation results.');s+=Path('work/paper495_addition.txt').read_text();assert re.findall(r'^(\d+)\. ',s,re.M)==list(map(str,range(1,436)));p.write_text(s)
p=r/'README.md';s=p.read_text();s=re.sub(r'TURN_\d+_REGISTERED_DECLARATIONS_AUDIT.log','TURN_495_REGISTERED_DECLARATIONS_AUDIT.log',s);s=s.replace('1 entries are in progress','1 entry is in progress');s=re.sub(r'(Current registered comparisons cover \*\*[0-9,]+ candidate records across )\d+( source entries)',lambda m:m[1]+str(total)+m[2],s);s=s.replace('Matter through exchange, conserved labels, particle spectrum, hadrons, scattering and decay verified.','State mixing, nuclear binding, nuclear levels and complete-path radioactivity verified.');p.write_text(s)
summary=dict(source_commit=c['source_commit'],completed_entries=total,in_progress=c['summary']['in_progress'],registered_theorems=ths,audited_definitions_and_theorems=defs,registered_candidate_rows=rows,new_completed_entries=4,scientific_component_audits=sum(len([n for n in v["declarations"] if any(n.startswith("SFT.Physics."+m+".") for m in [entry[2] for entry in groups["matter"]]+["MatterExchangeSpin"])]) for v in json.load(open("work/auditmatter495_config.json")).values()),axiom_dependencies=[],remaining_for_completed_entries=[],staged_next_components=nextmods,staged_next_audited_declarations=nextcount,full_model_complete=False);rel='verification/TURN_495_BATCH_COMPLETION.json';(r/rel).write_text(json.dumps(summary,indent=2)+'\n');paths.add(rel)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+Path('work/timeline495_addition.txt').read_text()+f'\nFinal totals {total}/2781 completed, {ths} registered theorems, {defs} audited definitions/theorems, {rows} candidate records and 435 numbered manuscript sections. Next freeze, push and verify this four-entry checkpoint; continue NUCLEAR_REACTIONS, FISSION and FUSION toward Unified Constants. No milestone reached. No Zenodo publication.\n')
paths.update(['README.md','ZENODO_PAPER_DRAFT.txt','TIMELINE.txt','COVERAGE.json','reference/CORRESPONDENCE.json']);Path('work/checkpoint495_paths.json').write_text(json.dumps(sorted(paths)));print(json.dumps(summary,indent=2))

from pathlib import Path
import json,re,hashlib,subprocess,shutil,datetime
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
configs=json.loads(Path('work/completions381_config.json').read_text());coverage=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in coverage['claims']};corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());newpaths=[];allnames=[];alltheorems=[];sourcecache={}
for row in configs:
 kind=row['kind'];cid=row['claim_id'];entry=by[cid]
 if entry['lean_status']=='complete':continue
 assert entry['lean_status']=='pending'
 assert all(by[x]['lean_status']=='complete' for x in entry['v3_registration']['dependencies']),cid
 report=json.loads(Path('work',kind+'_program_report.json').read_text());assert report['status']=='PASS' and report['candidate_lookup_decisions']==256
 independent=json.loads(Path('work/orbit_independent381_output.json' if kind=='orbit' else 'work/independent_constants378_output.json').read_text());cases=[x for x in independent if x['claim_id']==cid];assert len(cases)==4 and all(x['actual']['passed']==x['expected'] for x in cases)
 audit=Path('work',kind+'_completion381_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in row['declarations']) and 'depends on axioms' not in audit and 'error:' not in audit
 evidence='verification/TURN_381_'+kind.upper()+'_COMPLETION.json';scopes={};paths=[]
 for m in row['modules']:
  path='SFT/'+row['namespace']+'/'+m+'.lean';s=(rec/path).read_text();assert not (r/path).exists(),path;assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M)
  source=row['source']
  if kind=='orbit':
   if 'Grammar' in m or 'Census' in m:scope='ORBIT_NUMBER_THEORY dimensions, exact original256 Cartesian forms/order, decision predicates/reasons, exhaustive coverage and unique survivor.'
   elif m in ['OrbitControls','OrbitEvidence']:scope='GeneratedMathematicsProgram original registration, census, lookup, closure, four controls, canonical identities and hashes.';source='sft/mathematics/generated_law.py'
   elif 'Witness' in m:scope='ORBIT_NUMBER_THEORY original four witnesses, all49 odd denominators3..99 and every reduced-rank ordered trace, preserving original guard/update/stopping branches.'
   elif m=='OrbitBinaryDepth':scope='ORBIT_NUMBER_THEORY binary-valuation/transient law: actual normalized denominator at,before and after the counted binary depth.'
   elif m in ['OrbitCyclotomic','OrbitTilingCount']:scope='ORBIT_NUMBER_THEORY laws and induction: actual reduced-cycle partition, complete disjoint equal-length support counting and prime-period divisibility.'
   elif m in ['OrbitOrderExistence','OrbitLoopCompletion','OrbitReplayCorrespondence','OrbitNumberWitnessBase']:scope='_order_two and _orbit: original finite source loop transitions, least-return existence, complete ordered trace, termination on admitted parts and period/order equality.'
   else:scope='_fold_rank and ORBIT_NUMBER_THEORY derivation: exact executed modular identity, reduced cancellation, least return, complete cycle support and position injectivity.'
  elif kind=='force_ladder':
   if m=='PrimeSectorLadder':scope='is_prime_count,upper_cover_depth,prime_sector_ladder,mediator_count,sector_coupling: full positive divisor tests, generated ceiling7, complete sectors2,3,5,7, exact pair-cell counts and couplings; prime11 excluded.'
   else:scope='PRIME_SECTOR_SPEC original256 grammar forms/order, witnesses, controls, program records and hashes.'
   if m.endswith(('Controls','Evidence')):source='sft/physics/structural_constants.py'
  else:
   scope='PROTON_PLANCK_SPEC complete256 grammar, witnesses, controls and program fields; generated successor volume81, least binary cover7, unique massive predecessor127, squared hierarchy2^127 and retained unsquared exponent127/2.'
   if m.endswith(('Controls','Evidence')):source='sft/physics/structural_constants.py'
  scopes[m]=scope
  if source not in sourcecache:sourcecache[source]=subprocess.check_output(['git','-C',repo,'show',pin+':'+source])
  record=dict(module=path,v3_claim=cid,source_path=source,source_sha256=hashlib.sha256(sourcecache[source]).hexdigest(),lean_source_sha256=hashlib.sha256(s.encode()).hexdigest(),domain=scope,implemented={n:scope for n in re.findall(r'^\s*(?:def|theorem|structure|inductive) (\w+)',s,re.M)},remaining=[],completion_evidence=evidence)
  if m=='PlanckHierarchy':record['additional_source_components']={'sft/physics/precision_value_laws_v1.py':'Shared native terminalTransport/terminalSquaredHierarchy and related proofs are retained components of pending SFT-PHYS-SCALE-PROTON-PLANCK-TERMINAL-003; this completion marks only the base hierarchy entry.'}
  corr['modules' if m.endswith('Grammar') else 'evidence_modules'].append(record)
  (r/path).parent.mkdir(parents=True,exist_ok=True);(r/path).write_text(s);paths.append(path);newpaths.append(path)
  with (r/'SFT.lean').open('a') as f:f.write('import SFT.'+row['namespace']+'.'+m+'\n')
 with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+n+'\n' for n in row['theorems']))
 grammar={'orbit':'Orbit','force_ladder':'ForceLadder','planck_base':'PlanckBase'}[kind]+'Grammar';ns='SFT.'+row['namespace']+'.'+grammar
 with (r/'Parity.lean').open('a') as f:f.write('\n  for c in '+ns+'.candidates do\n    IO.println ("'+grammar+'\\t" ++ '+ns+'.candidateId c ++ "\\t" ++ (if '+ns+'.survives c then "true" else "false") ++ "\\t" ++ '+ns+'.exactForm c ++ "\\t" ++ '+ns+'.decisionReason c)\n')
 for suffix in ['program_report.json','program_output.json','completion381_audit.log']:
  src=Path('work',kind+'_'+suffix);dest=r/'verification'/('TURN_381_'+kind+'_'+suffix);shutil.copyfile(src,dest);newpaths.append(str(dest.relative_to(r)))
 independentPath='verification/TURN_381_'+kind+'_INDEPENDENT.json';(r/independentPath).write_text(json.dumps(cases,indent=2)+'\n');newpaths.append(independentPath)
 result=dict(status='complete',claim_id=cid,source_commit=pin,source_components=scopes,dependencies={x:'complete' for x in entry['v3_registration']['dependencies']},remaining=[],candidate_rows=256,audited_definitions_and_theorems=len(row['declarations']),native_theorems=len(row['theorems']),axiom_dependencies=[],program_comparison='verification/TURN_381_'+kind+'_program_report.json',independent_validation=independentPath,build_scope='Pinned Lean4.35 targeted native module builds and every named declaration audit; original full program and bound independent validator. No fresh global build is asserted after interrupted Turn375.')
 (r/evidence).write_text(json.dumps(result,indent=2)+'\n');newpaths.append(evidence)
 entry.update(lean_status='complete',remaining=[],lean_modules=paths,completion_evidence=evidence,verified_scope='; '.join(dict.fromkeys(scopes.values())),artifact_runtime_parity='PASS all256 actual source-program lookups, records, hashes and controls; original implementation-distinct validator accepts the native output and rejects omitted candidate, extra survivor and failed control.')
 old=coverage['summary'].copy();n=sum(x['lean_status']=='complete' for x in coverage['claims']);coverage['summary'].update(fully_reconstructed_claims=n,pending=sum(x['lean_status']=='pending' for x in coverage['claims']),in_progress=sum(x['lean_status']=='in_progress' for x in coverage['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(row['theorems']),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(row['declarations']));coverage['updated_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();(r/'COVERAGE.json').write_text(json.dumps(coverage,indent=2)+'\n');(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
 for f in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
  p=r/f;s=p.read_text().replace(str(old['fully_reconstructed_claims'])+' / 2,781',str(n)+' / 2,781').replace(str(old['fully_reconstructed_claims'])+' model entries complete',str(n)+' model entries complete').replace(str(old['fully_reconstructed_claims'])+' completed entries',str(n)+' completed entries').replace(f"{old['axiom_free_exported_results']:,}",f"{coverage['summary']['axiom_free_exported_results']:,}").replace(f"{old['axiom_free_audited_definitions_and_theorems']:,}",f"{coverage['summary']['axiom_free_audited_definitions_and_theorems']:,}");p.write_text(s)
 with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+coverage['updated_at']+' Completion '+str(n)+': '+cid+'. Actual registered dependencies complete. All source-specific derivations, original256 enumeration/witnesses/controls, fresh full-program fields/hashes and four pinned independent-validator cases passed. Registered '+str(len(row['modules']))+' modules, '+str(len(row['theorems']))+' theorems and '+str(len(row['declarations']))+' audited declarations, all zero axioms. Exact source correspondence and completion evidence retained at '+evidence+'. No unrelated host-library condition added.\n')
 allnames+=row['declarations'];alltheorems+=row['theorems']
 print(cid,'COMPLETE',n)
Path('work/completions381_paths.json').write_text(json.dumps(newpaths,indent=2)+'\n')
for f in ['README.md','docs/assets/sft-banner.svg']:
 p=r/f;s=p.read_text().replace('67,174','67,942').replace('across 188 represented source entries','across 191 represented source entries').replace('Half-One vacuum floor complete.','Orbit number theory, force ladder and Planck hierarchy complete.')
 if f=='README.md':
  s=re.sub(r'\*\*Completed source entries:.*','**Completed source entries: 189 / 2,781.** 2 entries are in progress and 2,590 remain pending. Exact source-component evidence is recorded in COVERAGE.json.',s)
  s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence](verification/TURN_381_PLANCK_BASE_COMPLETION.json)',s)
 p.write_text(s)
with (r/'ZENODO_PAPER_DRAFT.txt').open('a') as f:f.write('''\n326. Completed orbit, prime-sector and base hierarchy verification\n\nThe orbit-number-theory entry is complete, including the general return/order identity, disjoint cyclotomic counting, prime-period divisibility, exact binary transient and original source-loop termination. Every one of its 256 original program cases and all original records and hashes reproduce V3. Its implementation-distinct validator accepts the complete native product and rejects each retained adverse variant.\n\nWith that dependency closed, the prime-sector ladder and base proton/Planck hierarchy entries are also complete. The generated ceiling seven admits exactly sectors two, three, five and seven. Their mediator counts are three, eight, twenty-four and forty-eight, with couplings one-half, two-thirds, four-fifths and six-sevenths. The successor volume81 has least binary cover seven; its support128 has unique massive predecessor127. The squared hierarchy is2^127, with the unsquared exponent retained exactly as127/2. Both entries reproduce their complete256-case programs and pass their original independent validators.\n\nThe cumulative ledger contains189 completed V3 entries,9,010 native theorems and20,445 audited definitions and theorems, all with zero axiom dependencies. The base hierarchy completion does not assert completion of the separate terminal hierarchy entry.\n''')
p=r/'ZENODO_PAPER_DRAFT.txt';s=p.read_text();s=re.sub(r'\b(volume|support|is|as|complete|contains|entries,|and)(?=\d)',lambda m:m.group(0)+' ',s);p.write_text(s)
statusPath=r/'verification/TURN_377_NATIVE_BATCH/BATCH_STATUS.json';status=json.loads(statusPath.read_text());status['completed_entries']=189;status['completed_direct_prerequisites']=['SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003','SFT-PHYS-MATTER-QUARK-CUBICS-003','SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002'];status['remaining_direct_prerequisites']=['SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001','SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001','SFT-PHYS-SCALE-PROTON-PLANCK-TERMINAL-003','SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035'];statusPath.write_text(json.dumps(status,indent=2)+'\n')
print(coverage['summary'])

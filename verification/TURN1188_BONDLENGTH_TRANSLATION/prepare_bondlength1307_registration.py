from pathlib import Path
import re,json,ast
w=Path('work');r=w/'turn1064_recovery';mods=['EquilibriumBondLength'+s for s in ['','Grammar','Evidence','Experiment','Source','Validation']];n=sum(len(re.findall(r'^(?:def|theorem)\s+(\w+)',(r/'SFT/Chemistry'/(m+'.lean')).read_text(),re.M))for m in mods)
s=(w/'register_quantum1235.py').read_text().replace('quantum1235','bondlength1307').replace('SFT-CHEM-MOLECULAR-QUANTUM-MEASUREMENT-REDUCTION-014','SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001').replace('TURN1235_QUANTUM','TURN1307_BONDLENGTH').replace('TURN1235','TURN1307').replace('Molecular quantum measurement reduction','Exact H2/D2 equilibrium bond length').replace('142',str(n)).replace('345','4')
s=s.replace("reports=[","reports=['bondlength1307_experiment_report.json',",1)
a=s.index(';scopes=')+1;b=s.index('\noldNames=',a)
scopes={
mods[0]:('sft/chemistry/equilibrium_bond_length_law_v1.py:equilibrium_length_multiplier/equilibrium_length_vector/OPERATIONAL_WITNESSES','Original H2/D2 typed support routes,exact binary alpha power,unsupported-isotopologue guard,ordered two-row vector,common base21/24counts and positive ordering.'),
mods[1]:('sft/chemistry/equilibrium_bond_length_law_v1.py:DIMENSIONS','All eight original binary axes,256literal forms,original elimination reasons,exhaustiveness and unique survivor.'),
mods[2]:('sft/chemistry/equilibrium_bond_length_batch_v1.py:GeneratedFiniteQuantitativeChemistryProgram; generated_observational_law.py','Original registration,census,decisions,finite_complete closure includingboundaryfield and no generality certificate,original controls and three source-bound witnesses.'),
mods[3]:('sft/chemistry/equilibrium_bond_length_validation_v1.py:prediction_program_document/experiment_registration_record; generated_law.py:EmpiricalChemistrySpec.validate','Computed14instruction interval programme,all12registrationfields,exact source IDs and spec guards; no target or physical unit input in dimensionless law.'),
mods[4]:('sft/chemistry/equilibrium_bond_length_validation_v1.py:_fraction/_ratio/_load_scale/_load_targets; equilibrium_bond_length_batch_v1.py:registry initialization','Positive exact conversion,denominator sign normalization,scale guards,last-row dictionary indexing,two matching IDs,complete original reconstruction and unchanged spectroscopy source reuse; original batch initialization guards.'),
mods[5]:('sft/chemistry/equilibrium_bond_length_validation_v1.py:EquilibriumBondLengthValidator.validate','Complete source capability execution,exact input/envelope/seal,hostile audit,custody/release,twointerval overlap comparisons,two displaced controls,all12fields4messages and hashes.')}
s=s[:a]+'scopes='+repr(scopes)+s[b:];s=s.replace('original_target_rows=330','original_target_rows=2').replace('complete330row796cell reconstruction','complete two-isotope interval reconstruction').replace('All 330 rows,796 cells,15 counts and all12 fields4 messages','Both isotope intervals,both displaced controls and all12 fields4 messages')
s=s.replace("if fn=='ZENODO_PAPER_DRAFT.txt':s=s.replace('Its full native programme and empirical comparisons are running before entry registration.','Its full native programme and empirical comparisons agree with V3 and the entry is registered complete.')",'''if fn=='ZENODO_PAPER_DRAFT.txt':
  start=s.index('\\n1127. Exact H2/D2 equilibrium bond-length relation')
  stop=s.find('\\n1128.',start);stop=len(s)if stop<0 else stop
  part=s[start:stop]
  part=part.replace("This entry's native law, three original operational witnesses, complete 256-form grammar, finite closure, controls and proof terms are staged; its native build, axiom audit, full programme comparison and empirical-validator translation/comparison remain pending and it is not counted complete.","This entry is verified complete: the native build, empty-axiom audit, full original programme, source-domain cases and complete empirical comparison pass.")
  part=part.replace('native verification remains pending','native verification is complete').replace('Native verification remains pending','Native verification is complete').replace('This translation is staged; native verification remains pending.','This translation is verified complete.').replace('are staged in','are verified in')
  s=s[:start]+part+s[stop:]''')
s=s.replace("s['bondlength1307'].update(status='complete',receipt=receipt)","s.setdefault('bondlength1307',{}).update(status='complete',receipt=receipt);s['equilibrium_length1186'].update(status='complete',receipt=receipt,next_action='Entry complete; preserve verified work and continue next original dependency-ready entry.')")
ast.parse(s);(w/'register_bondlength1307.py').write_text(s)
watch='''from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery';cid='SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001'
while True:
 files=['bondlength1307_full_audit_report.json','bondlength1307_empirical_report.json','bondlength1307_program_report.json','bondlength1307_independent_report.json','bondlength1307_core_report.json','bondlength1307_experiment_report.json']
 if all((w/f).exists()for f in files):
  c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
  if x['lean_status']=='complete':break
  if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
   subprocess.run(['python3','work/register_bondlength1307.py'],check=True);break
 time.sleep(15)
''';ast.parse(watch);(w/'register_bondlength1307_when_ready.py').write_text(watch)
print('Prepared original-source registration for',n,'audited declarations; requires all actual reports,unchanged hashes and original parent completions.')

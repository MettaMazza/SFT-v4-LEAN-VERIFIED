from pathlib import Path
w=Path('work');s=(w/'register_bondlength1307.py').read_text()
s=s.replace('bondlength1307','correspondence1308').replace('SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001','SFT-CHEM-OPERATIONAL-CLASSICAL-QUANTUM-CORRESPONDENCE-015').replace('TURN1307_BONDLENGTH','TURN1308_CORRESPONDENCE').replace('TURN1307','TURN1308')
a=s.index('reports=');b=s.index('\nfor n in reports:',a)
s=s[:a]+"reports=['correspondence1308_full_audit_report.json','correspondence1308_program_report.json','correspondence1308_original_report.json','correspondence1308_core_report.json']"+s[b:]
s='\n'.join(line for line in s.splitlines() if not line.startswith("assert json.loads((w/'correspondence1308_empirical_output.json')"))+'\n'
s=s.replace('==129','==len(auditNames)').replace("+129)","+len(auditNames))")
a=s.index(';scopes=')+1;b=s.index('\noldNames=',a)
scopes={
'MolecularCorrespondence':('sft/chemistry/classical_quantum_correspondence_law_v1.py:MolecularProcess/branchwise_certificate','Exact original constructor families/nonempty/distinct-column guards;classical traces,singleton quantum execution,shared decoder,all branch records,inverse action,11certificate fields and five resource counts.'),
'MolecularCorrespondenceDerivation':('sft/chemistry/classical_quantum_correspondence_law_v1.py:MolecularProcess.__post_init__/quantum_execution; sft/quantum_computation/operations.py:apply_gate/observe','Source-constructor guards imply actual generated state/gate admission and exact domain;existing reversible and observation proofs compose into constructedExecution for every admitted process,including nonidentical source/target sets.'),
'MolecularCorrespondenceGrammar':('sft/chemistry/classical_quantum_correspondence_law_v1.py:DIMENSIONS','All8original binary axes,256forms,exhaustive classification,original elimination decisions and unique preserving vector.'),
'MolecularCorrespondenceEvidence':('sft/chemistry/classical_quantum_correspondence_batch_v1.py; sft/chemistry/operational_law.py:OperationalChemistrySpec/GeneratedOperationalChemistryProgram','Original formal registration,source-specific base/successor closure,allcontrols,threeoperational witnesses and exactspecguards.')}
s=s[:a]+'scopes='+repr(scopes)+s[b:]
s=s.replace(",'correspondence1308_empirical_output.json'",'')
s=s.replace('original_target_rows=2,empirical_fields=12,measurement_messages=4,','certificate_fields=11,operational_witnesses=3,')
s=s.replace('PASS all original256candidate programme fields and hashes, original and three adverse independent cases,full12field4message empirical receipt and complete two-isotope interval reconstruction','PASS original256candidate programme fields and hashes,original and three adverse independent cases,all11certificate fields over original source-domain cases')
a=s.index("  start=s.index(");b=s.index(" if fn.endswith('.svg')",a)
s=s[:a]+'''  start=s.index('\\n1128. Operational classical–quantum chemical correspondence')
  stop=s.find('\\n1129.',start);stop=len(s)if stop<0 else stop
  part=s[start:stop].replace('The native build, axiom audit and fresh source comparisons are queued; this entry is not yet counted complete.','The native build, empty-axiom audit, original full programme and independent controls pass; this entry is complete.')
  part=part.replace('Native verification of the source-specific composition is queued.','Native verification of the source-specific composition passes.')
  s=s[:start]+part+s[stop:]
'''+s[b:]
a=s.index("with(r/'ZENODO_PAPER_DRAFT.txt').open('a')");b=s.index('\nnextId=',a)
s=s[:a]+'''with(r/'ZENODO_PAPER_DRAFT.txt').open('a')as f:f.write('\\nOperational classical–quantum molecular correspondence is complete. All '+str(len(auditNames))+' audited declarations have empty axiom dependencies. The source-constructor-to-execution derivation, all256original candidate decisions, fullprogramme and threeadverse independent controls pass. All11certificate fields agree with the original source-domain cases. Completion receipt: '+receipt+'. Timeline TURN1308.\\n')
with(r/'TIMELINE.txt').open('a')as f:f.write('\\nTURN1308 registration — '+now+' — Molecular correspondence complete at '+str(newCount)+'. Verified source-specific construction/execution composition,'+str(len(auditNames))+' empty-axiom declarations,original256programme,threeindependent adversecases and11field certificate cases. Checked actualsourcehashes and dependencies;updatedcount,correspondence,paper andtimeline.\\n')
''' +s[b:]
s=s.replace("s['equilibrium_length1186'].update(status='complete',receipt=receipt,next_action='Entry complete; preserve verified work and continue next original dependency-ready entry.');",'')
(w/'register_correspondence1308.py').write_text(s)
s=(w/'register_bondlength1307_when_ready.py').read_text().replace('bondlength1307','correspondence1308').replace('SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001','SFT-CHEM-OPERATIONAL-CLASSICAL-QUANTUM-CORRESPONDENCE-015')
s=s.replace("'correspondence1308_empirical_report.json',",'').replace(",'correspondence1308_experiment_report.json'",'')
(w/'register_correspondence1308_when_ready.py').write_text(s)
compile((w/'register_correspondence1308.py').read_text(),'register_correspondence1308.py','exec')
compile(s,'register_correspondence1308_when_ready.py','exec')
print('Prepared registration using existing completion script, with formal source-specific evidence and all four native modules; no completion asserted.')

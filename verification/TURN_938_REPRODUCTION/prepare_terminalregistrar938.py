from pathlib import Path
w=Path('work');s=(w/'register_confinement937.py').read_text().replace("f'{low}{n}_proofs_config.json'","f'{low}{n}_all_proofs_config.json'").replace("f'{low}{n}_audit.log'","f'{low}{n}_all_audit.log'")
a=s.index('scopes={');b=s.index("assert set(scopes)",a);s=s[:a]+'''scopes={
 'TerminalCKM':'Original terminal_ckm_slope_contribution and terminal_ckm_relation;two exact routes,all6 fields and source guards.',
 'TerminalQuarkRoots':'Original refined_quark_roots at1e-15;all six source intervals,exact initial isolation,repeated bisection and source-run termination proofs.',
 'TerminalCKMComparison':'Original terminal_ckm_prediction_intervals;all four exact squared intervals,all guards,full Jarlskog endpoint propagation.',
 'TerminalMatterRecords':'Original authoritative_record,source_rows;complete retained source record,seven custody conditions,two component hashes and rejection branches.',
 'TerminalCKMMeasurement':'Original three_sigma_squared,terminal_ckm_classification;all four rows,full asymmetric uncertainties,exact overlap and original classification.',
 'TerminalCKMEntryWitnesses':'Original two-route operational witness.',
 'TerminalCKMEntryGrammar':'Original complete256 law alternatives and exact elimination decisions.',
 'TerminalCKMEntryControls':'Original law controls,closure and witness bindings.',
 'TerminalCKMEntryEvidence':'Original complete StructuralPhysicsProgram with empirical mode and observational_derivation provenance.',
 'TerminalCKMEmpiricalWitnesses':'Original target-free positive terminal contribution witness.',
 'TerminalCKMEmpiricalGrammar':'Original complete256 post-seal comparison alternatives.',
 'TerminalCKMEmpiricalEvidence':'Original GeneratedEmpiricalPhysicsProgram for this precise comparison spec.',
 'TerminalCKMEmpiricalExperiment':'Original four-row experiment,snapshot identity,prediction program,target vault and complete source metadata.',
 'TerminalCKMEmpiricalValidation':'Original blind external measurement protocol plus exact terminal source classification precheck;complete output equality.'}
'''+s[b:]
s=s.replace("source='sft/physics/matter_flavour_completion_laws_v1.py'","source='sft/physics/matter_flavour_terminal_ckm_laws_v1.py'")
s=s.replace("additional_source_paths=[common]","additional_source_paths=[common,'sft/physics/matter_flavour_terminal_ckm_validation_v1.py','sft/physics/matter_flavour_terminal_ckm_execution_v1.py']")
s=s.replace("files += ['confinement937_core_build.log']","files += ['terminalckm938_core_build.log','terminalckm938_comparison_build.log','terminalckm938_measurement_build.log','terminalckm938_empirical_build.log','terminalckm938_core_audit.log','terminalckmempirical938_empirical_report.json','terminalckmempirical938_empirical_output.json','terminalckmempirical938_original_empirical.json','terminalckm938_refinement_steps.json']")
s=s.replace("for file in [", "assert json.load(open(w/'terminalckmempirical938_empirical_report.json'))['status']=='PASS'\nassert (w/'timeline938_addition.txt').is_file()\nfor file in [",1)
s=s.replace("source_component_correspondence={m:","empirical_report='verification/TURN_938_terminalckmempirical938_empirical_report.json',evidence_mode='empirical',provenance=['observational_derivation'],source_component_correspondence={m:")
s=s.replace('original formal evidence boundary retained.','original empirical evidence mode and observational-derivation provenance retained;complete source empirical validator output matches.')
(w/'register_terminalckm938.py').write_text(s)

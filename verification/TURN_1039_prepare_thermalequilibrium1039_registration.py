from pathlib import Path
import json
w=Path('work');cfg=json.loads((w/'thermalequilibrium1039_proofs_config.json').read_text());s=(w/'register_inflation1035.py').read_text();a=s.index('scopes=');b=s.index('\nfor name in',a)
components={
'ThermalEquilibriumResponse':'All original exact operations and guards: temperature,total identity,full paired census,dyadic counts and weights,exact sequential multinomial divisions,complete fixed-count/throw walk,maximum certificate,fluctuation ledger andnoise cycle.',
'ThermalEquilibriumResponseCertificate':'All six original certificate fields and exact original finite ranges,with full enumeration.',
'ThermalEquilibriumNoise':'Original complete four-record cycle length,sum,and actual mean for every positive repetition.',
'ThermalEquilibriumWeights':'Actual dyadic recurrence,positive population,exact2^L-1denominator,normalization andstrict adjacentdecline for allL>=2.',
'ThermalEquilibriumTemperature':'Original exact mean operation,positive temperature andtotal=N*Tfor every finite nonempty exactpositive population.',
'ThermalEquilibriumPaired':'Complete four-field original paired census for everypositivepaircount;factorialquotient correspondence;unique centralmaximum;allrows,survivor andhalf-One share.',
'ThermalEquilibriumMultinomial':'Actual factorialdivisionidentity;dyadic power identity derivedfrom originalfixedpopulation andthrow;strictmultinomialmaximum for every distinct admittedcountvector andL>=2.',
'ThermalEquilibriumEnumeration':'Originalwalk soundness,completeness,no duplicates,targetmembership,fullmaximumfold,survivorlist,and completefour-fieldcanonicalcertificateforallL>=2.',
'ThermalEquilibriumCertificateProof':'Nativekernel theoremfor thecomplete six-fieldoriginalcertificate.',
'ThermalEquilibriumResponseWitnesses':'Allfouroriginal operationalwitnesses boundto theprovedsourcecertificate.',
'ThermalEquilibriumResponseEntryEvidence':'Exact originalStructuralPhysicsProgramregistration,256census,decisions,closure,fourcontrols,canonicalhashes andunknownidentifierbehavior.'}
scopes={m:('sft/physics/structural_constants.py' if m.endswith('EntryEvidence')else'sft/physics/thermal_equilibrium_response_terminal_law_v1.py',components.get(m,'Original full fixed-count/fixed-throw maximum at level'+m[-1] if m.startswith('ThermalEquilibriumMaximum')else'Originaleightbinaryaxes,complete256orderedcandidates,exactfirstfailuredecisions,uniqueacceptedcandidate andcoordinateexclusions.'))for m in cfg['modules']}
s=s[:a]+'scopes='+repr(scopes)+s[b:];s=s.replace('inflation1035','thermalequilibrium1039').replace('TURN_1035','TURN_1039').replace('TURN1035','TURN1039').replace('checkpoint1035','checkpoint1039').replace('INFLATION_039','THERMAL_EQUILIBRIUM_043').replace('SFT-PHYS-INFLATION-GROWTH-TERMINAL-039','SFT-PHYS-THERMAL-EQUILIBRIUM-RESPONSE-TERMINAL-043').replace('InflationGrowth','ThermalEquilibriumResponse').replace('inflation, primordial-support and structure-growth','exact temperature, complete canonical equilibrium and fluctuation-response')
for suffix in ['program_report','program_output','fresh_report','independent_report']:s=s.replace('thermalequilibrium1039_'+suffix,'thermalequilibrium1036_'+suffix)
s=s.replace("state['inflation1034_staged']","state['equilibrium1035_staged']")
(w/'register_thermalequilibrium1039.py').write_text(s)

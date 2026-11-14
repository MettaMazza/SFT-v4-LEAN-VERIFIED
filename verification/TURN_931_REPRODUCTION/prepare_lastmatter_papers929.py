from pathlib import Path
import json
w=Path('work');q=json.loads((w/'majoranacomparison929_science_report.json').read_text())['actual'];m=json.loads((w/'magneticcomparison930_science_report.json').read_text())['actual'];fraction=lambda x:str(x[0])+'/'+str(x[1])
record=json.loads((w/'mattervalidation926_original_record.json').read_text());nist=next(x for x in record['sources'] if x['source_id']=='NIST-CODATA-2022-ALL-CONSTANTS')['rows'];fnal=next(x for x in record['sources'] if x['source_id']=='FERMILAB-MUON-G2-FINAL-2025')['rows']
majorana='''
801. Majorana and neutrinoless-double-beta status comparison

The Majorana discriminator and formal noncancellation result are already sealed by their dependency proofs. The source now compares their predicted effective-mass interval with the retained experimental status and sensitivity. This preserves the distinction between a closed formal prediction and its observation status.

Use the sole solar anchor a=749/10,000,000 eV² and generated mass-square coefficients (1/32,33/32,3203/96). The exact mass intervals [lᵢ,uᵢ] are those derived in section800 by the original square-bisection procedure. The generated electron weights are

(w₁,w₂,w₃)=(47/72,47/144,1/48),
w₁+w₂+w₃=(94+47+3)/144=1.

The source retains every weighted lower and upper contribution,

Lᵢ=wᵢlᵢ, Uᵢ=wᵢuᵢ.

Its dominant-middle noncancellation floor and full upper sum are

F=L₂−U₁−U₃,
C=U₁+U₂+U₃.

With the exact rational endpoints of section800, native computation gives

F=FLOOR eV > 0,
C=CEILING eV < 0.028 eV.

The positive floor follows from the middle contribution exceeding both opposing upper contributions together, so cancellation cannot remove the complete predicted effective mass. MajoranaComparisonMeasurement.predictionBounds recomputes these values from the original mass-square and PMNS operations; it does not insert the displayed answers into the computation. Its originalClassification theorem proves the complete source comparison from the retained record.

The retained xenon half-life lower limit is 3.8×10²⁶ years at 90% confidence. The source keeps the complete nuclear-matrix-dependent effective-mass upper range, 0.028–0.122 eV, and compares C against its lower endpoint. The original observation status is “not observed.” Thus the sealed positive interval lies below the retained sensitivity; this comparison records neither an existing observation nor an exclusion of that interval.

The source first checks the exact observation-status text, then assembles all three weighted bounds and checks F>0 and C<0.028. Its base retains non-observation and the xenon limit; its successor requires future comparisons to retain the half-life, matrix-element range and observation status without changing the sealed formal receipt. The complete eight-axis,256-form grammar,original operational witness,controls,experiment and blind external validator preserve these same boundaries and the full source custody checks.

Original V3: sft/physics/matter_flavour_validation_v1.py, majorana_classification and MAJORANA_SPEC; original neutrino_mass_squares,pmns_cp_structure and sqrt_refined. Pin: 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Lean: MajoranaComparisonMeasurement and MajoranaStatusValidation Witnesses/Grammar/Evidence/Experiment/Validation; reused NeutrinoMeasurementRoots,PMNSPhysical and MatterAuthoritativeRecords. Timeline: TURN929. Receipt: verification/TURN_929_MAJORANA_STATUS_VALIDATION_COMPLETION.json.

[Original source](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/matter_flavour_validation_v1.py); [Native bound and status comparison](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/MajoranaComparisonMeasurement.lean); [Original full grammar](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/MajoranaStatusValidationGrammar.lean); [Timeline](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/TIMELINE.txt).
'''.replace('FLOOR',fraction(q['floor'])).replace('CEILING',fraction(q['ceiling']))
magnetic='''
802. Raw electron and muon magnetic-anomaly comparison

The source keeps the exact bare-g and terminal-alpha leading structure sealed before opening the measured record. The terminal value is

α=3,676,744,786/503,846,395,469.

Its conventional full-turn conversion remains on the comparison side. Using the original rational circumference enclosures 333/106 and 355/113, the complete leading interval is

A₋=α/[2·(355/113)]=LOWER,
A₊=α/[2·(333/106)]=UPPER.

Every operation is rational: no irrational value is inserted into the formal derivation, and no imported radiative series enters this comparison. The generated squared mass-sensitivity relation remains the already sealed dependency of the magnetic-anomaly entry.

The raw retained electron and muon anomaly centres are

aₑ=ELECTRON,
aμ=MUON.

The exact source check establishes the complete strict ordering

aₑ < A₋ < A₊ < aμ.

MagneticComparisonMeasurement.leadingInterval computes both endpoints from the source's exact terminal alpha and rational turn bounds; originalClassification proves the complete raw-data classification. The source also checks the declared Fermilab boundary that only raw measured anomaly and uncertainty enter SFT validation. The full source record retains the measured uncertainties and original scheme/status text. No consensus-model anomaly or interpretation is substituted as an empirical target, and the leading interval is not labelled the completed measured anomaly.

The source base seals the bare and terminal-alpha carriers first. Its successor appends the two raw measurement rows without selecting a later radiative successor. The full eight-axis comparison grammar contains all256 alternatives and retains every original decision,witness,control and validation record. The source's falsification statement concerns a complete separately sealed SFT radiative successor,or mislabelling this leading-only result as the full anomaly. The native entry preserves that statement and the complete post-seal source custody and blind empirical protocol.

Original V3: sft/physics/matter_flavour_validation_v1.py, magnetic_classification and MAGNETIC_SPEC; original magnetic_anomaly_structure dependency. Pin: 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Lean: MagneticComparisonMeasurement and MagneticRawValidation Witnesses/Grammar/Evidence/Experiment/Validation; reused MatterAuthoritativeRecords and exact rational arithmetic. Timeline: TURN930. Receipt: verification/TURN_930_MAGNETIC_RAW_VALIDATION_COMPLETION.json.

[Original source](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/matter_flavour_validation_v1.py); [Native raw-data comparison](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/MagneticComparisonMeasurement.lean); [Full grammar](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/MagneticRawValidationGrammar.lean); [Timeline](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/TIMELINE.txt).
'''.replace('LOWER',fraction(m['lower'])).replace('UPPER',fraction(m['upper'])).replace('ELECTRON',nist['electron_magnetic_anomaly']['value']).replace('MUON',fnal['experimental_world_average']['value'])
for n,low,core,paper,scope in [(929,'majoranastatusvalidation','MajoranaComparisonMeasurement',majorana,'Original majorana_classification:retained observation status,solar anchor,three refined mass intervals,electron weights,positive noncancellation floor,total upper bound and original matrix-element limit.'),(930,'magneticrawvalidation','MagneticComparisonMeasurement',magnetic,'Original magnetic_classification:exact terminal alpha,rational full-turn interval,both raw measured centres,strict ordering and source validation-boundary prefix;no imported radiative model.')]:
 paper=paper.replace('axis,256','axis, 256').replace('all256','all 256').replace('decisions,witness','decisions, witness').replace('witness,control','witness, control').replace('control and','control and').replace('successor,or','successor, or')
 (w/f'paper_{low}{n}_addition.txt').write_text(paper)
 s=(w/'register_neutrinovalidation928.py').read_text().replace('_build928','_build'+str(n));science='majoranacomparison929' if n==929 else 'magneticcomparison930';s=s.replace('neutrinomeasurement928_science_report',science+'_science_report')
 a=s.index(" 'NeutrinoMeasurementRoots':");b=s.index(" tag+'Grammar':",a);s=s[:a]+f" '{core}':{scope!r},\n"+s[b:]
 s=s.replace("'neutrinomeasurement928_core_audit.log','neutrinomeasurement928_core_build.log','neutrinomeasurement928_measurement_audit.log','neutrinomeasurement928_measurement_build.log'",repr(science+'_core_audit.log')+','+repr(science+'_core_build.log'))
 s=s.replace('check_neutrinovalidation_original928.py','check_'+('majorana' if n==929 else 'magnetic')+'validation_original'+str(n)+'.py').replace('all exact neutrino interval computations and original complete classification','all exact entry-specific interval computations and original complete classification')
 (w/('register_'+('majorana' if n==929 else 'magnetic')+'validation'+str(n)+'.py')).write_text(s)

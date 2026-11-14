from pathlib import Path
import json
w=Path('work');d=json.loads((w/'protoncomparison927_original.json').read_text());lo,hi=d['ratio']
p='''
799. Proton/electron precision comparison

The original comparison uses the already sealed lepton polynomial

x³−x²+x/6−1/485=0.

The existing complete dyadic isolation supplies the ordered electron, muon and tau root brackets. At each refinement the original cubic-hand bisection acts on all three brackets. Its stopping test examines exactly the first two:

max(uₑ−lₑ,uμ−lμ) ≤ 10⁻¹⁵.

No measured proton/electron value enters this isolation or stopping rule. The exact source computation reaches this condition after 43 refinements. ProtonComparison.originalIsolation and originalRefinement certify the calculations, and exactSourceRun retains the original continuation condition at every preceding refinement.

Squaring the positive electron and muon intervals gives E=[lₑ²,uₑ²] and M=[lμ²,uμ²]. The source identity R=(1/3)(1/E−1/M) therefore yields

R₋=(1/3)(1/uₑ²−1/lμ²),
R₊=(1/3)(1/lₑ²−1/uμ²).

The exact native interval is

R₋=LOW,
R₊=HIGH.

The full retained CODATA row supplies its centre c and standard uncertainty σ. Its target interval is [c−σ,c+σ], using the original recorded decimal strings as exact rational comparisons. The original test is

R₋≤c+σ and c−σ≤R₊.

That conjunction is false: the sealed reconstruction is near the proton/electron scale but outside the complete retained uncertainty interval. The native originalClassification theorem proves the source's explicit unfavorable classification. This comparison does not widen the uncertainty, change the sealed polynomial, select a fitted successor or turn a small relative error into a precision pass.

The original base retains both the full measured centre and its standard uncertainty. Its successor narrows the same algebraic prediction while preserving its survivor. All eight original binary comparison axes and all 256 alternatives remain represented, together with the original operational witness, decision reasons, controls, experiment registration and complete blind external-validation protocol. The shared six-source custody checks remain those of the pinned source record.

Original V3: sft/physics/matter_flavour_validation_v1.py, proton_ratio_interval, proton_classification and PROTON_SPEC; the original lepton polynomial, cubic isolation and bisection in its declared dependencies. Pin: 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Lean: ProtonComparison, ProtonComparisonMeasurement and ProtonPrecisionValidation Witnesses/Grammar/Evidence/Experiment/Validation; shared MatterAuthoritativeRecords. Timeline: TURN927. Receipt: verification/TURN_927_PROTON_PRECISION_VALIDATION_COMPLETION.json.

[Original comparison](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/matter_flavour_validation_v1.py); [Native interval derivation](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/ProtonComparison.lean); [Native precision comparison](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/ProtonComparisonMeasurement.lean); [Full grammar](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/ProtonPrecisionValidationGrammar.lean); [Timeline](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/TIMELINE.txt).
'''.replace('LOW',f'{lo[0]}/{lo[1]}').replace('HIGH',f'{hi[0]}/{hi[1]}')
record=json.loads((w/'mattervalidation926_original_record.json').read_text());row=next(x for x in record['sources'] if x['source_id']=='NIST-CODATA-2022-ALL-CONSTANTS')['rows']['proton_electron_mass_ratio'];p=p.replace('Its target interval is','Here c='+row['value']+' and σ='+row['standard_uncertainty']+'. Its target interval is');(w/'paper_protonprecisionvalidation927_addition.txt').write_text(p)
s=(w/'register_quarkvalidation926.py').read_text().replace('_build926','_build927').replace("assert json.load(open(w/'quarkcomparison926_science_report.json'))['status']=='PASS'","assert json.load(open(w/'protoncomparison927_science_report.json'))['status']=='PASS'")
a=s.index(" 'QuarkComparison':");b=s.index(" tag+'Grammar':",a)
s=s[:a]+""" 'MatterAuthoritativeRecords':'Original authoritative_record hash,post-seal custody,six-source count,five component hashes and exact source-row lookup;reused unchanged from TURN926.',
 'ProtonComparison':'Original proton_ratio_interval:exact1/6,1/485 cubic,original isolation,first-two-bracket1e-15 stopping test,all-three bisection,source-run proof and complete rational interval.',
 'ProtonComparisonMeasurement':'Original CODATA centre/standard-uncertainty comparison,exact non-overlap and unfavorable classification;full input/source binding retained.',
"""+s[b:]
s=s.replace("'quarkcomparison926_science_report.json','quarkcomparison926_core_audit.log','quarkvalidation926_core_build.log'","'protoncomparison927_science_report.json','protoncomparison927_core_audit.log','protoncomparison927_core_build.log','protoncomparison927_measurement_audit.log','protoncomparison927_measurement_build.log'")
s=s.replace('check_quarkvalidation_original926.py','check_protonvalidation_original927.py').replace('all exact quark/CKM computations and original status outcomes','the exact proton interval computation and original unfavorable precision outcome')
(w/'register_protonvalidation927.py').write_text(s)

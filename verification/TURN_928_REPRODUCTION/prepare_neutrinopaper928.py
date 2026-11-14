from pathlib import Path
import json
from fractions import Fraction
w=Path('work');d=json.loads((w/'neutrinomeasurement928_original.json').read_text());br={k:[Fraction(*x) for x in v] for k,v in d.items()};slo=sum(x[0] for x in br.values());shi=sum(x[1] for x in br.values());fmt=lambda x:f'{x.numerator}/{x.denominator}'
p='''
800. Neutrino mass, ordering, mixing and CP comparison

The original comparison retains the formally generated PMNS values and CP carrier, then tests them against the complete registered source intervals. The three mixing predictions are

sin²θ₁₂=1/3,
sin²θ₂₃=1/2,
sin²θ₁₃=1/48.

Their exact three-sigma tests are respectively

0.275≤1/3≤0.345,
0.435≤1/2≤0.585,
0.02030≤1/48≤0.02388.

The half-One phase is translated on the comparison side by 360·(1/2)=180 degrees, and 124≤180≤364. These measured intervals do not select any formal angle or phase; all are already sealed by the original dependency proofs.

The measured splitting rows retain solar centre 0.0000749 eV² and atmospheric centre 0.002438 eV², together with their original uncertainty fields. The source's exact ratio check is

29/1000 < 0.0000749/0.002438 = 749/24380 < 32/1000.

The sole declared dimensional anchor is a=749/10,000,000 eV². The already generated mass-square coefficients are (1/32,33/32,3203/96), hence

m₁²=a/32,
m₂²=33a/32,
m₃²=3203a/96.

For each square q, the original comparison first finds the least whole u≥1 with u²≥q. If u>1, its initial bracket is [u−1,u]; for u=1 it uses [1/2,1] when q≥1/4 and [1/1024,1] otherwise. All three present squares use the last branch. This is the source's comparison-side initialization. At each step m=(l+u)/2; when m²<q the new bracket is [m,u], otherwise it is [l,m]. The exact stopping rule is u−l≤10⁻¹². An exact midpoint follows the original lower-half branch.

The resulting intervals are

m₁ ∈ LIGHT,
m₂ ∈ MIDDLE,
m₃ ∈ HEAVY,

in eV. NeutrinoMeasurementRoots supplies an original-loop execution proof for each interval and kernel-checked exact endpoint equalities. The complete sum enclosure is

m₁+m₂+m₃ ∈ [SUMLOW,SUMHIGH] eV.

Its upper endpoint is below 0.12 eV, and the heavy-state upper endpoint is below 0.45 eV. The former is the retained Planck base-ΛCDM-plus-BAO bound with its model dependence; the latter is the registered direct upper bound. The sum is approximately 0.060 eV. The retained ordering row reports a preference slightly above two sigma and does not classify the measured ordering as decisive.

NeutrinoComparisonMeasurement executes every original mixing, phase, splitting, mass-sum and direct-bound check in source order. Its originalClassification theorem returns the original complete status from the retained record. Source access still follows the post-seal custody flag, immutable record identity, six-source count and named component hashes. The complete eight-axis grammar enumerates all 256 alternatives, keeping the sole dimensional anchor, full uncertainty and scope rows, original controls and blind-validation receipt.

Original V3: sft/physics/matter_flavour_validation_v1.py, sqrt_refined, neutrino_classification and NEUTRINO_SPEC; original neutrino_mass_squares, pmns_cp_structure and bisect_square dependencies. Pin: 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Lean: NeutrinoMeasurementRoots, NeutrinoComparisonMeasurement and NeutrinoMassMixingValidation Witnesses/Grammar/Evidence/Experiment/Validation, with MatterAuthoritativeRecords. Timeline: TURN928. Receipt: verification/TURN_928_NEUTRINO_MASS_MIXING_VALIDATION_COMPLETION.json.

[Original comparison](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/matter_flavour_validation_v1.py); [Native mass enclosures](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/NeutrinoMeasurementRoots.lean); [Native full comparison](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/NeutrinoComparisonMeasurement.lean); [Full grammar](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/NeutrinoMassMixingValidationGrammar.lean); [Timeline](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/TIMELINE.txt).
'''
for key,name in [('LIGHT','lightest'),('MIDDLE','middle'),('HEAVY','heavy')]:p=p.replace(key,'['+','.join(fmt(x) for x in br[name])+']')
p=p.replace('SUMLOW',fmt(slo)).replace('SUMHIGH',fmt(shi));(w/'paper_neutrinomassmixingvalidation928_addition.txt').write_text(p)
s=(w/'register_protonvalidation927.py').read_text().replace('_build927','_build928').replace('protoncomparison927_science_report','neutrinomeasurement928_science_report')
s=s.replace(" 'ProtonComparison':'Original proton_ratio_interval:exact1/6,1/485 cubic,original isolation,first-two-bracket1e-15 stopping test,all-three bisection,source-run proof and complete rational interval.',"," 'NeutrinoMeasurementRoots':'Original comparison-side sqrt_refined initialization,bisection,precision stopping and exact three anchored mass interval source-run proofs.',")
s=s.replace(" 'ProtonComparisonMeasurement':'Original CODATA centre/standard-uncertainty comparison,exact non-overlap and unfavorable classification;full input/source binding retained.',"," 'NeutrinoComparisonMeasurement':'Original neutrino_classification:all PMNS/CP comparisons,splitting ratio,one solar anchor,mass-square calls,exact root/sum bounds,direct and Planck checks and original ordering status.',")
s=s.replace('protoncomparison927_core_audit','neutrinomeasurement928_core_audit').replace('protoncomparison927_core_build','neutrinomeasurement928_core_build').replace('protoncomparison927_measurement_audit','neutrinomeasurement928_measurement_audit').replace('protoncomparison927_measurement_build','neutrinomeasurement928_measurement_build').replace('check_protonvalidation_original927.py','check_neutrinovalidation_original928.py').replace('the exact proton interval computation and original unfavorable precision outcome','all exact neutrino interval computations and original complete classification')
(w/'register_neutrinovalidation928.py').write_text(s)

from pathlib import Path
w=Path('work')
p='''
798. Complete quark-ratio and CKM comparison

The source compares the sealed quark cubics and dressing factors with the complete retained PDG record. Refinement changes the rational enclosures; it does not change a polynomial, dressing factor or admitted survivor. With elementary-symmetric sum One, the down and up cubic relations are

x³−x²+(1/8)x−1/383=0,
x³−x²+(1/12)x−1/3071=0.

The existing exhaustive dyadic isolation supplies three ordered brackets for each cubic. For a bracket [l,u], let m=(l+u)/2. The original bisection tests the cubic's positive and counter contributions at m and l: an exact middle root returns [m,m]; an exact lower root returns [l,m]; opposite hands at l and m retain [l,m]; the remaining case retains [m,u]. Every refinement applies that same operation to all three intervals. The source continues precisely while

∃i, uᵢ−lᵢ > 10⁻¹².

The down and up calculations terminate after 34 and 32 refinements respectively. QuarkComparison.sourceDown and sourceUp prove successful executions of this original stopping rule, with every preceding continuation condition retained. The resulting intervals, expressed over the common denominator Q=2⁴⁰=1,099,511,627,776, are

d₀ ∈ [28,872,365,447, 28,872,365,448]/Q,
d₁ ∈ [127,443,095,797, 127,443,095,798]/Q,
d₂ ∈ [943,196,166,530, 943,196,166,531]/Q,
u₀ ∈ [4,518,254,149, 4,518,254,150]/Q,
u₁ ∈ [95,881,516,425, 95,881,516,426]/Q,
u₂ ∈ [999,111,857,200, 999,111,857,201]/Q.

Each displayed width is 2⁻⁴⁰ < 10⁻¹². The source's exact dyadic endpoints, including their reduced fractional representations, are checked directly against native Lean execution.

For positive root intervals N=[N₋,N₊] and D=[D₋,D₊], the source constructs

R(N,D)=[(N₋/D₊)²,(N₊/D₋)²].

Let A=503,846,395,469/3,676,744,786 be the generated terminal inverse fine-structure constant. The already established dressing factors are L=(A+2)/A and U=A/(A+7). Thus

s/d = L·R(d₁,d₀),
b/s = L⁻¹·R(d₂,d₁),
t/c = U·R(u₂,u₁).

The comparison intervals retain the full recorded uncertainties. In the same declared scheme, the s/d target is

[(92.74−0.54)/(4.69+0.05), (92.74+0.54)/(4.69−0.05)],

and the b/s target is

[(11.769−0.035)(4.584−0.012), (11.769+0.035)(4.584+0.012)].

For intervals I and T, overlap means I₋≤T₊ and T₋≤I₊. Both dressed predictions overlap these complete targets. The retained top/charm row states that no direct scheme-matched measurement is registered; its independently sealed value remains a prediction.

The CKM calculation first derives X=R(d₀,d₁). The two slope enclosures and their positive separation are

D=[d₁₋/d₂₊,d₁₊/d₂₋],
U=[u₁₋/u₂₊,u₁₊/u₂₋],
S=[D₋−U₊,D₊−U₋], with S₋>0.

Then the squared mixing intervals are

sin²θ₁₂=X,
Y=sin²θ₂₃=[S₋²,S₊²],
Z=sin²θ₁₃=[X₋Y₋/6,X₊Y₊/6].

The exact Jarlskog-square enclosure retains the source's endpoint construction. Define

F=[X₋(1−X₋),X₊(1−X₊)],
G=[Y₋(1−Y₋),Y₊(1−Y₊)],
H=[Z₋(1−Z₊)²,Z₊(1−Z₋)²].

Then J² ∈ [F₋G₋H₋,F₊G₊H₊]. Every ratio, subtraction and product here is rational and is computed from the previously sealed cubic roots and dressing results.

For each recorded centre c and lower/upper uncertainties σ₋,σ₊, the source compares these squared quantities against

[(c−3σ₋)²,(c+3σ₊)²].

The retained (c,σ₋,σ₊) rows are (0.22501,0.00068,0.00068), (0.04183,0.00069,0.00079), (0.003732,0.000085,0.000090) and (0.0000312,0.0000012,0.0000013) for θ₁₂, θ₂₃, θ₁₃ and J. The resulting overlap vector is (true,false,true,true). The original θ₂₃ three-sigma tension remains explicit alongside the supported comparisons; no uncertainty is enlarged and no result is dropped.

The full six-source record retains the post-seal custody flag and original byte identity. All five named component documents are checked against their pinned hashes. Source-row lookup and classification recompute the comparisons above before the original blind validation protocol checks the sealed package, source release, target rows, unfavorable control and custody certificates. The original grammar is the complete Cartesian product of eight binary post-seal comparison axes: 2⁸=256 alternatives, retaining all original decisions and controls. Its base keeps the complete light-quark interval; its successor adds heavy ratios, all CKM rows and scheme/tension controls without selecting or rescaling the formal law.

Original V3: sft/physics/matter_flavour_validation_v1.py, refined_quark_roots, square_ratio_interval, scaled, inverted, overlaps, quark_prediction_intervals, ckm_prediction_intervals, quark_ckm_classification and QUARK_CKM_SPEC; sft/physics/matter_flavour_laws_v1.py, cubic isolation and bisection. Pin: 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Lean: QuarkComparison, MatterAuthoritativeRecords, QuarkComparisonMeasurement, MatterAuthoritativeWitnesses and QuarkCKMValidation Witnesses/Grammar/Evidence/Experiment/Validation. Timeline: TURN926. Receipt: verification/TURN_926_QUARK_CKM_VALIDATION_COMPLETION.json.

[Original comparison source](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/matter_flavour_validation_v1.py); [Native interval derivation](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/QuarkComparison.lean); [Native complete comparison](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/QuarkComparisonMeasurement.lean); [Full grammar](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/QuarkCKMValidationGrammar.lean); [Timeline](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/TIMELINE.txt).
'''
(w/'paper_quarkckmvalidation926_addition.txt').write_text(p)

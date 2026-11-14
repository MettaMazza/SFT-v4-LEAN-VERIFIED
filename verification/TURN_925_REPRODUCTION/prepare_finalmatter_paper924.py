from pathlib import Path
import datetime
w=Path('work');items=[('zeronu',924,'NeutrinolessBounds','ZERO_NU',796,'Exact noncancellation certificate for neutrinoless double beta','sqrt_bracket, bisect_square, zero_nu_noncancellation and ZERO_NU_SPEC','''The preceding entries supply the positive mass-square coefficients

q=(1/32,33/32,3203/96)

and electron weights

w=(47/72,47/144,1/48).

The original square-root operation first searches positive whole upper endpoints in increasing order. For q=n/d>0 with d≥1, q≤n<(n+1)², so this search has a derived finite upper bound. wholeUpperFromOne proves that its executable search follows the original first-acceptable-upper relation. This bound is derived from the input numerator; it does not select a scientific bracket or tolerance.

When the whole upper endpoint is One, the source exhausts the ordered dyadic intervals at depths 1 through 64. At support S=2ᵏ it checks every adjacent pair (i/S,(i+1)/S), i=1,…,S−1, and returns the first pair whose squared endpoints enclose q. scanDyadic and dyadicSearch retain this complete order, both inclusive endpoint tests and the original failure boundary.

For the generated three mass squares, the first brackets are

B₀=(1/8,1/4), B₁=(1,2), B₂=(5,6).

Their exact square inequalities are

1/64≤1/32≤1/16,
1≤33/32≤4,
2400/96≤3203/96≤3456/96.

allOriginalSquareBounds proves all three. Weighting each lower and upper endpoint gives

L=(47/576,47/144,5/48),
U=(47/288,47/72,1/8).

The original stopping condition compares the middle lower contribution with the sum of the other upper contributions:

L₁=94/288,
U₀+U₂=47/288+36/288=83/288,
L₁>U₀+U₂.

The initial brackets already satisfy this strict condition. exactInitialState, originalStoppingCondition and exactSourceLoop prove that the original loop returns at its first test, before any refinement. The original bisection operation and refinement branch remain represented: the midpoint is (l+u)/2; a midpoint square below q retains (midpoint,u), otherwise (l,midpoint). No chosen refinement count or tolerance enters the stopping condition.

The returned lower and upper coefficients are

F=L₁−U₀−U₂=(94−47−36)/288=11/288>0,
C=U₀+U₁+U₂=(47+188+36)/288=271/288.

For any held opposing contribution n/d bounded by the two outer terms, d>0 and 288n≤83d imply 288n<94d. everyBoundedOppositionFails proves this cross-multiplied statement for every such numerator and denominator. Together with the certified endpoint bounds, the middle contribution cannot be canceled by the other two, even at their maximum opposing magnitude. The triangle certificate retains the strictly positive floor F and finite ceiling C; the overall dimensional scale remains the square root of the declared post-seal solar anchor.

NeutrinolessBounds.zeroNuNoncancellation computes the original three-field result from the generated masses, weights and first brackets. Its otherwise-unbounded source loop has an explicit SourceLoopRun relation for stopping and refinement; the native entry follows the proved initial stopping branch. completeSourceResult, exactPositiveFloor, exactCeiling and strictlyPositiveFloor establish the full returned result. The original witness checks its positive floor. Fresh source comparisons retain every bracket and coefficient, fourteen root/domain cases and five bisection cases.'''),('magneticanomaly',925,'MagneticAnomaly','MAGNETIC_ANOMALY',797,'Terminal lepton magnetic-anomaly structure','magnetic_anomaly_structure and MAGNETIC_ANOMALY_SPEC','''The original operation reuses the terminal inverse electromagnetic coupling

A=α⁻¹=503846395469/3676744786.

Reciprocation gives the source terminal coupling, and the generated binary count gives the bare gyromagnetic carrier:

α=3676744786/503846395469,
b=g_bare=2.

The single terminal return supplies the exact phase-normalized leading anomaly

a_phase=α/b
       =3676744786/(2·503846395469)
       =1838372393/503846395469>0.

Thus 2a_phase=α. MagneticAnomaly.magneticAnomalyStructure obtains the coupling from the existing inverseFineStructure operation, divides by the generated binary count and retains the original bare count. completeSourceRecord proves the entire output; binaryLeadingReassemblesAlpha proves the return identity and strictlyPositiveLeading proves positivity.

The operation also retrieves the original leading charged-lepton polynomial record (1,1/6,1/485) from protonElectronIdentity. Its mass-sensitivity graph is the square of the sealed muon-to-electron mass ratio:

S_μ/e=(m_μ/m_e)².

With the source's masses represented as squared roots of the same lepton polynomial, this is equivalently (r_μ/r_e)⁴. The graph supplies no independently fitted mass-scale channel.

All five original fields are retained: bare g, terminal α, phase-normalized leading anomaly, squared mass-sensitivity relation and the post-seal-only physical-turn translation label. The source distinguishes its phase-normalized result from the later full-turn correspondence operation. It imports no Schwinger coefficient, QED perturbation series or irrational π into this formal derivation. The original two witnesses check the exact leading return and bare binary count.

The source base supplies the binary pair and one terminal electromagnetic return. Its successor appends each typed mass-scale channel through the square of its carrier ratio while preserving the common leading return. The existing coupling and lepton-polynomial proofs are reused unchanged.''')]
for low,n,core,key,sec,title,source,body in items:
 tag='ZeroNuEntry' if low=='zeronu' else 'MagneticAnomalyEntry'
 s=(w/'register_pmnsphysical922.py').read_text().replace("'PMNSPhysical':'Original pmns_cp_structure complete five-field assembly from binary,generator and positive power;all three electron weights,exact sum guard,phase and source-record/weight/phase proofs.'",repr(core)+':'+repr('Original '+source+';complete exact source operations,returned fields,guards and entry-specific derivation proofs.')).replace('Original exact full electron-weight triple and CP phase witness.','Original entry-specific source-operation witnesses.').replace("['pmnsphysical922_core_build.log']",f"['{low}{n}_core_build.log']");(w/f'register_{low}{n}.py').write_text(s)
 (w/f'paper_{low}{n}_addition.txt').write_text(f'\n{sec}. {title}\n\n'+body+f'\n\nThe complete original eight binary axes enumerate all256 forms,retaining every original elimination decision,unique survivor,operational witness,control and closure record.\n\nOriginal V3: sft/physics/matter_flavour_laws_v1.py, {source}; original registered dependencies. Pin: 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Lean: {core} and {tag}Witnesses/Grammar/Controls/Evidence. Timeline: TURN{n}. Receipt: verification/TURN_{n}_{key}_COMPLETION.json.\n\n[Original source](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/matter_flavour_laws_v1.py); [Native derivation](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/{core}.lean); [Complete grammar](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/{tag}Grammar.lean); [Timeline](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/TIMELINE.txt).\n'.replace('all256','all 256').replace('forms,retaining','forms, retaining'))
 (w/f'timeline{n}_addition.txt').write_text('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+f' — TURN{n}: translated original {source} and retained actual source domains and returned fields. Reused existing exact arithmetic and generated dependencies. Core build and all exported declaration audits pass;fresh original scientific output comparison passes. Existing complete256-form entry checks required before registration. Section{sec} gives source equations,intermediate calculations,original domains and source/Lean/timeline references.\n')
with (w/'timeline924_addition.txt').open('a') as f:f.write('The original zero-nu trace stops before any refinement. Implemented full64-depth dyadic interval enumeration,source-order bisection and unbounded-loop operational relation;proved generated initial stop rather than imposing a fuel/tolerance on the scientific loop. Whole-upper recursion fuel is derived from the positive numerator;wholeUpperFromOne proves correspondence for every positive denominator. Initial proof used unsupported split syntax;corrected it. Nat.le_mul_self carried propext,identified by actual axiom audit and printed proof dependencies;replaced that lemma locally by constructive zero/successor multiplication bounds. All32 declarations then audited empty. Added original square bounds and universal rational opposition bound. Fresh full result,14 root/domain cases and5 bisection cases match source.\n')
print('Prepared source-bound sections796–797 and registrars')

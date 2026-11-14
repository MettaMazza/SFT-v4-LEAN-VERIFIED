from pathlib import Path
import json
w=Path('work');items=json.load(open(w/'gravityvalidation912_items.json'))
texts=[('Gravity, clock and equivalence: complete post-seal comparison', '''The sealed clock and redshift derivations precede the observational comparison. The generated static-clock example retains well depth 7/16 and clock factor 3/4. Their exact relation is

1−7/16=9/16=(3/4)².

The existing equivalence derivation retains the same source-bound clock/redshift relationship. The post-seal operation does not fit either fraction to measurement. It retains the original NIST/JILA frequency-gradient record,

g=(-1.28±0.27)×10⁻¹⁹ mm⁻¹,

and the CNES MICROSCOPE equivalence test at reported precision of order 10⁻¹⁵. The corrected central value and uncertainty remain one observation record; neither is an input selecting the formal clock factor. The original normalization control explicitly distinguishes these observations from a measurement of universal Fold fractions 3/4 or 7/16.

For the original clock key k, the exact comparison is

L_clock=P[complete_classification][k],
passed=(L_clock=E_clock).

GravityAuthoritativeWitnesses.clockOriginalClassification proves that the whole registered label is returned, including its structural-normalization clause; clockCheckPassed proves the original witness. The source's induction base retains the corrected NIST gradient and uncertainty; the extension appends equivalence and normalization-control rows without selecting or rescaling the sealed law.'''),('Gravitational waves: speed, polarization and quadrupole comparison', '''The preceding formal wave derivation retains One-speed phase transport and its two transverse polarizations. Its original trace separates the constant first difference

Δ(1,2,3,4)=(1,1,1)

from the cubic trace

Δ(1,8,27,64)=(7,19,37),
Δ²(1,8,27,64)=(12,18).

The original post-seal observation retains the GW170817/GRB170817A delay 1.74±0.05 s and both sides of the inferred relative-speed interval:

−3×10⁻¹⁵ ≤ (c_g−c)/c ≤ 7×10⁻¹⁶.

The formal common-speed value gives (c_g−c)/c=0, which lies in this held interval. The interval is an external comparison, not a chosen tolerance in the formal derivation. Tensorial-polarization and fundamental-quadrupolar/first-overtone records are retained alongside the registered catalog coverage. The source does not turn these observations into exclusion of every additional mode at every frequency or source class.

The native lookup gives

L_wave=P[complete_classification][gravitational_waves],
passed=(L_wave=E_wave).

GravityAuthoritativeWitnesses.waveOriginalClassification and waveCheckPassed retain the entire original classification. The source base retains the two-sided speed interval; the extension appends polarization, quadrupole and coverage records without deleting either interval endpoint or the finite-coverage control.'''),('Horizons and information: measured support and retained boundaries', '''The sealed horizon calculation gives radius 1/2 from mass 1/4, with exact normalized entropy

r=2m=2·(1/4)=1/2,
S=(1/4)·32=8.

The information ledger retains eight ordered boundary labels and reconstruction with the complete inverse record. The earlier proof establishes, for a complete observation record R,

observe(state,mapping,label)=ok(selected,R)
⇒ (map first R,selected.phaseCycle)=state.

These results are fixed before the validation target is opened. The original EHT source retains independent reconstruction and persistent ring-size observations; the LIGO/Virgo record retains compact strong-field ringdown. The original source also retains that the shadow is not a direct photograph of the event horizon, and that Hawking temperature, singularity avoidance and complete information reconstruction are not directly measured by these records.

The exact post-seal classification is

L_horizon=P[complete_classification][horizons_information],
passed=(L_horizon=E_horizon).

GravityAuthoritativeWitnesses.horizonOriginalClassification and horizonCheckPassed prove the complete original label and witness. The base retains independent shadow observations and size consistency; extension appends strong-field, directness, thermal and information rows. It preserves each row's original role rather than converting an inference into direct observation.'''),('Nonstandard spacetime: formal admissibility and realization records', '''The preceding three formal entries establish the exact original acceptance relations:

W(s,L,T)=(0<s)∧L∧T,
A(s,d,R)=(0<s)∧(0<d)∧(s=d)∧R,
C(I,F,T)=(I≠())∧(I=F)∧T.

Their native proofs establish both directions of each acceptance equivalence over the original carriers. The post-seal operation preserves these conditions and separately reads the authority vector's realization status. It does not alter any condition using observation.

The source record contains no confirmed wormhole, warp or closed-timelike realization, and retains the catalog's stated absence of nonstandard strong-field signatures in its registered analysis. The original source forbids both an inference from admissibility to observed existence and an unlimited no-go conclusion from this finite search.

L_nonstandard=P[complete_classification][nonstandard_spacetime],
passed=(L_nonstandard=E_nonstandard).

GravityAuthoritativeWitnesses.nonstandardOriginalClassification and nonstandardCheckPassed prove that the complete original label and witness are preserved. The base retains each formal theorem's source and causal ledger. The extension requires a future realization claim to append a separately committed controlled measurement without rewriting the sealed admissibility receipt. The formal conditions and observational status therefore remain separate, explicit records.''')]
shared='''
All four comparisons retain the same original source object P and its bytes B. The original ordered identity checks are

H(B)=h_record,
P.record_id=GRAVITY-SPACETIME-AUTHORITATIVE-2017-2026,
P.formal_seal_boundary.sealed_claim_count=13,
|P.sources|=6,
|P.unfavorable_and_scope_controls|=6,
H(B_j)=h_j for each snapshot named in the two-component map.

The two named component snapshots are the CNES MICROSCOPE final page and GWOSC catalog JSON. The other source rows remain in the returned object; no additional component requirement is introduced. GravityAuthoritativeRecords.authoritativeRecord preserves the check order and returns P in full. classificationFromRecord returns the requested string or the original missing-classification error. The native input adapter reads the pinned bytes and component files, so full-record comparison includes the actual source and component digest operations.

For each entry, CompleteRecordValidator first requires the original classification to equal the registered complete label. The existing blind empirical pipeline then executes and seals the prediction, audits the package, releases the held target through custody, compares the whole label, rejects the altered-target control, and retains every certificate and receipt field. The source has one complete target row per entry; its internal favorable and adverse source records remain together in that row. No measurement selects a formal survivor.

Each entry retains all eight original binary empirical axes, their full 2⁸=256-product enumeration, original elimination decisions, unique retained form, operational witness and four controls. The scientific laws are the previously sealed dependency results; these entries implement their original post-seal measurement comparison and empirical boundaries.
'''
for i,((key,tag,n,cid),(title,body)) in enumerate(zip(items,texts)):
 low=tag.lower();section=784+i
 (w/f'paper_{low}{n}_addition.txt').write_text(f'\n{section}. {title}\n\n'+body+'\n'+shared+f'\nOriginal V3: sft/physics/gravity_spacetime_validation_v1.py, authoritative_record, classification, {key}_SPEC and CompleteRecordValidator.validate; gravity-spacetime-source-record.json; generated_empirical_law.py. Pin: 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Lean: GravityAuthoritativeRecords, GravityAuthoritativeWitnesses and {tag}Witnesses/Grammar/Evidence/Experiment/Validation. Timeline: TURN{n}. Receipt: verification/TURN_{n}_{key}_VALIDATION_COMPLETION.json.\n\n[Original source](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/gravity_spacetime_validation_v1.py); [Record operations](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/GravityAuthoritativeRecords.lean); [Exact classification proofs](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/GravityAuthoritativeWitnesses.lean); [Complete validation](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/{tag}Validation.lean); [Timeline](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/TIMELINE.txt).\n')
print('Prepared mathematical sections784–787')

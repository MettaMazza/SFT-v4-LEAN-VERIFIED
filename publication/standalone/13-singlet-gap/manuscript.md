# A positive colour-singlet gap from exact Fold closure

**Maria Smith · Ernos Labs**  
Standalone paper 13 · Version 1.0 · 17 November 2026  
DOI: 10.5281/zenodo.24326473

## Abstract

The generated colour-three sector has the exact normalized least-singlet gap \(g=1/3\) at every positive finite depth. Its complementary holding share \(c=2/3\) exchanges with \(g\) under Fold, forming a complete period-two orbit. The least observable singlet has two constituents; the complete colour fibre has three. At separation \(j\), the original construction returns \((j,g,W_j,S_j)=(j,1/3,2j/3,2)\). Every successor preserves the positive gap and adds exactly \(2/3\) confinement work. For every positive rational work bound \(B\), the finite separation \(N=\lfloor3B/2\rfloor+1\) satisfies \(W_N>B\). These results coexist with an empty local carrier mass record and exact One-cell causal propagation. We derive the partition, support, base and successor statements, finite bound witness and complete grammar closure, with corresponding native Lean proofs. A separate sealed comparison retains all three registered pure-gauge lattice intervals: \([1627,1679]\), \([2344,2408]\) and \([2521,2601]\) MeV. Every lower edge is positive and the intervals are strictly ordered. The formal result supplies the normalized one-third separation; the lattice masses supply the external dimensional spectrum. Complete source records, controls and verification evidence accompany the paper.

**Keywords:** colour-singlet gap; confinement; locally massless carrier; glueball spectrum; finite Fold dynamics; exact rational arithmetic; Smithian Fold Theory; Lean 4.

## 1. The result and its quantified domain

For every positive integer depth \(d\), the original singlet construction generates exactly the ordered list

\[\mathcal R_d=\left[\left(j,\frac13,\frac{2j}{3},2\right):j=1,\ldots,d\right].\]

The coordinates are separation depth, normalized singlet gap, confinement work and physical constituent support. Consequently,

\[g_j=\frac13>0,\qquad S_j=2,\qquad W_j=\frac{2j}{3}>0,\]
\[g_{j+1}=g_j,\qquad W_{j+1}=W_j+\frac23>W_j.\]

The quantified carrier is every positive finite depth. Its construction is exact rational arithmetic over the generated colour-three sector and the original closed singlet supports. The empty excitation record represents the vacuum. The isolated-colour observation record, local carrier mass record and rest-capture record are also empty, with distinct roles. Record emptiness is preserved as structure throughout the derivation.

A second quantified result strengthens strict work increase:

\[\forall B\in\mathbb Q_{>0}\ \exists N\in\mathbb N_{>0}:\quad W_N>B.\]

The witness is computed explicitly from \(B\), and its proof is given in section 5. Neither statement is inferred from the finite operational witness traces. Native Lean proofs establish the row formula for arbitrary depth, the exact successor identities and the bound witness for every positive rational numerator and denominator.

The mathematical inputs are the pinned V3 colour inventory, interaction table and simultaneous local-carrier/confinement law [1,2]. V4 preserves their original operations and proof domains [3]. The three entries retain observational-derivation provenance; sealing separates the executable prediction from subsequent target release. The external spectrum comparison is developed after the mathematical construction.

## 2. The generated colour partition

### 2.1. Complete sector and pair support

The admitted prime-sector ladder is \((2,3,5,7)\). The original colour sector is three. Its complete ordered charge-pair support has

\[3\times3=9\]

cells, of which one is the colourless return. The non-return mediator count is therefore

\[9-1=8.\]

The original `strong_sector_structure` returns the sector, three charge labels, nine pair cells, one return cell, eight mediators, the coupling, empty mass label, its mass-class label and the retained colour/anticolour charge. Thus the carrier’s colour charge and local mass record are separately represented.

For every admitted sector \(m\), `base_sector_table` constructs the holding share \((m-1)/m\), mass shortfall \(1/m\), mixing share \(1/(m-1)\), mediator count \(m^2-1\) and complete standing-mode list. At \(m=3\),

\[c=\frac{3-1}{3}=\frac23,\qquad g=\frac13,\]
\[c+g=\frac{2+1}{3}=1.\]

The single interior standing mode is \(1/(3-1)=1/2\). The table supplies both shares before the spectrum record is read. For a fixed \(c=2/3\), any exact part \(h\) satisfying \(c+h=1\) equals \(1-c=1/3\). The complete One-partition therefore fixes the complement uniquely.

### 2.2. The period-two Fold orbit

On positive exact parts \(0<x\leq1\), the original Fold operation is

\[F(x)=\begin{cases}2x,&2x\leq1,\\2x-1,&2x>1.\end{cases}\]

At the two generated shares,

\[F\!\left(\frac13\right)=\frac23,\]
\[F\!\left(\frac23\right)=\frac43-1=\frac13.\]

The first images differ from their starting values because \(1/3\neq2/3\). The second images return to their starting values. The least positive return count is consequently two. Both parts remain positive and their union as shares reconstructs One.

`YangMillsSingletGap.strongGapPartition` calls the actual interaction table and both guarded Fold operations. `originalPartition` proves the complete returned record: coupling \(2/3\), gap \(1/3\), complete partition, both exchanges and period two. The input guard rejects values outside the positive exact-part domain.

## 3. Why the least physical support is nonempty

The original sector inventory has two singlet constructions. `antipodal_pair_count` checks that the sector is admitted and returns the antipodal pair count two. `singlet_constituent_count` returns the complete charge-kind count, which is three in the colour sector. The ordered support list is therefore

\[\mathcal S=(2,3).\]

Its least element is two. Since \(2>1\), the least retained singlet is a nonempty composite. The complete three-member colour fibre remains the second support; it is not discarded when the least support is selected.

The physical closure rule joins an antipodal pair or the complete colour fibre, retaining every colour label in the selected closure. The isolated-colour observation record is empty under the admitted confinement law. The vacuum excitation record is empty. These records are returned alongside the constituent counts by `physical_singlet_support`:

\[\bigl(2,3,(2,3),\mathrm{true},(),()\bigr).\]

`YangMillsSingletGap.originalSupport` proves that full six-field output. The mathematical separation is the positive complement \(1/3\) attached to this least closed physical support. It does not arise by treating the empty local mass record as a scalar and subtracting it from a measured mass.

The combined construction now has three explicit ingredients: the generated complete colour sector fixes \(c=2/3\); its unique One-complement is \(g=1/3\); the physical singlet boundary supplies least support two. The subsequent successor operation retains all three.

## 4. Local masslessness and confinement in one construction

### 4.1. Exact causal propagation

For an admitted causal depth \(d\geq2\), the original local trace returns

\[x_t=t+1\quad(t=0,\ldots,d),\qquad\phi_t=\frac13.\]

Every adjacent difference is

\[x_{t+1}-x_t=(t+2)-(t+1)=1.\]

The phase is unchanged at every position. The mass label and rest-capture record remain empty, and the causal speed is One. `originalEveryCausalPositionTrace`, `originalEveryRetainedPhaseTrace` and `originalEveryCausalEmptyMass` identify those complete original outputs for every admitted depth. `originalCausalSuccessor` proves the exact One-position successor.

### 4.2. Fixed tube and increasing work

For each positive separation \(j\) in the admitted tube trace, the source returns

\[\left(\text{separation},\text{width},\text{field},\text{work}\right)
=\left(j,\frac12,\frac23,\frac{2j}{3}\right).\]

The width \(1/2\) and field carrier \(2/3\) remain fixed. The work increments satisfy

\[W_{j+1}-W_j=\frac{2(j+1)}3-\frac{2j}3=\frac23>0.\]

The isolated-colour carrier record remains empty. `originalEveryTubeRow` proves the entire generated row list; `originalEveryTubeBoundary` proves the width, field and empty boundary for every admitted depth. `originalWorkRepresentation` puts each product into the exact numerator form \(2j/3\). `originalConfinementSuccessor` and `originalWorkStrictlyIncreases` then establish the successor identity and its strict inequality.

These proofs lie in `SFT.Physics.StrongCarrierMasslessConfinedGeneral`. The simultaneous certificate combines local causal propagation, fixed tube width, fixed field, exact work increments, empty local mass and empty isolated-colour records. Local propagation and physical isolation are different records of the same colour carrier. The source construction retains both at every successor.

## 5. A finite witness beyond every positive work bound

Let \(B=n/d\) with positive integers \(n,d\). Dividing by the fixed work increment gives

\[R=\frac{B}{2/3}=\frac{3n}{2d}.\]

Write its reduced positive rational representation as \(R=a/b\), with \(b>0\). The original operation returns

\[N=\left\lfloor\frac ab\right\rfloor+1,\qquad W_N=\frac{2N}{3}.\]

Euclidean division gives integers \(q,r\) with

\[a=bq+r,\qquad0\leq r<b,\qquad q=\lfloor a/b\rfloor.\]

Hence

\[a=bq+r<bq+b=b(q+1)=bN,\]
\[\frac ab<N.\]

Multiplication by the positive share \(2/3\) preserves the inequality:

\[B=\frac23\frac ab<\frac23N=W_N.\]

Also \(N=q+1\geq1\), so the witness is a positive finite separation. In unreduced source coordinates the strict inequality is

\[3n<2Nd.\]

The Lean proof follows these same steps. `successorWholeExceeds` uses quotient and remainder to prove \(a<b(a/b+1)\). `originalBoundCross` transports the normalized ratio identity and obtains \(3n<2Nd\). `originalBoundWorkExceeds` converts that cross-product inequality to exact rational order. `originalEveryBoundRecord` identifies the actual returned record, including the input bound, witness separation, work, strict-exceedance result and finite-witness result.

The source certificate also retains five explicit operational instances:

| Bound \(B\) | \(3B/2\) | Witness \(N\) | Work \(W_N\) |
|---:|---:|---:|---:|
| \(1/8\) | \(3/16\) | \(1\) | \(2/3\) |
| \(1/2\) | \(3/4\) | \(1\) | \(2/3\) |
| \(1\) | \(3/2\) | \(2\) | \(4/3\) |
| \(7/3\) | \(7/2\) | \(4\) | \(8/3\) |
| \(32\) | \(48\) | \(49\) | \(98/3\) |

Each work value exceeds its corresponding bound. The quantified proof supplies the result for every positive rational bound, including all bounds absent from this operational list.

## 6. The all-depth positive singlet gap

### 6.1. Base and successor

The first positive separation has

\[R_1=\left(1,\frac13,\frac23,2\right).\]

Its gap and work are positive, and its physical support is nonempty. Assume the generated row at separation \(j\) is

\[R_j=\left(j,\frac13,\frac{2j}{3},2\right).\]

The successor preserves the colour sector and singlet support and adds the same holding share to the work:

\[R_{j+1}=\left(j+1,\frac13,\frac{2j}{3}+\frac23,2\right)
=\left(j+1,\frac13,\frac{2(j+1)}3,2\right).\]

The gap remains \(1/3>0\), and the work increases strictly. Positive finite induction yields the formula at every positive separation. Enumerating precisely the first \(d\) positive separations gives \(\mathcal R_d\) from section 1.

### 6.2. Correspondence to the complete trace

The actual `singletGapTrace` accepts every integer \(d\geq1\). It invokes the local and tube traces at \(\max(2,d)\), preserving their original minimum input depth while retaining exactly \(d\) singlet rows. `originalEveryRows` proves the returned list for arbitrary \(d=n+1\). Its proof handles \(d=1\) directly and uses \(\max(2,d)=d\) for \(d\geq2\).

For an arbitrary row index \(k\in\mathbb N\), `originalRow k` has separation \(k+1\). The native declarations `originalRowGapPositive`, `originalRowGapInvariant` and `originalRowSupport` prove its positive gap, successor invariance and support two. `originalRowWorkPositive` proves positivity of the exact product. `originalRowWorkSuccessor` and `originalRowWorkIncreases` reuse the quantified confinement theorems directly on the generated singlet row.

`originalEveryEmptyBoundary` proves, for every admitted depth, that the isolated-colour, vacuum-excitation and local-mass records remain empty while the physical singlet remains nonempty and positively separated. The trace also retains the exact local causal-speed and confinement results. The finite operational witnesses at depths 20 and 24 exercise the original program; the universal row and successor proofs establish the unrestricted positive finite-depth result.

## 7. Complete construction, classification and closure

### 7.1. Simultaneous-carrier grammar

The carrier grammar has six three-way coordinates and two binary coordinates. The first six coordinates are sector, mass record, causal propagation, self-source, confinement and composition. Each includes the generated construction, an alternative construction and a target-assigned construction. The final coordinates distinguish prediction sealing and extension. The complete product has

\[3^6\cdot2^2=2916\]

forms. The preserving coordinate uses the generated colour-three/eight-mediator sector; empty mass and rest-capture records; One-cell propagation; colour-carrying self-source; fixed half-One tube and two-thirds work increment; simultaneous local and isolation records; sealed prediction; and empty extension.

The other alternatives replace the sector count, assign a mass or speed, replace self-source with a chargeless carrier, spread the tube or bound its work, treat masslessness and confinement as exclusive, read observations before sealing, or add a free correction. Each changes an original operation or its declared record boundary. `factsComputed` proves that the program’s candidate facts are exactly the facts of the simultaneous certificate. `sourceDecision` connects the original decision operation to their conjunction. `candidatesComplete` proves membership for every candidate coordinate; `uniqueSurvivor` and `survivorAccepted` establish the unique admitted combination.

### 7.2. Singlet-gap grammar

The singlet grammar is the full ten-axis binary product, containing

\[2^{10}=1024\]

forms. The axes and both alternatives are explicit:

| Axis | Preserving construction | Other construction |
|---|---|---|
| Sector | Generated colour-three support | Conventional sector name alone |
| Physical support | Complete closed singlet | Isolated colour carrier |
| Vacuum | Empty excitation record | Numerical-zero vacuum |
| Gap | Exact positive one-third complement | Massless or fitted gap |
| Confinement | Fixed two-thirds positive successor | Bounded or free separation work |
| Carrier | Local massless and physical gapped records | Conflated local and singlet records |
| Orbit | Complete period-two One-partition | Selected pair without closure |
| Depth | Positive finite successor induction | Bounded sample or completed infinity |
| Prior statement | Free singlet spectrum distinction | Exclusion of locally massless strong carriers |
| Extension | No extra rule | Free scale, action or continuum limit |

Necessity follows coordinate by coordinate. The generated sector supplies the exact shares; complete physical support supplies the nonempty singlet; the empty-record vacuum preserves the source domain; the unique complement fixes the gap; the work successor supplies confinement; separate local and singlet records preserve the simultaneous certificate; Fold proves the orbit; induction extends it to every positive finite depth; the prior-statement coordinate retains the established locally massless carrier; and the empty extension keeps the original construction fixed.

Sufficiency is constructive: combine those ten preserving coordinates and execute sections 2–6. They return every required partition, support, row and boundary record. Thus the complete preserving tuple is accepted. If any coordinate changes, its corresponding required operation or boundary changes, and the original decision rejects it.

The native product lists both constructors on every axis. `candidatesComplete` proves membership by nested finite-list membership for an arbitrary candidate. Sixteen exhaustive decision subranges cover the full product. `sourceDecisionMatchesCriteria` proves that the actual source decision equals the coordinate conjunction; `uniqueCriteriaSurvivor` proves that conjunction holds precisely for the preserving tuple. Their composition gives

\[\forall c\in\mathcal C:\quad\operatorname{survives}(c)
\iff c=c_*.\]

`acceptanceIffExactCriteria` states the same result as the explicit ten-coordinate conjunction. These grammar proofs accompany, rather than replace, the all-depth mathematical derivation.

## 8. Complete pure-gauge spectrum comparison

### 8.1. Exact external intervals

The registered external source is the pinned PDG 2026 Quark Model record [4], retaining pages 11, 12 and 32 and the complete PDF byte identity. Its three precise pure-SU(3)-gauge lattice rows are:

| Quantum numbers | Mass, MeV | Standard uncertainty, MeV | Closed interval, MeV | Registered role |
|---|---:|---:|---|---|
| \(0^{++}\) | \(1653\) | \(26\) | \([1627,1679]\) | Lightest registered glueball |
| \(2^{++}\) | \(2376\) | \(32\) | \([2344,2408]\) | First registered excitation |
| \(0^{-+}\) | \(2561\) | \(40\) | \([2521,2601]\) | Pseudoscalar excitation |

For each row, the source reads exact inscriptions \(m,u\) and constructs \([m-u,m+u]\). Explicitly,

\[1653-26=1627>0,\qquad1653+26=1679,\]
\[2376-32=2344>0,\qquad2376+32=2408,\]
\[2561-40=2521>0,\qquad2561+40=2601.\]

Their adjacent ordering is strict:

\[1679<2344,\qquad2408<2521.\]

Every lower uncertainty edge is positive and the three intervals are disjoint. The scalar ground-state and tensor first-excitation labels retain their original external assignments.

The retained source describes the quenched approximation, which neglects quark loops; possible mixing of glue and quark–antiquark states; and the need for dynamical light quarks, mixing control and high statistics in full QCD. Its experimental-identification record reports no scalar below 2 GeV established as predominantly glueball and no unambiguous experimental glueball identification. These statements belong to the actual spectrum record used here.

### 8.2. What carries the scale

The Fold construction supplies the normalized exact separation \(g=1/3\) and its positivity. The table supplies dimensional lattice masses and uncertainties in MeV. The comparison tests the positive sign and retains the full ordered spectrum. No conversion coefficient from one-third to a MeV mass is introduced by the original law. Its domain is the finite Fold colour sector and all positive finite successors; the source does not import a continuum action, Hamiltonian or completed infinite-volume construction.

### 8.3. Complete analysis and adverse control

Each returned spectrum row retains quantum numbers, central mass, uncertainty, lower edge, upper edge and role. The nine-field aggregate retains all rows, row count, quantum-number order, central positivity, lower-edge positivity, interval ordering, scalar-ground check, tensor-excitation check and the conjunction of the six source-scope conditions.

The original adverse control changes the first central mass to 2400 MeV while preserving its uncertainty 26 MeV. It therefore gives

\[[2400-26,2400+26]=[2374,2426].\]

The required first ordering would become \(2426<2344\), which is false. The altered record is rejected. Full row retention and an unfavorable control are part of the accepted comparison.

## 9. Prediction, custody and empirical grammar

The formal predecessor supplies three original witnesses: gap \(1/3\), least support two and a positive-gap/increasing-work trace at depth 20. The prediction program takes a sealed-derivation label, constructs the registered physical-observation label, pairs the labels and emits the observation label. These are its four instructions. Six registered spectrum/scope locators refer to one complete withheld target object.

Let \(R\) be the registration, \(H\) the original canonical digest operation and \(S\) the derivation seal. The envelope binds the experiment identifier, the input digest \(H(\operatorname{HeldLabel}(\text{sealed-derivation},S))\), the withheld-target identifier, \(S\) and \(H(R)\). The target-vault nonce is

\[H\bigl((H(R),\text{source hashes})\bigr).\]

After capability-closed execution, the prediction seal binds the output, trace and envelope digests. The target vault releases the committed target against that seal. Custody verification checks the release against its original identity. The comparator then evaluates the complete source record.

The acceptance conjunction is

\[P=F\land A\land C\land T,\]

where \(F\) contains all three formal witnesses; \(A\) requires three rows, ordered labels \((0^{++},2^{++},0^{-+})\) and every scope condition; \(C\) contains central positivity, lower-edge positivity, strict disjoint ordering and both state-label checks; and \(T\) requires rejection of the altered scalar row. Sections 6 and 8 establish each mathematical and arithmetic component.

The empirical grammar is the complete eight-axis binary product, containing \(2^8=256\) forms. Its preserving coordinates are complete Fold carrier, the positive-gap relation with complete spectrum scope, source-bound proof trace, capability-closed prediction, separate measurement record, every registered row, finite successor closure and no extra rule. The alternative at each coordinate omits or changes that requirement. Native completeness proves every eight-coordinate form occurs; source-decision correspondence and the unique-survivor theorem establish the exact conjunction. Opening another registered spectrum row retains the preceding formal gap and its successor proof.

## 10. Source correspondence and native verification

The original source is pinned to V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1` [1,2]. Native source and retained verification are pinned to V4 commit `21cdf559922fb057f8560f42d056ffa035329eb3` [3]. The principal source files under `sft/physics/` are `strong_carrier_massless_confined_terminal_law_v1.py`, `yang_mills_singlet_gap_terminal_law_v1.py`, `yang_mills_singlet_gap_empirical_v1.py` and `yang_mills_singlet_gap_empirical_validation_v1.py`, with their original execution bindings and dependencies.

| Source operation or argument | Native family under `SFT.Physics` | Evidence |
|---|---|---|
| Local trace, tube and simultaneous certificate | `StrongCarrierMasslessConfined`, `StrongCarrierMasslessConfinedCertificate` | TURN986 |
| Arbitrary depth and every positive work bound | `StrongCarrierMasslessConfinedGeneral` | TURN986 |
| Partition, support, all singlet rows and successors | `YangMillsSingletGap` | TURN1004 |
| Complete 1,024-form construction | `YangMillsSingletGapGrammarBase`, `Census0`–`Census15`, `YangMillsSingletGapGrammar` | TURN1004 |
| Complete record identity and exact intervals | `YangMillsSpectrumRecords`, `YangMillsSpectrumMeasurement` | TURN1005 |
| Sealed program, 256-form grammar and full comparison | `YangMillsSpectrumExperiment`, `YangMillsSpectrumGrammar`, `YangMillsSpectrumValidation` | TURN1005 |

The three entry receipts cover 352 distinct audited declarations with empty axiom dependencies. The retained evidence includes affected-module builds, full original program comparisons, all candidates and decisions, original controls and independent-validator checks. The singlet-gap operation comparison retains 49 complete original outputs. The spectrum operations retain 88 analysis outputs and 85 accepted/rejected record outcomes, followed by the complete sealed empirical comparison.

The archive contains 750 native source/import modules, 54 original source/binding/dependency files, exact source correspondence and retained verification. Its portable arithmetic reproduction executes unchanged original pure functions with their actual imported operations. It reproduces the complete partition and support records, original traces, all five bound witnesses, complete spectrum analysis, input guards and the altered-mass control. Existing native proofs are reused with their matching source digests and raw empty-axiom audit records.

## 11. Consequence

The complete generated colour construction yields a nonempty least physical singlet with exact normalized gap \(1/3\). Every positive finite successor preserves that separation and adds \(2/3\) work. The explicit quotient-and-successor witness exceeds every supplied positive rational bound at a finite separation. Exact One-cell local propagation and empty local mass coexist with these confinement and singlet results. The independent dimensional spectrum record has three positive, disjoint ordered intervals, and its complete comparison preserves the same positive-separation sign.

## References

1. Smith, Maria. *SFT V3 physics corpus*. [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655). [Pinned original source](https://github.com/MettaMazza/ernos-labs-sft-platform/tree/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1).
2. Smith, Maria. *SFT V3 monograph*. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Operational foundation: [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).
3. Smith, Maria. *SFT native Lean 4 verification*, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Cumulative sections 874–876; [pinned native source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3).
4. Particle Data Group. *Review of Particle Physics 2026: Quark Model*, sections 15.4.2 and 15.8, registered pages 11, 12 and 32. [Original source](https://pdg.lbl.gov/2026/reviews/rpp2026-rev-quark-model.pdf). The exact three-row spectrum and complete source scope are retained in the pinned V3 record `yang-mills-singlet-gap-source-record.json`.

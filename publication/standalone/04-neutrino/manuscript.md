# Neutrino masses, mixing and a nonzero double-beta amplitude from Fold geometry

**Maria Smith** · Ernos Labs  
Standalone paper 4 · Version 1.0 · 17 November 2026 · DOI: 10.5281/zenodo.24324554

## Abstract

Smithian Fold Theory fixes the positive, normally ordered neutrino mass-square coefficients at 1/32, 33/32 and 3203/96 in solar-splitting units. Its solar-to-atmospheric splitting ratio is exactly 3/100. Binary separation, generator-three separation and complete depth-three support give the squared mixing entries 1/2, 1/3 and 1/48, with normalized electron-flavour weights 47/72, 47/144 and 1/48. The unique self-antipodal half-One supplies phase carrier 1/2 and the one-hand Majorana coupling. Exact rational root enclosures prove that the middle weighted mass exceeds the combined opposition budget of the other two, giving a phase-independent positive double-beta coefficient floor 11/288 and ceiling 271/288 relative to the square root of the solar anchor. With the original registered solar mass-squared anchor, the three masses are approximately 1.529910, 8.788665 and 49.990072 meV, summing to 60.308647 meV; refined double-beta bounds are approximately 0.828371–4.908674 meV. Seven formal entries and two empirical entries are translated in native Lean 4; their audit union contains 918 distinct declarations with zero axiom dependencies. The paper gives the exact constructions, exhaustive grammars, noncancellation argument, dimensional translation and complete original PDG, direct-mass and cosmological comparisons.

**Keywords:** neutrino masses; neutrino mixing; PMNS matrix; normal ordering; Majorana neutrino; neutrinoless double-beta decay; Smithian Fold Theory; Lean 4; zero free parameters.

## 1. The principal results

Let \(\Delta_\odot>0\) denote the solar mass-squared anchor when the generated dimensionless structure is translated to eV units. The exact construction yields
\[
 (m_1^2,m_2^2,m_3^2)
 =\Delta_\odot\left(\frac1{32},\frac{33}{32},\frac{3203}{96}\right),
 \qquad 0<m_1<m_2<m_3.
\]
The differences obey
\[
 m_2^2-m_1^2=\Delta_\odot,\qquad
 m_3^2-m_1^2=\frac{100}{3}\Delta_\odot,
\]
so their exact ratio is \(3/100\). The squared mixing entries and phase carrier are
\[
 (s_{23}^2,s_{12}^2,s_{13}^2)=\left(\frac12,\frac13,\frac1{48}\right),
 \qquad p_{\rm CP}=\frac12.
\]
The normalized electron-flavour weights are
\[
 (w_1,w_2,w_3)=\left(\frac{47}{72},\frac{47}{144},\frac1{48}\right),
 \qquad w_1+w_2+w_3=1.
\]
For the source Majorana construction, the exact phase-independent enclosure is
\[
 \frac{11}{288}\sqrt{\Delta_\odot}
 \le m_{\beta\beta}\le
 \frac{271}{288}\sqrt{\Delta_\odot},
 \qquad m_{\beta\beta}>0.
\]
Sections 2–6 derive the coefficients and the strict noncancellation certificate. Sections 7–9 retain the complete candidate classifications and the original measured comparisons. The original V3 laws and their native V4 proofs are cited together [1–4].

## 2. The generated support counts

SFT's operational root retains the distinction between unpresented absence and presented occurrence. Presenting a claim, denial or record is itself an occurrence. Complete retention without unforced addition fixes structural One. Equal complementary positive parts satisfy \(h+h=1\), giving half-One \(h=1/2\). Fold doubles a positive exact part and retains its positive representative through One:
\[
 F(x)=\begin{cases}2x,&0<x\le1/2,\\2x-1,&1/2<x\le1.\end{cases}
\]
In the original primitive grammar, identity and square are injective; constant One has only a fixed image. Fold is noninjective because \(F(1/2)=F(1)=1\), and it has a nonstatic return through one-third and two-thirds. Thus it is the unique generating singleton. Any least nonempty generating finite word has length at most this singleton and at least one, so the singleton classification also establishes least-word uniqueness over all finite words [5].

Complete binary support doubles at each extension. From one initial word, induction gives \(|W_d|=2^d\); the two successor label classes are disjoint and retain every prior word. Source unit parts use the positive predecessor of that complete support. The first-return traces are
\[
\begin{aligned}
 \frac1{2^2-1}=\frac13&\longmapsto\frac23\longmapsto\frac13,\\
 \frac1{2^3-1}=\frac17&\longmapsto\frac27\longmapsto\frac47\longmapsto\frac17.
\end{aligned}
\]
No intermediate value equals its source. The first return has length two; the least larger positive count is three and is realized by the second trace. The generator is therefore three and its predecessor is two.

The binary cover of generator volume \(3^3=27\) has least depth five, because
\[
 2^4=16<27\le32=2^5.
\]
Every earlier positive depth has still smaller support. The independently generated interface count is \(2+3=5\), agreeing with that least cover. These are the original down-depth and covering-prime carrier. The complete depth-five cell is therefore \(1/2^5=1/32\), and complete support at generator depth is \(2^3=8\).

The native `GeneratorThreeDerivation.generatorThree` proves the first-return and least-successor argument. `AlphaCovers.leastCompleteSupport` links least coverage to actual generated word cardinality for every admitted carrier; `AlphaBlocks.downMinimal` specializes it to 27 and excludes all earlier depths. These same source objects feed the neutrino operations; they are not selected from a mass or mixing table.

## 3. Splitting and positive mass squares

### 3.1. Two distinct source ratios

The non-unison count at positive depth \(d\) is the positive predecessor of complete binary support:
\[
 M_d=2^d-1.
\]
At down-depth five and doubled depth ten,
\[
 M_5=31,\qquad M_{10}=1023,
 \qquad\frac{M_{10}}{M_5}=33.
\]
The factorization
\[
 2^{10}-1=(2^5-1)(2^5+1)=31\cdot33
\]
explains the rung-ratio cross-lock. This ratio is retained in the source record as the ratio of non-unison counts.

The physical splitting translation is a separate constructed quantity. One complete depth-five cell contributes \(1/32\). The covering-prime square is \(5^2=25\), whose positive predecessor is 24. Their product gives
\[
 R_\Delta=\frac1{32}\frac{24}{25}=\frac3{100}.
\]
The four-field source record retains solar rung 31, atmospheric rung 1,023, rung ratio 33 and translation ratio \(3/100\). The two ratios retain their distinct meanings. `NeutrinoLadder.completeSplitting`, `countRatioCrossLock` and `exactTranslation` verify the complete record and both exact identities.

### 3.2. The first positive cell and its two successors

The original No-Zero construction requires the lightest mass-square carrier to occupy a positive cell. The first complete depth-five cell is \(1/32\). In solar-splitting units, the next state adds One; the heavy state adds the reciprocal of the already generated splitting ratio:
\[
\begin{aligned}
 c_1&=\frac1{32},\\
 c_2&=c_1+1=\frac{33}{32},\\
 c_3&=c_1+\frac1{R_\Delta}
     =\frac1{32}+\frac{100}{3}
     =\frac{3203}{96}.
\end{aligned}
\]
All three coefficients are positive. The first difference is One and the second difference is \(100/3\); hence
\[
 0<c_1<c_2<c_3,
 \qquad\frac{c_2-c_1}{c_3-c_1}=\frac3{100}.
\]
The source operation checks this strict ordering before returning its three-field record. `NeutrinoLadder.completeMassSquares` evaluates the complete construction, and `strictPositiveOrdering` retains each strict comparison.

The coefficients are fixed before dimensional translation. Multiplying them by the single registered \(\Delta_\odot\) supplies mass squares in eV². The dimensional anchor does not alter the cell, select an ordering, or fit the two successor coefficients.

## 4. Mixing, flavour normalization and phase

The atmospheric squared-support part is the binary separation \(1/2\). The solar part is the generator-three unit separation \(1/3\). Their product is distributed over all eight depth-three binary cells, giving
\[
 s_{13}^2=\frac{(1/2)(1/3)}{2^3}=\frac1{48}.
\]
The construction retains every cell: multiplying the reactor contribution by eight recovers \((1/2)(1/3)=1/6\). `PMNSSupport.generatedTowerCardinality` identifies the denominator with the complete Fold-word enumeration, while `completeCellsReassemble` proves exact reassembly.

The source electron-flavour weights retain the remaining solar and reactor shares:
\[
\begin{aligned}
 w_1&=(1-s_{12}^2)(1-s_{13}^2)
     =\frac23\frac{47}{48}=\frac{47}{72},\\
 w_2&=s_{12}^2(1-s_{13}^2)
     =\frac13\frac{47}{48}=\frac{47}{144},\\
 w_3&=s_{13}^2=\frac1{48}.
\end{aligned}
\]
Their sum is
\[
 \frac{94+47+3}{144}=1.
\]
Every weight is a positive proper part. The complete PMNS/CP record contains the three squared entries, phase carrier and all three weights; `PMNSPhysical.completeSourceRecord` and `exactWeightClosure` prove the record and closure.

A self-antipodal positive part satisfies \(1-x=x\). Adding \(x\) to both sides gives \(2x=1\), so \(x=1/2\). Conversely half-One is its own complement and folds to One. It is the unique self-antipodal carrier, and every other positive exact part is excluded. `CPPhase.uniqueSelfAntipodal` and `everyOtherPartExcluded` prove these statements over the full positive exact part carrier. The registered physical comparison reads the carrier as a fraction of a full turn:
\[
 \delta_{\rm CP}=360^\circ\,p_{\rm CP}=180^\circ.
\]
This is the source's self-antipodal, maximal-separation phase position.

## 5. The one-hand Majorana discriminator

Solving the half-One fibre equation \(F(x)=1/2\) in the two Fold branches gives
\[
 x_L=\frac14,\qquad x_R=\frac34.
\]
They are complementary, and their separation is \(3/4-1/4=1/2\). The complete two-hand carrier retains both roles for the Dirac pair. The neutrino census retains one hand; that single role cannot instantiate the two distinct entries of the pair.

For one-hand self-pairing, the retained coupling must equal its own antipode. Section 4 proves that half-One is the unique such positive part. The generic left hand is not self-antipodal because its complement is the distinct right hand. The exact discriminator record is therefore
\[
 (x_L,x_R,\text{separation},\text{hand count})=(1/4,3/4,1/2,1),
\]
with self-antipodal lock true and generic-hand self-antipodality false. The class is the source's single-hand self-antipodal Majorana coupling. `MajoranaStructure.completeSourceRecord`, `genericComplement` and `halfOneLock` retain the original operation and its distinguishing fields. The unique-half-One theorem supplies the exclusion of every other proposed positive lock.

## 6. A phase-independent noncancellation certificate

Let \(r_i\) denote the positive roots of the dimensionless coefficients \(c_i\). The formal calculation represents them only by exact rational brackets. The original bracket operation searches whole bounds when the root exceeds One, otherwise the first successful dyadic interval. Squaring the endpoints verifies
\[
\begin{aligned}
 \frac18\le r_1\le\frac14,&\qquad
 \frac1{64}\le\frac1{32}\le\frac1{16},\\
 1\le r_2\le2,&\qquad 1\le\frac{33}{32}\le4,\\
 5\le r_3\le6,&\qquad 25\le\frac{3203}{96}\le36.
\end{aligned}
\]
The lower middle contribution is
\[
 w_2\,r_{2,\mathrm{lower}}=\frac{47}{144}=\frac{94}{288}.
\]
The greatest combined opposition allowed by the other two upper bounds is
\[
 w_1\,r_{1,\mathrm{upper}}+w_3\,r_{3,\mathrm{upper}}
 =\frac{47}{72}\frac14+\frac1{48}6
 =\frac{47+36}{288}=\frac{83}{288}.
\]
The middle contribution is strictly larger. Even maximal opposition cannot consume it; the remaining coefficient is at least
\[
 \frac{94-83}{288}=\frac{11}{288}>0.
\]
Adding all three upper contributions gives
\[
 \frac{47}{288}+\frac{47}{72}+\frac18=\frac{271}{288}.
\]
Multiplication by \(\sqrt{\Delta_\odot}\) gives the amplitude enclosure in Section 1. The bound holds for arbitrary held phase opposition because the entire opposing contribution is already bounded above by \(83/288\). In cross-multiplied form, for every positive denominator \(d\) and numerator \(n\),
\[
 288n\le83d\quad\Longrightarrow\quad288n<94d.
\]
`NeutrinolessBounds.everyBoundedOppositionFails` proves this quantified implication. `allOriginalSquareBounds`, `exactMiddleLower`, `exactOppositionBudget`, `exactPositiveFloor` and `exactCeiling` prove the complete rational certificate.

The source stopping rule asks whether the middle lower contribution exceeds the other two upper contributions. If not, it bisects all three brackets and repeats. In this construction the initial brackets already satisfy the strict test. `exactSourceLoop` proves that the original loop stops at this initial state, and `completeSourceResult` returns its full record. No selected tolerance or fitted phase enters the formal noncancellation argument.

## 7. Complete grammars and closure

Each of the seven formal entries uses a complete eight-axis binary product, with 256 forms. The two predecessor entries are the squared-support PMNS construction and the self-antipodal phase. The five successor entries are splitting, positive mass, physical PMNS/CP, Majorana discrimination and double-beta noncancellation.

The shared eight roles are generated carrier, admitted dependency trace, entry-specific relation, complete enumeration, omission/minimality control, measurement direction, full retained record and absence of an extra rule. Each role has exactly its preserving constructor and original opposed constructor. The relation axis is instantiated as follows:

| Entry | Preserving relation |
|---|---|
| PMNS squared support | Binary separation times generator separation, distributed over complete depth-three support |
| CP position | Unique self-antipodal half-One that folds to One |
| Splitting | Complete non-unison rung counts and the independent cell/predecessor-square translation |
| Positive masses | First positive depth-five cell plus the two forced splitting successors |
| Physical PMNS/CP | Complete normalized weights and self-antipodal phase |
| Majorana | One-hand coupling at the unique self-antipodal lock |
| Double-beta amplitude | Positive weighted contributions with strict rational noncancellation |

Every typed candidate chooses one constructor on every coordinate. Product membership supplies all \(2^8\) combinations. Acceptance requires the eight preserving constructors, so an accepted candidate equals their unique tuple; conversely that tuple passes. The source-matching and uniqueness proofs in each entry grammar quantify over arbitrary typed candidates. Each entry also retains its operational witnesses and four original adverse controls.

The base and successor arguments are substantive operations: complete binary support doubles; the two non-unison depths factor exactly; positive mass successors add the fixed differences; the reactor channel reassembles the complete diluted product; the self-antipodal equation has one positive solution; and the double-beta loop stops on its strict opposition certificate. The grammar does not replace these derivations. It exhausts the registered alternative ways of retaining or violating them.

The two empirical entries also enumerate 256 forms each. Their axes are complete Fold carrier, specified comparison relation, source-bound provenance, capability-closed prediction, separate measurement record, complete registered rows, one-successor row retention and no extra rule. Appending a registered authoritative row requires keeping and checking earlier rows. The registered comparisons use all the source fields described below.

## 8. The solar anchor and absolute mass intervals

The pinned PDG 2025 source record gives the solar value
\[
 \Delta_\odot=0.0000749\ \mathrm{eV}^2=\frac{749}{10^7}\ \mathrm{eV}^2,
\]
with reported lower and upper uncertainties of \(0.0000019\ \mathrm{eV}^2\). The original dimensional comparison uses this central solar value once. It produces the exact anchored squares
\[
 \frac{749}{320000000},\qquad
 \frac{24717}{320000000},\qquad
 \frac{2399047}{960000000}\quad\mathrm{eV}^2.
\]
The comparison-side root operation starts from its original positive bracket and bisects until its width is at most \(10^{-12}\) eV. At each midpoint \(q\), the test \(q^2<v\) chooses which endpoint to replace. The returned rational enclosures are:

| Mass | Lower endpoint (eV) | Upper endpoint (eV) |
|---|---:|---:|
| \(m_1\) | 430631417527/281474976710656 | 1722525671131/1125899906842624 |
| \(m_2\) | 1236894578135/140737488355328 | 9895156626103/1125899906842624 |
| \(m_3\) | 56283817330027/1125899906842624 | 28141908665525/562949953421312 |

The corresponding approximate readings are
\[
 (m_1,m_2,m_3)\approx(0.001529910128,\ 0.008788664574,\ 0.049990071931)\ \mathrm{eV}.
\]
Adding the lower and upper endpoints separately yields
\[
 0.060308646632392\ldots\le\sum_i m_i
 \le0.060308646635118\ldots\quad\mathrm{eV}.
\]
`NeutrinoMeasurementRoots.lightestSourceRun`, `middleSourceRun` and `heavySourceRun` connect all three successful evaluations to the original precision-based loop. Their numerical enclosures express the source calculation at its declared anchor; the reported solar uncertainty remains separately retained in the measurement record.

The same refined brackets sharpen the double-beta amplitude. Multiply each bracket by its exact electron weight, subtract the outer upper contributions from the middle lower contribution, and sum the three upper contributions. The exact results are
\[
\begin{aligned}
 m_{\beta\beta,\mathrm{lower}}
 &=\frac{4196984259353}{5066549580791808}\ \mathrm{eV},\\
 m_{\beta\beta,\mathrm{upper}}
 &=\frac{88426802945145}{18014398509481984}\ \mathrm{eV}.
\end{aligned}
\]
Thus the refined anchored enclosure is approximately \([0.828371299,4.908673632]\) meV. The lower endpoint is strictly positive and the upper endpoint lies below the registered effective-mass upper bound of 0.028 eV.

## 9. Complete original measured comparisons

The registered PDG mixing records retain their central values, asymmetric uncertainties and full three-standard-deviation support. The source comparison checks the exact predictions against both support endpoints:

| Quantity | Exact prediction | Registered central value | Lower / upper uncertainty | Registered three-sigma interval |
|---|---:|---:|---:|---:|
| \(\sin^2\theta_{12}\) | 1/3 | 0.308 | 0.011 / 0.012 | [0.275, 0.345] |
| \(\sin^2\theta_{23}\) | 1/2 | 0.470 | 0.013 / 0.017 | [0.435, 0.585] |
| \(\sin^2\theta_{13}\) | 1/48 | 0.02215 | 0.00058 / 0.00056 | [0.02030, 0.02388] |
| \(\delta_{\rm CP}\) | 180° | 212° | 41° / 26° | [124°, 364°] |

All four predictions lie inside these registered intervals. Exact decimal conversion supplies rational endpoints; the comparisons do not replace them by central-value equality.

The atmospheric record is \(0.002438\ \mathrm{eV}^2\), with lower uncertainty 0.000019 and upper uncertainty 0.000021. The original splitting comparison computes
\[
 \frac{0.0000749}{0.002438}=\frac{749}{24380}
 =0.030721903199\ldots,
\]
then checks the registered band
\[
 \frac{29}{1000}<\frac{749}{24380}<\frac{32}{1000}.
\]
The formal splitting translation remains exactly \(3/100\).

The heaviest upper endpoint is below the registered direct effective-electron-neutrino mass limit 0.45 eV. Since the electron weights are positive and sum to One, the weighted effective mass cannot exceed the heaviest mass: \(\sum_i w_i m_i^2\le m_3^2\). The source implements the stronger sufficient comparison of the heaviest upper endpoint to the direct limit. The mass-sum upper endpoint is below the registered Planck 2018 base-ΛCDM-plus-BAO bound 0.12 eV. The Planck row retains that cosmological model specification.

The original ordering record reports a normal-ordering preference slightly above two sigma and does not treat it as decisively measured. The source double-beta record reports no observation, a xenon half-life lower limit of \(3.8\times10^{26}\) years at 90% confidence, and an effective-mass upper-limit range 0.028–0.122 eV across the registered nuclear-matrix-element interpretations. The exact predicted enclosure lies below the stricter 0.028 eV endpoint. These are the recorded experimental outcomes; the formal Majorana and noncancellation results remain the predictions derived above.

Source custody binds the complete six-source matter/flavour record and its five byte-bound components. The neutrino classifiers obtain the PDG and Planck rows through that authoritative record, retain the protected prediction and derivation seals, and preserve the original tampered adverse controls. The native `NeutrinoComparisonMeasurement.originalClassification` and `MajoranaComparisonMeasurement.originalClassification` return the original complete outcome labels from those records.

## 10. Native proof and source correspondence

All V3 references use commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The native proof files are retained from the published V4 edition 0.4 scientific commit `21cdf559922fb057f8560f42d056ffa035329eb3`.

| Scientific component | Native declarations in `SFT.Physics` | Completion receipt |
|---|---|---|
| Squared mixing support | `PMNSSupport.sourceAssembly`, `generatedTowerCardinality`, `completeCellsReassemble` | TURN_868 |
| Unique self-antipodal phase | `CPPhase.uniqueSelfAntipodal`, `everyOtherPartExcluded` | TURN_870 |
| Complete splitting record | `NeutrinoLadder.completeSplitting`, `exactTranslation` | TURN_920 |
| Positive mass-square record | `NeutrinoLadder.completeMassSquares`, `strictPositiveOrdering` | TURN_921 |
| Physical weights and phase | `PMNSPhysical.completeSourceRecord`, `exactWeightClosure` | TURN_922 |
| Majorana discriminator | `MajoranaStructure.completeSourceRecord`, `halfOneLock` | TURN_923 |
| Noncancellation and exact loop | `NeutrinolessBounds.completeSourceResult`, `exactSourceLoop`, `everyBoundedOppositionFails` | TURN_924 |
| Anchored masses and source comparison | `NeutrinoMeasurementRoots`; `NeutrinoComparisonMeasurement.originalClassification` | TURN_928 |
| Double-beta observation comparison | `MajoranaComparisonMeasurement.predictionBounds`, `originalClassification` | TURN_929 |

These nine completed source entries comprise seven formal entries and two empirical entries. Their retained audit lists have 918 distinct declaration names after deduplicating shared definitions and proofs; every listed declaration has empty axiom dependencies. The receipts retain source-operation mappings, source digests, successful applicable builds, complete candidate/program comparisons and independent controls. The accompanying archive includes the relevant implementation, imported proof dependencies and original source/evidence records. No scientific definition is changed for this standalone exposition.

## 11. Conclusion

The generated binary and generator supports determine the splitting translation, first positive mass cell, mixing weights and self-antipodal phase. Their exact successors force positive normal mass ordering. The one-hand discriminator selects the Majorana coupling, and a strict rational opposition bound prevents complete double-beta cancellation for every held phase arrangement. One declared solar anchor translates the closed dimensionless structure to the displayed masses and amplitude interval. The original measured comparisons retain agreement with the registered mixing support and mass bounds, together with the recorded ordering and double-beta observation status.

## References

[1] Maria Smith. *Physical matter and flavour laws*, pinned V3 source. [Splitting, masses, physical PMNS, Majorana and noncancellation operations](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/matter_flavour_laws_v1.py). [Original mixing and phase predecessors](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/lineage_particle_laws.py).

[2] Maria Smith. *Post-seal matter and flavour validation*, pinned V3 source. [Complete neutrino and Majorana classifiers](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/matter_flavour_validation_v1.py). [Registered authoritative source record](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/experiments/external_sources/physics/snapshots/matter-flavour-source-record.json).

[3] Maria Smith. *Smithian Fold Theory: Zero-Axiom, Zero-Free-Parameter Derivations from First Principles - Lean 4 Formal Verification*. Edition 0.4, Sections 792–796 and 800–801. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). [Native mass and splitting construction](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/NeutrinoLadder.lean). [Native noncancellation proof](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/NeutrinolessBounds.lean).

[4] Maria Smith. *From Fold to Physics*, version 1.4.1. [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655). *Smithian Fold Theory*, original V3 cumulative monograph, recorded version 0.4.0. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[5] Maria Smith. *From Nothing to Fold*. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656). *The fine-structure constant from first principles: an exact zero-parameter Fold derivation*. [doi:10.5281/zenodo.24324400](https://doi.org/10.5281/zenodo.24324400). These sources develop the operational foundation, least generator and complete binary cover used here.

[6] Particle Data Group. *Neutrino Masses, Mixing, and Oscillations*, 2025 review. [PDG review](https://pdg.lbl.gov/2025/reviews/rpp2025-rev-neutrino-mixing.pdf). The original registered rows preserve the mixing intervals, solar and atmospheric measurements, direct-mass limit and double-beta status and limits used in Sections 8–9.

[7] Planck Collaboration. *Planck 2018 results. VI. Cosmological parameters*. [arXiv:1807.06209](https://arxiv.org/abs/1807.06209). The original registered comparison uses the base-ΛCDM-plus-BAO neutrino mass-sum bound.

[8] Maria Smith. *Independent Lean 4 Verification of the Complete Smithian Fold Theory Model*, version 1.0.1. [doi:10.5281/zenodo.21761665](https://doi.org/10.5281/zenodo.21761665).

**Authorship.** Maria Smith originated SFT and its derivations and directs the scientific work. AI assistance supports source-bound manuscript preparation, native translation and verification.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

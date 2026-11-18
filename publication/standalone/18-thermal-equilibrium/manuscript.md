# Thermal equilibrium from finite population counting

**Unique binomial and multinomial maxima, exact temperature and complementary response in Smithian Fold Theory**

Maria Smith · Ernos Labs  
18 November 2026 · Version 1.0 · DOI: 10.5281/zenodo.24335786

## Abstract

The complete paired binary census has one multiplicity maximum: equal populations and equilibrium share one half. For every generated finite level count, the dyadic population ladder is the unique multinomial maximum among all occupation vectors with the same population and total throw. We prove the latter by a strict integer-factor comparison and bind it to the original exhaustive enumeration and returned survivor record. Temperature is the exact positive mean of the retained finite throws, with total equal to population times mean. The generated ladder normalizes exactly and decreases strictly; the complementary fluctuation/response ledger and every positive repetition of its deterministic four-record cycle retain the same half-share balance. The separately sealed acoustic and Johnson-noise comparisons both contain the exact SI Boltzmann carrier within their complete registered uncertainty intervals. Full constructions, induction arguments and comparison arithmetic accompany two exhaustive 256-form classifications and 295 distinct Lean declarations with empty axiom dependencies.

## 1. Exact temperature on the retained finite population

Let \(x_1,\ldots,x_N\) be a nonempty finite list of exact positive throw records. The original `exact_temperature` operation checks positivity of every entry, retains their order and computes

\[T=\frac{S}{N},\qquad S=\sum_{j=1}^{N}x_j.\]

Finite addition preserves positivity, so \(S>0\). Since \(N\ge1\), the quotient exists and is positive. Multiplication by the same population count gives

\[NT=N\frac{S}{N}=S.\]

The proof concerns the original source operation, including its input checks and exact rational output. Its positive-validation loop returns precisely the supplied list: the empty tail retains the accumulator, and a positive head is accepted unchanged before the induction continues. Exact rational addition then gives a positive total; division by the positive count and cross-multiplication establish the identity without rounding.

`SFT.Physics.ThermalEquilibriumTemperature.originalExactMean` identifies that operation, `originalPositiveTemperature` proves successful positive output and `originalTotalThrowIdentity` proves that the source's total/mean test returns true. For the population \((1/3,1/2,2/3)\), the total is \(3/2\), the count is three and \(T=1/2\). The theorem holds for every admitted finite positive list.

The source rejects an empty population and a nonpositive throw. Empty combinatorial cells used later are structural-absence records in counting operations; they are not positive throws supplied to this mean operation.

## 2. Equal labels are the unique paired equilibrium

For positive pair count \(n\), the population is \(2n\). A row records an upper-label count \(k\) and its complete multiplicity

\[M_n(k)=\binom{2n}{k},\qquad k=0,1,\ldots,2n.\]

These rows exhaust every possible split. The original operation constructs them all, takes their maximum and returns every index attaining it. To prove its unique survivor, first split a population into \(a\) and \(b\) and use the exact factorial relation

\[\binom{a+b}{a}\,a!b!=(a+b)!.\]

The native proof establishes this factorization from the positive Pascal multiplicity recurrence, then proves that it equals the source's factorial quotient. Adjacent splits satisfy

\[(a+1)\binom{a+b+1}{a+1}
=(b+1)\binom{a+b+1}{a}.\]

If \(a<b\), then \(b+1>a+1\) and the multiplicity on the right is positive. Consequently moving one count toward balance strictly increases the multiplicity. Applying this step repeatedly gives

\[k<n\quad\Longrightarrow\quad
\binom{2n}{k}<\binom{2n}{n}.\]

Factorial symmetry gives \(\binom{2n}{k}=\binom{2n}{2n-k}\). If \(k>n\), its reflected index is below \(n\), so the same strict inequality holds. Therefore

\[0\le k\le2n,\quad k\ne n
\quad\Longrightarrow\quad M_n(k)<M_n(n).\]

`SFT.Physics.ThermalEquilibriumPaired.originalSplitMultiplicity`, `originalAdjacentMultiplicity`, `originalBelowCentral`, `originalAboveCentral` and `originalUniqueCentralMaximum` prove these steps. The source maximum fold is bounded above by the central value and includes that actual row, so its value equals \(M_n(n)\). Filtering at this value accepts exactly \(k=n\); the complete range contains that index once. `originalCensusMaximum` and `originalCensusSurvivors` bind the proof to these exact operations.

The complete original output is therefore the population \(2n\), all ordered multiplicity rows, the sole survivor \([n]\) and the share

\[\frac{n}{2n}=\frac12.\]

`originalEveryPositivePairedCensus` proves that full record for every positive \(n\). The base pair has multiplicities \(1,2,1\). Adding another pair preserves the general central-maximum result. Equilibrium is selected by the complete count, rather than by placing a preferred label at the midpoint.

## 3. The generated dyadic level ladder

For \(L\ge2\), the original Fold successor ladder is

\[t^{(L)}=(2^{L-1},2^{L-2},\ldots,2,1).\]

Its actual successor doubles every earlier count and appends one terminal record:

\[t^{(L+1)}=2t^{(L)}\mathbin{+\!+}[1].\]

This identity follows componentwise from \(2^{r+1}=2\,2^r\), with the new terminal exponent empty and its count one. `SFT.Physics.ThermalEquilibriumWeights.originalCountSuccessor` proves it for the original list-generating operation.

Let \(P_L\) be the sum of all counts. The base \(L=2\) is \((2,1)\), with sum three. Successor gives

\[P_{L+1}=2P_L+1.\]

Inductively, \(P_L+1=2^L\), and hence

\[P_L=2^L-1.\]

The population is positive because the terminal count is one. Normalizing the entire list gives

\[p_i=\frac{2^{L-i-1}}{2^L-1},\qquad
\sum_{i=0}^{L-1}p_i=1.\]

The adjacent numerator is exactly half its predecessor, while the common denominator is positive. Thus \(p_i>p_{i+1}>0\) at every adjacent pair. `originalPopulationFormula`, `originalWeightOperation`, `originalCompleteNormalization` and `originalAdjacentWeightsDecrease` establish these identities on the complete source output.

The finite successor determines every component and the normalization. The next sections show that this same generated ladder, at its own population and throw, is the unique maximum of the complete multiplicity census.

## 4. Exhaustive vectors at the same population and throw

For a natural occupation vector \(c=(c_0,\ldots,c_{L-1})\), retain

\[P(c)=\sum_{i=0}^{L-1}c_i,\qquad
E(c)=\sum_{i=0}^{L-1}i c_i.\]

The first level has empty index offset. An empty occupation coordinate is the original structural-absence count. Fix \(P=P(t)\) and \(E=E(t)\) for the dyadic target \(t=t^{(L)}\).

The original `fixed_count_throw_forms` enumerates every length-\(L\) nonnegative vector of population \(P\) in ascending first-coordinate order. With retained prefix \(u\) and remaining population \(R\), it visits \(c=0,\ldots,R\), appends \(c\) and recurses with \(R-c\). At the last cell it appends all remaining population, retaining the word if and only if its complete indexed throw equals \(E\).

The walk invariant is

\[w=u\mathbin{+\!+}v,\quad |v|=k,\quad
\sum v=R,\quad E(w)=E.\]

At one remaining cell, the only suffix is \([R]\) and the terminal throw test is exact. At a successor, the selected first count and the tail's population add back to \(R\), while the final complete-word throw test remains unchanged. This proves soundness by induction.

For completeness, the first count of any admissible suffix lies between zero and its total \(R\), so the corresponding branch is visited. Its tail has the required smaller length and remaining population. Induction places it in that branch; the complete-word throw equation accepts the terminal row. Distinct first counts cannot produce the same full word after cancellation of the retained prefix, and induction excludes duplicates within each branch.

`SFT.Physics.ThermalEquilibriumEnumeration.originalWalkSound`, `originalWalkComplete`, `originalWalkMembership` and `originalWalkUnique` prove the exact recursion facts. In particular,

\[w\in W_L\quad\Longleftrightarrow\quad
|w|=L,\ P(w)=P(t),\ E(w)=E(t).\]

`originalCompleteFixedCountThrowCensus` proves this equivalence. The target itself satisfies all three equations and therefore occurs in the census. No same-count/same-throw vector is omitted.

## 5. Strict multinomial maximality for every finite level count

The source computes the exact multinomial multiplicity

\[\mathcal M(c)=\frac{P(c)!}{\prod_i c_i!}.\]

We compare the actual factorial denominators using only finite integer products.

### 5.1 One-coordinate factorial inequality

For every positive target count \(t\) and natural competitor count \(c\),

\[t!\,t^c\le c!\,t^t.\]

If \(c\le t\), expand the factorial segment:

\[t!=c!\prod_{j=c+1}^{t}j
\le c!\,t^{t-c}.\]

Multiplication by \(t^c\) proves the claim. If \(c=t+r\) with \(r\ge1\), then

\[c!=t!\prod_{j=t+1}^{t+r}j>t!\,t^r,\]

because every new factor is strictly greater than \(t\). Multiplication by \(t^t\) gives the strict inequality. At \(c=t\) equality holds. `SFT.Physics.ThermalEquilibriumMultinomial.originalFactorialWeightBound` and `originalExcessCountStrictBound` prove the weak inequality and the strict excess case.

### 5.2 Product inequality and an unavoidable strict coordinate

For equal-length lists of positive target counts \(t_i\) and natural competitor counts \(c_i\), multiply all coordinate inequalities:

\[\left(\prod_i t_i!\right)\left(\prod_i t_i^{c_i}\right)
\le
\left(\prod_i c_i!\right)\left(\prod_i t_i^{t_i}\right).\]

Every factor is positive. If any \(c_i>t_i\), that coordinate is strict and the product inequality is strict. These are `originalProductBound` and `originalExcessProductStrict`.

Suppose \(P(c)=P(t)\) and \(c\ne t\). There must be an index with \(c_i>t_i\). Otherwise all coordinates would satisfy \(c_i\le t_i\), and at least one would be strictly smaller, forcing \(P(c)<P(t)\). The native `originalEqualPopulationAlternative` proves that equal populations give either identical lists or an excess coordinate, including every empty-cell case.

### 5.3 Fixed throw identifies the power product

For the dyadic target \(t_i=2^{L-1-i}\),

\[\left(\prod_i t_i^{c_i}\right)2^{E(c)}
=2^{\sum_i(L-1-i)c_i+\sum_i i c_i}
=2^{(L-1)P(c)}.\]

Apply the same identity to \(t\). Equal populations make the right sides equal; equal throws make the positive factor \(2^E\) equal. Cancellation gives

\[\prod_i t_i^{c_i}=\prod_i t_i^{t_i}.\]

`originalFixedCountThrowProduct` proves the complementary exponent identity, and `originalFixedCountThrowPower` proves this exact cancellation on the original generated counts.

For a different competitor with equal population and throw, Section 5.2 gives a strict product inequality. Cancel the common positive power product to obtain

\[\prod_i t_i!<\prod_i c_i!.\]

`originalDyadicDenominatorStrict` proves this for every \(L\ge2\) and every competitor satisfying the explicit three carrier conditions.

### 5.4 The actual integer operation has the strict maximum

The source implements the factorial quotient by successive integer divisions. Their exactness is proved by factorizing the multinomial into binomial multiplicities: select the first coordinate from the full population, then the next from the remainder, and continue. The factorial terms telescope. The resulting positive integer \(Q(c)\) obeys

\[Q(c)\prod_i c_i!=P(c)!.\]

Induction through the source division loop cancels one factorial at each step and returns precisely \(Q(c)\). Thus the actual `multinomial_count` operation satisfies

\[\mathcal M(c)\prod_i c_i!=P(c)!,\qquad \mathcal M(c)>0.\]

These are `originalMultinomialDenominatorIdentity` and `originalMultinomialPositive`. Since target and competitor have the same factorial numerator and the competitor has the strictly larger positive denominator,

\[c\ne t,\quad |c|=L,\quad P(c)=P(t),\quad E(c)=E(t)
\quad\Longrightarrow\quad \mathcal M(c)<\mathcal M(t).\]

`originalDyadicMultinomialStrictMaximum` proves the conclusion by contradiction from those exact integer identities. This establishes the unique dyadic maximum for every generated finite level count.

## 6. The complete selected maximum record

Every enumerated word satisfies the carrier conditions, so Section 5 bounds its multiplicity by the target's, strictly unless it is the target. The maximum fold is at most the target multiplicity and at least it because the target is present. It therefore returns the target value. Filtering all original rows at that maximum selects only the target; duplicate-free enumeration makes the survivor list exactly \([t]\).

`SFT.Physics.ThermalEquilibriumEnumeration.originalMaximumFold` and `originalSurvivorList` prove these operation-level steps. `originalEveryCanonicalMaximumCertificate` establishes the full returned record:

\[\bigl(\text{target}=t,\quad\text{forms}=|W_L|,\quad
\text{survivors}=[t],\quad\text{unique}=\mathrm{true}\bigr).\]

The form count remains the length of the complete original enumeration. The theorem does not replace that list with a singleton.

At three levels, the generated target is \((4,2,1)\), population seven and throw four. The complete ordered census is:

| Occupation word | Population | Indexed throw | Multinomial count |
|---|---:|---:|---:|
| \((3,4,0)\) | 7 | 4 | \(7!/(3!4!0!)=35\) |
| \((4,2,1)\) | 7 | 4 | \(7!/(4!2!1!)=105\) |
| \((5,0,2)\) | 7 | 4 | \(7!/(5!0!2!)=21\) |

Hence the exact certificate has three forms and sole survivor \((4,2,1)\). For the source's two-, three-, four- and five-level certificate checks, the complete enumerations contain respectively 1, 3, 16 and 206 forms. Those finite checks accompany the general proof above.

## 7. Complementary fluctuation, response and deterministic orbit

The original response ledger retains equilibrium \(e=1/2\), fluctuation \(f=3/4\) and response \(r=1/4\). Direct exact arithmetic gives

\[f+r=1,\qquad f-e=e-r=\frac14.\]

Thus the upper and lower observations are complementary and lie at equal retained departures from the same equilibrium. The complete ledger returns these three coordinates together with both equality checks. The source's thermal noise reading uses the four-record orbit

\[C=\left(\frac14,\frac12,\frac34,\frac12\right).\]

Its sum is two and its length is four. Appending one complete orbit adds two to the sum and four to the length. For every positive repetition count \(q\), induction gives

\[\sum C^{[q]}=2q,\qquad |C^{[q]}|=4q,\qquad
\operatorname{mean}(C^{[q]})=\frac{2q}{4q}=\frac12.\]

`SFT.Physics.ThermalEquilibriumNoise.originalCycleSum`, `originalCycleLength` and `originalNoiseMean` prove this for the actual list construction and source operation. The returned record keeps every orbit entry, its exact mean and period four. Fluctuation and response are readings of the same retained finite deterministic orbit.

## 8. Complete grammars and source closure

The formal source uses eight binary axes. Their preserving alternatives are exact positive mean throw; population times mean; unique binomial multiplicity maximum; normalized dyadic successor ladder; complete fixed-count/throw multinomial maximum; complementary three-quarter departure; quarter-share response; and finite periodic orbit readout. Their rejected alternatives introduce a primitive continuum coordinate, fitted total/mean coefficient, selected midpoint, continuum weighting, asserted shape, random kick, free response rate or untracked stochastic source.

The complete product contains \(2^8=256\) candidates in original axis order. For an arbitrary candidate, each binary coordinate belongs to its two-element list; nested product membership gives exhaustive inclusion. Constructor elimination establishes agreement between the direct conjunction of the eight preserving tests and the original ordered decision function, including the first-failure reason. Acceptance forces every coordinate to its preserving constructor, and that tuple passes all eight tests. Hence the survivor is unique.

`ThermalEquilibriumResponseGrammarBase`, the sixteen native census partitions and `ThermalEquilibriumResponseGrammar` retain the full ordered candidate list and proof. The four source witnesses are bound to the exact six-field certificate: temperature; paired equilibrium; canonical maximum and weights; fluctuation and deterministic noise. The certificate checks the two original positive temperature examples, pair counts one through eleven, complete canonical censuses for levels two through five, weights for levels two through nine and orbit repetitions one through nine. Native kernel proofs establish the entire certificate. The general proofs above establish the positive finite domains beyond those checks.

The source-specific closure is explicit. A positive appended throw preserves the mean construction and total identity. A further binary pair remains within the general central-maximum theorem. A level successor doubles the retained counts and appends one, preserving positivity, normalization and the full fixed-count/throw maximum argument. A complete orbit successor preserves the half-share mean.

The separate thermometry grammar has its own 256 candidates. Its eight preserving choices retain the complete carrier, sealed thermal law versus the full acoustic/electronic vector, source-bound proof trace, capability-closed prediction, separate measurement record, all registered rows, one-successor closure and no extra rule. The same complete product argument gives its exhaustive membership and unique survivor, with its original content-specific reasons. Every added measurement route, endpoint and observation row remains recorded and cannot alter the already sealed formal survivor. `SFT.Physics.ThermometryGrammar` contains these native proofs. The two entries therefore retain 512 candidate decisions.

## 9. Acoustic and Johnson-noise thermometry

### 9.1 Three primary records and two measurement routes

The original comparison binds the NIST CODATA exact SI Boltzmann record, the cylindrical acoustic-gas thermometry report by Feng and colleagues, and the electronic Johnson-noise report by Benz and colleagues. All values use the original common denominator \(D=10^{30}\) and unit joule per kelvin:

\[k_B=\frac{13806490}{D},\]
\[k_{\rm acoustic}=\frac{13806484\pm28}{D},\qquad
k_{\rm electronic}=\frac{13806510\pm170}{D}.\]

The acoustic report gives its combined result as \(1.3806484(28)\times10^{-23}\) J/K and a relative standard uncertainty of two parts per million. It explicitly relates thermodynamic temperature to average molecular kinetic energy. The electronic report gives \(1.380651(17)\times10^{-23}\) J/K from thermal-noise measurements against a Josephson-junction waveform reference. The registered record retains its twelve-parts-per-million combined uncertainty. The acoustic source writes its kinetic relation as

\[\frac12 m_{\rm atom}v_{\rm RMS}^2=\frac32 k_BT.\]

The electronic source uses the mean-square voltage relation

\[\langle V_R^2\rangle=4k_BTR\,\Delta f,\]

where \(R\) is the resistor and \(\Delta f\) the measurement bandwidth. It reports one-part-per-million accuracy for this relation below 10 MHz and above 250 K. These equations specify the two primary measurement routes retained by the comparison.

### 9.2 Exact complete uncertainty intervals

Integer subtraction and addition give

\[A=[13806456,13806512]/D,\]
\[J=[13806340,13806680]/D.\]

The inclusion checks are

\[13806456\le13806490\le13806512,\]
\[13806340\le13806490\le13806680.\]

The acoustic endpoint gaps are 34 and 22; the electronic gaps are 150 and 190. Both complete intervals contain the exact SI carrier. The source also checks positivity of both uncertainties, every endpoint, the exact carrier and denominator, together with endpoint ordering. `SFT.Physics.ThermometryAnalysis.originalAcousticBounds`, `originalElectronicBounds` and `originalBothContain` prove the original arithmetic and inclusion.

The registered vector retains two physically distinct measurement routes, the acoustic mean-kinetic-energy relation, and the electronic dependence of Johnson noise power on temperature and resistance. Its two explicit reporting fields record that these experiments do not directly measure the internal dyadic population ladder or the three-quarter/quarter coordinates as universal values. Those fields belong to the original source vector and remain beside the proved formal results and the measured interval comparisons.

### 9.3 Complete analysis and adverse control

The original `exact_thermal_analysis` returns thirteen fields: positive ordered carriers; both intervals; both exact-carrier inclusions; route count; distinct routes; kinetic-temperature relation; Johnson response relation; reported relation accuracy; both reporting fields; and complete row retention. Boolean predicates use literal identity: integer one is not substituted for true, and integer zero is not substituted for false.

The original unfavorable control changes only the acoustic center to 13000000. Its uncertainty remains 28, giving

\[A_{\rm changed}=[12999972,13000028]/D.\]

Since \(13000028<13806490\), the exact carrier is outside the interval. `originalTamperedAcousticRejected` proves rejection. The control does not change the formal temperature operation, census or response ledger.

## 10. Sealed evaluation and reproducible evidence

The formal thermal receipt precedes the registered target binding. The evaluator verifies the source-record digest, three primary-file digests, schema, exact formal receipt and complete source count. Its prediction program receives the sealed derivation identity and emits the registered label. The capability-closed interpreter fixes the output and trace before the target is released; the protected-package audit checks the program, and custody verification checks the released target against its commitment.

The evaluator then computes the complete analysis, combines its original acceptance predicates with the formal certificate fields, executes the unfavorable acoustic control and retains the complete measurement and custody record. `ThermometryRecords`, `Measurement`, `Experiment` and `Validation` reproduce the original source-bound sequence and canonical receipt. The retained native empirical comparison agrees with fresh original execution and the pinned records in every field and hash. The original analysis comparison includes the registered target and 84 numerical or Boolean-identity mutations.

The publication reproduction executes the unchanged original functions. It reproduces the six-field certificate; 32 complete paired censuses; all 226 ordered fixed-count/throw forms for levels two through five, checked against independent separator enumeration; 32 normalized ladders and their successor identities; 32 complete noise cycles; and four exact temperature populations. The full thirteen-field analysis, original acoustic control, six literal-Boolean tests, eight input/error cases and six source-file digests pass. The exact ordered forms retain every multiplicity, not only the maximum.

The source examples accompany the general native proofs. No new scientific definitions or proof criteria are introduced by this reproduction.

## 11. Native correspondence and references

Maria Smith is the scientific author of SFT and the original derivations. The V3 source is pinned to `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Native evidence is V4 edition 0.4 at `21cdf559922fb057f8560f42d056ffa035329eb3`.

The original mathematical operations and formal grammar are in `sft/physics/thermal_equilibrium_response_terminal_law_v1.py`. The source bindings and exact evaluator are in `thermal_equilibrium_empirical_v1.py` and `thermal_equilibrium_validation_v1.py`. The named native modules above identify the actual proof terms for the corresponding operations. The formal entry has 33 direct modules and completion receipt TURN1039; the thermometry entry has eight direct modules and completion receipt TURN1043, with their original timeline and retained verification records.

The two entries have 187 and 108 distinct audited declarations:

\[187+108=295.\]

All selected declarations match retained empty-axiom audit output and their applicable receipt module digests. This declaration count is separate from two completed source entries and 512 candidate decisions. Full native programs retain every candidate, decision, registration, closure and control field. The original independent validators accept the translated records and reject their retained adverse cases.

`SOURCE_CORRESPONDENCE.json` maps the source files, proof modules and exact completion evidence. `SOURCE_AND_EVIDENCE.zip` contains 431 native modules with imported proof dependencies, 18 original source files, retained checks and the portable reproduction script. The paper develops the full arguments; the archive supplies their exact source operations, proof terms and verification records.

## References

1. Maria Smith. Smithian Fold Theory V3 foundation. https://doi.org/10.5281/zenodo.21627656.
2. Maria Smith. Smithian Fold Theory V3 physics corpus. https://doi.org/10.5281/zenodo.21761655. Exhaustive monograph: https://doi.org/10.5281/zenodo.21900790.
3. Maria Smith. SFT V4 Lean verified corpus, edition 0.4. https://doi.org/10.5281/zenodo.24320778. Pinned native source: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3.
4. NIST. CODATA 2022 fundamental physical constants, Boltzmann constant. https://physics.nist.gov/cuu/Constants/Table/allascii.txt. Exact registered snapshot retained in the archive.
5. X. J. Feng et al. Determination of the Boltzmann constant with cylindrical acoustic gas thermometry: new and previous results combined. Metrologia 54, 748 (2017). https://doi.org/10.1088/1681-7575/aa7b4a.
6. S. P. Benz et al. An electronic measurement of the Boltzmann constant. Metrologia 48, 142–153 (2011). https://doi.org/10.1088/0026-1394/48/3/008.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

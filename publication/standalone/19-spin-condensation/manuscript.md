# Spin, occupation and condensation in the finite Fold model

**Complete occupation counts, a unique ground minimum and a first finite condensation crossing**

Maria Smith · Ernos Labs  
18 November 2026 · Version 1.0 · DOI: 10.5281/zenodo.24335592

## Abstract

Every positive finite preserving population has exactly one minimum-throw occupation word: the entire population in its shared ground orbit. For two or more generated levels, the exact ground share strictly increases with cold depth and reaches the retained lock share at a uniquely first finite depth. We derive an explicit finite search bound and prove that the original operation returns the complete first-crossing record, including its exact rational critical mean throw. The same exhaustive occupation walk gives \(\binom{N+L-1}{N}\) preserving words and \(\binom{L}{N}\) alternating words, with empty alternating support when \(N>L\). Every nonempty admitted occupation measure normalizes exactly. The two-label spin census has three preserving readings and one alternating reading; the alternating constituent first returns after two turns and its pair after one. These results are compared with the registered finite Bose-gas, Pauli-blocking and neutron-spinor records after sealing. Full constructions, induction arguments and comparison arithmetic accompany two complete 256-form censuses and 312 distinct Lean declarations with empty axiom dependencies.

## 1. The complete finite occupation carrier

Let \(N\ge1\) be the positive population count and \(L\ge1\) the positive generated level count. An occupation word is an ordered list

\[w=(n_0,\ldots,n_{L-1}),\qquad \sum_{i=0}^{L-1}n_i=N.\]

Each \(n_i\) is a natural count; an empty cell is the source's typed structural-absence record. The preserving exchange class admits every such word. The alternating class also requires \(n_i\le1\) for each level. The source's exchange alternatives retain either the held exchange trace or its alternating orientation; duplicate alternating occupation erases the one-cell distinction. Preserving exchange imposes no ceiling independent of the finite population.

The original `occupation_vectors` operation constructs the whole carrier. It keeps a prefix, the remaining population and the next cell index. At a nonterminal cell it visits every count

\[c=0,1,\ldots,\min(q,R),\]

in that order, appends \(c\) to the prefix and recurses with remaining population \(R-c\). At the last cell it emits the remaining population if and only if \(R\le q\). The source cap is \(q=N\) for preserving exchange and \(q=1\) for alternating exchange. Both the order of the branches and the complete emitted words are retained.

### 1.1 Soundness and completeness of the original walk

For any prefix \(u\), remaining population \(R\) and positive number \(k\) of remaining cells, every emitted word has the form \(u\mathbin{+\!+}v\), where

\[|v|=k,\qquad \sum v=R,\qquad \forall c\in v,\ c\le q.\]

At \(k=1\), the only possible suffix is \([R]\), emitted precisely when its cap test passes. Suppose the statement holds for \(k\) cells. A successor branch selects \(c\le\min(q,R)\) and obtains a suffix of length \(k\) with sum \(R-c\). Prepending \(c\) gives length \(k+1\), total \(R\) and the same cap bound. This proves soundness.

Conversely, take any suffix satisfying those three conditions. At one cell its only count equals \(R\), so the terminal test accepts it. At a successor write it as \(c::v\). Its cap gives \(c\le q\), and nonnegativity together with its total gives \(c\le R\). Hence \(c\) belongs to the enumerated interval. The tail has the required length, sum \(R-c\) and cap; the induction hypothesis places it in that branch. This proves completeness.

Different first counts belong to disjoint branches. If one emitted word occurred in two branches, cancellation of the common prefix would identify their first counts. Within a branch, induction excludes duplicate suffixes. The base contains at most one word, so the complete walk is duplicate-free. `SFT.Physics.SpinStatisticsOccupationEnumeration.originalWalkSound`, `originalWalkComplete`, `originalWalkMembership` and `originalWalkUnique` formalize these arguments for the actual recursive operation and arbitrary prefix.

For the preserving class, \(n_i\le N\) follows already from \(\sum_i n_i=N\). Thus the implementation cap \(q=N\) adds no restriction. The complete carrier is exactly the set of nonnegative length-\(L\) words summing to \(N\). For the alternating class, summing \(n_i\le1\) gives \(N\le L\). If \(N>L\), no word exists and the original output is the empty list. `SpinStatisticsOccupationBounds.originalPreservingComplete`, `originalAlternatingComplete` and `originalOverfullAlternatingEmpty` prove the exact source domains.

## 2. General occupation counts

Let \(B(N,L)\) denote the preserving count. With one level there is exactly one word, \([N]\). Partition the complete carrier by its first occupation \(c\):

\[B(N,1)=1,\qquad
B(N,L+1)=\sum_{c=0}^{N}B(N-c,L).\]

The original factorial-quotient operation satisfies Pascal's identity

\[\binom{a+b+2}{a+1}
=\binom{a+b+1}{a}+\binom{a+b+1}{a+1}.\]

Induction on the population telescopes the branch sum:

\[\sum_{c=0}^{N}\binom{N-c+L-1}{N-c}
=\binom{N+L}{N}.\]

To see the step, separate \(c=0\) and shift the remaining index. The induction hypothesis makes the tail \(\binom{N+L-1}{N-1}\), and Pascal combines it with \(\binom{N+L-1}{N}\). Induction on \(L\) now yields

\[B(N,L)=\binom{N+L-1}{N}.\]

This count is the length of the original ordered walk, not a replacement enumeration. `SFT.Physics.SpinStatisticsOccupationCounts.originalPreservingCount` proves it for an arbitrary retained prefix and cap at least the remaining population; `originalBosonCensusCount` binds it to the positive input operation.

For alternating occupation the first cell is either empty or contains one occupant. Thus

\[F(N,L+1)=F(N,L)+F(N-1,L).\]

The empty-population continuation is one all-empty word. If positive population exceeds the number of remaining cells, its continuation is empty. These are actual recursion boundaries. Starting with one occupied level and adding occupied or empty levels, Pascal's identity gives

\[F(N,L)=\begin{cases}
\binom{L}{N},&N\le L,\\
0,&N>L.
\end{cases}\]

`originalAlternatingCount` proves the admissible count; `originalEveryOccupationCensus` combines it with the overfull result and the preserving count. The original census returns both complete word lists, both actual counts, both expected counts and their equality flag. That flag is true for every positive \(N,L\).

For example, at \(N=2,L=2\), the preserving operation emits \((0,2),(1,1),(2,0)\) in that order, while the alternating operation emits only \((1,1)\). At \(N=3,L=2\), preserving exchange still admits \((3,0)\) and the other complete compositions, while alternating support is empty. Adding a preserving occupant always retains an all-ground word; no fixed finite occupation ceiling appears.

## 3. Exact dyadic measure and normalization

The source assigns the raw level weights

\[a_i=2^{L-i-1},\qquad 0\le i<L.\]

For positive cold depth \(d\), each generated word receives the complete product score

\[s_d(w)=\prod_{i=0}^{L-1}a_i^{d n_i}.\]

Every raw weight is a positive integer. Powers and their finite products are positive, so \(s_d(w)>0\) for every word. On a nonempty admitted carrier \(W\), define

\[Z_d=\sum_{w\in W}s_d(w),\qquad p_d(w)=\frac{s_d(w)}{Z_d}.\]

A positive term exists and all terms are positive, hence \(Z_d>0\). The source returns the complete ordered list of pairs \((w,p_d(w))\). It neither drops a generated word nor adds a new one. Summing the common-denominator fractions gives

\[\sum_{w\in W}p_d(w)
=\frac{\sum_{w\in W}s_d(w)}{Z_d}=1.\]

`SFT.Physics.SpinStatisticsOccupationWeights.originalScorePositive`, `originalTotalPositive`, `originalWeightAssembly` and `originalEveryAdmittedMeasureNormalizes` prove the positivity, exact source output and normalization. In the overfull alternating case the source returns an empty weight list; its mean operation rejects the empty carrier. The normalization theorem has the actual nonempty-carrier hypothesis.

The total indexed throw of a word and its canonical mean per occupant are

\[M_1(w)=\sum_{i=0}^{L-1}(i+1)n_i,\]
\[\mu_d=\sum_{w\in W}p_d(w)\frac{M_1(w)}{N}.\]

These are finite sums of exact rational quantities on the same complete measure. No continuum occupation distribution enters their construction. The positive population permits each division by \(N\). The original output records preserve the exact reduced fractions.

## 4. The unique minimum-throw ground word

Define the nonnegative excited offset

\[e(w)=\sum_{i=0}^{L-1}i n_i.\]

Since \(\sum_i n_i=N\),

\[M_1(w)=N+e(w)\ge N.\]

The generated word \(g=(N,0,\ldots,0)\) has \(e(g)=0\), so \(M_1(g)=N\). Conversely, if \(M_1(w)=N\), then \(e(w)=0\). Every contribution \(i n_i\) with \(i\ge1\) is nonnegative and can vanish in that sum only with \(n_i=0\). The population equation then forces \(n_0=N\). Therefore

\[M_1(w)=N\quad\Longleftrightarrow\quad w=g,\]

and every generated \(w\ne g\) has \(M_1(w)>N\).

The native argument also establishes this directly through indexed moments. Shifting every index up by one adds exactly the occupation sum. If the first-indexed moment equals that sum, the tail's first-indexed moment is empty; its occupation sum is bounded by that moment and is therefore empty too. Induction makes every tail cell empty. `SFT.Physics.SpinStatisticsGroundMinimum.originalMinimumWord`, `originalGroundAttains`, `originalGroundGenerated` and `originalExcitedThrowStrict` give the equality case, attainment, source membership and strict alternative.

The source then computes the entire energy list, folds its minimum and filters that same list at the minimum. Ground membership ensures the minimum is at most \(N\); the lower bound makes it at least \(N\). The equality characterization accepts only \(g\), and duplicate-free enumeration ensures it occurs once. Consequently the complete original three-field certificate is

\[\bigl(\text{least}=N,\quad\text{survivors}=[g],\quad\text{unique}=\mathrm{true}\bigr).\]

`SpinStatisticsGroundRecord.originalMinimumFold`, `originalGroundSurvivorList` and `originalEveryGroundCertificate` prove this exact record for all positive \(N,L\), including \(L=1\).

## 5. Cold-depth ordering from the complete score

For the preserving carrier with \(L\ge2\), expand the dyadic exponent:

\[s_d(w)=2^{d\sum_i(L-1-i)n_i}.\]

Adding the excited offset to its complementary exponent gives

\[\sum_i(L-1-i)n_i+e(w)=(L-1)N.\]

Hence the exact integer identity is

\[s_d(w)\,2^{d e(w)}=2^{d(L-1)N}=s_d(g).\]

`SFT.Physics.SpinStatisticsColdScores.originalColdComplement` reuses the original fixed-count/throw product identity and raises it to cold depth \(d\). `originalGroundScore` computes the ground score; `originalRelativeColdScore` combines them. The relative score is therefore the exact reciprocal

\[\frac{s_d(w)}{s_d(g)}=\frac{1}{2^{d e(w)}}.\]

For every excited word, the unique-minimum proof gives \(e(w)\ge1\). Its successor penalty obeys

\[2^{(d+1)e(w)}=2^{e(w)}2^{d e(w)},\qquad 2^{e(w)}\ge2.\]

Thus every additional cold step reduces each excited score relative to ground by at least a factor of two. `originalColdPenaltySuccessor` and `originalExcitedCoolingFactor` prove these identities and inequalities for the actual generated words.

### 5.1 Strict increase of the normalized ground share

Put \(G_d=s_d(g)\). The score successor law is

\[s_{d+1}(w)=s_d(w)s_1(w).\]

For excited \(w\), its base score is strictly below the ground base score. Positivity therefore gives

\[s_{d+1}(w)G_d<s_d(w)G_{d+1}.\]

The ground word gives equality in this comparison. At least one excited word exists for \(N\ge1,L\ge2\): \((N-1,1,0,\ldots,0)\). It has the correct population and length and differs from \(g\). Summing over the complete carrier, with this strict term and all other terms weakly ordered, yields

\[Z_{d+1}G_d<Z_dG_{d+1}.\]

Both denominators are positive, so

\[\frac{G_d}{Z_d}<\frac{G_{d+1}}{Z_{d+1}}.\]

`SFT.Physics.SpinStatisticsColdGrowth.originalExcitedWordGenerated` supplies the explicit strict witness. `originalGroundShareCrossStrict` proves the sum inequality, and `originalEveryGroundShareIncreases` binds it to the source's exact rational `ground_share` operation at every positive depth. The normalized ground share strictly increases throughout the accepted condensation domain.

## 6. Finite crossing of the retained lock share

Let the retained Fold factor be \(m\ge2\), with lock share

\[\theta_m=\frac{m-1}{m}.\]

This factor is an input of the source operation; the threshold uses the admitted Fold relation. Let \(K=|W|-1\) be the number of excited competitors. Every excited word obeys

\[s_d(w)2^d\le G_d.\]

Separate the single ground contribution from the complete duplicate-free sum. Adding all competitor bounds gives

\[Z_d2^d\le G_d2^d+KG_d.\]

Choose the source's least positive cover depth \(b\) satisfying

\[2^b\ge\max(1,K(m-1)).\]

The existing positive-cover construction `AlphaCovers.coverDepth` supplies this finite \(b\) and proves its cover property. Multiply the score bound by \(m-1\) and use \(K(m-1)\le2^b\):

\[(m-1)Z_b2^b
\le(m-1)G_b2^b+(m-1)KG_b
\le mG_b2^b.\]

Cancel the positive factor \(2^b\) and divide by the positive \(mZ_b\):

\[(m-1)Z_b\le mG_b,\qquad
\frac{G_b}{Z_b}\ge\frac{m-1}{m}.\]

`SFT.Physics.SpinStatisticsColdBound.originalCompetingScoreBound` proves the full-census bound; `originalFiniteLockBound` performs this multiplication and cancellation. `originalSearchBoundCovers` identifies the actual cover returned by the source's search-bound construction. `SpinStatisticsColdThreshold.originalSufficientDepthPasses` establishes that the actual normalized rational comparison passes at that depth.

### 6.1 Termination and first-crossing selection of the actual search

The original search examines \(1,2,\ldots,b+1\) in increasing order. At each depth it computes both the ground share and the canonical mean, appends their full row and returns on the first share at least \(\theta_m\). Each operation succeeds on the positive preserving carrier. Depth \(b\) lies in the searched list and passes, so the search must return.

This can be proved directly by induction on the supplied depth list. If its head passes, the operation returns its complete record. If the head fails, remove it: a passing depth still exists in the tail, because the head cannot be that witness. The induction hypothesis gives a returned record for the tail. `SFT.Physics.SpinStatisticsCriticalExecution.originalFirstCrossingReturns` proves this recursion theorem, and `originalEveryCriticalCertificateReturns` applies it to the source's positive search list and finite bound.

For minimality, maintain the invariant that every retained prior row is below threshold. It is vacuous before the first test. A rejected head is appended only after its exact comparison is below threshold, preserving the invariant. When a head passes, all previous depths fail and the selected depth passes. Hence the returned depth \(d_*\) is the unique first crossing. Strict ground-share growth further preserves acceptance at every later depth. `SpinStatisticsCriticalSelection.originalSelectedCertificate` and `originalEveryCriticalFirstCrossing` prove the selection on the actual recursion, including its exact source operation results.

The ten returned fields are population, level count, factor, lock share, critical depth, critical mean throw, ground share, prior-below flag, tested rows and minimum-throw ground word. In particular,

\[\mu_{d_*}=\sum_{w\in W}\frac{s_{d_*}(w)}{Z_{d_*}}
\frac{\sum_i(i+1)n_i}{N}\]

is the exact critical-temperature carrier of this source operation. The complete record retains both its value and every tested predecessor row.

### 6.2 Exact two-level example

For \(N=2,L=2\), the source-ordered words \((0,2),(1,1),(2,0)\) have raw scores \(1,2^d,4^d\). With \(m=3\), the threshold is \(2/3\). At depth one,

\[p_1(g)=\frac47<\frac23,\qquad
\mu_1=\frac17\,2+\frac27\,\frac32+\frac47\,1=\frac97.\]

At depth two,

\[p_2(g)=\frac{16}{21}>\frac23,\qquad
\mu_2=\frac1{21}\,2+\frac4{21}\,\frac32+\frac{16}{21}\,1=\frac87.\]

Thus \(d_*=2\), the prior-below flag is true and the retained tested rows are \((1,4/7,9/7)\) and \((2,16/21,8/7)\). The minimum-throw word is \((2,0)\). This is the full original computation within the general proof above.

## 7. Spin composition and typed return

The original two-label spin census keeps the equal-label readings lower–lower and upper–upper, together with the mixed preserving and mixed alternating readings. Its complete output is:

| Exchange class | Retained readings | Count | Share |
|---|---|---:|---:|
| Preserving | lower–lower; mixed-preserving; upper–upper | 3 | \(3/4\) |
| Alternating | mixed-alternating | 1 | \(1/4\) |

The two equal-label readings preserve the label pair. The mixed readings retain their distinct exchange organizations. The four recorded readings give total four and the exact shares shown. These are the original `exchange_spin_census` outputs.

The alternating constituent's typed orbit is lower, upper, lower. The first turn changes the held label, so it is not a return; the second restores it. The paired orbit is paired, paired: two alternating changes compose to preserving exchange and the pair returns after one complete turn. The original `spin_return_certificate` retains both full orbits, both first-return counts and the pairing result. It uses held labels to represent the return, with no angular or signed phase magnitude in the formal orbit. The measurement comparison below supplies the separately registered angular correspondence.

`SFT.Physics.SpinStatisticsCondensation` implements the two exact record operations. `SpinStatisticsCertificateProof.originalCertificate` includes the complete four-reading count and alternating first-return result alongside the occupation, normalization and cold certificates. The general occupation and condensation proofs in Sections 1–6 establish their full positive finite domains.

## 8. Exhaustive law and comparison grammars

The formal source's candidate grammar is the complete product of eight binary axes. Its preserving choices retain: the preserving/alternating held exchange trace; one-cell distinction exclusion; every positive finite preserving multiplicity; the complete exact dyadic occupation census; typed one-turn/two-turn return; preserving composition of an alternating pair; the first exact crossing of \((m-1)/m\); and the unique minimum-throw shared ground word.

The corresponding alternatives select a species name, an occupation cap, a finite ceiling, a continuum distribution, an imaginary/signed phase, an independent boson postulate, a measured/fitted onset, or an asserted ground mode. Each alternative fails its particular source obligation. The complete nested product has \(2^8=256\) candidates, enumerated in the original axis order. For an arbitrary candidate, case analysis places each coordinate in its two-element axis; nested product membership then proves that the candidate occurs in the enumeration. This proves completeness for all constructors.

Writing \(b_i\) for the preserving test at axis \(i\), the source decision is

\[\operatorname{accept}(c)\quad\Longleftrightarrow\quad
\bigwedge_{i=1}^{8} b_i(c).\]

Exhaustive coordinate cases establish agreement between this conjunction and the original ordered decision function, including its first-failure reason. If accepted, all eight coordinates equal their preserving constructors, so the candidate equals the all-preserving tuple. That tuple passes every test. Thus there is exactly one survivor. `SpinStatisticsCondensationGrammarBase`, the sixteen complete census partitions and `SpinStatisticsCondensationGrammar` retain all identifiers, exact forms and reasons in source order.

The formal closure proceeds through the actual recursions already proved: adding a level extends the full occupation walk and its Pascal counts; adding a preserving occupant retains the all-ground word; increasing cold depth imposes the complete competitor penalty and reaches the finite lock bound. The source's four operational witnesses bind to the complete occupation, weight, spin and cold certificate fields. The certificate's finite checks cover counts for \(N,L=1,\ldots,6\), normalized measures on both classes for \(L=2,\ldots,5\), \(N=1,\ldots,L\), \(d=1,\ldots,4\), and crossing/minimum records for \(m,L=2,\ldots,5\), \(N=2,\ldots,6\). Each field is proved by native kernel reduction, in addition to the general induction results.

The separately registered comparison grammar also contains 256 candidates. Its eight axes retain the complete carrier, sealed law versus complete measured vector, source-bound proof trace, capability-closed prediction, separate measurement record, complete registered rows, one-successor closure and no extra rule. Its membership and unique-survivor proofs use the same complete product reasoning while retaining its own content and first-failure decisions. Adding a registered comparison row preserves its exact source and custody binding and cannot change the sealed formal survivor. `SFT.Physics.SpinCondensationGrammar` proves the full classification. The two source entries therefore account for 512 candidate decisions.

## 9. Three registered physical comparisons

### 9.1 Finite Bose-gas ground occupation

Ensher and colleagues measure the ground-state occupation of a dilute rubidium-87 gas as temperature changes. The registered source retains measured ground occupation, its increase during cooling, the sharp transition, finite population and the reported finite-number correction. Its transition ratio to the paper's independently specified trap scale is \((94\pm5)/100\). The complete interval is

\[\left[\frac{94-5}{100},\frac{94+5}{100}\right]
=\left[\frac{89}{100},\frac{99}{100}\right].\]

The exact interval check is \(89\le99<101\). The reported three-percent finite-number correction is retained as a separate row. The observed accumulation under cooling is the registered comparison to the increasing formal ground share. The ratio and correction retain their original trap and population definitions.

### 9.2 Pauli blocking

The DeMarco, Papp and Jin record reports direct Pauli blocking in a two-spin-state potassium-40 gas, including a factor-two reduction in effective collision cross section. The registered vector retains direct blocking, spin-state count two and the reported response factor two. These rows test the exclusion distinction on the stated experimental carrier. The measured collision response remains attached to that apparatus and observation record.

### 9.3 Neutron spinor return

Rauch and colleagues report the neutron-interferometry return angle \(704\pm38\) degrees. The complete registered interval is

\[[704-38,704+38]=[666,742].\]

The sealed alternating return corresponds to two complete turns:

\[720=2\times360,\qquad 666\le720\le742.\]

The source also retains the one-turn change of orientation and identical-state restoration after two turns. The scan's final page reports the measured center and uncertainty and distinguishes the one-turn and two-turn behavior. The exact interval contains the sealed return correspondence.

### 9.4 Full analysis and adverse controls

The original `exact_spin_statistics_analysis` returns fifteen fields: positive exact carriers; both complete intervals; ordered Bose interval; finite population; measured ground occupation; cooling direction; observed transition; observed Pauli blocking; two spin states; retained response factor; containment of the spinor return; one-turn change; two-turn restoration; and complete row retention. Thirteen are acceptance predicates and two are interval records.

Positivity checks both interval endpoints, both uncertainties, the Bose denominator, finite-population correction, spin-state count, collision factor and forced return. Boolean fields require the literal true value. The native `SFT.Physics.SpinCondensationAnalysis.originalCompleteTargetAnalysis` proves the entire fifteen-field result by kernel equality.

Both original adverse controls are applied. Changing the spinor center to 600 produces \([562,638]\), which excludes 720. Reversing the cooling-direction flag fails that predicate. Neither altered record changes the formal operation. `originalTamperedSpinorRejected` establishes the altered-interval failure; the complete empirical execution retains both rejected controls.

## 10. Sealing, source identity and reproducibility

The original law receipt and derivation seal are fixed before the three-source measurement vector is bound. The comparison first verifies the full record hash and all three primary-file hashes, the schema, the exact formal receipt binding and the complete source count. Its prediction program consumes the sealed derivation identity and emits the registered observation label. A capability-closed interpreter fixes the output and trace; prediction sealing precedes target release. The protected-package audit verifies the unchanged program, and custody verification binds the released target to its original commitment.

The evaluator then computes the full analysis, checks all thirteen empirical predicates, reuses all four formal certificate fields and executes both adverse controls. Acceptance is their conjunction. The returned record keeps the registration, prediction, isolation and custody identities, all seven measurement messages, all three source identifiers, exact analysis and canonical receipt. `SpinCondensationMeasurement`, `Records`, `Experiment` and `Validation` preserve this complete original pipeline. The retained TURN1049 empirical report records equality of every field and hash against fresh original package execution and the pinned source record.

For the present portable reproduction, the unchanged original function bodies reproduce the four-field certificate, 36 complete ordered occupation censuses, 112 exact normalized measures and 80 complete first-crossing records. Independent Cartesian enumeration verifies the actual word ordering and contents for the tested censuses. Every minimum record has the exact sole ground survivor; every selected crossing retains only below-threshold prior rows. The complete fifteen-field measurement analysis, both original adverse controls and literal-Boolean behavior reproduce exactly. The record and three primary snapshots match their registered hashes. Seven original input/error cases are retained, including invalid positive counts, exchange class, condensation domain and the undefined mean of an empty alternating carrier.

The original retained native comparison additionally covers 1,064 direct source operation evaluations and the complete source certificate. The formal and empirical programs each match all 256 candidate decisions, trace/proof hashes, registration, closure, controls and unknown-identifier behavior. The original independent validators accept the translated outputs and reject their three programme-level adverse cases. These results are retained under TURN1043–1049, with completion receipts TURN1048 and TURN1049.

## 11. Source and proof references

Maria Smith is the scientific author of SFT and the original derivations. V3 is pinned to `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`; the native evidence is V4 edition 0.4 at `21cdf559922fb057f8560f42d056ffa035329eb3`.

The formal operations and grammar are in `sft/physics/spin_statistics_condensation_terminal_law_v1.py`. The source bindings and complete evaluator are in `spin_statistics_condensation_empirical_v1.py` and `spin_statistics_condensation_validation_v1.py`. Their original execution bindings, registration documents and precise source records accompany the release. Sections 1–8 correspond to the 39 formal entry modules; Sections 9–10 correspond to the eight comparison modules. The named native declarations identify the actual proof bodies for each construction and argument.

The two completed entries have 202 and 110 distinct audited declarations, respectively:

\[202+110=312.\]

All selected declarations match retained empty-axiom audit output, and the applicable receipt module digests match the archived proof source. This count is separate from two completed source entries and 512 candidate decisions. `SOURCE_CORRESPONDENCE.json` records the source identities, native modules and completion receipts. `SOURCE_AND_EVIDENCE.zip` includes 443 native modules with the full selected proof dependency closure, 18 original source files, retained verification and a portable exact reproduction script. The mathematics is developed in the paper; the archive supplies its exact operations and native proof terms.

## References

1. Maria Smith. Smithian Fold Theory V3 foundation. https://doi.org/10.5281/zenodo.21627656.
2. Maria Smith. Smithian Fold Theory V3 physics corpus. https://doi.org/10.5281/zenodo.21761655. Exhaustive monograph: https://doi.org/10.5281/zenodo.21900790.
3. Maria Smith. SFT V4 Lean verified corpus, edition 0.4. https://doi.org/10.5281/zenodo.24320778. Pinned native source: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3.
4. J. R. Ensher, D. S. Jin, M. R. Matthews, C. E. Wieman and E. A. Cornell. Bose-Einstein Condensation in a Dilute Gas: Measurement of Energy and Ground-State Occupation. Physical Review Letters 77, 4984–4987 (1996). https://doi.org/10.1103/PhysRevLett.77.4984.
5. B. L. DeMarco, S. Papp and D. S. Jin. Pauli Blocking of Collisions in a Quantum Degenerate Atomic Fermi Gas (2001). NIST primary publication record: https://www.nist.gov/publications/pauli-blocking-collisions-quantum-degenerate-atomic-fermi-gas-0.
6. H. Rauch, A. Zeilinger, G. Badurek, A. Wilfing, W. Bauspiess and U. Bonse. Verification of Coherent Spinor Rotation of Fermions. Physics Letters A 54, 425–427 (1975). https://doi.org/10.1016/0375-9601(75)90798-7.

# Crystallographic restriction and aperiodic substitution in SFT

Maria Smith · Ernos Labs

Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com) · SFT Discord: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

The SFT periodic rotation carrier admits exactly the positive orders 1, 2, 3, 4 and 6. The native proof quantifies over every positive order, derives the prime-factor degree restriction and closes the classification by strong induction. The rank-three metric grammar retains seven crystal systems from twelve forms, and its system–centering quotient retains fourteen distinct Bravais classes from thirty-five forms. Reciprocal support is characterized exactly by return of every generated probe path; coherent merging retains the complete positive support at every finite depth. The aperiodic population substitution \((a,b)\mapsto(a+b,a)\) has an exact successor history at every positive depth, while no coprime positive integers satisfy its rational fixed-scale equation \(p^2=pq+q^2\). We give the derivations, full classification tables, quantified recurrence and translation statements, and their pinned V3 and native Lean correspondences. Six completed source entries retain 56 entry modules and 902 distinct empty-axiom audited definitions and theorems, with complete source-programme and registered observation records.

## 1. Unrestricted periodic rotation classification

Let \(n\) be any positive whole order. The original source constructs its distinct prime support by increasing trial division, stripping each discovered prime completely before continuing. It then retains exactly the positive residue labels through \(n\) that are divisible by none of those primes. Define

\[
R(n)=\{k:1\leq k\leq n,\ \gcd(k,n)=1\},\qquad d(n)=|R(n)|.
\]

The source rank-two integral rotation boundary is

\[
\operatorname{Admitted}(n)\iff d(n)\leq2.
\]

The complete result is

\[
\boxed{\operatorname{Admitted}(n)\iff n\in\{1,2,3,4,6\}}
\qquad(n\in\mathbb N_{>0}).
\]

This is `RotationClassification.exactClassification`. The source functions are `totient_count`, `crystallographic_rotation_admitted` and `allowed_crystallographic_orders` in `sft/materials/structural_counts.py` [1]. The native source does not merely evaluate the five proposed survivors. It proves factor primality, complete prime support, exact coprime residue membership, degree multiplication and unrestricted classification [2,3].

For a prime \(p\), the residues modulo \(p\) are precisely \(1,\ldots,p-1\), giving \(d(p)=p-1\). The degree multiplication rules are

\[
d(pn)=
\begin{cases}
p\,d(n),&p\mid n,\\
(p-1)d(n),&p\nmid n.
\end{cases}
\]

To obtain the first rule, divide the positive interval through \(pn\) into \(p\) blocks of length \(n\). Each block has \(d(n)\) labels coprime to \(n\). When \(p\mid n\), those labels already exclude multiples of \(p\); all \(p\) copies survive. When \(p\nmid n\), every retained residue class modulo \(n\) has exactly one multiple of \(p\) among its \(p\) lifts. Removing that copy leaves \(p-1\) per class. The native proofs `RotationDegreeProduct.repeatedPrimeDegree` and `RotationDegreeFresh.freshPrimeDegree` establish these exact counts from complete residue membership and unique enumerations.

Induction through prime removal therefore gives

\[
p\mid n\quad\Longrightarrow\quad p-1\mid d(n).
\]

Since \(d(n)>0\), admission forces \(p-1\leq2\), hence every prime divisor of an admitted order is either two or three. Removing a prime factor never increases the degree: both multipliers above are positive whole numbers. Thus the quotient order remains admitted.

Now use strong induction on \(n\). Order one is admitted. If \(n>1\), choose a prime divisor \(p\), put \(m=n/p<n\), and apply the induction hypothesis to \(m\). Then \(m\in\{1,2,3,4,6\}\) and \(p\in\{2,3\}\). The complete products are

\[
2\{1,2,3,4,6\}=\{2,4,6,8,12\},\qquad
3\{1,2,3,4,6\}=\{3,6,9,12,18\}.
\]

The extra orders have degrees

\[
d(8)=4,\quad d(9)=6,\quad d(12)=4,\quad d(18)=6,
\]

and are rejected. Conversely, the five retained orders have degrees \(1,1,2,2,2\), respectively, proving both directions. No upper bound on \(n\) appears in this argument or theorem.

The equivalent source factor certificate is

\[
n=2^a3^b,\qquad a\leq2,\quad b\leq1,
\quad\neg(a=2\land b=1).
\]

The six pairs in \(\{0,1,2\}\times\{0,1\}\) produce \(1,3,2,6,4,12\); excluding the final pair leaves exactly the five admitted orders. `RotationClosure.factorCertificateIff` proves the equivalence. Its `fiveExcluded` and `allBeforeFiveAdmitted` establish that five is the least excluded positive order.

## 2. Complete rank-three metric grammar

The source metric carrier records axis-length equality and angle equality in categorical form. The length classes are all equal, two equal and all distinct; the angle classes are all right, two right, all equal nonright and all distinct. Their product has exactly

\[
|L\times A|=3\cdot4=12
\]

forms. The source compatibility operation `_system_name` supplies the following complete quotient table. A dash is a rejected combination in this original grammar.

| Length class | All right | Two right | All equal nonright | All distinct |
|---|---|---|---|---|
| All equal | Cubic | — | Trigonal | — |
| Two equal | Tetragonal | Hexagonal | — | — |
| All distinct | Orthorhombic | Monoclinic | — | Triclinic |

The row totals are two, two and three, so seven distinct system names survive. The five rejected forms are explicitly

\[
\begin{aligned}
&(\text{all equal},\text{two right}),\quad
(\text{all equal},\text{all distinct}),\\
&(\text{two equal},\text{all equal nonright}),\quad
(\text{two equal},\text{all distinct}),\\
&(\text{all distinct},\text{all equal nonright}).
\end{aligned}
\]

For every proposed row \((s,l,a)\), the native membership theorem states

\[
(s,l,a)\in\mathrm{retained}
\iff l\in L\ \land\ a\in A\ \land\ \mathrm{systemName}(l,a)=s.
\]

The proof follows the exact product enumeration and the optional lookup result. A successful lookup originates in a specific compatible source row; an unmatched lookup yields no result. This establishes both completeness and source identity, while the guards check seven survivors and seven distinct names. The native declarations are `CrystalSystems.exactRetained`, `sevenSystems`, `distinctNames`, and `CrystalSystemsProofs.retainedExactly`, `everyReturnedClassSourceBound`, `exactRejections` and `completePartitionCount`.

The enumeration order is cubic, trigonal, tetragonal, hexagonal, orthorhombic, monoclinic, triclinic. This is the product's original order, and is retained in the source and native outputs.

## 3. Fourteen Bravais classes from thirty-five forms

For each of the seven systems, the centering grammar supplies five alternatives: primitive, base, body, face and rhombohedral. The source `_centering_preserves_system` retains the canonical system–centering rows below, representing its basis and centering quotient.

| System | Retained centerings | Count |
|---|---|---:|
| Triclinic | Primitive | 1 |
| Monoclinic | Primitive, base | 2 |
| Orthorhombic | Primitive, base, body, face | 4 |
| Tetragonal | Primitive, body | 2 |
| Trigonal | Rhombohedral | 1 |
| Hexagonal | Primitive | 1 |
| Cubic | Primitive, body, face | 3 |

Thus

\[
7\cdot5=35,\qquad 1+2+4+2+1+1+3=14,\qquad35-14=21.
\]

Enumeration traverses every system and every centering, applies the original canonical lookup, and retains exactly the compatible rows in source order. Completeness follows from the product carrier; uniqueness follows from the distinct system names and distinct centering alternatives. `BravaisClasses.sourceOrderExact` gives the complete returned list. `fourteenDistinct` proves its length and uniqueness, and `BravaisProofs.completePartition` records all fourteen retained and twenty-one rejected forms. `lookupSourceRow` identifies the actual original canonical row for every successful lookup; `lookupUnknownKey` preserves the source error for an unknown system.

This count is therefore accompanied by its full carrier, every retention decision and the complete partition. The source tables are presented explicitly so the classification operation can be reproduced without importing an external count.

## 4. Reciprocal support is complete path return

A probe consists of a source event, an arrival event at each generated site, a path connecting each pair, and a strictly positive exact support magnitude at each site. Let \(c_0\) be the source phase carrier and \(c_s\) the arrival carrier at site \(s\). Define

\[
\mathrm{returnsAt}(p,s)\iff c_s=c_0,
\qquad
\mathrm{completeReturn}(p,S)\iff\forall s\in S,\ c_s=c_0.
\]

For a finite declared probe carrier \(P\), the exact reciprocal class is

\[
P^*(S)=\{p\in P:\mathrm{completeReturn}(p,S)\}.
\]

`ReciprocalSupport.returnTestExactly` proves by induction on the complete site list that the executable return test succeeds exactly when every site returns. The empty list passes. On a successor list, the head phase must agree and the tail test must pass. Consequently,

\[
p\in P^*(S)\iff p\in P\land\forall s\in S,\ c_s=c_0.
\]

A single present nonreturning site excludes the probe. Adding a site preserves membership precisely when the old complete-return condition and the new site's return both hold:

\[
\mathrm{completeReturn}(p,S\mathbin{+\!+}[s])
\iff\mathrm{completeReturn}(p,S)\land\mathrm{returnsAt}(p,s).
\]

The path record is equally complete: it retains one site-labelled transition trace per site, and appending a site appends its trace without changing any predecessor trace.

Let \(w_s>0\) be the exact support magnitude and \(o\) the phase-to-orientation map. The source interference operation merges matching orientations by adding their magnitudes. Under complete return, every arrival has orientation \(o(c_0)\). Induction therefore gives, for nonempty \(S\),

\[
\mathrm{mergedObservation}(p,S)
=\mathrm{positive}\!\left(o(c_0),\sum_{s\in S}w_s\right)
\ne\mathrm{EmptyOne}.
\]

The base case retains the single positive support. At each successor, equal phase fixes the orientation, and the original matching-label interference law adds the next positive magnitude. This is `completeCoherentMerge`, followed by `coherentPeakPresent`. The result retains the full support and predecessor paths, rather than only a successful probe label.

## 5. Coherent recurrence and absence of a translation period

The aperiodic material organization supplies a site at each generated index. At depth \(n\), its finite carrier is

\[
S_n=[s_0,s_1,\ldots,s_n],\qquad|S_n|=n+1,
\qquad S_{n+1}=S_n\mathbin{+\!+}[s_{n+1}].
\]

It also supplies a material word at each site and a network whose nodes are exactly \(S_n\). Coherent recurrence is complete return at every generated depth. The native theorem proves

\[
\bigl(\forall n,\ \mathrm{completeReturn}(p,S_n)\bigr)
\iff\bigl(\forall n,\ \mathrm{returnsAt}(p,s_n)\bigr).
\]

For the forward implication, use the held final site at its own depth. For the reverse implication, start with \(s_0\), then apply the successor return equivalence at each appended site.

A `TranslationPeriod` contains one held shift acting at every finite depth, an original lattice translation record on each corresponding graph, and equality of the material words and shift actions with the organization. Nontriviality requires a held site moved by the shift. These records preserve every local word and every adjacency under every finite repeated translation; the native proofs reuse `Lattice.everyLocalWordRecurs` and `Lattice.everyAdjacencyRecurs`.

For such a material family \(O\), the source characterization is

\[
\mathrm{quasicrystalline}(O)
\iff
\left(\forall n,\ \mathrm{returnsAt}(p,s_n)\right)
\land
\left(\forall T:\mathrm{TranslationPeriod}(O),\ \bot\right).
\]

This states the exact supplied carrier and the two required properties: coherent recurrence and no nontrivial depth-compatible translation record. `QuasicrystallineOrder.sourceCharacterization` proves both directions. For every family satisfying this statement, `quasicrystalHasCoherentPeaks` gives a nonempty coherent observation at every depth; `exactMergedSupportEveryDepth` gives its complete positive magnitude, and `successorPreservesPaths` retains all paths. The periodic restriction from Section 1 remains exact: order five is excluded from periodic closure. It is not imposed as a replacement restriction on the aperiodic carrier.

## 6. Positive substitution and rational fixed-scale exclusion

The original substitution is \(A\mapsto AB\), \(B\mapsto A\). If \(a_n\) and \(b_n\) count the two labels, each \(A\) contributes one to both next counts, while each \(B\) contributes one next \(A\). Therefore

\[
(a_0,b_0)=(1,1),\qquad
(a_{n+1},b_{n+1})=(a_n+b_n,a_n).
\]

Positive initial counts and positive addition preserve the admitted domain at every successor. The first six retained rows are

\[
(1,1),\ (2,1),\ (3,2),\ (5,3),\ (8,5),\ (13,8).
\]

A requested positive depth \(D\) returns the initial row and its first \(D-1\) successors. The history recurrence is

\[
H_0=[(1,1)],\qquad H_{n+1}=H_n\mathbin{+\!+}[(a_{n+1},b_{n+1})].
\]

Induction yields \(|H_n|=n+1\), so the original operation returns exactly \(D\) rows for every positive \(D\). These are `QuasicrystalInflation.successorEquation`, `historyCount` and `originalDepthCount`; `originalSixSuccessors` proves the displayed witness exactly.

For the exact ratio \(r_n=a_n/b_n\),

\[
r_{n+1}=1+\frac1{r_n}.
\]

A positive rational fixed scale \(r=p/q\), expressed with coprime positive whole \(p,q\), would satisfy

\[
\frac pq=1+\frac qp
\quad\Longrightarrow\quad p^2=pq+q^2.
\]

The equation gives \(q\mid p^2\). If \(q>1\), choose a prime divisor \(\ell\mid q\). Then \(\ell\mid p^2\), so primality gives \(\ell\mid p\), contradicting \(\gcd(p,q)=1\). Hence \(q=1\). The same equation gives \(p\mid q^2\), so \(p\mid1\), forcing \(p=1\). Substitution now requires \(1=1+1\), a contradiction. Thus

\[
\boxed{\forall p,q>0,\quad\gcd(p,q)=1
\ \Longrightarrow\ p^2\ne pq+q^2.}
\]

`QuasicrystalInflation.rationalFixedScaleExcluded` contains this prime-divisor and coprimality proof. The source certificate records the recurrence, equation, divisibility argument, rejected least candidate and structural absence of a positive rational fixed scale. The argument uses no evaluated irrational limit; the exact finite successors and universal rational exclusion are the established source results.

## 7. Exhaustive source grammar and evidence

Each of the six entries also carries its original eight-coordinate binary source grammar: carrier, relation, organization, observation, record, provenance, generality and extension. For inflation, the admitted coordinates retain the two labels, the actual substitution, finite-word provenance, the positive successor and rational-exclusion observation, complete transition traces, root-bound derivation, finite-successor closure and no extra rule. The rejected alternatives respectively erase, replace or violate those source obligations.

Every coordinate has exactly two constructors, so the complete carrier has \(2^8=256\) alternatives. Source decisions inspect all required coordinates. A candidate survives exactly when all eight coordinates have their admitted constructor, yielding one survivor. The native proof exhausts the constructor cases, establishes agreement with the original decision and proves complete membership of the product enumeration. This grammar theorem is recorded separately from the arithmetic induction, complete metric enumeration and coherent-support proofs above.

The six completion receipts retain the following native evidence:

| Entry | Native entry modules | Audited definitions and theorems |
|---|---:|---:|
| Rotation restriction | 23 | 239 |
| Crystal systems | 7 | 136 |
| Bravais classes | 7 | 135 |
| Reciprocal support | 6 | 131 |
| Quasicrystalline order | 6 | 135 |
| Substitution inflation | 7 | 126 |
| Total | 56 | 902 |

All 902 distinct audited names have retained empty-axiom dependency output. The package includes 509 native modules with imports. Whole-programme records compare all 256 source candidate decisions per entry, registrations, canonical hashes, controls and closure. Source-bound observation records retain the original extraction and comparison boundaries. The inflation record specifically compares all twelve protocol fields and three messages with the original pinned source, including the frozen prediction, receipts and registered source identity. Earlier Materials entries retain their original global source guard as recorded; those comparison records distinguish archived post-source agreement from a fresh successful replay of that entire guard.

The portable reproduction executes the original counting and substitution functions with their original exact value classes, loading those modules without package initializers. It checks all rotation orders through 512, all twelve metric forms, all thirty-five centering forms, population histories at 128 positive depths and 10,043 coprime rational examples. The unrestricted theorems are supplied by the native proof bodies; the finite reproduction provides independent executable examples of the same source operations.

## References

[1] Maria Smith. SFT V3 source, commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Original paths: `sft/materials/structural_counts.py`, `successor_structural_counts.py`, `obligations.py`, `derivation.py`, `successor_derivation.py`, `generated_law.py` and their source bindings. Exact files accompany this paper. V3 foundation: [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656). Monograph: [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[2] Maria Smith. SFT V4 Lean verified corpus, edition 0.4, commit [`21cdf559922fb057f8560f42d056ffa035329eb3`](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3). All cited native declarations lie under `SFT.Materials`. Completion receipts: `TURN_677_ROTATION_COMPLETION.json`, `TURN_678_SYSTEMS_COMPLETION.json`, `TURN_679_BRAVAIS_COMPLETION.json`, `TURN_680_RECIPROCAL_COMPLETION.json`, `TURN_682_QUASICRYSTAL_COMPLETION.json` and `TURN_1091_QUASICRYSTAL_INFLATION_COMPLETION.json`.

[3] Maria Smith. SFT V4 cumulative scientific edition: [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Correspondence edition: [doi:10.5281/zenodo.24337358](https://doi.org/10.5281/zenodo.24337358). This paper includes `SOURCE_CORRESPONDENCE.json`, the retained source/proof archive and executable reproduction.

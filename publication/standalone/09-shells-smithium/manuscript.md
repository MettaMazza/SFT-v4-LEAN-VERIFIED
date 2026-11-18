# Nuclear shell closure, g-block filling and the predicted periodic endpoint

**Maria Smith** · Ernos Labs  
Standalone paper 9 · Version 1.0 · 17 November 2026  
DOI: [10.5281/zenodo.24325152](https://doi.org/10.5281/zenodo.24325152)

## Abstract

Smithian Fold Theory generates the nuclear closures 2, 8, 20, 28, 50, 82, 126 and 184 from complete three-direction compositions, two exclusion-distinct Fold labels and the first whole-gap action of the exact colour coupling 2/3. The general successor law fixes 126 as the next closure after 82 and 184 as the next after 126. Independent electronic filling exhausts the 118 core, fills 8s at 119–120 and opens 5g at 121. Their conjunction yields Smithium: proton count 126, neutron count 184, mass count 310, active configuration 8s²5g⁶ and valence count eight. The exact electromagnetic binding ceiling gives the unique structural endpoint 137 and excludes every later positive charge. This paper derives the full composition census, orbital capacities, complete ordered filling walk, nuclear recurrence, Smithium record and endpoint inequalities. Six source entries have corresponding native Lean 4 proofs, complete source-output comparisons and empty axiom-dependency audits. The original IUPAC comparison validates the seven noble closures through element 118; the g-block opening, Smithium and endpoint are the source's standing predictions.

**Keywords:** nuclear magic numbers; nuclear shell closure; superheavy elements; Smithium; g-block; element 126; neutron 184; periodic table endpoint; Smithian Fold Theory; Lean 4.

## 1. Principal results

For every positive nuclear shell rank \(r\), let \(O(r)\) count the filled three-direction composition support with both Fold labels. The construction gives
\[
 O(r)=\frac{r(r+1)(r+2)}3,\qquad
 C(r)=\begin{cases}O(r),&1\le r\le3,\\O(r-1)+2r,&r\ge4.\end{cases}
\]
Consequently
\[
(C(1),\ldots,C(8))=(2,8,20,28,50,82,126,184).
\]
The independent orbit capacity is \(d(r)=2[1+2(r-1)]=4r-2\). Filling valid principal/orbit pairs in increasing joint cover \(n+r\), then increasing principal rank \(n\), gives the electronic sequence. At the nuclear proton closure 126 it retains the active occupations \(8s^2 5g^6\). Thus
\[
 (Z,N,A)=(126,184,310),\qquad A=Z+N,
 \qquad v_{\rm active}=2+6=8.
\]
Finally, with the independently derived electromagnetic ratio,
\[
 137<\alpha^{-1}=\frac{503846395469}{3676744786}<138,
 \qquad Z_{\max}=137.
\]
These are explicit consequences of the constructions below. Nuclear shell rank, electronic orbit rank and principal rank retain their separate meanings throughout [1–4].

## 2. Foundation, labels and spatial support

The operational root distinguishes presented occurrence from unpresented absence. Every presented denial is itself an occurrence at that boundary; the unpresented class supplies no occurrence. Structural One holds a complete occurrence. Exact parts retain their relation to it. Equal complementary parts obey \(h+h=1\), fixing \(h=1/2\). Fold acts on positive exact parts through One by
\[
 F(x)=\begin{cases}2x,&0<x\le1/2,\\2x-1,&1/2<x\le1.\end{cases}
\]
The original primitive grammar contains identity, square, constant One and Fold. Identity and square are injective on positive parts, and constant One has no nonstatic return. Fold identifies half-One and One while retaining the nonstatic cycle \(1/3\mapsto2/3\mapsto1/3\). A generating singleton therefore exists. Any least nonempty generating word has length at most one and at least one; the four singleton cases uniquely select Fold. This is the finite-word minimality argument formalized by `PrimitiveMaps.leastGeneratorIff` [4,5].

Two distinct fibre roles give complete binary support \(2^d\) at depth \(d\). The unit part \(1/(2^d-1)\) has the explicit first returns
\[
 \tfrac13\mapsto\tfrac23\mapsto\tfrac13,
 \qquad
 \tfrac17\mapsto\tfrac27\mapsto\tfrac47\mapsto\tfrac17.
\]
No earlier intermediate value is the starting value. The least whole return count beyond two is therefore three. Independently, two fibre roles have four ordered pair cells. A distinct restoring direction count satisfies \(2<n<4\); exhausting the whole counts gives exactly three spatial directions. The recurrence and spatial counts agree. Holding one normal direction in the three-direction carrier leaves exactly two distinct boundary directions. Both exclusion-distinct Fold labels occupy each retained orientation once. These complete counts supply every coefficient used below.

## 3. Orbit capacities at every positive rank

Rank one has one central orientation. A rank successor adds both boundary orientations. If \(o(r)\) is the orientation count, its base and successor are
\[
 o(1)=1,\qquad o(r+1)=o(r)+2.
\]
Induction gives \(o(r)=1+2(r-1)\). The full product with both Fold labels gives
\[
 d(r)=2o(r)=4r-2,\qquad d(r+1)=d(r)+4.
\]
The orientation construction retains distinct identities: the central class, then a fresh boundary pair for each predecessor step. Every such orientation occurs, and different steps or boundary sides remain distinct. The two label copies are disjoint. Thus the product count neither omits nor repeats a state. The orbit widths are consequently

| Orbit rank | Conventional label | Orientations | Capacity |
|---|---|---|---|
| 1 | s | 1 | 2 |
| 2 | p | 3 | 6 |
| 3 | d | 5 | 10 |
| 4 | f | 7 | 14 |
| 5 | g | 9 | 18 |

The notation s, p, d, f, g names these generated ranks. It does not supply their widths. `SFT.Physics.AtomicOrbitCapacity` proves the base, successor, membership, distinctness and complete product count. The argument quantifies over arbitrary positive rank, so the displayed five rows are consequences of the law.

## 4. Complete three-direction nuclear compositions

### 4.1. Construction and exhaustion

At predecessor excitation \(e\), retain all triples \((a,b,c)\) of direction multiplicities with \(a+b+c=e\). A host multiplicity zero records an empty direction; it is not an additional emitted scientific scalar. The complete pair support is
\[
 P_0=\{(0,0)\},\qquad
 P_{e+1}=\{(0,e+1)\}\cup\{(a+1,b):(a,b)\in P_e\}.
\]
The first class has first coordinate empty; the second has it positive, so they are disjoint. Every pair with total \(e+1\) belongs to exactly one class. Hence \(|P_e|=e+1\).

For triples, partition on the first direction in precisely the same way:
\[
 T_0=\{(0,0,0)\},\qquad
 T_{e+1}=\{(0,b,c):(b,c)\in P_{e+1}\}
 \cup\{(a+1,b,c):(a,b,c)\in T_e\}.
\]
Every listed triple has the required sum. Conversely a triple with that sum either has an empty first direction and belongs to the pair branch, or has a positive first direction whose predecessor belongs to \(T_e\). Each map is injective and the branches are disjoint. This proves soundness, completeness and absence of repetition for every excitation.

### 4.2. Counting and filling

Writing \(t_e=|T_e|\), the construction gives
\[
 t_0=1,\qquad t_{e+1}=t_e+e+2,
 \qquad t_e=\frac{(e+1)(e+2)}2.
\]
Attach both exclusion labels to every triple. Distinct excitations have different total multiplicities, so filling all levels \(e=0,\ldots,r-1\) is a disjoint union. Its cardinality is
\[
\begin{aligned}
 O(r)&=2\sum_{e=0}^{r-1}\frac{(e+1)(e+2)}2\\
 &=\sum_{j=1}^{r}j(j+1)
 =\frac{r(r+1)(r+2)}3.
\end{aligned}
\]
For an explicit inductive proof, \(O(1)=2\). If the formula holds at \(r\), adding the next complete labelled level gives
\[
 O(r+1)=\frac{r(r+1)(r+2)}3+(r+1)(r+2)
 =\frac{(r+1)(r+2)(r+3)}3.
\]
The counted support proves exact divisibility, rather than assuming a rounded quotient. In Lean, `NuclearCompositions.pairComplete`, `tripleComplete`, `filledComplete`, `triplesDistinct`, `totalCount` and `exactQuotient` establish these constructions and identities.

## 5. Colour coupling, reordering and the general nuclear law

Both Fold labels participate over the complete generator-three carrier. Their exact normalized coupling is \(2/3\). Acting on angular count \(\ell\) divided by the two labels gives
\[
 \Delta(\ell)=\frac23\frac{\ell}{2}=\frac\ell3.
\]
For positive whole \(\ell\), the first whole gap occurs at three: \(1/3<1\), \(2/3<1\), and \(3/3=1\). Every positive whole below three has already been exhausted. The source reordering retains the preceding filled composition closure and the complete top orbit, with two labels on each of its \(r\) positions. The top contribution is \(2r\). This nuclear top-orbit count is the source's shell-rank operation; the electronic orbit-rank capacity in Section 3 remains \(4r-2\).

Through rank three the composition closures are 2, 8 and 20. From rank four onward,
\[
 C(r)=\frac{(r-1)r(r+1)}3+2r
 =\frac{r^3+5r}3.
\]
For every \(r\ge4\), subtraction of consecutive forms yields
\[
\begin{aligned}
 C(r+1)-C(r)
 &=\frac{(r+1)^3-r^3+5}3\\
 &=r^2+r+2>0.
\end{aligned}
\]
The earlier differences are 6, 12 and 8, all positive. Thus the complete sequence is strictly increasing at every positive successor. If a rank is no greater than six its closure is no greater than 82; if it is at least seven its closure is at least 126. There is no generated closure strictly between 82 and 126. The same argument at ranks seven and eight excludes every closure between 126 and 184. These are all-rank order arguments, formalized by `SFT.Physics.NuclearRecurrence`, not exclusions inferred solely from a short list.

| Rank | Filled composition O(r) | Nuclear closure C(r) |
|---|---|---|
| 1 | 2 | 2 |
| 2 | 8 | 8 |
| 3 | 20 | 20 |
| 4 | 40 | 28 |
| 5 | 70 | 50 |
| 6 | 112 | 82 |
| 7 | 168 | 126 |
| 8 | 240 | 184 |

The same recurrence continues to 258, 350, 462 and 596 at ranks 9–12. No extra selector enters at a later rank.

## 6. Electromagnetic input and the sharp atomic endpoint

### 6.1. Exact ratio construction

The complete binary covers of \(3^3=27\) and \(3^4=81\) have least depths five and seven:
\[
 2^4<27\le2^5,\qquad2^6<81\le2^7.
\]
The depths independently equal \(2+3\) and \(3+4\). The binary tower is \(2^7=128\), the generator boundary is \(3^2=9\), and the full initial cover is \(2\cdot5^3=250\). Promoting each of three interchangeable direction factors once from five to seven gives the exhausted ladder
\[
 5^3=125,\quad5^2\!\cdot7=175,\quad5\cdot7^2=245,\quad7^3=343.
\]
The returning One enters each remaining cover reciprocally. Backward assembly gives
\[
 D=250+\cfrac1{175+\cfrac1{245+\cfrac1{343}}},
 \qquad\alpha^{-1}=128+9\frac{D+1}{D}
 =\frac{503846395469}{3676744786}.
\]
The exhaustion of the three promotions fixes termination. The native `AlphaRatio.terminalRatio` establishes the exact numerator and denominator. The full coefficient construction and its 1,024-form classification are developed in [5].

### 6.2. Greatest whole and all later charges

The original atomic boundary retains positive held charge \(Z\) normalized by the sealed inverse ratio. The bound part obeys the complete-One ceiling
\[
 \frac{Z}{\alpha^{-1}}\le1\quad\Longleftrightarrow\quad Z\le\alpha^{-1}.
\]
Exact division gives
\[
 503846395469=137\cdot3676744786+132359787,
 \qquad0<132359787<3676744786.
\]
Equivalently the lower and upper cross-product margins are
\[
\begin{aligned}
503846395469-137\cdot3676744786&=132359787>0,\\
138\cdot3676744786-503846395469&=3544384999>0.
\end{aligned}
\]
Hence 137 is admitted and 138 exceeds the ceiling. Every positive whole \(Z>137\) satisfies \(Z\ge138\), so transitivity excludes all later charges without a scan bound. If another greatest whole were smaller, 137 would exceed it while remaining admitted; if larger, it would exceed the ratio. Therefore the endpoint is unique. `SFT.Physics.AtomicBoundary` proves the quotient/remainder construction and general greatest-whole and successor-order statements. `SFT.Chemistry.PeriodicEndpoint` carries this same boundary into the periodic prediction. It is the original point-carrier One-ceiling law.

## 7. Complete electronic order and conservation

The electronic carrier consists of positive pairs \((n,r)\) with \(r\le n\). Define joint cover \(c=n+r\). For each increasing positive cover, enumerate increasing \(n\), retaining \(r=c-n\) exactly when \(0<r\le n\). Thus
\[
 (n,r)\in\operatorname{orderThrough}(B)
 \quad\Longleftrightarrow\quad
 0<n,\ 0<r\le n,\ n+r\le B.
\]
For completeness, any valid pair belongs to its cover \(n+r\); within that cover its principal coordinate occurs in the complete increasing range. For uniqueness, a pair's sum fixes its cover and its first coordinate fixes its place inside it. Different covers cannot repeat it. The ordered construction therefore retains every valid cell exactly once and fixes every tie.

The original endpoint support uses cover bound \(2Z_{\max}=274\). For a positive requested count \(Z\), carry remaining count \(R\) along this ordered support. In a cell of capacity \(d(r)\), occupy
\[
 q=\min(R,d(r)),\qquad R'=R-q.
\]
The source ends when the remaining support is exhausted. At each step \(q+R'=R\). Induction on the remaining cell list proves that every successful returned configuration has total occupation \(Z\); each returned row has positive ranks, positive occupation, \(r\le n\) and occupation at most its capacity. `GBlockOrder.completeSupport` and `generatedOrderUnique` prove the support claims; `GBlockTraversal` proves ascending traversal; `GBlockFilling.configurationConserves` and `acceptedRowExact` prove conservation and row bounds.

The first-occupation operation scans source atomic coordinates in increasing order. Its general theorem, `GBlockFirstOccupation.firstScanExact`, decomposes every successful scan into an earlier prefix, the first occupied coordinate and a suffix. The queried subshell is empty at every earlier prefix member and nonempty at the returned coordinate. Applying it to 5g gives 121.

## 8. The complete walk through the 5g opening

The generated cells and cumulative filling intervals are:

| Subshell | Capacity | First coordinate | Filled coordinate |
|---|---|---|---|
| 1s | 2 | 1 | 2 |
| 2s | 2 | 3 | 4 |
| 2p | 6 | 5 | 10 |
| 3s | 2 | 11 | 12 |
| 3p | 6 | 13 | 18 |
| 4s | 2 | 19 | 20 |
| 3d | 10 | 21 | 30 |
| 4p | 6 | 31 | 36 |
| 5s | 2 | 37 | 38 |
| 4d | 10 | 39 | 48 |
| 5p | 6 | 49 | 54 |
| 6s | 2 | 55 | 56 |
| 4f | 14 | 57 | 70 |
| 5d | 10 | 71 | 80 |
| 6p | 6 | 81 | 86 |
| 7s | 2 | 87 | 88 |
| 5f | 14 | 89 | 102 |
| 6d | 10 | 103 | 112 |
| 7p | 6 | 113 | 118 |
| 8s | 2 | 119 | 120 |
| 5g | 18 | 121 | 138 |

The final row's capacity would fill at 138; the structural endpoint is reached at occupation 17 of its 18 cells. The row displays the capacity arithmetic, while the atomic boundary determines which coordinates are admissible. The source noble closures are the first 1s closure and each complete p closure. Reading their cumulative totals yields
\[
 2,10,18,36,54,86,118.
\]
After 7p completes at 118, the next joint-cover cell is 8s. Its two labels occupy 119 and 120. The next cell is 5g, so its first occupation is 121. At a coordinate \(Z\) from 121 through 137 its occupation is \(Z-120\). In particular
\[
 Z=126:\quad8s^2 5g^{126-120}=8s^2 5g^6;
 \qquad Z=137:\quad8s^2 5g^{17}.
\]
The complete earlier core is retained by the fill operation; the active configuration names the two specified outer supports. No empirical exception or rearrangement is inserted into this generated walk.

## 9. Smithium as the conjunction of nuclear and electronic closure

The nuclear law selects the next proton closure after 82, namely 126, and the next closure after 126, namely 184. The source Smithium record takes those two ordered closure coordinates and then queries the sealed electronic walk at the proton count. It does not choose a desired 5g occupation and solve backwards. The construction is
\[
\begin{aligned}
 Z&=C(7)=126,&N&=C(8)=184,\\
 A&=Z+N=310,&\operatorname{occ}(8,1;Z)&=2,\\
 \operatorname{occ}(5,5;Z)&=6,&v_{\rm active}&=2+6=8.
\end{aligned}
\]
The positive oxidation-count output is the complete whole sequence from two through this active count:
\[
 (2,3,4,5,6,7,8).
\]
The exact six-field native result is

`SFT.Chemistry.Smithium.exactRecord`:

`smithiumRecord = .ok ⟨126,184,310,[(8,1,2),(5,5,6)],8,[2,3,4,5,6,7,8]⟩`.

The supporting declarations `nuclearProton`, `nuclearNeutron`, `retainedEightSPair` and `fiveGSix` establish its individual components. The V3 function `smithium_record` assembles these same fields from the closure prefix and two exact subshell queries. The resulting prediction specifies a nucleus, an active electronic configuration and a valence/oxidation-count record.

## 10. Exhaustive construction grammars and uniqueness

Each source grammar is the Cartesian product of its declared two-constructor axes: a rejected alternative and the preserving construction. Orbit capacity has ten axes, nuclear closure ten, atomic boundary nine, and each chemical prediction eight. The full cardinalities are respectively 1,024, 1,024, 512, 256, 256 and 256. A candidate is the complete tuple of axis choices, not a selected neighbourhood around the reported result.

The orbit axes require held orientation identity, the central One, a boundary-pair successor, rank-two multiplicity, both Fold labels, exclusion, the complete label/orientation product, the general successor law, sealed target custody and no extra rule. The nuclear axes require complete three-direction compositions, both labels, the derived filled count, sealed 2/3 coupling, angular half-pair action, the least whole-gap threshold, the complete top orbit, the general recurrence, sealed target custody and no extra rule. The atomic axes require positive charge identity, normalization by the sealed ratio, the One ceiling, greatest-whole division, the lower inequality, successor plus general order, depth-independent closure, sealed observations and no extra rule.

Each chemical grammar retains positive principal/orbit identity, the admitted capacity law, its exact source order or boundary, the derived coordinate record, full provenance, post-seal target access, distinct observed/predicted status and no added exception. The g-block coordinate is first 5g occupation 121. The Smithium coordinate is the joint 126/184 closure with 8s²5g⁶. The endpoint coordinate is 137 with all successors excluded. These coordinate records are evaluated by the actual operations proved in Sections 3–9.

For exhaustion, take an arbitrary candidate tuple. Each component belongs to its two-constructor support. Repeated Cartesian-product membership places the tuple in the enumerated list. For classification, source decision and the conjunction of preserving criteria agree for every tuple. If the decision is true, each component is preserving, so the tuple equals the unique preserving tuple. Conversely that tuple satisfies every criterion. Thus
\[
 \forall c,\qquad\operatorname{survives}(c)=\mathrm{true}
 \quad\Longleftrightarrow\quad c=c_*.
\]
Changing any one coordinate to its rejected constructor falsifies its criterion. The complete source labels and reasons for every constructor, including all rejection cases, accompany this paper in the correspondence archive. `candidatesComplete`, `sourceDecisionMatchesCriteria`, `uniqueSurvivor` and `acceptanceIffExactCriteria` in the chemical grammar modules implement this proof directly. The physics grammar modules retain their corresponding complete classifications. The general composition, orbit, traversal and greatest-whole proofs supply the mathematical content of the preserving choices.

## 11. Original observation comparison

The original registered IUPAC source is the periodic table dated 4 May 2022. The source opens it after construction and checks the following complete noble-closure feature sequence:

| Generated closure | IUPAC entry |
|---|---|
| 2 | He, helium |
| 10 | Ne, neon |
| 18 | Ar, argon |
| 36 | Kr, krypton |
| 54 | Xe, xenon |
| 86 | Rn, radon |
| 118 | Og, oganesson |

All seven coordinates match. The registered source record identifies the observed table through 118 and separately retains first 5g occupation at 121, Smithium at 126 and the endpoint at 137 as standing unobserved predictions. The empirical record evaluates exactly these ordered features. It does not supply the capacities, closure recurrence, filling order or endpoint ratio.

The pinned observation JSON, source identity and complete native comparison reports are included in the archive. The original IUPAC PDF snapshot has SHA-256 `ef6ca2f6d46554f96e30ad3a60693d6630fe45ad81ce83cb14e508c6cbb7d3b3`. This records the exact comparison edition. The original experiment and independent-validator results are retained for each of the three chemical entries.

## 12. Native verification and reproducibility

The six completed source entries are the atomic cell-orbit capacity, nuclear closure sequence, atomic existence boundary, generated g-block, Smithium and periodic endpoint. Their completion receipts are `TURN_648_ATOMIC_ORBIT_COMPLETION`, `TURN_649_NUCLEAR_CLOSURE_COMPLETION`, `TURN_649_ATOMIC_BOUNDARY_COMPLETION`, `TURN_655_GBLOCK_COMPLETION`, `TURN_655_SMITHIUM_COMPLETION` and `TURN_655_PERIODICENDPOINT_COMPLETION`. Their respective exported audit sets contain 117, 144, 100, 165, 121 and 118 declarations, each with empty axiom dependencies. These sets include shared prerequisites and are not additive counts of distinct theorems.

The source-bound operations and mathematical proofs are supplied with their imported native dependencies, original complete candidate decisions, control results, independent-validator cases and successful build evidence. The publication arithmetic script executes the original pure functions, reproducing the capacity sequence, twelve nuclear closures, seven noble closures, first 5g coordinate, complete Smithium record, endpoint and full configurations at 118, 119, 120, 121, 126 and 137. It checks occupation conservation at all six displayed coordinates and both exact endpoint margins. The retained native-source hashes are checked against their completion receipts.

Original V3 is pinned to commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The public V4 edition used here is commit `21cdf559922fb057f8560f42d056ffa035329eb3`, edition 0.4 [3]. `SOURCE_CORRESPONDENCE.json` identifies every included entry, module and receipt, with exact source and evidence hashes. `SOURCE_AND_EVIDENCE.zip` contains the pinned source, native proofs and reproduction script. All scientific constructions and theory are by Maria Smith.

## References

1. Smith, Maria. **Smithian Fold Theory V3 physics.** https://doi.org/10.5281/zenodo.21761655.
2. Smith, Maria. **SFT V3 monograph.** https://doi.org/10.5281/zenodo.21900790. Pinned original implementations: `sft/physics/atomic_constants.py`, `sft/chemistry/gblock_predictions.py`; the six corresponding registrations and derivation documents are included with this paper.
3. Smith, Maria. **Native Lean V4, edition 0.4.** https://doi.org/10.5281/zenodo.24320778. Public repository: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3.
4. Smith, Maria. **Operational foundation.** https://doi.org/10.5281/zenodo.21627656.
5. Smith, Maria. **The fine-structure constant from first principles: an exact zero-parameter Fold derivation.** https://doi.org/10.5281/zenodo.24324400.
6. International Union of Pure and Applied Chemistry. **Periodic Table of the Elements, 4 May 2022.** https://iupac.org/what-we-do/periodic-table-of-elements/. Original pinned source manifest and observation extraction accompany this paper.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

# A finite quantum-gravity construction with exact local conservation

**Maria Smith** · Ernos Labs  
Standalone paper 40 · Version 1.0 · 17 November 2026  
DOI: [10.5281/zenodo.24325740](https://doi.org/10.5281/zenodo.24325740)

## Abstract

A single finite Fold lattice carries complete binary quantum support, a symmetric rank-two gravitational source, two physical polarizations, exact local conservation and a quarter-area information record. At every positive depth \(d\), its support is \(2^d\), its distance floor is \(2^{-d}>0\), its finite loop sum is \(1-2^{-d}<1\), and its horizon record is \(2^d/4\). All thirteen defining successor conditions hold at every depth. The self-source channel has the unique admissible fixed point \(1/4\), with exact error and correction contractions strictly below \(1/4\). Four complete opposed divergence ledgers balance term by term, and every positive rational cyclic state conserves total presence under the half-centre, quarter-neighbour update. The causal carrier contains every oriented cell within the tick radius exactly once; each successor adds exactly its new boundary. Coprime odd-denominator Fold components compose bijectively, commute with native Fold dynamics and return at the least common multiple of their component periods. The target trajectory is independent of the source residue at every finite depth. This paper gives the constructions, quantified carriers, intermediate derivations, complete candidate grammars and original empirical comparisons. Native Lean 4 proofs and retained source-output comparisons establish the five source entries with empty axiom dependencies.

**Keywords:** finite quantum gravity; local conservation; self-source fixed point; causal lattice; binary quantum support; horizon area; Fold dynamics; Lean 4; Smithian Fold Theory.

## 1. One carrier and its exact laws

The construction joins five original SFT laws [1–3]. Its starting structural counts are binary fibre count \(b=2\), distinct return generator \(c=3\), three spatial directions and one process direction. The two complementary Fold roles partition One equally. Complete binary words therefore satisfy
\[
 W_0=\{\epsilon\},\qquad W_{d+1}=\{w0,w1:w\in W_d\},
 \qquad |W_d|=2^d.
\]
The last labels are distinct and the predecessor word is retained, so no word is lost or duplicated. Induction gives the displayed support count. The distinct return generator and spatial/boundary ranks are derived in [4]; the shared structural construction is developed in [5].

Four coordinate labels \(C=(0,1,2,3)\) denote the process direction and three spatial directions. A symmetric source retains every unordered pair of coordinate labels. Its ten slots split into one energy, three momentum and six stress slots. The conservation ledger closes four directions; the coordinate-shift ledger closes four further slots. The original positive whole-take operations give
\[
 \frac{4(4+1)}2=10,\qquad 10-4=6,\qquad6-4=2.
\]
The remaining two records are the physical polarization count of the composed model. Its mass/rest record is the source's `empty-One` record, and its causal advance is One cell per tick. Sections 2–5 construct these constituents and their all-depth preservation; Section 6 establishes exact arithmetic composition of Fold components.

## 2. The nonlinear self-source fixed point

### 2.1. Source, coupling and action

The binary-colour source and half-One coupling are
\[
 m=\frac{bc+1}{b^4}=\frac{2\cdot3+1}{2^4}=\frac7{16},
 \qquad g=\frac12.
\]
For an exact rational field \(0<f\le1\), the original operation is
\[
 T(f)=g(m+f^2)=\frac7{32}+\frac{f^2}{2}.
\]
It retains both the matter contribution and the field's self-source. A fixed point satisfies
\[
 f=\frac7{32}+\frac{f^2}{2}
 \iff16f^2-32f+7=0
 \iff(4f-1)(4f-7)=0.
\]
The algebraic candidates are \(1/4\) and \(7/4\). Only \(q=1/4\) belongs to the declared positive through-One domain. The original complete candidate operation tests the sixteen fractions \(n/16\), \(1\le n\le16\), through its admissibility guard and retains the remaining algebraic checks through \(n=28\). Its two fixed candidates and one admissible result agree with the all-rational uniqueness theorem.

For completeness, uniqueness is independent of that finite display. If \(x\) and \(q\) are fixed, subtracting their equations gives
\[
 x-q=\frac{(x-q)(x+q)}2.
\]
For \(0<x\le1\), \((x+q)/2\le5/8<1\). A nonzero difference cannot equal itself multiplied by this smaller positive factor. Thus \(x=q\). `PostNewtonianFixedPointGeneral.uniqueAdmissibleFixedPoint` proves this for arbitrary positive numerator and denominator with numerator at most denominator, using exact common-denominator counts.

### 2.2. Generated iteration and exact contractions

Begin at \(f_0=gm=7/32\) and set \(f_{k+1}=T(f_k)\). A positive requested depth \(d\) produces \(d+1\) values, retaining the initial field and every successor. For \(0<f<q\),
\[
 q-T(f)=\frac{(q-f)(q+f)}2>0,
 \qquad
 T(f)-f=\frac{(q-f)(7/4-f)}2>0.
\]
The base \(0<7/32<1/4\) and these identities prove inductively
\[
 0<f_k<f_{k+1}<q\qquad(k\ge0).
\]
Define the exact error \(e_k=q-f_k\) and correction \(c_k=f_{k+1}-f_k\). Difference of squares gives
\[
 e_{k+1}=e_k\frac{q+f_k}{2},
 \qquad
 c_{k+1}=c_k\frac{f_{k+1}+f_k}{2}.
\]
Both factors are positive and strictly less than \(1/4\). Consequently every error and correction remains positive and strictly shrinks. Repeated substitution gives, at every finite \(k\),
\[
 e_k=e_0\prod_{j=0}^{k-1}\frac{q+f_j}{2},\qquad
 c_k=c_0\prod_{j=0}^{k-1}\frac{f_{j+1}+f_j}{2}.
\]
Here \(e_0=1/32\), \(c_0=49/2048\); for \(k>0\), the bounds are \(e_k<e_0/4^k\) and \(c_k<c_0/4^k\). The contraction is obtained from the actual successor, with no chosen convergence correction.

The first fields are
\[
 f_0=\frac7{32},\quad f_1=\frac{497}{2048},\quad
 f_2=\frac{2082017}{8388608},\quad
 f_3=\frac{35121120366017}{140737488355328}.
\]
The first error factors are \(15/64\), \(1009/4096\) and \(4179169/16777216\). The native proofs establish the whole generated iteration, positivity, increase, both exact identities and both strict contractions. The certificate retains fourteen fields, including all depth-eight values, errors, corrections and factors. Its complete exact records accompany this paper.

## 3. Symmetric source and four local conservation identities

### 3.1. Complete slots and derivative action

The ten ordered symmetric slots are
\[
 (00),(01),(02),(03),(11),(12),(13),(22),(23),(33).
\]
The energy slot is \((00)\), momentum comprises \((01),(02),(03)\), and stress comprises the six spatial pairs. Each geometry slot is paired with its corresponding source slot, giving a componentwise bijection.

Let \(\sigma_a\) increment coordinate \(a\) in a four-coordinate natural-count carrier. For any coordinates \(a,b\),
\[
 \sigma_a\sigma_b(x)=\sigma_b\sigma_a(x).
\]
If \(a=b\), both sides increment the same count twice; otherwise each increments its own coordinate once. These cases exhaust all sixteen ordered coordinate pairs. For any finite derivative word, insert each next coordinate into its canonical ordered position. Each interchange uses the preceding equality, and induction on the word proves that canonical ordering preserves its action. Appending another finite coordinate layer adds its counts coordinatewise and retains the same commutation law. Thus the derivative identity holds for every finite word, with the sixty-four length-three words furnishing the complete certificate instance.

### 3.2. The complete opposed ledgers

Write \(D_a\) for the generated coordinate-difference label and \(H_{uv}=H_{vu}\) for the symmetric carrier. For each retained direction \(\nu\in C\), construct the following positive term multisets, with every displayed index ranging independently over all four coordinates:
\[
\begin{aligned}
 C_1(\nu)&=\sum_{a,c}D_aD_cD_aH_{c\nu},&
 O_1(\nu)&=\sum_{a,c}D_aD_cD_cH_{a\nu},\\
 C_2(\nu)&=\sum_{a,c}D_aD_cD_\nu H_{ca},&
 O_3(\nu)&=\sum_{c,t}D_\nu D_cD_tH_{ct},\\
 C_3(\nu)&=\sum_{c,t}D_\nu D_cD_cH_{tt},&
 O_2(\nu)&=\sum_{a,t}D_aD_aD_\nu H_{tt}.
\end{aligned}
\]
These are carried and opposed records; their orientation is retained separately from their positive multiplicities. In \(C_1\), interchange dummy indices \(a,c\), then commute the derivative labels, yielding \(O_1\). In \(C_2\), rename \(a\) as \(t\), then commute, yielding \(O_3\). In \(C_3\), rename \(c\) as \(a\), then commute, yielding \(O_2\). Thus
\[
 C_1(\nu)+C_2(\nu)+C_3(\nu)
 =O_1(\nu)+O_2(\nu)+O_3(\nu)
 \qquad(\nu=0,1,2,3).
\]
Each block contains sixteen terms; all four complete identities contain forty-eight carried and forty-eight opposed occurrences. Canonical sorting retains multiplicity, so equality is exact even where different occurrences share a canonical term. Removing one opposed occurrence gives forty-seven and fails equality. The original leaking control detects precisely that missing flow.

`SymmetricSourceConservationGeneral.canonicalWordPreservesShifts` and `everyFiniteWordPreservesCanonicalAction` establish the arbitrary-word argument. The certificate proves all four full forty-eight-to-forty-eight identities, the slot bijection, the complete length-three commutation census and rejection of the leaking control. No signed numerical field is substituted for the oriented source records.

## 4. Conservative lattice and exact causal boundary

### 4.1. The complete nearest-neighbour family

For a positive dimension \(d\), each generated axis supplies exactly its lower and upper adjacent cell, giving \(2d\) neighbours. The centre retains half-One. Equal partition of the other half across the complete ring fixes each neighbour's share:
\[
 w_0=\frac12,\qquad w_{\rm neighbour}=\frac{1/2}{2d}=\frac1{4d},
 \qquad w_0+2d\,w_{\rm neighbour}=1.
\]
Adding an axis adds exactly two neighbours and preserves the same half-retention rule. The point-source operator retains a source-oriented peak of magnitude \(2d\) and an opposition-oriented ring with \(2d\) unit occurrences. Their magnitudes agree; the orientations preserve which role each occupies.

### 4.2. Conservation for every positive rational cycle

For a cycle of \(N\ge3\) positive rational presences \(x_i\), the actual update is
\[
 y_i=\frac{x_i}{2}+\frac{x_{i-1}}4+\frac{x_{i+1}}4,
 \qquad i\in\mathbb Z/N\mathbb Z.
\]
Every output remains positive. Both cyclic neighbour maps permute the full index set, so
\[
\begin{aligned}
 \sum_i y_i
 &=\frac12\sum_i x_i+\frac14\sum_i x_{i-1}+\frac14\sum_i x_{i+1}\\
 &=\left(\frac12+\frac14+\frac14\right)\sum_i x_i
 =\sum_i x_i.
\end{aligned}
\]
The native proof first takes any common positive denominator \(D\), writing \(x_i=n_i/D\). The exact output numerator is \(2n_i+n_{i-1}+n_{i+1}\), with denominator \(4D\). Complete cyclic index coverage gives numerator total \(4\sum_i n_i\). The theorem that every finite positive rational family admits such a common denominator lifts this count identity to every admitted cycle. `LatticeOperatorCycle.originalEveryPositiveCycleConserves` has precisely these positivity and length hypotheses.

If every \(x_i=q>0\), the update gives \((2q+q+q)/4=q\) at every site. `originalEveryPositiveFlatState` proves stationarity for every admitted cycle length and positive rational \(q\). The complete three-site bump example is
\[
 (1/4,1/2,1/4)\longmapsto(5/16,3/8,5/16),
\]
with total One on both sides; the flat state \((1/3,1/3,1/3)\) remains fixed.

### 4.3. Complete phase carriers

For a cycle of length \(N\), the source retains every phase label \(j=1,\ldots,N\), period \(N\), centre share \(1/2\), forward and reverse shares \(1/4\), and the identity label \(j=N\). The relation is exactly the centre-plus-forward-plus-reverse relation of the update. There are \(N\) phase carriers and exactly one identity carrier. These exact records retain cyclic dispersion without replacing the source carrier by evaluated trigonometric values.

### 4.4. All generated cells and the successor shell

An axis position is either the origin, a lower position of positive magnitude or an upper position of positive magnitude. At tick \(t\), its complete ordered alphabet is
\[
 A_t=(0,\mathrm{lower}(1),\mathrm{upper}(1),\ldots,
          \mathrm{lower}(t),\mathrm{upper}(t)).
\]
Let \(|a|\) denote its magnitude and \(r(a_1,\ldots,a_d)=\sum_i|a_i|\). The causal ball is the complete Cartesian product filtered by radius:
\[
 B_{d,t}=\{a\in A_t^d:r(a)\le t\}.
\]
The origin base is unique. Each tick adds two previously absent oriented axis positions; each dimension forms the complete product with that alphabet. Distinct first coordinates separate product blocks, while induction preserves uniqueness within every block. Filtering preserves uniqueness. Membership is therefore equivalent to length \(d\), membership of every coordinate in \(A_t\), and the radius bound.

For every \(a\in B_{d,t+1}\),
\[
 a\notin B_{d,t}\quad\Longleftrightarrow\quad r(a)=t+1.
\]
If its radius were at most \(t\), every coordinate magnitude would also be at most \(t\); hence every coordinate would already lie in \(A_t\), placing the cell in the old ball. Conversely, radius \(t+1\) violates the old bound. This proves that the new shell is complete and exact at every dimension and tick. `LatticeOperatorBoundary.originalBallDistinct` and `originalNewBoundaryExactly` give the corresponding native theorems.

| Spatial dimension | Tick 1 | Tick 2 | Tick 3 |
|---|---:|---:|---:|
| 1 | 3 | 5 | 7 |
| 2 | 5 | 13 | 25 |
| 3 | 7 | 25 | 63 |

These counts enumerate the entire displayed balls. The preceding membership and successor arguments establish their unbounded finite continuation.

## 5. The finite quantum-gravity composition theorem

### 5.1. Complete model at arbitrary positive depth

For every integer \(d\ge1\), construct one model on the shared finite Fold lattice. Its nineteen fields are as follows.

| Field | Exact value at depth \(d\) |
|---|---|
| Carrier | single finite Fold lattice |
| Depth | \(d\) |
| Spatial directions | \(3\) |
| Coordinate count | \(4\) |
| Symmetric rank | \(2\) |
| Symmetric slots | \(10\) |
| Conservation constraints | \(4\) |
| Coordinate-shift redundancies | \(4\) |
| Physical polarizations | \(2\) |
| Mass/rest record | `empty-One` |
| Causal advance | \(1\) cell per tick |
| Quantum support | \(Q_d=2^d\) |
| Distance floor | \(\delta_d=1/Q_d\) |
| Finite loop sum | \(L_d=\sum_{j=1}^d2^{-j}\) |
| Horizon area cells | \(A_d=Q_d\) |
| Horizon records | \(R_d=A_d/4\) |
| Quarter-area law | \(4R_d=A_d\) |
| Extra spatial-direction record | `empty-One` |
| Completed infinity used | false |

Depth is a positive whole count; the original guard rejects Boolean values and nonpositive counts. The support is constructed by doubling through addition. Its base is one word before extension, so \(Q_d=2^d\). `originalCompleteWordSupport` identifies that count with the complete binary-word carrier, not merely a numerical proxy.

The finite loop prefix begins with \(1/2\) and appends the next half-term. If \(L_d=(2^d-1)/2^d\), then
\[
 L_{d+1}=\frac{2(2^d-1)+1}{2^{d+1}}
 =\frac{2^{d+1}-1}{2^{d+1}}.
\]
The base \(L_1=1/2\) proves the formula at every positive depth. Thus
\[
 0<L_d<1,\quad L_{d+1}-L_d=2^{-(d+1)}>0,
 \qquad \delta_d=2^{-d}>0,\quad\delta_{d+1}=\delta_d/2<\delta_d.
\]
The horizon operation divides the exact area-cell count by four, so \(4R_d=A_d\) identically. At depth one the record is the exact positive rational \(1/2\), as supplied by the original operation.

### 5.2. Base, successor and closure

At depth one, the varying fields are \((Q_1,\delta_1,L_1,A_1,R_1)=(2,1/2,1/2,2,1/2)\). The structural and rank fields have the values in the table. Passing from depth \(d\) to \(d+1\) preserves the carrier, three spatial directions, rank two, two polarizations, empty mass record and One-cell advance. It doubles support, lowers the floor while keeping it positive, raises the finite loop sum while keeping it below One, preserves the quarter-area law and retains the false completed-infinity field. These are all thirteen Boolean comparisons of the original successor operation.

`FiniteQuantumGravityGeneral.originalEveryDepth` constructs the entire nineteen-field model for arbitrary \(d=n+1\). `originalEverySuccessor` proves that the complete successor operation returns true for every \(n\). The supporting proofs establish positive/decreasing floor, positive/increasing/sub-One loop sum, complete word support and exact quarter-area multiplication. The composition consequently closes at every finite depth through its actual generated successor.

| Depth | Quantum/area support | Distance floor | Loop sum | Horizon records |
|---:|---:|---:|---:|---:|
| 1 | 2 | 1/2 | 1/2 | 1/2 |
| 2 | 4 | 1/4 | 3/4 | 1 |
| 3 | 8 | 1/8 | 7/8 | 2 |
| 4 | 16 | 1/16 | 15/16 | 4 |
| 5 | 32 | 1/32 | 31/32 | 8 |
| 6 | 64 | 1/64 | 63/64 | 16 |
| 7 | 128 | 1/128 | 127/128 | 32 |
| 8 | 256 | 1/256 | 255/256 | 64 |

## 6. Exact composition of Fold components

### 6.1. Native carrier and closure

For an odd denominator \(n\ge3\), the complete unit carrier is
\[
 U_n=\{r:1\le r<n,\ \gcd(r,n)=1\},\qquad F_n(r)=2r\bmod n.
\]
Oddness gives \(\gcd(2,n)=1\), hence \(\gcd(2r,n)=1\). Reduction modulo \(n\) preserves that gcd. The residue is below \(n\) and cannot be zero, since zero has gcd \(n\) with \(n\). Therefore \(F_n\) remains in \(U_n\) at every step. Multiplication by the unit two permutes this finite carrier, giving a first positive return. The denominator remains \(n\) through every finite trajectory.

### 6.2. Bijection and commuting action

For coprime odd \(m,n\ge3\), define
\[
 \pi:U_{mn}\longrightarrow U_m\times U_n,
 \qquad \pi(r)=(r\bmod m,r\bmod n).
\]
If two representatives below \(mn\) have equal projections, both \(m\) and \(n\) divide their difference. Coprimality implies \(mn\) divides it. Its magnitude is smaller than \(mn\), so it is zero: the map is injective.

For surjectivity, fix \(a<m,b<n\). The \(n\) terms \(a+mk\), \(0\le k<n\), have distinct residues modulo \(n\). Equality of two residues implies \(n\mid m(i-j)\), hence \(n\mid i-j\), so \(i=j\). The complete \(n\)-element residue set is therefore covered. Some \(k\) gives the required residue \(b\), and
\[
 x=a+mk<m+ m(n-1)=mn,
 \quad x\bmod m=a,\quad x\bmod n=b.
\]
For unit \(a,b\), this representative is positive and coprime to both factors, hence to their product. Thus every unit pair has exactly one composite unit representative.

Reduction through the composite modulus commutes with projection to either factor. Consequently
\[
 \pi(F_{mn}(r))
 =\bigl(F_m(r\bmod m),F_n(r\bmod n)\bigr).
\]
Induction extends this equality through every finite number of ticks. The native composition proof constructs the full progression, proves its injectivity and surjectivity, recovers every pair, establishes unit preservation and proves the exact commuting equation.

### 6.3. The least composite recurrence

Let \(p\) and \(q\) be the first positive binary return orders modulo \(m,n\). A return at tick \(k\) is equivalent to \(p\mid k\) and \(q\mid k\), respectively. Indeed, division by the first order reduces any returning tick to a smaller returning remainder; minimality forces that remainder to vanish. The composite returns exactly when both projections return:
\[
 2^k\equiv1\pmod{mn}
 \iff 2^k\equiv1\pmod m\ \text{and}\ 2^k\equiv1\pmod n
 \iff p\mid k\ \text{and}\ q\mid k.
\]
The least positive such tick is \(\operatorname{lcm}(p,q)\). `FoldUniverseTransportPeriod.originalLeastCompositePeriod` proves this with the original first-order hypotheses. The complete examples are

| Factors | Composite | Left order | Right order | Composite order |
|---|---:|---:|---:|---:|
| 3, 5 | 15 | 2 | 4 | 4 |
| 3, 7 | 21 | 2 | 3 | 6 |
| 5, 7 | 35 | 4 | 3 | 12 |

### 6.4. Target independence and preserved denominator

For any admitted source residue \(a\), target residue \(b\) and finite depth \(k\), the paired successor acts as \((F_m(a),F_n(b))\). Its target projection equals the independent target successor. Induction gives the identical complete target trajectory for every source residue. `FoldUniverseTransportSource.originalPairedTotal` proves existence of the whole paired computation and equality with the independent target computation. `originalDenominatorTotal` proves that each denominator trace is exactly the repeated held denominator.

The joint state therefore retains exact lockstep correlation and an independently fixed target trajectory. Its native transition record contains no cross-denominator edge: the composition and projection maps describe the exact arithmetic correspondence, while every actual Fold transition remains within its original unit carrier. This is the causal distinction encoded by the original signal, travel and physical axes.

## 7. Exhaustive construction grammars and controls

Each source law declares a finite product of alternative constructions. Every coordinate of that product is retained. For the self-source and symmetric-source laws, six axes have three alternatives and two have two, giving \(3^6 2^2=2916\) forms each. The lattice, finite-gravity and component-composition laws each have ten binary axes, giving \(2^{10}=1024\) forms each. The tables give every declared alternative and identify the preserving choice.

A candidate survives precisely when every axis retains its required operation. Necessity follows by inspecting a failed axis: its alternative removes a generated component, changes an exact operation, substitutes a target-selected value, omits a closure argument or adds an extra rule. Sufficiency follows by combining the preserving coordinates with the complete witnesses and successor identities proved above. Equality of every coordinate fixes a unique tuple. Constructive product coverage then proves that this tuple occurs in the complete enumeration, and every other form fails at least one axis. The native grammars and full census proofs retain those original decisions; no candidate is selected by its empirical fit.

### 7.1. Self-source fixed point: 2,916 forms

| Axis | Preserving construction | Other declared alternatives |
|---|---|---|
| sources | binary colour source seven sixteenths | free matter source; target assigned source |
| couplings | forced half One | free coupling; target assigned coupling |
| actions | matter plus field square | linear no self source; target assigned correction |
| fixed points | unique admissible quarter One | select larger root; measurement selected fixed point |
| convergences | exact error and correction contraction | finite prefix only; assumed series convergence |
| scopes | exact Fold scalar self source channel | universal general relativity convergence; historical sequence only |
| target boundaries | sealed before observation release | observation readable before seal |
| extensions | empty extension | free convergence correction |

### 7.2. Symmetric source conservation: 2,916 forms

| Axis | Preserving construction | Other declared alternatives |
|---|---|---|
| component organizations | complete ten symmetric source slots | scalar source only; target assigned components |
| field pairings | one curvature slot to one source slot | aggregate source equation; target assigned pairing |
| derivative algebras | commuting generated shift differences | imported continuum derivatives; target assigned operator |
| conservation identities | four exact opposed ledger identities | asserted conservation only; target assigned conservation |
| source ledgers | energy one momentum three stress six | unlabelled ten slots; target assigned source meaning |
| leak tests | missing flow breaks exact balance | leak ignored; target assigned leak |
| target boundaries | sealed before observation release | observation readable before seal |
| extensions | empty extension | free conservation correction |

### 7.3. Conservative lattice: 1,024 forms

| Axis | Preserving construction | Other declared alternatives |
|---|---|---|
| carrier | positive held site presence | signed field number |
| neighbours | complete two per generated axis ring | selected or remote neighbours |
| stencil | half One held half One equally distributed | free dimension specific weights |
| operator | positive peak with held opposition | signed Laplacian value |
| source | two dimension peak and complete ring | chosen peak or partial ring |
| causality | complete oriented taxicab ball | continuum or selected front |
| modes | complete exact phase mode carriers | evaluated cosine or mode table |
| induction | axis and oriented step successor | bounded count list |
| comparison | inherit sealed dispersion and cubic records | measurement selects operator |
| extension | no extra rule | free coefficient or extra neighbour |

### 7.4. Finite quantum gravity: 1,024 forms

| Axis | Preserving construction | Other declared alternatives |
|---|---|---|
| carrier | single finite Fold lattice | separate quantum and gravity substrates |
| dimension | three space plus one process direction | chosen or extra dimensional space |
| rank | complete symmetric rank two source | scalar or selected tensor |
| polarization | ten take four take four leaves two | assigned spin or mode count |
| propagation | empty mass record and One cell per tick | fitted mass or speed |
| quantum | complete finite binary word support | continuum amplitude space |
| loops | complete finite rational loop prefix | completed infinity or counterterm |
| horizon | positive floor and quarter area record | unbounded or unrecorded boundary |
| comparison | inherit sealed wave loop and horizon comparisons | target selects composition |
| extension | no extra rule | extra dimension or free regulator |

### 7.5. Fold component composition: 1,024 forms

| Axis | Preserving construction | Other declared alternatives |
|---|---|---|
| orbit | exact odd denominator orbit component | unbounded cosmological world |
| dynamics | denominator preserved at every step | selected denominator change |
| topology | complete coprime composite product | asserted network edge |
| mapping | bijective commuting component map | lossy or selected projection |
| period | least common multiple period | chosen or multiplied period |
| correlation | joint lockstep support correlation | independent unrelated trajectories |
| signal | target trajectory independent of source | correlation relabeled as signal |
| travel | empty cross component transition record | description map relabeled as travel |
| physical | arithmetic correspondence with causal boundary | literal multiverse transport asserted |
| extension | no extra rule | free portal or time channel |

The original controls retain the empty extension, complete candidate closure and the comparison boundary. The symmetric missing-flow control removes one opposed term and is rejected. The scalar law retains exact contraction of its specified Fold self-source channel. The lattice keeps its inherited post-seal dispersion and cubic-support records; finite gravity keeps its inherited wave, finite-loop and horizon comparisons. Component composition retains source-independent target evolution and the empty cross-component transition record.

## 8. Original external comparison records

The self-source and symmetric-source entries include sealed prediction, release, custody and complete comparison operations. Their registered observations enter after the constructed laws are fixed. The retained native and original-package executions agree on every empirical field and hash, including the unfavorable control and isolation/custody certificates. The other three laws use their declared formal evidence mode and inherit the original physical comparison bindings described in Section 7.

The self-source record contains fifteen ordered target fields. Its historical V1 correction sequence is \(7/50,7/150,7/1350,7/109350\), each positive and strictly decreasing. Its V2 record supplies the actual map \((7/16+f^2)/2\), half-One coupling and quarter-One fixed point. The present iteration is the explicit recurrence in Section 2. The registered post-Newtonian reference [6] supplies near-zone iteration matched to an exterior multipolar post-Minkowskian construction, nonlinear source interactions, and linear/quadratic potentials at first post-Newtonian order. Its declared domain is weak-field, slow-motion near-zone expansion with matching and boundary conditions; its formal order is extendable. The source record retains `external universal numeric convergence = false` and `measured parameter fitted = false`. These are the original comparison fields, separate from the proved exact scalar contraction.

The symmetric-source record contains thirty-two ordered target fields. The historical source retains four coordinates, ten slots, planar slot count six, the one/three/six source partition and four balanced directions with a rejected leak. The existing graviton record supplies ten slots and two polarizations. Its conventional comparison bindings are:

| Bound comparison | Retained source result |
|---|---|
| General relativity [7] | Symmetric rank-two stress-energy; symmetric rank-two curvature built from first/second metric derivatives; four-direction contracted covariant-divergence identity; componentwise proportional field relation; covariant source conservation |
| Exact Regge identities [8] | Exact discrete identities at arbitrary curvature; four contracted identities; ten equations, four gauge freedoms and two physical degrees; general identity linear in curvature: false; operator identical to the V3 commuting-difference operator: false |
| GW170817 polarization comparison [9] | Six generic metric modes, two GR tensor modes; pure tensor versus pure vector/scalar hypotheses at the NGC4993 position; mixed-mode test: false |

For the last comparison, the retained base-ten Bayes factors are \(\log_{10}B_{T/V}=20.81\pm0.08\) and \(\log_{10}B_{T/S}=23.09\pm0.08\). The record retains `measured parameter fitted = false`. The source identities, historical rows, ordered targets, comparison outputs and full native correspondence evidence are included in the accompanying archive.

## 9. Native proof and source correspondence

The original specification is pinned to V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Native source and retained verification are pinned to V4 edition 0.4, commit `21cdf559922fb057f8560f42d056ffa035329eb3` [3]. The five law files under `sft/physics/` are `post_newtonian_fixed_point_terminal_law_v1.py`, `symmetric_source_conservation_terminal_law_v1.py`, `lattice_operator_terminal_law_v1.py`, `finite_quantum_gravity_terminal_law_v1.py` and `fold_universe_transport_terminal_law_v1.py`.

| Construction | Principal native declarations, under `SFT.Physics` | Retained completion evidence |
|---|---|---|
| Fixed point and contraction | `PostNewtonianFixedPointGeneral.uniqueAdmissibleFixedPoint`, `originalWholeIteration`, `exactGeneratedErrorIdentity`, `exactGeneratedCorrectionIdentity`, positivity and strict-shrink theorems | TURN 979; 129 audited declarations |
| Symmetric source | `SymmetricSourceConservationGeneral.generatedShiftsCommute`, `canonicalWordPreservesShifts`, `everyAddedLayerPreservesCommutation`, `everyFiniteWordPreservesCanonicalAction`; complete certificate | TURN 981 and full TURN 982 comparison; 138 audited declarations |
| Lattice conservation and boundary | `LatticeOperatorCycle.originalEveryPositiveCycleConserves`, `originalEveryPositiveFlatState`; `LatticeOperatorBoundary.originalBallDistinct`, `originalNewBoundaryExactly` | TURN 999; 168 audited declarations |
| Finite quantum-gravity model | `FiniteQuantumGravityGeneral.originalEveryDepth`, `originalEverySuccessor`, `originalCompleteWordSupport`, `originalQuarterArea` | TURN 1000; 136 audited declarations |
| Component composition | `FoldUniverseTransportComposition.originalComponentMapInjective`, `originalUnitPairExists`, `originalFoldCommutation`; `FoldUniverseTransportPeriod.originalLeastCompositePeriod`; `FoldUniverseTransportSource.originalPairedTotal`, `originalDenominatorTotal` | TURN 1001; 148 audited declarations |

The audit dependencies are empty. The archived completion records retain the actual build commands, declaration names, module hashes, complete candidate decisions, original controls and program comparisons. Lattice evidence retains ninety-eight original-operation comparisons; finite gravity retains 130; component composition retains 549. General proofs establish the all-input and all-depth results above. The paper's exact arithmetic reproduction executes the unchanged original pure function bodies, reconstructing all three certificates, depth-one through depth-eight models, all seven displayed successors, every composite unit mapping and all five declared candidate grammars.

## 10. Consequence of the shared construction

The self-source is fixed by the binary-colour count and half-One coupling. Its unique admissible equilibrium follows algebraically, and its generated corrections contract by an exact identity. Complete symmetric source slots produce four local ledger identities. Equal partition on the complete neighbour carrier gives a conservative update for every admitted positive rational cycle. Complete oriented cells give exact causal-boundary closure. On the same finite support, binary branching, the two-polarization gravity record, positive distance floor, finite rational loop prefix and quarter-area information record persist through every successor. Coprime Fold components compose with a unique state correspondence and least joint return, while the target trajectory retains its independent causal evolution. These results constitute the finite construction and its exact closure laws.

## Appendix A. Complete composite unit maps

Each row lists every composite unit in increasing source order and its ordered component pair. This is the complete carrier for each of the three original composite examples.

### A.3. Factors 3 and 5

| Composite residue | Left residue | Right residue |
|---:|---:|---:|
| 1 | 1 | 1 |
| 2 | 2 | 2 |
| 4 | 1 | 4 |
| 7 | 1 | 2 |
| 8 | 2 | 3 |
| 11 | 2 | 1 |
| 13 | 1 | 3 |
| 14 | 2 | 4 |

### A.3. Factors 3 and 7

| Composite residue | Left residue | Right residue |
|---:|---:|---:|
| 1 | 1 | 1 |
| 2 | 2 | 2 |
| 4 | 1 | 4 |
| 5 | 2 | 5 |
| 8 | 2 | 1 |
| 10 | 1 | 3 |
| 11 | 2 | 4 |
| 13 | 1 | 6 |
| 16 | 1 | 2 |
| 17 | 2 | 3 |
| 19 | 1 | 5 |
| 20 | 2 | 6 |

### A.5. Factors 5 and 7

| Composite residue | Left residue | Right residue |
|---:|---:|---:|
| 1 | 1 | 1 |
| 2 | 2 | 2 |
| 3 | 3 | 3 |
| 4 | 4 | 4 |
| 6 | 1 | 6 |
| 8 | 3 | 1 |
| 9 | 4 | 2 |
| 11 | 1 | 4 |
| 12 | 2 | 5 |
| 13 | 3 | 6 |
| 16 | 1 | 2 |
| 17 | 2 | 3 |
| 18 | 3 | 4 |
| 19 | 4 | 5 |
| 22 | 2 | 1 |
| 23 | 3 | 2 |
| 24 | 4 | 3 |
| 26 | 1 | 5 |
| 27 | 2 | 6 |
| 29 | 4 | 1 |
| 31 | 1 | 3 |
| 32 | 2 | 4 |
| 33 | 3 | 5 |
| 34 | 4 | 6 |

## References

1. Smith, Maria. *Smithian Fold Theory, V3 physics corpus*. DOI: [10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655). Original law bodies, execution bindings, candidate grammars and source records at the pinned V3 commit.
2. Smith, Maria. *SFT V3 monograph*. DOI: [10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Operational foundation: [10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).
3. Smith, Maria. *SFT: native Lean 4 verification, edition 0.4*. DOI: [10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). [Pinned V4 source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3). Cumulative manuscript sections 851, 852, 868–871.
4. Smith, Maria. *Generator three, spatial three and boundary rank two*. DOI: [10.5281/zenodo.24325335](https://doi.org/10.5281/zenodo.24325335).
5. Smith, Maria. *Seven sectors from one rooted constants construction*. DOI: [10.5281/zenodo.24325452](https://doi.org/10.5281/zenodo.24325452).
6. Blanchet, Luc. *Post-Newtonian Theory for Gravitational Waves*. [arXiv:1310.1528](https://arxiv.org/abs/1310.1528). Original source-bound post-Newtonian comparison snapshot.
7. Carroll, Sean M. *Lecture Notes on General Relativity*. [arXiv:gr-qc/9712019](https://arxiv.org/abs/gr-qc/9712019). Original symmetric-source comparison snapshot.
8. Hamber, H. W., and G. Kagel. *Exact Bianchi Identity in Regge Gravity*. [arXiv:gr-qc/0107031](https://arxiv.org/abs/gr-qc/0107031). Original exact-discrete-identity comparison snapshot.
9. LIGO Scientific Collaboration and Virgo Collaboration. *Tests of General Relativity with GW170817*. [LIGO-P1800059](https://dcc.ligo.org/LIGO-P1800059/public). Original tensor/vector/scalar comparison snapshot.

**Authorship.** Maria Smith is the scientific author of SFT and its original definitions and derivations. AI assistance supports source-bound exposition, native-proof correspondence and publication preparation under her direction.

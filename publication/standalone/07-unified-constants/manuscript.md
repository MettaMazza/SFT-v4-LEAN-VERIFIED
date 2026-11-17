# Seven sectors from one rooted constants construction

**Maria Smith** · Ernos Labs  
Standalone paper 7 · Version 1.0 · 17 November 2026  
DOI: [10.5281/zenodo.24325452](https://doi.org/10.5281/zenodo.24325452)

## Abstract

The Unified Constants Object of Smithian Fold Theory connects electromagnetic, charged-lepton, quark, dark/baryonic, Hubble, Planck-hierarchy and vacuum readings through one exact rooted construction. Binary two, generator three, spatial rank three and boundary rank two generate the shared cover depths five and seven. These carriers produce a 16-field foundation vector and a 26-field terminal vector. Fourteen common-order readings agree exactly between independently assembled vectors. The complete parent-to-child graph has seventeen nodes and ten parent rows; explicit paths connect the foundational One to all seven sector nodes. The original generator-successor dependency test changes three to four while holding the independently specified binary and ranks fixed. All twelve designated dependent fields change, and all four held controls remain equal. This paper gives the full formulas, exact vectors, intermediate sector derivations, complete graph, all sixteen probe comparisons and the 4,096-form construction grammar. Native Lean 4 proofs establish the actual source operations, seven path witnesses, fourteen equalities, twelve changes, four controls and the complete certificate with zero axiom dependencies. The seven sectors are linked readings of shared generated support, rather than independently adjustable numerical inputs.

**Keywords:** unification of physical constants; fine-structure constant; lepton and quark invariants; dark matter; Hubble ratio; Planck hierarchy; vacuum density; Smithian Fold Theory; Lean 4.

## 1. The exact shared object

The common generated carriers are
\[
 b=2,\quad g=3,\quad s=3,\quad r=2,
 \qquad d_-=5,\quad d_+=7.
\]
Here \(b\) counts the Fold fibres, \(g\) is the second distinct nonidentity return generator, \(s\) is the independent spatial rank, \(r\) is the retained boundary rank, and \(d_-,d_+\) are the least binary cover depths of the generated volumes. The foundation readings include
\[
\begin{gathered}
 \alpha^{-1}_{\rm leading}=\frac{34259}{250},\qquad
 P_{\ell,\rm leading}=\frac1{485},\qquad
 R_{D/B,\rm leading}=\frac{27}{5},\\
 R_{H,\rm leading}=\frac{13}{12},\qquad
 E_{\rm hierarchy}=\frac{127}{2},\qquad
 \rho_{\rm local,min}=2^{-20}.
\end{gathered}
\]
Each is a typed reading of the same support counts. The terminal object retains their original completed continuations, including exact inverse alpha, charged-lepton and quark products, recursive cosmic ratios, the charged-colour hierarchy transport and the separately typed cosmic vacuum magnitude.

The source certificate has eight fields: three complete vectors and five Boolean conclusions. The vectors are foundation order, terminal assembly and generator-successor probe. The conclusions establish all seven sectors' reachability from One, incoming sector incidence, change of every designated generator-dependent field, equality of all held controls and exact agreement at fourteen shared-order fields. Native `UnifiedConstantsCertificate.allOriginalChecks` proves all five conclusions together [1–3].

## 2. The shared ranks and least covers

### 2.1. One, Fold and the distinct return generator

Structural One retains complete presented occurrence. Equal complementary parts satisfy \(h+h=1\), fixing half-One. Fold acts on exact positive parts through One by doubling below or at half-One and casting out a completed whole above it:
\[
 F(x)=\begin{cases}2x,&0<x\le1/2,\\2x-1,&1/2<x\le1.\end{cases}
\]
The two distinct fibre roles give complete binary word support: one initial empty word, then both label extensions of every earlier word. Disjointness of the last labels and retention of the preceding word prove \(|W_{d+1}|=2|W_d|\), hence \(|W_d|=2^d\). Its unique positive predecessor constructs the unit part \(u_d=1/(2^d-1)\). At depths two and three,
\[
 \tfrac13\mapsto\tfrac23\mapsto\tfrac13,
 \qquad
 \tfrac17\mapsto\tfrac27\mapsto\tfrac47\mapsto\tfrac17.
\]
No intermediate value equals the initial part. These are first returns of lengths two and three. Every whole count above two is at least three, and the displayed three-step return is attained. Any later count has this earlier witness, proving the unique least distinct successor generator \(g=3\).

### 2.2. Independent spatial and boundary ranks

The two fibre roles have four ordered pair cells. A spatial return distinct from the fibres requires its count to exceed two; retaining a positive restoring remainder before pair saturation requires it to remain below four. The complete whole-count census of \(2<s<4\) has the single member three. The source checks that it agrees with the independently obtained recurrence result.

For any independent three-direction carrier with one held normal, retain every nonnormal direction. If the complete list is \(L\mathbin{++}[\nu]\mathbin{++}R\), the boundary is exactly \(L\mathbin{++}R\). Every retained direction is spatial and differs from \(\nu\), and every such direction is retained. Its positive rank satisfies \(r+1=3\), uniquely giving \(r=2\). These all-count and all-position arguments are developed in [4] and formalized by `GeneratorThreeDerivation`, `SpatialStability` and `BoundarySupport`.

### 2.3. Cover construction and closure

The generated volumes are \(g^s=27\) and \(g^{s+1}=81\). Starting from binary support two, multiply by two until the support reaches the whole volume. Monotone binary succession and
\[
 2^4=16<27\le32=2^5,
 \qquad2^6=64<81\le128=2^7
\]
prove unique least depths five and seven. All smaller positive depths have still smaller support. The resulting blocks are
\[
 T_-=2^5=32,\quad T_+=2^7=128,
 \quad B=g^r=9,\quad C=b\,d_-^g=250.
\]
The independent arithmetic decompositions \(d_-=b+g\) and \(d_+=g+(g+1)\) agree. The least-cover argument and role-preserving block assembly fix the coefficients before sector reading.

## 3. The complete foundation-order vector

For the original dependency probe, let \(G\) be the supplied generator count. Binary \(b=2\), spatial rank \(s=3\), boundary rank \(r=2\) and half-One remain held. Define
\[
\begin{aligned}
 d(G)&=\min\{k>0:2^k\ge G^3\},\\
 u(G)&=\min\{k>0:2^k\ge G^4\},\\
 T_d&=2^{d(G)},\quad T_u=2^{u(G)},\\
 C_G&=2d(G)^G,\quad B_G=G^2.
\end{aligned}
\]
The source constructs its remaining exact readings by
\[
\begin{aligned}
 A_G&=T_u+B_G\frac{C_G+1}{C_G},\\
 P_G&=\frac1{2G^{d(G)}-1},\\
 Q_{-,G}&=\frac1{GT_d-1},\qquad
 Q_{+,G}=\frac1{GT_u-1},\\
 D_G&=\frac{G^3}{d(G)},\qquad f_{D,G}=\frac{G^3}{T_d},\\
 H_G&=1+\frac{(G-1)/G}{2^3},\\
 E_G&=\frac{T_u-1}{2},\qquad
 L_G=\frac1{2^{4d(G)}}.
\end{aligned}
\]
Each denominator predecessor is the unique positive count whose successor restores its complete support. These operations retain their original type and role: \(Q_-\) and \(Q_+\) are foundation cover readings, while the quark terminal products in Section 5 have their specified continuation depths.

At \(G=3\), direct substitution gives \(d=5,u=7,C_G=250,B_G=9\). In particular,
\[
 A_3=128+\frac{9\cdot251}{250}=\frac{34259}{250},
 \quad P_3=\frac1{2\cdot3^5-1}=\frac1{485},
 \quad H_3=1+\frac{2/3}{8}=\frac{13}{12}.
\]
The complete sixteen fields, including their generator-successor values, appear in Section 8. `UnifiedConstantsFoundation.foundationOrderVector` implements the actual source construction; `completeFoundationFields` proves the field count. The source helpers preserve the supplied binary cover argument and exact positive-power/predecessor operations.

## 4. Electromagnetic and charged-lepton continuations

### 4.1. Exhausting the three cover directions

The three interchangeable cover directions are promoted once each from depth five to depth seven. Their complete product ladder is
\[
 5^3=125,\quad5^2\cdot7=175,
 \quad5\cdot7^2=245,\quad7^3=343.
\]
After three promotions no unpromoted direction remains. The returning One is retained reciprocally through the ladder:
\[
 D=250+\cfrac1{175+\cfrac1{245+\cfrac1{343}}},
 \qquad
 \alpha^{-1}=128+9\frac{D+1}{D}
 =\frac{503846395469}{3676744786}.
\]
Thus \(\alpha=3676744786/503846395469\). This is the same native `AlphaRatio` operation imported by the unified terminal assembly [5].

### 4.2. The charged-lepton product

Complete five-direction colour support has \(3^5=243\) words. Both Fold labels give 486 states; removing the held reference leaves 485 nonreference positions. Their leading product reading is \(1/485\). Retaining the independently generated three-channel identity gives
\[
 P_{\ell,*}=\frac3{3\cdot485-1}=\frac3{1454}.
\]
The normalized root sum and pair sum remain \(S_1=1\) and \(S_2=1/6\). Expanding the square,
\[
 \sum_i x_i^2=(\sum_i x_i)^2-2\sum_{i<j}x_ix_j
 =1-\frac13=\frac23.
\]
Consequently the squared-root mass reading has exact Koide invariant \(2/3\).

The terminal self-coupling acts once at each of the three root roles, producing \(\alpha^3\); it is distributed over the complete volume \(3^3=27\). The down-depth contribution is five, and the up-depth contribution transports seven through three with one additional electromagnetic return. Hence the exact removed part and retained product are
\[
 \delta_\ell=\frac{\alpha^3}{27}\left(5+\frac73\alpha\right),
 \qquad P_{\ell,T}=\frac3{1454}-\delta_\ell.
\]
Equivalently, its fully expanded rational numerator and denominator are
\[
\begin{aligned}
 N_\ell&=15659709397871168801443815466454510956837000584115,\\
 D_\ell&=7590004776733382935404977537704409308185713931574254,\\
 P_{\ell,T}&=N_\ell/D_\ell.
\end{aligned}
\]
Only the triple product changes; the root sum and pair sum are retained. The cubic is \(x^3-x^2+x/6-P_{\ell,T}\). The unified object reads the original admitted terminal operation and retains its observational-derivation provenance and complete source comparisons [6]. `LeptonInvariants` and `LeptonTerminal` supply the exact native inputs; no new product coefficient is introduced by the shared object.

## 5. Quark products from the same covers

The lower-hand share is \(1/b^2=1/4\). The up channel count is \(g+g=6\), and the down channel count is \(g+1=4\). Their two equivalent pair-sum routes give
\[
 S_{2,u}=\frac1{b(g+g)}=\frac1{12}=\frac14\frac13,
 \qquad
 S_{2,d}=\frac1{b(g+1)}=\frac18=\frac14\frac12.
\]
The source checks both equalities. It also checks that the cover depths agree with the least-cover constructions. The down-sector reach is the admitted upper depth seven; the up-sector reach appends the generator count, giving ten. Complete binary support at these depths, with all three generator roles and one held reference removed, yields
\[
 P_d=\frac1{3\cdot2^7-1}=\frac1{383},
 \qquad P_u=\frac1{3\cdot2^{10}-1}=\frac1{3071}.
\]
The full invariants are \((1,1/8,1/383)\) and \((1,1/12,1/3071)\), with cubics \(x^3-x^2+S_2x-P\). The unified terminal vector reads the two product coordinates. `QuarkInvariants.exactChannels` and `exactCubics` prove both routes, depths and exact tuples. In particular the foundation \(1/95\) cover conjugate is not substituted for the terminal down-sector product; the exact original field identities are retained.

## 6. Cosmic ratios, hierarchy and vacuum

### 6.1. Dark and baryonic support

The volume 27 and depth five partition the complete 32-cell support:
\[
 f_B=5/32,\qquad f_D=27/32,\qquad f_B+f_D=1.
\]
Their leading ratio is \(27/5\). The support predecessor is 31. Its generated unit part has the first-return trace
\[
 \tfrac1{31}\mapsto\tfrac2{31}\mapsto\tfrac4{31}
 \mapsto\tfrac8{31}\mapsto\tfrac{16}{31}\mapsto\tfrac1{31}.
\]
Every earlier numerator differs from one. The original first-recursive reading retains the return \(1/31\) in the denominator:
\[
 R_{D/B,T}=\frac{27}{5+1/31}=\frac{837}{156}=\frac{279}{52}.
\]
These are the two source orders read by the unified vector. `CosmicRatios.darkExact` establishes the complete native record, including the trace.

### 6.2. Hubble calibration ratio

The leading matter and vacuum shares are \(1/3\) and \(2/3\), and the complete three-direction binary cover has eight cells. Therefore
\[
 R_{H,0}=1+\frac{2/3}{8}=\frac{13}{12}.
\]
The upper-depth predecessor is \(2^7-1=127\); its unit part successively visits numerators \(1,2,4,8,16,32,64,1\), so the first return has length seven. Retaining its exact return part gives
\[
 R_{H,T}=1+\frac{2/3+1/127}{8}
 =1+\frac{257}{3048}=\frac{3305}{3048}.
\]
This is a dimensionless calibration ratio. Its source assembly adds no dimensional rate datum. `CosmicRatios.hubbleExact` supplies the native exact record.

### 6.3. Planck hierarchy and charged-colour transport

The least upper binary cover has 128 positions. Its unique positive predecessor retains 127 massive positions. Complete binary support on those positions gives the squared hierarchy
\[
 \mathcal H^2=2^{127}
 =170141183460469231731687303715884105728.
\]
The corresponding exponent reading for the unsquared hierarchy is \(127/2\). The source charged-colour transport removes the exact share \((2/3)\alpha\), retaining
\[
 t=1-\frac23\alpha,
 \qquad0<t<1.
\]
Positivity follows from \(0<\alpha<1\); in fact \(0<(2/3)\alpha<2/3<1\). The terminal squared hierarchy is
\[
 \mathcal H_T^2=2^{127}\left(1-\frac23\alpha\right)
 =\frac{255923934603817488008405160690199418432572494970880}{1511539186407}.
\]
`PlanckHierarchy.massivePredecessorUnique`, `squaredHierarchyExact`, `terminalTransportStrict` and `exactTerminalHierarchy` retain these steps and the strict positive part.

### 6.4. Local vacuum floor and cosmic magnitude

Both Fold labels occur at each of the five covering levels, giving complete boundary-record depth \(2\cdot5=10\). The least nonempty amplitude on that support is
\[
 a_{\min}=2^{-10}=1/1024.
\]
Energy retains both observation legs, so the exact local floor is its self-composition:
\[
 \rho_{\rm local,min}=a_{\min}^2=2^{-20}=1/1048576.
\]
The global cosmic partition is a separately typed reading. In its complete 32-cell support, the two labels at five levels pin ten cells. The remaining 22 give
\[
 f_M=10/32=5/16,\qquad f_V=22/32=11/16,
 \qquad f_M+f_V=1.
\]
The positive successor count of boundary pairs obeys \(p_{n+1}=p_n+2\), so \(p_n=2n\), giving the ten pinned cells at five levels. `CosmoCompleteBudget` proves this count and both complete partition closures. The three-space rate multiplicity then gives the normalized cosmological reading
\[
 \Lambda(c/H)^2=3f_V=33/16.
\]
The local amplitude floor, local energy floor and global fraction retain different carriers and types; the unified object records their exact source readings. `VacuumDensity.completeBoundaryTen`, `amplitudeFloorExact`, `energyFloorExact` and the normalized magnitude operation establish the native values.

## 7. The full terminal vector and shared-order equality

The terminal assembly imports the completed sector operations and retains all twenty-six original fields. In the table, \(P_{\ell,T}\) and \(\mathcal H_T^2\) denote the fully specified exact expressions above; \(2^{127}\) is the exact integer displayed in Section 6.

| Original reading | Exact value |
|---|---|
| Binary fibre count | 2 |
| Generator count | 3 |
| Spatial rank | 3 |
| Boundary rank | 2 |
| Down cover depth | 5 |
| Up cover depth | 7 |
| Inverse alpha, leading | 34259/250 |
| Inverse alpha, terminal | 503846395469/3676744786 |
| Charged-lepton product, leading | 1/485 |
| Charged-lepton product, sharpened | 3/1454 |
| Charged-lepton product, terminal | \(P_{\ell,T}\) |
| Down-quark product, terminal | 1/383 |
| Up-quark product, terminal | 1/3071 |
| Dark/baryon ratio, leading | 27/5 |
| Dark/baryon ratio, terminal | 279/52 |
| Dark share, leading | 27/32 |
| Baryon share, leading | 5/32 |
| Hubble ratio, leading | 13/12 |
| Hubble ratio, terminal | 3305/3048 |
| Hierarchy exponent | 127/2 |
| Squared hierarchy | \(2^{127}\) |
| Squared hierarchy, terminal | \(\mathcal H_T^2\) |
| Local vacuum amplitude floor | 1/1024 |
| Local vacuum energy floor | 1/1048576 |
| Normalized cosmological magnitude | 33/16 |
| Half-One | 1/2 |

Fourteen named fields belong to both the independently reconstructed foundation order and the admitted terminal vector: the six primary counts and cover depths, leading inverse alpha, leading charged-lepton product, leading dark/baryon ratio, leading dark share, leading Hubble ratio, hierarchy exponent, local vacuum energy floor and half-One. Each pair of exact typed values is equal. Their field names, integer/fraction distinctions and rational numerator/denominator values are preserved by `sameFields`. `UnifiedConstantsTerminal.originalLeadingTerminalEquality` proves the complete conjunction; `originalTwentySixFields` and `originalFourteenSharedFields` prove the two counts.

## 8. The complete generator-successor probe

The original probe evaluates the same foundation construction at \(G=3\) and \(G=4\), holding binary two, spatial rank three, boundary rank two and half-One fixed. It is a dependency test on the original formula inputs. At four, the covers are fixed by
\[
 2^5<4^3=64\le2^6,\qquad
 2^7<4^4=256\le2^8,
\]
so \(d(4)=6\) and \(u(4)=8\). Its complete cover is \(2\cdot6^4=2592\), boundary factor \(4^2=16\), and leading inverse reading is
\[
 256+16\frac{2593}{2592}=\frac{44065}{162}.
\]
The other rows follow by the exact formulas of Section 3. Every field is shown:

| Foundation field | Generator 3 | Generator 4 | Original role |
|---|---|---|---|
| Binary fibre count | 2 | 2 | Held control |
| Generator count | 3 | 4 | Changes |
| Spatial rank | 3 | 3 | Held control |
| Boundary rank | 2 | 2 | Held control |
| Down cover depth | 5 | 6 | Changes |
| Up cover depth | 7 | 8 | Changes |
| Inverse alpha, leading | 34259/250 | 44065/162 | Changes |
| Charged-lepton product, leading | 1/485 | 1/8191 | Changes |
| Down cover conjugate | 1/95 | 1/255 | Changes |
| Up cover product | 1/383 | 1/1023 | Changes |
| Dark/baryon ratio, leading | 27/5 | 32/3 | Changes |
| Dark share, leading | 27/32 | 1 | Changes |
| Hubble ratio, leading | 13/12 | 35/32 | Changes |
| Hierarchy exponent | 127/2 | 255/2 | Changes |
| Local vacuum energy floor | 1/1048576 | 1/16777216 | Changes |
| Half-One | 1/2 | 1/2 | Held control |

The twelve changing rows include the supplied generator itself, both cover depths and the nine dependent rational readings. The four held controls are exactly those specified by the source. Equality or inequality is decided on the original integer/fraction types with exact reduced rationals. Thus the result is the complete source predicate, not a test of a selected subset or a rounded decimal difference. `UnifiedConstantsFoundation.originalGeneratorChangeAndHeldControls` proves the pair of conclusions together; `allTwelveDependents` proves the designated dependent-field count.

## 9. The complete rooted graph

The graph is the original parent-to-child incidence object. All ten parent rows are:

| Parent | Complete child list |
|---|---|
| One | Fold |
| Fold | binary fibre count, generator count |
| binary fibre count | down cover depth, up cover depth, half One |
| generator count | spatial rank, lepton sector, quark sector, cosmic partition |
| spatial rank | boundary rank, down cover depth, up cover depth |
| boundary rank | fine structure sector, vacuum sector |
| down cover depth | fine structure sector, lepton sector, dark baryon sector, vacuum sector |
| up cover depth | fine structure sector, quark sector, hubble sector, planck sector |
| fine structure sector | lepton sector, quark sector, planck sector |
| cosmic partition | dark baryon sector, hubble sector, vacuum sector |

Parent and child identity gives seventeen distinct nodes. Each edge is retained in source order. The native construction accepts the graph and proves the node count. Explicit paths from One to the seven sector nodes are:

| Sector | Complete path |
|---|---|
| Fine structure | One → Fold → binary fibre count → down cover depth → fine structure |
| Charged leptons | One → Fold → generator count → lepton sector |
| Quarks | One → Fold → generator count → quark sector |
| Dark/baryon | One → Fold → binary fibre count → down cover depth → dark/baryon sector |
| Hubble | One → Fold → binary fibre count → up cover depth → Hubble sector |
| Planck hierarchy | One → Fold → binary fibre count → up cover depth → Planck sector |
| Vacuum | One → Fold → binary fibre count → down cover depth → vacuum sector |

Every adjacent pair in each path occurs in the parent table. The general native path-witness theorem turns each complete witness into reachability; `sectorReachable0` through `sectorReachable6` instantiate it, and `allSevenReachable` joins them. The seven incoming parent-row counts are respectively dark/baryon two, fine structure three, Hubble two, lepton three, Planck two, quark three and vacuum three. Each is positive. `everySectorHasIncoming` proves the original incidence condition.

Reachability preserves common ancestry. The formulas and shared-field equalities establish what numerical carrier each graph edge transports. The generator probe supplies the separate computational test of dependence. These three parts together are the original rooted constants certificate.

## 10. Exhaustive grammar and the complete certificate

The source grammar is the full product of twelve binary axes. Every candidate chooses one constructor on each axis, giving \(2^{12}=4096\) forms. The original preserving and rejected choices are:

| Axis | Preserving construction | Rejected alternative |
|---|---|---|
| root | single One root | disconnected constant list |
| fold | Fold generated binary and generator | borrowed numerals |
| covers | least binary covers of generated volumes | selected depth labels |
| typing | shared carrier incidence | untyped number coincidence |
| leading | complete registered foundation vector | selected headline values |
| terminal | root preserving terminal continuations | replacement values with new roots |
| graph | connected rooted dependency graph | sector local formulas only |
| mutation | complete generator successor probe | decorative shared labels |
| control | binary and rank held controls | blanket global mutation |
| measurement | formal object sealed before comparison | measurement assembled object |
| extension | append traced node | rewrite existing object |
| rule | no extra rule | free extra rule |

For an arbitrary candidate, each coordinate belongs to its two-constructor domain. Repeated Cartesian membership proves that the complete tuple occurs in the census. The original criteria require the rooted graph, generated Fold counts, least covers, typed sector readings, complete foundation and terminal vectors, exact dependency changes, all held controls, retained source classification and absence of an added free rule. Source decision equals the conjunction of these criteria for every tuple. If it is true, all coordinates equal their preserving constructors, so the tuple equals the preserving candidate. Conversely that tuple satisfies the full conjunction. Hence
\[
 \forall c,\quad\operatorname{survives}(c)=\mathrm{true}
 \Longleftrightarrow c=c_*.
\]
The native complete census is partitioned into 128 exhaustive blocks of 32 tuples. The aggregate `sourceDecisionMatchesCriteria` and `uniqueSurvivor` join every block; this partition does not remove a constructor or restrict the scientific carrier. Coordinate-specific rejection theorems retain each original alternative's failure.

The eight-field certificate then assembles the three vectors and five conclusions. Its checks use the actual field operations and graph witnesses. The original independent validator separately recomputes the foundation probe and graph against the declared dependency registrations and certificates. Complete retained adverse cases include omitted candidates and an added survivor; the native program retains original control outputs and unknown-identifier refusal.

This entry has the source's formal evidence mode. Sector empirical receipts and provenance remain attached to their original entries; constructing the shared object introduces no new measurement or independently adjustable coefficient.

## 11. Native evidence and reproduction

The completed source entry is `SFT-PHYS-UNIFIED-CONSTANTS-OBJECT-077`, with receipt `TURN_515_UNIFIEDCONSTANTS_COMPLETION`. Original V3 is pinned to commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The public V4 source used here is edition 0.4, commit `21cdf559922fb057f8560f42d056ffa035329eb3` [3].

The principal native families are `UnifiedConstantsHelpers`, `UnifiedConstantsFoundation`, `UnifiedConstantsTerminal`, `UnifiedConstantsGraph`, `UnifiedConstantsCertificate`, the full grammar and census modules, controls and evidence. The retained audit covers 434 declarations with zero axiom dependencies. The complete native program comparison matches all 4,096 identifier decisions, trace/proof hashes, exact records, closure, controls and registration fields. The recorded helper/foundation comparison covers 264 cases, including source errors, supplied cover binary and accepted generator inputs 3, 4, 5 and 8. The source-field comparison retains all 26 terminal, 16 foundation, 16 successor and eight certificate fields, all ten graph rows and seventeen reachable nodes.

The accompanying reproduction script executes the unchanged original pure functions in separate module namespaces with the original import bindings. It reproduces all vectors and five certificate conclusions, the graph and incoming counts, and the complete twelve-axis product. The archive retains the original execution binding and generated independent validator, all declared dependency registration/certificate inputs, native proof modules and imports, complete source-output reports and audit evidence. `SOURCE_CORRESPONDENCE.json` records the precise sources and digests. No scientific source or native proof was changed for this paper.

## References

1. Smith, Maria. **Smithian Fold Theory V3 physics.** https://doi.org/10.5281/zenodo.21761655.
2. Smith, Maria. **SFT V3 monograph.** https://doi.org/10.5281/zenodo.21900790. Original shared-object source: `sft/physics/unified_constants_object_law_v1.py`, with exact execution and validator bindings in the accompanying archive.
3. Smith, Maria. **Native Lean V4, edition 0.4.** https://doi.org/10.5281/zenodo.24320778. Pinned native source: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics.
4. Smith, Maria. **Why the Fold construction gives generator three, three spatial dimensions and boundary rank two.** https://doi.org/10.5281/zenodo.24325335.
5. Smith, Maria. **The fine-structure constant from first principles: an exact zero-parameter Fold derivation.** https://doi.org/10.5281/zenodo.24324400.
6. Smith, Maria. **Charged-lepton mass ratios and the exact Koide invariant from Fold geometry**, version 1.1. https://doi.org/10.5281/zenodo.24325169.
7. Smith, Maria. **Twelve Smithion mass-ratio predictions and the dark-to-baryonic abundance from Fold geometry.** https://doi.org/10.5281/zenodo.24324894.
8. Smith, Maria. **Operational foundation.** https://doi.org/10.5281/zenodo.21627656.

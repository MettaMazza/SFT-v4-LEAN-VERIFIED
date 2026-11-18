# Connected molecular electronic support, exchange and delocalization

Maria Smith · Ernos Labs  
18 November 2026 · Version 1.1 · DOI: 10.5281/zenodo.24354515

Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com) · SFT Discord: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

An admitted SFT multicentre molecular support retains a connected graph and one complete electron-support word containing every registered centre exactly once. Its word has at least three cells and cannot equal a localized two-cell word. Attaching a fresh centre to a retained anchor preserves graph connectivity and complete word incidence; additional registered edges preserve connectivity. We derive this construction together with exact electron counting, the unique pair-plus-unmatched spin decomposition, complete orbital occupancy, complementary exchange sectors, alternating conjugated incidence and equivalent resonance representations. Separated-centre joint support contains exactly two complementary words, while the independent Cartesian carrier has four. The full arguments retain the original source domains, guards, identities and observation boundaries. Eight completed native Lean entries supply 91 entry modules and 1,459 distinct empty-axiom audited definitions and theorems. Retained source comparisons and a portable reproduction connect the mathematical statements to the original V3 operations and published V4 proofs.

## 1. Connected support retains the complete molecular word

The original multicentre constructor receives

\[
S=(M,T,V,E,w),
\]

where \(M\) is a held molecular carrier, \(T\) a source topology, \(V\) an ordered list of distinct molecular centres, \(E\) an undirected edge list and \(w\) the electron-support word. Successful admission requires \(|V|\geq3\), distinct endpoints in every edge, no repeated unordered edge, endpoint membership in \(V\), connectivity, and exact ordered equality \(w=V\). The source topologies and their additional guards are given in Section 2.

The constructor therefore establishes

\[
|w|=|V|\geq3,\qquad
\forall x\in w,\ x\in V,\qquad
w\ne[a,b]\quad\text{for all held }a,b.
\]

The last statement follows immediately: equality with a two-cell list would give \(|w|=2\), contradicting \(|w|\geq3\). Native `MulticentreDerivation.acceptedMeaning` extracts the count and complete-word equality from the actual successful constructor. Induction on the two word lists proves `sameWordLength` and `sameWordCellsInside`; `acceptedIrreducible` and `acceptedWordNotPair` then give the source's irreducibility result. These are statements about the entire admitted support, including its centre identities and order [1–3].

The source connectivity procedure begins with the first centre reached. A scan visits every edge; whenever one endpoint is reached, it adjoins both endpoints. Let \(F_E(R)\) denote this scan. Each step preserves the reached prefix, adds no duplicate identity and retains only registered centres. Hence

\[
R\subseteq F_E(R)\subseteq V,\qquad
|R|\leq|F_E(R)|\leq|V|.
\]

If the size does not increase, the retained-prefix property gives \(F_E(R)=R\). Otherwise at least one previously unreached centre is added. Starting from one centre, strictly increasing scans can occur at most \(|V|-1\) times. The native counted scan consequently reaches exactly the original source fixed point. `MulticentreConnectivity.scanBoundReachesFixedPoint` proves this by induction on the remaining count, using the upper cardinality bound. `acceptedInitialScanRunsOriginal` connects the successful constructor to the original stopping operation.

Now let \(a\in V\) be a retained anchor and \(x\notin V\) a fresh centre. Define

\[
V'=V\mathbin{+\!+}[x],\qquad
E'=E\mathbin{+\!+}[(a,x)],\qquad
w'=w\mathbin{+\!+}[x].
\]

Every old centre remains reachable through the old edges. Since the anchor is reached, scanning the new edge reaches \(x\). No new centre lies outside \(V'\); therefore the reached set is exactly \(V'\). Appending the same cell to equal words gives \(w'=V'\). This is the quantified theorem `acceptedConnectedWordSuccessor`, for every accepted source support, retained anchor and fresh centre. Its proof invokes `connectedFreshCentre` and `sameWordFreshExtension`. Further edges whose endpoints lie in \(V'\) cannot remove reachability; `connectedFreshCentreWithAdditionalEdges` establishes the corresponding extension. The complete topology constructor also applies the topology-specific degree guards below.

## 2. Paths, cycles and branched support

For a connected admitted graph, let \(d(v)\) be the number of incident retained edges. The original topology guards are:

| Topology | Exact additional source conditions |
|---|---|
| Ribbon path | \(|E|+1=|V|\); exactly two vertices have degree one; every degree is one or two |
| Surface cycle | \(|E|=|V|\); every degree is two |
| Volume polyhedron | \(|V|\geq4\); \(|E|>|V|\); some degree is at least three |

The path conditions produce a connected sequence with two ends and no branch. The cycle conditions produce a connected closed sequence. The third row is the original combinatorial branch criterion attached to the volume label. Each constructor retains \(w=V\), so topology and electron-support incidence are checked together.

For the original diborane bridge, the retained centres are B-left, H-bridge and B-right, with the two consecutive edges. Thus

\[
|V|=3,\quad |E|=2,\quad(d_1,d_2,d_3)=(1,2,1).
\]

The benzene support is the six-centre cycle, with six edges and six degrees equal to two. The tetrahedrane support retains four centres and all six distinct pairs, giving degrees \((3,3,3,3)\). The source witnesses check these complete objects and reject a two-centre localized input and a disconnected three-centre input. Native `MulticentreSupport.bridgeWitnessPassed`, `cycleWitnessPassed`, `volumeWitnessPassed`, `localizedWitnessPassed` and `disconnectedWitnessPassed` preserve those decisions.

## 3. Exact electron census and unique spin decomposition

For nuclear populations with positive atomic numbers \(Z_i\) and positive occurrence counts \(n_i\), the neutral electron census is

\[
N_0=\sum_i Z_i n_i.
\]

Charge is represented by a held direction and positive transfer count, or by structural empty One. Neutral transfer retains \(N=N_0\); adjoining \(t>0\) gives \(N=N_0+t\); removing \(t>0\) gives \(N=N_0-t\) with the original guard \(t<N_0\). Nuclear support is nonempty, so the admitted count remains positive.

For a supplied positive spin width \(m\), put \(u=m-1\). The source admits the organization exactly when

\[
u\leq N,\qquad N-u\equiv0\pmod2,
\]

and constructs

\[
p=\frac{N-u}{2},\qquad N=2p+u,\qquad m=u+1.
\]

Here \(p\) counts complementary two-fibre cells and \(u\) counts unmatched single-fibre cells. An absent count is retained by the original structural empty constructor. The generated cells and distinct occurrence identities exhaust the entire electron support.

The division algorithm gives \(N-u=2\lfloor(N-u)/2\rfloor\) under the evenness guard; adding \(u\) proves exhaustion. If another count \(q\) satisfies \(2q+u=N\), cancellation gives \(2q=2p\), hence \(q=p\). Therefore the pair count is unique. Reduction modulo two yields

\[
N\equiv u\pmod2,\qquad m\equiv N+1\pmod2.
\]

Even electron support therefore has odd positive width, and odd support has even positive width. The successor equations are exact:

\[
2(p+1)+u=(2p+u)+2,\qquad
2p+(u+1)=(2p+u)+1.
\]

`ElectronCountSpin.generatedPairsExhaust`, `generatedPairCountUnique`, `supportParity`, `widthParity`, `complementaryPairSuccessor` and `unmatchedSuccessor` prove these statements for arbitrary admitted counts.

## 4. Orbital incidence and complete occupancy

A source molecular support cell retains the molecular carrier, positive radial recurrence, axis recurrence, one of two joining phases, and held exchange/reflection observations. The first positive axis ordinal corresponds to structural empty One; every later ordinal \(n>1\) corresponds to the positive recurrence \(n-1\). At fixed molecular, radial and axis coordinates, joining constructs exactly two cells, with phases A and B and the source empty observations.

An occupied cell has distinct electron occurrences \(E\) and matching spin fibres \(F\), with

\[
1\leq|E|\leq2,\qquad |F|=|E|.
\]

For double occupancy, the two fibres must be complementary. The available fibre set is exactly \(\{A_s,B_s\}\), so a two-cell admitted fibre list contains one of each. A complete molecular support holds occupied cells of the same molecule, distinct cell coordinates and the full occurrence partition

\[
E_{\mathrm{all}}=E_1\mathbin{+\!+}\cdots\mathbin{+\!+}E_k,
\qquad |E_{\mathrm{all}}|=N,
\]

with no repeated occurrence identity. Appending an occupied cell gives the exact successor count

\[
|E_{\mathrm{all}}\mathbin{+\!+}E_{k+1}|
=|E_{\mathrm{all}}|+|E_{k+1}|.
\]

The native `completeCensusExact` and `completeOccurrencesDistinct` extract these properties from successful complete admission. `singleOccurrenceBase` constructs the one-occurrence base; `occurrenceCensusSuccessor` proves the append equation. `joinedPairExact` preserves the two-phase construction at every admitted coordinate. The radial and positive-axis successor theorems show that incrementing either exact coordinate changes the retained cell: equality would force a positive successor count to equal its predecessor.

The electron census, occupied cells and pair decomposition are thus separate, explicitly connected records. Counts are established by complete occurrence lists, and repeated identities are rejected by the original constructor.

## 5. Exchange sectors and same-cell support

The retained two-electron spin census contains three preserving words and one alternating word. Its widths are therefore

\[
|C_P|=3,\qquad |C_A|=1,\qquad |C_P|+|C_A|=4.
\]

Write \(P\) and \(A\) for the original preserving and alternating held exchange labels. The complete composition table is

| \(\circ\) | \(P\) | \(A\) |
|---|---|---|
| \(P\) | \(P\) | \(A\) |
| \(A\) | \(A\) | \(P\) |

The total identical-electron exchange is alternating. Consequently the spin and spatial labels must be complementary: equal labels would compose to \(P\), while either unequal pair composes to \(A\). The source multiplicity constructor has exactly two admitted cases:

| Spin width | Spin exchange | Spatial exchange | Same-cell status |
|---:|---|---|---|
| 1 | Alternating | Preserving | Admitted |
| 3 | Preserving | Alternating | Excluded |

`PairExchange.originalSpinSectorWidths` reuses the complete native spin census. The four exchange-product theorems prove every table entry. `fromMultiplicity` constructs the complementary labels and validates total exchange and same-cell status. A single occupant is compatible; two occupants require the admitted same-cell status; a third occupant is rejected. A same-support pair retains one molecular and orbital-support identity, distinct state identities, widths one and three, and complementary spatial labels.

## 6. Conjugated incidence and equivalent resonance representations

A conjugated support contains one molecular carrier, \(n\geq3\) distinct ordered atom occurrences and exactly \(n-1\) adjacent support fibres. Each fibre is one of two held labels and neighbours alternate. Its complete incidence is

\[
(a_0,f_0,a_1),\ (a_1,f_1,a_2),\ldots,
(a_{n-2},f_{n-2},a_{n-1}).
\]

For a fresh atom \(a_n\), the successor must append the fibre opposite to \(f_{n-2}\). There are exactly two admitted labels. If the old label is the first, opposition forces the second; if it is the second, opposition forces the first. These two cases prove `ConjugatedSupport.opposedChoiceUnique`. Appending increases atom and fibre counts by one, preserving

\[
(n-1)+1=n=(n+1)-1.
\]

Earlier incidences are retained because indexing an appended list within its old length returns the original element. `labelAtPrefix` proves this by induction; `retainedSourceIncidence` applies it to every old atom–fibre–atom triple. The operational successor theorem retains the original freshness, label and admission checks.

A resonance encoding retains its own encoding identity, molecular carrier, complete ordered atom list, complete adjacency and one fibre per adjacency. A pair of equivalent representations has distinct encoding identities but identical carrier, atoms and adjacency. Its second fibre word is the complete complement of the first:

\[
R_1=(e_1,M,V,E,F),\qquad
R_2=(e_2,M,V,E,\overline F),\qquad e_1\ne e_2.
\]

Complement exchanges the two held labels at every position. A successful shared successor appends the same fresh atom to both atom lists, an edge from each retained final atom to that fresh atom, and the opposed next fibre to each word. Complementary final fibres have complementary opposites, preserving the complete complement relation. `ResonanceEquivalent.admittedPairComplement` derives the relation from the actual pair validator; `successfulSharedExtension` proves all resulting field equations and successful final pair admission. Neither encoding identity nor any predecessor atom, edge or fibre is discarded.

## 7. Joint separated-centre support and dissociation records

Let \(L\ne R\) be retained product centres and let the two electron fibres be lower and upper. Independent marginal assignment gives

\[
\{L,R\}\times\{L,R\}
=\{(L,L),(L,R),(R,L),(R,R)\},
\]

with cardinality four. The source joint support retains exactly the complementary cross-centre assignments

\[
J=\{(L,R),(R,L)\},\qquad |J|=2.
\]

Each assignment is a complete ordered word containing both fibre labels and both centre labels. Its two marginal supports are both \(\{L,R\}\), but their Cartesian product contains the two excluded same-centre words. Thus \(J\) is not that product. The accepted constructor cannot return one, three or four words: it checks exactly the two required complete words. `JointCorrelationSupport.acceptedJointCardinality` proves the resulting cardinality, and `acceptedNonfactorizable` establishes the source predicate. Original adverse witnesses reject a missing complementary word, the four-word product and indistinguishable centres.

The registered dissociation comparison retains this two-versus-four prediction together with a positive external energy separation and either a positive uncertainty or structural absence. Each observation keeps source, species, state, role and unit identities. The exact observed separation is stored as

\[
D=\frac{n_D}{d_D},\qquad n_D,d_D>0,
\]

and a present uncertainty has the same positive-ratio form. The source comparison checks the joint and Cartesian counts against the sealed structural prediction and checks equality of the reconstructed energy and uncertainty with the retained external row. `JointCorrelationObservation.acceptedEnergyRatio`, `acceptedUncertainty` and `JointCorrelationComparison.compare` preserve this exact observation boundary. The original record contains twelve empirical protocol fields and thirty measurement messages.

## 8. Molecular state composition

The source rovibronic state holds an electronic state, ordered unique nuclear occurrences, one isotope label per occurrence, positive vibrational and rotational ordinals, a spin label and an observation label. For positive ordinals \(v,j\), the retained recurrences are

\[
V(v)=2v-1,\qquad R(j)=j(j+1).
\]

In the native proof these are stated with \(v=n+1\) and \(j=n+1\), giving \(2n+1\) and \((n+1)(n+2)\). `MolecularRovibronicState.vibrationalValue` and `rotationalValue` reuse the existing general molecular-ladder results. Its complete key is

\[
K=(M,\ I,\ V(v),\ R(j),\ s,\ o),
\]

where \(I\) is the ordered isotope-label vector. `completeKey` preserves all six fields. The original isotopologue comparison first requires the same molecular carrier class, then compares these complete keys. Electronic organization, isotope identity, recurrence, spin and observation remain explicitly represented in the composed state.

## 9. Native proof and source verification

### 9.1 Original coordinate carriers

The eight source laws each enumerate eight binary coordinates. Each table below gives its own original coordinates and alternatives, in source order; spaces replace source label separators. A candidate contains exactly one constructor from every row. The tables are the literal `DIMENSIONS` of the V3 files named beneath each heading. [1]

<p style="break-after: avoid"><strong>MolecularRovibronicGrammar</strong> · <code>rovibronic_composition_derivation.py</code></p>

| Coordinate | Rejected alternative | Admitted alternative |
|---|---|---|
| carrier | detached state name | identified molecular state carrier |
| composition | nuclei or electrons erased | nuclear electronic joint support |
| scale | imported separation approximation | admitted electronic vibrational rotational order |
| vibration | continuum vibrational coordinate | positive odd vibrational recurrence |
| rotation | signed or continuum rotation | positive counted rotational recurrence |
| spin | spin erased state | held spin state |
| observation | result without readout record | retained rovibronic observation |
| extension | free species exception | no extra rule |

<p style="break-after: avoid"><strong>ElectronCountSpinGrammar</strong> · <code>electron_count_spin_law_v1.py</code></p>

| Coordinate | Rejected alternative | Admitted alternative |
|---|---|---|
| nuclear support | formula name only | atomic number occurrence support |
| charge | signed charge scalar | held directed electron transfer |
| electron count | asserted electron number | complete electron occurrence census |
| spin | signed spin magnitude | two held spin fibres |
| occupation | same fibre cell duplication | complementary cell occupation |
| decomposition | unstructured spin list | complete pairs plus held surplus |
| observation | state width detached from support | support compatible spin width |
| extension | species specific exception | no extra rule |

<p style="break-after: avoid"><strong>OrbitalSupportGrammar</strong> · <code>orbital_support_law_v1.py</code></p>

| Coordinate | Rejected alternative | Admitted alternative |
|---|---|---|
| carrier | free orbital name | molecule bound support cell |
| joining | unjoined atomic support list | two held joining phases |
| axis | continuum angular coordinate | empty One or positive axis recurrence |
| symmetry | unsigned erased symmetry | held exchange and reflection labels |
| occupancy | signed or unbounded occupation | empty One single or complementary pair |
| spin | same fibre double occupation | complementary spin double occupation |
| completeness | selected support fragment | complete electron support partition |
| extension | species or symbol exception | no extra rule |

<p style="break-after: avoid"><strong>PairExchangeGrammar</strong> · <code>pair_exchange_law_v1.py</code></p>

| Coordinate | Rejected alternative | Admitted alternative |
|---|---|---|
| carrier | cross molecule pair | one molecule electron pair |
| identity | named distinguishable electrons | exchange equivalent constituents |
| total | free total exchange label | alternating total word |
| spin | imported spin sign function | complete one and three spin sectors |
| composition | independent spin and space labels | complementary spin spatial fibres |
| same cell | selected occupancy cap | spatial exchange controlled occupation |
| record | selected favourable spin states | complete state and exchange pair record |
| extension | species or energy order exception | pairwise successor with no extra rule |

<p style="break-after: avoid"><strong>JointCorrelationGrammar</strong> · <code>joint_correlation_law_v1.py</code></p>

| Coordinate | Rejected alternative | Admitted alternative |
|---|---|---|
| carrier | unbound energy only record | bound carrier and product support |
| support | independent single product word | complete complementary joint support |
| relation | marginals declared complete | nonfactorizable held joint relation |
| exchange | named electron product assignment | held fibre exchange pair |
| transition | dissociation as disconnected lookup | bound to separated support transition |
| energy | fitted correlation correction | positive post seal separation record |
| record | selected single isotopologue | complete measurement and provenance vector |
| extension | species specific correlation rule | pairwise successor with no extra rule |

<p style="break-after: avoid"><strong>MulticentreSupportGrammar</strong> · <code>multicentre_support_law_v1.py</code></p>

| Coordinate | Rejected alternative | Admitted alternative |
|---|---|---|
| carrier | isolated bond list | complete molecular carrier |
| centres | two centre only premise | three or more generated centres |
| support | localized edge identities | one complete extended support |
| connection | disconnected centre union | connected generated graph |
| topology | imported or single topology | ribbon surface volume census |
| reduction | pairwise model declared complete | multicentre irreducible support |
| record | selected example only | complete authority and geometry vector |
| extension | species specific extra rule | connected successor with no extra rule |

<p style="break-after: avoid"><strong>ConjugatedSupportGrammar</strong> · <code>conjugated_support_law_v1.py</code></p>

| Coordinate | Rejected alternative | Admitted alternative |
|---|---|---|
| carrier | selected unbound bond marks | one retained molecular subcarrier |
| connectivity | disconnected support fragments | complete connected adjacency path |
| fibres | bond support label erased | two forced held support fibres |
| alternation | arbitrary adjacent fibre repetition | exact opposed adjacent fibre recurrence |
| coverage | favourable subpath only | complete atom and incidence support |
| propagation | independent bond pairs | shared centre support propagation |
| observation | spectrum or name selects structure | structure sealed before external observation |
| extension | named conjugation exception | opposed fibre successor no extra rule |

<p style="break-after: avoid"><strong>ResonanceEquivalentGrammar</strong> · <code>resonance_equivalent_representation_law_v1.py</code></p>

| Coordinate | Rejected alternative | Admitted alternative |
|---|---|---|
| carrier | different molecular carriers | one retained molecular carrier |
| atoms | atom occurrence change | complete equal atom occurrence support |
| adjacency | connectivity change | complete equal adjacency support |
| encodings | one encoding only | multiple distinct encoding identities |
| fibres | partial or arbitrary label change | complete opposed fibre complement |
| identity | representations counted as species | one carrier many representations |
| process | equilibrium or transition imported | representation relation only |
| extension | named resonance exception | shared complement successor no extra rule |

### 9.2 Complete enumeration and forcing of the preserving tuple

Write the two constructors in each displayed row as \(D_i=[r_i,a_i]\). Beginning with one empty tuple, append both constructors from each successive row to every preceding tuple. Induction proves completeness: any next tuple consists of an already generated prefix and one of the two displayed next constructors. Every generated tuple has precisely that form. The product therefore contains \(2^8=256\) candidates per law and \(8\cdot256=2,048\) decisions across the eight laws.

The original decision tests the corresponding row conditions in order. Acceptance requires all eight admitted constructors, while the all-admitted tuple passes every test. Thus
\[
 \operatorname{survives}(c)=\mathrm{true}
 \iff \bigwedge_{i=1}^{8}(c_i=a_i)
 \iff c=(a_1,\ldots,a_8).
\]
Field equality gives the final equivalence. A rejected coordinate in a purported survivor would equal its distinct admitted constructor, a contradiction. This establishes both existence and uniqueness without omitting a candidate.

Each native module named above supplies `candidatesComplete`, constructing membership through seven nested products and a final map; `generatedCardinality` gives its exact length. `sourceDecisionMatchesCriteria` checks the actual source decision against the coordinate conditions. Where the case split is partitioned, all sixteen four-coordinate prefixes are present and all sixteen remaining suffixes are checked in each block. `uniqueCriteriaSurvivor`, `uniqueSurvivor` and `acceptanceIffExactCriteria` establish the displayed equivalences by constructor exhaustion and field equality. [2]

### 9.3 Operational successors and retained observations

These preserving forms accompany the concrete derivations above. A nuclear population contributes its exact atomic-number product; a directed transfer acts on the full count. Complementary pairs and unmatched fibres then exhaust the resulting support uniquely, with the exact pair and single successors in Section 3. Orbital support appends complete occurrence lists and retains their census and identity guards. Conjugated support appends the unique opposed fibre and preserves every earlier indexed incidence. The shared resonance operation retains both encoding identities, the common appended atom and edge, and the complementary words through its original admission checks. Multicentre support appends a fresh centre at a retained anchor: the bounded source scan reaches the old graph and then the new centre, while the complete electron word appends the same identity. Further registered edges preserve reachability. Pair exchange exhausts its four products, and the separated-centre constructor retains exactly its two complete complementary words. Rovibronic composition retains the six-field key and the existing arbitrary-ordinal recurrence proofs. [1,2]

The observation coordinates retain their stated source comparisons: spectroscopy and isotope identity, complete electron and orbital occurrences, exchange-state and same-support rows, the positive dissociation record, complete topology and geometry rows, conjugated response and equivalent-representation records. Their extraction, prediction and comparison evidence is retained below. The source choices are tested against these records after sealing; the explicit operational proofs establish the count, identity, incidence and successor statements used by the preserving forms.

| Completed source entry | Entry modules | Audited declarations |
|---|---:|---:|
| Rovibronic composition | 7 | 131 |
| Electron count and spin | 14 | 197 |
| Orbital support and occupancy | 12 | 165 |
| Conjugated support | 12 | 188 |
| Equivalent resonance representations | 12 | 183 |
| Pair exchange | 11 | 181 |
| Joint correlation and dissociation | 11 | 179 |
| Multicentre delocalized support | 12 | 235 |
| Total | 91 | 1,459 |

The accompanying source archive includes 512 native modules with imports. All entry-module digests agree with their completion receipts and published source. Empty-axiom evidence covers all 1,459 distinct audited definitions and theorems: 1,355 names appear in retained raw audit logs, and the remaining 104 are included in the retained 165-declaration orbital audit report whose complete module digests agree with this package.

Source-programme comparisons retain complete candidate records, controls, closure and canonical hashes. Empirical comparisons preserve original identities, extraction, prediction, release and measurement fields. Examples include the 360-row orbital target support, 46 pair-exchange state rows and 20 multicentre target rows; pair exchange and multicentre retain eighty and forty-one measurement messages, respectively. These original observation records accompany the actual derivations and native proofs.

The portable reproduction executes the pinned original functions and exact value classes. It checks all 1,096 undirected graphs on three through five labelled centres, 3,804 connected fresh attachments, sixty path/cycle constructions, the six-edge tetrahedral object, 1,088 admitted spin organizations, all four exchange products, the two joint words and thirty-two shared resonance successors. The general statements are the retained native theorems; these executable comparisons reproduce the corresponding source behavior.

<div style="break-before: page"></div>

## References

[1] Maria Smith. SFT V3 source corpus, commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Source laws: `sft/chemistry/multicentre_support_law_v1.py`, `electron_count_spin_law_v1.py`, `orbital_support_law_v1.py`, `pair_exchange_law_v1.py`, `conjugated_support_law_v1.py`, `resonance_equivalent_representation_law_v1.py`, `joint_correlation_law_v1.py` and `rovibronic_composition_derivation.py`, with their original validation and batch files. Exact bytes accompany this paper. V3 foundation: [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656). Monograph: [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[2] Maria Smith. SFT V4 Lean verified source, edition 0.4, commit [`21cdf559922fb057f8560f42d056ffa035329eb3`](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3). Native declarations cited above lie under `SFT.Chemistry`. Completion receipts: TURN1071 rovibronic, TURN1074 electron spin, TURN1078 orbital support, TURN1080 conjugated support, TURN1089 resonance equivalent, TURN1104 pair exchange, TURN1119 joint correlation and TURN1132 multicentre. Full receipt filenames and declarations are retained in the correspondence map.

[3] Maria Smith. SFT V4 cumulative scientific edition: [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Correspondence edition: [doi:10.5281/zenodo.24337358](https://doi.org/10.5281/zenodo.24337358). This paper supplies the complete selected source/evidence archive, `SOURCE_CORRESPONDENCE.json` and runnable reproduction.

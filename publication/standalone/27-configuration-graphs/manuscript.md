# Molecular configuration graphs, reaction paths and exact barriers

**Maria Smith**  
Ernos Labs  
Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com)  
SFT community: [discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

A molecular path retains every configuration, every adjacent comparison and its carrier identity at every finite extension. Appending a configuration preserves the complete previous path and adds exactly one neighbour triple once two nodes are present. Exact structural and positive-rational comparison branches determine basins and barriers. The complete original eight-axis configuration grammar contains 256 candidates and has a unique survivor. Both complete experimental ethanol torsion paths are reconstructed from the pinned NIST source: fifty rows contain forty-six positive heights and four structural absences; their forty-eight nonduplicated configurations give six basins, six barriers and thirty-six ordinary nodes. Each path has minima at 60°, 180° and 300°, with barriers at 0°, 120° and 240°. The state-order construction gives one structural least state and consecutive positive excited positions; matching molecular transitions retain the intermediate state in their composed word. Three completed source entries supply thirty-three native Lean modules and 501 distinct empty-axiom audited declarations. The paper gives the constructions, proofs, complete classification and source-bound observation procedure explicitly.

## 1. Complete paths and their successor theorem

Fix a retained molecular carrier \(M\). A configuration node is a four-part record

\[
 v=(M,c,h,r),
\]

where \(c\) is a configuration-coordinate label, \(r\) a configuration-record label and \(h\) an exact positive ratio or the original structural EmptyOne value. The constructor checks these label families. A path is a nonempty ordered list \(P=[v_0,\ldots,v_{n-1}]\) whose nodes all retain the same carrier. The source retains repeated coordinates and complete record identities. Its ordered successor relation records which configurations are consecutive; all local comparisons use this retained incidence. The definitions are `ConfigurationNode` and `ConfigurationPath` in the pinned V3 configuration law [4], translated by `SFT.Chemistry.ConfigurationOrder` [7].

For arbitrary nodes \(a,b\) and a finite tail \(R\), define the complete triple list recursively:

\[
 T(a,b,[]) = [],\qquad
 T(a,b,c::R)=(a,b,c)::T(b,c,R).
\]

**Theorem 1 (complete comparison and extension).** For every finite \(R\) and next node \(x\),

\[
 |T(a,b,R)|=|R|,
\]
\[
 \operatorname{take}_{|R|}T(a,b,R\mathbin{+\!+}[x])=T(a,b,R),
\]
\[
 |T(a,b,R\mathbin{+\!+}[x])|=|T(a,b,R)|+1.
\]

The proof is induction on the actual tail. For \(R=[]\), appending \(x\) creates the single triple \((a,b,x)\); taking zero triples recovers the empty old list. For \(R=c::R'\), the first triple \((a,b,c)\) is identical before and after extension. Apply the induction hypothesis to \(T(b,c,R')\), then prepend that common triple. The length equation becomes \(1+|R'|=|R|\), and extension adds one to the tail count. Thus every earlier comparison remains in its original position. Independently,

\[
 \operatorname{take}_{|P|}(P\mathbin{+\!+}[x])=P
\]

retains every previous node. These are the native `completeComparisonCount`, `priorComparisonsRetained`, `exactlyOneNewComparison` and `successorRetainsNodes` declarations. Their list induction is independent of a chosen path length. For a path of length \(n\), the number of interior triples is \(\max(n-2,0)\); a two-node path has no interior triple, and its next node supplies the first one.

## 2. Exact basin and barrier operations

Write \(\bot\) for the distinguished original EmptyOne singleton. Positive heights are \(p/q\) with positive integer numerator and denominator. Their comparison is exact:

\[
 \frac{p}{q}<\frac{r}{s}\quad\Longleftrightarrow\quad ps<rq.
\]

Because \(q,s>0\), multiplying by \(qs\) preserves the inequality. Equal ratios give neither a strict minimum nor a strict maximum against one another. No floating approximation enters this decision.

For a neighbour triple \((\ell,h,u)\), the original core minimum operation is

\[
 B(\ell,h,u)=
 \begin{cases}
 (\ell\ne\bot)\land(u\ne\bot),&h=\bot,\\
 \mathrm{false},&h\ne\bot\text{ and }(\ell=\bot\text{ or }u=\bot),\\
 (h<\ell)\land(h<u),&\ell,h,u\text{ positive}.
 \end{cases}
\]

The original core barrier operation is

\[
 H(\ell,h,u)=
 \begin{cases}
 (h\ne\bot)\land(\ell=\bot\text{ or }u=\bot),
   &\bot\text{ occurs in the triple},\\
 (h>\ell)\land(h>u),&\ell,h,u\text{ positive}.
 \end{cases}
\]

These equations preserve the source's mixed structural branch: a positive centre with a structural neighbour enters the first barrier branch. Its other positive neighbour is not additionally compared in that branch. The public native `minimumTriple` and `barrierTriple` definitions preserve this exact decision order. The ratio-only equations and structural cases are exposed by `positiveBasin`, `positiveBarrier` and `structuralBasin`.

A requested path position must satisfy \(0<i<n-1\). The core operation rejects an endpoint or an out-of-range signed index before taking its neighbours. The original runtime also distinguishes the canonical EmptyOne singleton from other instances of that class. The native height representation retains the separate `otherEmptyOne` branch and the original attribute-error outcome where a noncanonical instance reaches a ratio access. This preserves the accepted constructor domain and subsequent decisions exactly.

The paper's executable reproduction applies the original Python operations to all \(4^3=64\) triples from \(\{\bot,1/2,1,2\}\), checks both equations and exercises 512 invalid-position calls. The retained native source correspondence additionally covers the original full program, controls and candidate enumeration.

## 3. The complete configuration grammar

The original construction generates a literal product of eight binary axes. Each coordinate chooses between the following source alternatives:

| Axis | First alternative | Admitted alternative |
|---|---|---|
| Carrier | Coordinate-only surface | Retained molecular carrier |
| Configuration | Continuum-point premise | Generated configuration nodes |
| Order | Signed or floating energy | Exact positive order or EmptyOne |
| Stability | Named stable structure | Complete-neighbour local minimum |
| Barrier | Imported saddle formula | Complete-neighbour local barrier |
| Path | Endpoints alone | Complete connected configuration path |
| Recurrence | Open-curve assumption | Exact periodic endpoint identity |
| Record | Selected extrema | Complete favourable and adverse vector |

Let \(C=\prod_{j=1}^{8}\{0,1\}\), with the admitted constructor represented by 1 in each coordinate. There are

\[
 |C|=\underbrace{2\cdot2\cdot2\cdot2\cdot2\cdot2\cdot2\cdot2}_{8\text{ axes}}=256
\]

generated candidates. For each axis, case analysis proves that its candidate field belongs to its two-element generating list. Nesting these membership witnesses through the eight product loops proves every candidate belongs to the generated list. This is `ConfigurationOrderGrammar.candidatesComplete`, together with `generatedCardinality`.

The source decision applies the eight corresponding criteria conjunctively. Carrier retention identifies the molecular configuration space; generated nodes provide its source domain; exact order supplies comparison; complete neighbours decide stability and barriers; the path retains intermediates; recurrence identifies the terminal copy; the full vector retains ordinary and adverse observations. With \(A_j(c)\) the admitted-constructor test,

\[
 D(c)=\bigwedge_{j=1}^{8} A_j(c).
\]

Each coordinate criterion is true exactly for its admitted constructor. Hence \(D(c)\) is true if and only if every coordinate is admitted, which is equivalent to

\[
 c=(1,1,1,1,1,1,1,1).
\]

`sourceDecisionMatchesCriteria` identifies the original decision with that conjunction; `uniqueCriteriaSurvivor`, `uniqueSurvivor` and `acceptanceIffExactCriteria` prove the equivalences. A rejected coordinate contradicts the corresponding field of the unique survivor. This proves completeness and uniqueness over the entire original grammar, while Theorem 1 establishes arbitrary finite extension of the resulting path representation.

## 4. Ground, excited and transition states

The state-order source fixes one molecular composition and geometry. Each retained state has a molecular carrier, state identity, exact order position and support identity. Its accepted order has distinct state identities, exactly one structural ground position and positive positions that, after sorting, are

\[
 [1,2,\ldots,n-1].
\]

The native `admittedGroundCount` and `admittedSuccessorPositions` proofs unfold the original acceptance guards. Each rejected guard contradicts successful construction; the remaining equality guard yields the exact position list. Thus the result retains one least state and the complete positive successor census.

For same-carrier states, the comparison first handles the ground branch. Ground precedes every positive position, and no state precedes ground. Positive states with positions \(a,b\) compare by \(a<b\). For distinct positive positions, integer trichotomy eliminates equality and gives \(a<b\) or \(b<a\). For \(a<b\), the retained gap satisfies

\[
 g=b-a>0,\qquad a+g=b.
\]

The proofs recurse on \(a\). At \(a=0\), both claims reduce directly to the assumed positive upper position. At successor positions, subtraction cancels one successor on each side and the induction hypothesis applies. These are `retainedPositiveGap` and `gapReconstructsHigher`, alongside `groundBeforePositive`, `noStateBeforeGround`, `positiveComparisonEquation` and `distinctPositivePositionsComparable` in `StateEnergyOrderDerivation` [6]. The row-builder append theorem retains old state/support records and continues the positive indices; `successfulAppendRetainsRecords` identifies successful construction with the exact concatenation.

A molecular transition retains \((M,s,t,o,r)\): carrier, initial state, terminal, orientation and record. An observed terminal is a state distinct from the initial state. Its orientation is forward, reverse, bidirectional or coupled. The absence orientation instead requires the structural EmptyOne terminal. Exhausting the constructor branches proves this disjunction in `MolecularStateTransitionDerivation.acceptedTerminalMeaning`; `observedHasDistinctTerminal` and `absentTerminalIsStructural` select its two cases.

Two observed transitions compose when they share a carrier and the first terminal equals the second initial state. For \(s_0\to s_1\) and \(s_1\to s_2\), the original composed word is

\[
 [M,s_0,s_1,s_2,o_1,o_2].
\]

All six cells are retained, including the intermediate state and both orientations. Unfolding composition under the matching guards produces exactly this word; `compositionExact`, `matchingComposition` and `composedWordLength` establish the result. These state and transition constructions provide the retained identities on which configuration paths operate.

## 5. Both complete experimental torsion paths

The empirical source is the NIST CCCBDB experimental ethanol rotational-barrier table [8]. The pinned snapshot, identity file and withheld target file are each checked against their original SHA-256 authority. The original HTML parser collects table cells, normalizes whitespace and reconstructs every ordered target row. Each row preserves torsion index, angle inscription, energy inscriptions in kJ/mol and inverse centimetres, and path position. Decimal inscriptions are parsed into exact rationals.

Each torsion path contains 25 coordinates from 0° through 360° in 15° steps. The terminal height equals the initial height. Remove that terminal copy for cyclic neighbour comparisons, leaving 24 nodes indexed modulo 24:

\[
 \ell_i=h_{(i-1)\bmod24},\qquad u_i=h_{(i+1)\bmod24}.
\]

The original observation comparator uses strict exact comparisons in both directions:

\[
 b_i=[h_i<\ell_i\ \land\ h_i<u_i],\qquad
 q_i=[h_i>\ell_i\ \land\ h_i>u_i].
\]

This cyclic observation operation compares the recorded rational heights directly. The core mixed structural branch in Section 2 is preserved as its own original operation. All fifty inscriptions remain in the observation record; only the duplicated endpoints are removed from the cyclic classification count.

| Complete observation | Torsion 1 | Torsion 2 | Combined |
|---|---:|---:|---:|
| Source rows | 25 | 25 | 50 |
| Nonduplicated cyclic nodes | 24 | 24 | 48 |
| Strict local basins | 3 | 3 | 6 |
| Strict local barriers | 3 | 3 | 6 |
| Ordinary nodes | 18 | 18 | 36 |
| Terminal recurrence copies | 1 | 1 | 2 |

Both paths have basin angles \(60^\circ,180^\circ,300^\circ\) and barrier angles \(0^\circ,120^\circ,240^\circ\). Across all fifty source rows there are forty-six positive heights and four structural absences. The two energy-unit inscriptions agree on absence. Classification exhausts the nonduplicated rows:

\[
 6+6+36=48,\qquad48+2=50,\qquad46+4=50.
\]

The original sealed prediction program has nineteen instructions: one input, eight label-key/label-value pairs, one table and one emit. It freezes the eight structural laws before reading the withheld angle and energy inscriptions. The observation then reconstructs the complete table and evaluates the original comparisons. The retained configuration validation reproduces all twelve empirical fields and all fifty-six protocol messages. `ConfigurationObservation`, `ConfigurationTargets`, `ConfigurationOrderExperiment` and `ConfigurationOrderValidation` preserve the parser, target authority, program and post-seal protocol respectively [7].

## 6. Native evidence and reproduction

The three completed registrations are state-energy order 004, molecular-state transition 009 and configuration-order path 011. Their retained completion receipts are TURN1087, TURN1135 and TURN1155. They cover 14, 12 and 7 direct native modules respectively, and 178, 164 and 159 audited declarations: 33 modules and 501 distinct declarations in total. All retained declaration audits report empty axiom dependencies. The package includes 519 native source files with imports and seventy pinned V3 files, together with source-specific comparison logs, receipt checksums and full declaration names.

The state-order and transition sources are pinned to V4 edition 0.4 [6]. The completed configuration translation is pinned to the later public checkpoint [7]; its seven receipt-bound modules and additional imported dependencies are included at that checkpoint. Each relevant module and evidence-file digest is checked against its applicable receipt. Source identity, declaration audit and original program comparison are retained as separate evidence components.

`SOURCE_CORRESPONDENCE.json` maps each registration, source file and native module to its pin and digest. `SOURCE_AND_EVIDENCE.zip` contains the source, evidence and portable reproduction script. After extraction, run `python3 reproduction/check_paper_arithmetic.py`. It executes the original comparison branches, original HTML parser, all three source hash guards and all fifty retained observations, and produces the exact counts and extrema above. The supplied proof bodies establish the general finite-path and state-order arguments independently of this observation replay.

## References

[1] Maria Smith. SFT V3 foundation. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).

[2] Maria Smith. SFT exhaustive monograph. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[3] Maria Smith. SFT V4 Lean verified corpus, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Contact-enriched edition: [doi:10.5281/zenodo.24337358](https://doi.org/10.5281/zenodo.24337358).

[4] Maria Smith. Pinned V3 corpus, commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Configuration law, batch and validation: `sft/chemistry/configuration_order_law_v1.py`, `configuration_order_batch_v1.py`, `configuration_order_validation_v1.py`. Full files and registration dependencies are supplied in the source archive.

[5] Maria Smith. Pinned V3 molecular state-energy and transition constructions. Original registrations `SFT-CHEM-STATE-ENERGY-ORDER-004` and `SFT-CHEM-MOLECULAR-STATE-TRANSITION-009`, at the commit in [4]. Verbatim source files, dependencies and receipts accompany this paper.

[6] Maria Smith. [SFT V4 edition 0.4 source](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3), commit `21cdf559922fb057f8560f42d056ffa035329eb3`. Native `SFT.Chemistry.StateEnergyOrder` and `SFT.Chemistry.MolecularStateTransition` families; TURN1087 and TURN1135 completion evidence.

[7] Maria Smith. [Completed configuration-order source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/e10682febb1e610fe8ae2ab5613390b71db34514), commit `e10682febb1e610fe8ae2ab5613390b71db34514`. Native `SFT.Chemistry.ConfigurationOrder` family and `TURN1155_CONFIGURATION_COMPLETION.json`.

[8] NIST. [CCCBDB SRD 101: ethanol experimental rotational barriers](https://cccbdb.nist.gov/exprotbar2x.asp?casno=64175&ti=1). The exact snapshot used by the original validation, its identity and target files, and their authority digests are preserved in this paper's source archive.

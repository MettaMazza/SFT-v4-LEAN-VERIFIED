# Phase, interference and error correction in native Fold circuits

**Exact phase restoration, complete predecessor records and the first correcting width at every finite fault order**

Maria Smith · Ernos Labs  
18 November 2026 · Version 1.1 · DOI: 10.5281/zenodo.24354217

Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com)  
SFT community: [discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

Every complete phase period restores the full admitted Fold state. Every interference output retains exactly its original predecessor branches and their phase labels. Every successfully evaluated admitted circuit has an exact reverse-order inverse and a complete predecessor-state ledger. For every supplied positive finite fault order \(t\), repetition width \(2t+1\) corrects every mask of at most \(t\) changed positions, while every smaller positive width has an explicit tie or wrong-majority counterexample. This establishes the unique first correcting width, redundancy \(2t\) and successor increment two. Exact word recovery preserves the complete circuit evaluation. We develop these constructions and proofs from the pinned Smithian Fold Theory source, with native Lean correspondence and 458 distinct empty-axiom audited declarations across five completed entries. [1–3]

## 1. Complete support and retained basis records

For a duplicate-free alphabet \(A\) and a nonempty duplicate-free position trace of length \(n\), the original support operation enumerates \(A^n\) in Cartesian-product order. The information-correspondence operation requires at least two labels. For the inherited Fold alphabet \((\texttt{held-a},\texttt{held-b})\), the support is exactly the inherited support after \(n\) extensions. Native `QuantumCanonical.supportCorrespondence` proves the membership equivalence.

Each position has an independently realized distinction: the all-first-label word and the word obtained by replacing only that position with the second label. Both belong to the complete support. They differ at that position, and their four-field trace retains position identity, the one-Fold-information-distinction tag and both words.

The source basis operation retains a pair \((w,B(w))\), where
\[
 B(w)=\texttt{basis:}\mathbin{+\!+}\operatorname{join}_{:}(w).
\]
Projecting the first coordinate reconstructs every original word in order. The inherited labels are exactly those of the pinned `fold_assembly.LABELS`. To prove injection of the actual names, cancel the common `basis:` prefix and prepend a colon to a nonempty joined word. Each label now occupies a seven-character block, `:held-a` or `:held-b`. Equality forces the same first block; dropping seven characters leaves equality of the remaining blocks. Induction recovers the entire word. Empty and nonempty lists are distinguished by their first character. The finite character alphabet has exact UTF-8 encode/decode round trips, so equality of the original strings gives the character-list equality used by this cancellation argument. These are `QuantumCanonical.decodeEncoded`, `nameChars`, `tailsInjection`, `joinedInjection` and `basisNameInjection`. Equality of complete names therefore implies equality of words. `QuantumCanonical.admittedNamesInjective`, `admittedNamesDistinct` and `basisInverse` establish the canonical name bijection and its unique inverse.

The raw executable interface also accepts arbitrary string labels. Its complete pair record continues to identify the word even when two textual names coincide. For example, \((a,a{:}a)\) and \((a{:}a,a)\) both have name `basis:a:a:a`; their retained first coordinates differ. The original accepted domain and its exact outputs remain preserved.

For admitted supports \(L,R\), joint support visits every pair and retains \((u,v,u\mathbin{+\!+}v)\). Projection recovers both inputs even when concatenation alone would erase their boundary. A total observation assigns every support word exactly one image. Its returned record retains every word and image, the selected class and the closed alternatives. Projecting the reconstruction record recovers the complete original support.

## 2. States and finite phase operations

A Fold state is an ordered nonempty branch list
\[
 S=((w_1,p_1),\ldots,(w_N,p_N))
\]
together with a duplicate-free phase cycle \(P=(p^{(0)},\ldots,p^{(m-1)})\), where \(m\ge2\). Branch words are distinct and every branch phase belongs to \(P\). The constructor checks these exact conditions.

A nonempty successor trace \(u\) specifies shift \(k=|u|\bmod m\). The phase action retains each word and replaces its phase index \(j\) by
\[
 j'=(j+k)\bmod m.
\]
For one complete period, \(|u|=m\), the shift is zero. Since \(0\le j<m\), \(j\bmod m=j\), and every branch is unchanged. Applying this equality through the ordered branch list restores the entire state, including the phase cycle. `PhaseInterference.exactPhasePeriod` proves that equality for every admitted state and every trace of one cycle length.

The inverse shift is zero if \(k=0\), and \(m-k\) otherwise. In the latter case,
\[
 ((j+k)\bmod m+(m-k))\bmod m
 =(j+m)\bmod m=j.
\]
The first equality follows by reducing before addition; the second uses one complete cycle and the index bound. `ReversiblePhase.inverseIndex` proves these arithmetic identities; `PhaseInterference.phaseActionInverse` lifts them through the complete branch transformation. The inverse trace is nonempty and its length modulo \(m\) equals that inverse shift.

State composition requires identical phase cycles. It forms every ordered branch pair, inserts the source `joint` marker between its words and adds the phase indices modulo \(m\). The resulting state is passed through the same constructor, preserving the original acceptance and rejection decisions.

## 3. Interference retains the exact predecessor fibre

Let \(f\) be a total, single-valued classification of the complete branch-word support. For output label \(y\), define
\[
 G_y=((w,p)\in S:f(w)=y).
\]
The original predecessor-merge operation groups every branch by its image, sorts output labels and retains original branch order within each group. Its exact characterization is
\[
 (w,p)\in G_y\iff (w,p)\in S\ \land\ f(w)=y.
\]

To prove the forward implication, unfold the returned group as the filter of the complete classified record. Membership supplies both an original record row and its image equality. That record row came from exactly the original branch and its classification. Conversely, an original branch with image \(y\) appears in the complete classified record and passes the filter for \(y\). Native `PhaseInterference.predecessorFibreExactly` composes these two membership equivalences.

If two original branches share an output, the same group contains both. `sameImageRetainsBoth` first obtains the group containing one branch, then applies the exact membership theorem to the other. The output therefore retains both source words and both phase labels.

The observation operation additionally selects a nonempty image class. It returns the selected state together with the full record \((w,p,f(w))\) for every original branch. Removing only the observation-label coordinate reconstructs the pre-observation branch list and its phase cycle. Selection and complete reconstruction are retained as distinct outputs of the same operation.

## 4. Reversible gates and complete circuit traces

A gate has a nonempty finite word map with distinct sources and distinct targets, and a nonempty phase-successor trace. Application requires its source domain to equal the complete state support. It replaces each word by its unique mapped word and applies the phase shift from Section 2.

The inverse gate exchanges source and target rows. Inverse application uses the inverse phase shift. Word-map inversion restores every original word; modular phase inversion restores every original phase. The branch list retains its order throughout, giving exact state equality after the inverse.

A circuit is evaluated recursively over its gate list. The empty circuit returns the original state and an empty predecessor list. At a successor, evaluate the first gate, retain its predecessor state, and evaluate the remaining gates from the resulting state. Successful application preserves admission, so the recursive construction yields a complete causal trace.

For a successfully evaluated circuit with \(r\) gates, induction gives
\[
 |\text{predecessor states}|=r,\qquad
 |\text{terminal branches}|=|\text{initial branches}|.
\]
The inverse proof reverses gate order: first undo the last application, then use the inverse trace of its predecessor circuit. The base is identity. `Circuit.evaluationHasExactTrace` constructs the causal trace from executable success; `circuitInverseAndLedger` supplies the reverse trace and both counts.

Every application retains the phase cycle, so induction gives the same cycle at the terminal state. A subsequent observation retains one complete classification record per terminal branch. Combining observation reconstruction with branch-count and phase-cycle preservation reconstructs the terminal state and gives record length equal to the initial branch count. This is `Circuit.circuitObservationRecord`.

## 5. Every fault mask at width \(2t+1\)

The fault allowance is supplied as a nonempty trace of distinct position labels. Its length \(t\) is the allowed number of changed positions. A source label is one of `held` and `returned`. Encode it as \(w=2t+1\) copies. A mask selects positions to replace by the opposite generated label.

The original mask generator enumerates every positional subset of sizes zero through \(t\), in increasing size and combination order. Its complete membership theorem is
\[
 M\in\mathcal M(w,t)\iff
 M\text{ is an ordered subset of }[0,\ldots,w-1]
 \ \land\ |M|\le t.
\]
The generator's include/omit recursion preserves order and proves coverage by induction on the position list. `ReversibleFaults.faultMasksExactly` proves this characterization; `ErrorCorrection.completeCensusRows` connects it to every exact changed-word/decoded-label row in the returned census.

Let \(e\) count opposite labels after changing a repeated word and \(c\) count original labels. Induction over the word proves
\[
 e\le |M|,\qquad c+e=w.
\]
At an unselected position, the original count increases. At a selected position, the opposite count increases and removal of that position from the mask reduces its available length by one; later positions see the same selection decisions. These are the native `changedCountBound` and `changedCounts` arguments.

Since \(|M|\le t\) and \(w=2t+1\),
\[
 e\le t,\qquad c=2t+1-e\ge t+1>e.
\]
Thus the original label has strict majority. `heldCorrection` and `returnedCorrection` establish recovery for both source labels and every bounded mask; `ErrorCorrection.everyCensusRowRecovers` proves recovery for every actual census row. The proof has no terminal fault-order bound.

The two original decoder interfaces retain their exact decisions. The original operational decoder rejects a tie with its registered error. The later fault-order decoder returns `no-strict-majority` on a tie. Both reject empty words and unregistered labels. On every successfully corrected word the two interfaces return the same original label; `UnboundedFaults.oldSuccessfulDecoder` proves that agreement.

## 6. Constructive minimality and unbounded finite order

For every positive predecessor width \(1\le w\le2t\), change the first
\[
 q=\left\lfloor\frac{w+1}{2}\right\rfloor
\]
positions of an all-held word to returned. Quotient/remainder arithmetic gives
\[
 q\le t,\qquad w-q\le q.
\]
For the first inequality, if \(q\ge t+1\), then \(2q\ge2t+2\), whereas \(2q\le w+1\le2t+1\), a contradiction. For the second, the remainder of \(w+1\) modulo two is at most one, so \(w\le2q\), and subtraction gives \(w-q\le q\).

The original counterexample word is built from the ordered position range. Its exact returned count is \(q\) and held count is \(w-q\). Therefore the original label either ties or loses the majority, using at most \(t\) changes. `predecessorReturnedCount`, `predecessorHeldCount`, `predecessorAllowance` and `everyPredecessorDefeatsHeld` prove this on the actual source construction.

All smaller positive widths fail, while Section 5 proves that \(2t+1\) succeeds for every allowed mask. Hence it is the unique first correcting width. Its redundancy above one source label and its successor are
\[
 (2t+1)-1=2t,\qquad w_{t+1}=2(t+1)+1=w_t+2.
\]
At the first positive fault order, width three corrects a single changed position while widths one and two have the constructed failures. Every supplied finite order has a successor, so no finite ceiling terminates this construction.

## 7. Recovery preserves exact circuit evaluation

The original canonical worst mask changes the first \(t\) positions of each width-\(2t+1\) block. Its changed count is exactly \(t\), and its original count is exactly \(t+1\). The two majority cases give exact recovery for either source label. Induction over any generated source word yields
\[
 \operatorname{recoverWord}(a_1,\ldots,a_n;t)=(a_1,\ldots,a_n).
\]
`UnboundedFaults.everySourceWordRecovers` proves that equality for arbitrary word length and fault order. The original depth-seven full-word comparison is an executable instance of this general result.

Place the recovered word at any branch position, retaining the surrounding branches, phase label, cycle and gate list. Substitution of recovered-word equality gives
\[
 \operatorname{evaluate}(S[\text{recovered}],G)
 =\operatorname{evaluate}(S[\text{source}],G).
\]
This is equality of the complete evaluation result, including any returned trace or error. `UnboundedComposition.recoveryPreservesCircuit` proves it directly from exact word recovery. The original specified fault domain and canonical recovery operation remain explicit.

## 8. Complete grammars and retained verification

### 8.1 The actual generated carriers

The following tables give every original coordinate and both of its constructors, in source order; spaces display the source label separators. A candidate is a tuple with exactly one constructor from each row. The carrier is the full Cartesian product of those two-element lists. [4–6]

The ten-coordinate support grammar is `SPEC.dimensions` in the original information-correspondence law and `SFT.InformationScience.QuantumGrammar.Candidate` in Lean:

| Coordinate | First alternative | Admitted alternative |
|---|---|---|
| unit | imported qubit | one Fold distinction |
| support | sampled branches | complete Fold word support |
| basis | unnamed state count | bijective word basis trace |
| provenance | amplitude only row | position label trace |
| superposition | complex amplitude premise | complete alternative support |
| composition | tensor symbol premise | complete pair cell support |
| observation | stochastic collapse | exact observation class |
| record | discarded predecessors | complete branch image record |
| generality | small depth table | position successor |
| addition | extra amplitude phase or gate law | no extra quantum operation |

Phase/interference, circuits and error correction share the following eight-coordinate construction, `catalog.DIMENSIONS`. The native `PhaseInterferenceGrammar`, `CircuitGrammar` and `ErrorCorrectionGrammar` use the actual `ReversibleGrammar.Candidate`, generator and acceptance proofs; their source-specific statements and decision reasons remain separate.

| Coordinate | First alternative | Admitted alternative |
|---|---|---|
| support | partial or selected branch support | complete generated branch support |
| unit | imported bit or qubit | one Fold distinction unit |
| composition | sampled joint states | complete pair cell joint support |
| phase | complex amplitude postulate | period held phase action |
| transformation | partial or irreversible map | total reversible source bound map |
| observation | collapse without record | retained class and complete record |
| generality | fixed circuit examples | branch and depth successor certificate |
| addition | imported quantum model | no extra quantum premise |

The general fault-order entry has its own eight-coordinate carrier, `lineage_laws.DIMENSIONS` and `SFT.QuantumComputation.UnboundedGrammar.Candidate`:

| Coordinate | First alternative | Admitted alternative |
|---|---|---|
| fault order | fixed one error model | supplied positive finite fault trace |
| width | selected or even width | first strict majority width 2t plus 1 |
| coverage | sampled fault patterns | all masks through t by subset count |
| minimality | shorter widths unchecked | counterexample for every width through 2t |
| recovery | decoded label without record | exact syndrome and recovery trace |
| circuit | isolated code example | corrected word feeds exact circuit semantics |
| generality | fixed t table | fault order successor and ceiling defeat |
| addition | imported hardware threshold | no rate device or noise parameter |

### 8.2 Exhaustion, forcing and closure

Let the ordered two-constructor list in row \(i\) be \(D_i=[r_i,a_i]\). Begin with the singleton empty tuple and extend each prior tuple once with each constructor in the next row. Induction on the rows proves that the resulting list contains every tuple in \(\prod_i D_i\): an arbitrary tuple has a head in the first list, and its tail belongs to the recursively generated product. Conversely, every generated tuple chooses each coordinate from its displayed row. Each extension doubles the list length, giving \(2^{10}=1,024\) and \(2^8=256\). This is the nested `flatMap`/`map` construction and the actual `candidatesComplete` and `generatedCardinality` proof in each native grammar.

The original decision compares the complete candidate identity to the all-admitted identity. Case analysis on the two constructors of every coordinate proves its equivalence to
\[
 D(c)=\bigwedge_i[c_i=a_i].
\]
If this conjunction holds, each coordinate is its admitted constructor, so tuple equality gives \(c=(a_1,\ldots,a_d)\). Conversely, substitution of that tuple makes every conjunct true. Any first-alternative coordinate contradicts the corresponding equality. These are `sourceDecisionMatchesCriteria`, `uniqueCriteriaSurvivor`, `uniqueSurvivor` and `acceptanceIffExactCriteria` in `QuantumGrammar`, `ReversibleGrammar` and `UnboundedGrammar`. The three source-specific circuit-family grammars inherit these same proofs through their explicit aliases. Thus the five registrations contribute \(1,024+3\cdot256+256=2,048\) classified forms.

The operational arguments establish why the admitted structure is preserved. Complete word extension and distinct held labels provide support and position provenance (Section 1). Modular inversion retains phases (Section 2); exact fibres and complete reconstruction retain every predecessor (Section 3). Bijection and reverse gate order retain the entire circuit trace (Section 4). The complete subset generator covers every allowed fault mask and the majority bound proves recovery (Section 5). The original predecessor construction rules out every smaller positive width (Section 6), and exact recovered-word substitution preserves circuit evaluation (Section 7). The identity circuit is the base; a successful next gate preserves state admission and adds one predecessor. The first positive fault order has width three; the proved successor adds exactly two positions and defeats every supplied finite ceiling. These are the actual base and successor constructions associated with the displayed coordinates. [4–6]

### 8.3 Retained verification

The five selected entry namespaces contain 458 distinct audited declarations with empty axiom dependencies: 180 support-correspondence, 49 phase/interference, 47 circuit, 46 error-correction and 136 unbounded-fault declarations. Their definitions and theorems accompany the retained original/native programme and source comparisons. Imported operational proofs are included in the evidence archive.

The portable reproduction checks 9,350 phase actions with inverse restoration, 783 complete predecessor/observation records, 36 gate inverses and 10,920 full fault-census rows through fault order six. It also checks every original smaller-width counterexample and complete depth-seven word round trip through order fourteen. Six canonical support depths retain the exact basis/unit/observation outputs. The raw basis-name collision and both decoder tie outcomes remain explicit checks. The general native proofs quantify over the full admitted carriers described above.

## 9. Sources and authorship

Maria Smith is the scientific author of SFT and its original derivations. AI assistance supports translation, verification and manuscript preparation under her direction.

V3 is pinned to `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The original operations are in `sft/information_science/quantum_information_correspondence/law.py` and `sft/quantum_computation/operations.py`; the general fault-order construction is `lineage_laws.py`. V4 edition 0.4 is pinned to `21cdf559922fb057f8560f42d056ffa035329eb3`. Completion receipts TURN179, TURN353, TURN357, TURN363 and TURN867 retain the exact source correspondence and verification records.

<div style="break-before: page"></div>

## References

1. Maria Smith. Smithian Fold Theory V3 foundation. https://doi.org/10.5281/zenodo.21627656.
2. Maria Smith. Smithian Fold Theory exhaustive monograph. https://doi.org/10.5281/zenodo.21900790.
3. Maria Smith. SFT V4 Lean verified corpus, edition 0.4. https://doi.org/10.5281/zenodo.24320778.

4. Maria Smith. Original Fold support and basis construction: `sft/foundation/fold_assembly.py` and `sft/information_science/quantum_information_correspondence/law.py`, V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Native `QuantumCanonical`, `QuantumSupport`, `QuantumUnits`, `QuantumObservation` and `QuantumGrammar`, V4 commit `21cdf559922fb057f8560f42d056ffa035329eb3`; TURN179 completion and TURN176 full-program comparison. Verbatim source and proof bodies accompany this paper.
5. Maria Smith. Original phase, gate, observation and error-census operations: `sft/quantum_computation/operations.py`, and the exact grammar and entry statements in `catalog.py`, same V3 commit. Native `PhaseInterference`, `ReversiblePhase`, `ReversibleApplication`, `ReversibleObservation`, `ReversibleExecution`, `Circuit`, `ReversibleFaults`, `ReversibleCorrection` and `ErrorCorrection`, same V4 commit; TURN353, TURN357 and TURN363 completion and full-program comparisons.
6. Maria Smith. Original general fault-order construction: `sft/quantum_computation/lineage_laws.py`, same V3 commit. Native `UnboundedFaults`, `UnboundedComposition` and `UnboundedGrammar`, same V4 commit; TURN867 completion, source-output and full-program comparisons.

Pinned native source: [SFT V4 verified corpus](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3/SFT).

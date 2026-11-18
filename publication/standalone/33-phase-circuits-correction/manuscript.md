# Phase, interference and error correction in native Fold circuits

**Exact phase restoration, complete predecessor records and the first correcting width at every finite fault order**

Maria Smith · Ernos Labs  
18 November 2026 · Version 1.0 · DOI: 10.5281/zenodo.24339388

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
Projecting the first coordinate reconstructs every original word in order. Over the inherited labels, the textual encodings distinguish the first label and then the tail recursively. Equality of complete names therefore implies equality of words. `QuantumCanonical.admittedNamesInjective`, `admittedNamesDistinct` and `basisInverse` establish the canonical name bijection and its unique inverse.

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

The support-correspondence entry has ten binary preservation dimensions. Phase/interference, circuits, error correction and unbounded finite fault tolerance each have eight. The complete products therefore contain \(1,024+4\cdot256=2,048\) forms. For each entry, acceptance is the conjunction of its original admitted coordinates. Every accepted tuple equals the all-admitted tuple, and substitution accepts that tuple. Exhaustive generation, exact decision correspondence and unique survival are retained by the native grammar proofs.

The five selected entry namespaces contain 458 distinct audited declarations with empty axiom dependencies: 180 support-correspondence, 49 phase/interference, 47 circuit, 46 error-correction and 136 unbounded-fault declarations. Their definitions and theorems accompany the retained original/native programme and source comparisons. Imported operational proofs are included in the evidence archive.

The portable reproduction checks 9,350 phase actions with inverse restoration, 783 complete predecessor/observation records, 36 gate inverses and 10,920 full fault-census rows through fault order six. It also checks every original smaller-width counterexample and complete depth-seven word round trip through order fourteen. Six canonical support depths retain the exact basis/unit/observation outputs. The raw basis-name collision and both decoder tie outcomes remain explicit checks. The general native proofs quantify over the full admitted carriers described above.

## 9. Sources and authorship

Maria Smith is the scientific author of SFT and its original derivations. AI assistance supports translation, verification and manuscript preparation under her direction.

V3 is pinned to `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The original operations are in `sft/information_science/quantum_information_correspondence/law.py` and `sft/quantum_computation/operations.py`; the general fault-order construction is `lineage_laws.py`. V4 edition 0.4 is pinned to `21cdf559922fb057f8560f42d056ffa035329eb3`. Completion receipts TURN179, TURN353, TURN357, TURN363 and TURN867 retain the exact source correspondence and verification records.

## References

1. Maria Smith. Smithian Fold Theory V3 foundation. https://doi.org/10.5281/zenodo.21627656.
2. Maria Smith. Smithian Fold Theory exhaustive monograph. https://doi.org/10.5281/zenodo.21900790.
3. Maria Smith. SFT V4 Lean verified corpus, edition 0.4. https://doi.org/10.5281/zenodo.24320778.

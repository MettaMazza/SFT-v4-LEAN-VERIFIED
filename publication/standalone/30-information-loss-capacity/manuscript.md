# Finite information loss, channel capacity and exact reversibility

**Complete distinction ledgers and all maximum zero-error codes in Smithian Fold Theory**

Maria Smith · Ernos Labs  
18 November 2026 · Version 1.0 · DOI: 10.5281/zenodo.24339200

Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com)  
SFT community: [discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

A finite deterministic transformation is reversible exactly when every image fibre contains one predecessor. Every source distinction belongs to exactly one of two complete ledgers: a retained image distinction or a pair closed inside an image fibre. Under composition, the retained ledger can only decrease. For a finite channel, confusability is exact overlap of output supports, and capacity is the complete family of greatest-cardinality distinguishable codes, retaining every tie. We derive these results, the complete code enumeration and their arbitrary finite successor constructions from the original Smithian Fold Theory operations. The native Lean evidence includes 339 distinct declarations with empty axiom dependencies and complete correspondence for two 1,024-form preservation grammars. The accompanying reproduction retains exact source order, full five-field transformation ledgers, complete tied capacity families, predecessor records and source-bound controls. [1–3]

## 1. Complete carriers and observations

Let \(X=(x_1,\ldots,x_n)\) be a nonempty finite ordered source carrier with no duplicate labels. A transformation is a held map \(f\) containing exactly one image for every member of \(X\), with no additional source key. Its row order may differ from source order. The image carrier is the first-occurrence list
\[
 Y=\operatorname{first}(f(x_1),\ldots,f(x_n)).
\]
For \(y\in Y\), the predecessor fibre is
\[
 F_y=(x\in X:f(x)=y),
\]
retaining source order. Every source occurs in its image fibre, and two different image labels have disjoint fibres: membership in both would give two different values for the same held image. Every member of \(Y\) occurs as an image, so its fibre is nonempty. The fibres therefore give an exhaustive partition of the complete source carrier.

The original validator first checks nonempty duplicate-free source support, then checks that the map has exactly the source keys without repetition. Empty strings and the literal label `empty-One` remain admissible labels. Structural absence in a pair ledger is separately represented by the original empty-One result.

## 2. The exact conservation ledger

The source-pair carrier is
\[
 P(X)=\{(x_i,x_j):1\le i<j\le n\},
\]
visited in increasing first position and then increasing second position. Define
\[
 R_f=\{(a,b)\in P(X):f(a)\ne f(b)\},\qquad
 L_f=\{(a,b)\in P(X):f(a)=f(b)\}.
\]
Here \(R_f\) retains image distinctions and \(L_f\) retains the distinctions closed by the map.

**Exact accounting theorem.** The two ledgers are disjoint and exhaust \(P(X)\).

**Proof.** Fix any source pair. Equality of its images either holds or fails. In the first case the pair belongs to \(L_f\); in the second it belongs to \(R_f\). Membership in both would assert equality and inequality of the same images, which is impossible. Filtering the complete ordered source-pair list by these complementary decisions retains every original pair exactly once across the two ledgers.

A pair is closed if and only if its two endpoints belong to a common predecessor fibre. Forward, choose the shared image \(y=f(a)=f(b)\); both endpoints lie in \(F_y\). Reverse, membership of both endpoints in \(F_y\) gives the image equality. Thus loss identifies the exact merged predecessors.

The complete source operation returns five fields: source support, first-occurrence image support, retained distinctions, closed distinctions and predecessor fibres. An empty retained or closed list is returned as the structural empty-One marker. `ConservationLedger.retainedMeaning`, `closedMeaning`, `pairExhaustion`, `pairDisjoint`, `closedFibre` and `fibreCloses` prove these statements on the actual native operations.

## 3. Reversibility is exactly singleton fibres

**Reversibility theorem.** For every admitted total transformation on \(X\), the following are equivalent:
\[
 |Y|=|X|,\qquad f\text{ is injective on }X,\qquad
 \forall y\in Y,\ \exists x\in X:\ F_y=[x].
\]

To connect the executable image-count test with injectivity, first consider first-occurrence deduplication of a list. Its length never exceeds the input length. At an already-seen item, the operation omits that item, so equality of the two lengths becomes impossible unless no item was repeated. Conversely, a duplicate-free list is unchanged by deduplication. Therefore the deduplicated image list has length \(|X|\) exactly when the source-indexed image list has no repeats.

Because \(X\) has no duplicate source labels, its mapped image list has no repeats exactly when \(f\) is injective. The actual source code counts distinct dictionary values; the native `valuesCorrespond` theorem establishes equality of the value sets obtained from map-row order and source order. Their first-occurrence lists therefore have the same length. This connects the original implementation to the source-indexed argument.

If \(f\) is injective, choose any \(y\in Y\). At least one predecessor exists. Any two members of its fibre have equal images and hence are equal. The fibre is duplicate-free as a filtered source list, so it is exactly a singleton. Conversely, if every image fibre is singleton, two source elements with the same image belong to the same singleton and must be equal.

`ConservationCardinality.reversibleIffInjective`, `injectiveIffSingletonFibres` and `reversibleIffSingletonFibres` give the complete equivalence for an arbitrary admitted finite transformation. The cardinality proof includes the exact dictionary/source-image correspondence.

## 4. What a reverse record must retain

For each image \(y\), the original reverse operation returns its unique predecessor when \(F_y=[x]\). For a non-singleton fibre it returns the complete held-predecessor-label record. The record follows the first-use image order and preserves the source order inside each fibre.

If \(F_y=[x]\), every source with image \(y\) equals \(x\), proving exact recovery. If distinct \(a,b\) both lie in \(F_y\), an inverse depending on \(y\) alone would have to return both \(a\) and \(b\). Equality of those returns contradicts their distinctness. Recovery through the merged image therefore requires a retained predecessor label resolving that fibre.

`ConservationReverse.uniqueIff` proves that the unique constructor occurs exactly for a singleton list. `heldIff` characterizes the complete held-list constructor. `uniqueRecovery` proves recovery from a singleton; `heldRecovery` proves that membership in the held record is exactly original source membership together with the indicated image. `distinctPredecessorsNotUnique` excludes a unique predecessor record in the presence of two distinct predecessors.

For the original example
\[
 X=(aa,ab,ba,bb),\qquad
 f=(aa\mapsto a,ab\mapsto a,ba\mapsto b,bb\mapsto b),
\]
the fibres are \((a,(aa,ab))\) and \((b,(ba,bb))\). The closed pairs are \((aa,ab)\) and \((ba,bb)\); the four cross-fibre pairs are retained. The reverse record retains both two-member predecessor lists.

## 5. Composition cannot reopen a closed distinction

Let \(g\) be an admitted total map on the complete image carrier \(Y\). The original composition visits the source carrier in order and returns
\[
 h(x)=g(f(x)).
\]
If \((a,b)\in L_f\), then \(f(a)=f(b)\), so applying the same function \(g\) gives \(h(a)=h(b)\). Thus
\[
 L_f\subseteq L_h,\qquad R_h\subseteq R_f.
\]
The second inclusion also follows directly by contradiction: if \(h(a)\ne h(b)\) but \(f(a)=f(b)\), functional application would give equal composite images. `ConservationComposition.closedPersists` and `retainedSubset` prove these statements; `downstreamTrue` connects them to the actual returned subset check after validation and exact composition.

Appending \(g(a)=g(b)=one\) to the prefix example closes all six source pairs. The first ledger retains four pairs and the composite retains none, represented by structural empty-One. The original source distinctions remain accounted for in the complete closed ledger.

## 6. Finite channels and exact confusability

A channel has ordered, nonempty, duplicate-free input and output carriers \(X,Y\), together with a duplicate-free relation \(T\subseteq X\times Y\). Every input has at least one output. An output carrier may contain an unused label; the admitted source domain permits it.

The ordered output support of input \(x\) is
\[
 S_T(x)=(y:(x,y)\in T),
\]
retaining relation order. Two inputs are confusable exactly when
\[
 S_T(a)\cap S_T(b)\ne\varnothing.
\]
Symmetry follows because the same shared output witnesses either orientation. An admitted input is confusable with itself because its support is nonempty.

A distinguishable code is a nonempty, duplicate-free held input selection whose distinct selected inputs have pairwise disjoint output supports. Every possible output then belongs to at most one selected input support. Conversely, a shared output between two selected inputs witnesses failure of this exact distinguishability condition. The original constructor, support and code predicates retain these conditions directly in `ChannelRelation`.

## 7. Exhaustive codes and the complete capacity family

Write \(\operatorname{Comb}(k,X)\) for the original size-\(k\) source-order combinations. Its recursion is
\[
 \operatorname{Comb}(0,X)=[[]],\qquad
 \operatorname{Comb}(k+1,[]) = [],
\]
\[
 \operatorname{Comb}(k+1,x::X)
 =\operatorname{map}(x::-,\operatorname{Comb}(k,X))
 \mathbin{+\!+}\operatorname{Comb}(k+1,X).
\]
The first branch includes the head and the second omits it. By induction, a selection occurs exactly when it is an order-preserving subsequence of length \(k\). If it contains the head it is covered by the first branch; otherwise it is covered by the second. For a duplicate-free carrier those branches cannot share a selection, and the recursive lists contain no duplicates.

The full candidate list takes every size from one through \(|X|\), then filters by the exact code predicate. Its membership is therefore equivalent to being a source-order selection satisfying that predicate. Native `ChannelSelections.combinationsMeaning`, `throughMeaning` and `candidatesMeaning` prove these equivalences on the actual generators.

Let \(\mathcal D_T\) be that complete code list. Every singleton input is a code, so \(\mathcal D_T\) is nonempty. Define
\[
 M_T=\max_{C\in\mathcal D_T}|C|,\qquad
 \mathcal K_T=(C\in\mathcal D_T:|C|=M_T).
\]
The original capacity is the full ordered family \(\mathcal K_T\).

The maximum recursion compares a head length with the tail maximum. Induction proves every candidate length is bounded by the result. For a nonempty list, either the head attains the result or a tail candidate does. Filtering by equality therefore returns a nonempty family. Conversely, any candidate at least as large as every candidate has length equal to the maximum and survives the filter. Hence
\[
 C\in\mathcal K_T\iff C\in\mathcal D_T\ \land\
 \forall D\in\mathcal D_T,\ |D|\le |C|.
\]
`ChannelCapacity.memberBound`, `largestAttained`, `greatestMeaning`, `capacityMeaning` and `admittedCapacity` establish this complete result. `familyDistinct` preserves unique records. There is no additional tie selection.

For the original clean channel \(a\mapsto x,b\mapsto y,c\mapsto z\), the capacity family is \(((a,b,c))\). For \(a\mapsto x,b\mapsto x,c\mapsto z\), it is \(((a,c),(b,c))\). Both greatest two-input codes remain in source order.

## 8. Relational composition preserves confusability

For channels \(T:X\to Y\) and \(U:Y\to Z\), composition requires equality of the ordered interface carriers. Its relation is
\[
 (x,z)\in U\circ T\iff\exists y:\ (x,y)\in T\land(y,z)\in U.
\]
The implementation traverses both relations in their original nested order, retaining the first occurrence of each composite cell. Deduplication removes repeated paths to the same cell without removing any cell. Totality of both channels supplies at least one composite output for every input.

If inputs \(a,b\) share an intermediate output \(y\), totality of \(U\) supplies a target \(z\) of \(y\). Both \((a,z)\) and \((b,z)\) then occur in the composite. Consequently a distinction merged at the interface remains merged downstream. `ChannelComposition.compositionPaths` proves the exact path equivalence; `noRestoredDistinction` proves this preservation of confusability on admitted channels.

## 9. Arbitrary finite successor constructions

For a deterministic transformation, append a fresh source \(q\notin X\) and one held image cell \(q\mapsto v\). Admission is preserved. Every old image remains unchanged, and the exact fibre update is
\[
 F'_y=F_y\mathbin{+\!+}
 \begin{cases}[q],&v=y,\\{}[],&v\ne y.\end{cases}
\]
The source-pair successor preserves old pairs and adds exactly \((x,q)\) for each \(x\in X\). A new pair is retained precisely when \(f(x)\ne v\) and closed precisely when \(f(x)=v\). The actual pair list preserves source-index order; the membership equations do not replace that ordered operation. `ConservationExtension.fibreSuccessor`, `pairSuccessorOrder`, `retainedSuccessor` and `closedSuccessor` establish these facts. The singleton base has one fibre and two structural empty-One pair ledgers.

For a channel, append a fresh input \(q\) with a nonempty duplicate-free output support inside the existing output carrier. Append its relation cells in support order. Old supports and old overlap decisions remain unchanged. Every new confusability test is exactly overlap between the fresh support and one old input support.

Every code in the extended carrier belongs to exactly one of these forms: an old code; the singleton \((q)\); or an old nonempty code with \(q\) appended, provided its every old support is disjoint from the fresh support. To prove completeness, split a source-order selection according to whether it contains the final fresh input. If it does, remove that final input; the remaining selection is empty or an old code, and the code predicate supplies all required fresh-pair separations. Conversely, each listed form satisfies every pair check. `ChannelExtension.candidateAlternatives` proves the full equivalence.

Starting from the singleton base, these successor constructions cover arbitrary positive finite carriers. At each stage the complete candidate family is retained and its maximum filter applied. No fixed carrier-size cutoff enters the proofs.

## 10. Preservation grammars and verification

Each original law also carries ten binary preservation coordinates. For channels these are input coverage, output coverage, relation, totality, confusability, codes, capacity, composition, generality and added-model status. For transformations they are support, map, provenance, accounting, loss, reversal, composition, conservation, generality and added-source status.

For each law the complete product has \(2^{10}=1,024\) forms. A form survives exactly when all ten coordinates take their original admitted alternative. The forward argument fixes each coordinate; the reverse substitutes the all-admitted tuple. Their native grammar modules prove exhaustive generation, exact criteria equivalence, unique survival and rejection by every failed coordinate. The operation-level theorems above supply the specific finite mathematics retained by these forms.

The retained entry audits contain 177 channel and 162 transformation declarations: 339 distinct names with empty axiom dependencies. The original/native programme comparisons reproduce all 1,024 identifier-based decisions per entry, registration fields, complete census and decision hashes, closure and controls, and unknown-identifier rejection. All five original operational witnesses per entry are retained.

The portable reproduction additionally checks 399 complete small channels, 392 fresh-input extensions, 120 total maps and 624 deterministic compositions against independently constructed exact outputs. These executions retain all tied families and every ledger field; the native proofs above quantify over arbitrary admitted finite carriers.

<div style="break-before:page"></div>

## 11. Sources and authorship

Maria Smith is the scientific author of SFT and the original derivations. AI assistance supports translation, verification and manuscript preparation under her direction.

V3 is pinned to `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The exact operations are in `sft/information_science/channels_capacity/law.py` and `conservation_loss_transformation/law.py`; their shared registration and grammar programme is `generated_law.py`. The native corpus is V4 edition 0.4, commit `21cdf559922fb057f8560f42d056ffa035329eb3`. Completion receipts TURN148 and TURN164 retain source-component correspondence and the applicable original/native comparisons. The companion archive includes the proof bodies, imported dependencies and exact reproduction.

## References

1. Maria Smith. Smithian Fold Theory V3 foundation. https://doi.org/10.5281/zenodo.21627656.
2. Maria Smith. Smithian Fold Theory exhaustive monograph. https://doi.org/10.5281/zenodo.21900790.
3. Maria Smith. SFT V4 Lean verified corpus, edition 0.4. https://doi.org/10.5281/zenodo.24320778.

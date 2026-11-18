# Exact evaluation, minimum circuits and correction width for finite Fold words

**Maria Smith**  
Ernos Labs  
Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com)  
SFT community and invitation: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

Every positive finite native Fold word of depth k closes in exactly k lawful transitions. Its complete evaluation is its unique accepted certificate, giving the native equality P_F = NP_F with equal edge resources. Across every circuit built from the lawful suffix edges, depth-k closure requires k gates, complete depth-k input support requires 2^k vertices, and complete layered coverage requires 2^(k+1) − 2 distinct edges. The complete circuit attains all three bounds. For every positive finite fault order t, the first repetition width correcting every mask of at most t changes is 2t + 1: every smaller positive width has an explicit tie or wrong-majority counterexample. Recovery preserves the source word and its exact subsequent circuit evaluation. This paper derives these results, the complete four 256-candidate grammar classifications, and their finite successor constructions. Four completed V3 registrations correspond to twenty-one native Lean modules and 444 distinct declarations with empty axiom audits. The source package retains the original programs, proof bodies and comparisons, including all 16,384 subsets of the fourteen-edge circuit and all 168 small-order correction masks.

## 1. Exact domain and headline results

Let \(A=\{\mathtt{held\!\text{-}\!lower},\mathtt{held\!\text{-}\!upper}\}\) be the two original labels. A depth-\(k\) source is a word in \(W_k=A^k\), for a supplied positive finite \(k\). Write \(\epsilon_F=(\mathtt{empty\!\text{-}\!One})\) for the distinguished terminal record; it is separate from the generated label alphabet. Define

\[
 W_{\le k}=\bigcup_{r=1}^{k}W_r,\qquad
 f(w)=\begin{cases}\operatorname{tail}(w),&|w|>1,\\ \epsilon_F,&|w|=1.\end{cases}
\]

The union is enumerated in increasing depth, with the original label order within each layer. Each native gate is exactly \((w,f(w))\). These are the actual source domain and transition operation in `sft/computation/lineage_laws.py` [4]. Native resource means the number of these lawful edges. Define \(T(w)\) as the complete suffix-closing trace and \(V(w,c)\) as the original exact trace verifier. The principal equalities are

\[
 |T(w)|-1=|w|,\qquad BB_F(k)=k,
\]
\[
 V(w,c)=\mathrm{true}\ \Longleftrightarrow\ c=T(w),\qquad P_F=NP_F,
\]
\[
 (D_k,B_k,S_k)=\left(k,2^k,\sum_{r=1}^{k}2^r\right)
                 =\left(k,2^k,2^{k+1}-2\right).
\]

Here \(P_F\) and \(NP_F\) denote evaluation and accepted-certificate computation in this generated native grammar; \(D_k,B_k,S_k\) are the tight complete Fold-circuit path, input-width and layered-size resources. The corresponding fault-order theorem uses the original correction alphabet \(\{\mathtt{held},\mathtt{returned}\}\), a nonempty distinct fault trace of length \(t\), and strict-majority repetition decoding:

\[
 w_{\min}(t)=2t+1,\qquad R(t)=2t,\qquad w_{\min}(t+1)=w_{\min}(t)+2.
\]

Each parameter is supplied by its generated finite input. None of these equalities introduces a fitted coefficient or a selectable transition rule. Sections 2–6 give the derivations and the exact quantified carriers.

## 2. Complete generation and the maximum closing time

The word generator has the recursive construction

\[
 W_0=[[]],\qquad W_{r+1}=[a::u\mid a\in A,\ u\in W_r].
\]

The auxiliary empty list seeds generation; the public positive-depth constructor rejects nonpositive depth. By induction, membership in \(W_r\) is equivalent to length \(r\) and every cell belonging to \(A\). For the successor, the first cell belongs to \(A\) and the tail belongs to \(W_r\); conversely every nonempty word of the required length splits in that way. Thus no generated word is omitted. The same recursion yields \(|W_0|=1\) and \(|W_{r+1}|=2|W_r|\), hence \(|W_r|=2^r\). Distinct label choices and distinct tails give distinct words. Different positive layers are disjoint because their lengths differ.

The internal trace recursion is

\[
 T([])=[\epsilon_F],\qquad T(a::u)=(a::u)::T(u).
\]

For an admitted nonempty word, this is exactly the source operation: retain the initial word, successively remove its head, retain the one-letter state, and append the terminal. For example,

\[
 T([a,b,a])=[[a,b,a],[b,a],[a],\epsilon_F].
\]

**Theorem 1.** For every generated word \(w\in W_k\), the trace contains \(k+1\) states and exactly \(k\) transitions.

The list induction proves the stronger internal equation \(|T(w)|=|w|+1\). At the empty list the trace has one terminal state. At \(a::u\), the recursive call supplies \(|u|+1\) states and prepending the initial state gives \(|u|+2=|a::u|+1\). Subtracting one state gives the transition count. The positive-depth admission guards follow from the membership characterization: the word is nonempty and every cell is one of the two allowed labels. The corresponding native declarations are `NativeClosing.exactTraceLength`, `exactHaltTime`, `everyGeneratedWordHalts` and `NativeClosingDomain.generatedWordAdmitted` [6].

Define the native maximum over the entire closing population,

\[
 BB_F(k)=\max_{w\in W_{\le k}}(|T(w)|-1).
\]

Each word belongs to some \(W_r\) with \(1\le r\le k\), so Theorem 1 bounds its time by \(k\). The word containing \(k\) copies of the first label belongs to \(W_k\) and attains time \(k\). Both bounds force equality. The implementation takes the maximum by a left fold; `maximumUpper` proves that the fold preserves the upper bound, and `maximumRetainsMember` proves it retains the attaining value. Therefore the executable maximum, as well as its abstract characterization, equals \(k\). These are `maximumCharacterization` and `nativeBusyBeaverValue`.

Prepending either label adds one state and one edge:

\[
 |T(a::w)|-1=(|T(w)|-1)+1.
\]

The exhaustive successor generator creates every word at the next depth. Consequently \(BB_F(k+1)=BB_F(k)+1\) holds for every positive finite depth, independently of a fixed table. The source also retains a separate recurrent process: the two labels alternate, returning after period two. Every observed label remains in \(A\), and no singleton of either label is \(\epsilon_F\). `recurrenceHasNoEmptyOne` proves this exclusion for every supplied positive finite trace length. This recurrent trace never contributes a terminal closing time to the maximum.

## 3. Unique certificates and exact native evaluation resources

The verifier first rejects an empty certificate, then a wrong initial state, then a wrong terminal. It calls the guarded closing evaluator and accepts precisely when the supplied complete list equals that evaluation. Thus every intermediate state and its order enter the equality test.

**Theorem 2.** For every \(k>0\), every \(w\in W_k\), and every finite list of proposed states \(c\),

\[
 V(w,c)=\mathrm{true}\quad\Longleftrightarrow\quad c=T(w).
\]

For soundness, success eliminates each rejecting branch. The successful evaluator branch returns \(T(w)\); the final true equality test forces \(c=T(w)\). For completeness, the admitted source produces a nonempty trace whose head is \(w\). Induction on the word proves that its final element is \(\epsilon_F\). Every guard therefore succeeds, and the final equality is reflexive. These are `NativeVerification.acceptedTraceIsEvaluation`, `evaluationTerminal`, `everyGeneratedEvaluationAccepted` and `bothContainments` [6].

Evaluation emits an accepted certificate, establishing the native evaluation-to-verification containment. Conversely every accepted certificate is that deterministic evaluation, establishing the reverse containment. Their edge resources are identical:

\[
 c=T(w)\quad\Longrightarrow\quad |c|-1=|T(w)|-1=k.
\]

`exactResourceEquality` records both equations together. The native equality \(P_F=NP_F\) expresses these two containments on the generated word/process carrier. Prepending a label adds exactly the same one edge to evaluation and accepted certification.

The original adverse control changes the first certificate state to the reversed source when reversal differs; otherwise it replaces that state by \(\epsilon_F\). In the first case the new head differs by construction. In the second, the generated source cannot equal \(\epsilon_F\), because its cells belong to \(A\). Hence the head guard rejects in both cases. `changedHeadRejected`, `generatedNotEmptyOne` and `everyGeneratedTamperRejected` establish this for every generated source. The complete operational check through depth seven includes \(2+4+\cdots+128=254\) accepted evaluations and 254 rejected changed certificates.

## 4. Tight lower bounds over every lawful circuit

For a cap \(k\), let

\[
 E_k=[(w,f(w))\mid w\in W_{\le k}].
\]

A lawful circuit is a finite list \(C\) of edges, each belonging to \(E_k\). A path consists of a zero-edge identity path or an edge of \(C\) followed by a path. This is the exact inductive `NativeCircuitPaths.Path` type. It permits arbitrary finite composition of the admitted edges.

Assign rank zero to \(\epsilon_F\), and rank \(|w|\) to a generated word. Each lawful edge reduces rank by exactly one. For a one-letter source the target is the rank-zero terminal. For a longer source the tail has one fewer cell and remains generated. Induction on a path from \(x\) to \(y\) with \(n\) edges gives

\[
 \rho(x)=\rho(y)+n.
\]

The identity case has \(n=0\). For a leading edge \(x\to z\), use \(\rho(x)=\rho(z)+1\) and the induction equation \(\rho(z)=\rho(y)+n\), giving \(\rho(x)=\rho(y)+(n+1)\). A closing path from \(w\in W_r\) to \(\epsilon_F\) therefore has exactly \(r\) edges. This proves necessity across every lawful circuit, through `edgeLowers`, `everyPathRank` and `everyClosingPathHasRequiredDepth`.

Complete depth-\(k\) input support contains all \(2^k\) distinct words, so its source list has length at least \(2^k\). Complete layered coverage contains the outgoing edge for every \(w\in W_{\le k}\). Distinct words give distinct edges because their first projections differ. Consequently

\[
 |C|\ge |W_{\le k}|=\sum_{r=1}^{k}2^r.
\]

The native proof maps the circuit edges to their first projections, applies the distinct-source containment bound, and uses preservation of length under mapping. This is `requiredSourceEdges`, based on `layeredSourceLowerBound`; `inputWidthLowerBound` supplies the width result. In particular, requiring a closing path from each source forces its outgoing edge: a positive-rank source is not the terminal, so the path has a first edge, and the only lawful edge with that source is its suffix edge.

The complete construction \(C=E_k\) attains these bounds. Its source count is exactly the complete layer count; its edges are distinct. For each nonempty source, its own edge belongs to \(E_k\). Its nonempty tail lies at a smaller retained layer, so induction constructs the rest of the path; a one-letter source closes in one edge. `completeCircuitAttainsPath` proves this construction for every source through the cap. The recurrence

\[
 S_0=0,\qquad S_{k+1}=S_k+2^{k+1}
\]

implies \(S_k=2^{k+1}-2\): the base is \(0=2-2\), and substitution at the successor gives \((2^{k+1}-2)+2^{k+1}=2^{k+2}-2\). Together with the path and width proofs this establishes all three tight resources stated in Section 1.

At depth three there are \(2+4+8=14\) forced edges. The original census generates every subset by its fourteen-bit mask, hence \(2^{14}=16{,}384\) subsets. Full coverage requires every bit to be set, giving the sole mask

\[
 \sum_{i=0}^{13}2^i=2^{14}-1=16{,}383.
\]

`NativeCircuitCensus.completeSubsetCensus` establishes exactly that singleton survivor list. The arbitrary-depth path and source-count proofs above supply the general lower bounds; the census exhausts the original declared finite subset experiment.

## 5. Every finite fault order: correction and minimality

Let a fault trace be a nonempty list of distinct identifiers, and let \(t\) be its length. Encode one original label \(a\in\{\mathtt{held},\mathtt{returned}\}\) by \(w\) repeated copies. A mask is a subset of the \(w\) positions containing at most \(t\) positions; selected positions become the opposite label. The decoder rejects empty words and unregistered labels, returns the strict majority when present, and returns the exact `no-strict-majority` result on a tie.

The exhaustive mask generator enumerates every increasing position sublist of length \(j\), for \(0\le j\le t\). Its recursive combination generator either includes the first available position and chooses \(j-1\) from the tail, or omits that position and chooses \(j\) from the tail. Induction proves both directions of

\[
 M\in\operatorname{Masks}(w,t)
 \quad\Longleftrightarrow\quad
 M\text{ is a sublist of }[0,\ldots,w-1]\ \land\ |M|\le t.
\]

These are `ReversibleFaults.combinationExactly` and `faultMasksExactly`. Thus every allowed mask appears, with its exact position record.

**Theorem 3.** At width \(2t+1\), every mask of at most \(t\) changes decodes to the original label.

Let \(m\) be the number of changed positions. The count induction retains total length and gives

\[
 m\le t,\qquad c+m=2t+1,\qquad c\ge t+1>m,
\]

where \(c\) counts original labels. To prove the changed-count bound directly, scan the word. An unselected position contributes no changed label. At a selected position, remove that position from the remaining mask; its length decreases by one, while changes at later positions are unchanged. Induction then bounds the total by the original mask length. Every scanned cell is one of the two registered labels. The decoder therefore reaches its strict-majority branch and returns the source. This is the proof in `changedCountBound`, `changedCounts`, `majorityFromBudget`, `heldCorrection` and `returnedCorrection`, reused by `UnboundedFaults.everyHeldMask` and `everyReturnedMask` [7].

**Theorem 4.** Every positive width \(w\le2t\) fails to correct all masks of at most \(t\) changes.

Change the first

\[
 m=\left\lceil\frac w2\right\rceil=\left\lfloor\frac{w+1}{2}\right\rfloor
\]

positions of the all-held word. Since \(w\le2t\), \(m\le t\), so this is an allowed mask. Also \(2m\ge w\), hence \(w-m\le m\). If \(w\) is even, changed and original counts tie; if \(w\) is odd, the changed label has the strict majority. Neither result is the original held label. The native quotient/remainder argument proves `predecessorAllowance` and `predecessorTwiceCover`; the exact count equations are `predecessorReturnedCount` and `predecessorHeldCount`. `everyPredecessorDefeatsHeld` then follows by the actual decoder branches.

Theorem 3 proves sufficiency of \(2t+1\), and Theorem 4 eliminates every smaller positive width. The first width is therefore unique. Removing the single information label leaves redundancy \(2t\). At the next fault order,

\[
 2(t+1)+1=(2t+1)+2.
\]

The same sufficiency and predecessor arguments apply at that successor. For every supplied finite order \(t\), the next generated order \(t+1\) exists and has its forced width. This is the unbounded finite-order construction, with no fixed maximum order selected.

## 6. Exact recovery and subsequent circuit composition

For the original word-level round trip, each source cell is repeated \(2t+1\) times and the first \(t\) positions are changed. The resulting cell has \(t\) opposite and \(t+1\) source labels, so it recovers exactly. The arbitrary-mask theorem also applies separately to every allowed cell mask.

The source `recoverWord` recursively decodes the canonical changed block at the head and then the remaining source. For the empty source it returns the empty word. For \(a::u\), the cell theorem returns \(a\), and the induction hypothesis returns \(u\); hence

\[
 \operatorname{recoverWord}(s,t,2t+1)=s
\]

for every finite word over the correction alphabet. This is `UnboundedFaults.everySourceWordRecovers`, whose proof uses `worstHeldRecovers` and `worstReturnedRecovers` in the two label cases.

A reversible circuit state retains an ordered collection of word/phase records and its phase cycle. Let \(B,A\) be arbitrary preceding and following record lists, \(p\) a phase, \(\gamma\) a cycle and \(G\) a finite gate list. If recovery returns \(s'\), its exact-word theorem gives \(s'=s\). Substitution yields

\[
 \operatorname{Eval}(B\mathbin{+\!+}[(s',p)]\mathbin{+\!+}A,\gamma,G)
 =\operatorname{Eval}(B\mathbin{+\!+}[(s,p)]\mathbin{+\!+}A,\gamma,G).
\]

`UnboundedComposition.recoveryPreservesCircuit` states this equality for all these arguments. Evaluation applies the original gate operation in order and retains its intermediate states and terminal, or its exact error result. Because recovery supplies the identical input word, the entire evaluation result is identical. This connects correction to the existing circuit semantics without choosing a new gate operation.

## 7. Four complete grammar classifications

Each original registration constructs the literal product of eight binary coordinates. The following tables retain the exact source alternatives and their order; hyphens inside labels are displayed as spaces for readability.

### 7.1 Closing maximum

| Coordinate | First alternative | Admitted alternative |
|---|---|---|
| grammar | external transition tables | complete native fold descriptions |
| transition | chosen instruction step | one lawful depth lowering edge |
| halting | assumed terminal | exact empty one terminal trace |
| maximum | sampled long run | complete upper and attaining lower witness |
| recurrence | cycle counted as halt | separate exact nonhalting certificate |
| successor | depth fourteen table only | prepend one label successor |
| evidence | reported number | all process traces and attainment |
| addition | conventional busy beaver import | no extra machine premise |


### 7.2 Evaluation and certification

| Coordinate | First alternative | Admitted alternative |
|---|---|---|
| domain | arbitrary external languages | complete native fold word family |
| evaluator | answer only evaluation | unique exact closing trace |
| certificate | unconstrained advice | compiled lawful evaluation trace |
| verifier | test sampled verifier | edgewise sound complete verifier |
| p to np | assumed first containment | evaluator emits accepted certificate |
| np to p | nondeterministic branch import | soundness forces unique evaluation |
| successor | depth seven only | prepend label trace successor |
| boundary | export to arbitrary p np | native equality only |


### 7.3 Complete lawful circuits

| Coordinate | First alternative | Admitted alternative |
|---|---|---|
| gate | rewired or multi depth gate | unique lawful one depth edge |
| path | reported k depth | one distinction per dependent edge |
| width | sampled input width | all b to k source words |
| size | one implementation count | every source edge required |
| exhaustion | selected subsets | complete forced edge subset census |
| attainment | unattained bound | registered circuit attains all bounds |
| successor | finite table only | add next complete source layer |
| boundary | arbitrary gate basis export | admitted fold circuits only |


### 7.4 Finite fault correction

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


For each table let \(C=\prod_{i=1}^{8}\{0,1\}\), assigning 0 to the first alternative and 1 to the admitted alternative. The product has exactly \(2^8=256\) candidates. Completeness follows by case analysis on each binary constructor followed by the eight nested product-membership steps. Every possible candidate therefore appears in the actual enumeration.

The original decision preserves all eight source requirements conjunctively. Its native criteria equation is

\[
 D(c)=\bigwedge_{i=1}^{8}(c_i=1).
\]

Exhausting the two constructors in each field identifies the original decision with this conjunction. If \(D(c)\) is true, each coordinate equals 1, so \(c=(1,1,1,1,1,1,1,1)\). Conversely that exact candidate satisfies every criterion. This proves existence, uniqueness and the rejection of every candidate having a first-alternative coordinate. The native `generatedCardinality`, `candidatesComplete`, `sourceDecisionMatchesCriteria`, `uniqueSurvivor` and `acceptanceIffExactCriteria` declarations establish these facts in each of `NativeBusyGrammar`, `NativePnpGrammar`, `NativeCircuitGrammar` and `UnboundedGrammar`.

The coordinates follow the constructions just proved. Closing requires complete words, one-depth edges, terminal traces and both maximum bounds; certificate equality requires both containments; complete circuits require every source edge and an attaining construction; correction requires exhaustive masks and a counterexample at every predecessor width. The successor arguments supply closure for arbitrary supplied finite depth and fault order. These derivations and the full classification together identify the unique source-preserving construction in each grammar.

## 8. Retained evidence and exact reproduction

| Completed registration | Direct modules | Distinct audited declarations | Completion receipt |
|---|---:|---:|---|
| Native Busy-Beaver 002 | 5 | 116 | TURN864 |
| Fold-P/NP equality 002 | 4 | 82 | TURN865 |
| Fold-circuit lower bound 002 | 7 | 110 | TURN866 |
| Unbounded finite fault tolerance 002 | 5 | 136 | TURN867 |
| Total | 21 | 444 | Four completed entries |

All 444 retained declaration audits report empty axiom dependencies. All twenty-one receipt-bound module digests match; all 197 native modules including imports match the published V4 source archive. The package also contains twenty-four files from the exact V3 commit, original full-program comparisons, complete 256-candidate decision records and independent accepted/adverse controls. Source identity, proof bodies, axiom audits and executable source comparison are retained separately.

The portable reproduction executes the original function bodies and checks all 32,766 closing words through depth fourteen, resource equations at each depth, the complete 254-source certificate check, all 16,384 edge subsets, fourteen fault orders, 168 small-order masks, 210 predecessor counterexamples and all 128 depth-seven source words at fault order fourteen. Eight invalid-input calls verify the source guards. At fault orders one, two and three the complete two-label mask counts are

\[
 2\left[\sum_{j=0}^{1}\binom3j+\sum_{j=0}^{2}\binom5j+
 \sum_{j=0}^{3}\binom7j\right]=2(4+16+64)=168.
\]

The predecessor count is \(\sum_{t=1}^{14}2t=210\). The general proofs in Sections 2–6 quantify over arbitrary supplied finite input; the operational vectors reproduce the original declared experiments exactly.

`SOURCE_CORRESPONDENCE.json` supplies full declaration names, registrations, source paths and digests. Extract `SOURCE_AND_EVIDENCE.zip` and run `python3 reproduction/check_paper_arithmetic.py` to regenerate the paper's arithmetic and source-operation checks. The retained Lean build and audit results accompany their exact source versions.

## References

[1] Maria Smith. SFT V3 foundation. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).

[2] Maria Smith. SFT exhaustive monograph. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[3] Maria Smith. SFT V4 Lean verified corpus, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Contact edition: [doi:10.5281/zenodo.24337358](https://doi.org/10.5281/zenodo.24337358).

[4] Maria Smith. V3 computation source, `sft/computation/lineage_laws.py`, pinned commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Original registrations SFT-COMP-CBL-NATIVE-BUSY-BEAVER-002, SFT-COMP-CPLX-FOLD-P-NP-EQUALITY-002 and SFT-COMP-CPLX-ARBITRARY-CIRCUIT-LOWER-BOUND-002. Verbatim files and dependencies accompany this paper.

[5] Maria Smith. V3 correction source, `sft/quantum_computation/lineage_laws.py`, at the commit in [4]. Registration SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002, its generated-law implementation and original derivation documents are retained in the source package.

[6] Maria Smith. [Pinned native computation proofs](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Computation), V4 commit `21cdf559922fb057f8560f42d056ffa035329eb3`. NativeClosing, NativeClosingDomain, NativeVerification, NativeCircuit, NativeCircuitPaths, NativeCircuitCensus, NativeCircuitDomain, and corresponding grammar/evidence modules; TURN864–866 completion evidence.

[7] Maria Smith. [Pinned native correction and composition proofs](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/QuantumComputation), same V4 commit. ReversibleFaults, ReversibleCorrection, ReversibleInterpretation, UnboundedFaults, UnboundedComposition, UnboundedGrammar and associated witnesses/evidence; TURN867 completion evidence.

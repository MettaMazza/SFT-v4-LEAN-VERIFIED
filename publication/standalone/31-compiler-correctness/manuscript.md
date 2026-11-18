# Compiler correctness by composition of observed executions

**Maria Smith**  
Ernos Labs  
Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com)  
SFT community and invitation: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

A complete compiler certificate yields a total verified translation relation: every source form has a target in the declared target grammar, and every allowed translation preserves the declared observation on every registered runtime input. Each comparison retains both complete executions. Compiler stages compose through equality of their intermediate expression, input support and observation interface; repeated composition proves the result for every finite serial chain. Input extension preserves the certificate and concatenates the complete observation records. A worked three-program chain preserves the exact results 1 and 5/6 while retaining event counts 6, 6 and 10. The accompanying native basis construction gives every generated held-label word a unique basis name and a unique inverse, with complete branch provenance and exact reconstruction after observation. The paper derives both constructions, their successor laws and their complete 256- and 1,024-candidate classifications. Two completed V3 registrations supply sixteen native Lean modules and 283 audited definitions and theorems with empty axiom dependencies.

## 1. Total verified compilation

Fix two finite generated grammar carriers \(I\) and \(O\), and an admitted relation \(R\subseteq I\times O\). A form is the original retained grammar object. The relation can contain several targets for one source; each row remains separately represented. Its native representation is `FormalSpecification.RelationSpecification`, containing the two carriers, the allowed rows and the successful original `generatedRelation` construction [6].

A runtime interface is a tuple

\[
 \mathcal U=(S,E_s,E_t,o),
\]

where \(S\) is the finite ordered support of input environments, \(E_s:I\to\mathrm{Expr}\) and \(E_t:O\to\mathrm{Expr}\) interpret forms as source and target expressions, and \(o\) maps a complete execution result and event list to an observation string. The native functions accept arbitrary form arguments, with relation membership enforcing the declared grammar carriers. These are the actual fields of `CompilationRelation.Runtime`.

Let \(\operatorname{run}(\sigma,e)\) return the exact result and complete execution event list for expression \(e\) in environment \(\sigma\). Define

\[
 \operatorname{Eq}_{S,o}(e,f)
 \quad\Longleftrightarrow\quad
 \forall\sigma\in S,\ o(\operatorname{run}(\sigma,e))
                    =o(\operatorname{run}(\sigma,f)).
\]

The executable row check is the original complete equivalence certificate:

\[
 \operatorname{checked}_{\mathcal U}(s,t)
 =\bigwedge_{\sigma\in S}
 [o(\operatorname{run}(\sigma,E_s(s)))
  =o(\operatorname{run}(\sigma,E_t(t)))].
\]

The coverage and full compiler checks are

\[
 \operatorname{coverage}(R)=
 \bigwedge_{s\in I}\ \bigvee_{(a,b)\in R}[a=s],
\]
\[
 \operatorname{compilerCheck}(R,\mathcal U)
 =\operatorname{coverage}(R)\land
   \bigwedge_{(s,t)\in R}\operatorname{checked}_{\mathcal U}(s,t).
\]

**Theorem 1 (total verified translation).** If the complete compiler check succeeds, then

\[
 \forall s\in I,\ \exists t\in O:\ (s,t)\in R\ \land\
 \operatorname{Eq}_{S,o}(E_s(s),E_t(t)).
\]

The coverage conjunction supplies a true disjunction for the selected \(s\). Its successful row gives a target \(t\) with \((s,t)\in R\). The all-rows conjunct supplies the semantic check for that same row. The generated-relation invariant places \(t\) in \(O\), and the exact certificate theorem turns its true check into observation equality on every input in \(S\). Thus coverage and semantic evidence refer to the identical selected target. This is `coverageMeaning`, `grammarBoundary`, `verifiedTotal` and `completeCompilerCheck` in `SFT.Computation.CompilationRelation` [6].

Every other allowed row is also checked: `everyRelationRowChecked` obtains its Boolean check from the same conjunction. A source outside \(I\) or target outside \(O\) cannot belong to \(R\), because that would contradict the generated-relation invariant. A false semantic row cannot be `Verified`, since verification includes equality of that check with true. These exclusions are proved by `outsideSourceRejected`, `outsideTargetRejected` and `failureRejected`. The construction therefore retains the full relation and its complete successful and adverse evidence.

## 2. Exact executions and observation certificates

The original evaluator [4] has value, name and join constructors. An environment is an ordered finite list of binding-name/exact-number pairs with distinct binding identities. A literal value must be a positive exact rational; name lookup returns the corresponding environment value. A join evaluates its left expression, then its right expression, and adds their exact results. Duplicate bindings, an unbound name, an inadmissible literal and an unregistered constructor produce their original error results.

The native trace records an `enter` event and a `leave` event for every evaluated expression, retaining the environment, expression and resulting value or error. Define

\[
 \operatorname{frame}(\sigma,e,L,r)
 =[\operatorname{enter}(\sigma,e)]\mathbin{+\!+}L
 \mathbin{+\!+}[\operatorname{leave}(\sigma,e,r)].
\]

A leaf has no child events. A successful join with child runs \((a,L)\) and \((b,M)\) has result \(a+b\) and event list \(\operatorname{frame}(\sigma,e,L\mathbin{+\!+}M,a+b)\). If the left child fails, the parent retains that child's events and propagates its error; the right child is not evaluated. If the right child fails after a successful left child, both child event lists are retained in order. A duplicate environment fails at the outer frame before child evaluation.

`EvaluationTrace.Execution` has constructors for precisely these cases. Structural induction on the expression constructs a derivation for the executable run: each leaf uses its own rule, and each join selects the rule determined by its child results. Conversely induction on an execution derivation replays that same run. Therefore

\[
 \operatorname{Execution}(\sigma,e,r,L)
 \quad\Longleftrightarrow\quad
 \operatorname{run}(\sigma,e)=(r,L).
\]

This is `exactExecution`, established by `reconstruct` and `replay`. The result projection equals the original evaluator through `resultCorrespondence`. Two execution derivations for the same expression and environment replay to the identical pair; projecting equality proves equality of both result and event list. `noOmittedRows` records that exact uniqueness.

For an input \(\sigma\), a comparison row retains

\[
 (\sigma,\operatorname{run}(\sigma,e),\operatorname{run}(\sigma,f),
 o(\operatorname{run}(\sigma,e)),o(\operatorname{run}(\sigma,f))).
\]

Mapping this record over \(S\) creates the complete ledger. Every ledger row arises from an input in \(S\); applying `reconstruct` to both executions gives the full source and target derivations for that row. This is `ProgramEquivalence.completeExecutions`, used directly by `CompilationRelation.completeExecutionRows`.

The certificate is recursively the equality test at the first input conjoined with the certificate on the remaining inputs. Induction proves soundness: a true conjunction supplies equality at the head and the induction hypothesis for every tail member. The reverse induction proves completeness: pointwise equality makes the head test true, and restriction to the tail supplies the remaining certificate. Hence

\[
 \operatorname{certificate}(S,o,e,f)=\mathrm{true}
 \quad\Longleftrightarrow\quad\operatorname{Eq}_{S,o}(e,f).
\]

The empty input support is the induction base with a true empty conjunction. The theorem states its actual finite support explicitly. If the certificate is false, either its head equality fails or the tail certificate fails. Recursing in the latter case produces an actual distinguishing input in \(S\). The ledger filters rows into equal-observation and differing-observation lists; equality case analysis proves these lists cover the full ledger and are disjoint. `exactCertificate`, `distinguishingInput`, `completeDistinctions` and `disjointDistinctions` establish these results.

## 3. Serial composition and finite chains

Consider two runtimes \(\mathcal U_1\) and \(\mathcal U_2\), source form \(s\), intermediate form \(m\), and target form \(t\). The original serial theorem has three explicit interface equalities:

\[
 S_1=S_2,\qquad o_1=o_2,\qquad E_{1,t}(m)=E_{2,s}(m).
\]

Suppose both row checks succeed. For every \(\sigma\in S_1\), the first certificate gives

\[
 o_1(\operatorname{run}(\sigma,E_{1,s}(s)))
 =o_1(\operatorname{run}(\sigma,E_{1,t}(m))).
\]

Rewrite the second certificate using the three interface equalities. It gives

\[
 o_1(\operatorname{run}(\sigma,E_{1,t}(m)))
 =o_1(\operatorname{run}(\sigma,E_{2,t}(t))).
\]

The right side of the first equation is now literally the left side of the second. Equality transitivity proves

\[
 \operatorname{Eq}_{S_1,o_1}(E_{1,s}(s),E_{2,t}(t)).
\]

This is the proof body of `CompilationRelation.serialCorrespondence`: obtain both semantic equivalences, rewrite the interfaces, and apply `ProgramEquivalence.composition`. The middle execution is preserved as the shared term connecting the observations.

For a finite chain of \(n\) stages with these equalities at every adjacent interface, the endpoint observation theorem follows by induction on \(n\). At zero stages the expression equals itself, and `identityCorrespondence` gives a true certificate. For the successor, the induction hypothesis gives equality from the initial expression to the current endpoint; the next checked stage gives equality from that same endpoint to the new endpoint. The two-stage argument composes them. If each stage also has a successful complete compiler check and the middle target carrier is admitted as the next source carrier, repeated application of Theorem 1 supplies the intermediate form witnesses and the final target. This retains the existential translation relation through the whole finite chain.

Input extension has a separate exact law. If the same expressions and observation agree on \(S\) and on an additional support \(T\), membership in \(S\mathbin{+\!+}T\) lies in one list or the other. The corresponding equality proves agreement on the concatenated support. Certificate completeness then yields a true extended certificate. Mapping the record constructor over append gives

\[
 \operatorname{ledger}(S\mathbin{+\!+}T,o,e,f)
 =\operatorname{ledger}(S,o,e,f)\mathbin{+\!+}\operatorname{ledger}(T,o,e,f).
\]

Thus every old row remains and every added input has its complete new row. These are `inputSuccessor` and `observationSuccessor`. Repeated occurrences in the supplied input list retain their corresponding repeated records.

## 4. A worked three-program chain

Use the exact source syntax and the following expressions:

\[
 e_0=\operatorname{join}(\operatorname{name}(x),\operatorname{value}(1/3)),
\]
\[
 e_1=\operatorname{join}(\operatorname{value}(1/3),\operatorname{name}(x)),
\]
\[
 e_2=\operatorname{join}(\operatorname{name}(x),
              \operatorname{join}(\operatorname{value}(1/6),\operatorname{value}(1/6))).
\]

Let \(S=[\{x\mapsto2/3\},\{x\mapsto1/2\}]\). Define \(o\) to return a canonical exact result string, including the exact error string when evaluation fails. The observation is fixed for both stages. Introduce singleton form carriers for the three expressions and the relation rows \((s,m)\) and \((m,t)\). Each carrier is fully covered by its row. Interpret \(m\) as exactly \(e_1\) on both sides of the interface.

At \(x=2/3\), the exact arithmetic is

\[
 2/3+1/3=1,\qquad1/3+2/3=1,\qquad
 1/6+1/6=1/3,\quad2/3+1/3=1.
\]

At \(x=1/2\), convert to sixths:

\[
 1/2+1/3=3/6+2/6=5/6,
\]
\[
 1/3+1/2=2/6+3/6=5/6,\qquad
 1/2+(1/6+1/6)=3/6+2/6=5/6.
\]

Every row check succeeds for both stages. Their middle observations are exactly 1 and 5/6, respectively, so the serial theorem gives the same initial-to-final observations.

| Input binding | Observation of e₀ | Observation of e₁ | Observation of e₂ | Event counts e₀/e₁/e₂ |
|---|---:|---:|---:|---|
| x = 2/3 | 1 | 1 | 1 | 6 / 6 / 10 |
| x = 1/2 | 5/6 | 5/6 | 5/6 | 6 / 6 / 10 |

For \(e_0\), the six events are enter-join, enter-name, leave-name, enter-value, leave-value and leave-join. For \(e_1\), the two leaf frames occur in the opposite order. For \(e_2\), the outer join and name contribute four events and its inner join with two value leaves contributes six. The full execution records retain these differences while the fixed result observation agrees.

The original `resource_ledger` takes the complete labelled event sequence and a nonempty distinct occupied-support list. It records each event at its numbered transition position, the event count and the occupied support. Applied with occupied support \([x]\), the three time counts are 6, 6 and 10, and all three space counts are 1. `CompilationRelation.executionResources` proves that each accepted ledger reconstructs its event labels, exact event count and supplied support. The source and target resource ledgers remain separate throughout composition.

Replacing a target by \(x+1/2\) produces \(7/6\) at the first input and 1 at the second. Both observations differ from the corresponding source; these are explicit failed semantic rows. The reproduction also checks the original errors for an unbound name, a zero literal, an outside constructor and duplicate bindings. This example is an instance of the source operations and the proven interface theorem; all its results are regenerated by the attached executable script.

## 5. A canonical basis encoding with a unique inverse

The second original registration supplies the complete native information carrier and its basis naming [5]. Let \(H=[\mathtt{held\!\text{-}\!a},\mathtt{held\!\text{-}\!b}]\) be the two labels inherited from `sft/foundation/fold_assembly.py`, and let \(P=[p_1,\ldots,p_k]\) be a nonempty list of distinct positions. The complete support is the ordered product

\[
 W_k(H)=H^k.
\]

Word induction gives the exact membership characterization

\[
 w\in W_k(H)\quad\Longleftrightarrow\quad
 |w|=k\ \land\ (\forall a\in w,\ a\in H).
\]

This is the same condition for the inherited Fold Assembly support and the quantum-information support. `QuantumCanonical.supportCorrespondence` identifies the two generated carriers through that equivalence. There are \(2^k\) distinct words: each successor appends either held label to each old word, and the last position and preceding word recover the two choices uniquely.

The original basis name is

\[
 B([a_1,\ldots,a_k])=
 \mathtt{basis:}\mathbin{+}\operatorname{join}_{\mathtt{:}}[a_1,\ldots,a_k].
\]

**Theorem 2 (canonical name bijection).** On the complete support generated from \(H\), the name map is injective, its emitted names are duplicate-free, and every emitted name has exactly one source word.

The proof retains the original string operation. All characters in the prefix, delimiter and held labels belong to the explicit alphabet

\[
 \{\mathtt h,\mathtt e,\mathtt l,\mathtt d,\mathtt{-},
   \mathtt a,\mathtt b,\mathtt{:},\mathtt s,\mathtt i\}.
\]

Induction on a character list proves exact UTF-8 encoding/decoding for this finite alphabet. Therefore equality of names implies equality of their character lists. Cancel the shared `basis:` prefix. For nonempty words, prepend a colon to the remaining lists. Each becomes a concatenation of seven-character blocks `:held-a` or `:held-b`. Their seventh characters distinguish the two alternatives. Equality forces the same first block; dropping its seven characters reduces to equality of the remaining blocks. Induction recovers the entire word. The empty list and a first block have different character lists, supplying the terminating case.

These are the actual proofs `decodeEncoded`, `nameChars`, `tailsInjection`, `joinedInjection` and `basisNameInjection`. Restricting them to generated support gives `admittedNamesInjective`. Since the word support is already duplicate-free, injective mapping makes the name list duplicate-free (`admittedNamesDistinct`). Finally, membership in the emitted name list supplies a word preimage. Any second preimage has the same name and hence the same word, proving `basisInverse`.

The raw helper retains its broader original string domain. Its exact delimiter example is \(B([\mathtt a,\mathtt{a:a}])=B([\mathtt{a:a},\mathtt a])=\mathtt{basis:a:a:a}\), with distinct words. `QuantumBasis.delimiterNamesEqual` and `delimiterWordsDifferent` preserve that behavior. The canonical theorem above uses the actual inherited labels \(H\), for which the seven-character argument proves unique inversion. Full basis rows always retain the word alongside its name.

## 6. Complete provenance, observation and successor

For each position \(p_i\), the information-unit construction retains two words: the all-held-a word and the word obtained by replacing only position \(i\) with held-b. Both belong to the complete product; cancellation of the common prefix and comparison at position \(i\) proves they differ. The trace has exactly one such row per position and projects to the entire original position list. These are `QuantumUnits.rowAlternatives`, `alternativesDistinct`, `traceLength` and `tracePositions`.

Every branch additionally retains the complete zip record \(\operatorname{zip}(P,w)\). Since \(|P|=|w|\), induction projects its first components to \(P\) and its second components to \(w\). Thus each branch is identified by all its positions and labels. The source's superposition-equivalent support record consists of this complete alternative family and provenance; its amplitude field is the literal `not-admitted-at-support-boundary` value.

For two nonempty canonical supports \(L\) and \(R\), joint support contains exactly

\[
 J(L,R)=[(a,b,a\mathbin{+\!+}b)\mid a\in L,\ b\in R].
\]

Membership in the outer product loop supplies \(a\), and membership in the inner map supplies \(b\); the emitted triple has exactly their concatenation. Conversely these two membership witnesses insert every such cell. Projection recovers both origins, so the complete pair product preserves all source distinctions. `QuantumJoint.cellMembership` and `cellCoordinates` establish the two statements.

An observation map \(g:W\to Y\) must classify every support word exactly once. For an observed image \(y\) with nonempty predecessor class, the source returns

\[
 W_y=[w\in W\mid g(w)=y],\qquad
 W_{\ne y}=[w\in W\mid g(w)\ne y],
\]

and the complete reconstruction record \(Q=[(w,g(w))\mid w\in W]\). Equality case analysis places each word in exactly one of the two classes. A word cannot satisfy both equality and its negation, proving disjointness. If the complementary class is empty, the output uses the original structural EmptyOne marker. Projection of \(Q\) onto its first component returns \(W\) in its original order; nonempty duplicate-free support makes the reconstruction constructor succeed. `QuantumObservation.retainedClosedCover`, `retainedClosedDisjoint`, `recordProjection` and `observedReconstruction` give these results.

At three positions the canonical support has eight words. Observation of the first label retains four held-a branches, closes four held-b branches, and preserves all eight branch/image rows. Reconstruction recovers all eight. Two one-position supports each containing two words produce four joint cells.

A fresh position \(p\notin P\) extends support by

\[
 W(P\mathbin{+\!+}[p])=[w\mathbin{+\!+}[a]\mid w\in W(P),\ a\in H].
\]

Its provenance equation is

\[
 \operatorname{zip}(P\mathbin{+\!+}[p],w\mathbin{+\!+}[a])
 =\operatorname{zip}(P,w)\mathbin{+\!+}[(p,a)].
\]

Induction on \(P\) and the equal-length word proves the zip equation by retaining the common head pair and applying the induction hypothesis to the tails. The complete product successor preserves distinctness, adds one information-unit row and preserves the canonical basis injection. `QuantumExtension.supportSuccessor`, `admittedProvenanceSuccessor`, `successorDistinct` and `successorTrace` prove the arbitrary finite extension. The first-position base is exactly the two inherited labels.

## 7. Complete source grammars

The compiler registration uses the eight original semantics coordinates; the information-support registration uses ten. The following tables retain their exact alternatives, with label hyphens displayed as spaces.

### 7.1 Compiler semantics

| Coordinate | First alternative | Admitted alternative |
|---|---|---|
| syntax | partial or ambiguous syntax | complete generated syntax |
| binding | presentation name | canonical held binding |
| relation | informal meaning | exact semantic relation |
| evaluation | result only | complete evaluation trace |
| equivalence | visual equivalence | observation bound equivalence |
| proof | test only | machine checkable proof object |
| generality | sample programs | syntax successor certificate |
| addition | imported language semantics | no extra semantic premise |


### 7.2 Canonical information support

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


Each grammar is the literal product of its binary constructor lists. With \(d=8\) or \(d=10\), the carrier contains exactly \(2^d\) candidates: 256 compiler candidates and 1,024 information-support candidates. To prove completeness, split each coordinate into its first or admitted constructor. Every constructor belongs to its generating list. Repeated product-membership introduction then inserts the complete candidate into the nested generator. This proves exhaustive membership for an arbitrary candidate.

The original decision is equivalent to the conjunction of all admitted-coordinate tests:

\[
 D(c)=\bigwedge_{i=1}^{d}[c_i=\mathrm{admitted}].
\]

A true conjunction forces every field to be the admitted constructor, determining one candidate. That candidate passes by direct evaluation. Any first-alternative coordinate contradicts the corresponding conjunct and is rejected. `CompilationGrammar` and `QuantumGrammar` retain the complete source decisions and their uniqueness proofs. The compiler grammar preserves generated syntax, bindings, full executions and the observation interface used in Theorem 1. The support grammar preserves the inherited word carrier, bijective canonical names, complete pair cells and reconstructing observation records used in Theorem 2. Their base and successor derivations are given in Sections 3 and 6.

## 8. Native evidence and reproducibility

| Completed source registration | Direct native modules | Audited definitions and theorems | Completion evidence |
|---|---:|---:|---|
| SFT-COMP-SEM-COMPILATION-001 | 5 | 103 | TURN258 |
| SFT-INFO-QUANTUM-CORRESPONDENCE-001 | 11 | 180 | TURN179; program comparison TURN176 |
| Total | 16 | 283 | Two completed registrations |

The retained raw audit logs report empty axiom dependencies for all 283 listed definitions and theorems. All 214 included native modules, with imports, match the published V4 source archive at the pinned commit. The compiler receipt's original source digests match the pinned V3 files. The original full-program comparisons cover every candidate lookup, registration fields, complete census and closure output, proof hashes, witnesses, controls and unknown-identifier rejection. The quantum program comparison remains applicable to its unchanged executable definitions; the later canonical proof module supplies the actual fixed-label name injection and inverse.

The attached reproduction executes the original evaluator for the worked program results and checks an explicit event adapter following the inspected native trace constructor order. It validates six complete runs, both failed semantic rows, all four original runtime guard errors and the separate event ledgers. It also executes the original support operations across depths one through eight: 510 canonical words and basis names, eight fresh-position extensions, the complete three-position observation and reconstruction, and all four joint cells. The raw delimiter case is retained as an exact source-domain check.

`SOURCE_CORRESPONDENCE.json` gives the registrations, complete native declaration names, source paths and digests. `SOURCE_AND_EVIDENCE.zip` contains the pinned sources, retained proof/build/audit/program evidence and portable script. After extraction run `python3 reproduction/check_paper_arithmetic.py`. The universal compiler, serial-composition and canonical-word proofs are included as proof bodies alongside these executable examples.

## References

[1] Maria Smith. SFT V3 foundation. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).

[2] Maria Smith. SFT exhaustive monograph. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[3] Maria Smith. SFT V4 Lean verified corpus, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Contact edition: [doi:10.5281/zenodo.24337358](https://doi.org/10.5281/zenodo.24337358).

[4] Maria Smith. V3 computation specification and operations, commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`: `sft/computation/spec_data.py` (COMPILATION), `catalog.py`, `operations.py` (`evaluate_expression`, `resource_ledger`), `semantics/compilation/law.py`, and the original registration and derivation documents. Verbatim files accompany this paper.

[5] Maria Smith. V3 canonical support and basis construction, same V3 commit: `sft/information_science/quantum_information_correspondence/law.py` and `sft/foundation/fold_assembly.py`. Original registration SFT-INFO-QUANTUM-CORRESPONDENCE-001 and its derivation documents are retained in the package.

[6] Maria Smith. [Native compiler and execution proofs](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Computation), V4 commit `21cdf559922fb057f8560f42d056ffa035329eb3`. CompilationRelation, ProgramEquivalence, EvaluationTrace, FormalSpecification, ResourceRecord and the Compilation grammar/evidence family; TURN258 completion and full-program comparison.

[7] Maria Smith. [Native canonical support and basis proofs](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/InformationScience), same V4 commit. QuantumCanonical, QuantumSupport, QuantumBasis, QuantumUnits, QuantumJoint, QuantumObservation, QuantumExtension and grammar/evidence modules; TURN179 completion and TURN176 full-program comparison.

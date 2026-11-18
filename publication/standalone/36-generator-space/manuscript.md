# Why the Fold construction gives generator three, three spatial dimensions and boundary rank two

**Maria Smith** · Ernos Labs  
Standalone paper 36 · Version 1.0 · 17 November 2026  
DOI: [10.5281/zenodo.24325335](https://doi.org/10.5281/zenodo.24325335)

## Abstract

Smithian Fold Theory derives generator three, spatial dimension three and boundary rank two by three linked constructions. Complete binary Fold-word support gives the unit parts 1/3 and 1/7. Their exact first-return traces have lengths two and three. Positive-count succession makes the latter the unique least distinct period after the binary generator and excludes every later count from minimality. Independently, a stable direction carrier must retain a distinct return beyond the two fibre roles and a positive restoring remainder before saturation of their four ordered pair cells. The complete positive-count census of the open interval between two and four has the sole member three, which agrees with the recurrence generator. Holding one normal in any independent three-direction carrier leaves exactly all its other directions, of unique rank two. Their complete Cartesian support contains every pair exactly once and grows quadratically at every positive whole scale; the exact rational growth operation gives the same square for every admitted ratio above One. Native Lean 4 proofs establish arbitrary-depth support, all-count minimality, complete stability enumeration, all-position normal removal and general pair-product closure with zero axiom dependencies. The complete source grammars classify 1,024 generator forms, 1,024 spatial forms and 2,048 boundary forms, with one preserving construction in each. No measured dimension, falloff exponent or fitted coefficient enters these constructions.

**Keywords:** spatial dimensions; three-dimensional space; Fold recurrence; generator three; boundary rank; exact dynamics; Smithian Fold Theory; zero free parameters; Lean 4 formal verification.

## 1. Three results and their logical order

The recurrence construction gives
\[
 \frac13\longmapsto\frac23\longmapsto\frac13,
 \qquad
 \frac17\longmapsto\frac27\longmapsto\frac47\longmapsto\frac17.
\]
Both are first-return traces. The second has the unique least whole length greater than two:
\[
 g=3.
\]
The spatial construction separately exhausts the generated positive direction counts satisfying
\[
 2<n<2\cdot2=4.
\]
It yields exactly \(n=3\), and the source requires this unique result to agree with the recurrence generator. For any independent carrier of that length and any one held normal, complete retention of the nonnormal directions gives
\[
 b+1=3,\qquad b=2.
\]
The boundary's complete two-coordinate support consequently has \(r^2\) cells when each coordinate has \(r\) distinct scale cells. These conclusions are the contents of three completed source entries [1–3]: `SFT-PHYS-STRUCT-GENERATOR-THREE-001`, `SFT-PHYS-SPACE-DIMENSION-THREE-001` and `SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001`.

The proofs preserve the distinction between a return period, a spatial direction count and a boundary rank. Their equal or related numerical values follow from the corresponding constructions; they are not interchangeable definitions. The dependency order is Fold support and action, then recurrence generator, then independent spatial census with agreement, then held-normal boundary incidence.

## 2. The positive exact carrier and Fold action

Structural One retains a complete presented occurrence. Exact positive parts keep their relation to this held whole. The operational root partitions arbitrary records into presented occurrence and unpresented absence; a presented challenge is itself an occurrence, while absence supplies none. Equal complementary parts obey \(h+h=1\), so their common part is half-One [4].

The two held Fold fibre roles pair a positive part. A completed whole is cast out when the paired part exceeds One; exact completion retains One. Thus on the original exact carrier
\[
 \mathcal P=\{x\in\mathbb Q:0<x\le1\},
 \qquad
 F(x)=\begin{cases}
 2x,&0<x\le1/2,\\
 2x-1,&1/2<x\le1.
 \end{cases}
\]
Both branches remain positive and at most One. At the junction \(F(1/2)=1\), and \(F(1)=1\). Every subtraction in the second branch removes a completed whole from a strictly larger paired part, leaving a positive remainder.

A first-return trace from \(x\) is a finite list of states after transitions, ending in \(x\), whose earlier entries differ from \(x\). In symbols, if the list is \((x_1,\ldots,x_k)\), then
\[
 x_1=F(x),\quad x_{i+1}=F(x_i),\quad x_k=x,
 \quad x_i\ne x\ \text{for }1\le i<k.
\]
The source retains every transition. Its return count is the trace length. One has identity period one; the binary and ternary witnesses below are nonidentity returns.

## 3. Complete word support constructs the witness parts

Let the fibre labels be \(a\) and \(b\). The initial word support contains the one empty word. A successor attaches each label to each earlier word:
\[
 W_0=\{\epsilon\},\qquad
 W_{d+1}=\{wa:w\in W_d\}\cup\{wb:w\in W_d\}.
\]
The last label distinguishes the two branches, and within either branch deletion of the last label recovers the earlier word. Thus no word is repeated and every word of the new length is retained. If \(s_d=|W_d|\),
\[
 s_0=1,\qquad s_{d+1}=s_d+s_d,
 \qquad s_d=2^d.
\]
The host base index denotes the empty extension history; the public scientific operation accepts positive depths. At every positive depth, \(s_d>1\), so there is a unique positive predecessor \(p_d\) satisfying
\[
 p_d+1=s_d.
\]
Existence follows by positive succession through the complete finite count. If \(q+1=s_d=p_d+1\), successor injectivity gives \(q=p_d\). The source unit part is therefore
\[
 u_d=\frac1{p_d}=\frac1{2^d-1}.
\]
At depths two and three this construction gives
\[
 s_2=4,\quad p_2=3,\quad u_2=1/3;
 \qquad s_3=8,\quad p_3=7,\quad u_3=1/7.
\]
The denominators arise from complete support and its unique predecessor. `GeneratorThreeDerivation.completeSupportCount`, `predecessorPositive`, `predecessorSuccessor` and `predecessorUnique` prove these facts for arbitrary finite depth; `depthTwoUnit` and `depthThreeUnit` specialize them.

## 4. Exact first returns and least distinct successor

### 4.1. The binary witness

Since \(1/3<1/2\), Fold doubles it to \(2/3\). Since \(2/3>1/2\), the next Fold gives
\[
 F(2/3)=4/3-1=1/3.
\]
The only earlier state is \(2/3\), distinct from \(1/3\). The complete trace after transitions is \((2/3,1/3)\), with first-return length two.

### 4.2. The ternary witness

The first two states lie below half-One, and the third lies above it:
\[
 F(1/7)=2/7,\qquad F(2/7)=4/7,
 \qquad F(4/7)=8/7-1=1/7.
\]
The earlier numerators two and four differ from the starting numerator one, with common positive denominator seven. Neither is an earlier return. Thus the trace after transitions is \((2/7,4/7,1/7)\), of first-return length three. The native `binaryFirstReturn` and `ternaryFirstReturn` prove both the transition relations and the absence of premature return.

### 4.3. Uniqueness over every positive count

Let \(k\) be any positive whole count strictly greater than the binary length two. Whole-count succession implies \(k\ge3\). The exhibited trace realizes three. Hence three is attained and no smaller distinct successor is possible. If \(k\) is itself least among counts greater than two, comparison with the exhibited three gives \(k\le3\); combining the inequalities gives \(k=3\). For every \(k>3\), three is an explicit earlier admissible witness, so \(k\) is nonminimal.

This proves
\[
 \forall k\in\mathbb N_{>0},\quad 2<k\Rightarrow3\le k,
 \qquad
 k>3\Rightarrow\exists j\,(2<j<k),\quad j=3.
\]
The native `leastDistinctSuccessor`, `uniqueLeastSuccessor` and `laterCountNonminimal` quantify over arbitrary counts. `generatorThree` combines support-generated unit parts, both complete traces and the universal minimality result. The proof requires no denominator-search cutoff.

## 5. The original first-return program and its general closure

The original `first_return_trace` begins with the source in its visited set. Each step applies Fold, appends the resulting state, tests return to the source, then tests an already visited state. A source return succeeds; a repeated different state reports entry into another recurrence; a fresh state advances with the enlarged visited record. This order is essential: a return must not be rejected merely because the source was visited initially.

Native `FoldFirstReturn.Run` has exactly these three constructors: returned, repeated and advanced. The implementation uses a finite rational carrier derived from the starting denominator. If a reduced part has denominator \(d\), doubling and a positive cast-out can only preserve or reduce that denominator. A carrier containing all reduced positive parts through One with denominator at most the original \(D\) is therefore invariant. It is finite because each denominator lies in \(1,\ldots,D\) and each positive numerator is at most that denominator.

Retain the carrier as remaining or already seen. Every fresh transition removes its exact key from remaining and adds it to seen. Key equality preserves exact reduced-part identity. Removal strictly reduces remaining length. If no fresh state remains, a next state must already be seen; the supposedly fresh branch is impossible. This establishes termination without imposing an arbitrary orbit bound.

Induction on the three `Run` constructors proves that every successful returned list follows the original transitions and ends at the source with no earlier return. `originalLoop` connects the executable operation to this relation for every admitted part. `nativeFirstReturn` then proves the first-return property of every successful execution. The source-generated binary and ternary calls return the exact lists in Section 4; `generatorPeriodThree` evaluates the complete generator operation to three.

For example, half-One advances to One and then remains there. The source half-One never returns, so the repeated-state branch rejects it. The input guards likewise retain the original exact positive part domain and reject nonparts, nonpositive values and values above One. These operational distinctions are preserved in the original source-output evidence rather than replaced by a period label.

## 6. Spatial stability from the complete pair-cell carrier

### 6.1. Two fibre roles and four ordered cells

Let \(L=\{a,b\}\) be the two distinct fibre roles. Their ordered support is
\[
 L\times L=\{(a,a),(a,b),(b,a),(b,b)\}.
\]
The coordinates retain their roles, so \((a,b)\) and \((b,a)\) are distinct cells. Complete product counting gives four cells.

The source spatial carrier retains independent generated incidence directions and their return. To keep the return distinct from the two fibre roles, its count \(n\) must strictly exceed two. To retain a proper positive restoring remainder before the one-Fold pair support saturates, it must remain strictly below four. The two original construction conditions are therefore
\[
 2<n,\qquad n<4.
\]
At two the return is identified with a fibre role. At four all pair-cell roles are saturated and no positive restoring remainder remains. These are the source's lower and upper boundary arguments, expressed before selecting a spatial count.

### 6.2. Complete census and independent agreement

For a general positive fibre count \(b>1\), the source enumerates every positive whole count through \(b^2\) and retains precisely those satisfying \(b<n<b^2\). Native `positiveCounts` begins empty and appends the next positive whole at each successor. Induction proves
\[
 n\in\operatorname{positiveCounts}(B)
 \quad\Longleftrightarrow\quad0<n\le B.
\]
Its length is \(B\), and its values are distinct: the newly appended \(B+1\) exceeds every earlier member. Filtering therefore yields the exact equivalence
\[
 n\in\operatorname{stableCounts}(b)
 \quad\Longleftrightarrow\quad b<n<b^2.
\]
Every admissible count is included; every included count satisfies both strict inequalities. The equivalence also excludes all counts outside the finite enumeration because no count above \(b^2\) can satisfy the upper condition.

For the actual two fibres, integer order gives \(3\le n\) from \(2<n\) and \(n\le3\) from \(n<4\). Hence \(n=3\), which satisfies both conditions. Thus
\[
 \operatorname{stableCounts}(2)=[3].
\]
The separately computed recurrence result is also three. The original `spatial_dimension_three` checks that the full stable list equals the singleton recurrence result before returning it. `SpatialStability.completeWindow`, `onlySpatialCount`, `independentCrosslock` and `completeSpatialDerivation` prove the census, uniqueness and agreement. No observed dimension is used to choose the list member.

## 7. Holding one normal retains exactly rank two

Take any independent three-direction carrier and any one held source-normal direction \(\nu\). Represent the complete carrier in its original order as
\[
 S=L\mathbin{++}[\nu]\mathbin{++}R,
 \qquad |S|=3,
\]
where all entries are distinct and \(\nu\) does not occur in \(L\mathbin{++}R\). Retain the entire nonnormal boundary list
\[
 B=L\mathbin{++}R.
\]
For every direction \(d\),
\[
 d\in B\quad\Longleftrightarrow\quad d\in S\ \text{and}\ d\ne\nu.
\]
In the forward direction, membership in either retained list gives spatial membership, while separation excludes the normal. In the reverse direction, spatial membership lies in the left list, the held singleton or the right list; the singleton contradicts \(d\ne\nu\), leaving exactly the two retained branches. Thus every nonnormal direction remains and none is added.

List concatenation gives the positive reassembly equation
\[
 |B|+1=|S|=3.
\]
Since \(2+1=3\), successor injectivity gives \(|B|=2\). Any other rank satisfying the same reassembly equation equals two. The normal may occupy any position: the proof quantifies over both surrounding lists and the held identity. `BoundarySupport.allNonnormalRetained`, `normalReassembles`, `retainedRankTwo` and `uniqueRank` establish these claims. The executable `boundaryRank` computes the positive predecessor of the independently derived spatial count and verifies reassembly; `boundaryRankTwo` gives its exact result.

## 8. Complete pair support and arbitrary-scale growth

Let \(X\) and \(Y\) be the distinct scale-cell lists on the two retained boundary directions. The generated support contains each ordered pair from \(X\times Y\). Pair membership satisfies
\[
 (x,y)\in\operatorname{pairCells}(X,Y)
 \quad\Longleftrightarrow\quad x\in X\ \text{and}\ y\in Y.
\]
Induction on \(X\) gives
\[
 |\operatorname{pairCells}(X,Y)|=|X|\,|Y|.
\]
For the successor, a new first-coordinate cell contributes one pair with every member of \(Y\), adding exactly \(|Y|\). Its first coordinate distinguishes all new pairs from old ones. Within the new row, distinct second coordinates distinguish its pairs. Induction proves the whole list has no duplicates when both coordinate lists have none. The same reasoning applies to a new second-coordinate cell, retaining every old pair.

At equal positive whole scale \(|X|=|Y|=r\), the count is \(r^2\). Enlarging both coordinates from \(r\) to \(r+1\) adds a new row of \(r\) cells, a new column of \(r\) cells and their one intersection:
\[
 (r+1)^2=r^2+r+r+1.
\]
The base \(r=1\) has one pair. This successor retains the complete earlier support and establishes arbitrary positive-scale closure. `BoundaryPairs.completeEquivalentSupport` packages distinctness, count and the bidirectional membership statement.

The original exact-ratio operation extends the scale calculation by repeated positive multiplication. For a positive exact ratio \(q>1\), it uses the derived boundary rank two:
\[
 G(q)=\underbrace{q\cdot q}_{\text{two retained coordinates}}=q^2.
\]
If \(q=u/v\), the result is the reduced positive fraction equal to \(u^2/v^2\). Normalization preserves its value by cross-multiplication. `BoundaryGrowth.nativeProductSteps` proves the original multiplication-step relation, and `productComposition` proves that consecutive finite multiplication runs compose. `growthAdmitted` proves the square for every admitted exact ratio above One; `exactGrowthValue` proves its exact rational value. Examples are
\[
 G(3/2)=9/4,\quad G(2)=4,\quad G(3)=9,\quad G(7/3)=49/9.
\]
The rank was derived before these evaluations. No measured scaling exponent or external surface-area formula selects it.

## 9. Complete construction grammars

The original generator grammar has ten two-choice axes. The spatial grammar has eight two-choice axes and one four-choice value axis. The boundary grammar has nine two-choice axes and one four-choice rank axis. Their complete sizes are
\[
 2^{10}=1024,\qquad2^8\cdot4=1024,
 \qquad2^9\cdot4=2048.
\]
The following tables give every preserving choice and every original alternative. Each candidate is a tuple containing one choice from every row of its table.

### 9.1. Recurrence generator

| Axis | Preserving construction | Alternatives rejected |
|---|---|---|
| carrier | exact positive period trace | borrowed integer name |
| action | double and cast complete One | imported modular map |
| recurrence | complete first return orbit | repeated value without first return |
| binary | depth two unit part period | asserted binary count |
| successor | least distinct positive successor | selected later period |
| unit | support predecessor unit part | target denominator |
| orbit | all Fold transitions held | period label only |
| order | positive count discreteness plus existence | bounded denominator search |
| measurement | derivation before measurement | measurement selected period |
| extension | no extra rule | extra generator rule |

### 9.2. Spatial carrier

| Axis | Preserving construction | Alternatives rejected |
|---|---|---|
| carrier | independent generated direction carrier | coordinate name only |
| lower | strictly beyond two Fold fibres | one or collapsed fibre count |
| upper | strictly within four pair cells | unbounded coordinate extension |
| interval | open Fold stability window | closed or one sided window |
| census | complete positive count enumeration | selected dimension |
| value | three directions | two directions; four directions; target selected directions |
| crosslock | equals generator three | no independent lock |
| measurement | forced count then observed | space count read from measurement |
| extension | no extra rule | extra dimensional model |

### 9.3. Boundary incidence

| Axis | Preserving construction | Alternatives rejected |
|---|---|---|
| carrier | forced three direction carrier | unbound coordinate space |
| normal | one held source normal | no held source normal |
| incidence | all nonnormal directions retained | selected tangent subset |
| rank | unique positive predecessor | signed dimension minus one |
| value | rank two | rank one; rank three; target selected rank |
| scale | complete pair cell product | linear or unlabelled repetition |
| coverage | complete equivalent boundary support | partial boundary sample |
| generality | pair product successor closure | fixed scale table |
| measurement | rank sealed before measurement | measured rank input |
| extension | no extra rule | extra boundary rule |

### 9.4. Exhaustion, classification and closure

Take any candidate in a declared product carrier. Each coordinate belongs to its listed two- or four-constructor domain. Successively inserting these memberships into the Cartesian enumeration proves that the complete tuple occurs. Different coordinate choices remain distinguishable. Every original form is therefore represented, without a selected neighbourhood or omitted combination.

The preserving criteria are the operations and arguments established in Sections 2–8: complete support, actual first return, least positive successor, both strict spatial boundaries, agreement of the independent routes, complete nonnormal incidence and complete pair support. The source decision equals their conjunction on every candidate. If a candidate is accepted, each coordinate must be preserving, so the tuple is the unique preserving tuple. Conversely that tuple satisfies every criterion. Thus for each of the three grammars,
\[
 \forall c,\qquad\operatorname{survives}(c)=\mathrm{true}
 \quad\Longleftrightarrow\quad c=c_*.
\]
Every rejected alternative violates its corresponding retention, domain, order or provenance requirement. A period label without the orbit loses first-return evidence; a later period loses leastness; a closed spatial endpoint loses distinct return or restoring remainder; a selected tangent subset loses complete incidence; a fixed-scale table loses successor closure. Target-selected values reverse the original construction-to-comparison order. The exact constructor-specific reasons are preserved with the source and arithmetic record.

`GeneratorThreeGrammar`, `SpatialThreeGrammar` and `BoundaryRankGrammar` contain the full enumerations and universal classification proofs. Their `candidatesComplete`, `generatedCardinality`, `sourceDecisionMatchesCriteria` and `uniqueSurvivor` results retain the complete original grammars. The general mathematical theorems above establish the content of the preserving constructions. Original controls retain false-premise, changed-source, changed-artifact and boundary cases, with all program fields and decisions compared against pinned V3.

## 10. Native proofs, source correspondence and reproduction

The original definitions, derivation documents and executions are pinned to V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The corresponding public native Lean source is V4 edition 0.4, commit `21cdf559922fb057f8560f42d056ffa035329eb3` [3]. The principal source operation is `sft/physics/structural_constants.py`.

| Construction | Native proof families | Completion receipt |
|---|---|---|
| Complete support, first return and least period | `GeneratorThreeDerivation`, `FoldReturnCarrier`, `FoldFirstReturn`, `GeneratorOperations` | TURN_267 |
| Complete positive-count window and independent agreement | `SpatialStability`, `SpatialThreeGrammar` | TURN_268 |
| All-position held normal, exact retained boundary and scale product | `BoundarySupport`, `BoundaryPairs`, `BoundaryGrowth` | TURN_269 |

The retained native audit logs report empty axiom dependencies for the exported results. The associated successful builds and full program comparisons retain all 1,024, 1,024 and 2,048 candidate identifier lookups, exact forms, ordering, reasons, trace/proof hashes, registration fields, closure records, controls and unknown-identifier refusal. The completion receipts map the mathematical constructions, source operations and program checks separately. Cumulative audit totals include earlier modules and are not counts of new results in this paper.

The accompanying `SOURCE_CORRESPONDENCE.json` identifies every source, module and retained evidence file. `SOURCE_AND_EVIDENCE.zip` contains the original pinned derivation records, native modules with imports, complete audits and program comparisons. The reproduction script executes the unchanged original pure functions, reconstructs both traces, all three ranks and the four exact growth examples, exhausts all three constructor products, and checks ten original domain/nonreturn errors. The scientific definitions and proof inputs are unchanged for this exposition.

## References

1. Smith, Maria. **Smithian Fold Theory V3 physics.** https://doi.org/10.5281/zenodo.21761655.
2. Smith, Maria. **SFT V3 monograph.** https://doi.org/10.5281/zenodo.21900790. Pinned implementation and complete derivation documents accompany this paper.
3. Smith, Maria. **Native Lean V4, edition 0.4.** https://doi.org/10.5281/zenodo.24320778. Native proof source: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics.
4. Smith, Maria. **Operational foundation.** https://doi.org/10.5281/zenodo.21627656.
5. Smith, Maria. **The fine-structure constant from first principles: an exact zero-parameter Fold derivation.** https://doi.org/10.5281/zenodo.24324400. Downstream application of the generator, direction and boundary counts.
6. Smith, Maria. **Nuclear shell closure, g-block filling and the predicted periodic endpoint.** https://doi.org/10.5281/zenodo.24325152. Downstream application of complete direction and boundary support.



## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

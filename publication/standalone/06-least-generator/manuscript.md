# From operational occurrence to the unique least Fold generator

**Maria Smith · Ernos Labs**  
Standalone paper 6 · Version 1.0 · 17 November 2026  
DOI: 10.5281/zenodo.24327008

## Abstract

Fold is the unique least generator among all finite words in the normalized parameter-free primitive grammar. Its map on exact positive parts is \(F(x)=2x\) for \(0<x\leq1/2\) and \(F(x)=2x-1\) for \(1/2<x\leq1\). It is noninjective, has exactly two preimages for every image, and has the nonstatic recurrent orbit \(1/3\mapsto2/3\mapsto1/3\). Identity and square are injective; constant One has no nonstatic recurrence. Fold therefore qualifies at primitive size one, and every longer composition is nonminimal by positive construction count. The theorem quantifies over every finite word, beyond the complete 84-word executed prefix. We derive the supporting construction from the operational occurrence partition through structural One, exact finite retention, positive part coordinates, common-refinement pairing, the unique first nonidentity extension, complete Fold-word assembly, half-One and exact cast dynamics. Each grammar, carrier, base, successor, completeness argument and uniqueness statement is made explicit. Eleven source entries supply 2,182 candidate records and 44 original controls; their retained native evidence includes 1,311 exported declarations with empty axiom dependencies. The paper presents the mathematical chain and its pinned V3-to-Lean correspondence without scientific fitting parameters.

**Keywords:** least generator; Fold dynamics; operational occurrence; structural One; exact finite count; common refinement; parameter-free grammar; constructive uniqueness; Smithian Fold Theory; Lean 4.

## 1. The principal result

Let \(D=\mathbb Q\cap(0,1]\) be the exact positive-part carrier obtained below. The normalized primitive grammar is

\[\mathcal P=(I,Q,C,F),\]

where \(I(x)=x\), \(Q(x)=x^2\), \(C(x)=1\), and \(F\) is self-junction followed by complete-One cast. A word \(w=(p_1,\ldots,p_n)\) applies its primitives in the listed order:

\[A_{()}(x)=x,\qquad A_{(p_1,\ldots,p_n)}(x)=p_n(\cdots p_2(p_1(x))\cdots).\]

A word generates when its resulting self-map is noninjective and has a nonstatic recurrent point:

\[\operatorname{Gen}(w)\iff\bigl(\exists x\ne y:\ A_w(x)=A_w(y)\bigr)\ \land\]
\[\bigl(\exists x\in D,\ k\geq1:\ A_w^k(x)=x\ \land\ A_w(x)\ne x\bigr).\]

A least generator is a nonempty generating word whose length is no larger than the length of any other nonempty generating word.

**Theorem.** For every finite word \(w\in\mathcal P^*\),

\[\operatorname{LeastGenerator}(w)\quad\Longleftrightarrow\quad w=(F).\]

The source-defined grammar consists of normalized total parameter-free primitive self-maps, with primitive cost through two source occurrences, followed by arbitrary finite ordered composition. Section 9 derives the four normal forms; section 10 proves their behavior; section 11 proves the all-word theorem. This states the complete quantified result, including the grammar that determines its meaning.

The construction preceding that theorem is also exact: every operational presentation record has one of two classes; complete addition-free retention gives structural One; every finite Count trace has a unique complete generated retention; the first nonidentity Count extension is uniquely minimal; and every finite Fold depth has all and only its recursively generated held-label words. The following sections develop these results in dependency order from the original V3 operations [1,2] and their native proofs [3]. Native declaration names below use the common prefix `SFT.Foundation`.

## 2. Operational occurrence and structural One

### 2.1. Every presentation record

The source record schema is

\[R=\mathrm{String}\times\mathrm{Bool}\times\mathrm{String}.\]

Its fields retain candidate identity, whether a challenge is presented, and descriptive form. The two finite strings can be arbitrary. Write \(P(r)\) for the presentation flag. Classification has exactly two cases,

\[\kappa(r)=\begin{cases}U,&P(r)=\mathrm{false},\\O,&P(r)=\mathrm{true},\end{cases}\qquad A(r)=P(r).\]

Here \(U\) is unpresented absence and \(O\) is presented occurrence. A statement, denial, record, trace or identity that is presented supplies an occurrence. With no presentation there is no challenge artifact to admit. Boolean elimination exhausts the source records. Consequently,

\[A(r)=\mathrm{true}\iff\kappa(r)=O,\]
\[\kappa(r)=\kappa(s)\iff P(r)=P(s).\]

For the forward implication of the second statement, apply the presentation projection to equal classes. For the reverse implication, equal flags select the same classifier branch. The generated representatives satisfy \(\kappa(\operatorname{record}(c))=c\). Every arbitrary record therefore belongs to the generated partition independently of its metadata, notation or content.

The full candidate list is \([U,O]\). Filtering by acceptance gives \([O]\), proving existence and uniqueness. Deleting \(O\) leaves no survivor. Changing acceptance to retain both classes gives \([U,O]\); since the constructors differ, that modified list has two distinct survivors. Deleting a record’s presentation flag rejects it; changing either metadata string preserves its decision and reason.

These are the source’s operational occurrence argument and its complete controls. Native `Root.Derivation.classificationExact`, `decisionAgreesWithClassification`, `everyAcceptedRecordHasSurvivorClass`, `acceptanceIffWitnessedOccurrence` and metadata-independence proofs quantify over all records in \(R\).

### 2.2. Complete retention forces structural One

Relative to the admitted occurrence, a representation retains none, a proper portion, or the complete occurrence. Independently, it adds no extra material or it does. The full relation product is

\[\{\mathrm{none},\mathrm{proper},\mathrm{complete}\}\times\{\mathrm{no\ extra},\mathrm{extra}\},\]

containing six forms. No coverage loses the occurrence. Proper coverage introduces a cut and loses complete identity. Extra material has no source in the sole admitted dependency. Exactly one form preserves the complete occurrence without addition:

\[\mathrm{complete}\ \land\ \mathrm{no\ extra}.\]

This exact self-whole is structural One. It is the retained identity of the occurrence; numerical coordinates enter after the finite-generation construction. For every source relation record, the decision is equivalent to this conjunction and to membership in the unique survivor class. `One.Derivation.generatedProductPreserved`, `recordClassificationExhaustive` and `acceptedIffCompleteWithoutAddition` prove the product construction and exact iff statement. Omission, fragmentation and unforced addition each have a direct rejection theorem.

## 3. Positive finite count from complete generation

### 3.1. The base and successor

A generated trace has constructors

\[t::=\mathrm{base}\mid\mathrm{extend}(t).\]

The base has one structural-One position. An extension embeds every old position as a prior position and appends one fresh terminal. Write \(L(t)\) for the complete ordered retention:

\[L(\mathrm{base})=[\mathrm{base}],\]
\[L(\mathrm{extend}(t))=\operatorname{map}(\mathrm{prior},L(t))\mathbin{+\!+}[\mathrm{terminal}].\]

Every generated position is retained. At the base this is immediate. At a successor, a position is either prior, where the induction hypothesis applies, or terminal, which is explicitly appended. The prior embedding is injective, and no prior constructor equals the terminal constructor. Mapping a duplicate-free list through that embedding preserves distinctness, and appending the fresh terminal preserves it again. Thus every finite trace has

\[L(t)\ne[],\qquad\forall p\in\operatorname{Position}(t),\ p\in L(t),\qquad L(t)\text{ duplicate-free}.\]

The previous complete trace is proper coverage of the extension because the new terminal is absent from it. Repeating any generated position violates exact multiplicity; removing one violates completeness.

The ordered record is unique under the generation rules. Any valid base record is the singleton base. Any valid successor record is the prior valid record followed by its fresh terminal. Induction therefore forces every generated record to equal \(L(t)\). This is uniqueness of the actual ordered construction, in addition to complete membership and distinctness.

`Count.TraceDerivation.finiteGenerationPreservesExactRetention`, `previousCoverageIsProper` and `uniqueCompleteGeneratedTrace` prove these statements for every trace. Positive finite count is this complete generated succession identity. Every proof concerns a finite constructed trace; the successor rule can be applied at every further finite stage.

### 3.2. Exhaustive retention grammar

Coverage is none, proper or complete. For nonempty retained coverage, multiplicity is once or duplicated; for no coverage it is not applicable. Each case independently has no extra or extra material. Therefore the source generates

\[1\cdot1\cdot2+2\cdot2\cdot2=10\]

forms. The unique preserving form is complete coverage, once, no extra. The base and successor proof supplies its actual retention semantics. The representation-level proofs reject an omitted position, duplicated retention, an ungenerated addition and a predecessor prefix used as the complete successor record. This connects the ten-class decision to arbitrary finite trace proposals.

## 4. Exact part coordinates and common refinement

### 4.1. A selected part of a complete whole

A whole is partitioned into equal disjoint fibres. Let its complete generated position list be \(L(t)\), and let a Boolean held predicate choose a nonempty selection \(H(t)\). Filtering retains only source positions and introduces no duplicates. Induction on the list gives

\[|H(t)|\leq|L(t)|.\]

A held witness \(p\) is in \(L(t)\) by complete generation and remains in the filter, so \(H(t)\) is nonempty. The exact coordinate retains both ordered records,

\[\operatorname{coord}(t,H)=(H(t),L(t)).\]

Its two projections recover the held and whole records. Any pair with those same projections equals this coordinate. With \(h=|H(t)|\) and \(n=|L(t)|\), the count relation is \(0<h\leq n\).

The source grammar tests complete coverage, disjointness, equal fibres, a contained nonempty selection, presence of both counts and absence of extra data. Its six binary coordinates and one three-way selection coordinate generate \(2^6\cdot3=192\) forms. Each failed criterion has a concrete loss: an incomplete or overlapping whole loses exact partition identity; unequal fibres make counts insufficient; empty or external selection loses the admitted part; a missing count loses either selection or reference; extra scale adds unforced data. Exactly the complete seven-criterion conjunction survives.

`Part.SelectionDerivation.witnessedCoordinatePositiveAndContained` proves positivity and containment for every trace and every held predicate with a selected witness. `heldWholePairUnique` proves coordinate uniqueness. Cross-partition equality is supplied by the next construction.

### 4.2. Pair-cell generation and exact equivalence

Given complete partition lists \(A,B\), generate one cell for every ordered pair of source positions. The source emits the formatted label \((a,b)\) in nested source order. Selection from \(A\) lifts to all cells descending from its held positions; selection from \(B\) lifts to all cells descending from its held positions:

\[\widehat H_A=H_A\times B,\qquad\widehat H_B=A\times H_B.\]

Every lifted cell belongs to the complete refinement when its source selection is contained. Every selected origin retains every required descendant. The source comparator pairs generated indices and accepts precisely when the two lifted trace lengths are equal. The pairing concerns generated positions, retaining the complete source strings in the output labels.

If \(|A|=n\), \(|B|=m\), \(|H_A|=h\) and \(|H_B|=k\), the nested enumeration gives \(hm\) and \(nk\) lifted positions. A complete one-to-one and onto index pairing therefore gives

\[hm=nk.\]

This count equation is the rational-coordinate equality \(h/n=k/m\). It follows from the generated pair lists and their pairing; it is not a replacement for those retained records.

An exact pairing has maps \(f,g\) with \(g(f(a))=a\) and \(f(g(b))=b\). The first identity proves injectivity: apply \(g\) to \(f(a)=f(a')\). The second proves surjectivity with witness \(g(b)\). Identity maps establish reflexivity. Exchanging \(f,g\) establishes symmetry. For pairings \((f,g)\) and \((u,v)\), use \((u\circ f,g\circ v)\); substitution into the two inverse equations proves transitivity. Uniform refinement by a descendant carrier \(T\) uses

\[f_T(a,t)=(f(a),t),\qquad g_T(b,t)=(g(b),t),\]

and the same inverse equalities prove preservation of equivalence.

`CommonRefinement.generatedBijectionIffEqualLength`, `identityPairing`, `reversePairing`, `chainPairings` and `uniformRefinement` implement these arguments. `RefinementSelection.liftedPairingOneToOne` and `liftedPairingOnto` apply them to the exact lifted source lists. The complete equivalence grammar has eight binary coordinates and a four-way pairing coordinate, hence \(2^8\cdot4=1024\) candidates. It retains both refinements, both complete lifts and both directions of pairing, with no added scale.

## 5. Why the first Fold has exactly two held fibres

### 5.1. Unique minimal nonidentity extension

Order Count traces by generated prefix. The base is identity. The first extension is \(t_1=\mathrm{extend}(\mathrm{base})\). Every nonidentity trace contains \(t_1\) as a prefix: this follows immediately at the first extension and is preserved on appending another terminal.

A minimal nonidentity trace is nonidentity and has no proper nonidentity prefix. The only prefixes of \(t_1\) are the base and \(t_1\) itself, so \(t_1\) is minimal. Conversely any minimal nonidentity trace contains \(t_1\); minimality forces equality. Thus

\[\operatorname{MinimalNonidentity}(t)\iff t=t_1.\]

The first extension contains exactly the retained prior base and the fresh terminal. They are distinct, exhaust its position type and occur exactly once. This supplies two positions from the Count construction. `FoldDerivation.firstIsMinimal`, `minimalNonidentityUnique`, `firstPositionDomainExhausted` and `firstPositionsRetainedOnce` prove the complete argument.

### 5.2. Equality, distinction and return

The unqualified structural One supplies no allocation selector privileging one fibre. The source therefore retains equal fibre status; an unequal allocation introduces additional data. Complete disjointness preserves the whole without omission or repeated structure. The two fibres carry distinct held labels so the generated distinction remains operationally identifiable. A complete return relation identifies their joint assembly with the predecessor whole.

The full Fold relation product has five binary coordinates, a three-way extension coordinate and a three-way label coordinate:

\[2^5\cdot3\cdot3=288.\]

The unique survivor is complete, disjoint, equal, first-extension, distinct-held-labels, return-present and no-extra. Identity has no nontrivial distinction; a later extension already contains the first; absent or equal labels lose the distinction; absent return loses assembly identity. `FoldStage.stageAcceptanceIff` links the source decision to arbitrary finite Count stages and the remaining exact relation criteria.

## 6. Complete finite Fold-word assembly

Let the two held labels be \(a,b\). The complete support before a Fold is the singleton list containing the empty word. At a successor append each label once to every prior word, preserving nested source order:

\[W_0=[()],\qquad W_{d+1}=[wa,wb:w\in W_d].\]

The empty word is the structural base form. Every successor word records one additional held label. A generated word therefore has length \(d\) and uses only \(a,b\). Conversely, induction on any word using these labels builds its generation trace, so

\[w\in W_d\iff |w|=d\ \land\ \text{every label of }w\text{ belongs to }\{a,b\}.\]

Distinct prior words or distinct appended labels give distinct successors: equality of appended words recovers the last label and prior word. Induction gives duplicate-free support at every depth. Each successor has its unique predecessor obtained by removing the final label, and its branch pair returns to that predecessor. The complete assembly records retain all transitions and returns, not merely the terminal support.

Cardinalities satisfy \(|W_0|=1\) and \(|W_{d+1}|=2|W_d|\), hence \(|W_d|=2^d\). Omitting a generated word breaks completeness; repeating one breaks uniqueness; a wrong-length or external-label word fails support membership. Missing or incorrect transitions and returns fail the corresponding record conditions.

`FoldAssembly.exactFiniteSupport`, `supportIffLengthAndHeldLabels`, `allFiniteSupportsUnique` and `returnPredecessorUnique` prove these statements. `FoldAssemblyTrace` and `AssemblyRecords` retain the complete construction records. Their three-way coverage coordinate and six binary coordinates generate all 192 assembly forms, with one complete survivor.

## 7. Positive exact operations and the forced half-One

### 7.1. Complete-One cast

Exact positive part values are normalized rational coordinates \(x=n/d\) with positive counts \(n\leq d\). For a positive rational magnitude \(z\), complete-One cast repeatedly removes one complete One while the remainder exceeds One. It retains the final value in \((0,1]\); a complete positive integral turn casts to One.

If \(z=n/d\) with positive integers \(n,d\), each removal replaces \(n\) by \(n-d\) only when \(n>d\). The positive count strictly decreases until \(1\leq n\leq d\). This proves termination and positivity. If \(n=qd+r\) with \(1\leq r\leq d\), the result is \(r/d\). This convention retains the positive endpoint for exact full turns.

Write \(K\) for cast. Self-junction followed by cast gives

\[F(x)=K(x+x)=\begin{cases}2x,&0<x\leq\frac12,\\2x-1,&\frac12<x\leq1.\end{cases}\]

Take is accepted precisely when its first exact part is strictly larger than its second, returning their positive difference. Unison compares exact part values. The seven binary operation criteria generate 128 forms; the unique admitted interface preserves the positive carrier, full-turn One, junction-then-cast, strict Take, exact unison, generating trace and no extra rule.

### 7.2. First-Fold selection classes

The first Fold has exactly two equal held positions. Their four subsets are empty, either singleton, and both positions. Positive selection excludes the empty set. Exchanging the two held labels identifies the singleton coordinates, while the whole selection has value One. Thus there are exactly two nonempty selection-equivalence classes,

\[\frac12\quad\text{and}\quad1,\]

and the sole proper class is half-One. For any exact part \(x\), self-junction equals One precisely when \(2x=1\), forcing \(x=1/2\). In normalized numerator/denominator form, \(2n=d\) and coprimality force \(n=1,d=2\). Its complement is \(1-1/2=1/2\); its Fold image is One, and \(F(1)=K(2)=1\).

Complement and half-One phase translation are distinct operations. Complement is the positive remainder inside One where Take is admitted. Phase translation is \(T(x)=K(x+1/2)\). At half-One,

\[\operatorname{complement}(1/2)=1/2,\qquad T(1/2)=1.\]

`HalfOneDerivation.selectionForms`, `nonemptySelectionClasses`, `properSelectionIsHalf`, `exchangePreservesCoordinate` and `selfJunctionOneIff` establish the complete class and uniqueness proofs. Its seven binary invariants give a complete 128-form grammar.

## 8. Exact two-preimage dynamics

### 8.1. Every image has exactly two preimages

For any \(y\in D\), the lower and upper preimages are

\[\ell(y)=\frac y2,\qquad u(y)=\frac{y+1}{2}.\]

They lie respectively in \((0,1/2]\) and \((1/2,1]\), so they are distinct. Direct substitution gives

\[F(\ell(y))=y,\qquad F(u(y))=2\frac{y+1}{2}-1=y.\]

Conversely, if \(F(x)=y\), then either \(2x\leq1\), giving \(x=y/2\), or \(2x>1\), giving \(x=(y+1)/2\). These two cases exhaust the domain. Therefore

\[F(x)=y\iff x=\ell(y)\ \lor\ x=u(y).\]

`FoldFibres.exactTwoPreimages` proves the general iff statement, including both generated solutions and exhaustion. The source upper operation is \(K(y/2+1/2)\), which equals the displayed upper value because it is already at most One.

### 8.2. Phase involution and uniform divisions

The half-One translation has the piecewise form

\[T(x)=\begin{cases}x+1/2,&x\leq1/2,\\x-1/2,&x>1/2.\end{cases}\]

The first case moves into the second half; applying the second branch returns \(x\). The second case moves into the first half; applying the first branch returns \(x\). Thus \(T(T(x))=x\). Doubling the half-turn shift adds or removes a complete One before cast, giving

\[F(T(x))=F(x).\]

These are general exact identities, proved by `FoldPhaseFull.fullPhaseInvolution` and `fullPhaseCollision` from the source cast-removal operations.

For every positive integer \(n\), the uniform division of \(2n\) has points \(i/(2n)\), \(1\leq i\leq2n\). For \(1\leq j\leq n\),

\[F\!\left(\frac j{2n}\right)=\frac jn,\qquad F\!\left(\frac{j+n}{2n}\right)=\frac jn.\]

Every source index is in exactly one of these two halves. Distinct images are precisely \(j/n\) for \(1\leq j\leq n\), in increasing order. Adjacent gaps are \((j+1)/n-j/n=1/n\), and the final point is One. The even uniform division therefore becomes the complete uniform division of \(n\) after duplicate images are identified. `FoldUniform.exactEvenImageSet`, the exact list correspondence, and `FoldUniformOrder` prove membership, order, distinctness and equal gaps for every positive \(n\).

### 8.3. The first nonstatic return

Exact substitution gives

\[F(1/3)=2/3,\qquad F(2/3)=1/3.\]

The two values differ, so this is nonstatic and returns after two applications. Positive return length one means a fixed point, hence cannot be nonstatic. The two-cycle has the least possible positive nonstatic return length. The seven binary dynamics criteria generate 128 forms, retaining domain closure, both preimages, phase collision, phase involution, uniform division, the first cycle and no extra dynamics.

## 9. Exhausting the normalized primitive grammar

The source primitive normalization uses exact product, self-junction, complete-One cast and ordered composition, with no supplied literal or scientific parameter. At normalized primitive cost through two source occurrences, the total self-map normal forms are:

| Source expression | Normal form |
|---|---|
| Retain the input; multiply by One | \(I(x)=x\) |
| Product of two input occurrences | \(Q(x)=x^2\) |
| Closed positive whole expression followed by cast | \(C(x)=1\) |
| Self-junction of the input followed by cast | \(F(x)=K(x+x)\) |

Multiplication by One is identity on either side. The self-product is square. A closed positive whole magnitude has only complete turns and therefore casts to One. Self-junction followed by cast is Fold by the source operation itself. Raw self-junction is not total on the part carrier because it takes One to two Ones. Guarded removal is not total because equal operands, including One with itself, fail its strict guard. These reductions and excluded interfaces account for the four declared primitive operational classes.

`PrimitiveMaps.productRightOne`, `productLeftOne`, `selfProductIsSquare`, `closedWholeCastsOne` and `selfJunctionCastIsFold` prove the reductions. `rawSelfJunctionNotTotal` and `guardedRemovalNotTotal` prove the failed totality conditions at their explicit source witnesses. The normalized grammar is then closed under arbitrary finite ordered words. `PrimitiveMaps.namedWordMatches` preserves the source’s named operations, and `wordAppend` proves

\[A_{uv}(x)=A_v(A_u(x)).\]

Appending one primitive increases construction length by exactly one.

## 10. Complete primitive behavior

### 10.1. Identity

Identity is injective because \(I(x)=I(y)\) is \(x=y\). Every point is fixed. It fails both required generating behaviors.

### 10.2. Square

For positive rational parts, \(x^2=y^2\) implies \(x=y\). In normalized coordinates \(x=a/b,y=c/d\), cross multiplication gives \((ad)^2=(cb)^2\). Natural squares are strictly increasing: if \(u<v\), then \(u^2<v^2\). Trichotomy therefore gives \(ad=cb\), and reduced rational identity gives \(x=y\).

For a proper part \(0<x<1\), multiplying \(x<1\) by positive \(x\) gives

\[0<x^2<x.\]

The result remains proper. Repeating the argument and using strict-order transitivity shows every positive square iterate lies below its starting proper value. It cannot return. One is fixed under every iterate. Thus a positive square iterate returns exactly when its starting part is One, and this return is static.

`PrimitiveMaps.squareInjective`, `squareStrictlyContracts`, `everyPositiveSquareIterateContracts` and `squarePositiveReturnIffOne` prove the full positive-domain statements, using normalized integer numerator/denominator equations.

### 10.3. Constant One

Every input maps to One, so the map collapses distinct values. Every positive iterate is One. If an iterate returns to its starting value, that value must be One, already fixed by the first application. There is no nonstatic return. `PrimitiveMaps.positiveConstantIterate` supplies this argument for every positive iterate.

### 10.4. Fold

Half-One and One are distinct but have the same Fold image One. Thus Fold is noninjective. The one-third/two-thirds cycle supplies nonstatic recurrence. Both witnesses are exact and were derived before selecting a generator:

\[1/2\ne1,\quad F(1/2)=F(1)=1,\]
\[F^2(1/3)=1/3,\quad F(1/3)=2/3\ne1/3.\]

Consequently,

\[\operatorname{Gen}((p))\iff p=F\qquad(p\in\mathcal P).\]

`PrimitiveMaps.foldGenerates` and `singletonGeneratorIffFold` prove the constructive classification over all four primitive constructors.

## 11. Uniqueness over every finite composition

Every nonempty finite word has positive length. Fold is a generating singleton, so its length one is no greater than the length of any nonempty generating word. It is therefore a least generator.

Conversely, let \(w\) be any least generator. Comparing it with the generating singleton \((F)\) gives \(|w|\leq1\). Nonemptiness gives \(1\leq|w|\). Thus \(w\) is a singleton \((p)\). The primitive classification forces \(p=F\). This proves both directions of

\[\forall w\in\mathcal P^*,\qquad\operatorname{LeastGenerator}(w)\iff w=(F).\]

Every word of length greater than one is nonminimal, regardless of its dynamical behavior. Appending a primitive changes length from \(n\) to \(n+1\); once a word is later than size one, every successor remains later. This is the positive-size closure argument for all finite word lengths.

`PrimitiveMaps.foldLeastGenerator`, `leastGeneratorUnique`, `leastGeneratorIff`, `everyLargerWordNonminimal` and `successorPreservesNonminimality` prove these statements with the full word carrier. The result does not depend on a maximum executed enumeration depth.

The complete executed prefix independently lists every word of sizes one, two and three. With primitive order \((I,Q,C,F)\), assign digits \((0,1,2,3)\). A size-\(n\) word has one-based rank

\[1+\sum_{j=1}^{n}d_j4^{n-j}.\]

All digit choices occur exactly once, giving \(4+16+64=84\) records. Fold is size one, rank four. At size one the other three records fail the behavior classification. At sizes two and three all words fail least-size selection. `PrimitiveMapGrammar` proves prefix completeness, exact source order, rank and acceptance correspondence to the actual least-generator predicate. The complete source prefix and the general all-word theorem therefore agree.

## 12. Complete grammars, controls and native evidence

| Source entry | Complete candidate count | Preserving content |
|---|---:|---|
| Operational root | 2 | Presented occurrence |
| Structural One | 6 | Complete self-whole without addition |
| Count | 10 | Complete finite retention, once, no extra |
| Part | 192 | Complete equal disjoint whole and positive contained selection |
| Common-refinement equivalence | 1,024 | Both complete lifts with two-sided pairing |
| First Fold | 288 | Unique first extension, equal distinct held fibres and return |
| Fold assembly | 192 | Every word, transition and return, uniquely retained |
| Exact operations | 128 | Positive carrier, cast, guarded Take and exact identity |
| Half-One | 128 | Unique proper first-Fold selection class |
| Fold dynamics | 128 | Exact fibres, phase, uniform divisions and first cycle |
| Primitive words through size three | 84 | The sole least-size generating primitive |
| Total | 2,182 | Eleven source entries |

Each classification retains all original candidate identifiers, forms, ordering and first-failure reasons. Their actual derivations are given above. The original four control categories accompany each entry: false premise, altered source identity, altered artifact and boundary preservation. All 44 source controls are retained. In the primitive entry, the controls reject identity as a generator, distinguish a changed source hash, retain exactly one survivor at rank four, and preserve both the two-preimage witness and the nonstatic two-cycle. Fold-dynamics controls retain two distinct preimages and phase identities for the original rational rows and six even uniform divisions. These finite controls accompany the general proofs.

The original source is pinned to V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1` [1,2]. Native definitions, proof bodies and retained evidence are pinned to V4 commit `21cdf559922fb057f8560f42d056ffa035329eb3` [3]. Principal files under `sft/foundation/` are `root_theorem.py`, `one.py`, `count.py`, `part.py`, `part_equivalence.py`, `fold.py`, `fold_assembly.py`, `exact_operations.py`, `half_one.py`, `fold_dynamics.py` and `primitive_map_uniqueness.py`.

The eleven completion receipts are TURN111 Root, TURN112 One/Count, TURN113 Part, TURN114 Fold, TURN115 Assembly, TURN116 PartEquivalence and TURN119 ExactOperations/HalfOne/FoldDynamics/PrimitiveMapUniqueness. Their source-specific records preserve native build and axiom-audit results, complete program outputs, controls, closure data and original dependencies. Across the selected entry modules, 1,311 exported definitions and theorems have retained empty-axiom audits. Declaration counts and completed source-entry counts are distinct quantities.

The accompanying archive includes the complete original records, native source and imported proof dependencies, source correspondence, retained receipts and raw audit/comparison logs. Its portable reproduction imports the unchanged pinned source with its original engine seal, reproduces all 2,182 candidate decisions and 44 controls, and retains exact assembly, common-refinement, half-One, uniform-division and cycle outputs. The full declaration-to-file mapping and source digests are supplied in `SOURCE_CORRESPONDENCE.json`.

## 13. Consequence

Operational presentation supplies the occurrence class; complete addition-free retention supplies its structural One. Finite generation supplies positive exact count, and complete selected/whole records with common-refinement pairing supply exact part identity. The first nonidentity extension uniquely supplies two equal held fibres and their return. Their proper selection class is half-One. Exact self-junction and complete-One cast give Fold, with two preimages at every image and an explicit nonstatic two-cycle. Exhausting the normalized primitive classes leaves Fold as the sole generating singleton, and positive construction length excludes every later word from least size. The resulting uniqueness theorem covers every finite ordered composition in the derived grammar.

## References

1. Smith, Maria. *SFT V3 operational foundation*. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656). [Pinned original source](https://github.com/MettaMazza/ernos-labs-sft-platform/tree/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1).
2. Smith, Maria. *SFT V3 monograph*. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Physics corpus: [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655).
3. Smith, Maria. *SFT native Lean 4 verification*, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Cumulative sections 6–12 and 21–22, with exact-operation and dynamics dependencies; [pinned native source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3).

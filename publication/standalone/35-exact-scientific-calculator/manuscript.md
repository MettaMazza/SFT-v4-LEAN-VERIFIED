# A verified exact scientific calculator across numerical and interface layers

Maria Smith · Ernos Labs

Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com) · SFT Discord: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

The SFT scientific calculator carries exact rational values and rational enclosure certificates from expression input to the browser display. Decimal input `0.1+0.2` produces exactly `3/10`; a root such as `sqrt(2)` produces ordered rational endpoints with a polynomial enclosure certificate; an attempted result below structural empty One halts and restores the admitted answer, memory and history. The same evaluator supplies the command, controller and browser interfaces. We derive the value representation, root bisection, finite-series bounds, circle-angle composition, parser precedence, projection rules and transactional admission. Exhaustive source grammars classify 1,024, 8,192, 1,024 and 256 alternatives for the corrected arithmetic, scientific session, complete controller and browser stages, respectively. Native Lean definitions and proofs cover these source operations and classifications; retained programme comparisons preserve every registered candidate decision, closure, control and canonical hash. The five translated source registrations, including the explicitly superseded first enclosure edition, retain 255 entry modules and 1,281 distinct empty-axiom audited definitions and theorems. Actual browser execution confirms equality of the server result and proof text with the rendered interface.

## 1. Exact computation reaches the visible result

The calculator's principal result is a single chain of admitted computation:

\[
\text{input}\longrightarrow\text{tokens}\longrightarrow\text{typed value and trace}
\longrightarrow\text{session admission}\longrightarrow\text{exact browser view}.
\]

The browser does not evaluate a second arithmetic expression. Its controls submit actions to the original controller; the response contains the result, proof text, error state, mode and history. `CalculatorBrowserNative.nativeValue` gives the display representation of the retained value, while `CalculatorBrowserTransaction.applyController` determines whether the proposed state is admitted. These operations correspond to `calculator_browser/native.py` and `calculator_browser/app.py` at the pinned V3 source [1]. The native definitions occur in the published V4 source [2,3].

Three executions exhibit the complete route. First, exact parsing gives

\[
0.1+0.2=\frac1{10}+\frac2{10}=\frac3{10}.
\]

Second, the actual browser root calculation returns

\[
\sqrt2\in\left[
\frac{854839645001009215068541}{604462909807314587353088},
\frac{427419822500504607534271}{302231454903657293676544}
\right].
\]

Squaring the lower endpoint gives a value at most two; squaring the upper gives a value at least two. Both endpoints are nonnegative, so monotonicity of squaring establishes the enclosure. Third, `1-2` yields `HALT`; the preceding admitted history is retained. The transport response can be successful while the mathematical action is rejected: the view's explicit error and `HALT` fields carry that rejection. This distinction is implemented in the source response constructor.

## 2. The value carrier and exact decimal input

The source scalar carrier has a structural empty constructor and two orientations of a strictly positive rational magnitude:

\[
S=\{\mathrm{EmptyOne}\}\;\sqcup\;
\bigl(\{\mathrm{forward},\mathrm{counter}\}\times\mathbb Q_{>0}\bigr).
\]

The magnitude is a numerator and positive denominator, reduced exactly. Empty One is the structural result of complete cancellation; the familiar glyph `0` is its display. Counter orientation is retained internally by the original arithmetic representation. The final browser admission rule examines complete values and prevents counter-held results from entering answer, memory or history.

There are three value forms: a scalar; an ordered pair of scalar endpoints with a nonempty certificate; and a pair of real and orthogonal scalar fibres. Writing the scalar's comparison value as \(\sigma\),

\[
\sigma(\mathrm{EmptyOne})=0,\qquad
\sigma(\mathrm{forward},q)=q,\qquad
\sigma(\mathrm{counter},q)=-q.
\]

These comparison coordinates express the exact source decisions. They do not replace the stored constructors. A certified interval satisfies \(\sigma(L)\leq\sigma(U)\); a fibre retains its two components separately. `CalculatorValues`, `CalculatorOperations` and the original `values.py` implement these constructions.

For a decimal token with digit integer \(N\), \(k\) fractional digits and exponent \(e\), the value is constructed as

\[
q=\frac{N10^{\max(e,0)}}{10^{k+\max(-e,0)}}.
\]

Unary orientation is parsed separately. Thus no floating approximation intervenes between the written decimal and its rational value. For rational magnitudes, common refinement gives

\[
\frac ab+\frac cd=\frac{ad+bc}{bd},\qquad
\frac ab\frac cd=\frac{ac}{bd},\qquad
\frac ab\div\frac cd=\frac{ad}{bc}\quad(c\ne0).
\]

Subtraction compares the refined numerators, retaining the residual orientation or Empty One when they agree. Interval addition uses \([a+c,b+d]\); subtraction uses \([a-d,b-c]\). Multiplication takes the minimum and maximum of the four endpoint products. Reciprocal reverses the reciprocal endpoints when the interval excludes the empty boundary. These are exact rational operations with explicit domain rejection.

## 3. Roots: exact recognition and polynomial enclosures

For a forward magnitude \(x=a/b>0\) and positive integer degree \(d\), the original integer root search tests numerator and denominator separately. If \(a=u^d\) and \(b=v^d\), it returns \(u/v\) exactly. Otherwise it starts from

\[
L_0=0,\qquad U_0=\max(1,x),\qquad L_0^d\leq x\leq U_0^d.
\]

The upper inequality follows from \(x\leq1\Rightarrow x\leq1^d\), and \(x\geq1\Rightarrow x\leq x^d\). At each counted step,

\[
M_n=\frac{L_n+U_n}{2},\qquad
(L_{n+1},U_{n+1})=
\begin{cases}
(M_n,U_n),&M_n^d<x,\\
(L_n,M_n),&M_n^d\geq x.
\end{cases}
\]

Monotonicity of the positive integer power preserves the enclosure in either branch. Induction gives

\[
L_n^d\leq x\leq U_n^d,\qquad U_n-L_n=\frac{\max(1,x)}{2^n}.
\]

The original certificate retains degree, target, depth and endpoint powers. The default depth is 80. A nonpositive supplied depth performs no bisections, exactly as the original counted loop specifies. Odd roots of counter orientation reverse the bounds. An exact even root of counter orientation has an orthogonal-fibre representation; the source rejects the nonexact even case for which that operation does not construct a paired enclosure. The browser subsequently applies its own counter-component admission rule.

The relevant native definitions are `CalculatorRoots.positiveRoot` and `CalculatorRoots.nthRoot`; the source operations are `_perfect_root` and `nth_root` in `calculator/operations.py`. The portable reproduction checks 100 combinations of target, degree and depth by rational endpoint powers.

## 4. Finite series with explicit remainder bounds

For positive \(x\), the exponential operation starts with \(t_0=S_0=1\) and forms

\[
t_k=t_{k-1}\frac{x}{k},\qquad S_k=S_{k-1}+t_k.
\]

After the next term \(t_{k+1}\), all following successive ratios are at most \(r=x/(k+2)\). Once the source guard \(k+1>x\) holds, \(r<1\), and comparison with a geometric series gives

\[
0<e^x-S_k\leq\frac{t_{k+1}}{1-x/(k+2)}=:R_k.
\]

The operation returns \([S_k,S_k+R_k]\) when \(R_k\leq10^{-p}\). Counter orientation uses the reciprocal enclosure. Empty input has the exact multiplicative identity result. Requested precision is a counted value from 1 through 60, and exhaustion of the declared term bound returns an explicit halt.

For \(x>0\), let \(z=|x-1|/(x+1)\), so \(0\leq z<1\), and let \(\varepsilon\) select the forward or counter orientation according to \(x\gtrless1\). From the geometric expansion of \(1/(1-z^2)\), integration gives

\[
\log x=\varepsilon\,2\sum_{j=0}^{\infty}\frac{z^{2j+1}}{2j+1}.
\]

After indices \(0\) through \(k\), every remaining denominator is at least \(2k+3\). Therefore

\[
R_k\leq\frac{2z^{2k+3}}{(2k+3)(1-z^2)}.
\]

The source forms centre \(C_k=\varepsilon2\sum_{j=0}^kz^{2j+1}/(2j+1)\) and returns \([C_k-R_k,C_k+R_k]\) once the tolerance is met. These recurrences and stopping decisions are the bodies of `CalculatorSeries.expLoop` and `CalculatorSeries.lnLoop`.

The sine and cosine source recurrences use the factorial-denominator term ratios, with alternating signs. Once the remaining magnitudes decrease, the next term bounds the remainder; the returned symmetric enclosure retains that bound. The complete evaluator first performs exact interval period reduction. If \(P=[P_L,P_U]\) is the circle enclosure and \(n\) is the selected whole-turn count, it constructs

\[
X'=X-2nP,\qquad \operatorname{width}(2nP)=2|n|(P_U-P_L).
\]

`CalculatorCompleteOperations.circleForTurns` refines the circle enclosure until this width is at most \(10^{-(p+6)}\), within its original counted term limits. Its `periodicReduce` retains the exact translated endpoints and whole-turn certificate. Circular function dispatch then consumes this interval; tangent divides sine and cosine enclosures with the original denominator guard.

## 5. Circle enclosure and the parity that determines it

For \(0<x\leq1\) and positive term count \(N\), define

\[
A_N(x)=\sum_{j=0}^{N-1}(-1)^j\frac{x^{2j+1}}{2j+1},\qquad
q_N(x)=\frac{x^{2N+1}}{2N+1}.
\]

Successive positive term magnitudes decrease because their ratio is \(x^2(2j+1)/(2j+3)<1\). Pairing the alternating terms bounds the remaining tail between zero and its first term, with the appropriate sign. Consequently,

\[
\arctan x\in
\begin{cases}
[A_N-q_N,A_N],&N\text{ odd},\\
[A_N,A_N+q_N],&N\text{ even}.
\end{cases}
\]

These are the exact branches of `CalculatorOperationsV2.atanUnitEnclosureV2`. The original 003 registration has status `superseded_adverse_evidence`; its opposite endpoint parity is not used for the circle result here. The 004 source supplies the displayed formula and is the arithmetic inherited by the subsequent calculator stages. Both registrations and their exact statuses remain in the source package.

Put \(\alpha=\arctan(1/5)\) and \(\beta=\arctan(1/239)\). Twice applying the tangent double-angle formula gives

\[
\tan(2\alpha)=\frac5{12},\qquad
\tan(4\alpha)=\frac{120}{119}.
\]

The subtraction formula then yields

\[
\tan(4\alpha-\beta)
=\frac{120/119-1/239}{1+(120/119)(1/239)}=1.
\]

The angle is positive, since \(\alpha>\beta>0\), and is below \(4/5\) because \(\arctan(1/5)<1/5\). It lies on the principal increasing tangent branch and hence equals the quarter turn. Thus

\[
\pi=16\arctan(1/5)-4\arctan(1/239).
\]

If the two arctangent intervals are \([a,b]\) and \([c,d]\), the circle interval is exactly \([16a-4d,16b-4c]\). The certificate retains the angle composition and tangent identity. The reproduction verifies the rational identity and both parity branches for 128 argument/count combinations.

## 6. Parsing, resources and projection

The parser consumes the complete expression. Its precedence proceeds through additive terms, multiplicative terms, unary orientation, powers, postfix operations and primary forms. The exponent is parsed through the unary level, making powers associate to the right: `2^3^2` is \(2^{(3^2)}=512\). Unary reversal surrounds the following power, so the arithmetic parser treats `-2^2` as reversal of \(2^2\). Parentheses explicitly change the grouping. Factorial and percentage are postfix operations; percentage divides by the exact whole 100.

A final equals sign is an execute marker; an internal equals sign is rejected. Bare names bind retained session symbols or the source constants. Function calls enforce arity and their original value domains. Every accepted operation appends its named trace and increments its count. The complete parser additionally bounds numeric-token digits, exponent magnitude, counted root degree, combinatorial supports and aggregate argument count by the declared resource boundary. These decisions appear in `CalculatorCompleteMachine.lex`, `boundedWhole`, `call` and `calculateWithSymbols`, preserving the original `calculator_complete/machine.py` operations.

Decimal projection is separate from this evaluation. `CalculatorProjection.roundQuotient` divides \(n\) by \(d\), obtaining quotient \(q\) and remainder \(r\), and increments precisely when

\[
2r>d\quad\text{or}\quad(2r=d\;\land\;q\text{ is odd}).
\]

This is the exact ties-to-even decision. The source first performs decimal division with precision \(p+8\), then formats to the requested significant precision; the native translation retains both stages and the original exponent thresholds. The browser's native view instead prints the rational or certified value, and removes the projection suffix from the displayed trace. Exact state is therefore shared across interfaces even where their presentation policies differ.

## 7. Transactional admission and the browser grammar

Let \(s\) be the retained controller state, \(e(s,p)\) the optional expression edit from payload \(p\), and \(D\) the requested controller action. The original transaction snapshots the edited state before dispatch:

\[
s_e=e(s,p),\qquad s'=D(s_e,p).
\]

Its counter predicate inspects the answer, memory and every history value. For intervals it inspects both endpoints; for fibres it inspects both components. For a non-state action with a counter component, the transaction restores the snapshot's answer, memory, history and mode, retains the attempted expression, and sets the explicit rejection view. A dispatch error retains the already accepted expression edit and returns the error response. A `state` action reads the state without applying the post-dispatch rejection branch. These distinctions are present in `snapshot`, `restore`, `containsCounter`, `applyController` and `response`.

Each new page obtains its own session. The HTTP implementation checks request authentication, payload type and size before routing. The page renders the returned state and forwards button and keyboard actions to the same controller. Its eight source presentation axes are rendered surface, keypad organisation, value boundary, kernel route, session state, network reach, dependency boundary and validation.

For each axis the source declares exactly two alternatives, admitted and rejected. Thus its candidate carrier is

\[
C=\prod_{i=1}^{8}\{a_i,r_i\},\qquad |C|=2^8=256.
\]

The generation enumerates the product in source order. The first-failure decision rejects a candidate at its first rejected coordinate. Hence

\[
\operatorname{survives}(c)=\mathrm{true}
\iff\bigwedge_{i=1}^{8}(c_i=a_i)
\iff c=(a_1,\ldots,a_8).
\]

For the forward implication, any rejected coordinate would force a failure; therefore every coordinate is admitted. For the reverse implication, every source check succeeds on the all-admitted tuple. Enumeration is exhaustive because each constructor is included at each product coordinate. Native `CalculatorBrowserGrammar.sourceDecisionMatchesCriteria`, `uniqueCriteriaSurvivor`, `uniqueSurvivor`, `acceptanceIffExactCriteria` and `candidatesComplete` prove these statements over every candidate. Their proof bodies split the declared coordinate constructors and reduce the source decision; they do not infer completeness from a sampled application run. The corresponding earlier grammars use their own original axes, counts and decision predicates.

## 8. Source correspondence and retained verification

The source package separates the native proof evidence, whole-programme comparisons, operation comparisons and actual browser execution. The five completion receipts bind their native modules to exact digests. The published source archive contains all 255 entry modules and 851 modules including their retained imports. Every one of the 1,281 distinct audited names has retained empty-axiom output; this count includes definitions and theorems.

| Source registration | Candidate rows | Entry modules | Audited names in receipt |
|---|---:|---:|---:|
| Calculator 003, superseded source retained | 1,024 | 39 | 240 |
| Corrected calculator 004 | 1,024 | 5 | 68 |
| Scientific session 005 | 8,192 | 149 | 471 |
| Complete controller 006 | 1,024 | 34 | 303 |
| Browser application 007 | 256 | 28 | 200 |

The distinct audit total removes overlap between receipts. Whole-programme comparisons preserve registrations, every candidate lookup, census trace hashes, decision proof hashes, closure and controls, including unknown-identifier rejection. Retained calculation comparisons cover 202 corrected-evaluator cases, 176 scientific-session evaluator cases and 308 complete-evaluator cases, comparing complete values, certificates, traces, resource counts, rendering and errors. Browser evidence includes 208 transaction states across 120 sequences, 19 full HTTP responses, 15 request-boundary cases and six complete-page cases. These checks retain their original source and check digests in the accompanying evidence.

The present reproduction adds exact rational root, series and parity checks and actual original-application actions. An installed browser run types the three expressions from Section 1 into the original page, observes the HTTP responses and compares the DOM result and proof text with those responses. All three pass with no browser console errors. Screenshots and sanitized result records accompany the paper; session credentials are excluded.

The mathematical construction is Maria Smith's SFT. The paper's source specification is pinned V3, and its native translation evidence is the published V4 edition. The source archive, correspondence map and runnable reproduction are supplied with this paper so that the stated operations, complete classifiers and displayed outcomes can be inspected together.

## References

[1] Maria Smith. SFT V3 source corpus, commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Source paths: `sft/mathematics/calculator/`, `calculator_complete/`, `calculator_browser/`, and `generated_law.py`. Exact source bytes accompany this paper. V3 foundational publication: [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656). Monograph: [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[2] Maria Smith. SFT V4 Lean verified source, edition 0.4, commit [`21cdf559922fb057f8560f42d056ffa035329eb3`](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3). Native declarations cited above are under `SFT.Mathematics`; completion receipts are `TURN_1011_CALCULATOR_003_COMPLETION.json`, `TURN_1011_CALCULATOR_004_COMPLETION.json`, `TURN_1016_CALCULATOR_005_COMPLETION.json`, `TURN_1025_CALCULATOR_006_COMPLETION.json` and `TURN_1027_CALCULATOR_007_COMPLETION.json`.

[3] Maria Smith. SFT V4 cumulative scientific edition: [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Correspondence edition: [doi:10.5281/zenodo.24337358](https://doi.org/10.5281/zenodo.24337358). Source and evidence are retained with the published edition and this paper's `SOURCE_AND_EVIDENCE.zip`.

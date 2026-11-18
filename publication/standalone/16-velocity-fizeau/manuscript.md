# Positive velocity composition and the Fizeau comparison

**Unique bilinear forcing, exact retained-pair reconstruction and moving-medium optics**

Maria Smith · Ernos Labs  
18 November 2026 · Version 1.0 · DOI: 10.5281/zenodo.24327587

## Abstract

The positive same-direction composition law is uniquely forced by the original four-form bilinear grammar, typed rest identity and absorption at the limiting One. Its exact operation is \(C(u,v)=(u+v)/(1+uv)\). Multiplication of the retained forward and held parts reconstructs this law for every admitted rational input, including the typed-empty limiting branch. The normalized numerator–denominator derivation proves strict sublimit closure, limiting absorption and commutativity; retained component multiplication proves associativity. The independent Fizeau comparison retains the measured water slope \(274/1000\pm3/1000\), both relativistic predictions \(248/1000\) and \(299/1000\), and ordinary addition's \(563/1000\) in rad s/m. The complete relativistic systematic bracket contains the measured interval, and its nearest prediction is more than ten times closer to the measured centre than ordinary addition. The air comparison and all original experimental conditions remain in the same committed record. This paper gives the forcing argument, general rational proof, finite append construction, optical correspondence and complete post-seal comparison, with 2,304 source candidate decisions and 334 distinct empty-axiom audited native Lean declarations.

## 1. Original motion domain and the unique law

The source motion carrier consists of typed rest and an exact positive rational speed \(0<u\leq1\). One is the limiting speed. Rest is a separate constructor: the composition operation returns the other argument immediately when either argument is rest. For two numeric arguments, it first converts and checks each speed, rejecting a nonpositive value or a value greater than One. This order is part of the source operation. In particular the rest shortcut precedes the numeric checks; it does not introduce a numeric zero speed into the positive carrier. The Python boundary uses its original `Fraction` conversion. The native rational operation preserves the resulting guard, and the boundary comparisons retain the original converted inputs and errors.

The original bilinear grammar first fixes the left term, right term and denominator-One by the identity requirements. It then exhausts the presence or absence of the numerator and denominator cross terms. Write their two Boolean enumeration coordinates as \(n,d\in\{0,1\}\). They indicate term presence, not adjustable coefficients. The four forms are

\[C_{n,d}(u,v)=\frac{u+v+nuv}{1+duv}.\]

Requiring the limiting One to absorb an admitted positive input gives

\[C_{n,d}(1,v)=1
\quad\Longleftrightarrow\quad
1+v+nv=1+dv
\quad\Longleftrightarrow\quad d=1+n.\]

Since each coordinate has only its two original constructors, the sole solution is \(n=0,d=1\). The enumeration is complete:

| Numerator cross term | Denominator cross term | Value at \((1,1/2)\) | Limiting absorption |
|---|---|---|---|
| Absent | Absent | \(3/2\) | Fails |
| Absent | Present | \(1\) | Holds |
| Present | Absent | \(2\) | Fails |
| Present | Present | \(4/3\) | Fails |

Consequently,

\[\boxed{C(u,v)=\frac{u+v}{1+uv}}.\]

The original complete rows retain their identifiers, both coordinates, the three identity-forced terms and the absorption decision. `SFT.Physics.VelocityComposition.bilinearCensusCount` proves that there are four; `bilinearUniqueCoordinates` gives exactly the accepted list `[(false,true)]`; `bilinearLimitForcesCoordinates` proves the coordinate implication for every Boolean pair. This exhaustion selects the law before any Fizeau observation is released. It introduces no fitted scientific coefficient or experimental choice.

## 2. Rational normalization, closure and the limiting branch

Let \(u=n/d\) and \(v=m/e\), with natural numerators, positive denominators and the original speed guards. Common-denominator arithmetic gives

\[u+v=\frac{ne+md}{de},\qquad uv=\frac{nm}{de},\qquad
1+uv=\frac{de+nm}{de}.\]

Dividing cancels the common positive denominator:

\[C(u,v)=\frac{ne+md}{de+nm}.\]

The native proof follows these operations on normalized rational values. `VelocityComposition.originalRationalComposition` rewrites source addition, source multiplication and the denominator-One representation, then applies the existing exact division and normalization identities. `originalCompositionFormula` binds the expression to the actual guarded operation. `originalCommutative` uses the same identities to establish \(C(u,v)=C(v,u)\) for admitted arguments. All velocity declaration names in this paper have the namespace prefix `SFT.Physics.VelocityComposition`, including those stored in the Algebra, PairProduct and Reconstruction modules.

For strict sublimit inputs, write \(d=n+a\) and \(e=m+b\) with positive residuals \(a,b\). Put

\[N=n(m+b)+m(n+a),\qquad D=(n+a)(m+b)+nm.\]

Expansion gives

\[D=2nm+nb+am+ab=N+ab.\]

Since \(N>0\) and \(ab>0\), \(0<N<D\) and \(0<C(u,v)<1\). The exact complement is

\[1-C(u,v)=\frac{D-N}{D}
=\frac{ab}{D}
=\frac{(1-u)(1-v)}{1+uv}.\]

`originalHeldResidual` proves the denominator decomposition and `originalStrictClosureCross` proves the strict inequality. If either input is One, its residual vanishes, \(D=N\) and \(C=1\); `originalLimitCross` proves this boundary identity. The direct operation likewise gives \(C(1,v)=(1+v)/(1+v)=1\) and its commuted form. Thus the entire admitted carrier is closed: strict parts remain strict when composed together, and the limiting value is absorbing.

The departure from ordinary addition follows by putting both terms over the same denominator:

\[(u+v)-C(u,v)
=\frac{(u+v)(1+uv)-(u+v)}{1+uv}
=\frac{uv(u+v)}{1+uv}.\]

Every factor is fixed by the original inputs. At low speeds the discrepancy begins with the higher product \(uv(u+v)\); ordinary addition is the leading small-speed expression. The exact rational difference, including its denominator, is retained in the original certificate.

## 3. Forward and held products reconstruct the actual operation

For a strict positive part, the source represents motion by

\[P(u)=(1+u,1-u).\]

At \(u=1\) its representation is \((2,\mathrm{EMPTY})\), where `EMPTY` is the original typed empty held component. Pair composition multiplies the forward components and multiplies the held components, with typed empty absorbing. For two strict inputs,

\[P(u)\star P(v)=(A,B),\quad
A=(1+u)(1+v),\quad B=(1-u)(1-v).\]

The source recovery guard requires \(A>B\), then returns \((A-B)/(A+B)\). Expansion supplies the exact differences and sums:

\[A=1+u+v+uv,\qquad B=1-u-v+uv,\]
\[A-B=2(u+v)>0,\qquad A+B=2(1+uv)>0.\]

The guard therefore holds and

\[\operatorname{recover}(P(u)\star P(v))
=\frac{2(u+v)}{2(1+uv)}=C(u,v).\]

The native reconstruction binds this calculation to the actual returned pairs. With the residual notation of Section 2, set

\[F=(n+a+n)(m+b+m),\qquad H=ab.\]

The composed pair is exactly \((F/(de),H/(de))\). The verified polynomial identities are

\[F=H+2N,\qquad F+H=2D.\]

`originalForwardHeldDifference` and `originalForwardHeldSum` prove these identities. `originalProductRecovery` applies exact normalized subtraction and division to obtain \(2N/(2D)=N/D\). The proof establishes positivity of the forward excess, so the original recovery guard succeeds; it does not replace that guard with an assumed output. `originalHeldPairSublimit` and `originalComposedHeldSublimit` identify the exact results of the original constructors. `originalReconstructionSublimit` combines the guarded construction, product and recovery equalities for arbitrary admitted strict rational inputs.

At a limiting input, `originalHeldPairLimit` returns \((2,\mathrm{EMPTY})\). The product has empty held component. The original recovery operation takes this constructor first and returns One immediately. `originalRecoverEmpty`, `originalReconstructionLeftLimit` and `originalReconstructionRightLimit` prove these branches, completing the admitted domain. The recovery error for a nonempty held component with forward value at most held value remains part of the operation. No extra restriction is applied to the original empty shortcut.

## 4. Associativity and every finite append

Multiplication of retained rational components is associative. For natural numerators \(a,b,c\) and positive denominators \(p,q,r\),

\[\left(\frac ap\frac bq\right)\frac cr
=\frac{(ab)c}{(pq)r}
=\frac{a(bc)}{p(qr)}
=\frac ap\left(\frac bq\frac cr\right).\]

`normalizedComponentAssociative` proves this equality through exact normalization, and `retainedComponentAssociative` transports it to existing nonnegative rational components. A held product is either a rational product or typed empty. If one of three components is empty, both parenthesizations are empty; otherwise the rational equality applies. `originalHeldAssociative` exhausts those constructors. The forward equality and held equality together prove `originalPairAssociative` under the explicit nonnegative component hypotheses satisfied by the source-generated pairs. `originalPairProduct` identifies this append with the multiplication already used by `compose_held_pairs`.

Repeated append therefore retains the full product pair. For a nonempty finite list \(u_1,\ldots,u_k\) of strict positive parts,

\[A_k=\prod_{i=1}^k(1+u_i),\qquad
B_k=\prod_{i=1}^k(1-u_i),\qquad
U_k=\frac{A_k-B_k}{A_k+B_k}.\]

For the base \(k=1\), recovery gives \(2u_1/2=u_1\). On appending \(v\), the two retained components become \(A_k(1+v)\) and \(B_k(1-v)\). Their difference and sum are

\[A_k(1+v)-B_k(1-v)=(A_k-B_k)+v(A_k+B_k),\]
\[A_k(1+v)+B_k(1-v)=(A_k+B_k)+v(A_k-B_k).\]

Division by the positive \(A_k+B_k\) gives \((U_k+v)/(1+U_kv)\). This is the original successor operation. Every parenthesization has the same component product by associativity. A limiting member makes the held product empty and recovery One; insertion of typed rest leaves the source composition unchanged. This base/successor argument uses the existing component associativity and reconstruction equalities without a new scientific rule.

For three motions the explicit recovered expression is

\[C(C(u,v),w)=\frac{u+v+w+uvw}{1+uv+uw+vw}=C(u,C(v,w)).\]

It follows directly by substituting \(C(u,v)\) and multiplying numerator and denominator by \(1+uv\); the second parenthesization produces the same four numerator and four denominator terms. All denominators are positive on the admitted domain. The native retained-pair proof gives the general associative mechanism, while the source's finite certificate additionally checks all \(8^3=512\) triples of its declared eight-point grid.

## 5. Complete source grammars, witnesses and controls

The four-form algebraic census sits inside the original eleven-axis entry grammar. Its binary axes and admitted values are:

| Axis | Admitted construction |
|---|---|
| Motion domain | Exact positive part of the limiting One |
| Rest | Typed two-sided identity |
| Representation | Forward and held pair |
| Numerator | No cross term |
| Denominator | Cross term present |
| Limit | Absorbing One |
| Closure | Strict sublimit closure |
| Associativity | Retained component composition |
| Record | Both forward and held parts retained |
| Measurement | Comparison only after sealing |
| Extension | No extra coefficient or rule |

Each axis has its original admitted/rejected constructors. The candidate list is the ordered nested Cartesian product, containing \(2^{11}=2048\) alternatives. Constructor membership at each field proves membership of every candidate in the generated product. The source decision checks the original conditions in order and retains its first-failure reason. Exhaustion of all constructor combinations proves equivalence to their conjunction, and that conjunction holds exactly for the admitted candidate. The proof is organized as thirty-two complete 64-row blocks. `VelocityCompositionGrammar.candidatesComplete`, `sourceDecisionMatchesCriteria`, `uniqueCriteriaSurvivor` and `uniqueSurvivor` give completeness, decision correspondence and uniqueness. The complete identifiers, exact forms, decisions and reasons agree with the original ordered execution.

The source certificate uses the grid

\[G=(1/8,1/4,1/3,1/2,2/3,3/4,7/8,1).\]

It returns nine fields: the count four, unique survivor identifier, closure, associativity, pair equivalence, strict sublimit closure, limiting absorption, typed rest identity and exact higher-product difference. It checks all 64 pairs and 512 triples as appropriate; the strict grid omits One. The five original operational witnesses have native proofs. The retained operation comparison contains 903 cases, all four census rows and every certificate field, including the numeric rejection branches and rest-before-guard behavior. These executable comparisons accompany the general proofs in Sections 2–4.

The Fizeau entry has eight binary axes: carrier, relation, provenance, prediction isolation, separate proof/measurement record, complete rows, successor closure and no extra rule. Its complete product has \(2^8=256\) alternatives. `FizeauGrammar.candidatesComplete`, `sourceDecisionMatchesCriteria`, `uniqueSurvivor` and `acceptanceIffExactCriteria` prove the corresponding complete classification. Its three witnesses reuse the formal bilinear census, closure/associativity certificate and rest/limit laws. The two entry products total \(2048+256=2304\) decisions; the four algebraic cross-term choices are a separate nested census. Every original false-premise, source-tampering, artifact-tampering and boundary control is retained. The independent source validator accepts the complete program and rejects an omitted candidate, an extra survivor and a failed control.

## 6. From the composition law to the Fizeau phase shift

The registered external source is Lahaye, Labastie and Mathevet, *Fizeau's aether-drag experiment in the undergraduate laboratory*, arXiv:1201.0501. Its retained PDF gives the optical derivation on pages 2–3, equations 1–7, water results on pages 6–7 and air results on page 7. This section spells out that source's correspondence. The dimensional inscriptions belong to the external optical comparison; the native law above remains the exact positive rational operation.

For a medium of index \(n\) moving at speed \(v\), the rest-medium phase speed is \(c/n\). In the same-direction branch, substituting normalized speeds \(1/n\) and \(v/c\) into the forced law gives

\[v_+=c\,C(1/n,v/c)=\frac{c/n+v}{1+v/(nc)}.\]

The primary source obtains the opposite-direction optical branch by reversing the medium direction:

\[v_- =\frac{c/n-v}{1-v/(nc)}.\]

This orientation reversal is the external two-arm optical correspondence; the original positive same-direction carrier is unchanged. For interaction length \(2\ell\) and vacuum wavelength \(\lambda\), the accumulated phases are \(\phi_\pm=(2\pi c/\lambda)(2\ell/v_\pm)\). Their difference is therefore

\[\Delta\phi=\frac{4\pi\ell c}{\lambda}
\left(\frac{1-v/(nc)}{c/n-v}-\frac{1+v/(nc)}{c/n+v}\right).\]

Putting the two terms over their common denominator gives numerator \(2v(1-1/n^2)\) and denominator \(c^2/n^2-v^2\). Hence

\[\Delta\phi=\frac{8\pi\ell v}{\lambda c}\,
\frac{n^2-1}{1-n^2v^2/c^2}.\]

At first order in \(v/c\), the primary source's result is

\[\Delta\phi_{\mathrm{rel}}=\frac{8\pi\ell v}{\lambda c}(n^2-1).\]

Ordinary addition instead uses \(v_\pm=c/n\pm v\) and gives the first-order prediction

\[\Delta\phi_{\mathrm{ordinary}}=\frac{8\pi\ell v}{\lambda c}n^2.\]

The subtraction of One in the optical factor is the observable distinction. The source includes dispersion by replacing \(n^2-1\) with \(n^2-1+n\omega\,dn/d\omega\). Its water calculation at 532 nm increases the raw prediction by 3.8%. The beam samples the axial water speed, whereas the flow measurement gives a section average. The source's empirical turbulent profile \(v(r)=v_{\max}(1-r^2/R^2)^{1/6}\) gives

\[\bar v=\frac{2}{R^2}\int_0^R r\,v(r)\,dr
=v_{\max}\int_0^1(1-x)^{1/6}dx
=\frac67v_{\max}.\]

The axial/mean correction is thus \(7/6\), reported approximately as 1.16 in the source. Together with dispersion it produces the retained corrected slope \(299/1000\) rad s/m. The original target keeps that published rounded value and the raw \(248/1000\) separately; neither is refitted to the measured slope. The primary source reports the corresponding agreement at the 8% level, retained as its original inscription \(8/100\).

## 7. Exact water discriminator and complete air record

The complete committed record contains the water measurement \(m=274/1000\) and stated statistical uncertainty \(s=3/1000\), in rad s/m. It also contains raw prediction \(r=248/1000\), corrected prediction \(q=299/1000\) and ordinary-addition alternative \(o=563/1000\). The measured interval is

\[I_m=[m-s,m+s]=[271/1000,277/1000].\]

All distances are evaluated as exact rational differences:

\[|m-r|=26/1000,\quad |m-q|=25/1000,\quad
|m-o|=289/1000,\]
\[d_{\mathrm{best}}=\min(|m-r|,|m-q|)=25/1000.\]

The three registered numerical decisions follow without rounding:

\[r\leq m-s<m+s\leq q
\quad\text{because}\quad248\leq271<277\leq299,\]
\[10d_{\mathrm{best}}=250/1000<289/1000=|m-o|,\]
\[o=563/1000>277/1000=m+s.\]

Thus the complete relativistic systematic bracket contains the measured interval, the nearest retained relativistic prediction is \(289/25=11.56\) times closer than ordinary addition, and ordinary addition lies outside the measured interval. The raw and corrected point predictions lie on opposite sides of that interval. The source-defined result is the complete bracket and alternative discrimination.

The air experiment provides the retained independent contrast: ordinary addition is ruled out and the measurements are compatible with the relativistic calculation. Its optical factor explains the large contrast. For air with \(n\) close to One, \(n^2-1\) is small whereas \(n^2\) is near One. The source's Figure 8 preserves both predicted curves and the measured behavior. The committed record also preserves the water velocity examples \(57/10,8/10,57/10\) m/s.

The four original experimental conditions remain explicit: flow-rate calibration is estimated at about five percent; the axial-to-mean turbulent-profile correction is modelled rather than measured directly in this apparatus; the effective optical interaction length has percent-level uncertainty; and the water comparison is a discriminator rather than a precision interval confirmation. These conditions are part of the registered experimental record and its acceptance operation.

The numerical operation returns all fifteen fields, rather than only a passing flag:

| Field group | Exact retained result |
|---|---|
| Measured slope and uncertainty | \(274/1000\), \(3/1000\) |
| Measured interval | \([271/1000,277/1000]\) |
| Raw, corrected, ordinary predictions | \(248/1000\), \(299/1000\), \(563/1000\) |
| Raw and corrected distances | \(26/1000\), \(25/1000\) |
| Best and ordinary distances | \(25/1000\), \(289/1000\) |
| Complete bracket, tenfold, ordinary outside | True, true, true |
| Air control and all four conditions retained | True, true |

`SFT.Physics.FizeauAnalysis.originalMeasuredInterval`, `originalDistances`, `originalBracket`, `originalTenfold` and `originalOrdinaryOutside` prove these exact values and decisions. `originalAirControl` binds the two air flags, and `originalLimitationCount` identifies the four-member condition test. For the adverse control, replace only the ordinary prediction by the measured centre. Its distance becomes zero, so \(10(25/1000)<0\) is false. `originalTamperedControl` proves rejection. The unchanged source reproduction returns the same full result and rejects this changed row.

## 8. Target custody and complete program correspondence

The source record and primary PDF are independently bound by their SHA256 identities. `FizeauRecords.authoritativeRecord` checks both byte identities, then checks schema, source identifier, PDF path/hash, all six original numeric strings, both air flags, the four-member condition ledger and the original custody flags. The numerical inscriptions include the reported agreement fraction. The custody record requires the formal result to have been sealed before source retrieval, every favorable and unfavorable row to be retained, the target to be inaccessible to the formal derivation and measurement selection of the formal survivor to be false.

The original experiment specification describes five source locators: water measurement, relativistic predictions, ordinary-addition control, air result and systematics. The actual custom validator carries them in one withheld complete-record target. Its four-instruction prediction program receives the sealed derivation premise, not the measured slopes. Execution fixes the output and trace hashes. The prediction seal binds these to the experiment envelope. The protected-package comparison checks the same program and unchanged protected snapshot; the custodian then releases the committed record and verifies its identity.

`FizeauValidation.validate` checks the expected prediction label before running the exact fifteen-field analysis. Its accepted result is

\[\mathrm{Formal}\land\mathrm{AllRows}\land\mathrm{Discriminator}
\land\mathrm{TamperedRejected},\]

where `Formal` is the conjunction of the three inherited formal witnesses, `AllRows` retains the air result and four conditions, and `Discriminator` is the conjunction of the bracket, tenfold and ordinary-outside comparisons. The isolation certificate records denied clock, import, environment, filesystem, foreign-function, network and subprocess capabilities. The custody certificate binds registration, target identity, prediction seal and release. The complete comparison receipt includes source hashes, original seal, target identity, full analysis, all decisions and trace identity.

`FizeauMeasurement.exactFizeauAnalysis` retains the original field order, exact input conversion, source truth-value conjunction for the air result and source length operation for the conditions. The source-bound comparisons cover 157 record outcomes, 41 complete numerical outputs, 53 Fraction/JSON measurement outputs and five registration/document/envelope outputs. The full native empirical result agrees field for field and hash for hash with the fresh original validator and retained original empirical record. The complete 256-candidate program, controls and unknown-identifier behavior also agree. These results bind the numerical theorem, serialized record and execution protocol to the same original source operation.

## 9. Source correspondence and reproducibility

Maria Smith is the scientific author. The original V3 commit is `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`; the V4 edition 0.4 evidence commit is `21cdf559922fb057f8560f42d056ffa035329eb3`.

The formal entry is `SFT-PHYS-SPACETIME-VELOCITY-COMPOSITION-TERMINAL-033`. Its original specification and operations are in `sft/physics/velocity_composition_terminal_law_v1.py`. The native composition, algebra, pair product, reconstruction, witnesses, complete grammar and entry evidence are in the corresponding `SFT/Physics/VelocityComposition*.lean` modules. Its source-specific completion receipt is `verification/TURN_1030_VELOCITY_033_COMPLETION.json`, with 206 audited declarations, including 124 theorems. The general proof and operation comparisons are retained in the TURN1021, TURN1022, TURN1028 and TURN1030 evidence; their chronological correspondence is in the cumulative TIMELINE.txt at the pinned V4 repository.

The empirical entry is `SFT-PHYS-VALIDATION-VELOCITY-COMPOSITION-034`. Its sources are `velocity_composition_fizeau_empirical_v1.py`, `velocity_composition_fizeau_validation_v1.py`, `velocity_composition_fizeau_execution_v1.py` and the shared `generated_empirical_law.py`, with the original generated independent validator. Its nine native Fizeau modules and `verification/TURN_1031_FIZEAU_034_COMPLETION.json` retain 128 audited declarations, including 32 theorems, together with the full comparison and control results.

The two entries therefore supply 334 distinct selected declarations with empty axiom dependencies, including 156 theorems. The release archive includes 723 native modules with imports, 39 original source files, the exact primary-source PDF and registered record, applicable build/audit/comparison results and a portable executable reproduction. `SOURCE_CORRESPONDENCE.json` gives their exact digests and entry mappings. The reproduction executes the unchanged four-form census, nine-field certificate, complete grid pairs, original source-hash/record checks, all fifteen Fizeau fields and changed-row rejection. Applicable existing native proof results are retained; no new Lean compilation is counted as a new scientific result.

## References

1. Maria Smith. Smithian Fold Theory V3 foundation. https://doi.org/10.5281/zenodo.21627656.
2. Maria Smith. Smithian Fold Theory V3 physics corpus. https://doi.org/10.5281/zenodo.21761655. Exhaustive monograph: https://doi.org/10.5281/zenodo.21900790.
3. Maria Smith. SFT V4 Lean verified corpus, edition 0.4. https://doi.org/10.5281/zenodo.24320778. Pinned native source: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3.
4. Thierry Lahaye, Pierre Labastie and Renaud Mathevet. Fizeau's aether-drag experiment in the undergraduate laboratory. arXiv:1201.0501. https://arxiv.org/abs/1201.0501. The exact registered PDF snapshot and source record are included in this release; equations 1–7, Figure 6, Sections V.C–D and Figure 8/Section V.E supply the complete optical and empirical comparison.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

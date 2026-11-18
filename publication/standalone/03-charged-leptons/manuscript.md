# Charged-lepton mass ratios and the exact Koide invariant from Fold geometry

**Maria Smith** · Ernos Labs  
Standalone paper 3 · Version 1.1 · 17 November 2026 · DOI: 10.5281/zenodo.24325169

## Abstract

Smithian Fold Theory derives an exact charged-lepton cubic with normalized root sum One and pair sum 1/6, hence the Koide invariant is exactly 2/3. Complete colour support fixes the leading product 1/485; the unique generator-three channel sharpens it to 3/1454. The terminal electromagnetic coupling acts once on each of the three root positions, distributes over the complete 27-cell carrier and retains the independently generated cover depths five and seven. Its exact product is \(P=3/1454-\alpha^3(5+(7/3)\alpha)/27\), with \(\alpha=3676744786/503846395469\). Exact rational isolation and refinement of \(x^3-x^2+x/6-P\) place both muon–electron and muon–tau mass ratios inside their complete NIST CODATA 2022 one-standard-uncertainty intervals. The root-sum and pair-sum identities remain unchanged, so the terminal coupling preserves Koide exactly. The paper develops the support counts, complete symmetric expansion, channel uniqueness, terminal correction, exhaustive classifications, source-resolution root algorithms and full measured comparisons. Native Lean 4 proofs retain the original source operations and zero axiom dependencies. The source's initial cubic comparison and the observational provenance of its terminal refinement are included with their exact outcomes.

**Keywords:** charged-lepton masses; Koide formula; electron muon tau mass ratios; Smithian Fold Theory; fine-structure constant; exact cubic; Lean 4 verification; CODATA 2022.

## 1. The exact result

Write the three positive normalized mass-root positions in increasing order as \(x_e,x_\mu,x_\tau\). The mass interpretation uses their squared ratios:
\[
 \frac{m_\mu}{m_e}=\left(\frac{x_\mu}{x_e}\right)^2,
 \qquad
 \frac{m_\mu}{m_\tau}=\left(\frac{x_\mu}{x_\tau}\right)^2.
\]
Equivalently, normalization divides each positive square-root mass by their common sum. The exact symmetric carrier obeys
\[
 x_e+x_\mu+x_\tau=1,\qquad
 x_ex_\mu+x_ex_\tau+x_\mu x_\tau=\frac16.
\]
Its three positions are the roots of
\[
 f_P(x)=x^3-x^2+\frac16x-P.
\]
The terminal product is the exact positive fraction
\[
 P=\frac{15659709397871168801443815466454510956837000584115}
 {7590004776733382935404977537704409308185713931574254}.
\]
No measured lepton mass or mass ratio enters this coefficient. Sections 2–5 derive its generated ingredients and their composition. The resulting exact root enclosures imply
\[
\begin{aligned}
 206.76828065
 &\le m_\mu/m_e\le206.76828449,\\
 0.05945977034
 &\le m_\mu/m_\tau\le0.05946013504.
\end{aligned}
\]
The exact rational endpoints, rather than these display decimals, are used in every comparison below. Both prediction intervals are wholly contained in the complete registered CODATA intervals.

The Koide ratio follows without evaluating any root:
\[
 Q=\frac{m_e+m_\mu+m_\tau}
 {(\sqrt{m_e}+\sqrt{m_\mu}+\sqrt{m_\tau})^2}
 =\frac{x_e^2+x_\mu^2+x_\tau^2}{(x_e+x_\mu+x_\tau)^2}
 =1-2\cdot\frac16=\frac23.
\]
The product \(P\) does not occur in this identity. Its terminal refinement therefore preserves the exact Koide value while changing the two independently tested mass ratios [1–4].

## 2. From Fold to the complete three-position carrier

The operational root distinguishes unpresented absence from occurrence: presenting a claim, denial or retained record is itself an occurrence. Complete retention without an unforced addition gives structural One. Equal complementary positive parts obey \(h+h=1\), hence \(h=1/2\). On positive parts through One, Fold is
\[
 F(x)=\begin{cases}2x,&0<x\le1/2,\\2x-1,&1/2<x\le1.\end{cases}
\]
The primitive identity and square maps are injective, while constant One has no nonstatic return. Fold joins the distinct inputs half-One and One at One and retains a nonstatic cycle. The singleton Fold therefore supplies a generating word; any least nonempty generating word has length one, and the primitive classification selects Fold uniquely. The native least-word proof quantifies over all admitted finite words [5].

Complete binary support extends each existing word in two labelled ways. Its base has one empty word; its successor contains both disjoint extensions of every prior word. Induction gives \(2^d\) words at depth \(d\). The first positive predecessor unit parts yield the exact Fold traces
\[
 \frac13\mapsto\frac23\mapsto\frac13,
 \qquad
 \frac17\mapsto\frac27\mapsto\frac47\mapsto\frac17.
\]
Neither trace returns at an earlier positive step. The least return length is two; the least larger generated count is three. Thus the source's colour generator is \(g=3\), and its positive predecessor gives the two Fold fibres, \(b=2\).

The charged carrier retains all three positions as one normalized no-loss partition. Its root sum is One. Pairing the two fibres once with the generator-three carrier gives six roles and their unit part
\[
 S_1=1,\qquad S_2=\frac1{bg}=\frac16.
\]
The pair alternatives in the original complete grammar are \(1/g\), \(1/(bg)\) and \(1/g^2\). The first omits the fibres; the third substitutes a colour pair for the required fibre–generator pairing. Only \(1/(bg)\) retains both original roles.

### 2.1. Complete colour support and the leading product

Let \(C_d\) contain every length-\(d\) word over the three colour labels. At depth zero it contains the empty word. Extending each word by each of the three labels yields disjoint successor classes, so
\[
 |C_0|=1,\qquad |C_{d+1}|=3|C_d|,\qquad |C_d|=3^d.
\]
Membership is equivalent to having the required length and using only the three labels. Distinct labels and distinct prior words keep the complete enumeration duplicate-free. `LeptonSupport.colourSupportCount`, `colourSupportComplete` and `colourSupportDistinct` prove these statements for every natural depth.

The original leading product uses the complete fifth colour succession: \(g^g\cdot g\cdot g=3^5\). The two fibre-labelled copies have
\[
 N=2\cdot3^5=486
\]
positions. Their unique positive predecessor \(D\) satisfies \(D+1=N\), hence \(D=485\). Therefore
\[
 P_{\rm lead}=\frac1{485}.
\]
`completeDoubleCount`, `supportReassembly` and `predecessorUnique` connect this number to the actual labelled word enumeration and prove uniqueness of the predecessor.

### 2.2. The complete neighbouring-channel census

The registered channels are the predecessor, generator and successor: \(c\in\{2,3,4\}\). For each, hold one positive channel part from the leading denominator and then take its reciprocal:
\[
 P_c=\frac1{485-1/c}=\frac{c}{485c-1}.
\]
Every held part is positive and smaller than 485. The complete census gives
\[
 P_2=\frac2{969},\qquad P_3=\frac3{1454},\qquad P_4=\frac4{1939}.
\]
The carrier has three generated root positions, so its own channel identity is \(c=g=3\). The binary channel is not that identity; the successor adds a fourth role. The sharpened product is consequently \(P_0=3/1454\). `LeptonInvariants.exactInvariants` returns the exact tuple
\[
 (S_1,S_2,P_{\rm lead},P_0)=\left(1,\frac16,\frac1{485},\frac3{1454}\right).
\]
`uniqueCarrierChannel` connects the selected channel to the independently generated count. The original guards reject every channel outside the declared census.

## 3. The full symmetric expansion and the Koide identity

For three formal positions \(a,b,c\), the factor product has one term for each choice of whether to retain that position's root factor. The eight selections are
\[
 \varnothing,\{c\},\{b\},\{b,c\},\{a\},\{a,c\},\{a,b\},\{a,b,c\}.
\]
Each position has two choices, so every term is present once. The expansion recursion starts from the empty product and, for a new position, retains the earlier terms and appends their products with that position. Grouping by degree gives the complete polynomial identity
\[
 (t-a)(t-b)(t-c)
 =t^3-(a+b+c)t^2+(ab+ac+bc)t-abc.
\]
There are three single terms, three pair terms and one triple term. `LeptonLedger.cubicExpansion` identifies the independent recursive expansion with the exhaustive selection ledger. `ledgerExhaustive`, `ledgerUnique`, `expansionRetainsEarlier` and `expansionAddsProduct` prove complete retention; `appendOnce` preserves uniqueness whenever a generated term is fresh.

Insert \(S_1=1\), \(S_2=1/6\), and the admitted product. This fixes all four cubic coefficients. Squaring the sum and separating the diagonal and pair contributions gives
\[
 S_1^2=(a^2+b^2+c^2)+2S_2,
 \qquad a^2+b^2+c^2=1-\frac13=\frac23.
\]
The normalized mass interpretation then gives \(Q=2/3\) as in Section 1. Native `KoideComparison.sealedInvariant` obtains the sum and pair sum by executing `LeptonInvariants.chargedInvariants`; `exactTwoThirds` proves the result. It does not insert an observed Koide value as an input.

## 4. The electromagnetic input and its generated depths

The terminal correction uses the independently derived fine-structure constant. Its complete construction is summarized here so the input's exact mathematics is explicit [4]. The least complete binary covers of the generator and successor volumes satisfy
\[
 2^4<3^3\le2^5,\qquad 2^6<3^4\le2^7.
\]
Strict increase of binary powers excludes every earlier depth. The down-depth and up-depth are therefore \(d=5\), \(u=7\). The full block record is
\[
 (b,g,d,u,T,B,C)=(2,3,5,7,128,9,250),
\]
where \(T=2^7\), \(B=3^2\), and \(C=2\cdot5^3\).

Promoting one remaining direction at each successor preserves the total of three directions. Its complete states are \((0,3),(1,2),(2,1),(3,0)\), with no successor after the final state. Their products are
\[
 5^3=125,\quad7\cdot5^2=175,\quad7^2\cdot5=245,\quad7^3=343.
\]
The terminal cover retains all the promoted directions through the descending reciprocal chain
\[
\begin{aligned}
 D_*&=250+\frac1{175+1/(245+1/343)},\\
 245+1/343&=84036/343,\\
 175+343/84036&=14706643/84036,\\
 D_*&=3676744786/14706643.
\end{aligned}
\]
The returning One dilates the boundary response by \(1+1/D_*\). Adding the complete tower gives
\[
 \alpha^{-1}=128+9\left(1+\frac1{D_*}\right)
 =\frac{503846395469}{3676744786},
 \qquad \alpha=\frac{3676744786}{503846395469}.
\]
The native `AlphaCovers`, `AlphaBlocks`, `AlphaPromotion` and `AlphaRatio` proofs retain the least-cover conditions, complete stage trace, exact descending operation order and terminal ratio. In particular, depths five and seven and the terminal order are generated outcomes.

## 5. Terminal self-coupling of the product

Attach one electromagnetic factor \(\alpha\) to each root role. The source recursion begins with multiplicative One and appends one factor per retained position; induction on the list of positions yields \(\alpha^n\) for a list of length \(n\). At three positions, the complete coupling is \(\alpha^3\). `LeptonTerminal.coupleEveryRoot` and `threeRootCoupling` prove this connection.

Distribute the action over the complete generator volume \(3^3=27\). Its unswept depth weight is the generated down-depth five. The up-depth seven crosses one further electromagnetic order and one of the three channels, contributing \((7/3)\alpha\). The correction is therefore
\[
 H=\frac{\alpha^3}{27}\left(5+\frac73\alpha\right).
\]
The source retains this correction inside the admitted product by positive take:
\[
 P=P_0-H=\frac3{1454}-H.
\]
The exact arithmetic gives
\[
 H=\frac{376926193013708290190758164816402371555272}
 {5220085816185270244432584276275384668628413983201}.
\]
`exactCorrection` proves this value, `smallerThanAdmitted` proves \(0<H<3/1454\), and `exactTerminal` gives the fraction in Section 1. The common-denominator reassembly is
\[
 \left(3D_H-1454N_H\right)+1454N_H=3D_H,
\]
where \(H=N_H/D_H\). The strictly positive retained numerator supplies the terminal product; adding the held part recovers the original product exactly. `heldCorrectionReassembly` proves this preservation for the admitted positive correction.

Only the triple-product coefficient changes. The normalized sum and pair sum stay fixed, retaining the exact Koide identity. The source classifies this terminal construction as an observational derivation: the initial product's CODATA mismatch motivated it. Its executable inputs are the admitted cubic, the derived electromagnetic ratio, generated counts and cover depths; its admission requires both complete mass-ratio comparisons. Section 8 retains the original initial and terminal outcomes [1,2].

## 6. Exhaustive classifications and closure

The base cubic grammar has ten typed axes. Eight have two constructors and two have three, giving
\[
 2^8\cdot3^2=2304
\]
complete forms. Their preserving choices and excluded alternatives are:

| Axis | Preserving construction | Original alternatives rejected |
|---|---|---|
| Carrier | One complete symmetric three-root carrier | Three unrelated names |
| Generator | Independently generated three | Selected familiar count |
| Partition | Root sum One | Unnormalized free scale |
| Pair | 1/(2×3) | 1/3 and 1/9 |
| Support | Two complete fifth-power supports | Fourth-power truncation |
| Predecessor | Positive predecessor 485 | Unchanged support count 486 |
| Channel | Generator-three channel | Binary and successor channels |
| Sharpening | Hold one channel part | Add a channel whole |
| Root representation | Complete exact invariants | Solve and round roots during admission |
| Extension | No extra rule | Added coefficient or measured selector |

The carrier is the product of these finite types. Every typed tuple belongs to the product enumeration. The original coordinate criteria hold exactly for the all-preserving tuple, proving both existence and uniqueness. `LeptonGrammar.candidatesComplete`, `sourceDecisionMatchesCriteria` and `uniqueSurvivor` retain the arbitrary-candidate statements, source decisions and complete enumeration order. Operational witnesses execute the support, channel and invariant derivations; the grammar records their complete alternatives.

The terminal grammar has ten binary axes and 1,024 forms. They retain the admitted product, one factor per root, complete generator volume, generated down-depth, alpha-transported up-depth, complete channel share, held orientation, measurement-inaccessible executable relation, disclosed observational provenance and no extra term. Altering any coordinate violates its corresponding source requirement. The `TerminalGrammar` proof uses the complete typed product and proves that precisely the preserving tuple survives. Its construction closes by counting all three root attachments, all 27 support cells and both generated depth roles.

The three retained empirical registrations—original Koide, versioned terminal validation and versioned Koide validation—each have eight binary axes and 256 forms. These preserve the exact law, complete source relation, proof provenance, isolated prediction, separate measurement record, all registered rows, one/successor retention and no extra rule. The base keeps the first complete row. Every successor appends a complete row without discarding an earlier value, uncertainty or outcome. The versioned registrations reuse the already established numeric derivations.

## 7. Exact root isolation and source-resolution refinement

The source computes no floating root. At depth \(d\), it generates every dyadic cell
\[
 I_{d,j}=[j/2^d,(j+1)/2^d],\qquad 0\le j<2^d,
\]
evaluates \(f_P\) exactly at both endpoints, and retains sign-changing cells or an exact endpoint root. It starts at depth one and increases the depth until exactly three strictly positive nondegenerate brackets remain. For the actual terminal product, the first accepted depth is seven, with
\[
 I_e=[1/128,1/64],\quad
 I_\mu=[3/16,25/128],\quad
 I_\tau=[101/128,51/64].
\]
These disjoint sign-changing intervals contain three positive roots. A cubic has at most three distinct roots, so the three intervals exhaust them. Native `LeptonIsolation.terminalSearchComplete` gives the exact returned brackets. `terminalNativeRun`, using the inductive `IsolationRun`, retains every earlier unsuccessful depth and the successful original search step.

For a current bracket \([l,u]\), calculate its midpoint \(q=(l+u)/2\). An exact midpoint root becomes the point bracket \([q,q]\). Otherwise retain \([l,q]\) when \(f_P(l)f_P(q)<0\), and \([q,u]\) in the other branch. Each step retains the root through exact sign decisions. `LeptonIntervals` implements all branches, including unchanged exact-point brackets.

For positive numerator bracket \([a,b]\) and denominator bracket \([c,d]\), the squared ratio lies in
\[
 [(a/d)^2,(b/c)^2].
\]
For each measured row the source refines all three root brackets together until this prediction interval is either wholly inside the complete source interval or wholly disjoint from it. This stopping decision uses the complete interval endpoints; no chosen decimal tolerance replaces the source uncertainty. `LeptonRatios.refinementSound` proves that every returned finite evaluation follows the original `RefinementRun` rules.

For the terminal product, the muon–electron comparison stops after 26 refinements and the muon–tau comparison after 14. `LeptonRefinement.muonElectronRun` and `muonTauRun` connect the actual native product, original root isolation and exact stopping endpoints. The retained intervals are
\[
\begin{aligned}
 R_{\mu e}&=\left[
 \frac{2760006749688854416}{13348308265544641},
 \frac{2760006753011508025}{13348308034474884}\right],\\
 R_{\mu\tau}&=\left[
 \frac{164508926409}{2766726569104},
 \frac{164509737604}{2766723242409}\right].
\end{aligned}
\]
The native `muonElectronContained` and `muonTauContained` prove containment against the source intervals. These exact rational endpoints determine the rounded readings in the abstract and Section 1.

## 8. The complete CODATA mass-ratio test

The original registered NIST CODATA 2022 snapshot supplies:

| Quantity | Central value | Standard uncertainty | Complete interval |
|---|---:|---:|---:|
| Muon/electron mass ratio | 206.7682827 | 0.0000046 | [206.7682781, 206.7682873] |
| Muon/tau mass ratio | 0.0594635 | 0.0000040 | [0.0594595, 0.0594675] |

The parser retains exactly one matching full fixed-width row for each quantity. It converts the complete central and uncertainty inscriptions to exact rationals and checks that the uncertainty is positive and smaller than the central value. Their exact bounds are
\[
 S_{\mu e}=\left[\frac{2067682781}{10^7},\frac{2067682873}{10^7}\right],
 \qquad
 S_{\mu\tau}=\left[\frac{118919}{2000000},\frac{23787}{400000}\right].
\]
Cross-multiplication proves \(R_{\mu e}\subset S_{\mu e}\) and \(R_{\mu\tau}\subset S_{\mu\tau}\). `LeptonSource.muonElectronParsed` and `muonTauParsed` connect these exact values to the complete snapshot rows; `LeptonComparison.nativeComparison` assembles the full two-row result and `bothRowsPassed` proves the combined decision.

For completeness, the original unrefined product \(P_0=3/1454\), tested by the same algorithm, returns
\[
\begin{aligned}
 R^{(0)}_{\mu e}&=\left[
 \frac{164507304025}{795691264},
 \frac{164508115216}{795634849}\right],\\
 R^{(0)}_{\mu\tau}&=\left[
 \frac{2570388601}{43230310561},
 \frac{10281757201}{172920410569}\right].
\end{aligned}
\]
Both intervals are disjoint from their corresponding CODATA intervals. The terminal result passes both complete rows. This distinction is part of the original scientific comparison and explains the source's observational classification of the terminal law.

The protected prediction and one-use target custody retain the source seal before comparison. Native `LeptonValidation.terminalConnection` connects the exact numeric record to the full registered validation protocol; disagreement between the numeric decision and the comparison label is rejected. Versioned `TerminalLeptonValidationValidation` reuses this derivation while retaining the original versioned registration, target rows and adverse controls. No failing row is discarded or uncertainty enlarged.

## 9. A separate full-interval Koide comparison

The empirical Koide test is distinct from the exact identity. Let the measured muon/electron and muon/tau intervals be \([A_-,A_+]\) and \([B_-,B_+]\). Positivity gives the tau/electron interval
\[
 [T_-,T_+]=[A_-/B_+,A_+/B_-].
\]
All root operations use outward rational enclosures. For a positive rational \(v=n/d\) and source binary depth \(k=160\), let \(s=2^k\). The integer-square-root seed and exact correction loops determine the unique integer \(h\) with
\[
 h^2d\le ns^2<(h+1)^2d.
\]
It follows that \(h/s\le\sqrt v<(h+1)/s\); if \(h^2d=ns^2\), the source returns the exact point \([h/s,h/s]\). `KoideEnclosure.floorBounds`, `boundsUnique` and `floorUnique` prove these inequalities and uniqueness for arbitrary positive denominators. `upSourceRun` connects the correction loop to its original step relation.

Apply the operation to both endpoints of \(A\) and \(T\), obtaining outward square-root intervals \([a_-,a_+]\) and \([t_-,t_+]\). Then
\[
 N_-=1+A_-+T_-,\quad N_+=1+A_++T_+,
\]
\[
 D_-=(1+a_-+t_-)^2,\quad D_+=(1+a_++t_+)^2,
\]
and the complete source-derived Koide interval is
\[
 Q_{\rm source}\in[N_-/D_+,N_+/D_-].
\]
The resulting exact rational endpoints, retained in the accompanying arithmetic record, have decimal readings
\[
 [0.66658265955384626148\ldots,\ 0.66673848847304794479\ldots].
\]
They enclose the sealed value \(2/3\). `KoideComparison.sourceAssembly` proves composition from the two parsed rows, and `nativeSourceAssembly` instantiates it with the registered snapshot. The numeric precheck precedes the complete blind-validation protocol; a failed precheck stops delegation. Both original and versioned Koide registrations retain this numeric result, both complete target rows and their adverse controls.

### 9.1. Central-value residual

The two central values give exact positive ratios
\[
 A_0=\frac{2067682827}{10000000},\qquad
 B_0=\frac{118927}{2000000},\qquad
 T_0=\frac{A_0}{B_0}=\frac{2067682827}{594635}.
\]
The central-value comparison is
\[
 Q_0=\frac{1+A_0+T_0}{(1+\sqrt{A_0}+\sqrt{T_0})^2}.
\]
Apply the original 160-bit positive square-root enclosure separately to \(A_0\) and \(T_0\). If their returned bounds are \([a_-,a_+]\) and \([t_-,t_+]\), positivity gives the exact outward interval
\[
 \frac{1+A_0+T_0}{(1+a_++t_+)^2}
 \le Q_0\le
 \frac{1+A_0+T_0}{(1+a_-+t_-)^2}.
\]
Its width is below \(10^{-45}\); both endpoints round to the same displayed digits:
\[
\begin{aligned}
 Q_0&\simeq0.66666056927693233980,\\
 Q_0-\frac23&\simeq-0.000006097389734326867903,\\
 \frac{Q_0-2/3}{2/3}&\simeq-9.146084601490302\times10^{-6}.
\end{aligned}
\]
Thus the source central values lie approximately 9.146 parts per million below the exact invariant. The signed residual is a central-value comparison. The full-uncertainty test above propagates both complete source intervals and contains \(2/3\). The accompanying arithmetic record retains the exact rational outward endpoints for both calculations, and the reproduction script evaluates them using the original enclosure operation.

## 10. Native verification and reproducibility

All original code and claim documents are pinned to V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The native files are taken from the published V4 edition 0.4 source commit `21cdf559922fb057f8560f42d056ffa035329eb3` [3].

| Component | Native proof families | Retained completion receipt |
|---|---|---|
| Support, channels and full symmetric cubic | `LeptonTake`, `LeptonSupport`, `LeptonInvariants`, `LeptonLedger`, `LeptonGrammar` | TURN_273 |
| Terminal coupling and full two-row comparison | `LeptonTerminal`, `TerminalGrammar`, `LeptonIsolation`, `LeptonRefinement`, `LeptonComparison`, `LeptonValidation` | TURN_278 |
| Exact Koide invariant and source enclosure | `KoideEnclosure`, `KoideComparison`, `KoideIntervalExternal` | TURN_856 |
| Versioned terminal validation | `TerminalLeptonValidation` families | TURN_1040 |
| Versioned Koide validation | `KoideValidationV2` families | TURN_1041 |

The retained evidence includes applicable successful native builds, axiom audits, exact program/candidate comparisons, full source-output checks and independent adverse controls. The named native results retain zero axiom dependencies. The terminal evidence includes 2,812 arithmetic/polynomial/bisection comparisons, 575 ratio/index/refinement comparisons, 799 decimal cases and eight row guards, with the complete original empirical receipt preserved. The later versioned entries reuse the established derivations rather than counting them as new mathematics.

The accompanying source archive contains the native proof modules and imports, original pinned source and claim documents, registered NIST snapshot, completion/audit records and exact manuscript arithmetic. Re-evaluation of the original rational functions reproduces the native terminal endpoints and the complete Koide interval. The scientific source and proof files are unchanged for this exposition.

## 11. Conclusion

Complete generated support fixes the charged-lepton symmetric carrier. The normalized root sum and fibre–generator pair sum yield the exact Koide invariant, while the complete product support and channel identity fix the initial cubic. The terminal electromagnetic coupling preserves those two invariants and refines the product through all three root roles, the complete 27-cell carrier and both generated depths. Its exact rational root consequences pass both original complete CODATA mass-ratio intervals. The independent outward Koide comparison also contains the sealed value two-thirds.

## References

[1] Maria Smith. Original pinned V3 charged-lepton derivation: [prior_value_laws.py](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/prior_value_laws.py), [terminal_lepton_law.py](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/terminal_lepton_law.py), and original claim derivation documents supplied in the source archive.

[2] Maria Smith. Original pinned V3 [charged_lepton_validation.py](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/charged_lepton_validation.py): full initial and terminal mass-ratio comparisons, outward Koide enclosure and registered source protocol.

[3] Maria Smith. *Smithian Fold Theory: Zero-Axiom, Zero-Free-Parameter Derivations from First Principles — Lean 4 Formal Verification*, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Native sources: [LeptonInvariants](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/LeptonInvariants.lean), [LeptonTerminal](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/LeptonTerminal.lean), [KoideComparison](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/KoideComparison.lean).

[4] Maria Smith. *The fine-structure constant from first principles: an exact zero-parameter Fold derivation*. [doi:10.5281/zenodo.24324400](https://doi.org/10.5281/zenodo.24324400).

[5] Maria Smith. Operational foundation, [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656); *Smithian Fold to Physics*, version 1.4, [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655); *Smithian Fold Theory*, original V3 cumulative monograph, recorded version 0.4, [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[6] NIST. *2022 CODATA recommended values of the fundamental physical constants*. [Complete fixed-width table](https://physics.nist.gov/cuu/Constants/Table/allascii.txt). This paper uses the original pinned 40,801-byte snapshot with SHA-256 `77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67` and retains both full registered mass-ratio rows.

[7] Maria Smith. *Independent Lean 4 Verification of the Complete Smithian Fold Theory Model*, version 1.0.1. [doi:10.5281/zenodo.21761665](https://doi.org/10.5281/zenodo.21761665).

**Authorship.** Maria Smith originated SFT and its derivations and directs the scientific work. AI assistance supports source-bound manuscript preparation, native translation and verification.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

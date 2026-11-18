# The fine-structure constant from first principles: an exact zero-parameter Fold derivation

**Maria Smith** · Ernos Labs  
Standalone paper 1 · Version 1.0 · 17 November 2026  
DOI: [10.5281/zenodo.24324400](https://doi.org/10.5281/zenodo.24324400)

## Abstract

Smithian Fold Theory derives the terminal inverse fine-structure ratio \(\alpha^{-1}=503846395469/3676744786\), or 137.035999177180855…, without a measured constant, fitted coefficient or adjustable truncation. The first-return construction fixes generator three. Complete binary support independently fixes cover depths five and seven. The resulting tower 128, boundary 9 and complete cover 250 retain their distinct structural roles. Promoting each of three interchangeable directions exactly once generates the four-rung ladder 125, 175, 245, 343; exhaustion fixes the terminal order. Its backward reciprocal assembly gives the displayed exact ratio. The complete ten-axis construction grammar contains 1,024 forms and has one preserving survivor. Native Lean 4 proofs establish the general least-cover result, complete promotion trace, exact admissible order domain and terminal rational equality with zero axiom dependencies. The independently registered CODATA 2022 comparison retains both endpoints of 137.035999177 ± 0.000000021. Exact cross-products place the sealed ratio inside that interval, with a central displacement of approximately 0.008612 stated standard uncertainties. This paper develops the foundation, coefficient construction, exhaustive classification, terminal closure and measurement comparison explicitly.

**Keywords:** fine-structure constant; inverse alpha; first-principles derivation; Smithian Fold Theory; zero free parameters; Lean 4; CODATA 2022; exact rational arithmetic; finite continued fraction.

## 1. The exact result

The terminal construction is
\[
\begin{aligned}
 D_4&=250+\cfrac{1}{175+\cfrac{1}{245+\cfrac{1}{343}}},\\
 \alpha^{-1}&=128+9\frac{D_4+1}{D_4}
 =\frac{503846395469}{3676744786},\\
 \alpha&=\frac{3676744786}{503846395469}.
\end{aligned}
\]
The integers in this expression are generated objects. Depth five is the least binary cover of \(3^3\); depth seven is the least binary cover of \(3^4\). The tower is \(2^7\), the boundary is \(3^2\), and the initial complete cover is \(2\cdot5^3\). The three factors of the cover are promoted one at a time from five to seven. No direction remains after the third promotion. This supplies the exact terminal order before any measured interval is opened.

The native theorem `SFT.Physics.AlphaRatio.terminalRatio` states

`outputPair (inverseFineStructure none) = .ok (503846395469,3676744786)`.

The default operation computes the length of the generated ladder; it does not accept a desired accuracy or a measured target. `automaticTerminal` proves that this operation equals the explicitly named fourth order. The derivation and the original post-seal comparison are separate completed V3 entries, preserved in V4 [1–3].

## 2. Operational foundation and the least Fold generator

### 2.1. Presentation, One and half-One

The operational root partitions every challenge into presented occurrence and unpresented absence. In the original record schema, a record consists of an identifier, presentation flag and descriptive form. The two strings do not affect presentation. Exhausting the Boolean flag gives the two classes; only the presented class supplies an occurrence at the proof boundary. A presented denial is itself such an occurrence. Unpresented absence supplies no counterexample. This complete partition establishes the source root without a premise about the internal wording of the challenge [4].

Structural One retains the complete presented occurrence with no unforced addition. Counts retain repeated complete occurrences; exact parts retain their relation to the held whole. On the normalized positive part carrier, equal complementary parts satisfy
\[
 h+h=1,\qquad h=\frac12.
\]
This fixes the half-One boundary. The Fold operation pairs a part with the two fibre roles and casts out a completed whole when appropriate, retaining the positive representative through One:
\[
 F(x)=\begin{cases}
 2x,&0<x\le1/2,\\
 2x-1,&1/2<x\le1.
 \end{cases}
\]
The value One is retained at exact closure, so \(F(1/2)=F(1)=1\). All proof values in this construction are exact positive parts or ratios. The host counters used to enumerate absent or remaining roles do not introduce extra scientific scalar states.

### 2.2. Uniqueness over all finite primitive words

The source primitive grammar contains identity \(I\), square \(S\), constant One \(K\), and Fold \(F\), acting on reduced positive exact parts through One. Finite words compose these operations in source order. The generating predicate requires noninjectivity and a nonstatic finite recurrence.

Identity is injective. Squaring is injective on positive parts: if \(x<y\), then \(x^2<xy<y^2\), so equal squares force equal inputs. Constant One has only the fixed image One and cannot supply a nonstatic return. Fold is noninjective because half-One and One share an image. It also has the exact nonstatic recurrence
\[
 \frac13\xrightarrow{F}\frac23\xrightarrow{F}\frac13.
\]
Thus \([F]\) is a generating word of length one. Let \(w\) be any least nonempty generating word. Comparison with \([F]\) gives \(|w|\le1\), while nonemptiness gives \(1\le|w|\). Hence \(|w|=1\), and the four singleton cases force \(w=[F]\). Conversely \([F]\) generates and no nonempty word has smaller length. Therefore
\[
 w\text{ is a least nonempty generating word}\quad\Longleftrightarrow\quad w=[F].
\]
Every longer word is excluded by the already exhibited singleton; appending another primitive preserves that exclusion. The native `PrimitiveMaps.leastGeneratorIff` and its successor theorem quantify over all finite words [4].

### 2.3. Binary return and generator three

Complete binary extension produces \(2^d\) held words at depth \(d\). The source unit part takes the positive predecessor of this support:
\[
 u_d=\frac1{2^d-1}.
\]
At depths two and three, exact execution gives
\[
\begin{aligned}
 u_2=\frac13&\longmapsto\frac23\longmapsto\frac13,\\
 u_3=\frac17&\longmapsto\frac27\longmapsto\frac47\longmapsto\frac17.
\end{aligned}
\]
Each intermediate part differs from its source, establishing first return rather than merely eventual recurrence. The first trace has length two. The least larger positive count is three, and the second trace realizes it. Every count greater than two is at least three; every count greater than three has this exhibited return before it. The unique least distinct successor generator is therefore \(g=3\). Its positive predecessor supplies \(b=2\).

The native first-return operation tests return before a previously visited state and otherwise advances with the enlarged visited record. A finite exact carrier bounds possible states; the proof returns the corresponding source execution trace. `GeneratorThreeDerivation.generatorThree` combines the two first returns with least-successor minimality; `FoldFirstReturn.generatorPeriodThree` evaluates the original operation.

## 3. Independent direction and boundary counts

The original spatial construction retains two disjoint fibre roles and their complete ordered pair-cell support. There are \(2\cdot2=4\) such pairs. A distinct return requires the independent-direction count to exceed the two fibre roles. Retaining a restoring remainder before complete pair-cell saturation requires it to remain below four. Thus the original stability conditions are
\[
 2<n<4,\qquad n\text{ a positive whole count}.
\]
Positive succession exhausts the interval and leaves only \(n=3\). The lower endpoint identifies the return with a fibre role; the upper endpoint exhausts the restoring remainder. The independently obtained recurrence generator also equals three. The source cross-lock requires agreement of these two constructions.

The native enumeration theorem is general: for any binary count \(b\), membership in `stableCounts b` is equivalent to \(b<n<b^2\). Its specialization to the two Fold fibres yields the singleton \([3]\), and `SpatialStability.completeSpatialDerivation` joins this census to the recurrence result.

To construct a boundary, take an independent three-direction carrier and hold one source-normal direction. Retain every other direction exactly once. If the normal occurs between lists \(L\) and \(R\), the spatial carrier is \(L\mathbin{++}[\nu]\mathbin{++}R\), while its boundary carrier is \(L\mathbin{++}R\). Distinctness excludes the normal from the remainder. Cardinalities obey
\[
 |L\mathbin{++}R|+1=3,
\]
so the retained boundary rank is uniquely two, independently of the normal's position. `BoundarySupport.allNonnormalRetained`, `normalReassembles` and `retainedRankTwo` prove these statements for every such carrier. A generator-three label on each of the two retained directions gives the complete boundary product \(3\cdot3=9\).

## 4. Complete binary support and least covers

Let \(W_d\) be the complete binary word support after \(d\) extensions. The base support is the one empty word. A successor attaches each of the two distinct fibre labels to every earlier word. The two label classes are disjoint, and each preserves earlier word identity. Hence
\[
 |W_0|=1,\qquad |W_{d+1}|=2|W_d|,\qquad |W_d|=2^d
\]
by induction. This is the exact generated support count, not a numerical replacement for the enumeration.

For a positive exact carrier \(C\), the original least-cover loop starts at depth one and support two. While support is less than \(C\), it doubles the support and increases depth by one. The invariant is support \(=2^{\mathrm{depth}}\). Every continued depth is therefore too small; the stopping depth covers \(C\). Consequently the returned \(d(C)\) satisfies
\[
 0<d(C),\qquad C\le2^{d(C)},\qquad
 0<k<d(C)\Longrightarrow2^k<C.
\]
For termination, positive support obeys \(s+1\le2s\). A carrier-derived remaining-step bound therefore decreases with each doubling while preserving enough support to reach the carrier. At its exhaustion, coverage already holds. The native implementation cannot truncate an uncovered source carrier. `AlphaCovers.coverDepthRun` supplies the source trace; `leastPositiveCover` proves the displayed conditions; `leastCompleteSupport` replaces each power by the cardinality of the actual Fold-word enumeration.

Apply this operation independently to generator volume and successor volume:
\[
 g^g=3^3=27,\qquad g^{g+1}=3^4=81.
\]
The exact inequalities are
\[
 2^4=16<27\le32=2^5,\qquad
 2^6=64<81\le128=2^7.
\]
Strict growth of positive binary powers excludes all earlier depths. Thus the down-depth is \(d=5\) and the up-depth is \(u=7\). The source then independently checks
\[
 d=b+g=2+3=5,\qquad u=g+(g+1)=3+4=7.
\]
These are cross-locks on the computed cover results, not assignments replacing the cover search.

The seven-field block record is
\[
 (b,g,d,u,T,B,C_0)=(2,3,5,7,128,9,250),
\]
where
\[
 T=b^u=128,\qquad B=g^2=9,\qquad C_0=b\,d^g=250.
\]
`AlphaBlocks.nativeBlockDerivation` retains the block equality together with universal exclusion of every earlier positive cover depth.

## 5. The complete promotion object

There are three interchangeable cover directions. A stage records the number promoted \(p\) and number remaining \(r\). Begin at \((0,3)\). When \(r>0\), the unique source successor promotes one remaining direction:
\[
 (p,r+1)\longmapsto(p+1,r).
\]
The sum is invariant, since \((p+1)+r=p+(r+1)\), and the remaining count strictly decreases. Induction produces
\[
 (0,3),\ (1,2),\ (2,1),\ (3,0).
\]
Every possible remaining count from three down to none occurs. Distinct remaining counts prevent duplicate stages. At \((3,0)\), `nextStage` returns no successor. Thus there are four rungs and no freely selected stopping index.

At stage \(p\), multiply one up-depth factor for each promoted direction and one down-depth factor for each remaining direction. When a group is absent, the source supplies multiplicative One. It does not invoke a positive-power operation at exponent zero. The complete products are
\[
\begin{array}{c|c|c}
(p,r)&\text{generated product}&\text{rung}\\\hline
(0,3)&5\cdot5\cdot5&125\\
(1,2)&7\cdot5\cdot5&175\\
(2,1)&7\cdot7\cdot5&245\\
(3,0)&7\cdot7\cdot7&343
\end{array}
\]
`stageConservation`, `allRemainingStages` and `stagesUnique` establish preservation, completeness and absence of duplicates. `nativeStages` identifies the actual rung evaluator with execution over this complete stage trace. `completeNativeLadder` combines the exact four products with the terminal no-successor result.

## 6. Typed assembly and all four exact orders

The source assigns distinct roles to tower, boundary, complete cover and returning One. The tower carries complete binary reach. The boundary carries generator support over the two retained directions. The returning One is distributed over the effective cover \(D\), giving the dimensionless return share \(1/D\). It dilates the boundary response by \(1+1/D\); the complete response joins the tower as
\[
 A(D)=T+B\left(1+\frac1D\right)=128+9\frac{D+1}D.
\]
This retains the source's typed composition: the return acts on the boundary carrier it traverses. The return is One, not an adjustable coefficient.

The leading rung supplies \(C_0=2\cdot125=250\). For an admitted order \(k>1\), initialize a chain with rung \(k\) and traverse the intervening promoted rungs backward, replacing the chain by the current rung plus its reciprocal. Add the reciprocal of the completed chain to \(C_0\). With \(r_1=125,r_2=175,r_3=245,r_4=343\), the four covers are
\[
\begin{aligned}
 D_1&=250,\\
 D_2&=250+1/175=43751/175,\\
 D_3&=250+\frac1{175+1/245}=10719245/42876,\\
 D_4&=250+\frac1{175+1/(245+1/343)}.
\end{aligned}
\]
Every rung and every intermediate chain is positive, so every reciprocal is defined. The native `ChainSteps` relation records the exact descending order of operations; `nativeChain` proves the actual evaluator follows it for every finite step count.

At the terminal order, the intermediate exact fractions are
\[
\begin{aligned}
 245+\frac1{343}&=\frac{84036}{343},\\
 175+\frac{343}{84036}&=\frac{14706643}{84036},\\
 D_4=250+\frac{84036}{14706643}
 &=\frac{3676744786}{14706643}.
\end{aligned}
\]
Substituting the result into the typed assembly gives
\[
\begin{aligned}
 A(D_4)
 &=\frac{128(3676744786)+9(3676744786+14706643)}{3676744786}\\
 &=\frac{503846395469}{3676744786}.
\end{aligned}
\]
All four original readings are retained:

| Order | Effective cover | Inverse fine-structure reading |
|---:|---:|---:|
| 1 | 250 | 34259/250 |
| 2 | 43751/175 | 5995462/43751 |
| 3 | 10719245/42876 | 1468922449/10719245 |
| 4 | 3676744786/14706643 | 503846395469/3676744786 |

Order is an index into the complete generated object. The source rejects Boolean inputs, nonpositive integers and integers above four. `AlphaDomain.exactOrderDomain` proves success exactly for the integers one through four, including every later integer through the universal `aboveFourRejected` theorem. The omitted-order operation uses the full ladder length and therefore returns the fourth reading.

## 7. Exhaustive construction and uniqueness

The original construction carrier is the Cartesian product of ten binary axes. It contains \(2^{10}=1024\) typed forms. The following table states each axis and the actual structural reason for its surviving choice.

| Axis | Preserving construction and its derivation |
|---|---|
| Cover | Least complete binary covers, obtained by the exhaustive support loop of Section 4 |
| Depth | Agreement with the independently generated sums \(2+3\) and \(3+4\) |
| Tower | Complete binary reach at the up-depth: \(2^7\) |
| Boundary | Generator support at the retained boundary rank: \(3^2\) |
| Return | The returning One distributed over the complete cover |
| Join | Tower plus the boundary dilated by that return |
| Promotion | Exactly one remaining interchangeable direction per successor |
| Termination | Exhaust all three directions, leaving no successor |
| Target custody | Seal the ratio and complete construction census before measurement |
| Extension | Preserve the complete generated object without an added scale rule |

Each axis also contains its original opposed form: asserted depths, a single unchecked route, a free leading whole, a free boundary factor, a fitted correction, untyped arithmetic permutation, a selected refinement series, fit-selected truncation, target-visible derivation, or an extra scale rule. Acceptance is the conjunction of the ten preserving choices. Thus every accepted tuple equals the unique all-preserving tuple, and that tuple is accepted.

The product generator enumerates both constructors of each coordinate. Successive product membership proves that every typed candidate appears; no name search or sampled classification stands in for completeness. `AlphaGrammar.candidatesComplete` proves this for arbitrary candidates. `sourceDecisionMatchesCriteria` identifies the actual source decision with the structural conjunction, and `acceptanceIffExactCriteria` and `uniqueSurvivor` prove the two directions of acceptance and uniqueness.

No coordinate is an adjustable parameter. The earlier sections derive the preserving values and operations. The exhaustive product then rules out changing a role, substituting a fitted coefficient, withholding a required promotion, or adding another scale. The three operational witnesses execute the block derivation, complete ladder and first/terminal readings. The four original controls retain false-premise, source-tampering, artifact-tampering and boundary checks. Complete native program comparisons preserve all 1,024 candidate identities, decisions, reasons, closure fields and evidence hashes.

## 8. Exact CODATA 2022 comparison

The original empirical entry uses the complete registered NIST CODATA 2022 table snapshot. It identifies exactly one fixed-width row named “inverse fine-structure constant,” reads the full central-value and uncertainty columns, and converts their decimal inscriptions to exact fractions. The central value and stated standard uncertainty are
\[
 c=137.035999177,\qquad \sigma=0.000000021.
\]
The complete interval is
\[
 [c-\sigma,c+\sigma]
 =\left[\frac{137035999156}{10^9},\frac{137035999198}{10^9}\right].
\]
Let \(P=503846395469\) and \(Q=3676744786\). Both membership inequalities are established by positive integer differences:
\[
\begin{aligned}
 10^9P-137035999156Q&=77876599384>0,\\
 137035999198Q-10^9P&=76546681628>0.
\end{aligned}
\]
Therefore the independently sealed ratio lies strictly inside the stated uncertainty interval. Its decimal value and central displacement are
\[
\begin{aligned}
 P/Q&=137.03599917718085532630167167659\ldots,\\
 P/Q-c&\approx1.8085532630\times10^{-10},\\
 (P/Q-c)/\sigma&\approx0.0086121584.
\end{aligned}
\]
The interval test itself uses exact fractions, not these decimal illustrations. The central value is retained as a separate datum; neither endpoint is omitted or selected after comparing the prediction.

The empirical construction has its own eight-axis product and 256 forms. Its eight coordinates retain the complete Fold carrier, the sealed-ratio/full-interval relation, source-bound proof trace, capability-closed prediction, separate measurement record, complete registered rows, one-successor closure and no extra rule. Each coordinate has exactly its admitted and rejected constructor, so their complete product contains 256 candidates. Acceptance is equivalent to the all-admitted tuple. The successor rule appends each further registered authoritative row and checks it without removing or reweighting earlier rows; the present registration contains exactly the one CODATA row. The unique accepted comparison uses the full reported interval. The source file contains 40,801 bytes, identity-bound by SHA-256 `77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67`.

The actual alpha-specific wrapper parses and checks the ratio before delegating those same UTF-8 bytes to the blind source/custody validator. Missing or repeated matching rows are rejected. An uncertainty that fails to retain a positive interval is rejected. A failed ratio precheck prevents delegation. Changed source bytes and the original tampered adverse comparison remain tested. `AlphaInterval.registeredInterval`, `exactIntervalPassed` and `registeredPasses` prove the native registered result; `AlphaIntervalExternal.invalidRecordRejected` and `acceptedRecordDelegates` preserve the wrapper's original execution order. The complete native empirical report matches the original validation fields and hashes [2,3,6].

## 9. Native proof correspondence and retained verification

Original V3 sources are pinned at commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Native V4 sources are taken from the published edition 0.4 scientific commit `21cdf559922fb057f8560f42d056ffa035329eb3`. The two completion receipts are `TURN_271_ALPHA_COMPLETION` and `TURN_650_ALPHA_INTERVAL_COMPLETION`.

| Source operation or mathematical statement | Native Lean declaration |
|---|---|
| First-return construction and least distinct successor | `GeneratorThreeDerivation.generatorThree`; `FoldFirstReturn.generatorPeriodThree` |
| Complete stability census and independent cross-lock | `SpatialStability.completeSpatialDerivation` |
| Retain every nonnormal direction and recover rank two | `BoundarySupport.completeBoundaryRank` |
| Exact positive powers and general least cover | `AlphaCovers.positivePowerValue`, `leastPositiveCover`, `leastCompleteSupport` |
| Forced typed block record | `AlphaBlocks.nativeBlockDerivation` |
| Complete stages, terminal closure and actual rung execution | `AlphaPromotion.allRemainingStages`, `terminalHasNoSuccessor`, `nativeStages`, `completeNativeLadder` |
| Distinct stages and exact input domain | `AlphaDomain.stagesUnique`, `exactOrderDomain` |
| Source-order reciprocal assembly | `AlphaRatio.nativeChain` |
| Leading and terminal exact ratios | `AlphaRatio.leadingRatio`, `terminalRatio`, `automaticTerminal` |
| Exhaustive grammar and unique preserving form | `AlphaGrammar.candidatesComplete`, `acceptanceIffExactCriteria`, `uniqueSurvivor` |
| Exact registered target interval and comparison | `AlphaInterval.registeredInterval`, `exactIntervalPassed` |
| Original empirical wrapper order | `AlphaIntervalExternal.invalidRecordRejected`, `acceptedRecordDelegates` |

These names are in `SFT.Physics` except the foundational finite-word results identified in Section 2. The retained alpha audit lists 156 declarations with no axiom dependencies. The separate empirical-entry receipt lists 136 audited declarations with empty axiom dependencies. These are declaration counts for the two specified collections, not counts of additional completed source entries.

The source correspondence also retains 1,420 exact power, cover and guard comparisons, 47 exact rational/output/guard comparisons, the 1,024-form formal program comparison and the 256-form empirical program comparison. Successful builds, native execution and independent controls are recorded in the cited receipts. The accompanying source/evidence archive contains the relevant proof and source records; it reuses the verified scientific implementation.

## 10. Result and closure

The chain is complete: operational occurrence and exact parts generate Fold; first returns fix the least distinct generator three; stability and normal retention fix the spatial and boundary counts; complete binary support forces depths five and seven; those depths generate the tower, boundary and cover; three one-direction promotions exhaust the finite object; exact backward reciprocal assembly yields \(503846395469/3676744786\). The complete construction grammar has one preserving survivor. The sealed ratio then passes the full CODATA 2022 interval comparison. No measured digit, fitted coefficient or adjustable terminal order enters the derivation.

## References

[1] Maria Smith. *Terminal exact inverse fine-structure Fold ratio*, original V3 claim `SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001`. [Derivation](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/claims/SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001/WHY_DERIVATION_CHECK.md); [exact atomic-constant operations](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/atomic_constants.py); [structural predecessor construction](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/structural_constants.py).

[2] Maria Smith. *Post-seal CODATA check of the terminal inverse fine-structure ratio*, original V3 claim `SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001`. [Source parser and complete comparison](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/atomic_constants_validation.py).

[3] Maria Smith. *Smithian Fold Theory: Zero-Axiom, Zero-Free-Parameter Derivations from First Principles - Lean 4 Formal Verification*. Edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). [Exact ratio proof](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/AlphaRatio.lean); [formal-entry receipt](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/verification/TURN_271_ALPHA_COMPLETION.json); [empirical-entry receipt](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/verification/TURN_650_ALPHA_INTERVAL_COMPLETION.json).

[4] Maria Smith. *From Nothing to Fold: A Premise-Free, Parameter-Free and Machine-Closed Foundation for Smithian Fold Theory*. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656). Native all-finite-word proof: [PrimitiveMinimality](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Foundation/PrimitiveMinimality.lean).

[5] Maria Smith. *From Fold to Physics*, version 1.4.1. [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655). *Smithian Fold Theory*, original V3 cumulative monograph, recorded version 0.4.0. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[6] National Institute of Standards and Technology. *CODATA 2022 recommended values of the fundamental physical constants*, complete ASCII table. [NIST source](https://physics.nist.gov/cuu/Constants/Table/allascii.txt). [Exact V3-registered snapshot](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt).

[7] Maria Smith. *Independent Lean 4 Verification of the Complete Smithian Fold Theory Model*, version 1.0.1. [doi:10.5281/zenodo.21761665](https://doi.org/10.5281/zenodo.21761665).

**Authorship.** Maria Smith originated SFT and its derivations and directs the scientific work. AI assistance supports source-bound manuscript preparation, native translation and verification.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

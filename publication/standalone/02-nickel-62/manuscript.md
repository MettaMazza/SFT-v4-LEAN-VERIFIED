# Nickel-62 from first principles: a zero-parameter nuclear binding maximum in Smithian Fold Theory

**Maria Smith** · Ernos Labs  
Standalone paper 2 · Version 1.0 · 17 November 2026  
DOI: [10.5281/zenodo.24324193](https://doi.org/10.5281/zenodo.24324193)

## Abstract

Smithian Fold Theory derives the unique nuclear binding maximum at 28 protons and 34 neutrons, identifying nickel-62 without using a nuclide name, measured binding energy or fitted coefficient in the calculation. The surface share is 1/5; asymmetry and pairing each carry the two-boundary residual share 1/4; electromagnetic opposition carries the independently generated exact fine-structure ratio. Concavity reduces each complete proton census to its possible integer and parity maximizers. Across all 4,094 masses below the generated cutoff 4,096, this produces 25,303 candidates. Exact rational enclosures separate (A,Z,N)=(62,28,34) from every rival; two charge partitions close the unbounded mass tail. Native Lean 4 proofs reproduce the complete certificate, with zero axiom dependencies across 12,545 audited declarations for this entry. After the prediction is sealed, the complete AME2020 comparison independently identifies nickel-62 as the maximum among 2,548 accepted positive composite rows. Its lower reported uncertainty endpoint exceeds every rival upper endpoint by at least 2.2897 keV per nucleon. The paper presents the coefficient construction, exhaustive grammar, finite certificate, tail argument and measured comparison explicitly.

**Keywords:** nickel-62; nuclear binding energy per nucleon; nuclear stability; parameter-free derivation; Smithian Fold Theory; Lean 4; exact rational arithmetic; AME2020.

## 1. The result

For every positive proton/neutron composition, let the mass count be \(A\), charge count \(Z\), and neutron count \(N=A-Z\), with
\[
 A\in\mathbb N,\qquad A>1,\qquad 1\le Z<A.
\]
The SFT construction assigns one normalized saturated bulk support, its generated surface deficit, electromagnetic opposition along ordered distinct charge paths, and the residual asymmetry and parity contributions. The unique maximizing composition is
\[
 (A,Z,N)=(62,28,34).
\]
Its exact separation certificate is
\[
\begin{aligned}
 L_*&=\frac{9080439588063887159}{9809818781286064340},\\
 U_*&=\frac{1515016807116167539}{1636583784834496420},\\
 U_{\rm rival}&=\frac{7773977012907656069}{8398424104442482780},\\
 U_{\rm rival}&<L_*\le U_*.
\end{aligned}
\]
Here the rival endpoint is the largest upper endpoint over all other retained coordinates, not the score of a selected neighboring isotope. Every possible maximizer below 4,096 is represented, and every mass at or beyond 4,096 is excluded by the tail argument in Section 6. Thus neither a finite isotope window nor a rounded numerical coincidence determines the result.

The construction is the original V3 nuclear-binding successor [1,2], translated into native Lean in V4 [3]. The theorem `SFT.Physics.NuclearBindingPeakClosure.completePeak` evaluates the original operations to the full eleven-field certificate. Its proof composes the complete candidate census, all four refinement stages and the terminal assembly. Sections 2–7 give the mathematics underlying that computation; Section 8 identifies the corresponding proof declarations.

## 2. Generated coefficients

### 2.1. Binary support and generator three

SFT begins with operational presentation: a presented statement or challenge is an occurrence; unpresented absence supplies no counterexample. Complete retention with no unforced addition selects structural One. The normalized primitive carrier consists of positive exact parts through One. Equal complementary parts satisfy \(h+h=1\), fixing \(h=1/2\). Fold doubles a part and retains its positive representative through One:
\[
 F(x)=\begin{cases}2x,&0<x\le1/2,\\2x-1,&1/2<x\le1.\end{cases}
\]
The source primitive grammar is identity, square, constant One and Fold, together with all their finite words. A generating word must be noninjective and have a nonstatic finite recurrence. Identity and square are injective; constant One has only its fixed image. Fold is noninjective because \(F(1/2)=F(1)=1\), and it has the recurrence
\[
 \frac13\longmapsto\frac23\longmapsto\frac13.
\]
Consequently Fold is the unique generating singleton. Since this singleton already generates, a least nonempty generating word has length at most one and at least one. Every longer word is excluded from least size. This gives the all-finite-word result, rather than a truncation to a short sample of words [4].

On the source unit-part construction \(1/(2^d-1)\), depth two gives the two-step orbit above. The least larger positive count is three, and depth three realizes it:
\[
 \frac17\longmapsto\frac27\longmapsto\frac47\longmapsto\frac17.
\]
The intermediate parts differ from the initial part, so both displayed returns are first returns. Every count greater than two is at least three; every count greater than three has the exhibited count three before it. Thus the construction fixes binary count \(b=2\) and least distinct successor generator \(g=3\). Native first-return traces preserve the actual stop, repeat and advance branches of the V3 loop.

### 2.2. Surface and electromagnetic shares

The least binary covers of \(g^g=27\) and \(g^{g+1}=81\) have depths \(d=5\) and \(u=7\):
\[
 2^4<27\le2^5,\qquad 2^6<81\le2^7.
\]
Strict increase of positive binary powers excludes every earlier depth. The interface cross-lock is \(d=b+g=5\). One missing boundary act shared over this interface fixes the surface share
\[
 s=\frac1{b+g}=\frac15.
\]
The electromagnetic coefficient uses the independently constructed terminal fine-structure ratio. The three-direction promotion ladder replaces each down-depth factor once by its up-depth factor:
\[
 5^3=125,\quad7\cdot5^2=175,\quad7^2\cdot5=245,\quad7^3=343.
\]
After the third promotion no down-direction remains, fixing the terminal order. The generated tower, boundary and cover are \(2^7=128\), \(3^2=9\) and \(2\cdot5^3=250\). Backward reciprocal assembly gives
\[
\begin{aligned}
 245+1/343&=84036/343,\\
 175+343/84036&=14706643/84036,\\
 D&=250+84036/14706643=3676744786/14706643,\\
 \alpha^{-1}&=128+9(D+1)/D=503846395469/3676744786,\\
 \alpha&=3676744786/503846395469.
\end{aligned}
\]
Every denominator is positive. The cover inequalities, promotion exhaustion and rational assembly determine this coefficient before the nuclear calculation or the measured comparison [3,5].

### 2.3. Residual asymmetry and pairing

A complete colour-three neutral composite closes its leading colour label internally. The first retained exchange between two such boundaries includes one half-One act from each boundary. Their product is
\[
 q=\frac12\frac12=\frac14,\qquad F(1/4)=1/2,\qquad F(1/2)=1.
\]
Finite boundary capacity and finite positive reciprocal mediator range give the source locality and saturation construction. One completed interior word retains one normalized bulk support. Both unmatched-label pair support and pairing inherit this same residual order, hence \(a=p=q=1/4\). There is no separate coefficient selection for either term. These are the original `residual_boundary_support` and nuclear ledger operations [1,2].

## 3. The complete nuclear ledger

Every charge has \(Z-1\) distinct target charges. Counting ordered source-to-target paths gives \(Z(Z-1)\), with no half factor. The unmatched label count is \(U=|N-Z|=|A-2Z|\). In the executable representation, a single charge has an empty path tuple and equal neutron and proton support has an empty unmatched tuple. The associated contribution is omitted; the representation retains structural absence.

Write the retained nonradial share as \(D_A\) and radial loss as \(R_{A,Z}\):
\[
 D_A=1-\frac{(A-2Z)^2}{4A^2},\qquad
 C_{A,Z}=\alpha\frac{Z(Z-1)}A,\qquad J_A=\frac1{4A}.
\]
The three source parity branches are
\[
 R_{A,Z}=\begin{cases}
 1/5+C_{A,Z}-J_A,& Z,N\text{ both even},\\
 1/5+C_{A,Z}+J_A,& Z,N\text{ both odd},\\
 1/5+C_{A,Z},& Z,N\text{ of different parity}.
 \end{cases}
\]
Every subtraction in the executable calculation uses the original strict positive-take guard. The symbolic score is
\[
 B(A,Z)=D_A-\frac{R_{A,Z}}{A^{1/3}}.
\]
This notation displays the source rank-two boundary to rank-three volume relation. The actual proof values are positive rational enclosures; no irrational radius is evaluated or stored. Expanding the notation exposes all five source contributions: saturated bulk, \(1/(5A^{1/3})\) surface loss, \(\alpha Z(Z-1)/A^{4/3}\) Coulomb loss, \((A-2Z)^2/(4A^2)\) asymmetry loss, and the parity-dependent \(1/(4A^{4/3})\) adjustment.

The executable ledger retains ten fields: mass, charge, neutron count, bulk support, surface share, ordered paths, Coulomb share, asymmetry share, pairing share and pairing class. Neither the output coordinate nor any isotope name is an input.

## 4. Exhausting all fixed-mass candidates

### 4.1. Exact radius enclosure

Starting at \(k=1\), advance while \((k+1)^3\le A\). If \(k^3=A\), return the exact interval \([k,k]\). Otherwise \(k^3<A<(k+1)^3\); initialize \([\ell,h]=[k,k+1]\). For every refinement, form the exact rational midpoint \(m=(\ell+h)/2\). If \(m^3<A\), replace \(\ell\) by \(m\); otherwise replace \(h\) by \(m\). The bracketing invariant is preserved and the width halves. For positive radial loss,
\[
 B(A,Z)\in[L_{A,Z},U_{A,Z}]
 =\left[D_A-\frac{R_{A,Z}}\ell,\ D_A-\frac{R_{A,Z}}h\right].
\]
The native integer loop uses decreasing remainder \(A-k\). If the source permits another step, then \(k+1\le(k+1)^3\le A\), so \(k<A\) and that remainder is positive. Its recursion therefore cannot exhaust before the original stopping test.

### 4.2. Concavity and parity

At fixed mass and within a fixed parity class, the pairing contribution is constant. The charge-dependent expression is a strictly concave quadratic. Writing \(r=A^{1/3}\), its quadratic and linear coefficients are
\[
 -\left(\frac1{A^2}+\frac\alpha{Ar}\right)Z^2
 +\left(\frac1A+\frac\alpha{Ar}\right)Z.
\]
Completing the square places the vertex at
\[
 v(r)=\frac{A(r+\alpha)}{2r+2\alpha A}.
\]
For \(r_2>r_1>0\), cross multiplication gives
\[
 v(r_2)-v(r_1)=
 \frac{A\alpha(A-1)(r_2-r_1)}{2(r_2+\alpha A)(r_1+\alpha A)}>0.
\]
Thus radius endpoints give vertex endpoints. In each parity class a quadratic maximum lies at the nearest available lattice neighbors of its vertex; these have spacing two. For odd mass the mixed-parity adjustment is constant for all charges and the lattice spacing is one. Restricting to \(1\le Z<A\) simply retains the corresponding nearest boundary when needed.

Refine until \(v(h)-v(\ell)<1/4\), beginning at one refinement and increasing by one. Set
\[
 z_{\min}=\max(1,\lfloor v(\ell)\rfloor-2),\qquad
 z_{\max}=\min(A-1,\lfloor v(h)\rfloor+3).
\]
Every nearest integer and parity neighbor lies in this inclusive interval. The margins are the source binary and generator counts. Concavity excludes every charge outside the retained neighborhood from being a fixed-mass maximum.

The generated finite/tail boundary is
\[
 T=b^{d+u}=2^{12}=4096=16^3.
\]
Applying the same procedure to every \(A=2,\ldots,4095\), in increasing mass and charge order, yields exactly 25,303 pairs. The numbers of masses first reaching the vertex-width test at refinements one through seven are respectively
\[
 59,\ 33,\ 67,\ 138,\ 310,\ 847,\ 2640;
 \qquad\text{sum}=4094.
\]
Every row has both an exact native evaluation and a proof that the successful result follows the original uncapped stop-or-successor loop.

## 5. Exact finite separation

At score refinement \(n\), choose the first candidate whose lower endpoint is maximal, preserving the source tie order. Exclude that coordinate from the rival list and compute the largest remaining upper endpoint. Accept precisely when
\[
 \max_{c\ne w}U_c(n)<L_w(n).
\]
Otherwise double \(n\). The complete source and native computations continue at \(n=1,2,4\) and separate at \(n=8\). They return the three fractions in Section 1 and coordinate \((62,28)\). Subtraction gives \(N=34\).

This is a strict uniqueness argument: every rival's score is at most its upper endpoint, every rival upper endpoint is at most the recorded maximum, and that maximum is strictly below the winner's lower endpoint. No tie survives. The candidate concatenation and interval evaluations are proved in batches with exact append laws; composition preserves every candidate and its order.

The final record has eleven fields: mass 62, charge 28, neutron count 34, winner lower endpoint, winner upper endpoint, rival upper endpoint, refinement count 8, finite mass count 4,094, candidate count 25,303, cutoff 4,096 and tail-closed flag. It is assembled from the source operations rather than a coordinate lookup.

## 6. Closing the unbounded tail

For \(A\ge T\), the largest possible pairing gain is
\[
 G=\frac1{4T\sqrt[3]T}=\frac1{262144}.
\]
The two source charge cases exhaust the domain.

**Low charge, \(5Z\le A\).** Write \(A=5Z+t\), \(t\ge0\). Then \(U=A-2Z=3Z+t\), and
\[
 3A=15Z+3t\le15Z+5t=5U.
\]
Squaring and dividing by positive \(A^2\) gives \(U^2/A^2\ge9/25\). Omitting the other losses therefore gives
\[
 B(A,Z)\le1-\frac9{100}+G
 =\frac{5963801}{6553600}<L_*.
\]
`NuclearBindingTailSuccession.lowChargeAsymmetry` proves the cross-multiplied inequality for every nonnegative charge and remainder.

**High charge, \(5Z>A\).** The same ledger supplies a direct explicit lower bound on Coulomb loss. Since \(Z>A/5\) and \(Z-1>A/5-1>0\),
\[
 \frac{\alpha Z(Z-1)}{A^{4/3}}
 >\frac\alpha{25}\frac{A-5}{A^{1/3}}.
\]
To see the right-hand factor increases, write \(r=A^{1/3}\). It becomes \(r^2-5/r\). If \(r_2>r_1>0\), its increment is
\[
 (r_2-r_1)\left(r_2+r_1+\frac5{r_1r_2}\right)>0.
\]
Consequently every high-charge tail composition satisfies the explicit bound
\[
 B(A,Z)<1-\alpha\frac{4091}{400}+G<L_*.
\]
The last comparison is exact rational arithmetic; its left side is approximately 0.92537014 and the winner lower endpoint approximately 0.92564805. These decimal readings illustrate the already strict rational comparison.

The original executable tail certificate also records its high-charge base value using \(z_0=\lfloor4096/5\rfloor+1=820\):
\[
 B_{\mathrm{high,record}}
 =1-\alpha\frac{820\cdot819}{4096\cdot16}+G<L_*.
\]
Its positive successor condition is \(12m+14<2m^2\) for every \(m=4096+k\). Indeed, \(14\le14m\) and \(26<2m\), so
\[
 12m+14\le26m<2m^2.
\]
`NuclearBindingTailSuccession.everyTailSuccessor` proves this universal successor inequality. The explicit ledger inequalities above display why neither charge partition can reach the finite winner, while the native certificate retains the original two tail fields and successor decision exactly.

## 7. Exhaustive construction grammar and absence of free coefficients

The source construction grammar is a product of ten binary axes, so it contains \(2^{10}=1024\) forms. Each axis records the original structural obligation and its opposed alternative:

| Axis | Retained construction | Rejected alternative |
|---|---|---|
| Predecessors | Compose immutable admitted laws | Rewrite predecessor laws |
| Bulk | One saturated interior support | Unbounded pairwise bulk growth |
| Surface | One over the binary-plus-generator interface | Fit a surface coefficient |
| Coulomb | Exact alpha on ordered distinct charge paths | Import a mass-formula Coulomb term |
| Asymmetry | Quarter-order unmatched-label square | Choose an asymmetry penalty |
| Pairing | Quarter-order gain, loss or absent adjustment | Fit a parity term |
| Radius | Rational enclosures until order separates | Evaluate an irrational proof value |
| Maximum | Complete concave census and unbounded tail | Select an isotope window |
| Target custody | Seal derivation before target access | Read the target during derivation |
| Extension | Retain the complete generated ledger | Append a free coefficient or residual |

Every product form is constructed by choosing one value on every axis. Case analysis on the ten coordinates proves completeness. Acceptance requires all ten retained constructions. Hence an accepted form equals their unique tuple; conversely that tuple passes every criterion. The native theorem `NuclearBindingCurveEntryGrammar.uniqueCriteriaSurvivor` proves this equivalence for every typed candidate, and `sourceDecisionMatchesCriteria` identifies it with the actual source decision.

The coefficient derivations in Section 2 supply the values used by the surviving form. The 1,024-form grammar, the 25,303-coordinate numerical census and the 2,548-row empirical census have distinct roles: construction uniqueness, global score maximization, and measured comparison respectively. The independent validator reconstructs the peak using its own integer-scaled cube enclosure and a broader charge neighborhood. Its original case passes; omitted-candidate, additional-survivor and failed-control cases are rejected [3].

## 8. Native Lean verification and source correspondence

All original source references use V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The V4 edition 0.4 scientific source is pinned at `21cdf559922fb057f8560f42d056ffa035329eb3`. The entry's completion receipt lists 12,545 audited declarations, empty axiom dependencies, its successful affected-entry build, original/native output comparisons and independent-validator controls. The retained proofs are reused without changing scientific definitions.

| Mathematical component | Native declarations in `SFT.Physics` |
|---|---|
| First-return generator | `GeneratorThreeDerivation.generatorThree`; `FoldFirstReturn.originalLoop`, `nativeFirstReturn`, `generatorPeriodThree` |
| Generated alpha | `AlphaCovers`; `AlphaBlocks.forcedBlocks`; `AlphaPromotion.forcedRungs`; `AlphaRatio` |
| Residual quarter | `NuclearResidualForce.originalResidual`, `completeExchange` |
| Ten-field binding ledger | `NuclearBindingCurve.bindingLedger`, `netRadialLoss`, `nonradialRetention` |
| Exact radius and original loop | `NuclearBindingRadius.wholeLoopCorrespondence`, `exactCubeRootEnclosure`, `bindingScoreEnclosure` |
| Complete fixed-mass census | `NuclearBindingCensus.candidatesCorrespond`; `NuclearBindingGatherClosure.completeCensus` |
| Every score stage | `NuclearBindingScoreClosure1.complete0`, `NuclearBindingScoreClosure2.complete0`, `NuclearBindingScoreClosure4.complete0`, `NuclearBindingScoreClosure8.complete0` |
| Strict separation and assembly | `NuclearBindingPeakClosure.originalSeparationRun`, `certificateAssembly`, `completePeak` |
| Tail inequalities | `NuclearBindingTailSuccession.lowChargeAsymmetry`, `everyTailSuccessor` |
| Construction uniqueness | `NuclearBindingCurveEntryGrammar.sourceDecisionMatchesCriteria`, `uniqueCriteriaSurvivor` |
| Complete target comparison | `NuclearBindingMeasuredRows`; `NuclearBindingMeasurement` |

For clarity, the terminal theorem is an exact evaluation equality:

`bindingPeakWithin 7 4 = .ok (some originalCertificate)`.

Seven covers every successful candidate-enclosure trace; four covers the observed score-refinement sequence 1,2,4,8. The source-loop correspondence theorems turn those successful evaluations into original uncapped execution traces. The proof of `originalSeparationRun` composes the three continuing stages with the accepted fourth stage. `certificateAssembly` uses the proved candidate count. `completePeak` combines that assembly with the full gathered census. These proof bodies establish the actual computed result, while the algebraic arguments above explain its scientific construction.

## 9. The complete AME2020 comparison

The original empirical procedure opens the identity-bound AMDC AME2020 table after the prediction seal [1,6]. It retains 2,550 numeric rows, of which 2,548 are positive composites. The two mass-one rows retain their external empty-binding boundary records. The reader preserves the original fixed columns and exclusion of estimated, absent and nonnumeric binding inscriptions.

For reported binding energy per nucleon \(b\) and standard uncertainty \(\sigma\), form \([b-\sigma,b+\sigma]\). Stable descending ranking of all accepted central values gives nickel-62 first and iron-58 second. In keV per nucleon,
\[
\begin{aligned}
 b_{\mathrm{Ni62}}&=17589111/2000,&\sigma_{\mathrm{Ni62}}&=69/10000,\\
 b_{\mathrm{Fe58}}&=43961267/5000,&\sigma_{\mathrm{Fe58}}&=11/2000.
\end{aligned}
\]
The complete rival scan gives largest upper endpoint \(87922589/10000\), whereas nickel-62 has lower endpoint \(43972743/5000\). Their exact separation is
\[
 \frac{43972743}{5000}-\frac{87922589}{10000}
 =\frac{22897}{10000}=2.2897\ \mathrm{keV/nucleon}>0.
\]
All eight original anchors are retained:

| Nuclide | Lower endpoint (keV/nucleon) | Upper endpoint (keV/nucleon) |
|---|---:|---:|
| Deuterium | 11122829/10000 | 11122833/10000 |
| Helium-4 | 35369577/5000 | 35369579/5000 |
| Carbon-12 | 19200361/2500 | 9600181/1250 |
| Iron-56 | 17580703/2000 | 87903611/10000 |
| Iron-58 | 87922479/10000 | 87922589/10000 |
| Nickel-62 | 43972743/5000 | 10993203/1250 |
| Lead-208 | 3146979/400 | 15734917/2000 |
| Uranium-238 | 75701199/10000 | 3028053/400 |

The original decisions retain the light-anchor rise, heavy-anchor fall, strict peak separation, equality of predicted and measured coordinates, and rejection of an unqualified iron-only maximum. Native execution matches every field of all accepted rows, all eight anchor intervals, the complete ranking and the five comparison decisions. The structural score predicts the maximizing composition; the independent measured column supplies the energy values displayed here.

## 10. Conclusion

The generated surface, electromagnetic and residual shares determine one nuclear ledger. Its concave fixed-mass structure exhausts all possible charge maxima; exact rational separation selects (62,28,34); the two tail partitions exclude every larger mass. The result is a unique nickel-62 maximum with zero fitted coefficients. The independently opened AME2020 census identifies the same coordinate and separates it from all measured rivals. The native Lean proof and original executable certificate retain the complete derivation and comparison.

## References and reproducible sources

[1] Maria Smith. *Terminal zero-parameter nuclear binding curve and stability maximum*. Original V3 claim `SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005`, derivation and executable law. [Original derivation](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/claims/SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005/WHY_DERIVATION_CHECK.md). [Exact law](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/nuclear_binding_curve_successor_laws_v1.py). [Target comparison](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/nuclear_binding_curve_successor_validation_v1.py).

[2] Maria Smith. *From Fold to Physics*. Version 1.4.1. [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655). The original [residual-force construction](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/nuclear_residual_force_successor_laws_v1.py) supplies the quarter-order dependency.

[3] Maria Smith. *Smithian Fold Theory: Zero-Axiom, Zero-Free-Parameter Derivations from First Principles - Lean 4 Formal Verification*. Edition 0.4, especially Sections 834–838. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). [Complete peak proof](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/NuclearBindingPeakClosure.lean). [Source-specific completion and audit receipt](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/verification/TURN_964_NUCLEAR_BINDING_CURVE_COMPLETION.json).

[4] Maria Smith. *From Nothing to Fold: A Premise-Free, Parameter-Free and Machine-Closed Foundation for Smithian Fold Theory*. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656). Native all-word theorem: [PrimitiveMinimality](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Foundation/PrimitiveMinimality.lean).

[5] Maria Smith. *Smithian Fold Theory*, original V3 cumulative monograph, recorded version 0.4.0. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Native exact assembly: [AlphaRatio](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/AlphaRatio.lean).

[6] Atomic Mass Data Center. *Atomic Mass Evaluation 2020*, `mass_1.mas20`, original fixed-column dataset. [AMDC table](https://www-nds.iaea.org/amdc/ame2020/mass_1.mas20). The V3 target record and V4 `NuclearBindingRecords`, `NuclearBindingMeasuredRows` and `NuclearBindingMeasurement` retain the data identity, reader, accepted rows and complete comparison.

[7] Maria Smith. *Independent Lean 4 Verification of the Complete Smithian Fold Theory Model*. Version 1.0.1. [doi:10.5281/zenodo.21761665](https://doi.org/10.5281/zenodo.21761665).

**Authorship.** Maria Smith originated SFT and its derivations and directs the scientific work. AI assistance supports source-bound manuscript preparation, native translation and verification.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

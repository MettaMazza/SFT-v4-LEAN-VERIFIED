# The Higgs mass ratio and self-coupling from the unique Fold ground

**Maria Smith** · Ernos Labs  
Standalone paper 5 · Version 1.1 · 18 November 2026  
DOI: 10.5281/zenodo.24351363  
Published predecessor: [10.5281/zenodo.24337113](https://doi.org/10.5281/zenodo.24337113)

## Abstract

Smithian Fold Theory derives the exact dimensionless Higgs relation \(m_H/v=1/2+(6/5)\alpha\) and the self-coupling \(\lambda=(m_H/v)^2/2\), with \(\alpha=3676744786/503846395469\). The complete minimal ground census contains absence, half-One and One. Half-One is the unique positive proper self-antipodal ground and returns to One under Fold. Its complete binary-hand by generator-direction support has six cells; retaining the invariant return leaves five active cells, independently equal to the least binary cover depth of generation volume 27. Transporting one terminal alpha return over that support yields the factor 6/5. The exact ratio is 2563352914777/5038463954690, and the exact self-coupling is approximately 0.129416752514. The original released electroweak scale 246.22 GeV translates the ratio to 125.266104978… GeV, inside the complete registered PDG interval [125.09, 125.31] GeV. The paper supplies the ground uniqueness proof, all support counts, the complete alpha input, mass and coupling derivations, exhaustive 2,048-form classification and full five-source comparison, including individual ATLAS/CMS offsets and the Higgs-pair constraint. Native Lean 4 proof and source-output evidence preserve the complete construction with zero axiom dependencies.

**Keywords:** Higgs mass; Higgs self-coupling; displaced ground; electroweak scale; Smithian Fold Theory; fine-structure constant; exact rational derivation; Lean 4 formal verification.

## 1. Exact mass and coupling

Let \(R=m_H/v\) denote the dimensionless ratio in the original source. Its generated form is
\[
 R=\frac12+\frac65\alpha,
 \qquad \alpha=\frac{3676744786}{503846395469}.
\]
Consequently
\[
 R=\frac{2563352914777}{5038463954690}
 =0.508756823077186153\ldots,
\]
\[
 \lambda=\frac{R^2}{2}
 =\frac{6570778165695741824959729}{50772238045420788745992200}
 =0.129416752513795646\ldots.
\]
Both values are exact positive rationals. Their two routes agree identically:
\[
 R^2=2\lambda.
\]
The released dimensional reference \(v=12311/50=246.22\) GeV then gives
\[
 m_H=\frac{31557437733819647}{251923197734500}\ \mathrm{GeV}
 =125.266104978064774613\ldots\ \mathrm{GeV}.
\]
This multiplication occurs after the exact ratio and its complete grammar are sealed. The Higgs mass, electroweak scale and reported coupling constraints do not select the formal coefficients [1,2].

## 2. The complete minimal ground and its unique displacement

### 2.1. Occurrence, One and the binary partition

The operational root distinguishes unpresented absence from occurrence. Presenting any claim, denial or record is itself occurrence. Complete retention without an unforced addition gives structural One. Its minimal binary extension has two distinct labelled positions. The complete selection census is empty, first position, second position and both positions. The two one-position selections are exchanged by label symmetry and have the same normalized coordinate.

A nonempty proper selection has one position out of two, so its part is \(h=1/2\). Selecting both gives One. Selecting neither gives the structural empty record. Thus the complete coordinate classes of the minimal selection carrier are absence, half-One and One. `HalfOneDerivation.selectionForms` quantifies over every Boolean selection of the two positions; `properSelectionIsHalf`, `exchangePreservesCoordinate` and `nonemptySelectionClasses` prove the resulting complete coordinate classification.

The complement of a proper positive part \(x\) is the retained part \(1-x\). Self-antipodality requires
\[
 1-x=x,
 \qquad 2x=1,
 \qquad x=\frac12.
\]
This excludes every other positive part, not merely the other rows of a finite sample. Native `CPPhase.uniqueSelfAntipodal` applies to an arbitrary exact positive part whose complement equals itself; it reuses `RiemannMirror.uniqueFixedAxis`. `HalfOneDerivation.selfJunctionOneIff` independently states that two copies of a part assemble to One exactly when that part is half-One.

### 2.2. Fold and the ground predicates

On positive parts through One, Fold is
\[
 F(x)=\begin{cases}2x,&0<x\le1/2,\\2x-1,&1/2<x\le1.\end{cases}
\]
Hence \(F(1/2)=1\) and \(F(1)=1\). Half-One is proper and self-antipodal; One is the complete unison carrier and is not a displaced proper part. Absence is not an occupied positive field carrier.

The original `vacuum_ground_census` retains five predicates for each row:

| Ground form | Positive | Proper | Self-antipodal | Folds to One | Displaced |
|---|---|---|---|---|---|
| Structural empty | no | no | no | no | no |
| Half-One | yes | yes | yes | yes | yes |
| One | yes | no | no | yes | no |

Acceptance is the conjunction of all five predicates. Its complete result is \((\mathrm{false},\mathrm{true},\mathrm{false})\), selecting half-One uniquely. `HiggsGround.completeAcceptance` proves the full decision vector; `uniqueDisplaced` proves that the original selection operation returns the exact half-One. The source preserves both the minimal selection census and the general uniqueness of its self-antipodal coordinate.

### 2.3. The retained leading rungs

Successive binary sharing gives
\[
 v_0=\frac12,\qquad h_0=\frac{v_0}{2}=\frac14,
 \qquad \lambda_0=\frac{h_0}{2}=\frac18.
\]
The leading mass-to-ground ratio is \(h_0/v_0=1/2\). These three rungs retain distinct source roles: ground, mass rung and coupling rung. `HiggsGround.originalRungs` proves the ordered tuple \((1/2,1/4,1/8)\), and `HiggsCertificate.theoremCertificate` retains their normalized leading mass ratio. Terminal completion keeps these leading controls.

## 3. Generated directions and the independent cover

Complete binary support doubles each prior word by its two labelled extensions. The empty-word base has cardinality one; the disjoint successor classes give \(2^d\) words at depth \(d\). The predecessor unit parts at the first two nonstatic recurrence depths produce
\[
 1/3\mapsto2/3\mapsto1/3,
 \qquad1/7\mapsto2/7\mapsto4/7\mapsto1/7.
\]
Neither trace returns earlier. The least generated count beyond the binary period is three. The original Fold primitive is the unique least generating singleton: identity and square are injective, constant One lacks nonstatic return, and Fold has both noninjectivity and a nonstatic cycle. A generating singleton makes every least nonempty generating word a singleton, so that primitive classification establishes least-word uniqueness [3,4].

The scalar excitation retains both binary hands across all three generator directions:
\[
 \mathcal S=\{L,R\}\times\{1,2,3\},\qquad |\mathcal S|=2\cdot3=6.
\]
The invariant return is held once. The active count is the unique positive predecessor of six:
\[
 a+1=6\quad\Longrightarrow\quad a=5.
\]
The source independently computes the least complete binary cover of generation volume \(3^3=27\):
\[
 2^4=16<27\le32=2^5.
\]
Every smaller positive depth has smaller support. Its depth is therefore five, equal to the active scalar count. `HiggsTerminal.originalSupport` proves the ordered record \((6,5,5)\), connecting complete directions, active directions and the independently computed cover depth.

The two computations must agree before the source constructs the return. A selected denominator cannot replace either computation. The complete directional share per active support is \(6/5\).

## 4. The exact electromagnetic return input

The terminal alpha used here comes from the complete Fold cover construction [4]. Its mathematics is retained explicitly. The least covers of generator and successor volumes are
\[
 2^4<3^3\le2^5,
 \qquad2^6<3^4\le2^7.
\]
Thus the down/up depths are \(d=5\) and \(u=7\), with independent count checks \(d=2+3\), \(u=3+4\). The typed tower, boundary and cover are
\[
 T=2^7=128,\qquad B=3^2=9,\qquad C=2\cdot5^3=250.
\]
Promoting each of the three interchangeable cover directions once retains the complete sequence
\[
 5^3=125,\quad7\cdot5^2=175,\quad7^2\cdot5=245,\quad7^3=343.
\]
The stage recursion changes \((p,r+1)\) to \((p+1,r)\), preserves the total three and stops exactly when no direction remains. Hence no extra stopping index selects the terminal order.

The descending reciprocal chain gives
\[
\begin{aligned}
 245+1/343&=84036/343,\\
 175+343/84036&=14706643/84036,\\
 D_*&=250+84036/14706643
 =3676744786/14706643.
\end{aligned}
\]
The returning One dilates the boundary by \(1+1/D_*\); adding the tower yields
\[
 \alpha^{-1}=T+B(1+1/D_*)
 =\frac{503846395469}{3676744786}.
\]
Native `AlphaCovers`, `AlphaBlocks`, `AlphaPromotion` and `AlphaRatio` retain the least-cover proofs, complete promotion object, original descending order and exact terminal assembly. `PlanckHierarchy.terminalAlpha` takes its exact reciprocal. The source Higgs construction uses this admitted value without any Higgs data.

The assembly retains the roles of its generated carriers. The tower is complete binary reach at the up-depth; the boundary is the generator composed over boundary rank two. The only admitted returning whole is structural One. Distributing that return over the complete effective cover gives \(1/D_*\). Since the return traverses the boundary carrier, it dilates that carrier by \(1+1/D_*=(D_*+1)/D_*\). Complete reach and the resulting boundary response compose additively, giving \(2^u+g^2(1+1/D_*)\). Thus the position of the return, the boundary multiplier and the additive tower follow the typed construction; they are not interchangeable arithmetic placements [4].

The original fine-structure grammar exhausts ten binary axes: least covers, depth cross-lock, tower, boundary, return, join, promotion, termination, target custody and extension. Its \(2^{10}=1024\) forms include each preserving form and its registered alternative. Asserted depths replace the cover census; a free tower or boundary adds a coefficient; a fitted return reads the target; an arithmetic permutation discards carrier roles; a selected promotion series or truncation replaces direction exhaustion. The preserving assembly keeps the two independent depth identities \(d=b+g\) and \(u=g+(g+1)\), promotes one remaining direction at each step, seals before comparison and adds no extra scale. `SFT.Physics.AlphaGrammar.candidatesComplete` quantifies over every constructor combination; `sourceDecisionMatchesCriteria` checks the source decision against those ten criteria; `uniqueCriteriaSurvivor` establishes the sole preserving form. `SFT.Physics.AlphaRatio.inverseFineStructure` implements the typed join, and `terminalRatio` evaluates its exact terminal value. These grammar results accompany the upstream construction and its carrier meanings [3,4].

## 5. Terminal mass, coupling and route equality

Transport one terminal alpha return from all six direction cells over the five active supports:
\[
 \delta_H=\frac65\alpha
 =\frac{22060468716}{2519231977345}.
\]
Retain it with the displaced-ground ratio. At the common denominator the exact addition is
\[
 R=\frac12+\delta_H
 =\frac{2519231977345+44120937432}{5038463954690}
 =\frac{2563352914777}{5038463954690}.
\]
The positive return puts \(R\) above half-One, and the exact result is below One. The source checks this strict interval before constructing the coupling.

The complete binary sharing of the squared excitation gives
\[
 \lambda=\frac{R^2}{2}
 =\frac{2563352914777^2}{2\cdot5038463954690^2}
 =\frac{6570778165695741824959729}{50772238045420788745992200}.
\]
It satisfies \(1/8<\lambda<1/2\). The lower inequality follows from \(R>1/2\); the upper follows from \(R<1\). Multiplying the coupling by the two-fibre count returns exactly the squared mass route:
\[
 2\lambda=R^2.
\]
`HiggsTerminal.originalMassRatio`, `originalCoupling` and `originalRouteEquality` prove the exact original values and the equality of routes. `HiggsCertificate` assembles the complete twelve-field record, retaining the ground census, leading controls, both support counts, cover depth, terminal return, ratio, coupling and route record.

## 6. Complete classification and closure

The formal grammar contains eleven binary axes and therefore \(2^{11}=2048\) complete candidates. Its preserving forms and opposed forms are:

| Axis | Preserving construction | Original opposed form |
|---|---|---|
| Ground | Positive proper carrier | Absence used as field value |
| Displacement | Unique self-antipodal half-One | Unison or selected part |
| Rungs | Retained half, quarter, eighth | Discarded leading controls |
| Directions | Complete two-by-three product | Selected subset |
| Return | One held invariant, five active | All six counted as active |
| Cover | Least cover of 27 | Free denominator |
| Transport | One 6/5 alpha return | Fitted offset or repeated series |
| Coupling | Squared excitation shared over two fibres | Imported potential or free coupling |
| Route | Exact equality of both routes | Independent mass and coupling inputs |
| Measurement | Targets inaccessible before seal | Readable target selecting the form |
| Extension | No additional rule | Extra field, mass or correction |

The carrier is the product of these eleven finite types. Every typed tuple belongs to the complete enumeration. The source acceptance criteria require each preserving constructor, so acceptance implies equality with their unique tuple; conversely that tuple passes. `HiggsGrammarBase` and `HiggsGrammar` retain constructor completeness, the original first-failure decisions and the unique survivor. The implementation's 32 census blocks retain all 2,048 forms in source order.

The base is the unique displaced ground. Binary succession retains its leading rungs. The next construction appends every hand–direction cell, holds the invariant return once, checks the independent cover depth, transports one terminal return and shares the square over both fibres. At completion every original role has been counted. Five operational witnesses evaluate the complete ground census, leading rungs, support equality, terminal ratio and coupled-route result.

The source registration records observational-derivation provenance, while the executable relation excludes measured masses, the dimensional scale and coupling observations. Its empirical successor contains eight binary axes and 256 forms, retaining the formal result, the complete source vector, isolated prediction, all rows and unchanged comparison rules. Its base preserves the first complete row; each successor appends another original row without erasing the preceding values, uncertainties or offsets.

## 7. Dimensional translation and all mass measurements

The original five-source record opens only after sealing. Its electroweak reference is
\[
 v=12311/50=246.22\ \mathrm{GeV}.
\]
Multiplying the already fixed \(R\) gives the exact mass in Section 1. The original registered comparisons are:

| Source | Central mass (GeV) | Reported uncertainty (GeV) | Prediction minus centre (GeV) | Offset / reported uncertainty |
|---|---:|---:|---:|---:|
| PDG 2025 average | 125.20 | 0.11 | 0.066104978… | 0.600954346… |
| ATLAS 2023 combined | 125.11 | 0.11 | 0.156104978… | 1.419136164… |
| CMS 2024 four-lepton | 125.04 | 0.12 | 0.226104978… | 1.884208151… |

The PDG listing retains its error scale factor \(7/5=1.4\) and the complete listed interval \([125.09,125.31]\) GeV. The exact predicted mass is inside it. The separate ATLAS interval \([125.00,125.22]\) GeV and CMS interval \([124.92,125.16]\) GeV do not contain the prediction at one reported uncertainty. Their positive offsets remain in the original result. ATLAS's retained components are 0.09 GeV statistical and 0.06 GeV systematic, alongside its reported 0.11 GeV combined uncertainty.

For any row with central value \(c\) and uncertainty \(u\), the computation is exactly
\[
 \Delta=m_H-c,\qquad z=\Delta/u.
\]
For the PDG row,
\[
 \Delta_{\rm PDG}=\frac{16653377460247}{251923197734500}\ \mathrm{GeV},
 \qquad z_{\rm PDG}=\frac{1513943405477}{2519231977345}.
\]
For ATLAS and CMS the exact offsets are
\[
 \Delta_{\rm ATLAS}=\frac{9831616314088}{62980799433625}\ \mathrm{GeV},
 \qquad
 \Delta_{\rm CMS}=\frac{56961089097767}{251923197734500}\ \mathrm{GeV}.
\]
Dividing by \(11/100\) and \(3/25\) respectively gives the exact normalized offsets behind the table. The comparison retains the aggregate and the two individual rows as distinct observations; none replaces another.

## 8. The Higgs-pair constraint and complete validation

The registered ATLAS–CMS Higgs-pair source reports signal strength 0.8, with lower and upper uncertainties 0.7 and 0.9. Its 95-percent trilinear-coupling interval is conventionally written
\[
 -0.71<\kappa_\lambda<6.1,
\]
in the experiment's Standard-Model-reference normalization. The original comparison maps the SFT normalized prediction to \(\kappa_\lambda=1\), which is inside this interval. It retains the below-reference lower direction and positive magnitude \(71/100\) as external source fields. This interval is the registered search constraint; the dimensionless exact \(\lambda\) in Section 5 is the formal self-coupling construction.

Native `HiggsObservationAnalysis.exactAnalysis` retains all 31 original fields: the formal ratio and coupling, released scale, translated mass, PDG interval and scale factor, individual central values and uncertainties, every exact offset and containment result, coupling normalization and bounds, confidence fraction and complete source-retention decisions. `HiggsObservationAnalysisProofs.originalComplete` proves the complete original output.

Three original controls test the actual comparison. Replacing the PDG interval by [124,125] GeV rejects the mass prediction. Replacing the coupling upper coordinate by 0.9 rejects the normalized prediction One. Replacing the ATLAS central value by the prediction erases its offset and fails the original offset-retention predicate. The corresponding complete proof outputs and input substitutions are retained in `HiggsObservationAnalysisProofs` and `HiggsObservationInputProofs`.

The validator requires the exact formal fractions and route equality, all nine original empirical predicates and all three controls. The source identities bind five ordered sources and six hashes, including the complete combined record. Native source custody and isolated prediction retain their original order. The observational result therefore reproduces the full source record, including both aggregate agreement and individual offsets.

## 9. Native proof and reproducibility

The original V3 code is pinned to `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`; native proof files are taken from published V4 edition 0.4 source commit `21cdf559922fb057f8560f42d056ffa035329eb3` [3].

| Component | Native proofs | Completion evidence |
|---|---|---|
| Complete ground and leading rungs | `HiggsGround.uniqueDisplaced`, `completeAcceptance`, `originalRungs` | TURN_1061_HIGGS_065 |
| Support, exact ratio and coupling | `HiggsTerminal.originalSupport`, `originalMassRatio`, `originalCoupling`, `originalRouteEquality` | TURN_1061_HIGGS_065 |
| Full theorem and candidate census | `HiggsCertificate`, `HiggsWitnesses`, `HiggsGrammar` | TURN_1061_HIGGS_065 |
| Complete source comparisons and controls | `HiggsObservationAnalysisProofs`, `HiggsObservationInputProofs`, `HiggsObservationValidation` | TURN_1062_HIGGS_OBSERVATION_066 |

The formal receipt audits 165 declarations and the empirical receipt 117; both retain empty axiom dependencies. Applicable builds, complete programme/candidate comparisons and independent controls pass in the deposited records. The source-specific numerical evidence includes all ten ground/terminal operation outputs and 31 complete original, control and modified-record comparisons. Independent exact re-evaluation for this paper reproduces the terminal ratio, coupling, translated mass, all comparison fields and all three rejected controls. No scientific definition or proof is changed.

## 10. Conclusion

The complete minimal Fold partition gives the unique displaced half-One ground. All six scalar hand–direction cells, their one held return and the independent five-depth cover force a single \((6/5)\alpha\) contribution. This determines the exact Higgs mass ratio; binary sharing of its square determines the exact coupling and makes both routes identical. The original released scale gives 125.266104978… GeV. The complete source comparison retains PDG-interval containment, both individual mass offsets and the Higgs-pair constraint with their exact reported values.

## References

[1] Maria Smith. Original pinned V3 [higgs_symmetry_terminal_law_v1.py](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/higgs_symmetry_terminal_law_v1.py), with original ground, terminal-return and source grammar derivations.

[2] Maria Smith. Original pinned V3 [higgs_symmetry_terminal_validation_v1.py](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/higgs_symmetry_terminal_validation_v1.py), empirical registration and `higgs-terminal-postseal-source-record.json`, included with complete source identities and values.

[3] Maria Smith. *Smithian Fold Theory: Zero-Axiom, Zero-Free-Parameter Derivations from First Principles — Lean 4 Formal Verification*, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Native [HiggsGround](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/HiggsGround.lean) and [HiggsTerminal](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/HiggsTerminal.lean), with imported proof dependencies.

[4] Maria Smith. *The fine-structure constant from first principles: an exact zero-parameter Fold derivation*, [doi:10.5281/zenodo.24324400](https://doi.org/10.5281/zenodo.24324400); operational foundation, [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656); *Smithian Fold to Physics*, version 1.4, [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655); original V3 monograph, recorded version 0.4, [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[5] J. Erler and A. Freitas, Particle Data Group. *Electroweak Model and Constraints on New Physics*, 2024. [PDG review](https://pdg.lbl.gov/2024/reviews/rpp2024-rev-standard-model.pdf).

[6] Particle Data Group. *Higgs-boson listing*, 2025 update. [PDG listing](https://pdg.lbl.gov/2025/listings/rpp2025-list-higgs-boson.pdf).

[7] ATLAS Collaboration. *Combined measurement of the Higgs boson mass from H to gamma-gamma and H to ZZ-star to four leptons*. [arXiv:2308.04775](https://arxiv.org/abs/2308.04775).

[8] CMS Collaboration. *Measurement of the Higgs boson mass and width using the four-lepton final state*. [arXiv:2409.13663](https://arxiv.org/abs/2409.13663).

[9] ATLAS and CMS Collaborations. *Combination of ATLAS and CMS searches for Higgs boson pair production at 13 TeV*. [arXiv:2602.23991](https://arxiv.org/abs/2602.23991).

**Authorship.** Maria Smith originated SFT and its derivations and directs the scientific work. AI assistance supports source-bound manuscript preparation, native translation and verification.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

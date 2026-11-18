# Electroweak mixing and the W-to-Z mass relation from complete Fold channels

**Maria Smith · Ernos Labs**  
Standalone paper 37 · Version 1.0 · 17 November 2026  
DOI: 10.5281/zenodo.24326240

## Abstract

Complete Fold channels determine the exact terminal on-shell electroweak share
\[
S=\frac{1930922298157999}{8642477221479757},\qquad
C=\frac{6711554923321758}{8642477221479757},\qquad S+C=1.
\]
The direct on-shell measurement contains \(S\), and the complete compatible-input W/Z squared-mass interval contains \(C\). The derivation starts from the two exact half-One preimages, quarter-One and three-quarter-One. The complete four-rung electromagnetic promotion object generates sixteen binary words. Holding the three generator directions gives level thirteen; all 225 charged and 784 neutral labelled channels then force the base share \(225/1009\). One terminal electromagnetic return crosses the complete-support successor seventeen, yielding \(S=225/1009+\alpha/17\). Every support position and channel product is retained exactly once. General native proofs establish enumeration, product completeness, uniqueness, positive-count descent and invariance under every positive rational common-unit change. The paper develops the full mathematics, exhaustive candidate grammars, original measured rows, exact uncertainty propagation and both measurement-record versions. Native Lean proofs and pinned V3/V4 evidence accompany the paper.

**Keywords:** electroweak mixing; weak mixing angle; W boson; Z boson; on-shell scheme; exact mass ratio; Smithian Fold Theory; Lean 4.

## 1. The exact result and its measured comparison

The terminal construction gives a strict positive partition of One. Its sine-squared share is approximately \(0.223422318471\) and its complementary squared W-to-Z share is approximately \(0.776577681529\). The exact fractions above are the scientific output; decimal displays serve only to locate them within the registered measurements.

The original direct row is \(0.22342\pm0.00009\), whose complete interval is \([0.22333,0.22351]\). The terminal share lies inside it. Independently, the original compatible W row \(80.3692\pm0.0133\) GeV and Z row \(91.1880\pm0.0020\) GeV yield a squared-ratio interval containing the exact complement. Both uncertainties enter the endpoint calculation.

The result is generated without a measured angle, boson mass, fitted running level or adjustable correction. Its inputs are the original binary fibre, generator-three carrier, finite electromagnetic promotion object and one returning electromagnetic share. The following sections derive those inputs and every subsequent operation.

The source also retains the all-input W aggregate \(80.395\pm0.012\) GeV and its published incompatible-input and poor-consistency disclosures. Its arithmetic is reproduced unchanged in Section 8. The original measured-value successor treats that aggregate as a measurement-method record and tests the two compatible physical records. This source-defined treatment is carried into the paper together with every original row.

## 2. Complete half-One preimages

### 2.1. Fold and its admitted parts

An exact Fold part is a positive rational \(x\) with \(0<x\leq1\). The operation is

\[F(x)=\begin{cases}2x,&0<x\leq1/2,\\2x-1,&1/2<x\leq1.\end{cases}\]

Both branches return an admitted positive part; the retained endpoint is One. The complete binary fibre has count \(b=2\), and half-One is \(1/b=1/2\).

For a positive support count \(m\), the original ordered enumeration is

\[E_m=[1/m,2/m,\ldots,m/m].\]

The recursive construction begins with the empty enumeration and appends the next positive numerator. Its length is \(m\): the base has length zero, and each successor appends exactly one part. The native theorem `ElectroweakMixing.enumerationCount` proves this for every support and every enumerated prefix bounded by that support.

Filtering a supplied list \(E\) by exact image \(y\) obeys

\[p\in\operatorname{returning}(y,E)
\quad\Longleftrightarrow\quad p\in E\ \text{and}\ F(p)=y.\]

`returningIff` proves both implications by induction on the original list. At each head, the exact equality test either retains the head and its equality witness or passes to the tail. Thus the filter preserves precisely the original image condition, not merely a chosen number of outputs.

### 2.2. The full depth-two census

Binary depth two gives \(m=2^2=4\). Every support part and its Fold image is retained in the census:

| Part | Fold image | Returns to half-One |
|---|---|---|
| \(1/4\) | \(1/2\) | yes |
| \(1/2\) | \(1\) | no |
| \(3/4\) | \(1/2\) | yes |
| \(1\) | \(1\) | no |

Consequently

\[\operatorname{returning}(1/2,E_4)=[1/4,3/4].\]

The two parts are distinct and sum to One. Conversely, any member of \(E_4\) returning to half-One belongs to this two-element output and therefore equals quarter-One or three-quarter-One. `completeDepthTwo`, `completeFibre` and `noOtherDepthTwoPreimage` prove the census and its complete exclusion result. `quarterReturn`, `threeQuarterReturn`, `distinctChannels` and `partitionOne` prove the actual two returns and partition.

The executable source checks both the returned count and partition before constructing the three-field result:

\[\bigl(\text{unified},\sin^2,\cos^2\bigr)=(1/2,1/4,3/4).\]

`nativeMixing` proves that complete output. The exact original guards are retained. The image must be an admitted rational part and the depth must pass the positive-depth test; the positive-power routine then enforces exact count input. Zero depth fails the first guard, while Boolean true passes that comparison and is rejected by the count guard. The original domain comparison retains 715 rational/depth cases, alongside the general membership theorem.

## 3. The W-to-Z relation and every common unit

The original bare W-to-Z operation reads the upper channel from the completed mixing record:

\[\left(\frac{m_W}{m_Z}\right)^2_{\rm bare}=\frac34.\]

`WZRelation.sourceAssembly` proves this actual readout. The lower channel completes it to One. The terminal construction below refines the share through its separately registered support and return operation; the bare value remains the lower-order carrier.

For arbitrary positive exact fractions \(a=n/d\), \(b=m/e\) and common scale \(u=q/f\), where all six counts are positive,

\[\frac{au}{bu}
=\frac{(nq)/(df)}{(mq)/(ef)}
=\frac{nqef}{dfmq}
=\frac{ne}{dm}
=\frac ab.\]

The common scale cancels because every factor removed is positive. Squaring the same equality preserves the squared ratio. Thus a common rational change of mass unit changes neither the bare nor terminal dimensionless comparison.

The native theorem `CommonScaleAxis.commonUnitCancellation` quantifies over all six positive counts and proves normalized multiplication and division equalities. Its proof converts both routes to exact rational cross-products and rearranges the same factors. `everyPositiveUnitCancels` extends this to every native positive-fraction carrier. `WZRelation.everyPositiveScaleRetainsRatio` specializes it to the original \(3/4\) readout for every \(q/f>0\). No particular unit or finite list of scale factors defines the result.

## 4. The terminal support is generated

### 4.1. Generator and complete promotion object

The original generator-three first-return trace is

\[1/7\longmapsto2/7\longmapsto4/7\longmapsto1/7.\]

The three pre-return states are distinct. The independently established generator and full first-return construction are developed in [4]. Here their actual native operation supplies \(c=3\).

Complete colour volume and its successor give the first binary cover depths five and seven:

\[2^4<3^3=27\leq2^5,\qquad2^6<3^4=81\leq2^7.\]

Promoting each of three cover directions once yields the complete ordered object

\[5^3=125,\quad5^2\cdot7=175,\quad5\cdot7^2=245,\quad7^3=343.\]

There are \(c+1=4\) rungs. Each successor promotes one remaining direction, leaving the total number of directions equal to three; the final state has no remaining unpromoted direction. The original operation checks that the rung count equals the generator successor. `ElectroweakTerminalSupport.promotionCountExact` proves this actual count.

The electromagnetic construction uses tower \(2^7=128\), boundary \(3^2=9\) and initial cover \(2\cdot5^3=250\). Its terminal continued fraction and inverse coupling are

\[K=250+\frac1{175+\dfrac1{245+\dfrac1{343}}},\qquad
A=128+9\frac{K+1}{K}=\frac{503846395469}{3676744786}.\]

Therefore

\[\alpha=A^{-1}=\frac{3676744786}{503846395469},\qquad0<\alpha<1.\]

This is the same exact terminal object derived and compared in [5]. Its full finite promotion expression is included here because it supplies the self-return in Section 6.

### 4.2. Sixteen words and three held directions

With two choices at each of four generated positions, complete terminal binary support has \(2^4=16\) words. Using \(L,U\) as the two held labels, the complete source order is

\[\begin{array}{llll}
LLLL&LLLU&LLUL&LLUU\\
LULL&LULU&LUUL&LUUU\\
ULLL&ULLU&ULUL&ULUU\\
UULL&UULU&UUUL&UUUU.
\end{array}\]

The cardinality follows recursively: one extension appends each label to every existing word and doubles the count. `supportMatchesPower` identifies the computed power with the length of the complete native word list.

Holding all three generator directions uses three positive predecessor operations:

\[16\longmapsto15\longmapsto14\longmapsto13.\]

The running level is therefore \(\ell=13\). More generally, for natural counts \(r,t\),

\[\operatorname{predecessorSteps}(r+t+1,t)=r+1.\]

At \(t=0\) nothing is held. At \(t+1\), the first predecessor transforms \(r+t+2\) into \(r+t+1\), after which the induction hypothesis performs the remaining \(t\) steps. `predecessorStepsExact` proves this identity on the actual recursion. `ElectroweakTerminalDomain.retainedPositive` preserves the original positive-input operation; exhaustion at One is rejected rather than supplying a new magnitude.

## 5. Every labelled charged and neutral channel

### 5.1. General complete products

For each natural \(n\), let

\[P_n=[1,2,\ldots,n].\]

The recursive rule appends \(n+1\) to \(P_n\). Induction proves all four source properties: length \(n\); every member lies between one and \(n\); every positive integer at most \(n\) is present; and each member occurs once. For uniqueness, the new endpoint exceeds every prior member, so appending it cannot duplicate one.

For finite lists \(X,Y\), the source product lists \((x,y)\) for each \(x\in X\) and then each \(y\in Y\). Its complete properties are

\[|X\times Y|=|X||Y|,\]
\[(x,y)\in X\times Y\quad\Longleftrightarrow\quad x\in X\ \text{and}\ y\in Y.\]

The length proof sums one copy of \(Y\) for each member of \(X\). Membership follows by recovering the two originating elements; the reverse implication inserts their exact pair. If both lists have unique members, each fixed-first-coordinate block is unique and different blocks have different first coordinates. Hence the whole product is unique. The native `positionsCount`, `positionBound`, `allPositions`, `positionsUnique`, `productCount`, `productMember` and `productUnique` prove these statements for arbitrary finite carriers.

### 5.2. The complete terminal inventories

At level thirteen the charged axis count is \(\ell+b=15\). Charged support is

\[\mathcal C=P_{15}\times P_{15},\qquad |\mathcal C|=15^2=225.\]

The neutral axis count is \(\ell+1=14\), with \(b^b=2^2=4\) complete neutral pair channels:

\[\mathcal N=P_4\times(P_{14}\times P_{14}),\qquad
|\mathcal N|=4\cdot14^2=784.\]

Thus every charged ordered pair occurs exactly once and every neutral labelled triple occurs exactly once. Their distinct source roles retain the complete charged and neutral inventories. All 1,009 records are supplied in the arithmetic reproduction file; the product definitions above specify each record without an omitted subset.

`chargedCount`, `neutralCount`, `chargedUnique` and `neutralUnique` derive the exact census from the general product theorems. `sourceChannelCounts` proves that the scientific count operation returns these same list lengths.

## 6. Exact terminal share and complement

At any admitted positive integer level \(\ell\), the original ratio is

\[R(\ell)=\frac{(\ell+2)^2}{4(\ell+1)^2+(\ell+2)^2}.\]

Both supports are positive, so \(0<R(\ell)<1\). `runningShareAllPositive` proves the complete normalized fraction for every native input \(n+1\); Boolean, zero and negative levels preserve the original rejection. The terminal construction uses the generated level thirteen:

\[R(13)=\frac{225}{784+225}=\frac{225}{1009}.\]

The complete-support successor supplies the return divisor

\[D=16+1=17.\]

The sole returning terminal electromagnetic share is

\[\frac\alpha D=\frac{3676744786}{8565388722973}.\]

The original channel orientation appends this positive return to the base share:

\[S=\frac{225}{1009}+\frac{3676744786}{8565388722973}.\]

Putting the two fractions over their common positive denominator gives

\[S=\frac{225\cdot8565388722973+1009\cdot3676744786}
{1009\cdot8565388722973}
=\frac{1930922298157999}{8642477221479757}.\]

The numerator is smaller than the denominator. Holding this part from One gives

\[C=\frac{8642477221479757-1930922298157999}{8642477221479757}
=\frac{6711554923321758}{8642477221479757}.\]

Consequently \(S+C=1\) exactly, and \(1/5<S<1/4\). The native ratio proofs establish the running share, alpha, self-return, both normalized terminal fractions and their complete sum. Their actual operations check the strict positive-part conditions before returning the values.

The lower form and terminal form remain distinct registered constructions. The bare quarter share supplies the original channel orientation; the complete terminal promotion and labelled support supply \(225/1009\), and the sole return supplies \(\alpha/17\). No additional rung, freely chosen level or later correction is appended to this complete terminal grammar.

## 7. Exhaustion and unique retained construction

### 7.1. Bare mixing and the W/Z relation

The original bare and W/Z laws each enumerate all \(2^8=256\) combinations of their eight binary construction axes. The axes retain the generated carrier, admitted dependencies, exact relation, complete enumeration, original minimality controls, sealed measurement direction, complete record and absence of an extra rule. The mixing relation uses the complete two-preimage partition; the W/Z relation reads its upper channel.

Necessity is exhibited by the complete four-part census: omitting either returning part loses the binary count or the One partition, and selecting another depth-two part loses the required image. Sufficiency is the exact two-return output together with distinctness and partition. The W/Z operation then has one specified readout, so replacing it by a fitted mass ratio changes its original source operation. The complete grammar retains every alternative and the original first-failure decision, yielding the unique preserving form for each law.

### 7.2. Terminal ten-axis grammar

The terminal precision law generates all \(2^{10}=1024\) forms. Its complete axes are:

| Axis | Preserving construction | Other choice |
|---|---|---|
| Carrier | Admitted lower-law carrier | Detached measured number |
| Terminal | Complete promotion termination | Selected intermediate stage |
| Support | Complete binary terminal support | Free scale support |
| Relation | Level thirteen, full channels, alpha/17 | Free running level or imported renormalization |
| Correction | One typed terminal alpha transport | Fitted additive offset |
| Orientation | Fixed by share or retention | Target-selected orientation |
| Enumeration | Complete registered product | Selected neighbourhood |
| Minimality | Bare and intermediate forms retained | Successor without lower controls |
| Measurement | Exact result sealed before target release | Target visible before sealing |
| Extension | No extra rule | Additional free correction |

The exact derivation gives the witness for every preserving coordinate. The complete rung count fixes the word support; holding all directions fixes the level; full labelled products fix the two channel counts; the support successor fixes the return divisor; and the channel share fixes its positive-return orientation. Omitting a carrier changes one of these counts or operations. Adding an extra term introduces a role absent from the exhausted construction.

All coordinates together suffice to execute the terminal fraction and its positive complement. Equality in all ten coordinates fixes one form. Complete product enumeration includes it and every alternative, so the unique survivor is established over the entire declared grammar. The native census modules retain every original candidate and decision; the grammar proofs bind their executable decisions to the complete criteria.

## 8. Full measured-value arithmetic

### 8.1. All original rows and uncertainties

The two original PDG documents [6,7] supply the following complete record:

| Quantity | Central value | Standard uncertainty | Role in the original successor |
|---|---:|---:|---|
| On-shell \(\sin^2\theta_W\) | 0.22342 | 0.00009 | Direct physical comparison |
| Z mass, GeV | 91.1880 | 0.0020 | Shared denominator interval |
| Compatible-input W mass, GeV | 80.3692 | 0.0133 | Independent physical reconstruction |
| All-input W aggregate, GeV | 80.395 | 0.012 | Retained measurement-method record |

For central value \(x\) and uncertainty \(u\), the operation first requires \(x>u>0\) and then returns

\[I(x,u)=[x-u,x+u].\]

For positive mass intervals \(W=[w_-,w_+]\) and \(Z=[z_-,z_+]\), the exact squared-ratio enclosure is

\[Q(W,Z)=\left[\left(\frac{w_-}{z_+}\right)^2,
\left(\frac{w_+}{z_-}\right)^2\right].\]

A positive ratio increases with its numerator and decreases with its denominator, so these endpoint pairings retain both uncertainties. Squaring preserves order on positive parts. A central-value ratio does not replace the complete operation.

### 8.2. Direct on-shell comparison

The complete direct interval is

\[I_S=\left[\frac{22333}{100000},\frac{22351}{100000}\right].\]

Cross-multiplying the exact positive denominators gives

\[\frac{22333}{100000}\leq
\frac{1930922298157999}{8642477221479757}
\leq\frac{22351}{100000}.\]

Thus the exact terminal share is inside the complete registered standard-uncertainty interval. The original comparison uses no uncertainty multiplier.

### 8.3. Compatible W/Z reconstruction

The exact mass intervals are

\[Z=[45593/500,9119/100],\qquad
W_{\rm compatible}=[803559/10000,32153/400].\]

Applying the complete endpoint operation gives

\[Q(W_{\rm compatible},Z)=
\left[\frac{645707066481}{831561610000},
\frac{25845385225}{33259546384}\right].\]

The exact complement satisfies

\[\frac{645707066481}{831561610000}\leq C\leq
\frac{25845385225}{33259546384}.\]

This reconstructs the same sealed squared share from both boson measurements. Common-unit cancellation from Section 3 shows why the dimensionless result does not depend on the chosen common positive rational mass unit.

### 8.4. The complete all-input record

The all-input W interval is

\[W_{\rm all}=[80383/1000,80407/1000].\]

The identical endpoint operation gives

\[Q(W_{\rm all},Z)=
\left[\frac{6461426689}{8315616100},
\frac{6465285649}{8314886596}\right].\]

Arithmetic places \(C\) outside this interval. The original earlier comparison therefore returns the entire vector

\[\bigl(S\in I_S,\ C\in Q(W_{\rm compatible},Z),\
C\in Q(W_{\rm all},Z)\bigr)=(\mathrm{true},\mathrm{true},\mathrm{false}).\]

The later original measured-value source retains this aggregate unchanged, including its uncertainty. Its registered source record identifies the incompatible CDF 2022 input and the published poor consistency when that input is included. Under that source-defined measurement treatment, the aggregate remains a method record; it is not a second physical target. The physical comparisons are the direct on-shell interval and the compatible W/Z reconstruction. Neither the aggregate’s arithmetic nor its source disclosures are deleted or converted into agreement.

The archive retains both validation versions. The successor’s ten-field analysis contains all three intervals, the two physical comparison Booleans, exact partition, and four disclosure/row-retention Booleans. Its source-record validation checks both original document identities and the bound formal receipt. Every actual methodological-boundary key must carry literal true except the measurement-selection flag, which must carry literal false. The source’s observational-derivation provenance is retained.

### 8.5. Original altered-record controls

Changing only the direct central value to \(0.22000\) leaves its uncertainty fixed. The resulting interval \([0.21991,0.22009]\) excludes \(S\), and the direct comparison rejects. Changing only the compatible W central value to \(81\) GeV leaves the original W uncertainty and Z record fixed; the resulting squared interval excludes \(C\), and the reconstruction rejects.

`ElectroweakMeasuredAnalysis.originalMeasuredPass`, `originalDirectControl` and `originalCompatibleWControl` prove the executed original and altered-record outcomes. The analysis accepts arbitrary converted rational inputs with the actual interval guards. Its retained 47-case source comparison includes complete ten-field results and errors for signed, zero and rational cases. The record decoder binds the immutable original source and its two specified controls.

## 9. Complete empirical grammars and source binding

Both original validation versions retain their full eight-axis empirical grammar: carrier, relation, provenance, prediction, record, rows, generality and extension. Each product has 256 forms. The preserving form carries the complete Fold record, source-bound proof trace, measurement-inaccessible prediction, separate measurement record, all source rows, declared successor closure and no added rule. The exact relation coordinate differs between the original complete comparison vector and the later source-defined measured-value test.

Completeness quantifies over every combination of axis constructors. The native proof constructs membership in the full product from membership on each two-way axis. The source decision is proved equal to its ordered criteria; all criteria hold exactly for the preserving tuple. The full programs retain candidate identifiers, order, decisions, first-failure reasons, witnesses, closure, controls and unknown-identifier behavior.

The terminal formal fraction is fixed before target release. The original empirical pipeline binds the source snapshot and experiment registration, executes the capability-closed prediction operation, seals its output and trace, then releases the committed target for exact comparison. Source changes, omitted rows, altered uncertainty, a changed formal value or either failed physical comparison reject the successor. The earlier validation receipt is retained as evidence of its own complete calculation; the source’s measured-value closure is carried by the successor.

## 10. Native proofs and reproducibility

The specification is pinned to V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Native source and retained checks are pinned to V4 edition 0.4 commit `21cdf559922fb057f8560f42d056ffa035329eb3` [1–3]. The source files are `lineage_particle_laws.py`, `precision_value_laws_v1.py`, `precision_value_validation_v1.py`, `electroweak_measured_value_successor_v1.py` and its validator under `sft/physics/`, with their actual structural and atomic dependencies.

| Source operation | Native proof family | Retained completion |
|---|---|---|
| All Fold preimages, exact pair and partition | `ElectroweakMixing` | TURN279 |
| Terminal support, fraction, domains and labelled channels | `ElectroweakTerminalSupport`, `ElectroweakTerminalRatio`, `ElectroweakTerminalDomain`, `ElectroweakChannels` | TURN488 |
| Squared W/Z and arbitrary common-unit cancellation | `WZRelation`, `CommonScaleAxis` | TURN869 |
| Original complete three-result comparison | `PrecisionValidationOperations`, `PrecisionValidationWitnesses`, `EWValidation` modules | TURN873 |
| Complete measured-value successor and controls | `ElectroweakMeasuredAnalysis`, `Records`, `Measurement` and entry modules | TURN1056 |

All families are under `SFT.Physics`; the last row’s record and entry module names carry the `ElectroweakMeasured` prefix. The evidence package lists full declaration names and exact source correspondence. It retains 740 distinct audited declarations with empty axiom dependencies, together with existing build, full-program, independent-validator and observation-comparison results. Complete source files and imported native modules accompany the receipts.

The portable arithmetic reproduction executes the unchanged original pure functions with the original structural and atomic imports. It reproduces the complete bare fibre, all sixteen word labels, all charged and neutral channel labels, terminal level and divisor, exact fractions, every measured interval and all ten successor fields. It also reproduces the all-input arithmetic exclusion and both original altered-record controls. General source-domain statements, arbitrary finite product properties and common-unit cancellation are established by the native proof bodies described above.

## 11. Consequences

The exact terminal weak share follows from complete finite supports: four promotion rungs, sixteen binary words, three held directions, 225 charged channels, 784 neutral channels and one return over seventeen. The two complementary fractions partition One and pass the source’s two physical measurements with their full original standard uncertainties. The bare and terminal forms, complete general support proofs, all comparison arithmetic and original source treatment remain explicitly connected. No additional scientific parameter enters the completed construction.

## References

1. Smith, Maria. *SFT V3 physics corpus*. [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655). [Pinned source](https://github.com/MettaMazza/ernos-labs-sft-platform/tree/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1).
2. Smith, Maria. *SFT V3 monograph*. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Operational foundation: [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).
3. Smith, Maria. *SFT native Lean 4 verification*, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Cumulative sections 226, 340, 341, 343, 393, 741, 745 and 951; [pinned proof source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3).
4. Smith, Maria. *Generator three, spatial three and boundary rank two*. [doi:10.5281/zenodo.24325335](https://doi.org/10.5281/zenodo.24325335).
5. Smith, Maria. *The fine-structure constant from first principles: an exact zero-parameter Fold derivation*. [doi:10.5281/zenodo.24324400](https://doi.org/10.5281/zenodo.24324400).
6. Particle Data Group. *Electroweak Model and Constraints on New Physics*, 2025. [Original review](https://pdg.lbl.gov/2025/reviews/rpp2025-rev-standard-model.pdf), printed pages 19 and 23.
7. Particle Data Group. *W-boson listing*, 2024. [Original listing](https://pdg.lbl.gov/2024/listings/rpp2024-list-w-boson.pdf), printed page 1.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

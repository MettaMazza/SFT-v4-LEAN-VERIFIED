# Dirac squares and Maxwell propagation from one Fold construction

**Maria Smith · Ernos Labs**  
Standalone paper 38 · Version 1.0 · 18 November 2026  
DOI: 10.5281/zenodo.24327162

## Abstract

The same generated binary and spatial counts close the two-hand Dirac square, the complete three-plus-one square and both planar and three-space Maxwell curvatures. The two-hand construction returns \((p,m,E^2)=(3/5,4/5,1)\); the four-component construction closes at One by both direct summation and polarization, retaining both empty equal-difference records. For every exact source and radius \(0<q<r\leq1\), the Coulomb operation returns field \(q/r^2\), reconstructs flux \(q\) through its two successive radius multiplications, and retains positive potential \(1-q/r\). For every rational speed \(0<v<1\), the electric remainder \(1-v^2\) is positive and satisfies \(F(1-v^2)=1-F(v^2)\). A finite descent proves that no admitted rational speed square lies at the exceptional half-One boundary. Every positive exact electric force then decomposes into retained share \(f(1-v^2)\) and motion-held share \(fv^2\), whose sum is exactly \(f\). Planar and spatial curvature records both give speed square One. We derive the complete records and their general proofs, exhaust the original candidate grammars, and retain the separate sealed PDG, CODATA and APS correspondence with its original measurement conditions. Eight source entries have 784 audited declarations with empty axiom dependencies.

**Keywords:** Dirac square; Maxwell propagation; Coulomb law; Gauss flux; magnetic correction; Lorentz transfer; exact rational dynamics; Smithian Fold Theory; Lean 4.

## 1. One source construction, several exact closures

Let \(b\) be the generated binary count and \(d\) the generated spatial count. The retained dependency chain gives

\[b=2,\qquad b<d<b^2,\qquad d=3.\]

The complete binary word support at depth \(k\) has \(2^k\) cells: the singleton empty-word base is doubled by appending each of the two distinct held labels once to every prior word. The generator unit part is \(u_k=1/(2^k-1)\). At the binary period, \(u_2=1/3\), and its complete first return is \(1/3\mapsto2/3\mapsto1/3\), of length two. The next positive candidate is three; \(u_3=1/7\) has the complete trace \(1/7\mapsto2/7\mapsto4/7\mapsto1/7\), whose intermediate parts are distinct and whose first return has length three. The source derives the binary count as the positive predecessor of that independently returned count, giving \(b=3-1=2\).

The spatial enumeration retains every positive count strictly between the fibre count \(b\) and its complete ordered pair-cell count \(b^2\). With \(b=2\), its entire admitted set is \(\{3\}\). The source checks that this singleton equals the independent first-return count. Holding one source-normal direction then gives boundary rank \(3-1=2\), and restoring that direction reconstructs three. These exact dependency operations fix the binary, planar and spatial counts used throughout this paper.

The common exact-part operation is Fold:

\[F(x)=\begin{cases}2x,&0<x\leq1/2,\\2x-1,&1/2<x\leq1.\end{cases}\]

Self-junction doubles the part; complete-One cast retains the result in \((0,1]\), with an exact full turn represented by One. Orientation is a held label. Equal oriented differences return an empty structural record. These original operations determine the subsequent square, field and transfer records.

The principal closures are

\[\left(\frac35\right)^2+\left(\frac45\right)^2=1,\]
\[4\left(\frac12\right)^2=\frac{(1/2+1/2)^2+(1/2+1/2)^2}{2}=1,\]
\[\frac{q}{r^2}\,r\,r=q,\qquad f(1-v^2)+fv^2=f,\]
\[c_D^2=\frac{bD}{Db}=1\quad(D=2,3).\]

Sections 2–7 derive these equations from the complete source operations, including their input domains, intermediate steps and returned fields. The general magnetic and force statements quantify over every positive rational carrier satisfying the original strict speed bound. The source labels its two square constructions as Dirac closures and its curvature constructions as Maxwell closures; their exact content is developed explicitly here.

Original V3 operations are in `relativistic_field_laws_v1.py`, with their admitted count and field dependencies [1,2]. Native proofs and evidence are pinned to V4 edition 0.4 [3]. Native declaration names below use the prefix `SFT.Physics` unless stated otherwise.

## 2. The generated two-hand Dirac square

The two-hand operation derives all three counts before constructing its fractions:

\[\mathrm{three}=d=3,\qquad\mathrm{four}=b^2=4,\qquad\mathrm{five}=d+b=5.\]

Its momentum and mass carriers are

\[p=\frac{d}{d+b}=\frac35,\qquad m=\frac{b^2}{d+b}=\frac45.\]

The source squares the two carriers and adds them:

\[p^2=\frac9{25},\qquad m^2=\frac{16}{25},\]
\[E^2=p^2+m^2=\frac{9+16}{25}=\frac{25}{25}=1.\]

Its complete returned record is \((p,m,E^2)=(3/5,4/5,1)\). The original equality guard is evaluated on the assembled energy square. The fractions are obtained from the generated counts; no measured mass or momentum is an input.

`TwoHandDirac.twoHandDiracSquare` calls the actual binary and spatial operations. `sourceAssembly` unfolds them using `AlphaCovers.binaryCountTwo` and `SpatialStability.spatialDimensionThree`, then proves the complete record. `everyReturnedSquare` establishes for every returned result both its reconstructed sum-of-squares identity and its energy-square field equality. The source’s two operational witnesses expose the parts and the square separately.

## 3. The complete three-plus-one square by two routes

### 3.1. Direct accumulation

The spatial count three together with the substance hand gives four components. Each is the same reciprocal of the generated binary count,

\[h=1/b=1/2,\qquad\mathbf h=(h,h,h,h).\]

The original direct operation begins with the first square and appends each of the other three squares in order:

\[D_1=h^2=\frac14,\]
\[D_2=D_1+h^2=\frac12,\quad D_3=D_2+h^2=\frac34,\quad D_4=D_3+h^2=1.\]

Every component is retained, and each contributes once.

### 3.2. Polarized accumulation and held differences

The two equal-component pair sums are both \(h+h=1\). Their present polarized squares give

\[P_{\rm present}=(h+h)^2+(h+h)^2=1+1=2,\]

and division by the generated binary count gives \(P=P_{\rm present}/b=1\).

The source’s oriented difference operation is

\[\Delta(a,b)=\begin{cases}(),&a=b,\\(\mathrm{left},a-b),&a>b,\\(\mathrm{right},b-a),&b>a.\end{cases}\]

For unequal carriers the retained magnitude is positive, and the label records orientation. At the two compared equal pairs,

\[\Delta(h,h)=(),\qquad\bigl(\Delta(h,h),\Delta(h,h)\bigr)=((),()).\]

Both empty records remain explicit. The complete four-field output is

\[\left((1/2,1/2,1/2,1/2),\ 1,\ ((),()),\ 1\right),\]

in the order components, direct square, held equal differences and polarized square. `FullDiracSquare.sourceAssembly` proves this entire output from the generated binary count. `everyCompleteCell` proves the four-component count, both One closures and both empty records for every returned cell. The complete source cell therefore preserves the same two routes whenever it is replicated.

## 4. Coulomb response, Gauss flux and positive retained potential

The original exact input domain is

\[0<q<r\leq1,\]

with exact rational source \(q\) and radius \(r\). The operation forms the rank-two response

\[E(q,r)=\frac{q}{r^2}.\]

The original executable order reconstructs flux through two multiplications:

\[\Phi_1=Er=\frac qr,\qquad\Phi=\Phi_1r=q.\]

Associativity and exact normalization preserve this order. In numerator/denominator coordinates \(q=a/b\), \(r=c/d\),

\[E=\frac{ad^2}{bc^2},\qquad Er=\frac{ad}{bc},\qquad(Er)r=\frac ab=q.\]

All denominator factors are positive. Cancelling their common factors in reduced representations leaves the same exact values. `CoulombGauss.sequentialFluxReturnsSource` connects the two successive multiplications to the existing `InverseSquare.conservedAtEveryScale` theorem.

The retained potential is

\[V=1-\frac qr.\]

The strict source order gives \(ad<bc\), hence \(q/r=ad/(bc)<1\). If exact normalization represents this quotient as \(u/v\), value preservation gives \(ad\,v=u\,bc\). Were \(u\geq v\), that equality would contradict \(ad<bc\). Thus \(u<v\), and the actual positive difference is

\[V=\frac{v-u}{v}>0.\]

`quotientBelowOne` and `retainedPotentialPositive` prove these inequalities over arbitrary admitted positive carriers. `admittedSourceRecord` proves the complete returned record

\[\left(E,\Phi,V\right)=\left(\frac{q}{r^2},q,1-\frac qr\right).\]

The field magnitude can exceed One; the radius and source are ordered parts, while the response is a positive exact magnitude. The two original examples retain all intermediate scales:

| Source \(q\) | Radius \(r\) | \(E=q/r^2\) | \(Er\) | Flux \((Er)r\) | \(V\) |
|---|---|---|---|---|---|
| \(1/8\) | \(1/4\) | \(2\) | \(1/2\) | \(1/8\) | \(1/2\) |
| \(1/8\) | \(1/2\) | \(1/2\) | \(1/4\) | \(1/8\) | \(3/4\) |

`innerSourceRecord` and `outerSourceRecord` prove the original full outputs. Equal or reversed source/radius order, a nonpositive carrier, radius above One or a nonfraction radius fails the source boundary. The rank-two response and conserved source are fixed before the external Coulomb exponent comparison.

## 5. Magnetic correction for every admitted rational speed

### 5.1. Positive exact partition

Let \(v=n/d\) with positive integers \(n<d\). The source sets

\[t=v^2=\frac{n^2}{d^2},\qquad C(v)=1-t=\frac{d^2-n^2}{d^2}.\]

Since \(n^2<nd<d^2\), both parts are positive. Their exact sum is

\[t+C(v)=\frac{n^2+d^2-n^2}{d^2}=1.\]

Normalization preserves that equality. `MagneticSourceProofs.squareProper`, `exactPartition` and `positiveRemainder` prove these statements on every original rational speed.

### 5.2. Why the half-One branch cannot occur

The Fold-complement relation requires the two complementary parts to avoid simultaneous half-One. The speed domain itself excludes that possibility. Suppose

\[v^2=\frac12,\qquad d^2=2n^2,\]

for positive integers \(n,d\). An odd square is odd because

\[(2k+1)^2=2(2k^2+2k)+1.\]

Therefore even \(d^2\) forces \(d=2k\). Substitution and cancellation give

\[4k^2=2n^2,\qquad n^2=2k^2.\]

The new equation has the same form with leading count \(n\). Moreover \(n<d\): if \(d\leq n\), then \(d^2\leq n^2<2n^2=d^2\), a contradiction. The new \(k\) is positive because \(d=2k\) and \(d>0\). Strong induction on the positive leading count therefore excludes the original equation. `MagneticSquare.noHalfSquare` carries out this exact finite descent without requiring a reduced starting fraction.

### 5.3. Fold covariance in both branches

If \(t<1/2\), then \(1-t>1/2\), and

\[F(t)=2t,\qquad F(1-t)=2(1-t)-1=1-2t=1-F(t).\]

If \(t>1/2\), then \(1-t<1/2\), and

\[F(t)=2t-1,\qquad F(1-t)=2(1-t)=1-(2t-1)=1-F(t).\]

The preceding descent excludes \(t=1/2\) for every admitted rational speed. Hence

\[\forall v\in\mathbb Q,\ 0<v<1:\qquad F(1-v^2)=1-F(v^2).\]

`MagneticCovariance.foldComplement` proves the two positive count branches and exact normalized subtraction. `MagneticSourceProofs.everyOriginalSpeed` then proves that the complete source operation succeeds for every positive numerator and larger denominator. `everyPositiveFraction` states the same result for the exact positive-fraction carrier. The complete output retains speed square, electric remainder and folded remainder.

At \(v=1/2\), the output is \((1/4,3/4,1/2)\). At \(v=1/3\), it is \((1/9,8/9,7/9)\). Both original witnesses are direct instances of the general argument.

## 6. Lorentz transfer conserves every positive source force

Let \(f=a/b>0\) be any exact force magnitude and let \(v=n/d\) satisfy the original rational speed domain. The source calls the magnetic operation and retains

\[f_{\rm retained}=f(1-v^2)=\frac{a(d^2-n^2)}{bd^2},\]
\[f_{\rm motion}=fv^2=\frac{an^2}{bd^2}.\]

Both shares are positive. Adding them reconstructs the supplied force:

\[f_{\rm retained}+f_{\rm motion}=\frac{a(d^2-n^2)+an^2}{bd^2}=\frac{ad^2}{bd^2}=\frac ab=f.\]

The force has no upper-One restriction. The decomposition preserves its supplied exact value and introduces no independently chosen magnetic-force magnitude. The full record is retained force, motion share and source force.

`LorentzSourceProofs.exactSourceRecomposition` proves the exact rational sum. `everyOriginalTransfer` proves the complete successful output for arbitrary positive \(a,b,n\) and \(n<d\). `everyPositiveForceAndSpeed` connects those arguments to every admitted positive force and speed carrier.

The original witness uses \(f=1/4\), \(v=1/2\):

\[f_{\rm retained}=\frac14\frac34=\frac3{16},\qquad f_{\rm motion}=\frac14\frac14=\frac1{16},\]
\[\frac3{16}+\frac1{16}=\frac14.\]

The source guards reject a nonpositive or nonexact supplied force and every speed outside the admitted exact sub-One domain.

## 7. Planar and three-space Maxwell propagation

For a registered dimension \(D\), the spatial curvature counts the binary curvature at each axis, while the temporal curvature is the same binary count:

\[K_s=bD,\qquad K_t=b.\]

The total curvature ratio and per-axis speed square are

\[R_D=\frac{K_s}{K_t}=D,\qquad c_D^2=\frac{K_s}{DK_t}=\frac{bD}{Db}=1.\]

The original admitted dimensions are the generated boundary rank two and spatial count three. Their complete returned records are:

| \(D\) | Spatial curvature | Temporal curvature | Total ratio | Speed square |
|---:|---:|---:|---:|---:|
| 2 | 4 | 2 | 2 | 1 |
| 3 | 6 | 2 | 3 | 1 |

Thus changing from the plane to the complete three-space carrier changes the total curvature while preserving the same per-axis propagation square. Positive propagation selects speed One from that square.

`MaxwellCurvature.planarSource` and `spatialSource` prove both full records by unfolding the generated binary, boundary and spatial counts. `exactAcceptedDomain` proves that every successful admitted count input is exactly one of these two cases with its corresponding record. `everyReturnedOneSpeed` consequently proves the speed-square equality for every successful original input. The source dimension guard rejects all other integral dimensions. This is the complete planar/three-space curvature construction.

## 8. Exhaustive grammars and retained source behavior

Each of the seven formal entries uses the complete ordered product of eight binary form axes, giving \(2^8=256\) candidates per entry. The common preserving coordinates are:

| Axis | Preserved source condition |
|---|---|
| Carrier | Generated exact Fold count, part, word or held label |
| Dependency | Admitted V3 dependency chain |
| Relation | The complete claim-specific closure derived above |
| Enumeration | Every combination of the registered axis choices |
| Minimality | Rejection of every named omission |
| Measurement | Formal result sealed before external comparison |
| Record | Complete trace, census, decisions and original controls |
| Extension | No extra rule or selector |

Each axis has its original rejected alternative: imported carrier, asserted prerequisite, failed relation, selected candidate neighborhood, uncontrolled omission, target-visible prediction, answer-only record or free extra rule. The first failing source condition determines the rejection reason. A candidate survives exactly when every preserving coordinate is present, so the all-preserving tuple is the unique survivor. Native grammar proofs exhaust the candidate constructors and connect this conjunction to the original decisions.

The claim-specific closure is substantive. The two-hand and full-square entries retain their complete generated cells and all returned identities. Coulomb closure is proved for every ordered exact source and radius. Magnetic closure is proved for every rational sub-One speed, including the finite descent that removes the half boundary. Lorentz transfer preserves every positive supplied force. Maxwell closure exhausts both original dimensions and every successful output. Replication retains the same complete source records; no extra scale, fitted coefficient or measured target selects the formal result.

The original source controls and full program methods retain registration, complete candidate order, decisions, closure records, canonical identities and refusal of unknown identifiers. The independent validators accept each original program and reject candidate omission, an additional survivor and a failed control. Existing native builds and raw axiom audits accompany these source-specific results.

## 9. The sealed physical correspondence

### 9.1. The complete external record

The original field comparison opens a source-bound record after the formal results are sealed. The shared record binds twelve formal claims, seven external sources and five original interpretation controls. This paper’s field entry selects the complete relativistic/electromagnetic classification from that record. Its one registered target retains the entire classification label.

The field-relevant observations are the CODATA invariant vacuum-speed record and electric/magnetic observable families, the PDG Dirac/Lorentz framework, and the APS Coulomb exponent experiment. The record also retains its shared NIST spectral, interference and nonlinear-mixing rows and PDG radiative-calculation row. All seven source identities and all five controls remain in the supplied archive.

The CODATA 2022 table gives

\[c=299\,792\,458\ \mathrm{m\,s^{-1}},\]

exact by the SI definition [4]. The formal curvature construction yields normalized speed One; the CODATA entry supplies the external dimensional record. The PDG review retains Dirac fermion masses, Dirac matrix structure, and gauge and Lorentz invariance [5]. These source classes are compared with the already sealed square and field constructions.

### 9.2. The complete Coulomb exponent interval

Williams, Faller and Hill test the form \(1/r^{2+\epsilon}\) and report [6]

\[\epsilon=(2.7\pm3.1)\times10^{-16}.\]

Writing the exact reported decimals over a common denominator gives

\[\epsilon\in\left[\frac{-4}{10^{17}},\frac{58}{10^{17}}\right].\]

Consequently the complete positive exponent interval is

\[2+\epsilon\in\left[\frac{199999999999999996}{10^{17}},\frac{200000000000000058}{10^{17}}\right].\]

The formal exponent two lies inside this interval because its numerator \(200000000000000000\) lies strictly between the two endpoints. The signed experimental offset is retained as reported measurement data. The exact positive inverse-square exponent is the formal derivation’s output. The comparison preserves the original uncertainty without a confidence reinterpretation.

### 9.3. Retained interpretation and validation

The square records \((3/5,4/5)\) and four half-One components are exact Fold closure coordinates. The external PDG record concerns physical Dirac/Lorentz structure; it does not assign those fractions as universal measured particle coordinates. The CODATA speed entry supplies the exact SI dimensional value, while sections 1 and 7 give the independent Fold curvature derivation.

The shared source record additionally preserves three controls for its other classifications: the listed Fold oscillator fractions are not universal measured NIST atomic energies; optical operation classes do not equate every material amplitude or susceptibility with half-One; and renormalized radiative predictions do not directly measure the finite-versus-continuous substrate distinction. These five original controls remain part of the complete external record and its classification.

The original evaluator compares the sealed prediction label with the registered source classification. It does not fit the rational square coordinates or substitute an interval regression for that comparison. Source guards verify the main record identity, twelve-claim seal boundary, all seven source rows, four bound component snapshots and all five controls. The prediction program executes on its sealed premise; the target vault releases the committed record only after the prediction seal. Package audit, target identity and all comparison rows enter the complete validation output. A deliberately altered unfavorable-control classification is rejected, and a second prediction seal is refused.

`FieldAuthoritativeRecords.authoritativeRecord` and `fieldClassification` preserve the original source checks. `RelativisticFieldValidationValidation.validateExternal` connects the classification to the complete capability, package, custody and comparison pipeline. The observational grammar is another full 256-form product, retaining source-bound proof trace, separate measurement record, all rows, successor closure and no extra rule. Together, the seven formal grammars and this empirical grammar contain \(8\cdot256=2048\) candidate records.

## 10. Native source correspondence and reproducibility

The original V3 commit is `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`; the native V4 evidence is pinned to `21cdf559922fb057f8560f42d056ffa035329eb3` [1–3]. The principal operations are in `relativistic_field_laws_v1.py`; the external classification is in `relativistic_field_validation_v1.py`, using the original shared empirical protocol. Binary/spatial dependencies come from `atomic_constants.py`, `structural_constants.py` and their corresponding native proofs.

| Source operation | Principal native result | Completion evidence |
|---|---|---|
| Two-hand square | `TwoHandDirac.sourceAssembly`, `everyReturnedSquare` | TURN886 |
| Full square | `FullDiracSquare.sourceAssembly`, `everyCompleteCell` | TURN887 |
| Coulomb/Gauss closure | `CoulombGauss.admittedSourceRecord` | TURN888 |
| Magnetic correction | `MagneticSourceProofs.everyOriginalSpeed` | TURN889 |
| Lorentz transfer | `LorentzSourceProofs.everyPositiveForceAndSpeed` | TURN890 |
| Planar Maxwell | `MaxwellCurvature.planarSource` | TURN891 |
| Three-space Maxwell | `MaxwellCurvature.spatialSource`, `everyReturnedOneSpeed` | TURN892 |
| Sealed external comparison | `FieldAuthoritativeRecords`, `RelativisticFieldValidationValidation` | TURN896 |

The eight receipts retain complete source-program comparisons, candidate decisions, original controls, independent-validator results and affected native builds. Their 784 distinct audited declarations have empty axiom dependencies. Source correspondence includes applicable module digests and full declaration names.

The archive contains 388 native source/import modules, 71 original source/binding files, retained verification and portable exact reproduction. The reproduction executes the unchanged original functions for all nine square/field/force/curvature outputs, preserves eight input rejection cases, verifies the original component snapshot identities, and displays the exact APS interval arithmetic. The native proofs supply the general quantified statements; the source reproduction preserves the original complete operational records.

## 11. Consequence

The generated counts \(b=2\) and \(d=3\) determine both Dirac square constructions and both Maxwell curvature records. Exact rank-two response reconstructs every supplied Coulomb source. The rational-speed descent and complementary Fold branches establish magnetic covariance throughout the admitted speed domain, and multiplication by every positive force preserves the complete transfer partition. Both original propagation dimensions close at the same normalized speed One. The separately sealed external record retains invariant-speed, Dirac/Lorentz, electromagnetic and inverse-square correspondence with its complete measurement conditions.

## References

1. Smith, Maria. *SFT V3 physics corpus*. [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655). [Pinned original source](https://github.com/MettaMazza/ernos-labs-sft-platform/tree/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1).
2. Smith, Maria. *SFT V3 monograph*. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Operational foundation: [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).
3. Smith, Maria. *SFT native Lean 4 verification*, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Cumulative sections 758–764 and 768; [pinned native source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3).
4. NIST/CODATA. *2022 recommended values of the fundamental physical constants*, complete registered table. [Original table](https://physics.nist.gov/cuu/Constants/Table/allascii.txt). The pinned snapshot retains the exact SI speed and original electromagnetic rows.
5. Particle Data Group. *Electroweak Model and Constraints on New Physics*, 2025 review. [Original review](https://pdg.lbl.gov/2025/reviews/rpp2025-rev-standard-model.pdf). The pinned snapshot retains Dirac/Lorentz and radiative-calculation statements.
6. Williams, E. R., Faller, J. E., and Hill, H. A. “New Experimental Test of Coulomb’s Law: A Laboratory Upper Limit on the Photon Rest Mass.” *Physical Review Letters* 26, 721–724 (1971). [doi:10.1103/PhysRevLett.26.721](https://doi.org/10.1103/PhysRevLett.26.721). The complete reported exponent and uncertainty are retained in the pinned source record.
7. NIST shared source vector: [Atomic Spectra Database version history](https://physics.nist.gov/PhysRefData/ASD/Html/verhist.shtml); [photon interference](https://www.nist.gov/news-events/news/2019/12/new-playbook-interference); [nonlinear optical synthesis](https://www.nist.gov/publications/nonlinear-networks-arbitrary-optical-synthesis), [doi:10.1103/PhysRevX.13.021027](https://doi.org/10.1103/PhysRevX.13.021027); [PPLN frequency conversion](https://tf.nist.gov/ofm/synthesis/ppln.htm). These identities remain in the original seven-source classification record.

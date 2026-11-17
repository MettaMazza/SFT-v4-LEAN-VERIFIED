# One construction for quark and lepton mass ratios and mixing

**Maria Smith · Ernos Labs**  
Standalone paper 11 · Version 1.0 · 17 November 2026  
DOI: 10.5281/zenodo.24326116

## Abstract

A common exact overlap operation generates the complete quark and lepton alignment matrices from their Fold mass and channel fibres. Their first rows return the respective generating locks, two-thirds and half-One. All three lepton sites share a two-operation return through half-One to One. At every positive depth \(d\), binary-by-generator support \(N_d=2\cdot3^d\) forces the heavy-to-light ratio \(N_d-1\); complete position–shortfall reversal preserves every symmetric observable. The terminal transport of the quark-root mixing graph yields four CKM predictions that pass their complete registered three-standard-uncertainty comparisons. Half-One transport gives a baryon-to-photon ratio near \(6.14612312138\times10^{-10}\), inside the registered primordial-abundance interval and overlapping the Planck-derived interval. The colour-composite dressing gives a proton/electron ratio near \(1836.152673425313\), whose exact enclosure lies inside the registered CODATA standard-uncertainty interval. This paper derives the complete construction, including its intermediate counts, cubic graphs, root refinement, terminal transport, complete candidate grammars and native Lean proofs. The terminal laws retain their original observational-derivation provenance and measurement-inaccessible prediction execution.

**Keywords:** quark masses; lepton masses; CKM matrix; baryon-to-photon ratio; proton-electron mass ratio; exact arithmetic; Smithian Fold Theory; Lean 4.

## 1. The results and their common carriers

The construction begins with the complete binary Fold fibre, \(b=2\), and the first nontrivial generator period, \(c=3\). It uses complete finite products of these carriers. No mass, mixing angle, cosmological abundance or measured proton/electron value enters the executable relations. The structural chain comprises seven laws: baryon-residue transport, common mixing construction, the all-depth mass-ratio family, mirror closure, row coupling, common generation return, and lightest-carrier confinement lift. Three terminal laws transport the completed electromagnetic carrier into CKM, baryon abundance and the proton/electron ratio.

The common alignment operation is

\[A(x,q)=1-|x-q|.\]

Applying it to every generated mass/channel pair produces all nine entries in each sector. The distinction between the two sectors is carried by their generated sites and locks; the overlap operation is identical. The resulting matrices are

\[Q=\frac19\begin{pmatrix}8&5&2\\7&8&5\\4&7&8\end{pmatrix},\qquad
L=\frac16\begin{pmatrix}5&3&1\\5&5&3\\3&5&5\end{pmatrix}.\]

Three consequences are already visible in these complete carriers. First, the first-row sums are \(5/3\) and \(3/2\), leaving their respective locks when one complete One is held. Second, lepton positions reverse under the One-complement. Third, all three positions share the same ordered pair of return operations. Sections 2–5 derive these statements and the general mass-ratio theorem. Sections 6–10 transport the exact cubic graphs into the terminal comparisons.

The pinned specification is Maria Smith’s V3 physics source [1,2]. Native definitions and proof terms are retained in V4 edition 0.4 [3]. Each source-defined law has its own complete program, grammar, controls and completion receipt; their correspondence is given in Section 12.

## 2. Generated support and the electromagnetic carrier

### 2.1. Binary and generator-three support

On an admitted exact part \(0<x\leq1\), Fold acts by

\[F(x)=\begin{cases}2x,&x\leq1/2,\\2x-1,&x>1/2.\end{cases}\]

The retained endpoint is One. Thus half-One maps to One and One returns to itself. The generator-three cycle is

\[\frac17\longmapsto\frac27\longmapsto\frac47\longmapsto\frac17.\]

The three states are distinct before return, so the first return has length three. The original generator construction and complete carrier derivation are developed in [4]; here the actual first-return operation supplies \(c=3\) to every subsequent count. Binary count comes from the complete two-word Fold support, giving \(b=2\).

The first binary covers of colour volume and its successor are

\[2^4<3^3=27\leq2^5,\qquad2^6<3^4=81\leq2^7.\]

Consequently the down and up cover depths are five and seven. Their difference is exactly the binary count, \(7-5=2\). These depths determine the later quark dressing and the terminal proton transport.

### 2.2. Complete finite electromagnetic promotion

The original electromagnetic blocks are tower \(2^7=128\), boundary \(3^2=9\) and cover \(2\cdot5^3=250\). Promoting each of three cover directions once gives the full ordered ladder

\[5^3=125,\quad5^2\cdot7=175,\quad5\cdot7^2=245,\quad7^3=343.\]

The terminal effective cover and inverse coupling are

\[C=250+\frac1{175+\dfrac1{245+\dfrac1{343}}},\qquad
A=128+9\frac{C+1}{C},\qquad\alpha=A^{-1}.\]

Every count is generated before any comparison. The terminal alpha object used below is this complete finite expression, not a fitted decimal. The full electromagnetic derivation and precision comparison are developed in [5]. The present calculation evaluates the same original `fine_structure_blocks`, `promotion_rungs`, `effective_cover` and `inverse_fine_structure` functions and reuses their native proofs.

## 3. One complete alignment construction

### 3.1. Mass sites, channel sites and all matrix cells

For \(i,j\in\{1,2,3\}\), the channel fibre and the two mass fibres are

\[q_j=\frac j3,\qquad m_i=\frac{3i-1}{9},\qquad
\ell_i=\frac{2i-1}{6}.\]

Thus

\[q=(1/3,2/3,1),\quad m=(2/9,5/9,8/9),\quad
\ell=(1/6,1/2,5/6).\]

For the first quark row, the three differences from the channel sites are \(1/9,4/9,7/9\). Their One-complements give \((8/9,5/9,2/9)\). For the second row the differences are \((2/9,1/9,4/9)\), and for the third they are \((5/9,2/9,1/9)\). This yields every entry of \(Q\).

For the first lepton row, the differences are \((1/6,1/2,5/6)\), yielding \((5/6,1/2,1/6)\). The second row has differences \((1/6,1/6,1/2)\); the third has \((1/2,1/6,1/6)\). Their complements yield every entry of \(L\). Both matrices contain the full \(3\times3\) product; no cell is selected or independently normalized.

`MixingCorrespondence.alignmentMatrix` applies the original operation to every supplied mass site and generated channel site. `completeLeptonAlignment` proves the complete lepton output; `completeSourceRecord` retains both matrices, both locks and both original classifications. `CKMFibres` supplies the original quark matrix.

### 3.2. The exact generating locks

Let \(T(x)\) triple an exact part and repeatedly hold One while the result exceeds One. The three lepton traces are

\[T(1/6)=1/2,\qquad T(1/2)=3/2-1=1/2,\]
\[T(5/6)=5/2-1-1=1/2.\]

For the quark sites the same operation gives

\[T(2/9)=2/3,\quad T(5/9)=5/3-1=2/3,\quad
T(8/9)=8/3-1-1=2/3.\]

The source therefore retains the quark classification “generator-orbit-lock” and the lepton classification “self-antipodal-balance-lock.” The matrices use the same overlap; their generating locks are \(2/3\) and \(1/2\).

The native repeated-subtraction implementation is related to the original loop by `trimCorrespondence`. For positive denominator \(d\), each subtraction step reduces the numerator by \(d\) until it is at most \(d\). Induction on the evaluation allowance constructs the complete `TrimRun`: the stop case has no further subtraction, and the successor records the actual subtraction followed by the induction hypothesis. The supplied allowance exceeds the starting numerator, so it covers every such descent. The original operation also retains its behavior on zero, negative and above-One rational arguments; the three physical traces above use the declared positive parts.

### 3.3. Complete row coupling and common generation depth

The first quark row sums to

\[\frac89+\frac59+\frac29=\frac{15}{9}=\frac53,\]

and holding One leaves \(2/3\). The first lepton row sums to

\[\frac56+\frac36+\frac16=\frac96=\frac32,\]

and holding One leaves \(1/2\). These are precisely the independently generated locks. `MixingRowCoupling.completeSourceRecord` proves all four returned fields: both sums and both residues.

Each lepton site then follows the same two operations:

\[\ell_i\xrightarrow{T}\frac12\xrightarrow{F}1\qquad(i=1,2,3).\]

The initial sites remain distinct. The waypoint and home are shared. The source counts the ordered operations, giving depth two for every generation. `GenerationDepth.firstStage`, `secondStage` and `twoStages` establish the full three-trace record and its count.

## 4. Every positive depth and every symmetric observable

### 4.1. General mass-ratio theorem

For every positive integer \(d\), let

\[N_d=2\cdot3^d,\qquad l_d=\frac1{N_d},\qquad
h_d=\frac{N_d-1}{N_d}.\]

Since \(N_d>1\), both parts are positive. Their sum is

\[l_d+h_d=\frac{1+N_d-1}{N_d}=1.\]

Division by the positive light part gives

\[\frac{h_d}{l_d}=\frac{(N_d-1)/N_d}{1/N_d}=N_d-1.\]

The base is \(N_1=6\), so the first ratio is five. The successor is

\[N_{d+1}=3N_d,\qquad R_{d+1}=3(R_d+1)-1=3R_d+2.\]

Thus the partition and ratio identity hold at every successor, yielding \(5,17,53,161,485,1457,\ldots\). These are consequences of the general formula, not a finite table defining it. The original routine admits positive integer depths and rejects booleans, zero and negative counts.

`MassRatioFamily.supportPositive` and `supportBeyondOne` prove the support conditions by induction. `exactComplementRatio` proves normalized rational division for every positive support. `completeEveryPositiveDepth` rewrites the actual count, power, predecessor and division operations to establish the complete five-field source result for every input \(d+1\): support, light, central half-One, heavy and heavy/light. The theorem therefore includes the actual operation and its accepted positive-depth domain.

### 4.2. Mirror closure and arbitrary symmetric invariants

The complete position carrier is

\[P=(1/6,1/2,5/6).\]

Its One-shortfalls are

\[S=(1-1/6,1-1/2,1-5/6)=(5/6,1/2,1/6)=\operatorname{rev}(P).\]

The central half maps to itself and the outer pair exchange. Both sums are \(3/2\). More generally, for any codomain \(E\) and any observable \(g\) on lists of exact rational parts satisfying

\[g(\operatorname{rev}(x))=g(x)\quad\text{for every list }x,\]

one obtains

\[g(S)=g(\operatorname{rev}(P))=g(P).\]

This is exactly the quantified statement of `MirrorMassClosure.everySymmetricInvariant`. Its hypothesis is reversal invariance; it does not require a numerical observable or a particular polynomial. Every symmetric invariant satisfies that hypothesis. `exactReverse` proves the complete carrier identity and `bothCompleteSums` proves the two sums.

## 5. Channel invariants, cubic roots and confinement

### 5.1. Forced cubic coefficients

The lower-hand factor is \(1/b^2=1/4\). Complete up support has \(c+c=6\) channels and down support has \(c+1=4\). Their pair sums agree by two routes:

\[s_u=\frac1{2\cdot6}=\frac14\frac13=\frac1{12},\qquad
s_d=\frac1{2\cdot4}=\frac14\frac12=\frac18.\]

The down reach is the already generated upper cover depth seven. The up reach appends three, giving ten. Complete predecessor products are

\[p_d=\frac1{3\cdot2^7-1}=\frac1{383},\qquad
p_u=\frac1{3\cdot2^{10}-1}=\frac1{3071}.\]

For any three positions \(r_0,r_1,r_2\), multiplying their three factors gives

\[\prod_{i=0}^{2}(x-r_i)=x^3-(r_0+r_1+r_2)x^2+(r_0r_1+r_0r_2+r_1r_2)x-r_0r_1r_2.\]

The expansion retains the one triple-\(x\) choice, all three single-root choices, all three root-pair choices and the complete root triple. Substituting root sum One and the generated pair and product invariants fixes every coefficient. The normalized cubic graphs are therefore

\[d^3-d^2+\frac d8-\frac1{383}=0,\qquad
u^3-u^2+\frac u{12}-\frac1{3071}=0.\]

Write their ordered positive roots as \(d_0<d_1<d_2\) and \(u_0<u_1<u_2\). The implementation retains polynomial coefficients and exact rational isolating intervals. It evaluates the two positive sides \(x^3+sx\) and \(x^2+p\), storing their ordering and positive difference rather than a signed proof magnitude.

### 5.2. Complete isolation and narrowing

At successive dyadic depths the original program scans every adjacent cell from the first positive grid point through One. An exact root or change of side records a bracket. The first complete grid that separates all three roots is retained. A bisection tests the exact midpoint and keeps the half whose endpoint sides preserve the root, or the exact midpoint singleton when the sides agree there.

The terminal quark comparison refines all brackets until every width is at most \(10^{-15}\). The proton comparison uses the lepton cubic

\[x^3-x^2+\frac x6-\frac1{485}=0\]

The original proton base uses the leading lepton product: two fibre-labelled fifth colour supports have \(2\cdot3^5=486\) positions, whose positive predecessor is 485. Pairing both fibres with all three positions gives pair sum \(1/(2\cdot3)=1/6\). Substitution in the same complete symmetric expansion fixes this cubic. The proton specification retains this leading cubic as its base while applying its own terminal composite dressing; the separately sharpened charged-lepton product in [6] is a distinct source operation.

The proton comparison refines until the first two widths are at most \(10^{-18}\). All three brackets are carried at each refinement. `TerminalQuarkRoots.refinementCorrespondence` and `TerminalProtonComparison.refinementCorrespondence` inductively relate successful native evaluation to the original uncapped refinement loops. Their stop constructors contain the actual width test; their successor constructors contain the actual bisection followed by the rest of the run. The retained exact runs prove that the original stopping conditions are reached.

### 5.3. Sharpened products and the lightest-carrier lift

At depth \(d\), binary-by-colour support has predecessor \(2\cdot3^d-1\). Holding one channel part \(1/3\) gives the sharpened product

\[P_d=\frac1{(2\cdot3^d-1)-1/3}.\]

At the independently generated down and up depths,

\[P_5=\frac1{485-1/3}=\frac3{1454},\qquad
P_7=\frac1{4373-1/3}=\frac3{13118}.\]

The complete two-fibre lift is \(b=2\) and acts once on the lightest unclosed generation. The retained carrier record keeps central and heavy generations unchanged. `ConfinementLift.completeSourceRecord` proves both products, the lift, the acted carrier and the complete retained pair. These sharpened products are the source’s confinement record; the terminal CKM graph below continues to consume its original registered cubic-root graph.

## 6. Terminal CKM transport

### 6.1. Leading graph and its completed carrier

Define the exact positive quantities

\[X=\left(\frac{d_0}{d_1}\right)^2,\qquad
T_0=\frac{d_1}{d_2}-\frac{u_1}{u_2}.\]

The source’s down central lift and upper-up retention are

\[\frac{A+2}{A},\qquad\frac{A}{A+7}.\]

The CKM terminal operation carries one electromagnetic share through all three colour channels with the already generated upper-up retention:

\[\varepsilon=\frac{\alpha}{3}\frac{A}{A+7}
=\frac1{3(A+7)}.\]

The equality follows by substituting \(\alpha=1/A\) and cancelling the positive \(A\). The exact returned fraction is

\[\varepsilon=\frac{3676744786}{1588750826913}.\]

The completed slope and squared graph are

\[T=T_0+\varepsilon,\qquad Y=T^2,\qquad Z=\frac{XY}{6},\]
\[s_{12}^2=X,\quad s_{23}^2=Y,\quad s_{13}^2=Z,\]
\[J^2=X(1-X)Y(1-Y)Z(1-Z)^2.\]

The phase is the original half-One and the six-channel denominator is \(bc=6\). The terminal step preserves the original \(s_{12}\) relation and transports the completed slope through both \(s_{13}\) and the CP-square graph. `TerminalCKM.exactContribution` and `completeSourceRecord` prove the exact contribution and all six original relation fields.

### 6.2. Exact interval propagation

For positive intervals \(a=[a_-,a_+]\) and \(b=[b_-,b_+]\),

\[\left(\frac ab\right)^2\subseteq
\left[\left(\frac{a_-}{b_+}\right)^2,
\left(\frac{a_+}{b_-}\right)^2\right].\]

The slope bounds use the lowest down slope minus the highest up slope, and conversely, then add the same exact \(\varepsilon\) to both. The executed lower slope exceeds \(10^{-9}\), so squaring preserves endpoint order. Multiplying the positive \(X,Y\) intervals and dividing by six gives \(Z\).

For \(0\leq x\leq y<1/2\),

\[y(1-y)-x(1-x)=(y-x)(1-x-y)\geq0.\]

This justifies the endpoint order used for \(X(1-X)\) and \(Y(1-Y)\); the original upper endpoints both lie below half-One. For the third factor, the source retains the enclosing products

\[[Z_-(1-Z_+)^2,\ Z_+(1-Z_-)^2].\]

Multiplying all three positive factor intervals yields the complete rational \(J^2\) enclosure. `TerminalCKMComparison.completePredictions` proves all four exact returned intervals. Their full numerators and denominators are retained in the source archive and reproduction output; the mathematical endpoint operations are given here in full.

### 6.3. Every registered CKM row

For source value \(v\) with lower and upper standard uncertainties \(\sigma_-,\sigma_+\), the original comparison is against

\[[(v-3\sigma_-)^2,(v+3\sigma_+)^2].\]

The original values and uncertainties are:

| Quantity | Central value | Lower uncertainty | Upper uncertainty |
|---|---:|---:|---:|
| \(s_{12}\) | 0.22501 | 0.00068 | 0.00068 |
| \(s_{23}\) | 0.04183 | 0.00069 | 0.00079 |
| \(s_{13}\) | 0.003732 | 0.000085 | 0.000090 |
| \(J\) | 0.0000312 | 0.0000012 | 0.0000013 |

All four comparisons use the complete asymmetric uncertainty record [7]. The resulting exact overlap tests all pass. No row is omitted and no uncertainty is changed. The following decimal displays are rounded presentations of the exact rational enclosures.

| Squared quantity | Lower prediction (decimal) | Upper prediction (decimal) | Complete overlap |
|---|---:|---:|---|
| \(s_{12}^2\) | 0.05132537213967944616625319 | 0.05132537213968370475207323 | yes |
| \(s_{23}^2\) | 0.001719414466773355924247577 | 0.001719414466773542230646405 | yes |
| \(s_{13}^2\) | 0.00001470826456158183215825944 | 0.00001470826456158464624481258 | yes |
| \(J^2\) | 1.229224624276083326360183E-9 | 1.229224624276547953356453E-9 | yes |

The terminal specification is an observational derivation: the earlier CKM comparison was visible during construction of the successor. Its executable relation uses only the admitted counts, root graph and electromagnetic carrier; prediction execution seals the result before the registered target record is released for comparison. This is the original source protocol.

## 7. Half-One transport and baryon abundance

The complete binary fibre divides the CP-square carrier into a retained half and its antipodal half. If an admitted part equals its own One-complement, then

\[h=1-h\quad\Longrightarrow\quad2h=1\quad\Longrightarrow\quad h=1/2.\]

`CPPhase.uniqueSelfAntipodal` establishes this unique part on the exact source carrier. Thus the original baryon transport is

\[\eta=\frac12J^2.\]

Its terminal successor consumes the completed CKM graph from Section 6 and preserves the same share:

\[\eta_{\rm terminal}=\frac12X(1-X)Y(1-Y)Z(1-Z)^2.\]

No abundance scale or efficiency is introduced. The native complete prediction divides both exact \(J^2\) endpoints by two. It yields

\[6.1461231213804\times10^{-10}<\eta<6.1461231213828\times10^{-10},\]

where the displayed bounds are rounded outward from the retained rational enclosure.

The original primordial-abundance interval is strictly

\[5.8\times10^{-10}<\eta<6.3\times10^{-10}.\]

The original Planck-derived row is \((6.12\pm0.04)\times10^{-10}\), hence \([6.08,6.16]\times10^{-10}\) [8]. The entire predicted enclosure lies strictly inside the first interval and overlaps the second. `TerminalBaryon.completePrediction` and `TerminalBaryonMeasurement.originalClassification` prove the executed prediction and its complete registered comparison. The source keeps the leading transport record and the terminal successor as distinct records with the same unique half-One share.

## 8. Proton/electron ratio from the colour composite

### 8.1. The retained algebraic base

Let \(e<\mu<\tau\) denote the ordered roots of the lepton cubic in Section 5. Its normalized mass carriers are their squares. The admitted proton relation is

\[R_3=\frac13\frac{\mu^2-e^2}{e^2\mu^2}
=\frac13\left(\frac1{e^2}-\frac1{\mu^2}\right).\]

The equality follows by a common positive denominator. Both terms therefore consume the same original lepton polynomial; the proton relation does not introduce independent mass inputs. The charged-lepton construction and its full mass comparisons are developed in [6].

### 8.2. Complete composite dressing

The colour-composite depth is \(c=3\). Section 4 gives the heavy complement

\[2\cdot3^3-1=53.\]

The complete colour bulk and its carried boundary channels give support

\[3^3+3=27+3=30.\]

One electromagnetic action at each of the two charged Fold ends contributes \(\alpha^2\). The leading complete self-coupling is therefore \((53/30)\alpha^2\). Its sole terminal return transports both Fold labels through down depth five and colour volume twenty-seven:

\[\frac2{5\cdot27}\alpha=\frac2{135}\alpha.\]

Combining the leading action and its terminal return gives

\[\delta=\frac{53}{30}\alpha^2\left(1+\frac2{135}\alpha\right).\]

The exact operation holds this positive dressing from One. The returned retention \(r\) obeys

\[r+\delta=1,\qquad10^{-6}<\delta<10^{-3},\qquad r>0.\]

The terminal mass ratio is

\[R_4=R_3r=R_3\left[1-\frac{53}{30}\alpha^2
\left(1+\frac2{135}\alpha\right)\right].\]

`TerminalProton.completeDressing`, `completeRetention`, `retainedClosure` and `originalDressingBounds` establish the actual computed values, exact closure and original positive bounds. `completeSourceRecord` proves all nine fields, including the base identifier, depth, complement, bulk/boundary support, order, transport, dressing, retention and result graph.

### 8.3. Complete uncertainty comparison

With root brackets \([e_-,e_+]\) and \([\mu_-,\mu_+]\), the complete base enclosure is

\[\left[\frac13\left(e_+^{-2}-\mu_-^{-2}\right),
\frac13\left(e_-^{-2}-\mu_+^{-2}\right)\right].\]

Multiplying both endpoints by positive \(r\) gives the terminal enclosure. The exact computation gives

\[1836.1526734253126<R_4<1836.1526734253131.\]

These displayed bounds are rounded outward. The original CODATA row [9] is

\[1836.152673426\pm0.000000032,\]

so its standard-uncertainty interval is

\[[1836.152673394,\ 1836.152673458].\]

The complete rational prediction enclosure is contained in that interval. `TerminalProtonComparison.completeSourceRatio` proves the source output, and `TerminalProtonMeasurement.originalClassification` proves containment against the complete registered source row.

The terminal law retains the original observational-prediction protocol: observation informed the successor law, while its executed relation contains only the admitted exact carriers and is sealed before target release. The earlier undressed proton non-overlap remains in the source record. It is not replaced by the terminal comparison. The terminal calculation changes the specified composite transport and then tests that version against the original full uncertainty.

## 9. Exhaustive construction, uniqueness and closure

### 9.1. The nine eight-axis laws

The seven structural laws and the terminal CKM and baryon laws each generate the complete product of eight binary axes: \(2^8=256\) forms per law. Seven axes are shared; the relation axis carries the actual law-specific operation.

| Axis | Preserving form | Rejected alternative |
|---|---|---|
| Carrier | Generated exact carrier | Imported parameter table |
| Dependency | Admitted root trace | Prior answer as premise |
| Relation | Complete operation in the table below | Its specified loss or substitution |
| Enumeration | Complete product | Selected subset |
| Minimality | Every omission rejected | Uncontrolled shortcut |
| Measurement | Seal before comparison | Target visible before sealing |
| Record | Polynomial, trace, census and controls | Answer only |
| Extension | No extra rule | Free additional selector |

| Law | Preserving relation | Rejected relation |
|---|---|---|
| Baryon transport | Sealed CP square through half-One | Measured abundance or free efficiency |
| Common mixing | One alignment law, two generated locks | Two independent fitted matrices |
| Mass-ratio family | Complete support/complement at every depth | Finite list or measured masses |
| Mirror closure | Position–shortfall reversal | Independent position and mass tables |
| Row coupling | First-row residue returns its lock | Independent row normalization |
| Generation return | Tripling followed by Fold | Generation-specific coupling depths |
| Confinement lift | Channel sharpening, one binary light lift | Measurement-selected rescaling |
| Terminal CKM | Slope gap plus retained colour alpha share | Unused dependency or selected mixing shift |
| Terminal baryon | Terminal CP square through half-One | Leading graph or imported abundance |

The preserving operation is necessary because each rejected relation loses the stated original count, carrier, route or retained distinction. The calculations in Sections 3–8 exhibit that failure concretely: incomplete products omit matrix cells; a selected finite ratio list does not supply the positive-depth recurrence; separate position tables lose the reversal identity; independent row scales break the recovered locks; generation-specific steps alter the complete shared traces; target-selected rescaling changes the fixed confinement action; unused terminal retention leaves a declared CKM carrier untransported; and an imported abundance changes half-One transport.

Sufficiency follows by composing the generated carrier with the exact operation, its complete witnesses and its applicable successor proof. Equality in all eight coordinates fixes the preserving form. Complete product enumeration contains that form and every alternative, establishing the unique survivor in each declared grammar. This uniqueness is the source’s complete construction result with the original domains and axes retained.

### 9.2. The complete terminal proton grammar

The proton successor has eleven binary axes and therefore \(2^{11}=2048\) complete forms.

| Axis | Preserving choice | Other choice |
|---|---|---|
| Base | Retain admitted proton graph | Replace or refit base |
| Depth | Generator-three composite | Selected depth |
| Complement | Complete depth-three predecessor 53 | Free multiplicity |
| Order | One alpha per charged Fold end | Selected alpha order |
| Support | Complete colour bulk plus boundary | Partial bulk or boundary |
| Terminal | One terminal alpha successor | Leading only or extra series |
| Transport | Both labels through down depth and volume | Free return weight |
| Orientation | Hold dressing from existing ratio | Append unbound mass |
| Target | Measurement inaccessible to relation | Measurement-readable relation |
| Provenance | Registered observational prediction | Unregistered target-readable fit |
| Extension | No extra rule | Additional fit term |

The complete typed support gives \(53,30,2\) and \(2/135\) by the derivations in Section 8. Omitting any of those carriers changes the corresponding count or exhausts only part of the stated construction. The base and its normalization are preserved by holding the dressing; appending a new mass would change that operation. Once both charged ends, the complete bulk/boundary support and the sole terminal return are transported, the declared first-terminal grammar has no additional successor. The complete preserving tuple therefore supplies the operation and closure, while every other tuple fails at least one original axis.

### 9.3. Complete comparisons and controls

Each of the three empirical comparisons also retains its complete eight-axis, 256-form grammar: carrier, relation, provenance, prediction, record, rows, generality and extension. The preserved record includes every source row, uncertainty, prior adverse result and custody field required by its original specification. The CKM successor appends each of four rows without selection; baryon transport retains both cosmological intervals; proton refinement narrows the same root enclosure without changing the law or uncertainty.

All ten source programs retain the original false-premise, tampered-source, tampered-artifact and boundary controls. Their full candidate lists, decisions, witnesses and closure outputs are included in the evidence archive. The retained empirical validators include the actual registered source identities and complete comparison outcomes. Formal completion and empirical comparison are recorded separately.

## 10. Exact arithmetic and reproducibility

All displayed predictions are evaluated through positive counts, exact fractions and rational intervals. The underlying algebraic objects remain specified by their cubic identities. Root brackets are refined by exact side comparison; no floating root is substituted into a proof. Decimal numbers in the result tables are presentations of exact fractions, and the displayed narrow bounds in Sections 7 and 8 are rounded outward.

The portable reproduction executes the unchanged pinned original pure functions with their original structural and atomic imports. It reproduces all ten returned record groups, the two complete alignment matrices, mirror and return traces, six displayed ratio-family values, confinement products, terminal transport fractions, all four CKM intervals, both cosmological comparisons and the terminal proton containment. The all-depth and arbitrary-observable results use the general proof terms described above; they are not inferred from the displayed finite examples.

The archive retains the original source files, execution and dependency bindings, native source with imported modules, full-program comparisons, independent-validator outcomes, build records and empty-axiom audits. Source and evidence digests identify the exact artifacts associated with the completed entries. The original build evidence is reused for unchanged native source.

## 11. Consequences of the common construction

The same generated counts and exact operations connect the mass and mixing chain. Complete overlap produces both alignment matrices; row residues recover their generating locks; one tripling action and one Fold action return every lepton site home. The mass-ratio family holds at every positive depth, and mirror closure preserves every reversal-invariant observable. Terminal electromagnetic transport completes the quark mixing graph, whose CP square supplies the baryon prediction through the unique half-One share. The same depth-three complement and complete colour support determine the proton dressing. The resulting CKM, baryon and proton comparisons retain their complete registered observations and uncertainty arithmetic.

## 12. Native source correspondence

V3 is pinned to `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`; V4 source and retained verification are pinned to `21cdf559922fb057f8560f42d056ffa035329eb3`. The principal original files are `matter_flavour_laws_v1.py`, `matter_flavour_completion_laws_v1.py`, `matter_flavour_terminal_ckm_laws_v1.py`, `matter_flavour_terminal_proton_laws_v1.py` and their original execution and validation bindings under `sft/physics/`.

| Original operation | Native declaration family | Completion receipt |
|---|---|---|
| Half-One baryon transport | `BaryonPhotonTransport.completeSourceRelation` | TURN931 |
| Complete alignment and locks | `MixingCorrespondence.completeSourceRecord` | TURN932 |
| Every positive mass-ratio depth | `MassRatioFamily.completeEveryPositiveDepth` | TURN933 |
| Mirror and arbitrary invariant | `MirrorMassClosure.everySymmetricInvariant` | TURN934 |
| Complete first-row residues | `MixingRowCoupling.completeSourceRecord` | TURN935 |
| Three complete two-stage traces | `GenerationDepth.completeSourceRecord` | TURN936 |
| Sharpened products and acted carrier | `ConfinementLift.completeSourceRecord` | TURN937 |
| Terminal mixing and four comparisons | `TerminalCKM`, `TerminalQuarkRoots`, `TerminalCKMComparison`, `TerminalCKMMeasurement` | TURN938 |
| Terminal baryon interval and comparisons | `TerminalBaryon`, `TerminalBaryonMeasurement` | TURN939 |
| Composite dressing, root run and containment | `TerminalProton`, `TerminalProtonComparison`, `TerminalProtonMeasurement` | TURN940 |

All declaration families above are under `SFT.Physics`. Entry-specific `Witnesses`, `Grammar`, `Controls` and `Evidence` modules retain each complete scientific program. The three terminal entries also retain their empirical grammar, experiment, witness, evidence and validation modules. The accompanying correspondence file lists full paths, exact receipt names, source hashes and every audited declaration. The ten receipts cover 1331 distinct declarations with empty axiom dependencies.

## References

1. Smith, Maria. *SFT V3 physics corpus*. [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655). [Pinned original source](https://github.com/MettaMazza/ernos-labs-sft-platform/tree/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1).
2. Smith, Maria. *SFT V3 monograph*. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Operational foundation: [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).
3. Smith, Maria. *SFT native Lean 4 verification*, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Cumulative sections 803–812; [pinned native source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3).
4. Smith, Maria. *Generator three, spatial three and boundary rank two*. [doi:10.5281/zenodo.24325335](https://doi.org/10.5281/zenodo.24325335).
5. Smith, Maria. *The fine-structure constant from first principles: an exact zero-parameter Fold derivation*. [doi:10.5281/zenodo.24324400](https://doi.org/10.5281/zenodo.24324400).
6. Smith, Maria. *Charged-lepton mass ratios and the exact Koide invariant from Fold geometry*, version 1.1. [doi:10.5281/zenodo.24325169](https://doi.org/10.5281/zenodo.24325169).
7. Particle Data Group. *CKM Quark-Mixing Matrix*, 2025. [Original registered review](https://pdg.lbl.gov/2025/reviews/rpp2025-rev-ckm-matrix.pdf).
8. Particle Data Group. *Big-Bang Cosmology*, 2025. [Original registered review](https://pdg.lbl.gov/2025/reviews/rpp2025-rev-bbang-cosmology.pdf), equation 22.55 and Planck-derived baryon-density translation.
9. NIST/CODATA. *2022 recommended values of the fundamental physical constants*. [Original complete table](https://physics.nist.gov/cuu/Constants/Table/allascii.txt), proton-electron mass ratio.

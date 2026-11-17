# Twelve Smithion mass-ratio predictions and the dark-to-baryonic abundance from Fold geometry

**Maria Smith** · Ernos Labs  
Standalone paper 14 · Version 1.0 · 17 November 2026 · DOI: 10.5281/zenodo.24324894

## Abstract

Smithian Fold Theory generates four penta/hepta cubics, twelve mass-ratio predictions, a neutral lightest relic class and the exact dark-to-baryonic abundance 27/5. The complete prime-sector ladder is 2, 3, 5, 7. Transporting the admitted coloured product to sectors five and seven, with both down/up kinds, forces cover depths 7, 10, 9 and 12 and product \(p/[p(2p^d-1)-1]\). Complete enumeration of the 1,024-cell rational grid isolates three positive roots for each cubic; sixty exact halvings give all twelve retained root enclosures. The complete sector fibre is neutral, and the unique least root supplies the stable lightest singlet in the closed sector/generation construction. Generated lepton preimages and mode separations independently yield flavour weights 1/32, 5/96 and 5/24, hence 3:5:20 and a same-parent tau-channel ratio four. Generator volume 27 and its least binary cover 32 give baryonic and dark shares 5/32 and 27/32. The exact ratio 27/5 lies inside the complete registered Planck density-ratio interval, and transport of the central baryonic density gives 0.12096 inside [0.119, 0.121]. All four spectra, exact intermediate steps, complete grammars and original SPARC and lepton-flavour search records are presented with native Lean 4 source correspondence and zero-axiom verification.

**Keywords:** Smithion; dark matter; dark-to-baryonic ratio; penta hepta sectors; particle mass spectrum; lepton flavour violation; Smithian Fold Theory; Lean 4; Planck density ratio.

## 1. Principal predictions

For each \(p\in\{5,7\}\) and \(k\in\{\mathrm{down},\mathrm{up}\}\), the source generates one normalized cubic
\[
 x^3-x^2+S_{p,k}x-P_{p,k}=0.
\]
Its exact coefficients and least cover depths are:

| Sector | Kind | Depth | Root sum | Pair sum | Product |
|---|---|---:|---:|---:|---:|
| 5 | down | 7 | 1 | 1/8 | 5/781244 |
| 5 | up | 10 | 1 | 1/20 | 5/97656244 |
| 7 | down | 9 | 1 | 1/8 | 7/564950490 |
| 7 | up | 12 | 1 | 1/28 | 7/193778020806 |

Each cubic has three positive, disjoint root brackets. The mass-ratio vector normalizes the light member to One and retains the original two-fibre lift for the heavier members. If \(x_1<x_2<x_3\), the three entries are
\[
 \left(1,\frac{x_2^2}{2x_1^2},\frac{x_3^2}{2x_1^2}\right).
\]
Sections 3–5 give the exact construction and all twelve predictions, including a compact table from which every rational endpoint follows directly.

The same generated support gives
\[
 f_b=\frac5{32},\qquad f_d=\frac{27}{32},\qquad
 \frac{\rho_d}{\rho_b}=\frac{27}{5},\qquad
 \frac{\rho_m}{\rho_b}=\frac{32}{5}.
\]
The flavour-transition weights are
\[
 (w_{\mu e},w_{\tau\mu},w_{\tau e})
 =\left(\frac1{32},\frac5{96},\frac5{24}\right),
 \qquad w_{\mu e}:w_{\tau\mu}:w_{\tau e}=3:5:20.
\]
The registered Planck comparison passes both the full density-ratio test and the transported-density test. The original experimental records contain null radiative lepton-flavour searches and no measured Smithion masses; Sections 8–9 retain their exact values and classifications alongside the predictions [1–4].

## 2. Generated counts and the closed sector ladder

The operational starting point retains occurrence and complete One. Equal complementary positive parts give half-One. Fold acts on positive parts through One by doubling below half-One and retaining the positive remainder above it:
\[
 F(x)=\begin{cases}2x,&0<x\le1/2,\\2x-1,&1/2<x\le1.\end{cases}
\]
Its primitive classification selects the unique least generating singleton: identity and square are injective, constant One has no nonstatic return, and Fold is noninjective with a nonstatic cycle. A generating singleton also bounds the minimum nonempty word length at one. Thus the singleton classification establishes least-word uniqueness over every finite admitted primitive word [4].

Complete binary support doubles by appending both labels to every earlier word. Induction gives \(2^d\) distinct words at depth \(d\). The predecessor unit parts produce
\[
 1/3\mapsto2/3\mapsto1/3,
 \qquad1/7\mapsto2/7\mapsto4/7\mapsto1/7.
\]
The first return lengths are two and three, with no earlier return in either trace. The least generated count beyond the binary period is therefore three. The spatial stability window is strictly above the two fibres and strictly below their four ordered pair cells; its sole integer is also three. The source consequently uses generator \(g=3\), binary count \(b=2\), and three spatial directions.

For the generator-successor volume,
\[
 3^4=81,\qquad 2^6=64<81\le128=2^7.
\]
The least binary cover has depth seven. This generated upper depth is the original sector ceiling. Enumerate every integer from two through seven and retain those with no proper divisor. Four and six are composite; the complete prime ladder is
\[
 \mathcal P=\{2,3,5,7\}.
\]
The next prime eleven is outside the generated ceiling. `PrimeSectorLadder.completeTests`, `completeLadder` and `nextPrimeExcluded` prove the complete original decisions.

A sector \(p\) has \(p\) charge roles. Its complete pair-cell support has \(p^2\) positions and mediator predecessor \(p^2-1\). The retained coupling is \((p-1)/p\), and its mass part is \(1/p\). Thus the original inventory is

| Sector | Mediators | Coupling | Mass part | Coupling / mass part |
|---|---:|---:|---:|---:|
| 2 | 3 | 1/2 | 1/2 | 1 |
| 3 | 8 | 2/3 | 1/3 | 2 |
| 5 | 24 | 4/5 | 1/5 | 4 |
| 7 | 48 | 6/7 | 1/7 | 6 |

The two new sectors are the penta and hepta sectors, five and seven. Both down/up kinds and every generated root position are retained, giving \(2\times2\times3=12\) Smithion entries. No extra sector, independent coupling or mass scale is appended.

## 3. The transported coloured cubic

### 3.1. The complete support and product

At sector \(p\) and depth \(d\), two fibre-labelled colour supports contain \(2p^d\) positions. Their positive predecessor is \(2p^d-1\). Retain one sector-channel part \(1/p\) from this denominator and take the reciprocal:
\[
 P(p,d)=\frac1{(2p^d-1)-1/p}
 =\frac{p}{p(2p^d-1)-1}.
\]
This is the admitted coloured construction transported without changing its roles. At the earlier colour sector \(p=3\), it returns
\[
 P(3,5)=\frac3{1454},\qquad P(3,7)=\frac3{13118}.
\]
`ConfinementLift.bothProducts` retains these two independently admitted values. `SmithionSpectrum.theoremCertificate` checks their equality with the transported family before retaining the new-sector spectra.

The normalized root sum remains One. The down pair carrier distributes One over complete binary support at generator depth, giving \(1/2^3=1/8\). The up pair carrier retains the binary pair-cell support and its sector label, giving \(1/(2^2p)=1/(4p)\). Thus
\[
 S_{p,\mathrm{down}}=\frac18,\qquad
 S_{p,\mathrm{up}}=\frac1{4p}.
\]
The cubic retains the complete three-position symmetric expansion
\[
 (t-x_1)(t-x_2)(t-x_3)
 =t^3-(x_1+x_2+x_3)t^2
 +(x_1x_2+x_1x_3+x_2x_3)t-x_1x_2x_3.
\]
The three single, three pair and one triple terms occur exactly once, together with the leading term. Inserting the generated sum, pair sum and product fixes the entire polynomial.

### 3.2. The four least cover depths

The down volume is \(p^3\), and the up volume is \(p^4\). The source chooses the least positive binary depth containing each volume. The complete inequalities are
\[
\begin{aligned}
 64<5^3=125&\le128 &&\Rightarrow d_{5d}=7,\\
 512<5^4=625&\le1024 &&\Rightarrow d_{5u}=10,\\
 256<7^3=343&\le512 &&\Rightarrow d_{7d}=9,\\
 2048<7^4=2401&\le4096 &&\Rightarrow d_{7u}=12.
\end{aligned}
\]
Strict growth of binary powers excludes every smaller depth. Substitution into \(P(p,d)\) gives the four products in Section 1. `SmithionInvariants.originalDepths` proves the ordered vector \((7,10,9,12)\); its original operations call the existing generated-count and least-cover definitions.

## 4. Complete rational root enumeration

The source retains the cubic as equality of two positive hands:
\[
 x^3+Sx=x^2+P.
\]
If the left hand is larger, record its positive difference; if the right is larger, record the opposite positive difference. Equality is represented by the structural empty record. This is the exact `cubic_side` operation, translated as `SmithionRoots.cubicSide`.

The full grid contains all 1,024 positive upper endpoints \(j/1024\), \(j=1,\ldots,1024\). The initial lower endpoint is structural empty with counter-hand \(P\). The scan processes every endpoint in order, retains every change of side and handles an exact equality explicitly. It rejects any result other than exactly three brackets. It therefore retains the full grid, including the first cell containing the smallest roots; no selected neighbourhood is searched.

For a retained bracket \([l,u]\), the midpoint is \((l+u)/2\), or \(u/2\) when the lower endpoint is structural empty. An exact midpoint equality yields a point bracket. Otherwise the side comparison retains the half containing the change of side. The source performs sixty exact halvings for every bracket. Four native theorems, `SmithionRoots0.originalCompleteRoots` through `SmithionRoots3.originalCompleteRoots`, prove the entire returned vectors from the full grid and the original sixty-step recursion.

Every final endpoint can be written with the common denominator
\[
 H=2^{70}=1180591620717411303424.
\]
The twelve intervals are exactly \([n/H,(n+1)/H]\), with numerators:

| Sector / kind | First root numerator \(n_1\) | Second root numerator \(n_2\) | Third root numerator \(n_3\) |
|---|---:|---:|---:|
| 5 down | 60471533426286918 | 172820649824972217329 | 1007710499359012799176 |
| 5 up | 1208950653683681 | 62317906542732519332 | 1118272505224025100410 |
| 7 down | 117024738198375 | 172893498686722081059 | 1007698005005951023988 |
| 7 up | 1194129051641 | 43788083075121748877 | 1136803536448160502905 |

All first numerators are positive, every bracket has width \(1/H\), and the brackets are disjoint and ordered. Exact opposite sides retain a root in each interval; the three disjoint roots exhaust the degree-three polynomial. The full native certificate checks positive endpoints, all four generation counts and the unique least root in each spectrum. `SmithionWitnesses.witness1Passed` and `witness2Passed` evaluate these actual constructions.

## 5. All twelve mass-ratio predictions

The original confinement lift acts on the lightest unclosed generation and retains the central and heavy carriers. Its factor is the two-fibre count. Consequently the light member is normalized to One, and the heavier mass ratios use \(x_i^2/(2x_1^2)\), \(i=2,3\). This is the specific source mass convention implemented by `ConfinementLift.completeCarrierSelection` and `SmithionRoots.massRatioEnclosures`.

With the complete integer table above, every exact heavier interval is
\[
 \boxed{\left[\frac{n_i^2}{2(n_1+1)^2},
 \frac{(n_i+1)^2}{2n_1^2}\right]},\qquad i\in\{2,3\}.
\]
The common denominator \(H\) cancels. Together with \([1,1]\) for each first member, this formula and the table specify all twenty-four mass-ratio endpoints exactly. Positivity makes the outward division valid: the upper denominator gives the lower ratio and the lower denominator gives the upper ratio.

For convenient reading, the complete vectors are approximately:

| Sector / kind | Light member | Central member | Heavy member |
|---|---:|---:|---:|
| 5 down | 1 | \(4.083751518\times10^6\) | \(1.388479936\times10^8\) |
| 5 up | 1 | \(1.328552028\times10^9\) | \(4.278072593\times10^{11}\) |
| 7 down | 1 | \(1.091369904\times10^{12}\) | \(3.707451219\times10^{13}\) |
| 7 up | 1 | \(6.723251268\times10^{14}\) | \(4.531461637\times10^{17}\) |

These are dimensionless predictions in the source's light-member normalization. The exact endpoints, not displayed rounded readings, are retained in the source/evidence archive and arithmetic record.

### 5.1. Neutrality and the lightest relic

A complete sector singlet retains all \(p\) charge roles once. `SectorInventory.singletConstituentCount` returns exactly \(p\), and the original relic certificate checks this complete fibre for both new sectors. The electromagnetic channel is empty; the sector channels remain \(4/5\) and \(6/7\), with 24 and 48 mediators and mass parts \(1/5\) and \(1/7\).

For every one of the four spectra, the first interval's upper endpoint lies below the second interval's lower endpoint, which lies below the third's. Thus each spectrum has a unique least root. The source's closed decay carrier consists of the admitted prime sectors, generated down/up kinds, complete neutral fibres and generated ordered root states. Its lightest complete neutral singlet has no lower same-charge image in that carrier. Completeness of the finite sector/kind/root enumeration excludes an omitted generated lower state; neutrality retains the complete fibre. These are the original neutrality and least-state arguments selecting the stable relic class. `SmithionSpectrum.relicCertificate` retains the full ten-field record, including the source's explicit sector/generation domain.

## 6. Abundance from a complete matter partition

Generator three over three directions gives the volume
\[
 V=3^3=27.
\]
The least complete binary cover obeys \(2^4<27\le2^5\), giving depth \(d=5\) and support \(N=32\). The independent count identity \(d=2+3\) agrees with that cover depth. Depth and volume partition the same support:
\[
 \frac dN+\frac VN=\frac5{32}+\frac{27}{32}=1.
\]
Dividing the two retained shares cancels the common normalization:
\[
 \rho_d/\rho_b=V/d=27/5,
 \qquad \rho_m/\rho_b=N/d=32/5.
\]
`SmithionFlavour.originalAbundance` proves the complete seven-field source record: volume, depth, support, both shares and both ratios. No observed density enters it.

The original predecessor entry also retains the first-recursive dark/baryon result. The support predecessor is \(32-1=31\). Its unit part has the complete first-return trace
\[
 \frac1{31}\mapsto\frac2{31}\mapsto\frac4{31}
 \mapsto\frac8{31}\mapsto\frac{16}{31}\mapsto\frac1{31}.
\]
All earlier values differ from the initial part, so the first return has period five. Append its own positive recurrence part to the corresponding depth:
\[
 \frac{27}{5+1/31}
 =\frac{837}{156}=\frac{279}{52}.
\]
`CosmicRatios.darkExact`, `darkLeastCover` and `darkFirstReturn` prove the exact record, minimum cover and complete recurrence. This preserves both original results: the leading partition ratio is \(27/5\), and the first-recursive ratio is \(279/52\). The Smithion abundance certificate and its specified empirical successor use \(27/5\).

## 7. The complete flavour-weight derivation

For a multiplicity \(m\ge2\) and positive image \(y\le1\), the original complete Fold fibre has preimages
\[
 x_j=\frac{y+j}{m},\qquad j=0,\ldots,m-1.
\]
Every preimage is positive and at most One; different indices give different preimages, and \(mx_j=y+j\) verifies return. Appending the next allowed index adds exactly one new preimage. At image half-One and multiplicity three,
\[
 (x_e,x_\mu,x_\tau)=\left(\frac16,\frac12,\frac56\right).
\]
These are the ordered generation coordinates used by the flavour operation. The interior fixed modes solve \(mx=x+j\), so \(x=j/(m-1)\) for \(j=1,\ldots,m-2\). At \(m=5\), the complete modes are \((1/4,1/2,3/4)\). The adjacent separation is \(1/4\); the long separation is \(1/2\).

The source multiplies squared mode separation by the parent generation part:
\[
\begin{aligned}
 w_{\mu e}&=(1/4)^2(1/2)=1/32,\\
 w_{\tau\mu}&=(1/4)^2(5/6)=5/96,\\
 w_{\tau e}&=(1/2)^2(5/6)=5/24.
\end{aligned}
\]
Expressing all three in units of \(1/96\) gives \(3:5:20\). The same-parent tau ratio cancels the parent part and equals
\[
 w_{\tau e}/w_{\tau\mu}=4.
\]
At each admitted sector, the coupling divided by its mass part gives
\[
 \beta_p=\frac{(p-1)/p}{1/p}=p-1,
\]
so the complete ordered slopes are \(1,2,4,6\). `SmithionFlavour.originalLFV` proves the five-field record, including the generation coordinates, all three weights, integer ratio, tau ratio and every sector slope.

## 8. The full registered observational comparison

The original source record retains four sources and six target rows: Planck densities, SPARC galaxy support, three radiative flavour-search channels and Smithion mass-measurement status. All physical observations are opened after the formal result is sealed [2].

### 8.1. Planck density ratio and absolute transport

The registered Planck values are
\[
 \omega_b=0.0224\pm0.0001,\qquad
 \omega_c=0.120\pm0.001,
\]
with the original 68-percent confidence record. Retaining both complete intervals gives
\[
 \frac{\omega_c}{\omega_b}\in
 \left[\frac{0.119}{0.0225},\frac{0.121}{0.0223}\right]
 =\left[\frac{238}{45},\frac{1210}{223}\right].
\]
The exact prediction satisfies
\[
 \frac{238}{45}<\frac{27}{5}<\frac{1210}{223}.
\]
The two cross-product margins are \(27\cdot45-238\cdot5=25\) and \(1210\cdot5-27\cdot223=29\), both strictly positive. The independent comparison-side transport of the central baryonic density gives
\[
 \frac{27}{5}\cdot0.0224=\frac{378}{3125}=0.12096,
 \qquad0.119<0.12096<0.121.
\]
The baryonic density is used here as a released observation, after the dimensionless ratio is fixed. Both original comparison decisions pass.

### 8.2. Galaxy support and search outcomes

The SPARC source retains all 175 disk galaxies and the recorded observed-to-baryonic velocity relation. Low-mass, low-surface-brightness galaxies are submaximal in the retained baryonic comparison. Under the admitted inverse-square relation, the finite baryonic contribution gives \(v_b^2(r)=GM_b(r)/r\); the retained velocity discrepancy supplies additional gravitating support. The source classifies that galaxy result separately from identification of the predicted particle species.

The original radiative search rows are:

| Search | Channel | Observed signal | Branching-fraction upper limit | Confidence |
|---|---|---|---:|---:|
| MEG II 2025 | \(\mu\to e\gamma\) | none | \(1.5\times10^{-13}\) | 90% |
| BaBar 2010 | \(\tau\to\mu\gamma\) | none | \(4.4\times10^{-8}\) | 90% |
| BaBar 2010 | \(\tau\to e\gamma\) | none | \(3.3\times10^{-8}\) | 90% |

The source's relative-weight prediction is \(3:5:20\); these three observations are null-search upper limits. The registered record contains no measured Smithion mass. The complete mass-ratio vectors and flavour-weight ratio therefore remain the exact standing predictions of the formal construction.

`SmithionObservationAnalysis.exactAnalysis` returns all twelve original fields, including both density tests, the complete SPARC record, all three positive null limits, both measurement-status fields and complete source retention. `SmithionObservationAnalysisProofs.originalComplete` proves the complete native result. The changed-density control replaces 0.120 by 0.100 and fails both density tests. The altered-evidence control changes the source's rate-classification flag and fails the evidence-type check. Both controls are required by the native validator; no measured nonzero rate is inserted.

## 9. Exhaustive grammar, induction and source correspondence

The Smithion grammar is the complete product of eleven binary axes: sector, kind, depth, invariant, roots, ratios, relic, abundance, flavour, measurement direction and extension. It contains \(2^{11}=2048\) typed candidates. The preserving constructors require both new prime sectors, both kinds, least covers, the same coloured family, the complete grid and exact halvings, every lifted ratio, the least complete neutral singlet, the common support partition, all squared-separation parent weights, sealed targets and no extra rule.

Every typed candidate has exactly one value on each axis and therefore belongs to the full product. Acceptance requires all preserving constructors; it is equivalent to equality with their unique tuple. `SmithionGrammarBase` and `SmithionGrammar` retain constructor membership, source decisions, original elimination order and uniqueness. Six operational witnesses evaluate the actual product cross-lock, all twelve roots, neutral least states, abundance, flavour weights and beta slopes.

The scientific base is the penta-down cubic, with all three roots and its unique least state. The successor advances through the generated kind and sector enumeration. It changes only the specified pair carrier and least-cover depth; it retains the entire root census, ratio operation, complete fibre and root order. The four-row spectrum is therefore a complete generated census, not four independently chosen examples. Refinement retains every bracket at each successor. The separate abundance predecessor has ten binary axes and 1,024 forms, retaining the complete cover partition and its native first-return extension. The observational successor has eight binary axes and 256 forms, retaining all six target rows and their original evidence classes.

All sources are pinned to V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The native proofs are taken from the published V4 edition 0.4 scientific commit `21cdf559922fb057f8560f42d056ffa035329eb3` [3].

| Component | Native declarations / families | Completion receipt |
|---|---|---|
| Complete matter cover and first recurrence | `CosmicRatios.darkExact`, `darkLeastCover`, `darkFirstReturn` | TURN_483 |
| Four exact cubics and complete root vectors | `SmithionInvariants`, `SmithionRoots`, `SmithionRoots0`–`SmithionRoots3` | TURN_1060_SMITHION_061 |
| Complete spectrum, relic, abundance and flavour | `SmithionSpectrum`, `SmithionFlavour`, `SmithionWitnesses` | TURN_1060_SMITHION_061 |
| Full source record and empirical decisions | `SmithionObservationRecords`, `SmithionObservationAnalysis`, `SmithionObservationValidation` | TURN_1060_SMITHION_OBSERVATION_062 |

The retained records include successful applicable builds, zero-axiom audits, the complete original programme comparisons, 153 invariant/guard outputs, 56 root/ratio outputs and 27 exact observational-analysis outputs. All four full-grid, sixty-halving root equalities have empty axiom dependencies. Independent re-evaluation of the original rational functions reproduces every native root endpoint, all twelve ratio intervals, both density decisions and the full flavour record. The archive retains the original laws, native proof imports, source records, audit/completion receipts and reproducible exact arithmetic.

## 10. Conclusion

The generated sector ceiling, complete prime census and transported coloured construction determine all four Smithion cubics. Their complete rational root enumeration gives twelve exact mass-ratio predictions and unique least states in complete neutral fibres. The same Fold supports yield the dark-to-baryonic ratio 27/5 and flavour weights 3:5:20. The registered Planck density comparisons pass exactly, while the original galaxy and particle-search records retain their distinct observed outcomes. Every construction, intermediate count and comparison is preserved in the pinned V3 source and native V4 evidence.

## References

[1] Maria Smith. Original pinned V3 [dark_smithion_lfv_terminal_law_v1.py](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/dark_smithion_lfv_terminal_law_v1.py), with `sector_inventory_law_v1.py`, `lineage_particle_laws.py`, `particle_mode_generation_terminal_law_v1.py`, `matter_flavour_completion_laws_v1.py` and `cosmology_prior_value_laws.py`. Original code and claim derivations are included in the source archive.

[2] Maria Smith. Original pinned V3 [dark_smithion_lfv_validation_v1.py](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/dark_smithion_lfv_validation_v1.py), empirical registration and `dark-smithion-lfv-postseal-source-record.json`, retained with source identities and all original rows.

[3] Maria Smith. *Smithian Fold Theory: Zero-Axiom, Zero-Free-Parameter Derivations from First Principles — Lean 4 Formal Verification*, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Native proofs include [SmithionRoots](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/SmithionRoots.lean), [SmithionSpectrum](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics/SmithionSpectrum.lean) and their imported proof dependencies.

[4] Maria Smith. Operational foundation, [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656); *Smithian Fold to Physics*, version 1.4, [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655); *Smithian Fold Theory*, original V3 monograph, recorded version 0.4, [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[5] Planck Collaboration. *Planck 2018 results. VI. Cosmological parameters*. [doi:10.1051/0004-6361/201833910](https://doi.org/10.1051/0004-6361/201833910), [arXiv:1807.06209](https://arxiv.org/abs/1807.06209).

[6] F. Lelli, S. S. McGaugh and J. M. Schombert. *SPARC: Mass Models for 175 Disk Galaxies with Spitzer Photometry and Accurate Rotation Curves*. [doi:10.3847/0004-6256/152/6/157](https://doi.org/10.3847/0004-6256/152/6/157), [arXiv:1606.09251](https://arxiv.org/abs/1606.09251).

[7] MEG II Collaboration. *New limit on the muon-to-electron-gamma decay with the MEG II experiment*. [arXiv:2504.15711](https://arxiv.org/abs/2504.15711).

[8] BaBar Collaboration. *Searches for Lepton Flavor Violation in the Decays tau to e gamma and tau to mu gamma*. [doi:10.1103/PhysRevLett.104.021802](https://doi.org/10.1103/PhysRevLett.104.021802), [arXiv:0908.2381](https://arxiv.org/abs/0908.2381).

**Authorship.** Maria Smith originated SFT and its derivations and directs the scientific work. AI assistance supports source-bound manuscript preparation, native translation and verification.

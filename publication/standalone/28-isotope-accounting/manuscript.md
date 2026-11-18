# Nuclide identity and exact isotope accounting through chemical transformation

**Maria Smith**  
Ernos Labs  
Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com)  
SFT community: [discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

Complete branch event counts force a normalized partition whose shares sum exactly to one. Isotope exchange preserves both isotope totals and both carrier totals; equilibrium fractionation and kinetic fractionation follow by exact cancellation of positive ratios. Radiotracer records retain every earlier location, recovery and unobserved amount under any accepted finite extension. Radiochemical separation preserves target and contaminant balance separately, while fission-product redistribution retains its original nuclide-set and total-event conditions. These results share a six-coordinate nuclide carrier that retains element, nucleon count, nuclear state, chemical species, phase and occurrence. Eleven completed source entries provide 67 direct native Lean modules and 1,506 distinct empty-axiom audited declarations. Each original eight-axis grammar is exhaustively classified across all 256 alternatives. This paper gives the mathematical constructions and proofs together with the original measured activity intervals, isotope-ratio vectors, recovery ranges, source methods and retained unresolved outcomes.

## 1. Complete event partitions

A radioactive branch row retains a channel \(c_i\), daughter species \(s_i\), positive event count \(e_i\) and positive recovered count \(r_i\le e_i\). The exact recovery is \(y_i=r_i/e_i\). The complete branch vector is nonempty and its channel identities are distinct. Define

\[
 T=\sum_{i=1}^{m}e_i>0,\qquad p_i=\frac{e_i}{T}.
\]

**Theorem 1 (complete branch normalization).** Every accepted original branch partition has the common denominator \(T\), preserves all original numerators in order, and satisfies

\[
 \sum_{i=1}^{m}p_i=\frac{\sum_i e_i}{T}=\frac{T}{T}=1.
\]

The native operation constructs the positive total once and maps each row to \((e_i,T)\). Induction on the row list proves the numerator sum: the empty sum is zero, and prepending a row adds its event count to both the mapped sum and the original total. Membership induction proves each returned pair has the same denominator. Successful construction identifies that denominator with \(T\). `RadioactiveBranchYield.partitionNumeratorConservation`, `partitionDenominator` and `partitionSumsOne` establish these identities for every successful call [4,5].

The original example has \((e_1,r_1)=(3,2)\) and \((e_2,r_2)=(1,1)\). Recovery on the first branch is \(2/3\); the partition is \((3/4,1/4)\). Adding the original third branch \((2,1)\) gives \(T'=6\), retaining the prior rows and returning

\[
 (p'_1,p'_2,p'_3)=(3/6,1/6,2/6).
\]

Every share uses the new complete total. Duplicate channel identities are rejected even if other row fields differ. The same exact normalization principle applies to the complete fission-product distribution in Section 8.

## 2. Nuclide identity, transformation and activity

The source carrier is

\[
 x=(e,A,s,\chi,\phi,k),
\]

where \(e\) is element identity, \(A>0\) nucleon count, \(s\) nuclear state, \(\chi\) chemical species, \(\phi\) phase and \(k>0\) occurrence. The four held-label families are checked in their corresponding positions. A replacement occurrence \(k'>0\) passes the same constructor and yields

\[
 x'=(e,A,s,\chi,\phi,k'),\qquad \pi(x')=\pi(x),
\]

where \(\pi\) projects the first five coordinates. `NuclideChemicalCarrier.occurrenceReplacement` unfolds the constructor under the accepted-family condition and proves this exact returned record. The original strontium example retains nucleon count 90, its held state, solution species and aqueous phase while changing occurrence one to occurrence two. A source state recorded as unreported remains that record.

A chemical decay edge is

\[
 a=(p,d,\chi_p,\chi_d,c,n),\qquad n>0,
\]

retaining parent, daughter, their two chemical species, channel and event count. Its uniqueness key is \(K(a)=(p,d,c)\). Empty edge support returns structural EmptyOne; a nonempty vector is returned unchanged precisely when its keys are distinct. A repeated transition key is rejected even when species or counts differ. `RadioactiveChemicalTransformation.completeNetworkRetained` reduces the successful uniqueness branch to the full original ordered edge list. Thus the parent and its chemistry remain present when a new daughter edge is appended.

An activity ledger retains held nuclide and species identities with initial count \(I>0\), transformed count \(E>0\), resource-interval count \(T>0\) and the guard \(E\le I\). Its relations are

\[
 A=\frac{E}{T},\qquad
 R=\begin{cases}I-E,&E<I,\\\mathrm{EmptyOne},&E=I.\end{cases}
\]

For \((I,E,T)=(5,2,3)\), activity is \(2/3\) and retained amount is three. At \((2,2,1)\), the remainder is structural absence. At \((5,3,3)\), activity is one. `ActivityAmountTime.activityCountedRatio` preserves the raw positive numerator and denominator; `fullyTransformed` substitutes \(I=E\), reduces \(E-E=0\) and returns the structural branch. The rational view divides numerator and denominator by their greatest common divisor without changing the ratio.

## 3. Radiochemical equilibrium over the complete interval word

Each interval retains one parent/daughter pair, positive rank \(i\), positive parent and daughter event counts \(P_i,D_i\), and a common positive resource count \(T_i\). Therefore

\[
 A_P(i)=P_i/T_i,\qquad A_D(i)=D_i/T_i,
\]
\[
 q_i=\frac{A_D(i)}{A_P(i)}
 =\frac{D_i/T_i}{P_i/T_i}=\frac{D_i}{P_i}.
\]

Cancellation is valid because \(T_i,P_i>0\). The source requires interval ranks exactly \((1,\ldots,m)\) and the same parent/daughter pair throughout. It computes all reduced \(q_i\). Empty support or a nonconstant ratio vector returns EmptyOne. A constant vector at \(q=1\) returns `secular-One-ratio`; a constant vector at \(q\ne1\) returns `transient-held-ratio`, together with the exact ratio.

This gives an explicit finite decision: normalize each pair using \(g_i=\gcd(D_i,P_i)\), then compare \((D_i/g_i,P_i/g_i)\) across every row. The original transient vector \((P,D)=(2,4),(3,6)\) has \(q_i=2\), and appending \((4,8)\) retains that value. The secular vector \((2,2),(3,3)\) has \(q_i=1\). Replacing the second transient row by \((3,3)\) produces two different ratios and structural absence. `RadiochemicalEquilibrium.equilibriumRegime` retains these complete guards and decisions [4,5].

## 4. Exchange conservation and equilibrium fractionation

Hold one element, distinct light/heavy isotope identities and distinct chemical carriers \(A,B\). Let the positive inventory be

\[
 v=(L_A,H_A,L_B,H_B).
\]

An accepted exchange keeps all five identities and satisfies

\[
 L_A+L_B=L'_A+L'_B,\qquad H_A+H_B=H'_A+H'_B,
\]
\[
 L_A+H_A=L'_A+H'_A,\qquad L_B+H_B=L'_B+H'_B.
\]

These equalities preserve each isotope total and each carrier total. To expose their relation, write \(\Delta=H'_B-H_B\) as an algebraic difference of the retained counts. The heavy-total equation gives \(H'_A=H_A-\Delta\). The carrier-B equation gives \(L'_B=L_B-\Delta\), and light conservation gives \(L'_A=L_A+\Delta\). Thus every changed accepted inventory has the complete balanced form

\[
 v'=(L_A+\Delta,H_A-\Delta,L_B-\Delta,H_B+\Delta),
\]

with all four resulting counts positive. The source uses held orientation and positive counts: unchanged inventory returns EmptyOne; increasing \(H_B\) gives `heavy-A-to-B`, otherwise `heavy-B-to-A`. The displayed difference derives the four balance equations and introduces no extra native input.

The exchange quotient is

\[
 Q=\frac{H_B L_A}{L_B H_A}.
\]

The original transition \((4,2,3,1)\to(5,1,2,2)\) preserves totals \((L,H,A,B)=(7,3,6,4)\), with initial \(Q=2/3\). Reversing it reverses the held orientation. Positive forward/reverse event counts \(F,R\) return structural balance at equality; otherwise the result carries the excess direction and positive count \(|F-R|\). These are the exact branches of `IsotopeExchange.exchangeTransition` and `eventBalance`.

For equilibrium fractionation, retain distinct isotope and phase identities with the same four positive inventory coordinates. The phase ratios and factor are

\[
 R_A=H_A/L_A,\qquad R_B=H_B/L_B,
\]
\[
 \alpha_{AB}=\frac{R_A}{R_B}
 =\frac{H_A}{L_A}\frac{L_B}{H_B}
 =\frac{H_A L_B}{L_A H_B}.
\]

Both denominator factors are positive. Let \(X=H_A L_B\), \(Y=L_A H_B\). Then \(X=Y\) gives \(\alpha=1\) and EmptyOne orientation; \(X>Y\) gives phase-A heavy enrichment; \(X<Y\) gives phase-B heavy enrichment. For the same numerical inventory, \(Q\alpha=1\) by cancellation. The original phase example \((4,2,6,1)\) gives \(R_A=1/2\), \(R_B=1/6\), \(\alpha=3\); \((4,2,6,3)\) gives coincidence at one. `EquilibriumIsotopeFractionation` preserves the exact ratios, cross-products and orientation.

## 5. Kinetic fractionation and remaining inventory

Each kinetic interval retains one reaction path, distinct isotope identities, positive rank, initial inventories \(I_L,I_H\), product counts \(P_L,P_H\), and resource count \(T\). The guards require \(P_L\le I_L\), \(P_H\le I_H\). Exact rates and their ratio are

\[
 r_L=P_L/T,\quad r_H=P_H/T,\quad
 \kappa=\frac{r_L}{r_H}
 =\frac{P_L/T}{P_H/T}=\frac{P_L}{P_H}.
\]

Equal product counts give EmptyOne orientation; otherwise the result retains `light-faster` or `heavy-faster`. Each remainder is \(I-P\) when positive and EmptyOne at equality. The complete series requires ranks \((1,\ldots,n)\) and one reaction/isotope identity tuple, then maps every interval to both rates, the factor and orientation.

For the original first interval, \(I_L=I_H=8\), \(P_L=4\), \(P_H=2\), \(T=2\). Hence rates are two and one, \(\kappa=2\), and remainders are four and six. The second interval \((P_L,P_H,T)=(6,3,2)\) again has factor two. Setting both product counts to eight yields structural absence for both remainders. `KineticIsotopeFractionation.timeSeries` preserves every interval in the original order.

## 6. Radiotracer custody under arbitrary finite extension

A tracer observation retains tracer identity, chemical carrier, location, positive rank, observed events \(O\), and administered events \(A\), with \(O\le A\). Recovery and unobserved custody are

\[
 \rho=O/A,\qquad
 U=\begin{cases}A-O,&O<A,\\\mathrm{EmptyOne},&O=A.\end{cases}
\]

A complete record accepts nonempty observations with consecutive ranks and a common tracer/carrier pair. For \(\pi(x)=(\operatorname{location}(x),\rho(x),U(x))\), its output is \(\operatorname{Record}(P)=\operatorname{map}(\pi,P)\).

**Theorem 2 (complete record extension).** For an accepted prior word \(P\) and accepted finite extension \(P\mathbin{+\!+}Q\),

\[
 \operatorname{Record}(P\mathbin{+\!+}Q)
 =\operatorname{Record}(P)\mathbin{+\!+}\operatorname{map}(\pi,Q).
\]

First, unfold the two original record guards. Each failed guard contradicts accepted output; the successful branch is exactly the mapped list. Next induct on \(P\). The empty-list mapping equation is immediate. At \(x::P'\), prepend \(\pi(x)\) to the induction equation for \(P'\). `RadiotracerCustody.acceptedRecordExact` and `completeExtensionPreservesRecord` implement these steps. Setting \(Q=[q]\) gives `successorPreservesRecord`. All previous locations, recoveries and remainders remain in their original positions.

The original sequence \((O,A)=(3,5),(4,5),(5,5)\) gives recoveries \(3/5,4/5,1\) and unobserved custody two, one and EmptyOne. The rank and common-identity guards remain in force for every accepted extension.

## 7. Species balance and decontamination

A separation ledger retains distinct target/contaminant label text with the original target and contaminant families, and positive feed, product and waste counts for each species. The source requires

\[
 F_T=P_T+W_T,\qquad F_C=P_C+W_C.
\]

**Theorem 3 (accepted species conservation).** Every successful separation constructor satisfies both equalities. Unfolding the constructor exposes the identity guard and the two count comparisons. A false comparison produces an error and contradicts acceptance; each true comparison yields the corresponding integer equality. This is `RadiochemicalSeparation.acceptedSpeciesBalance`.

Recovery is \(R=P_T/F_T\). Dividing the contaminant-to-target feed ratio by the product ratio gives

\[
 D=\frac{F_C/F_T}{P_C/P_T}
 =\frac{F_C P_T}{F_T P_C}.
\]

The original counts make every denominator positive. For

\[
 (F_T,F_C,P_T,P_C,W_T,W_C)=(10,12,8,2,2,10),
\]

both balances hold, \(R=4/5\), \(D=24/5\), and target residual is two. The separate residual operation rejects \(P>F\), returns \(F-P\) for \(P<F\), and returns EmptyOne for \(P=F\). The ledger itself retains positive waste counts; that separate equality operation does not change the ledger's original domain.

## 8. Complete fission-product distribution

Each row retains nuclide \(n_i\), chemical species \(s_i\), phase \(p_i\), location \(l_i\) and positive event count \(e_i\). For nonempty \(R\), let \(N=\sum_i e_i\). Its chemical distribution is

\[
 C(R)=\bigl((n_i,s_i,p_i,l_i,e_i/N)\bigr)_i.
\]

Every row and its order remain. The shares sum to one by the same common-denominator argument as Theorem 1. Empty support returns EmptyOne. The original redistribution guards are exactly

\[
 \{n_i:i\in R\}=\{n_j:j\in R'\},\qquad
 \sum_i e_i=\sum_j e'_j.
\]

On success it returns \(C(R')\). `FissionProductDistribution.acceptedRedistributionExact` unfolds those guards and identifies the full returned successor vector. The comparison is of nuclide sets and total events; each complete successor row remains explicit in the output.

The original Cs-fluoride/salt/bulk row has three events and the Xe-elemental/gas/headspace row one. Their shares are \(3/4,1/4\). The retained successor relocates Cs to the wall and assigns two events to each nuclide, giving \(1/2,1/2\), with both nuclides and total four preserved.

## 9. Exhaustive grammar and closure

Each of the eleven entries generates its original product of eight binary axes. Appendix A gives every rejected/admitted pair. Thus each candidate carrier has \(2^8=256\) elements. For each coordinate, its two constructors belong to the generating two-element list; repeated product-list membership proves every candidate occurs. The native `generatedCardinality` and `candidatesComplete` results establish these facts.

For an entry, let \(A_j(c_j)\) test its admitted coordinate. The original decision is proved equivalent to

\[
 D(c)=\bigwedge_{j=1}^{8}A_j(c_j).
\]

Every coordinate criterion holds exactly for its admitted constructor. Therefore \(D(c)=\mathrm{true}\) forces the all-admitted tuple \(c_*\); conversely \(c_*\) satisfies every criterion. This proves

\[
 D(c)=\mathrm{true}\quad\Longleftrightarrow\quad c=c_*.
\]

`sourceDecisionMatchesCriteria`, `uniqueCriteriaSurvivor` and `uniqueSurvivor` preserve the argument in every grammar module. A rejected field contradicts the corresponding survivor field. Complete-vector operations then retain the source's extension decisions: fresh carrier occurrence, complete network append, activity recomputation, complete branch repartition, all-interval equilibrium comparison, inventory-preserving exchange, exact fractionation recomputation, complete kinetic/tracer records, species balance and guarded fission redistribution. Sections 1–8 give these operations and their mathematical arguments explicitly.

## 10. Measured intervals and complete source outcomes

The original validations retain three complete source families. The initial family has four sources, eight PDF pages, two HTML documents and 34,442 extracted characters. The fractionation family has five sources, 266 PDF pages, one HTML document and 410,095 characters. The terminal family has four sources, 370 PDF pages and 837,013 characters. These are family counts; shared sources retain their original appearances. All source authority hashes, complete result-vector hashes, page/document reconstruction results, separately registered predicates and original omission controls accompany the paper.

The certified massic activities are \(29.492\pm0.088\) kBq/g for strontium-90 and \(26.30\pm0.23\) Bq/g for uranium-232, both with reported coverage factor two. Retaining the published units, their exact endpoint arithmetic gives

\[
 [29.492-0.088,29.492+0.088]=[29.404,29.580]\ \mathrm{kBq/g},
\]
\[
 [26.30-0.23,26.30+0.23]=[26.07,26.53]\ \mathrm{Bq/g}.
\]

Their reference times are 1200 EST on 25 December 2019 and 31 October 2022 respectively. The complete comparison also retains five amount forms, twelve uncertainty rows and three half-life records. The branch source vector retains daughter/channel identities, confirmatory methods and its recorded lack of numerical per-decay branch fractions. The equilibrium source vector retains both parent/daughter records and certified activities; its numerical transient/secular time series has the original unavailable status. The exact branch and regime equations in Sections 1 and 3 are evaluated on their declared counted inputs.

The source exchange vector contains all four alpha values \(0.99893,0.99916,1.041,1.0793\), with their isotope/carrier ratios, logarithmic inscriptions and conditions. Its four example isotope-ratio rows retain both absolute and standard-relative forms. The equilibrium comparison retains twelve table rows, four exchange-alpha rows and the source's 49 curve figures with their temperature support, fitting assumptions and estimated curves.

The ten-row electrolysis vector gives factor \(2.4\), initial recombined-gas density change \(-20.5\) ppm, and residual hydrogen inscription \(+57.8\) ppm at 150 litres collected. The original correction is \(2.2\pm0.5\) ppm, giving the stated interval \([1.7,2.7]\) ppm. Its three measured correction rows are \(1.4,2.4,2.8\) ppm. Flow reversals, five-percent loss, estimated curve B, operating conditions and unreported cells remain in the complete vector. These values retain their source measurement roles alongside the exact count ratio \(P_L/P_H\).

The radiotracer source reports cobalt recovery of 70–75 percent in copper matte, about five percent short-circuiting and nearly thirty percent blocked settling-tank volume. Liquid/solid mean-residence pairs are \((3.3,3.2)\), \((5.3,3.4)\) and \((6.2,5.3)\) minutes for the three retained machines. The gold-leach records retain injections of 100 and 130 mCi. Reported ranges, approximate percentages, background and decay corrections, fitted residence models and plant interpretations remain distinct source fields.

The separation vector retains fourteen species and nine process records. Its resin record reports 92 percent vanadium-48 recovery and post-column scandium as not detectable. The initial extraction record reports one percent extraction, measured vanadium-48 activity 2.55 mCi against the theoretical 2.23 mCi, and 435 ppm titanium feed. Detection-limit statements stay attached to their observations. The 7000-litre-to-one-litre factor is a projection; the one-week concentration and atom inventory retain their original estimated/calculated status.

The fission source retains four chemical groups, seven soluble-fluoride rows, seven noble-metal rows, five phase/location records and five sample records. Its iodine salt inventory spans 45–71 percent with median 62 percent; roughly one-quarter to one-third remains unaccounted for in the source balance. The six retained adverse records include poor noble-metal balances, uncontrolled operating changes, unsupported inferred iodine/tellurium off-gas attribution and unstudied flow effects. All these outcomes remain alongside the complete event-normalization construction.

The source families preserve their original prediction-seal chronology and prior-exposure disclosures. The retained full native validations match the original twelve-field empirical receipts and their hashes; the three measurement messages in each receipt summarize the complete source comparison, rather than count its individual source rows. The complete returned analyses and observations are supplied in the evidence archive.

## 11. Native correspondence and reproduction

The eleven completed registrations are the original NUCHEM entries 001 through 011. Completion receipts TURN1111, TURN1114, TURN1115, TURN1125, TURN1129, TURN1139, TURN1140, TURN1141 and TURN1142 bind their source-specific proof, program and observation checks. There are 67 direct modules and 1,506 distinct audited declarations; all retained axiom outputs are empty. The source archive includes 495 native files with imports, 168 pinned V3 files, the original source snapshots, all eleven grammar tables and exact declaration lists.

V3 is pinned to commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The V4 release source is edition 0.4 [3,5]. Three additional activity analysis/experiment/validation modules are supplied as their exact retained TURN1115 receipt-bound bytes. Their hashes and provenance are explicit in `SOURCE_CORRESPONDENCE.json`; the full source package published with this paper contains all three.

After extracting `SOURCE_AND_EVIDENCE.zip`, run `python3 reproduction/check_paper_arithmetic.py`. It executes all 88 original witnesses and checks 64 carrier replacements, 624 activity ledgers, 340 branch partitions, 256 isotope inventories, 288 exchange transitions, 441 kinetic intervals, 64 tracer prefixes, 256 balanced separation ledgers and 120 fission distributions/redistributions. It verifies all 58 original authority checks and three complete result-vector hashes, and reproduces the stated activity and correction interval endpoints. Applicable native build, axiom-audit and full source-comparison receipts are retained with their exact source digests.

## References

[1] Maria Smith. SFT V3 foundation. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).

[2] Maria Smith. SFT exhaustive monograph. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[3] Maria Smith. SFT V4 Lean verified corpus, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Contact-enriched edition: [doi:10.5281/zenodo.24337358](https://doi.org/10.5281/zenodo.24337358).

[4] Maria Smith. Pinned V3 chemistry source, commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Eleven original NUCHEM law modules and the initial, fractionation and terminal batch/validation modules under `sft/chemistry/`. Verbatim source, registrations, original snapshots and source-specific evidence accompany this paper.

[5] Maria Smith. [V4 native corpus](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3), commit `21cdf559922fb057f8560f42d056ffa035329eb3`. The corresponding `SFT.Chemistry` modules and complete receipt-bound activity modules are identified individually in this paper's source correspondence and archive.

[6] Original external sources. The following bibliography identifies the retained source snapshots. The evidence archive preserves each original source identity, capture record and byte digest.

- [DOE-ORNL-4865-FISSION-PRODUCT-BEHAVIOR-MSRE](https://www.osti.gov/servlets/purl/4077644).

- [DOE-OSTI-1580278-HFSLM-ISOTOPE-HARVESTING](https://www.osti.gov/servlets/purl/1580278).

- [IAEA-TCS-31-RADIOTRACER-RTD-2008](https://www-pub.iaea.org/MTCD/publications/PDF/TCS-31_web.pdf).

- [NBS-NSRDS-45-RADIATION-CHEMISTRY-NITROUS-OXIDE](https://nvlpubs.nist.gov/nistpubs/Legacy/NSRDS/nbsnsrds45.pdf).

- [NBS-RP729-ELECTROLYTIC-HYDROGEN-OXYGEN-FRACTIONATION-1934](https://nvlpubs.nist.gov/nistpubs/jres/13/jresv13n5p599_A2b.pdf).

- [NIST-NUCLEAR-PHYSICS-DATA-ISOTOPIC-COMPOSITION](https://www.nist.gov/pml/nuclear-physics-data).

- [NIST-RADIOACTIVITY-SRMS-GENERAL-INFO-2025](https://tsapps.nist.gov/srmext/certificates/documents/Radioactivity%20SRMs%20General%20Info.pdf).

- [NIST-SRM-4239A-STRONTIUM-90-2022](https://tsapps.nist.gov/srmext/certificates/4239a.pdf).

- [NIST-SRM-4324C-URANIUM-232-2025](https://www.nist.gov/programs-projects/standard-reference-materials-standardization-232u-srm-4324c).

- [USGS-PP-440-KK-STABLE-ISOTOPE-FRACTIONATION](https://pubs.usgs.gov/pp/0440kk/report.pdf).

- [USGS-WRIR-02-4172-ISOTOPE-EQUILIBRIUM-CONSTANTS](https://pubs.usgs.gov/wri/wrir02-4172/pdf/wrir02-4172.pdf).

## Appendix A. Every original grammar axis

Each row gives the two constructors in the original generating order. The conjunction selects the admitted column; the completeness and uniqueness proof in Section 9 applies to every table. Labels below retain the original words with spaces for readability.

### A.1 Nuclide chemical carrier

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| element | anonymous radiation | held element identity |
| nuclide | element only identity | positive nucleon count |
| state | ground state assumption | held nuclear state |
| species | bare nuclide answer | held chemical species |
| phase | phase free species | held chemical phase |
| occurrence | continuum amount premise | positive counted occurrence |
| record | selected nuclide row | complete nuclide species vector |
| extension | lookup table exception | fresh occurrence preserves identity |

### A.2 Radioactive chemical transformation

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| parent | parent number only | held parent nuclide |
| daughter | anonymous product | held daughter nuclide |
| chemistry | nuclear edge only | held parent daughter species |
| channel | unlabelled transition | held decay channel |
| events | continuum decay flow | positive counted transformations |
| network | selected decay edge | complete directed transformation network |
| absence | numerical zero daughter | structural EmptyOne no edge |
| extension | daughter overwrites parent | successor retains prior network |

### A.3 Activity amount time

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| identity | anonymous activity number | held nuclide species |
| amount | continuum amount premise | positive counted initial occurrences |
| events | expected decay number | positive counted transformations |
| time | continuous time premise | positive counted resource intervals |
| activity | fitted decay constant | exact transformations per resource |
| remaining | signed amount difference | positive Take or EmptyOne retained amount |
| record | selected reference time | complete activity amount time vector |
| extension | differential equation premise | ledger successor recomputes relation |

### A.4 Radioactive branching yield

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| channel | unlabelled yield | held decay channel |
| daughter | anonymous product amount | held daughter chemical species |
| events | continuum branch probability | positive counted branch events |
| recovery | fitted chemical recovery | positive counted recovered events |
| yield | percentage premise | exact recovered per branch ratio |
| partition | independent branch fractions | complete branch partition sums to One |
| record | selected favorable daughter | complete daughter yield vector |
| extension | renormalize after omission | new branch repartitions complete total |

### A.5 Radiochemical equilibrium

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| identity | anonymous activity pair | held parent daughter identity |
| support | continuous time premise | positive ordered resource intervals |
| activity | fitted decay curve | exact counted activity pair |
| relation | signed activity difference | held ratio or structural absence |
| transient | named transient assumption | persistent nonOne ratio forces transient |
| secular | approximate equality tolerance | persistent One ratio forces secular |
| record | selected timepoint | complete parent daughter time vector |
| extension | differential equation premise | finite successor recomputes regime |

### A.6 Isotope exchange

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| identity | mass number only | held element light heavy isotopes |
| carriers | phase free exchange | held distinct chemical carriers |
| inventory | continuum concentration premise | positive complete four count inventory |
| conservation | isotope label overwrite | exact isotope and carrier conservation |
| direction | signed exchange extent | held direction positive Take |
| quotient | fitted exchange constant | exact cross product exchange quotient |
| equilibrium | numerical zero net | equal forward reverse closes EmptyOne |
| extension | lookup fractionation factor | successor preserves identities and totals |

### A.7 Equilibrium isotope fractionation

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| identity | anonymous heavy light | held light heavy isotopes |
| phases | single phase ratio | held distinct phase pair |
| inventory | continuum abundance premise | positive complete isotope counts |
| ratios | decimal isotope ratio | exact heavy per light ratios |
| factor | fitted fractionation factor | exact ratio of ratios |
| orientation | signed delta premise | held enrichment or EmptyOne coincidence |
| equilibrium | named equilibrium assumption | exchange balance plus stable factor |
| extension | selected isotope pair | complete vector successor recomputes |

### A.8 Kinetic isotope fractionation

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| identity | mass only rate | held reaction light heavy identities |
| support | continuous time premise | positive ordered resource intervals |
| events | expected product yield | positive counted isotope products |
| rates | fitted rate constants | exact products per resource rates |
| factor | imported kinetic isotope effect | exact light heavy rate ratio |
| orientation | signed rate difference | held faster class or EmptyOne |
| inventory | negative depleted reactant | positive Take or EmptyOne remainder |
| extension | Rayleigh continuum premise | finite time series successor recomputes |

### A.9 Radiotracer custody

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| identity | activity only tracer | held tracer and chemical carrier |
| support | continuous concentration field | positive ordered observation support |
| locations | selected detector location | complete location time vector |
| events | expected count premise | positive administered and observed counts |
| recovery | fitted recovery coefficient | exact observed per administered ratio |
| loss | negative missing activity | positive Take or EmptyOne unobserved |
| inference | model selected localization | inference bounded by observed support |
| extension | renormalized selected series | successor preserves identity and complete record |

### A.10 Radiochemical separation

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| identity | total radioactivity only | held target and contaminant species |
| streams | product only record | complete feed product waste streams |
| inventory | continuum concentration premise | positive species resolved counts |
| balance | unrecorded process loss | exact target and contaminant conservation |
| recovery | percent recovery premise | exact product target per feed target ratio |
| decontamination | fitted separation factor | exact contaminant fraction ratio |
| absence | numerical zero contaminant | positive Take or EmptyOne residual |
| extension | selected best stage | successor composes balanced stages |

### A.11 Fission product distribution

| Axis | Rejected constructor | Admitted constructor |
|---|---|---|
| handoff | chemistry selects fission products | explicit physics product handoff |
| identity | mass chain only | held nuclide and chemical species |
| support | bulk release fraction | complete phase location support |
| events | expected yield premise | positive species resolved events |
| partition | renormalized selected products | exact complete partition of One |
| chemistry | fixed chemical form assumption | explicit chemical redistribution network |
| boundary | silent decay inside chemistry | nuclide change requires physics handoff |
| extension | selected terminal sample | successor retains complete time sample vector |

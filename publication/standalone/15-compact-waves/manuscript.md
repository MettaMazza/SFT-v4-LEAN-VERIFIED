# From the exterior Fold field to compact-object and wave signatures

**Maria Smith** · Ernos Labs  
Standalone paper 15 · Version 1.0 · 17 November 2026  
DOI: [10.5281/zenodo.24325871](https://doi.org/10.5281/zenodo.24325871)

## Abstract

The exterior field, compact-support endpoints and gravitational-wave sequence of Smithian Fold Theory follow from exact generated carriers. A doubled-mass boundary fixes inverse-square flux and the unique positive exterior clock-square coefficient. Every outward binary successor halves the well, quarters the field and increases that coefficient; an exact-square clock pair gives the rate ratio 16/15. The third generated difference of a cubic quadrupole trace is six times its amplitude, giving power 18 times amplitude squared under half-One coupling and conserved outward shell power. Three-space stellar response yields the restoring exponents 5/3 and 4/3, terminal luminosity classes three and four, exact enclosed-support growth for flat rotation, and finite tidal exhaustion. Complete exclusion packing gives fourth-power support against sixth-power gravity, two pre-horizon support families, quarter-area information and the thermal-mass invariant 1/16. The complete inspiral trace has falling separation and period, rising wave frequency and positive radiated takes; it ends at contact, joins two sources into one, and continues through a positive, binary-damped ringdown. Native Lean 4 proofs establish the all-input and all-depth operations. The paper gives the full derivations and original post-seal comparisons: atomic-clock redshift, Double Pulsar radiation, all six stellar luminosity rows, galaxy and spin–orbit observations, compact-object masses, and GW151226/GW190521 wave records. The thermal prediction retains its explicit observational test.

**Keywords:** gravitational waves; compact objects; gravitational redshift; quadrupole radiation; stellar equilibrium; black-hole thermodynamics; exact Fold dynamics; Smithian Fold Theory; Lean 4.

## 1. The linked construction

The common structural carriers are One, its two equal complementary Fold shares, the generated spatial count three and boundary rank two [1–5]. Equal complete shares \(x=x\) with \(x+x=1\) uniquely give \(x=1/2\). The complete spatial carrier has three directions; its retained boundary has two. Their source derivations and exhaustive classifications are given in [4], while [5] develops the shared constants construction and [6] the finite local-conservation laws.

This paper follows five formal source laws and three separately registered empirical companions. Each formal operation is fixed before its corresponding measurement record opens. Exact positive rationals carry magnitudes; orientation and structural emptiness remain explicit records. Squared clocks, cubed response carriers and squared frequencies preserve the actual rational source operations. Their numerical values, closure arguments and complete observed comparisons are developed below.

## 2. The exterior field and unique clock coefficient

### 2.1. Horizon, flux and retained radius

Take an exact positive mass \(0<m\le1/2\). Its generated boundary radius is \(h=2m\), and the exterior input domain is \(r\ge h\). Rank-two boundary conservation retains the complete radius-paired support. Dividing the source magnitude by that support gives
\[
 F(r)=\frac{h}{r^2},\qquad F(r)r^2=h.
\]
Retaining one radius converts the field to the well share,
\[
 w(r)=rF(r)=\frac hr,\qquad w(r)r=h.
\]
Both reconstruction identities hold for every admitted exact radius. No particular displayed radius determines the coefficient.

At \(r>h\), \(0<w<1\). The original positive-remainder operation constructs the clock-square coefficient \(A\) by
\[
 A+w=1,\qquad A>0.
\]
Write \(w=n/d\) with \(0<n<d\). Then
\[
 A=\frac{d-n}{d},\qquad A+w=\frac{d-n+n}{d}=1.
\]
To prove uniqueness, suppose \(c/e+w=1\), with positive denominator \(e\). Clearing denominators gives \(cd+ne=de\). Since \(d=(d-n)+n\), cancellation of the identical retained term \(ne\) yields \(cd=(d-n)e\). Thus \(c/e=(d-n)/d\). The actual normalized rational operation is therefore admitted and uniquely fixed.

At \(r=h\), \(w=1\), so the same source operation returns the empty coefficient and empty clock record. Its boundary result retains a `clock_record` field; the ordinary exterior result retains the positive coefficient and has no such extra field. This preserves the original distinction between a closed record and a numerical magnitude.

### 2.2. Every outward successor

For every positive radius,
\[
 w(2r)=\frac12w(r),\qquad F(2r)=\frac14F(r),
 \qquad F(2r)(2r)^2=F(r)r^2=h.
\]
Coefficient growth also follows at every exterior step. Write the proper well as \(n/(n+g)\), \(n,g>0\). Its old and new coefficients are
\[
 A_{\rm old}=\frac g{n+g},\qquad
 A_{\rm next}=\frac{n+2g}{2(n+g)}.
\]
Positive cross multiplication reduces \(A_{\rm old}<A_{\rm next}\) to \(2g<n+2g\), established by \(n>0\). At the original binary radii \(r_k=h2^k\), \(k\ge1\),
\[
 w_k=2^{-k},\quad A_k=1-2^{-k},\quad F_kr_k^2=h.
\]
The first exterior doubling supplies the base; the displayed identities supply every successor. Native `StaticExteriorClockGeneral` proves the operation-level quotient, complement, uniqueness, boundary and successor statements for arbitrary admitted rational inputs.

### 2.3. Exact-square clocks

For the original pair, \(m=1/4\), \(h=1/2\),
\[
\begin{aligned}
 r_{\rm near}&=8/7,& w_{\rm near}&=7/16,& A_{\rm near}&=9/16=(3/4)^2,\\
 r_{\rm far}&=25/18,& w_{\rm far}&=9/25,& A_{\rm far}&=16/25=(4/5)^2.
\end{aligned}
\]
The positive exact-square clock carriers are \(3/4\) and \(4/5\), giving
\[
 \frac{\text{far rate}}{\text{near rate}}
 =\frac{4/5}{3/4}=\frac{16}{15}>1.
\]
The farther clock runs faster. These are the actual exact rational square carriers used by `exactClockPair`; the general coefficient theorem covers every exterior radius.

## 3. Quadrupole radiation and conserved power

### 3.1. Complete generated differences

The held monopole is the source record and the held dipole is the momentum record. The source's first radiative moment is quadrupole. For any positive rational amplitude \(a\), generate \(Q_k=ak^3\) at successive positive ticks. The original difference operation returns positive adjacent takes for increasing records and structural emptiness for a constant record. Direct expansion gives
\[
\begin{aligned}
 \Delta Q_k&=a\bigl((k+1)^3-k^3\bigr)=a(3k^2+3k+1),\\
 \Delta^2Q_k&=a\bigl(3(k+1)^2+3(k+1)+1-(3k^2+3k+1)\bigr)\\
 &=a(6k+6),\\
 \Delta^3Q_k&=a\bigl(6(k+1)+6-(6k+6)\bigr)=6a.
\end{aligned}
\]
Every retained rate is positive. These displayed subtractions represent the source's positive takes. Equivalently, the cubic identity can be written entirely with positive opposed carriers:
\[
 (k+3)^3+3(k+1)^3=3(k+2)^3+k^3+6.
\]
Its common successor increment is
\[
 12k^2+48k+58.
\]
Indeed, \((k+4)^3-(k+3)^3=3k^2+21k+37\), while three times \((k+2)^3-(k+1)^3\) is \(9k^2+27k+21\). Their sum is the displayed increment. The right-hand side has the same increment. This proves preservation at every positive index. Multiplication by arbitrary positive \(a=n/d\) retains the equality at the common denominator \(d\). `QuadrupoleRadiatedPowerGeneral` connects each first, second and third difference to the actual normalized arithmetic operations.

### 3.2. Amplitude-squared power and shell transport

The admitted coupling is half-One. The retained constant third-rate carrier gives
\[
 P=\frac12(\Delta^3Q)^2=\frac12(6a)^2=18a^2.
\]
Thus amplitude One gives power 18, amplitude two gives 72, and doubling amplitude quadruples power. A constant quadrupole trace returns an empty difference record and empty power record. The original guard requires a positive sequence, enough ticks for three differences, half-One coupling and one retained constant positive third-rate carrier.

For outward binary shell radius \(r_\ell=2^\ell\), the source density is
\[
 \rho_\ell=\frac{P}{2^{2\ell}},\qquad
 \rho_\ell r_\ell^2=P.
\]
Doubling radius multiplies boundary support by four and divides density by four; complete reconstructed power remains unchanged. The twenty-one-field certificate retains the amplitude-One, amplitude-two and static traces, all cubic identities, rate/power tests and every shell row.

## 4. Stellar restoration, galaxy support and finite tidal closure

### 4.1. Restoring response and the two luminosity classes

Complete equal outward and inward shares are \((1/2,1/2)\). In three generated spatial directions, pressure retains the three directions plus two Fold fibres, while gravity retains the three directions plus One source. Their exponents are
\[
 \gamma_P=\frac{3+2}{3}=\frac53,\qquad
 \gamma_G=\frac{3+1}{3}=\frac43.
\]
For an exact compression ratio \(q>1\), compare cubed response carriers. Pressure has \(q^5\) and gravity \(q^4\). Since \(q>1\), \(q^5>q^4\), giving outward restoration. For expansion, \(q^{-4}>q^{-5}\), giving inward restoration. In positive count form, write \(q=n/d\), \(n>d>0\), and let \(C=n^4d^4>0\). Then
\[
 n^4d^5=Cd<Cn=n^5d^4.
\]
The same cross-product order establishes the inverse-power comparison. `StellarRadialDerivation` proves both inequalities for every admitted ratio, retaining exact perfect powers.

Three-space volume and volume with one radiative recurrence give the two terminal luminosity classes \(M^3\) and \(M^4\). Dividing one fuel carrier by those luminosities gives lifetime fall exponents two and three. At mass ratio \(q>1\), the source therefore returns
\[
 (L_1,L_2)=(q^3,q^4),\qquad
 (D_{\tau,1},D_{\tau,2})=(q^2,q^3).
\]
At \(q=2\), these are luminosity ratios \((8,16)\) and lifetime divisors \((4,8)\). The observational comparison in Section 8 retains all six measured mass intervals and tests each against both terminal classes.

### 4.2. Flat rotation and fourth-power baryonic response

For positive enclosed mass and radius, circular balance under the inverse-square law is
\[
 v^2=\frac{M(r)}r.
\]
Keeping \(M=1\) while increasing radius from one to \(q>1\) lowers \(v^2\) from one to \(1/q\). Preserving a flat value instead requires \(M(qr)=qM(r)\): multiplying the flat equality by \(qr\) fixes the same mass-growth ratio. Additional enclosed support is therefore required relative to a fixed visible-mass asymptote. Three-space plus orbital recurrence supplies the fourth-power baryonic Tully–Fisher carrier,
\[
 \frac{M_{b,2}}{M_{b,1}}=\left(\frac{v_2}{v_1}\right)^4.
\]
The source retains exact positive ratios and the complete observed central and systematic comparison intervals.

### 4.3. Exhaustion of every finite cycle mismatch

Let spin and orbit cycle counts be positive wholes \(s,o\). Set \(b=\min(s,o)>0\), \(e=|s-o|\). If \(e>0\), the original successor removes one cycle from the larger count, preserves the smaller count and records which surplus was transferred. The next mismatch is exactly \(e-1\). After \(e\) successors both counts are \(b\); a final lock row is retained. The complete trace length is \(e+1\).

For \((s,o)=(5,2)\), the rows retain \((4,2)\), \((3,2)\), \((2,2)\), then the final \((2,2)\) lock record. The successive mismatch pairs are \((3,2),(2,1),(1,0),(0,0)\). `StellarTides.completeTraceLength`, `completeTraceTerminal` and `StellarTidalClosure.originalStrictBeforeLock` prove finite exhaustion and strict dissipation before lock for arbitrary finite excess. The isolated circular channel closes at one-to-one; the original separate eccentric/external-forcing record retains Mercury's three-to-two comparison.

## 5. Compact support and horizon thermodynamics

### 5.1. Exclusion packing and endpoint census

For positive whole side count \(q\), complete three-space packing contains \(N=q^3\) singly occupied cells. Exclusion forces momentum depth \(q\), giving relativistic support numerator \(Nq=q^4\). Paired gravitational source support is \(N^2=q^6\). At \(q=1\) the two equal One. For every \(q>1\),
\[
 q^4<q^4q<q^4q^2=q^6.
\]
Positivity justifies each multiplication. This establishes the strict exponent order for every nonbase whole side, not only the displayed packings.

The source's retained upper-preimage operation on \(1/2<u\le1\) takes a quarter-One, \(U(u)=u-1/4\). Its loaded witness \(u=3/4\) returns the half-One balance. The complete pre-horizon family census retains the two binary roles: electron-exclusion support and neutral-fermion-exclusion support. The third pre-horizon family record is empty; the successor after the second family is horizon closure. The original eight-field certificate preserves this census together with the complete exclusion and evaporation records.

### 5.2. Exact scale laws

For every positive exact mass \(m\), doubling gives \(r=2m\), and rank-two support gives \(A=r^2=4m^2\). Two binary halvings fix entropy support to a quarter of area:
\[
 S=\frac A4=m^2,\qquad4S=A.
\]
The admitted quarter-One horizon witness retains \(m_*=1/4\), normalized thermal carrier \(T_*=1/4\) and quarter-area coefficient. Their product is
\[
 K=m_*T_*=\frac1{16},\qquad T(m)=\frac{K}{m}=\frac1{16m},
 \qquad mT(m)=K.
\]
For \(m=n/d>0\), the actual division returns \(T=d/(16n)\); multiplication by \(n/d\) reconstructs \(1/16\). `CompactHorizonDerivation.originalQuarterWitness`, `originalThermalWitness` and `originalQuarterBoundary` identify the prior horizon record exactly. `originalPositiveHorizon` proves the entire returned six-field record for arbitrary positive numerator and denominator.

### 5.3. Every finite emission successor

The source begins its emission trace at mass One and halves mass at each successor. At zero-based tick \(j\),
\[
 m_j=2^{-j},\quad r_j=2^{1-j},\quad A_j=4\,2^{-2j},
 \quad S_j=2^{-2j},\quad T_j=2^j/16.
\]
Thus \(m_{j+1}=m_j/2\), \(T_{j+1}=2T_j\), \(A_{j+1}=A_j/4\) and \(S_{j+1}=S_j/4\). Every reached carrier is positive and \(m_jT_j=1/16\). The operation-level induction `originalEvaporationTotal` constructs all requested rows and proves positivity; the mass, temperature and area order theorems prove the strict successor relations.

| Tick \(j\) | Mass | Radius | Area | Entropy | Temperature |
|---:|---:|---:|---:|---:|---:|
| 0 | 1 | 2 | 4 | 1 | 1/16 |
| 1 | 1/2 | 1 | 1 | 1/4 | 1/8 |
| 2 | 1/4 | 1/2 | 1/4 | 1/16 | 1/4 |
| 3 | 1/8 | 1/4 | 1/16 | 1/64 | 1/2 |

The complete compact-object observation in Section 9 tests the family ordering and preserves the thermal law as an explicit prediction.

## 6. Inspiral, contact, merger and ringdown

### 6.1. Exact orbital and radiation carriers

At every positive exact separation \(s\), inverse-square restoration balanced against cyclic acceleration supplies the normalized relation \(v^2=1/s\). Squaring the period relation gives \(P^2=s^2/v^2=s^3\). The orbital squared frequency is its reciprocal. A quadrupole repeats twice per orbit, multiplying squared wave frequency by four. Half-One coupling gives binding-support magnitude \(B=1/(2s)\). The full source row is
\[
 \left(s,P^2,f^2,f_{\rm GW}^2,B\right)
 =\left(s,s^3,s^{-3},4s^{-3},\frac1{2s}\right).
\]
The actual positive rational operations are proved by `ChirpRingdownDerivation.originalOrbitalRow` for arbitrary \(s=n/d\), \(n,d>0\).

Passing from \(2s\) to \(s\) divides period squared by eight, multiplies both squared frequencies by eight, and doubles binding support. The exact incoming radiation take is
\[
 B(s)-B(2s)=\frac1{2s}-\frac1{4s}=\frac1{4s}>0.
\]
Native `originalBinaryBindingTake` connects this positive difference to the source's guarded take operation.

### 6.2. Complete finite inspiral

For every positive depth \(d\), the source traverses the entire reversed binary range
\[
 2^d,2^{d-1},\ldots,2,1.
\]
There are \(d+1\) rows. The first has an empty incoming-take record; every later row retains the exact positive binding take from its predecessor. The last separation is One. To establish the actual list operation, let \(O(k)\) be the row at \(2^k\), and let \(R(k)\) retain \(O(k),\ldots,O(0)\), each with its incoming take \(1/(4\cdot2^j)\). Then
\[
 R(0)=[(O(0),1/4)],\quad
 R(k+1)=[(O(k+1),1/(4\cdot2^{k+1}))]\mathbin{++}R(k).
\]
The original trace is \([(O(d),\mathrm{empty})]\mathbin{++}R(d-1)\). Induction gives its length, exact order, positive takes and final contact. `ChirpInspiral.originalFullTrace`, `originalFullLength`, `originalTerminalContact` and `originalAllRetainedTakesPositive` prove these complete-list statements.

| Separation | Period squared | Orbital frequency squared | Wave frequency squared | Binding | Incoming take |
|---:|---:|---:|---:|---:|---:|
| 8 | 512 | 1/512 | 1/128 | 1/16 | empty |
| 4 | 64 | 1/64 | 1/16 | 1/8 | 1/16 |
| 2 | 8 | 1/8 | 1/2 | 1/4 | 1/8 |
| 1 | 1 | 1 | 4 | 1/2 | 1/4 |

### 6.3. Contact and retained merger records

Each original component has mass \(1/4\) and doubled boundary radius \(1/2\). Their two boundaries meet at separation \(1/2+1/2=1\), the actual final inspiral row. The merger retains both component labels, the quadrupole-take radiation record and remnant mass-support/held-turn labels. The source count changes from two to one. `originalHorizonContact` connects this contact directly to the existing horizon witness.

### 6.4. All-depth ringdown

The remnant begins at amplitude One. At positive tick \(j\),
\[
 a_j=2^{-(j-1)},\qquad a_{j+1}=\frac12a_j,
 \qquad0<a_{j+1}<a_j.
\]
The tone key is held and the source count remains one. Induction on the requested finite row count proves exact length, positive amplitudes, binary damping, strict decrease, unchanged tone and one-remnant status. These are operation-level results for `ringdownRows`, proved in `ChirpRingdownDerivation`. The seven-field theorem certificate retains complete inspiral and ringdown traces at depths 1, 2, 3, 8 and 16, the merger record and the unique ordered sequence: rising inspiral chirp, merger, damped ringdown.

## 7. Exterior-clock and binary-radiation observations

### 7.1. Atomic clocks

The exterior comparison retains thirty-four ordered target rows: historical exterior relations, five admitted prerequisites, the primary spherical-vacuum theory comparison, NIST/JILA measurements and their declared roles. Under the source's unit conversion \(m=GM/c^2\), \(h=2GM/c^2\), the exterior coefficient is the positive complement of \(h/r\). The conventional comparison is the static spherical vacuum solution with vanishing cosmological constant, reciprocal radial/time coefficients and no spherical-vacuum radiation. The complete source text is retained in Appendix A.

The atomic-clock record reports a predicted fractional gradient \(-1.09\times10^{-19}\) per millimetre, corrected full-cloud gradient \(-9.8(2.3)\times10^{-20}\), corrected split-cloud gradient \(-1.28(27)\times10^{-19}\), and fractional-frequency uncertainty \(7.6\times10^{-21}\), across fourteen measurements over ten days [7]. Its corrected gradient intervals contain the predicted gradient. The reported direction is a faster higher clock, matching the exact ordering in Section 2. The reported signed gradients retain their measurement convention. The source distinguishes this measured ordering from the specific structural ratio 16/15.

### 7.2. Complete Double Pulsar radiation comparison

The original primary system is PSR J0737−3039A/B, with a sixteen-year observation span, 2.45-hour orbit, eccentricity 0.088 and approximately 60,000 tracked orbits [8]. The measured-to-predicted ratio is \(0.999963\pm0.000063\). The exact normalized comparison is One, so
\[
 1-\frac{999963}{10^6}=\frac{37}{10^6}
 <\frac{63}{10^6},\qquad
 \frac{37}{10^6}<\frac{13}{10^5}.
\]
It lies within both the published uncertainty and 95-percent agreement boundary. The extreme-equation-of-state ratio is \(0.999958\pm0.000064\); its difference from One, \(42/10^6\), is also below \(64/10^6\).

| Retained correction or result | Original reported value |
|---|---|
| Shklovskii correction | \(+1.72(15)\times10^{-16}\) |
| Galactic correction | \(-3.40^{+0.25}_{-0.24}\times10^{-16}\) |
| Combined external correction | \(-1.68^{+0.11}_{-0.10}\times10^{-16}\) |
| Intrinsic orbital decay | \(-1.247752(79)\times10^{-12}\) |
| Spin-down mass-loss correction | \(+2.9(2)\times10^{-17}\) |
| Measured gravitational-wave orbital decay | \(-1.247782(79)\times10^{-12}\) |
| Leading quadrupole prediction | \(-1.247810^{+0.000006}_{-0.000007}\times10^{-12}\) |
| Next-order correction | \(-1.75\times10^{-17}\) |
| Total prediction | \(-1.247827^{+0.000006}_{-0.000007}\times10^{-12}\) |

The leading quadrupole term has the source's 2.5PN equations-of-motion classification; the next correction is 3.5PN. The observed timing error dominates the current intrinsic uncertainty, while future precision retains the kinematic corrections. This is the original mildly relativistic strong-field material-binary comparison. Its forty-eight target rows retain all corrections, historical/prerequisite bindings and the distinction between the binary radiation comparison and the exact normalized Fold power coefficient. The complete twenty-four-field analysis agrees between native and original execution.

## 8. Complete stellar, galaxy and spin–orbit comparison

### 8.1. Solar equilibrium and all six luminosity rows

The solar convection-boundary record [9] gives \(713/1000\pm1/1000\), hence
\[
 [712/1000,714/1000]=[89/125,357/500].
\]
The reference-model value \(1427/2000\) lies inside this interval. It is retained as the external solar model value; the SFT relation being compared is radial restoration. The reported sound-speed/adiabatic-index precision order is \(1/10000\), and density inversion precision is \(1/1000\).

The complete six-row main-sequence record [10] is:

| Lower mass ratio (exclusive) | Upper mass ratio | Slope | Uncertainty | Contains 3 | Contains 4 |
|---:|---:|---:|---:|---|---|
| 179/1000 | 9/20 | 507/250 | 27/200 | no | no |
| 9/20 | 18/25 | 1143/250 | 319/1000 | no | no |
| 18/25 | 21/20 | 5743/1000 | 413/1000 | no | no |
| 21/20 | 12/5 | 4329/1000 | 87/1000 | no | no |
| 12/5 | 7 | 3967/1000 | 143/1000 | no | yes |
| 7 | 31 | 573/200 | 31/200 | yes | no |

Only the fifth interval contains four: \([3.824,4.110]\). Only the sixth contains three: \([2.710,3.020]\). All four lower-mass intervals remain in the comparison. These results compare the two source terminal classes against the full measured piecewise relation.

### 8.2. Galaxy support and baryonic slope

The registered SPARC population contains 175 disk galaxies [11]. The baryonic Tully–Fisher record [12] contains 153 galaxies, intrinsic scatter \(3/50\), central slope \(77/20\) and uncertainty \(9/100\). Its central interval is
\[
 [77/20-9/100,77/20+9/100]=[94/25,197/50]=[3.76,3.94],
\]
which excludes four. Its complete reported systematic interval \([7/2,4]\) contains four at the upper endpoint. Both outcomes are retained. The Bullet Cluster record [13] reports an eight-standard-deviation mass/baryon peak separation, with mass following the collisionless galaxy distribution rather than the dominant X-ray plasma. This is the source's discriminator for additional enclosed support under the independently fixed field law.

### 8.3. The two spin–orbit observations

The lunar record [14] retains approximate orbit and rotation durations of 655 hours, giving one-to-one synchrony. Mercury [15] retains three rotation cycles per two orbital cycles and period \(29323073/500000=58.646146\) days with uncertainty \(11/10^6\) days. Its three-to-two ratio is the declared eccentric-resonance comparison. The complete thirty-four-field analysis retains all seven source records, their original uncertainties and all six stellar rows. Its altered-record controls detect an erased stellar row, discarded systematic interval, false lunar synchrony and erased Mercury resonance.

## 9. Compact-object observations and the thermal test

The compact-object vector has three complete source rows. NASA's white-dwarf summary [16] gives electron degeneracy and a theoretical mass limit \(7/5\) solar masses. The PSR J0740+6620 timing record [17] gives
\[
 M=\frac{52}{25}\pm\frac7{100},\qquad
 M\in\left[\frac{201}{100},\frac{43}{20}\right]=[2.01,2.15]M_\odot.
\]
Its entire interval lies above \(7/5=1.4\). The method is relativistic Shapiro delay in combined pulsar timing, with reported credibility \(683/1000\). This measured object supplies the source's lower witness for the neutral-fermion-supported family.

The GW170817 remnant record [18] gives two conditional baryonic upper boundaries: \(267/100=2.67\) solar masses if the merger produced a hypermassive neutron star, and \(61/20=3.05\) if a black hole formed after merger and the stars were slowly rotating. Both exceed 2.15. Their original conditional roles are retained as part of the comparison. The source does not replace them with measurements of a maximum mass.

The prior horizon comparison retains observed horizon-scale shadow/ringdown records. The exact thermal law \(mT=1/16\) is a prediction: direct astrophysical Hawking radiation, temperature and information reconstruction are absent from this registered observation vector. The original validation gives no reward for that absence. These are the actual source-defined thermal test and comparison outcome.

The seventeen-field native analysis retains every row and method/condition. Its controls reject a reversed neutron-star/white-dwarf ordering, an upper bound changed below the measured neutron-star interval, and removal of a remnant condition.

## 10. The complete chirp and remnant observation vector

The original record distinguishes GW150914 as disclosed development context from two post-seal source events. The full event values are retained below [19–21].

| Reported quantity | GW151226 | GW190521 |
|---|---:|---:|
| Duration | 1 s | 0.1 s |
| Cycles | 55 | 4 |
| Frequency endpoints | 35–450 Hz | 30–80 Hz |
| Network signal-to-noise | 13 | 14.7 |
| Initial sources / remnant | 2 / 1 | 2 / 1 |
| Primary mass, solar units | \(14.2^{+8.3}_{-3.7}\) | \(85^{+21}_{-14}\) |
| Secondary mass, solar units | \(7.5^{+2.3}_{-2.3}\) | \(66^{+17}_{-18}\) |
| Final mass, solar units | \(20.8^{+6.1}_{-1.7}\) | \(142^{+28}_{-16}\) |
| Radiated energy, solar mass-energy units | \(1.0^{+0.1}_{-0.2}\) | retained remnant comparison |

GW151226 has rising amplitude to its peak, positive radiated energy and a two-to-one transition. Its frequency increase is exactly \(450-35=415>0\). The peak-strain central value is \(3.4\times10^{-22}\), and the reported significance exceeds five standard deviations. The source parameter intervals are 90-percent credible intervals. Matched-filter recovery and parameter estimation use calibrated waveform models; the long inspiral is well resolved and merger/ringdown have the source's looser constraints.

GW190521 has \(80-30=50>0\), a two-to-one transition and decaying post-peak support in the least-damped \(l=m=2\) mode. Its false-alarm return period is 4,900 years. The record retains the conditional quasicircular-binary interpretation, alternative interpretations and approximately four observed cycles. The remnant-ringdown comparison is compatible with the full-waveform analysis. The observed decay is compared to the formal damped-remnant relation; the exact half-One successor is not a directly measured damping fraction.

The sixteen-field native analysis retains all these roles. Four complete altered records reverse the first frequency endpoint, erase the one-remnant result, relabel development context as blind, or remove the second event's conditional interpretation. The respective predicates reject each alteration. Original and native execution agree on the complete observation and controls.

## 11. Exhaustive grammars and native verification

### 11.1. Complete alternatives and unique closure

The exterior and quadrupole laws each have six ternary axes and two binary axes, hence \(3^6 2^2=2916\) candidates. Stellar response, compact horizon and chirp/ringdown each have twelve binary axes, hence \(2^{12}=4096\) candidates. The following tables display every axis and its original alternatives.

For each law, necessity of the preserving tuple follows from the actual operation: changing an axis removes a required carrier, changes its exact relation, loses a complete row or permits target selection/free extension. Sufficiency follows by assembling the retained construction, its complete certificate and its base/successor argument. Equality of every axis fixes a unique tuple. Complete product generation proves its membership and covers every other tuple; a different tuple fails at least one coordinate. Native full-census decision and uniqueness proofs establish this classification over the entire declared product.

### 11.2. Exterior coefficient and clocks

| Axis | Preserving construction | Other alternatives |
|---|---|---|
| horizon normalizations | twice mass generated horizon | free radius scale; target assigned horizon |
| field laws | inverse square with conserved horizon flux | free field power; target assigned field |
| well laws | radius times field gives horizon over radius share | independent potential profile; target assigned well |
| coefficient laws | positive One complement of well | signed subtraction import; target assigned coefficient |
| clock laws | exact square carriers and empty horizon record | unrestricted irrational root; target assigned clock |
| boundary laws | finite successor flat boundary and vacuum | completed infinity or interior extension; target assigned boundary |
| target boundaries | sealed before observation release | observation readable before seal |
| extensions | empty extension | free exterior correction |

### 11.3. Quadrupole power

| Axis | Preserving construction | Other alternatives |
|---|---|---|
| moment laws | held monopole and dipole leave quadrupole first | lower moment radiation; target assigned moment |
| rate laws | third generated quadrupole difference | free difference order; target assigned rate |
| energy laws | positive square of third rate | linear or unsigned rate energy; target assigned energy |
| coupling laws | admitted binary half One coupling | free radiation coupling; target assigned coupling |
| shell laws | rank two density dilution with conserved total power | unconserved or free shell power; target assigned shell law |
| adverse controls | static empty and amplitude square scaling | numerical zero or linear scaling; target assigned control |
| target boundaries | sealed before observation release | observation readable before seal |
| extensions | empty extension | free radiation correction |

### 11.4. Stellar and galactic response

| Axis | Preserving construction | Other alternatives |
|---|---|---|
| hydrostatic | complete self antipodal half One | selected pressure gravity ratio |
| radial | five thirds versus four thirds perfect power test | asserted self correction |
| stellar | three space and volume plus recurrence | fitted single power |
| lifetime | one fuel carrier over complete luminosity | independent lifetime fit |
| circular | inverse square balance v squared equals M over r | imported Kepler answer |
| flat | enclosed support grows linearly with radius | finite visible asymptote |
| dark | admitted neutral stable relic under fixed gravity | modified law or named particle |
| tully | three space plus one orbital recurrence | measured or fitted slope |
| resonance | finite low denominator common refinement | irrational continuum period |
| tidal | finite mismatch exhaustion to one to one | unbounded or selected terminal ratio |
| measurement | all targets inaccessible until seal | target readable before seal |
| extension | no extra rule | free response scale or correction |

### 11.5. Compact support and horizon

| Axis | Preserving construction | Other alternatives |
|---|---|---|
| occupation | one fermion per generated cell | multiply occupied cell |
| momentum | cube side momentum depth | selected momentum scale |
| support | occupants times forced depth q4 | imported pressure equation |
| gravity | paired source q6 | linear unpaired source |
| threshold | three quarter preimage to half One | chosen dimensional mass |
| endpoint | exactly two binary fibre families | open ended remnant list |
| radius | one Fold mass doubling | imported metric radius |
| area | rank two radius pair | volume support |
| entropy | quarter area boundary record | selected entropy coefficient |
| thermal | fixed thermal mass product | constant or fitted temperature |
| floor | positive finite floor at every reached depth | numerical zero or completed infinity |
| extension | no extra rule | free family or correction |

### 11.6. Chirp, merger and ringdown

| Axis | Preserving construction | Other alternatives |
|---|---|---|
| source | held two source orbit | unheld single source |
| moment | admitted quadrupole rate | monopole or dipole radiation |
| transfer | positive retained take | negative or erased energy |
| separation | strictly shrinking positive separation | fixed or expanding orbit |
| balance | inverse square period square equals radius cube | imported or selected frequency law |
| wave | two wave cycles per orbit | one or free wave cycle per orbit |
| contact | first horizon boundary contact | chosen merger time |
| merger | one remnant with held ledger | erased or two source remnant |
| tone | held remnant mass turn class | fitted tone |
| damping | binary half One contraction | negative exponential or free decay |
| floor | positive at every finite depth | numerical zero or completed infinity |
| sequence | inspiral chirp merger ringdown | permuted or omitted stage |

### 11.7. The three complete empirical grammars

Each separately registered stellar, compact-horizon and chirp observation uses the complete eight-axis binary product, giving 256 candidates. Its relation coordinate is the corresponding sealed formal construction. The shared axes are:

| Axis | Preserving construction | Rejected alternative |
|---|---|---|
| Carrier | Complete Fold carrier | Answer-only scalar |
| Relation | Source-specific sealed relation | Imported/fitted relation |
| Provenance | Source-bound proof trace | Unbound provenance |
| Prediction | Capability-closed prediction | Target-readable prediction |
| Record | Separate measurement record | Proof/measurement conflation |
| Rows | Complete registered rows | Selected favourable rows |
| Generality | One base and successor closure | Finite answer lookup |
| Extension | No extra rule | Free extra rule |

Each record appends the next declared source row with its original identity, value, uncertainty and role. The formal law remains fixed throughout. Complete row retention and the source-specific unfavorable controls establish the actual comparison, including the central baryonic-slope exclusion and thermal prediction status.

### 11.8. Exact source and proof correspondence

All original laws are pinned to V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Native proofs and retained checks are pinned to V4 edition 0.4, commit `21cdf559922fb057f8560f42d056ffa035329eb3` [3]. The complete source archive accompanying this paper includes the original law/validation operations, native modules and their imports, exact source correspondence, original build results, raw declaration audits, complete candidate/program comparisons and portable arithmetic reproduction.

| Source entry | Principal native declarations, under `SFT.Physics` | Completion evidence / audited declarations |
|---|---|---|
| Static exterior 011 | `StaticExteriorClockGeneral.originalEveryExteriorComplement`, `uniqueOriginalPositiveComplement`, `originalEveryRadiusWellHalving`, `originalEveryRadiusFieldQuartering`, `originalEveryBoundaryEmpty` | TURN 983 / 117 |
| Quadrupole power 012 | `QuadrupoleRadiatedPowerGeneral.originalEveryAmplitudeOpposition`, `originalEveryFirstDifference`, `originalEverySecondDifference`, `originalEveryThirdDifference`; full certificate | TURN 985 / 128 |
| Stellar response 067 | `StellarRadialDerivation.originalCompressedCrossOrder`, `originalExpandedCrossOrder`; `StellarTides.completeTraceLength`, `completeTraceTerminal`; `StellarTidalClosure.originalStrictBeforeLock` | TURN 1062 / 243 |
| Stellar observation 068 | `StellarObservationAnalysisProofs.originalComplete` and all four complete altered-record equalities | TURN 1062 / 126 |
| Compact horizon 071 | `CompactHorizonDerivation.originalExclusionExponentOrder`, `originalPositiveHorizon`, `originalThermalMassInvariant`, `originalEvaporationTotal` and successor-order proofs | TURN 1062 / 246 |
| Horizon observation 072 | `HorizonObservationAnalysisProofs.originalComplete` and all three complete altered-record equalities | TURN 1062 / 117 |
| Chirp/ringdown 073 | `ChirpRingdownDerivation.originalOrbitalRow`, `originalBinaryBindingTake`, all ringdown induction proofs; `ChirpInspiral.originalFullTrace`, `originalTerminalContact`, `originalAllRetainedTakesPositive` | TURN 1062/1063 / 255 |
| Chirp observation 074 | `ChirpObservationAnalysisProofs.originalComplete` and all four complete altered-record equalities | TURN 1062/1063 / 121 |

All reported audit dependencies are empty. General results retain their full quantified inputs and proof arguments; complete observation equalities retain every field. The original/native comparisons cover eighteen exterior-certificate fields, twenty-one quadrupole fields, twelve stellar-certificate fields, eight compact-horizon fields and seven chirp-certificate fields. Their five complete observation analyses have 26, 24, 34, 17 and 16 fields respectively. The paper's exact arithmetic reproduction executes the unchanged original function bodies and reconstructs these records.

## 12. Physical sequence and established results

The exterior law connects doubled source radius, rank-two flux, the retained well and a unique positive clock coefficient. The quadrupole construction connects positive generated differences to amplitude-squared power and conserved shell transport. Stellar response fixes the restoring exponent order, two luminosity classes, enclosed-support requirement and finite isolated tidal lock. Compact exclusion and paired gravity establish their exact exponent ordering, with the two endpoint families continuing into the horizon carrier. The complete binary inspiral reaches the actual contact row, retains positive radiation takes, joins two sources and produces a positive decaying remnant at every finite depth. The observed records test the corresponding clock, binary-radiation, stellar, galaxy, compact-object and wave relations in their original forms; the exact horizon thermal invariant remains available for its stated observational test.

## Appendix A. Complete exterior theory and clock comparison rows

The following table retains the source's full external-theory and NIST vector. The historical and prerequisite bindings are included in the source archive with all thirty-four ordered target fields.

| Original field | Retained value |
|---|---|
| external unique spherical vacuum | Schwarzschild-solution-under-vanishing-cosmological-constant |
| external static exterior | true |
| external vacuum equation | Ricci-tensor-empty-in-source-free-exterior |
| external time coefficient | One-take-two-G-M-over-radius |
| external radial coefficient | inverse-of-time-coefficient |
| external mass parameter | m-equals-G-M-over-c-squared |
| external horizon radius | two-m-equals-two-G-M-over-c-squared |
| external asymptotic flatness | dictated-by-spherical-vacuum-solution |
| external spherical vacuum radiation | absent |
| nist predicted fractional gradient per mm | -1.09e-19 |
| nist full cloud corrected gradient per mm | -9.8(2.3)e-20 |
| nist split cloud corrected gradient per mm | -1.28(27)e-19 |
| nist fractional frequency uncertainty | 7.6e-21 |
| nist measurement count | 14-over-10-days |
| nist higher clock direction | higher-region-ticks-faster |
| nist systematic corrections retained | true |
| nist result consistent with predicted redshift | true |
| nist measures universal Fold clock fraction | false |

## Appendix B. Complete primary Double Pulsar vector

The original record's reported signs and units remain measurement records. Every primary row is retained here in source order.

| Original field | Retained value |
|---|---|
| primary system | PSR-J0737-3039A/B-Double-Pulsar |
| primary observation span | 16-years |
| primary orbital period | 2.45-hours |
| primary eccentricity | 0.088 |
| primary tracked orbits | approximately-60000 |
| primary dominant orbital decay cause | gravitational-wave-emission |
| primary shklovskii correction | +1.72(15)e-16 |
| primary galactic correction | -3.40(+25/-24)e-16 |
| primary combined external correction | -1.68(+11/-10)e-16 |
| primary intrinsic orbital decay | -1.247752(79)e-12 |
| primary spin down mass loss correction | +2.9(2)e-17 |
| primary measured GW orbital decay | -1.247782(79)e-12 |
| primary measured fractional precision | 6e-5 |
| primary leading quadrupole prediction | -1.247810(+6/-7)e-12 |
| primary next order 3 5PN correction | -1.75e-17 |
| primary total prediction | -1.247827(+6/-7)e-12 |
| primary measured over predicted ratio | 0.999963(63) |
| primary 95 percent agreement boundary | 1.3e-4 |
| primary extreme EOS ratio | 0.999958(64) |
| primary cumulative periastron normalized chi squared | 0.76 |
| primary leading order classification | quadrupole-formula-at-2.5PN-in-equations-of-motion |
| primary next order classification | 3.5PN-in-equations-of-motion |
| primary distance uncertainty currently subdominant | true |
| primary observed timing error dominates current intrinsic uncertainty | true |
| primary future limit requires kinematic corrections | true |
| primary regime | mildly-relativistic-strong-field-material-binary |
| primary black-hole merger comparison requires regime caveat | true |
| primary alternative scalar theories can add lower-moment-radiation | true |
| primary result measures universal Fold power fraction | false |

## References

1. Smith, Maria. *SFT V3 physics corpus*. DOI: [10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655).
2. Smith, Maria. *SFT V3 monograph*. DOI: [10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Operational foundation: [10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).
3. Smith, Maria. *SFT native Lean 4 verification, edition 0.4*. DOI: [10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). [Pinned V4 source](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3). Cumulative manuscript sections 853, 854, 974–976 and 979–982.
4. Smith, Maria. *Generator three, spatial three and boundary rank two*. DOI: [10.5281/zenodo.24325335](https://doi.org/10.5281/zenodo.24325335).
5. Smith, Maria. *Seven sectors from one rooted constants construction*. DOI: [10.5281/zenodo.24325452](https://doi.org/10.5281/zenodo.24325452).
6. Smith, Maria. *A finite quantum-gravity construction with exact local conservation*. DOI: [10.5281/zenodo.24325740](https://doi.org/10.5281/zenodo.24325740).
7. NIST/JILA. *Resolving the gravitational redshift across a millimetre-scale atomic sample*. [Publication record](https://www.nist.gov/publications/resolving-gravitational-redshift-across-millimetre-scale-atomic-sample). Exterior-theory source: *Schwarzschild and Kerr Solutions of Einstein's Field Equation: an introduction*, [arXiv:1503.02172](https://arxiv.org/abs/1503.02172).
8. Kramer et al. *Strong-Field Gravity Tests with the Double Pulsar*. [arXiv:2112.06795](https://arxiv.org/abs/2112.06795).
9. *Our Sun IV: The Standard Model and Helioseismology: Consequences of Uncertainties in Input Physics and in Observed Solar Parameters*. [NASA NTRS 20010111092](https://ntrs.nasa.gov/citations/20010111092).
10. *Interrelated main-sequence mass-luminosity, mass-radius and mass-effective temperature relations*. [arXiv:1807.02568](https://arxiv.org/abs/1807.02568).
11. *SPARC: Mass Models for 175 Disk Galaxies with Spitzer Photometry and Accurate Rotation Curves*. [arXiv:1606.09251](https://arxiv.org/abs/1606.09251).
12. *The baryonic Tully-Fisher relation for different velocity definitions and implications for galaxy angular momentum*. [arXiv:1901.05966](https://arxiv.org/abs/1901.05966).
13. Clowe et al. *A direct empirical proof of the existence of dark matter*. [arXiv:astro-ph/0608407](https://arxiv.org/abs/astro-ph/0608407).
14. NASA Glenn Research Center. *Moon*. [Source record](https://www1.grc.nasa.gov/beginners-guide-to-aeronautics/moon/).
15. *The Gravity Field, Orientation, and Ephemeris of Mercury from MESSENGER Observations After Three Years in Orbit*. [NASA NTRS 20150000346](https://ntrs.nasa.gov/citations/20150000346).
16. NASA GSFC. *White Dwarfs*. [Source record](https://imagine.gsfc.nasa.gov/science/objects/dwarfs2.html).
17. Fonseca et al. *Refined Mass and Geometric Measurements of the High-Mass PSR J0740+6620*. [arXiv:2104.00880](https://arxiv.org/abs/2104.00880).
18. LIGO–Virgo. *Model comparison from LIGO-Virgo data on GW170817 binary components and consequences for the merger remnant*. [LIGO-P1800379](https://dcc.ligo.org/LIGO-P1800379/public).
19. LIGO–Virgo. *Observation of Gravitational Waves from a Binary Black Hole Merger*. [LIGO-P150914](https://dcc.ligo.org/P150914/public). Disclosed development-context source.
20. LIGO–Virgo. *GW151226: Observation of Gravitational Waves from a 22-Solar-Mass Binary Black Hole Coalescence*. [LIGO-P151226](https://dcc.ligo.org/LIGO-P151226/public).
21. LIGO–Virgo. *GW190521: A Binary Black Hole Merger with a Total Mass of 150 Solar Masses*. [LIGO-P2000020](https://dcc.ligo.org/P2000020/public).

**Authorship.** Maria Smith is the scientific author of SFT and its original derivations. AI assistance supports source-bound exposition, proof correspondence and publication preparation under her direction.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

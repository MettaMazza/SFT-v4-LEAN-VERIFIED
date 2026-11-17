# Primordial abundances, inflation and cosmic expansion from exact Fold transport

**Maria Smith · Ernos Labs**  
Standalone paper 17 · Version 1.1 · 17 November 2026  
DOI: 10.5281/zenodo.24326655

## Abstract

The least binary cover of generator-three spatial volume is \(2^5=32\), fixing five exact doubling transitions and the complete scalar/tensor partition \((31/32,1/32)\). The thermal construction gives inverse temperature transport, freeze-out neutron/proton ratio \(1/6\), capture-entry ratio \(1/7\), and analytic helium-family share \(1/4\). Complete four-constituent isotope closure converts the latter to the physical helium share \(59/240\). General native Lean proofs establish exact temperature invariance, descending threshold order, normalized finite visibility with a unique midpoint, complete alternating acoustic modes, positive finite sound horizons and matter-over-radiation growth equal to every supplied positive rational scale factor. The same cover gives matter/vacuum shares \((5/16,11/16)\) and the late expansion law \(E^2(r)=(11+5r^3)/16\). Complete post-seal comparisons contain the physical helium and scalar predictions, retain the strict tensor margin \(3/4000\), and accept all 32 chronometers through an exact rational mean-square residual certificate after three refinements, with upper mean below \(0.897598\). We give the intermediate derivations, complete observation tables, earlier family-share and angular-peak comparisons, cosmic-budget and acceleration tests, adverse records, full grammars and corresponding source-bound Lean evidence.

**Keywords:** primordial helium abundance; inflation; scalar spectral index; tensor-to-scalar ratio; cosmic microwave background; acoustic modes; cosmic chronometers; Smithian Fold Theory; Lean 4.

## 1. One counted support, several exact observables

The generated three-space volume is \(3^3=27\). Its first complete binary cover is 32 because

\[2^4=16<27\leq32=2^5.\]

One retained boundary distinction in this complete support leaves 31 scalar records and one tensor-pair record. The original inflation construction therefore gives

\[n_s=\frac{31}{32},\qquad r_t=\frac1{32},\qquad n_s+r_t=1.\]

The physical helium isotope follows a separate complete incidence construction:

\[Y_{\mathrm{He}}=\frac14\frac{4(2^4-1)-1}{4(2^4-1)}=\frac{59}{240}.\]

The present cosmic matter/vacuum partition uses both boundary records at each of the five cover depths:

\[\Omega_m=\frac{2\cdot5}{32}=\frac5{16},\qquad
\Omega_v=\frac{32-10}{32}=\frac{11}{16}.\]

These quantities have different carrier meanings. Their constructions and comparisons remain distinct throughout the paper. The exact predictions are sealed before the corresponding observation records are released. The original entries retain observational-derivation provenance; the historical observations are not relabelled as previously unknown.

The formal carriers are positive exact rational temperatures, scale factors, durations and speeds; positive finite counts; complete finite supports; and the source’s typed pressure and acceleration orientations. V3 defines these operations [1,2], and V4 supplies their native implementations, general proofs and complete program comparisons [3].

## 2. Exact cooling and thermal order

### 2.1. Inverse transport

Let \(T>0\) be an exact temperature and \(g>0\) the later/earlier scale ratio. The source operation is

\[T'=\frac Tg.\]

The product retained by transport is

\[T'g=\frac Tg\,g=T.\]

For \(T=a/b\) and \(g=n/d\), with all four integers positive,

\[T'=\frac{ad}{bn},\qquad T'g=\frac{ad}{bn}\frac nd=\frac ab.\]

The cancellation uses positive denominators and preserves the exact carrier. `ThermalHistoryTransport.originalInverseTransport` binds the source operation to this quotient for arbitrary positive fractions. `originalHeldProduct` and `originalInvariant` prove the recomposition and returned invariant result for every admitted pair. The certificate retains nine prescribed temperature/growth pairs as executable witnesses, while these proofs quantify over all positive rational pairs.

### 2.2. Complete descending thresholds

For positive fractions \(a=n_a/d_a\) and \(b=n_b/d_b\),

\[a<b\iff n_ad_b<n_bd_a.\]

The source requires a nonempty list of distinct positive thresholds and sorts them in descending order. Insertion into an empty list returns the single supplied threshold. At a nonempty list, insertion places the new threshold before the first smaller head; otherwise it retains the head and continues on the tail. Transitivity of the cross-product order preserves the descending relation. In either branch every input occurrence is retained. Sorting composes this insertion with the sorted tail.

Thus the output is both descending and a permutation of the full input. `ThermalHistoryOrder.originalAcceptedDescending` states both properties for every admitted list. The certificate’s complete example is

\[\left(\frac78,\frac34,\frac12,\frac14\right).\]

The order follows the thresholds and exact cooling operation. No additional chronology selects the sorting result.

## 3. Freeze-out, capture and physical helium

### 3.1. The full live orbit and two ratios

The original depth-seven recurrence starts at residue one and repeatedly doubles modulo seven:

\[1\longmapsto2\longmapsto4\longmapsto1.\]

All three pre-return residues are distinct, so the complete live orbit is \((1,2,4)\). Its least part is \(1/7\). The freeze-out ledger retains neutron share \(1/7\) and proton share \(6/7\), giving

\[\left(\frac np\right)_{\!f}=\frac{1/7}{6/7}=\frac16.\]

The least binary support covering seven has three doublings:

\[2^2=4<7\leq8=2^3.\]

Transporting the held neutron record into this complete cover gives capture-entry shares \(1/8\) and \(7/8\), hence

\[\left(\frac np\right)_{\!c}=\frac{1/8}{7/8}=\frac17.\]

Pairing each retained neutron with one proton places two eighths in the helium family and leaves six eighths in the hydrogen family:

\[Y_{\mathrm{family}}=2\frac18=\frac14,\qquad
X_{\mathrm{family}}=\frac68=\frac34,\]
\[Y_{\mathrm{family}}+X_{\mathrm{family}}=1.\]

`ThermalHistory.freezeoutCaptureLedger` returns the complete orbit, both shares at both boundaries, both ratios and both family fractions. The closed native proofs verify these exact outputs.

### 3.2. Complete isotope incidence and its unique identity

Helium-four has four retained constituent positions. Every constituent is either present or absent in a subword, so four positions generate \(2^4=16\) binary masks. Removing the empty mask leaves precisely

\[\mathcal M=\{1,2,\ldots,15\}.\]

The source retains the complete incidence product

\[\mathcal C=\{1,2,3,4\}\times\mathcal M.\]

Every position occurs against every nonempty mask; equality of pairs is equality in both coordinates. There are therefore \(4\cdot15=60\) distinct cells. Binding this support into one isotope retains one collective composite-identity record. No identity would leave separate constituent labels; more than one would add a second independent composite. The source holds that one identity outside the mass-incidence cells, leaving 59 of the 60 cells in the physical isotope conversion:

\[\eta=\frac{60-1}{60}=\frac{59}{60}.\]

Composition with the already derived family share gives

\[Y_{\mathrm{He}}=\frac14\eta=\frac{59}{240},\qquad
X_{\mathrm H}=\frac{181}{240},\]
\[Y_{\mathrm{He}}+X_{\mathrm H}=\frac{59+181}{240}=1.\]

Repeating disjoint copies of the same complete isotope word repeats the same 60-cell incidence and one identity per isotope, preserving the conversion \(59/60\). `HeliumIsotope.originalSubwords` proves the full mask list; `fullCertificate` checks all 60 distinct cells, the single identity and exact conversion; `physicalShares` proves both returned physical fractions. The source’s eight-axis grammar preserves this exact construction and its target boundary.

## 4. Finite visibility and complete acoustic recurrence

### 4.1. Positive visibility with a unique midpoint

At every positive integer radius \(r\), the source constructs

\[W_r=(1,2,\ldots,r,r+1,r,\ldots,2,1).\]

Let \(Z_r\) be its exact sum. Every weight is positive, so \(Z_r>0\). The source divides each weight by the same total:

\[P_r=\left(\frac{w}{Z_r}:w\in W_r\right).\]

For every prefix, common-denominator addition gives

\[\sum_{i=1}^{j}\frac{w_i}{Z_r}=\frac{\sum_{i=1}^{j}w_i}{Z_r}.\]

At the full support this becomes \(Z_r/Z_r=1\). The midpoint is the single displayed weight \(r+1\). Every side weight satisfies \(1\leq k\leq r<r+1\), and division by the same positive total preserves strict order:

\[\frac{k}{Z_r}<\frac{r+1}{Z_r}.\]

Consequently the normalized midpoint is uniquely maximal. `ThermalHistoryVisibility.originalMidpointDecomposition` identifies the source’s complete rising/reflected support. `originalNormalizedRecord`, `originalNormalizedTotal` and `originalVisibilityComplete` prove the actual normalized list and total. `originalUniqueNormalizedMidpoint` identifies one peak between two strictly smaller sides for every positive radius.

For example, radius two has weights \((1,2,3,2,1)\), total nine and normalized support \((1,2,3,2,1)/9\). The source certificate retains every radius from one through eight; the quantified proofs apply to every positive radius. The bound/free classification midpoint is half-One, while the physical visibility support remains finite and positive.

### 4.2. Internal modes and parity

For every positive mode count \(N\), the original mode ledger enumerates exactly

\[m=1,\ldots,N,\qquad\phi_m=\frac{m}{N+1}.\]

Every numerator and denominator is positive. Odd modes carry compression, and even modes carry rarefaction. Since successive integers exchange their residue modulo two, each successor exchanges the loading label. The source count \(N=8\) gives

\[\left(\frac19,\frac29,\frac39,\frac49,\frac59,\frac69,\frac79,\frac89\right)\]

with loading sequence compression, rarefaction, repeated four times. `originalModeLedger` identifies all returned rows; `originalCompleteModeCount`, `originalPositiveMode` and `originalPhasePositive` establish completeness and positivity. `originalSuccessiveParity` and `originalLoadingAlternates` prove the recurrence for arbitrary indices.

### 4.3. The exact finite sound horizon

For every nonempty finite ordered list of positive duration-speed pairs \((\Delta t_i,v_i)\), the source forms

\[s_i=\Delta t_i v_i>0,\]
\[S_1=s_1,\qquad S_{i+1}=S_i+s_{i+1},\qquad H=S_n.\]

The base is positive, and addition of each positive segment preserves positivity. Every segment occurs once in source order. `ThermalHistoryHorizon.originalSegments` binds the original two-list operation to all supplied pairs; `originalPositiveSum` proves the exact left-fold representation; `originalFiniteHorizon` establishes the complete returned positive sum for every such list.

The registered example evaluates every intermediate product:

\[H=\frac18\frac12+\frac14\frac23+\frac38\frac34
=\frac1{16}+\frac16+\frac9{32}
=\frac{6+16+27}{96}=\frac{49}{96}.\]

Internal mode labels and finite horizon segments are the formal carriers. The observed angular peak positions retain their projection and driving records in the comparison below.

## 5. The least inflation cover and exact forward growth

### 5.1. Cover recurrence and minimality

The generated spatial and boundary counts are three and two [5]. For a positive whole size \(n\), the original cover loop begins at depth one and support two, then repeatedly applies

\[(d,s)\longmapsto(d+1,2s)\]

while \(s<n\). The invariant is \(s=2^d\). Each visited depth below the terminal depth fails the covering inequality. Therefore the returned depth satisfies

\[d(n)>0,\qquad n\leq2^{d(n)},\qquad
0<k<d(n)\Longrightarrow2^k<n.\]

The existing least-cover proof supplies this general result. `InflationGrowth.everyPositiveCover` binds the original operation to it, and `coverMinimal` states its full minimum property. At volume \(3^3=27\), the successive supports are \(2,4,8,16,32\); only the last covers 27. Thus the exact cover is \((5,32)\).

The exact-duration operation accepts a supplied whole ratio \(q\geq2\) precisely when \(q=2^{d(q)}\). It then returns \(d(q)\); otherwise it rejects the incomplete doubling support. `originalAcceptedExactSupport` and `originalCompleteSupportAccepted` prove both directions. At ratio 32, duration is exactly five doublings.

### 5.2. Scalar/tensor partition and perturbation growth

One held boundary distinction leaves 31 scalar-support records and one tensor-pair record in the complete 32-state support:

\[n_s=\frac{32-1}{32}=\frac{31}{32},\qquad r_t=\frac1{32}.\]

Their sum is One. `originalShares` proves both source outputs. The original perturbation trace is

\[\frac14\longmapsto\frac12\longmapsto1,\]

with strict increase at both Fold steps. The ten-field certificate retains the volume, cover, shares, partition, exact duration, full trace, strict growth and original transfer witnesses.

### 5.3. Relative matter/radiation transport

At every later positive exact scale growth \(g=n/d\), three-space retention gives

\[M(g)=\frac1{g^3}=\frac{d^3}{n^3}.\]

Radiation has one additional recurrence factor:

\[R(g)=\frac1{g^4}=\frac{d^4}{n^4}.\]

The exact relative factor is

\[\frac{M(g)}{R(g)}=\frac{d^3n^4}{n^3d^4}=\frac nd=g.\]

All denominators remain positive. The last equality follows by associativity and commutativity from

\[(d^3n^4)d=n(n^3d^4).\]

`InflationGrowthTransport.originalPositiveTransfer` proves the complete three-field result for arbitrary positive \(n,d\). `originalRelativeGrowth` carries it to every original positive-fraction carrier. The five operational witnesses \(g=1/2,1,3/2,2,3\) are retained separately from this universal proof.

## 6. Thermal and inflation observations

### 6.1. Full thermal intervals and physical helium

The complete registered thermal rows give the following exact readings [6–10]:

| Quantity | Central value | Reported uncertainty | Exact interval |
|---|---:|---:|---|
| Temperature exponent | 1.007 | 0.027 | \([49/50,517/500]\) |
| Physical helium share | 0.2458 | 0.0013 | \([489/2000,2471/10000]\) |
| Deuterium share multiplied by \(10^5\) | 2.527 | 0.030 | \([2497/1000,2557/1000]\) |
| Recombination redshift | 1089.92 | 0.25 | \([1089.67,1090.17]\) |

The inverse transport exponent is One, which lies in the temperature interval. The physical isotope inclusion is exact:

\[\frac{489}{2000}\leq\frac{59}{240}\leq\frac{2471}{10000}.\]

Its cross-products are

\[489\cdot240=117360\leq118000=59\cdot2000,\]
\[59\cdot10000=590000\leq593040=2471\cdot240.\]

The analytic family quarter remains separately typed. Its value \(1/4=0.25\) exceeds the measured isotope upper edge \(0.2471\), and its central difference is \(0.25-0.2458=0.0042\). The physical closure in section 3 supplies the isotope quantity used by the measured-value successor.

The deuterium interval is positive. After undoing its displayed \(10^5\) scale, its upper share is \(2557/100000000\), below the helium lower edge \(489/2000\). The registered approximate neutron/proton labels are \(1/6\) at freeze-out and \(1/7\) at capture, matching the distinct exact ratios. The recombination interval retains a positive width and positive support.

### 6.2. Every retained acoustic peak

The original record retains eighteen detected extrema and all seven temperature-temperature peak rows. Amplitudes and their uncertainties are in the source table’s temperature-power units.

| Peak | Multipole | Uncertainty | Amplitude | Uncertainty |
|---:|---:|---:|---:|---:|
| 1 | 220.6 | 0.6 | 5733 | 39 |
| 2 | 538.1 | 1.3 | 2586 | 23 |
| 3 | 809.8 | 1.0 | 2518 | 17 |
| 4 | 1147.8 | 2.3 | 1227 | 9 |
| 5 | 1446.8 | 1.6 | 799 | 5 |
| 6 | 1779 | 3 | 378 | 3 |
| 7 | 2075 | 8 | 227 | 6 |

All four vectors contain seven positive values. The earlier eighteen-field comparison also computes the scaled-first-peak overlap test: for each \(m=2,\ldots,7\), it compares \(m[220.0,221.2]\) with the corresponding peak interval. Each pair is disjoint. The measured-value successor retains these angular positions as projection/method records; its acceptance uses full census, positive rows and retained source boundaries. It does not use angular noninteger displacement as a physical success criterion. The exact internal mode recurrence remains the one derived in section 4.

The fourteen-field successor analysis retains temperature, physical helium and scaled deuterium intervals, the exact physical helium share and ten original checks. A changed helium interval \([0.2299,0.2301]\) excludes \(59/240\). Changing only the detected count from eighteen to seventeen fails the census. The earlier changed temperature centre 1.100, with width 0.027 retained, gives \([1.073,1.127]\) and excludes One. Every control is rejected by its original test.

### 6.3. Inflation support comparison

The registered Planck scalar row [11] gives

\[c_s=\frac{9649}{10000},\qquad u_s=\frac{42}{10000},\]
\[I_s=\left[\frac{9607}{10000},\frac{9691}{10000}\right].\]

The generated share \(31/32\) lies inside this complete interval. Its exact central distance is

\[\left|\frac{31}{32}-\frac{9649}{10000}\right|=\frac{77}{20000}=0.00385.\]

The registered tensor upper bound [12] is strict:

\[r_t=\frac1{32}<\frac4{125}=0.032,\]
\[\frac4{125}-\frac1{32}=\frac{128-125}{4000}=\frac3{4000}>0.\]

The source’s ten-field comparison retains both predictions, scalar interval and distance, strict tensor bound and margin, partition and complete-row flag. Its changed scalar centre \(0.9\) with the same uncertainty excludes \(31/32\) and rejects. The observed values do not alter the original support count or complete grammar.

## 7. Cosmic component transport from the same cover

### 7.1. Present budget and complete composition

The complete boundary pair pins two records at each of the five cover depths. Thus the 32-state support contains ten pinned matter records and 22 free vacuum records:

\[\Omega_m=10/32=5/16,\qquad\Omega_v=22/32=11/16.\]

The original complete-budget operation also retains the internal matter partition \(5/32\) and \(27/32\), giving baryon \(25/512\) and cold-dark share \(135/512\). Their sum is \(160/512=5/16\), and adding vacuum closes to One. The source preserves the earlier leading \((1/3,2/3)\) partition as a distinct earlier approximation; the complete depth-five discriminator supplies the present terminal shares. `CosmicComponentTransport.generatedBudgetCoefficients` connects the actual complete-budget operation to the transport coefficients.

### 7.2. General positive-stretch laws

Let \(r>0\) be exact past stretch. Matter retains three volume powers, radiation retains those three plus one recurrence power, and the vacuum invariant retains One:

\[M_r=r^3,\qquad R_r=r^4,\qquad V_r=1.\]

Composing the terminal matter and vacuum shares gives

\[E^2(r)=\frac{11}{16}+\frac5{16}r^3=\frac{11+5r^3}{16}.\]

The epoch fractions divide each component by the complete rate:

\[\Omega_m(r)=\frac{5r^3}{11+5r^3},\qquad
\Omega_v(r)=\frac{11}{11+5r^3}.\]

Their sum is One at every positive stretch. For \(r=n/d\), the exact common numerator is \(11d^3+5n^3>0\), so

\[E^2=\frac{11d^3+5n^3}{16d^3},\quad
\Omega_m=\frac{5n^3}{11d^3+5n^3},\quad
\Omega_v=\frac{11d^3}{11d^3+5n^3}.\]

`everyMatterTransport`, `everyRadiationTransport`, `everySquaredExpansion`, `everyMatterFraction`, `everyVacuumFraction` and `fractionsCloseAtEveryStretch` prove these original operations for all positive numerators and denominators.

### 7.3. Equality and acceleration

Matter-vacuum equality requires \(5r^3=11\), hence

\[r_{\mathrm{eq}}^3=\frac{11}{5}.\]

The source’s half-matter/vacuum balance requires \(5r^3=2\cdot11\), hence

\[r_{\mathrm{acc}}^3=\frac{22}{5}.\]

At the present boundary, the positive accelerating separation is

\[A_0=\frac{11}{16}-\frac12\frac5{16}
=\frac{22-5}{32}=\frac{17}{32}.\]

The two balance theorems verify the exact substitutions. Tension and acceleration retain their typed orientations; conventional negative signs in the external records select those orientations and leave positive magnitudes for the comparison.

## 8. All 32 chronometers and the exact residual decision

### 8.1. Complete input and rational root brackets

The registered reference is \(H_0=67.66=3383/50\) with uncertainty \(u_0=0.42=21/50\) km s\(^{-1}\) Mpc\(^{-1}\). Every chronometer row [13] supplies \(z_i,H_i,u_i\). The formal carrier is evaluated at \(r_i=1+z_i\):

\[E_i^2=\frac{11+5(1+z_i)^3}{16}.\]

The source begins with consecutive integer bounds \([k_i,k_i+1]\) satisfying

\[k_i^2\leq E_i^2<(k_i+1)^2.\]

At each refinement, \(m_i=(l_i+u_i^{\mathrm{root}})/2\). If \(m_i^2\leq E_i^2\), retain \([m_i,u_i^{\mathrm{root}}]\); otherwise retain \([l_i,m_i]\). This preserves a rational enclosure and the original equality branch. The following table gives every source row and the final root bracket \([a_i,b_i]/8\) after three refinements. The displayed \(u_i\) is the observed Hubble uncertainty; both Hubble columns use km s\(^{-1}\) Mpc\(^{-1}\).

<table style="break-inside:auto"><thead><tr><th>Row</th><th>Redshift</th><th>Hubble value</th><th>Uncertainty</th><th>Root bracket</th></tr></thead><tbody><tr><td>1</td><td>0.07</td><td>69.0</td><td>19.6</td><td>[8,9]/8</td></tr><tr><td>2</td><td>0.09</td><td>69.0</td><td>12.0</td><td>[8,9]/8</td></tr><tr><td>3</td><td>0.12</td><td>68.6</td><td>26.2</td><td>[8,9]/8</td></tr><tr><td>4</td><td>0.17</td><td>83.0</td><td>8.0</td><td>[8,9]/8</td></tr><tr><td>5</td><td>0.1791</td><td>78.0</td><td>6.2</td><td>[8,9]/8</td></tr><tr><td>6</td><td>0.1993</td><td>78.0</td><td>6.9</td><td>[8,9]/8</td></tr><tr><td>7</td><td>0.2</td><td>72.9</td><td>29.6</td><td>[8,9]/8</td></tr><tr><td>8</td><td>0.27</td><td>77.0</td><td>14.0</td><td>[9,10]/8</td></tr><tr><td>9</td><td>0.28</td><td>88.8</td><td>36.6</td><td>[9,10]/8</td></tr><tr><td>10</td><td>0.3519</td><td>85.5</td><td>15.7</td><td>[9,10]/8</td></tr><tr><td>11</td><td>0.3802</td><td>86.2</td><td>14.6</td><td>[9,10]/8</td></tr><tr><td>12</td><td>0.4</td><td>95.0</td><td>17.0</td><td>[9,10]/8</td></tr><tr><td>13</td><td>0.4004</td><td>79.9</td><td>11.4</td><td>[9,10]/8</td></tr><tr><td>14</td><td>0.4247</td><td>90.4</td><td>12.8</td><td>[10,11]/8</td></tr><tr><td>15</td><td>0.4497</td><td>96.3</td><td>14.4</td><td>[10,11]/8</td></tr><tr><td>16</td><td>0.47</td><td>89.0</td><td>49.6</td><td>[10,11]/8</td></tr><tr><td>17</td><td>0.4783</td><td>83.8</td><td>10.2</td><td>[10,11]/8</td></tr><tr><td>18</td><td>0.48</td><td>97.0</td><td>62.0</td><td>[10,11]/8</td></tr><tr><td>19</td><td>0.5929</td><td>107.0</td><td>15.5</td><td>[11,12]/8</td></tr><tr><td>20</td><td>0.6797</td><td>95.0</td><td>10.5</td><td>[11,12]/8</td></tr><tr><td>21</td><td>0.75</td><td>98.8</td><td>33.6</td><td>[12,13]/8</td></tr><tr><td>22</td><td>0.7812</td><td>96.5</td><td>12.5</td><td>[12,13]/8</td></tr><tr><td>23</td><td>0.8754</td><td>124.5</td><td>17.4</td><td>[13,14]/8</td></tr><tr><td>24</td><td>0.88</td><td>90.0</td><td>40.0</td><td>[13,14]/8</td></tr><tr><td>25</td><td>0.9</td><td>117.0</td><td>23.0</td><td>[13,14]/8</td></tr><tr><td>26</td><td>1.037</td><td>133.5</td><td>17.6</td><td>[14,15]/8</td></tr><tr><td>27</td><td>1.3</td><td>168.0</td><td>17.0</td><td>[16,17]/8</td></tr><tr><td>28</td><td>1.363</td><td>160.0</td><td>33.8</td><td>[17,18]/8</td></tr><tr><td>29</td><td>1.43</td><td>177.0</td><td>18.0</td><td>[18,19]/8</td></tr><tr><td>30</td><td>1.53</td><td>140.0</td><td>14.0</td><td>[19,20]/8</td></tr><tr><td>31</td><td>1.75</td><td>202.0</td><td>40.0</td><td>[21,22]/8</td></tr><tr><td>32</td><td>1.965</td><td>186.5</td><td>50.6</td><td>[23,24]/8</td></tr></tbody></table>

### 8.2. Every residual contribution and stopping rule

Set \(p_i^-=H_0l_i\) and \(p_i^+=H_0u_i^{\mathrm{root}}\). The exact absolute-distance bounds are

\[[d_i^-,d_i^+]=\begin{cases}
[p_i^--H_i,p_i^+-H_i],&H_i<p_i^-,\\
[H_i-p_i^+,H_i-p_i^-],&H_i>p_i^+,\\
[0,\max(H_i-p_i^-,p_i^+-H_i)],&p_i^-\leq H_i\leq p_i^+.
\end{cases}\]

The source variance unit is

\[V_i=u_i^2+E_i^2u_0^2>0.\]

Every row contributes exactly once to both means:

\[B_i^-=(d_i^-)^2/V_i,\qquad B_i^+=(d_i^+)^2/V_i,\]
\[M^-=\frac1{32}\sum_{i=1}^{32}B_i^-,\qquad
M^+=\frac1{32}\sum_{i=1}^{32}B_i^+.\]

If \(M^+<1\), accept. If \(M^-\geq1\), reject. Otherwise refine every root bracket and repeat. These are the original mean-square tests; no rowwise tolerance multiplier is added.

The exact sums are retained in the archive. The following rational enclosures display their decision sequence; each endpoint shown is an integer divided by one million.

| Refinements | Enclosure of lower mean | Enclosure of upper mean |
|---:|---|---|
| 0 | [0,1]/1000000 | [14456020,14456021]/1000000 |
| 1 | [17614,17615]/1000000 | [3509289,3509290]/1000000 |
| 2 | [91423,91424]/1000000 | [1392085,1392086]/1000000 |
| 3 | [232098,232099]/1000000 | [897597,897598]/1000000 |

The initial and first two refined rounds are undecided. At refinement three,

\[M^+<\frac{897598}{1000000}<1,\]

so the complete record is accepted. All 32 rows contributed once, and every retained bracket satisfies its exact square inequalities. `CosmicMeasuredResidual.sourceRunCorrespondence` proves that a returned finite execution follows the original stop/refine transitions. `CosmicMeasuredOriginal.completeOriginalCertificate` proves the complete native result, including both exact mean fractions; `completeOriginalSourceRun` connects it to the actual source loop.

Changing only the first observed Hubble value to 1000 gives, at the initial bracket,

\[M^-=\frac{186917875600000}{3074790443963}>1.\]

The source rejects immediately. `completeTamperedCertificate` proves that complete unfavorable result.

## 9. Budget, acceleration and state comparisons

The registered Planck intervals [14] are

\[I_m=[3055,3167]/10000,\qquad I_v=[6833,6945]/10000.\]

Exact outward division gives

\[\frac{I_v}{I_m}=\left[\frac{6833}{3167},\frac{1389}{611}\right].\]

The equality cube \(11/5\) lies inside because

\[11\cdot3167=34837\geq34165=5\cdot6833,\]
\[11\cdot611=6721\leq6945=5\cdot1389.\]

Doubling both endpoints includes the onset cube \(22/5\).

The registered acceleration reconstruction [15] has conventional centre \(q_0=-0.52\) and uncertainty \(0.06\). Its positive accelerating-magnitude interval is

\[[0.46,0.58]=[23/50,29/50],\]

which contains \(17/32=0.53125\). Its transition redshift is \(0.64\) with lower/upper widths \(0.09,0.12\), giving \([0.55,0.76]\). Adding One and cubing positive endpoints gives

\[\left[\left(\frac{31}{20}\right)^3,\left(\frac{44}{25}\right)^3\right]
=\left[\frac{29791}{8000},\frac{85184}{15625}\right],\]

which contains \(22/5\). The changed transition \(1.50\pm0.01\) yields a cubic interval above \(22/5\) and rejects.

The registered constant-state row [16] has conventional centre \(-1.013\), upper uncertainty \(0.038\) and lower uncertainty \(0.043\). Reversing orientation while retaining the prescribed uncertainty order gives positive magnitude interval

\[[1.013-0.038,1.013+0.043]=[39/40,132/125],\]

which contains One.

The complete original record also retains the alternative reconstruction \(q_0=-0.60\pm0.10\), transition \(0.80\pm0.10\), and its source-prescribed two-uncertainty comparison boundary [17]. The DESI DR2 record [18] reports a preference for the evolving \(w_0\)–\(w_a\) extension at 3.1 sigma for BAO plus CMB, and 2.8–4.2 sigma with supernova samples. These remain typed alternative/model-comparison records in the measured-value successor. Their displacement is not rewarded as an acceptance result and does not select a correction to the static law.

The sixteen-field cosmic analysis retains the full residual certificate, four transported intervals and eleven source checks. The target contains all 32 chronometers plus seven budget, acceleration, state and method rows. All 39 locators remain in the registration and one complete withheld target.

## 10. Complete grammars and proof closure

The formal thermal, inflation and isotope grammars each contain eight binary coordinates, hence 256 candidates. The cosmic-transport grammar contains twelve binary coordinates, hence 4,096 candidates. Each is the complete Cartesian product of the original alternatives in source order.

| Grammar | Complete coordinate list | Count |
|---|---|---:|
| Thermal | Provenance, temperature, thresholds, freeze-out, cover successor, capture, recombination, acoustics | 256 |
| Inflation | Volume, cover, duration, scalar, tensor, exit, growth, transfer | 256 |
| Isotope | Analytic family, constituents, subwords, incidence product, collective identity, conversion, physical partition, target boundary | 256 |
| Cosmic transport | Space, matter, radiation, vacuum, expansion, fractions, equality, acceleration, orientation, physical scale, target custody, extension | 4096 |

For thermal history, the preserving tuple uses admitted threshold/transport dependencies, inverse scale transport, descending distinct thresholds, the least live neutron share, least complete cover, paired family capture, finite visibility and internal acoustic parity with projection records. The other alternatives replace these with a named chronology, fitted cooling, a named epoch list, the conflated freeze-out ratio, a selected decay correction, a named abundance, instantaneous zero-width support or exact-integer observed multipoles. Sections 2–4 derive each preserving operation and show which retained object each alternative changes.

For inflation, the preserving tuple uses generated volume 27, its least binary cover, exact doubling duration, the complete one-boundary scalar/tensor partition, first complete cover as exit, quarter/half/One perturbation growth and exact third/fourth-power transfer. The alternatives introduce a named universe size, a selected duration, fitted scalar/tensor values, a chosen potential exit, a different seed or a fitted transfer. Section 5 supplies the constructive sufficiency and leastness arguments.

For isotope closure, the preserving tuple retains the analytic family, all four constituents, all fifteen nonempty subwords, all sixty incidence cells, one collective identity, the resulting \(59/60\) conversion, exact physical partition and closed target. A selected arity, subword subset, partial product, empty/multiple identity or fitted conversion changes a counted source component. Section 3 supplies the complete construction and its closure.

For cosmic transport, three-space, the added recurrence and invariant vacuum fix the powers. Complete terminal shares fix the rate; component division fixes the fractions; the two balances fix the equality and onset cubes. Typed orientations, post-seal physical scale, target custody and empty extension preserve the remaining boundaries. Section 7 gives every algebraic result. The alternative coordinate choices replace one of those operations or introduce a selected coefficient, target value or additional rule.

In each native grammar, nested product enumeration proves `candidatesComplete` for an arbitrary typed candidate. Exhaustive constructor cases prove that the actual source decision equals its preservation conjunction. The conjunction holds exactly for the preserving tuple, giving `uniqueSurvivor` and the corresponding acceptance theorem. The general thermal, visibility, acoustic and transport proofs establish the quantified mathematics independently of the finite witness tables.

Four empirical grammars—earlier thermal comparison, inflation comparison, cosmic measured-value successor and thermal measured-value successor—each retain the original eight binary dimensions: complete carrier, declared relation, source provenance, prediction isolation, separate measurement, all registered rows, finite successor closure and no extra rule. Each complete product has 256 forms. Original witnesses connect the exact predecessor operations to the comparison; complete candidate, decision, closure and control records are retained. The full set considered here consists of seven 256-form programs and one 4,096-form program, counted separately from the mathematical theorems.

## 11. Prediction custody and native source correspondence

Each original empirical program consumes the sealed predecessor label, constructs the registered observation label, pairs those labels and emits the observation label. The registration and envelope bind the input, derivation seal and withheld target identity. Capability-closed execution produces the prediction seal before target release. The target vault, source byte identities, isolation certificate and custody exchange bind the complete released record. The exact analyses in sections 6, 8 and 9 run on that released record with the original unfavorable controls.

V3 is pinned to commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`; V4 source and evidence are pinned to `21cdf559922fb057f8560f42d056ffa035329eb3` [1–3]. The principal original laws are `thermal_history_recombination_terminal_law_v1.py`, `inflation_growth_terminal_law_v1.py`, `helium_isotope_closure_terminal_law_v1.py` and `cosmic_component_transport_terminal_law_v1.py`, with their actual original validators and execution bindings.

| Result | Native families under `SFT.Physics` | Retained evidence |
|---|---|---|
| Thermal operations, order, transport, visibility, acoustics and horizon | `ThermalHistory` and its `Transport`, `Order`, `Visibility`, `Acoustic`, `Horizon` families | TURN1032–1034 |
| Earlier full thermal comparison | `ThermalObservation` families | TURN1034 |
| Least inflation cover, exact duration and general transfer | `InflationGrowth`, `InflationGrowthDoubling`, `InflationGrowthTransport` | TURN1034–1035 |
| Scalar/tensor comparison | `InflationObservationAnalysis`, `InflationObservationValidation` | TURN1035 |
| Complete physical isotope | `HeliumIsotope` and its grammar/evidence families | TURN1058 |
| Physical thermal measured-value comparison | `ThermalMeasuredAnalysis`, `ThermalMeasuredAnalysisProofs`, `ThermalMeasuredValidation` | TURN1058–1059 |
| General cosmic transport and full original program | `CosmicComponentTransport`, `CosmicComponentTransportProofs` | TURN514–515 |
| Complete residual and measured cosmic comparison | `CosmicMeasuredRoots`, `CosmicMeasuredResidual`, `CosmicMeasuredOriginal`, `CosmicMeasuredInputProofs`, `CosmicMeasuredValidation` | TURN1057 |

The eight completion receipts contain 1,422 distinct declarations whose retained audits report empty axiom dependencies. The archive includes 948 native/import modules, 121 original source and binding files, applicable module digests, original controls, full program-comparison receipts and existing build evidence.

Portable reproduction executes unchanged original pure functions. It retains the complete thermal and inflation certificates, physical isotope and budget, all visibility witnesses, the eight acoustic modes, all four full analyses with 18, 14, 10 and 16 fields, every chronometer, all four residual rounds and all six unfavorable controls. Existing native proofs and applicable verification are reused for unchanged source.

## 12. Physical consequences of complete finite transport

Complete support fixes the inflation shares and duration; complete isotope incidence fixes physical helium; exact positive transport fixes cooling, relative component growth and the late expansion curve. The native proofs apply to arbitrary admitted positive rational carriers and complete finite supports. The registered comparisons retain the physical helium inclusion, strict tensor margin, complete angular data and exact 32-row residual decision. The measured residuals and alternative cosmological records remain visible alongside the successful exact tests.

## References

1. Smith, Maria. *SFT V3 physics corpus*. [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655). [Pinned original source](https://github.com/MettaMazza/ernos-labs-sft-platform/tree/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1).
2. Smith, Maria. *SFT V3 monograph*. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Operational foundation: [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).
3. Smith, Maria. *SFT native Lean 4 verification*, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Cumulative sections 908–912, 914–916, 954–955 and 958–960. [Pinned native source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3).
4. Smith, Maria. Original source records for thermal history, inflation and cosmic measured-value successors. Exact identities and full records in the accompanying source archive, pinned to the V3 commit in [1].
5. Smith, Maria. *Generator three, spatial three and boundary rank two*. [doi:10.5281/zenodo.24325335](https://doi.org/10.5281/zenodo.24325335).
6. Noterdaeme et al. *The evolution of the Cosmic Microwave Background Temperature*. [arXiv:1012.3164](https://arxiv.org/abs/1012.3164).
7. Aver et al. *The LBT Yp Project IV: A New Value of the Primordial Helium Abundance*. [arXiv:2601.22238](https://arxiv.org/abs/2601.22238).
8. Cooke, Pettini and Steidel. *One percent determination of the primordial deuterium abundance*. [arXiv:1710.11129](https://arxiv.org/abs/1710.11129).
9. Planck Collaboration. *Planck 2018 results. I. Overview and the cosmological legacy of Planck*, [arXiv:1807.06205](https://arxiv.org/abs/1807.06205); and *VI. Cosmological parameters*, [arXiv:1807.06209](https://arxiv.org/abs/1807.06209). Complete registered peak and recombination rows.
10. Particle Data Group. *Big-Bang Nucleosynthesis* (2025). [Original review](https://pdg.lbl.gov/2025/reviews/rpp2025-rev-bbang-nucleosynthesis.pdf).
11. Planck Collaboration. *Planck 2018 results. X. Constraints on inflation*. [arXiv:1807.06211](https://arxiv.org/abs/1807.06211).
12. *Improved limits on the tensor-to-scalar ratio using BICEP and Planck*. [arXiv:2112.07961](https://arxiv.org/abs/2112.07961).
13. Gómez-Valent. *Cosmic chronometers to calibrate the ladders and measure the curvature of the Universe. A model-independent study*. [doi:10.1093/mnras/stad1511](https://doi.org/10.1093/mnras/stad1511).
14. Planck Collaboration. *Planck 2018 cosmological parameters*, registered Planck plus BAO baseline. [doi:10.1051/0004-6361/201833880](https://doi.org/10.1051/0004-6361/201833880).
15. Haridasu et al. *An improved model-independent assessment of the late-time cosmic expansion*. [doi:10.1088/1475-7516/2018/10/015](https://doi.org/10.1088/1475-7516/2018/10/015).
16. Escamilla et al. *The state of the dark energy equation of state circa 2023*. [doi:10.1088/1475-7516/2024/05/091](https://doi.org/10.1088/1475-7516/2024/05/091).
17. Gómez-Valent. *Quantifying the evidence for the current speed-up of the Universe with low and intermediate-redshift data*. [doi:10.1088/1475-7516/2019/05/026](https://doi.org/10.1088/1475-7516/2019/05/026).
18. DESI Collaboration. *DESI DR2 Results II: Measurements of Baryon Acoustic Oscillations and Cosmological Constraints*. [doi:10.1103/PhysRevD.112.083515](https://doi.org/10.1103/PhysRevD.112.083515).

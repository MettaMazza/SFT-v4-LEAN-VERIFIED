# Exact support uncertainty and a sealed Bell-data test

**Maria Smith · Ernos Labs**  
Standalone paper 20 · Version 1.0 · 17 November 2026  
DOI: 10.5281/zenodo.24326873

## Abstract

For every generated binary depth \(d\geq1\) and every nonempty distinct support \(S\subseteq\{\mathrm H,\mathrm R\}^d\), exact held/returned phase counting gives \(\sum_k m_k^2=2^d|S|\) and \(|S|\,|\{k:m_k>0\}|\geq2^d\). We derive orthogonality by the binary successor construction, Parseval counting by adjoining one fresh support point, and the support-product bound by a finite magnitude estimate. The normalized product is at least One and is invariant under every positive rational spacing. The complete depth-one through depth-four census contains 65,808 nonempty supports, including 372 saturated cases. Complete joint-support censuses distinguish 21 factorable and 42 nonfactorable supports on a two-by-three carrier, and 217 factorable and 32,550 nonfactorable supports on a three-by-five carrier. The sixteen local Bell response records have maximum three wins in four settings, while setting-inclusive joint support has invariant local marginals. A separately sealed comparison with the superconducting-circuit experiment of Storz et al. gives the complete measured interval \([20714,20780]/10000>2\), central excess greater than twenty-two stated uncertainties, and a positive worst-edge locality margin of \(1814/1000\) ns. The full derivations, exhaustive classifications, experimental conditions, rejection controls and native Lean correspondence are presented together. The two source entries have 628 distinct audited declarations with empty axiom dependencies.

**Keywords:** support uncertainty; Parseval identity; Walsh phase counting; Bell inequality; CHSH; no signalling; superconducting circuits; Smithian Fold Theory; Lean 4.

## 1. The exact theorem

Let \(W_d\) be the complete ordered collection of binary words of depth \(d\). Its labels are held, H, and returned, R. Let \(S\) be any nonempty list of distinct members of \(W_d\), and write

\[N=2^d,\qquad s_t=|S|.\]

For each mode \(k\in W_d\), compare each selected point \(x\in S\) by the parity of coordinates at which both \(x\) and \(k\) have label R. Even parity returns H and odd parity returns R. Let \(h_k,r_k\) be the resulting label counts. Equal counts return the empty imbalance record; unequal counts return their positive difference. The magnitude map sends the empty record to the counting value zero. Thus

\[m_k=|h_k-r_k|,\qquad s_f=|\{k\in W_d:m_k>0\}|.\]

**Theorem.** For every such depth and support,

\[\sum_{k\in W_d}m_k^2=Ns_t,\qquad s_ts_f\geq N.\]

For every positive rational spacing \(a\),

\[\left(s_ta\right)\left(\frac{s_f}{Na}\right)=\frac{s_ts_f}{N}\geq1,\]

and the squared normalized support widths satisfy

\[\left(\frac{s_t}{N}\right)^2\left(\frac{s_f}{N}\right)^2\geq\frac1{N^2}.\]

The carrier consists of all generated words, every distinct nonempty selected support, and every generated mode. The proof quantifies over arbitrary generated depth; the exhaustive four-depth calculation in section 5 is a separate finite classification. Support width is defined by occupied-cell cardinality. Statistical moment variance is a different quantity and does not enter these formulas.

The original operations are `binary_words`, `walsh_phase`, `walsh_support_certificate` and `spacing_cancellation` in the pinned V3 source [1,2]. Native definitions and proofs preserve this carrier and its accepted input domain [3]. Sections 2–4 supply the mathematical argument in full.

## 2. Generated depth and phase orthogonality

### 2.1. Construction and preparation

Use \(W_0=[()]\) as the induction base. The positive-depth construction is

\[W_{d+1}=[\mathrm Hx:x\in W_d]\mathbin{+\!+}[\mathrm Rx:x\in W_d].\]

The two blocks have distinct first labels. Within a block, distinct tails remain distinct. Every binary word of length \(d+1\) has exactly one of these first labels and a unique tail. Hence the construction is exhaustive and duplicate-free. Its cardinality obeys

\[|W_0|=1,\qquad |W_{d+1}|=2|W_d|,\qquad |W_d|=2^d.\]

For an accepted preparation branch count \(B\), the source repeatedly doubles One until the first count at least \(B\). It accepts precisely a nonempty exact doubling trace, so \(B=2^d\) with \(d\geq1\), trace \((2,4,\ldots,2^d)\) and branch unit \(1/2^d\). Strict growth \(2^{d+1}>2^d\) proves uniqueness of the preparation depth. The depth is determined by the preparation count.

A measurement partition supplies positive class sizes \(n_1,\ldots,n_q\) summing to \(N\). It returns the exact weights

\[w_i=\frac{n_i}{N},\qquad\sum_iw_i=\frac{\sum_i n_i}{N}=1.\]

Maximal resolution occurs precisely when every class size is one. Boolean inputs and nonpositive or nonintegral counts fail the original positive-whole guard; an inexact doubling target fails the preparation guard.

`QuantumSupportDepth.originalWordCount`, `originalPreparationDepthUnique` and `originalEveryDyadicPreparation` prove the general cardinality, uniqueness and complete preparation output. Native source operations retain the original checks and partition fields.

### 2.2. The phase successor

Write \(b(x,k)\) for the parity bit of the count of simultaneous R coordinates. Prefixing H to either argument leaves the parity unchanged. Prefixing R to both flips it:

\[b(\mathrm Hx,\mathrm Hk)=b(\mathrm Hx,\mathrm Rk)=b(\mathrm Rx,\mathrm Hk)=b(x,k),\]
\[b(\mathrm Rx,\mathrm Rk)=1-b(x,k).\]

These are parity identities on the original count operation. `QuantumSupportParity.originalReturnedReturned` derives the flip from the successor remainder modulo two; `originalPhaseOperation` identifies the resulting bit with the guarded source phase label for equal nonempty word lengths.

For two points \(x,y\), let \(A_d(x,y)\) be the Boolean list recording phase agreement at each mode. If their new first labels are \(a,b\), the mode construction gives

\[A_{d+1}(ax,by)=A_d(x,y)\mathbin{+\!+}\begin{cases}A_d(x,y),&a=b,\\\neg A_d(x,y),&a\ne b.\end{cases}\]

Negation is entrywise. This equation retains every generated mode exactly once.

### 2.3. Orthogonality by complete induction

If \(x=y\), their phases agree at every mode, so the agreement/disagreement counts are \((N,0)\). For distinct points at the successor depth there are two cases. With equal first labels, their tails differ; the induction hypothesis gives equal agreement and disagreement counts on the tails, and duplicating both preserves equality. With different first labels, each old list is paired with its complement. If its counts are \((u,v)\), the concatenated counts are \((u+v,v+u)\), which are equal. At depth zero no distinct pair exists. Induction therefore yields

\[x=y:\quad(H_{xy},R_{xy})=(N,0),\]
\[x\ne y:\quad H_{xy}=R_{xy},\qquad H_{xy}+R_{xy}=N.\]

This is the exact orthogonality required below: phase-agreement and phase-disagreement cross counts cancel for each distinct pair. No imported transform identity is needed. `QuantumSupportOrthogonalityInduction.originalRowSuccessor`, `originalOffDiagonalCounts`, `originalDiagonalCounts` and `originalCompleteOrthogonality` prove the argument over every generated depth. `QuantumSupportOrthogonalityNative.originalGeneratedProductRow` connects it to the original pair of guarded phase calls.

## 3. Parseval counting from one fresh point

### 3.1. One-mode energy increment

Define \(M(h,r)\) as the magnitude of the original imbalance record. Cancelling one held and one returned label leaves the imbalance unchanged:

\[M(h+1,r+1)=M(h,r),\qquad M(h,0)=h,\qquad M(0,r)=r.\]

The square successor identity \((n+1)^2=n^2+2n+1\) then gives, by cancelling common pairs until one side is empty,

\[M(h+1,r)^2+2r=M(h,r)^2+2h+1.\]

The symmetric formula holds on adding one returned label. Let \(x\) be a fresh point adjoined to \(S\). At a fixed mode, let \(u_k\) count points in \(S\) whose phases agree with \(x\), and \(v_k\) count those whose phases disagree. Applying the appropriate identity yields

\[m_k(S\cup\{x\})^2+2v_k=m_k(S)^2+2u_k+1.\]

Every count is finite, and the equality uses natural-count additions. The source’s empty imbalance remains an empty record; only its magnitude is used in the squared counting expression.

### 3.2. Cancellation of all cross counts

Summing over the complete mode list gives

\[E(S\cup\{x\})+2\sum_kv_k=E(S)+2\sum_ku_k+N,\]

where \(E(S)=\sum_km_k(S)^2\). For each \(y\in S\), freshness gives \(x\ne y\). Orthogonality therefore says that its total agreements with \(x\) equal its total disagreements. Summing those equalities over the finite selected list gives

\[\sum_ku_k=\sum_kv_k.\]

Cancelling the common natural-count summand establishes the exact successor

\[E(S\cup\{x\})=E(S)+N.\]

For the empty selected list every magnitude is zero, so \(E(\varnothing)=0\). A distinct selected list can be built by adjoining one fresh point at each step. Induction on that list now gives

\[E(S)=N|S|.\]

This proof includes the empty auxiliary base and every distinct selected support. The nonempty condition is used later for division by its cardinality. In native Lean, `QuantumSupportParseval.originalModeEnergySuccessor`, `originalSupportEnergySuccessor` and `originalParsevalCounting` prove exactly these steps, with explicit membership and distinctness hypotheses.

## 4. Support uncertainty and spacing cancellation

For each mode, the two phase classes partition \(S\):

\[h_k+r_k=s_t.\]

Their imbalance satisfies \(m_k\leq h_k+r_k=s_t\). A mode outside the occupied frequency support contributes zero energy. Each of its \(s_f\) occupied modes contributes at most \(s_t^2\). Consequently,

\[Ns_t=\sum_km_k^2\leq s_fs_t^2.\]

Since \(s_t>0\), natural-number order cancellation gives

\[N\leq s_ts_f.\]

`QuantumSupportParseval.originalSupportProductBound` proves this inequality directly from the energy identity and the magnitude bound. Put \(P=s_ts_f\). Dividing by the positive \(N\) gives \(P/N\geq1\). Multiplying the inequality \(P\geq N\) by positive factors gives \(P^2\geq N^2\), and hence

\[\left(\frac{s_t}{N}\right)^2\left(\frac{s_f}{N}\right)^2=\frac{P^2}{N^4}\geq\frac{N^2}{N^4}=\frac1{N^2}.\]

Now let \(a=p/q\) with positive integers \(p,q\). The source’s two extents are

\[L_t=s_t\frac pq,\qquad L_f=\frac{s_f}{N}\frac qp.\]

Their product reduces exactly:

\[L_tL_f=\frac{s_tps_fq}{qNp}=\frac{s_ts_f}{N}.\]

Every positive rational spacing has such a positive-numerator, positive-denominator representation. Thus the statement holds on the complete accepted spacing domain. `QuantumSupportNormalization.originalUnitFreeBound`, `originalSquaredProduct`, `originalSquaredGridBound`, `originalSpacingCancellation` and `originalEveryPositiveSpacing` prove the exact rational operations, including their successful guarded outputs.

At depth two take \(S=[\mathrm{HH},\mathrm{HR}]\). The modes HH and RH have magnitude two; HR and RR have empty imbalance. Thus \(s_t=s_f=2\), \(N=4\), \(P/N=1\) and the squared normalized product is \(1/16\). At depth three a singleton has magnitude one at every mode, so \((s_t,s_f,N)=(1,8,8)\). The four registered spacings \(1/8,2/9,3/7,5/11\) all give product One by the same cancellation. These examples attain the bound; the preceding proof establishes it for every admitted support.

## 5. Complete Walsh-support classification

The source enumerates every nonempty subset in increasing cardinality and the original combination order. For each depth it first checks the complete ordered point-pair orthogonality table. For every selected support it retains every mode row and checks Parseval counting, the support-product inequality, the unit-free inequality and the squared-grid inequality. Saturation means exactly \(s_ts_f=N\).

| Depth | Generated cells | Nonempty supports | Saturated supports |
|---|---:|---:|---:|
| 1 | 2 | 3 | 3 |
| 2 | 4 | 15 | 11 |
| 3 | 8 | 255 | 51 |
| 4 | 16 | 65,535 | 307 |
| Total | — | 65,808 | 372 |

The support totals follow from \(2^N-1\), counting every subset except the empty selection. At depth four the complete size decomposition is:

| Size | Supports | Saturated |
|---:|---:|---:|
| 1 | 16 | 16 |
| 2 | 120 | 120 |
| 3 | 560 | 0 |
| 4 | 1,820 | 140 |
| 5 | 4,368 | 0 |
| 6 | 8,008 | 0 |
| 7 | 11,440 | 0 |
| 8 | 12,870 | 30 |
| 9 | 11,440 | 0 |
| 10 | 8,008 | 0 |
| 11 | 4,368 | 0 |
| 12 | 1,820 | 0 |
| 13 | 560 | 0 |
| 14 | 120 | 0 |
| 15 | 16 | 0 |
| 16 | 1 | 1 |

The column sums are 65,535 and \(16+120+140+30+1=307\). The native ordered assembly preserves the actual error-propagating source fold. Its first three depths give \((273,65)\); the fourth gives \((65808,372)\). `QuantumSupportWalshOrderedAssembly.originalFourthSizes`, `originalAllDepthTotals` and `originalCompleteCensus` prove the full returned census \((4,65808,372,\mathrm{true})\). The classification is exhaustive at these four depths, while the support theorem above is general in depth.

## 6. Joint support, factorability and projection

Let \(L,R\) be finite nonempty label lists and \(J\) a nonempty distinct subset of \(L\times R\). The original factorability decision compares the entire support with the Cartesian product of its two projections:

\[J\text{ factorable}\quad\Longleftrightarrow\quad J=\pi_L(J)\times\pi_R(J).\]

Each nonempty pair of subsets \(A\subseteq L\), \(B\subseteq R\) gives one factorable support \(A\times B\). Its projections recover \(A,B\), so different pairs give different supports. Conversely every factorable support has exactly this form. For \(|L|=m\), \(|R|=n\), the exact number is therefore

\[F(m,n)=(2^m-1)(2^n-1).\]

All nonempty joint supports number \(2^{mn}-1\). Subtraction gives the nonfactorable count.

| Carrier | All nonempty | Factorable | Nonfactorable |
|---|---:|---:|---:|
| \(2\times3\) | 63 | \(3\cdot7=21\) | 42 |
| \(3\times5\) | 32,767 | \(7\cdot31=217\) | 32,550 |

The original census evaluates every support, both projection-count lists, and the complete remote-label reversal. For each support,

\[\sum_{\ell\in L}|\{(\ell',r)\in J:\ell'=\ell\}|=|J|,\]

and the same identity holds on the right. Relabelling only the right coordinate preserves each left count because the left-equality test is unchanged for every row. The complete Cartesian product itself is factorable.

The registered coprime traces visit \((t\bmod m+1,t\bmod n+1)\) for \(0\leq t<mn\). For \((m,n)=(2,3)\) and \((3,5)\), equality of two trace pairs implies that the index difference is divisible by both periods, hence by their product; within that index range the indices coincide. The traces therefore visit all six or fifteen cells exactly once. Although \(6>2+3\) and \(15>3+5\), the full products remain factorable. Nonfactorability is a property of the selected joint support, not a consequence of multiplying carrier sizes. `QuantumSupportJoint` retains these definitions and full eleven-field census outputs, with `QuantumSupportJointCertificateProof.originalTwoByThree` and `QuantumSupportJointThreeFiveProof.originalThreeByFive` proving the complete closed outputs.

## 7. The complete Bell response census

### 7.1. Three wins out of four

A local deterministic response record assigns two outcomes to each site, one for each setting. Each response word belongs to \(W_2\), so there are \(4\cdot4=16\) response pairs. The four required relations are equal outcomes at HH, HR and RH, and unequal outcomes at RR.

If the first three equalities all hold, then

\[a_H=b_H,\qquad a_H=b_R,\qquad a_R=b_H,\]

which imply \(a_R=b_R\), contradicting the fourth relation. Thus every local record misses at least one setting. The all-H response pair satisfies the first three, attaining the bound. The exhaustive table of wins is

| Left / right response | HH | HR | RH | RR |
|---|---:|---:|---:|---:|
| HH | 3 | 3 | 1 | 1 |
| HR | 3 | 1 | 3 | 1 |
| RH | 1 | 3 | 1 | 3 |
| RR | 1 | 1 | 3 | 3 |

Thus \(p_{\rm win}\leq3/4\). With the CHSH convention assigning positive correlation to the first three relations and negative correlation to RR, each won relation contributes \(+1\) and each lost relation \(-1\) to the four-term sum. For equal setting weights,

\[S_{\rm CHSH}=4\bigl(2p_{\rm win}-1\bigr)\leq2.\]

A setting-independent mixture of local response records preserves this bound by summing the same inequality with normalized nonnegative weights. This identifies the local-factorization class tested by the experiment.

### 7.2. Setting-inclusive support and invariant marginals

The complete setting-inclusive construction retains the following joint outcomes:

| Settings | Joint outcomes |
|---|---|
| HH | HH, RR |
| HR | HH, RR |
| RH | HH, RR |
| RR | HR, RH |

Every setting has two outcomes satisfying its required relation. At either site, each local label appears once at every setting pair. Its local count vector is always \((1,1)\), so changing the remote setting leaves the marginal invariant. The complete record therefore satisfies every relation and preserves no signalling. Its dependence on the full setting pair is explicit in the joint support. Local-factorized response words and setting-inclusive joint records are distinct constructions.

`QuantumSupportBell.originalSixteenStrategies`, `originalMaximumThree` and `originalEveryLocalRecordBounded` prove the local census. `originalAllSettingsSatisfied`, `originalBothMarginals` and `originalNoSignalling` prove the complete setting-inclusive result. The construction establishes the structural compatibility of joint correlation and invariant local marginals; the measured experiment is evaluated against the local-factorization bound in the next section.

## 8. The sealed superconducting-circuit comparison

### 8.1. Source and exact Bell interval

The primary record is Storz et al., *Loophole-free Bell inequality violation with superconducting circuits*, Nature 617, 265–270 (2023) [4]. The registered V3 snapshot contains the Bell parameter, trial lower bound, reported significance, spatial and timing records, memory method and experimental assumptions. The formal Claim 049 receipt was sealed before that target snapshot was retrieved. Five registered target locators refer to this single complete measured record.

The recorded Bell value is

\[S=\frac{20747\pm33}{10000}.\]

Its entire one-standard-uncertainty interval is

\[I_S=\left[\frac{20714}{10000},\frac{20780}{10000}\right].\]

The lower edge exceeds two because \(20714>20000\), with exact margin

\[\inf I_S-2=\frac{714}{10000}=\frac{357}{5000}>0.\]

The central excess is \(747/10000\). In uncertainty units,

\[\frac{747}{33}=22+\frac7{11}>22,\]

since \(747>22\cdot33=726\). The registered primary record reports more than one million trials and a \(P\) value below \(10^{-108}\), with the reported excess lower bound twenty-two. These significance and trial statements are retained as measured-source records; the exact interval comparison uses the recorded integers directly.

### 8.2. Worst-edge locality calculation

The retained spatial separation is \(32.824\) m with uncertainty \(0.0046\) m. The source records a light-travel budget of \((109489\pm15)/1000\) ns and trial duration \((10740\pm26)/100\) ns. Use the earliest allowed light arrival and the latest allowed trial completion:

\[T_{\rm light,min}=\frac{109489-15}{1000}=\frac{109474}{1000}\ \mathrm{ns},\]
\[T_{\rm trial,max}=\frac{10740+26}{100}=\frac{107660}{1000}\ \mathrm{ns}.\]

The complete intervals are separated because

\[T_{\rm light,min}-T_{\rm trial,max}=\frac{1814}{1000}\ \mathrm{ns}>0.\]

The record additionally retains the reported locality margin of eight standard deviations, deterministic entanglement generation, two settings and binary outcomes at each site, and the memory-robust statistical method.

### 8.3. Experimental conditions and controls

The setting-choice procedure uses random-number generators. Measurement independence is an explicit experimental assumption in the primary source. The exact inference is rejection of the sealed local-factorization class under those conditions. Complete deterministic records remain admissible beyond that factorization class, and random setting generation is not an ontic-nondeterminism premise. The support-product theorem concerns Walsh cardinalities; this experiment measures the Bell correlation parameter.

The original comparator returns fourteen fields: the interval pair and thirteen Boolean decisions. They require positive exact carriers, an interval wholly above the local bound, central excess above twenty-two uncertainties, the reported significance and million-trial lower bound, binary two-setting data, deterministic entanglement generation, separated timing intervals, memory control, the recorded setting method, measurement independence, the authors’ assumption statement and retention of every row. `QuantumSupportObservationMeasurement.originalCompleteAnalysis` proves the full native output with all thirteen decisions true.

Two original controls test the rejection conditions. Replacing the Bell center by 19900 gives lower edge \(19867/10000<2\), so the interval test rejects. Replacing the duration center by 11100 gives upper duration

\[\frac{11100+26}{100}=\frac{111260}{1000}\ \mathrm{ns}>\frac{109474}{1000}\ \mathrm{ns},\]

so locality separation rejects. Neither control changes the formal support theorem or local response census.

## 9. Exhaustive grammars and sealed closure

### 9.1. Formal eight-axis product

The original formal grammar has eight binary coordinates. It generates their entire ordered product, hence \(2^8=256\) candidates.

| Axis | Preserving construction | Rejected alternative |
|---|---|---|
| Depth | Preparation-derived complete binary depth | Universal depth three |
| Observation | Held/returned parity count table | Complex-valued Walsh representation |
| Uncertainty | Orthogonality and Parseval support count | Imported named bound |
| Spread | Exact unit-free support spread | Support width treated as variance |
| Joint | Complete factorability subset census | Product size treated as entanglement |
| Projection | Complete marginal-count invariance | Remote labels assigned a signal |
| Bell | Incomplete local-factorization record identified | Ontic randomness or superluminal inference |
| Extension | No extra rule | Measurement-selected correction |

The phase construction determines the first mathematical relations; orthogonality and the fresh-point induction derive the support bound; complete joint-support comparison determines factorability; complete projection counts determine marginal invariance; and the sixteen response records determine the local bound. The grammar classifies combinations of these source constructions. A candidate passes precisely when every coordinate is the preserving choice, and the exact first failing coordinate determines its rejection reason. Thus the all-preserving tuple is the unique survivor.

Native `QuantumSupportGrammar.sourceDecisionMatchesCriteria` proves agreement between the source decision and the coordinate conjunction for every candidate. `uniqueSurvivor` and `acceptanceIffExactCriteria` prove uniqueness and the full iff statement. Closure rests on the actual word successor, fresh-point Parseval induction, complete support enumerations and unchanged original guards. It introduces no free scientific scale, fitting parameter or measurement-selected depth.

### 9.2. Observational grammar and complete acceptance

The observational grammar is another complete eight-axis product. Its preserving coordinates are complete Fold carrier, sealed local-factorization law versus the complete Bell record, source-bound proof trace, capability-closed prediction, separate measurement record, all registered rows, successor closure and no extra rule. Each coordinate has its original rejected alternative, and the complete product again contains 256 forms with one survivor.

The predictor receives the sealed formal premise and produces the registered observation label. Its executable document, input manifest, output and trace are bound before target release. The target vault checks the envelope, prediction seal and complete target identity. Source checks bind both the exact JSON record and primary snapshot, schema, formal receipt, source identifier and seven interpretation conditions. These preserve the six true source conditions and the false measurement-selected-survivor condition.

The final acceptance conjunction is

\[F\land A\land B\land C_S\land C_T.\]

Here \(F\) is the three proved formal witnesses—Walsh census, joint census and Bell construction; \(A\) is all thirteen analysis predicates; \(B\) is the complete interpretation record; and \(C_S,C_T\) are rejection of the altered Bell and timing controls. Every additional registered measurement row remains downstream of the formal seal and is retained in the complete comparison. `QuantumSupportObservationWitnessProofs.allWitnessesPass`, the observational grammar proofs and `QuantumSupportObservationValidation.validate` bind these components to the complete native output.

## 10. Native correspondence and reproducibility

The V3 source is pinned to `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1` [1,2]. Native source and retained verification are pinned to V4 `21cdf559922fb057f8560f42d056ffa035329eb3` [3]. Principal files are `quantum_support_uncertainty_terminal_law_v1.py`, `quantum_support_uncertainty_empirical_v1.py` and `quantum_support_uncertainty_validation_v1.py`, with their actual execution bindings and dependencies.

| Argument or operation | Native family under `SFT.Physics` |
|---|---|
| Preparation and parity | `QuantumSupportDepth`, `QuantumSupportParity` |
| General orthogonality | `QuantumSupportOrthogonalityInduction`, `QuantumSupportOrthogonalityNative` |
| General energy and support bound | `QuantumSupportParseval` |
| Rational normalization and all positive spacings | `QuantumSupportNormalization` |
| Complete ordered Walsh census | `QuantumSupportWalshOrderedAssembly` and its size/batch proofs |
| Joint factorability and Bell records | `QuantumSupportJoint`, `QuantumSupportBell` |
| Formal certificate and unique grammar | `QuantumSupportCertificateProof`, `QuantumSupportGrammar` |
| Complete target analysis and custody | `QuantumSupportObservationMeasurement`, `QuantumSupportObservationRecords`, `QuantumSupportObservationExperiment` |
| Empirical grammar, witnesses and validator | `QuantumSupportObservationGrammar`, `QuantumSupportObservationWitnessProofs`, `QuantumSupportObservationValidation` |

The two TURN1055 completion receipts retain affected native builds, original full-program comparisons, complete 256-candidate decisions, original controls and independent-validator results. The 628 distinct audited declarations have empty axiom dependencies. The retained TURN1051–1055 evidence includes the all-depth proofs, complete Walsh assembly and exact observation operations; the observation analysis comparison contains 181 source cases. Each original independent validator accepts its original program and rejects omission of a candidate, addition of a survivor and failure of a control.

The accompanying archive supplies pinned source files, native definitions and proof bodies, source correspondence, raw audit/build/comparison records and a portable exact-arithmetic reproduction. The reproduction executes the unchanged original pure operations for the complete Walsh census, joint censuses, Bell records, full fourteen-field observation analysis and both rejection controls. Full declaration names, source digests and applicable receipts are listed in `SOURCE_CORRESPONDENCE.json`.

## 11. Consequences

Binary generation and phase-count orthogonality force the exact energy identity at every generated depth. Its magnitude bound forces \(s_ts_f\geq2^d\), and every positive rational spacing cancels from the normalized product. Complete finite enumeration classifies all 65,808 registered supports and their 372 saturated cases. Joint-support enumeration distinguishes factorability from carrier size, and the Bell construction separates a three-of-four local response bound from invariant-marginal setting-inclusive support. The independently sealed superconducting-circuit comparison places the complete measured interval above two and retains positive worst-edge locality separation. These results connect exact finite derivation, exhaustive classification and physical comparison through the original source-defined records.

## References

1. Smith, Maria. *SFT V3 physics corpus*. [doi:10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655). [Pinned original source](https://github.com/MettaMazza/ernos-labs-sft-platform/tree/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1).
2. Smith, Maria. *SFT V3 monograph*. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Operational foundation: [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).
3. Smith, Maria. *SFT native Lean 4 verification*, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Cumulative sections 938–945; [pinned native source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3).
4. Storz, Simon, et al. “Loophole-free Bell inequality violation with superconducting circuits.” *Nature* 617, 265–270 (2023). [doi:10.1038/s41586-023-05885-0](https://doi.org/10.1038/s41586-023-05885-0). Complete registered target and primary snapshot are included with their pinned V3 bindings.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

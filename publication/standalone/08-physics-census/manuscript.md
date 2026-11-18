# An auditable dependency and empirical census of SFT physics

**Maria Smith**  
Ernos Labs  
Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com)  
SFT community and invitation: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

The frozen SFT Physics census contains 347 uniquely owned Physics entries and 534 transitive dependency nodes, with 3,736 registered parent links. Complete ordered traversal closes without a cycle or orphan, and every Physics entry reaches the foundational One. The independently assembled 21-field headline vector equals the vector reconstructed from generator three; changing only the generator to four changes every declared dependent field while preserving the binary fibre and spatial and boundary ranks. The empirical reconciliation retains all 234 empirical records, 147 external-source identities, six legacy receipt shapes and fourteen adverse-result or scope-boundary entries. Its eight-field certificate passes on the complete record and rejects each of four exact source-defined mutations. This paper derives the traversal, root, reconstruction and certificate arguments, publishes the full adverse and legacy inventories and all source identities, and supplies the complete machine-readable dependency and empirical records. Two completed entries provide 98 direct native Lean modules and 491 audited definitions and theorems with empty axiom dependencies. The 4,096-form formal grammar and 256-form empirical grammar each have their exact unique registered survivor.

## 1. Frozen domain and ownership

Let \(P\) be the ordered vector of pre-lock Physics identifiers. Let \(D\) be the dictionary assigning every transitive identifier its ordered parent list. Let \(F\) be the complete Physics record vector. The frozen input supplies

\[
 |P|=347,\qquad |D|=534,\qquad
 \sum_{v\in\operatorname{keys}(D)}|D(v)|=3736.
\]

Each Physics record retains its registered statement, exact result, dependencies, receipt identity, receipt-file hash, certificate hash, registration hash and applicable empirical records. The no-omission check is the two-way set equality

\[
 \operatorname{set}(P)=\{r.\mathrm{claim\_id}:r\in F\}.
\]

Both membership directions are evaluated over the complete source lists. The ordered uniqueness result is stronger than equal cardinality alone: `GrandLockDependencyProofs.originalUnique` proves that the original duplicate-elimination operation returns \(P\) itself. The four immutable evidence fields on every Physics row are retained and truthy; `originalEvidence` proves the complete mapped vector of 347 true results.

The source's initial Python guard is the chained comparison `len(ids) != len(set(ids)) == declared`. Its exact Boolean meaning is

\[
 (|P|\ne|\operatorname{set}(P)|)\ \land\
 (|\operatorname{set}(P)|=n_{\rm declared}).
\]

The native operation preserves this exact guard. For the frozen input, the independently proved uniqueness makes its first factor false, and the complete returned ownership and count fields are established directly. `frozenInput` checks the original input SHA-256 and schema before the certificate operation. The input and all bound records are included verbatim [4].

## 2. Ordered dependency traversal and foundational reachability

### 2.1 Distinct-node traversal

A traversal state consists of the active path set \(A\), the completed dictionary \(C\), and its count \(n\). To visit identifier \(v\), the source performs these ordered cases. If \(v\in A\), it rejects a cycle. If \(v\in C\), it returns \((C,n)\) unchanged. If \(v\notin\operatorname{keys}(D)\), it rejects an orphan. Otherwise it adds \(v\) to the active path, visits every parent in \(D(v)\) in source order, then inserts \(v\) into completed and increments the count once.

For the successful recursive case,

\[
 \operatorname{fold}_{u\in D(v)}
 \operatorname{visit}(D,A\cup\{v\},(C,n),u)=(C',n')
\]

implies

\[
 \operatorname{visit}(D,A,(C,n),v)=(C'\cup\{v\},n'+1).
\]

The completed dictionary is threaded between parent calls and between all top-level calls. A repeated dependency therefore enters the completed-hit case and does not add to the count. The active dictionary is local to the recursive path; a shared completed ancestor is distinct from a return to an active node.

The native dictionary follows exact UTF-8 bytes of the identifier. Insertion replaces only the same key and preserves all other branches. The native traversal has the finite bound \(|D|+1=535\), with active-cycle and completed-hit tests before the recursive-depth branch. The full original evaluation remains within that bound.

The proof retains each actual visit equation, its input and output dictionaries, and each parent-list fold. For an empty parent list, the fold returns its initial state. For \(u::U\), a proved call returning state \(s'\) and a proved remaining fold from \(s'\) compose to the full fold result. `sourceFoldCall` expresses this exact sequencing. The 347 top-level equations are composed in the same manner, beginning with empty completed state and count zero. `GrandLockDependencyTrace.originalTraversal` rewrites the original row dictionary to the proved dictionary and projects the resulting count:

\[
 \operatorname{traversalCount}(D,P)=\operatorname{Ok}(534).
\]

Every retained edge is traversed through the source dictionary; successful completion supplies the acyclic, orphan-free original execution. The certificate compares 534 with the declared transitive count and returns true.

### 2.2 Reaching the foundational One

Write \(o=\text{SFT-FOUNDATION-ONE-001}\). Root evaluation retains a memo dictionary \(M\) and follows

\[
 R(o)=\mathrm{true},\qquad
 R(v)=\bigvee_{u\in D(v)}R(u)\quad(v\ne o).
\]

A cached entry returns its stored Boolean. Otherwise the ordered parent fold evaluates parents until a true result is found, threads the updated memo through each call, and stores the resulting Boolean for \(v\). The original short-circuit behavior is retained. The top-level fold evaluates every Physics identifier while threading that same memo.

The native root proof composes the actual recursive call equations and ordered folds, retaining all names and parent lists. `GrandLockRootTrace.originalRoots` projects the final Boolean from the complete folded result and proves

\[
 \operatorname{allRooted}(D,P)=\operatorname{Ok}(\mathrm{true}).
\]

Thus each of the 347 Physics entries reaches One through its declared dependency chain. The portable replay separately traces the full reachable set from each Physics identifier and verifies One belongs to every set; their union contains exactly 534 nodes.

### 2.3 Complete dependency certificate

In original source-field order, the checked certificate is

\[
 D_*=(347,534,\mathrm{true},\mathrm{true},
 \mathrm{true},\mathrm{true},234,14).
\]

Its fields are Physics count, transitive count, no omission, acyclicity, reachability to One, bound evidence hashes, empirical count, and adverse/scope-boundary count. `GrandLockDependencyProofs.originalComplete` assembles the parsed source fields, complete uniqueness/evidence results, traversal and root equalities. Neither count is used as a substitute for the corresponding full operation.

## 3. Complete reconstruction and generator-successor test

Let \(g\ge3\) be the source's dependency probe. Binary count two and spatial rank three remain fixed. Define the least positive cover depths

\[
 d=\min\{k\ge1:2^k\ge g^3\},\qquad
 u=\min\{k\ge1:2^k\ge g^4\}.
\]

`least_binary_cover` begins at depth one and support two, multiplying support by two until the carrier is covered. Before each multiplication the current support is too small, so termination supplies both coverage and minimality. The declared carriers are \(g^3\) and \(g^4\); the spatial exponent is held in the perturbation.

Put \(B=2^u\), \(C=2d^g\), and \(r_j=d^{g-j}u^j\) for \(j=0,\ldots,g\). Set \(H_g=r_g\) and recursively

\[
 H_j=r_j+\frac1{H_{j+1}}\quad(j=g-1,\ldots,1),\qquad
 D=C+\frac1{H_1}.
\]

Every rung is positive; induction makes every reciprocal and continuation positive. The exact fine-structure reconstruction is

\[
 \alpha^{-1}=B+g^2\frac{D+1}{D},\qquad
 \alpha=\frac1{\alpha^{-1}}.
\]

At \(g=3\), \(d=5\), \(u=7\), and the rung word is \((125,175,245,343)\). Thus

\[
 H_1=175+\frac1{245+1/343},\quad
 D=250+\frac1{H_1},\quad
 \alpha^{-1}=\frac{503846395469}{3676744786}.
\]

The remaining fields are reconstructed by the following exact expressions. Put \(L=2g^{g+2}-1\), \(V=g^3\), \(S=2^d\), and \(v=(g-1)/g\).

| Field | Reconstructed expression |
|---|---|
| Generator, down depth, up depth | \(g,d,u\) |
| Inverse fine-structure terminal value | \(B+g^2(D+1)/D\) |
| Charged-lepton pair invariant | \(1/(2g)\) |
| Charged-lepton leading product | \(1/L\) |
| Charged-lepton sharpened product | \(1/(L-1/g)\) |
| Charged-lepton terminal product | \(1/(L-1/g)-\alpha^g[d+(u/g)\alpha]/g^g\) |
| Down- and up-quark pair invariants | \(1/[2(g+1)]\), \(1/(4g)\) |
| Down- and up-quark products | \(1/(g2^u-1)\), \(1/(g2^{u+g}-1)\) |
| Leading and refined dark/baryon ratios | \(V/d\), \(V/[d+1/(S-1)]\) |
| Dark and baryon shares | \(V/S\), \(d/S\) |
| Leading and refined Hubble ratios | \(1+v/8\), \(1+[v+1/(2^u-1)]/8\) |
| Squared terminal Planck/proton hierarchy | \(2^{2^u-1}[1-(2/g)\alpha]\) |
| Local vacuum amplitude and energy | \(2^{-2d}\), \(2^{-4d}\) |

These are all 21 source fields. Each subtraction is performed by the source's `positive_take`, which checks that the part is positive and strictly below its whole. The native operation retains those guards and exact rational reduction.

The independent current vector \(H\) calls the existing sector operations: fine-structure blocks and ratio, charged-lepton invariants and terminal product, quark invariants, dark/baryon and Hubble structures, Planck hierarchy and vacuum floor. It does not read the generator-vector output. `GrandLockHeadline.originalCurrentCrossLock` proves exact equality of the full serialized values:

\[
 H=V(3).
\]

`GrandLockVectorProofs.generator3Complete` and `generator4Complete` evaluate the complete source operations to their exact field vectors. The native proof terms reduce the rational operations and constructors directly. The source-order comparison forms

\[
 \Delta=[k\in\operatorname{keys}(V(3)):V(3)_k\ne V(4)_k].
\]

`GrandLockProbe.originalCompletePerturbation` proves \(\Delta=\operatorname{keys}(V(3))\), so all 21 declared dependent fields change. The separate held vector is exactly \(((\mathrm{binary\ fibre},1/2),(\mathrm{space\ rank},3),(\mathrm{boundary\ rank},2))\). The normalized cosmic value remains the separately typed \(33/16\).

The six shared carrier rows preserve their entire consumer incidence:

| Carrier | Consumers |
|---|---|
| Binary fibre | Fine structure, leptons, quarks, cosmology, Planck hierarchy, vacuum floor |
| Generator | Fine structure, leptons, quarks, dark/baryon, Hubble, Planck hierarchy, vacuum floor |
| Down cover | Fine structure, leptons, dark/baryon, vacuum floor |
| Up cover | Fine structure, leptons, quarks, Hubble, Planck hierarchy |
| Space rank | Cover depths, dark/baryon, Hubble, vacuum floor |
| Terminal alpha | Leptons, Planck hierarchy |

Every consumer list is nonempty. These exact identities, the two complete vectors, their comparison and the dependency result form the eleven-field theorem certificate

\[
 C_*=(D_*,H,V(3),V(4),\mathrm{true},\mathrm{true},
 \mathrm{true},21,G,\mathrm{true},\mathrm{true}).
\]

`GrandLockCertificateAssembly.assemble` unfolds the source operation and substitutes the proved dependency, headline, two generator and perturbation results. `GrandLockCertificateProof.originalComplete` obtains the complete nested equality. Equality of a serialized value with itself follows by structural induction on its byte-derived natural-number list in `GrandLockCertificateEquality.sameValueSelf`. The six operational witnesses project: ownership/evidence, acyclicity/root, current reconstruction, complete perturbation with held invariants, nonempty shared-carrier incidence, and the positive empirical/adverse counts. All six witness projections are proved true.

## 4. Exact empirical reconciliation

Let \(E\) be the empirical identifier vector, \(U\) the external-source identity vector, \(L\) the legacy receipt-shape identifiers, and \(A\) the adverse or scope-boundary vector. The complete source record has

\[
 |E|=|\operatorname{set}(E)|=234,\quad
 |U|=|\operatorname{set}(U)|=147,\quad
 |A|=|\operatorname{set}(A)|=14,\quad A\subseteq P.
\]

Let \(m(e)\) be the separate measurement-receipt field. The source retains every empirical and external validation hash and requires

\[
 \forall e\in E,\ \operatorname{truthy}(m(e))\lor e\in L,
 \qquad
 \operatorname{set}(L)=\{e\in E:\neg\operatorname{truthy}(m(e))\}.
\]

Exactly six original rows have the legacy shape. Their earlier records remain bound without adding a later measurement-receipt field. Appendix B names all six. The complete source-identity union across the 234 empirical rows equals the 147 identifiers in Appendix C; the accompanying inventory maps each source to every consuming claim.

The methodological record retains nine true flags: current evidence closed with lawful extensions open; every available measurement receipt retained; every empirical hash retained; every external hash retained; every adverse result and scope boundary retained; formal survivor sealed before this reconciliation; legacy shape explicit; observation treated as empirical evidence; and prior observations not relabelled as unseen predictions. The tenth flag, `measurements_select_formal_survivor`, is false. The formal receipt is bound to its exact original identity.

In source order, the eight Boolean certificate fields are uniqueness/completeness, empirical/external hash retention, available measurements, exact legacy shape, exact adverse vector, exact source vector, methodological boundary and bound formal receipt. Their complete original result is

\[
 C(R)=(\mathrm{true},\mathrm{true},\mathrm{true},\mathrm{true},
 \mathrm{true},\mathrm{true},\mathrm{true},\mathrm{true}).
\]

`GrandLockObservationRecordAssembly.assembleRecord` unfolds the actual record operation and substitutes the exact parsed vectors, mapped hash and measurement flags, filtered legacy rows and source fields. `GrandLockObservationAnalysisProofs.originalComplete` then rewrites all eight component equalities to obtain the full result. The proof retains all 234 rows and their original field order.

## 5. Mutation controls and complete validator

The four controls mutate the full original record while retaining all other fields. Their exact results, using T for true and F for false, are:

| Input | Unique | Hashes | Measurements | Legacy | Adverse | Sources | Boundary | Formal |
|---|---|---|---|---|---|---|---|---|
| Original | T | T | T | T | T | T | T | T |
| Remove first empirical row | F | T | T | T | T | T | T | T |
| Remove first adverse identifier | T | T | T | T | F | T | T | T |
| Empty declared legacy vector | T | T | F | F | T | T | T | T |
| Enable measurement selector | T | T | T | T | T | T | F | T |

Removing the first empirical row changes its length to 233 while retaining the declared 234. The first row has a measurement receipt, so the retained legacy list remains exact. Tail extraction from the complete original mapped lists proves the remaining hash and measurement fields stay true. `missingRowComplete` assembles that exact result.

Removing the first adverse identifier changes its length to 13, so the exact fourteen-entry requirement fails. The other fields are unchanged; `missingAdverseComplete` rewrites the retained fields and the new adverse-length result.

Emptying \(L\) changes the measurement predicate to \(\operatorname{truthy}(m(e))\lor\mathrm{false}\). It fails for each of the six original legacy rows. The empty list also differs from their complete six-row set. `falseLegacyComplete` therefore gives precisely two false fields, retaining all others.

Turning the selector on makes the required false-flag comparison fail. `selectorComplete` retains all other record fields and produces precisely the false methodological-boundary field. `GrandLockObservationInputProofs` binds each target to its actual source mutation, so these are tests of the specified altered records.

The validator first checks the sealed claim identity, reconciliation snapshot hash, formal receipt-file hash and pre-lock input hash. It requires the complete original certificate to pass, evaluates all four mutations and requires their designated failures. It then executes the retained generic sealed-observation validator. The final receipt binds the seal, source, full certificate, controls and complete empirical/source/adverse/legacy identifier vectors. The twelve-field output retains the base custody and isolation records, all source identities, the complete measurement summary, and the final conjunction of base, certificate and control results. `GrandLockObservationValidation.validate` implements this exact sequence [5].

## 6. Exhaustive grammars and uniqueness

The formal entry generates the complete product of twelve binary coordinates; the empirical entry generates eight. Thus their candidate counts are \(2^{12}=4096\) and \(2^8=256\). Every candidate carries the original alternatives, field names and elimination reason.

### 6.1 Formal dependency and value census

| Coordinate | Rejected alternative | Admitted alternative |
|---|---|---|
| ownership | omitted or duplicate owner | unique complete physics owner |
| receipt | unbound or current only result | receipt and certificate hash bound |
| registration | unstated or mutable premises | registration and dependencies hash bound |
| dependency | orphan or cycle | complete acyclic dictionary |
| root | multiple or missing roots | foundational One root |
| values | headline selection only | all claim exact result vector |
| perturbation | selected values move | every and only declared dependent value moves |
| invariants | silent global retuning | binary space boundary held |
| identity | duplicate unrelated numbers | complete cross domain identity graph |
| empirical | favourable rows only | complete receipts with adverse boundaries |
| extension | permanently locked theory | current evidence closed extension open |
| rule | free extra rule | no extra rule |


### 6.2 Empirical reconciliation

| Coordinate | Rejected alternative | Admitted alternative |
|---|---|---|
| carrier | answer only scalar | complete fold carrier |
| relation | imported or fitted relation | complete Physics empirical vector with all adverse and scope boundary records retained |
| provenance | unbound provenance | source bound proof trace |
| prediction | target readable prediction | capability closed prediction |
| record | proof measurement conflation | separate measurement record |
| rows | selected favourable rows | complete registered rows |
| generality | finite answer lookup | one successor closure |
| extension | free extra rule | no extra rule |


For either grammar, write \(c=(c_1,\ldots,c_k)\) and let \(c_*\) contain every admitted constructor. The criteria decision is

\[
 D(c)=\bigwedge_{i=1}^{k}[c_i=c_{*,i}].
\]

Each coordinate belongs to its two-constructor domain. Applying product membership successively proves every complete candidate is generated (`candidatesComplete`). Evaluating the full product gives its exact cardinality. For the twelve-axis grammar, the first six coordinates split the decision proof into 64 exhaustive cases, and each corresponding `GrandLockCensus` module exhausts the remaining six; together they cover all 4,096 combinations. The eight-axis proof exhausts all 256 constructor combinations directly. In every case, the source identifier decision equals the criteria conjunction.

If \(D(c)\) is true, each component equals its admitted constructor, hence \(c=c_*\). Conversely, substituting \(c_*\) makes every component comparison true. `sourceDecisionMatchesCriteria`, `uniqueCriteriaSurvivor`, `uniqueSurvivor` and `acceptanceIffExactCriteria` give the exact equivalences. A rejected coordinate cannot equal its admitted counterpart, so every rejected-axis theorem follows by projecting the alleged survivor equality. The complete source programs also retain the original candidate decisions, registration, witnesses, controls and closure records.

## 7. Retained results, provenance and reproduction

The formal entry `SFT-PHYS-GRAND-LOCK-TERMINAL-075` has 79 direct native modules and 277 audited definitions and theorems. The empirical entry `SFT-PHYS-VALIDATION-GRAND-LOCK-076` has 19 direct modules and 214 audited declarations. All 491 have retained empty-axiom audits. Their 1,450 native modules including imports match the published V4 archive. Completion receipts are `TURN_1132_GRAND_LOCK_COMPLETION.json` and `TURN_1132_GRAND_LOCK_OBSERVATION_COMPLETION.json`; original derivation and complete-operation evidence is retained from TURN1063–1070, with the unchanged full candidate-program checks retained through TURN1112 and TURN1132.

The archive includes the frozen 347 Physics records, complete dependency dictionary, 234 empirical rows, every bound identifier and hash, all source identities, the exact original operations, native proof bodies and retained comparisons. The full-program reports match all 4,096 and 256 candidate decisions and all corresponding output fields/hashes. The original independent validators accept their complete records and reject omitted-candidate, additional-survivor and failed-control variants. The retained empirical output matches the original complete empirical receipt.

Portable reproduction executes the original dependency and record certificate functions on the pinned bytes, independently traces every root path, reproduces all four mutation vectors, recomputes the 147-source union, and evaluates both 21-field generator vectors. Extract `SOURCE_AND_EVIDENCE.zip` and run `python3 reproduction/check_paper_arithmetic.py`. The complete JSON inventories retain all rows; Appendices A–C make the adverse, legacy and source identities readable in this paper.

## Appendix A. Complete adverse-result and scope-boundary inventory

The frozen vector contains the following fourteen entries. Each entry retains its original exact-result statement and source falsification condition where one is recorded. The vector includes both empirical adverse results and declared scope boundaries; its source identities and status distinctions remain intact.

### A.1 Terminal finite radiation, acoustic, laser, plasma and Alfvén response law

`SFT-PHYS-COLLECTIVE-RADIATION-RESPONSE-TERMINAL-041`

Every finite cavity occupation is an exact rational mean over the complete microcanonical word census; all modes above total support are empty and common scale changes preserve the complete word set. Wien covariance is exact at the relation level. In stable three-space P(gT)/P(T)=g^4, so doubling gives 16. Acoustic modes are f_n=n f_1. Laser inversion is greater than 1/2, threshold is gain=loss, above-threshold requires gain>loss, and linewidth times coherence ticks is One. Plasma omega_p^2=nq^2/(m epsilon), lambda_D^2=epsilon T/(nq^2), and Alfvén v_A^2=B^2/(mu rho), all as exact positive rational carriers.

### A.2 Terminal cosmic component transport and expansion law

`SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032`

Matter, radiation and vacuum have respectively third-power, fourth-power and Fold-invariant transport. The terminal late-time law is E2(r)=(11+5r^3)/16; Omega_m(r)=5r^3/(11+5r^3); Omega_v(r)=11/(11+5r^3); matter-vacuum equality is r^3=11/5; acceleration onset is r^3=22/5; and the present accelerating magnitude is 17/32. The static-vacuum correspondence is tension of One magnitude. All quantities are exact positive whole/fractional Fold forms or typed empty/orientation structures.

Recorded falsification condition: Any of the 32 CCH intervals fails the registered squared two-uncertainty comparison; either threshold cube lies outside its complete external interval; the q or tension magnitude lies outside its interval; any source hash, row, custody record or adverse DESI statement changes; or a tampered target is accepted.

### A.3 Terminal stellar hydrostatics, galactic response and tidal-lock law

`SFT-PHYS-STELLAR-GALACTIC-TIDAL-TERMINAL-067`

Hydrostatic balance is exactly (1/2,1/2). Radial pressure and gravity responses are 5/3 and 4/3, certified only through q^5 and q^4 perfect powers: every compression is outward restoring and every expansion inward restoring. The two terminal homologous luminosity exponents are three and four, forcing lifetime-fall magnitudes two and three. Circular balance is v^2=M(r)/r; flat v forces M(r) proportional to r and excludes a finite visible-only asymptote. The baryonic Tully-Fisher exponent is exactly four. Every finite rational isolated circular tidal mismatch exhausts to 1:1; eccentric or externally forced resonances remain an explicit separate boundary rather than a counterexample hidden from the census.

### A.4 Common Fold scale measured-value correction

`SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054`

The terminal on-shell share lies inside [22333,22351]/100000. The support-eight share 25/106 lies inside [2331,2367]/10000. The complete registered low-transfer vector preserves the sub-W direction. No mismatch, uncertainty multiplier, fitted rung or measurement-selected exception is admitted.

Recorded falsification condition: Reject if a source or dependency changes; either forced value leaves its like-typed measured interval; the below-W direction reverses; a row or threshold boundary is omitted; NuTeV displacement is made a passing result; any uncertainty is widened; or target data alter the formal survivor.

### A.5 Terminal cosmic transport measured-value correction

`SFT-PHYS-VALIDATION-COSMIC-TRANSPORT-MEASURED-VALUE-055`

The exact upper enclosure of the complete 32-row mean squared normalized residual is below the One after the fourth exact enclosure round (three forced bisection refinements). The exact 11/5, 22/5, 17/32 and tension-One values lie inside the complete registered Planck, Haridasu and constant-state intervals. No sigma multiplier, fitted component, uncertainty rescaling, deleted row or mismatch-as-success predicate remains.

Recorded falsification condition: Reject if a source or dependency changes; the complete normalized-residual lower enclosure reaches the One; any forced threshold, acceleration or static-state value leaves its like-typed interval; any row is omitted; an uncertainty is rescaled; a method/model-comparison displacement is rewarded; or target data alter the formal survivor.

### A.6 Criticality and turbulence measured-value correction

`SFT-PHYS-VALIDATION-CRITICALITY-MEASURED-VALUE-056`

All five manganite structural keys identify the binary local-order mean-field class. The complete fifteen-value mean squared normalized residual is exactly 5286961/10584000, below the One. The erbium beta/gamma/nu intervals contain 1/2, One and 1/2; the turbulence interval contains 2/3; and both physical routes exhibit the registered falling five-thirds plateau. No material mismatch is an acceptance condition.

Recorded falsification condition: Reject if a source or dependency changes; any material structural key is incomplete; the complete fifteen-value mean squared residual reaches the One; erbium or turbulence excludes a sealed exponent; either spectrum route is absent; any row is omitted or uncertainty rescaled; La02 displacement is rewarded; or targets alter the survivor.

### A.7 Post-seal critical-exponent, universality and turbulence-scaling test

`SFT-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048`

The erbium intervals [46,50]/100 for beta, [90,102]/100 for gamma and [47,51]/100 for nu contain exactly 1/2, One and 1/2. Of the complete five-row manganite record, La00, La04, La06 and La08 contain the entire beta=1/2, gamma=One, delta=three vector; La02 excludes gamma=One and delta=three and therefore cannot be admitted to that generated universality class. The independent turbulence interval [666,692]/1000 contains exactly 2/3. A Reynolds-count-720 physical flow exhibits five-thirds compensated plateaux over 40--4000 Hz by Fourier analysis and 20--2000 Hz by Hilbert analysis. The nonmatching composition, finite-Reynolds correction boundary, structure-function range limitation, normalized-threshold boundary and empty-exponent typing are all retained.

Recorded falsification condition: Reject if any source or reported row changes; the erbium vector excludes a sealed carrier; fewer than the registered four manganite rows match or La02 is concealed or relabelled as a complete match; the zeta_2 interval excludes 2/3; either registered physical spectrum route lacks its five-thirds plateau; any limitation is omitted; or target data alter the sealed survivor.

### A.8 Terminal electroweak measured-value correction

`SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053`

The exact forced terminal on-shell share lies inside the complete PDG interval [22333,22351]/100000. Its exact complement lies inside the outward-propagated compatible-input W/Z squared interval. No uncertainty is widened and no inconsistent aggregate is converted into a passing or failing SFT law.

Recorded falsification condition: Reject if either source changes; the sealed exact share leaves the direct on-shell interval; its complement leaves the compatible W/Z squared interval; any uncertainty is widened; the inconsistent aggregate is deleted, used as a second law, or relabelled as an SFT result; or target data alter the formal survivor.

### A.9 Blind PDG test of the terminal electroweak Fold share

`SFT-PHYS-VALIDATION-ELECTROWEAK-TERMINAL-003`

The sealed terminal share must lie inside the PDG on-shell interval and compatible-input W/Z interval while the all-input W/Z tension is retained, not silently discarded.

Recorded falsification condition: The sealed weak share leaves the on-shell interval, leaves the compatible-input W/Z interval, enters the presently disjoint all-input interval without a source revision, any registered row/hash changes, or an unfavorable row is omitted.

### A.10 Post-seal finite-loop and renormalization-boundary comparison

`SFT-PHYS-VALIDATION-FINITE-LOOPS-003`

Finite renormalized radiative observable calculations correspond to exact finite loop receipts; the absence of completed continuum support is a formal Fold boundary, not a directly measured ontology claim.

Recorded falsification condition: A generated finite exact loop census diverges, an unregistered subtraction is required inside the Fold proof, or the validation misstates a conventional calculation as direct measurement of substrate ontology.

### A.11 Complete hadron Regge measured-value correction

`SFT-PHYS-VALIDATION-HADRON-REGGE-MEASURED-VALUE-060`

The forced squared carriers 3/5, 9/5, 3, 21/5 and 27/5 all lie inside their corresponding complete measured resonance-support intervals. All five rows and the rho5 omission status are retained. No fitted slope, intercept, residual, selected row, uncertainty widening or mismatch-as-success remains.

Recorded falsification condition: Reject if a source or dependency changes; any exact carrier leaves its most restrictive measured resonance support; a row or status is missing; a width or uncertainty is widened; a coefficient or correction is fitted; a mismatch is rewarded; or targets alter the formal survivor.

### A.12 Majorana and neutrinoless-double-beta status comparison

`SFT-PHYS-VALIDATION-MAJORANA-ZERO-NU-003`

Zero-nu-beta-beta is not observed; the sealed positive effective-mass interval remains a closed prediction below current sensitivity and is neither confirmed nor excluded.

Recorded falsification condition: A controlled search excludes the complete sealed effective-mass interval under validated matrix elements, a Dirac neutrino is established, or an observation violates the sealed structure.

### A.13 Proton/electron precision comparison

`SFT-PHYS-VALIDATION-PROTON-ELECTRON-003`

The V3 reconstruction is near the 1836 scale but lies outside the complete CODATA uncertainty interval and is not empirically closed to CODATA precision.

Recorded falsification condition: A lawful separately sealed successor overlaps the complete CODATA interval, or this validation falsely labels the current non-overlap as a pass.

### A.14 Thermal history and physical helium measured-value correction

`SFT-PHYS-VALIDATION-THERMAL-HISTORY-MEASURED-VALUE-058`

Exact exponent One lies inside [49/50,517/500]. Exact physical helium-isotope share 59/240 lies inside [489/2000,2471/10000]. The one-sixth to one-seventh freezeout sequence, positive deuterium, finite recombination support, eighteen extrema and all seven TT rows remain complete. No excluded quarter or angular noninteger record is admitted as a successful result.

Recorded falsification condition: Reject if a source or dependency changes; exponent One or 59/240 leaves its complete measured interval; the freezeout sequence, positive deuterium, finite recombination support, extrema or TT rows are missing; an uncertainty is widened; a mismatch is rewarded; or targets alter either formal survivor.


## Appendix B. Six explicit legacy receipt shapes

These six empirical packages retain their original validation hashes and receipt identities while lacking the later separate measurement-receipt field:

- `SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001` — Terminal self-coupling refinement of the charged-lepton cubic

- `SFT-PHYS-COSMO-COMPLETE-BUDGET-001` — Depth-five Fold cosmic energy budget

- `SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001` — Generation-cover dark-to-baryon fraction

- `SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001` — Fold calibration ratio between early and late expansion routes

- `SFT-PHYS-COSMO-SPATIAL-FLATNESS-001` — Complete-partition spatial flatness and absent curvature remainder

- `SFT-PHYS-VALIDATION-CHARGED-LEPTON-KOIDE-001` — Post-seal exact Koide comparison

The certificate derives this list by filtering the full empirical vector for absent or false measurement-receipt fields and compares its set exactly with the declared legacy vector.

## Appendix C. All 147 external-source identities

The following is the complete registered source-identity vector. `external_source_inventory.json` maps every identity to all of its consuming empirical claim identifiers; `empirical_inventory.json` retains the full corresponding records.

1. `AMDC-AME2020-MASS-1-2021`

2. `AMDC-AME2020-MASS-1-BINDING-2021`

3. `AMDC-NUBASE2020-2021`

4. `AMDC-NUBASE2020-DECAY-HALFLIFE-2021`

5. `APS-HUANG-TURBULENCE-SPECTRUM-2010`

6. `APS-JILA-BEC-GROUND-OCCUPATION-1996`

7. `APS-MCCOMB-TURBULENCE-STRUCTURE-2014`

8. `APS-WILLIAMS-FALLER-HILL-1971-COULOMB`

9. `ARXIV-1201.0501-FIZEAU-WATER-AIR`

10. `ATLAS-2023-COMBINED-HIGGS-MASS`

11. `ATLAS-CMS-2026-HIGGS-PAIR-COMBINATION`

12. `ATOMIC-PRECISION-SUCCESSOR-NIST-2022-2026`

13. `AVER-ET-AL-2026-PRIMORDIAL-HELIUM`

14. `BABAR-2010-TAU-LFV-GAMMA`

15. `BERUT-NATURE-2012`

16. `BICEP-PLANCK-2022-TENSOR`

17. `BIPM-SI-BROCHURE-9-2026`

18. `BOREXINO-2020-CNO-NEUTRINOS`

19. `CERN-OPEN-DATA-DATASET-API-2026-07-23`

20. `CLOWE-2006-BULLET-CLUSTER`

21. `CMS-2024-FOUR-LEPTON-HIGGS-MASS`

22. `COOKE-PETTINI-STEIDEL-2018-DEUTERIUM`

23. `D10E-STRONG-FIELD-NONLINEAR-FIXED-POINT-COMPARISON`

24. `D10F-STRONG-CARRIER-MASSLESS-CONFINED-COMPARISON`

25. `D9F-EXTERNAL-ORBITAL-DIMENSION-STABILITY`

26. `D9M-POST-NEWTONIAN-FIXED-POINT-COMPARISON`

27. `D9N-SYMMETRIC-SOURCE-CONSERVATION-COMPARISON`

28. `D9O-STATIC-EXTERIOR-CLOCK-COMPARISON`

29. `D9Q-QUADRUPOLE-RADIATED-POWER-COMPARISON`

30. `DESAI-ET-AL-2025-PARKER-HCS-PROTONS`

31. `DESI-DR2-2025-COSMOLOGY`

32. `DIEHL-2014-SN2014J-GAMMA-LINES`

33. `EKER-2018-MAIN-SEQUENCE-RELATIONS`

34. `ESCAMILLA-2024-DARK-ENERGY-STATE`

35. `FONSECA-2021-PSR-J0740-MASS`

36. `GOMEZ-VALENT-2019-ACCELERATION`

37. `GOMEZ-VALENT-2023-CCH-32`

38. `GRAVITY-SPACETIME-AUTHORITATIVE-2017-2026`

39. `GWOSC-GW231123-135430-V3-2026-07-23`

40. `GWOSC-V2-CATALOGS-2026-07-23`

41. `HARIDASU-2018-LATE-EXPANSION`

42. `IAEA-ENDF-102-DATA-FORMATS-PROCEDURES`

43. `IAEA-ENDF-CURRENT-2026-07-23`

44. `IAEA-ENSDF-CURRENT-2026-07-23`

45. `IAEA-INDC-NDS-0452-MAGIC-NUMBERS`

46. `IAEA-NDS-JENDL1-INDC-JAP-45`

47. `IAEA-NDS-LEXFOR-FISSION-2006`

48. `IAEA-STI-PUB-1196-RADIATION-PHYSICS`

49. `IAEA-TECDOC-2024-NUCLEAR-COGENERATION`

50. `IAEA-THEORY-NUCLEAR-STRUCTURE-STI-PUB-249`

51. `IAEA-WORLD-FUSION-OUTLOOK-2023`

52. `IAPWS-RELEASES-2026-07-23`

53. `IUPAC-NIST-ATOMIC-SHELL-PERIODICITY-2022-2026`

54. `LELLI-2019-BARYONIC-TULLY-FISHER`

55. `LIGO-VIRGO-2019-GW170817-REMNANT`

56. `LIGO-VIRGO-GW151226-DISCOVERY-2016`

57. `LIGO-VIRGO-GW190521-DISCOVERY-2020`

58. `LOREDO-LAMB-2001-SN1987A-NEUTRINOS`

59. `MATTER-FLAVOUR-AUTHORITATIVE-2022-2026`

60. `MATTER-FLAVOUR-TERMINAL-ANOMALY-AUTHORITATIVE-2022-2026`

61. `MATTER-FLAVOUR-TERMINAL-AUTHORITATIVE-2025-2026`

62. `MATTER-FLAVOUR-TERMINAL-PROTON-AUTHORITATIVE-2022-2026`

63. `MCMASTER-LIN-ERBIUM-CRITICAL-SCATTERING-1993`

64. `MEGII-2025-MU-E-GAMMA`

65. `NASA-GRC-MOON-SYNCHRONOUS-ROTATION`

66. `NASA-GSFC-COSMIC-ELEMENTS-STELLAR-STAGES`

67. `NASA-GSFC-WHITE-DWARF-CHANDRASEKHAR`

68. `NASA-LAMBDA-2026-07-23`

69. `NASA-LAMBDA-COBE-FIRAS-2026-07-23`

70. `NASA-LAMBDA-COBE-FIRAS-MONOPOLE-2026-07-23`

71. `NASA-NTRS-HELIOSEISMOLOGY-2001`

72. `NASA-NTRS-MESSENGER-MERCURY-RESONANCE`

73. `NASA-PLASMA-FREQUENCY-PROBE-1992`

74. `NASA-STEREO-ALFVEN-LIST`

75. `NATURE-2019-PRAD-PROTON-RADIUS`

76. `NATURE-2026-ELECTRONIC-HYDROGEN-PROTON-RADIUS`

77. `NATURE-STORZ-LOOPHOLE-FREE-BELL-2023`

78. `NBS-ACOUSTIC-CAVITY-1986`

79. `NEDM-2020-PSI-PERMANENT-EDM`

80. `NIM-NIST-ACOUSTIC-BOLTZMANN-2017`

81. `NIST-ASD-5.12`

82. `NIST-ATOMIC-TRANSITION-RATE-LIFETIME-2026`

83. `NIST-CHEMISTRY-WEBBOOK-2026-07-23`

84. `NIST-COBLENTZ-BLACKBODY`

85. `NIST-CODATA-2014-HISTORICAL`

86. `NIST-CODATA-2022`

87. `NIST-CODATA-2022-ALL-CONSTANTS`

88. `NIST-CODATA-2022-BOLTZMANN`

89. `NIST-CODATA-2022-EXACT-C`

90. `NIST-DIODE-LASER-LINEWIDTH`

91. `NIST-HYDROGEN-RYDBERG-SUCCESSOR-2022-2026`

92. `NIST-JILA-PAULI-BLOCKING-2001`

93. `NIST-JOHNSON-NOISE-BOLTZMANN-2011`

94. `NIST-KRAMIDA-HYDROGEN-CRITICAL-COMPILATION-2010-2019`

95. `NIST-MOLECULAR-SPECTROSCOPY-H2-D2-SUCCESSOR`

96. `NIST-NBS-ATOMIC-FIELD-SPLITTING-2026`

97. `NIST-NCNR-DCS-SUPERFLUID-HELIUM`

98. `NIST-SRD-INDEX-2026-07-23`

99. `NOTERDAEME-ET-AL-2011-CMB-TEMPERATURE`

100. `PDG-2024-ELECTROWEAK-VACUUM-SCALE`

101. `PDG-2024-W-BOSON-LISTING`

102. `PDG-2025-2026-STRONG-EM-COMPLETE-RUNNING-VECTOR`

103. `PDG-2025-A2-1320`

104. `PDG-2025-A4-1970`

105. `PDG-2025-BBN-REVIEW`

106. `PDG-2025-CKM-MATRIX`

107. `PDG-2025-ELECTROMAGNETIC-RUNNING-ENDPOINT`

108. `PDG-2025-HIGGS-MASS-AVERAGE`

109. `PDG-2025-LEPTON-SUMMARY`

110. `PDG-2025-NEUTRINO-MIXING`

111. `PDG-2025-QUARK-MASSES`

112. `PDG-2025-RHO-770`

113. `PDG-2025-RHO3-1690`

114. `PDG-2025-RHO5-2350`

115. `PDG-2025-STANDARD-MODEL-REVIEW`

116. `PDG-2025-SUMMARY-TABLES`

117. `PDG-2026-ELECTROWEAK-REVIEW`

118. `PDG-2026-ELECTROWEAK-SCALE-VECTOR`

119. `PDG-2026-QCD-REVIEW`

120. `PDG-2026-QUARK-MODEL-GLUEBALL-BOUNDARY`

121. `PDG-2026-W-BOSON-LISTING`

122. `PDG-ELECTROWEAK-PRECISION-2024-2025`

123. `PDG-FORCE-SECTOR-ANCHORS-2025`

124. `PDG-HADRON-MULTIPLETS-REGGE-2025`

125. `PDG-NIST-NUCLEAR-RESIDUAL-RANGE-2025-2026`

126. `PDG-NIST-NUCLEON-BINDING-2022-2026`

127. `PH2-EXTERNAL-LYAPUNOV-KS-CORRESPONDENCE`

128. `PH3-EXTERNAL-COUPLED-MAP-CRITICALITY`

129. `PIECHOCINSKA-PRA-2000`

130. `PLANCK-2018-BAO-BASELINE-BUDGET`

131. `PLANCK-2018-COSMOLOGICAL-PARAMETERS`

132. `PLANCK-2018-INFLATION`

133. `PLANCK-2018-OVERVIEW-PEAKS`

134. `PLANCK-2018-VI-ABSTRACT-DENSITIES`

135. `PLANCK-PLA-BASE-NRUN-TTTEEE-BAO-LENSING-68PC`

136. `RAUCH-COHERENT-SPINOR-ROTATION-1975`

137. `RELATIVISTIC-FIELD-AUTHORITATIVE-1971-2026`

138. `SFTOM-V1-E3-EXACT-OBSERVATION`

139. `SFTOM-V1-E4-EXACT-OBSERVATION`

140. `SPARC-2016-175-GALAXY-MASS-MODELS`

141. `SPARC-2016-ROTATION-CURVES`

142. `SPRINGER-CETIN-MANGANITE-CRITICAL-EXPONENTS-2026`

143. `SUPERK-2020-PROTON-E-MU-PI0`

144. `SUPERK-2024-PROTON-E-MU-ETA`

145. `SUPERK-2026-PROTON-E-MU-TWO-PI0`

146. `VACUUM-LINEAGE-AUTHORITATIVE-2015-2026`

147. `WATSON-2019-GW170817-STRONTIUM`

## References

[1] Maria Smith. SFT V3 foundation. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).

[2] Maria Smith. SFT exhaustive monograph. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[3] Maria Smith. SFT V4 Lean verified corpus, edition0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Contact edition: [doi:10.5281/zenodo.24337358](https://doi.org/10.5281/zenodo.24337358).

[4] Maria Smith. Pinned V3 `sft/physics/grand_lock_terminal_law_v1.py`, `structural_constants.py` and `census/physics_grand_lock_input_v1.json`; original formal registration, execution and independent validator. Commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Verbatim source and frozen records accompany this paper.

[5] Maria Smith. Pinned V3 `sft/physics/grand_lock_empirical_v1.py`, `grand_lock_empirical_validation_v1.py`, complete empirical reconciliation snapshot and bound formal receipt, at the commit in [4].

[6] Maria Smith. [Native Grand Lock proofs](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Physics), V4 commit `21cdf559922fb057f8560f42d056ffa035329eb3`. Exact declarations, TURN1063–1070 evidence and TURN1132 completion receipts are identified in `SOURCE_CORRESPONDENCE.json`.

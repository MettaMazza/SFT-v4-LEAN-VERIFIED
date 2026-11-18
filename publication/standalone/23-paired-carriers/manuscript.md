# Paired carriers, flux quantization and circulation

**Least paired recurrence, persistent transport and exact whole-winding closure in Smithian Fold Theory**

Maria Smith · Ernos Labs  
18 November 2026 · Version 1.0 · DOI: 10.5281/zenodo.24335315

## Abstract

Two opposed fermionic labels form the least exclusion-compatible paired carrier: one exchange action changes its orientation and two return it exactly. On the complete phase-locked transport carrier, absence of a collective-label-compatible dissipative transition forces preservation of motion distinctions through every finite registered history. A single-valued return around a closed phase loop occurs exactly at a whole winding of the retained phase cycle. This yields discrete paired-carrier flux classes and, on the separate neutral carrier with its recorded vortex core, discrete circulation classes. The weak-link transfer is fixed by its complete source state and retained phase distinction; the paired identity remains conserved. We derive these results together with the coherent bulk magnetic response and the neutral flow theorem below the first retained excitation. The paper gives the constructions and proofs, seven exhaustive 256-form classifications, original source comparisons and 911 distinct Lean declarations with empty axiom dependencies. No fitted coefficient selects the recurrence, surviving grammar or winding class.

## 1. Least exclusion-compatible pair

The original Materials statement is: “The least exclusion-compatible collective carrier joins two opposed fermionic labels into one integer-composite recurrence class.” Its declared carrier retains two fermionic labels, their opposed pairing, the integer-composite recurrence and the pair-support observation boundary. The underlying two orientations are held labels, written \(a\) and \(\bar a\), rather than signed numerical charges. Opposition satisfies

\[\overline{\bar a}=a,\qquad \bar a\ne a.\]

Define the ordered pair \(P(a)=(a,\bar a)\). The complete two-by-two enumeration contains four ordered label pairs. The two equal-label pairs fail opposition. The two remaining pairs are precisely \(P(a)\) and \(P(\bar a)\). Thus the admissible ordered support has two forms, exchanged by reversal of the retained orientation. This is the exhaustive `completeOpposedPairs` construction in `SFT.Materials.PairedCarrier`.

The carrier cannot be a singleton. If a singleton label \(u\) contained both members, then \(a=u=\bar a\), contradicting opposition. An empty support contains neither member. The actual two-member pair contains both, so two is the least support cardinality retaining the required opposed labels. `noSingletonHoldsBoth` proves the non-singleton step directly from the two membership equalities.

Let \(A_0(a)=a\) and \(A_{n+1}(a)=\overline{A_n(a)}\). Then

\[A_1(a)=\bar a\ne a,\qquad A_2(a)=\overline{\bar a}=a.\]

The pair exchange is \(E(P(a))=P(\bar a)\), whence \(E(E(P(a)))=P(a)\) with both ordered labels retained. The native `oneActionNotClosed` and `twoActionsClose` proofs exhaust the two orientations. The integer-composite class is the preserving class of the original matter-exchange classification. Its closure is exhibited by the two actions themselves.

For repeated paired recurrence define \(B_0(a)=a\) and \(B_{n+1}(a)=A_2(B_n(a))\). The base is immediate. If \(B_n(a)=a\), then

\[B_{n+1}(a)=A_2(B_n(a))=B_n(a)=a.\]

Induction proves \(B_n(a)=a\) for every finite \(n\). `everyPairedRecurrenceCloses` is this induction. The result is independent of a selected repetition count. Pair records retain the whole ordered carrier, and appending a generated pair appends its complete record without changing prior records.

## 2. Exact phase carrier and generated action

The original operation `phase_action` acts on a `FoldQuantumState`. Such a state consists of a nonempty list of distinct branch words, each carrying one label from a finite distinct phase cycle

\[C=(c_0,\ldots,c_{d-1}),\qquad d\ge2.\]

A branch word identifies the complete branch support. A phase label identifies its position in the retained cycle. The constructor rejects duplicate words, repeated phase labels, cycles shorter than two and a branch phase outside the cycle. A generated successor trace must be nonempty. With trace length \(m\), the action retains every branch word and the complete cycle, and changes its phase by

\[T_m(c_i)=c_{(i+m)\bmod d}.\]

For a state \(S=((w_j,c_{i_j}))_j\), this gives

\[T_m(S)=((w_j,c_{(i_j+m)\bmod d}))_j.\]

The order of the branches is preserved. Distinct words remain distinct because no word is changed. Every new phase belongs to the original cycle by the remainder bound. The operation is thus defined on the same admitted carrier after each generated action. `SFT.QuantumComputation.PhaseInterference.phaseActionSource` identifies the complete native branch shift with this source operation.

Two traces with the same remainder modulo \(d\) produce the same state from the same complete source. If \(k=m\bmod d\) is nonempty displacement, an inverse displacement \(d-k\) restores every phase; if the displacement is the identity, a full cycle restores it. In both cases the actual restoring trace may be nonempty. For each branch,

\[((i+k)+(d-k))\bmod d=i,\]

with the identity case handled by a whole cycle. The cycle itself never changes, so branch equality also establishes equality of the full state. These exact finite actions provide the phase recurrence used in the transport, winding and weak-link constructions below.

## 3. Complete transport support and zero resistance

### 3.1 The original loss criterion

The original superconductivity dependency states that transport is a phase-locked joint-carrier recurrence whose accessible support has no momentum-randomizing transition compatible with its retained collective label. A transport row retains an actual observed transfer network, its complete source support, a complete motion-label map and a complete collective-label map. Both maps are projected from the same carrier rows. Write them as \(M_r\) and \(K_r\), and write \(R_r\) for the row's receiver map.

Let \(Q_r\) be the complete source-pair list. The lost compatible motion distinctions are exactly

\[D_r=\{(x,y)\in Q_r:\ R_r(x)=R_r(y),\ M_r(x)\ne M_r(y),\ K_r(x)=K_r(y)\}.\]

`SFT.Physics.SuperconductivityLabelClosure.closedMotionExactly` proves both directions of this membership statement from the original closed-label filter. No unlisted pair is inserted. The empty-loss criterion is equivalent to recoverability of motion distinctions within a collective class:

\[D_r=[]\quad\Longleftrightarrow\quad
\forall(x,y)\in Q_r,\quad
K_r(x)=K_r(y)\ \land\ R_r(x)=R_r(y)
\Longrightarrow M_r(x)=M_r(y).\]

For the forward implication, unequal motion labels under the two equalities would put the pair in \(D_r\), contradicting emptiness. Conversely, if \(D_r\) had a member, its defining equalities and the recoverability condition would give equal motion labels, contradicting its defining inequality. This proves `emptyClosureIffMotionDistinctionsRetained`.

The loss has an operational consequence. If a pair in \(D_r\) had a decoder recovering both original motion labels from the receiver, then their equal receiver values would give equal decoded labels and hence equal motion labels. This contradicts membership. `closedMotionCannotBeDecoded` therefore excludes recovery of a lost distinction from that receiver. The complete transfer ledger still conserves incoming and outgoing support. Distinction loss and support conservation are separate facts of the same recorded operation.

### 3.2 Exhaustive registered recurrence support

A transport contains the complete phase-compatible path census, together with its motion rows. The path-completeness condition is an equivalence: a path is in that census exactly when it occurs in a registered row. Every recorded path returns the prepared phase state. Every transfer is adjacent along its actual graph path. The ordered connected carrier and its graph are retained, and a collective binding associates each cell's macrostate label with the corresponding carrier label.

Write \(\mathcal R\) for the complete registered rows. The closed-transport condition is

\[\forall r\in\mathcal R,\quad D_r=[].\]

`SFT.Physics.CollectiveSuperconductivity.completeTransitionCensus`, `everyRecordedPathReturns`, `everyTransferAdjacent` and `closureExactly` establish the census, phase recurrence, locality and equivalence to complete pairwise motion preservation. These are quantified over the actual supplied transport carrier.

### 3.3 Persistence through the same finite history

A history begins with one registered row. Its successor appends another registered row with the same source support and collective map, and with the continuity condition

\[M_{r_{j+1}}=R_{r_j}.\]

The native `History` constructors retain these equalities explicitly. Suppose a source pair has equal collective labels and becomes equal at the final receiver. For a one-row history, the empty-loss equivalence gives equal initial motion labels. For an appended history, the common source support preserves pair membership and the common collective map preserves the collective equality. The last row's empty-loss condition gives

\[R_{r_{j+1}}(x)=R_{r_{j+1}}(y)
\Longrightarrow M_{r_{j+1}}(x)=M_{r_{j+1}}(y).\]

Continuity changes the latter equality into \(R_{r_j}(x)=R_{r_j}(y)\). The induction hypothesis then yields equality of the first row's motion labels. Hence an initially distinct motion pair in one collective class cannot be merged by the final receiver of any such history. This is `SFT.Physics.SuperconductivityJointHistory.noMotionDistinctionLost`.

The phase proof uses that same history. Every path extracted from it is registered. The empty sequence of actions leaves the prepared state unchanged. If a registered path returns that state and the remaining history does too, their composition returns it. Induction establishes exact return after the complete path list. `sameHistoryReturnsPhase` and `jointPhaseAndMotionPersistence` combine phase return and motion preservation without choosing separate histories for the two conclusions.

Finally, the collective binding covers every graph cell and identifies its retained collective label. `coherentPersistence` combines full-history phase return, the no-loss implication and the shared collective label. This is the persistent coherent transport result on the original phase-locked, dissipation-closed carrier at its declared critical-condition boundary.

## 4. Coherent magnetic response and declared penetration

The Meissner entry retains an actual superconducting carrier, its finite registered history, the computed final state, a declared penetration support and an applied/response magnetic observation for each graph cell. Let \(S_0\) be the prepared state, \(S_f\) the executed final state, \(V\) the graph nodes and \(P\) the penetration list. The bulk list is computed by filtering the actual nodes:

\[B=\{v\in V:v\notin P\}.\]

Thus \(v\in B\) holds exactly when \(v\in V\) and \(v\notin P\). A declared penetration node cannot occur in the bulk list. `SFT.Materials.MeissnerBoundary.bulkExactly` and `penetrationExcluded` prove these membership facts.

For each cell \(v\), the retained response record is linked to its final magnetic reading \(\mu_v(S_f)\). The complete superconducting recurrence proved above gives \(S_f=S_0\). Substitution into the actual response binding yields

\[\operatorname{after}_v=\mu_v(S_f)=\mu_v(S_0).\]

For a bulk cell, if the applied distinction is incompatible with that coherent reading, namely \(\operatorname{before}_v\ne\mu_v(S_0)\), then

\[\operatorname{after}_v\ne\operatorname{before}_v.\]

Otherwise equality of before and after, followed by the displayed response equality, would contradict the incompatibility hypothesis. This is the proof of `incompatibleAppliedDistinctionClosed`; `completeBulkRecurrence` and `bulkMagneticReadingRetained` supply its two premises. It identifies the incompatible applied distinction excluded by the complete bulk recurrence while retaining the explicitly declared penetration support.

The boundary response is an actual `FieldInduction.BoundaryWork` record. Its boundary trace is the recurrence trace of its complete recorded changes. `completeBoundaryResponse` preserves that equality. `boundarySourceRetained` preserves each source field-change component through the cyclic transfer records. Consequently the bulk conclusion is accompanied by the charged boundary response that generates it, including the original before/after observations. The record map retains the entire boundary object and the computed bulk list under both the base carrier and every finite append.

## 5. Exact flux winding

### 5.1 Return if and only if whole winding

Let \(C\) be a finite distinct phase cycle of length \(d\), and let an actually selected phase \(c_i\) have index \(i<d\). Membership establishes \(d>0\). For a natural transition count \(m\), phase return means

\[c_{(i+m)\bmod d}=c_i.\]

Distinctness of cycle labels forces equality of their selected indices:

\[(i+m)\bmod d=i.\]

Euclidean quotient and remainder give

\[i+m=d\left\lfloor\frac{i+m}{d}\right\rfloor+i.\]

Cancel \(i\) to obtain \(m=dn\) for the natural number \(n=\lfloor(i+m)/d\rfloor\). Conversely, if \(m=dn\), then adding a multiple of \(d\) leaves the remainder unchanged, and \(i<d\) gives

\[(i+dn)\bmod d=i.\]

The selected phase therefore returns. This proves the exact equivalence

\[T_m(c_i)=c_i\quad\Longleftrightarrow\quad \exists n\in\mathbb N,\ m=dn.\]

`SFT.Materials.FluxWinding.returnForcesWholeWinding`, `wholeWindingReturns` and `returnExactlyWholeWinding` are the two arguments and their equivalence. Natural counts here index finite list transitions; the empty transition list is represented by its natural length. The general remainder lemma includes that structural base. The nonempty quantum successor operation of Section 2 keeps its original nonempty-trace domain.

### 5.2 Closed paired-carrier path and computed class

A flux loop retains a graph, a valid path whose first and last labels agree, the paired label and charge record, a distinct phase cycle, the selected phase and its index, and the phase return along the complete adjacent-pair list of the path. Put

\[m=|\operatorname{adjacentPairs}(p)|,\qquad
w=\left\lfloor\frac{m}{d}\right\rfloor.\]

The return theorem supplies \(m=dn\). Since \(d>0\), division of this multiple gives \(w=n\). Consequently

\[m=dw.\]

`computedWindingExactly` proves this identity. The class is computed from the complete transition count and retained phase cycle; no independently chosen winding is supplied to select the output. The record retains the whole loop, its actual opposed pair and \(w\). The paired charge and both labels remain projections of the original input. Single-valued closure therefore admits exactly the discrete whole-winding flux classes of this carrier.

For a concrete cycle with three distinct labels, trace lengths one and two change every phase, length three returns every phase, and length six returns with winding two. The same arithmetic works for every positive cycle length admitted by the selected-phase lemma. The phase-state operation uses cycles of at least two as required by its own constructor. These statements follow from the quantified proof, rather than from the example.

## 6. Weak-link phase transfer and pair identity

A weak link retains two admitted phase states, an actual prepared transfer between them, the opposed paired carrier, a generated phase trace and the declared link conditions. The generating equation is

\[T_m(S)=S',\]

where \(m\) is the actual trace length. Define the retained phase distinction by \(k=m\bmod d\), with \(d\) the source cycle length. `SFT.Materials.WeakLinkTransfer.completePhaseTransfer` rewrites the generating equation as the complete branch shift

\[\operatorname{branches}(S')
=\operatorname{shiftBranches}(C,k,\operatorname{branches}(S)).\]

`sameCycleRetained` identifies the destination cycle with \(C\). For two links with the same complete source state and the same phase distinction, their complete destination branch lists are equal by this equation, and their cycles are equal by cycle retention. Thus their entire destination states agree. `samePhaseDistinctionSameResult` proves this uniqueness.

The inverse shift restores each branch phase by the modular identity in Section 2. The admitted cycle is distinct, contains each branch phase and has positive length; \(k<d\) follows from the remainder bound. Applying the inverse to every branch and retaining their word labels proves `inversePhaseRecurrence`.

The weak link's actual transfer network also retains paired identity. `pairIdentityAcrossLink` uses complete mechanical conservation to equate its outgoing and incoming support. `actualPairRetained` identifies the transferred carrier with the original opposed pair and preserves both labels. The phase distinction controls the full destination phase state while the transfer ledger conserves the pair. Complete link records append under finite successor with the original source, destination, conditions and computed phase distinction intact.

## 7. Neutral coherent flow below the first excitation

The superfluid entry uses a neutral carrier: its retained charge-support list is empty. It also retains a complete collective transport, its cell/carrier binding, a finite class list with a partial order, the excitation classes, and a computed unique least excitation \(e_*\). The successful `uniqueLeast` check is part of the declared boundary. Its correctness theorem establishes

\[e_*\in E,\qquad \forall e\in E,\ e_*\preceq e,\]

and any other least member equals \(e_*\). This is `SFT.Materials.SuperfluidBoundary.firstBoundaryIsLeast`, using the original held-order operation. The critical boundary is the first retained excitation in that order.

Every registered row has a class in the class list. The below-boundary predicate tests inequality with \(e_*\) and the actual order relation:

\[\operatorname{below}(r)\quad\Longleftrightarrow\quad
\operatorname{class}(r)\ne e_*\ \land\
\operatorname{class}(r)\preceq e_*.\]

Filter the complete registered transport rows by this predicate. `censusExactly` identifies membership with registered membership and the predicate. The dissipation condition requires \(D_r=[]\) for every row of this filtered census. A bounded history is generated by a below-boundary base row and appending another below-boundary registered row with the same history continuity conditions as Section 3.

The no-loss proof now runs on bounded histories. At the base, census membership supplies empty loss and the pairwise recoverability equivalence applies. At a successor, the last row belongs to that same census. Equal receiver images and equal collective labels force equal motion labels there. Motion/receiver continuity converts this to equality at the previous receiver, and induction yields equality of the original motion labels. `noLossInBoundedHistory` proves the complete statement.

All history paths are registered, so their phase actions return the same prepared state by the phase induction of Section 3. The collective binding gives one retained phase class across the connected cells. `sharedPhaseReturns` and `allCellsSharePhaseClass` retain these conclusions; `noChargedConstituent` proves that the empty charge support has no member. Thus the original neutral shared-phase carrier preserves coherent flow throughout every bounded finite history whose complete accessible census has no compatible loss path.

## 8. Neutral circulation and vortex-core retention

A superflow loop is a separate input type. It contains the valid closed graph path, empty charge support, a distinct phase cycle and selected phase, the return along the actual adjacent-pair transition list, and the declared vortex-core and observation conditions. The `SFT.Materials.SuperflowWinding` construction applies the general whole-winding equivalence from Section 5 to this neutral carrier:

\[T_m(c_i)=c_i\quad\Longleftrightarrow\quad m=dw
\text{ for some }w\in\mathbb N.\]

Its computed output is again \(w=\lfloor m/d\rfloor\), and `computedWindingExactly` proves \(m=dw\). The record keeps the full neutral loop and the computed circulation class. The vortex core is not discarded when assigning a class: its boundary and conditions are fields of the retained whole-loop record. The neutral charge list remains empty.

The same arithmetic explains whole return in flux and circulation because both use a single-valued phase cycle. Their source carriers remain distinct: the flux loop retains a paired charge and opposed pair, while the superflow loop retains neutrality and its vortex-core boundary. In each case the output follows from the complete actual transition list. For arbitrary finite lists of either loop type, mapping the complete record gives the base and successor identities

\[\operatorname{records}([x])=[\operatorname{record}(x)],\]
\[\operatorname{records}(xs\mathbin{+\!+}[x])
=\operatorname{records}(xs)\mathbin{+\!+}[\operatorname{record}(x)].\]

These are exact finite append laws. Together with the per-loop whole-winding theorem they retain each earlier loop, its class and all declared conditions after every generated successor.

## 9. Seven exhaustive grammars and closure

The seven original registrations use the superconducting/superfluid/topological Materials subbranch. Each grammar has eight binary axes: carrier, relation, organization, observation boundary, record, provenance, generality and extension. The content-specific preserving choices of the first four axes are:

| Entry | Carrier and relation | Organization and observation |
|---|---|---|
| Coherent pair | two-fermion joint carrier; opposed-label pairing | integer-composite recurrence; pair-support boundary |
| Zero resistance | phase-locked pair network; collective translation recurrence | momentum-randomizing paths absent; critical conditions |
| Meissner response | coherent boundary-current carrier; applied-field response | bulk phase lock retained; declared penetration |
| Flux quantization | closed phase loop; whole-return winding | paired charge retained; integer flux classes |
| Josephson link | two condensates and link; phase-difference transfer | pair identity across link; junction conditions |
| Superfluidity | neutral coherent fluid; shared-phase flow | loss paths below gap absent; critical conditions |
| Circulation | closed superflow loop; whole-phase return | vortex core retained; integer circulation classes |

The four common preserving choices retain the complete state/transition/boundary trace, root-bound forward provenance, positive-finite successor closure and no extra rule. Their alternatives remove or replace the required information: a result without its record, authority-selected provenance, single-instance lookup, or an added fit/exception. The first four rejected forms erase the carrier, import or erase its relation, collapse its organization, or leave its observation boundary unrecorded.

For each entry, the literal nested Cartesian product enumerates

\[2^8=256\]

candidates in the original axis order. Completeness holds for an arbitrary candidate: decompose its eight fields, place each field in its corresponding two-element list by cases, and apply the nested product membership rules. This constructs membership in the full enumeration, as proved by each module's `candidatesComplete`. The product length reduces to 256 in `generatedCardinality`.

Let \(b_i(c)\) mean that axis \(i\) has its preserving constructor. Source identifier comparison and the direct conjunction decision agree on every combination:

\[\operatorname{survives}(c)=\bigwedge_{i=1}^{8}b_i(c).\]

`sourceDecisionMatchesCriteria` proves this by complete constructor elimination. If the conjunction holds, all eight fields equal their preserving constructors, hence \(c\) equals the fully preserving tuple \(c_*\). Conversely, that tuple satisfies every field. Thus

\[\operatorname{survives}(c)=\mathrm{true}
\quad\Longleftrightarrow\quad c=c_*.\]

`uniqueCriteriaSurvivor`, `uniqueSurvivor` and `acceptanceIffExactCriteria` provide these implications. Setting any axis to its rejected constructor contradicts the corresponding field equality, giving the eight explicit exclusion theorems. Across seven entries the complete census contains 1,792 candidate decisions.

The physical closure arguments are those developed in Sections 1–8: opposed-pair recurrence induction; joint phase/motion history induction; complete bulk-response retention; exact winding equivalence; weak-link uniqueness and conservation; below-excitation history induction; and neutral circulation with retained vortex core. Their complete record maps preserve the one-carrier base and every finite append. The grammar's generality choice refers to these actual source-specific closures. The three original operational witnesses additionally check a nonempty carrier label and separate relation, organization and boundary labels. Those program checks retain the registered record identities alongside the mathematical derivations.

The native grammar modules are `CoherentPairGrammar`, `ZeroResistanceGrammar`, `MeissnerGrammar`, `FluxQuantizationGrammar`, `JosephsonGrammar`, `SuperfluidGrammar` and `CirculationGrammar` under `SFT.Materials`. Their companion `Evidence` modules retain every candidate record, decision reason, trace identity, closure record and source control.

## 10. Source comparisons and retained experimental protocol

The original source bindings associate the seven entries with four archived NIST documents. The pair entry binds to the functional electronic-materials programme and its superconducting-materials discussion. The zero-resistance, Meissner and flux entries bind to the superconducting flux-lattice document. It distinguishes persistent supercurrent, bulk field expulsion and flux carried by vortices. The weak-link entry binds to the Josephson voltage-standard account of superconductive tunnel junctions. The two neutral entries bind to the atom-SQUID report describing a superfluid ring and discrete circulation changes. Each binding retains the full snapshot identity and both required fragments, for fourteen entry-specific fragment checks.

The complete Materials branch prediction set is sealed before external source selection. Every selected prediction program consumes the sealed derivation premise and emits its registered observation label. Its capabilities exclude filesystem access, network, clock, environment, dynamic import, subprocess and foreign functions. Program execution fixes its output and trace identities; prediction sealing precedes the protected-package audit and target release. The custodian verifies the committed target identity and release record. Comparison checks the predicted label against the source-derived released label and rejects the deliberately altered label. Replacing an existing prediction seal is rejected.

The native `Experiment.validateSpec` operations check the registered subbranch, dependencies, all eight distinct dimensions, their unique preserving choices, exact result label, three witnesses, source bindings and target identity. Each `Validation.runComparison` retains registration and derivation identities, prediction seal, isolation certificate, custody certificate, all source rows, comparison, adverse control and complete measurement identity. The original independent validators exercise the corresponding controls.

The retained TURN803–809 reports establish agreement for all native program fields, 256 candidate lookups per entry, all census and decision hashes, closure, controls, registration and unknown-identifier rejection. Their source-specific reports retain fresh required-fragment extraction and field-for-field, hash-for-hash agreement with the archived post-source comparisons. The whole Materials registry guard separately preserves the pinned Wulffman snapshot-hash rejection before release. The entry-specific `rejectedSourcesStop` results preserve that original guard. Source-specific extraction, archived comparison and the whole-registry outcome remain separately recorded in the evidence bundle.

For this release, the unchanged original `FoldQuantumState` and `phase_action` bodies were executed on cycle lengths 2 through 33, all selected phases in each cycle, and nonempty trace lengths 1 through \(3d\). The 1,680 state cases cover 37,584 phase rows. Every complete ordered output agreed with its modular action; exact return agreed with whole winding; the inverse action restored the state; adding one complete cycle preserved the result. The original empty-trace error was also reproduced. All fourteen required fragments were freshly checked against the four digest-verified snapshots. These portable examples accompany the general proof bodies and retained complete-program comparisons.

## 11. Native proof evidence and source correspondence

Maria Smith is the scientific author of SFT and its original derivations. The original sources are pinned to V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`; the native release is V4 edition 0.4 at `21cdf559922fb057f8560f42d056ffa035329eb3`.

The seven Materials statements and declared domains are in `sft/materials/obligations.py`, positions 34–40. Their candidate construction is in `derivation.py`; the program, witnesses and experimental protocol are in `generated_law.py`; original source bindings are in `external_bindings.py`. The superconducting dependency is in `sft/physics/collective_matter_laws.py`. The exact state and phase action are in `sft/quantum_computation/operations.py`. Original execution bindings, registrations and derivation documents accompany the release.

TURN803–809 are the seven source-specific completion receipts, corresponding to the same numbered timeline steps. The zero-resistance entry reuses the unchanged TURN552 superconductivity derivation. The seven entry receipts audit 130, 112, 124, 126, 125, 126 and 126 declarations. The four reused superconductivity modules contribute 42 further distinct declarations, giving

\[130+112+124+126+125+126+126+42=911.\]

All selected declarations match retained empty-axiom audit output. Applicable source/module digests and original builds are retained. This is a declaration count, separate from seven completed entries and 1,792 candidate decisions.

`SOURCE_CORRESPONDENCE.json` maps the original sources, native modules, exact receipts and file identities. `SOURCE_AND_EVIDENCE.zip` includes 362 native modules with their imported proof dependencies, 80 original source files, complete selected evidence and a portable reproduction script. The paper presents the mathematical arguments themselves; the archive supplies their exact source operations, native proof terms and applicable verification records.

## References

1. Maria Smith. Smithian Fold Theory V3 foundation. https://doi.org/10.5281/zenodo.21627656.
2. Maria Smith. Smithian Fold Theory V3 physics corpus. https://doi.org/10.5281/zenodo.21761655. Exhaustive monograph including Materials: https://doi.org/10.5281/zenodo.21900790.
3. Maria Smith. SFT V4 Lean verified corpus, edition 0.4. https://doi.org/10.5281/zenodo.24320778. Pinned native source: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3.
4. NIST. Genomics of Electronic Materials. https://www.nist.gov/programs-projects/genomics-electronic-materials. Registered snapshot: `nist-functional-electronic-materials.html`.
5. NIST. Flux Lattice in Superconductors and Melting. https://www.nist.gov/ncnr/flux-lattice-superconductors-and-melting. Registered snapshot: `nist-superconducting-flux.html`.
6. NIST. The Josephson Volt: NIST's First Quantum Electrical Standard. https://www.nist.gov/news-events/events/josephson-volt-nists-first-quantum-electrical-standard. Registered snapshot: `nist-josephson.html`.
7. NIST. First Controllable Atom SQUID. https://www.nist.gov/news-events/news/2012/11/first-controllable-atom-squid. Registered snapshot: `nist-superfluid-circulation.html`.

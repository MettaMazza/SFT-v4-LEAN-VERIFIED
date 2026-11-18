# Observation, reversible records and the Fold erasure ledger

**Exact reconstruction, entropy orientation and the closed Maxwell-demon cycle**

Maria Smith · Ernos Labs  
18 November 2026 · Version 1.1 · DOI: 10.5281/zenodo.24352920

## Abstract

Macroscopic irreversibility and microscopic reconstruction follow from two projections of the same retained record. If an observation merges two distinct histories, no decoder of their common image can recover both. Retaining the history with its image gives an explicit inverse; any sufficient reduced label must distinguish the merged histories. For every admitted finite observation composition, earlier fibres lie inside later fibres and the complete unresolved-pair count cannot decrease. Exact source/destination accounting reduces internal-energy change to boundary transfers, and every finite lawful Fold trace preserves its positive carrier and source history. The reset fibre of half-One is exactly quarter-One and three-quarter-One: reset closes one binary distinction and has exact predecessor separation half-One. Every finite sequence of the original returned sorting cycles has equal gained, closed and exported record counts. The post-seal comparison retains all four registered Landauer theory/experiment rows and their thermal conditions. This paper develops the arguments and native Lean proof constructions in full, using eight original source entries, 2,816 complete candidate decisions and 1,034 distinct empty-axiom audited declarations.

## 1. Carrier, observation and the reconstruction theorem

Let the original microscopic support be a nonempty finite list of distinct source labels. An admitted observation is a finite source/image record with distinct source keys matching the support exactly. Each source therefore has one named image. A fibre is the original-order sublist with a common observed label. Every support member occurs in exactly one fibre; no unobserved predecessor is removed.

The native hypotheses are explicit computed admission results, rather than an arbitrary partition assigned to the process. `EntropyPartition.exactPartition` constructs the fibres; `partitionMembership` identifies their actual members, and `partitionClassDistinct` retains their uniqueness. Macrostate objects contain the source support, actual observation, computed partition and membership of their selected row. The downstream observation used in a process is itself admitted on the first observation's labels.

For an ordered list \([x_1,\ldots,x_n]\), the source-pair operation lists each pair \((x_i,x_j)\) with \(i<j\) in original enumeration order. Its recursive construction is

\[\operatorname{pairs}([])=[],\qquad
\operatorname{pairs}(x::L)=\operatorname{map}(y\mapsto(x,y),L)\mathbin{+\!+}\operatorname{pairs}(L).\]

The unresolved carrier retains these exact pairs; a singleton has empty unresolved support. The counts used below are lengths of these complete lists. A finite count zero in a list-length theorem denotes an empty record list; the physical scalar representation uses structural empty One for a closed distinction.

All physics declaration references below have prefix `SFT.Physics`; the information-science and foundation dependencies are named separately. The exact original operations and native source bodies accompany this paper at the pinned commits in Section 11.

## 2. Macroscopic irreversibility and retained microscopic reconstruction

Let O map a microscopic history to its macro-observation. If distinct histories a and b merge, O(a)=O(b), a decoder D of that macro-observation cannot reconstruct both: the two claimed recovery equations imply
\[
a=D(O(a))=D(O(b))=b,
\]
contradicting a≠b. mergedHistoriesCannotBothBeDecoded proves this directly for arbitrary histories and their actual observation map.

Retain the predecessor information through a label map l and form the extension
\[
E(h)=(O(h),l(h)).
\]
The first projection preserves the macro-observation and the second preserves the retained label. The complete extension equality is
\[
E(a)=E(b)\iff O(a)=O(b)\land l(a)=l(b).
\]
If a decoder of the extension recovers both distinct histories whose macro-images merge, their labels must differ. Otherwise the displayed equivalence would identify their extended records and the same decoding contradiction would follow. labelsMustSeparateMergedHistories therefore establishes the required distinguishing role of retained predecessor information.

Retaining the complete history itself provides the explicit construction
\[
E_{\rm full}(h)=(O(h),h),\qquad
\operatorname{recover}(m,h)=h,
\qquad\operatorname{recover}(E_{\rm full}(h))=h.
\]
This extension is injective by its second projection. More generally, a source label with its retained reconstruction function recovers the same history through that projection. The formalisation reuses the original finite-operation equivalences between reversibility, injectivity and singleton observation fibres, together with the full reverse-record and held-fibre recovery proofs. Thus the macroscopic loss and microscopic reconstruction are two projections of the retained record; the microscopic trace is not erased to obtain the macro-description.

Original source: sft/physics/thermodynamics_laws.py, thermal_law and IRREVERSIBILITY, and claims/SFT-PHYS-THERMO-IRREVERSIBILITY-001/WHY_DERIVATION_CHECK.md at V3 commit 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Native verification: SFT/Physics/ThermoIrreversibility.lean (macroProjectionPreserved, retainedLabelPreserved, mergedHistoriesCannotBothBeDecoded, extensionDistinguishesExactly, labelsMustSeparateMergedHistories, completeRecordReconstructs, completeRecordInjective, retainedDecoderRecovers); InformationScience.ConservationCardinality.reversibleIffInjective/reversibleIffSingletonFibres and ConservationReverse.heldRecovery/reverseAdmitted. Full entry checks: verification/TURN_532_IRREVERSIBILITY_COMPLETION.json.

## 3. Heat and work from the receiving observation

The original energy-transfer network retains every source, destination and complete carrier. Its source identities belong to the admitted observation support. For each pair (a,b) in the complete source-pair ledger P, let O denote the receiving observation. The earlier conservation-of-distinction derivation gives
\[
C=\{(a,b)\in P:O(a)=O(b)\},\qquad
H=\{(a,b)\in P:O(a)\ne O(b)\}.
\]
Equality or inequality of the two images exhausts the pair's possibilities. Thus
\[
P=C\cup H,\qquad C\cap H=\varnothing.
\]
The source heat/work distinction is consequently fixed by the receiving observation: C contains the closed microscopic carrier-label distinctions, while H retains distinguishable organization. closedSelectionIff and heldSelectionIff connect the implemented classifier to these exact ledger memberships. completeClassification and classesDisjoint prove exhaustiveness and exclusion. No additional transfer class or selectable classification coefficient enters the construction.

For a closed pair, both predecessors belong to one receiving fibre. If a and b are distinct and a decoder d were to reconstruct both from the shared image, then
\[
a=d(O(a))=d(O(b))=b,
\]
contradicting their distinction. The closed label cannot be recovered from that receiving image alone. This loss of observable organization does not remove the energy carrier: for the entire original transfer network N,
\[
\operatorname{outgoingSupport}(N)=\operatorname{incomingSupport}(N)
=\operatorname{map}(\operatorname{carrier},N).
\]
The heat/work observation therefore preserves the complete energy provenance while identifying precisely which source-label distinctions remain accessible.

Original source: sft/physics/thermodynamics_laws.py, thermal_law and HEAT_WORK, and claims/SFT-PHYS-THERMO-HEAT-WORK-001/WHY_DERIVATION_CHECK.md at pinned V3 commit 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Native proofs: SFT/Physics/ThermoHeatWork.lean (closedMeaning, heldMeaning, completeClassification, classesDisjoint, heatLabelClosedInReceiver, closedLabelNotReconstructible, completeEnergyProvenance, everyOriginalCarrierRetained); ThermoHeatWorkClasses.lean (closedSelectionIff, heldSelectionIff), reusing InformationScience.ConservationLedger and ConservationReverse. Entry grammar, controls, retained source-output and original empirical-validator comparisons: verification/TURN_522_HEATWORK_COMPLETION.json.

## 4. First law as complete boundary accounting

For each retained energy-transfer row t, write e(t) for its already derived energy change, s(t) and d(t) for its source and destination, and I for membership in the named support. The source/destination incidence fixes its contribution uniquely:
\[
\delta_I(t)=
\begin{cases}
 e(t)-e(t),&I(s(t))\land I(d(t)),\\
 -e(t),&I(s(t))\land\neg I(d(t)),\\
 e(t),&\neg I(s(t))\land I(d(t)),\\
 \varnothing_1,&\neg I(s(t))\land\neg I(d(t)).
\end{cases}
\]
Here the minus sign denotes reversal of the held scalar orientation, and the equal-carrier subtraction is structural empty One. The native effectIsExactSourceDestinationDifference theorem identifies every branch with incoming energy minus outgoing energy. In particular, an internal transfer cancels its own equal carrier; a fully external transfer has no internal contribution. The two remaining cases are exactly the boundary crossings.

Preserve the original order of the transfer rows and define their closed composition recursively:
\[
B_I([])=\varnothing_1,\qquad
B_I(t::L)=\operatorname{add}(\delta_I(t),B_I(L)).
\]
Let L_boundary filter L by unequal source/destination membership. Structural induction establishes
\[
B_I(L)=B_I(L_{\rm boundary}).
\]
The empty list is immediate. At a noncrossing head the contribution is empty One, so the induction hypothesis supplies the equality. At a crossing head the same contribution appears on both sides and congruence transports the induction hypothesis. This proves the full boundary identity for every finite retained ledger without reordering the scalar composition. Heat/work classification uses the receiving labels from the preceding section; changing that observation while retaining the same energy network leaves this balance unchanged, by sameEnergyNetworkSameBalance.

Original source: sft/physics/thermodynamics_laws.py, thermal_law and FIRST_LAW, and claims/SFT-PHYS-THERMO-FIRST-LAW-001/WHY_DERIVATION_CHECK.md at the same pinned V3 commit. Native proofs: SFT/Physics/ThermoFirstLaw.lean (internalCancels, incomingRetainsEnergy, outgoingReversesHeldOrientation, outsideHasNoInternalChange, noncrossingEmpty, completeBoundaryAccounting, sameEnergyNetworkSameBalance) and ThermoFirstLawBalance.lean (effectIsExactSourceDestinationDifference). Entry grammar, controls and retained full-program/empirical comparisons: verification/TURN_523_FIRSTLAW_COMPLETION.json.

## 5. Thermodynamic entropy as conditional unresolved support

The earlier observation partition derives the complete microscopic fibre F_l for each retained macro-label l from the admitted support S:
\[
F_l=\{x\in S:O(x)=l\},\qquad |F_l|>0,\qquad |S|>0.
\]
The native Macrostate carries the computed partition and the membership of its named fibre. exactHeldFibre identifies its stored microscopic members with this actual fibre, and retainedObservationLabel preserves l. The information required to distinguish the merged predecessors is the inherited uncertainty construction U(F_l); it preserves every source-pair distinction:
\[
\operatorname{uncertaintyPairs}(U(F_l))=\operatorname{sourcePairs}(F_l).
\]
This binds thermodynamic entropy directly to conditional unresolved support, with no added distribution or selected microscopic states. The exact support weight is the normalized ratio |F_l|/|S|. For the returned numerator n and denominator d, normalization proves
\[
|F_l|d=n|S|.
\]
The inherited certainty theorem gives empty unresolved support exactly when the member count is at most one. Partition membership supplies the positive lower bound, hence
\[
U(F_l)=\varnothing_1\iff |F_l|=1.
\]
Equal retained member lists produce equal entropy by congruence of the same unresolved-pair operation. The original singleton base and fresh-member successor proofs are reused: appending a new member retains all previous pairs and adds its pairs with the preceding members; the exact support ratio updates by the corresponding successor counts. These are the existing EntropyExtension.singletonBase, singletonWholePart, classPairSuccessor and successorPartValue derivations, now bound to the thermal macrostate.

Original source: sft/physics/thermodynamics_laws.py, thermal_law and ENTROPY, and claims/SFT-PHYS-THERMO-ENTROPY-001/WHY_DERIVATION_CHECK.md at pinned V3 commit 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Native proofs: SFT/Physics/ThermoEntropy.lean (exactHeldFibre, fullConditionalDistinctions, retainedObservationLabel, exactClassWeight, noUnresolvedDistinctionIffSingleton, sameRetainedFibreSameEntropy and the four inherited base/successor proof bindings); SFT/InformationScience/EntropyPartition.lean, EntropyLedger.lean and EntropyExtension.lean. Entry grammar, controls and retained source/empirical comparisons: verification/TURN_524_ENTROPY_COMPLETION.json.

## 6. Second Law from observation composition and retained reversal records

The source's closed macroscopic process composes an admitted observation f with an admitted downstream observation g over the same complete microscopic support S. The native Process carries both original validation results and the computed before/after partitions. The existing composition operation constructs g(f(x)) for every x in S and preserves its source row. Hence
\[
f(a)=f(b)\Longrightarrow g(f(a))=g(f(b)).
\]
This implication is the exact refinement predicate used by the earlier observation theory. inducedRefinement proves it from the actual composition, with both source-key guards retained. The inherited class-containment theorem then supplies, for every earlier fibre F, a later fibre G satisfying
\[
F\subseteq G.
\]
Earlier partition membership establishes that F contains no duplicate states. The constructive distinct-subset counting theorem therefore gives
\[
|F|\le |G|.
\]
predecessorSupportCannotShrink returns the later partition row, the inclusion for every earlier member and this count inequality together. No predecessor is silently discarded in moving to the later macro-observation.

Unresolved distinctions are the complete source-pair lists within those fibres. Their earlier derivation establishes unique pair enumeration and inclusion under refinement; its cardinality consequence now yields
\[
\sum_{F\in\mathcal P_f}|\operatorname{pairs}(F)|
\le
\sum_{G\in\mathcal P_{g\circ f}}|\operatorname{pairs}(G)|.
\]
The implemented statement uses the lengths of the corresponding flattened pair ledgers, preserving their exact order. Every closed distinction persists and every retained distinction after composition was retained before it. This derives the thermal orientation directly from observation composition.

Exact reversal retains the complete predecessor-fibre record. A singleton fibre identifies its unique predecessor; a nonsingleton fibre retains the list of possible predecessor labels. The inherited heldRecovery theorem proves membership in that list equivalent to membership in S with the required observed image. If two distinct predecessors a and b have the same final image and a decoder without their missing distinction claimed to recover both, then
\[
a=d(g(f(a)))=d(g(f(b)))=b,
\]
a contradiction. noUnrecordedReverse proves that exclusion; exactReverseRecord binds the existing complete reversal operation to the composed observation. The missing predecessor distinction must therefore remain available for an exact reversal.

Original source: sft/physics/thermodynamics_laws.py, thermal_law and SECOND_LAW, and claims/SFT-PHYS-THERMO-SECOND-LAW-001/WHY_DERIVATION_CHECK.md at V3 commit 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Native verification: SFT/Physics/ThermoSecondLaw.lean, especially actualComposition, inducedRefinement, predecessorSupportCannotShrink, unresolvedPairCountCannotDecrease, closedDistinctionsPersist, retainedDistinctionsCannotIncrease, exactReverseRecord and noUnrecordedReverse. Reused proofs: InformationScience.ConservationComposition, ConservationReverse, EntropyRefinement and EntropyPairs; Mathematics.ProbabilityEvents.distinctSubsetLength. Full source and empirical checks: verification/TURN_525_SECONDLAW_COMPLETION.json.

## 7. Third Law and the finite non-erasure boundary

The source's finite unattainability statement preserves the generated material carrier and its recurrence trace through every lawful step. The earlier exact-Part construction admits positive reduced parts of One; its Fold operation returns another admitted Part. For a source p and arbitrary finite step count n, the existing iterator is
\[
F^0(p)=p,\qquad F^{n+1}(p)=F^n(\operatorname{Fold}(p)).
\]
The returned Part retains its positive numerator and the original admission round trip. Consequently
\[
\operatorname{num}(F^n(p))>0,\qquad
\operatorname{num}(F^n(p))\ne0,\qquad
\operatorname{admit}(\operatorname{asFraction}(F^n(p)))=F^n(p).
\]
finiteIteratePositive, finiteIterateCannotErase and finiteIterateAdmitted bind these existing carrier properties to arbitrary finite iteration. They introduce no numerical cooling parameter or terminal replacement state.

The existing Steps relation retains the actual Fold successor at each transition. Every member of a lawful trace is therefore a positive admitted Part. Retaining its initial source gives H=p::L; sourceTraceRetained proves p belongs to H and noEmptyRetainedHistory excludes an empty H. At an actual successful first return, the previously established nativeFirstReturn theorem supplies
\[
L=L_{\rm before}\mathbin{+\!+}[p],\qquad
\operatorname{Steps}(p,L),\qquad
\forall q\in L_{\rm before},\ q\ne p.
\]
returnPreservesSource retains this entire statement. Since its final singleton contains p, the returned trace cannot be empty: recurrence closure returns the source instead of deleting it. This is distinct from erasing all generated distinction, which the positive carrier and retained history exclude.

The generated support proofs also establish C_0=1 and C_{n+1}=C_n+C_n. Positivity is retained at every depth; for positive depth C_n>1, and the recurrence predecessor C_n-1 is positive. The thermal binding reuses supportPositive, positiveSupportBeyondOne and predecessorPositive rather than assigning an independently adjustable recurrence bound. The source's finite unattainability boundary thus preserves the original generated support, carrier and history throughout.

Original source: sft/physics/thermodynamics_laws.py, thermal_law and THIRD_LAW, and claims/SFT-PHYS-THERMO-THIRD-LAW-001/WHY_DERIVATION_CHECK.md at the same pinned V3 commit. Native verification: SFT/Physics/ThermoThirdLaw.lean; Foundation.ExactPartCarrier, Foundation.FoldDynamics.iterate, Physics.GeneratorThreeDerivation.Steps and support proofs, and Physics.FoldFirstReturn.nativeFirstReturn. Full entry checks: verification/TURN_526_THIRDLAW_COMPLETION.json.

## 8. Exhaustion of the reset fibre and the complete finite ledger

The original exact Fold acts on every rational part \(0<x\leq1\) by

\[F(x)=\begin{cases}2x,&2x\leq1,\\2x-1,&2x>1.\end{cases}\]

The ready state is half-One. In the first branch, \(F(x)=1/2\) forces \(2x=1/2\) and hence \(x=1/4\). In the second branch it forces \(2x-1=1/2\), hence \(2x=3/2\) and \(x=3/4\). Both satisfy their respective branch inequalities, and substitution gives the same image:

\[F(1/4)=1/2,\qquad F(3/4)=3/2-1=1/2.\]

The branch split exhausts the full positive rational domain. `Foundation.FoldFibres.exactTwoPreimages` proves exhaustion for every admitted Part and image. Its proof recovers the lower preimage in the lower branch using exact normalized factors; in the upper branch, the phase antipode moves the input into the lower branch, preserves its Fold image and returns the original input by phase involution. Specialization to half-One gives the two rational values. `LandauerDemonLedgerDerivation.originalActualFold` identifies the entry operation with that foundational action; `originalNativeFibreComplete` transports the exact carrier round trip and proves the returned-image criterion. Thus the result is a complete fibre theorem, not only two evaluations.

The exact reset operation returns the ordered pair \((1/4,3/4)\). It counts its distinct predecessor labels and holds its one ready image. The closed distinction and native separation are therefore

\[C=2-1=1,\qquad \Delta=3/4-1/4=2/4=1/2.\]

These are `LandauerDemonLedger.originalTwoPreimages`, `originalOneDistinction` and `originalHalfOneThrow`. For any decoder \(d\) of the reset output, recovering both predecessors would give

\[1/4=d(F(1/4))=d(1/2)=d(F(3/4))=3/4,\]

contradicting their exact values. `originalUnrecordedResetNotReversible` applies the general merged-history theorem to these actual outputs. The retained decoder instead maps `lower-preimage` to quarter-One and `upper-preimage` to three-quarter-One. `originalRecordCriterion` proves, for every supplied string, that record admission is equivalent to the decoder returning a predecessor. Other labels return no predecessor. The choice records which source occurred; it does not choose another law.

The complete original cycle has six fields:

| Field | Complete returned content |
|---|---|
| Sorting gain | One `gas-speed-class` record |
| Memory support | `lower-preimage`, `upper-preimage` |
| Reset image | One `ready-half-One` record |
| Erased distinctions | One |
| Environment record | One `environment-reverse-label` record |
| Completeness | Equality of gained, exported and erased counts |

`LandauerDemonLedger.originalCompleteLedger` proves equality with this entire record. The two memory states are the alternative predecessors of one reset. They are not two gains. For any cycle returned by the source operation, `originalReturnedCycleBalance` first identifies it with this exact record and derives both count equalities.

For a list of returned cycles, define gain and environment lists by concatenating their actual fields, and define the closed count by summing their actual erased counts. Write these \(G_k,E_k,C_k\). The empty list gives

\[|G_0|=|E_0|=C_0=0.\]

Appending one returned cycle adds one retained record to each list and one to the count:

\[|G_{k+1}|=|G_k|+1,\qquad |E_{k+1}|=|E_k|+1,\qquad C_{k+1}=C_k+1.\]

Using the induction hypothesis gives

\[\boxed{|G_k|=C_k=|E_k|=k}\]

for every finite list of the original returned cycles. The native proof `originalFiniteClosedLedger` uses list induction and exact append-length equality for each field; `originalEveryReturnedCycleCloses` supplies its head condition from `originalReturnedCycleBalance`. Thus closure is derived from the actual returned source record rather than inserted as an unsupported balance assumption. Every gained distinction has its corresponding environment record.

Original V3 operations: `landauer_demon_ledger_terminal_law_v1.py`, `fold_part`, `reset_preimages`, `erased_distinction_count`, `minimum_throw`, `reversible_reset_labels`, `reset_is_reversible_with_record`, `demon_cycle_ledger`, and the exact base/successor clauses of `SPEC`. Native modules: `LandauerDemonLedger`, `LandauerDemonLedgerDerivation`; source-bound receipt TURN993 with retained TURN992 operation and derivation evidence.

## 9. Post-seal physical comparison

The original formal ledger fixes one lost predecessor distinction, one required external reverse record and native separation one-half before a thermal target is opened. The physical comparison then matches the two-state reset and nonfree environmental transfer to the original committed theory and experiment records. Its dimensional thermal statement is

\[\langle Q\rangle\geq k_B T\ln2\]

for the registered symmetric equiprobable bit in a thermal reservoir. The observed long-cycle limiting mean approaches that bound. In conventional normalized notation these statements are \(\langle Q\rangle/(k_BT)\geq\ln2\) and long-cycle approach to \(\ln2\). Here the external thermal coefficient is the original primary-source inscription. The native equation remains \(\Delta=1/2\), a rational predecessor separation. The original comparison preserves both quantities and their roles.

Piechocinska's theory identifies reset from two distinguishable states to one and treats classical continuous, classical discrete and quantum cases. Its bound is an ensemble average in contact with a thermal reservoir; a non-equiprobable initial distribution has a distribution-dependent lower bound. Bérut and colleagues implement a classical bit with a colloidal particle in a modulated double-well potential, measure finite mean dissipated heat on erasure and observe saturation in the long-cycle limit. The registered statement concerns that limiting mean, not an identical heat for every individual finite-time event.

Figure 3 also resolves incomplete erasure by its success rate \(r\). The primary experiment reports saturation near 95% for large tilt amplitudes, caused by the finite barrier and thermal activation into the other well. Its generalized mean-heat bound is

\[\langle Q\rangle_{\min}(r)=k_BT\bigl[\ln2+r\ln r+(1-r)\ln(1-r)\bigr].\]

The complete-reset limit \(r\to1\) gives \(k_BT\ln2\), using \(x\ln x\to0\) as \(x\to0^+\). At \(r=1/2\), substitution gives \(\ln2+\ln(1/2)=0\): the protocol has retained no reliable reset outcome. The experimental comparison therefore retains success probability alongside cycle duration. Individual trajectories can dissipate negative heat; the bound applies to the ensemble mean. These are the primary experiment's dimensional quantities and conditions; the exact Fold fibre and its one-record ledger remain those derived in Section 8. [6]

All four original target rows are retained, in order:

| Row | Source and original locator | Retained physical relation |
|---|---|---|
| Two-to-one reset | Piechocinska, page 1 | Two possible bit states reset to one |
| Thermal bound | Piechocinska, abstract and equations 19/52 | Ensemble-average bound and reservoir conditions |
| Experimental saturation | Bérut et al., abstract and Figure 3 | Long-cycle mean approaches the bound |
| Scope control | Bérut et al., one-bit bistable memory | Initial memory and limiting-mean conditions |

The registered source snapshot has SHA256 `76a746eb8760816598724a2db17fb7cd1f3a07325e69193525d313fecea4d27f`. Its complete record and both citations are supplied in the release. For \(k\) independently prepared resets, the finite source ledger still gives \(G_k=C_k=E_k=k\); ensemble averaging changes neither those counts nor the committed conditions.

The six earlier thermal comparisons also retain their original two-row vectors. Heat/work uses the NIST Chemistry WebBook thermochemistry and phase-change/reaction-energy holdings; first-law accounting uses enthalpy/internal-energy and reaction/phase-change balances; entropy uses entropy records and standard-state tables. The second-law comparison uses IAPWS irreversible transport and viscosity/thermal-conductivity releases; the third-law comparison uses low-temperature validity and reference-state/phase-boundary specifications. The irreversibility comparison retains its original transport/relaxation and thermodynamic-consistency locators. These source vectors are structural observation-label comparisons under the original protocol, with every row and adverse test preserved.

For each vector, let \(L\) be the predicted label from the sealed derivation and \(O_i\) the released label for row \(i\). The original comparison computes \(b_i=(L=O_i)\) for every committed row. It deliberately changes an observation to \(L_{\rm bad}\) and requires \(L\ne L_{\rm bad}\). Acceptance is

\[\left(\bigwedge_i b_i\right)\land(L\ne L_{\rm bad}).\]

The prediction program receives the sealed derivation premise. Its instruction vocabulary has no filesystem, network, process, clock, environment, dynamic-import or foreign-function capability. Execution fixes the output and trace hashes; the seal binds them to the experiment envelope. The source-hash check precedes execution. The package audit preserves program identity, and the target custodian releases the committed rows only after the seal. The evaluator verifies the release identity, compares the complete ordered vector and retains the unfavorable control. `LandauerValidationValidation.validate` implements this complete sequence, with experiment/spec/source checks in `LandauerValidationExperiment`. The retained native comparison reproduces all original source-output fields and receipt hashes.

## 10. Complete grammar construction, unique classification and closure

Each of the six thermal entries uses the original eight-axis product: carrier, relation, provenance, prediction, measurement record, rows, generality and extension. Each axis has exactly its admitted and rejected constructors. The admitted combination holds the complete Fold carrier, the entry-specific relation derived above, the source-bound proof trace, capability-closed prediction, a separate measurement record, every registered row, the One/successor closure and no extra rule. Exhaustion therefore gives \(2^8=256\) candidates for each entry. The Landauer empirical entry uses the same eight-axis preservation construction, with its actual erasure relation and four rows.

The reset-ledger formal grammar instead uses all ten original axes: support, image, distinction, throw, reversal, sorting, memory, environment, thermal translation and extension. Its admitted combination is the complete two-preimage fibre, common half-One image, one binary distinction, half-One separation, retained predecessor label, one gas distinction, two-label memory, one environment reverse label, post-seal dimensional correspondence and no extra rule. Every one of its \(2^{10}=1024\) alternatives is present.

For each native grammar, a candidate structure contains one constructor from each axis. The generated list is the ordered nested Cartesian product of both constructors at each field. For an arbitrary candidate, successive list membership rules place every field in that product, proving `candidatesComplete`. The decision theorem identifies the original source decision with the conjunction of its actual preservation criteria. Exhausting the two constructors at each field proves that all criteria hold exactly for the unique admitted structure. `uniqueSurvivor` and `acceptanceIffExactCriteria` identify this structure and its full conjunction; rejected-field theorems exclude every alternative. The reset ledger's native census divides its proof into sixteen complete 64-row blocks and combines them without omitting a case.

There are consequently

\[6\cdot256+1024+256=2816\]

complete source candidate decisions across eight entries. These grammar proofs accompany the arbitrary-support observation theorems, arbitrary finite ledger induction, complete rational reset-fibre theorem and full returned source records. Formal uniqueness, scientific derivation and empirical correspondence retain their respective evidence.

The original false-premise, tampered-source, tampered-artifact and boundary controls remain. The independent original validator accepts the complete unmodified record and rejects an omitted candidate, an additional survivor and a failed control. The base/successor proofs preserve actual predecessor lists, pair order, observation images and complete transfer provenance. No extra scientific coefficient, stochastic decision, omitted environment record or additional exception enters the reset law.

## 11. Source correspondence and reproducibility

The scientific author is Maria Smith. All original V3 sources are pinned to `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. The native evidence is the V4 edition 0.4 release at `21cdf559922fb057f8560f42d056ffa035329eb3`. The source-bound completion receipts are TURN522–526, TURN532, TURN993 and TURN994, with the actual proof and source-comparison results retained.

The eight selected entry receipts account for 1,034 distinct declarations whose retained kernel audits report no axiom dependencies. The archive includes 365 native modules with their imported proof dependencies, 86 original source files, applicable builds, complete-program and empirical comparison reports and independent controls. Eight entries, 2,816 candidate decisions and 1,034 audited declarations are distinct counts.

`SOURCE_CORRESPONDENCE.json` gives the exact module and source identities. `SOURCE_AND_EVIDENCE.zip` contains the original source package, proof bodies and raw results, plus an executable reproduction of the unchanged reset operations. Its displayed finite ledgers and exact rational examples supplement the existing universal proof bodies; their full source domains are stated above. The source-returned six-field cycle, both valid reversal labels, rejected labels and input guards remain inspectable.

## References

1. Maria Smith. Smithian Fold Theory V3 foundation. https://doi.org/10.5281/zenodo.21627656.
2. Maria Smith. Smithian Fold Theory V3 physics corpus. https://doi.org/10.5281/zenodo.21761655. Exhaustive monograph: https://doi.org/10.5281/zenodo.21900790.
3. Maria Smith. SFT V4 Lean verified corpus, edition 0.4. https://doi.org/10.5281/zenodo.24320778. Native pinned source: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3.
4. Maria Smith. From operational occurrence to the unique least Fold generator. https://doi.org/10.5281/zenodo.24327008. Thermal support and inflation, version 1.1: https://doi.org/10.5281/zenodo.24326655.
5. B. Piechocinska. Information erasure. *Physical Review A* **61**, 062314 (2000). https://doi.org/10.1103/PhysRevA.61.062314. Original registered primary source: https://harvest.aps.org/v2/journals/articles/10.1103/PhysRevA.61.062314/fulltext.
6. A. Bérut et al. Experimental verification of Landauer's principle linking information and thermodynamics. *Nature* **483**, 187–189 (2012). https://doi.org/10.1038/nature10872. Primary article copy: https://www.cpt.univ-mrs.fr/~verga/pdfs/Berut-2012yq.pdf.
7. NIST Chemistry WebBook, SRD 69. https://webbook.nist.gov/chemistry/. Original registered thermochemistry, phase-change and reaction-energy source snapshot retained in the archive.
8. International Association for the Properties of Water and Steam. Scientific releases. https://iapws.org/. Original registered releases snapshot and source-specific locators retained in the archive.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

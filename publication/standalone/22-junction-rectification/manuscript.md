# Semiconductor junction balance and rectification

**Exact transfer–field correspondence, finite-history preservation and the complete two-orientation barrier law**

Maria Smith · Ernos Labs  
18 November 2026 · Version 1.0 · DOI: 10.5281/zenodo.24327699

## Abstract

Every cross-interface transfer in the original generated junction carrier retains its source depletion, destination charge, field response and provenance. The ordered field-source projection equals the ordered transported-charge projection, including repeated occurrences. Exact charge normalization reconstructs the original force; reversing the depleted charge reverses the response. The complete response ledger preserves every earlier row under each finite successor and records every qualifying crossing. On the resulting retained junction carrier, positive barrier and applied counts have exactly two bias classes: forward bias leaves the positive residual when the applied count is smaller than the barrier and otherwise opens the junction; reverse bias strengthens the barrier by the positive sum. This paper develops the complete source-bound argument, from actual doping support through depletion and field coupling to both barrier branches, with exhaustive classification of 512 source candidates and 287 distinct empty-axiom audited Lean declarations. The registered external comparisons retain their original source fragments, prediction seals and full records, including the NIST account of forward and reverse diode operation.

## 1. Generated carrier and actual doping support

The original junction statement is: joining opposed doped regions forces interfacial carrier transfer until a retained depletion/space-charge organization balances transport and field response at declared conditions. Its quantified domain is every positive finite generated Materials carrier in the registered electronic-semiconductor grammar preserving opposed doped regions, cross-interface carrier transfer, retained space charge and field, and declared equilibrium/bias conditions. The generated carrier includes its actual transfer and field organization. The argument follows the original base and successor construction on that domain.

For each endpoint region \(r\), let \(B_r\) and \(A_r\) be the actual before- and after-doping support collections. The original support differences are

\[G_r=A_r\setminus B_r,\qquad L_r=B_r\setminus A_r.\]

The list operations retain the original source order. Membership satisfies

\[x\in G_r\iff x\in A_r\land x\notin B_r,\qquad
x\in L_r\iff x\in B_r\land x\notin A_r.\]

A gained member cannot also be lost: the first equivalence gives \(x\notin B_r\), while the second would give \(x\in B_r\). Moreover,

\[x\in A_r\iff(x\in B_r\land x\notin L_r)\lor x\in G_r.\]

To prove the forward implication, split on membership in \(B_r\): a retained member is not lost, and a new member is gained. Conversely, gained membership implies membership in \(A_r\); a before-member absent from \(A_r\) would be lost, contradicting its retained status. `SFT.Materials.DopingSupport.gainedExactly`, `lostExactly`, `differenceOrientationsDisjoint` and `afterSupportReconstructed` establish these identities for the actual collections.

Define \(g_r=|G_r|\) and \(l_r=|L_r|\). The majority selector has exactly three outcomes:

\[o(r)=\begin{cases}
\mathrm{first},&l_r<g_r,\\
\mathrm{second},&g_r<l_r,\\
\mathrm{none},&g_r=l_r.
\end{cases}\]

Strict order prevents both majority classes from holding together. Natural-number trichotomy gives one of them whenever the two counts differ. Swapping gained and lost counts reverses the held orientation. `CarrierMajority.occupationFromActualDifference`, `absenceFromActualDifference`, `balancedSupport`, `completeDopedSupportClassification` and `swappingDifferenceReversesMajority` prove these claims. Thus the opposed input regions are identified by computed support differences. Substitution and addition retain their original host, site, provenance and concentration boundary.

## 2. Complete interfacial selection and paired depletion

A retained transfer is \(t=(s,d,q,\pi,\alpha)\): source endpoint, destination endpoint, charge carrier, source identity and action record. A charge has a positive exact amount and one of two held orientations. Reversal changes the orientation while retaining the amount. The source depletion record is

\[S(t)=((s,\operatorname{rev}q),(d,q),\pi,\alpha).\]

It follows that the two endpoint amounts agree and their orientations are opposed. Every endpoint, source identity and action record is retained. These are `JunctionTransfer.chargeMagnitudePaired`, `chargeOrientationsOpposed` and `transferAndChargeProvenanceRetained`.

The opposed-region selection is

\[P(t)\iff[o(s)=\mathrm{first}\land o(d)=\mathrm{second}]
\lor[o(s)=\mathrm{second}\land o(d)=\mathrm{first}].\]

The original endpoint case distinction has only these two accepted combinations. Equal orientations and an absent majority return false. Both crossing directions are retained. For the ordered transfer network \(T\), define

\[T_{pn}=\operatorname{filter}(P,T),\qquad
Q_{pn}=\operatorname{map}(S,T_{pn}).\]

Filter membership and map preimage give the exact equivalence

\[r\in Q_{pn}\iff\exists t\in T,\ P(t)\land S(t)=r.\]

The forward proof extracts the originating transfer from map membership, then extracts its predicate and original membership from the filter. The reverse proof inserts that same transfer into the filtered list and maps it. `opposedDopedEndpointsExactly` and `dopedSpaceChargeExactly` prove the two constructions. Original occurrence order and repeated transfers survive; no support deduplication replaces a transfer history.

For a declared interior predicate, the complete transport ledger also satisfies

\[D_{\mathrm{inside}}+|T_{\mathrm{in}}|
=A_{\mathrm{inside}}+|T_{\mathrm{out}}|.\]

Here \(D\) counts departures, \(A\) arrivals and the two lists are actual inward and outward crossings. For one internal transfer both interior counts gain one; for an outward transfer departure and outward count gain one; for an inward transfer arrival and inward count gain one; an external transfer changes neither side. List induction sums these four endpoint cases. `JunctionTransfer.exactDepletionTransportBalance` applies the existing complete boundary identity to the original transfer network.

## 3. Ordered charge–field correspondence

A native coupling contains an actual transfer \(t_c\), its electromagnetic field carrier \(F_c\) and the common-source equality

\[q(t_c)=q_{\mathrm{electric}}(F_c).\]

The complete carrier holds an ordered list \(C\) of these couplings with

\[\operatorname{map}(c\mapsto t_c,C)=T.\]

These are the fields of `SFT.Physics.CollectivePlasma.Coupling` and `Plasma`. The field is attached to the same transported charge, and every transfer occurrence is represented. Restricting couplings by the same opposed-endpoint predicate gives

\[C_{pn}=\operatorname{filter}(c\mapsto P(t_c),C).\]

The ordered projections are exactly

\[\operatorname{map}(c\mapsto t_c,C_{pn})=T_{pn},\]
\[\operatorname{map}(c\mapsto q_{\mathrm{electric}}(F_c),C_{pn})
=\operatorname{map}(t\mapsto q(t),T_{pn}).\]

For the first identity, induction on \(C\) proves that mapping transfers commutes with this filter. At the empty list both sides are empty. At a head \(c\), the same predicate either removes the head on both sides or retains the same transfer before the induction hypothesis. Substitution of the complete original transfer projection finishes the proof. For the second identity, list induction rewrites each field charge by its common-source equality; the tails agree by induction. `JunctionCoupling.dopedTransferProjectionExact` and `dopedFieldSourceProjectionExact` therefore preserve order and multiplicity as well as membership.

For every selected transfer there is a selected coupling with that transfer and charge; `everyDopedInterfaceTransferHasSourceField` constructs it from the exact projection. The converse retains its actual network membership. Its source-depleted charge is the reversal of the same electric source, and the destination charge is that source itself.

The response row contains five components:

\[R(c)=(S(t_c),E_c,M_c,\mathcal P_c,\mathcal I_c),\]

where \(E_c\) and \(M_c\) are the electric and magnetic projections, \(\mathcal P_c\) the actual propagation record and \(\mathcal I_c\) the retained induction carrier. `retainedResponse` constructs this tuple; `sourcePropagationRetained` identifies the last two components with the original field propagation and induction. The record follows the source work and transported charge through the complete response.

## 4. Exact restoring response and force reconstruction

The original field operation divides the actual force scalar by the same charge. A scalar is either structural empty One or a positive exact magnitude with held orientation. Charge normalization multiplies by the reciprocal positive amount while retaining the charge orientation. If force magnitude is \(f=a/b\) and charge amount is \(q=c/d\), with all four counts positive, the magnitude quotient represents

\[E=\frac{f}{q}=\frac{ad}{bc}.\]

For a normalized result \(E=e/h\), `FieldElectricPotential.normalizationExact` proves the cross-product identity

\[(ad)h=e(bc).\]

This is exact rational normalization, with both orientations carried separately. `JunctionCoupling.responseUsesActualSourceWork` binds the field to the actual coupling's force and transported charge. Reversing the depleted charge reverses the normalized response:

\[\operatorname{normalize}(F,\operatorname{rev}q)
=\operatorname{rev}(\operatorname{normalize}(F,q)).\]

The proof splits the structural-empty and positive constructors. Empty remains empty. In the positive case the two force orientations and two charge orientations exhaust the held multiplication cases, giving the reversed result. `depletionReversesActualSourceResponse` applies this identity to the actual source-depleted endpoint charge.

Multiplying the field by that same charge reconstructs the original force magnitude:

\[\left(\frac{ad}{bc}\right)\left(\frac cd\right)
=\frac{acd}{bcd}=\frac ab.\]

The native proof uses exact quotient and product representations and cancels the positive factor \(cd\). Applying the same held charge orientation twice returns the original force orientation. `fieldReconstructsActualForce` proves the reconstructed scalar is structural empty when the force is empty; otherwise it has the original orientation and an exactly equal positive magnitude by cross multiplication.

The actual restoring-path carrier retains the terminal displacement equal to the original electric work displacement. Its induction response retains the same source charge at every supplied mechanical-event row. `JunctionObservation.actualRestoringPathRetainsJunctionCharge` combines `CollectivePlasmaOscillation.returnedDisplacement` and `recurrenceRetainsCharge`. These equalities carry the supplied restoring history and its original source through the junction response.

## 5. Base, successor and complete conditional balance record

Let \(H\) be an ordered history of actual charge–field couplings at the declared before/after supports. Its retained junction ledger is

\[\mathcal R(H)=\operatorname{map}(R,\operatorname{filter}(P\circ t,H)).\]

For one coupling,

\[\mathcal R([c])=\begin{cases}[R(c)],&P(t_c),\\{}[],&\text{otherwise}.\end{cases}\]

For any earlier and later histories,

\[\mathcal R(H\mathbin{+\!+}K)=\mathcal R(H)\mathbin{+\!+}\mathcal R(K).\]

The proof is list induction on \(H\). The empty prefix is immediate. At a head \(c\), the predicate either retains the same response head on both sides or removes it from both; the remaining equality is the induction hypothesis. With \(K=[c]\), this gives the exact successor equation

\[\mathcal R(H\mathbin{+\!+}[c])=
\mathcal R(H)\mathbin{+\!+}
\begin{cases}[R(c)],&P(t_c),\\{}[],&\text{otherwise}.\end{cases}\]

`JunctionPreservation.base`, `appendExactly` and `successorExactly` prove these equations. `earlierRowsRetained` preserves every earlier member. `everyRowHasActualTransferAndField` reconstructs an actual qualifying history member and its common field charge from each returned row. Conversely, `everyCrossingRecorded` places every qualifying history member's response in the ledger. Thus the base/successor argument retains all actual depletion, field, propagation and induction rows across every finite extension of the declared carrier.

This realizes the original conditional construction: opposed doped support, cross-interface transfers and actual space-charge/field organization remain held at the declared equilibrium and bias boundary, with exact charge normalization and source response retained. Every lawful successor appends its source-bound relation and preserves all earlier distinctions. The boundary and the preservation argument belong to the original generated domain.

Endpoint observation has its own exact projection. `JunctionObservation.endpointObservations` records the actual source and destination images. Its `closed` predicate says that selected endpoint images lie in the same observation fibre, and `closureExactly` identifies this with image equality. If two images differ, `distinctEndpointPreventsClosure` rejects that fibre condition. This observation-fibre result has its stated image-equality meaning; the transfer/field and finite-history equations above give the junction's source correspondence.

## 6. The complete two-orientation rectification law

The successor source takes two positive counts: retained barrier \(b\) and applied magnitude \(a\). Direction is a held bias class. Forward and reverse outputs are

\[F(b,a)=\begin{cases}
\operatorname{PositiveCount}(b-a),&a<b,\\
\operatorname{HeldLabel}(\text{junction-access},\text{open}),&b\leq a,
\end{cases}\]
\[R(b,a)=\operatorname{PositiveCount}(b+a).\]

The strict forward inequality guarantees \(b-a>0\), so the residual belongs to the original positive-count type. Equality and excess applied magnitude use the held open label. Reverse addition is always positive. Thus the original domain never substitutes numeric zero or a negative proof quantity for open access or reversed direction.

These cases exhaust all positive pairs. In the retained branch,

\[b-a<b<b+a,\]

because \(a>0\). The two barrier magnitudes differ. In the open branch the forward result is the distinct access constructor, while reverse remains a positive barrier. There is therefore an exact orientation distinction for every original input pair.

`SFT.Materials.RectificationSource.retainedForwardEquation` proves the guarded residual branch, `openedForwardEquation` proves its complement and `reverseEquation` proves the positive sum. The source operation `rectification_certificate` returns all three fields: forward orientation, reverse orientation and the true orientation-distinction flag. The native `certificate` preserves that entire record, including its serialized count objects and open-label object. The source's operational witness at \((b,a)=(3,1)\) returns forward count two and reverse count four; `originalWitnessPassed` proves the original witness decision.

| Barrier | Applied | Forward result | Reverse result |
|---|---|---|---|
| 3 | 1 | Positive count 2 | Positive count 4 |
| 3 | 3 | Open access | Positive count 6 |
| 3 | 4 | Open access | Positive count 7 |

The first complete carrier retains both directional outputs and their original boundary. A finite successor appends its lawful barrier/bias record while retaining all previous rows; the two-case partition is exhaustive for each appended positive pair. The source's three returned fields remain the complete elementary certificate. The release reproduction evaluates 400 positive pairs and checks every field, together with rejection of zero, negative, Boolean, floating and textual inputs by the unchanged positive-count constructor. These executable cases accompany the arbitrary-input branch proofs.

## 7. Exhaustive grammar construction and unique survivors

Each entry has eight ordered binary axes. The first four hold its actual scientific construction; the last four preserve complete trace, root-bound provenance, positive finite successor closure and no extra rule.

| Axis | Junction admitted coordinate | Rectification admitted coordinate |
|---|---|---|
| Carrier | Opposed doped regions | Junction barrier and held bias |
| Relation | Cross-interface transfer | Orientation-conditioned barrier transition |
| Organization | Space charge and field | Forward opening and reverse strengthening |
| Observation | Declared equilibrium and bias | Complete two-orientation transport census |
| Record | Complete state, transition and boundary trace | Complete state, transition and boundary trace |
| Provenance | Root-bound forward forcing | Root-bound forward forcing |
| Generality | Positive finite successor closure | Positive finite successor closure |
| Extension | No extra rule | No extra rule |

Each rejected coordinate is the original alternative that erases its required feature, imports or fits the relation, loses the observation boundary, reduces the result to a label, selects from authority, uses one specimen or adds a rule. The ordered Cartesian product has

\[|G|=\prod_{i=1}^{8}2=256\]

candidates for each entry. For an arbitrary candidate, constructor exhaustion proves membership in each binary field list; nested product membership places it in the full census. The source decision equals the conjunction of the eight admitted-coordinate tests. If accepted, each coordinate is admitted and the whole candidate equals the unique retained form. Conversely that form satisfies every coordinate. `JunctionGrammar` and `RectificationSourceGrammar` retain the full completeness and decision/uniqueness proofs. All 512 ordered source candidates, exact forms, decisions and reasons are retained across the two entries.

The source controls cover false premise, changed source, altered artifact and boundary. The independent validators accept the complete programs and reject the retained adverse variants. The junction validator also preserves the original typed sealed-record behavior: its census order is checked exactly; decision-key order is immaterial; later values overwrite earlier repeated decision keys; all required control kinds must occur and every control must pass. `JunctionIndependentValidator` implements those exact rules. Its retained comparisons include reversed census, missing and duplicate candidates, reordered decisions, overwritten decisions, wrong cardinality and changed controls. The full scientific record and the executable validator retain their respective original domains.

## 8. Registered external comparisons and source custody

The rectification source is Robert I. Scace, *Semiconductor Technology for the Non-Technologist*, second edition, NISTIR 4414 (September 1990), Section 3 and Figure 1, printed page 4. Its description has opposed majority-carrier regions. Forward polarity drives carriers toward the junction and across it, producing current. Reverse polarity draws carriers away, leaving a carrier-depleted region that obstructs current. The registered source requires the two exact fragments identifying forward bias and obstruction in the opposite direction. The byte-sealed text has SHA256 `ca301b8fc47ba509909982ca2b077c238b92f3ff4978ed7377d086071c519ba4`.

The earlier junction entry retains its original four source fragments: two NIST Josephson-standard fragments concerning tunnel junctions and series connection, and two NIST semiconductor fragments concerning devices and electrical context. Its complete source-derived observation-label comparison is retained as registered. The rectification successor supplies its own specific NIST diode-direction account. All source identities, fragments and receipts accompany the release. The junction-specific byte identities and all four fragments match their registration. The archived junction comparison is reproduced after that fragment extraction. The complete 33-source registry guard separately returns the original changed-Wulffman-snapshot error before release on the pinned bytes; `JunctionSource.rejectedSourcesStop` preserves that result. The rectification successor uses its own registered source set and complete successful comparison.

The original Materials foundation seals its complete 84-law, 21,504-candidate prediction set before source selection; the successor registry separately binds its eight claims and three sealed source-code files. The selected programs receive a sealed derivation premise. Their instruction vocabulary has no filesystem, network, environment, clock, process, dynamic-import or foreign-function capability. Source identity and fragment validation produces the full registered receipt vector. Execution fixes the prediction and trace hashes; the prediction seal binds those to the experiment envelope. A distinct target custodian releases the committed observation only after the prediction seal, and the package audit checks the protected program identity.

For rectification, the actual final comparator computes equality of predicted and released labels. Its returned object retains twelve fields: derivation seal, experiment-registration hash, isolation certificate, custody certificate, evaluator seal result, target-opened-after-seal result, all-rows result, source identifiers, three measurement messages, measurement-receipt hash, falsification condition and passed result. The messages retain the original source wording, including its changed-label statement. The independent adverse tests and complete output comparisons are retained separately. `RectificationSourceBinding.receipts`, `RectificationSourceExperiment` and `RectificationSourceValidation.validate` give the complete source sequence. All twelve fields, three messages and original hashes agree with pinned V3 execution.

## 9. Native verification and reproducible source record

Maria Smith is the scientific author. V3 is pinned to `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`; V4 edition 0.4 evidence is pinned to `21cdf559922fb057f8560f42d056ffa035329eb3`. The original junction specification is in `sft/materials/obligations.py`, `derivation.py` and the claim's `WHY_DERIVATION_CHECK.md`. The successor barrier operation is in `successor_structural_counts.py`; its obligation, grammar and external protocol are in `successor_obligations.py`, `successor_derivation.py` and `successor_evidence.py`.

The native junction modules contain the support selection, charge pairing, exact normalization, ordered projections and finite-history proofs described above. `verification/JUNCTION_COMPLETION_RECONCILIATION.json` retains the original source-domain completion and its existing evidence; TURN729 retains all 256 program outputs, TURN775 retains exact ordered pairing and audits, and `JUNCTION_INDEPENDENT/RESULT.json` retains the native independent-validator comparison. Their chronological source correspondence is in the pinned cumulative TIMELINE.txt.

The six rectification modules and `verification/TURN_1092_RECTIFICATION_COMPLETION.json` retain all 256 source decisions, original controls, positive-pair outputs and complete empirical comparison. The selected current declarations have 287 distinct empty-axiom audits: 171 junction declarations and 116 rectification declarations. These are declaration counts, separate from the two completed source entries and 512 candidate decisions.

`SOURCE_CORRESPONDENCE.json` records exact source and module digests. `SOURCE_AND_EVIDENCE.zip` contains 479 native modules with imports, 66 original source files, source-specific completion receipts, applicable build/audit/comparison results and the portable unchanged barrier-operation reproduction. Existing applicable native results are reused. The scientific argument, its exact hypotheses and the full elementary mathematics are given in this paper.

## References

1. Maria Smith. Smithian Fold Theory V3 foundation. https://doi.org/10.5281/zenodo.21627656.
2. Maria Smith. Smithian Fold Theory V3 physics corpus. https://doi.org/10.5281/zenodo.21761655. Exhaustive monograph, including Materials derivations: https://doi.org/10.5281/zenodo.21900790.
3. Maria Smith. SFT V4 Lean verified corpus, edition 0.4. https://doi.org/10.5281/zenodo.24320778. Pinned native source: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3.
4. Robert I. Scace. Semiconductor Technology for the Non-Technologist, second edition. NISTIR 4414, September 1990. Section 3, Figure 1, page 4. https://nvlpubs.nist.gov/nistpubs/Legacy/IR/nistir4414.pdf.
5. NIST. The Josephson Volt: NIST's First Quantum Electrical Standard. https://www.nist.gov/news-events/events/josephson-volt-nists-first-quantum-electrical-standard. Original junction-registry snapshot and fragments retained.
6. NIST. Semiconductors. https://www.nist.gov/mml/mmsd/primary-focus-areas/semiconductors. Original junction-registry snapshot and fragments retained.

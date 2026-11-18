# Strong-CP cancellation and baryon stability from complete Fold support

**Maria Smith** · Ernos Labs  
Standalone paper 41 · Version 1.0 · 17 November 2026  
DOI: [10.5281/zenodo.24325935](https://doi.org/10.5281/zenodo.24325935)

## Abstract

Complete colour-times-hand support uniquely retains both strong-sector hands and returns the aligned One phase. The strong-CP violation, electric-dipole and extra-compensator carriers are empty-One records. The independent weak handed restriction retains the unique self-antipodal half-One phase. Every one of the 83 generated mediator signatures preserves its prime fibre; none of the 202 ordered cross-fibre label pairs has a generated action. Every one of the 27 colour-three proton images retains baryon tally One, and induction proves fibre preservation under every finite composition. A separate complete matter–antimatter process has a positive retained residue if and only if tally change, conjugate-path distinction and held reverse completion all occur. These three distinctions preserve the cosmological residue construction without inserting a cross-fibre proton transition. This paper derives the phase carriers, complete hand census, mediator inventory, baryon tally, finite-composition theorem and all eight residue cases. It presents the original neutron electric-dipole record and all six proton-decay limits individually, including uncertainties, confidence levels and background-compatible candidates. Native Lean 4 proofs, complete 1,024-, 2,048- and 256-form grammars, source-output comparisons and empty-axiom audits accompany the derivations.

**Keywords:** strong CP problem; baryon stability; proton decay; neutron electric dipole moment; baryogenesis; parity; exact Fold phase; Smithian Fold Theory; Lean 4.

## 1. The three results and their generated carriers

Three source entries establish the construction [1–3]. The retained-residue law executes every Boolean triple of tally change, conjugate-path distinction and reverse-completion hold. The strong-sector law executes every nonempty restriction of the two-hand fibre, every generated mediator signature and every colour-three word. The empirical companion retains the complete neutron and six-mode proton comparison after the formal construction is sealed.

The results are linked by their actual carriers. Colour and handedness are independent factors in the complete strong product. Its unselected two-hand support is uniquely complete. Generated mediator actions have the same source and image fibre, so their finite compositions preserve that fibre. The retained-residue process instead explicitly contains a cosmological tally-changing act. Its three-condition theorem does not add that act to the mediator inventory.

Structural One, equal complementary shares and the generated spatial/colour count three are common prerequisites. Their complete source constructions are developed in [4,5]. The derivations needed here are given explicitly in Sections 2–6.

## 2. Exact phase and parity fibre

### 2.1. Half-One and its unique self-antipode

Complete equal complementary shares satisfy \(x+x=1\), fixing \(x=1/2\). For an exact part of One, Fold acts by
\[
 F(x)=\begin{cases}2x,&0<x\le1/2,\\2x-1,&1/2<x\le1.\end{cases}
\]
The half-One folds to One. Its complement is itself:
\[
 F(1/2)=1,\qquad 1-1/2=1/2.
\]
If another exact part \(p=n/d\) equals its complement, positive-count equality gives \(n=d-n\), hence \(2n=d\) and \(p=1/2\). Thus every other part is excluded from self-antipodal status. `CPPhase.uniqueSelfAntipodal` uses the established fixed-axis count proof; `returnsToOne` and `selfAntipodal` establish the two source operations.

The complete two-depth binary support consists of \(1/4,1/2,3/4,1\). Their Fold images are \(1/2,1,1/2,1\). Exactly \(1/4\) and \(3/4\) are preimages of half-One. The held parity fibre is therefore
\[
 (\text{lower-held},\text{image},\text{upper-held})
 =(1/4,1/2,3/4).
\]
The lower and upper held parts lie on opposite sides of the image. Swapping their roles changes either one-sided restriction and preserves the paired restriction. `ParityFibre.everyRestriction` enumerates the empty, lower-only, upper-only and paired channels; `oneSideAsymmetric`, `pairedPreserved` and `everyNonemptyChannel` establish the complete classification.

### 2.2. The strong colour-times-hand census

Let \(H=(L,U)\) denote the original lower-held and upper-held labels. Enumerate every nonempty restriction by increasing width:
\[
 \{L\},\quad\{U\},\quad\{L,U\}.
\]
For each \(K\), the complete colour-times-hand carrier is
\[
 C\times K,\qquad C=\{1,2,3\},\qquad |C\times K|=3|K|.
\]
The complete independent product has \(3|H|=6\) cells. Hence a surviving restriction must satisfy \(3|K|=6\), so \(|K|=2\). Only the paired restriction has that count.

| Hand restriction | Complete represented cells | Cell count | Complete strong product | Phase |
|---|---|---:|---|---|
| Lower only | \((1,L),(2,L),(3,L)\) | 3 | no | self-antipodal half-One |
| Upper only | \((1,U),(2,U),(3,U)\) | 3 | no | self-antipodal half-One |
| Paired | \((1,L),(1,U),(2,L),(2,U),(3,L),(3,U)\) | 6 | yes | aligned One |

The paired parity action preserves both held roles; the strong alignment operation consequently returns aligned One. A one-hand restriction instead uses the unique self-antipodal half-One already established above. This exhausts the original phase classes. Complete strong support leaves no unmatched phase carrier and therefore no electric-dipole or compensating-field carrier to append.

The seven-field alignment certificate is exactly:

| Field | Retained result |
|---|---|
| Strong hands | lower-held and upper-held |
| Strong phase | aligned One |
| Weak phase | self-antipodal half-One |
| Strong-CP violation carrier | empty-One |
| Electric-dipole carrier | empty-One |
| Additional compensator | empty-One |
| Complete phase classes | aligned One; self-antipodal half-One |

`StrongCPHands.completeSubsets`, `completeFlags`, `completePhases` and `completeAlignment` prove the full source outputs. Strong alignment is fixed by complete support, with no fitted phase or added compensator.

## 3. Complete mediator inventory and excluded cross-fibre actions

### 3.1. The generated ladder

The first distinct return generator is three. Its successor volume is \(3^{3+1}=81\). The least binary cover depth is seven because
\[
 2^6=64<81\le128=2^7.
\]
Every lower positive depth has still smaller support. The source tests every whole count from two through this ceiling by complete proper-divisor enumeration. Four and six have proper divisors; two, three, five and seven do not. Thus the complete prime-sector ladder is
\[
 P=(2,3,5,7).
\]
For each sector \(p\), the complete ordered charge-pair support has \(p^2\) cells. Removing its single colourless return gives \(p^2-1\) mediator cells, retaining its unique positive predecessor. The full action signatures are
\[
 \mathcal A=\{(p,p,j):p\in P,\ 1\le j\le p^2-1\}.
\]
Every source and image fibre is explicitly the same \(p\).

| Prime fibre | Ordered pair cells | Mediator cells | Complete action range |
|---:|---:|---:|---|
| 2 | 4 | 3 | \((2,2,j),\ 1\le j\le3\) |
| 3 | 9 | 8 | \((3,3,j),\ 1\le j\le8\) |
| 5 | 25 | 24 | \((5,5,j),\ 1\le j\le24\) |
| 7 | 49 | 48 | \((7,7,j),\ 1\le j\le48\) |

The count is \(3+8+24+48=83\). These ranges enumerate all signatures, in original sector and cell order. `PrimeSectorLadder.completeLadder` and `exactMediators` establish the original operations; `StrongCPActions.originalActionCertificate` retains the complete counts and endpoint typing.

### 3.2. Every ordered cross-fibre label pair

For each distinct \(p,q\in P\), retain all label pairs \((p,a,q,b)\), \(1\le a\le p\), \(1\le b\le q\). The number in the corresponding ordered block is \(pq\). The complete block census is:

| Source fibre | Target 2 | Target 3 | Target 5 | Target 7 | Cross-fibre row total |
|---:|---:|---:|---:|---:|---:|
| 2 | same fibre | 6 | 10 | 14 | 30 |
| 3 | 6 | same fibre | 15 | 21 | 42 |
| 5 | 10 | 15 | same fibre | 35 | 60 |
| 7 | 14 | 21 | 35 | same fibre | 70 |

Hence
\[
 \sum_{p\ne q}pq=(2+3+5+7)^2-(2^2+3^2+5^2+7^2)
 =289-87=202.
\]
None has a generated signature: every member of \(\mathcal A\) has equal endpoint fibres, whereas every pair in this census has unequal endpoint fibres. The colour-to-binary block has \(3\cdot2=6\) pairs and likewise no generated transition. The source computes the complete ordered pair list and filters it against every actual signature, returning an empty generated-cross-fibre list.

## 4. Baryon One and every finite composition

### 4.1. Complete colour-word support

A colour-three word is any ordered member of \(\{1,2,3\}^3\). The full product has \(3^3=27\) words; repeated labels remain included. The exact source tally begins with a positive one-third accumulator, adds one-third for each of the three word positions, then removes the initial accumulator:
\[
 B(w)=\frac13+\sum_{i=1}^3\frac13-\frac13=1.
\]
The result depends on retaining all three positions, not on choosing a particular colour permutation. Consequently every one of the twenty-seven source images has baryon tally One. The initial word \((1,2,3)\) has the same tally. `StrongCPActions.everyOriginalTally` proves the complete ordered list of twenty-seven returned Ones.

The full ordered image census is:

| First label | Remaining ordered pairs and resulting words |
|---:|---|
| 1 | 111, 112, 113, 121, 122, 123, 131, 132, 133 |
| 2 | 211, 212, 213, 221, 222, 223, 231, 232, 233 |
| 3 | 311, 312, 313, 321, 322, 323, 331, 332, 333 |

### 4.2. The generated-path theorem

A path is constructed only from the actual mediator signatures. Its empty base at sector \(p\) has endpoint pair \((p,p)\). A successor appends a signature \((q,r,j)\in\mathcal A\) to a prior path from \(p\) to \(q\). Membership in \(\mathcal A\) implies \(q=r\). If the induction hypothesis gives \(p=q\), transitivity gives \(p=r\). Thus
\[
 \text{every finite generated path from }p\text{ to }q
 \quad\Longrightarrow\quad p=q.
\]
A path from colour fibre three to binary fibre two would imply \(3=2\), which is impossible. `StrongCPComposition.generatedPreserves` extracts endpoint equality from membership in the complete 83-signature list. `everyFiniteComposition` proves the induction on its actual `Path` constructors, and `noColourToBinary` derives the exclusion.

The nine-field proton certificate retains the initial word and tally, all twenty-seven images, their count and tally invariance, empty quark-to-lepton and lepton-only-decay records, the finite-composition law and the separate baryogenesis process. Its full nested record is proved in `StrongCPCertificate`. Baryon stability follows from the exhaustive action carrier and its complete finite closure.

## 5. Retained baryon residue: three conditions, eight complete cases

### 5.1. The executed matter–antimatter process

Start with one positive matter carrier and one positive antimatter carrier. Let \(T\) mean a held tally-changing transition, \(C\) a held distinction of conjugate paths, and \(H\) held reverse completion. The operation executes these list actions:

1. If \(T\) is present, append One to matter.
2. If \(T\) is present and \(C\) absent, append the same One to antimatter.
3. If \(H\) is absent, return both lists to their initial first carrier.
4. Sum each actual retained list, compare their supports, and return either empty-One or the oriented positive difference.

The source support sum begins with One and then removes that same initial accumulator, preserving the original positive ledger method. The process computes the retained carriers before its residue; it does not select a result from a condition table.

If \(T\) is absent, both sides retain One. If \(T\) is present but \(C\) absent, the append is paired, so held supports are \((2,2)\). If \(H\) is absent, reverse completion restores \((1,1)\). With all three present, the held supports are \((2,1)\), yielding matter-oriented One.

### 5.2. Complete census and necessary-and-sufficient condition

| Tally change \(T\) | Conjugate distinction \(C\) | Reverse hold \(H\) | Retained supports | Residue |
|---|---|---|---|---|
| absent | absent | absent | (1,1) | empty-One |
| absent | absent | present | (1,1) | empty-One |
| absent | present | absent | (1,1) | empty-One |
| absent | present | present | (1,1) | empty-One |
| present | absent | absent | (1,1) | empty-One |
| present | absent | present | (2,2) | empty-One |
| present | present | absent | (1,1) | empty-One |
| present | present | present | (2,1) | matter-oriented One |

The product contains all \(2^3=8\) Boolean triples, each once in the original false-before-true order. Exactly the all-present row has a positive residue. Therefore
\[
 \text{positive retained residue}\quad\Longleftrightarrow\quad T\land C\land H,
\]
with residue exactly matter-oriented One in that case. `BaryogenesisDependency.originalResidueFormula` and `originalPositiveIffTriple` prove the executed operation for arbitrary Boolean inputs. `originalEveryCondition`, `originalConditionsDistinct`, `originalEightRows` and `originalUniquePositiveRow` establish complete coverage, distinctness and the unique surviving row.

The already sealed CKM and baryon-to-photon entries supply the original physical-carrier and abundance comparisons. Neither a measured abundance nor an efficiency coefficient appears in this process. The original provenance is an observationally informed reconstruction of the known three-condition dependency, with independently executed source operations. Its execution binding has no additional empirical validator.

## 6. Why the residue and stability results coexist

The residue construction explicitly changes the matter tally and retains a distinguished path against reverse completion. The mediator construction instead enumerates only signatures \((p,p,j)\). Its complete carrier contains no tally-changing cross-fibre signature. The proton certificate therefore preserves the residue law as a separate cosmological process without importing its extra process premise into the finite mediator path. Both results follow from the actual registered operations:
\[
 T\land C\land H\Rightarrow\text{retained matter residue},
 \qquad (p,p,j)\text{ composition}\Rightarrow\text{preserved fibre}.
\]
The strong/weak phase distinction likewise follows from the actual support: paired colour-times-hand completeness gives aligned One, while a one-hand restriction gives the unique self-antipodal half-One. No measured phase or decay limit chooses these support decisions.

## 7. Neutron electric-dipole comparison

The original neutron record [7] retains a null-central-estimate label, a positive upper-limit magnitude and separate statistical/systematic uncertainty magnitudes. With \(D=10^{26}\), the exact retained values are
\[
 U=\frac{18/10}{D}=1.8\times10^{-26}\ e\,\mathrm{cm},
\]
\[
 \sigma_{\rm stat}=\frac{11/10}{D}=1.1\times10^{-26}\ e\,\mathrm{cm},
 \qquad
 \sigma_{\rm sys}=\frac{2/10}{D}=2.0\times10^{-27}\ e\,\mathrm{cm}.
\]
The confidence fraction is \(90/100=9/10\). The direct-record predicate checks the original null-status label and positivity of all three retained magnitudes. It returns true for the source record. The strong-sector prediction is the empty electric-dipole carrier from the complete hand census; the observation retains its actual limit and uncertainty carriers.

The original adverse control changes only the central-status field to a confirmed nonempty displacement. The same analysis then returns false for direct-record consistency. The native proof `StrongCPObservationAnalysisProofs.confirmedEDMComplete` establishes the complete altered fourteen-field output, alongside `originalComplete` for the original record.

## 8. Six proton-decay limits, individually retained

For each mode, the source lifetime calculation is \(L=m10^n\), with positive rational mantissa \(m\) and whole exponent \(n\). The complete source order and all six reported limits are:

| Mode | Exact mantissa and power | Lower lifetime limit, years | Confidence | Candidate record |
|---|---|---|---|---|
| \(p\to e^+\pi^0\) | \((24/10)10^{34}\) | \(2.4\times10^{34}\) | 90% | empty observed candidate record |
| \(p\to\mu^+\pi^0\) | \((16/10)10^{34}\) | \(1.6\times10^{34}\) | 90% | one background-compatible candidate |
| \(p\to e^+\eta\) | \((14/10)10^{34}\) | \(1.4\times10^{34}\) | 90% | no candidate-count field in the registered row |
| \(p\to\mu^+\eta\) | \((73/10)10^{33}\) | \(7.3\times10^{33}\) | 90% | no candidate-count field in the registered row |
| \(p\to e^+\pi^0\pi^0\) | \((72/10)10^{33}\) | \(7.2\times10^{33}\) | 90% | one background-compatible candidate |
| \(p\to\mu^+\pi^0\pi^0\) | \((45/10)10^{33}\) | \(4.5\times10^{33}\) | 90% | one background-compatible candidate |

The pion, eta and two-pion observations are the three complete proton source records [8–10]. All limits exceed One year and all confidence fractions equal \(9/10\). Exactly four rows contain the candidate-count field; each original field is retained.

The \(e^+\pi^0\) interpretation is no proton-decay signal; \(\mu^+\pi^0\) is consistent with atmospheric-neutrino background. Both eta modes report no significant excess or indication of proton decay. Both two-pion modes are compatible with expected atmospheric-neutrino background. The analysis tests each row against the original four-label accepted interpretation set and finds every one retained. The lower limits remain finite experimental records.

The adverse decay control changes only the \(e^+\pi^0\) interpretation to confirmed proton decay. The all-mode null/background predicate then becomes false. `StrongCPObservationAnalysisProofs.confirmedDecayComplete` proves the complete altered output. Both adverse controls operate on the original nested record fields; corresponding decoding and update equalities are proved in `StrongCPObservationInputProofs`.

## 9. Complete construction grammars

### 9.1. Generation, necessity, sufficiency and uniqueness

The residue law declares ten binary axes, generating \(2^{10}=1024\) forms. The strong-sector law declares eleven, generating \(2^{11}=2048\). Each table below retains every axis, its preserving form and its original alternative.

Necessity follows by tracing the failed operation on each alternative: an incomplete hand product misses required cells; a cross-fibre action is absent from the exhaustive signature carrier; an untyped tally does not perform the three one-third takes; an unregistered path step violates the actual constructor; and a target-readable or freely extended form changes the source process. Sufficiency follows by combining the complete preserving carrier with the computed witnesses and the applicable finite successor proof. Equality in all coordinates fixes one tuple. The full product enumeration contains it and every alternative tuple, establishing unique closure without selecting a favorable candidate subset.

### 9.2. Retained-residue grammar

| Axis | Preserving form | Other alternative |
|---|---|---|
| carrier | exact paired particle antiparticle carrier | preloaded unpaired residue |
| tally | one explicit tally changing transition | every transition preserves baryon tally |
| conjugacy | CP carrier distinguishes conjugate paths | exactly paired conjugate paths |
| reverse | nonequilibrium reverse completion held | complete reverse recurrence |
| ledger | positive oriented residue or empty One | signed or unrecorded net number |
| composition | single three condition process composition | named independent conditions |
| enumeration | all eight presence absence combinations | selected successful combination |
| comparison | inherit sealed CKM and baryon photon records | abundance selects dependency law |
| provenance | observational reconstruction explicit | mislabel as blind discovery |
| extension | no extra rule | free efficiency or extra condition |

### 9.3. Strong-CP and baryon-stability grammar

| Axis | Preserving form | Other alternative |
|---|---|---|
| predecessor | compose immutable predecessors | rewrite or bypass predecessors |
| cp | aligned One or self antipodal half One | continuum angle or fitted small value |
| hand | complete two hand support | selected single hand |
| strong | paired parity returns aligned One | weak antipode reused for strong |
| compensator | empty One no extra compensator | add axion or free compensator |
| sector | all generated actions are fibre preserving | invent cross fibre mediator |
| baryon | three one third parts close to One | untyped particle name |
| transition | finite composition preserves the fibre | assume an unregistered decay step |
| baryogenesis | retain explicit cosmological boundary | conflate distinct process grammars |
| measurement | targets inaccessible until seal | target readable before seal |
| extension | no extra rule | free angle carrier or operation |

### 9.4. Complete 256-form empirical grammar

The empirical companion uses eight binary axes: carrier, relation, provenance, prediction, record, rows, generality and extension. Their preserving forms are the complete Fold carrier, sealed strong-CP/baryon relation, source-bound proof trace, capability-closed prediction, separate measurement record, complete registered rows, base/successor closure and no extra rule. Their alternatives are an answer-only scalar, imported/fitted relation, unbound provenance, target-readable prediction, conflated proof/measurement record, selected favorable rows, finite lookup and a free extra rule. The complete product contains \(2^8=256\) forms with one preserving tuple.

The source binding checks the original five file identities, four ordered source identifiers, formal receipt, schema and methodological flags before release. Its seven experiment targets are the neutron record followed by the six proton modes. Every source row enters with its own values, confidence and interpretation; the confirmed-EDM and confirmed-decay controls test the corresponding relation directly.

## 10. Native proofs and retained verification

The specification is pinned to V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`; the native implementation and evidence are pinned to V4 edition 0.4, commit `21cdf559922fb057f8560f42d056ffa035329eb3` [3]. The original operations are in `baryogenesis_dependency_terminal_law_v1.py`, `strong_cp_baryon_stability_terminal_law_v1.py`, `strong_cp_baryon_stability_empirical_v1.py` and `strong_cp_baryon_stability_validation_v1.py`, under `sft/physics/`.

| Source result | Native declarations under `SFT.Physics` | Completion evidence |
|---|---|---|
| Executed residue and all eight cases | `BaryogenesisDependency.originalResidueFormula`, `originalPositiveIffTriple`, `originalEveryCondition`, `originalConditionsDistinct`, `originalUniquePositiveRow` | TURN 997; 131 audited declarations |
| Unique strong paired support and phase | `StrongCPHands.completeSubsets`, `completeFlags`, `completePhases`, `completeAlignment` | TURN 1060 |
| All actions and baryon tallies | `StrongCPActions.originalActionCertificate`, `originalColourCount`, `everyOriginalTally`; full `StrongCPCertificate` | TURN 1060 |
| Every finite generated composition | `StrongCPComposition.generatedPreserves`, `everyFiniteComposition`, `noColourToBinary` | TURN 1060; strong-sector entry total 142 audited declarations |
| Entire observation and both controls | `StrongCPObservationAnalysisProofs.originalComplete`, `confirmedEDMComplete`, `confirmedDecayComplete`; input decoding and complete validator | TURN 1061; 124 audited declarations |

The listed entry audits have empty axiom dependencies. Source-specific retained checks include all original candidate decisions, full program/registration/closure/control comparisons, accepted independent validation and rejected adverse cases. The hand comparison retains ten complete outputs/errors; the action comparison retains thirty-seven; the nested alignment, action, proton and theorem certificates retain their complete fields. The empirical output has fourteen fields in original order. Its raw-record decoding, nested control updates, source identities, sealed comparison and custody results are retained with the complete proof evidence.

The reproduction accompanying this paper executes the unchanged original pure functions and their original structural/atomic/lineage imports. It reconstructs all eight condition rows, all three hand rows, all 83 action signatures, all 202 cross-fibre pairs, all 27 colour words, the complete nested strong-sector certificate and the observation with both original adverse controls. General native proofs establish unique self-antipode and arbitrary finite-path preservation beyond those complete finite carrier enumerations.

## 11. Consequences of complete support

Strong-sector alignment is the unique complete colour-times-hand result. The independent one-hand phase is self-antipodal half-One. The complete mediator inventory contains only same-fibre actions, and its finite-composition theorem preserves baryon support. The cosmological residue process retains its distinct three-condition operation, whose complete census has one positive case. The neutron and six-mode proton observations compare these results through their full original records, including all uncertainty and background information. No phase adjustment, compensator, cross-fibre action or abundance efficiency is introduced into the construction.

## References

1. Smith, Maria. *SFT V3 physics corpus*. DOI: [10.5281/zenodo.21761655](https://doi.org/10.5281/zenodo.21761655).
2. Smith, Maria. *SFT V3 monograph*. DOI: [10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790). Operational foundation: [10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).
3. Smith, Maria. *SFT native Lean 4 verification, edition 0.4*. DOI: [10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). [Pinned V4 source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3). Cumulative manuscript sections 867, 970 and 971.
4. Smith, Maria. *Generator three, spatial three and boundary rank two*. DOI: [10.5281/zenodo.24325335](https://doi.org/10.5281/zenodo.24325335).
5. Smith, Maria. *Seven sectors from one rooted constants construction*. DOI: [10.5281/zenodo.24325452](https://doi.org/10.5281/zenodo.24325452).
6. Smith, Maria. *Twelve Smithion mass-ratio predictions*. DOI: [10.5281/zenodo.24324894](https://doi.org/10.5281/zenodo.24324894). Complete prime-sector inventory and its generated carriers.
7. *Measurement of the permanent electric dipole moment of the neutron*. [arXiv:2001.11966](https://arxiv.org/abs/2001.11966). Original pinned neutron source record.
8. *Search for proton decay via p to e-plus pi-zero and p to mu-plus pi-zero*. [arXiv:2010.16098](https://arxiv.org/abs/2010.16098). Original pion-mode source record.
9. *Search for proton decay via p to e-plus eta and p to mu-plus eta*. [arXiv:2409.19633](https://arxiv.org/abs/2409.19633). Original eta-mode source record.
10. *Search for proton decay via p to e-plus two-pi-zero and p to mu-plus two-pi-zero*. [arXiv:2604.10975](https://arxiv.org/abs/2604.10975). Original two-pion-mode source record.

**Authorship.** Maria Smith is the scientific author of SFT and its original definitions and derivations. AI assistance supports source-bound exposition, native-proof correspondence and publication preparation under her direction.


## Author contact and community

Maria Smith, Ernos Labs. Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com). Join the SFT Discord community: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC).

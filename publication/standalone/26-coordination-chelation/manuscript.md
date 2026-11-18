# Coordination number, ligand denticity and the first chelate closure

**Maria Smith**  
Ernos Labs  
Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com)  
SFT community: [discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

The second distinct donor site on one connected ligand carrier is the first successor that closes a path through the retained coordination centre. One site gives an open topology; two sites give a three-trace closed path; every later admitted site preserves the previous donor and internal-path records and increases denticity by exactly one. Coordination number is the positive cardinality of the complete distinct central-incidence word, and its successor retains the entire previous word. Equal chemical group labels never merge distinct occurrences. Three exhaustive eight-axis grammars each contain 256 candidates and admit a unique survivor. The complete original external vectors retain twenty coordination-entity records, twenty-three coordination-number records and twenty-four denticity/chelation records. Native Lean proofs preserve the constructors, identity records, arbitrary finite successors, source decisions and complete validation protocols. Thirty direct native modules carry 440 distinct empty-axiom audited declarations. This paper derives the counting and first-closure results, states their exact carriers and constructions, and retains the original source comparisons and controls.

## 1. First closure from a second donor site

Fix one ligand carrier occurrence \(L\), one ligand-group identity \(g\) and one central occurrence \(M\). The original connected donor topology retains three ordered words:

\[
 D_n=[d_1,\ldots,d_n],\qquad A_n=[a_1,\ldots,a_n],
\]
\[
 I_n=[i_1,\ldots,i_{n-1}],\qquad n>0.
\]

The donor occurrences \(d_j\) are distinct. Each \(a_j\) is its distinct positive central attachment trace. Each \(i_j\) is a distinct positive internal ligand-path trace between successive donor positions. Their source label families are respectively `coordination-ligand-occurrence`, `positive-coordination-incidence` and `positive-ligand-internal-incidence`. The constructor requires precisely \(n\) attachment traces and \(n-1\) internal traces, retaining the complete gap-free internal path. Carrier, group and centre have their own checked label families [4].

Each binding triple \((d_j,g,a_j)\) must belong to the complete coordination entity, and the topology's central occurrence must equal the entity's central occurrence. Thus the construction keeps the same ligand, actual donor occurrences, their attachments and the centre together. It does not identify two ligand carriers merely because they share a chemical group name.

The source returns the eight-field record

\[
 R_n=(L,M,n,D_n,A_n,I_n,s_n,C_n),
\]

where \(n\) is an exact positive count, \(s_n\) is the topology state and the closed trace is

\[
 C_n=\begin{cases}
 [],&n=1,\\
 [a_1]\mathbin{+\!+}I_n\mathbin{+\!+}[a_n],&n\ge2.
 \end{cases}
\]

**Theorem 1 (first chelate closure).** For every admitted complete donor topology, the closed trace is empty exactly when \(n=1\). The first nonempty closed trace occurs at \(n=2\), and has length three. For every \(n\ge2\),

\[
 |C_n|=1+(n-1)+1=n+1.
\]

For one donor, there is one centre attachment and no internal donor-to-donor path: \(I_1=[]\), so the returned topology is open. At the next donor, the new internal trace joins the retained first site to the second. The first attachment, that internal connection and the second attachment give

\[
 M\xrightarrow{a_1}d_1\xrightarrow{i_1}d_2\xrightarrow{a_2}M.
\]

The arrows display traversal of the retained incidence traces. The path returns to the same centre. There is no earlier positive donor count between one and two. For further donors, the complete internal path joins the first donor to the new last donor; the first and last central attachments close it again.

In `SFT.Chemistry.LigandDenticityDerivation`, `retainedRecord` proves the returned carrier, centre, positive denticity and all three words for every successful original operation. `closedTraceEmptyExactlyAtOne` unfolds that operation. Failed centre, binding or positive-count branches cannot yield an accepted record. In the single-donor branch the trace is definitionally empty; in every larger branch its first attachment makes it nonempty. This is the native proof of the first-closure dichotomy [7].

## 2. The complete coordination entity

An attachment row is

\[
 r_j=(j,M,d_j,g_j,a_j),\qquad j>0.
\]

A complete entity \(E\) retains its entity identity, central element identity, central occurrence and the full ordered row list \([r_1,\ldots,r_N]\). Its constructor requires \(N>0\), source occurrences exactly \([1,\ldots,N]\), the same central occurrence in every row, distinct ligand occurrences and distinct positive incidence traces. Every occurrence is retained even when several \(g_j\) are equal.

The forced identity record projects the complete row list into three ordered words: ligand occurrences, ligand group identities and attachment traces. It also retains all three entity/central identifiers. For any projection \(f\) and next attachment \(r\),

\[
 \operatorname{take}_{|R|}\bigl(\operatorname{map}f(R\mathbin{+\!+}[r])\bigr)
 =\operatorname{map}f(R).
\]

Proof proceeds by induction on \(R\). At the empty list, taking zero elements returns the empty projection. At \(R=x::R'\), both sides begin with \(f(x)\); the tails agree by the induction hypothesis. The equation holds for each of the three projections, so no prior occurrence, group or attachment disappears.

The original successor must have source occurrence \(N+1\) and the same central occurrence. Reconstruction passes through the complete entity constructor, retaining its distinctness and sequence checks. `CoordinationEntityDerivation.constructedIdentity` proves that successful reconstruction returns exactly its supplied identifiers and rows. `appendedEntity` identifies the reconstructed row list as the old list followed by the successor. Applying the projection induction gives `entirePriorIdentityRetained`, including all identifiers and all three prior word prefixes [6].

## 3. Coordination number and denticity

For an admitted entity, define its complete trace word

\[
 \tau(E)=[a_1,\ldots,a_N].
\]

Every trace is distinct and positive. The original coordination-number record is

\[
 (\operatorname{id}(E),M,\operatorname{CN}(E),\tau(E)),
 \qquad \operatorname{CN}(E)=|\tau(E)|=N>0.
\]

`CoordinationNumber.forcedNumberExact` proves these four returned fields for every accepted call. It unfolds distinctness and the positive-count constructor; the empty branch cannot produce a positive-count record. For an admitted successor,

\[
 \tau(E')=\tau(E)\mathbin{+\!+}[a_{N+1}],
\]
\[
 \operatorname{CN}(E')=\operatorname{CN}(E)+1,\qquad
 \operatorname{take}_{N}\tau(E')=\tau(E).
\]

The length proof is induction on the original row list: the empty case contributes one appended trace, and each retained head increments both lengths. The prefix proof is the projection induction in Section 2. `CoordinationNumberDerivation.successorCountAndPrefix` combines these with exact successful construction. These equations hold for arbitrary finite admitted support, including repeated group labels.

Denticity instead counts the complete distinct donor incidences of a specified ligand carrier at that same centre:

\[
 \operatorname{dent}(L,M)=|D_n|=n.
\]

The membership check compares the exact triples \((d_j,g,a_j)\) against the complete entity bindings. It rejects a donor binding outside the entity, a changed centre, or collapsed binding support. Counting all entity traces gives coordination number; counting the retained connected donor support of one ligand carrier gives its denticity. A pair of separate one-site carriers remains two one-site topologies. A connected two-site carrier has denticity two and the first closed trace of Theorem 1.

For the next admitted donor, the original operation appends one cell to each word:

\[
 D_{n+1}=D_n\mathbin{+\!+}[d],\quad
 A_{n+1}=A_n\mathbin{+\!+}[a],\quad
 I_{n+1}=I_n\mathbin{+\!+}[i].
\]

It retains \(L,g,M\), checks the extended topology and requires its bindings to belong to the same supplied complete entity. Successful before/after records therefore satisfy

\[
 \operatorname{dent}_{n+1}=\operatorname{dent}_n+1,
\]
\[
 \operatorname{take}_{n}D_{n+1}=D_n,\qquad
 \operatorname{take}_{n}A_{n+1}=A_n,\qquad
 \operatorname{take}_{n-1}I_{n+1}=I_n.
\]

`LigandDenticityDerivation.successorPreservesAndIncrements` substitutes the two exact returned-record equations, then proves the length increment and three prefixes by list induction. The hypotheses are the original accepted before/after operations. For \(n\ge2\), all old path records remain and \(n+1\ge2\), so the resulting topology is again closed. The returned closed trace uses the first and new last attachment with the extended internal path; the full attachment word still retains every previous attachment. This gives arbitrary finite successor closure without replacing the original output record.

## 4. Complete grammar classification

Each original source grammar is the product of eight binary alternatives. The source generates all \(2^8=256\) combinations, preserving the original order. The entity axes are carrier, role, identity, attachment, composition, absence, observation and extension. Their admitted alternatives retain the complete entity, incidence-forced central/surrounding roles, every occurrence, positive attachment traces, gap-free support, structural absence, the twenty-record value-free seal and the whole prior entity under extension. The rejected alternatives use only names, imported roles, merged occurrences, proximity alone, selected support, numerical vacancy, pre-seal observations or replacement of prior identity.

The coordination-number axes are carrier, membership, quantity, identity, absence, observation, boundary and extension. Their admitted alternatives retain an admitted entity, all direct central incidences, exact generated cardinality, distinct occurrences counted once, structural absence, the twenty-three-record value-free seal, the original direct inorganic-incidence meaning and an append-one successor. The rejected alternatives use only a formula or name, selected neighbours, a count table, merged labels, numerical vacancy, exposed observed counts, mixed coordination senses or replacement of support.

The denticity alternatives are:

| Axis | Rejected alternative | Admitted alternative |
|---|---|---|
| Carrier | Chemical label alone | One retained ligand carrier occurrence |
| Membership | Selected or nearby sites | Every distinct donor site on that carrier |
| Centre | Sites across centres merged | Same retained central occurrence |
| Quantity | Imported name or table | Positive generated donor-incidence count |
| Chelation | Imported numerical threshold | First closed carrier–centre path |
| Boundary | Eta, kappa and separate sites collapsed | Attachment topologies distinguished |
| Observation | Topologies visible before seal | Complete twenty-four-record identity seal |
| Extension | Recount or replacement | Every prior site retained, one site added |

For each grammar let \(c=(c_1,\ldots,c_8)\), where each coordinate is its rejected or admitted constructor. Every coordinate belongs to the two-element list that generates it. Repeated product-list membership therefore proves every candidate occurs in the census. The native `candidatesComplete` and `generatedCardinality` declarations give completeness and cardinality.

For coordinate \(j\), its original criterion \(A_j\) is true exactly on the admitted constructor. The source decision is proved equal to

\[
 D(c)=\bigwedge_{j=1}^{8}A_j(c_j).
\]

If \(D(c)\) is true, every coordinate is admitted, so \(c\) equals the all-admitted survivor. Conversely that survivor satisfies every criterion. Thus

\[
 D(c)=\mathrm{true}\quad\Longleftrightarrow\quad c=c_*.
\]

A rejected coordinate contradicts the corresponding field of \(c_*\). The native `sourceDecisionMatchesCriteria`, `uniqueCriteriaSurvivor`, `uniqueSurvivor` and `acceptanceIffExactCriteria` results retain this argument in the three grammar modules. The source-specific candidate/decision programs reproduce all 256 rows per grammar. The arbitrary-length identity, count and topology successor proofs supply the associated closure arguments.

## 5. Complete observation vectors and attachment distinctions

The three original validations retain all registered external records:

| Source entry | IUPAC records | NIST CCCBDB records | Total records | Protocol messages |
|---|---:|---:|---:|---:|
| Coordination entity | 3 | 17 | 20 | 26 |
| Coordination number | 5 | 18 | 23 | 29 |
| Denticity and chelation | 24 | 0 | 24 | 30 |

The coordination-number source compares the complete direct-link vector for scandium trifluoride, titanium tetrachloride and iron pentacarbonyl. Generated support at the corresponding sizes gives

\[
 (\operatorname{CN}(E_3),\operatorname{CN}(E_4),\operatorname{CN}(E_5))=(3,4,5).
\]

The complete twenty-three-record vector retains the source's general, inorganic sigma-link and crystal meanings separately. The count follows from the distinct incidence word before the observed records are opened.

The chelation vector contains four retained surfaces for each of six IUPAC terms: binding site, chelation, denticity, eta, kappa and ligands [8]. It keeps definitions, examples and exclusions together with the source status and provenance. The original chelation example uses both nitrogen donors of ethylenediamine at one copper centre. The single-site exclusions retain coordinated ethene, the cyclopentadienyl group and benzene as their source describes them. Multiple atoms participating in a single binding site are therefore kept distinct from multiple separate donor sites. Kappa records single-atom attachment information; eta records multi-atom pi attachment. The inorganic and biochemical uses of “ligand” retain their original central-entity meanings.

The identity registry seals twenty-four value-free identities before these surfaces open. Every identity carries an ordinal, authority, source-document identity, term role and record role; it excludes the withheld definitions, classifications, formulae, values and target hashes. The prediction gives each identity its three structural law labels. After sealing, each row must satisfy

\[
 p_j=\text{identity-match}_j\land\text{law-match}_j
       \land\text{released-payload-hash-match}_j.
\]

The final decision takes all twenty-four row predicates, the complete original analysis and six controls. The controls reject an omitted source record and a changed central occurrence, retain distinct equal-group carrier occurrences, reject numerical zero as a Fold word, require the complete released vector and exclude the withheld target hash from the prediction. The fifteen-field analysis reconstructs one-site openness, the two-site three-trace closure and the next-site successor, alongside the original source distinctions. Its conjunction preserves the original Python return values. The full native validation matches all twelve empirical receipt fields, thirty messages and original hashes [7]. The entity and coordination-number validations likewise retain their complete twelve-field receipts and original control vectors [6].

## 6. Source correspondence and reproduction

The completed registrations are `SFT-CHEM-COORDINATION-ENTITY-RETAINED-IDENTITY-001`, `SFT-CHEM-COORDINATION-NUMBER-INCIDENCE-COUNT-002` and `SFT-CHEM-LIGAND-DENTICITY-CHELATION-TOPOLOGY-003`. Completion receipts TURN1137, TURN1145 and TURN1158 retain ten direct modules each, with 152, 141 and 147 distinct audited declarations respectively. All 440 declarations have retained empty-axiom audit output. Full original candidate programs, independent adverse cases and empirical comparisons accompany the proofs.

The entity and coordination-number modules are pinned to V4 edition 0.4 [6]. The completed ligand translation is pinned to the later public checkpoint [7]. The source archive contains 492 native files with their imports, eighty-nine pinned V3 files, complete declaration names, receipt-bound file digests and original source-comparison records. `SOURCE_CORRESPONDENCE.json` identifies the applicable source pin for each entry.

After extracting `SOURCE_AND_EVIDENCE.zip`, run `python3 reproduction/check_paper_arithmetic.py`. This executes the original constructors and operations at widths one through sixty-four, checks sixty-three successors for each of the three operations, exercises eleven original constructor/membership rejection cases, checks thirty source-file authorities, retains all sixty-seven observation records and executes all fifteen fields of the original chelation analysis. The portable checks reproduce the constructions and observations; the supplied native induction proofs establish the arbitrary finite successor statements.

## References

[1] Maria Smith. SFT V3 foundation. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).

[2] Maria Smith. SFT exhaustive monograph. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[3] Maria Smith. SFT V4 Lean verified corpus, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Contact-enriched edition: [doi:10.5281/zenodo.24337358](https://doi.org/10.5281/zenodo.24337358).

[4] Maria Smith. Original ligand denticity and chelation derivation. V3 commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`; `sft/chemistry/ligand_denticity_chelation_law_v1.py`, corresponding batch and validation, and the registered `WHY_DERIVATION_CHECK.md`. Verbatim sources accompany this paper.

[5] Maria Smith. Original coordination entity and number laws. At the pin in [4]: `sft/chemistry/coordination_entity_law_v1.py`, `coordination_number_law_v1.py`, and corresponding batch, validation and registration files. Complete source files and dependencies accompany this paper.

[6] Maria Smith. [V4 edition 0.4 native source](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3), commit `21cdf559922fb057f8560f42d056ffa035329eb3`. Native coordination entity/number definitions, derivations, grammars and validation; TURN1137 and TURN1145 completion evidence.

[7] Maria Smith. [Completed ligand denticity source and evidence](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/1094bbe9bcef75a8f32afbb394bdae16255facd0), commit `1094bbe9bcef75a8f32afbb394bdae16255facd0`. Native `SFT.Chemistry.LigandDenticity` family; `TURN1158_LIGAND_COMPLETION.json`.

[8] IUPAC Gold Book. [Binding site](https://doi.org/10.1351/goldbook.B00649), [chelation](https://doi.org/10.1351/goldbook.C01012), [denticity](https://doi.org/10.1351/goldbook.D01594), [eta](https://doi.org/10.1351/goldbook.H01881), [kappa](https://doi.org/10.1351/goldbook.K03366) and [ligands](https://doi.org/10.1351/goldbook.L03518). The six pinned source files, all twenty-four retained surfaces and original term attribution/licence records are included in the evidence archive.

<p align="center">
  <img src="docs/assets/sft-banner.svg" alt="SFT — Structure comes first. The V3 model. Formalised in Lean. One-to-one." width="100%" />
</p>

<p align="center">
  <a href="#the-model">The model</a> ·
  <a href="#proof-status">Proof status</a> ·
  <a href="ZENODO_PAPER_DRAFT.txt">Read the paper</a> ·
  <a href="#run-the-proofs">Run the proofs</a> ·
  <a href="TIMELINE.txt">Timeline</a>
</p>

<p align="center">
  <img alt="Lean 4.35.0" src="https://img.shields.io/badge/Lean-4.35.0-163747?style=flat-square&amp;labelColor=0b1825" />
  <img alt="4,137 audited results" src="https://img.shields.io/badge/Audited_results-4,137-163747?style=flat-square&amp;labelColor=0b1825" />
  <img alt="0 axiom dependencies in audited results" src="https://img.shields.io/badge/Axiom_dependencies-0-147d72?style=flat-square&amp;labelColor=0b1825" />
  <img alt="Full formalisation in progress" src="https://img.shields.io/badge/Full_formalisation-In_progress-b89143?style=flat-square&amp;labelColor=0b1825" />
</p>

# One model. Every derivation. Machine-checked.

**SFT v4 is the native Lean formalisation of Maria Smith’s Smithian Fold Theory v3.** The task is exact: carry the existing model into Lean, preserving its definitions, constraints, dependency order and derivations across all **2,781 registered entries**.

The governing requirement is **1:1 correspondence with v3**. Each scientific declaration is tied to its source. Each completed proof is audited for axiom dependencies. The entire model is the verification target.

## The model

SFT presents a structural unified theory of everything: gravity, particles and physical constants derived from first principles, with zero added axioms and zero free scientific parameters. This repository is the formal verification programme for that existing model.

Its foundation begins with an operational distinction: absence presents no counterexample; a presented challenge supplies an occurrence. The source then develops structural One and exact positive finite count, followed by Part, Fold and the downstream model.

```mermaid
flowchart LR
    R["Root<br/>There Is No Nothing"] --> O["One<br/>Structural self-wholeness"]
    O --> C["Count<br/>Exact positive finite count"]
    O --> P["Part"]
    C --> P
    P -. "continued source dependency order" .-> D["Fold and downstream model"]
    style R fill:#102d39,stroke:#69dec5,color:#f4fbff
    style O fill:#102d39,stroke:#69dec5,color:#f4fbff
    style C fill:#102d39,stroke:#69dec5,color:#f4fbff
    style P fill:#172333,stroke:#718796,color:#d3dfe6
    style D fill:#172333,stroke:#718796,color:#d3dfe6
```

## Proof status

Entry completion means the entry’s actual pinned V3 content is formalised and its applicable checks pass. Entries are completed in registered dependency order. Missing work must identify a specific V3 source component; general host-library or unrelated platform tasks do not hold a scientific entry open.

**4,137 proofs completed · 30,310 candidate records matched · 70 model entries complete · Fold Reduction and Completeness Law complete.**

| Progress measure | Current result |
| :--- | :--- |
| Lean theorems proved | **4,137**, all with zero axiom dependencies |
| Definitions and theorems audited | **8,690**, all with zero axiom dependencies |
| Candidate records matched to v3 | **30,310 / 30,310** across70 represented source entries |
| Complete model entries | **70 / 2,781** — [latest completion evidence](verification/TURN_219_REDUCTION_COMPLETENESS_COMPLETION.json) |

| Source component | Verified work | Evidence |
| :--- | :--- | :--- |
| **Root — complete** | All pinned Root source functions and program methods mapped; general record derivation, exact enumeration, closure and controls verified | [Completion evidence](verification/TURN_111_ROOT_COMPLETION.json) · [Fresh output checks](verification/TURN_111_ROOT_EVIDENCE_REPORT.json) |
| **One — complete** | General record derivation, full grammar, closure, controls and all program methods | [Completion evidence](verification/TURN_112_ONE_COMPLETION.json) |
| **Count — complete** | General finite-trace derivation, full grammar, closure, controls and all program methods | [Completion evidence](verification/TURN_112_COUNT_COMPLETION.json) |
| **Part — complete** | General held/whole coordinate derivation, full192 grammar, original closure/controls and all program methods | [Completion evidence](verification/TURN_113_PART_COMPLETION.json) |
| **Part Equivalence — complete** | General common-refinement/pairing derivations, full1024 grammar, original controls and complete source program | [Completion evidence](verification/TURN_116_PART_EQUIVALENCE_COMPLETION.json) |
| **Fold — complete** | Minimal-stage derivation, full288 grammar, original closure/controls and all source program methods | [Completion evidence](verification/TURN_114_FOLD_COMPLETION.json) |
| **Fold assembly — complete** | General support, transition, return and proposal proofs; full192 program matches V3 | [Completion evidence](verification/TURN_115_ASSEMBLY_COMPLETION.json) |
| **Exact operations** | Canonical Fraction reduction, exact value preservation, positive-domain guards, normalized cast/Fold/Take, exact unison and Fold-fixed One; complete 128-form grammar and source controls | [Operations](SFT/Foundation/ExactOperations.lean) · [Reduction proofs](SFT/Foundation/FractionReduction.lean) |
| **Half-One** | Complete first-Fold selection classes, label-exchange invariance, unique self-junction coordinate, self-complementarity and Fold-to-One; all 128 source candidates and four controls | [Derivation](SFT/Foundation/HalfOneDerivation.lean) |
| **Fold dynamics** | Exactly two preimages for every admitted image, with arbitrary-preimage exhaustion; full-domain phase laws, exact sorted output and executable uniformity for every even division and minimal two-cycle | [Derivation](SFT/Foundation/FoldDynamics.lean) |
| **Form Grammar — complete** | Complete 288-candidate enumeration, unique survivor, nine rejection rules and original controls | [Grammar](SFT/Foundation/FormGrammar.lean) |
| **Exact trace arithmetic** | General flattened-product associativity, complete pair-cell cardinality, exact pairing and held remainder | [Derivation](SFT/Mathematics/ExactTraceArithmetic.lean) |
| **Measured-value boundary** | Exact Boolean protocol conditions, complete 256-candidate product and original controls | [Derivation](SFT/Foundation/MeasurementProtocol.lean) |
| **Form identity — complete** | Canonical trace injectivity and equivalence for every generated Form; complete 192-candidate identity grammar | [Derivation](SFT/Foundation/FormIdentity.lean) |
| **Form construction** | Exact finite productions, injective tuple encoding and acceptance of every generated form by the tuple/list/string validator | [Derivation](SFT/Foundation/FormConstruction.lean) |
| **Source correspondence** | All 30,310 candidate records preserve source order, identifiers, exact forms, decisions and reasons; Root census, closure, decisions and all four control records match stored fields and hashes | [Correspondence map](reference/CORRESPONDENCE.json) · [Parity report](verification/TURN_219_PARITY_REPORT.json) |

**Completed source entries: 70 / 2,781.** 70 source entries are complete; 2,711 census entries remain pending. Each completed entry has a source-component completion record. Concrete remaining gaps are tracked in COVERAGE.json.

[Read the current axiom audit →](verification/TURN_219_BUILD.log) · [Inspect complete coverage →](COVERAGE.json) · [Root evidence/hash checks →](verification/TURN_013_EVIDENCE_REPORT.json) · [All 8,690 axiom audits →](verification/TURN_219_ALL_DECLARATIONS_AUDIT.log)

The translated forcing gate checks ordered identifiers, exactly one survivor, explicit reasons and canonical proof-hash identities. A general theorem proves that passing requires one survivor; Root’s tampered decisions are formally rejected. [Gate proofs](SFT/Engine/DecisionGate.lean) · [Root integration](SFT/Foundation/RootGate.lean) · [384-case comparison](verification/TURN_009_DECISION_GATE_REPORT.json)

The closure and control gates now retain their source field checks and error order. Native proofs establish required passing properties and reject Root evidence with missing minimality, missing generality certification or failed control flags. [Evidence-gate proofs](SFT/Engine/EvidenceGates.lean) · [432 closure and 576 control cases](verification/TURN_010_EVIDENCE_GATES_REPORT.json)

The census gate preserves signed cardinalities, candidate identity checks and source error order. Native proofs establish positive-cardinality witnesses and reject Root censuses with incorrect counts or duplicate candidates. [Census gate](SFT/Engine/CensusGate.lean) · [1,440-case comparison](verification/TURN_011_CENSUS_GATE_REPORT.json)

The Root record-level derivation now quantifies over all records with the source fields. It proves exact presentation classification, agreement of classification and acceptance, exclusion of unpresented records, and independence from identifier and descriptive text. Generated records connect directly to the emitted evidence. [Root derivation proofs](SFT/Foundation/RootDerivation.lean)

One’s record-level derivation proves that complete coverage without addition is necessary and sufficient for acceptance. Omission, fragmentation and unforced addition are rejected for every source-schema record. [One derivation proofs](SFT/Foundation/OneDerivation.lean)

Count’s finite-generation proof now establishes complete exact-once retention at every extension, freshness of the new terminal, rejection of repetition and deletion, and unique identity under the source base/successor clauses. [Count trace derivation](SFT/Foundation/CountTrace.lean)

Count’s proposal theorem derives the ten-class decision from actual retained positions: acceptance is equivalent to complete coverage, no duplication and no ungenerated occurrence. [Semantic bridge](SFT/Foundation/CountRepresentation.lean) · [493-proposal correspondence](verification/TURN_016_COUNT_REPRESENTATION_REPORT.json)

## Exact correspondence, from the root

| Commitment | How it is recorded |
| :--- | :--- |
| **Preserve the model** | Scientific declarations map to identified v3 source components. |
| **Preserve the constraints** | No added axioms, unfinished proofs or free scientific parameters. Audits report actual dependencies. |
| **Follow dependencies** | Complete the source foundation in order before advancing into dependent claims. |
| **Keep the evidence visible** | Proof logs, source comparisons and granular coverage accompany checkpoints. |
| **Keep a complete record** | The chronological timeline records work; the manuscript presents the science. |

The source is pinned to v3 commit [`76f1b34`](https://github.com/MettaMazza/ernos-labs-sft-platform/tree/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1). The [source inventory](reference/V3_TRACKED_FILES.tsv) records 39,278 tracked paths.

## Run the proofs

With Lean’s `elan` toolchain manager installed:

```sh
git clone https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED.git
cd SFT-v4-LEAN-VERIFIED
lake build
lake env lean Audit.lean
```

The project pins Lean **4.35.0**. Emit the translated records with:

```sh
lake env lean --run Parity.lean
lake env lean --run RootParity.lean
```

Every verification run rebuilds current Lean code, generates a fresh declaration audit and executes the current parity program. Committed TSVs and logs are historical evidence, never the verification input.

```sh
SFT_V3_SOURCE=/path/to/pinned/v3 python3 verification/check_current_parity.py
SFT_V3_SOURCE=/path/to/pinned/v3 python3 verification/check_root_evidence.py
SFT_V3_SOURCE=/path/to/pinned/v3 python3 verification/check_decision_gate.py
SFT_V3_SOURCE=/path/to/pinned/v3 python3 verification/check_evidence_gates.py
SFT_V3_SOURCE=/path/to/pinned/v3 python3 verification/check_census_gate.py
SFT_V3_SOURCE=/path/to/pinned/v3 python3 verification/check_registration_gate.py
SFT_V3_SOURCE=/path/to/pinned/v3 python3 verification/check_count_representation.py
```

The scripts read pinned v3 source and artifacts without importing or executing v3 scientific modules. `SFT_V3_SOURCE` overrides the local path in `reference/SOURCE.json`. [GitHub Actions](.github/workflows/verify.yml) performs these checks on pushes and pull requests using the pinned source commit and Lean toolchain.

## Explore the work

| | |
| :--- | :--- |
| **[Scientific manuscript](ZENODO_PAPER_DRAFT.txt)** | The accompanying Zenodo paper draft. Unpublished. |
| **[Chronological timeline](TIMELINE.txt)** | Exact steps, checks, outcomes and continuation points. |
| **[Full coverage ledger](COVERAGE.json)** | Every registered entry, original statement and tracked status. |
| **[Proof audit](Audit.lean)** | The exported results and their Lean axiom checks. |
| **[Original SFT v3](https://github.com/MettaMazza/ernos-labs-sft-platform)** | The source model being formalised. |

---

<p align="center"><strong>Smithian Fold Theory · Maria Smith</strong><br/><sub>V3 is the source. Lean is the proof language. Exact correspondence is the requirement.</sub></p>

Batch review: [all 21 existing entries](verification/TURN_114_BATCH_EXISTING_WORK.json). Run `python3 verification/batch_existing_work.py` for the existing global build/audit/parity and exact missing-method inventory. Interface presence alone does not establish derivation completion.

Retained full-program verification covers **70 / 70 implemented programs** and **30,310 actual lookup decisions**, including complete registration/census/closure/control/hash outputs. The original [batch source review](verification/TURN_115_SOURCE_REVIEW.json) is reconciled by the subsequent completion records; all identified gaps are closed in the [final six-entry report](verification/TURN_119_BATCH_COMPLETION.json). Run `ulimit -s 65520` and then `python3 verification/batch_program_outputs.py` to reproduce all70 comparisons.

Part Equivalence checkpoint: all **1,024** fresh native lookup decisions and complete source program outputs match pinned V3. [Program comparison](verification/TURN_116_PART_EQUIVALENCE_PROGRAM_REPORT.json).

Batch completion reconciliation: all **21** represented entries reviewed together, with **6** additional completions propagated through verified dependencies. Existing program results and the current full audit are retained. [Batch reconciliation](verification/TURN_118_BATCH_RECONCILIATION.json).

Final existing-work batch: **6 / 6 programs PASS**, **980 actual candidate decisions**, all original evidence fields and hashes matched. Measurement retains returned operands; Exact Operations and Half-One include their complete source program adapters. [Six-entry completion report](verification/TURN_119_BATCH_COMPLETION.json).

Geometry and Topology: four original operations translated with20 new native proofs, including incidence, shared-face adjacency, exact open-family closure, inverse-image continuity and finite generated joins/intersections. Boundary depth is now translated with a complete descent derivation proved equivalent to execution; path search is translated with returned-path soundness; general shortest-path minimality and unreachable-case equivalence are proved; the full1024-candidate source program now matches every pinned source output field. [Source-specific progress](verification/TURN_120_GEOMETRY_PROGRESS.json).

Boundary dimension: 15 additional native proofs, exact cycle rejection and both directions of complete face-depth derivation. [Verified source-specific results](verification/TURN_121_GEOMETRY_PROGRESS.json).

Path distance: exact ordered undirected search, constructive returned-path traces and literal edge-scan correspondence;19 additional native proofs. [Source-specific results](verification/TURN_122_GEOMETRY_PROGRESS.json).

General path results: returned paths have minimal length against every finite undirected trace; unreachable None is equivalent to absence of such a trace.20 additional axiom-free proofs. [Source-specific results](verification/TURN_123_GEOMETRY_PROGRESS.json).

Geometry and Topology is complete against its pinned V3 source: all six operations, native derivations, full1024 candidates, original witnesses/controls and program methods.  [Completion evidence](verification/TURN_124_GEOMETRY_COMPLETION.json).

Probability and Statistics: exact events, positive held/whole weights and common-refinement conditioning translated with25 new native proofs. [Source-specific progress](verification/TURN_125_PROBABILITY_PROGRESS.json).

Probability independence and exact modal summaries:31 additional native proofs,3185 independence cases and121 mode cases passed. [Source-specific progress](verification/TURN_126_PROBABILITY_PROGRESS.json).

Probability and Statistics is complete against pinned V3: six original operations, general native derivations, all512 candidates, exact witnesses/controls and every program output. [Completion evidence](verification/TURN_127_PROBABILITY_COMPLETION.json).

Optimization is complete against pinned V3: six operations, general native derivations, full512-candidate grammar, original witnesses/controls and exact program outputs. [Completion evidence](verification/TURN_128_OPTIMIZATION_COMPLETION.json).

Dynamical Systems: exact admission, trajectories, transition-count time, fixed forms, predecessor records and retained-record reversibility with15 new native proofs. [Source-specific progress](verification/TURN_129_DYNAMICS_PROGRESS.json).

Dynamical Systems is complete against pinned V3: eight operations, general trajectory/return/reachability derivations, all1024 candidates, seven witnesses and every source program output. [Completion evidence](verification/TURN_130_DYNAMICS_COMPLETION.json).

Logic and Proof is complete against pinned V3: original validated constructors, six operations, ordered proof-trace equivalence and relative soundness, full1024 grammar and exact program output. [Completion evidence](verification/TURN_131_LOGIC_COMPLETION.json).

Category, Type and Composition: native composition-trace association, exact validated arrow fields, type predicates, products and held sums are implemented. Twenty additional theorems and2,053 operational cases pass; identity erasure, transport/naturality and the original full grammar/program are now completed in the subsequent source review.

Category, Type and Composition is complete against pinned V3. [Source-component completion evidence](verification/TURN_133_CATEGORY_COMPLETION.json).

Symbol Distinction: original alphabet admission, complete observation validation, exact single-row lookup and distinguishability are implemented, with17 native proofs and2,016 passing input cases. Observation classes, pair ledgers and the512 grammar/program are completed in the subsequent source review.

Symbol Distinction is complete against pinned V3. [Source-component completion evidence](verification/TURN_135_SYMBOL_COMPLETION.json).

Encoding and Decoding: source validation, codeword classes, exact inverse construction and decoder lookup are implemented.21 native proofs include singleton-class equivalence and decoder left inverse;9,684 input cases pass. Loss ledger, composition, successor closure and complete1024 grammar/program are verified.

Encoding loss and composition add23 native proofs and7,553 passing input cases, including exact shared-class loss, guarded interface existence and complete composition provenance.

Encoding and Decoding is complete against pinned V3. [Source-component completion evidence](verification/TURN_138_ENCODING_COMPLETION.json).

Information Quantity: exact complete word support, ordered position successor and support composition with21 new native proofs and1,769 passing input cases. Pair/profile/position-trace execution and complete512 grammar/program are verified.

Information Quantity is complete against pinned V3. [Source-component completion evidence](verification/TURN_219_REDUCTION_COMPLETENESS_COMPLETION.json).

Entropy and Uncertainty: exact partition, structural empty-One uncertainty, class-ordered closed pairs and refinement/class-containment equivalence with22 new native proofs and7,781 passing input cases. Exact weighted ledger and pair monotonicity are verified; microstate successor and the complete512 program are verified.

Entropy exact weighted ledger and closed-pair monotonicity add23 native proofs and2,024 passing Fraction-based input cases.

Compression reconstruction and complete dictionary/token resource traces are verified, including general token-successor and redundancy provenance proofs;8,600 source-expression cases pass. Exact prefix parsing, the canonical-support pigeonhole derivation and complete1024 program are verified.

Channel admission, exact output supports, confusability and distinguishable-code predicates have native proofs and12,913 passing source-expression cases. Capacity enumeration and relational composition are verified; fresh-input successor and complete1024 program are verified.

Channel complete capacity families and exact relational composition add6,857 passing comparisons. Native proofs retain every greatest tie and every source-to-interface-to-target path, with source first-occurrence ordering and no restored merged distinction.

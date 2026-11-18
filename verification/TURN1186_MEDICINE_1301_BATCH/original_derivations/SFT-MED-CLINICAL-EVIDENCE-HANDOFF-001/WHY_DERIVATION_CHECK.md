# Clinical evidence handoff

Claim: `SFT-MED-CLINICAL-EVIDENCE-HANDOFF-001`

## WHY

A medical claim may cross to a reviewer only with reconstructible derivation, data provenance, code, adverse/null/unresolved rows, privacy boundary and custody record.

## DERIVATION

Dependencies: `SFT-FOUNDATION-FORM-ENFORCEMENT-001`, `SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001`, `SFT-MATH-EXACT-ARITHMETIC-001`, `SFT-MATH-DISCRETE-001`, `SFT-MATH-COMBINATORICS-001`, `SFT-MATH-ORDER-LATTICE-001`, `SFT-MATH-PROBABILITY-STATISTICS-001`, `SFT-MATH-LOGIC-PROOF-001`, `SFT-INFO-SYMBOL-DISTINCTION-001`, `SFT-INFO-MUTUAL-CONDITIONAL-001`, `SFT-INFO-ENTROPY-UNCERTAINTY-001`, `SFT-COMP-SEM-SPECIFICATION-001`, `SFT-COMP-SEM-VERIFICATION-001`, `SFT-COMP-DIST-CAUSALITY-001`, `SFT-COMP-SCI-COMPUTATIONAL-STATISTICS-001`, `SFT-PHYS-MEAS-OBSERVATION-CARRIER-001`, `SFT-PHYS-MEAS-UNCERTAINTY-001`, `SFT-CHEM-MEAS-CHEMICAL-SPECIES-001`, `SFT-CHEM-MEAS-UNCERTAINTY-001`, `SFT-CHEM-STEREO-ENANTIOMER-001`, `SFT-MAT-MEAS-TRACEABILITY-001`, `SFT-MAT-FUNC-BIOMATERIAL-001`, `SFT-BIO-ORGANISM-001`, `SFT-BIO-PHYSIOLOGY-001`, `SFT-BIO-HOMEOSTASIS-001`, `SFT-BIO-POPULATION-001`, `SFT-BIO-BIO-CONDITION-001`, `SFT-BIO-BIO-ASSAY-001`, `SFT-BIO-BIO-UNCERTAINTY-001`, `SFT-BIO-BIO-CAUSALITY-001`, `SFT-MED-CLINICAL-EQUIPOISE-001`

Boundary: Exactly eight binary dimensions and therefore 256 forms; closure is conditional only on this explicit complete grammar.

Generation: Generate the Cartesian product of all registered binary preservation dimensions before opening any clinical source or outcome.

The literal eight-axis product contains 256 forms:

- `carrier` — reject `carrier-erased-aggregate-or-answer-only`: Erasing the patient, population, specimen or evidence carrier prevents clinical reconstruction. Admit `consented-deidentified-evidence-record`: The complete generated clinical carrier is retained.
- `relation` — reject `relation-imported-fitted-or-erased`: An imported, fitted or absent relation can manufacture a familiar medical answer. Admit `claim-to-reviewer-reconstruction`: Only the generated transition or comparison relation is admitted.
- `organization` — reject `organization-collapsed`: Collapsing person, arm, outcome, time or evidence organization merges clinically distinct states. Admit `derivation-data-code-adverse-results`: Every required clinical organization distinction remains held.
- `observation` — reject `observation-boundary-unrecorded`: An unrecorded population, method, setting, interval or assessor cannot identify the observation class. Admit `purpose-access-version-and-custody`: The complete declared observation boundary is retained and cannot select the law.
- `record` — reject `favorable-result-without-complete-record`: A favorable label without protocol, transitions, missingness, adverse outcomes and controls is not auditable. Admit `complete-protocol-state-transition-adverse-null-record`: Initial state, transitions, protocol deviations, adverse, null, unresolved and missing rows are recorded.
- `provenance` — reject `authority-consensus-prior-or-target-selected-law`: Authority, consensus, prior SFT work or target outcomes may test but cannot select the Fold law. Admit `root-bound-forward-forcing`: Every decision traces through admitted dependencies to There Is No Nothing.
- `generality` — reject `single-patient-favorable-study`: One favorable patient, trial, population or analysis cannot close the generated clinical class. Admit `positive-finite-successor-and-unfavorable-closure`: The base carrier, every supplied positive finite successor and all registered unfavorable controls preserve the relation at its stated boundary.
- `extension` — reject `free-fit-exception-opaque-model-or-extra-rule`: A free coefficient, fitted cutoff, hidden exclusion, opaque model or exception can manufacture a desired answer. Admit `no-extra-rule`: No rule beyond admitted Fold dependencies and generated preservation conditions is present.

Exactly one form preserves every registered coordinate:

`consented-deidentified-evidence-record__claim-to-reviewer-reconstruction__derivation-data-code-adverse-results__purpose-access-version-and-custody__complete-protocol-state-transition-adverse-null-record__root-bound-forward-forcing__positive-finite-successor-and-unfavorable-closure__no-extra-rule`

Base: The least positive finite clinical carrier retains every required identity, relation, boundary, outcome and proof record.

Successor: Adding one lawful finite successor preserves all earlier persons, arms, outcomes, times, adverse and missing distinctions and appends the new trace.

## CHECK

All 72 Medicine predictions and 18,432 candidate forms were sealed before source selection. The capability-closed prediction process cannot read a filesystem, network, clock, environment or target. A distinct post-seal custodian opens every bound source, requires each claim-specific fragment, retains adverse, null, unresolved and failed rows, and compares the reconstructed held label exactly. A changed record must fail.

This claim closes a conditional clinical relation; it does not turn a patient-, population-, setting- or method-dependent magnitude into a universal constant.

External evidence tests the consequence and never selects the Fold grammar.

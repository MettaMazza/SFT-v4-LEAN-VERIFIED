"""Physical quantum laws forced from the admitted Fold computation model."""

from __future__ import annotations

from sft.physics.generated_empirical_law import EmpiricalPhysicsSpec, ExternalTargetRow, empirical_dimensions
from sft.physics.measured_value import (
    CODATA_SOURCE_HASH,
    CODATA_SOURCE_ID,
    CODATA_SOURCE_PATH,
    ExactMeasuredValueSpec,
    ExactRelationStep,
    MeasuredQuantity,
)


SOURCES = {
    "codata": (CODATA_SOURCE_ID, CODATA_SOURCE_PATH, CODATA_SOURCE_HASH),
    "asd": (
        "NIST-ASD-5.12",
        "experiments/external_sources/physics/snapshots/nist-asd-version-history.html",
        "sha256:a327a34eb1b85ef3f003e8c8f0dbcb0c3fc49f039ee4046546a924fc42118454",
    ),
    "pdg": (
        "PDG-2025-SUMMARY-TABLES",
        "experiments/external_sources/physics/snapshots/pdg-2025-summary-tables.html",
        "sha256:ae10b6a7c6fefb8a6d90d35dc341d3ae8284a1e3cf2c94c656ae2e8957df4d56",
    ),
    "cern": (
        "CERN-OPEN-DATA-DATASET-API-2026-07-23",
        "experiments/external_sources/physics/snapshots/cern-open-data-dataset-api.json",
        "sha256:4e232ef39985c02005828f97c43d903381411e7c0a762af768060343d17bd57d",
    ),
}

BASE = "SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001"


def quantum_law(
    claim_id: str,
    title: str,
    statement: str,
    relation: str,
    reason: str,
    result: str,
    label: str,
    prior: str,
    source_key: str,
    *locators: str,
) -> EmpiricalPhysicsSpec:
    source_id, source_path, source_hash = SOURCES[source_key]
    slug = claim_id.removeprefix("SFT-PHYS-QUANTUM-").removesuffix("-001")
    dependencies = (
        "SFT-INFO-QUANTUM-CORRESPONDENCE-001",
        "SFT-QUANTUM-INFORMATION-UNIT-001",
        "SFT-QUANTUM-STATE-COMPOSITION-001",
        "SFT-QUANTUM-MEASUREMENT-001",
        "SFT-PHYS-WAVE-INTERFERENCE-001",
        BASE,
    ) + (() if prior == BASE else (prior,))
    return EmpiricalPhysicsSpec(
        claim_id,
        title,
        statement,
        dependencies,
        "Generate the complete physical-support, composition, phase/action, observation, provenance, target-access, successor and extra-rule product.",
        "All finite physical quantum forms generated from exact Fold word support, held cyclic labels, reversible transitions, predecessor merging and observation records without imported amplitudes or stochastic collapse.",
        empirical_dimensions(relation, reason),
        result,
        "One physical Fold distinction occupies one generated support cell with its held state, phase/action and observation provenance.",
        "Adding one support cell or constituent preserves every prior word, phase/action, composition and observation record and appends its complete lawful branches.",
        (
            "ungenerated continuum, completed infinity or continuum wavefunction",
            "floating, irrational, imaginary or signed proof magnitude",
            "imported quantum postulate, fitted amplitude or stochastic oracle",
            "target access, omitted adverse outcome or unrecorded measurement setting",
        ),
        (
            ("finite-support", "Every state has complete positive generated word support.", len(("a", "b")) == 2),
            ("held-phase", "Cyclic action is retained as a held label rather than a signed or imaginary magnitude.", {"phase-a", "phase-b"} == {"phase-b", "phase-a"}),
        ),
        f"SFT-EXP-PHYS-QUANTUM-{slug}-001",
        label,
        tuple(ExternalTargetRow(f"{slug.lower()}-{n}", source_id, locator, label) for n, locator in enumerate(locators, 1)),
        source_path,
        source_hash,
        "The physical quantum law is falsified if a committed external row lacks its sealed support/composition/observation structure, a row is omitted, or the tampered row is accepted.",
    )


PHYSICAL_STATE = quantum_law(
    "SFT-PHYS-QUANTUM-PHYSICAL-STATE-001", "Physical quantum state correspondence",
    "A physical quantum state is the complete generated support of distinguishable Fold words together with held phase/action and preparation provenance; it is not an answer-only amplitude list.",
    "complete-word-support-with-held-phase", "Only complete support retains every possible physical predecessor, cyclic action and preparation record.",
    "The physical quantum state is complete finite Fold support with held phase/action and source-bound preparation trace.",
    "physical-quantum-support", BASE, "asd", "NIST ASD atomic energy-level holdings", "NIST ASD spectral-line transition support")

EVOLUTION = quantum_law(
    "SFT-PHYS-QUANTUM-EVOLUTION-001", "Reversible physical quantum evolution",
    "Closed physical quantum evolution is a one-to-one Fold transition on complete support; its held predecessor labels reconstruct every prior state exactly.",
    "bijective-complete-support-transition", "One-to-one transition is the unique form preserving all state distinctions, phase/action and probability support.",
    "Closed quantum evolution is exact reversible transition of the complete physical Fold support.",
    "reversible-physical-quantum-evolution", PHYSICAL_STATE.claim_id, "codata", "CODATA atomic unit of time and energy", "CODATA reduced Planck carrier")

OBSERVABLE = quantum_law(
    "SFT-PHYS-QUANTUM-OBSERVABLE-001", "Observable and measurement record",
    "A quantum observable is a generated partition of physical support into distinguishable record classes; measurement creates one retained source-bound record for the observed class.",
    "support-partition-to-retained-record", "The observation partition uniquely specifies what is distinguished and what remains unresolved while the retained record prevents unexplained erasure.",
    "A physical observable is an exact support partition and measurement is its provenance-retaining record transition.",
    "quantum-observable-record", EVOLUTION.claim_id, "asd", "NIST ASD observed-line classifications", "NIST ASD level and transition records")

WEIGHT = quantum_law(
    "SFT-PHYS-QUANTUM-WEIGHT-001", "Measurement weights from exact branch support",
    "The weight of a measurement record is the exact positive count of its phase-compatible predecessor fibre relative to complete generated predecessor support.",
    "compatible-predecessor-count-ratio", "Complete branch census gives the sole parameter-free weight and makes apparent randomness observer-relative rather than ontic.",
    "Quantum measurement weights are exact rational branch-support ratios over a complete deterministic census.",
    "exact-quantum-branch-weight", OBSERVABLE.claim_id, "asd", "NIST ASD transition-probability holdings", "NIST ASD line-intensity and branching records")

INCOMPATIBILITY = quantum_law(
    "SFT-PHYS-QUANTUM-INCOMPATIBILITY-001", "Incompatible observations and uncertainty",
    "Two observations are incompatible when their support partitions do not share a common refinement preserving both held phase/action records; resolving one necessarily closes distinctions needed by the other.",
    "noncommuting-observation-partition-refinement", "Failure of a record-preserving common refinement exactly identifies the uncertainty boundary without an imported irrational bound.",
    "Quantum incompatibility is absence of a joint record-preserving refinement of two generated observation partitions.",
    "quantum-observation-incompatibility", WEIGHT.claim_id, "asd", "NIST ASD angular-momentum selection holdings", "NIST ASD incompatible transition classifications")

SPIN = quantum_law(
    "SFT-PHYS-QUANTUM-SPIN-001", "Spin and finite cyclic label action",
    "Physical spin is the finite cyclic held-label action of a constituent under generated orientation recurrence; opposite readings are fibre labels, never signed proof magnitudes.",
    "finite-cyclic-orientation-action", "Cyclic label action retains recurrence, orientation and composition class while satisfying the positive exact domain.",
    "Spin is finite cyclic orientation action on a physical Fold constituent with exact held measurement labels.",
    "finite-cyclic-spin", INCOMPATIBILITY.claim_id, "pdg", "PDG particle spin columns", "PDG fermion and boson summary-table spin assignments")

INDISTINGUISHABILITY = quantum_law(
    "SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001", "Identical physical constituents",
    "Constituents are physically identical exactly when exchanging their unobserved identity labels preserves every complete observable transition and composition trace.",
    "constituent-exchange-observable-equivalence", "Complete trace equality quotients only labels with no observable distinction and retains every physical carrier.",
    "Identical quantum constituents are the exchange-equivalence class of complete physical Fold traces.",
    "quantum-constituent-indistinguishability", SPIN.claim_id, "pdg", "PDG repeated species property records", "PDG particle identity and quantum-number tables")

EXCLUSION = quantum_law(
    "SFT-PHYS-QUANTUM-EXCLUSION-001", "Exclusion from antisymmetric composition",
    "For the alternating held exchange class, two identical constituent labels cannot occupy the same one-constituent observation cell because exchange would erase the only distinguishing orientation trace.",
    "alternating-exchange-composition-exclusion", "Complete exchange provenance leaves no distinct doubled same-cell word in the alternating class, forcing exclusion structurally.",
    "Fermionic exclusion is absence of a distinct same-cell joint word under alternating held exchange composition.",
    "fold-exclusion-law", INDISTINGUISHABILITY.claim_id, "pdg", "PDG half-cycle-spin fermion tables", "PDG atomic-constituent and particle occupation classifications")

TUNNELLING = quantum_law(
    "SFT-PHYS-QUANTUM-TUNNELLING-001", "Barrier traversal on complete support",
    "Barrier traversal occurs when complete reversible support contains phase-compatible paths through generated barrier cells even though the corresponding coarse classical observation closes those paths.",
    "phase-compatible-barrier-path-support", "Complete support retains lawful internal paths that a coarse terminal-energy predicate alone would omit.",
    "Quantum tunnelling is observation of phase-compatible generated barrier paths present in complete support but absent from the coarse classical projection.",
    "quantum-barrier-traversal", EXCLUSION.claim_id, "asd", "NIST ASD metastable and forbidden-transition holdings", "NIST ASD transition-probability records")

DISCRETE_SPECTRA = quantum_law(
    "SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001", "Discrete bound-state spectra",
    "A bound physical support admits only recurrence classes whose phase/action closes exactly on the generated boundary; transition records are exact distinctions between such closed classes.",
    "boundary-closed-phase-recurrence", "Exact recurrence closure enumerates discrete classes without assuming a continuum eigenvalue equation.",
    "Bound-state spectra are the generated exact phase-recurrence classes closed on finite physical support.",
    "discrete-quantum-spectra", TUNNELLING.claim_id, "asd", "NIST ASD discrete atomic energy levels", "NIST ASD observed wavelengths between named levels")

ENTANGLEMENT = quantum_law(
    "SFT-PHYS-QUANTUM-ENTANGLEMENT-001", "Physical entanglement correlations",
    "A joint physical state is entangled when its complete word support cannot factor into independently prepared constituent supports while its joint preparation trace remains held.",
    "nonfactorable-joint-word-support", "Nonfactorability is the minimal exact compositional distinction producing joint correlations not determined by separate marginals.",
    "Physical entanglement is nonfactorable complete joint Fold support with common preparation provenance.",
    "physical-quantum-entanglement", DISCRETE_SPECTRA.claim_id, "cern", "CERN Open Data correlated multi-object event records", "CERN Open Data joint decay and reconstruction datasets")

BELL = quantum_law(
    "SFT-PHYS-QUANTUM-BELL-001", "Bell correlation and local-hidden-record boundary",
    "Bell correlations arise from joint generated support in which preparation and measurement-setting records belong to the complete deterministic state; a factorized local record omitting that dependence cannot reproduce the full joint census.",
    "setting-inclusive-joint-support-correlation", "Complete-state enumeration retains settings and common preparation while exposing exactly which factorization assumption fails, without permitting signalling.",
    "Bell correlation is exact setting-inclusive joint support; the excluded local-hidden-record model is the incomplete factorization that omits a generated dependence.",
    "bell-joint-support-boundary", ENTANGLEMENT.claim_id, "cern", "CERN Open Data joint angular-correlation records", "CERN Open Data complete event and detector provenance")

CONTEXTUALITY = quantum_law(
    "SFT-PHYS-QUANTUM-CONTEXTUALITY-001", "Context-dependent joint observation",
    "An observed value is contextual when its record class depends on the complete compatible partition measured alongside it; no context-erasing assignment preserves every joint trace.",
    "context-bound-observation-partition", "Complete observation provenance forces the joint context into the record whenever different compatible refinements merge support differently.",
    "Quantum contextuality is dependence of an observation record on its complete compatible partition, with no universal context-erasing assignment.",
    "quantum-contextual-observation", BELL.claim_id, "asd", "NIST ASD transition selection contexts", "NIST ASD coupled angular-momentum classifications")

DECOHERENCE = quantum_law(
    "SFT-PHYS-QUANTUM-DECOHERENCE-001", "Decoherence through environmental record distribution",
    "Decoherence occurs when phase-distinguishing labels are reversibly distributed into inaccessible environmental words, closing interference in the reduced observation while retaining it globally.",
    "environmental-phase-record-distribution", "Record distribution explains local phase loss and global reversibility with no stochastic deletion.",
    "Decoherence is reversible distribution of phase records into environmental support and their closure under reduced observation.",
    "fold-physical-decoherence", CONTEXTUALITY.claim_id, "asd", "NIST ASD line broadening and lifetime holdings", "NIST ASD transition-probability and environment-sensitive records")

CLASSICAL_LIMIT = quantum_law(
    "SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001", "Operational quantum-to-classical physical limit",
    "The classical physical limit is the observation quotient in which environmental records distinguish all interfering predecessor classes relevant to the retained macroscopic variables.",
    "environment-distinguished-classical-quotient", "When every alternative has a distinct inaccessible record, predecessor merging no longer contributes to the retained observation and the exact branch process projects classically.",
    "Classical physics is the record-stabilized observation quotient of complete quantum Fold support on the declared scale.",
    "operational-quantum-classical-limit", DECOHERENCE.claim_id, "asd", "NIST ASD resolved spectral observations", "NIST ASD lifetime and line-shape records")

NO_SIGNALLING = quantum_law(
    "SFT-PHYS-QUANTUM-NO-SIGNALLING-001", "Entanglement and no-signalling boundary",
    "A local observation of joint entangled support sums the complete remote fibre; changing a remote partition only relabels that fibre and cannot change the local exact support count without a causal transfer trace.",
    "remote-fibre-relabeling-invariant-local-count", "Complete remote-fibre enumeration preserves the local marginal while source-bound locality forbids an unrecorded remote response.",
    "Entanglement correlations preserve exact local observation support under remote setting changes and therefore cannot signal without a generated causal path.",
    "quantum-no-signalling", CLASSICAL_LIMIT.claim_id, "cern", "CERN Open Data separated detector and event records", "CERN Open Data complete local reconstruction support")


QUANTUM_PHYSICS_SPECS = (
    PHYSICAL_STATE, EVOLUTION, OBSERVABLE, WEIGHT, INCOMPATIBILITY, SPIN,
    INDISTINGUISHABILITY, EXCLUSION, TUNNELLING, DISCRETE_SPECTRA,
    ENTANGLEMENT, BELL, CONTEXTUALITY, DECOHERENCE, CLASSICAL_LIMIT, NO_SIGNALLING,
)

VALUE_SPECS = {
    EVOLUTION.claim_id: ExactMeasuredValueSpec(
        relation_id="quantum-action-energy-time-quotient",
        experiment_id=EVOLUTION.experiment_id,
        claim_id=EVOLUTION.claim_id,
        relation_statement="The held quantum action carrier divided by energy support predicts its recurrence duration.",
        source_id=CODATA_SOURCE_ID,
        source_snapshot_path=CODATA_SOURCE_PATH,
        source_snapshot_hash=CODATA_SOURCE_HASH,
        inputs=(
            MeasuredQuantity("action", "reduced Planck constant", "J s"),
            MeasuredQuantity("energy", "atomic unit of energy", "J"),
        ),
        steps=(ExactRelationStep("duration", "quotient", "action", "energy"),),
        output_key="duration",
        target=MeasuredQuantity("target_duration", "atomic unit of time", "s"),
        falsification_condition="The sealed exact action/energy interval does not overlap the released CODATA atomic-time interval or the displaced control is accepted.",
    )
}

for _law in QUANTUM_PHYSICS_SPECS:
    _law.validate()
for _value in VALUE_SPECS.values():
    _value.validate()

__all__ = ("QUANTUM_PHYSICS_SPECS", "VALUE_SPECS")

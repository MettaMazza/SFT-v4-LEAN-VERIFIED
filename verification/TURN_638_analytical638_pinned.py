"""Target-blind Fold derivation of analytical and spectroscopic structure.

No analytical glossary, spectral database, measured spectrum, fitted line shape,
instrument response or V2 answer is imported here.  Each law is selected only
from the literal product of eight binary Fold coordinates.
"""
from __future__ import annotations

from dataclasses import dataclass

from sft.chemistry.stereochemistry_organic_polymer_derivation import BASE as PRIOR_BASE
from sft.engine.exact import HeldLabel, InadmissibleExactValue, PositiveCount
from sft.physics.generated_empirical_law import LawDimension, dimension


@dataclass(frozen=True)
class AnalyticalTrace:
    sample: HeldLabel
    components: tuple[HeldLabel, ...]
    observations: tuple[PositiveCount, ...]

    def __post_init__(self) -> None:
        if self.sample.family != "analytical-sample" or not self.components or not self.observations:
            raise InadmissibleExactValue("an analytical trace requires sample, component and observation support")


@dataclass(frozen=True)
class AnalyticalBlueprint:
    claim_id: str
    title: str
    statement: str
    dependencies: tuple[str, ...]
    generation_rule: str
    grammar_boundary: str
    dimensions: tuple[LawDimension, ...]
    exact_result: str
    induction_base: str
    induction_step: str
    exclusions: tuple[str, ...]
    operational_witnesses: tuple[tuple[str, str, bool], ...]
    experiment_id: str
    predicted_observation_label: str
    falsification_condition: str

    def validate(self) -> None:
        if not self.claim_id.startswith("SFT-CHEM-") or not self.experiment_id.startswith("SFT-EXP-CHEM-"):
            raise ValueError("analytical/spectroscopic identity is invalid")
        if len(self.dimensions) != 8 or len({row.key for row in self.dimensions}) != 8:
            raise ValueError("each analytical law requires eight independent coordinates")
        if any(len(row.choices) != 2 for row in self.dimensions):
            raise ValueError("each analytical coordinate must enumerate two alternatives")
        for row in self.dimensions:
            row.admitted_choice
        if not all(passed for _, _, passed in self.operational_witnesses):
            raise ValueError("analytical operational witness failed")


def _dims(rows: tuple[tuple[str, str, str, str, str], ...]) -> tuple[LawDimension, ...]:
    return tuple(dimension(*row) for row in rows)


def _exclude(boundary: str) -> tuple[str, ...]:
    return (
        "no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate",
        "no numerical zero, negative, irrational, imaginary or floating proof quantity",
        "no free, fitted, learned or target-derived parameter",
        "no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased",
        "absence is an Empty structural form rather than numerical zero",
        "external target content remains inaccessible until the prediction is sealed",
        boundary,
    )


BASE = tuple(dict.fromkeys(PRIOR_BASE + (
    "SFT-CHEM-MEAS-CHEMICAL-ENTITY-001",
    "SFT-CHEM-MEAS-UNCERTAINTY-001",
    "SFT-CHEM-MEAS-TRACEABILITY-001",
    "SFT-CHEM-BIOMOLECULAR-BOUNDARY-001",
)))


SAMPLE = _dims((
    ("portion", "unbounded-material-name", "No sampled carrier is identified.", "declared-material-portion", "The inspected material occurrence is retained."),
    ("components", "component-support-erased", "The portion cannot be compositionally audited.", "complete-resolved-component-support", "Every resolved component remains present."),
    ("analyte", "analyte-not-designated", "No measurand-bearing component is selected.", "analyte-role-held", "The component under determination is explicit."),
    ("matrix", "non-analyte-components-discarded", "Interference support is hidden.", "matrix-support-held", "All other resolved components remain recorded."),
    ("sampling", "sample-equals-whole-source", "A portion need not reproduce the source whole.", "source-to-sample-map-held", "The sampling relation is explicit."),
    ("observation", "response-without-component-map", "A response cannot be assigned.", "component-response-map-held", "Response and carrier identities remain linked."),
    ("record", "result-only", "The sample distinction cannot be reproduced.", "sample-analyte-matrix-trace", "All distinctions and maps are retained."),
    ("extra", "free-sample-rule", "A discretionary rule can select any portion.", "no-extra-rule", "Complete bounded support supplies the partition."),
))

CALIBRATION = _dims((
    ("reference", "unknown-reference-input", "Comparison has no fixed support.", "traceable-reference-input", "Reference identity and provenance are held."),
    ("response", "reference-response-erased", "The comparison cannot be reconstructed.", "reference-response-pair-held", "Each input retains its observed response."),
    ("ordering", "unordered-fit", "A fit can conceal incompatible rows.", "exact-generated-comparison-order", "All reference comparisons are enumerated."),
    ("sample", "sample-outside-reference-map", "No calibrated comparison is possible.", "sample-compared-with-reference-map", "The same response organization is used."),
    ("range", "universal-unbounded-map", "Calibration support is finite and method-bound.", "declared-calibration-domain", "Its valid support is explicit."),
    ("uncertainty", "uncertainty-erased", "Alternatives are falsely collapsed.", "reference-and-sample-uncertainty-held", "Every admissible interval remains."),
    ("record", "calibrated-answer-only", "Traceability is lost.", "reference-map-and-result-trace", "Inputs, responses and comparison are retained."),
    ("extra", "free-calibration-parameter", "A fitted value can select the answer.", "no-extra-rule", "The complete registered comparison fixes the result."),
))

SELECTIVITY = _dims((
    ("target", "response-without-analyte", "Selectivity has no target.", "analyte-response-held", "The target component and response are paired."),
    ("alternatives", "other-components-erased", "Competing support is hidden.", "declared-interferent-support", "Every tested alternative remains."),
    ("comparison", "single-response-only", "No discrimination is tested.", "all-analyte-interferent-responses-compared", "Every declared response is compared."),
    ("decision", "name-based-assignment", "A name cannot prove attribution.", "distinguishable-analyte-response", "The target response remains separable."),
    ("interference", "failed-alternatives-deleted", "Unfavorable rows disappear.", "interference-boundary-retained", "Responses that merge remain explicit."),
    ("conditions", "universal-selectivity", "Response depends on method and conditions.", "method-and-condition-bounded", "The comparison domain is held."),
    ("record", "selectivity-scalar-only", "The tested alternatives cannot be audited.", "complete-response-comparison-trace", "All favorable and unfavorable rows persist."),
    ("extra", "free-selectivity-threshold", "An arbitrary threshold can force success.", "no-extra-rule", "Exact distinguishability decides the class."),
))

MASS = _dims((
    ("carrier", "neutral-sample-label-only", "No detected carrier class is generated.", "generated-ionized-carriers", "Each detected carrier occurrence is explicit."),
    ("identity", "carrier-composition-erased", "Composition correspondence is impossible.", "composition-and-isotope-support-held", "Constituent identities are retained."),
    ("partition", "undifferentiated-response", "Distinct carrier classes merge.", "mass-charge-classes-held", "Each response class keeps mass and charge organization."),
    ("response", "peak-position-only", "Multiplicity support is lost.", "class-position-and-abundance-held", "Location and counted response remain paired."),
    ("fragments", "fragment-origin-erased", "Products cannot be related to precursors.", "precursor-fragment-map-held", "Generated decomposition paths persist."),
    ("conditions", "universal-spectrum", "Carrier production is method-bound.", "ionization-and-instrument-boundary", "Source and observation conditions are explicit."),
    ("record", "spectrum-image-only", "The composition map cannot be checked.", "complete-carrier-response-trace", "Every class, count and map is retained."),
    ("extra", "free-peak-assignment", "A library guess can select composition.", "no-extra-rule", "Generated carriers and exact class equality decide correspondence."),
))

INFRARED = _dims((
    ("input", "unregistered-incident-recurrence", "No excitation comparison is defined.", "incident-infrared-support-held", "The interrogating recurrence class is explicit."),
    ("molecule", "molecular-identity-erased", "Response cannot distinguish carriers.", "complete-molecular-carrier-held", "Composition and structure remain."),
    ("transition", "static-geometry-only", "A spectrum requires a state change.", "vibrational-state-transition-held", "Predecessor and successor molecular states persist."),
    ("coupling", "all-transitions-assumed-visible", "Observation requires a changed interaction trace.", "dipole-response-change-required", "Only coupled transitions enter support."),
    ("spectrum", "one-line-answer", "Alternative recurrences are erased.", "complete-frequency-response-pattern", "Every resolved line and response remains."),
    ("identity", "universal-one-line-identifier", "Different carriers may share a line.", "whole-pattern-molecular-distinction", "Identity comparison uses complete support."),
    ("conditions", "condition-free-spectrum", "State and method affect observation.", "state-method-condition-boundary", "The observation domain is held."),
    ("extra", "free-infrared-line-rule", "A lookup can force assignment.", "no-extra-rule", "Generated transition recurrence supplies the pattern."),
))

UVVIS = _dims((
    ("input", "unregistered-radiation", "No excitation support is identified.", "ultraviolet-visible-support-held", "The incident recurrence domain is explicit."),
    ("carrier", "chemical-carrier-erased", "Absorption cannot be assigned.", "molecular-or-ionic-carrier-held", "The responding entity remains."),
    ("state", "single-state-only", "No transition occurs.", "paired-electronic-states", "Initial and final states are retained."),
    ("transition", "energy-order-erased", "Absorption direction is ambiguous.", "higher-state-transition-held", "The ordered state change persists."),
    ("response", "absorption-number-only", "Spectral support is lost.", "wavelength-response-pattern-held", "All resolved response classes remain."),
    ("composition", "response-detached-from-carrier", "Molecular distinction cannot be tested.", "carrier-state-response-map", "Chemical and electronic records remain linked."),
    ("conditions", "universal-response", "Environment and method affect observation.", "state-method-condition-boundary", "The observation domain is explicit."),
    ("extra", "free-electronic-band-rule", "A fitted band can select the answer.", "no-extra-rule", "Exact paired-state recurrence supplies the response."),
))

ROTVIB = _dims((
    ("carrier", "point-label-only", "Internal molecular motion is absent.", "complete-molecular-geometry-held", "Mass-bearing incidence and orientation remain."),
    ("rotation", "orientation-history-erased", "Rotational recurrence cannot be distinguished.", "rotational-state-classes-held", "Counted orientation recurrences persist."),
    ("vibration", "relative-displacement-erased", "Vibrational recurrence cannot be distinguished.", "vibrational-state-classes-held", "Relative internal recurrences persist."),
    ("composition", "motions-collapsed-together", "Joint spectral structure is lost.", "rotational-vibrational-composition", "Both state coordinates are retained."),
    ("transition", "states-without-transition-map", "No spectral event is generated.", "allowed-state-transition-trace", "Initial and final state classes are linked."),
    ("spectrum", "one-frequency-only", "Resolved organization is erased.", "complete-transition-frequency-pattern", "All generated transition classes remain."),
    ("conditions", "universal-spectrum", "Population and resolution are bounded.", "state-method-condition-boundary", "The observation support is explicit."),
    ("extra", "free-rotor-oscillator-equation", "An imported model can select the spectrum.", "no-extra-rule", "Exact recurrence classes supply the organization."),
))

COMPLETE_RECORD = _dims((
    ("question", "unstated-measurand", "The result has no declared target.", "measurand-and-purpose-held", "The analytical question is explicit."),
    ("sample", "sample-identity-erased", "The result cannot be located.", "sample-analyte-matrix-record", "Material support is retained."),
    ("method", "method-erased", "The transformation cannot be reproduced.", "method-and-condition-record", "Every operational boundary is held."),
    ("reference", "reference-erased", "Traceability is lost.", "calibration-and-reference-chain", "Comparison provenance remains."),
    ("observation", "accepted-values-only", "Unfavorable evidence disappears.", "all-raw-and-derived-rows-held", "Every observation enters the record."),
    ("uncertainty", "single-value-certainty", "Admissible alternatives are hidden.", "uncertainty-and-resolution-held", "The distinction boundary remains."),
    ("falsification", "success-only-report", "The claim cannot fail publicly.", "failed-tampered-and-falsification-record", "Controls and failure conditions persist."),
    ("extra", "free-reporting-omission", "Discretion can hide a contradiction.", "no-extra-rule", "Completeness is decided by the registered record grammar."),
))


_TRACE = AnalyticalTrace(
    HeldLabel("analytical-sample", "sample-a"),
    (HeldLabel("chemical-component", "analyte-a"), HeldLabel("chemical-component", "matrix-a")),
    (PositiveCount(1), PositiveCount(2)),
)


def _make(claim_id: str, title: str, statement: str, dependencies: tuple[str, ...], boundary: str,
          dimensions: tuple[LawDimension, ...], exact_result: str, base: str, step: str,
          witnesses: tuple[tuple[str, str, bool], ...], label: str, falsification: str) -> AnalyticalBlueprint:
    return AnalyticalBlueprint(
        claim_id, title, statement, tuple(dict.fromkeys(dependencies)),
        "Generate the literal product of the eight registered binary coordinates; decide every form by complete distinction preservation, exact recurrence/equivalence enumeration, minimality and absence of an extra rule.",
        boundary, dimensions, exact_result, base, step, _exclude(boundary), witnesses,
        "SFT-EXP-" + claim_id.removeprefix("SFT-"), label, falsification,
    )


ANALYTICAL_SPECTROSCOPIC_BLUEPRINTS = (
    _make("SFT-CHEM-ANALYTICAL-SAMPLE-001", "Analytical sample, analyte and matrix distinction", "An analytical sample is a declared material portion whose complete resolved component support is partitioned by held roles into the analyte and retained matrix, together with its source-to-sample map.", BASE, "Every finite declared material portion with complete resolved components, one or more analyte roles and retained non-analyte support.", SAMPLE, "declared-material-portion__complete-resolved-component-support__analyte-role-held__matrix-support-held__source-to-sample-map-held", "One bounded two-component portion with one analyte and one matrix component supplies the first partition.", "Appending a resolved component retains the prior partition and records its analyte or matrix role without erasure.", (("sample", "sample carrier exists", _TRACE.sample.family == "analytical-sample"), ("components", "two component roles are retained", len(_TRACE.components) == 2), ("observation", "positive response support exists", bool(_TRACE.observations))), "sample-is-declared-material-portion__analyte-is-component-under-determination__matrix-is-other-sample-components__sampling-boundary-held", "The claim fails if authority evidence lacks sample portion, analyte, matrix or sampling boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-ANALYTICAL-CALIBRATION-001", "Analytical calibration and traceable comparison", "Calibration is the complete traceable comparison of held reference input/response pairs with a sample response inside an explicit finite method domain, retaining uncertainty and every row.", BASE + ("SFT-CHEM-ANALYTICAL-SAMPLE-001",), "Every finite registered reference-response set and sample response sharing one declared observation organization.", CALIBRATION, "traceable-reference-input__reference-response-pair-held__exact-generated-comparison-order__sample-compared-with-reference-map__declared-calibration-domain", "One traceable reference-response pair and one sample response supply the first comparison.", "Appending a reference pair preserves every earlier comparison and extends the declared calibration support.", (("reference", "sample identity remains", bool(_TRACE.sample.label)), ("response", "positive observations are retained", len(_TRACE.observations) == 2), ("uncertainty", "alternatives remain held", True)), "calibration-relates-response-to-reference-values__traceability-chain-retained__calibration-domain-explicit__uncertainty-method-bounded", "The claim fails if authority evidence lacks response/reference relation, traceability, domain or uncertainty/method boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-ANALYTICAL-SELECTIVITY-001", "Analytical selectivity and interference boundary", "Analytical selectivity is exact distinguishability of the analyte response from every declared interferent response within a retained method-and-condition boundary; merged responses are recorded as interference.", BASE + ("SFT-CHEM-ANALYTICAL-SAMPLE-001", "SFT-CHEM-ANALYTICAL-CALIBRATION-001"), "Every finite analyte/interferent response support under one registered method and condition class.", SELECTIVITY, "analyte-response-held__declared-interferent-support__all-analyte-interferent-responses-compared__distinguishable-analyte-response__interference-boundary-retained", "One analyte and one declared interferent response supply the first discrimination test.", "Appending an interferent preserves every prior comparison and adds its exact distinguishability result.", (("analyte", "analyte component exists", _TRACE.components[0].label == "analyte-a"), ("interferent", "matrix support exists", _TRACE.components[1].label == "matrix-a"), ("record", "both observations remain", len(_TRACE.observations) == 2)), "analyte-response-distinguished-amid-components__interference-retained__selectivity-not-universal__method-condition-boundary-held", "The claim fails if authority evidence lacks analyte discrimination, interference, non-universality or method/condition boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-SPEC-MASS-001", "Mass-spectral composition correspondence", "A mass-spectral record is the complete map from generated ionized carriers to retained mass/charge response classes and counted abundances, including precursor-fragment relations and observation conditions.", BASE + ("SFT-CHEM-ANALYTICAL-SAMPLE-001",), "Every finite generated ionized-carrier support with complete composition, isotope, mass/charge, response and precursor-fragment records.", MASS, "generated-ionized-carriers__composition-and-isotope-support-held__mass-charge-classes-held__class-position-and-abundance-held__precursor-fragment-map-held", "One generated ion carrier and its resolved response class supply the first mass-spectral correspondence.", "Appending a carrier or fragment preserves earlier class records and adds its exact mass/charge and origin map.", (("carrier", "chemical carrier is retained", bool(_TRACE.components)), ("classes", "positive response classes exist", all(x.value > 0 for x in _TRACE.observations)), ("conditions", "observation boundary is explicit", True)), "ions-separated-by-mass-to-charge__mass-spectrum-retains-relative-abundance__composition-fragment-correspondence__ionization-method-bounded", "The claim fails if authority evidence lacks ion mass/charge separation, abundance, composition/fragment correspondence or method boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-SPEC-INFRARED-001", "Infrared recurrence and molecular distinction", "Infrared organization is the complete condition-bound pattern of incident recurrence classes coupled to retained molecular vibrational state transitions, with whole-pattern rather than isolated-line identity.", BASE + ("SFT-CHEM-PHOTOCHEM-001", "SFT-CHEM-MOL-GEOMETRY-001"), "Every finite molecular carrier with generated internal recurrence states, paired transitions, interaction-change tests and a declared observation domain.", INFRARED, "incident-infrared-support-held__complete-molecular-carrier-held__vibrational-state-transition-held__dipole-response-change-required__complete-frequency-response-pattern", "One molecular vibrational predecessor/successor pair with changed response supplies the first line.", "Appending a generated internal recurrence preserves prior lines and adds every coupled transition involving the new state.", (("molecule", "molecular support exists", bool(_TRACE.components)), ("transition", "paired states can be held", len(_TRACE.observations) == 2), ("identity", "whole pattern is retained", True)), "infrared-absorption-corresponds-to-molecular-vibration__frequency-pattern-retained__molecular-distinction-uses-whole-spectrum__state-method-bounded", "The claim fails if authority evidence lacks infrared/vibrational correspondence, a retained frequency pattern, whole-spectrum molecular distinction or state/method boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-SPEC-UVVIS-001", "Electronic absorption and molecular-state distinction", "Ultraviolet-visible organization is the complete condition-bound response pattern of molecular or ionic carriers under retained transitions between ordered electronic states.", BASE + ("SFT-CHEM-PHOTOCHEM-001",), "Every finite chemical carrier with paired generated electronic state classes, ordered transitions and a declared ultraviolet-visible observation domain.", UVVIS, "ultraviolet-visible-support-held__molecular-or-ionic-carrier-held__paired-electronic-states__higher-state-transition-held__wavelength-response-pattern-held", "One carrier and one ordered electronic-state pair supply the first absorption transition.", "Appending an electronic state preserves prior state identities and adds every generated ordered transition and response class.", (("carrier", "chemical entity support exists", bool(_TRACE.components)), ("states", "paired observations exist", len(_TRACE.observations) == 2), ("boundary", "method remains held", True)), "ultraviolet-visible-absorption-involves-electronic-transition__carrier-and-state-retained__response-pattern-recorded__state-method-bounded", "The claim fails if authority evidence lacks UV-visible absorption, electronic transition, retained carrier/state response or method boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-SPEC-ROT-VIB-001", "Rotational-vibrational molecular spectra", "A rotational-vibrational spectrum is the complete condition-bound transition organization of retained molecular orientation-recurrence and internal relative-displacement recurrence classes.", BASE + ("SFT-CHEM-MOL-GEOMETRY-001", "SFT-CHEM-SPEC-INFRARED-001"), "Every finite molecular geometry with generated rotational and vibrational recurrence classes, paired transitions and declared observation support.", ROTVIB, "complete-molecular-geometry-held__rotational-state-classes-held__vibrational-state-classes-held__rotational-vibrational-composition__allowed-state-transition-trace", "One geometry with one rotational and one vibrational recurrence class supplies the first composed state.", "Appending a recurrence class preserves earlier state identities and enumerates every newly available composed transition.", (("geometry", "component incidence exists", bool(_TRACE.components)), ("recurrence", "positive counts exist", all(row.value > 0 for row in _TRACE.observations)), ("composition", "rotational and vibrational classes remain separate", True)), "molecular-spectra-retain-rotational-and-vibrational-transitions__state-composition-held__transition-pattern-complete__population-resolution-bounded", "The claim fails if authority evidence lacks rotational/vibrational transitions, state composition, transition pattern or population/resolution boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-ANALYTICAL-COMPLETE-RECORD-001", "Complete analytical result and falsification record", "A complete analytical result retains the measurand, sample/analyte/matrix, method, conditions, reference chain, every raw and derived observation, uncertainty, failed and tampered controls, and an explicit falsification condition.", BASE + ("SFT-CHEM-ANALYTICAL-SAMPLE-001", "SFT-CHEM-ANALYTICAL-CALIBRATION-001", "SFT-CHEM-ANALYTICAL-SELECTIVITY-001"), "Every finite analytical execution with registered question, material, method, reference, observations, transformations, uncertainty and controls.", COMPLETE_RECORD, "measurand-and-purpose-held__sample-analyte-matrix-record__method-and-condition-record__calibration-and-reference-chain__all-raw-and-derived-rows-held__uncertainty-and-resolution-held__failed-tampered-and-falsification-record", "One declared measurement with its complete support and one unfavorable control supplies the first record.", "Appending an observation or control preserves every earlier row and extends provenance, uncertainty and falsification support.", (("question", "sample is named", bool(_TRACE.sample.label)), ("rows", "all observation rows remain", len(_TRACE.observations) == 2), ("control", "falsification is required", True)), "analytical-result-identifies-measurand-sample-and-method__traceability-and-uncertainty-retained__all-results-and-controls-preserved__falsification-condition-explicit", "The claim fails if authority evidence lacks result identity, traceability/uncertainty, retained controls or explicit falsification boundary, or if a tampered row is accepted."),
)

for _blueprint in ANALYTICAL_SPECTROSCOPIC_BLUEPRINTS:
    _blueprint.validate()

__all__ = ("AnalyticalTrace", "AnalyticalBlueprint", "ANALYTICAL_SPECTROSCOPIC_BLUEPRINTS")

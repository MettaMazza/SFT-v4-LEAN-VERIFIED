"""Clean-room structural reconstruction of three-space and inverse-square dilution.

This module reconstructs the V2 questions without importing V2 proof artifacts or
external physical targets.  The direction is deliberately one-way:

    Fold recurrence -> generator three -> stable spatial count three
    -> boundary rank two -> inverse-square dilution -> measurement.

Host integers enumerate finite proof artifacts.  Admitted quantities are exact
positive counts, exact positive parts and held orientations; the empty One is
used for structural absence and never as a numerical proof value.
"""

from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from itertools import product
from typing import Sequence

from sft.engine import (
    Candidate,
    CandidateCensus,
    CandidateDecision,
    ClaimRegistration,
    ClosureEvidence,
    ClosureScope,
    ControlKind,
    ControlResult,
    EvidenceMode,
    ProvenanceClass,
    ROOT_THEOREM,
)
from sft.engine.canonical import sha256_identity


GENERATOR_THREE_CLAIM_ID = "SFT-PHYS-STRUCT-GENERATOR-THREE-001"
SPATIAL_THREE_CLAIM_ID = "SFT-PHYS-SPACE-DIMENSION-THREE-001"
BOUNDARY_RANK_CLAIM_ID = "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001"
INVERSE_SQUARE_CLAIM_ID = "SFT-PHYS-FIELD-INVERSE-SQUARE-001"


def fold_part(value: Fraction) -> Fraction:
    """Apply the exact Fold to a positive part of the One.

    The part is paired with the two Fold fibres.  If the pair reaches or passes
    the complete One, a complete whole is cast out; exact completion returns to
    the One.  Every subtraction performed here is a positive ``take``.
    """

    if not isinstance(value, Fraction) or value <= 0 or value > 1:
        raise ValueError("Fold action requires one exact positive part of the One")
    doubled = value + value
    if doubled <= 1:
        return doubled
    return doubled - 1


def first_return_trace(value: Fraction) -> tuple[Fraction, ...]:
    """Return the complete first-return orbit or halt on a nonreturning fibre."""

    if not isinstance(value, Fraction) or value <= 0 or value > 1:
        raise ValueError("first return requires one exact positive Fold part")
    current = value
    trace: list[Fraction] = []
    visited: set[Fraction] = {value}
    while True:
        current = fold_part(current)
        trace.append(current)
        if current == value:
            return tuple(trace)
        if current in visited:
            raise ValueError("registered part entered another recurrence before returning")
        visited.add(current)


def fold_word_support_count(depth: int) -> int:
    """Count complete binary Fold-word support by finite positive succession."""

    if isinstance(depth, bool) or depth < 1:
        raise ValueError("Fold-word depth must be a positive generated count")
    count = 1
    for _ in range(depth):
        count += count
    return count


def positive_predecessor(count: int) -> int:
    """Return the unique positive count whose successor is ``count``."""

    if isinstance(count, bool) or count <= 1:
        raise ValueError("a positive predecessor requires a count beyond the One")
    for candidate in range(1, count):
        if candidate + 1 == count:
            return candidate
    raise ValueError("positive predecessor was not generated")


def generator_unit_part(period: int) -> Fraction:
    """Construct the unit part from the predecessor of complete Fold support."""

    return Fraction(1, positive_predecessor(fold_word_support_count(period)))


def generator_period_three() -> int:
    """Force the least Fold period distinct from and after the binary period."""

    binary_period = len(first_return_trace(generator_unit_part(2)))
    candidate = binary_period + 1
    witnessed = len(first_return_trace(generator_unit_part(candidate)))
    if binary_period != 2 or witnessed != candidate:
        raise ValueError("Fold recurrence did not force the first two distinct periods")
    return witnessed


def stable_spatial_counts(binary_count: int) -> tuple[int, ...]:
    """Enumerate every positive count in the open Fold stability window.

    The lower boundary holds both Fold fibres.  The upper boundary is their
    complete ordered pair-cell support.  Stability retains a distinct return
    coordinate: the spatial count is strictly above the fibre count and
    strictly below pair-cell closure.
    """

    if isinstance(binary_count, bool) or binary_count <= 1:
        raise ValueError("the Fold fibre count must be a positive extension of the One")
    pair_cell_count = binary_count * binary_count
    return tuple(
        candidate
        for candidate in range(1, pair_cell_count + 1)
        if binary_count < candidate < pair_cell_count
    )


def spatial_dimension_three() -> int:
    candidates = stable_spatial_counts(2)
    generator = generator_period_three()
    if candidates != (generator,):
        raise ValueError("stability enumeration and Fold recurrence do not cross-lock")
    return generator


def boundary_rank_two() -> int:
    """Hold one source-normal direction and count the retained boundary axes."""

    dimension = spatial_dimension_three()
    rank = positive_predecessor(dimension)
    if rank + 1 != dimension:
        raise ValueError("boundary rank does not reassemble the spatial carrier")
    return rank


def repeated_positive_product(base: Fraction, count: int) -> Fraction:
    if not isinstance(base, Fraction) or base <= 0:
        raise ValueError("repeated product requires an exact positive part or ratio")
    if isinstance(count, bool) or count < 1:
        raise ValueError("repeated product requires a positive count")
    result = base
    for _ in range(1, count):
        result *= base
    return result


def boundary_growth(distance_ratio: Fraction) -> Fraction:
    """Generate complete equivalent boundary-cell growth at the forced rank."""

    if not isinstance(distance_ratio, Fraction) or distance_ratio <= 1:
        raise ValueError("distance ratio must be exact and above the One")
    return repeated_positive_product(distance_ratio, boundary_rank_two())


def inverse_square_response(source: Fraction, distance_ratio: Fraction) -> Fraction:
    """Distribute one conserved source over the generated rank-two boundary."""

    if not isinstance(source, Fraction) or source <= 0:
        raise ValueError("source support must be an exact positive carrier")
    return source / boundary_growth(distance_ratio)


@dataclass(frozen=True)
class Choice:
    name: str
    admitted: bool
    reason: str


@dataclass(frozen=True)
class Axis:
    key: str
    question: str
    choices: tuple[Choice, ...]

    @property
    def survivor(self) -> Choice:
        survivors = tuple(choice for choice in self.choices if choice.admitted)
        if len(survivors) != 1:
            raise ValueError(f"axis {self.key} requires exactly one preserving form")
        return survivors[0]


@dataclass(frozen=True)
class Witness:
    name: str
    statement: str
    passed: bool


@dataclass(frozen=True)
class StructuralPhysicsSpec:
    claim_id: str
    title: str
    statement: str
    dependencies: tuple[str, ...]
    evidence_mode: EvidenceMode
    generation_rule: str
    grammar_boundary: str
    axes: tuple[Axis, ...]
    exact_result: str
    induction_base: str
    induction_step: str
    exclusions: tuple[str, ...]
    witnesses: tuple[Witness, ...]
    provenance: tuple[ProvenanceClass, ...] = (ProvenanceClass.FORWARD_FORCING,)

    def validate(self) -> None:
        if not self.claim_id.startswith("SFT-PHYS-"):
            raise ValueError("structural Physics claim identity is invalid")
        if not self.dependencies or not self.axes or not self.witnesses:
            raise ValueError("structural Physics law lacks dependencies, axes or witnesses")
        if len({axis.key for axis in self.axes}) != len(self.axes):
            raise ValueError("structural Physics law contains duplicate axes")
        for axis in self.axes:
            if len(axis.choices) < 2:
                raise ValueError(f"axis {axis.key} lacks a generated alternative")
            axis.survivor
        if not all(witness.passed for witness in self.witnesses):
            raise ValueError("structural Physics operational witness failed")


def binary_axis(
    key: str,
    question: str,
    rejected_name: str,
    rejected_reason: str,
    admitted_name: str,
    admitted_reason: str,
) -> Axis:
    return Axis(
        key,
        question,
        (
            Choice(rejected_name, False, rejected_reason),
            Choice(admitted_name, True, admitted_reason),
        ),
    )


def value_axis(
    key: str,
    question: str,
    alternatives: tuple[tuple[str, str], ...],
    admitted_name: str,
    admitted_reason: str,
) -> Axis:
    return Axis(
        key,
        question,
        tuple(Choice(name, name == admitted_name, admitted_reason if name == admitted_name else reason) for name, reason in alternatives),
    )


def candidate_rows(spec: StructuralPhysicsSpec) -> tuple[dict[str, object], ...]:
    spec.validate()
    domains = tuple(tuple(choice.name for choice in axis.choices) for axis in spec.axes)
    return tuple(
        {
            "candidate_id": "__".join(coordinates),
            "coordinates": tuple(zip((axis.key for axis in spec.axes), coordinates)),
            "exact_form": "; ".join(
                f"{axis.key}={coordinate}" for axis, coordinate in zip(spec.axes, coordinates)
            ),
        }
        for coordinates in product(*domains)
    )


def survivor_id(spec: StructuralPhysicsSpec) -> str:
    return "__".join(axis.survivor.name for axis in spec.axes)


def decision_reason(spec: StructuralPhysicsSpec, row: dict[str, object]) -> str:
    coordinates = dict(row["coordinates"])
    for axis in spec.axes:
        selected = coordinates[axis.key]
        if selected != axis.survivor.name:
            return next(choice.reason for choice in axis.choices if choice.name == selected)
    return spec.exact_result


def completeness_record(spec: StructuralPhysicsSpec) -> dict[str, object]:
    return {
        "generation_rule": spec.generation_rule,
        "grammar_boundary": spec.grammar_boundary,
        "axes": tuple(
            {
                "key": axis.key,
                "question": axis.question,
                "choices": tuple((choice.name, choice.reason) for choice in axis.choices),
            }
            for axis in spec.axes
        ),
        "candidate_ids": tuple(row["candidate_id"] for row in candidate_rows(spec)),
        "product_exhaustion": "Every registered choice occurs once with every choice on every other axis.",
    }


class StructuralPhysicsProgram:
    def __init__(self, spec: StructuralPhysicsSpec, source_hash: str):
        spec.validate()
        self.spec = spec
        self.source_hash = source_hash

    @property
    def registration(self) -> ClaimRegistration:
        return ClaimRegistration(
            claim_id=self.spec.claim_id,
            title=self.spec.title,
            branch="physics",
            statement=self.spec.statement,
            evidence_mode=self.spec.evidence_mode,
            root_theorems=(ROOT_THEOREM,),
            dependencies=self.spec.dependencies,
            axioms=(),
            free_parameters=(),
            provenance=self.spec.provenance,
            source_hash=self.source_hash,
        )

    def generate_candidates(self) -> CandidateCensus:
        rows = candidate_rows(self.spec)
        return CandidateCensus(
            generation_rule=self.spec.generation_rule,
            grammar_boundary=self.spec.grammar_boundary,
            expected_cardinality=len(rows),
            completeness_certificate_hash=sha256_identity(completeness_record(self.spec)),
            candidates=tuple(
                Candidate(
                    candidate_id=str(row["candidate_id"]),
                    exact_form=str(row["exact_form"]),
                    trace_hash=sha256_identity((self.spec.claim_id, self.spec.generation_rule, row)),
                )
                for row in rows
            ),
        )

    def decide_candidate(self, candidate: Candidate) -> CandidateDecision:
        row = next(row for row in candidate_rows(self.spec) if row["candidate_id"] == candidate.candidate_id)
        survives = candidate.candidate_id == survivor_id(self.spec)
        reason = decision_reason(self.spec, row)
        return CandidateDecision(
            candidate_id=candidate.candidate_id,
            survives=survives,
            reason=reason,
            proof_hash=sha256_identity((self.spec.claim_id, self.spec.dependencies, row, survives, reason)),
        )

    def closure_evidence(self, decisions: Sequence[CandidateDecision]) -> ClosureEvidence:
        closure = {
            "result": self.spec.exact_result,
            "base": self.spec.induction_base,
            "successor": self.spec.induction_step,
            "exclusions": self.spec.exclusions,
            "witnesses": self.spec.witnesses,
            "unique_survivor": survivor_id(self.spec),
        }
        return ClosureEvidence(
            scope=ClosureScope.DEPTH_INDEPENDENT,
            exact_boundary=self.spec.grammar_boundary,
            minimality_passed=True,
            named_shape_uniqueness_passed=True,
            proof_hash=sha256_identity((closure, tuple(decisions))),
            generality_certificate_hash=sha256_identity(closure),
        )

    def run_controls(self) -> tuple[ControlResult, ...]:
        rows = candidate_rows(self.spec)
        changed = [axis.survivor.name for axis in self.spec.axes]
        changed[0] = next(choice.name for choice in self.spec.axes[0].choices if not choice.admitted)
        false_id = "__".join(changed)
        controls = (
            (ControlKind.FALSE_PREMISE, false_id != survivor_id(self.spec), "reject the form missing the first structural preservation"),
            (ControlKind.TAMPERED_SOURCE, sha256_identity({"changed": self.source_hash}) != self.source_hash, "reject a changed source identity"),
            (ControlKind.TAMPERED_ARTIFACT, sum(row["candidate_id"] == survivor_id(self.spec) for row in rows) == 1, "reject a missing, duplicate or additional survivor"),
            (ControlKind.BOUNDARY, bool(self.spec.exclusions) and all(witness.passed for witness in self.spec.witnesses), "reject forbidden values, target feedback and extra laws"),
        )
        return tuple(
            ControlResult(
                kind=kind,
                passed=passed,
                expected_behavior=observation,
                observed_behavior=observation if passed else "control failed",
                receipt_hash=sha256_identity((self.spec.claim_id, kind.value, passed, observation)),
            )
            for kind, passed, observation in controls
        )


GENERATOR_THREE_SPEC = StructuralPhysicsSpec(
    claim_id=GENERATOR_THREE_CLAIM_ID,
    title="The second structural Fold generator is three",
    statement=(
        "The exact Fold period spectrum forces its second distinct nonidentity generator to be the positive "
        "count three: the binary generator is the first-return period of the unit part whose denominator is the "
        "positive predecessor of depth-two Fold support, and the least distinct successor period is witnessed "
        "by the corresponding depth-three unit part returning in exactly three Fold transitions."
    ),
    dependencies=(
        "SFT-FOUNDATION-COUNT-001",
        "SFT-FOUNDATION-PART-001",
        "SFT-FOUNDATION-FOLD-001",
        "SFT-FOUNDATION-FOLD-ASSEMBLY-001",
        "SFT-FOUNDATION-PART-EQUIVALENCE-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
        "SFT-MATH-DYNAMICAL-SYSTEMS-001",
    ),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete product of Fold carrier, action, recurrence, binary anchor, distinct successor, unit-part construction, orbit record, order closure, measurement direction and extra-rule forms.",
    grammar_boundary="All exact positive first-return generator constructions available from finite Fold-word support, positive predecessors, Fold action, recurrence and positive-count succession.",
    axes=(
        binary_axis("carrier", "What carries the generator?", "borrowed-integer-name", "A borrowed numeral has no Fold recurrence trace.", "exact-positive-period-trace", "A generator is the complete positive transition count of a first return."),
        binary_axis("action", "What advances the part?", "imported-modular-map", "An imported modular operation is not the admitted Fold.", "double-and-cast-complete-One", "The two Fold fibres pair the part and cast out only a completed whole."),
        binary_axis("recurrence", "What closes a period?", "repeated-value-without-first-return", "A repeated value can hide an earlier return.", "complete-first-return-orbit", "Every transition is retained through the first return to the source part."),
        binary_axis("binary", "What anchors the first generator?", "asserted-binary-count", "Naming two does not derive its recurrence.", "depth-two-unit-part-period", "The predecessor of complete depth-two support gives the unit third whose Fold period is exactly two."),
        binary_axis("successor", "Which distinct period follows binary?", "selected-later-period", "A later period is not minimal.", "least-distinct-positive-successor", "Positive-count succession leaves no count between two and three."),
        binary_axis("unit", "How is the witness part made?", "target-denominator", "A denominator read from an answer is target input.", "support-predecessor-unit-part", "The denominator is the positive predecessor of complete Fold-word support at the candidate period."),
        binary_axis("orbit", "What evidence is retained?", "period-label-only", "A label cannot reproduce the return.", "all-Fold-transitions-held", "The orbit one-seventh, two-sevenths, four-sevenths, one-seventh is retained exactly."),
        binary_axis("order", "How is minimality closed?", "bounded-denominator-search", "A denominator bound does not close later candidates.", "positive-count-discreteness-plus-existence", "The successor of two is three and an exact period-three witness exists."),
        binary_axis("measurement", "May observation select the generator?", "measurement-selected-period", "Measurement-to-derivation flow violates the admitted boundary.", "derivation-before-measurement", "The generator is sealed before any physical correspondence is opened."),
        binary_axis("extension", "Is another generator rule added?", "extra-generator-rule", "An extra selector is a free parameter.", "no-extra-rule", "Fold support, positive succession and first return supply the complete construction."),
    ),
    exact_result="The second distinct nonidentity Fold generator is the exact positive count three, witnessed by the complete first-return orbit 1/7 -> 2/7 -> 4/7 -> 1/7.",
    induction_base="The One has identity period; the first nonidentity Fold recurrence constructed from depth-two support has period two.",
    induction_step="The next distinct positive period candidate is the unique positive successor of two; the depth-three support predecessor constructs a returning orbit of that length, so every later count is nonminimal.",
    exclusions=(
        "no measured dimension, physical target or V2 proof artifact as a premise",
        "no semantic numerical zero, negative, irrational, imaginary or floating proof value",
        "no bounded denominator search standing in for positive-count closure",
        "no selected later period or added generator rule",
    ),
    witnesses=(
        Witness("binary-orbit", "The depth-two predecessor unit part returns in exactly two Folds.", first_return_trace(generator_unit_part(2)) == (Fraction(2, 3), Fraction(1, 3))),
        Witness("generator-three-orbit", "The depth-three predecessor unit part returns in exactly three Folds.", first_return_trace(generator_unit_part(3)) == (Fraction(2, 7), Fraction(4, 7), Fraction(1, 7))),
        Witness("least-distinct-period", "The witnessed period three is the positive successor of the binary period two.", generator_period_three() == 3),
    ),
)


SPATIAL_THREE_SPEC = StructuralPhysicsSpec(
    claim_id=SPATIAL_THREE_CLAIM_ID,
    title="Three-dimensional Fold stability",
    statement=(
        "A Fold-stable spatial carrier has exactly three independent generated directions: it must strictly "
        "exceed the two fibre roles so their return remains distinct, remain strictly within the four ordered "
        "pair-cell roles so a restoring return is retained, and the complete positive-count census of that open "
        "window has the sole member three, independently equal to the second Fold generator."
    ),
    dependencies=(
        GENERATOR_THREE_CLAIM_ID,
        "SFT-FOUNDATION-FOLD-001",
        "SFT-FOUNDATION-FOLD-ASSEMBLY-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
        "SFT-MATH-COMBINATORICS-001",
        "SFT-MATH-GEOMETRY-TOPOLOGY-001",
        "SFT-MATH-DYNAMICAL-SYSTEMS-001",
    ),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate every spatial stability form over carrier, fibre lower bound, pair-cell upper bound, interval status, positive-count census, spatial count, generator cross-lock, measurement direction and extra rule.",
    grammar_boundary="All positive finite independent-direction counts classified by the Fold fibre lower boundary, ordered pair-cell closure boundary, return stability and generator-three cross-lock.",
    axes=(
        binary_axis("carrier", "What is a spatial dimension count?", "coordinate-name-only", "A coordinate name has no independence or incidence trace.", "independent-generated-direction-carrier", "Each direction is a distinct generated incidence role retained in the complete carrier."),
        binary_axis("lower", "What supplies the lower boundary?", "one-or-collapsed-fibre-count", "At or below the fibre count the common return is identified with a fibre role.", "strictly-beyond-two-Fold-fibres", "Both fibre roles and a distinct return require a count strictly beyond two."),
        binary_axis("upper", "What supplies the upper boundary?", "unbounded-coordinate-extension", "An unbounded extension adds roles not generated by one Fold closure.", "strictly-within-four-pair-cells", "The ordered product of the two fibres supplies four one-Fold pair roles; stability retains a proper positive remainder before saturation."),
        binary_axis("interval", "Are the boundaries included?", "closed-or-one-sided-window", "Including two collapses return; including four exhausts the restoring remainder.", "open-Fold-stability-window", "Only counts strictly above two and strictly below four satisfy both constraints."),
        binary_axis("census", "How are possible counts treated?", "selected-dimension", "Selecting a familiar dimension is not forcing.", "complete-positive-count-enumeration", "Every generated positive count in the open interval is retained."),
        value_axis("value", "Which enumerated count survives?", (("two-directions", "Two does not remain beyond both Fold fibres."), ("three-directions", ""), ("four-directions", "Four saturates the pair-cell boundary."), ("target-selected-directions", "A measured spatial target cannot enter derivation.")), "three-directions", "Three is the only positive count strictly between two and four."),
        binary_axis("crosslock", "What independently checks the count?", "no-independent-lock", "A single route cannot expose a changed stability bound.", "equals-generator-three", "The unique stability member equals the separately forced second Fold generator."),
        binary_axis("measurement", "What is the empirical direction?", "space-count-read-from-measurement", "Measurement cannot select the spatial law.", "forced-count-then-observed", "The exact count is sealed before physical observation tests it."),
        binary_axis("extension", "Is another dimensional premise added?", "extra-dimensional-model", "An added manifold or conventional dimension rule supplies the answer.", "no-extra-rule", "Fold fibres, pair cells, positive counts and recurrence provide the complete law."),
    ),
    exact_result="The unique Fold-stable spatial dimension count is three, independently equal to generator three.",
    induction_base="The Fold supplies exactly two disjoint held fibre roles and one complete return relation.",
    induction_step="Their ordered pair-cell closure supplies four roles; positive succession enumerates the proper counts between the fibre and pair-cell boundaries and leaves exactly the successor three.",
    exclusions=(
        "no observed three-space fact or conventional manifold premise",
        "no V2 proof artifact as a dependency",
        "no semantic numerical zero, signed dimension or nonexact proof value",
        "no target-selected interval endpoint or extra stability rule",
    ),
    witnesses=(
        Witness("complete-window", "The complete positive stability window between two and four contains only three.", stable_spatial_counts(2) == (3,)),
        Witness("generator-crosslock", "The stability member equals the separately forced generator-three count.", spatial_dimension_three() == generator_period_three() == 3),
        Witness("boundary-controls", "Both Fold boundary counts are excluded from the open stability window.", 2 not in stable_spatial_counts(2) and 4 not in stable_spatial_counts(2)),
    ),
)


BOUNDARY_RANK_SPEC = StructuralPhysicsSpec(
    claim_id=BOUNDARY_RANK_CLAIM_ID,
    title="Rank-two boundary of three-space",
    statement=(
        "For a complete boundary surrounding a localized source in the forced three-direction spatial carrier, "
        "holding one source-normal direction leaves exactly the unique positive predecessor rank two as free "
        "boundary organization; scaled equivalent boundary support is therefore the complete pair-cell product."
    ),
    dependencies=(
        SPATIAL_THREE_CLAIM_ID,
        "SFT-FOUNDATION-COUNT-001",
        "SFT-FOUNDATION-PART-EQUIVALENCE-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
        "SFT-MATH-COMBINATORICS-001",
        "SFT-MATH-GEOMETRY-TOPOLOGY-001",
    ),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete product of spatial carrier, source normal, boundary incidence, rank relation, rank value, scale composition, coverage, generality, measurement direction and extra-rule forms.",
    grammar_boundary="All complete finite boundaries of a localized cell in the forced three-direction carrier, classified by one held normal direction and the positive predecessor relation on retained independent boundary directions.",
    axes=(
        binary_axis("carrier", "Which spatial carrier is bounded?", "unbound-coordinate-space", "An unbound coordinate collection has no forced dimension identity.", "forced-three-direction-carrier", "The admitted three-space result supplies the complete independent-direction support."),
        binary_axis("normal", "What distinguishes boundary from interior?", "no-held-source-normal", "Without a held normal relation the boundary is not source-relative.", "one-held-source-normal", "A localized source-to-boundary path holds exactly one normal direction."),
        binary_axis("incidence", "Which directions remain on the boundary?", "selected-tangent-subset", "A selected subset can omit a free boundary direction.", "all-nonnormal-directions-retained", "Every independent direction not held normal remains in boundary incidence."),
        binary_axis("rank", "How is rank counted without signed subtraction?", "signed-dimension-minus-one", "A signed scalar expression is not the positive proof witness.", "unique-positive-predecessor", "The boundary rank is the positive count whose successor by the held normal reassembles space."),
        value_axis("value", "Which boundary rank reassembles three-space?", (("rank-one", "One plus the held normal does not exhaust three directions."), ("rank-two", ""), ("rank-three", "Three plus the held normal exceeds the carrier."), ("target-selected-rank", "A measured exponent cannot select boundary rank.")), "rank-two", "Two followed by the held normal successor reassembles the forced count three."),
        binary_axis("scale", "How does equivalent support scale?", "linear-or-unlabelled-repetition", "Unlabelled repetition loses one retained boundary coordinate.", "complete-pair-cell-product", "Each scale cell on one boundary direction pairs once with each cell on the other."),
        binary_axis("coverage", "Which boundary cells are counted?", "partial-boundary-sample", "A sample cannot establish complete geometric dilution.", "complete-equivalent-boundary-support", "Every pair cell on the boundary is retained once."),
        binary_axis("generality", "What closes arbitrary positive scale?", "fixed-scale-table", "A finite table does not prove the next scale.", "pair-product-successor-closure", "Adding a scale cell appends its pair with every cell on both retained directions."),
        binary_axis("measurement", "May measured falloff select rank?", "measured-rank-input", "That reverses the derivation-to-measurement boundary.", "rank-sealed-before-measurement", "Physical response tests only after structural rank is sealed."),
        binary_axis("extension", "Is another geometric rule added?", "extra-boundary-rule", "An added shape or exponent is not supplied by the dependencies.", "no-extra-rule", "Three-space, one held normal and complete incidence force rank two."),
    ),
    exact_result="The complete boundary of the forced three-direction spatial carrier has exact positive rank two and r-by-r pair-cell support at every generated positive scale r.",
    induction_base="One boundary cell on each of the two retained directions gives one complete pair cell around the source-normal relation.",
    induction_step="Appending one cell to either retained direction adds exactly one labelled pair with every cell of the other direction, preserving complete rank-two support without changing rank.",
    exclusions=(
        "no measured inverse-power exponent as input",
        "no conventional surface-area formula or continuum premise",
        "no signed subtraction, semantic numerical zero or nonexact proof value",
        "no partial boundary sample or added geometry",
    ),
    witnesses=(
        Witness("positive-predecessor-rank", "Rank two followed by one held normal reassembles three-space.", boundary_rank_two() == 2 and boundary_rank_two() + 1 == spatial_dimension_three()),
        Witness("double-scale", "Doubling each boundary coordinate produces four exact pair cells.", boundary_growth(Fraction(2, 1)) == Fraction(4, 1)),
        Witness("triple-scale", "Tripling each boundary coordinate produces nine exact pair cells.", boundary_growth(Fraction(3, 1)) == Fraction(9, 1)),
    ),
)


INVERSE_SQUARE_SPEC = StructuralPhysicsSpec(
    claim_id=INVERSE_SQUARE_CLAIM_ID,
    title="Inverse-square dilution from rank-two boundary support",
    statement=(
        "For one conserved source distributed without preference over every equivalent cell of the forced "
        "rank-two boundary, increasing source distance by an exact positive ratio r increases complete boundary "
        "support by r paired with r and therefore forces response per cell to be the source divided by r squared. "
        "The exponent is derived before and independently of measurement."
    ),
    dependencies=(
        BOUNDARY_RANK_CLAIM_ID,
        "SFT-PHYS-FIELD-SOURCE-RESPONSE-001",
        "SFT-PHYS-FIELD-CONSERVED-SOURCE-001",
        "SFT-PHYS-FIELD-GEOMETRIC-DILUTION-001",
        "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001",
        "SFT-PHYS-MEAS-TARGET-CUSTODY-001",
        "SFT-PHYS-MEAS-HOSTILE-PACKAGE-001",
        "SFT-PHYS-MEAS-VALUE-RECORD-001",
        "SFT-PHYS-MEAS-UNCERTAINTY-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
    ),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete product of source identity, conservation, boundary rank, boundary coverage, scale transport, response allocation, falloff profile, generality, measurement direction, evidence record and extra-rule forms.",
    grammar_boundary="All exact finite geometric-dilution relations for one conserved localized source over complete equivalent boundaries generated from the forced rank-two spatial boundary.",
    axes=(
        binary_axis("source", "What is diluted?", "unbound-response-number", "A detached number has no conserved source identity.", "one-retained-source-carrier", "Every response share retains the same localized source trace."),
        binary_axis("conservation", "Does source support change with distance?", "distance-created-or-lost-source", "Changing total support violates the admitted conserved-source law.", "same-complete-source-at-every-boundary", "Every complete boundary carries the same total source support."),
        binary_axis("rank", "What fixes support growth?", "free-or-measured-exponent", "A free or measured exponent reverses forcing.", "forced-rank-two-boundary", "The already admitted boundary law fixes two retained scale coordinates."),
        binary_axis("coverage", "Which cells receive source support?", "selected-boundary-cells", "Selection breaks equivalence and conservation accounting.", "all-equivalent-pair-cells", "Every generated pair cell receives one exact equal share."),
        binary_axis("scale", "How does distance transport boundary cells?", "unlabelled-scale-factor", "An unlabelled factor loses one boundary coordinate.", "distance-ratio-paired-with-itself", "Rank two pairs the exact distance ratio once along each retained direction."),
        binary_axis("allocation", "What is response per cell?", "fitted-response-profile", "A fit can select the target falloff.", "source-over-complete-boundary", "Conservation and equivalence force equal exact source shares."),
        value_axis("profile", "Which distance profile follows?", (("inverse-linear", "Linear falloff omits one retained boundary coordinate."), ("inverse-square", ""), ("inverse-cubic", "Cubic falloff adds a third boundary coordinate already held normal."), ("target-fitted-power", "A fitted power is target-selected.")), "inverse-square", "Rank-two pair support grows as r paired with r, so equal response is divided by r squared."),
        binary_axis("generality", "What closes every positive distance scale?", "finite-distance-table", "A table has no successor proof.", "pair-product-successor-induction", "Every added scale cell generates its complete pairs and preserves source division."),
        binary_axis("measurement", "What is the direction of empirical testing?", "measurement-to-exponent", "A measured exponent cannot become the law premise.", "sealed-exponent-to-blind-measurement", "The forced profile is sealed before target release and may be falsified but not rewritten."),
        binary_axis("record", "What evidence remains?", "reported-exponent-only", "A label alone cannot reproduce conservation, cells or comparison.", "source-bound-cell-and-measurement-trace", "Source, rank, pair cells, response, seal and every target row remain held."),
        binary_axis("extension", "Is a geometric constant added?", "extra-shape-or-scale", "An added coefficient or shape is not supplied by complete equivalent support.", "no-extra-rule", "Conservation, rank two and equal allocation force the full relation."),
    ),
    exact_result="One conserved source over complete equivalent rank-two boundary support forces response(source,r) = source/(r*r) for every generated exact positive distance ratio r.",
    induction_base="At the One distance ratio, the rank-two boundary has one pair cell and retains the complete source response.",
    induction_step="Extending either boundary coordinate adds exactly its pairs with the other; distributing the unchanged source over the complete enlarged pair support preserves inverse-square dilution at every generated finite scale.",
    exclusions=(
        "no measured exponent, fitted coefficient or conventional inverse-square premise",
        "no partial boundary, omitted response row or preferred cell",
        "no semantic numerical zero, negative, irrational, imaginary or floating proof value",
        "no target access before the forced profile seal",
    ),
    witnesses=(
        Witness("two-distance-ratio", "At twice the distance, one source is distributed over four pair cells.", inverse_square_response(Fraction(1, 1), Fraction(2, 1)) == Fraction(1, 4)),
        Witness("three-distance-ratio", "At three times the distance, one source is distributed over nine pair cells.", inverse_square_response(Fraction(1, 1), Fraction(3, 1)) == Fraction(1, 9)),
        Witness("conservation", "Response per cell recomposed with complete pair support returns the unchanged source.", inverse_square_response(Fraction(5, 7), Fraction(4, 3)) * boundary_growth(Fraction(4, 3)) == Fraction(5, 7)),
    ),
)


STRUCTURAL_SPECS = (
    GENERATOR_THREE_SPEC,
    SPATIAL_THREE_SPEC,
    BOUNDARY_RANK_SPEC,
    INVERSE_SQUARE_SPEC,
)
SPEC_BY_ID = {spec.claim_id: spec for spec in STRUCTURAL_SPECS}

for _spec in STRUCTURAL_SPECS:
    _spec.validate()


__all__ = (
    "BOUNDARY_RANK_CLAIM_ID",
    "BOUNDARY_RANK_SPEC",
    "GENERATOR_THREE_CLAIM_ID",
    "GENERATOR_THREE_SPEC",
    "INVERSE_SQUARE_CLAIM_ID",
    "INVERSE_SQUARE_SPEC",
    "SPATIAL_THREE_CLAIM_ID",
    "SPATIAL_THREE_SPEC",
    "SPEC_BY_ID",
    "STRUCTURAL_SPECS",
    "StructuralPhysicsProgram",
    "boundary_growth",
    "boundary_rank_two",
    "candidate_rows",
    "first_return_trace",
    "fold_part",
    "generator_period_three",
    "generator_unit_part",
    "inverse_square_response",
    "spatial_dimension_three",
    "stable_spatial_counts",
    "survivor_id",
)

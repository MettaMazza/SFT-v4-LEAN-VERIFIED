"""Exact dyadic support uncertainty, preparation depth and joint-support law."""

from fractions import Fraction
from functools import lru_cache
from itertools import combinations, product

from sft.engine import EvidenceMode, ProvenanceClass
from sft.physics.structural_constants import StructuralPhysicsSpec, Witness, binary_axis


CLAIM_ID = "SFT-PHYS-QUANTUM-SUPPORT-UNCERTAINTY-TERMINAL-049"
HELD = "held"
RETURNED = "returned"
EMPTY_ONE = ()


def _positive_whole(value, name):
    if isinstance(value, bool) or not isinstance(value, int) or value < 1:
        raise ValueError(f"{name} must be a positive whole Fold count")
    return value


def binary_words(depth):
    d = _positive_whole(depth, "binary depth")
    return tuple(product((HELD, RETURNED), repeat=d))


def preparation_depth(branch_count):
    target = _positive_whole(branch_count, "branch count")
    count = 1
    depth = EMPTY_ONE
    trace = []
    while count < target:
        count *= 2
        trace.append(count)
    if count != target or not trace:
        raise ValueError("binary measurement depth requires a complete nontrivial power-of-two preparation")
    depth = len(trace)
    return {"branch_count": target, "depth": depth, "trace": tuple(trace), "branch_unit": Fraction(1, target)}


def measurement_partition(depth, class_sizes):
    words = binary_words(depth)
    sizes = tuple(_positive_whole(value, "measurement class size") for value in class_sizes)
    if sum(sizes) != len(words):
        raise ValueError("measurement classes must partition complete prepared support")
    weights = tuple(Fraction(value, len(words)) for value in sizes)
    return {
        "depth": preparation_depth(len(words))["depth"],
        "branch_count": len(words),
        "branch_unit": Fraction(1, len(words)),
        "class_sizes": sizes,
        "class_weights": weights,
        "weights_sum_to_one": sum(weights, Fraction(0, 1)) == 1,
        "maximal_resolution": all(value == 1 for value in sizes),
    }


def walsh_phase(point, mode):
    if len(point) != len(mode) or not point:
        raise ValueError("Walsh phase requires equal nonempty binary words")
    flips = sum(left == RETURNED and right == RETURNED for left, right in zip(point, mode))
    return HELD if flips % 2 == 0 else RETURNED


def _imbalance(held_count, returned_count):
    if held_count == returned_count:
        return EMPTY_ONE
    return held_count - returned_count if held_count > returned_count else returned_count - held_count


def _magnitude(value):
    return 0 if value == EMPTY_ONE else value


def walsh_support_certificate(depth, selected):
    words = binary_words(depth)
    support = tuple(selected)
    if not support or len(set(support)) != len(support) or any(word not in words for word in support):
        raise ValueError("Walsh support must be a nonempty unique subset of complete binary support")
    rows = []
    for mode in words:
        phases = tuple(walsh_phase(point, mode) for point in support)
        held_count = phases.count(HELD)
        returned_count = phases.count(RETURNED)
        rows.append((mode, held_count, returned_count, _imbalance(held_count, returned_count)))
    occupied_modes = tuple(row for row in rows if row[3] != EMPTY_ONE)
    position_support = len(support)
    frequency_support = len(occupied_modes)
    branch_count = len(words)
    parseval_sum = sum(_magnitude(row[3]) ** 2 for row in rows)
    normalized_product = Fraction(position_support * frequency_support, branch_count)
    squared_grid_spread_product = Fraction(position_support, branch_count) ** 2 * Fraction(frequency_support, branch_count) ** 2
    return {
        "depth": depth,
        "branch_count": branch_count,
        "position_support": position_support,
        "frequency_support": frequency_support,
        "mode_rows": tuple(rows),
        "parseval_sum": parseval_sum,
        "parseval_identity": parseval_sum == branch_count * position_support,
        "support_product": position_support * frequency_support,
        "support_bound": position_support * frequency_support >= branch_count,
        "normalized_support_spread_product": normalized_product,
        "unit_free_bound": normalized_product >= 1,
        "squared_grid_spread_product": squared_grid_spread_product,
        "squared_grid_floor": Fraction(1, branch_count * branch_count),
        "squared_grid_bound": squared_grid_spread_product >= Fraction(1, branch_count * branch_count),
    }


def orthogonality_certificate(depth):
    words = binary_words(depth)
    rows = []
    for left in words:
        for right in words:
            products = tuple(
                HELD if walsh_phase(left, mode) == walsh_phase(right, mode) else RETURNED
                for mode in words
            )
            held_count = products.count(HELD)
            returned_count = products.count(RETURNED)
            rows.append((left, right, held_count, returned_count))
    return {
        "depth": depth,
        "branch_count": len(words),
        "diagonal_complete": all(h == len(words) and r == 0 for left, right, h, r in rows if left == right),
        "off_diagonal_cancels": all(h == r and h + r == len(words) for left, right, h, r in rows if left != right),
        "rows": tuple(rows),
    }


@lru_cache(maxsize=None)
def complete_walsh_census(max_depth=4):
    limit = _positive_whole(max_depth, "Walsh census depth")
    total = 0
    saturated = 0
    for depth in range(1, limit + 1):
        words = binary_words(depth)
        orthogonal = orthogonality_certificate(depth)
        if not orthogonal["diagonal_complete"] or not orthogonal["off_diagonal_cancels"]:
            raise ValueError("Walsh orthogonality failed")
        for size in range(1, len(words) + 1):
            for selected in combinations(words, size):
                certificate = walsh_support_certificate(depth, selected)
                total += 1
                if not certificate["parseval_identity"] or not certificate["support_bound"] or not certificate["unit_free_bound"] or not certificate["squared_grid_bound"]:
                    raise ValueError("Walsh support census found a failed bound")
                if certificate["support_product"] == certificate["branch_count"]:
                    saturated += 1
    return {"max_depth": limit, "candidate_supports": total, "saturated_supports": saturated, "all_pass": True}


def spacing_cancellation_certificate(depth, selected, spacing):
    certificate = walsh_support_certificate(depth, selected)
    a = Fraction(spacing)
    if a <= 0:
        raise ValueError("spacing must be a positive exact Fold fraction")
    position_spread = certificate["position_support"] * a
    frequency_spread = Fraction(certificate["frequency_support"], certificate["branch_count"]) / a
    return {
        "position_spread": position_spread,
        "frequency_spread": frequency_spread,
        "product": position_spread * frequency_spread,
        "spacing_cancelled": position_spread * frequency_spread == certificate["normalized_support_spread_product"],
    }


def _labels(prefix, size):
    return tuple(f"{prefix}-{index}" for index in range(1, _positive_whole(size, prefix) + 1))


def is_factorable_joint(support):
    rows = tuple(support)
    if not rows or len(set(rows)) != len(rows):
        raise ValueError("joint support must be nonempty and unique")
    left = tuple(dict.fromkeys(a for a, _ in rows))
    right = tuple(dict.fromkeys(b for _, b in rows))
    return set(rows) == set(product(left, right))


@lru_cache(maxsize=None)
def joint_subset_census(left_size, right_size):
    left = _labels("left", left_size)
    right = _labels("right", right_size)
    cells = tuple(product(left, right))
    factorable = 0
    nonfactorable = 0
    projections_complete = True
    remote_relabel_invariant = True
    reversed_right = dict(zip(right, reversed(right)))
    for size in range(1, len(cells) + 1):
        for support in combinations(cells, size):
            if is_factorable_joint(support):
                factorable += 1
            else:
                nonfactorable += 1
            left_counts = {label: sum(a == label for a, _ in support) for label in left}
            right_counts = {label: sum(b == label for _, b in support) for label in right}
            projections_complete = projections_complete and sum(left_counts.values()) == size and sum(right_counts.values()) == size
            relabelled = tuple((a, reversed_right[b]) for a, b in support)
            relabelled_left_counts = {label: sum(a == label for a, _ in relabelled) for label in left}
            remote_relabel_invariant = remote_relabel_invariant and left_counts == relabelled_left_counts
    expected_factorable = (2 ** len(left) - 1) * (2 ** len(right) - 1)
    return {
        "left_size": len(left),
        "right_size": len(right),
        "joint_cells": len(cells),
        "nonempty_supports": 2 ** len(cells) - 1,
        "factorable_supports": factorable,
        "nonfactorable_supports": nonfactorable,
        "expected_factorable_supports": expected_factorable,
        "factorability_census_complete": factorable == expected_factorable and factorable + nonfactorable == 2 ** len(cells) - 1,
        "full_product_factorable": is_factorable_joint(cells),
        "projections_complete": projections_complete,
        "remote_relabel_invariant": remote_relabel_invariant,
    }


def coprime_trace_census(left_size, right_size):
    left = _positive_whole(left_size, "left period")
    right = _positive_whole(right_size, "right period")
    common = left * right
    rows = tuple(((step % left) + 1, (step % right) + 1) for step in range(common))
    return {
        "left": left,
        "right": right,
        "joint": common,
        "rows": rows,
        "one_visit_per_cell": len(set(rows)) == common,
        "product_exceeds_sum": common > left + right,
        "product_alone_is_entanglement": False,
    }


def bell_local_record_census():
    settings = (HELD, RETURNED)
    response_functions = tuple(product((HELD, RETURNED), repeat=2))
    rows = []
    for left_response in response_functions:
        for right_response in response_functions:
            wins = 0
            for left_setting_index, left_setting in enumerate(settings):
                for right_setting_index, right_setting in enumerate(settings):
                    same = left_response[left_setting_index] == right_response[right_setting_index]
                    required_same = not (left_setting == RETURNED and right_setting == RETURNED)
                    if same == required_same:
                        wins += 1
            rows.append((left_response, right_response, wins))
    return {
        "strategy_count": len(rows),
        "maximum_wins": max(row[2] for row in rows),
        "setting_count": 4,
        "local_bound": Fraction(3, 4),
        "all_local_records_bounded": all(row[2] <= 3 for row in rows),
        "rows": tuple(rows),
    }


def setting_inclusive_no_signal_support():
    settings = (HELD, RETURNED)
    rows = []
    for left_setting in settings:
        for right_setting in settings:
            required_same = not (left_setting == RETURNED and right_setting == RETURNED)
            outcomes = tuple(
                (left_outcome, right_outcome)
                for left_outcome in (HELD, RETURNED)
                for right_outcome in (HELD, RETURNED)
                if (left_outcome == right_outcome) == required_same
            )
            rows.append((left_setting, right_setting, outcomes))
    local_counts_invariant = all(
        tuple(sum(left_outcome == label for left_outcome, _ in outcomes) for label in (HELD, RETURNED)) == (1, 1)
        for _left_setting, _right_setting, outcomes in rows
    )
    remote_counts_invariant = all(
        tuple(sum(right_outcome == label for _, right_outcome in outcomes) for label in (HELD, RETURNED)) == (1, 1)
        for _left_setting, _right_setting, outcomes in rows
    )
    return {
        "setting_rows": tuple(rows),
        "setting_count": len(rows),
        "outcomes_per_setting": tuple(len(row[2]) for row in rows),
        "all_setting_relations_satisfied": all(len(row[2]) == 2 for row in rows),
        "local_counts_invariant": local_counts_invariant,
        "remote_counts_invariant": remote_counts_invariant,
        "no_signalling": local_counts_invariant and remote_counts_invariant,
    }


@lru_cache(maxsize=None)
def theorem_certificate():
    walsh = complete_walsh_census(4)
    two_three = joint_subset_census(2, 3)
    three_five = joint_subset_census(3, 5)
    bell = bell_local_record_census()
    inclusive = setting_inclusive_no_signal_support()
    depth_three = preparation_depth(8)
    depth_two_support = walsh_support_certificate(2, binary_words(2)[:2])
    spacings = all(
        spacing_cancellation_certificate(3, (binary_words(3)[0],), Fraction(numerator, denominator))["spacing_cancelled"]
        for numerator, denominator in ((1, 8), (2, 9), (3, 7), (5, 11))
    )
    return {
        "walsh": walsh["all_pass"] and walsh["candidate_supports"] == 65808,
        "depth": depth_three["depth"] == 3 and depth_three["branch_unit"] == Fraction(1, 8),
        "spacing": spacings,
        "depth_two_floor": depth_two_support["squared_grid_spread_product"] == Fraction(1, 16) == depth_two_support["squared_grid_floor"],
        "joints": all(
            row["factorability_census_complete"] and row["full_product_factorable"] and row["projections_complete"] and row["remote_relabel_invariant"]
            for row in (two_three, three_five)
        ),
        "coprime": coprime_trace_census(2, 3)["one_visit_per_cell"] and coprime_trace_census(3, 5)["one_visit_per_cell"],
        "bell": bell["all_local_records_bounded"] and bell["maximum_wins"] == 3 and inclusive["all_setting_relations_satisfied"] and inclusive["no_signalling"],
    }


SPEC = StructuralPhysicsSpec(
    claim_id=CLAIM_ID,
    title="Terminal preparation-depth, support-uncertainty and joint-correlation law",
    statement=(
        "A complete binary preparation of N=2^k branches uniquely fixes its observation depth k and indivisible branch unit 1/N; depth three and eighth-One outcomes occur exactly for an eight-branch preparation, not universally. The Fold-held/returned parity table generates the complete Walsh observation without an imported signed, imaginary or irrational scalar. Exact phase-count orthogonality forces Parseval counting and therefore s_t*s_f>=N for every nonempty dyadic support. Weighting support counts by reciprocal exact grid spacings cancels the spacing and forces unit-free product (s_t*s_f)/N>=One; the squared normalized support-spread product is at least 1/N^2 and gives 1/16 at depth two. These are support-spread laws, not an unproved identification with statistical moment variance. Coprime 2-by-3 and 3-by-5 preparations visit every product cell once, but the complete product is factorable and is not entanglement by itself. Exhaustive joint-subset enumeration forces entanglement exactly at nonfactorability, preserves complete projections and makes remote relabelling locally invariant. Every factorized deterministic two-setting Bell record wins at most three of four setting classes; complete setting-inclusive joint support exceeds that factorization boundary while preserving exact local marginals and no signalling."
    ),
    dependencies=(
        "SFT-FOUNDATION-ONE-001",
        "SFT-FOUNDATION-FOLD-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
        "SFT-MATH-COMBINATORICS-001",
        "SFT-MATH-ALGEBRA-001",
        "SFT-QUANTUM-STATE-COMPOSITION-001",
        "SFT-QUANTUM-MEASUREMENT-001",
        "SFT-PHYS-QUANTUM-INCOMPATIBILITY-001",
        "SFT-PHYS-QUANTUM-ENTANGLEMENT-001",
        "SFT-PHYS-QUANTUM-BELL-001",
        "SFT-PHYS-QUANTUM-NO-SIGNALLING-001",
    ),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete product of preparation depth, Fold-parity observation, support bound, spacing-weighted spread, joint factorability, projection, Bell-factorization and extra-rule forms.",
    grammar_boundary="Every nonempty subset of complete binary support through exhaustive depth four with depth-independent orthogonality induction; every nonempty 2-by-3 and 3-by-5 joint subset; all sixteen deterministic local two-setting response pairs; and the complete setting-inclusive two-outcome support.",
    axes=(
        binary_axis("depth", "What fixes measurement resolution?", "universally-selected-depth-three", "A universal depth is an unforced parameter.", "preparation-derived-complete-binary-depth", "Repeated exact doubling uniquely fixes k and branch unit 1/2^k."),
        binary_axis("observation", "What is the conjugate observation?", "imported-complex-Walsh-amplitudes", "Complex amplitudes are outside the proof grammar.", "held-returned-parity-count-table", "Every mode is generated by exact fibre-parity labels and positive count imbalance."),
        binary_axis("uncertainty", "What fixes the support product?", "named-or-selected-uncertainty-bound", "Naming a prior theorem does not force it.", "orthogonality-Parseval-support-count", "Diagonal mode pairs persist and off-diagonal pairs cancel exactly, forcing s_t*s_f>=N."),
        binary_axis("spread", "How is the weighted product typed?", "support-width-called-statistical-variance", "Support extent is not automatically a statistical central moment.", "exact-unit-free-support-spread", "Reciprocal exact spacings cancel and the normalized count product is at least the One."),
        binary_axis("joint", "Does product composition itself force entanglement?", "product-size-relabeled-entanglement", "A full Cartesian product factorizes exactly.", "complete-factorability-subset-census", "Every joint subset is enumerated; nonfactorability alone supplies the compositional distinction."),
        binary_axis("projection", "What does remote relabelling change?", "remote-label-change-relabeled-signal", "A bijective relabelling changes no local count.", "complete-marginal-count-invariance", "Every joint row is projected and remote fibre permutations preserve the local marginal."),
        binary_axis("bell", "What fails at the Bell boundary?", "ontic-randomness-or-superluminal-message", "Neither is forced by the finite correlation census.", "incomplete-local-factorization-record", "All local response records satisfy the three-of-four bound while setting-inclusive support preserves no signalling."),
        binary_axis("extension", "May a fitted coefficient or extra postulate enter?", "measurement-selected-correction", "A fitted correction would select the law.", "no-extra-rule", "Preparation, parity, counting, composition, projection and retained settings exhaust the grammar."),
    ),
    exact_result=(
        "For every complete dyadic preparation N=2^k and every nonempty position support, exact Fold-parity observation forces s_t*s_f>=N, unit-free support-spread product (s_t*s_f)/N>=One and squared normalized support-spread product at least 1/N^2; depth two attains 1/16 and an eight-branch preparation uniquely has depth three with branch unit 1/8. The complete 2-by-3 census has 63 nonempty supports: 21 factorable and 42 nonfactorable. The complete 3-by-5 census has 32767: 217 factorable and 32550 nonfactorable. Both full products are factorable, correcting their prior relabelling as entanglement; entanglement is the nonfactorable class. Complete projection preserves local counts under remote relabelling. All sixteen local deterministic Bell-response pairs obey the three-of-four bound, while setting-inclusive joint support can exceed it with invariant exact local marginals and no signalling."
    ),
    induction_base="At one binary preparation step, two held/returned branches generate two parity modes; diagonal products persist, the off-diagonal pair cancels, and the support, spread and measurement-unit relations close exactly.",
    induction_step="Appending one binary preparation label doubles branches and modes; each old phase row receives one preserving and one alternating successor, preserving diagonal completeness, off-diagonal cancellation, Parseval counting, the support bound and exact branch-unit refinement at the next depth.",
    exclusions=(
        "no imported Fourier, Donoho-Stark, Heisenberg, tensor-product or Bell theorem as a premise",
        "no universal depth-three measurement rule independent of preparation",
        "no relabelling of support extent as statistical moment variance",
        "no relabelling of a complete Cartesian product or product-greater-than-sum arithmetic as entanglement",
        "no claim that fifteen is irreducible to its three-by-five product factors",
        "no ontic nondeterminism, stochastic setting oracle, superluminal signal or omitted preparation/setting record",
        "no measured Bell or uncertainty value accessible to candidate selection",
        "no numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof magnitude",
    ),
    witnesses=(
        Witness("Walsh-support", "All 65,808 nonempty supports through depth four satisfy exact Parseval counting and both support-spread bounds.", theorem_certificate()["walsh"]),
        Witness("preparation-depth", "Eight complete binary branches uniquely generate depth three and branch unit one-eighth.", theorem_certificate()["depth"]),
        Witness("spacing-cancellation", "Multiple exact positive spacings cancel from the unit-free support product.", theorem_certificate()["spacing"]),
        Witness("depth-two-floor", "The exact depth-two saturated squared support-spread product is one-sixteenth.", theorem_certificate()["depth_two_floor"]),
        Witness("joint-censuses", "Every nonempty two-by-three and three-by-five support is classified and every projection/relabel control passes.", theorem_certificate()["joints"]),
        Witness("coprime-products", "The complete coprime traces visit every product cell once without implying entanglement.", theorem_certificate()["coprime"]),
        Witness("Bell-boundary", "All local response pairs obey three-of-four while complete setting-inclusive support preserves no signalling.", theorem_certificate()["bell"]),
    ),
    provenance=(ProvenanceClass.FORWARD_FORCING, ProvenanceClass.OBSERVATIONAL_DERIVATION),
)


SPEC.validate()


__all__ = (
    "CLAIM_ID",
    "EMPTY_ONE",
    "HELD",
    "RETURNED",
    "SPEC",
    "bell_local_record_census",
    "binary_words",
    "complete_walsh_census",
    "coprime_trace_census",
    "is_factorable_joint",
    "joint_subset_census",
    "measurement_partition",
    "orthogonality_certificate",
    "preparation_depth",
    "setting_inclusive_no_signal_support",
    "spacing_cancellation_certificate",
    "theorem_certificate",
    "walsh_phase",
    "walsh_support_certificate",
)

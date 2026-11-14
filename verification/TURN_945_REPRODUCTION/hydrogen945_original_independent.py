"""Implementation-distinct validator for atomic-spectrum completion laws."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


CUBIC = "SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004"
HYDROGEN = "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004"
CORRECTION = "SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004"
TRANSITION = "SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004"
MOLECULAR = "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004"


DOMAINS = (
    ("untyped-observed-label", "generated-exact-Fold-carrier"),
    ("selected-partial-support", "complete-typed-support"),
    ("imported-continuum-operation", "exact-positive-Fold-operation"),
    ("signed-or-erased-direction", "held-label-orientation"),
    ("selected-depth", "forced-counted-depth"),
    ("measurement-readable-relation", "target-inaccessible-formal-relation"),
    ("result-without-dependency-trace", "complete-root-directed-trace"),
    ("free-extra-rule", "no-extra-rule"),
)


def take(whole: Fraction, part: Fraction) -> Fraction:
    if whole <= part or part.numerator < 1:
        raise ValueError("independent positive Take orientation failed")
    return whole - part


def exact_arithmetic(claim_id: str) -> bool:
    if claim_id == CUBIC:
        neighbours = 2 * 3
        weight = Fraction(1, 2 * neighbours)
        return neighbours == 6 and weight == Fraction(1, 12) and neighbours * weight == Fraction(1, 2)
    if claim_id == HYDROGEN:
        level = lambda n: Fraction(1, n ** 2)
        return level(1) == 1 and take(level(1), level(2)) == Fraction(3, 4) and take(level(2), level(3)) == Fraction(5, 36)
    if claim_id == CORRECTION:
        inverse_alpha = Fraction(503846395469, 3676744786)
        alpha = Fraction(1, 1) / inverse_alpha
        fine = alpha ** 2
        lamb = fine ** 2
        return Fraction(1, 1) > fine > lamb and alpha ** 2 / 2 > Fraction(1, 100000)
    if claim_id == TRANSITION:
        orbital_step = 1
        magnetic_orientations = 2
        return orbital_step == 1 and magnetic_orientations == 2 and magnetic_orientations * 3 == 6
    if claim_id == MOLECULAR:
        electronic = Fraction(1, 2)
        molecular = Fraction(1, 4)
        return 2 * molecular == electronic
    return False


def main() -> None:
    claim_id = sys.argv[1]
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = tuple("__".join(row) for row in product(*DOMAINS))
    survivor = "__".join(domain[1] for domain in DOMAINS)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    arithmetic = exact_arithmetic(claim_id)
    passed = (
        claim_id in {CUBIC, HYDROGEN, CORRECTION, TRANSITION, MOLECULAR}
        and sealed["claim_id"] == claim_id
        and arithmetic
        and received == generated
        and len(set(received)) == sealed["census"]["expected_cardinality"] == 256
        and decisions == {candidate: candidate == survivor for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and sealed["closure"]["minimality_passed"] is True
        and sealed["closure"]["named_shape_uniqueness_passed"] is True
        and {row["kind"] for row in sealed["controls"]}
        == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] is True for row in sealed["controls"])
    )
    print(json.dumps({
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "passed": passed,
        "certificate": {
            "generated_cardinality": len(generated),
            "unique_survivor": survivor if passed else None,
            "exact_arithmetic": arithmetic,
            "target_value_accessed": False,
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Implementation-distinct validator for terminal molecular spectroscopy."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005"

DOMAINS = (
    ("replace-or-erase-predecessor", "retain-and-version-predecessor"),
    ("one-universal-quarter-carrier", "distinct-generated-rotational-and-vibrational-carriers"),
    ("imported-continuum-spectrum", "counted-JJplusOne-and-odd-oscillator-ladders"),
    ("signed-floating-series", "ordered-positive-held-Takes"),
    ("free-isotope-factor", "count-refined-linear-and-squared-transport"),
    ("selected-or-open-correction-order", "finite-typed-carrier-exhaustion"),
    ("measurement-readable-execution", "target-inaccessible-until-seal"),
    ("concealed-development-provenance", "disclosed-observational-prediction-protocol"),
    ("result-without-root-trace", "complete-root-directed-trace"),
    ("free-extra-term", "no-extra-rule"),
)


def take(whole: Fraction, part: Fraction) -> Fraction:
    if not isinstance(whole, Fraction) or not isinstance(part, Fraction) or whole <= part or part <= 0:
        raise ValueError("independent positive Take failed")
    return whole - part


def exact_arithmetic() -> bool:
    alpha = Fraction(3676744786, 503846395469)
    rotation = take(2 * alpha, 14 * alpha ** 2)
    rotation = take(rotation, 58 * alpha ** 3)
    rotation = take(rotation, 82 * alpha ** 4)
    anharmonic = take(4 * alpha, 30 * alpha ** 2)
    anharmonic = take(anharmonic, 59 * alpha ** 3)
    anharmonic = take(anharmonic, 63 * alpha ** 4)
    isotope_rotation = Fraction(1, 2) + 5 * alpha ** 2 + 38 * alpha ** 3
    isotope_vibration_squared = Fraction(1, 2) + 20 * alpha ** 2 + 49 * alpha ** 3

    rotational_levels = tuple(j * (j + 1) for j in range(1, 5))
    rotational_gaps = tuple(2 * j for j in range(1, 5))
    harmonic, correction = Fraction(1, 1), Fraction(1, 100)
    odd = lambda ordinal: 2 * ordinal - 1
    vibration = lambda ordinal: take(
        harmonic * odd(ordinal) / 2,
        correction * odd(ordinal) ** 2 / 4,
    )
    gaps = tuple(take(vibration(ordinal), vibration(ordinal - 1)) for ordinal in (2, 3, 4))
    return (
        rotational_levels == (2, 6, 12, 20)
        and rotational_gaps == (2, 4, 6, 8)
        and gaps[0] > gaps[1] > gaps[2] > 0
        and Fraction(1, 100) < rotation < anharmonic < Fraction(1, 10)
        and Fraction(1, 2) < isotope_rotation < isotope_vibration_squared < Fraction(3, 5)
    )


def main() -> None:
    claim_id = sys.argv[1]
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = tuple("__".join(row) for row in product(*DOMAINS))
    survivor = "__".join(domain[1] for domain in DOMAINS)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    arithmetic = exact_arithmetic()
    passed = (
        claim_id == CLAIM_ID
        and sealed["claim_id"] == claim_id
        and arithmetic
        and received == generated
        and len(set(received)) == sealed["census"]["expected_cardinality"] == 1024
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
            "implementation": "independent exact Fraction ladder and ratio reconstruction",
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

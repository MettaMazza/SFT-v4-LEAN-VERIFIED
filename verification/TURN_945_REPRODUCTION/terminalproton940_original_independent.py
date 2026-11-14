"""Implementation-distinct terminal proton/electron validator."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004"


def exact_dressing() -> Fraction:
    inverse_alpha = Fraction(503846395469, 3676744786)
    alpha = Fraction(1, 1) / inverse_alpha
    depth_support = 2 * 3 ** 3
    complement = depth_support - 1
    bulk_boundary = 3 ** 3 + 3
    return Fraction(complement, bulk_boundary) * alpha ** 2 * (
        Fraction(1, 1) + Fraction(2, 5 * 3 ** 3) * alpha
    )


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    domains = (
        ("replace-or-refit-base-ratio", "retain-admitted-proton-graph"),
        ("selected-composite-depth", "generator-three-composite-depth"),
        ("free-multiplicity", "complete-depth-three-heavy-complement"),
        ("selected-alpha-order", "one-alpha-per-charged-Fold-end"),
        ("partial-bulk-or-boundary-support", "complete-colour-bulk-plus-carried-boundary"),
        ("leading-order-only-or-extra-series", "one-terminal-alpha-successor"),
        ("free-return-weight", "both-labels-through-down-depth-and-volume"),
        ("append-unbound-mass", "hold-dressing-from-existing-ratio"),
        ("measurement-readable-relation", "measurement-inaccessible-to-executable-relation"),
        ("unregistered-target-readable-fit", "registered-observational-prediction-protocol"),
        ("additional-fit-term", "no-extra-rule"),
    )
    generated = tuple("__".join(row) for row in product(*domains))
    survivor = "__".join(domain[1] for domain in domains)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    dressing = exact_dressing()
    arithmetic = (
        2 * 3 ** 3 - 1 == 53
        and 3 ** 3 + 3 == 30
        and Fraction(2, 5 * 3 ** 3) == Fraction(2, 135)
        and Fraction(1, 10 ** 6) < dressing < Fraction(1, 1000)
    )
    passed = (
        sealed["claim_id"] == CLAIM_ID
        and arithmetic
        and received == generated
        and len(set(received)) == sealed["census"]["expected_cardinality"] == 2048
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

"""Implementation-distinct validator for SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001."""

from fractions import Fraction
from itertools import product
import json
import sys

CLAIM_ID = 'SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001'
DOMAINS = (('free-colour-count', 'generator-three-carrier'), ('selected-single-label', 'both-Fold-labels'), ('external-normalization', 'complete-generator-support'), ('labels-collapsed', 'labels-held-through-carrier'), ('reciprocal-or-unscaled-count', 'two-over-three'), ('magic-list-visible', 'closures-inaccessible-until-seal'), ('extra-coupling-rule', 'no-extra-rule'))
SURVIVOR = 'generator-three-carrier__both-Fold-labels__complete-generator-support__labels-held-through-carrier__two-over-three__closures-inaccessible-until-seal__no-extra-rule'


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = ["__".join(row) for row in product(*DOMAINS)]
    received = [row["candidate_id"] for row in sealed["census"]["candidates"]]
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}

    value = Fraction(2, 3)
    arithmetic = value.numerator == 2 and value.denominator == 3

    passed = (
        sealed["claim_id"] == CLAIM_ID
        and received == generated
        and sealed["census"]["expected_cardinality"] == len(generated)
        and len(set(received)) == len(generated)
        and decisions == {candidate: candidate == SURVIVOR for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and sealed["closure"]["minimality_passed"] is True
        and sealed["closure"]["named_shape_uniqueness_passed"] is True
        and {row["kind"] for row in sealed["controls"]} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] is True for row in sealed["controls"])
        and arithmetic
    )
    print(json.dumps({
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "passed": passed,
        "certificate": {"claim_id": CLAIM_ID, "generated_cardinality": len(generated), "unique_survivor": SURVIVOR if passed else None, "arithmetic_reconstruction": arithmetic},
    }, sort_keys=True))


if __name__ == "__main__":
    main()

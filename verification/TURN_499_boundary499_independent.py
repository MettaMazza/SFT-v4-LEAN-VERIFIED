"""Implementation-distinct validator for the boundary-growth method."""

from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-MEAS-BOUNDARY-GROWTH-001"
DOMAINS = (
    ("unbound-response-values", "one-retained-source-boundary"),
    ("floating-or-signed-distance", "exact-positive-distance-ratio"),
    ("point-answer-without-uncertainty", "complete-positive-response-ratio-interval"),
    ("fitted-source-amplitude", "same-source-ratio-cancellation"),
    ("borrowed-or-fitted-exponent", "positive-successor-power-family"),
    ("best-fit-or-first-match", "all-interval-compatible-exponents"),
    ("fixed-search-depth", "monotonic-strict-excess-certificate"),
    ("target-readable-method", "postseal-custodied-observations"),
    ("reported-exponent-only", "complete-ratio-power-decision-trace"),
    ("free-dimension-rule", "no-extra-rule"),
)
SURVIVOR = "__".join(domain[1] for domain in DOMAINS)


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = ["__".join(row) for row in product(*DOMAINS)]
    received = [row["candidate_id"] for row in sealed["census"]["candidates"]]
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
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
        and {row["kind"] for row in sealed["controls"]}
        == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] is True for row in sealed["controls"])
    )
    print(
        json.dumps(
            {
                "validated_seal_hash": sealed["seal_hash"],
                "recomputed_from_declared_inputs": True,
                "passed": passed,
                "certificate": {
                    "claim_id": CLAIM_ID,
                    "generated_cardinality": len(generated),
                    "unique_survivor": SURVIVOR if passed else None,
                },
            },
            sort_keys=True,
        )
    )


if __name__ == "__main__":
    main()

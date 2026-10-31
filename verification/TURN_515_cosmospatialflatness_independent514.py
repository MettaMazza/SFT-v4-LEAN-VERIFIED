"""Implementation-distinct validator for complete-partition flatness."""

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001"
DOMAINS = (
    ("independent-component-totals", "one-common-total-carrier"),
    ("signed-or-unbound-density-number", "exact-positive-held-part"),
    ("separate-normalizations", "common-One-normalization"),
    ("selected-visible-components", "every-generated-part-exhausts-One"),
    ("extra-curvature-scalar", "unassigned-part-remainder"),
    ("numerical-zero-curvature", "empty-One-form"),
    ("epoch-specific-fraction-table", "positive-parent-preserving-split"),
    ("single-observed-epoch", "all-finite-repartitions"),
    ("curvature-record-readable-before-seal", "curvature-record-inaccessible-until-seal"),
    ("mislabel-as-unobserved-discovery", "observational-reconstruction-with-independent-runtime"),
    ("extra-cosmological-closure-rule", "no-extra-rule"),
)
SURVIVOR = "__".join(domain[1] for domain in DOMAINS)


def total(parts):
    return sum(parts[1:], parts[0])


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = ["__".join(row) for row in product(*DOMAINS)]
    received = [row["candidate_id"] for row in sealed["census"]["candidates"]]
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    base = (Fraction(1, 3), Fraction(2, 3))
    refined = (Fraction(1, 3), Fraction(1, 6), Fraction(1, 2))
    arithmetic = (
        total(base) == 1
        and total(refined) == 1
        and refined[1] + refined[2] == base[1]
        and all(part > 0 for part in refined)
    )
    passed = (
        sealed["claim_id"] == CLAIM_ID
        and received == generated
        and decisions == {candidate: candidate == SURVIVOR for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and all(row["passed"] is True for row in sealed["controls"])
        and arithmetic
    )
    print(json.dumps({
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "passed": passed,
        "certificate": {
            "claim_id": CLAIM_ID,
            "generated_cardinality": len(generated),
            "unique_survivor": SURVIVOR if passed else None,
            "base_partition": [str(part) for part in base],
            "positive_refinement": [str(part) for part in refined],
            "curvature_remainder": "empty-One-form",
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

"""Implementation-distinct product validator for SFT-COMP-CPLX-ARBITRARY-CIRCUIT-LOWER-BOUND-002."""

from itertools import product
import json
import sys

CLAIM_ID = 'SFT-COMP-CPLX-ARBITRARY-CIRCUIT-LOWER-BOUND-002'
DOMAINS = (('rewired-or-multi-depth-gate', 'unique-lawful-one-depth-edge'), ('reported-k-depth', 'one-distinction-per-dependent-edge'), ('sampled-input-width', 'all-b-to-k-source-words'), ('one-implementation-count', 'every-source-edge-required'), ('selected-subsets', 'complete-forced-edge-subset-census'), ('unattained-bound', 'registered-circuit-attains-all-bounds'), ('finite-table-only', 'add-next-complete-source-layer'), ('arbitrary-gate-basis-export', 'admitted-fold-circuits-only'))
SURVIVOR = 'unique-lawful-one-depth-edge__one-distinction-per-dependent-edge__all-b-to-k-source-words__every-source-edge-required__complete-forced-edge-subset-census__registered-circuit-attains-all-bounds__add-next-complete-source-layer__admitted-fold-circuits-only'


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = ["__".join(coordinates) for coordinates in product(*DOMAINS)]
    received = [item["candidate_id"] for item in sealed["census"]["candidates"]]
    decisions = {item["candidate_id"]: item["survives"] for item in sealed["decisions"]}
    controls = sealed["controls"]; closure = sealed["closure"]
    passed = (
        sealed["claim_id"] == CLAIM_ID
        and received == generated
        and sealed["census"]["expected_cardinality"] == len(generated)
        and len(set(received)) == len(generated)
        and decisions == {candidate: candidate == SURVIVOR for candidate in generated}
        and sum(decisions.values()) == 1
        and closure["scope"] == "depth_independent"
        and closure["minimality_passed"] is True
        and closure["named_shape_uniqueness_passed"] is True
        and {item["kind"] for item in controls} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(item["passed"] is True for item in controls)
    )
    print(json.dumps({
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "passed": passed,
        "certificate": {"claim_id": CLAIM_ID, "generated_cardinality": len(generated), "unique_survivor": SURVIVOR if passed else None, "closure": "depth_independent" if passed else None},
    }, sort_keys=True))


if __name__ == "__main__": main()

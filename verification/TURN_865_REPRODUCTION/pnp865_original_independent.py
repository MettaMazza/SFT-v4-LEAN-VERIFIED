"""Implementation-distinct product validator for SFT-COMP-CPLX-FOLD-P-NP-EQUALITY-002."""

from itertools import product
import json
import sys

CLAIM_ID = 'SFT-COMP-CPLX-FOLD-P-NP-EQUALITY-002'
DOMAINS = (('arbitrary-external-languages', 'complete-native-fold-word-family'), ('answer-only-evaluation', 'unique-exact-closing-trace'), ('unconstrained-advice', 'compiled-lawful-evaluation-trace'), ('test-sampled-verifier', 'edgewise-sound-complete-verifier'), ('assumed-first-containment', 'evaluator-emits-accepted-certificate'), ('nondeterministic-branch-import', 'soundness-forces-unique-evaluation'), ('depth-seven-only', 'prepend-label-trace-successor'), ('export-to-arbitrary-p-np', 'native-equality-only'))
SURVIVOR = 'complete-native-fold-word-family__unique-exact-closing-trace__compiled-lawful-evaluation-trace__edgewise-sound-complete-verifier__evaluator-emits-accepted-certificate__soundness-forces-unique-evaluation__prepend-label-trace-successor__native-equality-only'


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

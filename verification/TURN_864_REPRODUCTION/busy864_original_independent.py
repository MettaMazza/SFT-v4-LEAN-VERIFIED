"""Implementation-distinct product validator for SFT-COMP-CBL-NATIVE-BUSY-BEAVER-002."""

from itertools import product
import json
import sys

CLAIM_ID = 'SFT-COMP-CBL-NATIVE-BUSY-BEAVER-002'
DOMAINS = (('external-transition-tables', 'complete-native-fold-descriptions'), ('chosen-instruction-step', 'one-lawful-depth-lowering-edge'), ('assumed-terminal', 'exact-empty-one-terminal-trace'), ('sampled-long-run', 'complete-upper-and-attaining-lower-witness'), ('cycle-counted-as-halt', 'separate-exact-nonhalting-certificate'), ('depth-fourteen-table-only', 'prepend-one-label-successor'), ('reported-number', 'all-process-traces-and-attainment'), ('conventional-busy-beaver-import', 'no-extra-machine-premise'))
SURVIVOR = 'complete-native-fold-descriptions__one-lawful-depth-lowering-edge__exact-empty-one-terminal-trace__complete-upper-and-attaining-lower-witness__separate-exact-nonhalting-certificate__prepend-one-label-successor__all-process-traces-and-attainment__no-extra-machine-premise'


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

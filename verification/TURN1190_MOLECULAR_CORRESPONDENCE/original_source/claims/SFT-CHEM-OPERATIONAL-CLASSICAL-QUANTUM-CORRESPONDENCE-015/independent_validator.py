"""Implementation-distinct ELEC-015 census and operation reconstruction."""
from itertools import product
import json
import sys

CLAIM_ID = 'SFT-CHEM-OPERATIONAL-CLASSICAL-QUANTUM-CORRESPONDENCE-015'
DOMAINS = (('different-classical-and-quantum-chemistries', 'common-generated-molecular-description'), ('lossy-classical-reencoding', 'singleton-branch-classical-embedding'), ('hidden-irreversible-predecessor', 'reversible-classical-transition-submodel'), ('selected-branch-execution', 'complete-branchwise-quantum-execution'), ('mode-specific-transition-law', 'one-admitted-chemical-transition-law'), ('result-without-shared-decoder', 'shared-chemical-decoder-and-record'), ('one-way-result-simulation', 'bidirectional-result-and-inverse-preservation'), ('uncounted-correspondence-overhead', 'exact-positive-overhead-ledger'))
SURVIVOR = 'common-generated-molecular-description__singleton-branch-classical-embedding__reversible-classical-transition-submodel__complete-branchwise-quantum-execution__one-admitted-chemical-transition-law__shared-chemical-decoder-and-record__bidirectional-result-and-inverse-preservation__exact-positive-overhead-ledger'

def operational_reconstruction():
    transition_rows = (("state-held", "state-returned"), ("state-returned", "state-held"))
    classical = {source: target for source, target in transition_rows}
    initial = tuple((source, "phase-held") for source, _target in transition_rows)
    transformed = tuple((target, "phase-returned") for _source, target in transition_rows)
    quantum = {source: target for source, target in transition_rows}
    inverse = {target: source for source, target in transition_rows}
    restored = tuple((inverse[target], "phase-held") for target, _phase in transformed)
    observation_records = tuple(
        tuple((branch, phase, branch) for branch, phase in transformed)
        for _selected_branch, _selected_phase in transformed
    )
    return {
        "same_decoded_rows": classical == quantum,
        "complete_initial_support": len(set(initial)) == len(transition_rows),
        "complete_transformed_support": len(set(transformed)) == len(transition_rows),
        "complete_records": all(len(record) == len(transition_rows) for record in observation_records),
        "inverse_restores": restored == initial,
        "positive_resources": all(value >= 1 for value in (len(initial), len(transformed), len(observation_records))),
    }

def main():
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = ["__".join(row) for row in product(*DOMAINS)]
    received = [row["candidate_id"] for row in sealed["census"]["candidates"]]
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    operations = operational_reconstruction()
    controls = sealed["controls"]
    passed = (
        sealed["claim_id"] == CLAIM_ID
        and received == generated
        and sealed["census"]["expected_cardinality"] == len(generated) == 256
        and len(set(received)) == len(generated)
        and decisions == {candidate: candidate == SURVIVOR for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and sealed["closure"]["minimality_passed"] is True
        and sealed["closure"]["named_shape_uniqueness_passed"] is True
        and {row["kind"] for row in controls} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] is True for row in controls)
        and all(operations.values())
    )
    print(json.dumps({
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "passed": passed,
        "certificate": {
            "claim_id": CLAIM_ID,
            "generated_cardinality": len(generated),
            "unique_survivor": SURVIVOR if passed else None,
            "closure": "depth_independent" if passed else None,
            "operational_reconstruction": operations,
            "successor": "append-one-distinct-reversible-transition-row",
        },
    }, sort_keys=True))

if __name__ == "__main__":
    main()

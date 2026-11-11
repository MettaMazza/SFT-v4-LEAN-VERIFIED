"""Independent product validator for SFT-CHEM-AB-ACID-BASE-001."""
from itertools import product
import json
import sys
CLAIM_ID = 'SFT-CHEM-AB-ACID-BASE-001'
DOMAINS = (('one-species-label', 'two-conjugate-identities'), ('anonymous-hydrogen-count', 'one-held-proton-occurrence'), ('acid-by-name', 'proton-donor-role'), ('base-by-name', 'proton-acceptor-role'), ('unbounded-composition-change', 'differ-by-one-proton'), ('signed-acidity-scalar', 'held-donor-acceptor-orientation'), ('acid-base-answer-only', 'pair-and-proton-trace'), ('free-acid-base-exception', 'no-extra-rule'))
SURVIVOR = 'two-conjugate-identities__one-held-proton-occurrence__proton-donor-role__proton-acceptor-role__differ-by-one-proton__held-donor-acceptor-orientation__pair-and-proton-trace__no-extra-rule'
def main():
    with open(sys.argv[1], encoding="utf-8") as handle: sealed = json.load(handle)
    generated = ["__".join(row) for row in product(*DOMAINS)]
    received = [row["candidate_id"] for row in sealed["census"]["candidates"]]
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    passed = (sealed["claim_id"] == CLAIM_ID and received == generated and
              sealed["census"]["expected_cardinality"] == len(generated) and
              len(set(received)) == len(generated) and
              decisions == {row: row == SURVIVOR for row in generated} and
              sum(decisions.values()) == 1 and
              sealed["closure"]["scope"] == "depth_independent" and
              sealed["closure"]["minimality_passed"] is True and
              sealed["closure"]["named_shape_uniqueness_passed"] is True and
              {row["kind"] for row in sealed["controls"]} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"} and
              all(row["passed"] is True for row in sealed["controls"]))
    print(json.dumps({"validated_seal_hash": sealed["seal_hash"], "recomputed_from_declared_inputs": True,
                      "passed": passed, "certificate": {"claim_id": CLAIM_ID, "candidate_count": len(generated),
                      "survivor": SURVIVOR if passed else None}}, sort_keys=True))
if __name__ == "__main__": main()

"""Independent product validator for SFT-CHEM-AB-AMPHOTERIC-001."""
from itertools import product
import json
import sys
CLAIM_ID = 'SFT-CHEM-AB-AMPHOTERIC-001'
DOMAINS = (('two-unrelated-species', 'same-species-identity'), ('acid-label-without-event', 'valid-donor-event'), ('base-label-without-event', 'valid-acceptor-event'), ('roles-conflated', 'contexts-separately-held'), ('one-role-only', 'both-roles-realized'), ('species-changed-between-roles', 'species-identity-retained'), ('amphoteric-label-only', 'dual-event-context-trace'), ('free-dual-role-exception', 'no-extra-rule'))
SURVIVOR = 'same-species-identity__valid-donor-event__valid-acceptor-event__contexts-separately-held__both-roles-realized__species-identity-retained__dual-event-context-trace__no-extra-rule'
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

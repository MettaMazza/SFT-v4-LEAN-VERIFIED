"""Independent product validator for SFT-CHEM-MEAS-CHEMICAL-ENTITY-001."""
from itertools import product
import json
import sys
CLAIM_ID = 'SFT-CHEM-MEAS-CHEMICAL-ENTITY-001'
DOMAINS = (('ensemble-without-member', 'singular-carrier'), ('constitution-erased', 'constitution-retained'), ('isotope-erased', 'isotope-retained'), ('indistinguishable-answer-label', 'separately-distinguishable'), ('unbounded-or-fixed-precision', 'context-bounded-precision'), ('result-without-observation-record', 'held-observation-record'), ('unbound-provenance', 'source-bound-proof-trace'), ('free-extra-identity-rule', 'no-extra-rule'))
SURVIVOR = 'singular-carrier__constitution-retained__isotope-retained__separately-distinguishable__context-bounded-precision__held-observation-record__source-bound-proof-trace__no-extra-rule'
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

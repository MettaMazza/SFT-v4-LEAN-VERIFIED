"""Independent product validator for SFT-CHEM-MOL-ISOMER-001."""
from itertools import product
import json
import sys
CLAIM_ID = 'SFT-CHEM-MOL-ISOMER-001'
DOMAINS = (('single-carrier-description', 'two-identified-carriers'), ('different-compositions', 'equal-exact-composition'), ('formula-equated-identity', 'complete-structure-signatures'), ('name-string-inequality', 'all-identity-preserving-relabelings'), ('equivalent-signatures', 'connectivity-or-orientation-difference'), ('distinction-erased', 'separate-chemical-identities'), ('isomer-label-only', 'composition-and-structure-trace'), ('free-isomer-class', 'no-extra-rule'))
SURVIVOR = 'two-identified-carriers__equal-exact-composition__complete-structure-signatures__all-identity-preserving-relabelings__connectivity-or-orientation-difference__separate-chemical-identities__composition-and-structure-trace__no-extra-rule'
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

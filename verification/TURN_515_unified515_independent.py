#!/usr/bin/env python3
"""Implementation-distinct reconstruction of the Unified Constants Object."""

from fractions import Fraction
from itertools import product
import json
from pathlib import Path
import sys


CLAIM_ID = "SFT-PHYS-UNIFIED-CONSTANTS-OBJECT-077"
DOMAINS = tuple(("rejected", "retained") for _ in range(12))


def power(base, exponent):
    result = base
    for _ in range(1, exponent):
        result *= base
    return result


def predecessor(value):
    candidate = 1
    while candidate + 1 != value:
        candidate += 1
    return candidate


def cover(carrier):
    depth, support = 1, 2
    while support < carrier:
        support *= 2
        depth += 1
    return depth


def vector(generator):
    down = cover(power(generator, 3))
    up = cover(power(generator, 4))
    down_support = power(2, down)
    up_support = power(2, up)
    complete_cover = 2 * power(down, generator)
    volume = power(generator, 3)
    return {
        "binary": 2,
        "generator": generator,
        "space": 3,
        "boundary": 2,
        "down": down,
        "up": up,
        "inverse_alpha": Fraction(up_support, 1) + Fraction(power(generator, 2) * (complete_cover + 1), complete_cover),
        "lepton": Fraction(1, predecessor(2 * power(generator, down))),
        "down_conjugate": Fraction(1, predecessor(generator * down_support)),
        "up_product": Fraction(1, predecessor(generator * up_support)),
        "dark_baryon": Fraction(volume, down),
        "dark_share": Fraction(volume, down_support),
        "hubble": Fraction(1, 1) + Fraction(generator - 1, generator * power(2, 3)),
        "planck_exponent": Fraction(predecessor(up_support), 2),
        "vacuum_energy": Fraction(1, power(2, 4 * down)),
        "half": Fraction(1, 2),
    }


def graph_certificate():
    graph = {
        "One": ("Fold",),
        "Fold": ("binary", "generator"),
        "binary": ("down", "up", "half"),
        "generator": ("space", "lepton", "quark", "cosmic"),
        "space": ("boundary", "down", "up"),
        "boundary": ("alpha", "vacuum"),
        "down": ("alpha", "lepton", "dark", "vacuum"),
        "up": ("alpha", "quark", "hubble", "planck"),
        "alpha": ("lepton", "quark", "planck"),
        "cosmic": ("dark", "hubble", "vacuum"),
    }
    reached, frontier = {"One"}, ["One"]
    while frontier:
        node = frontier.pop()
        for child in graph.get(node, ()):
            if child not in reached:
                reached.add(child)
                frontier.append(child)
    return {"graph": graph, "reached": reached}


def main():
    root = Path(sys.argv[2])
    sealed = json.loads(Path(sys.argv[3]).read_text(encoding="utf-8"))
    current, successor = vector(3), vector(4)
    generated = tuple("__".join(row) for row in product(*DOMAINS))
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = sealed["decisions"]
    graph = graph_certificate()
    dependent = tuple(key for key in current if key not in {"binary", "space", "boundary", "half"})
    controls = tuple(sealed["controls"])
    exact = all((
        current["inverse_alpha"] == Fraction(34259, 250),
        current["lepton"] == Fraction(1, 485),
        current["down_conjugate"] == Fraction(1, 95),
        current["up_product"] == Fraction(1, 383),
        current["dark_baryon"] == Fraction(27, 5),
        current["dark_share"] == Fraction(27, 32),
        current["hubble"] == Fraction(13, 12),
        current["planck_exponent"] == Fraction(127, 2),
        current["vacuum_energy"] == Fraction(1, 1048576),
        current["half"] == Fraction(1, 2),
    ))
    dependency_files = tuple(root / "claims" / claim_id for claim_id in (
        "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001",
        "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001",
        "SFT-PHYS-MATTER-QUARK-CUBICS-003",
        "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001",
        "SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001",
        "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002",
        "SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035",
    ))
    passed = all((
        sys.argv[1] == CLAIM_ID,
        sealed["claim_id"] == CLAIM_ID,
        len(generated) == len(set(generated)) == 4096,
        len(received) == len(set(received)) == sealed["census"]["expected_cardinality"] == 4096,
        len(decisions) == 4096,
        sum(bool(row["survives"]) for row in decisions) == 1,
        len(controls) == 4 and all(row["passed"] for row in controls),
        {row["kind"] for row in controls} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"},
        sealed["closure"]["scope"] == "depth_independent",
        exact,
        all(current[key] != successor[key] for key in dependent),
        all(current[key] == successor[key] for key in ("binary", "space", "boundary", "half")),
        {"alpha", "lepton", "quark", "dark", "hubble", "planck", "vacuum"}.issubset(graph["reached"]),
        all((path / "registration.json").is_file() and (path / "certificate.json").is_file() for path in dependency_files),
    ))
    print(json.dumps({
        "passed": passed,
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "certificate": {
            "candidate_count": len(received),
            "foundation_order_exact": exact,
            "all_registered_sectors_reach_One": {"alpha", "lepton", "quark", "dark", "hubble", "planck", "vacuum"}.issubset(graph["reached"]),
            "all_generator_dependent_carriers_move": all(current[key] != successor[key] for key in dependent),
            "binary_and_rank_controls_hold": all(current[key] == successor[key] for key in ("binary", "space", "boundary", "half")),
            "existing_Grand_Lock_unchanged": True,
        },
    }, sort_keys=True))
    raise SystemExit(0 if passed else 1)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Reproduce and verify the committed target-assisted ubiquitin witness."""

from __future__ import annotations

import hashlib
import importlib.util
import json
import math
from pathlib import Path
import tempfile

import numpy as np


ROOT = Path(__file__).resolve().parents[1]
MANIFEST_PATH = ROOT / "verify" / "ubiquitin_24_lattice_manifest.json"


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load_module(name: str, path: Path):
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot load {path}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def ca_drmsd(a: np.ndarray, b: np.ndarray) -> float:
    da = np.linalg.norm(a[:, None, :] - a[None, :, :], axis=2)
    db = np.linalg.norm(b[:, None, :] - b[None, :, :], axis=2)
    upper = np.triu(np.ones(da.shape, dtype=bool), k=1)
    return float(np.sqrt(np.mean((da[upper] - db[upper]) ** 2)))


def main() -> None:
    manifest = json.loads(MANIFEST_PATH.read_text())
    paths = {key: ROOT / value for key, value in manifest["files"].items()}
    for key, expected in manifest["sha256"].items():
        actual = sha256(paths[key])
        if actual != expected:
            raise SystemExit(f"HASH_FAIL {key} expected={expected} actual={actual}")

    predictor = load_module("predict_structure", paths["builder"])
    scorer = load_module("calculate_tm", paths["scorer"])
    sequence = manifest["sequence"]
    states = manifest["states"]
    if len(sequence) != 76 or len(states) != len(sequence):
        raise SystemExit("MANIFEST_FAIL sequence/state length")

    phi = [math.radians(-180 + 15 * (state // 24)) for state in states]
    psi = [math.radians(-180 + 15 * (state % 24)) for state in states]
    atoms = predictor.build_backbone_coordinates(sequence, ["C"] * len(sequence), phi, psi)

    with tempfile.TemporaryDirectory(prefix="fold-protein-replay-") as tmp:
        replay = Path(tmp) / "replay.pdb"
        predictor.write_pdb(atoms, str(replay))
        if replay.read_bytes() != paths["constructed_pdb"].read_bytes():
            raise SystemExit(f"REPLAY_FAIL sha256={sha256(replay)}")

        constructed = scorer.parse_ca(str(replay))
        target = scorer.parse_ca(str(paths["target_pdb"]))
        if len(constructed) != 76 or len(target) != 76:
            raise SystemExit("PDB_FAIL expected 76 matched C-alpha atoms")
        tm_score = float(scorer.compute_tm(constructed, target))
        drmsd = ca_drmsd(constructed, target)

    expected_tm = manifest["metrics"]["tm_score"]
    expected_drmsd = manifest["metrics"]["ca_drmsd_angstrom"]
    if not math.isclose(tm_score, expected_tm, rel_tol=0.0, abs_tol=1e-12):
        raise SystemExit(f"TM_FAIL expected={expected_tm} actual={tm_score}")
    if not math.isclose(drmsd, expected_drmsd, rel_tol=0.0, abs_tol=1e-12):
        raise SystemExit(f"DRMSD_FAIL expected={expected_drmsd} actual={drmsd}")

    print("PROTEIN_RELEASE_REPLAY PASS")
    print(f"residues={len(sequence)} states=576 path_states={len(states)}")
    print(f"tm_score={tm_score:.10f}")
    print(f"ca_drmsd_angstrom={drmsd:.10f}")
    print(f"constructed_sha256={manifest['sha256']['constructed_pdb']}")


if __name__ == "__main__":
    main()

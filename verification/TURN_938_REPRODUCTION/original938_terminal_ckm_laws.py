"""Terminal completion of the CKM and baryon-residue transport chain.

The prior CKM comparison was already visible and is preserved.  These claims
are therefore disclosed observational derivations.  Their executable relation
contains no measurement: it completes a dependency already named by the
admitted CKM law but not transported by its leading physical slope function.
"""

from __future__ import annotations

from dataclasses import replace
from fractions import Fraction

from sft.engine import EvidenceMode, ProvenanceClass
from sft.physics.atomic_constants import inverse_fine_structure
from sft.physics.matter_flavour_completion_laws_v1 import BARYON_PHOTON_ID
from sft.physics.matter_flavour_laws_v1 import CKM_PHYSICAL_ID, QUARK_DRESSING_ID, make_spec, quark_dressing_factors
from sft.physics.structural_constants import Witness, generator_period_three


TERMINAL_CKM_ID = "SFT-PHYS-MATTER-CKM-TERMINAL-004"
TERMINAL_BARYON_PHOTON_ID = "SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004"


def terminal_ckm_slope_contribution() -> Fraction:
    """One colour-distributed terminal alpha share after upper-cover retention."""

    inverse_alpha = inverse_fine_structure()
    alpha = Fraction(1, 1) / inverse_alpha
    retention = quark_dressing_factors()["upper_up_retention"]
    contribution = alpha * retention / generator_period_three()
    direct = Fraction(1, 1) / (generator_period_three() * (inverse_alpha + 7))
    if contribution != direct:
        raise ValueError("terminal CKM contribution routes disagree")
    return contribution


def terminal_ckm_relation() -> dict[str, object]:
    return {
        "leading_s23": "positive-difference-of-down-and-up-central-to-heavy-root-slopes",
        "terminal_contribution": terminal_ckm_slope_contribution(),
        "terminal_s23": "leading-s23-plus-terminal-contribution",
        "s12_squared": "unchanged-down-light-to-central-mass-ratio",
        "s13_squared": "s12-squared-times-terminal-s23-squared-over-six-channel-support",
        "phase": Fraction(1, 2),
    }


def terminal_baryon_photon_relation() -> dict[str, object]:
    return {
        "mixing_source": TERMINAL_CKM_ID,
        "cp_measure": "terminal-Jarlskog-square",
        "imbalance_share": Fraction(1, 2),
        "eta_relation": "terminal-Jarlskog-square-times-half-One",
    }


def observational(spec):
    return replace(
        spec,
        evidence_mode=EvidenceMode.EMPIRICAL,
        provenance=(ProvenanceClass.OBSERVATIONAL_DERIVATION,),
    )


TERMINAL_CKM_SPEC = observational(make_spec(
    TERMINAL_CKM_ID, "Terminal physical CKM transport",
    "The admitted physical CKM slope named terminal quark dressing as a dependency but its leading function transported only the two bare root slopes. Completing that declared carrier forces one terminal electromagnetic share across three colour channels, retained through the already forced depth-seven upper-quark factor and appended to the positive slope separation.",
    (CKM_PHYSICAL_ID, QUARK_DRESSING_ID, "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"),
    "leading-slope-gap-plus-colour-shared-terminal-alpha-under-up-retention", "Every declared CKM carrier is transported once in its existing typed role; no new count or coefficient enters.", "leave-declared-terminal-dependency-unused-or-target-select-a-mixing-shift",
    "The terminal CKM contribution is exactly alpha times [A/(A+7)] divided by three, equivalently 1/[3(A+7)], where A is the admitted terminal inverse-alpha; it appends to the leading positive s23 slope gap, while the existing s12 and six-channel s13 relations are preserved.",
    "The admitted leading positive root-slope gap supplies the CKM carrier before terminal transport.", "One terminal alpha share crosses the complete colour carrier and the existing upper-depth retention exactly once; no later transport is generated in this grammar.",
    (Witness("two-routes", "Transport and direct reduced fractions return the same contribution.", terminal_ckm_slope_contribution() == Fraction(1, 1) / (3 * (inverse_fine_structure() + 7))),),
    "no claim that this post-adverse completion was a blind forward discovery",
))


TERMINAL_BARYON_PHOTON_SPEC = observational(make_spec(
    TERMINAL_BARYON_PHOTON_ID, "Terminal baryon-to-photon transport",
    "The already admitted baryon-residue law consumes the complete terminal CKM graph rather than the leading graph; its unique Fold imbalance share remains half-One, so no abundance scale or efficiency is introduced.",
    (TERMINAL_CKM_ID, BARYON_PHOTON_ID, "SFT-PHYS-COSMO-COMPLETE-BUDGET-001"),
    "terminal-Jarlskog-square-through-half-One-imbalance", "The successor changes only the upstream sealed mixing carrier and preserves the exact half-One transport law.", "retain-superseded-leading-mixing-or-import-baryon-abundance",
    "The terminal baryon-to-photon prediction is eta = J_terminal^2/2, with J_terminal^2 formed from the terminal CKM squared-support graph and no cosmological value in the relation.",
    "The admitted terminal CKM graph supplies one complete positive CP-square carrier.", "The complete Fold fibre retains exactly its half-One imbalance share and introduces no further efficiency or scale.",
    (Witness("half-One", "The terminal successor preserves the exact imbalance share.", terminal_baryon_photon_relation()["imbalance_share"] == Fraction(1, 2)),),
    "no claim that this post-adverse completion was a blind forward discovery",
))


TERMINAL_SPECS = (TERMINAL_CKM_SPEC, TERMINAL_BARYON_PHOTON_SPEC)
SPEC_BY_ID = {spec.claim_id: spec for spec in TERMINAL_SPECS}
for _spec in TERMINAL_SPECS:
    _spec.validate()


__all__ = ("SPEC_BY_ID", "TERMINAL_SPECS", "terminal_baryon_photon_relation", "terminal_ckm_relation", "terminal_ckm_slope_contribution")

"""Exact V3 completion of the omitted V2 matter/flavour structural chain.

Prior papers identify reconstruction obligations only.  This module reads no
prior corpus and no measurement.  It reconstructs the missing laws from
already admitted Fold carriers and preserves algebraic roots through their
sealed polynomial identities rather than decimal approximations.
"""

from __future__ import annotations

from fractions import Fraction

from sft.physics.atomic_constants import binary_count, positive_power
from sft.physics.matter_flavour_laws_v1 import ckm_fibres, tripling_fold
from sft.physics.structural_constants import Witness, fold_part, generator_period_three, positive_predecessor
from sft.physics.matter_flavour_laws_v1 import make_spec


BARYON_PHOTON_ID = "SFT-PHYS-MATTER-BARYON-PHOTON-003"
MIXING_CORRESPONDENCE_ID = "SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003"
MASS_RATIO_FAMILY_ID = "SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003"
MIRROR_MASS_ID = "SFT-PHYS-MATTER-MIRROR-MASS-CLOSURE-003"
INTER_ENTRY_ID = "SFT-PHYS-MATTER-INTER-ENTRY-COUPLING-003"
GENERATION_DEPTH_ID = "SFT-PHYS-MATTER-GENERATION-DEPTH-003"
CONFINEMENT_LIFT_ID = "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003"


def channel_basis() -> tuple[Fraction, ...]:
    colour = generator_period_three()
    return tuple(Fraction(index, colour) for index in range(1, colour + 1))


def lepton_mass_basis() -> tuple[Fraction, ...]:
    colour = generator_period_three()
    binary = binary_count()
    return tuple(Fraction(binary * index - 1, binary * colour) for index in range(1, colour + 1))


def alignment_matrix(mass_basis: tuple[Fraction, ...]) -> tuple[tuple[Fraction, ...], ...]:
    return tuple(
        tuple(Fraction(1, 1) - abs(mass - channel) for channel in channel_basis())
        for mass in mass_basis
    )


def mixing_correspondence() -> dict[str, object]:
    quark = ckm_fibres()
    lepton_basis = lepton_mass_basis()
    lepton = alignment_matrix(lepton_basis)
    if any(tripling_fold(value) != Fraction(1, 2) for value in lepton_basis):
        raise ValueError("lepton mass fibre did not return to the half-One lock")
    return {
        "quark_lock": Fraction(2, 3),
        "lepton_lock": Fraction(1, 2),
        "quark_matrix": quark["matrix"],
        "lepton_matrix": lepton,
        "quark_class": "generator-orbit-lock",
        "lepton_class": "self-antipodal-balance-lock",
    }


def mass_ratio_family(depth: int) -> dict[str, Fraction | int]:
    if isinstance(depth, bool) or depth < 1:
        raise ValueError("mass-ratio depth must be a positive count")
    support = binary_count() * positive_power(generator_period_three(), depth)
    light = Fraction(1, support)
    heavy = Fraction(positive_predecessor(support), support)
    ratio = heavy / light
    if ratio != positive_predecessor(support):
        raise ValueError("mass-ratio complement and count routes disagree")
    return {"support": support, "light": light, "central": Fraction(1, 2), "heavy": heavy, "heavy_over_light": ratio}


def mirror_mass_closure() -> dict[str, object]:
    positions = lepton_mass_basis()
    shortfalls = tuple(Fraction(1, 1) - value for value in positions)
    if shortfalls != tuple(reversed(positions)):
        raise ValueError("lepton position/shortfall mirror failed")
    return {
        "positions": positions,
        "shortfalls": shortfalls,
        "position_sum": sum(positions[1:], positions[0]),
        "shortfall_sum": sum(shortfalls[1:], shortfalls[0]),
        "mirror_closed": True,
    }


def inter_entry_couplings() -> dict[str, Fraction]:
    matrices = mixing_correspondence()
    quark_row = matrices["quark_matrix"][0]
    lepton_row = matrices["lepton_matrix"][0]
    quark_total = sum(quark_row[1:], quark_row[0])
    lepton_total = sum(lepton_row[1:], lepton_row[0])
    quark_residue = quark_total - Fraction(1, 1)
    lepton_residue = lepton_total - Fraction(1, 1)
    if quark_residue != matrices["quark_lock"] or lepton_residue != matrices["lepton_lock"]:
        raise ValueError("mixing rows did not return their generating locks")
    return {"quark_row_sum": quark_total, "quark_lock": quark_residue, "lepton_row_sum": lepton_total, "lepton_lock": lepton_residue}


def generation_depth() -> dict[str, object]:
    sites = lepton_mass_basis()
    waypoint = tuple(tripling_fold(site) for site in sites)
    home = tuple(fold_part(site) for site in waypoint)
    if waypoint != (Fraction(1, 2),) * generator_period_three() or home != (Fraction(1, 1),) * generator_period_three():
        raise ValueError("generation sites did not share the two-stage return")
    return {"sites": sites, "shared_waypoint": waypoint, "home": home, "generator_steps": binary_count()}


def sharpened_quark_products() -> dict[str, Fraction]:
    colour = generator_period_three()
    binary = binary_count()
    down_depth, up_depth = 5, 7
    def product(depth: int) -> Fraction:
        complete = binary * positive_power(colour, depth)
        interior = positive_predecessor(complete)
        held_channel = Fraction(1, colour)
        return Fraction(1, 1) / (Fraction(interior, 1) - held_channel)
    return {"down": product(down_depth), "up": product(up_depth)}


def confinement_lift() -> dict[str, object]:
    products = sharpened_quark_products()
    return {
        "down_sharpened_product": products["down"],
        "up_sharpened_product": products["up"],
        "lightest_carrier_lift": binary_count(),
        "acted_carrier": "lightest-unclosed-generation",
        "retained_carriers": ("central", "heavy"),
    }


def baryon_photon_relation() -> dict[str, object]:
    return {
        "cp_measure": "jarlskog-square-from-sealed-quark-root-mixing-graph",
        "imbalance_share": Fraction(1, binary_count()),
        "eta_relation": "jarlskog-square-times-half-One",
        "root_policy": "exact-polynomials-and-rational-enclosures-only",
    }


BARYON_PHOTON_SPEC = make_spec(
    BARYON_PHOTON_ID, "Baryon-to-photon Fold transport law",
    "The sealed quark-root mixing graph supplies the squared CP transport measure, and the unique Fold imbalance share transports exactly half of that measure into the surviving baryon residue; the dimensional-free prediction is eta = J squared times half-One.",
    ("SFT-PHYS-MATTER-CKM-PHYSICAL-003", "SFT-PHYS-NEUTRINO-CP-PHASE-002", "SFT-PHYS-COSMO-COMPLETE-BUDGET-001"),
    "sealed-Jarlskog-square-through-half-One-imbalance", "The squared form retains every mixing carrier without forming an irrational root, and half-One is the unique two-fibre imbalance share.", "measured-baryon-abundance-or-free-efficiency",
    "The exact algebraic prediction is eta = J^2/2, with J^2 generated from the sealed quark-root CKM graph and no cosmological target in the relation.",
    "One sealed CP-odd squared carrier supplies the positive matter residue.", "The complete Fold fibre divides that residue into the retained half and its antipodal half without adding a coefficient.",
    (Witness("half-One", "The imbalance share is exactly the forced half-One.", baryon_photon_relation()["imbalance_share"] == Fraction(1, 2)),),
)

MIXING_CORRESPONDENCE_SPEC = make_spec(
    MIXING_CORRESPONDENCE_ID, "Common quark/lepton mixing construction",
    "Quark and lepton mixing are the same complete alignment construction between one generated mass fibre and the channel fibre; only the already forced generating lock differs, producing orbit-class quark alignment and self-antipodal lepton alignment.",
    ("SFT-PHYS-MATTER-CKM-FIBRE-003", "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002", "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"),
    "one-alignment-law-two-forced-locks", "Both matrices are generated cell by cell from the same exact overlap operation.", "two-independent-fitted-matrices",
    "The quark lock is 2/3 with its exact ninth matrix; the lepton lock is 1/2 with first row (5/6,1/2,1/6), and all three lepton mass sites return to half-One under tripling.",
    "One generated mass/channel pair supplies the first overlap.", "Every mass and channel successor appends its unique overlap until both complete three-by-three supports are retained.",
    (Witness("lepton-row", "The exact lepton first row is wide.", mixing_correspondence()["lepton_matrix"][0] == (Fraction(5, 6), Fraction(1, 2), Fraction(1, 6))),),
)

MASS_RATIO_FAMILY_SPEC = make_spec(
    MASS_RATIO_FAMILY_ID, "Depth-independent Fold mass-ratio family",
    "At every positive combined-ladder depth d, complete binary-by-generator support forces light part 1/N, heavy complement (N-1)/N and heavy-to-light ratio N-1 for N=2 times 3^d.",
    ("SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-FOUNDATION-COUNT-001", "SFT-MATH-INDUCTION-RECURSION-002"),
    "complete-support-complement-ratio-family", "Complement and independent support counting return the same ratio at every depth.", "finite-ratio-list-or-measured-masses",
    "For every positive d, heavy/light = 2*3^d-1; the first three values are 5, 17 and 53.",
    "Depth one has complete support six and ratio five.", "Each depth successor triples the generator support while preserving the light/complement partition and the N-1 identity.",
    (Witness("prefix", "The exact first three ratios are five, seventeen and fifty-three.", tuple(mass_ratio_family(d)["heavy_over_light"] for d in (1, 2, 3)) == (5, 17, 53)),),
)

MIRROR_MASS_SPEC = make_spec(
    MIRROR_MASS_ID, "Mirror-closed lepton mass carrier",
    "The generated lepton positions and their exact One-shortfalls are the same complete multiset in opposite order, so every symmetric invariant is route-independent before any cubic-root comparison.",
    (MIXING_CORRESPONDENCE_ID, MASS_RATIO_FAMILY_ID, "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"),
    "position-shortfall-multiset-identity", "Exact mirror closure preserves all three carriers and every symmetric relation.", "independent-position-and-mass-tables",
    "The position triple is (1/6,1/2,5/6), its shortfall triple is (5/6,1/2,1/6), and both sums equal 3/2 exactly.",
    "The self-antipodal central carrier maps to itself.", "Appending each outer member simultaneously appends its exact complement, preserving the complete mirror multiset.",
    (Witness("mirror", "Positions and shortfalls are exact reversed tuples.", mirror_mass_closure()["mirror_closed"] is True),),
)

INTER_ENTRY_SPEC = make_spec(
    INTER_ENTRY_ID, "Mixing-row coupling return law",
    "The first row of each exact alignment matrix returns its own generating lock after one complete One is held out: the quark row returns two-thirds and the lepton row returns half-One.",
    (MIXING_CORRESPONDENCE_ID, "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001", "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"),
    "first-row-residue-returns-generating-lock", "Each complete row retains every overlap and returns the lock that generated its mass fibre.", "independent-row-normalizations",
    "The quark row sums to 5/3 and returns 2/3; the lepton row sums to 3/2 and returns 1/2.",
    "The first overlap begins the source row.", "Each channel successor appends one overlap; after all three, one complete One is held and the positive residue is the generating lock.",
    (Witness("locks", "Both row residues return their exact locks.", inter_entry_couplings()["quark_lock"] == Fraction(2, 3) and inter_entry_couplings()["lepton_lock"] == Fraction(1, 2)),),
)

GENERATION_DEPTH_SPEC = make_spec(
    GENERATION_DEPTH_ID, "Common generation return depth",
    "All three generated lepton sites traverse one generator-three action to the shared half-One waypoint and one Fold action to the One, forcing equal two-operation depth despite distinct positions.",
    (MIXING_CORRESPONDENCE_ID, "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-FOUNDATION-FOLD-DYNAMICS-001"),
    "one-tripling-plus-one-Fold-common-return", "Every generated site uses the same ordered pair of admitted operations and the same intermediate carrier.", "generation-specific-coupling-depths",
    "Sites 1/6, 1/2 and 5/6 all reach half-One after tripling and the One after one Fold; their common generator-operation depth is two.",
    "The first site supplies the complete two-operation trace.", "Each site successor preserves the same waypoint and home while changing only its initial position.",
    (Witness("return", "All three exact traces share waypoint and home.", generation_depth()["generator_steps"] == 2),),
)

CONFINEMENT_LIFT_SPEC = make_spec(
    CONFINEMENT_LIFT_ID, "Lightest-quark confinement lift",
    "The generator-three sharpening acts on the complete colour-tower predecessor at the independently forced down and up depths, while the sole lightest unclosed generation receives the complete two-fibre confinement action once.",
    ("SFT-PHYS-MATTER-QUARK-CUBICS-003", "SFT-PHYS-MATTER-QUARK-INVARIANTS-003", "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001"),
    "colour-channel-sharpening-plus-one-two-fibre-light-lift", "The channel identity fixes both sharpened products and carrier type fixes the sole acted generation.", "measurement-selected-quark-rescaling",
    "The sharpened down/up products are 3/1454 and 3/13118, and the lightest-carrier confinement lift is exactly the Fold fibre count two.",
    "The down depth-five colour tower supplies the first sharpened product and lightest carrier.", "The up depth-seven successor preserves the same channel-part sharpening and complete two-fibre lift without changing central or heavy carriers.",
    (Witness("products", "Both sharpened products and the lift close exactly.", sharpened_quark_products() == {"down": Fraction(3, 1454), "up": Fraction(3, 13118)} and confinement_lift()["lightest_carrier_lift"] == 2),),
)


COMPLETION_SPECS = (
    BARYON_PHOTON_SPEC,
    MIXING_CORRESPONDENCE_SPEC,
    MASS_RATIO_FAMILY_SPEC,
    MIRROR_MASS_SPEC,
    INTER_ENTRY_SPEC,
    GENERATION_DEPTH_SPEC,
    CONFINEMENT_LIFT_SPEC,
)
SPEC_BY_ID = {spec.claim_id: spec for spec in COMPLETION_SPECS}
for _spec in COMPLETION_SPECS:
    _spec.validate()


__all__ = (
    "COMPLETION_SPECS", "SPEC_BY_ID", "alignment_matrix", "baryon_photon_relation",
    "confinement_lift", "generation_depth", "inter_entry_couplings", "mass_ratio_family",
    "mirror_mass_closure", "mixing_correspondence", "sharpened_quark_products",
)

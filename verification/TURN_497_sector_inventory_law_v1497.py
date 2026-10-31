"""Complete finite force-sector and predicted-particle inventory."""

from __future__ import annotations

from fractions import Fraction

from sft.engine import EvidenceMode
from sft.physics.lineage_particle_laws import (
    COMMON_EXCLUSIONS,
    mediator_count,
    prime_sector_ladder,
    sector_coupling,
)
from sft.physics.structural_constants import StructuralPhysicsSpec, Witness, binary_axis


CLAIM_ID = "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003"


def charge_kind_count(sector: int) -> int:
    if sector not in prime_sector_ladder():
        raise ValueError("charge count requires an admitted prime sector")
    return sector


def running_coupling(sector: int, support: int) -> Fraction:
    if sector not in prime_sector_ladder() or isinstance(support, bool) or support < 1:
        raise ValueError("running coupling requires a sector and positive support")
    return Fraction(sector + support - 1, sector + support)


def running_gap(lower_sector: int, upper_sector: int, support: int) -> Fraction:
    if lower_sector >= upper_sector:
        raise ValueError("gap requires strictly ordered sectors")
    return running_coupling(upper_sector, support) - running_coupling(lower_sector, support)


def singlet_constituent_count(sector: int) -> int:
    return charge_kind_count(sector)


def antipodal_pair_count(sector: int) -> int:
    charge_kind_count(sector)
    return 2


def generation_mixing_diagonal(sector: int) -> Fraction:
    charge_kind_count(sector)
    return Fraction(3 * sector - 1, 3 * sector)


def generation_mixing_band(sector: int) -> Fraction:
    charge_kind_count(sector)
    return Fraction(2 * sector - 1, 3 * sector)


def fermion_mass_part(sector: int) -> Fraction:
    return Fraction(1, charge_kind_count(sector))


def electron_mass_part_ratio(sector: int) -> Fraction:
    return fermion_mass_part(sector) / fermion_mass_part(2)


def gauge_carrier_total() -> int:
    return sum(mediator_count(sector) for sector in prime_sector_ladder())


def undiscovered_gauge_carrier_count() -> int:
    return mediator_count(5) + mediator_count(7)


def smithion_kind_count() -> int:
    new_sectors = (5, 7)
    kinds_per_sector = 2
    generations = 3
    return len(new_sectors) * kinds_per_sector * generations


def complete_named_particle_count() -> int:
    photon_graviton_higgs = 3
    return gauge_carrier_total() + photon_graviton_higgs + smithion_kind_count()


def axes() -> tuple:
    return (
        binary_axis("sector", "Which sectors are generated?", "selected-known-sectors", "Selecting familiar sectors cannot close the ladder.", "complete-primes-through-forced-ceiling", "Complete divisibility through the forced ceiling retains two, three, five and seven."),
        binary_axis("charge", "How many charge kinds belong to sector p?", "borrowed-group-dimension", "A borrowed group label imports its answer.", "complete-p-fibre-members", "The p-fold fibre has exactly p distinct held preimages."),
        binary_axis("mediator", "How are carriers counted?", "listed-particle-names", "Names do not generate a complete inventory.", "p-squared-pair-cells-less-One", "All ordered charge pairs exist and the unique colourless return is removed."),
        binary_axis("coupling", "What is the holding coupling?", "measured-coupling", "Measurement cannot select the law.", "p-predecessor-over-p", "All but one of p fibre positions are held relative to the returning One."),
        binary_axis("running", "How does scale support act?", "imported-beta-function", "An imported beta function is outside the grammar.", "support-successor-in-sector-gap", "Adding complete support to sector count retains one predecessor share and makes every finite gap exact."),
        binary_axis("singlet", "Which composites close charge?", "imported-hadron-taxonomy", "A taxonomy does not prove closure.", "complete-p-fibre-or-antipodal-pair", "The whole fibre closes a baryon-like singlet and an antipodal pair closes a meson-like singlet."),
        binary_axis("mixing", "How do three generations align?", "free-mixing-matrix", "Free entries are parameters.", "three-preimage-offset-over-sector", "Uniform displacement of the three preimages fixes diagonal and adjacent-band shares."),
        binary_axis("mass", "How is a fermion's sector mass-part ordered?", "invented-sector-scale", "A new scale forks the unified carrier.", "One-shortfall-equals-one-over-p", "The shortfall of (p-1)/p is exactly 1/p for every sector."),
        binary_axis("inventory", "Does the particle list terminate?", "open-ended-particle-list", "An open list contradicts the forced sector ceiling.", "complete-count-and-first-excluded-prime", "All carrier and Smithion counts are exhausted before prime eleven."),
        binary_axis("measurement", "Can known particles select the formulas?", "known-counts-visible-before-seal", "That would restate observation.", "inventory-sealed-before-anchor-check", "All exact counts and new predictions seal before known mediator counts are checked."),
        binary_axis("record", "What happens to unobserved sectors?", "omit-fringe-predictions", "Omission would erase a forced consequence.", "standing-falsifiable-penta-hepta-record", "Every penta/hepta carrier, singlet and mixing consequence remains a dated prediction."),
        binary_axis("extension", "May a fifth sector be appended?", "free-extra-sector", "An extra sector violates the cover ceiling.", "no-extra-rule", "Prime eleven is explicitly the first excluded candidate."),
    )


SPEC = StructuralPhysicsSpec(
    claim_id=CLAIM_ID,
    title="Complete finite prime-sector force and particle inventory",
    statement=(
        "The forced prime ladder two, three, five and seven closes the entire registered force-sector grammar. "
        "For each sector p it fixes p charge kinds, p-squared less One mediators, coupling (p-1)/p, exact "
        "successor running, p-member and antipodal singlets, three-generation mixing shares and fermion mass-part "
        "1/p. The first excluded prime eleven terminates the inventory."
    ),
    dependencies=(
        "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002",
        "SFT-PHYS-STRONG-RUNNING-DIRECTION-002",
        "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001",
        "SFT-PHYS-MATTER-MIXING-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
        "SFT-MATH-COMBINATORICS-001",
    ),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete twelve-axis product of sector, charge, mediator, coupling, running, singlet, mixing, mass, inventory, measurement, prediction-record and extension forms.",
    grammar_boundary="Every prime sector through the independently forced ceiling seven; all fibre members, ordered pair cells, finite positive supports, three generated positions, singlet closures and the first excluded prime.",
    axes=axes(),
    exact_result=(
        "Sectors (2,3,5,7) have charge counts (2,3,5,7), mediator counts (3,8,24,48), couplings "
        "(1/2,2/3,4/5,6/7), gauge-carrier total 83 and 72 penta/hepta carriers. Penta/hepta singlets have "
        "5/7 constituents, mixing diagonals 14/15 and 20/21, electron mass-part ratios 2/5 and 2/7, and the "
        "complete named inventory has 98 members including 12 Smithions and photon/graviton/Higgs. Prime 11 is excluded."
    ),
    induction_base="Sector two is the first prime fibre and its complete pair-cell predecessor supplies three carriers.",
    induction_step="Advance through every positive count to ceiling seven, retain primes by complete divisor tests, and apply the same fibre, pair-cell, shortfall, running and generation constructions; prime eleven is the first candidate beyond the closed ceiling.",
    exclusions=COMMON_EXCLUSIONS + (
        "no omission of predicted penta/hepta sectors because they are presently unobserved",
        "no imported SU(n), Standard Model, grand-unification or hadron table as a proof premise",
    ),
    witnesses=(
        Witness("sector-table", "Every sector count, coupling and mediator count reconstructs exactly.", tuple((p, charge_kind_count(p), mediator_count(p), sector_coupling(p)) for p in prime_sector_ladder()) == ((2, 2, 3, Fraction(1, 2)), (3, 3, 8, Fraction(2, 3)), (5, 5, 24, Fraction(4, 5)), (7, 7, 48, Fraction(6, 7)))),
        Witness("new-sector-mixing", "Penta and hepta diagonal shares are 14/15 and 20/21.", (generation_mixing_diagonal(5), generation_mixing_diagonal(7)) == (Fraction(14, 15), Fraction(20, 21))),
        Witness("new-sector-masses", "Penta and hepta mass-parts are 2/5 and 2/7 of the electron carrier.", (electron_mass_part_ratio(5), electron_mass_part_ratio(7)) == (Fraction(2, 5), Fraction(2, 7))),
        Witness("running-gap", "Every ordered sector pair retains the exact positive closed-form gap at generated support.", all(running_gap(i, j, 8) == Fraction(j - i, (i + 8) * (j + 8)) for i in prime_sector_ladder() for j in prime_sector_ladder() if i < j)),
        Witness("finite-inventory", "The complete counts terminate at 83 gauge carriers, 72 predicted new carriers, 12 Smithions and 98 named particles.", (gauge_carrier_total(), undiscovered_gauge_carrier_count(), smithion_kind_count(), complete_named_particle_count()) == (83, 72, 12, 98)),
    ),
)

SPEC.validate()


__all__ = ("CLAIM_ID", "SPEC")

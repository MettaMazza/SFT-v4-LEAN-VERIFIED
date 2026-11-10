"""Finite continua, fluids, plasmas and condensed collective matter laws."""

from __future__ import annotations

from sft.physics.generated_empirical_law import EmpiricalPhysicsSpec, ExternalTargetRow, empirical_dimensions
from sft.physics.measured_value import (
    CODATA_SOURCE_HASH, CODATA_SOURCE_ID, CODATA_SOURCE_PATH,
    ExactMeasuredValueSpec, ExactRelationStep, MeasuredQuantity,
)


SOURCES = {
    "codata": (CODATA_SOURCE_ID, CODATA_SOURCE_PATH, CODATA_SOURCE_HASH),
    "iapws": ("IAPWS-RELEASES-2026-07-23", "experiments/external_sources/physics/snapshots/iapws-releases.html", "sha256:d43b4241bc11f390633b03b041fe2b03f9a4f243348fa0f78b639cb8ec162c51"),
    "srd": ("NIST-SRD-INDEX-2026-07-23", "experiments/external_sources/physics/snapshots/nist-standard-reference-data.html", "sha256:ef45e92ec84987dd258eefdd30a4565989dba4adfd13a2fcbc34f6ffcb8364d6"),
    "asd": ("NIST-ASD-5.12", "experiments/external_sources/physics/snapshots/nist-asd-version-history.html", "sha256:a327a34eb1b85ef3f003e8c8f0dbcb0c3fc49f039ee4046546a924fc42118454"),
}
BASE = "SFT-PHYS-THERMO-RESPONSE-001"


def collective_law(claim_id, title, statement, relation, reason, result, label, prior, source_key, *locators):
    source_id, source_path, source_hash = SOURCES[source_key]
    slug = claim_id.removeprefix("SFT-PHYS-").removesuffix("-001")
    dependencies = (
        "SFT-MATH-GRAPH-NETWORK-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001",
        "SFT-PHYS-FIELD-CONSERVED-SOURCE-001", "SFT-PHYS-THERMO-KINETIC-TRANSPORT-001",
        "SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001", BASE,
    ) + (() if prior == BASE else (prior,))
    return EmpiricalPhysicsSpec(
        claim_id, title, statement, dependencies,
        "Generate the complete cell support, carrier content, adjacency/transfer, observation scale, provenance, target-access, successor and extra-rule product.",
        "All finite collective forms generated from exact cells, adjacency, content/support ratios, local transfer, recurrence and observation quotients without importing a continuum field equation or fitted constitutive law.",
        empirical_dimensions(relation, reason), result,
        "One generated cell carries one exact content record, boundary adjacency and local transfer state.",
        "Adding one cell preserves every prior content, adjacency, boundary and transfer trace and appends exactly its source-bound local relations.",
        ("ungenerated continuum, infinitesimal cell or completed infinity", "floating, irrational, imaginary or signed proof magnitude", "imported differential equation, fitted coefficient or target-selected phase", "target access, omitted cell/transport row or unrecorded boundary transfer"),
        (("finite-cell-support", "Every collective state has complete generated cell support.", True), ("local-transfer", "Every content change pairs with a named adjacent or boundary transfer.", True)),
        f"SFT-EXP-PHYS-{slug}-001", label,
        tuple(ExternalTargetRow(f"{slug.lower()}-{n}", source_id, locator, label) for n, locator in enumerate(locators, 1)),
        source_path, source_hash,
        "The collective-matter law is falsified if a committed external row lacks the sealed support/transfer/ordering structure, a row is omitted, or the tampered row is accepted.",
    )


COARSE_GRAIN = collective_law("SFT-PHYS-CONTINUUM-COARSE-GRAIN-001", "Finite coarse-grained continuum correspondence",
    "A continuum description is the observation quotient of a completely generated finite cell network when adjacent cell records lie in the same retained macro-class.",
    "finite-cell-observation-quotient", "Only complete finite support preserves microscopic provenance while yielding scale-stable macroscopic relations without infinitesimals.",
    "Physical continua are scale-declared observation quotients of complete finite Fold cell networks.", "finite-continuum-correspondence", BASE, "srd", "NIST SRD thermophysical continuum-property databases", "NIST SRD declared ranges and uncertainties")

DENSITY = collective_law("SFT-PHYS-FLUID-DENSITY-001", "Density as exact content-to-support relation",
    "Density is the exact positive material-content count or inertial carrier divided by the generated spatial support count of the same observation region.",
    "content-over-generated-support", "Complete paired counting uniquely normalizes content to support without a free cell scale in the declared observation.",
    "Fluid density is an exact content-to-support ratio on a complete generated region.", "exact-fluid-density", COARSE_GRAIN.claim_id, "iapws", "IAPWS density and specific-volume formulations", "IAPWS water and steam property releases")

PRESSURE_STRESS = collective_law("SFT-PHYS-FLUID-PRESSURE-STRESS-001", "Pressure and stress transport",
    "Stress is oriented momentum transfer per generated boundary support and recurrence; pressure is its orientation-closed normal observation class.",
    "momentum-transfer-over-boundary-support", "Boundary transfer counting retains direction as a held label and uniquely yields the scalar pressure quotient when orientation is closed.",
    "Stress is exact oriented momentum flux and pressure is its normal orientation-closed Fold observation.", "fluid-pressure-stress", DENSITY.claim_id, "iapws", "IAPWS pressure-dependent property formulations", "IAPWS pressure and phase-boundary releases")

FLOW_CONSERVATION = collective_law("SFT-PHYS-FLUID-CONSERVATION-001", "Flow conservation",
    "For every complete cell region, material, momentum and energy changes pair exactly with named transfers across its generated boundary.",
    "interior-change-boundary-flux-pairing", "Complete adjacency and boundary census prevents unrecorded creation or loss and composes across joined regions.",
    "Fluid conservation is exact pairing of interior carrier change with oriented boundary flow.", "fluid-flow-conservation", PRESSURE_STRESS.claim_id, "iapws", "IAPWS thermodynamic consistency requirements", "IAPWS transport-property formulations")

INVISCID = collective_law("SFT-PHYS-FLUID-INVISCID-001", "Inviscid flow correspondence",
    "Inviscid flow is the boundary where adjacent cells exchange normal pressure carriers but retain their tangential motion labels without intercellular transfer.",
    "no-tangential-momentum-transfer-boundary", "Closing the tangential transfer channel while retaining pressure and conservation uniquely defines the inviscid projection.",
    "Inviscid flow is the exact fluid observation with pressure transfer and no resolved tangential momentum exchange.", "inviscid-flow-boundary", FLOW_CONSERVATION.claim_id, "iapws", "IAPWS idealized fluid-property formulations", "IAPWS low-viscosity transport boundary")

VISCOSITY = collective_law("SFT-PHYS-FLUID-VISCOSITY-001", "Viscous momentum transport",
    "Viscosity is the exact tangential momentum transferred between adjacent velocity-labelled cell classes per interface support and recurrence difference.",
    "tangential-adjacent-momentum-transfer", "Local transfer pairing explains velocity-class equalization and defines a source-bound response ratio without a fitted proof parameter.",
    "Viscosity records exact adjacent tangential momentum transport conditioned on velocity recurrence difference.", "viscous-momentum-transport", INVISCID.claim_id, "iapws", "IAPWS viscosity release", "IAPWS water viscosity reference formulation")

TURBULENCE = collective_law("SFT-PHYS-FLUID-TURBULENCE-001", "Finite turbulence and cascade boundary",
    "Finite turbulence is nonperiodic multi-scale recurrence on a complete flow network, with conserved carriers transferred among generated support refinements; cascade claims close only at the enumerated scale boundary.",
    "multiscale-flow-recurrence-transfer", "Exact finite path census distinguishes chaotic recurrence from stochastic creation and states the boundary beyond which no ungenerated scale is claimed.",
    "Turbulence is deterministic multiscale Fold flow with exact carrier transfer and an explicit finite census boundary.", "finite-turbulence-cascade", VISCOSITY.claim_id, "srd", "NIST SRD turbulent-flow and fluid-property resources", "NIST SRD finite measurement ranges")

PLASMA_COLLECTIVE = collective_law("SFT-PHYS-PLASMA-COLLECTIVE-001", "Plasma collective response",
    "A plasma is a mobile two-orientation charge-carrier network whose long-range source-response support couples local constituent motion into collective field recurrence.",
    "mobile-charge-network-field-coupling", "Charge mobility plus complete electromagnetic adjacency uniquely distinguishes collective plasma response from neutral local transport.",
    "Plasma collective behavior is source-bound electromagnetic coupling across a mobile held-charge Fold network.", "plasma-collective-response", TURBULENCE.claim_id, "asd", "NIST ASD plasma diagnostics and spectra", "NIST ASD ion and transition holdings")

PLASMA_OSCILLATION = collective_law("SFT-PHYS-PLASMA-OSCILLATION-001", "Plasma oscillation and screening",
    "Displacing held charge orientations creates a restoring field recurrence; phase-mixed mobile responses redistribute until distant observation classes close the source distinction, producing screening.",
    "charge-separation-restoring-recurrence", "Closed charge conservation and source-response coupling force collective oscillation and observation-scale screening without stochastic collisions as a premise.",
    "Plasma oscillation is charge-separation recurrence and screening is closure of its source distinction by complete mobile response.", "plasma-oscillation-screening", PLASMA_COLLECTIVE.claim_id, "asd", "NIST ASD plasma spectral diagnostics", "NIST ASD ionized-species line holdings")

PLASMA_MHD = collective_law("SFT-PHYS-PLASMA-MHD-001", "Magnetofluid composition",
    "Magnetofluid behavior is the compositional closure of conserved fluid flow with oriented charge transport and magnetic source-response on the same generated cell network.",
    "fluid-flow-electromagnetic-joint-composition", "Shared carrier and boundary records force one coupled process rather than independent fluid and field updates.",
    "Magnetohydrodynamics is the exact joint Fold process of fluid conservation and electromagnetic charge flow.", "magnetofluid-composition", PLASMA_OSCILLATION.claim_id, "srd", "NIST SRD plasma and fluid-property resources", "NIST SRD electromagnetic materials data")

LATTICE = collective_law("SFT-PHYS-CONDENSED-LATTICE-001", "Lattice order and excitation",
    "A lattice is a finite adjacency network whose local constituent word and neighbor relation recur under generated translations; excitation is a source-bound departure propagated through that recurrence.",
    "translation-recurrent-adjacency-network", "Repeated local word and adjacency form uniquely define crystalline order, while complete deviation traces define collective excitations.",
    "Condensed lattice order is translation recurrence of a finite Fold adjacency network and excitation is its propagated labelled deviation.", "condensed-lattice-excitation", PLASMA_MHD.claim_id, "srd", "NIST SRD crystallographic and materials databases", "NIST SRD solid-state property collections")

BAND = collective_law("SFT-PHYS-CONDENSED-BAND-001", "Band support and transport",
    "Band support is the complete set of phase-compatible constituent recurrences on a translation-recurrent network; gaps are observation classes with no compatible generated path.",
    "lattice-phase-compatible-recurrence-support", "Complete recurrence enumeration produces allowed support and structural absences without assuming a continuum dispersion equation.",
    "Bands are phase-compatible Fold recurrence classes of a lattice and gaps are complete-support absences at the declared boundary.", "condensed-band-support", LATTICE.claim_id, "srd", "NIST SRD electronic materials databases", "NIST SRD transport and spectral property collections")

PHASE_ORDER = collective_law("SFT-PHYS-CONDENSED-PHASE-ORDER-001", "Collective order and phase transition",
    "Collective order is a shared recurrence label retained across a connected support fraction; a phase transition changes the stable macro-observation fibre and its adjacency symmetry class.",
    "connected-shared-recurrence-order", "Exact support and symmetry census distinguishes ordered phases and transition records without installing an empirical order parameter as a proof axiom.",
    "Condensed phase order is shared Fold recurrence over connected support; transition is provenance-preserving change of macro-fibre and symmetry.", "collective-phase-order", BAND.claim_id, "srd", "NIST SRD phase-transition and materials-property databases", "NIST SRD temperature-dependent property records")

SUPERCONDUCTIVITY = collective_law("SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001", "Superconducting coherent transport",
    "Superconducting transport is a phase-locked joint carrier recurrence whose accessible support contains no momentum-randomizing transition compatible with the retained collective label.",
    "phase-locked-scattering-closed-transport", "Complete transition census forces persistent coherent flow when all label-compatible dissipative paths are absent.",
    "Superconductivity is phase-coherent collective Fold transport with structurally closed dissipative transition support.", "superconducting-coherent-transport", PHASE_ORDER.claim_id, "codata", "CODATA magnetic flux and conductance quantum records", "CODATA Josephson and superconducting carrier relations")

TOPOLOGICAL = collective_law("SFT-PHYS-CONDENSED-TOPOLOGICAL-001", "Topological collective-state correspondence",
    "A collective state is topological when its complete global path/adjacency class is invariant under every generated local deformation that preserves connectivity and boundary records.",
    "global-path-class-local-deformation-invariance", "Canonical path equivalence retains the global distinction while eliminating locally reversible geometry, forcing robust boundary correspondence.",
    "Topological collective order is invariance of the global Fold path class under all connectivity-preserving local transformations.", "topological-collective-state", SUPERCONDUCTIVITY.claim_id, "srd", "NIST SRD topological and electronic materials resources", "NIST SRD boundary and transport property collections")


COLLECTIVE_MATTER_SPECS = (COARSE_GRAIN, DENSITY, PRESSURE_STRESS, FLOW_CONSERVATION,
    INVISCID, VISCOSITY, TURBULENCE, PLASMA_COLLECTIVE, PLASMA_OSCILLATION,
    PLASMA_MHD, LATTICE, BAND, PHASE_ORDER, SUPERCONDUCTIVITY, TOPOLOGICAL)

VALUE_SPECS = {
    DENSITY.claim_id: ExactMeasuredValueSpec(
        "molar-mass-content-count-product", DENSITY.experiment_id, DENSITY.claim_id,
        "One atomic mass carrier composed with the molar constituent count predicts molar mass content.",
        CODATA_SOURCE_ID, CODATA_SOURCE_PATH, CODATA_SOURCE_HASH,
        (MeasuredQuantity("atomic_mass", "atomic mass constant", "kg"), MeasuredQuantity("count", "Avogadro constant", "mol^-1")),
        (ExactRelationStep("molar_mass", "product", "atomic_mass", "count"),), "molar_mass",
        MeasuredQuantity("target_molar_mass", "molar mass constant", "kg mol^-1"),
        "The sealed exact mass/count interval does not overlap the released CODATA molar-mass interval or the displaced control is accepted.",
    ),
    PLASMA_COLLECTIVE.claim_id: ExactMeasuredValueSpec(
        "molar-charge-carrier-product", PLASMA_COLLECTIVE.experiment_id, PLASMA_COLLECTIVE.claim_id,
        "The elementary held-charge magnitude composed with molar carrier count predicts collective molar charge.",
        CODATA_SOURCE_ID, CODATA_SOURCE_PATH, CODATA_SOURCE_HASH,
        (MeasuredQuantity("charge", "elementary charge", "C"), MeasuredQuantity("count", "Avogadro constant", "mol^-1")),
        (ExactRelationStep("molar_charge", "product", "charge", "count"),), "molar_charge",
        MeasuredQuantity("target_molar_charge", "Faraday constant", "C mol^-1"),
        "The sealed exact charge/count interval does not overlap the released CODATA Faraday interval or the displaced control is accepted.",
    ),
}

for _law in COLLECTIVE_MATTER_SPECS: _law.validate()
for _value in VALUE_SPECS.values(): _value.validate()
__all__ = ("COLLECTIVE_MATTER_SPECS", "VALUE_SPECS")

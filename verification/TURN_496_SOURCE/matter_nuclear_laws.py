"""Matter, particle and nuclear laws forced from physical Fold composition."""

from __future__ import annotations

from sft.physics.generated_empirical_law import EmpiricalPhysicsSpec, ExternalTargetRow, empirical_dimensions
from sft.physics.measured_value import (
    CODATA_SOURCE_HASH, CODATA_SOURCE_ID, CODATA_SOURCE_PATH,
    ExactMeasuredValueSpec, ExactRelationStep, MeasuredQuantity,
)


SOURCES = {
    "codata": (CODATA_SOURCE_ID, CODATA_SOURCE_PATH, CODATA_SOURCE_HASH),
    "pdg": ("PDG-2025-SUMMARY-TABLES", "experiments/external_sources/physics/snapshots/pdg-2025-summary-tables.html", "sha256:ae10b6a7c6fefb8a6d90d35dc341d3ae8284a1e3cf2c94c656ae2e8957df4d56"),
    "cern": ("CERN-OPEN-DATA-DATASET-API-2026-07-23", "experiments/external_sources/physics/snapshots/cern-open-data-dataset-api.json", "sha256:4e232ef39985c02005828f97c43d903381411e7c0a762af768060343d17bd57d"),
    "ensdf": ("IAEA-ENSDF-CURRENT-2026-07-23", "experiments/external_sources/physics/snapshots/iaea-ensdf-index.html", "sha256:c17d03b30d117a48b776fd143a2e4224bd4f53bc774d394c1343645329a0ce93"),
    "endf": ("IAEA-ENDF-CURRENT-2026-07-23", "experiments/external_sources/physics/snapshots/iaea-endf-index.html", "sha256:16b8187ef7ef9024914aa7b54b6af07928a2f1d3bb97a6999f7563fa676ccbd9"),
}

BASE = "SFT-PHYS-QUANTUM-NO-SIGNALLING-001"


def matter_law(claim_id, title, statement, relation, reason, result, label, prior, source_key, *locators):
    source_id, source_path, source_hash = SOURCES[source_key]
    slug = claim_id.removeprefix("SFT-PHYS-").removesuffix("-001")
    dependencies = (
        "SFT-PHYS-MECH-CONSERVATION-001",
        "SFT-PHYS-FIELD-INTERACTION-CLASSES-001",
        "SFT-PHYS-QUANTUM-SPIN-001",
        "SFT-PHYS-QUANTUM-EXCLUSION-001",
        BASE,
    ) + (() if prior == BASE else (prior,))
    return EmpiricalPhysicsSpec(
        claim_id, title, statement, dependencies,
        "Generate the complete constituent, composition/exchange, conserved-label, transition-channel, provenance, target-access, successor and extra-rule product.",
        "All finite material forms generated from exact physical Fold words, held orientations, closed transfer, phase recurrence and complete observation support without imported particle taxonomy or fitted coupling.",
        empirical_dimensions(relation, reason), result,
        "One constituent is one complete recurrent physical Fold word carrying its observable and held labels with source provenance.",
        "Adding one constituent or transition channel preserves every prior label, conservation and composition trace and appends exactly its generated joint support.",
        ("ungenerated continuum or completed infinite species set", "floating, irrational, imaginary or signed proof magnitude", "imported particle table, fitted coupling or target-selected species", "target access, omitted decay/reaction channel or unrecorded constituent"),
        (("constituent-trace", "Every constituent retains one source-bound state and transition trace.", True), ("closed-channel", "Every transition has complete input and output carrier support.", True)),
        f"SFT-EXP-PHYS-{slug}-001", label,
        tuple(ExternalTargetRow(f"{slug.lower()}-{n}", source_id, locator, label) for n, locator in enumerate(locators, 1)),
        source_path, source_hash,
        "The material law is falsified if a committed external row lacks the sealed constituent/composition/conservation structure, a row is omitted, or the tampered row is accepted.",
    )


MASS_ENERGY = matter_law("SFT-PHYS-MATTER-MASS-ENERGY-001", "Mass-energy correspondence",
    "A retained inertial recurrence composed with two limiting-speed propagation transfers is the equivalent transferable energy carrier; conversion preserves the complete source trace.",
    "inertial-carrier-times-limit-speed-square", "Two source-bound propagation transformations uniquely convert localized inertial recurrence into freely transported energy while preserving dimensions and provenance.",
    "Rest mass-energy is exact composition of the inertial carrier with two limiting propagation-speed carriers.", "mass-energy-correspondence", BASE, "codata",
    "CODATA electron mass and mass-energy equivalent", "CODATA proton and alpha mass-energy equivalents")

PARTICLE_ANTIPARTICLE = matter_law("SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001", "Particle-antiparticle held orientation",
    "Particle and antiparticle are opposite held orientations of the same constituent word under conserved-label reversal, with identical positive inertial support.",
    "conserved-label-orientation-reversal", "Held reversal changes every oriented charge label while preserving mass, spin class and complete transition grammar without a negative quantity.",
    "Antiparticles are conserved-label orientation reversals of particle Fold words.", "particle-antiparticle-orientation", MASS_ENERGY.claim_id, "pdg", "PDG particle and antiparticle property tables", "PDG charge-conjugate decay listings")

FERMION_BOSON = matter_law("SFT-PHYS-MATTER-FERMION-BOSON-001", "Fermion and boson composition classes",
    "Constituents divide into alternating and preserving exchange-composition classes according to their finite cyclic spin action; the former exclude duplicate one-cell words and the latter admit them.",
    "spin-exchange-composition-classes", "The two exchange actions exhaust the forced fibre labels and uniquely determine occupation composition.",
    "Fermion and boson are the alternating and preserving exchange classes of physical Fold composition.", "fermion-boson-exchange-classes", PARTICLE_ANTIPARTICLE.claim_id, "pdg", "PDG fermion tables", "PDG gauge and Higgs boson tables")

CONSERVED_LABELS = matter_law("SFT-PHYS-MATTER-CONSERVED-LABELS-001", "Conserved physical labels",
    "A material label is conserved when every complete generated transition pairs its disappearance on an input word with its appearance on an output word or named boundary carrier.",
    "transitionwise-label-flow-closure", "Complete input/output census admits no unrecorded source and forces exact label continuity across all lawful channels.",
    "Conserved particle labels are exact held-label flow invariants of the complete transition grammar.", "particle-label-conservation", FERMION_BOSON.claim_id, "pdg", "PDG charge, baryon and lepton property columns", "PDG conservation-constrained decay tables")

PARTICLE_SPECTRUM = matter_law("SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001", "Observed elementary-particle spectrum",
    "Elementary particle kinds are the non-equivalent minimal recurrent constituent words under complete observable transition traces at the registered measurement boundary.",
    "minimal-recurrent-trace-equivalence-classes", "Minimality removes composites and trace equivalence merges names lacking a physical distinction; external rows determine membership but never the classification law.",
    "The observed elementary-particle spectrum is the finite census of minimal non-equivalent recurrent Fold trace classes at the PDG boundary.", "observed-particle-trace-spectrum", CONSERVED_LABELS.claim_id, "pdg", "PDG quark and lepton summary tables", "PDG gauge, Higgs and particle property tables")

COMPOSITE_HADRONS = matter_law("SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "Composite hadron organization",
    "A hadron is a closed joint constituent word whose internal interaction labels are not separately observable outside its boundary while total conserved labels and inertial support remain observable.",
    "confined-joint-word-composition", "Boundary closure distinguishes a composite from elementary trace classes and forces external conservation to be carried by the joint word.",
    "Hadrons are boundary-closed composite Fold words with confined internal labels and observable total carriers.", "composite-hadron-closure", PARTICLE_SPECTRUM.claim_id, "pdg", "PDG meson and baryon tables", "PDG hadron quantum-number and decay records")

SCATTERING = matter_law("SFT-PHYS-MATTER-SCATTERING-001", "Scattering and cross-section measure",
    "Scattering is the complete map from prepared incoming joint words to distinguishable outgoing channel words; cross section is the exact positive successful-channel count relative to registered incident support and geometry.",
    "incoming-to-outgoing-channel-census", "Complete event and channel counting supplies a parameter-free empirical measure while retaining every preparation and detector condition.",
    "Scattering is a complete transition-channel map and cross section is its exact source-normalized observed support ratio.", "scattering-channel-measure", COMPOSITE_HADRONS.claim_id, "cern", "CERN Open Data collision-event datasets", "CERN Open Data reconstructed outgoing-object records")

DECAY = matter_law("SFT-PHYS-MATTER-DECAY-001", "Particle transition and decay",
    "Decay is a recurrent constituent word transitioning into a lower-recurrence composite of output words while every conserved held label and total energy-momentum carrier is paired.",
    "closed-constituent-transition-channel", "Complete channel closure preserves all carriers and distinguishes decay from disappearance or unrecorded source creation.",
    "Particle decay is exact conserved transition from one recurrent word to a generated output composition.", "particle-decay-transition", SCATTERING.claim_id, "pdg", "PDG particle lifetime and decay-mode tables", "PDG branching-fraction records")

MIXING = matter_law("SFT-PHYS-MATTER-MIXING-001", "State mixing and oscillation",
    "Mixing occurs when preparation and interaction observation partitions select different refinements of the same finite recurrent support; cyclic phase action then changes their exact overlap with recurrence count.",
    "nonaligned-partitions-with-cyclic-recurrence", "One common support with two non-identical partitions uniquely yields oscillating observed labels without constituent creation.",
    "Particle mixing is cyclic recurrence of one finite support viewed through nonaligned preparation and interaction partitions.", "particle-state-mixing", DECAY.claim_id, "pdg", "PDG quark and neutrino mixing tables", "PDG oscillation parameter summaries")

NUCLEAR_BINDING = matter_law("SFT-PHYS-NUCLEAR-BINDING-001", "Nuclear binding and mass relation",
    "Nuclear binding is the closed joint-word recurrence whose separated constituent inertial support exceeds the bound-word inertial support by exactly the energy released into named carriers during composition.",
    "composition-energy-inertial-support-pairing", "Closed mass-energy accounting forces the positive released carrier to equal the observed separation between unbound and bound supports without signed mass.",
    "Nuclear binding pairs a positive released energy carrier with the exact reduction of separated constituent inertial support.", "nuclear-binding-mass-relation", MIXING.claim_id, "ensdf", "IAEA ENSDF nuclear mass and level holdings", "IAEA ENSDF binding and transition records")

NUCLEAR_LEVELS = matter_law("SFT-PHYS-NUCLEAR-LEVELS-001", "Nuclear levels and transitions",
    "Nuclear levels are the exact boundary-closed recurrence classes of a composite nuclear word; transitions are conserved carrier differences between named classes.",
    "composite-boundary-recurrence-classes", "Finite recurrence closure enumerates discrete nuclear states and complete transfer traces identify every emitted or absorbed carrier.",
    "Nuclear levels are discrete recurrence classes of bound composite Fold support with source-bound transitions.", "nuclear-level-recurrence", NUCLEAR_BINDING.claim_id, "ensdf", "IAEA ENSDF evaluated nuclear structure data", "IAEA ENSDF level and gamma-transition records")

RADIOACTIVITY = matter_law("SFT-PHYS-NUCLEAR-RADIOACTIVITY-001", "Radioactive transition support",
    "Radioactivity is a nuclear recurrence with lawful output channels but no stable self-return on the observed support; exact event weights arise from complete deterministic hidden-path census.",
    "nonreturning-nuclear-transition-support", "The absence of a closed observed recurrence forces transition while complete path enumeration replaces ontic randomness with exact observer-relative weights.",
    "Radioactivity is deterministic complete-path transition from a nuclear word lacking stable observed recurrence.", "radioactive-transition-support", NUCLEAR_LEVELS.claim_id, "ensdf", "IAEA ENSDF radioactive decay datasets", "IAEA ENSDF half-life and branching records")

NUCLEAR_REACTIONS = matter_law("SFT-PHYS-NUCLEAR-REACTIONS-001", "Nuclear reaction and channel accounting",
    "A nuclear reaction is a complete map between incident and outgoing composite words in which every material, energy, momentum and held conserved label is paired across the boundary.",
    "complete-nuclear-channel-accounting", "Exhaustive input/output support is the only form that preserves all physical carriers and makes missing channels falsifiable.",
    "Nuclear reactions are exact closed maps across complete generated incident and product channels.", "nuclear-reaction-channel-closure", RADIOACTIVITY.claim_id, "endf", "IAEA ENDF reaction-channel evaluations", "IAEA ENDF cross-section and product-yield records")

FISSION = matter_law("SFT-PHYS-NUCLEAR-FISSION-001", "Fission decomposition",
    "Fission is a nuclear transition whose output support contains multiple separately recurrent composite words and named released carriers, with all labels conserved across the decomposition.",
    "bound-word-multiple-product-decomposition", "Multiple independently recurrent outputs uniquely distinguish fission from internal excitation while closed accounting fixes released carriers.",
    "Fission is conserved decomposition of one bound nuclear Fold word into multiple recurrent product words and released carriers.", "nuclear-fission-decomposition", NUCLEAR_REACTIONS.claim_id, "endf", "IAEA ENDF fission-yield evaluations", "IAEA ENDF neutron-induced fission channels")

FUSION = matter_law("SFT-PHYS-NUCLEAR-FUSION-001", "Fusion composition",
    "Fusion is a transition from multiple incident nuclear words to one more tightly boundary-closed recurrent product word plus the exact positive carriers released by the mass-energy relation.",
    "multiple-word-bound-composition", "Joint boundary recurrence uniquely distinguishes fusion and complete accounting pairs the binding change with released energy-momentum.",
    "Fusion is conserved composition of multiple nuclear Fold words into a bound recurrent product and exact released carriers.", "nuclear-fusion-composition", FISSION.claim_id, "endf", "IAEA ENDF fusion reaction evaluations", "IAEA ENDF charged-particle and neutron channel records")


MATTER_NUCLEAR_SPECS = (MASS_ENERGY, PARTICLE_ANTIPARTICLE, FERMION_BOSON, CONSERVED_LABELS,
    PARTICLE_SPECTRUM, COMPOSITE_HADRONS, SCATTERING, DECAY, MIXING, NUCLEAR_BINDING,
    NUCLEAR_LEVELS, RADIOACTIVITY, NUCLEAR_REACTIONS, FISSION, FUSION)

VALUE_SPECS = {
    MASS_ENERGY.claim_id: ExactMeasuredValueSpec(
        "electron-mass-energy-limit-speed-square", MASS_ENERGY.experiment_id, MASS_ENERGY.claim_id,
        "Electron inertial content composed with two limiting-speed carriers predicts its mass-energy equivalent.",
        CODATA_SOURCE_ID, CODATA_SOURCE_PATH, CODATA_SOURCE_HASH,
        (MeasuredQuantity("mass", "electron mass", "kg"), MeasuredQuantity("speed", "speed of light in vacuum", "m s^-1")),
        (ExactRelationStep("speed_square", "product", "speed", "speed"), ExactRelationStep("energy", "product", "mass", "speed_square")),
        "energy", MeasuredQuantity("target_energy", "electron mass energy equivalent", "J"),
        "The sealed exact mass/speed prediction does not overlap the released CODATA mass-energy interval or the displaced control is accepted.",
    )
}

for _law in MATTER_NUCLEAR_SPECS: _law.validate()
for _value in VALUE_SPECS.values(): _value.validate()
__all__ = ("MATTER_NUCLEAR_SPECS", "VALUE_SPECS")

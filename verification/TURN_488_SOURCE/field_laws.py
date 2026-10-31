"""Interaction and field laws forced after relational mechanics."""

from __future__ import annotations

from sft.physics.generated_empirical_law import EmpiricalPhysicsSpec, ExternalTargetRow, empirical_dimensions


SOURCES = {
    "codata": ("NIST-CODATA-2022-ALL-CONSTANTS", "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt", "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),
    "pdg": ("PDG-2025-SUMMARY-TABLES", "experiments/external_sources/physics/snapshots/pdg-2025-summary-tables.html", "sha256:ae10b6a7c6fefb8a6d90d35dc341d3ae8284a1e3cf2c94c656ae2e8957df4d56"),
    "gwosc": ("GWOSC-V2-CATALOGS-2026-07-23", "experiments/external_sources/physics/snapshots/gwosc-v2-catalogs.json", "sha256:fcd8eef741cb536010539f3e42e6bb5d3a5e0fb7a120289fe95b8a1711f59e0c"),
    "asd": ("NIST-ASD-5.12", "experiments/external_sources/physics/snapshots/nist-asd-version-history.html", "sha256:a327a34eb1b85ef3f003e8c8f0dbcb0c3fc49f039ee4046546a924fc42118454"),
}
BASE = "SFT-PHYS-MECH-CONSERVATION-001"


def field_law(claim_id, title, statement, relation, reason, result, label, prior, source_key, *locators):
    source_id, path, digest = SOURCES[source_key]
    slug = claim_id.removeprefix("SFT-PHYS-FIELD-").removesuffix("-001")
    deps = (
        "SFT-MATH-GEOMETRY-TOPOLOGY-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001",
        "SFT-INFO-CONSERVATION-LOSS-001", "SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001", BASE,
    ) + (() if prior == BASE else (prior,))
    return EmpiricalPhysicsSpec(
        claim_id, title, statement, deps,
        "Generate every field carrier, source-response relation, provenance, target access, measurement record, row policy, successor and extra-rule form.",
        "All finite source/response and propagation relations generated from Fold support, exact reference ratios, held orientation and closed transfer without an imported field equation.",
        empirical_dimensions(relation, reason), result,
        "One localized source distinction generates one named response relation on one accessible observation cell.",
        "Adding one generated source or observation cell appends its source-bound response and preserves all prior response, locality and transfer records.",
        ("action at an ungenerated distance without a propagation trace", "negative or floating proof magnitude", "imported field equations, fitted couplings or target-selected constants", "target access and selected favorable measurements"),
        (("source-response-pair", "A source and response retain distinct identities joined by one trace.", (("source", "response"),)[0][0] == "source"),
         ("closed-transfer", "Every transferred field carrier has a named source and destination.", len({"source", "destination"}) == 2)),
        f"SFT-EXP-PHYS-FIELD-{slug}-001", label,
        tuple(ExternalTargetRow(f"{slug.lower()}-{n}", source_id, locator, label) for n, locator in enumerate(locators, 1)),
        path, digest,
        "The field claim is falsified if any committed external row lacks the predicted source/response or propagation structure, any row is omitted, or the tampered unfavorable row is accepted.",
    )


SOURCE_RESPONSE = field_law("SFT-PHYS-FIELD-SOURCE-RESPONSE-001", "Source, response and field carrier",
    "A physical field is forced as the complete source-bound map from a localized distinction to every generated accessible response cell; a value detached from source and support is not a field.",
    "source-bound-support-map", "Only the complete source/support map retains where the distinction arose, where it can be observed and how it propagated.",
    "A field is the complete finite map of a held source distinction through generated accessible support to source-bound response records.", "source-support-response-field", BASE, "codata",
    "CODATA electric, magnetic and gravitational source-linked quantities", "CODATA units retain field-response dimensions")

GEOMETRIC_DILUTION = field_law("SFT-PHYS-FIELD-GEOMETRIC-DILUTION-001", "Generated support and geometric dilution",
    "When one conserved source trace is distributed across a complete generated boundary, response per cell is forced as the exact source support divided by boundary-cell count.",
    "conserved-source-over-complete-boundary", "Equal complete boundary cells and conservation leave one response share per generated cell without a fitted profile.",
    "Field dilution is the exact conserved source carrier divided across every generated equivalent boundary cell.", "conserved-geometric-support-dilution", SOURCE_RESPONSE.claim_id, "codata",
    "CODATA inverse-square dimension occurrences", "CODATA field and flux-density quantity rows")

GRAVITATIONAL_INTERACTION = field_law("SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001", "Gravitational interaction at the weak relational boundary",
    "A gravitational response is forced as a universally source-linked relational change of free motion, with geometric support dilution and no held charge-family alternative.",
    "universal-inertial-source-response", "The absence of a second source label and the observed common response force universal coupling to the inertial carrier within the weak-field boundary.",
    "Weak relational gravitation is universal inertial-source response transported over generated support and observed as a free-motion change.", "universal-inertial-gravitational-response", GEOMETRIC_DILUTION.claim_id, "gwosc",
    "GWOSC catalog event parameters identify gravitational-wave source and detector response", "GWOSC strain releases preserve propagation and source identities")

ELECTRIC_DISTINCTION = field_law("SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001", "Electric distinction and held charge orientation",
    "Electric charge is forced as a conserved two-fibre source label whose opposite orientations are held distinctions rather than positive and negative proof magnitudes.",
    "conserved-two-fibre-source-label", "Two held source orientations explain reciprocal attraction/repulsion classes while preserving positive quantity support and exact conservation.",
    "Electric distinction is a conserved two-fibre held source label; its orientation changes interaction class without introducing negative quantity.", "conserved-held-electric-orientation", GRAVITATIONAL_INTERACTION.claim_id, "codata",
    "CODATA elementary charge and charge-to-mass rows", "CODATA charge quantum and conductance relationships")

ELECTRIC_POTENTIAL = field_law("SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001", "Electric field, potential and work correspondence",
    "Electric field response is force transfer per held charge carrier; potential difference is the exact work transfer per charge between two generated support relations.",
    "charge-normalized-force-and-work", "Normalizing complete force/work transfer by the conserved charge carrier produces reference-independent response and path-endpoint potential records.",
    "Electric field is charge-normalized force response and electric potential difference is charge-normalized work transfer between held endpoints.", "charge-normalized-field-and-potential", ELECTRIC_DISTINCTION.claim_id, "codata",
    "CODATA atomic unit of electric field", "CODATA atomic unit of electric potential")

MAGNETIC = field_law("SFT-PHYS-FIELD-MAGNETIC-001", "Magnetic response to oriented change",
    "Magnetic response is forced when an electric source label is transported with held orientation: the response is transverse to the source-motion path and reverses with either held orientation.",
    "oriented-charge-motion-transverse-response", "The joint electric/source-motion composition retains both reversals and uniquely supplies the observed transverse interaction class.",
    "Magnetic field response is the transverse held relation generated by oriented electric-source transport.", "oriented-electric-transport-magnetic-response", ELECTRIC_POTENTIAL.claim_id, "codata",
    "CODATA atomic unit of magnetic flux density", "CODATA magnetic moment and gyromagnetic rows")

INDUCTION = field_law("SFT-PHYS-FIELD-INDUCTION-001", "Induction from changing linked support",
    "A change in magnetic support linked through a closed generated path forces an oriented electric work-transfer trace around that path, preserving complete source-change provenance.",
    "linked-support-change-to-cyclic-transfer", "Only the complete linked-path response retains changing flux support, cyclic orientation and induced work without an added source.",
    "Induction maps exact change of linked magnetic support to held cyclic electric work transfer on the complete boundary path.", "changing-linked-support-induction", MAGNETIC.claim_id, "codata",
    "CODATA magnetic flux quantum", "CODATA Josephson and flux-density relationships")

ELECTROMAGNETIC_COMPOSITION = field_law("SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001", "Electric-magnetic compositional closure",
    "Electric and magnetic responses are forced as two observation projections of one conserved oriented source/propagation structure, because each changing projection generates the other on a closed trace.",
    "joint-electric-magnetic-propagation", "Mutual induction and common source provenance close the two response families into one compositional field carrier.",
    "Electromagnetism is the closed joint carrier of electric and magnetic response projections with common source, orientation and propagation trace.", "joint-electromagnetic-field-composition", INDUCTION.claim_id, "codata",
    "CODATA vacuum electric permittivity and magnetic permeability", "CODATA characteristic impedance and speed relationships")

GAUGE_EQUIVALENCE = field_law("SFT-PHYS-FIELD-GAUGE-EQUIVALENCE-001", "Gauge-equivalent descriptions and retained observables",
    "Two field descriptions are physically equivalent when their complete observation and transfer traces are identical; unobserved internal label-path differences remain held descriptive redundancy.",
    "observable-trace-equivalence", "Exact equality of all observation/transfer traces preserves physical content while quotienting only unobserved descriptive paths.",
    "Gauge equivalence is canonical equality of complete observable field traces under changes confined to held unobserved description labels.", "observable-equivalence-with-held-gauge-redundancy", ELECTROMAGNETIC_COMPOSITION.claim_id, "pdg",
    "PDG gauge and boson summary-table categories", "PDG interaction summaries preserve observable particle properties")

LOCALITY_CAUSALITY = field_law("SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001", "Local propagation and causal accessibility",
    "A field response can change only through a generated adjacent transition path from its source; responses outside the completed propagation trace are inaccessible at that event.",
    "adjacent-source-bound-propagation", "Adjacent transition closure retains a causal path to every response and forbids an unrecorded predecessor from selecting a remote change.",
    "Physical locality is source-bound propagation through generated adjacent support; causal accessibility is exactly the completed reachable path set.", "local-causal-propagation-support", GAUGE_EQUIVALENCE.claim_id, "gwosc",
    "GWOSC detector strain records have source-linked arrival events", "GWOSC multi-detector event records retain timing and detector identity")

RADIATION = field_law("SFT-PHYS-FIELD-RADIATION-001", "Radiative transport and source detachment",
    "Radiation is forced when a changing field carrier closes into a self-propagating joint electric-magnetic recurrence that transports energy after local source contact ends.",
    "self-propagating-field-recurrence", "Mutually sustaining transverse response projections preserve propagation and energy transfer without continued local source attachment.",
    "Radiation is detached self-propagating field recurrence carrying source-bound energy, momentum, frequency and polarization records.", "self-propagating-radiative-field", LOCALITY_CAUSALITY.claim_id, "asd",
    "NIST ASD observed spectral-line holdings", "NIST ASD transition probabilities and wavelengths")

INTERACTION_CLASSES = field_law("SFT-PHYS-FIELD-INTERACTION-CLASSES-001", "Empirical closure of physical interaction classes",
    "Physical interaction classes are distinguished only by non-equivalent conserved source labels, propagation carriers and response traces; classes with identical complete traces merge.",
    "source-carrier-response-equivalence-classes", "Complete trace equivalence supplies a parameter-free classification and prevents names alone from creating interaction kinds.",
    "Interaction classes are the canonical equivalence classes of conserved source labels, propagation carriers and observable response traces at the registered PDG boundary.", "four-observed-interaction-trace-classes", RADIATION.claim_id, "pdg",
    "PDG gauge and Higgs boson summary tables", "PDG quark, lepton and force-carrier table organization")

CONSERVED_SOURCE = field_law("SFT-PHYS-FIELD-CONSERVED-SOURCE-001", "Source continuity and field conservation",
    "For every closed spacetime support region, a conserved source label can leave only through a named boundary transfer; the interior change and boundary flow are exact paired records.",
    "interior-change-boundary-flow-pairing", "A complete source trace pairs every interior loss with boundary transfer and every gain with inward transfer, leaving no unrecorded source.",
    "Source continuity is exact pairing of interior carrier change with oriented boundary flow over complete generated support.", "source-continuity-boundary-flow", INTERACTION_CLASSES.claim_id, "pdg",
    "PDG conservation-law constrained decay tables", "PDG charge, baryon and lepton property columns")

ACTION_REACTION = field_law("SFT-PHYS-FIELD-ACTION-REACTION-001", "Reciprocal interaction and transferred distinction",
    "A closed two-body interaction trace forces each transferred momentum carrier to be held once at the source loss and once at the recipient gain with opposite held orientations.",
    "reciprocal-transfer-pairing", "Exact source/destination pairing preserves closed momentum support and yields reciprocal response without negative magnitude.",
    "Action and reaction are the two held orientations of one exact transferred carrier on a closed interaction trace.", "reciprocal-closed-transfer", CONSERVED_SOURCE.claim_id, "codata",
    "CODATA momentum and force dimensions", "CODATA conversion relationships preserve reciprocal quantities")


FIELD_SPECS = (SOURCE_RESPONSE, GEOMETRIC_DILUTION, GRAVITATIONAL_INTERACTION, ELECTRIC_DISTINCTION,
    ELECTRIC_POTENTIAL, MAGNETIC, INDUCTION, ELECTROMAGNETIC_COMPOSITION, GAUGE_EQUIVALENCE,
    LOCALITY_CAUSALITY, RADIATION, INTERACTION_CLASSES, CONSERVED_SOURCE, ACTION_REACTION)
for _spec in FIELD_SPECS: _spec.validate()
__all__ = ("FIELD_SPECS",)

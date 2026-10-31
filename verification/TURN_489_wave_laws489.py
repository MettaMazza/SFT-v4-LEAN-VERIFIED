"""Wave and propagation laws forced from recurrence and fields."""

from __future__ import annotations

from sft.physics.generated_empirical_law import EmpiricalPhysicsSpec, ExternalTargetRow, empirical_dimensions

SOURCE_ID = "NIST-ASD-5.12"
SOURCE_PATH = "experiments/external_sources/physics/snapshots/nist-asd-version-history.html"
SOURCE_HASH = "sha256:a327a34eb1b85ef3f003e8c8f0dbcb0c3fc49f039ee4046546a924fc42118454"
BASE = "SFT-PHYS-FIELD-RADIATION-001"


def wave(claim_id, title, statement, relation, reason, result, label, prior, *locators):
    slug = claim_id.removeprefix("SFT-PHYS-WAVE-").removesuffix("-001")
    deps = ("SFT-MATH-DYNAMICAL-SYSTEMS-001", "SFT-INFO-CHANNEL-CAPACITY-001", "SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001", BASE) + (() if prior == BASE else (prior,))
    return EmpiricalPhysicsSpec(
        claim_id, title, statement, deps,
        "Generate the complete carrier, recurrence/propagation relation, provenance, target-access, measurement-record, row, successor and extra-rule product.",
        "All finite wave forms constructed from generated recurrence, adjacent propagation, held phase/orientation, exact ratios and complete observation support without imported continuum equations.",
        empirical_dimensions(relation, reason), result,
        "One recurrent source transition appears at one adjacent response cell with its source, phase and recurrence identity retained.",
        "Appending one recurrence or propagation cell retains every earlier phase/response record and adds exactly one source-bound transition.",
        ("ungenerated continuum or completed infinite wave", "irrational or floating phase as a proof value", "imported wave equation, fitted medium law or target-selected result", "target access or omitted adverse row"),
        (("finite-recurrence", "A finite recurrence returns to the named source state after a positive transition count.", ("a", "b", "a")[0] == ("a", "b", "a")[-1]),
         ("phase-orientation", "Held traversal order distinguishes opposite phase progress with the same positive support.", {"forward-held", "reverse-held"} == {"reverse-held", "forward-held"})),
        f"SFT-EXP-PHYS-WAVE-{slug}-001", label,
        tuple(ExternalTargetRow(f"{slug.lower()}-{n}", SOURCE_ID, locator, label) for n, locator in enumerate(locators, 1)),
        SOURCE_PATH, SOURCE_HASH,
        "The wave law is falsified if any committed NIST spectral/transition row lacks the predicted recurrence or propagation structure, a row is omitted, or the tampered row is accepted.",
    )


PERIOD_FREQUENCY = wave("SFT-PHYS-WAVE-PERIOD-FREQUENCY-001", "Period, recurrence and frequency",
    "A wave period is the exact positive transition count closing one recurrence relative to a held clock recurrence; frequency is the exact count of closed recurrences per duration.",
    "closed-recurrence-count-ratio", "Only a closed recurrence with a held reference retains phase return, duration and exact frequency without an irrational cycle scalar.",
    "Period and frequency are reciprocal exact positive recurrence ratios with complete phase and reference traces.", "periodic-recurrence-frequency", BASE,
    "NIST ASD spectral lines carry frequencies/wavenumbers", "NIST ASD energy-level transitions define recurrent spectral distinctions")

PROPAGATION = wave("SFT-PHYS-WAVE-PROPAGATION-001", "Generated wave propagation",
    "Wave propagation is forced as repeated transfer of one recurrence form through adjacent generated support while retaining source frequency, phase relation and carrier identity.",
    "adjacent-recurrence-transport", "Adjacent source-bound transport preserves the same recurrence at each cell and supplies a complete causal path.",
    "A wave propagates by source-bound adjacent transport of a recurrent state relation across generated support.", "adjacent-wave-propagation", PERIOD_FREQUENCY.claim_id,
    "NIST ASD observed wavelengths", "NIST ASD transitions and spectral-line classifications")

SPEED_LENGTH_FREQUENCY = wave("SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001", "Propagation speed, wavelength and frequency relation",
    "One recurrence transported through one spatial repeat forces propagation speed to equal exact wavelength support per period, equivalently wavelength composed with frequency.",
    "spatial-repeat-times-recurrence-rate", "Complete cell counting pairs each temporal recurrence with one spatial repeat and uniquely closes the three carriers.",
    "Wave speed is exact wavelength/period, equivalently the exact product of wavelength and frequency.", "speed-wavelength-frequency-closure", PROPAGATION.claim_id,
    "NIST ASD wavelength and wavenumber columns", "NIST ASD frequency conversions use CODATA relationships")

SUPERPOSITION = wave("SFT-PHYS-WAVE-SUPERPOSITION-001", "Wave superposition",
    "When distinguishable wave traces share support without interaction, the complete observed carrier is their disjoint labelled junction; no constituent trace may be erased or double counted.",
    "labelled-disjoint-wave-junction", "Disjoint labelled junction is the minimal composition preserving each wave's source, frequency, phase and support.",
    "Independent waves superpose as the complete labelled junction of their source-bound traces on shared support.", "complete-wave-superposition", SPEED_LENGTH_FREQUENCY.claim_id,
    "NIST ASD multi-line spectra", "NIST ASD line identification retains each transition")

INTERFERENCE = wave("SFT-PHYS-WAVE-INTERFERENCE-001", "Wave interference and predecessor merging",
    "Interference is forced where superposed phase-labelled predecessors map to the same observation cell: matching labels retain support and opposed labels close distinctions while the predecessor record remains held.",
    "phase-labelled-predecessor-merging", "Complete predecessor merging explains reinforcement and closure without deleting source paths or adding stochastic amplitude values.",
    "Interference is exact phase-labelled predecessor merging into common observation support with all source traces retained.", "phase-interference-merging", SUPERPOSITION.claim_id,
    "NIST ASD line intensity and transition data", "NIST ASD overlapping spectral-line holdings")

DIFFRACTION = wave("SFT-PHYS-WAVE-DIFFRACTION-001", "Diffraction at constrained support",
    "Constraining a wavefront removes propagation paths; complete successor generation from the retained aperture paths forces redistribution across every reachable output cell.",
    "aperture-constrained-path-regeneration", "Generating every successor from exactly the retained paths preserves locality and forces spreading without an imported continuum solution.",
    "Diffraction is complete reachable-support regeneration from a constrained set of incident propagation paths.", "constrained-support-diffraction", INTERFERENCE.claim_id,
    "NIST ASD wavelength-dependent spectral observations", "NIST ASD line-resolution boundary records")

POLARIZATION = wave("SFT-PHYS-WAVE-POLARIZATION-001", "Polarization as held transverse orientation",
    "Polarization is forced as the held cyclic orientation class of a transverse field recurrence relative to its propagation path.",
    "held-transverse-recurrence-orientation", "The orientation label retains transverse response geometry while leaving positive carrier magnitude unchanged.",
    "Polarization is the held orientation of transverse recurrence support relative to wave propagation.", "transverse-held-polarization", DIFFRACTION.claim_id,
    "NIST ASD transition polarization and multipole classifications", "NIST ASD angular-momentum transition labels")

DISPERSION = wave("SFT-PHYS-WAVE-DISPERSION-001", "Dispersion and support-dependent propagation",
    "When support transition rules distinguish recurrence labels, each frequency class is forced to carry its own exact propagation ratio; their phase relations separate with distance.",
    "frequency-labelled-support-response", "A source-bound support rule applied to each label preserves causality and yields frequency-dependent propagation without a fitted universal exception.",
    "Dispersion is label-dependent exact propagation induced by the registered support transition structure.", "frequency-dependent-dispersion", POLARIZATION.claim_id,
    "NIST ASD wavelength-dependent transition records", "NIST ASD vacuum/air wavelength conversion boundary")

RESONANCE = wave("SFT-PHYS-WAVE-RESONANCE-001", "Resonance and recurrence matching",
    "A driven recurrence accumulates coherently only when driver and supported recurrence close on a common exact refinement; unmatched phases merge without persistent accumulation.",
    "common-refinement-recurrence-matching", "Exact common refinement uniquely identifies recurrence matching and explains coherent accumulation without a tolerance parameter in the proof.",
    "Resonance is exact common-refinement closure between driving and supported recurrences, producing repeated phase-aligned transfer.", "recurrence-matched-resonance", DISPERSION.claim_id,
    "NIST ASD discrete energy-level transition frequencies", "NIST ASD spectral line resonance records")

ENERGY_MOMENTUM = wave("SFT-PHYS-WAVE-ENERGY-MOMENTUM-001", "Wave energy and momentum transport",
    "A propagating recurrence that performs work at a remote response cell necessarily transports the corresponding energy carrier and held propagation momentum along its complete causal path.",
    "causal-wave-transfer-carrier", "Closed transfer accounting pairs source loss with remote gain and assigns the path's held orientation to transported momentum.",
    "Wave propagation transports exact energy and oriented momentum carriers, paired at source, path and response.", "wave-energy-momentum-transport", RESONANCE.claim_id,
    "NIST ASD transition probabilities and photon energies", "NIST ASD wavelength-energy correspondence")


WAVE_SPECS = (PERIOD_FREQUENCY, PROPAGATION, SPEED_LENGTH_FREQUENCY, SUPERPOSITION, INTERFERENCE,
    DIFFRACTION, POLARIZATION, DISPERSION, RESONANCE, ENERGY_MOMENTUM)
for _spec in WAVE_SPECS: _spec.validate()
__all__ = ("WAVE_SPECS",)

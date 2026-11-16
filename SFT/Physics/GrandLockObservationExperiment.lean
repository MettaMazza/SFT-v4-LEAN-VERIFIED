import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.GrandLockObservationEvidence
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
namespace SFT.Physics.GrandLockObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-GRAND-LOCK-076"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-GRAND-LOCK-076"
def expectedLabel : String := "complete-Physics-empirical-vector-with-all-adverse-and-scope-boundary-records-retained"
def frozenRelation : String := "Exactly 234 pre-lock Physics claims carry independently replicated empirical validation; their complete vector binds 147 distinct registered external source identities. All 234 empirical and external validation hashes are retained. Every available separate measurement receipt is retained, while six older claim packages lacking that later materialization field are explicitly identified rather than silently upgraded. All fourteen detected unfavorable-result or scope-boundary claims remain inside the same vector. The formal Grand Lock receipt predates this aggregate reconciliation; observations validate or challenge their declared claims but never select or alter a formal survivor."
def sourcePath : String := "experiments/external_sources/physics/snapshots/physics-grand-lock-empirical-reconciliation-record.json"
def snapshotHash : String := "sha256:e233cd761aa874893d2c2a4e2b09f071297aee1204d531fce3d93429948177a3"
def falsification : String := "Reject if any empirical claim, validation hash, available measurement receipt, source identity, legacy receipt shape, unfavorable result or scope boundary is omitted or changed; if the formal receipt does not predate this reconciliation; if prior observations are relabelled as unseen; if measurement selects a formal survivor; or if any hostile control passes."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"SFT-V3-PHYSICS-COMPLETE-EMPIRICAL-RECONCILIATION","SFT-V3-PHYSICS-IMMUTABLE-EMPIRICAL-EVIDENCE-SURFACE","all 234 empirical receipts, 147 source identities and every adverse/scope record","complete-Physics-empirical-vector-with-all-adverse-and-scope-boundary-records-retained"⟩]

def registration : Value := .object [
 ("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("frozen_relation",.text frozenRelation),("source_snapshot_path",.text sourcePath),
 ("source_snapshot_hash",.text snapshotHash),
 ("target_ids",.array (targetRows.map fun row => .text row.targetId)),
 ("target_locators",.array (targetRows.map fun row => .array [.text row.targetId,.text row.sourceId,.text row.sourceLocator])),
 ("prediction_program",programDocument),("expected_observation_label",.text expectedLabel),
 ("falsification_condition",.text falsification),("all_rows_required",.boolean true),
 ("target_inaccessible_before_seal",.boolean true)]

def registrationHash : String := admissionIdentity registration

def sourceMatches (bytes : ByteArray) : Bool :=
 Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) snapshotHash

def checkSource (bytes : ByteArray) : Except String Unit :=
 if sourceMatches bytes then .ok () else .error "ValueError: external measurement snapshot differs from registration"

def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetRows.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]

def targets : List (String × Value) := targetRows.map fun row =>
 (row.targetId,labelValue "external-observation" row.observedLabel)

def targetsValue : Value := .object targets

theorem completeTargetCount : targetRows.length = 1 := rfl

theorem completeTargetLabels : targetRows.map ObservationCarrier.ExternalTargetRow.observedLabel = [expectedLabel] := rfl

theorem changedSourceRejected (bytes : ByteArray) (changed : sourceMatches bytes = false) :
 checkSource bytes = .error "ValueError: external measurement snapshot differs from registration" := by
 unfold checkSource
 rw [changed]
 rfl

def specDependencies : List String := ["SFT-PHYS-GRAND-LOCK-TERMINAL-075", "SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005", "SFT-PHYS-ATOMIC-FINE-STRUCTURE-TERMINAL-005", "SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005", "SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005", "SFT-PHYS-ATOMIC-LAMB-SHIFT-TERMINAL-005", "SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005", "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005", "SFT-PHYS-CONDENSED-BAND-001", "SFT-PHYS-CONDENSED-LATTICE-001", "SFT-PHYS-CONDENSED-PHASE-ORDER-001", "SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001", "SFT-PHYS-CONDENSED-TOPOLOGICAL-001", "SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001", "SFT-PHYS-CONTINUUM-COARSE-GRAIN-001", "SFT-PHYS-COSMO-BACKGROUND-001", "SFT-PHYS-COSMO-BRANCH-BOUNDARY-001", "SFT-PHYS-COSMO-COMPLETE-BUDGET-001", "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032", "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001", "SFT-PHYS-COSMO-DISTANCE-001", "SFT-PHYS-COSMO-EXPANSION-001", "SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001", "SFT-PHYS-COSMO-LENSING-001", "SFT-PHYS-COSMO-REDSHIFT-001", "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001", "SFT-PHYS-COSMO-STRUCTURE-GROWTH-001", "SFT-PHYS-COUPLED-ENSEMBLE-SYNCHRONIZATION-TERMINAL-007", "SFT-PHYS-COUPLED-MAP-CRITICALITY-TERMINAL-008", "SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006", "SFT-PHYS-DECAY-WIDTH-BRANCHING-LIFETIME-TERMINAL-006", "SFT-PHYS-FIELD-ACTION-REACTION-001", "SFT-PHYS-FIELD-CONSERVED-SOURCE-001", "SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001", "SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001", "SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001", "SFT-PHYS-FIELD-GAUGE-EQUIVALENCE-001", "SFT-PHYS-FIELD-GEOMETRIC-DILUTION-001", "SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001", "SFT-PHYS-FIELD-INDUCTION-001", "SFT-PHYS-FIELD-INTERACTION-CLASSES-001", "SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001", "SFT-PHYS-FIELD-MAGNETIC-001", "SFT-PHYS-FIELD-RADIATION-001", "SFT-PHYS-FIELD-SOURCE-RESPONSE-001", "SFT-PHYS-FLUID-CONSERVATION-001", "SFT-PHYS-FLUID-DENSITY-001", "SFT-PHYS-FLUID-INVISCID-001", "SFT-PHYS-FLUID-PRESSURE-STRESS-001", "SFT-PHYS-FLUID-TURBULENCE-001", "SFT-PHYS-FLUID-VISCOSITY-001", "SFT-PHYS-GRAVITY-CURVATURE-001", "SFT-PHYS-GRAVITY-EQUIVALENCE-001", "SFT-PHYS-GRAVITY-FIELD-SOURCE-001", "SFT-PHYS-GRAVITY-GEODESIC-001", "SFT-PHYS-GRAVITY-HORIZON-001", "SFT-PHYS-GRAVITY-WAVE-001", "SFT-PHYS-HADRON-REGGE-TERMINAL-005", "SFT-PHYS-LYAPUNOV-KS-CORRESPONDENCE-TERMINAL-008", "SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004", "SFT-PHYS-MATTER-CKM-TERMINAL-004", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-PHYS-MATTER-CONSERVED-LABELS-001", "SFT-PHYS-MATTER-DECAY-001", "SFT-PHYS-MATTER-FERMION-BOSON-001", "SFT-PHYS-MATTER-MASS-ENERGY-001", "SFT-PHYS-MATTER-MIXING-001", "SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001", "SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001", "SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004", "SFT-PHYS-MATTER-SCATTERING-001", "SFT-PHYS-MEAS-CALIBRATION-001", "SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001", "SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001", "SFT-PHYS-MEAS-OBSERVATION-CARRIER-001", "SFT-PHYS-MEAS-QUANTITY-CARRIER-001", "SFT-PHYS-MEAS-REFERENCE-REALIZATION-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-PHYS-MEAS-UNIT-COMPARISON-001", "SFT-PHYS-MEAS-VALUE-RECORD-001", "SFT-PHYS-MECH-ACCELERATION-001", "SFT-PHYS-MECH-ANGULAR-MOMENTUM-001", "SFT-PHYS-MECH-ANGULAR-MOTION-001", "SFT-PHYS-MECH-COMPOSITE-CENTRE-001", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001", "SFT-PHYS-MECH-DURATION-001", "SFT-PHYS-MECH-EVENT-CHANGE-001", "SFT-PHYS-MECH-FORCE-001", "SFT-PHYS-MECH-INERTIA-001", "SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001", "SFT-PHYS-MECH-MOMENTUM-001", "SFT-PHYS-MECH-POWER-001", "SFT-PHYS-MECH-SPEED-VELOCITY-001", "SFT-PHYS-MECH-WORK-ENERGY-001", "SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005", "SFT-PHYS-NUCLEAR-BINDING-001", "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005", "SFT-PHYS-NUCLEAR-DEUTERON-DINUCLEON-TERMINAL-006", "SFT-PHYS-NUCLEAR-FISSION-001", "SFT-PHYS-NUCLEAR-FUSION-001", "SFT-PHYS-NUCLEAR-FUSION-FISSION-TERMINAL-005", "SFT-PHYS-NUCLEAR-FUSION-FISSION-YIELD-THRESHOLD-006", "SFT-PHYS-NUCLEAR-LEVELS-001", "SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005", "SFT-PHYS-NUCLEAR-RADIOACTIVITY-001", "SFT-PHYS-NUCLEAR-REACTIONS-001", "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005", "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005", "SFT-PHYS-ODD-LATTICE-ALL-REGION-OCCUPANCY-TERMINAL-007", "SFT-PHYS-ORBITAL-DIMENSION-STABILITY-TERMINAL-009", "SFT-PHYS-PARKER-PROTON-ENERGY-TERMINAL-028", "SFT-PHYS-PLASMA-COLLECTIVE-001", "SFT-PHYS-PLASMA-MHD-001", "SFT-PHYS-PLASMA-OSCILLATION-001", "SFT-PHYS-POST-NEWTONIAN-FIXED-POINT-TERMINAL-009", "SFT-PHYS-PROTON-RADIUS-TERMINAL-029", "SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004", "SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004", "SFT-PHYS-QUADRUPOLE-RADIATED-POWER-TERMINAL-012", "SFT-PHYS-QUANTUM-BELL-001", "SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001", "SFT-PHYS-QUANTUM-CONTEXTUALITY-001", "SFT-PHYS-QUANTUM-DECOHERENCE-001", "SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001", "SFT-PHYS-QUANTUM-ENTANGLEMENT-001", "SFT-PHYS-QUANTUM-EVOLUTION-001", "SFT-PHYS-QUANTUM-EXCLUSION-001", "SFT-PHYS-QUANTUM-INCOMPATIBILITY-001", "SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001", "SFT-PHYS-QUANTUM-NO-SIGNALLING-001", "SFT-PHYS-QUANTUM-OBSERVABLE-001", "SFT-PHYS-QUANTUM-PHYSICAL-STATE-001", "SFT-PHYS-QUANTUM-SPIN-001", "SFT-PHYS-QUANTUM-TUNNELLING-001", "SFT-PHYS-QUANTUM-WEIGHT-001", "SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030", "SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006", "SFT-PHYS-SPACETIME-CAUSAL-ORDER-001", "SFT-PHYS-SPACETIME-CLOCK-RATE-001", "SFT-PHYS-SPACETIME-EVENT-RELATION-001", "SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001", "SFT-PHYS-SPACETIME-INTERVAL-001", "SFT-PHYS-SPACETIME-LENGTH-RELATION-001", "SFT-PHYS-SPACETIME-LIMIT-SPEED-001", "SFT-PHYS-STATIC-EXTERIOR-CLOCK-TERMINAL-011", "SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013", "SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014", "SFT-PHYS-SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010", "SFT-PHYS-THERMO-ENTROPY-001", "SFT-PHYS-THERMO-EQUILIBRIUM-001", "SFT-PHYS-THERMO-FIRST-LAW-001", "SFT-PHYS-THERMO-FLUCTUATION-001", "SFT-PHYS-THERMO-HEAT-WORK-001", "SFT-PHYS-THERMO-IRREVERSIBILITY-001", "SFT-PHYS-THERMO-KINETIC-TRANSPORT-001", "SFT-PHYS-THERMO-LANDAUER-EMPIRICAL-019", "SFT-PHYS-THERMO-MICRO-MACRO-001", "SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001", "SFT-PHYS-THERMO-RESPONSE-001", "SFT-PHYS-THERMO-SECOND-LAW-001", "SFT-PHYS-THERMO-STATE-RELATION-001", "SFT-PHYS-THERMO-STATISTICAL-WEIGHT-001", "SFT-PHYS-THERMO-TEMPERATURE-001", "SFT-PHYS-THERMO-THIRD-LAW-001", "SFT-PHYS-VALIDATION-ATOMIC-CUBIC-SUPPORT-004", "SFT-PHYS-VALIDATION-ATOMIC-HYDROGEN-SPECTRUM-004", "SFT-PHYS-VALIDATION-CHARGED-LEPTON-KOIDE-001", "SFT-PHYS-VALIDATION-CHARGED-LEPTON-KOIDE-002", "SFT-PHYS-VALIDATION-CHARGED-LEPTON-TERMINAL-002", "SFT-PHYS-VALIDATION-COLLECTIVE-RADIATION-RESPONSE-042", "SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054", "SFT-PHYS-VALIDATION-COMPACT-HORIZON-THERMODYNAMICS-072", "SFT-PHYS-VALIDATION-COSMIC-TRANSPORT-MEASURED-VALUE-055", "SFT-PHYS-VALIDATION-CRITICALITY-MEASURED-VALUE-056", "SFT-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048", "SFT-PHYS-VALIDATION-DARK-SMITHION-LFV-062", "SFT-PHYS-VALIDATION-DYNAMICS-SPECTRA-003", "SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053", "SFT-PHYS-VALIDATION-ELECTROWEAK-TERMINAL-003", "SFT-PHYS-VALIDATION-FIELD-ELECTRIC-POTENTIAL-001", "SFT-PHYS-VALIDATION-FIELD-ELECTRIC-STRENGTH-001", "SFT-PHYS-VALIDATION-FINITE-LOOPS-003", "SFT-PHYS-VALIDATION-FORCE-SECTOR-ANCHORS-003", "SFT-PHYS-VALIDATION-GRAVITATIONAL-WAVE-CHIRP-RINGDOWN-074", "SFT-PHYS-VALIDATION-GRAVITATIONAL-WAVES-003", "SFT-PHYS-VALIDATION-GRAVITY-CLOCK-EQUIVALENCE-003", "SFT-PHYS-VALIDATION-GRAVITY-HORIZONS-003", "SFT-PHYS-VALIDATION-HADRON-REGGE-MEASURED-VALUE-060", "SFT-PHYS-VALIDATION-HIGGS-SYMMETRY-TERMINAL-066", "SFT-PHYS-VALIDATION-INFLATION-GROWTH-040", "SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-VALIDATION-INVERSE-SQUARE-001", "SFT-PHYS-VALIDATION-MAGNETIC-ANOMALIES-003", "SFT-PHYS-VALIDATION-MAJORANA-ZERO-NU-003", "SFT-PHYS-VALIDATION-MECHANICS-FORCE-001", "SFT-PHYS-VALIDATION-MECHANICS-MOMENTUM-001", "SFT-PHYS-VALIDATION-METROLOGY-MOLAR-PLANCK-001", "SFT-PHYS-VALIDATION-NEUTRINO-MASS-MIXING-003", "SFT-PHYS-VALIDATION-NONSTANDARD-SPACETIME-003", "SFT-PHYS-VALIDATION-NUCLEAR-CLOSURES-001", "SFT-PHYS-VALIDATION-OPTICAL-OPERATIONS-003", "SFT-PHYS-VALIDATION-PARTICLE-MODE-GENERATION-052", "SFT-PHYS-VALIDATION-PROTON-ELECTRON-003", "SFT-PHYS-VALIDATION-PROTON-PLANCK-TERMINAL-003", "SFT-PHYS-VALIDATION-QUANTUM-SUPPORT-UNCERTAINTY-050", "SFT-PHYS-VALIDATION-QUARK-CKM-003", "SFT-PHYS-VALIDATION-RELATIVISTIC-FIELDS-003", "SFT-PHYS-VALIDATION-SPIN-STATISTICS-CONDENSATION-046", "SFT-PHYS-VALIDATION-STELLAR-GALACTIC-TIDAL-068", "SFT-PHYS-VALIDATION-STELLAR-NUCLEAR-COLLAPSE-070", "SFT-PHYS-VALIDATION-STRONG-CP-BARYON-STABILITY-064", "SFT-PHYS-VALIDATION-THERMAL-EQUILIBRIUM-044", "SFT-PHYS-VALIDATION-THERMAL-HISTORY-MEASURED-VALUE-058", "SFT-PHYS-VALIDATION-THERMAL-HISTORY-RECOMBINATION-038", "SFT-PHYS-VALIDATION-THERMO-MOLAR-ENERGY-001", "SFT-PHYS-VALIDATION-VACUUM-DENSITY-SCALE-036", "SFT-PHYS-VALIDATION-VACUUM-EXTRACTION-003", "SFT-PHYS-VALIDATION-VACUUM-FLOOR-003", "SFT-PHYS-VALIDATION-VACUUM-INERTIA-003", "SFT-PHYS-VALIDATION-VACUUM-POLARIZATION-003", "SFT-PHYS-VALIDATION-VELOCITY-COMPOSITION-034", "SFT-PHYS-VALIDATION-WAVE-ENERGY-001", "SFT-PHYS-VALIDATION-WAVE-FREQUENCY-001", "SFT-PHYS-WAVE-DIFFRACTION-001", "SFT-PHYS-WAVE-DISPERSION-001", "SFT-PHYS-WAVE-ENERGY-MOMENTUM-001", "SFT-PHYS-WAVE-INTERFERENCE-001", "SFT-PHYS-WAVE-PERIOD-FREQUENCY-001", "SFT-PHYS-WAVE-POLARIZATION-001", "SFT-PHYS-WAVE-PROPAGATION-001", "SFT-PHYS-WAVE-RESONANCE-001", "SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001", "SFT-PHYS-WAVE-SUPERPOSITION-001", "SFT-PHYS-YANG-MILLS-SINGLET-GAP-EMPIRICAL-027", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := .ok (GrandLockObservationWitnesses.witnesses.all GrandLockObservationWitnesses.Witness.passed)

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-PHYS-").isPrefixOf (Text.chars claimId) ||
    !(Text.chars "SFT-EXP-PHYS-").isPrefixOf (Text.chars experimentId) then
   .error "ValueError: empirical Physics identity is invalid"
 else if specDependencies.isEmpty || specDimensions.length != 8 || targetRows.isEmpty then
   .error "ValueError: empirical Physics law lacks dependencies, eight dimensions or targets"
 else if !uniqueNames (specDimensions.map Prod.fst) then
   .error "ValueError: empirical Physics law contains duplicate dimensions"
 else if !(specDimensions.all (fun d => d.2.length == 2)) then
   .error "ValueError: each empirical dimension must exhaust two registered forms"
 else if !(specDimensions.all (fun d => (d.2.filter id).length == 1)) then
   .error "ValueError: dimension requires one preserving form"
 else if !nonblank expectedLabel || !nonblank falsification then
   .error "ValueError: empirical prediction or falsification condition is missing"
 else if !uniqueNames (targetRows.map ObservationCarrier.ExternalTargetRow.targetId) then
   .error "ValueError: empirical target identities are duplicated"
 else
   let witnesses ← specWitnesses
   if witnesses then .ok () else .error "ValueError: empirical Physics operational witness failed"

theorem specWitnessesPassed : specWitnesses = .ok true := congrArg (fun value : Bool => (Except.ok value : Except String Bool)) GrandLockObservationWitnesses.allWitnessesPass

theorem registeredSpecValid : validateSpec = .ok () := by
 unfold validateSpec
 rewrite [specWitnessesPassed]
 rfl
#print axioms registeredSpecValid

theorem sourceMatchesOriginal (bytes : ByteArray) :
 sourceMatches bytes = Text.equal (Text.append "sha256:" (SHA256.digest bytes)) snapshotHash := by
 unfold sourceMatches
 rw [SHA256Chunks.digestPreserved]

end SFT.Physics.GrandLockObservationExperiment

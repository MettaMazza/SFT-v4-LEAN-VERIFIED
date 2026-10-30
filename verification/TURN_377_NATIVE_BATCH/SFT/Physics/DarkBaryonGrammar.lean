import SFT.Physics.CosmicRatios
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.DarkBaryonGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "named-dark-and-baryon-scalars"
  | .admitted => "one-complete-matter-cover"

inductive Volume where
  | rejected | admitted

def volumeName : Volume → String
  | .rejected => "selected-cosmological-volume"
  | .admitted => "generator-over-forced-space"

inductive Cover where
  | rejected | admitted

def coverName : Cover → String
  | .rejected => "free-cover-depth"
  | .admitted => "least-complete-binary-cover"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "independent-normalizations"
  | .admitted => "depth-and-volume-over-cover"

inductive Leading where
  | rejected | admitted

def leadingName : Leading → String
  | .rejected => "measured-ratio-insertion"
  | .admitted => "volume-over-depth"

inductive Orbit where
  | rejected | admitted

def orbitName : Orbit → String
  | .rejected => "tower-or-up-depth-floor"
  | .admitted => "own-depth-first-return-floor"

inductive Deepening where
  | rejected | admitted

def deepeningName : Deepening → String
  | .rejected => "selected-sign-or-bare-depth"
  | .admitted => "one-positive-orbit-part-appended"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "density-readable-construction"
  | .admitted => "densities-inaccessible-until-seal"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "old-answer-runtime-input"
  | .admitted => "prior-question-machine-independent-reconstruction"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-density-or-fit-term"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  volume : Volume
  cover : Cover
  partition : Partition
  leading : Leading
  orbit : Orbit
  deepening : Deepening
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, volumeName c.volume, coverName c.cover, partitionName c.partition, leadingName c.leading, orbitName c.orbit, deepeningName c.deepening, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "volume=" (volumeName c.volume), SFT.Host.Text.append "cover=" (coverName c.cover), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "leading=" (leadingName c.leading), SFT.Host.Text.append "orbit=" (orbitName c.orbit), SFT.Host.Text.append "deepening=" (deepeningName c.deepening), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-complete-matter-cover__generator-over-forced-space__least-complete-binary-cover__depth-and-volume-over-cover__volume-over-depth__own-depth-first-return-floor__one-positive-orbit-part-appended__densities-inaccessible-until-seal__prior-question-machine-independent-reconstruction__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-complete-matter-cover" &&
  SFT.Host.Text.equal (volumeName c.volume) "generator-over-forced-space" &&
  SFT.Host.Text.equal (coverName c.cover) "least-complete-binary-cover" &&
  SFT.Host.Text.equal (partitionName c.partition) "depth-and-volume-over-cover" &&
  SFT.Host.Text.equal (leadingName c.leading) "volume-over-depth" &&
  SFT.Host.Text.equal (orbitName c.orbit) "own-depth-first-return-floor" &&
  SFT.Host.Text.equal (deepeningName c.deepening) "one-positive-orbit-part-appended" &&
  SFT.Host.Text.equal (targetName c.target) "densities-inaccessible-until-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "prior-question-machine-independent-reconstruction" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-complete-matter-cover") then "Names do not construct a common conserved support." else
  if !(SFT.Host.Text.equal (volumeName c.volume) "generator-over-forced-space") then "A selected volume reads the target." else
  if !(SFT.Host.Text.equal (coverName c.cover) "least-complete-binary-cover") then "A free depth is a fitted parameter." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "depth-and-volume-over-cover") then "Separate denominators need not conserve one matter whole." else
  if !(SFT.Host.Text.equal (leadingName c.leading) "volume-over-depth") then "A measured ratio is not a derivation." else
  if !(SFT.Host.Text.equal (orbitName c.orbit) "own-depth-first-return-floor") then "The tower is pre-periodic and the up-depth belongs to another carrier." else
  if !(SFT.Host.Text.equal (deepeningName c.deepening) "one-positive-orbit-part-appended") then "A chosen orientation or bare repeat adds no forced recurrence record." else
  if !(SFT.Host.Text.equal (targetName c.target) "densities-inaccessible-until-seal") then "That would fit the ratio." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "prior-question-machine-independent-reconstruction") then "Earlier answer artifacts cannot select the V3 law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An added term is a free parameter." else
  "The leading dark-to-baryon ratio is 27/5 with shares 27/32 and 5/32; the unique native period-five deepening is exactly 279/52."

def generationRule : String := "Generate the complete product of generation carrier, spatial volume, cover, partition, leading ratio, recurrence floor, deepening, measurement boundary, provenance and extension forms."
def grammarBoundary : String := "All exact first-recursive dark/baryon partitions generated from the admitted generator-three spatial volume, its least binary cover and the first-return orbit native to that cover depth."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Volume.rejected,Volume.admitted]).flatMap fun volume =>
  ([Cover.rejected,Cover.admitted]).flatMap fun cover =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Leading.rejected,Leading.admitted]).flatMap fun leading =>
  ([Orbit.rejected,Orbit.admitted]).flatMap fun orbit =>
  ([Deepening.rejected,Deepening.admitted]).flatMap fun deepening =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,volume,cover,partition,leading,orbit,deepening,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier volume cover partition leading orbit deepening target provenance extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvolume : volume ∈ [Volume.rejected,Volume.admitted] := by
      cases volume <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcover : cover ∈ [Cover.rejected,Cover.admitted] := by
      cases cover <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hleading : leading ∈ [Leading.rejected,Leading.admitted] := by
      cases leading <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horbit : orbit ∈ [Orbit.rejected,Orbit.admitted] := by
      cases orbit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdeepening : deepening ∈ [Deepening.rejected,Deepening.admitted] := by
      cases deepening <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ volume _ hvolume
    apply CommonRefinement.memFlatMap _ _ cover _ hcover
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ leading _ hleading
    apply CommonRefinement.memFlatMap _ _ orbit _ horbit
    apply CommonRefinement.memFlatMap _ _ deepening _ hdeepening
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier volume cover partition leading orbit deepening target provenance extension =>
    cases carrier <;> cases volume <;> cases cover <;> cases partition <;> cases leading <;> cases orbit <;> cases deepening <;> cases target <;> cases provenance <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier volume cover partition leading orbit deepening target provenance extension =>
    cases carrier <;> cases volume <;> cases cover <;> cases partition <;> cases leading <;> cases orbit <;> cases deepening <;> cases target <;> cases provenance <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.volume = .admitted ∧ c.cover = .admitted ∧ c.partition = .admitted ∧ c.leading = .admitted ∧ c.orbit = .admitted ∧ c.deepening = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier volume cover partition leading orbit deepening target provenance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem volume_rejected_rejected (c : Candidate) (h : c.volume = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.volume eq
    rw [h] at field
    cases field

theorem cover_rejected_rejected (c : Candidate) (h : c.cover = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cover eq
    rw [h] at field
    cases field

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
    rw [h] at field
    cases field

theorem leading_rejected_rejected (c : Candidate) (h : c.leading = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.leading eq
    rw [h] at field
    cases field

theorem orbit_rejected_rejected (c : Candidate) (h : c.orbit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orbit eq
    rw [h] at field
    cases field

theorem deepening_rejected_rejected (c : Candidate) (h : c.deepening = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.deepening eq
    rw [h] at field
    cases field

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
    rw [h] at field
    cases field

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.DarkBaryonGrammar

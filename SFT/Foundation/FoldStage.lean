import SFT.Foundation.Fold
namespace SFT.Foundation.FoldStage
open Count.TraceDerivation FoldDerivation

def stageExtension : Trace → Fold.Extension
  | .base => .identity
  | .extend .base => .first
  | .extend (.extend _) => .later

def proposalAtStage (c : Fold.Candidate) (t : Trace) : Fold.Candidate :=
  { c with extension := stageExtension t }

theorem stageExtensionFirstExact (t : Trace) : stageExtension t = .first ↔ t = firstExtension := by
  cases t with
  | base => constructor <;> intro h <;> cases h
  | extend t =>
    cases t with
    | base => exact ⟨fun _ => rfl,fun _ => rfl⟩
    | extend t => constructor <;> intro h <;> cases h

theorem stageClassesAgree (t : Trace) :
    (match extensionClass t with
      | .identity => Fold.Extension.identity
      | .first => .first
      | .later => .later) = stageExtension t := by
  cases t with
  | base => rfl
  | extend t => cases t <;> rfl

theorem proposalStageExact (c : Fold.Candidate) (t : Trace) :
    (proposalAtStage c t).extension = stageExtension t := rfl

theorem acceptedProposalHasMinimalStage (c : Fold.Candidate) (t : Trace)
    (h : Fold.survives (proposalAtStage c t) = true) : MinimalNonidentity t := by
  have eq := (Fold.uniqueSurvivor _).mp h
  have first : stageExtension t = .first := congrArg Fold.Candidate.extension eq
  have ht := (stageExtensionFirstExact t).mp first
  cases ht
  exact firstIsMinimal

def RemainingCriteria (c : Fold.Candidate) : Prop :=
  c.coverage = .complete ∧ c.overlap = .disjoint ∧ c.fibre = .equal ∧
  c.labels = .distinctHeld ∧ c.returnRelation = .present ∧ c.extra = .noExtra

theorem minimalStageWithRemainingCriteriaAccepted (c : Fold.Candidate) (t : Trace)
    (ht : MinimalNonidentity t) (h : RemainingCriteria c) :
    Fold.survives (proposalAtStage c t) = true := by
  have eq := minimalNonidentityUnique t ht
  cases eq
  obtain ⟨hc,ho,hf,hl,hr,he⟩ := h
  apply (Fold.acceptanceIffExactCriteria _).mpr
  exact ⟨hc,ho,hf,rfl,hl,hr,he⟩

theorem acceptedProposalRetainsRemainingCriteria (c : Fold.Candidate) (t : Trace)
    (h : Fold.survives (proposalAtStage c t) = true) : RemainingCriteria c := by
  obtain ⟨hc,ho,hf,_,hl,hr,he⟩ := (Fold.acceptanceIffExactCriteria _).mp h
  exact ⟨hc,ho,hf,hl,hr,he⟩

theorem stageAcceptanceIff (c : Fold.Candidate) (t : Trace) :
    Fold.survives (proposalAtStage c t) = true ↔ MinimalNonidentity t ∧ RemainingCriteria c :=
  ⟨fun h => ⟨acceptedProposalHasMinimalStage c t h,acceptedProposalRetainsRemainingCriteria c t h⟩,
   fun h => minimalStageWithRemainingCriteriaAccepted c t h.1 h.2⟩

theorem everyLaterProposalRejected (c : Fold.Candidate) (t : Trace) :
    Fold.survives (proposalAtStage c (.extend (.extend t))) = false :=
  Fold.extensionLaterRejected _ rfl

theorem everyIdentityProposalRejected (c : Fold.Candidate) :
    Fold.survives (proposalAtStage c .base) = false :=
  Fold.extensionIdentityRejected _ rfl

end SFT.Foundation.FoldStage

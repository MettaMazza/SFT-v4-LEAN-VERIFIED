import SFT.Chemistry.OrbitalSupport
import SFT.Mathematics.CategoryIdentity
namespace SFT.Chemistry.OrbitalSupport
open SFT.Host SFT.Physics.CapabilityValues

-- Original OccupiedMolecularSupport admission, for every finite occurrence list.
theorem occupiedCardinalityGuard (row result : OccupiedMolecularSupport)
 (accepted : validOccupied row = .ok result) :
 (row.electronOccurrences.isEmpty || row.electronOccurrences.length > 2) = false := by
 unfold validOccupied at accepted
 cases h : (row.electronOccurrences.isEmpty || row.electronOccurrences.length > 2) with
 | false => rfl
 | true => rw [h] at accepted; cases accepted

-- Original complete partition admission: census equality and no repeated occurrence.
theorem completeCensusGuard (state result : CompleteMolecularSupport)
 (accepted : validComplete state = .ok result) :
 ((state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences).length != state.exactElectronCount.value ||
 !ElectronCountSpin.distinctLabels (state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences)) = false := by
 unfold validComplete at accepted
 cases h0 : (!Text.equal state.molecularCarrier.family "molecular-carrier" || state.occupiedCells.isEmpty) with
 | true => rw [h0] at accepted; cases accepted
 | false =>
  rw [h0] at accepted
  cases h1 : !(state.occupiedCells.all (fun row => ElectronCountSpin.sameLabel row.cell.molecularCarrier state.molecularCarrier)) with
  | true => rw [h1] at accepted; cases accepted
  | false =>
   rw [h1] at accepted
   try dsimp only at accepted
   cases h2 : ((state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences).length != state.exactElectronCount.value ||
    !ElectronCountSpin.distinctLabels (state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences)) with
   | false => rfl
   | true => rw [h2] at accepted; cases accepted

-- The source's positive radial successor changes the exact coordinate.
theorem radialSuccessorDistinct (cell : MolecularSupportCell) (next : PositiveCount)
 (successor : next.value = cell.radialRecurrence.value + 1) :
 {cell with radialRecurrence := next} ≠ cell := by
 intro equal
 have same := congrArg (fun c : MolecularSupportCell => c.radialRecurrence.value) equal
 change next.value = cell.radialRecurrence.value at same
 exact Nat.succ_ne_self _ (Eq.trans successor.symm same)


-- The source complementary-spin guard holds at every admitted occupancy.
theorem complementarySpinGuard (row result : OccupiedMolecularSupport)
 (accepted : validOccupied row = .ok result) :
 ((row.spinFibres.map HeldLabel.label).length==2 && !((row.spinFibres.map HeldLabel.label).any (Text.equal "fibre-a") && (row.spinFibres.map HeldLabel.label).any (Text.equal "fibre-b"))) = false := by
 unfold validOccupied at accepted
 try dsimp only at accepted
 cases h0 : (row.electronOccurrences.isEmpty || row.electronOccurrences.length > 2) with
 | true => rw [h0] at accepted; cases accepted
 | false =>
  rw [h0] at accepted
  try dsimp only at accepted
  cases h1 : (row.electronOccurrences.length != row.spinFibres.length) with
  | true => rw [h1] at accepted; cases accepted
  | false =>
   rw [h1] at accepted
   try dsimp only at accepted
   cases h2 : (!ElectronCountSpin.distinctLabels row.electronOccurrences) with
   | true => rw [h2] at accepted; cases accepted
   | false =>
    rw [h2] at accepted
    try dsimp only at accepted
    cases h3 : (!(row.electronOccurrences.all (fun label => Text.equal label.family "electron-occurrence"))) with
    | true => rw [h3] at accepted; cases accepted
    | false =>
     rw [h3] at accepted
     try dsimp only at accepted
     cases h4 : (!(row.spinFibres.all (fun label => Text.equal label.family "electron-spin"))) with
     | true => rw [h4] at accepted; cases accepted
     | false =>
      rw [h4] at accepted
      try dsimp only at accepted
      cases h5 : (!((row.spinFibres.map HeldLabel.label).all (fun label => Text.equal label "fibre-a" || Text.equal label "fibre-b"))) with
      | true => rw [h5] at accepted; cases accepted
      | false =>
       rw [h5] at accepted
       try dsimp only at accepted
       cases h6 : ((row.spinFibres.map HeldLabel.label).length==2 && !((row.spinFibres.map HeldLabel.label).any (Text.equal "fibre-a") && (row.spinFibres.map HeldLabel.label).any (Text.equal "fibre-b"))) with
       | false => rfl
       | true => rw [h6] at accepted; cases accepted

-- joined_phase_pair for every source-admissible carrier and recurrence.
theorem joinedPairExact (label : String) (named : nonblank label = true)
 (radial : PositiveCount) (axis : AxisRank) :
 joinedPhasePair label radial axis = .ok [
 ⟨⟨"molecular-carrier",label,by rfl,named⟩,radial,axis,
  ⟨"joining-phase","fibre-a",by rfl,by rfl⟩,.emptyOne "empty-One",.emptyOne "empty-One"⟩,
 ⟨⟨"molecular-carrier",label,by rfl,named⟩,radial,axis,
  ⟨"joining-phase","fibre-b",by rfl,by rfl⟩,.emptyOne "empty-One",.emptyOne "empty-One"⟩] := by
 unfold joinedPhasePair heldLabel
 rw [dite_eq_left (show nonblank "molecular-carrier" = true from rfl),dite_eq_left named]
 rfl

-- Positive axis recurrence has a new exact coordinate at each successor.
theorem axisSuccessorDistinct (cell : MolecularSupportCell) (prior next : PositiveCount)
 (current : cell.axisRecurrence = .count prior)
 (successor : next.value = prior.value + 1) :
 {cell with axisRecurrence := .count next} ≠ cell := by
 intro equal
 have same := congrArg (fun c : MolecularSupportCell => c.axisRecurrence) equal
 change ElectronCountSpin.CountOrEmpty.count next = cell.axisRecurrence at same
 rw [current] at same
 have values := congrArg (fun a : AxisRank => match a with | .emptyOne _ => 0 | .count n => n.value) same
 exact Nat.succ_ne_self _ (Eq.trans successor.symm values)

-- The base occurrence occupies an arbitrary source cell with one held spin fibre.
theorem singleOccurrenceBase (cell : MolecularSupportCell) (label : String)
 (named : nonblank label = true) :
 validOccupied ⟨cell,[⟨"electron-occurrence",label,by rfl,named⟩],
 [⟨"electron-spin","fibre-a",by rfl,by rfl⟩]⟩ =
 .ok ⟨cell,[⟨"electron-occurrence",label,by rfl,named⟩],
 [⟨"electron-spin","fibre-a",by rfl,by rfl⟩]⟩ := rfl

-- Flattening an added occupied cell retains the old occurrence list and adds
-- exactly that cell's occurrences, independently of construction depth.
theorem occurrenceCensusSuccessor (cells : List OccupiedMolecularSupport)
 (added : OccupiedMolecularSupport) :
 ((cells ++ [added]).flatMap OccupiedMolecularSupport.electronOccurrences).length =
 (cells.flatMap OccupiedMolecularSupport.electronOccurrences).length + added.electronOccurrences.length := by
 rw [SFT.Mathematics.CategoryIdentity.flatMapAppend]
 change ((cells.flatMap OccupiedMolecularSupport.electronOccurrences) ++ (added.electronOccurrences ++ [])).length = _
 rw [SFT.Mathematics.CategoryIdentity.appendNil, SFT.Foundation.CommonRefinement.appendLength]

theorem completeCensusExact (state result : CompleteMolecularSupport)
 (accepted : validComplete state = .ok result) :
 (state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences).length = state.exactElectronCount.value := by
 have guard := completeCensusGuard state result accepted
 cases h : ((state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences).length == state.exactElectronCount.value) with
 | true => exact Nat.eq_of_beq_eq_true h
 | false =>
  change (!((state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences).length == state.exactElectronCount.value) ||
    !ElectronCountSpin.distinctLabels (state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences)) = false at guard
  rw [h] at guard
  cases guard

theorem completeOccurrencesDistinct (state result : CompleteMolecularSupport)
 (accepted : validComplete state = .ok result) :
 ElectronCountSpin.distinctLabels (state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences) = true := by
 have guard := completeCensusGuard state result accepted
 cases h : ElectronCountSpin.distinctLabels (state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences) with
 | true => rfl
 | false =>
  rw [h] at guard
  cases countGuard : ((state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences).length != state.exactElectronCount.value) with
  | false => rw [countGuard] at guard; cases guard
  | true => rw [countGuard] at guard; cases guard

#print axioms occupiedCardinalityGuard
#print axioms completeCensusGuard
#print axioms radialSuccessorDistinct
#print axioms complementarySpinGuard
#print axioms joinedPairExact
#print axioms axisSuccessorDistinct
#print axioms singleOccurrenceBase
#print axioms occurrenceCensusSuccessor
#print axioms completeCensusExact
#print axioms completeOccurrencesDistinct
end SFT.Chemistry.OrbitalSupport

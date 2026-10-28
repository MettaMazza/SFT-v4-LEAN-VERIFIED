import SFT.InformationScience.ClassicalWhole
namespace SFT.InformationScience.ClassicalClosure
open ClassicalWhole ClassicalLedger ClassicalSupport
open SFT.Foundation.FractionReduction
open SFT.Mathematics.ProbabilityObservations

def memberCount : List EntropyLedger.Record → Nat
  | [] => 0
  | row :: rest => row.microstates.length + memberCount rest

def sumNatural (rows : List EntropyLedger.Record) (n d : Nat) : Nat × Nat :=
  match rows with
  | [] => (n,d)
  | row :: rest => sumNatural rest
    (n * row.exactSupportPart.denominator + row.exactSupportPart.numerator * d)
    (d * row.exactSupportPart.denominator)

theorem addRatios (n d used cn cd count whole : Nat)
    (prior : n * whole = used * d) (part : cn * whole = count * cd) :
    (n * cd + cn * d) * whole = (used + count) * (d * cd) := by
  have distribute (a b c : Nat) : (a+b)*c = a*c+b*c := by
    rw [Nat.mul_comm (a+b) c,Nat.mul_add,Nat.mul_comm c a,Nat.mul_comm c b]
  have swap (a b c : Nat) : a*b*c = a*c*b := by
    rw [mulAssoc,Nat.mul_comm b c,← mulAssoc]
  rw [distribute,swap n cd whole,prior,swap cn d whole,part,distribute,
    mulAssoc used d cd,mulAssoc count cd d,Nat.mul_comm cd d]


theorem sumInvariant (rows : List EntropyLedger.Record) (whole : Nat)
    (parts : ∀ row, row ∈ rows → row.exactSupportPart.numerator * whole = row.microstates.length * row.exactSupportPart.denominator)
    (n d used : Nat) (prior : n * whole = used * d) :
    (sumNatural rows n d).1 * whole = (used + memberCount rows) * (sumNatural rows n d).2 := by
  induction rows generalizing n d used with
  | nil => exact (Nat.add_zero used).symm ▸ prior
  | cons row rest ih =>
    have next := addRatios n d used row.exactSupportPart.numerator row.exactSupportPart.denominator row.microstates.length whole prior (parts row (List.Mem.head rest))
    have result := ih (fun r hr => parts r (List.Mem.tail row hr)) _ _ (used+row.microstates.length) next
    change _ = (used + (row.microstates.length + memberCount rest)) * _
    exact (Nat.add_assoc used row.microstates.length (memberCount rest)) ▸ result

theorem integerAccumulation (rows : List EntropyLedger.Record) (n d : Nat) :
    sumParts (rows.map (fun row => positiveRat row.exactSupportPart)) (Int.ofNat n) d =
      (Int.ofNat (sumNatural rows n d).1,(sumNatural rows n d).2) := by
  induction rows generalizing n d with
  | nil => rfl
  | cons row rest ih =>
    change sumParts (rest.map (fun row => positiveRat row.exactSupportPart))
      (Int.ofNat n * Int.ofNat row.exactSupportPart.denominator + Int.ofNat row.exactSupportPart.numerator * Int.ofNat d)
      (d * row.exactSupportPart.denominator) = _
    exact ih _ _

def partitionCount : List (String × List String) → Nat
  | [] => 0
  | row :: rest => row.2.length + partitionCount rest

theorem countProjection (rows : List EntropyLedger.Record) :
    memberCount rows = partitionCount (rows.map (fun row => (row.observation,row.microstates))) := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (Nat.add row.microstates.length) ih

theorem countClasses (support : List String) (mapping : Observation) (labels : List String) :
    partitionCount (labels.map (fun label => (label,fibre support mapping label))) = classCount support mapping labels := by
  induction labels with
  | nil => rfl
  | cons label rest ih => exact congrArg (Nat.add (fibre support mapping label).length) ih

theorem ledgerCount (support : List String) (mapping : Observation) (rows : List EntropyLedger.Record)
    (h : EntropyLedger.entropyLedger support mapping = .ok rows)
    (keys : keysMatch support mapping = true) : memberCount rows = support.length := by
  rw [countProjection,EntropyLedger.entropyProvenance _ _ _ h]
  exact (countClasses support mapping _).trans (originalClassCount support mapping keys)

theorem wholeFromCounts (rows : List EntropyLedger.Record) (whole : Nat) (positive : 0 < whole)
    (count : memberCount rows = whole)
    (parts : ∀ row, row ∈ rows → row.exactSupportPart.numerator * whole = row.microstates.length * row.exactSupportPart.denominator) :
    ledgerIsExactWhole (rows.map (fun row => positiveRat row.exactSupportPart)) = true := by
  have invariant := sumInvariant rows whole parts 0 1 0 (Nat.zero_mul whole)
  rw [count,Nat.zero_add,Nat.mul_comm whole] at invariant
  have equal := Nat.eq_of_mul_eq_mul_right positive invariant
  have accumulated := integerAccumulation rows 0 1
  have same : (sumParts (rows.map (fun row => positiveRat row.exactSupportPart))).1 =
      Int.ofNat (sumParts (rows.map (fun row => positiveRat row.exactSupportPart))).2 := by
    change (sumParts (rows.map (fun row => positiveRat row.exactSupportPart)) (Int.ofNat 0) 1).1 = Int.ofNat (sumParts (rows.map (fun row => positiveRat row.exactSupportPart)) (Int.ofNat 0) 1).2
    rw [accumulated]
    exact congrArg Int.ofNat equal
  cases rows with
  | nil => exact False.elim ((Nat.ne_of_gt positive) count.symm)
  | cons row rest => exact (wholeMeaning _ _).mpr same

theorem entropyWhole (support : List String) (mapping : Observation) (rows : List EntropyLedger.Record)
    (valid : validateProbability support mapping = .ok mapping)
    (h : EntropyLedger.entropyLedger support mapping = .ok rows) :
    ledgerIsExactWhole (rows.map (fun row => positiveRat row.exactSupportPart)) = true := by
  have partition := probabilityPartition support mapping valid
  have keys := ((SFT.Foundation.Count.Representation.andTrue _ _).mp ((probabilityMeaning _ _ _).mp valid).2.1).2
  apply wholeFromCounts rows support.length (EntropyLedger.supportPositive _ _ _ partition)
    (ledgerCount support mapping rows h keys)
  intro row hr
  exact (EntropyLedger.rowExactPart _ _ _ h row hr).symm

theorem probabilityParts (rows : List EntropyLedger.Record) :
    (rows.map probabilityRow).map (fun row => positiveRat row.exactSupportPart) =
      rows.map (fun row => positiveRat row.exactSupportPart) := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons (positiveRat row.exactSupportPart)) ih

theorem pushforwardParts (rows : List EntropyLedger.Record) :
    (rows.map pushforwardRow).map (fun row => positiveRat row.exactSupportPart) =
      rows.map (fun row => positiveRat row.exactSupportPart) := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons (positiveRat row.exactSupportPart)) ih

theorem probabilityExactWhole (support : List String) (mapping : Observation) (rows : List ProbabilityRow)
    (valid : validateProbability support mapping = .ok mapping)
    (h : probabilityLedger support mapping = .ok rows) : probabilityWhole rows = true := by
  obtain ⟨original,ho⟩ := admittedLedgerExists _ _ valid
  have eq := (probabilityOutput _ _ _ valid ho).symm.trans h
  cases Except.ok.inj eq
  unfold probabilityWhole
  rw [probabilityParts]
  exact entropyWhole _ _ _ valid ho

theorem pushforwardExactWhole (support : List String) (mapping : Observation) (rows : List PushforwardRow)
    (valid : validatePushforward support mapping = .ok mapping)
    (h : pushforwardLedger support mapping = .ok rows) : pushforwardWhole rows = true := by
  have pv := pushforwardProbability _ _ valid
  obtain ⟨original,ho⟩ := admittedLedgerExists _ _ pv
  have eq := (pushforwardOutput _ _ _ valid ho).symm.trans h
  cases Except.ok.inj eq
  unfold pushforwardWhole
  rw [pushforwardParts]
  exact entropyWhole _ _ _ pv ho

end SFT.InformationScience.ClassicalClosure

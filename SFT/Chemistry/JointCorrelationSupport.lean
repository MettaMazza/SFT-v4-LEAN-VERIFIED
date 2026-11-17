import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.JointCorrelationSupport
open SFT.Host SFT.Physics.CapabilityValues
structure JointSupport where
 molecularCarrier : HeldLabel
 leftCentre : HeldLabel
 rightCentre : HeldLabel
 jointWords : List Value

def lowerFibre : HeldLabel := ⟨"electron-held-fibre","lower-fibre",by rfl,by rfl⟩
def upperFibre : HeldLabel := ⟨"electron-held-fibre","upper-fibre",by rfl,by rfl⟩
def assignmentWord (firstFibre : String) (firstCentre : HeldLabel) (secondFibre : String) (secondCentre : HeldLabel) : Except String Value := do
 return .word [.label (← heldLabel "electron-held-fibre" firstFibre),.label firstCentre,
  .label (← heldLabel "electron-held-fibre" secondFibre),.label secondCentre]
def requiredWords (left right : HeldLabel) : List Value := [
 .word [.label lowerFibre,.label left,.label upperFibre,.label right],
 .word [.label lowerFibre,.label right,.label upperFibre,.label left]]
theorem firstAssignment (left right : HeldLabel) :
 assignmentWord "lower-fibre" left "upper-fibre" right = .ok (.word [.label lowerFibre,.label left,.label upperFibre,.label right]) := rfl
theorem secondAssignment (left right : HeldLabel) :
 assignmentWord "lower-fibre" right "upper-fibre" left = .ok (.word [.label lowerFibre,.label right,.label upperFibre,.label left]) := rfl

def sameLabel (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label
def wordsMatch (words : List Value) (left right : HeldLabel) : Bool := match words with
 | [a,b] => equal a (.word [.label lowerFibre,.label left,.label upperFibre,.label right]) &&
   equal b (.word [.label lowerFibre,.label right,.label upperFibre,.label left])
 | [] | [_] | _::_::_::_ => false
def construct (molecule left right : HeldLabel) (words : List Value) : Except String JointSupport :=
 match Text.equal molecule.family "molecular-carrier" with
 | false => .error "joint support requires one retained molecular carrier"
 | true => match Text.equal left.family "separated-product-centre" && Text.equal right.family "separated-product-centre" with
  | false => .error "dissociation support requires two retained product centres"
  | true => match sameLabel left right with
   | true => .error "the two separated product centres must remain distinguishable"
   | false => match wordsMatch words left right with
    | false => .error "joint support must retain exactly both complementary exchange assignments and no same-centre word"
    | true => .ok ⟨molecule,left,right,words⟩
def completeSupport (molecule leftProduct rightProduct : String) : Except String JointSupport := do
 let left ← heldLabel "separated-product-centre" leftProduct
 let right ← heldLabel "separated-product-centre" rightProduct
 let molecule ← heldLabel "molecular-carrier" molecule
 construct molecule left right (requiredWords left right)
def positiveJointWordCount (s : JointSupport) : Except String PositiveCount := count s.jointWords.length
def positiveIndependentCartesianCount : PositiveCount := ⟨4,by decide⟩
def retainsNonfactorizable (s : JointSupport) : Bool := s.jointWords.length==2 && positiveIndependentCartesianCount.value==4

theorem requiredWordsCardinality (left right : HeldLabel) : (requiredWords left right).length = 2 := rfl
theorem cartesianCardinality : positiveIndependentCartesianCount.value = 4 := rfl

theorem acceptedJointCardinality (molecule left right : HeldLabel) (words : List Value) (s : JointSupport)
 (h : construct molecule left right words = .ok s) : s.jointWords.length = 2 := by
 unfold construct at h
 split at h
 · cases h
 · split at h
   · cases h
   · split at h
     · cases h
     · cases words with
       | nil => cases h
       | cons a rest =>
        cases rest with
        | nil => cases h
        | cons b tail =>
         cases tail with
         | cons c more => cases h
         | nil =>
          split at h
          · cases h
          · cases h; rfl

theorem acceptedNonfactorizable (molecule left right : HeldLabel) (words : List Value) (s : JointSupport)
 (h : construct molecule left right words = .ok s) : retainsNonfactorizable s = true := by
 unfold retainsNonfactorizable
 rw [acceptedJointCardinality molecule left right words s h]
 rfl

def original : Except String JointSupport := completeSupport "H2" "H-left" "H-right"
def check (p : JointSupport → Bool) : Bool := match original with
 | .ok s => p s
 | .error _ => false
def completeJointPairWitness : Bool := check (fun s => s.jointWords.length==2)
def nonfactorizableWitness : Bool := check (fun s => retainsNonfactorizable s && positiveIndependentCartesianCount.value==4)
def rejected (r : Except String JointSupport) : Bool := match r with
 | .error _ => true
 | .ok _ => false
def incompleteWitness : Bool := check (fun s => rejected (construct s.molecularCarrier s.leftCentre s.rightCentre (s.jointWords.take 1)))
def factorizedWitness : Bool := check (fun s => rejected (construct s.molecularCarrier s.leftCentre s.rightCentre
 (s.jointWords ++ [.word [.label lowerFibre,.label s.leftCentre,.label upperFibre,.label s.leftCentre],
 .word [.label lowerFibre,.label s.rightCentre,.label upperFibre,.label s.rightCentre]])))
def sameCentreWitness : Bool := rejected (completeSupport "H2" "same" "same")
theorem completeJointPairWitnessPassed : completeJointPairWitness = true := rfl
theorem nonfactorizableWitnessPassed : nonfactorizableWitness = true := rfl
theorem incompleteWitnessPassed : incompleteWitness = true := rfl
theorem factorizedWitnessPassed : factorizedWitness = true := rfl
theorem sameCentreWitnessPassed : sameCentreWitness = true := rfl
end SFT.Chemistry.JointCorrelationSupport

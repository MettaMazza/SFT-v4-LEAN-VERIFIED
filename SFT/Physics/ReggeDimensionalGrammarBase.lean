import SFT.Physics.ReggeDimensional
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ReggeDimensionalGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "rewrite-or-ignore-admitted-laws"
  | .admitted => "immutable-receipt-custody"

inductive Motion where
  | rejected | admitted

def motionName : Motion → String
  | .rejected => "selected-or-fitted-intercept"
  | .admitted => "admitted-three-fifths-motion-share"

inductive Hands where
  | rejected | admitted

def handsName : Hands → String
  | .rejected => "chosen-trajectory-multiplicity"
  | .admitted => "both-forced-Fold-hands"

inductive Successor where
  | rejected | admitted

def successorName : Successor → String
  | .rejected => "fitted-common-slope"
  | .admitted => "two-times-three-fifths"

inductive Base where
  | rejected | admitted

def baseName : Base → String
  | .rejected => "numerical-zero-or-free-offset"
  | .admitted => "first-positive-rank-three-fifths"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "finite-five-row-pattern"
  | .admitted => "depth-independent-induction"

inductive Units where
  | rejected | admitted

def unitsName : Units → String
  | .rejected => "unit-name-selects-coefficients"
  | .admitted => "postseal-common-positive-unit"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "target-readable-before-seal"
  | .admitted => "target-inaccessible-until-formal-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-spin-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  motion : Motion
  hands : Hands
  successor : Successor
  base : Base
  closure : Closure
  units : Units
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, motionName c.motion, handsName c.hands, successorName c.successor, baseName c.base, closureName c.closure, unitsName c.units, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "motion=" (motionName c.motion), SFT.Host.Text.append "hands=" (handsName c.hands), SFT.Host.Text.append "successor=" (successorName c.successor), SFT.Host.Text.append "base=" (baseName c.base), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "units=" (unitsName c.units), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "immutable-receipt-custody__admitted-three-fifths-motion-share__both-forced-Fold-hands__two-times-three-fifths__first-positive-rank-three-fifths__depth-independent-induction__postseal-common-positive-unit__target-inaccessible-until-formal-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "immutable-receipt-custody" &&
  SFT.Host.Text.equal (motionName c.motion) "admitted-three-fifths-motion-share" &&
  SFT.Host.Text.equal (handsName c.hands) "both-forced-Fold-hands" &&
  SFT.Host.Text.equal (successorName c.successor) "two-times-three-fifths" &&
  SFT.Host.Text.equal (baseName c.base) "first-positive-rank-three-fifths" &&
  SFT.Host.Text.equal (closureName c.closure) "depth-independent-induction" &&
  SFT.Host.Text.equal (unitsName c.units) "postseal-common-positive-unit" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-formal-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (predecessorName c.predecessor) "immutable-receipt-custody") then "A successor may not replace an admitted dependency." else
  if !(SFT.Host.Text.equal (motionName c.motion) "admitted-three-fifths-motion-share") then "A selected intercept reads the spectrum." else
  if !(SFT.Host.Text.equal (handsName c.hands) "both-forced-Fold-hands") then "A chosen multiplicity changes the slope." else
  if !(SFT.Host.Text.equal (successorName c.successor) "two-times-three-fifths") then "A measured slope is not a derivation." else
  if !(SFT.Host.Text.equal (baseName c.base) "first-positive-rank-three-fifths") then "Neither numerical nothingness nor an offset is generated." else
  if !(SFT.Host.Text.equal (closureName c.closure) "depth-independent-induction") then "Five inspected rows do not establish a general law." else
  if !(SFT.Host.Text.equal (unitsName c.units) "postseal-common-positive-unit") then "A unit label cannot choose a ratio." else
  if !(SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-formal-seal") then "That would fit the known spectrum." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An ungenerated correction is a parameter." else
  "Every positive spin rank has the exact squared resonance-support carrier Q(J)=(6J-3)/5. The base is 3/5; every successor step is 6/5; the first five carriers are 3/5, 9/5, 3, 21/5 and 27/5."

def generationRule : String := "Generate the complete product of predecessor custody, motion share, tube hands, base rank, successor act, closed form, unit boundary, target custody and extension forms."
def grammarBoundary : String := "The admitted exact 3/5 motion share, exactly two Fold tube hands, every positive spin successor, exact positive fractions, a post-seal common unit label and no measurement in survivor selection."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Motion.rejected,Motion.admitted]).flatMap fun motion =>
  ([Hands.rejected,Hands.admitted]).flatMap fun hands =>
  ([Successor.rejected,Successor.admitted]).flatMap fun successor =>
  ([Base.rejected,Base.admitted]).flatMap fun base =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Units.rejected,Units.admitted]).flatMap fun units =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,motion,hands,successor,base,closure,units,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor motion hands successor base closure units target extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmotion : motion ∈ [Motion.rejected,Motion.admitted] := by
      cases motion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hhands : hands ∈ [Hands.rejected,Hands.admitted] := by
      cases hands <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuccessor : successor ∈ [Successor.rejected,Successor.admitted] := by
      cases successor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbase : base ∈ [Base.rejected,Base.admitted] := by
      cases base <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunits : units ∈ [Units.rejected,Units.admitted] := by
      cases units <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ motion _ hmotion
    apply CommonRefinement.memFlatMap _ _ hands _ hhands
    apply CommonRefinement.memFlatMap _ _ successor _ hsuccessor
    apply CommonRefinement.memFlatMap _ _ base _ hbase
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ units _ hunits
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.ReggeDimensionalGrammar

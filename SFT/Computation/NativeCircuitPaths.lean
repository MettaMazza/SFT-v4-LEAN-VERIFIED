import SFT.Computation.NativeCircuit
import SFT.Computation.NativeVerification
namespace SFT.Computation.NativeCircuitPaths
open NativeCircuit NativeClosing SFT.InformationScience.QuantitySupport
open SFT.InformationScience.CompressionSupport
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

def rank (word : Word) : Nat := if word=emptyOne then 0 else word.length

theorem terminalRank : rank emptyOne=0 := if_pos rfl

theorem generatedRank (depth : Nat) (word : Word) (held : word∈words labels depth) : rank word=word.length :=
 if_neg (NativeVerification.generatedNotEmptyOne depth word held)

theorem edgeLowers (depth : Nat) (positive : 0<depth) (word : Word)
 (held : word∈words labels depth) : rank (edge word).1=rank (edge word).2+1 := by
 have carrier := (wordCharacterization _ _ _).mp held
 cases word with
 | nil => rw [← carrier.1] at positive; cases positive
 | cons a rest =>
   cases rest with
   | nil =>
     change rank [a]=rank emptyOne+1
     rw [generatedRank depth [a] held,terminalRank]; rfl
   | cons b tail =>
     have tailHeld : (b::tail)∈words labels (b::tail).length :=
       (wordCharacterization _ _ _).mpr ⟨rfl,fun x h => carrier.2 x (.tail a h)⟩
     have longer : 1<(a::b::tail).length := Nat.succ_lt_succ (Nat.zero_lt_succ _)
     change rank (a::b::tail)=rank (if (a::b::tail).length>1 then (b::tail) else emptyOne)+1
     rw [if_pos longer,generatedRank depth _ held,generatedRank _ _ tailHeld]
     rfl

inductive Path (circuit : List Edge) : Word → Word → Nat → Prop
 | identity (word : Word) : Path circuit word word 0
 | step {first next last count} : (first,next)∈circuit → Path circuit next last count → Path circuit first last (count+1)

theorem everyPathRank (circuit : List Edge) (depth : Nat)
 (lawful : ∀ e,e∈circuit → e∈forcedEdges depth)
 (first last : Word) (count : Nat) (path : Path circuit first last count) : rank first=rank last+count := by
 induction path with
 | identity word => rfl
 | @step first next last count member path ih =>
   obtain ⟨word,held,eq⟩ := memMapPreimage edge (first,next) (wordsThroughDepth depth) (lawful _ member)
   obtain ⟨width,positive,bound,generated⟩ := (shortMembership labels depth word).mp held
   have lowers := edgeLowers width positive word generated
   rw [eq] at lowers
   change rank first=rank next+1 at lowers
   rw [lowers,ih,Nat.add_assoc]

theorem everyClosingPathHasRequiredDepth (circuit : List Edge) (cap depth : Nat)
 (lawful : ∀ e,e∈circuit → e∈forcedEdges cap)
 (word : Word) (generated : word∈words labels depth) (count : Nat)
 (path : Path circuit word emptyOne count) : count=depth := by
 have value := everyPathRank circuit cap lawful word emptyOne count path
 rw [generatedRank depth word generated,terminalRank,Nat.zero_add] at value
 exact value.symm.trans ((wordCharacterization _ _ _).mp generated).1

theorem requiredSourceEdges (depth : Nat) (circuit : List Edge)
 (covers : ∀ word,word∈wordsThroughDepth depth → edge word∈circuit) :
 layeredCount depth≤circuit.length := by
 have bound := layeredSourceLowerBound depth (circuit.map Prod.fst) (fun word held =>
   memMap Prod.fst (edge word) circuit (covers word held))
 rw [mapLength] at bound
 exact bound

theorem completeCircuitAttainsPath (cap : Nat) (word : Word)
 (held : word∈wordsThroughDepth cap) : Path (forcedEdges cap) word emptyOne word.length := by
 induction word with
 | nil =>
   obtain ⟨width,positive,bound,generated⟩ := (shortMembership labels cap []).mp held
   have length := ((wordCharacterization _ _ _).mp generated).1
   rw [← length] at positive; cases positive
 | cons a rest ih =>
   have current := memMap edge (a::rest) (wordsThroughDepth cap) held
   cases rest with
   | nil => exact Path.step current (.identity emptyOne)
   | cons b tail =>
     obtain ⟨width,positive,bound,generated⟩ := (shortMembership labels cap (a::b::tail)).mp held
     have carrier := (wordCharacterization _ _ _).mp generated
     have tailHeld : (b::tail)∈wordsThroughDepth cap := by
       apply (shortMembership labels cap _).mpr
       refine ⟨(b::tail).length,Nat.zero_lt_succ _,?_,?_⟩
       · apply Nat.le_trans (Nat.le_succ _) ?_
         change (a::b::tail).length≤cap
         rw [carrier.1]
         exact bound
       · exact (wordCharacterization _ _ _).mpr ⟨rfl,fun x h => carrier.2 x (.tail a h)⟩
     change ((a::b::tail),if (a::b::tail).length>1 then b::tail else emptyOne)∈forcedEdges cap at current
     have longer : 1<(a::b::tail).length := Nat.succ_lt_succ (Nat.zero_lt_succ _)
     rw [if_pos longer] at current
     exact Path.step current (ih tailHeld)
end SFT.Computation.NativeCircuitPaths


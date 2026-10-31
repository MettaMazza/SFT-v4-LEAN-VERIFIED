import SFT.Physics.GravityCurvature
namespace SFT.Physics.GravityGeodesic
open GravityCurvature

-- GEODESIC keeps the whole source-curved path. Local free propagation
-- preserves the held inertial recurrence and has no added force record.
structure LocalStep (Event Source Word Force : Type) (recurrence : Word → Word)
 (first last : Event) where
 relation : Edge Event Source first last
 before : Word
 after : Word
 followsRecurrence : after=recurrence before
 extraForces : List Force
 unforced : extraForces=[]

inductive FreePath (Event Source Word Force : Type) (recurrence : Word → Word) :
 Event → Word → Event → Word → Type where
 | empty (event : Event) (word : Word) : FreePath Event Source Word Force recurrence event word event word
 | append {a b c : Event} {initial held : Word}
   (path : FreePath Event Source Word Force recurrence a initial b held)
   (step : LocalStep Event Source Word Force recurrence b c) (joins : step.before=held) :
   FreePath Event Source Word Force recurrence a initial c step.after

variable {Event Source Word Force : Type} {recurrence : Word → Word}

def transitions {a b : Event} {initial final : Word} :
 FreePath Event Source Word Force recurrence a initial b final → Nat
 | .empty _ _ => 0
 | .append path _ _ => transitions path+1

def sourcePath {a b : Event} {initial final : Word}
 (path : FreePath Event Source Word Force recurrence a initial b final) : GravityCurvature.Path Event Source a b :=
 match path with
 | .empty _ _ => .empty _
 | .append prior step _ => .append (sourcePath prior) step.relation

def forces {a b : Event} {initial final : Word} :
 FreePath Event Source Word Force recurrence a initial b final → List Force
 | .empty _ _ => []
 | .append path step _ => forces path ++ step.extraForces

def recurrenceSteps (step : Word → Word) : Nat → Word → Word
 | 0,w => w
 | n+1,w => step (recurrenceSteps step n w)

theorem everyTransitionUnforced {a b : Event} {initial final : Word}
 (path : FreePath Event Source Word Force recurrence a initial b final) : forces path=[] := by
 induction path with
 | empty => rfl
 | append path step joins ih =>
  change forces path ++ step.extraForces=[]
  rw [ih,step.unforced]
  rfl

theorem completeRecurrencePreserved {a b : Event} {initial final : Word}
 (path : FreePath Event Source Word Force recurrence a initial b final) :
 final=recurrenceSteps recurrence (transitions path) initial := by
 induction path with
 | empty => rfl
 | append path step joins ih =>
  change step.after=recurrence (recurrenceSteps recurrence (transitions path) _)
  exact step.followsRecurrence.trans (congrArg recurrence (joins.trans ih))

def Minimal {a b : Event} {initial final : Word}
 (path : FreePath Event Source Word Force recurrence a initial b final) : Prop :=
 ∀ {otherFinal : Word}, ∀ other : FreePath Event Source Word Force recurrence a initial b otherFinal,
 transitions path ≤ transitions other

theorem minimalTransitionCountUnique {a b : Event} {initial final : Word}
 (p : FreePath Event Source Word Force recurrence a initial b final)
 {otherFinal : Word} (q : FreePath Event Source Word Force recurrence a initial b otherFinal)
 (hp : Minimal p) (hq : Minimal q) : transitions p=transitions q :=
 Nat.le_antisymm (hp q) (hq p)

theorem shorterPathExcludesMinimality {a b : Event} {initial final : Word}
 (p : FreePath Event Source Word Force recurrence a initial b final)
 {otherFinal : Word} (q : FreePath Event Source Word Force recurrence a initial b otherFinal)
 (shorter : transitions q < transitions p) : ¬ Minimal p :=
 fun hp => Nat.not_lt_of_ge (hp q) shorter
end SFT.Physics.GravityGeodesic

import SFT.InformationScience.CompressionSupport
namespace SFT.Computation.Hashing
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

structure Model where
  messages : List String
  outputs : List String
  transform : String → String
  outputBound : ∀ message, message ∈ messages → transform message ∈ outputs

def fibre (m : Model) (output : String) : List String :=
  m.messages.filter (fun message => decide (m.transform message = output))

theorem fibreMeaning (m : Model) (output message : String) : message ∈ fibre m output ↔
    message ∈ m.messages ∧ m.transform message = output := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

def preimages (m : Model) : List (String × List String) := m.outputs.map (fun y => (y,fibre m y))

theorem everySourceRetained (m : Model) (message : String) (held : message ∈ m.messages) :
    (m.transform message,fibre m (m.transform message)) ∈ preimages m ∧ message ∈ fibre m (m.transform message) :=
  ⟨memMap _ _ _ (m.outputBound message held),(fibreMeaning _ _ _).mpr ⟨held,rfl⟩⟩

def collisions (m : Model) : List (String × String) :=
  (m.messages.flatMap (fun a => m.messages.map (fun b => (a,b)))).filter
    (fun pair => decide (pair.1 ≠ pair.2) && decide (m.transform pair.1 = m.transform pair.2))

theorem collisionMeaning (m : Model) (a b : String) : (a,b) ∈ collisions m ↔
    a ∈ m.messages ∧ b ∈ m.messages ∧ a ≠ b ∧ m.transform a = m.transform b := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    obtain ⟨x,hx,inner⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ p.1
    obtain ⟨y,hy,eq⟩ := memMapPreimage _ _ _ inner
    have xa := congrArg Prod.fst eq; have yb := congrArg Prod.snd eq
    cases xa; cases yb
    have q := (andTrue _ _).mp p.2
    exact ⟨hx,hy,of_decide_eq_true q.1,of_decide_eq_true q.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨SFT.Foundation.CommonRefinement.memFlatMap _ _ a (a,b) h.1
      (memMap (fun b => (a,b)) b _ h.2.1),(andTrue _ _).mpr ⟨decide_eq_true h.2.2.1,decide_eq_true h.2.2.2⟩⟩

theorem largerDomainNotInjective (m : Model) (unique : distinct m.messages = true)
    (larger : m.outputs.length < m.messages.length) :
    ¬ (∀ a, a ∈ m.messages → ∀ b, b ∈ m.messages → m.transform a = m.transform b → a = b) := by
  intro injective
  have uniqueCodes := SFT.Mathematics.CombinatorialSelections.mapDistinctWithin
    (fun a => [m.transform a]) m.messages unique (by
      intro a ha b hb same
      exact injective a ha b hb (List.cons.inj same).1)
  have bound := SFT.InformationScience.CompressionSupport.wordSubsetLength
    (m.messages.map (fun a => [m.transform a])) (m.outputs.map (fun y => [y])) uniqueCodes (by
      intro code held
      obtain ⟨source,hs,id⟩ := memMapPreimage _ _ _ held
      exact id ▸ memMap (fun y => [y]) _ _ (m.outputBound source hs))
  rw [SFT.Foundation.CommonRefinement.mapLength,SFT.Foundation.CommonRefinement.mapLength] at bound
  exact Nat.not_lt_of_ge bound larger

theorem largerDomainCollision (m : Model) (unique : distinct m.messages = true)
    (larger : m.outputs.length < m.messages.length) : collisions m ≠ [] := by
  intro empty
  apply largerDomainNotInjective m unique larger
  intro a ha b hb same
  cases decEq a b with
  | isTrue equal => exact equal
  | isFalse different =>
    have held := (collisionMeaning m a b).mpr ⟨ha,hb,different,same⟩
    rw [empty] at held; cases held

theorem postCompositionPreservesCollision (m : Model) (a b : String) (held : (a,b) ∈ collisions m)
    (next : String → String) : next (m.transform a) = next (m.transform b) :=
  congrArg next ((collisionMeaning _ _ _).mp held).2.2.2

def domainSeparated (domain output : String) : String × String := (domain,output)

theorem distinctDomains (left right x y : String) (different : left ≠ right) :
    domainSeparated left x ≠ domainSeparated right y := fun h => different (congrArg Prod.fst h)

theorem largerDomainWitness (m : Model) (unique : distinct m.messages = true)
    (larger : m.outputs.length < m.messages.length) :
    ∃ a b, a ∈ m.messages ∧ b ∈ m.messages ∧ a ≠ b ∧ m.transform a = m.transform b := by
  cases rows : collisions m with
  | nil => exact False.elim (largerDomainCollision m unique larger rows)
  | cons pair rest =>
    have held : pair ∈ collisions m := by rw [rows]; exact .head _
    exact ⟨pair.1,pair.2,(collisionMeaning _ _ _).mp held⟩

structure Extension (first second : Model) : Prop where
  messages : ∀ x, x ∈ first.messages → x ∈ second.messages
  outputs : ∀ y, y ∈ first.outputs → y ∈ second.outputs
  transform : ∀ x, x ∈ first.messages → second.transform x = first.transform x

theorem fibreExtension (first second : Model) (inc : Extension first second) (output message : String)
    (held : message ∈ fibre first output) : message ∈ fibre second output := by
  have p := (fibreMeaning _ _ _).mp held
  exact (fibreMeaning _ _ _).mpr ⟨inc.messages message p.1,(inc.transform message p.1).trans p.2⟩

theorem collisionExtension (first second : Model) (inc : Extension first second) (a b : String)
    (held : (a,b) ∈ collisions first) : (a,b) ∈ collisions second := by
  have p := (collisionMeaning _ _ _).mp held
  exact (collisionMeaning _ _ _).mpr ⟨inc.messages a p.1,inc.messages b p.2.1,p.2.2.1,
    (inc.transform a p.1).trans (p.2.2.2.trans (inc.transform b p.2.1).symm)⟩

theorem sameDomainEquality (domain x y : String) : domainSeparated domain x = domainSeparated domain y ↔ x = y := by
  constructor
  · intro h; exact congrArg Prod.snd h
  · intro h; cases h; rfl

theorem outputMembership (m : Model) (message : String) (held : message ∈ m.messages) : m.transform message ∈ m.outputs :=
  m.outputBound message held

end SFT.Computation.Hashing

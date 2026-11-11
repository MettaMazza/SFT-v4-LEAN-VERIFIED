import SFT.Chemistry.ExactComposition
namespace SFT.Chemistry.ReactionTotals
inductive Side where
 | reactant | product
 deriving DecidableEq
structure Element where
 identity : String
 count : Nat
 positive : 0 < count
 nonblank : SourceText.nonblank identity = true
def makeElement (identity : String) (count : Nat) (positive : 0 < count) : Except String Element :=
 if named : SourceText.nonblank identity = true then .ok ⟨identity,count,positive,named⟩
 else .error "elemental support must contain distinct held identities"

def uniqueElements : List Element → Bool
 | [] => true
 | first :: rest => rest.all (fun e => !SFT.Host.Text.equal first.identity e.identity) && uniqueElements rest

structure Species where
 side : Side
 identity : String
 coefficient : Nat
 positive : 0 < coefficient
 elements : List Element
 nonempty : elements ≠ []
 nonblank : SourceText.nonblank identity = true
 distinct : uniqueElements elements = true

def elementTotal (label : String) : List Element → Nat
 | [] => 0
 | element :: rest => (if element.identity = label then element.count else 0) + elementTotal label rest

def total (side : Side) (label : String) : List Species → Nat
 | [] => 0
 | species :: rest => (if species.side = side then species.coefficient * elementTotal label species.elements else 0) + total side label rest

def closed (word : List Species) : Prop := ∀ label, total .reactant label word = total .product label word

def reverseSide (species : Species) : Species :=
 {species with side := match species.side with | .reactant => .product | .product => .reactant}

theorem totalsAppend (side : Side) (label : String) (left right : List Species) :
 total side label (left ++ right) = total side label left + total side label right := by
 induction left with
 | nil => exact (Nat.zero_add _).symm
 | cons species rest ih =>
   change _ + total side label (rest++right) = _
   rw [ih]
   exact (Nat.add_assoc _ _ _).symm

theorem identicalPairClosed (species : Species) : closed [species,reverseSide species] := by
 intro label
 cases species with
 | mk side identity coefficient positive elements nonempty nonblank distinct =>
   cases side with
   | reactant =>
     change coefficient * elementTotal label elements + (0+0) = 0 + (coefficient * elementTotal label elements + 0)
     exact (Nat.zero_add _).symm
   | product =>
     change 0 + (coefficient * elementTotal label elements + 0) = coefficient * elementTotal label elements + (0+0)
     exact Nat.zero_add _

theorem pairedSuccessor (word : List Species) (species : Species) (prior : closed word) :
 closed (word ++ [species,reverseSide species]) := by
 intro label
 rw [totalsAppend,totalsAppend,prior label,identicalPairClosed species label]

theorem completePriorWordRetained (word : List Species) (species old : Species) (held : old ∈ word) :
 old ∈ word ++ [species,reverseSide species] := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem identityRetained (species : Species) : (reverseSide species).identity = species.identity := rfl

theorem formulaRetained (species : Species) : (reverseSide species).elements = species.elements := rfl
def makeSpecies (family side identity : String) (coefficient : Nat) (positive : 0 < coefficient)
 (elements : List Element) : Except String Species := do
 let orientation ← if family = "reaction-side" then
   if side = "reactant" then .ok Side.reactant else if side = "product" then .ok Side.product
   else .error "reaction side must be a held reactant/product orientation"
  else .error "reaction side must be a held reactant/product orientation"
 if named : SourceText.nonblank identity = true then
  if nonempty : elements ≠ [] then
   if unique : uniqueElements elements = true then .ok ⟨orientation,identity,coefficient,positive,elements,nonempty,named,unique⟩
   else .error "elemental support must contain distinct held identities"
  else .error "reaction species requires identity and elemental support"
 else .error "reaction species requires identity and elemental support"
def labels : List Species → List String
 | [] => []
 | species :: rest => species.elements.map Element.identity ++ labels rest

def checks (word : List Species) : List String → Bool
 | [] => true
 | label :: rest => decide (total .reactant label word = total .product label word) && checks word rest

def hasSide (side : Side) (word : List Species) : Bool := word.any (fun species => decide (species.side = side))

def reactionIsBalanced (word : List Species) : Bool :=
 if word.isEmpty then false else hasSide .reactant word && hasSide .product word && checks word (labels word)

theorem checksExactly (word : List Species) (support : List String) : checks word support = true ↔
 ∀ label ∈ support, total .reactant label word = total .product label word := by
 induction support with
 | nil => exact ⟨(fun _ label held => nomatch held),(fun _ => rfl)⟩
 | cons first rest ih =>
   constructor
   · intro h label held
     have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp h
     cases held with
     | head => exact of_decide_eq_true both.1
     | tail _ held => exact ih.mp both.2 label held
   · intro h
     exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
       ⟨decide_eq_true (h first (.head _)),ih.mpr (fun label held => h label (.tail _ held))⟩

theorem absentElementTotal (label : String) (elements : List Element)
 (absent : label ∉ elements.map Element.identity) : elementTotal label elements = 0 := by
 induction elements with
 | nil => rfl
 | cons first rest ih =>
   have different : first.identity ≠ label := by
     intro same
     exact absent (same ▸ (List.Mem.head (rest.map Element.identity)))
   have tailAbsent : label ∉ rest.map Element.identity := fun h => absent (.tail _ h)
   change (if first.identity = label then first.count else 0) + elementTotal label rest = 0
   rw [ite_eq_right different,ih tailAbsent]

theorem absentTotal (side : Side) (label : String) (word : List Species)
 (absent : label ∉ labels word) : total side label word = 0 := by
 induction word with
 | nil => rfl
 | cons first rest ih =>
   have leftAbsent : label ∉ first.elements.map Element.identity :=
     fun h => absent (SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ h)
   have rightAbsent : label ∉ labels rest :=
     fun h => absent (SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ h)
   change (if first.side = side then first.coefficient * elementTotal label first.elements else 0) + total side label rest = 0
   rw [absentElementTotal _ _ leftAbsent,ih rightAbsent,Nat.mul_zero]
   split <;> rfl

theorem labelCases (label : String) (support : List String) : label ∈ support ∨ label ∉ support := by
 induction support with
 | nil => exact .inr (fun h => nomatch h)
 | cons first rest ih =>
   by_cases same : first = label
   · exact .inl (same ▸ List.Mem.head rest)
   · cases ih with
     | inl held => exact .inl (.tail _ held)
     | inr absent =>
       apply Or.inr
       intro held
       cases held with
       | head => exact same rfl
       | tail _ h => exact absent h

theorem completeChecksExactly (word : List Species) : checks word (labels word) = true ↔ closed word := by
 constructor
 · intro h label
   cases labelCases label (labels word) with
   | inl held => exact (checksExactly _ _).mp h label held
   | inr absent => exact (absentTotal .reactant label word absent).trans (absentTotal .product label word absent).symm
 · intro h
   exact (checksExactly _ _).mpr (fun label _ => h label)

theorem balanceExactly (word : List Species) : reactionIsBalanced word = true ↔
 word.isEmpty = false ∧ hasSide .reactant word = true ∧ hasSide .product word = true ∧ closed word := by
 unfold reactionIsBalanced
 cases empty : word.isEmpty with
 | true => constructor <;> intro h
           · cases h
           · cases h.1
 | false =>
   change ((hasSide .reactant word && hasSide .product word) && checks word (labels word)) = true ↔ _
   constructor
   · intro h
     have a := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp h
     have b := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp a.1
     exact ⟨rfl,b.1,b.2,(completeChecksExactly _).mp a.2⟩
   · intro h
     exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
       ⟨(SFT.Mathematics.GeometryTopology.andTrue _ _).mpr ⟨h.2.1,h.2.2.1⟩,(completeChecksExactly _).mpr h.2.2.2⟩

theorem unequalElementRejected (word : List Species) (label : String)
 (different : total .reactant label word ≠ total .product label word) : reactionIsBalanced word ≠ true :=
 fun h => different (((balanceExactly _).mp h).2.2.2 label)
def lookup (label : String) : List (String × Nat) → Nat
 | [] => 0
 | (name,value) :: rest => if name = label then value else lookup label rest

def addCount (label : String) (amount : Nat) : List (String × Nat) → List (String × Nat)
 | [] => [(label,amount)]
 | (name,value) :: rest => if name = label then (name,value+amount)::rest else (name,value)::addCount label amount rest

def accumulateElements (coefficient : Nat) : List Element → List (String × Nat) → List (String × Nat)
 | [], totals => totals
 | element :: rest, totals => accumulateElements coefficient rest (addCount element.identity (coefficient*element.count) totals)

def sideTotalsFrom (side : Side) : List Species → List (String × Nat) → List (String × Nat)
 | [], totals => totals
 | species :: rest, totals => sideTotalsFrom side rest
   (if species.side = side then accumulateElements species.coefficient species.elements totals else totals)

def sideTotals (word : List Species) (side : String) : List (String × Nat) :=
 if side = "reactant" then sideTotalsFrom .reactant word [] else
 if side = "product" then sideTotalsFrom .product word [] else []

theorem lookupAddCount (query label : String) (amount : Nat) (totals : List (String × Nat)) :
 lookup query (addCount label amount totals) = lookup query totals + (if label=query then amount else 0) := by
 induction totals with
 | nil =>
   change (if label=query then amount else 0) = 0 + (if label=query then amount else 0)
   exact (Nat.zero_add _).symm
 | cons pair rest ih =>
   rcases pair with ⟨name,value⟩
   by_cases same : name=label
   · subst name
     unfold addCount
     rw [ite_eq_left rfl]
     unfold lookup
     by_cases equal : label=query
     · rw [ite_eq_left equal,ite_eq_left equal,ite_eq_left equal]
     · rw [ite_eq_right equal,ite_eq_right equal,ite_eq_right equal,Nat.add_zero]
   · unfold addCount
     rw [ite_eq_right same]
     unfold lookup
     by_cases equal : name=query
     · have other : label ≠ query := fun h => same (equal.trans h.symm)
       rw [ite_eq_left equal,ite_eq_left equal,ite_eq_right other,Nat.add_zero]
     · rw [ite_eq_right equal,ite_eq_right equal]
       exact ih

theorem lookupElements (label : String) (coefficient : Nat) (elements : List Element) (totals : List (String × Nat)) :
 lookup label (accumulateElements coefficient elements totals) = lookup label totals + coefficient*elementTotal label elements := by
 induction elements generalizing totals with
 | nil => exact (Nat.add_zero _).symm
 | cons first rest ih =>
   change lookup label (accumulateElements coefficient rest (addCount first.identity (coefficient*first.count) totals)) = _
   rw [ih,lookupAddCount]
   rw [elementTotal.eq_2]
   by_cases same : first.identity=label
   · rw [ite_eq_left same,ite_eq_left same,Nat.mul_add,Nat.add_assoc] <;> rfl
   · rw [ite_eq_right same,ite_eq_right same,Nat.zero_add,Nat.add_zero] <;> rfl

theorem lookupSideTotals (side : Side) (label : String) (word : List Species) (totals : List (String × Nat)) :
 lookup label (sideTotalsFrom side word totals) = lookup label totals + total side label word := by
 induction word generalizing totals with
 | nil => exact (Nat.add_zero _).symm
 | cons first rest ih =>
   rw [sideTotalsFrom.eq_2]
   rw [ih]
   rw [total.eq_2]
   by_cases same : first.side=side
   · rw [ite_eq_left same,ite_eq_left same,lookupElements,Nat.add_assoc] <;> rfl
   · rw [ite_eq_right same,ite_eq_right same,Nat.zero_add] <;> rfl

theorem balancedTotalsExactly (word : List Species) (valid : reactionIsBalanced word = true) (label : String) :
 lookup label (sideTotals word "reactant") = lookup label (sideTotals word "product") := by
 change lookup label (sideTotalsFrom .reactant word []) = lookup label (sideTotalsFrom .product word [])
 rw [lookupSideTotals,lookupSideTotals]
 exact congrArg (fun n => 0+n) (((balanceExactly _).mp valid).2.2.2 label)
end SFT.Chemistry.ReactionTotals

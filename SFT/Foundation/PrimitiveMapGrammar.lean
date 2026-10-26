import SFT.Foundation.PrimitiveMinimality
import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.PrimitiveMapGrammar
open PrimitiveMaps CommonRefinement Count.TraceDerivation

inductive Candidate where
  | single (a : Primitive)
  | double (a b : Primitive)
  | triple (a b c : Primitive)

def primitives : List Primitive := [.identity,.square,.constantOne,.fold]
def word : Candidate → List Primitive
  | .single a => [a]
  | .double a b => [a,b]
  | .triple a b c => [a,b,c]
def digit : Primitive → Nat
  | .identity => 0
  | .square => 1
  | .constantOne => 2
  | .fold => 3
def rank : Candidate → Nat
  | .single a => digit a + 1
  | .double a b => digit a * 4 + digit b + 1
  | .triple a b c => (digit a * 4 + digit b) * 4 + digit c + 1

def candidateId (c : Candidate) : String := SFT.Host.Text.join
  ["size-",toString (word c).length,":",SFT.Host.Text.intercalate ">" ((word c).map primitiveName)]
def exactForm (c : Candidate) : String := SFT.Host.Text.join
  ["Ordered size-",toString (word c).length," composition ",SFT.Host.Text.intercalate " then " ((word c).map primitiveName),"."]
def survivorId : String := "size-1:Fold"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def primitiveReason : Primitive → String
  | .identity => "Identity is injective and every orbit is static."
  | .square => "Square is injective and strictly contracts every proper exact part, so it has no nonstatic recurrent orbit."
  | .constantOne => "The constant map collapses every input to the fixed One and has no nonstatic recurrent orbit."
  | .fold => "Fold is noninjective and has the nonstatic recurrent one-third/two-thirds orbit, so it is the sole least-size generator."
def decisionReason : Candidate → String
  | .single p => primitiveReason p
  | .double _ _ => "A size-one generating self-map already exists, so every later composition is nonminimal regardless of its behavior."
  | .triple _ _ _ => "A size-one generating self-map already exists, so every later composition is nonminimal regardless of its behavior."
def generationRule : String := "Base-four rank every ordered word over identity, square, constant-One and Fold at sizes one, two and three; decide least-size generation before any larger composition."
def grammarBoundary : String := "The normalized parameter-free self-map grammar generated from x and the One by product, self-junction, complete-One cast and ordered composition; the executed prefix contains every word of size one through three, and the least-size certificate excludes every later word from minimality."

def candidates : List Candidate :=
  primitives.map Candidate.single ++
  (primitives.flatMap (fun a => primitives.map (Candidate.double a)) ++
  primitives.flatMap (fun a => primitives.flatMap (fun b => primitives.map (Candidate.triple a b))))

def survivor : Candidate := .single .fold

theorem primitiveComplete (p : Primitive) : p ∈ primitives := by
  cases p <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | single a => exact memAppendLeft _ _ _ (memMap _ a primitives (primitiveComplete a))
  | double a b =>
    apply memAppendRight
    apply memAppendLeft
    exact memFlatMap _ primitives a _ (primitiveComplete a) (memMap _ b primitives (primitiveComplete b))
  | triple a b c =>
    apply memAppendRight
    apply memAppendRight
    apply memFlatMap _ primitives a _ (primitiveComplete a)
    apply memFlatMap _ primitives b _ (primitiveComplete b)
    exact memMap _ c primitives (primitiveComplete c)

theorem generatedCardinality : candidates.length = 84 := rfl

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  cases c with
  | single a => cases a <;> constructor <;> intro h <;> first | rfl | cases h
  | double a b => cases a <;> cases b <;> constructor <;> intro h <;> cases h
  | triple a b c => cases a <;> cases b <;> cases c <;> constructor <;> intro h <;> cases h

theorem survivorAccepted : survives survivor = true := rfl

theorem survivorRank : rank survivor = 4 := rfl

theorem wordNonempty (c : Candidate) : 0 < (word c).length := by
  cases c <;> dsimp only [word,List.length_cons,List.length_nil] <;> decide

theorem wordWithinExecutedPrefix (c : Candidate) : (word c).length ≤ 3 := by
  cases c <;> dsimp only [word,List.length_cons,List.length_nil] <;> decide

theorem wordEncodingComplete (xs : List Primitive) (positive : 0 < xs.length) (bound : xs.length ≤ 3) :
    ∃ c : Candidate, word c = xs := by
  cases xs with
  | nil => cases positive
  | cons a rest =>
    cases rest with
    | nil => exact ⟨.single a,rfl⟩
    | cons b rest =>
      cases rest with
      | nil => exact ⟨.double a b,rfl⟩
      | cons c rest =>
        cases rest with
        | nil => exact ⟨.triple a b c,rfl⟩
        | cons d rest =>
          have bad : 4 ≤ 3 := Nat.le_trans (Nat.le_add_left 4 rest.length) bound
          exact False.elim (Nat.not_succ_le_zero 0 (Nat.le_of_succ_le_succ (Nat.le_of_succ_le_succ (Nat.le_of_succ_le_succ bad))))

theorem wordInjective (a b : Candidate) (h : word a = word b) : a = b := by
  cases a <;> cases b <;> cases h <;> rfl

theorem sourceAcceptanceIffLeastGenerator (c : Candidate) :
    survives c = true ↔ LeastGenerator (word c) := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact foldLeastGenerator
  · intro h
    have eq := leastGeneratorUnique (word c) h
    have same : c = survivor := wordInjective c survivor eq
    exact (uniqueSurvivor c).mpr same

end SFT.Foundation.PrimitiveMapGrammar

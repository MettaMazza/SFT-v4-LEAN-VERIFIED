import SFT.Physics.LeptonInvariants
namespace SFT.Physics.LeptonLedger
open SFT.Foundation SFT.Foundation.Count.TraceDerivation LeptonInvariants FoldFirstReturn

-- Positions are formal carrier identities, not approximations to root values.
inductive Position where
 | first | second | third
 deriving DecidableEq

structure Selection where
 first : Bool
 second : Bool
 third : Bool
 deriving DecidableEq

def term (s : Selection) : List Position :=
 (if s.first then [.first] else []) ++
 (if s.second then [.second] else []) ++ (if s.third then [.third] else [])

def selections : List Selection := [false,true].flatMap fun first =>
 [false,true].flatMap fun second => [false,true].map fun third => ⟨first,second,third⟩

def ledger : List (List Position) := selections.map term

theorem selectionComplete (s : Selection) : s ∈ selections := by
 cases s with
 | mk a b c =>
   cases a <;> cases b <;> cases c
   all_goals repeat first | exact List.Mem.head _ | apply List.Mem.tail

theorem termInjective (s t : Selection) (same : term s = term t) : s = t := by
 cases s with
 | mk a b c => cases t with
   | mk d e f =>
     cases a <;> cases b <;> cases c <;> cases d <;> cases e <;> cases f
     all_goals cases same
     all_goals rfl

theorem selectionsUnique : selections.Nodup := by decide

theorem ledgerUnique : ledger.Nodup := nodupMapInjective term termInjective selections selectionsUnique

theorem ledgerExhaustive (s : Selection) : term s ∈ ledger :=
 memMap term s selections (selectionComplete s)

def singles : List (List Position) := ledger.filter fun t => t.length == 1

def pairs : List (List Position) := ledger.filter fun t => t.length == 2

def triples : List (List Position) := ledger.filter fun t => t.length == 3

theorem singleLedger : singles = [[.third],[.second],[.first]] := rfl

theorem pairLedger : pairs = [[.second,.third],[.first,.third],[.first,.second]] := rfl

theorem tripleLedger : triples = [[.first,.second,.third]] := rfl

theorem allDegrees : ledger = [[],[.third],[.second],[.second,.third],
 [.first],[.first,.third],[.first,.second],[.first,.second,.third]] := rfl

-- Formal distributive expansion retains the chosen root factors for each term.
def expandFactors : List Position → List (List Position)
 | [] => [[]]
 | position :: rest => expandFactors rest ++ (expandFactors rest).map (List.cons position)

theorem expansionBase : expandFactors [] = [[]] := rfl

theorem expansionSuccessor (position : Position) (rest : List Position) :
 expandFactors (position :: rest) = expandFactors rest ++ (expandFactors rest).map (List.cons position) := rfl

theorem cubicExpansion : expandFactors [.first,.second,.third] = ledger := rfl

theorem expansionRetainsEarlier (position : Position) (rest : List Position) (held : List Position)
 (member : held ∈ expandFactors rest) : held ∈ expandFactors (position :: rest) :=
 memAppendLeft _ _ _ member

theorem expansionAddsProduct (position : Position) (rest : List Position) (held : List Position)
 (member : held ∈ expandFactors rest) : position :: held ∈ expandFactors (position :: rest) :=
 memAppendRight _ _ _ (memMap (List.cons position) held _ member)

def appendGenerated (previous : List (List Position)) (next : List Position) : List (List Position) := previous ++ [next]

theorem appendPreservesEarlier (previous : List (List Position)) (next held : List Position)
 (member : held ∈ previous) : held ∈ appendGenerated previous next := memAppendLeft _ _ _ member

theorem appendAddsTerm (previous : List (List Position)) (next : List Position) : next ∈ appendGenerated previous next :=
 memAppendRight _ _ _ (List.Mem.head _)

theorem appendOnce (previous : List (List Position)) (next : List Position)
 (unique : previous.Nodup) (fresh : next ∉ previous) : (appendGenerated previous next).Nodup :=
 nodupAppendFresh previous next unique fresh

theorem generatorCarrier : generatorPeriod = .ok singles.length := generatorPeriodThree

-- The three coefficient ledgers retain every non-leading symmetric role.
structure SymmetricCarrier where
 sumTerms : List (List Position)
 pairTerms : List (List Position)
 productTerms : List (List Position)

def cubicCarrier : SymmetricCarrier := ⟨singles,pairs,triples⟩

theorem carrierComplete : cubicCarrier.sumTerms.length = 3 ∧ cubicCarrier.pairTerms.length = 3 ∧
 cubicCarrier.productTerms.length = 1 ∧ ledger.Nodup ∧ ∀ selection, term selection ∈ ledger :=
 ⟨rfl,rfl,rfl,ledgerUnique,ledgerExhaustive⟩

theorem normalizedInvariantCarrier : invariantPairs = .ok ((1,1),(1,6),(1,485),(3,1454)) ∧
 generatorPeriod = .ok cubicCarrier.sumTerms.length ∧ ledger.Nodup :=
 ⟨exactInvariants,generatorCarrier,ledgerUnique⟩
end SFT.Physics.LeptonLedger

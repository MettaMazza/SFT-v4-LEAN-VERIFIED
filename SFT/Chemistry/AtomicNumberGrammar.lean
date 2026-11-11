import SFT.Chemistry.AtomicNumberOrder
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AtomicNumberGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "symbol-position-only"
  | .admitted => "exact-proton-count"

inductive Location where
  | rejected | admitted

def locationName : Location → String
  | .rejected => "whole-atom-particle-count"
  | .admitted => "nuclear-count-carrier"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "unordered-label"
  | .admitted => "positive-count-order"

inductive Element_map where
  | rejected | admitted

def element_mapName : Element_map → String
  | .rejected => "many-elements-one-count"
  | .admitted => "one-count-one-element-class"

inductive Isotope where
  | rejected | admitted

def isotopeName : Isotope → String
  | .rejected => "mass-dependent-number"
  | .admitted => "isotope-invariant"

inductive Charge where
  | rejected | admitted

def chargeName : Charge → String
  | .rejected => "electron-count-dependent"
  | .admitted => "charge-state-invariant"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "number-without-nucleus"
  | .admitted => "count-nucleus-element-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-order-offset"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  location : Location
  order : Order
  element_map : Element_map
  isotope : Isotope
  charge : Charge
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, locationName c.location, orderName c.order, element_mapName c.element_map, isotopeName c.isotope, chargeName c.charge, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "location=" (locationName c.location), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "element_map=" (element_mapName c.element_map), SFT.Host.Text.append "isotope=" (isotopeName c.isotope), SFT.Host.Text.append "charge=" (chargeName c.charge), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "exact-proton-count__nuclear-count-carrier__positive-count-order__one-count-one-element-class__isotope-invariant__charge-state-invariant__count-nucleus-element-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "exact-proton-count" &&
  SFT.Host.Text.equal (locationName c.location) "nuclear-count-carrier" &&
  SFT.Host.Text.equal (orderName c.order) "positive-count-order" &&
  SFT.Host.Text.equal (element_mapName c.element_map) "one-count-one-element-class" &&
  SFT.Host.Text.equal (isotopeName c.isotope) "isotope-invariant" &&
  SFT.Host.Text.equal (chargeName c.charge) "charge-state-invariant" &&
  SFT.Host.Text.equal (recordName c.record) "count-nucleus-element-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "exact-proton-count") then "A table position cannot define the nuclear quantity." else
  if !(SFT.Host.Text.equal (locationName c.location) "nuclear-count-carrier") then "Counting every atomic particle changes across isotopes and charge states." else
  if !(SFT.Host.Text.equal (orderName c.order) "positive-count-order") then "An unordered label cannot supply periodic succession." else
  if !(SFT.Host.Text.equal (element_mapName c.element_map) "one-count-one-element-class") then "Two element classes with one proton count violate their identity condition." else
  if !(SFT.Host.Text.equal (isotopeName c.isotope) "isotope-invariant") then "Mass-number variation must not alter element order." else
  if !(SFT.Host.Text.equal (chargeName c.charge) "charge-state-invariant") then "Ion formation changes electrons without changing the element." else
  if !(SFT.Host.Text.equal (recordName c.record) "count-nucleus-element-trace") then "A bare number loses the physical carrier and class mapping." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An offset can relabel the periodic order arbitrarily." else
  "exact-proton-count__nuclear-count-carrier"

def generationRule : String := "Generate the literal product of the registered atomic-number carrier, location, order, element map, isotope, charge, record and extension choices."
def grammarBoundary : String := "Every generated positive-finite nuclear proton collection and its one-to-one order coordinate over admitted chemical-element classes."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Location.rejected,Location.admitted]).flatMap fun location =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Element_map.rejected,Element_map.admitted]).flatMap fun element_map =>
  ([Isotope.rejected,Isotope.admitted]).flatMap fun isotope =>
  ([Charge.rejected,Charge.admitted]).flatMap fun charge =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,location,order,element_map,isotope,charge,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier location order element_map isotope charge record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlocation : location ∈ [Location.rejected,Location.admitted] := by
      cases location <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helement_map : element_map ∈ [Element_map.rejected,Element_map.admitted] := by
      cases element_map <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hisotope : isotope ∈ [Isotope.rejected,Isotope.admitted] := by
      cases isotope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcharge : charge ∈ [Charge.rejected,Charge.admitted] := by
      cases charge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ location _ hlocation
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ element_map _ helement_map
    apply CommonRefinement.memFlatMap _ _ isotope _ hisotope
    apply CommonRefinement.memFlatMap _ _ charge _ hcharge
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier location order element_map isotope charge record extension =>
    cases carrier <;> cases location <;> cases order <;> cases element_map <;> cases isotope <;> cases charge <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier location order element_map isotope charge record extension =>
    cases carrier <;> cases location <;> cases order <;> cases element_map <;> cases isotope <;> cases charge <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.location = .admitted ∧ c.order = .admitted ∧ c.element_map = .admitted ∧ c.isotope = .admitted ∧ c.charge = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier location order element_map isotope charge record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem location_rejected_rejected (c : Candidate) (h : c.location = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.location eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
    rw [h] at field
    cases field

theorem element_map_rejected_rejected (c : Candidate) (h : c.element_map = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.element_map eq
    rw [h] at field
    cases field

theorem isotope_rejected_rejected (c : Candidate) (h : c.isotope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.isotope eq
    rw [h] at field
    cases field

theorem charge_rejected_rejected (c : Candidate) (h : c.charge = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.charge eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.AtomicNumberGrammar

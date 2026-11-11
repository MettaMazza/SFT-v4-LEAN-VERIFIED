import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CellGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Sites where
  | rejected | admitted

def sitesName : Sites → String
  | .rejected => "one-conflated-site"
  | .admitted => "distinct-oxidation-reduction-sites"

inductive ElectronPath where
  | rejected | admitted

def electronPathName : ElectronPath → String
  | .rejected => "electron-teleportation"
  | .admitted => "complete-external-electron-path"

inductive IonicPath where
  | rejected | admitted

def ionicPathName : IonicPath → String
  | .rejected => "charge-accumulation-unclosed"
  | .admitted => "complete-compensating-ionic-path"

inductive Coupling where
  | rejected | admitted

def couplingName : Coupling → String
  | .rejected => "independent-half-reactions"
  | .admitted => "one-redox-transfer-cycle"

inductive Work where
  | rejected | admitted

def workName : Work → String
  | .rejected => "free-energy-output"
  | .admitted => "source-bounded-work-transfer"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "negative-potential-primitive"
  | .admitted => "held-cell-orientation"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "cell-label-only"
  | .admitted => "sites-paths-transfer-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-electrode-potential"
  | .admitted => "no-extra-rule"

structure Candidate where
  sites : Sites
  electronPath : ElectronPath
  ionicPath : IonicPath
  coupling : Coupling
  work : Work
  orientation : Orientation
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [sitesName c.sites, electronPathName c.electronPath, ionicPathName c.ionicPath, couplingName c.coupling, workName c.work, orientationName c.orientation, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "sites=" (sitesName c.sites), SFT.Host.Text.append "electron-path=" (electronPathName c.electronPath), SFT.Host.Text.append "ionic-path=" (ionicPathName c.ionicPath), SFT.Host.Text.append "coupling=" (couplingName c.coupling), SFT.Host.Text.append "work=" (workName c.work), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "distinct-oxidation-reduction-sites__complete-external-electron-path__complete-compensating-ionic-path__one-redox-transfer-cycle__source-bounded-work-transfer__held-cell-orientation__sites-paths-transfer-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sitesName c.sites) "distinct-oxidation-reduction-sites" &&
  SFT.Host.Text.equal (electronPathName c.electronPath) "complete-external-electron-path" &&
  SFT.Host.Text.equal (ionicPathName c.ionicPath) "complete-compensating-ionic-path" &&
  SFT.Host.Text.equal (couplingName c.coupling) "one-redox-transfer-cycle" &&
  SFT.Host.Text.equal (workName c.work) "source-bounded-work-transfer" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-cell-orientation" &&
  SFT.Host.Text.equal (recordName c.record) "sites-paths-transfer-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (sitesName c.sites) "distinct-oxidation-reduction-sites") then "Separation is required for an external path." else
  if !(SFT.Host.Text.equal (electronPathName c.electronPath) "complete-external-electron-path") then "It omits the transfer trace." else
  if !(SFT.Host.Text.equal (ionicPathName c.ionicPath) "complete-compensating-ionic-path") then "Accumulation halts sustained transfer." else
  if !(SFT.Host.Text.equal (couplingName c.coupling) "one-redox-transfer-cycle") then "Unpaired halves violate conservation." else
  if !(SFT.Host.Text.equal (workName c.work) "source-bounded-work-transfer") then "Untraced work creates support." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-cell-orientation") then "A negative scalar is not needed." else
  if !(SFT.Host.Text.equal (recordName c.record) "sites-paths-transfer-trace") then "A label cannot reproduce either path." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fitted potential can select behavior." else
  "distinct-oxidation-reduction-sites__complete-external-electron-path__complete-compensating-ionic-path__one-redox-transfer-cycle__source-bounded-work-transfer"

def generationRule : String := "Generate the literal product of site, electron-path, ionic-path, coupling, work, orientation, record and extra-rule choices."
def grammarBoundary : String := "Every finite separated pair of coupled redox sites with a complete electron path from oxidation to reduction, a complete compensating ionic path, retained chemical boundaries and source-bounded work transfer."

def candidates : List Candidate :=
  ([Sites.rejected,Sites.admitted]).flatMap fun sites =>
  ([ElectronPath.rejected,ElectronPath.admitted]).flatMap fun electronPath =>
  ([IonicPath.rejected,IonicPath.admitted]).flatMap fun ionicPath =>
  ([Coupling.rejected,Coupling.admitted]).flatMap fun coupling =>
  ([Work.rejected,Work.admitted]).flatMap fun work =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨sites,electronPath,ionicPath,coupling,work,orientation,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk sites electronPath ionicPath coupling work orientation record extra =>
    have hsites : sites ∈ [Sites.rejected,Sites.admitted] := by
      cases sites <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helectronPath : electronPath ∈ [ElectronPath.rejected,ElectronPath.admitted] := by
      cases electronPath <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hionicPath : ionicPath ∈ [IonicPath.rejected,IonicPath.admitted] := by
      cases ionicPath <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoupling : coupling ∈ [Coupling.rejected,Coupling.admitted] := by
      cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hwork : work ∈ [Work.rejected,Work.admitted] := by
      cases work <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ sites _ hsites
    apply CommonRefinement.memFlatMap _ _ electronPath _ helectronPath
    apply CommonRefinement.memFlatMap _ _ ionicPath _ hionicPath
    apply CommonRefinement.memFlatMap _ _ coupling _ hcoupling
    apply CommonRefinement.memFlatMap _ _ work _ hwork
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk sites electronPath ionicPath coupling work orientation record extra =>
    cases sites <;> cases electronPath <;> cases ionicPath <;> cases coupling <;> cases work <;> cases orientation <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk sites electronPath ionicPath coupling work orientation record extra =>
    cases sites <;> cases electronPath <;> cases ionicPath <;> cases coupling <;> cases work <;> cases orientation <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.sites = .admitted ∧ c.electronPath = .admitted ∧ c.ionicPath = .admitted ∧ c.coupling = .admitted ∧ c.work = .admitted ∧ c.orientation = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk sites electronPath ionicPath coupling work orientation record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem sites_rejected_rejected (c : Candidate) (h : c.sites = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sites eq
    rw [h] at field
    cases field

theorem electronPath_rejected_rejected (c : Candidate) (h : c.electronPath = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.electronPath eq
    rw [h] at field
    cases field

theorem ionicPath_rejected_rejected (c : Candidate) (h : c.ionicPath = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ionicPath eq
    rw [h] at field
    cases field

theorem coupling_rejected_rejected (c : Candidate) (h : c.coupling = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coupling eq
    rw [h] at field
    cases field

theorem work_rejected_rejected (c : Candidate) (h : c.work = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.work eq
    rw [h] at field
    cases field

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

theorem extra_rejected_rejected (c : Candidate) (h : c.extra = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Chemistry.CellGrammar

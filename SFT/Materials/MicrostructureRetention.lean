import SFT.Materials.Microstructure
namespace SFT.Materials.MicrostructureRetention
open Microstructure SFT.Physics.CollectiveCoarseGrain

def oneNetwork (scale : String) : NetworkObservation :=
 ⟨["One"],[],⟨["One"],[]⟩,rfl,scale,[("One","One")],[("One",["One"])],rfl⟩

def initial (scale lower upper : String) : Record :=
 ⟨oneNetwork scale,[("One",["One"])],[("One",["One"])],[],[],lower,upper⟩

theorem oneCompleteCarrier (scale lower upper : String) :
 (initial scale lower upper).network.graph.nodes=["One"] ∧
 (initial scale lower upper).network.classes=[("One",["One"])] := ⟨rfl,rfl⟩

theorem phasesRetained (record : Record) (extension : Extension) (row : String × List String)
 (held : row∈record.phases) : row∈(extend record extension).phases := by
 cases extension with
 | phase added => exact List.mem_append_left _ held
 | grain added => exact held
 | interface added => exact held
 | defect added => exact held

theorem finitePhasesRetained (record : Record) (history : List Extension) (row : String × List String)
 (held : row∈record.phases) : row∈(extendMany record history).phases := by
 induction history generalizing record with
 | nil => exact held
 | cons first rest ih => exact ih (extend record first) (phasesRetained record first row held)

theorem grainsRetained (record : Record) (extension : Extension) (row : String × List String)
 (held : row∈record.grains) : row∈(extend record extension).grains := by
 cases extension with
 | phase added => exact held
 | grain added => exact List.mem_append_left _ held
 | interface added => exact held
 | defect added => exact held

theorem finiteGrainsRetained (record : Record) (history : List Extension) (row : String × List String)
 (held : row∈record.grains) : row∈(extendMany record history).grains := by
 induction history generalizing record with
 | nil => exact held
 | cons first rest ih => exact ih (extend record first) (grainsRetained record first row held)

theorem interfacesRetained (record : Record) (extension : Extension) (row : String × String × String)
 (held : row∈record.interfaces) : row∈(extend record extension).interfaces := by
 cases extension with
 | phase added => exact held
 | grain added => exact held
 | interface added => exact List.mem_append_left _ held
 | defect added => exact held

theorem finiteInterfacesRetained (record : Record) (history : List Extension) (row : String × String × String)
 (held : row∈record.interfaces) : row∈(extendMany record history).interfaces := by
 induction history generalizing record with
 | nil => exact held
 | cons first rest ih => exact ih (extend record first) (interfacesRetained record first row held)

theorem defectsRetained (record : Record) (extension : Extension) (row : String × List String)
 (held : row∈record.defects) : row∈(extend record extension).defects := by
 cases extension with
 | phase added => exact held
 | grain added => exact held
 | interface added => exact held
 | defect added => exact List.mem_append_left _ held

theorem finiteDefectsRetained (record : Record) (history : List Extension) (row : String × List String)
 (held : row∈record.defects) : row∈(extendMany record history).defects := by
 induction history generalizing record with
 | nil => exact held
 | cons first rest ih => exact ih (extend record first) (defectsRetained record first row held)

theorem finiteObservationBoundary (record : Record) (history : List Extension) :
 (extendMany record history).network.scale=record.network.scale ∧
 (extendMany record history).constituentBoundary=record.constituentBoundary ∧
 (extendMany record history).bulkBoundary=record.bulkBoundary := by
 induction history generalizing record with
 | nil => exact ⟨rfl,rfl,rfl⟩
 | cons first rest ih =>
   have h:=ih (extend record first)
   have network:=extensionRetainsNetwork record first
   have boundaries:=extensionRetainsBoundary record first
   exact ⟨h.1.trans (congrArg (fun n => n.scale) network),h.2.1.trans boundaries.1,h.2.2.trans boundaries.2⟩
end SFT.Materials.MicrostructureRetention

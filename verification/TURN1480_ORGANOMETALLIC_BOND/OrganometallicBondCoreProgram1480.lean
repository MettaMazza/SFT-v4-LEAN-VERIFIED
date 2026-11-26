import SFT.Chemistry.OrganometallicBond
import SFT.Host.Canonical
open SFT.Chemistry.OrganometallicBond SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def incidenceJSON (i : Incidence) : J := .object [("centre",labelJSON i.centre),("carbon_occurrence",labelJSON i.carbon),("electron_support",.array (i.electrons.map labelJSON))]
def topologyJSON (t : Topology) : J := .object [("entity",labelJSON t.entity),("incidences",.array (t.incidences.map incidenceJSON)),("direct_incidence_count",.integer (.ofNat t.directCount.value)),("classification",labelJSON t.classification)]
def bondJSON : BondSupport → J
 | .empty identity => .object [("empty",.text identity)]
 | .positive t => topologyJSON t
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
result ((direct "M1" "C1" ⟨1,by decide⟩).map incidenceJSON),
result ((do forceRows "entity" [← direct "M1" "C1" ⟨1,by decide⟩]).map topologyJSON),
result ((do appendDirect (← forceRows "entity" [← direct "M1" "C1" ⟨1,by decide⟩]) (← direct "M1" "C2" ⟨1,by decide⟩)).map topologyJSON),
result ((direct "M1" "C1" ⟨2,by decide⟩).map incidenceJSON),
result ((do forceRows "entity" [← direct "M1" "C1" ⟨2,by decide⟩]).map topologyJSON),
result ((do appendDirect (← forceRows "entity" [← direct "M1" "C1" ⟨2,by decide⟩]) (← direct "M1" "C2" ⟨2,by decide⟩)).map topologyJSON),
result ((direct "M1" "C1" ⟨3,by decide⟩).map incidenceJSON),
result ((do forceRows "entity" [← direct "M1" "C1" ⟨3,by decide⟩]).map topologyJSON),
result ((do appendDirect (← forceRows "entity" [← direct "M1" "C1" ⟨3,by decide⟩]) (← direct "M1" "C2" ⟨3,by decide⟩)).map topologyJSON),
result ((direct "M1" "C1" ⟨4,by decide⟩).map incidenceJSON),
result ((do forceRows "entity" [← direct "M1" "C1" ⟨4,by decide⟩]).map topologyJSON),
result ((do appendDirect (← forceRows "entity" [← direct "M1" "C1" ⟨4,by decide⟩]) (← direct "M1" "C2" ⟨4,by decide⟩)).map topologyJSON),
result ((direct "M1" "C1" ⟨5,by decide⟩).map incidenceJSON),
result ((do forceRows "entity" [← direct "M1" "C1" ⟨5,by decide⟩]).map topologyJSON),
result ((do appendDirect (← forceRows "entity" [← direct "M1" "C1" ⟨5,by decide⟩]) (← direct "M1" "C2" ⟨5,by decide⟩)).map topologyJSON),
result ((direct "M1" "C1" ⟨6,by decide⟩).map incidenceJSON),
result ((do forceRows "entity" [← direct "M1" "C1" ⟨6,by decide⟩]).map topologyJSON),
result ((do appendDirect (← forceRows "entity" [← direct "M1" "C1" ⟨6,by decide⟩]) (← direct "M1" "C2" ⟨6,by decide⟩)).map topologyJSON),
result ((forced "" (.empty "empty-One")).map bondJSON),
result ((forced "" (.empty "custom-absence")).map bondJSON),
result ((forced "entity" (.rows [])).map bondJSON),
result ((incidence ⟨"other","M1",by decide,by decide⟩ ⟨"carbon-occurrence","C1",by decide,by decide⟩ [⟨"held-bond-electron","e",by decide,by decide⟩]).map incidenceJSON),
result ((incidence ⟨"organometallic-centre-occurrence","M1",by decide,by decide⟩ ⟨"other","C1",by decide,by decide⟩ [⟨"held-bond-electron","e",by decide,by decide⟩]).map incidenceJSON),
result ((incidence ⟨"organometallic-centre-occurrence","M1",by decide,by decide⟩ ⟨"carbon-occurrence","C1",by decide,by decide⟩ []).map incidenceJSON),
result ((incidence ⟨"organometallic-centre-occurrence","M1",by decide,by decide⟩ ⟨"carbon-occurrence","C1",by decide,by decide⟩ [⟨"other","e",by decide,by decide⟩]).map incidenceJSON),
result ((incidence ⟨"organometallic-centre-occurrence","M1",by decide,by decide⟩ ⟨"carbon-occurrence","C1",by decide,by decide⟩ [⟨"held-bond-electron","e",by decide,by decide⟩,⟨"held-bond-electron","e",by decide,by decide⟩]).map incidenceJSON),
result ((do topology ⟨"wrong","entity",by decide,by decide⟩ [(← direct "M1" "C1" ⟨2,by decide⟩)] ⟨1,by decide⟩ ⟨"chemical-class","organometallic",by decide,by decide⟩).map topologyJSON),
result ((do topology ⟨"chemical-entity","entity",by decide,by decide⟩ [] ⟨1,by decide⟩ ⟨"chemical-class","organometallic",by decide,by decide⟩).map topologyJSON),
result ((do topology ⟨"chemical-entity","entity",by decide,by decide⟩ [(← direct "M1" "C1" ⟨2,by decide⟩),(← direct "M1" "C2" ⟨2,by decide⟩)] ⟨1,by decide⟩ ⟨"chemical-class","organometallic",by decide,by decide⟩).map topologyJSON),
result ((do topology ⟨"chemical-entity","entity",by decide,by decide⟩ [(← direct "M1" "C1" ⟨2,by decide⟩),(← direct "M1" "C1" ⟨3,by decide⟩)] ⟨2,by decide⟩ ⟨"chemical-class","organometallic",by decide,by decide⟩).map topologyJSON),
result ((do topology ⟨"chemical-entity","entity",by decide,by decide⟩ [(← direct "M1" "C1" ⟨2,by decide⟩)] ⟨1,by decide⟩ ⟨"other","organometallic",by decide,by decide⟩).map topologyJSON),
result ((do topology ⟨"chemical-entity","entity",by decide,by decide⟩ [(← direct "M1" "C1" ⟨2,by decide⟩)] ⟨1,by decide⟩ ⟨"chemical-class","other",by decide,by decide⟩).map topologyJSON),
result ((do appendDirect (← first) (← direct "M1" "C1" ⟨3,by decide⟩)).map topologyJSON)]))

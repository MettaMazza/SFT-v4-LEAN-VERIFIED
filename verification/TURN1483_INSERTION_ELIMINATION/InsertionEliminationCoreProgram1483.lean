import SFT.Chemistry.InsertionElimination
import SFT.Host.Canonical
open SFT.Chemistry.InsertionElimination SFT.Physics.CapabilityValues
set_option maxHeartbeats 20000000
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def labelsJSON (xs : List HeldLabel) : J := .array (xs.map labelJSON)
def edgeJSON (p : Edge) : J := .array [labelJSON p.1,labelJSON p.2]
def edgesJSON (xs : List Edge) : J := .array (xs.map edgeJSON)
def traceJSON (t : Trace) : J := .object [("carriers",labelsJSON t.carriers),("before",edgesJSON t.before),("after",edgesJSON t.after),("removed",edgesJSON t.removed),("added",edgesJSON t.added),("pathway_class",labelJSON t.pathwayClass),("composition",labelsJSON t.composition)]
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
result ((insertion "X" "Y" "Z").map traceJSON),
result ((do extrusion (← insertion "X" "Y" "Z")).map traceJSON),
result ((migratory "X" "Y" "Z").map traceJSON),
result ((do extrusion (← migratory "X" "Y" "Z")).map traceJSON),
result ((insertion "X" "Z" "Y").map traceJSON),
result ((do extrusion (← insertion "X" "Z" "Y")).map traceJSON),
result ((migratory "X" "Z" "Y").map traceJSON),
result ((do extrusion (← migratory "X" "Z" "Y")).map traceJSON),
result ((insertion "Y" "X" "Z").map traceJSON),
result ((do extrusion (← insertion "Y" "X" "Z")).map traceJSON),
result ((migratory "Y" "X" "Z").map traceJSON),
result ((do extrusion (← migratory "Y" "X" "Z")).map traceJSON),
result ((insertion "Y" "Z" "X").map traceJSON),
result ((do extrusion (← insertion "Y" "Z" "X")).map traceJSON),
result ((migratory "Y" "Z" "X").map traceJSON),
result ((do extrusion (← migratory "Y" "Z" "X")).map traceJSON),
result ((insertion "Z" "X" "Y").map traceJSON),
result ((do extrusion (← insertion "Z" "X" "Y")).map traceJSON),
result ((migratory "Z" "X" "Y").map traceJSON),
result ((do extrusion (← migratory "Z" "X" "Y")).map traceJSON),
result ((insertion "Z" "Y" "X").map traceJSON),
result ((do extrusion (← insertion "Z" "Y" "X")).map traceJSON),
result ((migratory "Z" "Y" "X").map traceJSON),
result ((do extrusion (← migratory "Z" "Y" "X")).map traceJSON),
result ((insertion "X" "X" "Y").map traceJSON),
result ((do extrusion (← insertion "X" "X" "Y")).map traceJSON),
result ((migratory "X" "X" "Y").map traceJSON),
result ((do extrusion (← migratory "X" "X" "Y")).map traceJSON),
result ((insertion "X" "Z" "X").map traceJSON),
result ((do extrusion (← insertion "X" "Z" "X")).map traceJSON),
result ((migratory "X" "Z" "X").map traceJSON),
result ((do extrusion (← migratory "X" "Z" "X")).map traceJSON),
result ((insertion "" "Z" "Y").map traceJSON),
result ((do extrusion (← insertion "" "Z" "Y")).map traceJSON),
result ((migratory "" "Z" "Y").map traceJSON),
result ((do extrusion (← migratory "" "Z" "Y")).map traceJSON),
result ((insertion "α" "β" "γ").map traceJSON),
result ((do extrusion (← insertion "α" "β" "γ")).map traceJSON),
result ((migratory "α" "β" "γ").map traceJSON),
result ((do extrusion (← migratory "α" "β" "γ")).map traceJSON),
result ((elimination "A" "B" "X" "Y").map traceJSON),
result ((elimination "A" "A" "X" "Y").map traceJSON),
result ((elimination "A" "B" "X" "X").map traceJSON),
result ((elimination "A" "A" "X" "X").map traceJSON),
result ((elimination "A" "X" "A" "X").map traceJSON),
result ((elimination "B" "A" "Y" "X").map traceJSON),
result ((elimination "" "B" "X" "Y").map traceJSON),
result ((elimination "α" "β" "γ" "δ").map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","X",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","X",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩),(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩),(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩),(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩),(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"other","insertion",by decide,by decide⟩ [⟨"process-component","insertion",by decide,by decide⟩]).map traceJSON),
result ((trace [⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] [(⟨"carrier","X",by decide,by decide⟩,⟨"carrier","Y",by decide,by decide⟩),(⟨"carrier","Y",by decide,by decide⟩,⟨"carrier","Z",by decide,by decide⟩)] ⟨"organometallic-pathway","insertion",by decide,by decide⟩ []).map traceJSON),
result (.ok (edgeJSON (edge ⟨"a","z",by decide,by decide⟩ ⟨"b","a",by decide,by decide⟩))),
result (.ok (edgeJSON (edge ⟨"same","a",by decide,by decide⟩ ⟨"same","z",by decide,by decide⟩))),
result (.ok (edgeJSON (edge ⟨"same","α",by decide,by decide⟩ ⟨"same","β",by decide,by decide⟩))),
result (.ok (edgeJSON (edge ⟨"same","a",by decide,by decide⟩ ⟨"same","a",by decide,by decide⟩)))]))

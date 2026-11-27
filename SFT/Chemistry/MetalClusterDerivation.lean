import SFT.Chemistry.MetalCluster
namespace SFT.Chemistry.MetalClusterDerivation
open SFT.Physics.CapabilityValues MetalCluster

theorem relationRetains (l r m : HeldLabel) (bs : List HeldLabel) (out : Relation)
 (h : makeRelation l r m bs=.ok out) : out=⟨l,r,m,bs⟩ := by
 unfold makeRelation at h
 repeat first | split at h | cases h | rfl

theorem clusterRetains (e : HeldLabel) (cs : List HeldLabel) (rs : List Relation) (n : PositiveCount)
 (d b : ElectronCountSpin.CountOrEmpty) (out : Cluster)
 (h : cluster e cs rs n d b=.ok out) : out=⟨e,cs,rs,n,d,b⟩ := by
 unfold cluster at h
 repeat first | split at h | cases h | rfl

theorem acceptedConnected (e : HeldLabel) (cs : List HeldLabel) (rs : List Relation) (n : PositiveCount)
 (d b : ElectronCountSpin.CountOrEmpty) (out : Cluster)
 (h : cluster e cs rs n d b=.ok out) : connected cs rs=true := by
 unfold cluster at h
 split at h
 · cases h
 · split at h
   · cases h
   · split at h
     · cases h
     · cases hc : connected cs rs with
       | true => rfl
       | false => rw [hc] at h; cases h

theorem forcedRetains (entity : String) (labels : List String) (rs : List Relation) (out : Cluster)
 (h : forced entity labels rs=.ok out) :
 out.relations=rs ∧ out.centreCount.value=out.centres.length ∧
 out.directCount=counted (classCount "direct-metal-bond" rs) ∧
 out.bridgeCount=counted (classCount "bridging-ligand-path" rs) ∧ connected out.centres rs=true ∧
 labels.mapM (heldLabel "metal-centre")=.ok out.centres ∧ out.entity.label=entity := by
 unfold forced at h
 cases hc : labels.mapM (heldLabel "metal-centre") with
 | error err => rw [hc] at h; cases h
 | ok cs =>
  rw [hc] at h
  cases he : heldLabel "cluster-entity" entity with
  | error err => rw [he] at h; cases h
  | ok e =>
   rw [he] at h
   change (do
    let n ← count cs.length
    cluster e cs rs n (counted (classCount "direct-metal-bond" rs)) (counted (classCount "bridging-ligand-path" rs)))=.ok out at h
   cases hn : count cs.length with
   | error err => rw [hn] at h; cases h
   | ok n =>
    rw [hn] at h
    have conn := acceptedConnected e cs rs n _ _ out h
    have kept := clusterRetains e cs rs n _ _ out h
    cases kept
    have size : n.value=cs.length := by
     unfold count at hn
     split at hn
     · cases hn; rfl
     · cases hn
    have name : e.label=entity := by
     unfold heldLabel at he
     repeat first | split at he | cases he | rfl
    exact ⟨rfl,size,rfl,rfl,conn,rfl,name⟩

theorem appendRetains (c out : Cluster) (label anchor mode : String)
 (h : appendCentre c label anchor mode=.ok out) :
 ∃ r, out.relations=c.relations++[r] ∧
 (c.centres.map HeldLabel.label++[label]).mapM (heldLabel "metal-centre")=.ok out.centres ∧
 out.centreCount.value=out.centres.length ∧ connected out.centres out.relations=true ∧
 out.entity.label=c.entity.label := by
 unfold appendCentre at h
 dsimp only at h
 cases hr : relation anchor label mode
  (if SFT.Host.Text.equal mode "bridging-ligand-path" then ElectronCountSpin.CountOrEmpty.count ⟨1,by decide⟩ else .emptyOne "empty-One") with
 | error err => rw [hr] at h; cases h
 | ok r =>
  rw [hr] at h
  have kept := forcedRetains c.entity.label (c.centres.map HeldLabel.label++[label]) (c.relations++[r]) out h
  exact ⟨r,kept.1,kept.2.2.2.2.2.1,kept.2.1,kept.1 ▸ kept.2.2.2.2.1,kept.2.2.2.2.2.2⟩

theorem namedCentreCount (labels : List String) (cs : List HeldLabel)
 (h : labels.mapM (heldLabel "metal-centre")=.ok cs) : cs.length=labels.length := by
 have rev : ∀ (xs acc : List HeldLabel), (xs.reverseAux acc).length=xs.length+acc.length := by
  intro xs
  induction xs with
  | nil => intro acc; exact (Nat.zero_add _).symm
  | cons x xs ih =>
   intro acc
   exact (ih (x::acc)).trans (Nat.add_right_comm xs.length acc.length 1)
 have loop : ∀ (xs : List String) (acc result : List HeldLabel),
  List.mapM.loop (heldLabel "metal-centre") xs acc=.ok result → result.length=xs.length+acc.length := by
  intro xs
  induction xs with
  | nil =>
   intro acc result h
   change Except.ok acc.reverse=Except.ok result at h
   cases h
   exact (rev acc []).trans (Nat.zero_add acc.length).symm
  | cons x xs ih =>
   intro acc result h
   unfold List.mapM.loop at h
   cases hx : heldLabel "metal-centre" x with
   | error err => rw [hx] at h; cases h
   | ok x =>
    rw [hx] at h
    exact (ih (x::acc) result h).trans (Nat.add_right_comm xs.length acc.length 1)
 exact loop labels [] cs h

theorem appendCount (c out : Cluster) (label anchor mode : String)
 (h : appendCentre c label anchor mode=.ok out) : out.centreCount.value=c.centres.length+1 := by
 obtain ⟨r,hr,hlabels,hcount,hconn,hentity⟩ := appendRetains c out label anchor mode h
 rw [hcount,namedCentreCount _ _ hlabels,SFT.Foundation.CommonRefinement.appendLength,
  SFT.Foundation.CommonRefinement.mapLength]
 rfl

theorem classCountExtension (mode : String) (rs : List Relation) (r : Relation) :
 classCount mode (rs++[r])=classCount mode rs+(if SFT.Host.Text.equal r.mode.label mode then 1 else 0) := by
 induction rs with
 | nil =>
  unfold classCount
  simp only [List.nil_append,List.filter]
  cases SFT.Host.Text.equal r.mode.label mode <;> rfl
 | cons a rs ih =>
  unfold classCount at *
  rw [List.cons_append,List.filter,List.filter]
  cases SFT.Host.Text.equal a.mode.label mode with
  | false => exact ih
  | true =>
   change ((rs++[r]).filter _).length+1=(rs.filter _).length+1+_
   rw [ih,Nat.add_right_comm]

theorem reachedExact (rs : List Relation) (first : HeldLabel) :
 reached rs first=MetalClusterClosure.closure (edges rs) [first] :=
 MetalClusterClosure.endpointBoundScan (edges rs) [first]

theorem reachedClosed (rs : List Relation) (first : HeldLabel) :
 MulticentreSupport.scanEdges (edges rs) (reached rs first)=reached rs first := by
 rw [reachedExact]
 exact MetalClusterClosure.closureFixed _ _

theorem attachedCentreStep (rs : List Relation) (cs : List HeldLabel) (anchor fresh : HeldLabel)
 (fixed : MulticentreSupport.scanEdges (edges rs) cs=cs)
 (held : MulticentreSupport.contains cs anchor=true) (newCentre : MulticentreSupport.contains cs fresh=false) :
 MulticentreSupport.scanEdges (edges rs++[⟨anchor,fresh⟩]) cs=cs++[fresh] := by
 rw [MulticentreDerivation.scanEdgesConcatenation,fixed]
 change (if MulticentreSupport.contains cs anchor || MulticentreSupport.contains cs fresh then
  MulticentreSupport.addReached (MulticentreSupport.addReached cs anchor) fresh else cs)=cs++[fresh]
 rw [held,newCentre]
 unfold MulticentreSupport.addReached
 rw [held]
 change (if MulticentreSupport.contains cs fresh then cs else cs++[fresh])=cs++[fresh]
 rw [newCentre]
 rfl
end SFT.Chemistry.MetalClusterDerivation

import SFT.Chemistry.InorganicNetworkBoundary
namespace SFT.Chemistry.InorganicNetworkDerivation
open SFT.Physics.CapabilityValues InorganicNetwork

theorem lewisRetains (s p a : HeldLabel) (pair : List HeldLabel) (product : HeldLabel) (out : Lewis)
 (h : lewis s p a pair product=.ok out) : out=⟨s,p,a,pair,product⟩ := by
 unfold lewis at h
 repeat' first | split at h | cases h | rfl

theorem redoxRetains (s d a : HeldLabel) (support : List HeldLabel) (out : Redox)
 (h : redox s d a support=.ok out) : out=⟨s,d,a,support⟩ := by
 unfold redox at h
 repeat' first | split at h | cases h | rfl

theorem networkRetains (identity : HeldLabel) (sp : List HeldLabel) (acid : Support Lewis) (redox : Support Redox) (path : List HeldLabel) (out : Network)
 (h : network identity sp acid redox path=.ok out) : out=⟨identity,sp,acid,redox,path⟩ := by
 unfold network at h
 dsimp only at h
 repeat' first | split at h | cases h | rfl

theorem reverseConserves (s out : Redox) (label : String)
 (h : reverseRedox s label=.ok out) : out.donor=s.acceptor ∧ out.acceptor=s.donor ∧ out.electrons=s.electrons := by
 unfold reverseRedox at h
 cases hs : heldLabel "inorganic-network-step" label with
 | error e => rw [hs] at h; cases h
 | ok step =>
  rw [hs] at h
  have kept := redoxRetains step s.acceptor s.donor s.electrons out h
  cases kept
  exact ⟨rfl,rfl,rfl⟩

theorem appendRetains (s out : Network) (step : Redox)
 (h : appendRedox s step=.ok out) :
 out.network=s.network ∧ out.species=orderedUnique (s.species++redoxParticipants step) ∧
 out.acid=pack (values s.acid) ∧ out.redox=.rows (values s.redox++[step]) ∧ out.path=s.path++[step.step] := by
 have kept := networkRetains s.network (orderedUnique (s.species++redoxParticipants step)) (pack (values s.acid)) (.rows (values s.redox++[step])) (s.path++[step.step]) out h
 cases kept
 exact ⟨rfl,rfl,rfl,rfl,rfl⟩

theorem appendPathCount (s out : Network) (step : Redox)
 (h : appendRedox s step=.ok out) : out.path.length=s.path.length+1 := by
 obtain ⟨_,_,_,_,hp⟩ := appendRetains s out step h
 rw [hp,SFT.Foundation.CommonRefinement.appendLength]
 rfl
end SFT.Chemistry.InorganicNetworkDerivation

import SFT.Chemistry.InorganicNetworkDerivation
namespace SFT.Chemistry.InorganicNetworkSupportDerivation
open SFT.Physics.CapabilityValues InorganicNetwork

theorem positiveTransfer (s d a : HeldLabel) (electrons : List HeldLabel) (out : Redox)
 (h : redox s d a electrons=.ok out) : 0<out.electrons.length := by
 have retained := InorganicNetworkDerivation.redoxRetains s d a electrons out h
 cases retained
 cases electrons with
 | nil =>
  unfold redox at h
  dsimp only [List.isEmpty,Bool.or] at h
  repeat' first | contradiction | split at h | cases h
 | cons e es => exact Nat.zero_lt_succ es.length

theorem exactPairCount (s p a : HeldLabel) (pair : List HeldLabel) (product : HeldLabel) (out : Lewis)
 (h : lewis s p a pair product=.ok out) : out.pair.length=2 := by
 have retained := InorganicNetworkDerivation.lewisRetains s p a pair product out h
 cases retained
 cases he : pair.length == 2 with
 | true => exact Nat.eq_of_beq_eq_true he
 | false =>
  unfold lewis at h
  unfold bne at h
  rw [he] at h
  dsimp only [Bool.not,Bool.or] at h
  repeat' first | contradiction | split at h | cases h
end SFT.Chemistry.InorganicNetworkSupportDerivation

import SFT.Host.SHA256Streaming
import Lean
def main : IO Unit := do
 let b ← IO.FS.readBinFile "work/hash_profile1469.bin"
 IO.println (SFT.Host.SHA256Streaming.digest b)

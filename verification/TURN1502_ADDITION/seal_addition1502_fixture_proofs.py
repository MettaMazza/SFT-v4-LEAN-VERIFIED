from pathlib import Path
import re,json
w=Path('work');p=w/'AdditionGraphProofExact1502.lean';s=p.read_text();pairs={};defs=[]
pat=r'⟨("(?:[^"\\]|\\.)*"),("(?:[^"\\]|\\.)*"),(?:rfl|by decide),(?:rfl|by decide)⟩'
def sub(m):
 key=(m[1],m[2])
 if key not in pairs:
  n='held'+str(len(pairs));pairs[key]=n
  defs.extend([f'private theorem {n}Family : SFT.Physics.CapabilityValues.nonblank {m[1]} = true := rfl',f'private theorem {n}Label : SFT.Physics.CapabilityValues.nonblank {m[2]} = true := rfl',f'private def {n} : SFT.Physics.CapabilityValues.HeldLabel := ⟨{m[1]},{m[2]},{n}Family,{n}Label⟩',f'private theorem {n}Name : {n}.label = {m[2]} := rfl'])
 return pairs[key]
s=re.sub(pat,sub,s);a=s.index('def sourceSame');s=s[:a]+'\n'.join(defs)+'\n'+s[a:];s=s.replace('simp only [List.filter,','simp only [List.filter,'+','.join(n+'Name'for n in pairs.values())+',');p.write_text(s);print('Typed literal fixtures',len(pairs))

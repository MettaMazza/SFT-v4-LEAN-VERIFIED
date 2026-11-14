from pathlib import Path
w=Path('work');r=w/'constants-recovery'
items=[('wormhole',909,'WormholeEntry','Wormhole','WORMHOLE_SPEC','SPACETIME-WORMHOLE-ADMISSIBILITY', [('admissibleCheck','wormholeAdmissible (.fraction ⟨1,4,by decide,by decide⟩) true true'),('remoteCheck','!wormholeAdmissible (.fraction ⟨1,4,by decide,by decide⟩) false true')]),('warp',910,'WarpEntry','Warp','WARP_SPEC','SPACETIME-WARP-ADMISSIBILITY',[('admissibleCheck','warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩) true'),('ledgerCheck','!warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩) false'),('gainCheck','!warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩) true')]),('timelike',911,'TimelikeEntry','Timelike','CTC_SPEC','SPACETIME-CLOSED-TIMELIKE-ADMISSIBILITY',[('cycleCheck','closedTimelikeAdmissible ["state","proof"] ["state","proof"] true'),('paradoxCheck','!closedTimelikeAdmissible ["state","proof"] ["changed-state","proof"] true'),('traceCheck','!closedTimelikeAdmissible ["state","proof"] ["state","proof"] false')])]
for low,n,tag,program,spec,cid,checks in items:
 s=(w/'prepare_static901.py').read_text().replace('STATIC_CLOCK_SPEC',spec).replace('static901',low+str(n)).replace('static_witness901',low+'_witness'+str(n)).replace('StaticFoldClockEntry',tag).replace('StaticFoldClock','SpacetimeAdmissibility')
 a=s.index("s='''");b=s.index("''';",a)
 witness='import SFT.Physics.SpacetimeAdmissibility\nnamespace SFT.Physics.'+tag+'Witnesses\nopen SpacetimeAdmissibility\nstructure Witness where\n name : String\n statement : String\n passed : Bool\n'
 for name,term in checks:witness+='def '+name+' : Bool := '+term+'\n'
 witness+='def witnesses : List Witness := [WITNESS_ROWS]\n'
 for name,term in checks:witness+='theorem '+name+'Passed : '+name+'=true := rfl\n'
 witness+='theorem allWitnessesPass : witnesses.all Witness.passed=true := by\n change ('+' && '.join(name for name,term in checks)+' && true)=true\n rw ['+','.join(name+'Passed' for name,term in checks)+']\n rfl\nend SFT.Physics.'+tag+'Witnesses\n'
 s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['covarianceCheck','rateCheck','horizonCheck']",repr([name for name,term in checks]));(w/f'prepare_{low}{n}.py').write_text(s)
 for kind in ['entry','program','independent','original']:
  s=(w/f'check_static_{kind}901.py').read_text().replace('901',str(n)).replace('static',low).replace('StaticFoldClockEntry',tag).replace('StaticFoldClock','SpacetimeAdmissibility').replace('StaticProgram',program+'Program').replace('GRAVITY-STATIC-CLOCK',cid).replace('STATIC_CLOCK_SPEC',spec);(w/f'check_{low}_{kind}{n}.py').write_text(s)
 s=(w/'prepare_static_native901.py').read_text().replace('901',str(n)).replace('StaticFoldClockEntry',tag).replace('StaticProgram',program+'Program');(w/f'prepare_{low}_native{n}.py').write_text(s)
 (r/f'{program}Program{n}.lean').write_text((r/'StaticProgram901.lean').read_text().replace('StaticFoldClockEntry',tag))
import subprocess
for low,n,*_ in items:subprocess.run(['python3',str(w/f'prepare_{low}{n}.py')],check=True)

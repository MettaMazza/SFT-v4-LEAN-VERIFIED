from pathlib import Path
import json
w=Path('work');r=w/'turn1064_recovery';plan=json.loads((w/'nonordinary1394_plan.json').read_text())
for row in plan:
 name=row['name'];tag=name.lower()+'1395';row['tag']=tag
 s=(r/'RedControlsProgram1444.lean').read_text().replace('RedControls',name);(r/(name+'Program1395.lean')).write_text(s)
 s=(w/'prepare_redcontrols1444_programme_native1381.py').read_text().replace('RedControls',name).replace('1444','1395').replace('redcontrols1395',name.lower()+'1395')
 s=s.replace("out=w/'"+tag+"_programme_native1381'","out=w/'nonordinary1395_native'")
 s=s.replace("shared_receipt=w/'observation1374_native_build1328.json'","shared_receipt=w/'redcontrols1444_programme_native_build1381.json'")
 s=s.replace("obj=w/'observation1374_native'/(module+'.o')","obj=Path(row.get('reused_object',str(Path(row['generated_c']).with_suffix('.o'))))")
 s=s.replace("and 'SFT_Host_Text' in expected",'')
 native=w/('prepare_'+tag+'_programme.py');native.write_text(s);row['native_driver']=str(native)
(w/'nonordinary1395_checks_plan.json').write_text(json.dumps(plan,indent=2)+'\n')

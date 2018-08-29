
# az group deployment create --resource-group examplegroup --template-file nokiaSdwanPoc.json

# pscp -pw An51bl318! D:\NuageAzure\setup\nokiaSdwanPoc.json mcneila3@10.213.83.141:/home/mcneila3




#AzCopy /Source:C:\Users\803190045\Downloads\5.1.2-azure3.vhd /Dest:https://sdwansa.blob.core.windows.net/sdwanvnfimages/5.1.2-azure3.vhd /DestKey:UMSdTHPX+aQA8y7hj9itw89m4fpl8pHdeI2e2QLUKwgIgvzBaQgJKhp4lDsvjJlxdd7Vj0yw8sADYdG+A0A/Ag==

AzCopy /Source:"https://nuagensg.blob.core.windows.net/123/5.1.2-azure1.vhd?sp=r&st=2018-05-30T21:50:09Z&se=2018-08-01T05:50:09Z&spr=https&sv=2017-11-09&sig=6wLkdMHvSoni35vo8klri9Gz4dXF%%2ByF8OVR%%2BdhPWYTQ%%3D&sr=b" /Dest:https://sdwansa.blob.core.windows.net/sdwanvnfimages/5.1.2-azure4.vhd /DestKey:UMSdTHPX+aQA8y7hj9itw89m4fpl8pHdeI2e2QLUKwgIgvzBaQgJKhp4lDsvjJlxdd7Vj0yw8sADYdG+A0A/Ag==


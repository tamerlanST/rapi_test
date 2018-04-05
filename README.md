# rAPItest
# Run rapi_test.sh to test all cases.

To deploy test task - create config.sh in rapi root path. With this content:

#!/bin/bash
#config for local testing on vps923

# remote api endpoint
server='http://cms.vps923.dnt-msq.gurtam.net/wialon/ajax.html'

# cms dns, to use avl_evts
site='http://cms.vps923.dnt-msq.gurtam.net'

# you must create token with params: {"callMode":"create","app":"wialon","at":0,"dur":0,"fl":-1,"p":"{}","items":[]}, use sid from login with auth_hach to cms site (manually).
token='5be69c16554f172696b26265cef0a557CC59FCD17D40812CFF8F56364EDEDF774381FF8B'

# you must create this items manually, and write here.
itemId=13 #resource id
uitemId=12 #user_id
unitId=238 #test unit with "Atrack" hw type
billingPlan=rapimsk #name of billing plan
child_accId=184

or mv config from config directory & rename to config.sh
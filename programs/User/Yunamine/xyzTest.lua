require "xyzAPI"

xyz=XyzApi.new()

xyz.moveTo(10,10,10)
sleep(10)
xyz.moveToRelative(-5,-5,-5)
sleep(10)
xyz.moveToRelative(-6,-6,-6)
sleep(10)
xyz.moveTo(-5,-5,-5)
sleep(10)
xyz.moveTo(0,0,0)


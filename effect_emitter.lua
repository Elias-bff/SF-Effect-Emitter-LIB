--@name Effect Emitter
--@author Elias
--@client

    --"utaunt_twinkling_goldsilver_parent"
    --"utaunt_electric_mist_parent"
    --"utaunt_auroraglow_purple_parent"

    --requiring content not added yet

    setupPermissionRequest({"effect.play"}, "Allows effects to be played.", true)
    
    fx=class("fx")
    effects={}
    
    function fx:initialize(path,parent,time,require)
        self.parent=parent
        self.path=path
        
        if type(parent)=="Vector" and hologram.hologramsLeft()>0 then
            self.parent=hologram.create(parent,Angle(),"models/sprops/misc/axis_plane.mdl",Vector(0))
            self.holo=true
        end
        
        if hasPermission("effect.play") and isValid(self.parent) and particle.particleEmittersLeft()>0 then
            try(function()
                self.effectfx=particleEffect.attach(self.parent,path,PATTACH.ABSORIGIN_FOLLOW,{})
                self.effectfx:startEmission() 
                effects[table.address(self)]=self.effectfx
                
                if time then
                    timer.simple(time,function()
                        self.effectfx:destroy()
                        
                        if self.holo then
                            self.parent:remove()
                        end
                    end)
                end
                
                hook.add("think","particle_"..table.address(self),function()
                    if !isValid(self.parent) then
                        self.effectfx:destroy()
                        
                        hook.remove("think","particle_"..table.address(self))
                    end
                end)
            end)
        end
        
        return self
    end
    
    function fx:setParent(parent)
        self.parent:setParent(parent)
    end
    
    hook.add("permissionrequest","",function()
        for i,_ in pairs(effects) do
            print(i)
            
            if effects[i]:isValid() then
                effects[i]:restart()
            end
        end
    end)
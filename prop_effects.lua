--@name Prop effects
--@author Elias
--@include lib/effect_emitter.lua
--@client

require("lib/effect_emitter.lua")

hook.add("OnEntityCreated","",function(ent)
    local Class=ent:getClass()
    try(function()
        if ent:getOwner()==owner() or (ent:getOwner()==nil and (Class=="starfall_processor" or Class=="prop_physics")) then
            fx:new("utaunt_auroraglow_purple_parent",ent)
        end
    end)
end)
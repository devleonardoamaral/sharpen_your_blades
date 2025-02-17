function Recipe.OnGiveXP.SharpenBlade(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Maintenance, SandboxVars.SharpenYourBlades.shappenBladeRecipeXP)
end

function Recipe.GetItemTypes.SharpenBlade(scriptItems)
    local sM = getScriptManager()
    local items = sM:getAllItems()

    for i = 0, items:size() - 1 do
        local item = items:get(i)

        if tostring(item:getType()) == "Weapon" then
            local categories = item:getCategories()

            if categories:contains("LongBlade") or categories:contains("Axe") or categories:contains("SmallBlade") then
                scriptItems:add(item)
            end
        end
    end
end

function Recipe.OnCreate.OnSharpenBlade(items, result, player)
    local item = items:get(0)
    local maxCondition = item:getConditionMax()
    local currentCondition = item:getCondition()

    local level = player:getPerkLevel(Perks.Maintenance)
    local chance = SandboxVars.SharpenYourBlades.minChanceToNotBreak + (SandboxVars.SharpenYourBlades.maxChanceToNotBreak / 10) * level
    local rand = ZombRand(100) + 1

    if rand > chance then
        item:setCondition(0)
        item:setBroken(true)
    elseif currentCondition < maxCondition then
        item:setCondition(currentCondition + 1)
    end
end

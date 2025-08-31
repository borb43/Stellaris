---@diagnostic disable: duplicate-set-field
STLR.get_return = function(type, ret, fallback) --Used to check for specific return values in context.post_trigger. type is the type of effect, ret is the return table to check. returns fallback if value is not found
    for _, key in ipairs(STLR.valid_returns[type]) do
        if ret[key] then
            return ret[key]
        end
    end
    return fallback
end

STLR.get_return_name = function(type, ret) --used to get the name of the return used in other_ret for SMODS.scale_card
    for _, key in ipairs(STLR.valid_returns[type]) do
        if ret[key] then
            return key
        end
    end
end

STLR.balance_vars = function(var1, var2) --balances two variables
    newvar1 = (var1 + var2) / 2
    newvar2 = (var1 + var2) / 2
    return newvar1, newvar2
end

STLR.swap_vars = function(var1, var2) --swaps two variables by returning var2, var1
    return var2, var1
end

STLR.card_sticker_count = function(card) --counts the number of stickers on a card
    local amt = 0
    for sticker, _ in pairs(SMODS.Sticker.obj_table) do
        if card.ability and card.ability[sticker] then
            amt = amt + 1
        end
    end
    return amt
end

STLR.blind_is_special_akyrs = function(blind) --for finding akyrs special blind types
    if blind.debuff.akyrs_is_forgotten_blind or blind.debuff.akyrs_blind_difficulty == "expert" or blind.debuff.akyrs_blind_difficulty == "master" then
        return true
    end
end

local blind_disable_ref = Blind.disable
function Blind:disable()
    if not (self.debuff and self.debuff.stlr_no_disable) then
        blind_disable_ref(self)
    end
end
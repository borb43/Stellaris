STLR.get_return = function(type, ret) --Used to check for specific return values in context.post_trigger. type is the type of effect, ret is the return table to check
    for _, key in ipairs(STLR.valid_returns[type]) do
        if ret[key] then
            return ret[key]
        end
    end
end

STLR.get_return_name = function(type, ret) --used to get the name of the return used in other_ret for SMODS.scale_card
    for _, key in ipairs(STLR.valid_returns[type]) do
        if ret[key] then
            return key
        end
    end
end

STLR.balance_vars = function(var1, var2) --balances two variables
    newvar1 = (var1+var2)/2
    newvar2 = (var1+var2)/2
    return newvar1, newvar2
end

STLR.swap_vars = function(var1, var2) --swaps two variables by returning var2, var1
    return var2, var1
end

lvl_up_handref = level_up_hand
level_up_hand = function(card, hand, instant, amount)
    local flags = SMODS.calculate_context({
        stlr_source_card = card,
        stlr_level_up = true,
        stlr_level_count = amount
    }) or {}
    if flags.extra_levels then
        amount = amount + flags.extra_levels
    end
    return lvl_up_handref(card, hand, instant, amount)
end
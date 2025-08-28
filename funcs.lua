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
    newvar1 = (var1 + var2) / 2
    newvar2 = (var1 + var2) / 2
    return newvar1, newvar2
end

STLR.swap_vars = function(var1, var2) --swaps two variables by returning var2, var1
    return var2, var1
end

--[[ commented out since its not used yet and can definitely be simplified
--do not EVER call level_up_hand or custom_hand_upgrade during one of their respective contexts. the game WILL crash or result in an infinite loop
STLR.custom_hand_upgrade = function(card, hand, instant, chips, mult, level, operator, forwarded, identifier)
    level = level or 0
    chips = chips or G.GAME.hands[hand].l_chips * level
    mult = mult or G.GAME.hands[hand].l_mult * level
    local flags = SMODS.calculate_context({
        stlr_modding_hand = true,
        chips_mod = chips,
        mult_mod = mult,
        level_mod = level,
        mod_operator = operator,
        source_card = card,
        forwarded = forwarded,
        forward_indentifier = identifier
    }) or {}
    if flags.chip_override then chips = flags.chip_override end
    if flags.mult_override then mult = flags.mult_override end
    if flags.level_override then level = flags.level_override end
    if flags.operator_override then operator = flags.operator_override end
    if flags.hand_override then hand = flags.hand_override end
    
    if not operator or operator == "+" then
        G.GAME.hands[hand].chips = G.GAME.hands[hand].chips + (chips or G.GAME.hands[hand].l_chips * level)
        G.GAME.hands[hand].mult = G.GAME.hands[hand].mult + (mult or G.GAME.hands[hand].l_chips * level)
        G.GAME.hands[hand].level = G.GAME.hands[hand].level + (level or 0)
    elseif operator == "*" then
        G.GAME.hands[hand].chips = G.GAME.hands[hand].chips * (chips or 1)
        G.GAME.hands[hand].mult = G.GAME.hands[hand].mult * (mult or 1)
        G.GAME.hands[hand].level = G.GAME.hands[hand].level + (level or 0)
    elseif type(operator) == "function" then
        G.GAME.hands[hand].chips = operator(G.GAME.hands[hand].chips, chips)
        G.GAME.hands[hand].mult = operator(G.GAME.hands[hand].mult, mult)
        G.GAME.hands[hand].level = G.GAME.hands[hand].level + (level or 0)
    end
    if not instant then --animation stolen from vanilla code, will probably look wierd on non + operators
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                if card then card:juice_up(0.8, 0.5) end
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = G.GAME.hands[hand].mult, StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                if card then card:juice_up(0.8, 0.5) end
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = G.GAME.hands[hand].chips, StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                if card then card:juice_up(0.8, 0.5) end
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = G.GAME.hands[hand].level })
        delay(1.3)
    end
    if level ~= 0 then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = (function()
                check_for_unlock { type = 'upgrade_hand', hand = hand, level = G.GAME.hands[hand].level }
                return true
            end)
        }))
    end
    SMODS.calculate_context({
        post_hand_mod = true,
        chips_mod = chips,
        mult_mod = mult,
        mod_operator = operator,
        level_mod = level,
        source_card = card,
        forwarded = forwarded,
        forward_identifier = identifier
    })
end

lvl_up_handref = level_up_hand
level_up_hand = function(card, hand, instant, amount)
    local ret
    local flags = SMODS.calculate_context({
        source_card = card,
        level_mod = amount,
        hand_type = hand,
        vanilla_level_up = true
    }) or {}
    if flags.level_override then amount = flags.level_override end
    if flags.hand_override then hand = flags.hand_override end
    if flags.to_mod then
        return STLR.custom_hand_upgrade(card, hand, instant, nil, nil, amount, nil, true, flags.identifier)
    else
        ret = lvl_up_handref(card, hand, instant, amount)
    end
    SMODS.calculate_context({
        post_level_up = true,
        source_card = card,
        level_mod = amount,
        hand_type = hand
    })
    return ret
end
]]
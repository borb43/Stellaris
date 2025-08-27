SMODS.Joker { --paint smear, gains x0.1 mult when a wild card is scored
    key = "paintsmear",
    config = { extra = { mult = 1, multgain = 0.1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { card.ability.extra.mult, card.ability.extra.multgain } }
    end,
    discovered = true,
    rarity = 2,
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    blueprint_compat = true,
    perishable_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint
            and SMODS.has_enhancement(context.other_card, "m_wild") then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "multgain"
            })
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.mult
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_wild') then
                return true
            end
        end
        return false
    end
}

SMODS.Joker { --pluripotent larva, prevents death but fills consumables with eternal spectrals
    key = "plarva",
    discovered = true,
    rarity = 2,
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    blueprint_compat = false,
    eternal_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
            local activate
            if not to_big(#G.consumeables.cards + G.GAME.consumeable_buffer) < to_big(G.consumeables.config.card_limit) then
                for _, v in ipairs(G.consumeables.cards) do
                    if not SMODS.is_eternal(v, card) then
                        local activate = true
                        break
                    end
                end
            else
                local activate = true
            end
            if activate then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _first_dissolve = nil
                        for _, consumable in ipairs(G.consumeables.cards) do
                            if not SMODS.is_eternal(consumable, card) then
                                consumable:start_dissolve(nil, _first_dissolve)
                                _first_dissolve = true
                            end
                        end
                    end
                }))
                for _ = 1, G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer) do
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = "Spectral",
                                key_append = "stlr_plarva",
                                stickers = { "eternal" },
                            }
                        end
                    }))
                    G.GAME.consumeable_buffer = 0
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound("tarot1")
                        card:start_dissolve(G.C.PURPLE)
                    end
                }))
                return {
                    message = localize("k_evil_saved_ex"),
                    saved = "ph_stlr_plarva",
                    colour = G.C.STLR_DEEP_PURPLE
                }
            end
        end
    end
}

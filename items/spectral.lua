SMODS.Consumable {
    key = "shatter",
    set = "Spectral",
    config = { extra = { destroy = 1, create = 5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return { vars = { card.ability.extra.destroy, card.ability.extra.create } }
    end,
    discovered = true,
    atlas = "placeholder",
    pos = { x = 2, y = 2 },
    cost = 4,
    use = function(self, card, area, copier)
        local card_to_destroy = pseudorandom_element(G.hand.cards, "random_destroy" )
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3,0.5)
                return true
            end
        }))
        SMODS.destroy_cards(card_to_destroy)

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra.create do
                    cards[i] = SMODS.add_card { set = "Base", enhancement = "m_stone", edition = poll_edition(edition_generic, nil , true, true)}
                end
                SMODS.calculate_context({ playing_card_added = true, cards = cards })
                return true
            end
        }))
        delay(0.3)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 1
    end
}

SMODS.Consumable {
    key = "shroud",
    set = "Spectral",
    config = { extra = { seal = "pink" }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}
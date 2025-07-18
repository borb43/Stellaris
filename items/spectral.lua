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
                for i = 1, card.ability.extra.cards do
                    cards[i] = SMODS.add_card { set = "Base", enhancement = "m_stone", edition = poll_edition({ guaranteed = true })}
                end
                SMODS.calculate_context({ playing_card_added = true, cards = cards })
                return true
            end
        }))
        delay(0.3)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 1
    end,
    draw = function(self, card, layer)
        if ( layer == "card" or layer == "both" ) and card.sprite_facing == "front" then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
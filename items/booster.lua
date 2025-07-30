---@diagnostic disable: need-check-nil
SMODS.Booster {
    key = "wonder_normal_1",
    weight = 0.3,
    kind = "stlr_wonder",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 0, y = 3 },
    config = { extra = 2, choose = 1 },
    draw_hand = true,
    group_key = "k_stlr_wonderpack",
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3),
        }
    end,
    discovered = true,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.wonder)
        ease_background_colour({ new_colour = G.C.SET.wonder, special_colour = G.C.WHITE, contrast = 2 })
    end,
    create_card = function(self, card)
        return {
            set = "wonder",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "stlr_wonderpack"
        }
    end
}

SMODS.Booster {
    key = "wonder_normal_2",
    weight = 0.3,
    kind = "stlr_wonder",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 0, y = 3 },
    config = { extra = 2, choose = 1 },
    draw_hand = true,
    group_key = "k_stlr_wonderpack",
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3),
        }
    end,
    discovered = true,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.wonder)
        ease_background_colour({ new_colour = G.C.SET.wonder, special_colour = G.C.WHITE, contrast = 2 })
    end,
    create_card = function(self, card)
        return {
            set = "wonder",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "stlr_wonderpack"
        }
    end
}

SMODS.Booster {
    key = "wonder_jumbo_1",
    weight = 0.3,
    kind = "stlr_wonder",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 1, y = 3 },
    config = { extra = 4, choose = 1 },
    draw_hand = true,
    group_key = "k_stlr_wonderpack",
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3),
        }
    end,
    discovered = true,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.wonder)
        ease_background_colour({ new_colour = G.C.SET.wonder, special_colour = G.C.WHITE, contrast = 2 })
    end,
    create_card = function(self, card)
        return {
            set = "wonder",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "stlr_wonderpack"
        }
    end
}

SMODS.Booster {
    key = "wonder_mega_1",
    weight = 0.07,
    kind = "stlr_wonder",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 2, y = 3 },
    config = { extra = 4, choose = 2 },
    draw_hand = true,
    group_key = "k_stlr_wonderpack",
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3),
        }
    end,
    discovered = true,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.wonder)
        ease_background_colour_blind({ new_colour = G.C.SET.wonder, special_colour = G.C.WHITE, contrast = 2 })
    end,
    create_card = function(self, card)
        return {
            set = "wonder",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "stlr_wonderpack"
        }
    end
}
-- this is just the en-us file, but i cant be assed to copy this every time i change it for a seperate en-us file 
return {
    descriptions = {
        Joker = {
            j_stlr_silly = {
                name = "Silly Joker",
                text = {
                    "{C:mult}+#1#{} Mult if played poker hand",
                    "contains a {C:attention}#2#{}"
                }
            },
            j_stlr_dubious = {
                name = "Dubious Joker",
                text = {
                    "{C:chips}+#1#{} Chips if played poker hand",
                    "contains a {C:attention}#2#{}"
                }
            },
            j_stlr_algebra = {
                name = "Algebra Albert",
                text = {
                    "Played {C:attention}Aces{} and {C:attention}Face{} cards give",
                    "{X:mult,C:white}X#1#{} Mult when scored"
                }
            },
            j_stlr_slappyhand = {
                name = "Slappy Hand",
                text = {
                    "{X:mult,C:white}X#2#{} Mult for every card in your hand",
                    "{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)"
                }
            },
            j_stlr_paintsmear = {
                name = "Paint Smear",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult when",
                    "each played {C:attention}Wild{} card is scored",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_stlr_rkey = {
                name = "R Key",
                text = {
                    "Sets ante to #1# when sold",
                    "{C:red}banishes self{}"
                }
            },
            j_stlr_scales = {
                name = "Tipped Scales",
                text = {
                    "Increases all {C:green}numerators{} and {C:green}denominators{}",
                    "of {C:attention}listed{} probabilities by {C:green}1{}",
                    "{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}#2# in #3#{C:inactive})"
                }
            },
            j_stlr_circus = {
                name = "S-001 CIRCUS",
                text = {
                    "{X:mult,C:white}X#1#{} Mult when another Joker is triggered"
                }
            },
            j_stlr_clover = {
                name = "57-Leaf Clover",
                text = {
                    "Adds {C:green}#1#{} to all {C:attention}listed {C:green}numerators{}.",
                    "Increases by {C:green}#2#{} when each played",
                    "{C:clubs}#3#{} card is scored",
                    "{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}#4# in 3{C:inactive})"
                }
            },
            j_stlr_hypercoin = {
                name = "Hypercoin",
                text = {
                    "Sets all {C:attention}listed {C:green}probabilities{}",
                    "to {C:green}1 in 3{}"
                }
            }
        },
        Spectral = {
            c_stlr_shatter = {
                name = "Shatter",
                text = {
                    "Destroys {C:attention}#1#{} random card in your hand,",
                    "add {C:attention}#2#{} random {C:dark_edition}Editioned{} {C:attention}Stone{} cards to your hand"
                }
            },
            c_stlr_stellarstar = {
                name = "Stellaris",
                text = {
                    "Creates a random {C:stlr_stellar,E:1}Stellar {C:attention}Joker{}",
                    "destroys all other {C:attention}Jokers"
                }
            },
            c_stlr_shroud = {
                name = "Shroud",
                text = {
                    "Add a {C:pink}Pink Seal{}",
                    "to {C:attention}#1#{} selected",
                    "card in your hand"
                }
            }
        },
        wonder = {
            c_stlr_dreamwheel = {
                name = "Wheel of Dreams",
                text = {
                    "Applies a random {C:dark_edition}edition{}",
                    "to a random Joker"
                }
            },
            c_stlr_sage = {
                name = "Sage",
                text = {
                    "Creates a random {C:dark_edition}editioned{}",
                    "{C:uncommon}Uncommon{C:attention} Joker"
                }
            }
        },
        Other = {
            stlr_credits = {
                name = "Credits",
                text = {
                    "Idea by {C:attention}#1#{} on {C:attention}#2#{}",
                    "Art by {C:attention}#3#{} on {C:attention}#4#{}",
                    "Code by {C:attention}#5#{} on {C:attention}#6#{}"
                }
            },
            undiscovered_stlr_wonder = {
                name = "Not Discovered",
                text = {
                    "Purchase or use",
                    "this card in an",
                    "unseeded run to",
                    "learn what it does",
                }
            },
            p_stlr_wonder_normal = {
                name = "Wonder Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:wonder} Wonder{} cards to",
                    "be used immediately",
                }
            },
            p_stlr_wonder_jumbo = {
                name = "Jumbo Wonder Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:wonder} Wonder{} cards to",
                    "be used immediately"
                }
            },
            p_stlr_wonder_mega = {
                name = "Mega Wonder Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:wonder} Wonder{} cards to",
                    "be used immediately"
                }
            },
            stlr_pink_seal = {
                name = "Pink Seal",
                text = {
                    "Creates a {C:wonder}Wonder{} card",
                    "when scored on the",
                    "first hand of round",
                    "{C:inactive}(Must have room){}"
                }
            }
        },
    },
    misc = {
        dictionary = {
            k_stlr_stellar = "Stellar",
            k_stlr_resetante = "Ante 1",
            b_wonder_cards = "Wonder Cards",
            k_wonder = "Wonder",
            k_stlr_wonderpack = "Wonder Pack",
            k_plus_wonder = "+1 Wonder",
        },
        labels = {
            stlr_stellar = "Stellar",
            wonder = "Wonder",
            stlr_pink_seal = "Pink Seal"
        },
    }
}
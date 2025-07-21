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
            }
        },
        Spectral = {
            c_stlr_shatter = {
                name = "Shatter",
                text = {
                    "Destroys {C:attention}#1#{} random card in your hand,",
                    "add {C:attention}#2#{} random {C:dark_edition}Editioned{} {C:attention}Stone{} cards to your hand"
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
            }
        },
    },
    misc = {
        dictionary = {
            k_stlr_stellar = "Stellar",
            k_stlr_resetante = "Ante 1",
            b_stlr_wonder_cards = "Wonder Cards",
            k_stlr_wonder = "Wonder"
        },
        labels = {
            stlr_stellar = "Stellar",
            stlr_wonder = "Wonder",
        },
    }
}
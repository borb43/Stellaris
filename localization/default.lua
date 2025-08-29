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
            j_stlr_beanstalk = {
                name = "Beanstalk",
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
                    "to {C:green}#1# in #2#{}"
                }
            },
            j_stlr_plarva = {
                name = "Pluripotent Larva",
                text = {
                    "Prevents Death",
                    "Fills all consumable slots",
                    "with {C:stlr_eternal}eternal {C:spectral}spectral{} cards,",
                    "destroys all other consumables",
                    "{C:red,E:2}self destructs{}",
                    "{C:inactive}(Must have room)"
                }
            },
            j_stlr_singularity = {
                name = "Singularity",
                text = {
                    "When another eligible joker is triggered",
                    "destroys it and absorbs its effects",
                    "Currently:",
                    "{C:blue}+#1#{} Chips, {C:red}+#2#{} Mult",
                    "{X:chips,C:white}X#3#{} Chips, {X:mult,C:white}X#4#{} Mult",
                    "Earn {C:money}$#5#{} at the end of round"
                }
            },
            j_stlr_spaghetti = {
                name = "Spaghetti Code",
                text = {
                    "{C:blue}+#2#{} Chips for every line in",
                    "Singularitys calculate function",
                    "Reduces by {C:blue}#3#{} at the end of round",
                    "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)"
                }
            },
            j_stlr_multiplicare = {
                name = "Multiplicare",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult when",
                    "another joker gives {C:red}+Mult{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{} Mult)"
                }
            },
            j_stlr_shopping = {
                name = "Shopping Cart",
                text = {
                    "This joker gains {X:mult,C:white}X#2#{} Mult when a joker is bought",
                    "This joker loses {X:mult,C:white}X#2#{} Mult when a joker is sold",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_stlr_hardboil = {
                name = "Hard Boiled",
                text = {
                    "When you earn any money",
                    "earn {C:money}$#1# extra"
                }
            },
            j_stlr_temple = {
                name = "Temple",
                text = {
                    "Each played card with {V:1}#3#{} suit",
                    "permanently gains {B:2,V:3}#4##1#{} #2#",
                    "when scored",
                    "{s:0.8}suit and effect",
                    "{s:0.8}change each round"
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
            c_stlr_twist = {
                name = "Twist",
                text = {
                    "Add a {C:green}Dice Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand"
                }
            },
            c_stlr_cosmos = {
                name = "Cosmos",
                text = {
                    "Creates a",
                    "{C:stlr_stellar,E:1}Stellar{} Joker",
                    "{C:inactive}(Must have room)"
                }
            }
        },
        Other = {
            stlr_dice_seal = {
                name = "Dice Seal",
                text = {
                    "{C:green}Listed probabilities{} are",
                    "{C:green}#1#{} times as likely to",
                    "activate from this card"
                }
            },
        }
    },
    misc = {
        dictionary = {
            k_stlr_resetante = "Ante 1",
            k_evil_saved_ex = "Saved?",
            ph_stlr_plarva = "Saved by Pluripotent Larva",
            k_stlr_stellar = "Stellar"
        },
        labels = {
            k_stlr_stellar = "Stellar",
            stlr_dice_seal = "Dice Seal"
        }
    }
}
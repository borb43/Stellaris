loc_colour() --required for adding colours

--for talisman compat
to_big = to_big or function(x) return x end

--make banning modifiers work with custom pools
old_enhancement_roll = SMODS.poll_enhancement
function SMODS.poll_enhancement(args)
    if args.ignore_bans or args.options == nil then
        return old_enhancement_roll(args)
    else
        to_ban = {}
        for k, v in pairs(args.options) do
            if G.GAME.banned_keys[k] or G.GAME.banned_keys[v] then
                to_ban[#to_ban+1] = k
            elseif type(v) == "table" then
                if G.GAME.banned_keys[v.key] then
                    to_ban[#to_ban+1] = k
                end
            end
        end
        for _, v in ipairs(to_ban) do
            args.options[v] = nil
        end
        if #args.options == 0 or args.options == nil then
            return nil
        else
            return old_enhancement_roll(args)
        end
    end
end

--for the HEX function, first 6 characters are RGB values, can add 2 more at the end for opacity
--define and load custom text colours, then add into loc_colours
G.C.PINK = HEX("eb90e8")
G.ARGS.LOC_COLOURS["pink"] = G.C.PINK --for pink seals
G.C.CRIMSON = HEX("a52a2a")
G.ARGS.LOC_COLOURS["crimson"] = G.C.CRIMSON --for blind modifying stuff

--load optional features (none yet)

--loading stuff
assert(SMODS.load_file("atlas.lua"))() --loads atlases
assert(SMODS.load_file("fileloader.lua"))() --loads mod content files
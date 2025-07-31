---@diagnostic disable: duplicate-set-field
loc_colour() --required for adding colours

--for talisman compat
to_big = to_big or function(x) return x end

--make banning modifiers work with custom pools
old_enhancement_roll = SMODS.poll_enhancement
function SMODS.poll_enhancement(args)
    if args.ignore_bans then
        if not args.options then --allows ignoring bans with default pool
            args.options = {}
            for _, v in ipairs(G.P_CENTER_POOLS.Enhanced) do
                if v.in_pool and type(v.in_pool) == "function" then
                    if v:in_pool() then
                        args.options[#args.options+1] = v
                    end
                end
            end
            return old_enhancement_roll(args)
        else
            return old_enhancement_roll(args)
        end
    elseif args.options then --check if options was filled in, if so trim it to remove banned keys
        to_ban = {}
        for k, v in pairs(args.options) do
            if G.GAME.banned_keys[k] or G.GAME.banned_keys[v] then
                to_ban[#to_ban + 1] = k
            elseif type(v) == "table" then
                if G.GAME.banned_keys[v.key] then
                    to_ban[#to_ban + 1] = k
                end
            end
        end
        for _, v in ipairs(to_ban) do
            args.options[v] = nil
        end
        if #args.options == 0 then
            return nil
        else
            return old_enhancement_roll(args)
        end
    else --return default function if ignore_bans was false or nil and options wasnt filled in
        return old_enhancement_roll(args)
    end
end

--for the HEX function, first 6 characters are RGB values, can add 2 more at the end for opacity
--define and load custom text colours, then add into loc_colours
G.C.PINK = HEX("eb90e8")
G.ARGS.LOC_COLOURS["pink"] = G.C.PINK       --for pink seals

--load optional features (none yet)

--loading stuff
assert(SMODS.load_file("atlas.lua"))()      --loads atlases
assert(SMODS.load_file("fileloader.lua"))() --loads mod content files

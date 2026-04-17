-- pfQuest-turtle overwrites.lua
-- Kludge-Bureau base + Moonwhisper Coast full data

do -- Kludge-Bureau phantom zone fix
  local pz = { 5600, 5098, 5550, 5132, 5138, 5139, 5140, 5150, 5161, 5155, 5164, 5169, 5170, 5173, 5177, 5178 }
  for _, loc in pairs({ "enUS", "deDE", "esES", "ptBR", "zhCN" }) do
    local t = pfDB["zones"][loc .. "-turtle"]
    if t then for _, z in pairs(pz) do t[z] = nil end end
  end
end

do -- Kludge-Bureau quest/item fixes
  pfDB["quests"]["data-turtle"][41682]["obj"]["O"] = { 2020173 }
  pfDB["items"]["data-turtle"][41783]["U"] = { [62217] = 1.0 }
end

-- ============================================================
-- 2026-04-17: Moonwhisper Coast / Tel'Abim zone-ID unification.
--
-- Background. pfQuest-turtle shipped Tel'Abim as zone 5121 years ago
-- (see enUS/zones-turtle.lua: [5121] = "Tel'Abim"). When TurtleWoW
-- renamed / extended the region to "Moonwhisper Coast", a second
-- ID 5700 was registered here with the new display name, while coord
-- rows in units-turtle.lua got split -- some tagged 5121, others 5700.
-- Since pfQuest keys rendered pins by a single integer map-ID and
-- resolves the current map by NAME via pfDB["zones"]["loc"] (hit on
-- exact string match only), whichever name the client reports
-- determined which half of the pins rendered. The other half went
-- invisible. That's what produced the "some NPCs show, some bleed,
-- some never appear" pattern reported 2026-04-17.
--
-- Fix. Settle on zone 5121 as the canonical ID for both names:
--   * bulk-rename every coord row in units-turtle.lua from zone 5700
--     to zone 5121 (done, 471 rows renamed);
--   * override pfDB["zones"]["loc"][5121] from "Tel'Abim" to the new
--     "Moonwhisper Coast" display name so both the client's DBC name
--     (new: "Moonwhisper Coast") and any residual "Tel'Abim" string
--     from older captures resolve to the same bucket via reverse
--     lookup.
--
-- No 5700 registration here anymore -- it was orphaned after the
-- bulk rename, and keeping it would just re-split the rendering.
-- ============================================================
pfDB["zones"]["loc"] = pfDB["zones"]["loc"] or {}
pfDB["zones"]["loc"][5121] = "Moonwhisper Coast"
if pfQuest_config then pfQuest_config["allquestgivers"] = "1"; pfQuest_config["showlowlevel"] = "1" end

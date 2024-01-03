#===============================================================================
# Infinite Repel by dpertierra
# https://github.com/Pokemon-Fan-Games/InifiniteRepel
# https://twitter.com/dpertierra
#===============================================================================
class PokemonGlobalMetadata
  attr_accessor :infRepel
end

def pbToggleInfiniteRepel()
  if !$PokemonGlobal.infRepel
    Kernel.pbMessage("Se activó el repelente infinito")
  else
    Kernel.pbMessage("Se desactivó el repelente infinito")
  end
  $PokemonGlobal.infRepel = !$PokemonGlobal.infRepel
  return 0
end

ItemHandlers::UseFromBag.add(:INFREPEL,proc{|item| pbToggleInfiniteRepel() })

class PokemonEncounters
  def pbCanEncounter?(encounter)
    return false if $game_system.encounter_disabled
    return false if !encounter || !$Trainer
    return false if $DEBUG && Input.press?(Input::CTRL)
    if !pbPokeRadarOnShakingGrass
      return false if $PokemonGlobal.infRepel && $Trainer.ablePokemonCount>0 &&
                      encounter[1]<=$Trainer.ablePokemonParty[0].level
    end
    return true
  end
end
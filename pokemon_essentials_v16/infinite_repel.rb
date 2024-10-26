#===============================================================================
# Infinite Repel by dpertierra
# https://github.com/Pokemon-Fan-Games/InifiniteRepel
# https://twitter.com/dpertierra
#===============================================================================
class PokemonGlobalMetadata
  attr_accessor :infRepel
  attr_accessor :repel

  alias initialize_inf_repel initialize
  def initialize
    initialize_inf_repel
    @infRepel = false
  end
end

def pbToggleInfiniteRepel()
  $PokemonGlobal.infRepel = false if $PokemonGlobal.infRepel.nil?
  if !$PokemonGlobal.infRepel
    Kernel.pbMessage("Se activó el repelente infinito")
    $PokemonBag.pbChangeItem(PBItems::INFREPELOFF, PBItems::INFREPEL)
  else
    Kernel.pbMessage("Se desactivó el repelente infinito")
    $PokemonBag.pbChangeItem(PBItems::INFREPEL, PBItems::INFREPELOFF)
  end
  $PokemonGlobal.infRepel = !$PokemonGlobal.infRepel
  return 0
end

ItemHandlers::UseFromBag.add(:INFREPEL,proc{|item| pbToggleInfiniteRepel() })
ItemHandlers::UseFromBag.copy(:INFREPEL, :INFREPELOFF)

class PokemonEncounters
  def pbCanEncounter?(encounter)
    return false if $game_system.encounter_disabled
    return false if !encounter || !$Trainer
    return false if $DEBUG && Input.press?(Input::CTRL)
    if !pbPokeRadarOnShakingGrass
      return false if ( $PokemonGlobal.infRepel || $PokemonGlobal.repel>0 ) && $Trainer.ablePokemonCount>0 &&
                      encounter[1]<=$Trainer.ablePokemonParty[0].level
    end
    return true
  end
end
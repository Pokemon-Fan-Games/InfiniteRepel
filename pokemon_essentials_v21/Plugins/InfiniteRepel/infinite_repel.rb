#===============================================================================
# Infinite Repel by dpertierra
# https://github.com/Pokemon-Fan-Games/InifiniteRepel
# https://twitter.com/dpertierra
#===============================================================================

LANG = "es" # Change to "en" for English
ADD_REPEL_TOGGLE_TO_POKEGEAR = true # Set to false to disable the repel toggle in the Pokegear menu
if LANG == "es"
  INFREPEL_MESSAGE = _INTL("Se activó el repelente infinito.")
  INFREPEL_MESSAGE_OFF = _INTL("Se desactivó el repelente infinito.")
  INFREPEL_COMMAND_ON = _INTL("Activar")
  INFREPEL_COMMAND_OFF = _INTL("Desactivar")
  INFREPEL_POKEGEAR = _INTL("Repelente Infinito")
else
  INFREPEL_MESSAGE = _INTL("Infinite Repel on.")
  INFREPEL_MESSAGE_OFF = _INTL("Infinite Repel off.")
  INFREPEL_COMMAND_ON = _INTL("Enable")
  INFREPEL_COMMAND_OFF = _INTL("Disable")
  INFREPEL_POKEGEAR = _INTL("Infinite Repel")
end

class PokemonGlobalMetadata
  attr_accessor :infRepel
  attr_accessor :repel
end

def pbToggleInfiniteRepel()
  if !$PokemonGlobal.infRepel
    Kernel.pbMessage(INFREPEL_MESSAGE)
    $bag.replace_item(:INFREPELOFF, :INFREPEL)
  else
    Kernel.pbMessage(INFREPEL_MESSAGE_OFF)
    $bag.replace_item(:INFREPELOFF, :INFREPEL)
  end
  $PokemonGlobal.infRepel = !$PokemonGlobal.infRepel
  return 0
end

ItemHandlers::UseFromBag.add(:INFREPEL,proc{|item| pbToggleInfiniteRepel() })
ItemHandlers::UseText.add(:INFREPEL, proc { |item| next ($PokemonGlobal.infRepel) ? INFREPEL_COMMAND_ON : INFREPEL_COMMAND_OFF})

alias pbBattleOnStepTakenOverride pbBattleOnStepTaken 
def pbBattleOnStepTaken(repel_active)
  repel = ($PokemonGlobal.infRepel  || $PokemonGlobal.repel > 0 || repel_active)
  pbBattleOnStepTakenOverride(repel)
end

if ADD_REPEL_TOGGLE_TO_POKEGEAR
  # Contribution by enomic_atom
  MenuHandlers.add(:pokegear_menu, :infrepel, {
    "name"      =>  INFREPEL_POKEGEAR,
    "icon_name" => "infrepel",
    "order"     => 70,
    "effect"    => proc { |menu|
    pbFadeOutIn {
      pbToggleInfiniteRepel
    }
    }
  })
end

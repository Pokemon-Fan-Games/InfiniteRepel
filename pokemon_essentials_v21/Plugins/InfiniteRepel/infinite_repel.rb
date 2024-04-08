#===============================================================================
# Infinite Repel by dpertierra
# https://github.com/Pokemon-Fan-Games/InifiniteRepel
# https://twitter.com/dpertierra
#===============================================================================

LANG = "es" # Change to "en" for English

if LANG == "es"
  INFREPEL_MESSAGE = "Se activó el repelente infinito."
  INFREPEL_MESSAGE_OFF = "Se desactivó el repelente infinito."
  INFREPEL_COMMAND_ON = "Activar"
  INFREPEL_COMMAND_OFF = "Desactivar"
else
  INFREPEL_MESSAGE = "Infinite Repel on."
  INFREPEL_MESSAGE_OFF = "Infinite Repel off."
  INFREPEL_COMMAND_ON = "Enable"
  INFREPEL_COMMAND_OFF = "Disable"
end

class PokemonGlobalMetadata
  attr_accessor :infRepel
end

def pbToggleInfiniteRepel()
if !$PokemonGlobal.infRepel
  Kernel.pbMessage(INFREPEL_MESSAGE)
else
  Kernel.pbMessage(INFREPEL_MESSAGE_OFF)
end
$PokemonGlobal.infRepel = !$PokemonGlobal.infRepel
return 0
end

ItemHandlers::UseFromBag.add(:INFREPEL,proc{|item| pbToggleInfiniteRepel() })
ItemHandlers::UseText.add(:INFREPEL, proc { |item| next ($PokemonGlobal.infRepel) ? INFREPEL_COMMAND_ON : INFREPEL_COMMAND_OFF})

alias pbBattleOnStepTakenOverride pbBattleOnStepTaken 
def pbBattleOnStepTaken(repel_active)
  pbBattleOnStepTakenOverride($PokemonGlobal.infRepel)
end
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
  
  alias pbBattleOnStepTakenOverride pbBattleOnStepTaken 
  def pbBattleOnStepTaken(repel_active)
    pbBattleOnStepTakenOverride($PokemonGlobal.infRepel)
  end

class PokemonBagScreen
  def pbStartScreen
    @scene.pbStartScene(@bag)
    item = nil
    loop do
      item = @scene.pbChooseItem
      break if !item
      itm = GameData::Item.get(item)
      cmdRead     = -1
      cmdUse      = -1
      cmdRegister = -1
      cmdGive     = -1
      cmdToss     = -1
      cmdDebug    = -1
      commands = []
      # Genera Lista de comandos
      commands[cmdRead = commands.length] = _INTL("Leer") if itm.is_mail?
      if (ItemHandlers.hasOutHandler(item) || (itm.is_machine? && $player.party.length > 0)) && GameData::Item.get(item) != 'INFREPEL'
        if ItemHandlers.hasUseText(item)
          commands[cmdUse = commands.length]    = ItemHandlers.getUseText(item)
        else
          commands[cmdUse = commands.length]    = _INTL("Usar")
        end
      end

      commands[cmdUse=commands.length]=_INTL("Activar") if GameData::Item.get(item) == 'INFREPEL' && !$PokemonGlobal.infRepel
      commands[cmdUse=commands.length]=_INTL("Desactivar") if GameData::Item.get(item) == 'INFREPEL' && $PokemonGlobal.infRepel
      commands[cmdGive = commands.length]       = _INTL("Dar") if $player.pokemon_party.length > 0 && itm.can_hold?
      commands[cmdToss = commands.length]       = _INTL("Tirar") if !itm.is_important? || $DEBUG
      if @bag.registered?(item)
        commands[cmdRegister = commands.length] = _INTL("Deseleccionar")
      elsif pbCanRegisterItem?(item)
        commands[cmdRegister = commands.length] = _INTL("Registrar")
      end
      commands[cmdDebug = commands.length]      = _INTL("Debug") if $DEBUG
      commands[commands.length]                 = _INTL("Cancelar")
      # Show commands generated above
      itemname = itm.name
      command = @scene.pbShowCommands(_INTL("{1} fue seleccionado.", itemname), commands)
      if cmdRead >= 0 && command == cmdRead   # Leer carta
        pbFadeOutIn do
          pbDisplayMail(Mail.new(item, "", ""))
        end
      elsif cmdUse >= 0 && command == cmdUse   # Usar item
        ret = pbUseItem(@bag, item, @scene)
        # ret: 0=Item no fue usado; 1=Item usado; 2=Cerrar mochila para usar en area
        break if ret == 2   # finalizar pantalla de la mochila
        @scene.pbRefresh
        next
      elsif cmdGive >= 0 && command == cmdGive   # Dar item a Pokémon
        if $player.pokemon_count == 0
          @scene.pbDisplay(_INTL("No hay pokémon."))
        elsif itm.is_important?
          @scene.pbDisplay(_INTL("No se puede dar {1}.", itm.portion_name))
        else
          pbFadeOutIn do
            sscene = PokemonParty_Scene.new
            sscreen = PokemonPartyScreen.new(sscene, $player.party)
            sscreen.pbPokemonGiveScreen(item)
            @scene.pbRefresh
          end
        end
      elsif cmdToss >= 0 && command == cmdToss   # Tirar item
        qty = @bag.quantity(item)
        if qty > 1
          helptext = _INTL("¿Cuántos {1} deseas tirar?", itm.portion_name_plural)
          qty = @scene.pbChooseNumber(helptext, qty)
        end
        if qty > 0
          itemname = (qty > 1) ? itm.portion_name_plural : itm.portion_name
          if pbConfirm(_INTL("¿Estas seguro de tirar {1} {2}?", qty, itemname))
            pbDisplay(_INTL("Tiraste {1} {2}.", qty, itemname))
            qty.times { @bag.remove(item) }
            @scene.pbRefresh
          end
        end
      elsif cmdRegister >= 0 && command == cmdRegister   # Registrar item
        if @bag.registered?(item)
          @bag.unregister(item)
        else
          @bag.register(item)
        end
        @scene.pbRefresh
      elsif cmdDebug >= 0 && command == cmdDebug   # Debug
        command = 0
        loop do
          command = @scene.pbShowCommands(_INTL("¿Qeé hacer con {1}?", itemname),
                                          [_INTL("Cambiar cantidad"),
                                           _INTL("Hacer regalo misterioso"),
                                           _INTL("Cancelar")], command)
          case command
          ### Cancelar ###
          when -1, 2
            break
          ### Cambiar cantidad ###
          when 0
            qty = @bag.quantity(item)
            itemplural = itm.name_plural
            params = ChooseNumberParams.new
            params.setRange(0, Settings::BAG_MAX_PER_SLOT)
            params.setDefaultValue(qty)
            newqty = pbMessageChooseNumber(
              _INTL("Elija la cantidad de {1} (máx. {2}).", itemplural, Settings::BAG_MAX_PER_SLOT), params
            ) { @scene.pbUpdate }
            if newqty > qty
              @bag.add(item, newqty - qty)
            elsif newqty < qty
              @bag.remove(item, qty - newqty)
            end
            @scene.pbRefresh
            break if newqty == 0
          ### Hacer regalo misterioso ###
          when 1
            pbCreateMysteryGift(1, item)
          end
        end
      end
    end
    ($game_temp.fly_destination) ? @scene.dispose : @scene.pbEndScene
    return item
  end
end
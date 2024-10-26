**¡Ahora puedes descargar los archivos de la última [versión](https://github.com/Pokemon-Fan-Games/InfiniteRepel/releases/latest)!**

Item clave inspirado en esta funcionalidad del Pokémon Radical Red. Al usarlo, se activará y el jugador no se encontrará con Pokémon salvajes hasta que lo vuelva a usar para desactivarlo.

# Implementacion

1. Crea estos 2 items en el PBS/items.txt con el siguiente formato:
   1. En la V16 `XXX,INFREPEL,Repelente Infinito,Repelente Infinito,8,0,"El Repelente infinito está activado",2,0,6`
   2. En la V16 `XXX,INFREPELOFF,Repelente Infinito,Repelente Infinito,8,0,"El Repelente infinito está desactivado",2,0,6`
   Reemplaza XXX por el siguiente número disponible en la lista de items.
   3. V21 Agrega el siguiente codigo al items.txt
      ```
      [INFREPEL]
      Name = Repelente Infinito
      NamePlural = Repelente Infinito
      Pocket = 8
      Price = 0
      FieldUse = Direct
      Flags = KeyItem
      Description = El Repelente infinito está activado.

      [INFREPELOFF]
      Name = Repelente Infinito
      NamePlural = Repelente Infinito
      Pocket = 8
      Price = 0
      FieldUse = Direct
      Flags = KeyItem
      Description = El Repelente infinito está desactivado.
      ```
2. Agregar los íconos para los item:
   1. En Essentials V16: Crea un icono para el item en Graphics/Icons con el nombre "iconxxx.png"para el repelente activo pueden usar ![este icono](assets/INREPEL.png) donde xxx es el número del item y luego el "iconxxx.png" del repelente desactivado pueden usar ![este icono](assets/INREPELOFF.png).
   2. En Essentials V19+: Crea un icono para el item en Graphics/Icons con el nombre "INFREPEL.png".
3. **OPCIONAL** Cambiar el texto al seleccionar el item de "Usar" a "Activar" cuando esta desactivado y "Desactivar" cuando este activado.
   1. _**En Essentials V16:**_
      1. En el script `PScreen_Bag` arriba de la declaracion de la clase `PokemonBagScreen` agregar este snippet para tener acceso al atributo infRepel del $PokemonGlobal:
      ```ruby
      class PokemonGlobalMetadata
         attr_accessor :infRepel
      end
      ```
      2. En el script `PScreen_Bag` en el método `pbStartScreen` buscar la linea donde se agrega el comando de usar deberia estar cerca de la linea 560, reemplazar esa linea por este snippet:
      ```ruby
      # Inf Repel DP
      # commands[cmdUse=commands.length]=_INTL("Usar") if ItemHandlers.hasOutHandler(item) || (pbIsMachine?(item) && $Trainer.party.length>0)
      commands[cmdUse=commands.length]=_INTL("Usar") if (ItemHandlers.hasOutHandler(item) || (pbIsMachine?(item) && $Trainer.party.length>0)) && item != PBItems::INFREPEL && item != PBItems::INFREPELOFF  
      commands[cmdUse=commands.length]=_INTL("Activar") if item == PBItems::INFREPELOFF && !$PokemonGlobal.infRepel
      commands[cmdUse=commands.length]=_INTL("Desactivar") if item == PBItems::INFREPEL && $PokemonGlobal.infRepel
      # Inf Repel DP
      ```

## Pasos para V16

1. Descarga el archivo `infinite_repel.rb` que está en el zip `infinite_repel_v16.zip` del [release](https://github.com/Pokemon-Fan-Games/InfiniteRepel/releases/latest) y crealo en los scripts de tu proyecto encima de Main.
2. Crear el objeto en el PBS como decia el paso 1


## Pasos para V21

1. Descarga la carpeta `Plugins` que está en el zip `infinite_repel_21.zip` [release](https://github.com/Pokemon-Fan-Games/InfiniteRepel/releases/latest) y pegala en la carpeta de tu proyecto. Windows unificará los archivos, pero no te preocupes, no hay conflicto entre ellos.
2. Crear el objeto en el PBS como decia el paso 1

**Note for english speakers:** The script has translations just set the lang variable in the script to "en"

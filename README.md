**¡Ahora puedes descargar los archivos de la última [versión](https://github.com/Pokemon-Fan-Games/InfiniteRepel/releases/latest)!**

Item clave inspirado en esta funcionalidad del Pokémon Radical Red. Al usarlo, se activará y el jugador no se encontrará con Pokémon salvajes hasta que lo vuelva a usar para desactivarlo.

# Implementacion

1. Crea el item en el PBS/items.txt con el siguiente formato:
   1. Hasta V20 `XXX,INFREPEL,Repelente Infinito,Repelente Infinito,8,0,"Repelente infinito activalo y desactivalo cuando quieras",2,0,6,,,false`
   Reemplaza XXX por el siguiente número disponible en la lista de items.
   2. V21 Agrega el siguiente codigo al items.txt
      ```
      [INFREPEL]
      Name = Repelente Infinito
      NamePlural = Repelente Infinito
      Pocket = 8
      Price = 0
      FieldUse = Direct
      Flags = KeyItem
      Description = Un repelente que nunca se gasta, solo activalo o desactivalo cuando lo necesites.
      ```
2. **OPCIONAL** agregar un ícono para el item:
   1. En Essentials V16 a V18: Crea un icono para el item en Graphics/Icons con el nombre "iconxxx.png" donde xxx es el número del item.
   2. En Essentials V19+: Crea un icono para el item en Graphics/Icons con el nombre "INFREPEL.png".
3. **OPCIONAL** Cambiar el texto al seleccionar el item de "Usar" a "Activar" cuando esta desactivado y "Desactivar" cuando este activado.
   1. _**En Essentials V16 y V17:**_
      1. En el script `PScreen_Bag` arriba de la declaracion de la clase `PokemonBagScreen` agregar este snippet para tener acceso al atributo infRepel del $PokemonGlobal:
      ```ruby
      class PokemonGlobalMetadata
         attr_accessor :infRepel
      end
      ```
      2. En el script `PScreen_Bag` en el método `pbStartScreen` buscar la linea donde se agrega el comando de usar deberia estar cerca de la linea 560, reemplazar esa linea por este snippet:
      ```ruby
      commands[cmdUse=commands.length]=_INTL("Usar") if ( ItemHandlers.hasOutHandler(item) || (pbIsMachine?(item) && $Trainer.party.length>0) ) && item != PBItems::INFREPEL
      commands[cmdUse=commands.length]=_INTL("Activar") if item == PBItems::INFREPEL && !$PokemonGlobal.infRepel
      commands[cmdUse=commands.length]=_INTL("Desactivar") if item == PBItems::INFREPEL && $PokemonGlobal.infRepel
      ```
   2. _**En Essentials V18:**_
      1. En el script `PScreen_Bag` arriba de la declaracion de la clase `PokemonBagScreen` agregar este snippet para tener acceso al atributo infRepel del $PokemonGlobal:
      ```ruby
      class PokemonGlobalMetadata
         attr_accessor :infRepel
      end
      ```
      2. En el script `PScreen_Bag` en el método `pbStartScreen` buscar el siguiente if `if ItemHandlers.hasOutHandler(item) || (pbIsMachine?(item) && $Trainer.party.length>0)` envolver esa condición entre parentesís y agregar la condición `&& item != PBItems::INFREPEL` al final de la condición, deberia quedar asi:
      ```ruby
      if ( ItemHandlers.hasOutHandler(item) || (pbIsMachine?(item) && $Trainer.party.length>0) ) && item != PBItems::INFREPEL  
      ```
      3. Luego debajo de todo ese bloque de if, agregar estas 2 lineas:
      ```ruby
      commands[cmdUse=commands.length]=_INTL("Activar") if item == PBItems::INFREPEL && !$PokemonGlobal.infRepel
      commands[cmdUse=commands.length]=_INTL("Desactivar") if item == PBItems::INFREPEL && $PokemonGlobal.infRepel
      ```
   3. _**En Essentials V19+:**_
      1. En el script `UI_Bag` arriba de la declaracion de la clase `PokemonBagScreen` agregar este snippet para tener acceso al atributo infRepel del $PokemonGlobal:
      ```ruby
      class PokemonGlobalMetadata
         attr_accessor :infRepel
      end
      ```
      2. En el script `UI_Bag` en el método `pbStartScreen` buscar el siguiente if `if ItemHandlers.hasOutHandler(item) || (itm.is_machine? && $Trainer.party.length>0)` envolver esa condición entre parentesís y agregar la condición `&& item != PBItems::INFREPEL` al final de la condición, deberia quedar asi:
      ```ruby
      if (ItemHandlers.hasOutHandler(item) || (itm.is_machine? && $Trainer.party.length>0)) && item != PBItems::INFREPEL
      ```
      3. Luego debajo de todo ese bloque de if, agregar estas 2 lineas:
      ```ruby
      commands[cmdUse=commands.length]=_INTL("Activar") if item == PBItems::INFREPEL && !$PokemonGlobal.infRepel
      commands[cmdUse=commands.length]=_INTL("Desactivar") if item == PBItems::INFREPEL && $PokemonGlobal.infRepel
      ```
   4. _**En Essentials V19+:**_
      1. Solo descarga del release el Plugin y copialo a la carpeta de Plugins de tu proyecto.

## Pasos para V16

Descarga el archivo `infinite_repel.rb` que está en el zip `infinite_repel_v16.zip` del [release](https://github.com/Pokemon-Fan-Games/InfiniteRepel/releases/latest) y crealo en los scripts de tu proyecto encima de Main.

## Pasos para V17

Descarga el archivo `infinite_repel.rb` que está en el zip `infinite_repel_v17.zip` del [release](https://github.com/Pokemon-Fan-Games/InfiniteRepel/releases/latest) y crealo en los scripts de tu proyecto encima de Main.

## Pasos para V18+

Descarga la carpeta `Plugins` que está en el zip `infinite_repel_v18_20.zip` [release](https://github.com/Pokemon-Fan-Games/InfiniteRepel/releases/latest) y pegala en la carpeta de tu proyecto. Windows unificará los archivos, pero no te preocupes, no hay conflicto entre ellos.

## Pasos para V21

Descarga la carpeta `Plugins` que está en el zip `infinite_repel_21.zip` [release](https://github.com/Pokemon-Fan-Games/InfiniteRepel/releases/latest) y pegala en la carpeta de tu proyecto. Windows unificará los archivos, pero no te preocupes, no hay conflicto entre ellos.

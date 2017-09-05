-- res vita 960 * 544

--TODO :
-- * afficher une liste, tableau scrollable des titres des jeux/app
--      * scroll avec fleche, joystick et touch screen
--      * moyen de trouver le dumper
-- * afficher quand un jeu est selectionné, les infos : title id, region, version
-- * ajouter un mecanisme de filtre afin de sel les genres
-- * possiblité de modifier les genres, pourquoi pas dans le futur un scrapping online à la fs uae
-- * possibilité de configurer l'affichage ou plusieurs types d'affichages : coverflow, liste déroulante, panel
--      * permettre de desaciver le fond : fond noir/fixe/par jeux
--      * mecanisme de layout : description d'un layout (xml) avec les elements obligatoire : boutons, ...
-- * prendre en compte retroarch et permettre de lancer directement les roms dispo!

-- * obtenir des info supplémentaire des rdb de retroarch?

-- PB :
-- * comment revenir au game launcher après la sortie d'un jeu?

app0 = ""

dofile(app0.."libWrapperOne.lua")

-- main file
dofile(app0.."main.lua")


main()

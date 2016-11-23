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
--app0 = ""
dofile(app0.."slaxml.lua")

dofile(app0.."tools.lua")
dofile(app0.."libWrapper.lua")

dofile(app0.."main.lua")

dofile(app0.."sfoTools.lua")
dofile(app0.."gameObject.lua")
dofile(app0.."gameVitaObject.lua")
dofile(app0.."gameRomObject.lua")

--dofile(app0.."buttonController.lua")
dofile(app0.."infoController.lua")

dofile(app0.."inputManager.lua")

dofile(app0.."wSystemInfo.lua")
dofile(app0.."wAppInfo.lua")
dofile(app0.."wBackground.lua")
dofile(app0.."wAppList.lua")
dofile(app0.."mmi.lua")

main ()

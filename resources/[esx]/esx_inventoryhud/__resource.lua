resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "ESX Inventory HUD"

version "1.1"

ui_page "html/ui.html"

client_scripts {
  "@es_extended/locale.lua",
  "client/main.lua",
  "client/trunk.lua",
  "client/property.lua",
  "client/player.lua",
  "locales/cs.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "config.lua"
}

server_scripts {
  "@es_extended/locale.lua",
  "server/main.lua",
  "locales/cs.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "config.lua"
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/inventory.js",
  "html/js/config.js",
  -- JS LOCALES
  "html/locales/cs.js",
  "html/locales/en.js",
  "html/locales/fr.js",
  -- IMAGES
  "html/img/bullet.png",
   -- ICONS
	'html/img/items/org1key.png',
	'html/img/items/org2key.png',
	'html/img/items/org3key.png',
	'html/img/items/policekey.png',
	'html/img/items/ambulancekey.png',
	'html/img/items/mechanickey.png',
	'html/img/items/unicornkey.png',
	'html/img/items/journalistekey.png',
	'html/img/items/courthousekey.png',
	'html/img/items/marducaskey.png',
	'html/img/items/hifi.png',
	'html/img/items/warrantkey.png',
	'html/img/items/fibkey.png',
	'html/img/items/fruitgangkey.png',
	'html/img/items/casinokey.png',
	'html/img/items/contract.png',
	'html/img/items/alive_chicken.png',
	'html/img/items/bandage.png',
	'html/img/items/black_chip.png',
	'html/img/items/weed_pooch.png',
	'html/img/items/opium.png',
	'html/img/items/opium_pooch.png',
	'html/img/items/wine.png',
	'html/img/items/coffee.png',
	'html/img/items/opium_pooch.png',
	'html/img/items/fixkit.png',
	'html/img/items/sandwich.png',
	'html/img/items/chips.png',
	'html/img/items/icetea.png',
	'html/img/items/milk.png',
	'html/img/items/lockpick.png',
	'html/img/items/lighter.png',
	'html/img/items/cigarett.png',
	'html/img/items/fishingrod.png',
	'html/img/items/diamond.png',
    'html/img/items/beer.png',
    'html/img/items/binoculars.png',
    'html/img/items/bread.png',
	'html/img/items/casino_chip.png',
    'html/img/items/cannabis.png',
    'html/img/items/cocacola.png',
    'html/img/items/coffe.png',
    'html/img/items/coke.png',
	'html/img/items/coke_pooch.png',
	'html/img/items/meth.png',
	'html/img/items/meth_pooch.png',
    'html/img/items/gold.png',
    'html/img/items/hamburger.png',
    'html/img/items/cash.png',
    'html/img/items/chocolate.png',
    'html/img/items/iron.png',
    'html/img/items/jewels.png',
    'html/img/items/medikit.png',
    'html/img/items/tequila.png',
    'html/img/items/whisky.png',
    'html/img/items/limonade.png',
    'html/img/items/phone.png',
    'html/img/items/vodka.png',
    'html/img/items/water.png',
    'html/img/items/cupcake.png',
    'html/img/items/drpepper.png',
    'html/img/items/energy.png',
    'html/img/items/croquettes.png',
    'html/img/items/bolpistache.png',
    'html/img/items/bolnoixcajou.png',
    'html/img/items/bolcacahuetes.png',
    'html/img/items/fixkit.png',
    'html/img/items/bolchips.png',
    'html/img/items/black_money.png',
    'html/img/items/WEAPON_APPISTOL.png',
    'html/img/items/WEAPON_ASSAULTRIFLE.png',
    'html/img/items/WEAPON_ASSAULTSHOTGUN.png',
    'html/img/items/WEAPON_BOTTLE.png',
    'html/img/items/WEAPON_BULLPUPRIFLE.png',
    'html/img/items/WEAPON_CARBINERIFLE.png',
    'html/img/items/WEAPON_COMBATMG.png',
    'html/img/items/WEAPON_BAT.png',
    'html/img/items/WEAPON_COMBATPISTOL.png',
    'html/img/items/WEAPON_CROWBAR.png',
    'html/img/items/WEAPON_GOLFCLUB.png',
	'html/img/items/WEAPON_GUSENBERG.png',
    'html/img/items/WEAPON_KNIFE.png',
    'html/img/items/WEAPON_MICROSMG.png',
    'html/img/items/WEAPON_NIGHTSTICK.png',
    'html/img/items/WEAPON_HAMMER.png',
    'html/img/items/WEAPON_PISTOL.png',
    'html/img/items/WEAPON_PUMPSHOTGUN.png',
    'html/img/items/WEAPON_SAWNOFFSHOTGUN.png',
    'html/img/items/WEAPON_SMG.png',
	'html/img/items/WEAPON_MACHETE.png',
    'html/img/items/WEAPON_STUNGUN.png',
    'html/img/items/WEAPON_SPECIALCARBINE.png',
    'html/img/items/WEAPON_KNUCKLE.png',
    'html/img/items/WEAPON_FLASHLIGHT.png',
    'html/img/items/WEAPON_REVOLVER.png',
    'html/img/items/WEAPON_DAGGER.png',
    'html/img/items/WEAPON_PETROLCAN.png',
    'html/img/items/WEAPON_PISTOL50.png',
    'html/img/items/WEAPON_DBSHOTGUN.png',
    'html/img/items/WEAPON_SWITCHBLADE.png',
    'html/img/items/WEAPON_POOLCUE.png',
	'html/img/items/WEAPON_FLAREGUN.png',
	'html/img/items/WEAPON_PARACHUTE.png',
	'html/img/items/absinthe.png',
	'html/img/items/adminkey.png',
	'html/img/items/airbag.png',
	'html/img/items/ammoanalyzer.png',
	'html/img/items/animal_fat.png',
	'html/img/items/antibiotics.png',
	'html/img/items/bagofdope.png',
	'html/img/items/bankerkey.png',
	'html/img/items/battery.png',
	'html/img/items/blindfold.png',
	'html/img/items/bloodsample.png',
	'html/img/items/blowtorch.png',
	'html/img/items/bobbypin.png',
	'html/img/items/bottle.png',
	'html/img/items/bouquet.png',
	'html/img/items/bulletproof.png',
	'html/img/items/c4_bank.png',
	'html/img/items/camera.png',
	'html/img/items/carokit.png',
	'html/img/items/carotool.png',
	'html/img/items/casinokey.png',
	'html/img/items/champagne.png',
	'html/img/items/chemical_cleaner.png',
	'html/img/items/chemical_mix_coke.png',
	'html/img/items/chemical_mix_meth.png',
	'html/img/items/clip.png',
	'html/img/items/cloth.png',
	'html/img/items/coal.png',
	'html/img/items/coke_ingredients.png',
	'html/img/items/cokekey.png',
	'html/img/items/copper.png',
	'html/img/items/cutted_wood.png',
	'html/img/items/detonator.png',
	'html/img/items/dnaanalyzer.png',
	'html/img/items/dopebag.png',
	'html/img/items/drill.png',
	'html/img/items/drugscales.png',
	'html/img/items/duc_tape.png',
	'html/img/items/empty_can.png',
	'html/img/items/empty_propane_tank.png',
	'html/img/items/explosive_material.png',
	'html/img/items/fabric.png',
	'html/img/items/firstaid.png',
	'html/img/items/fish_oil.png',
	'html/img/items/fixtool.png',
	'html/img/items/gazbottle.png',
	'html/img/items/gintonic.png',
	'html/img/items/glue.png',
	'html/img/items/goldNecklace.png',
	'html/img/items/handcuffs.png',
	'html/img/items/highgradefemaleseed.png',
	'html/img/items/highgradefert.png',
	'html/img/items/highgrademaleseed.png',
	'html/img/items/ice.png',
	'html/img/items/jager.png',
	'html/img/items/jagerbomb.png',
	'html/img/items/junk.png',
	'html/img/items/jusfruit.png',
	'html/img/items/leather.png',
	'html/img/items/lily.png',
	'html/img/items/lowgradefemaleseed.png',
	'html/img/items/lowgrademaleseed.png',
	'html/img/items/lowgradefert.png',
	'html/img/items/mintleaf.png',
	'html/img/items/metal_fragments.png',
	'html/img/items/meth_ingredients.png',
	'html/img/items/milk.png',
	'html/img/items/mojito.png',
	'html/img/items/oxygen_mask.png',
	'html/img/items/packaged_chicken.png',
	'html/img/items/packaged_plank.png',
	'html/img/items/patreonkey.png',
	'html/img/items/penthousekey.png',
	'html/img/items/petrol.png',
	'html/img/items/petrol_raffin.png',
	'html/img/items/plantpot.png',
	'html/img/items/purifiedwater.png',
	'html/img/items/radio.png',
	'html/img/items/raisin.png',
	'html/img/items/rasperry.png',
	'html/img/items/redskey.png',
	'html/img/items/ring.png',
	'html/img/items/rolex.png',
	'html/img/items/rope.png',
	'html/img/items/rose.png',
	'html/img/items/samsungS10.png',
	'html/img/items/rubberband.png',
	'html/img/items/shark.png',
	'html/img/items/simmonskey.png',
	'html/img/items/slaughtered_chicken.png',
	'html/img/items/soda.png',
	'html/img/items/solvent.png',
	'html/img/items/stone.png',
	'html/img/items/strokerkey.png',
	'html/img/items/sulfur.png',
	'html/img/items/trimmedweed.png',
	'html/img/items/tulip.png',
	'html/img/items/tuning_laptop.png',
	'html/img/items/washed_stone.png',
	'html/img/items/weedkey.png',
	'html/img/items/wool.png',
	'html/img/items/wood.png',
	'html/img/items/wateringcan.png',
	'html/img/items/jus_raisin.png',
	'html/img/items/bulletsample.png',
	'html/img/items/weed.png',
	'html/img/items/pdmkey.png',
	'html/img/items/pdmownerkey.png',
	'html/img/items/fish.png',
	'html/img/items/dopebag.png',
	'html/img/items/villakey.png',
	'html/img/items/baphometkey.png',
	'html/img/items/shitpitkey.png',
	'html/img/items/sullivansbible.png',
	'html/img/items/sealedjar.png',
    'html/img/items/repairkit.png',
    'html/img/items/bagkey.png',
    'html/img/items/airbag.png',
    'html/img/items/highradio.png',
    'html/img/items/highrim.png',
    'html/img/items/lowradio.png',
	'html/img/items/stockrim.png',
    'html/img/items/marijuana.png',
    'html/img/items/taco.png',
    'html/img/items/firstaidkit.png',
    'html/img/items/defibrillateur.png',
    'html/img/items/www.png',
    'html/img/items/gheart.png',
    'html/img/items/playersafeSmall.png',
	'html/img/items/playersafeLarge.png',
	'html/img/items/vitohouse.png',
	'html/img/items/winekey.png',
    'html/img/items/matthiasash.png',
    'html/img/items/tacorub.png',
    'html/img/items/flightkey.png',
    'html/img/items/carcleankit.png',
    'html/img/items/cigaretter.png',
    'html/img/items/monster.png',
	'html/img/items/meat.png',
	'html/img/items/donut.png',
	'html/img/items/picknick.png',
	'html/img/items/grand_cru.png',
}


INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('cardealer',0,'recruit','Recruit',100,'{}','{}'),
  ('cardealer',1,'novice','Novice',250,'{}','{}'),
  ('cardealer',2,'experienced','Experienced',350,'{}','{}'),
  ('cardealer',3,'boss','Boss',500,'{}','{}');


CREATE TABLE `owned_vehicles` (
  `owner` varchar(22) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext,
  `type` VARCHAR(20) NOT NULL DEFAULT 'car',
  `job` VARCHAR(20) NULL DEFAULT NULL,
  `stored` TINYINT(1) NOT NULL DEFAULT '0',

  PRIMARY KEY (`plate`)
);


CREATE TABLE `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `inshop` int(11) NOT NULL DEFAULT 1,

  PRIMARY KEY (`model`)
);

INSERT INTO `vehicles` (name, model, price, category, inshop) VALUES
  ('Tow Truck','towtruck',15000,'utility',1),
  ('Flat Bed','flatbed',15000,'utility',1),
  ('Blade','blade',15000,'muscle',1),
  ('Buccaneer','buccaneer',18000,'muscle',1),
  ('Buccaneer Rider','buccaneer2',24000,'muscle',1),
  ('Chino','chino',15000,'muscle',1),
  ('Chino Luxe','chino2',19000,'muscle',1),
  ('Coquette BlackFin','coquette3',55000,'muscle',1),
  ('Dominator','dominator',35000,'muscle',1),
  ('Dukes','dukes',28000,'muscle',1),
  ('Gauntlet','gauntlet',30000,'muscle',1),
  ('Hotknife','hotknife',125000,'muscle',1),
  ('Faction','faction',20000,'muscle',1),
  ('Faction Rider','faction2',30000,'muscle',1),
  ('Faction XL','faction3',40000,'muscle',1),
  ('Nightshade','nightshade',65000,'muscle',1),
  ('Phoenix','phoenix',12500,'muscle',1),
  ('Picador','picador',18000,'muscle',1),
  ('Sabre Turbo','sabregt',20000,'muscle',1),
  ('Sabre GT','sabregt2',25000,'muscle',1),
  ('Slam Van','slamvan3',11500,'muscle',1),
  ('Tampa','tampa',16000,'muscle',1),
  ('Virgo','virgo',14000,'muscle',1),
  ('Vigero','vigero',12500,'muscle',1),
  ('Voodoo','voodoo',7200,'muscle',1),
  ('Blista','blista',8000,'compacts',1),
  ('Brioso R/A','brioso',18000,'compacts',1),
  ('Issi','issi2',10000,'compacts',1),
  ('Panto','panto',10000,'compacts',1),
  ('Prairie','prairie',12000,'compacts',1),
  ('Bison','bison',45000,'vans',1),
  ('Bobcat XL','bobcatxl',32000,'vans',1),
  ('Burrito','burrito3',19000,'vans',1),
  ('Burrito','gburrito2',29000,'vans',1),
  ('Camper','camper',42000,'vans',1),
  ('Gang Burrito','gburrito',45000,'vans',1),
  ('Journey','journey',6500,'vans',1),
  ('Minivan','minivan',13000,'vans',1),
  ('Moonbeam','moonbeam',18000,'vans',1),
  ('Moonbeam Rider','moonbeam2',35000,'vans',1),
  ('Paradise','paradise',19000,'vans',1),
  ('Rumpo','rumpo',15000,'vans',1),
  ('Rumpo Trail','rumpo3',19500,'vans',1),
  ('Surfer','surfer',12000,'vans',1),
  ('Youga','youga',10800,'vans',1),
  ('Youga Luxuary','youga2',14500,'vans',1),
  ('Asea','asea',5500,'sedans',1),
  ('Cognoscenti','cognoscenti',55000,'sedans',1),
  ('Emperor','emperor',8500,'sedans',1),
  ('Fugitive','fugitive',12000,'sedans',1),
  ('Glendale','glendale',6500,'sedans',1),
  ('Intruder','intruder',7500,'sedans',1),
  ('Premier','premier',8000,'sedans',1),
  ('Primo Custom','primo2',14000,'sedans',1),
  ('Regina','regina',5000,'sedans',1),
  ('Schafter','schafter2',25000,'sedans',1),
  ('Stretch','stretch',90000,'sedans',1),
  ('Super Diamond','superd',130000,'sedans',1),
  ('Tailgater','tailgater',30000,'sedans',1),
  ('Warrener','warrener',4000,'sedans',1),
  ('Washington','washington',9000,'sedans',1),
  ('Baller','baller2',40000,'suvs',1),
  ('Baller Sport','baller3',60000,'suvs',1),
  ('Cavalcade','cavalcade2',55000,'suvs',1),
  ('Contender','contender',70000,'suvs',1),
  ('Dubsta','dubsta',45000,'suvs',1),
  ('Dubsta Luxuary','dubsta2',60000,'suvs',1),
  ('Fhantom','fq2',17000,'suvs',1),
  ('Grabger','granger',50000,'suvs',1),
  ('Gresley','gresley',47500,'suvs',1),
  ('Huntley S','huntley',40000,'suvs',1),
  ('Landstalker','landstalker',35000,'suvs',1),
  ('Mesa','mesa',16000,'suvs',1),
  ('Mesa Trail','mesa3',40000,'suvs',1),
  ('Patriot','patriot',55000,'suvs',1),
  ('Radius','radi',29000,'suvs',1),
  ('Rocoto','rocoto',45000,'suvs',1),
  ('Seminole','seminole',25000,'suvs',1),
  ('XLS','xls',32000,'suvs',1),
  ('Btype','btype',62000,'sportsclassics',1),
  ('Btype Luxe','btype3',85000,'sportsclassics',1),
  ('Btype Hotroad','btype2',155000,'sportsclassics',1),
  ('Casco','casco',30000,'sportsclassics',1),
  ('Coquette Classic','coquette2',40000,'sportsclassics',1),
  ('Manana','manana',12800,'sportsclassics',1),
  ('Monroe','monroe',55000,'sportsclassics',1),
  ('Pigalle','pigalle',20000,'sportsclassics',1),
  ('Stinger','stinger',80000,'sportsclassics',1),
  ('Stinger GT','stingergt',75000,'sportsclassics',1),
  ('Stirling GT','feltzer3',65000,'sportsclassics',1),
  ('Z-Type','ztype',220000,'sportsclassics',1),
  ('Bifta','bifta',12000,'offroad',1),
  ('Bf Injection','bfinjection',16000,'offroad',1),
  ('Blazer','blazer',6500,'offroad',1),
  ('Blazer Sport','blazer4',8500,'offroad',1),
  ('Brawler','brawler',45000,'offroad',1),
  ('Bubsta 6x6','dubsta3',120000,'offroad',1),
  ('Dune Buggy','dune',8000,'offroad',1),
  ('Guardian','guardian',45000,'offroad',1),
  ('Rebel','rebel2',35000,'offroad',1),
  ('Sandking','sandking',55000,'offroad',1),
  ('The Liberator','monster',210000,'offroad',1),
  ('Trophy Truck','trophytruck',60000,'offroad',1),
  ('Trophy Truck Limited','trophytruck2',80000,'offroad',1),
  ('Cognoscenti Cabrio','cogcabrio',55000,'coupes',1),
  ('Exemplar','exemplar',32000,'coupes',1),
  ('F620','f620',40000,'coupes',1),
  ('Felon','felon',42000,'coupes',1),
  ('Felon GT','felon2',55000,'coupes',1),
  ('Jackal','jackal',38000,'coupes',1),
  ('Oracle XS','oracle2',35000,'coupes',1),
  ('Sentinel','sentinel',32000,'coupes',1),
  ('Sentinel XS','sentinel2',40000,'coupes',1),
  ('Windsor','windsor',95000,'coupes',1),
  ('Windsor Drop','windsor2',125000,'coupes',1),
  ('Zion','zion',36000,'coupes',1),
  ('Zion Cabrio','zion2',45000,'coupes',1),
  ('9F','ninef',65000,'sports',1),
  ('9F Cabrio','ninef2',80000,'sports',1),
  ('Alpha','alpha',60000,'sports',1),
  ('Banshee','banshee',70000,'sports',1),
  ('Bestia GTS','bestiagts',55000,'sports',1),
  ('Buffalo','buffalo',12000,'sports',1),
  ('Buffalo S','buffalo2',20000,'sports',1),
  ('Carbonizzare','carbonizzare',75000,'sports',1),
  ('Comet','comet2',65000,'sports',1),
  ('Coquette','coquette',65000,'sports',1),
  ('Drift Tampa','tampa2',80000,'sports',1),
  ('Elegy','elegy2',38500,'sports',1),
  ('Feltzer','feltzer2',55000,'sports',1),
  ('Furore GT','furoregt',45000,'sports',1),
  ('Fusilade','fusilade',40000,'sports',1),
  ('Jester','jester',65000,'sports',1),
  ('Jester(Racecar)','jester2',135000,'sports',1),
  ('Khamelion','khamelion',38000,'sports',1),
  ('Kuruma','kuruma',30000,'sports',1),
  ('Lynx','lynx',40000,'sports',1),
  ('Mamba','mamba',70000,'sports',1),
  ('Massacro','massacro',65000,'sports',1),
  ('Massacro(Racecar)','massacro2',130000,'sports',1),
  ('Omnis','omnis',35000,'sports',1),
  ('Penumbra','penumbra',28000,'sports',1),
  ('Rapid GT','rapidgt',35000,'sports',1),
  ('Rapid GT Convertible','rapidgt2',45000,'sports',1),
  ('Schafter V12','schafter3',50000,'sports',1),
  ('Seven 70','seven70',39500,'sports',1),
  ('Sultan','sultan',15000,'sports',1),
  ('Surano','surano',50000,'sports',1),
  ('Tropos','tropos',40000,'sports',1),
  ('Verlierer','verlierer2',70000,'sports',1),
  ('Adder','adder',900000,'super',1),
  ('Banshee 900R','banshee2',255000,'importcars',0),
  ('Bullet','bullet',90000,'super',1),
  ('Cheetah','cheetah',375000,'super',1),
  ('Entity XF','entityxf',425000,'importcars',0),
  ('ETR1','sheava',220000,'importcars',0),
  ('FMJ','fmj',185000,'super',1),
  ('Infernus','infernus',180000,'super',1),
  ('Osiris','osiris',160000,'super',1),
  ('Pfister','pfister811',85000,'super',1),
  ('RE-7B','le7b',325000,'importcars',0),
  ('Reaper','reaper',150000,'importcars',0),
  ('Sultan RS','sultanrs',65000,'importcars',0),
  ('T20','t20',300000,'super',1),
  ('Turismo R','turismor',350000,'super',1),
  ('Tyrus','tyrus',600000,'super',1),
  ('Vacca','vacca',120000,'super',1),
  ('Voltic','voltic',90000,'super',1),
  ('X80 Proto','prototipo',2500000,'super',1),
  ('Zentorno','zentorno',1500000,'super',1),
  ('Akuma','AKUMA',7500,'motorcycles',1),
  ('Avarus','avarus',18000,'motorcycles',1),
  ('Bagger','bagger',13500,'motorcycles',1),
  ('Bati 801','bati',12000,'importbikes',0),
  ('Bati 801RR','bati2',19000,'importbikes',0),
  ('BF400','bf400',6500,'motorcycles',1),
  ('BMX (velo)','bmx',160,'motorcycles',1),
  ('Carbon RS','carbonrs',18000,'motorcycles',1),
  ('Chimera','chimera',38000,'motorcycles',1),
  ('Cliffhanger','cliffhanger',9500,'motorcycles',1),
  ('Cruiser (velo)','cruiser',510,'motorcycles',1),
  ('Daemon','daemon',11500,'motorcycles',1),
  ('Daemon High','daemon2',13500,'motorcycles',1),
  ('Defiler','defiler',9800,'motorcycles',1),
  ('Double T','double',28000,'motorcycles',1),
  ('Enduro','enduro',5500,'motorcycles',1),
  ('Esskey','esskey',4200,'motorcycles',1),
  ('Faggio','faggio',1900,'motorcycles',1),
  ('Vespa','faggio2',2800,'motorcycles',1),
  ('Fixter (velo)','fixter',225,'motorcycles',1),
  ('Gargoyle','gargoyle',16500,'motorcycles',1),
  ('Hakuchou','hakuchou',31000,'motorcycles',1),
  ('Hakuchou Sport','hakuchou2',55000,'motorcycles',1),
  ('Hexer','hexer',12000,'motorcycles',1),
  ('Innovation','innovation',23500,'motorcycles',1),
  ('Manchez','manchez',5300,'motorcycles',1),
  ('Nemesis','nemesis',5800,'motorcycles',1),
  ('Nightblade','nightblade',35000,'importbikes',0),
  ('PCJ-600','pcj',6200,'motorcycles',1),
  ('Ruffian','ruffian',6800,'motorcycles',1),
  ('Sanchez','sanchez',5300,'motorcycles',1),
  ('Sanchez Sport','sanchez2',5300,'motorcycles',1),
  ('Sanctus','sanctus',25000,'importbikes',0),
  ('Scorcher (velo)','scorcher',280,'motorcycles',1),
  ('Sovereign','sovereign',22000,'motorcycles',1),
  ('Shotaro Concept','shotaro',320000,'importbikes',0),
  ('Thrust','thrust',24000,'motorcycles',1),
  ('Tri bike (velo)','tribike3',520,'motorcycles',1),
  ('Vader','vader',7200,'motorcycles',1),
  ('Vortex','vortex',9800,'motorcycles',1),
  ('Woflsbane','wolfsbane',9000,'importbikes',0),
  ('Zombie','zombiea',9500,'motorcycles',1),
  ('Zombie Luxuary','zombieb',12000,'importbikes',0),
  ('blazer5', 'blazer5', 1755600, 'offroad',1),
  ('Ruiner 2', 'ruiner2', 5745600, 'muscle',1),
  ('Voltic 2', 'voltic2', 3830400, 'super',1),
  ('Ardent', 'ardent', 1150000, 'sportsclassics',1),
  ('Oppressor', 'oppressor', 3524500, 'super',1),
  ('Visione', 'visione', 2250000, 'super',1),
  ('Retinue', 'retinue', 615000, 'sportsclassics',1),
  ('Cyclone', 'cyclone', 1890000, 'super',1), 
  ('Rapid GT3', 'rapidgt3', 885000, 'sportsclassics',1),
  ('raiden', 'raiden', 1375000, 'sports',1),
  ('Yosemite', 'yosemite', 485000, 'muscle',1),
  ('Deluxo', 'deluxo', 4721500, 'sportsclassics',1),
  ('Pariah', 'pariah', 1420000, 'sports',1),
  ('Stromberg', 'stromberg', 3185350, 'sports',1),
  ('SC 1', 'sc1', 1603000, 'super',1),
  ('riata', 'riata', 380000, 'offroad',1),
  ('Hermes', 'hermes', 535000, 'muscle',1),
  ('Savestra', 'savestra', 990000, 'sportsclassics',1),
  ('Streiter', 'streiter', 500000, 'sports',1),
  ('Kamacho', 'kamacho', 345000, 'offroad',1),
  ('GT 500', 'gt500', 785000, 'sportsclassics',1),
  ('Z190', 'z190', 900000, 'sportsclassics',1),
  ('Viseris', 'viseris', 875000, 'sportsclassics',1),
  ('Autarch', 'autarch', 1955000, 'super',1),
  ('Comet 5', 'comet5', 1145000, 'sports',1), 
  ('Neon', 'neon', 1500000, 'sports',1),
  ('Revolter', 'revolter', 1610000, 'sports',1),
  ('Sentinel3', 'sentinel3', 650000, 'sports',1),
  ('Hustler', 'hustler', 625000, 'muscle',1)
;


CREATE TABLE `vehicles_display` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `profit` int(11) NOT NULL DEFAULT 10,
  `price` int(11) NOT NULL,

  PRIMARY KEY (`ID`)
);

INSERT INTO `vehicles_display` (`ID`, `name`, `model`, `profit`, `price`) VALUES
  (1, 'RE-7B', 'le7b', 10, 325000),
  (2, 'Reaper', 'reaper', 10, 150000),
  (3, 'Sultan RS', 'sultanrs', 10, 65000),
  (4, 'Wolfsbane', 'wolfsbane', 10, 9000),
  (5, 'Zombie Bobber', 'zombieb', 10, 12000),
  (6, 'Nightblade', 'nightblade', 10, 35000);
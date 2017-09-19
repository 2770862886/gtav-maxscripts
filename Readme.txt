GTAV MAP HELPER BY NEOS7
v0.2

INSTALL:
Copy the folders "GTAV_Map_Helper" and "Startup" in the "scripts" folder of your 3ds Max. (usually "3dsmax\scripts\")
Run 3ds Max and the script will appear in your utilities.

USAGE:

Ymap & Ytyp:
Select geometries and click the export button. (Yes it only works with Geometries)
Of course exported models have to be coherent with those used to generate the metadata in order to properly work in game.

InstancedGrass:
Select your geometries and be sure they are of class Editable_Poly.
Each geometry is used as batch and its selected polygons are used as positions for instances.
I suggest to tesselate/turbosmooth/subdivide your geometry sample to increase polygons density, instances density in our case.

Water.xml:
Work from Top View and create planes, they will be used as water blocks. 

FiveM .json Exporter:
I also included the .json support since this script is initially written to work with json only and I still find the json a good format to backup both entities and archetype in the same file.
You can also import a json to move/rotate geometries in scene, it will create instances for entities with the same name.(this feature will be extended to ymaps)
If you have an error on startup about the assembly, right click on "Newtonsoft.Json.dll" located in the "scripts\GTAV_Map_Helper\fivem\" folder, go to Properties and unblock it or simply download it from Newtonsoft here:
https://github.com/JamesNK/Newtonsoft.Json/releases/latest

This maxscript allows you to export meta data to help loading maps/props in GTA V.
It allows to export:
.ytyp.xml
.ymap.xml
.json
water.xml

The .ytyp.xml and .ymap.xml files have fixed properties for now, the settings panel is just a placeholder until I finish it.
This script isn't complete but I've choosen to release it to have suggestions, feedbacks and help of course, I've started working on this just because I needed and I had no maxscript knowledge.

NOTE: 
This script doesn't export game models, you will still need a script like GIMS EVO to do that.
You will also need to convert the .xml to game format using a tool like OpenIV or MetaTool.

IMPORTANT: 
Because of its early state, I remember that you have to manually edit some properties:
1.textureDictionary/txdName tag for the archetypes, they are saved as "geometryname_ytd", I've added the "_ytd" so you can easily detect them with regex or what ever you wanna use.
2.lodDist in ymaps which is meant to be at least big as the radius of the archetype.

This tool was initially made to help creating custom maps for GTADrifting server for FiveM.

People I would thanks:
3Doomer
Those 2 guys who keeps blaming what I don't do. <3

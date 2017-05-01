GTAV MAP HELPER BY NEOS7
v0.1

INSTALL:
Copy the folder "scripts" in your 3ds Max root folder.
Run 3ds Max and the script will appear in your utilities.

If you have an error on startup about the assembly, right click on "Newtonsoft.Json.dll" located in the "scripts\GTAV_Map_Helper\" folder, go to Properties and unblock it or simply download it from Newtonsoft here:
https://github.com/JamesNK/Newtonsoft.Json/releases/latest

This maxscript allows you to export meta data to help loading maps/props in GTA V.
It allows to export:
.ytyp.xml
.ymap.xml
.json

I also included the .json support since this script is initially written to work with json only and I still find the json a good format to backup both entities and archetype in the same file.
You can also import a json to move/rotate geometries in scene, it will create instances for entities with the same name.(this feature will be extended to ymaps)

The .ytyp.xml and .ymap.xml files have fixed properties for now, the settings panel is just a placeholder until I finish it.
This script isn't complete but I've choosen to release it to have suggestions, feedbacks and help of course, I've started working on this just because I needed it and then I thought someone else could need it too.

NOTE: This script doesn't export game models, you will still need a script like GIMS EVO to do that.

IMPORTANT: Because of its early state, I remember that you have to manually edit some properties:
1.textureDictionary/txdName tag for the archetypes, they are saved as "geometryname_ytd", I've added the "_ytd" so you can easily detect them with regex or what ever you wanna use.
2.lodDist in ymaps which is meant to be at least big as the radius of the archetype.

So to finish, this might be a incomplete shit for now but I hope it might help already,somehow.
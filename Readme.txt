GTAV MAP HELPER BY NEOS7
v0.3

INSTALL
Copy the folders "GTAV_Map_Helper" and "Startup" in the "scripts" folder of your 3ds Max. (usually "3dsmax\scripts\")
Run 3ds Max and the script will appear in your utilities.

YTYP & YMAP
###EXPORT###
Select the meshes used as GTA V drawables, customize the settings and click "Add" to collect the data.
The chosen settings will be used for all the selected meshes.
When you finished click the "Export" button to save the .xml file.
In case you want to restart you can click the "Reset" button.

In case you are using GIMS EVO to export models remember that the name of the meshes you select should be the same used for .#dr files because the script takes the name from the meshes. Some properties you don't see in the panels might be still not supported or auto calculated. For example the lodDist is automatically calculated based on the radius of the mesh, textureDictionary in .ytyp instead if left empty will be filled with the same name of the single mesh (case of embedded textures), otherwise the chosen name will be used for all the selected created archetypes.

I strongly suggest to place the pivots of your meshes inside their bounding box, you can easily move them in the center of the mesh using the tool in 3ds. Remember also that their parent dummy create with GIMS EVO overrides the children pivots, so you should manually move it at the same position of the pivot that you previously moved in the center of the mesh (or at least inside the bounding box)

You can use the "GIMS EVO Shortcouts" in the main menu of this script to automatically do move create the parent dummies and move them at the same position of the meshes pivots. (It will also add the "Game Mesh" modifier required for GIMS EVO)

So an example scenario would be:
1.Resets the pivots of all the meshes in their local center
2.Select all the meshes and click on "Create multiple models" in the main menu of this script
3.Export models with GIMS EVO and ytyp/ymap with this script

Remember that exported models and exported metadata must be coherent to work properly, so if you edit the mesh topology of your models you have export new metadata. 

###IMPORT###
The imported is really simple, you click "Import .ymap.xml" and select your file.
The script will read it and then will move/rotate/scale your objects in scene based on their name.
You can first use the "Check .ymap.xml" to check which object is missing without moving anything.

So an example scenario would be:
1.Import your models using GIMS EVO
2.Import the .ymap.xml using my script


INSTANCED GRASS PAINTER
Select the meshes you want to paint over, select the archetypeName and click on "Enable Paint" to start painting.
If there is no mesh in scene with the selected archetypeName, the script will load it from the assets folder.
Click again on "Enable Paint" to close the current batch. Repeat these steps for each batch.
When you finish, select the root dummies of the batches, customize your setting for both batches and instances and click "Add Batches" to collect the data. Remember that thr chosen settings will be used for all the selected batches when you add them.
Click "Reset" if you want to reset the batches you collected in the exporter.
To export the .ymap.xml file just click on "Export .ymap.xml"

If you want to preload all the assets click on the button "Import assets" and wait until they are loaded.
You can also import grass batches back in the scene using the "Import .ymap.xml" button.

NOTE: This is a beta script, it may change a lot.


OLD SCRIPTS:
Water.xml
Work from Top View and create planes, they will be used as water blocks. 

FiveM .json Exporter
I also included the .json support since this script is initially written to work with json only and I still find the json a good format to backup both entities and archetype in the same file.
You can also import a json to move/rotate geometries in scene, it will create instances for entities with the same name.(this feature will be extended to ymaps)
If you have an error on startup about the assembly, right click on "Newtonsoft.Json.dll" located in the "scripts\GTAV_Map_Helper\fivem\" folder, go to Properties and unblock it or simply download it from Newtonsoft here:
https://github.com/JamesNK/Newtonsoft.Json/releases/latest

NOTES
The .ytyp.xml and .ymap.xml files have fixed properties for now, the settings panel is just a placeholder until I finish it.
This script isn't complete but I've choosen to release it to have suggestions, feedbacks and help of course, I've started working on this just because I needed it and I had no maxscript knowledge.

This script doesn't export game models, you will still need a script like GIMS EVO to do that.
You will also need to convert the .xml to game format using a tool like CodeWalker, OpenIV or MetaTool.

This tool was initially made to help creating custom maps for GTADrifting server for FiveM.

People I would thanks:
GTADrifting members
Remaster Autos members
dexyfex
3Doomer
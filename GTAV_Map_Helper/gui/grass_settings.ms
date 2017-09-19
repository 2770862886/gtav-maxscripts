rollout Grass_Instance "GrassInstance Settings" width:250 height:500
(
	group "GrassInstance"
	(
		dropdownlist 'BatchAABB_archetypeName' "archetypeName:" items: #("RANDOM", "proc_brittlebush_01", "proc_desert_sage_01", "proc_drygrasses01", "proc_drygrasses01b", "proc_drygrassfronds01",
			"proc_dryplantsgrass_01", "proc_dryplantsgrass_02", "proc_dry_plants_01", "proc_forest_grass01", "proc_forest_ivy_01",
			"proc_grassdandelion01", "proc_grasses01", "proc_grasses01b", "proc_grassfronds01", "proc_grassplantmix_01", "proc_grassplantmix_02",
			"proc_indian_pbrush_01", "proc_leafybush_01", "proc_leafyplant_01", "proc_lizardtail_01", "proc_lupins_01", "proc_meadowmix_01",
			"proc_meadowpoppy_01", "proc_sage_01", "proc_scrub_bush01", "proc_sml_reeds_01", "proc_sml_reeds_01b", "proc_sml_reeds_01c",
			"proc_stones_01", "proc_stones_02", "proc_stones_03", "proc_stones_04", "proc_stones_05", "proc_stones_06", "proc_wildquinine",
			"prop_dandy_b", "prop_dryweed_001_a", "prop_dryweed_002_a", "prop_fernba", "prop_fernbb", "prop_flowerweed_005_a", "prop_grass_001_a",
			"prop_grass_ca", "prop_grass_da", "prop_log_aa", "prop_log_ab", "prop_log_ac", "prop_log_ad", "prop_log_ae", "prop_log_af", "prop_saplin_001_b",
			"prop_saplin_001_c", "prop_saplin_002_b", "prop_saplin_002_c", "prop_small_bushyba", "prop_tall_drygrass_aa", "prop_tall_grass_ba",
			"prop_thindesertfiller_aa", "prop_weed_001_aa", "prop_weed_002_ba", "urbandryfrnds_01", "urbandrygrass_01", "urbangrnfrnds_01",
			"urbangrngrass_01", "urbanweeds01", "urbanweeds01_l1", "urbanweeds02", "urbanweeds02_l1")
	)
	
	group "Instance"
	(
		spinner 'Instance_Scale' "Scale" range:[0,255,48] type:#integer align:#center width:150
		spinner 'Instance_ColorR' "Color R" range:[0,255,0] type:#integer align:#center width:150
		spinner 'Instance_ColorG' "Color G" range:[0,255,0] type:#integer align:#center width:150
		spinner 'Instance_ColorB' "Color B" range:[0,255,0] type:#integer align:#center width:150
	)
)
createdialog Grass_Instance
	/*
if(BatchAABB_archetypeName.selected == "RANDOM")then
	(
		v_proc1 = #("proc_brittlebush_01", "proc_desert_sage_01", "proc_drygrasses01", "proc_drygrasses01b", "proc_drygrassfronds01",
			"proc_dryplantsgrass_01", "proc_dryplantsgrass_02", "proc_dry_plants_01", "proc_forest_grass01", "proc_forest_ivy_01",
			"proc_grassdandelion01", "proc_grasses01", "proc_grasses01b", "proc_grassfronds01", "proc_grassplantmix_01", "proc_grassplantmix_02",
			"proc_indian_pbrush_01", "proc_leafybush_01", "proc_leafyplant_01", "proc_lizardtail_01", "proc_lupins_01", "proc_meadowmix_01",
			"proc_meadowpoppy_01", "proc_sage_01", "proc_scrub_bush01", "proc_sml_reeds_01", "proc_sml_reeds_01b", "proc_sml_reeds_01c",
			"proc_stones_01", "proc_stones_02", "proc_stones_03", "proc_stones_04", "proc_stones_05", "proc_stones_06", "proc_wildquinine",
			"prop_dandy_b", "prop_dryweed_001_a", "prop_dryweed_002_a", "prop_fernba", "prop_fernbb", "prop_flowerweed_005_a", "prop_grass_001_a",
			"prop_grass_ca", "prop_grass_da", "prop_log_aa", "prop_log_ab", "prop_log_ac", "prop_log_ad", "prop_log_ae", "prop_log_af", "prop_saplin_001_b",
			"prop_saplin_001_c", "prop_saplin_002_b", "prop_saplin_002_c", "prop_small_bushyba", "prop_tall_drygrass_aa", "prop_tall_grass_ba",
			"prop_thindesertfiller_aa", "prop_weed_001_aa", "prop_weed_002_ba", "urbandryfrnds_01", "urbandrygrass_01", "urbangrnfrnds_01",
			"urbangrngrass_01", "urbanweeds01", "urbanweeds01_l1", "urbanweeds02", "urbanweeds02_l1")
		i = random 1 v_proc1.count
		print v_proc1[i]
	)
*/
CAMPAIGN_NAME = "BoTM Altis #1";
CAMPAIGN_AUTHOR = "[BoTM] OzDeaDMeaT";
SPECIAL_SLOT = ["ZeusPlayer","ZeusPlayer_1"]; // These special Slots will not load or save any data when the player uses this slot.
RESERVED_SLOT = ["ZeusPlayer"];
RESERVED_UID = ["76561197970647342","_SP_PLAYER_"]; //Put Player GUID for people who are allowed to have access to Reserved Slot Units.
CURATOR_OBJ = Zeus; //Remember, this is not the player, this is the Game Master Module Name
HELPER_CURATOR_OBJ = [[ZeusPlayer_1,Zeus_1]]; //Locked Down Curator Objects
CAMPAIGN_FACTION = "BLU_F"; //BLU_G_F , OPF_F , OPF_G_F , IND_F , IND_G_F , CIV_F
CM_STARTING_LIVES = 8; // This Variable is used for the first time the mission runs only. Then the saved data is used.
MISSIONSUCCESS_BONUS_SCORE = 100; 	//used in iniDB_Functions at end mission.
MISSIONSUCCESS_BONUS_LIVES = 1;		//used in iniDB_Functions at end mission.
ACTIONcrates = ["Box_FIA_Support_F"]; //FIA Equipment Cache BE CAREFUL, CASE SENSITIVE!!!
//--------------------DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING!!--------------------\\
//RANK STUFF
RANKSCORE = [0, 500, 2000, 5000, 11000, 23000, 47000, 95000,1000000000];
RANKNAME = 	["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL","GENERAL","SupremeCommander"];
RANKSN = 	["Pvt","Cpl","Sgt","Lt","Cpt","Maj","Col","Gen","SC"];
//--------------------------------------------------------------------------------------------------------\\
//ZEUS STUFF
CURATOR_OBJ removeCuratorAddons ["a3_modules_f_curator_respawn"]; //Removes Respawn Stuff from Zeus Interface
ZEUS_LOCKDOWN = ["A3_Modules_F_Curator","A3_Modules_F_Curator_Curator","A3_Modules_F_Curator_Flares","A3_Modules_F_Curator_Misc","A3_Modules_F_Curator_Smokeshells","A3_Modules_F_Bootcamp_Misc"];
NOTALLOWED=["ModuleOrdnanceRocket_F","ModuleCASMissile_F","ModuleCASGun_F","ModuleCASGunMissile_F","ModuleTimeMultiplier_F","ModulePostprocess_F","ModuleCountdown_F","ModuleRespawnTickets_F","ModuleMissionName_F","ModuleBootcampStage_F","ModuleHint_F","ModuleObjectiveAttackDefend_F",
"ModuleObjectiveNeutralize_F","ModuleObjectiveProtect_F","ModuleObjectiveSector_F","ModuleObjectiveGetIn_F","ModuleObjectiveRaceCP_F","ModuleObjectiveRaceFinish_F","ModuleObjectiveRaceStart_F","B_Soldier_VR_F","I_Soldier_VR_F","O_Soldier_VR_F","C_Soldier_VR_F"];
SPECIAL_BKPK = ["B_UAV_01_backpack_F","B_HMG_01_support_F","B_HMG_01_support_high_F","B_HMG_01_weapon_F","B_HMG_01_A_weapon_F","B_GMG_01_weapon_F","B_GMG_01_A_weapon_F","B_HMG_01_high_weapon_F","B_HMG_01_A_high_weapon_F","B_GMG_01_high_weapon_F","B_GMG_01_A_high_weapon_F","B_Mortar_01_support_F","B_Mortar_01_weapon_F","B_AA_01_weapon_F","B_AT_01_weapon_F","I_UAV_01_backpack_F","I_HMG_01_support_F","I_HMG_01_support_high_F","I_HMG_01_weapon_F","I_HMG_01_A_weapon_F","I_GMG_01_weapon_F","I_GMG_01_A_weapon_F","I_HMG_01_high_weapon_F","I_HMG_01_A_high_weapon_F","I_GMG_01_high_weapon_F","I_GMG_01_A_high_weapon_F","I_Mortar_01_support_F","I_Mortar_01_weapon_F","I_AA_01_weapon_F","I_AT_01_weapon_F","O_UAV_01_backpack_F","O_HMG_01_support_F","O_HMG_01_support_high_F","O_HMG_01_weapon_F","O_HMG_01_A_weapon_F","O_GMG_01_weapon_F","O_GMG_01_A_weapon_F","O_HMG_01_high_weapon_F","O_HMG_01_A_high_weapon_F","O_GMG_01_high_weapon_F","O_GMG_01_A_high_weapon_F","O_Mortar_01_support_F","O_Mortar_01_weapon_F","O_AA_01_weapon_F","O_AT_01_weapon_F"];
//--------------------------------------------------------------------------------------------------------\\
//StarterCrate Stuff
STARTER_CRATE_ITEMS = ["U_C_HunterBody_grn","U_BG_Guerrilla_6_1","U_BG_leader","U_BG_Guerilla3_1","U_BG_Guerilla1_1","H_Booniehat_khk","H_Booniehat_mcamo","H_Booniehat_tan","H_Booniehat_dgtl","H_Cap_tan","H_Cap_blk","H_Cap_blk_CMMG","H_Cap_brn_SPECOPS","H_Cap_tan_specops_US","H_Cap_khaki_specops_UK","H_Cap_grn","H_Cap_grn_BI","H_Cap_blu","H_Cap_blk_Raven","H_Cap_blk_ION","H_MilCap_ocamo","H_MilCap_mcamo","H_MilCap_gry","H_MilCap_dgtl","H_MilCap_blue","H_Bandanna_surfer","H_Bandanna_khk","H_Bandanna_cbr","H_Bandanna_sgg","H_Bandanna_gry","H_Bandanna_camo","H_Bandanna_mcamo","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Beret_blk","H_Watchcap_blk","H_Watchcap_khk","H_Watchcap_camo","H_Hat_blue","H_Hat_brown","H_Hat_camo","H_Hat_grey","H_Hat_checker","H_Hat_tan","H_Cap_oli","H_Bandanna_khk_hs","H_Booniehat_khk_hs","H_Cap_oli_hs","H_Shemag_olive_hs","H_Shemag_olive","H_Booniehat_oli","H_Bandanna_surfer_blk","H_Bandanna_surfer_grn","H_Bandanna_blu","H_Bandanna_sand","H_Watchcap_cbr","H_Cap_usblack","H_Cap_surfer","H_Beret_02","H_Beret_Colonel","ItemWatch","ItemCompass","ItemMap","AGM_Bandage","G_Spectacles","G_Spectacles_Tinted","G_Combat","G_Lowprofile","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Squares","G_Squares_Tinted","G_Sport_BlackWhite","G_Sport_Blackyellow","G_Sport_Greenblack","G_Sport_Checkered","G_Sport_Red","G_Tactical_Black","G_Aviator","G_Lady_Mirror","G_Lady_Dark","G_Lady_Red","G_Lady_Blue","G_Diving","G_B_Diving","G_O_Diving","G_I_Diving","G_Goggles_VR","G_Balaclava_blk","G_Balaclava_oli","G_Balaclava_combat","G_Balaclava_lowprofile","G_Bandanna_blk","G_Bandanna_oli","G_Bandanna_khk","G_Bandanna_tan","G_Bandanna_beast","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_aviator","G_Shades_Blue","G_Sport_Blackred","G_Tactical_Clear","acc_flashlight","U_IG_Menelaos","U_C_Novak","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_IG_Guerilla3_2","U_IG_leader","U_BG_Guerilla1_1","U_BG_Guerilla2_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_Guerilla3_2","U_BG_leader","U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_2","U_OG_Guerilla2_3","U_OG_Guerilla3_1","V_Rangemaster_belt","V_BandollierB_khk","V_BandollierB_cbr","V_BandollierB_rgr","V_BandollierB_blk","V_BandollierB_oli","V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_rgr","V_PlateCarrier1_blk","V_PlateCarrierSpec_rgr","V_Chestrig_khk","V_Chestrig_rgr","V_Chestrig_blk","V_Chestrig_oli","V_TacVest_khk","V_TacVest_brn","V_TacVest_oli","V_TacVest_blk","V_TacVest_camo","V_TacVestIR_blk","V_TacVestCamo_khk","V_HarnessO_brn","V_HarnessOGL_brn","V_HarnessO_gry","V_HarnessOGL_gry","V_HarnessOSpec_brn","V_HarnessOSpec_gry","V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_I_G_resistanceLeader_F","H_Booniehat_khk","H_Booniehat_indp","H_Booniehat_mcamo","H_Booniehat_grn","H_Booniehat_tan","H_Booniehat_dirty","H_Booniehat_dgtl","H_Booniehat_khk_hs","H_Cap_red","H_Cap_blu","H_Cap_oli","H_Cap_headphones","H_Cap_tan","H_Cap_blk","H_Cap_blk_CMMG","H_Cap_brn_SPECOPS","H_Cap_tan_specops_US","H_Cap_khaki_specops_UK","H_Cap_grn","H_Cap_blk_Raven","H_Cap_oli_hs","H_MilCap_oucamo","H_MilCap_rucamo","H_MilCap_gry","H_MilCap_blue","H_BandMask_blk","H_BandMask_khk","H_BandMask_reaper","H_BandMask_demon","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_cbr","H_Bandanna_sgg","H_Bandanna_gry","H_Bandanna_camo","H_Bandanna_mcamo","H_Shemag_khk","H_Shemag_tan","H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Beret_blk","H_Beret_red","H_Beret_grn","H_Beret_grn_SF","H_Beret_brn_SF","H_Beret_ocamo","H_Beret_02","H_Beret_Colonel","H_Watchcap_blk","H_Watchcap_khk","H_Watchcap_camo","H_Watchcap_sgg","H_TurbanO_blk","optic_Holosight_smg"];
STARTER_CRATE_WEAPONS = ["SMG_02_F","hgun_P07_F"];
STARTER_CRATE_MAGS = ["30Rnd_9x21_Mag","16Rnd_9x21_Mag"];
STARTER_CRATE_BACKPACKS = ["B_AssaultPack_khk","B_AssaultPack_khk_holder","B_AssaultPack_khk_Ammo","B_AssaultPack_khk_Medic","B_AssaultPack_khk_Repair","B_AssaultPack_dgtl","B_AssaultPack_dgtl_AAR","B_AssaultPack_dgtl_Spotter","B_AssaultPack_rgr","B_AssaultPack_rgr_AT","B_AssaultPack_rgr_Medic","B_AssaultPack_rgr_ReconMedic","B_AssaultPack_rgr_Repair","B_AssaultPack_sgg","B_AssaultPack_sgg_ReconExp","B_AssaultPack_sgg_ReconLAT","B_AssaultPack_sgg_Spotter","B_AssaultPack_blk","B_AssaultPack_blk_DiverExp","B_AssaultPack_blk_DiverTL","B_AssaultPack_cbr","B_AssaultPack_mcamo","B_AssaultPack_mcamo_AA","B_AssaultPack_mcamo_AAR","B_AssaultPack_mcamo_Ammo","B_AssaultPack_ocamo","B_Kitbag_mcamo","B_Kitbag_mcamo_Eng","B_Kitbag_sgg","B_Kitbag_cbr","B_Bergen_mcamo","B_Bergen_mcamo_AAA","B_Bergen_dgtl","B_Bergen_dgtl_AAT","B_Bergen_dgtl_Exp","B_Bergen_khk","B_Bergen_khk_AAA","B_Bergen_khk_Eng","B_Bergen_rgr","B_Bergen_rgr_AAT","B_Bergen_sgg","B_Bergen_sgg_Exp","B_Bergen_blk","B_FieldPack_khk","B_FieldPack_blk","B_FieldPack_blk_DiverExp","B_FieldPack_blk_DiverTL","B_FieldPack_ocamo","B_FieldPack_ocamo_AA","B_FieldPack_ocamo_AAR","B_FieldPack_ocamo_Medic","B_FieldPack_ocamo_ReconMedic","B_FieldPack_oucamo","B_FieldPack_oucamo_AAR","B_FieldPack_oucamo_ReconExp","B_FieldPack_oucamo_Spotter","B_FieldPack_cbr","B_FieldPack_cbr_AAT","B_FieldPack_cbr_Ammo","B_FieldPack_cbr_AT","B_FieldPack_cbr_Repair","B_Carryall_ocamo","B_Carryall_ocamo_AAA","B_Carryall_ocamo_Eng","B_Carryall_oucamo","B_Carryall_oucamo_Exp","B_Carryall_khk","B_Carryall_cbr","B_Carryall_cbr_AAT","B_OutdoorPack_blk","B_OutdoorPack_tan","B_OutdoorPack_blu","B_HuntingBackpack","B_AssaultPackG","B_AssaultPackG_AAR","B_AssaultPackG_Eng","B_BergenG","B_BergenG_Medic","B_BergenC_red","B_BergenC_grn","B_BergenC_blu","Bag_Base","B_AssaultPack_Base","B_Kitbag_Base","B_Bergen_Base","B_FieldPack_Base","B_Carryall_Base","B_OutdoorPack_Base","B_BergenC_Base","B_Parachute"];
//--------------------------------------------------------------------------------------------------------\\
//Item-Weapons
ITEMWEAPONS = ["Binocular","RangeFinder","Laserdesignator","AGM_Vector"];
//--------------------------------------------------------------------------------------------------------\\
//INIDB STUFF
PlayerDBName = format ["%1_PlayerPD",missionName];
MissionDBName = format ["%1_PD",missionName];
VehicleDBName = format ["%1_VehiclePD",missionName];
MarkerDBName =  format ["%1_MarkerPD",missionName];
CrateDBName =   format ["%1_CratePD",missionName];
ObjDBName =   format ["%1_ObjectPD",missionName];
PlayerSTORE_VAR = format ["%1_STORAGE",missionName]; //For profileNamespace data storage
GET_SET_GEAR_VAR = if((count (profileNamespace getVariable [PlayerSTORE_VAR,[]])) > 0) then {true} else {false}; //For profileNamespace data storage
RESTORED_VEHICLE = [];
VEHICLE_COUNT = 0;
RESTORED_CRATE = [];	
CRATE_COUNT = 0;
RESTORED_OBJ = [];
OBJECT_COUNT = 0;
RESTORED_MARKERS = [];
NAME_TRANSFER = []; //used to track changes in names from one mission to the next.
VehicleSaveName = "Restored_Vehicle";
MkrSaveName = "Restored_MkR";
MissionDBSection = "MissionData";
CAMPAIGN_NAMEmkr = "Campaign_Name";
CAMPAIGN_DAYSmkr = "Campaign_Days";
CAMPAIGN_DAY = 0;  //Worked out from StartDate and date
CAMPAIGN_STARTDATE = [];//Pulled from DB
CM_LIVES = 0;
CM_LIVESmkr = "CM_LIVES_mkr";
CM_DEATHS = 0;
CM_DEATHSmkr = "CM_DEATHS_mkr";
CM_ACTIVEPLAYERS = 0;
CM_ACTIVEPLAYERSmkr = "CM_ACTIVEPLAYER_mkr";
DEATHS_HISTORY = 0;
DEATHS_HISTORYmkr = "TotalDeaths_mkr";
MISSION_HISTORY = 0;
MISSION_HISTORYmkr = "TotalMissions_mkr";
MISSION_SUCCESS_HISTORY = 0;
MISSION_SUCCESS_HISTORYmkr = "TotalMissionsSuccess_mkr";
Total_PDPlayers = 0;
MISSIONCOUNT_mkr = "CM_Count";
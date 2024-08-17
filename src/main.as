function f_SetMainfp(u_temp)
{
   _root.main.n_state = 0;
   _root.main.b_do_init = true;
   _root.main.fp_Main = u_temp;
}
function f_ChangeLevel(u_temp)
{
   LOGPush(2,_root.level);
   main.s_levelpath = u_temp;
   f_SetMainfp(f_LoadNewLevel);
}
function f_LoadNewLevel(zone)
{
   if(!GetFlashGlobal("g_bExitGame"))
   {
      switch(zone.n_state)
      {
         case 0:
            SetFlashGlobal("g_bNoPause",1);
            ShowLoadIcon();
            break;
         case 3:
         case 4:
            var loc2 = undefined;
            if(GetGameMode() != 3)
            {
               loc2 = 1;
               while(loc2 <= 4)
               {
                  f_SavePlayerInfoToHudForLevelChange(p_game["p" + int(loc2)]);
                  loc2 = loc2 + 1;
               }
            }
            loc2 = 1;
            while(loc2 <= 4)
            {
               _root.p_game["p" + int(loc2)].gotoAndStop("blank");
               loc2 = loc2 + 1;
            }
            _root.fader.f_JumpOut();
            f_ResetLevelVars();
            _root.f_UnloadLevelClips();
            break;
         case 5:
            _root.f_RemoveLevelClips();
            _root.f_SetLetterbox(true);
            break;
         case 6:
            console_version = false;
            if(console_version)
            {
               _root.loader.gotoAndStop("exit");
            }
            break;
         case 7:
            if(_root.loader.b_loaded)
            {
               _root.loader.b_loaded = false;
               unloadMovie(_root.loader);
               return undefined;
            }
            break;
         case 8:
            zone.b_do_init = false;
            loadMovie(_root.main.s_levelpath,_root.loader);
            break;
         case 10:
            zone.kills = 0;
            zone.portals_active = true;
            zone.kills_goal = 0;
            zone.leash_right_x = _loc0_ = 0;
            zone.leash_left_x = _loc0_;
            zone.leash_right_locked = _loc0_ = false;
            zone.leash_left_locked = _loc0_;
            if(_root.loader.b_loaded)
            {
               HideLoadIcon();
               f_SetMainfp(_root.loader.f_Init);
            }
            return undefined;
      }
      zone.n_state = int(zone.n_state + 1);
   }
}
function f_Null(zone)
{
   return undefined;
}
function f_FirstTimeInitOnce()
{
   if(GetGameMode() == 3)
   {
      var loc2 = 1;
      while(loc2 <= 4)
      {
         _root["player" + int(loc2) + "wins"] = 0;
         _root["player" + int(loc2) + "losses"] = 0;
         _root["player" + int(loc2) + "winner"] = 0;
         SetScores(loc2 - 1,0,0,0);
         loc2 = loc2 + 1;
      }
   }
   SetFlashGlobal("g_bExitGame",false);
   SetFlashGlobal("g_nPort1CharId",0);
   SetFlashGlobal("g_nPort2CharId",0);
   SetFlashGlobal("g_nPort3CharId",0);
   SetFlashGlobal("g_nPort4CharId",0);
   SetFlashGlobal("g_bStartedArena",0);
   SetFlashGlobal("g_bStartedQuaff",0);
   SetFlashGlobal("g_nArenaPoints",0);
   u_point = new Object();
   gravity = 3;
   g_dash_timer = 6;
   PI = 0.017453292519943295;
   players = 11;
   total_enemies = 0;
   total_towers = 0;
   total_animals = 0;
   total_horses = 0;
   total_chickens = 0;
   total_corpses = 0;
   total_fx = 0;
   extra_fx = 0;
   total_boss = 0;
   gore = GetGore();
   if(!console_version)
   {
      gore = true;
   }
   spawn_portal_num = 1;
   num_portals = 1;
   portal1 = new Object();
   portal2 = new Object();
   portal3 = new Object();
   portal4 = new Object();
   portal5 = new Object();
   portal6 = new Object();
   portal7 = new Object();
   portal8 = new Object();
   portal9 = new Object();
   DMG_MELEE = 0;
   DMG_POISON = 1;
   DMG_ELEC = 2;
   DMG_ICE = 3;
   DMG_FIRE = 4;
   DMG_OBJECT = 5;
   DMG_MAGIC = 6;
   DMGFLAG_NONE = 0;
   DMGFLAG_JUGGLE = 1;
   DMGFLAG_STUN = 2;
   DMGFLAG_NORESIST = 4;
   DMGFLAG_BLOODY = 8;
   DMGFLAG_NO_ELEM_EFFECT = 16;
   DMGFLAG_SPARKLE_EFFECT = 32;
   STUCK_THRESHOLD = 200;
   CHEATS = true;
   nowaypoints = false;
   ez_enemies = GetCheat(6);
   all_combos_unlocked = new Array(10);
   loc2 = 0;
   while(loc2 < 10)
   {
      all_combos_unlocked[loc2] = true;
      loc2 = loc2 + 1;
   }
   f_InitSaveSystem();
   f_InitCharColors();
   friendly_fire = false;
   f_FirstTimeInitPlayers();
   if(GetWidescreen() == false)
   {
      SCREEN_WIDTH = 640;
   }
   else
   {
      SCREEN_WIDTH = 848;
   }
   if(IsPalMode() == true)
   {
      SCREEN_HEIGHT = 576;
   }
   else
   {
      SCREEN_HEIGHT = 480;
   }
   HALF_SCREEN_WIDTH = SCREEN_WIDTH / 2;
   HALF_SCREEN_HEIGHT = SCREEN_HEIGHT / 2;
   ASPECT_RATIO = SCREEN_WIDTH / SCREEN_HEIGHT;
   GAME_WIDTH = 848;
   GAME_HEIGHT = 480;
   HALF_GAME_WIDTH = GAME_WIDTH / 2;
   HALF_GAME_HEIGHT = GAME_HEIGHT / 2;
   GAME_ASPECT_RATIO = GAME_WIDTH / GAME_HEIGHT;
   GAME_SCALE = SCREEN_WIDTH / GAME_WIDTH;
   GAME_X_OFFSET = 0;
   GAME_Y_OFFSET = 0;
   MAX_ZOOM = 80;
   EDGE_MARGIN = 40;
   DEFAULT_LEASH_WIDTH = GAME_WIDTH * 2;
   f_SetLetterbox(true);
   f_PositionHud();
   loadMovie("../sounds/sounds.swf",_root.sounds);
   _quality = "low";

   // Mod vars
   extraLoadTime = 3;

   f_ChangeLevel("../lobby/lobby.swf");
}
function f_SetLetterbox(letterbox)
{
   if(letterbox and (GetWidescreen() == false or IsPalMode()))
   {
      if(IsPalMode() and GetWidescreen())
      {
         var loc3 = 10;
      }
      else
      {
         loc3 = 25;
      }
      var loc1 = SCREEN_HEIGHT - (SCREEN_WIDTH + loc3) / GAME_ASPECT_RATIO;
      if(IsPalMode())
      {
         if(GetWidescreen() == true)
         {
            var loc2 = 0.5 * loc1;
         }
         else
         {
            loc2 = 0.6 * loc1;
         }
      }
      else
      {
         loc2 = 0.45 * loc1;
      }
      GAME_X_OFFSET = (- loc3) / 2;
      GAME_Y_OFFSET = loc2;
      GAME_SCALE = (SCREEN_WIDTH + loc3) / GAME_WIDTH;
      var loc4 = loc1 - loc2;
      letterbox_top.gotoAndStop(2);
      letterbox_top._x = -5;
      letterbox_top._y = loc2 - 200;
      letterbox_bot.gotoAndStop(2);
      letterbox_bot._x = -5;
      letterbox_bot._y = SCREEN_HEIGHT - (loc4 - 200);
      loader._x = GAME_X_OFFSET;
      loader._y = GAME_Y_OFFSET;
      loader._xscale = GAME_SCALE * 100;
      loader._yscale = GAME_SCALE * 100;
      cinema_letterbox._x = GAME_X_OFFSET;
      cinema_letterbox._y = GAME_Y_OFFSET;
      cinema_letterbox._xscale = GAME_SCALE * 100;
      cinema_letterbox._yscale = GAME_SCALE * 100;
   }
   else
   {
      GAME_Y_OFFSET = 0;
      GAME_X_OFFSET = 0;
      GAME_SCALE = 1;
      cinema_letterbox._x = GAME_X_OFFSET;
      cinema_letterbox._y = GAME_Y_OFFSET;
      cinema_letterbox._xscale = GAME_SCALE * 100;
      cinema_letterbox._yscale = GAME_SCALE * 100;
      letterbox_top.gotoAndStop(1);
      letterbox_bot.gotoAndStop(1);
      loader._x = 0;
      loader._y = 0;
      loader._xscale = 100;
      loader._yscale = 100;
      cinema_letterbox._x = 0;
      cinema_letterbox._y = 0;
      cinema_letterbox._xscale = 100;
      cinema_letterbox._yscale = 100;
   }
}
function f_ResetLevelVars()
{
   SetFlashGlobal("g_bMap",0);
   SetFlashGlobal("g_bMenu",0);
   if(_root.main)
   {
      _root.main.p_cinema_clip = undefined;
   }
   _root.cinema_letterbox.active = false;
   _root.go_arrow.gotoAndStop(1);
   current_depth_mod = 99;
   total_huds = 6;
   combo_count = 0;
   combo_timer = 0;
   current_shadow = 1;
   object_index = 0;
   static_index = 0;
   kills = 0;
   kills_goal = 0;
   stuck_timer = 0;
   healthmeter.gotoAndStop(1);
   boss_fight = false;
   f_ClearUnlockDisplay();
   f_CreatePickupArray();
   _root.fp_FunctionLine = undefined;
   _root.fp_FunctionLineProjectile = undefined;
   grass = new Object();
   grass_total = 0;
   shovelspots = new Object();
   shovelspots_total = 0;
   bombspots = new Object();
   bombspots_total = 0;
   secrets = new Object();
   secrets_total = 0;
   trees = new Object();
   trees_total = 0;
   exits = new Object();
   exits_total = 0;
   ladders = new Object();
   ladders_total = 0;
   ripoffs = new Object();
   ripoffs_total = 0;
   ride_rotation = 0;
   AutoRun = false;
   level_dust = "dust_brown";
   f_ResetHudGoldCounters();
   f_SetLetterbox(true);
}
function f_CreateSky(sky_type)
{
   _root.sky_type = sky_type;
   switch(sky_type)
   {
      case 1:
         loadMovie("../sky1/sky1.swf",loader.sky);
         break;
      case 2:
         loadMovie("../sky2/sky2.swf",loader.sky);
         break;
      case 3:
         loadMovie("../sky1/sky1.swf",loader.sky);
         break;
      case 4:
         loadMovie("../sky1/sky1.swf",loader.sky);
         break;
      case 5:
         loadMovie("../sky3/sky3.swf",loader.sky);
         break;
      case 6:
         loadMovie("../sky2/sky2.swf",loader.sky);
         break;
      case 7:
         loadMovie("../sky2/sky2.swf",loader.sky);
         break;
      case 8:
         loadMovie("../sky2/sky2.swf",loader.sky);
         break;
      case 9:
         loadMovie("../sky4/sky4.swf",loader.sky);
         break;
      case 10:
         loadMovie("../sky1/sky1.swf",loader.sky);
         break;
      case 11:
         loadMovie("../sky1/sky1.swf",loader.sky);
         break;
      case 12:
         loadMovie("../sky5/sky5.swf",loader.sky);
         break;
      case 13:
         loadMovie("../sky6/sky6.swf",loader.sky);
         break;
      case 14:
         loadMovie("../sky6/sky6.swf",loader.sky);
   }
}
function f_CreateFog(fog_type)
{
   _root.fog_type = fog_type;
   loadMovie("../fog/fog.swf",loader.fog);
}
function f_CreateFX(total_fx, extra_fx)
{
   current_fx = 1;
   _root.total_fx = total_fx;
   _root.extra_fx = extra_fx;
   extra_fx_current = total_fx + 1;
   var loc3 = 1;
   while(loc3 <= total_fx + extra_fx)
   {
      var loc4 = f_GetDepthModAssignment();
      var loc2 = p_game.attachMovie("invisObject","fx" + int(loc3),loc4);
      loadMovie("../fx/fx.swf",loc2);
      loc2.depth_mod = loc4;
      loc3 = loc3 + 1;
   }
}
function f_RemoveFX()
{
   var loc1 = 1;
   while(loc1 <= total_fx + extra_fx)
   {
      removeMovieClip(p_game["fx" + int(loc1)]);
      loc1 = loc1 + 1;
   }
   total_fx = 0;
   extra_fx = 0;
}
function f_CreateShadows(u_num)
{
   total_shadows = u_num;
   total_shadows = 60;
   var loc1 = 1;
   while(loc1 <= total_shadows)
   {
      var loc2 = loader.game.game.attachMovie("shadow","s" + int(loc1),loc1);
      loc2.gotoAndStop("off");
      loc2.active = false;
      loc1 = loc1 + 1;
   }
}
function f_initLoadedPlayerClip(zone)
{
   zone.x = 0;
   zone.y = 0;
   zone.body_y = 0;
   zone.active = false;
   zone.warp_timer = 0;
   zone.bsp_timer = 0;
   var loc2 = zone.getDepth();
   zone.depth_mod = loc2 % 1000;
   zone.gotoAndStop("blank");
}
function f_initLoadedFxClip(zone)
{
   var loc1 = zone.getDepth();
   zone.depth_mod = loc1 % 1000;
}
function f_initLoadedHorseClip(zone)
{
   zone.active = false;
   var loc1 = zone.getDepth();
   zone.depth_mod = loc1 % 1000;
}

// Loading boss swfs
function f_CreatePlayers()
{
   var loc2 = 1;
   while(loc2 <= players) // 11th player is reserved for undead groom NPC
   {
      var loc3 = f_GetDepthModAssignment();
      var loc1 = p_game.attachMovie("invisObject","p" + int(loc2),loc3);
      var filepath = "../player/player.swf";
      if(loc2 < 5) {
         var hud = _root["hud" + int(loc2)];
         if(hud.p_type == 32) {
            filepath = "../pbarboss/pbarboss.swf";
         }
         else if(hud.p_type == 33) {
            filepath = "../pcyclops/pcyclops.swf";
         }
         else if(hud.p_type == 34) {
            filepath = "../pbeetle/pbeetle.swf";
         }
      }
      loadMovie(filepath, loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc2++;
   }
}
function f_RemovePlayers()
{
   var loc1 = 1;
   while(loc1 <= players)
   {
      p_temp = p_game["p" + int(loc1)];
      if(p_temp)
      {
         removeMovieClip(p_temp);
      }
      loc1 = loc1 + 1;
   }
}
function f_CreateTowers(u_num)
{
   total_towers = u_num;
   var loc2 = 1;
   while(loc2 <= total_towers)
   {
      var loc3 = f_GetDepthModAssignment();
      var loc1 = p_game.attachMovie("invisObject","e_tower" + int(loc2),loc3);
      loadMovie("../etower/etower.swf",loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc2 = loc2 + 1;
   }
}
function f_RemoveTowers()
{
   var loc1 = 1;
   while(loc1 <= total_towers)
   {
      removeMovieClip(p_game["e_tower" + int(loc1)]);
      loc1 = loc1 + 1;
   }
   total_towers = 0;
}
function f_CreateAnimals(u_num)
{
   total_animals = u_num;
   var loc2 = 1;
   while(loc2 <= total_animals)
   {
      var loc3 = f_GetDepthModAssignment();
      var loc1 = p_game.attachMovie("invisObject","animal" + int(loc2),loc3);
      loadMovie("../animals/animals.swf",loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc2 = loc2 + 1;
   }
}
function f_RemoveAnimals()
{
   var loc1 = 1;
   while(loc1 <= total_animals)
   {
      removeMovieClip(p_game["animal" + int(loc1)]);
      loc1 = loc1 + 1;
   }
   total_animals = 0;
}
function f_CreateSlimes(u_num)
{
   total_slimes = u_num;
   var loc3 = 1;
   while(loc3 <= total_slimes)
   {
      var loc4 = _root.f_GetDepthModAssignment();
      var loc2 = p_game.attachMovie("invisObject","e_slime" + int(loc3),loc4);
      loadMovie("../eslime/eslime.swf",loc2);
      loc2.depth_mod = loc4;
      loc2.active = false;
      loc3 = loc3 + 1;
   }
}
function f_CreateImps(u_num)
{
   total_imps = u_num;
   var loc3 = 1;
   while(loc3 <= total_imps)
   {
      var loc4 = _root.f_GetDepthModAssignment();
      var loc2 = p_game.attachMovie("invisObject","e_imp" + int(loc3),loc4);
      loadMovie("../eimp/eimp.swf",loc2);
      loc2.depth_mod = loc4;
      loc2.active = false;
      loc3 = loc3 + 1;
   }
}
function f_CreateHorses(u_num)
{
   total_horses = u_num;
   var loc2 = 1;
   while(loc2 <= total_horses)
   {
      var loc3 = f_GetDepthModAssignment();
      var loc1 = p_game.attachMovie("invisObject","horse" + int(loc2),loc3);
      loadMovie("../horse/horse.swf",loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc2 = loc2 + 1;
   }
}
function f_CreateMount2(u_num)
{
   total_mount2 = u_num;
   var loc2 = 1;
   while(loc2 <= total_mount2)
   {
      var loc3 = f_GetDepthModAssignment();
      var loc1 = p_game.attachMovie("invisObject","mount2" + int(loc2),loc3);
      loadMovie("../mount2/mount2.swf",loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc2 = loc2 + 1;
   }
}
function f_CreateMount3(u_num)
{
   total_mount3 = u_num;
   var loc2 = 1;
   while(loc2 <= total_mount3)
   {
      var loc3 = f_GetDepthModAssignment();
      var loc1 = p_game.attachMovie("invisObject","mount3" + int(loc2),loc3);
      loadMovie("../mount3/mount3.swf",loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc2 = loc2 + 1;
   }
}
function f_CreateMount4(u_num)
{
   total_mount4 = u_num;
   var loc2 = 1;
   while(loc2 <= total_mount4)
   {
      var loc3 = f_GetDepthModAssignment();
      var loc1 = p_game.attachMovie("invisObject","mount4" + int(loc2),loc3);
      loadMovie("../mount4/mount4.swf",loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc2 = loc2 + 1;
   }
}
function f_RemoveMount2()
{
   var loc1 = 1;
   while(loc1 <= total_mount2)
   {
      removeMovieClip(p_game["mount2" + int(loc1)]);
      loc1 = loc1 + 1;
   }
   total_mount2 = 0;
}
function f_DestroyMount3()
{
   var loc1 = 1;
   while(loc1 <= total_mount3)
   {
      unloadMovie(p_game["mount3" + int(loc1)]);
      loc1 = loc1 + 1;
   }
}
function f_RemoveMount3()
{
   var loc1 = 1;
   while(loc1 <= total_mount3)
   {
      removeMovieClip(p_game["mount3" + int(loc1)]);
      loc1 = loc1 + 1;
   }
   total_mount3 = 0;
}
function f_DestroyMount4()
{
   var loc1 = 1;
   while(loc1 <= total_mount4)
   {
      unloadMovie(p_game["mount4" + int(loc1)]);
      loc1 = loc1 + 1;
   }
}
function f_RemoveMount4()
{
   var loc1 = 1;
   while(loc1 <= total_mount4)
   {
      removeMovieClip(p_game["mount4" + int(loc1)]);
      loc1 = loc1 + 1;
   }
   total_mount4 = 0;
}
function f_RemoveHorses()
{
   var loc1 = 1;
   while(loc1 <= total_horses)
   {
      removeMovieClip(p_game["horse" + int(loc1)]);
      loc1 = loc1 + 1;
   }
   total_horses = 0;
}
function f_CreateCorpses(u_num)
{
   total_corpses = u_num;
   var loc2 = 1;
   while(loc2 <= total_corpses)
   {
      var loc3 = f_GetDepthModAssignment();
      var loc1 = p_game.attachMovie("invisObject","corpse" + int(loc2),loc3);
      loadMovie("../player/player.swf",loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc2 = loc2 + 1;
   }
}
function f_RemoveCorpses()
{
   var loc1 = 1;
   while(loc1 <= total_corpses)
   {
      removeMovieClip(p_game["corpse" + int(loc1)]);
      loc1 = loc1 + 1;
   }
   total_corpses = 0;
}
function f_CreateChickens(u_num)
{
   total_chickens = u_num;
   var loc2 = 1;
   while(loc2 <= total_chickens)
   {
      var loc3 = f_GetDepthModAssignment();
      var loc1 = p_game.attachMovie("invisObject","chicken" + int(loc2),loc3);
      loadMovie("../chicken/chicken.swf",loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc2 = loc2 + 1;
   }
}
function f_RemoveChickens()
{
   var loc1 = 1;
   while(loc1 <= total_chickens)
   {
      removeMovieClip(p_game["chicken" + int(loc1)]);
      loc1 = loc1 + 1;
   }
   total_chickens = 0;
}
function f_CreateEnemies(u_num)
{
   total_enemies = u_num;
   var loc1 = 1;
   while(loc1 <= total_enemies)
   {
      var loc3 = f_GetDepthModAssignment();
      var loc2 = p_game.attachMovie("invisObject","e_human" + int(loc1),loc3);
      loadMovie("../player/player.swf",loc2);
      loc2.depth_mod = loc3;
      loc2.active = false;
      loc1 = loc1 + 1;
   }
   loc1 = 1;
   while(loc1 <= total_enemies)
   {
      loc3 = f_GetDepthModAssignment();
      loc2 = p_game.attachMovie("invisObject","e_bodyparts" + int(loc1),loc3);
      loadMovie("../player/player.swf",loc2);
      loc2.depth_mod = loc3;
      loc2.active = false;
      loc1 = loc1 + 1;
   }
}
function f_RemoveEnemies()
{
   var loc1 = 1;
   while(loc1 <= total_enemies)
   {
      removeMovieClip(p_game["e_human" + int(loc1)]);
      removeMovieClip(p_game["e_bodyparts" + int(loc1)]);
      loc1 = loc1 + 1;
   }
   total_enemies = 0;
}
function f_AddStatic(zone)
{
   static_index++;
   loader.game.game["static" + int(static_index)] = zone;
   zone.x = zone._x;
   zone.y = zone._y;
   var loc3 = Math.abs(u_object._xscale) / 100;
   var loc2 = Math.abs(u_object._yscale) / 100;
   zone.zone.x = zone.x + zone.zone._x;
   zone.zone.y = zone.y + zone.zone._y + 2;
   zone.zone.h = zone.zone._height * loc2;
   zone.zone.w = zone.zone._width / 2 * loc3;
   zone.zone.top = zone.zone.y - zone.zone.h;
   zone.zone.left = zone.zone.x - zone.zone.w;
   zone.zone.right = zone.zone.x + zone.zone.w;
}
function f_UpdateObject(zone)
{
   zone.x = zone._x;
   zone.y = zone._y;
   zone.body_y = 0;
   var loc2 = Math.abs(zone._xscale) / 100;
   var loc3 = Math.abs(zone._yscale) / 100;
   zone.w = zone._width / 2 * loc2;
   zone.h = zone._height * loc3;
   if(zone._xscale > 0)
   {
      zone.zone.x = zone.x + zone.zone._x * loc2;
   }
   else
   {
      zone.zone.x = zone.x - zone.zone._x * loc2;
   }
   zone.zone.y = zone.y + zone.zone._y * loc3 + 2;
   zone.zone.h = zone.zone._height / 2 * loc3;
   if(zone.zone.h < 5)
   {
      zone.zone.h = 5;
   }
   zone.zone.w = zone.zone._width / 2 * loc2;
   zone.zone.top = zone.zone.y - zone.zone.h;
   if(zone.n_height)
   {
      zone.zone.top = zone.zone.y - zone.n_height;
   }
   zone.zone.left = zone.zone.x - zone.zone.w;
   zone.zone.right = zone.zone.x + zone.zone.w;
   zone.zone.bottom = zone.zone.y + zone.zone.h;
   zone.hitzone.x = zone.x + zone.hitzone._x * loc2;
   zone.hitzone.y = zone.y + zone.hitzone._y * loc3;
   zone.hitzone.w = zone.hitzone._width / 2 * loc2;
   zone.hitzone.h = zone.hitzone._height / 2 * loc3;
   zone.hitzone.left = zone.hitzone.x - zone.hitzone.w;
   zone.hitzone.right = zone.hitzone.x + zone.hitzone.w;
}
function f_AddObject(zone, nodepth)
{
   if(object_index < 0)
   {
      object_index = 0;
   }
   object_index++;
   loader.game.game["object" + int(object_index)] = zone;
   f_UpdateObject(zone);
   if(!nodepth)
   {
      zone.depth_mod = f_GetDepthModAssignment(zone);
      zone.depth_y = zone.y;
      f_Depth(zone,zone.y);
   }
   zone.active = true;
}
function f_AddNeutral(zone)
{
   zone.depth_mod = f_GetDepthModAssignment(zone);
   zone.x = zone._x;
   zone.y = zone._y;
   zone.w = zone._width / 2;
   zone.h = zone._height;
   zone.depth_y = zone.y;
   f_Depth(zone,zone.y);
}
function f_SetDiagonal(zone)
{
   var loc3 = Math.abs(zone._xscale) / 100;
   var loc2 = Math.abs(zone._yscale) / 100;
   var loc4 = zone._x + zone.zone._x;
   var loc5 = zone._y + zone.zone._y;
   var loc6 = zone.zone._height * loc2;
   var loc7 = zone.zone._width / 2 * loc3;
   zone.diagonal = true;
   zone.left_x = zone.left._x * loc3;
   zone.right_x = zone.right._x * loc3;
   zone.left_y = zone.left._y * loc2;
   zone.right_y = zone.right._y * loc2;
   zone.h = Math.abs(zone.left_y - zone.right_y);
   zone.h2 = zone.zone2._height;
   zone.w2 = zone.zone2._width;
   zone.x1 = loc4 + zone.left_x;
   zone.x2 = loc4 + zone.right_x;
   zone.w = Math.abs(zone.x1 - zone.x2);
}
function f_RegisterGrass(zone)
{
   grass_total++;
   f_AddNeutral(zone);
   grass["g" + int(grass_total)] = zone;
   zone.cut = false;
   zone.x = zone._x;
   zone.y = zone._y;
}
function f_RegisterShovelSpot(zone)
{
   shovelspots_total++;
   shovelspots["s" + int(shovelspots_total)] = zone;
   zone.dug = false;
   zone.x = zone._x;
   zone.y = zone._y;
}
function f_RegisterBombSpot(zone)
{
   bombspots_total++;
   bombspots["s" + int(bombspots_total)] = zone;
   zone.bomb_pt_x = zone._x + zone.bomb_pt._x;
   zone.bomb_pt_y = zone._y + zone.bomb_pt._y;
   zone.bomb_pt_w = zone.bomb_pt._width / 2;
}
function f_RegisterSecret(zone)
{
   secrets_total++;
   secrets["s" + int(secrets_total)] = zone;
   zone.dug = false;
   zone.x = zone._x;
   zone.y = zone._y;
}
function f_RegisterTree(zone)
{
   trees_total++;
   trees["s" + int(trees_total)] = zone;
   zone.dug = false;
   zone.x = zone._x;
   zone.y = zone._y;
}
function f_RegisterExit(zone)
{
   exits_total++;
   exits["s" + int(exits_total)] = zone;
   zone.dug = false;
   zone.x = zone._x;
   zone.y = zone._y;
   zone.w = zone._width / 2;
   zone.h = zone._height / 2;
}
function f_RegisterLadder(zone)
{
   ladders_total++;
   ladders["s" + int(ladders_total)] = zone;
   zone.x = zone._x;
   zone.y = zone._y;
   zone.w = zone._width / 2;
   zone.h = zone._height / 2;
}
function f_RegisterRipoff(zone)
{
   ripoffs_total++;
   ripoffs["s" + int(ripoffs_total)] = zone;
   zone.active = true;
   if(zone._xscale > 0)
   {
      zone.ripoff.x = zone._x + zone.ripoff._x;
   }
   else
   {
      zone.ripoff.x = zone._x - zone.ripoff._x;
   }
   zone.ripoff.y = zone._y + zone.ripoff._y;
   zone.ripoff.w = zone.ripoff._width / 2;
   zone.ripoff.h = zone.ripoff._height / 2;
}
function f_UnloadPreloadedClips()
{
   unloadMovie(_root.fx);
   unloadMovie(_root.player);
   unloadMovie(_root.animals);
   unloadMovie(_root.sky);
   unloadMovie(_root.fog);
   unloadMovie(_root.sounds);
}
function f_UnloadLevelClips()
{
   _root.loader.f_UnloadSpecificClips();
   if(_root.loader.sky)
   {
      unloadMovie(_root.loader.sky);
   }
   if(_root.loader.fog)
   {
      unloadMovie(_root.loader.fog);
   }
   f_UnloadClips("fx",total_fx + extra_fx);
   f_UnloadClips("chicken",total_chickens);
   f_UnloadClips("horse",total_horses);
   f_UnloadClips("animal",total_animals);
   f_UnloadClips("mount2",total_mount2);
   f_UnloadClips("mount3",total_mount3);
   f_UnloadClips("mount4",total_mount4);
   f_UnloadClips("p",players);
   f_UnloadClips("e_human",total_enemies);
   f_UnloadClips("e_bodyparts",total_enemies);
   f_UnloadClips("corpse",total_corpses);
   f_UnloadClips("e_tower",total_towers);
   f_UnloadClips("e_trollx",total_bigtrolls);
   f_UnloadClips("e_troll",total_bigtroll);
   f_UnloadClips("e_slime",total_slimes);
   f_UnloadClips("e_imp",total_imps);
   f_UnloadClips("e_bee",total_bees);
   f_UnloadClips("e_fish",total_fish);
   f_UnloadClips("e_bat",total_bats);
   f_UnloadClips("e_scorpion",total_scorpions);
   f_UnloadClips("ufo",total_ufo);
   f_UnloadClips("ufodust",total_ufo);
   f_UnloadClips("e_beetle",total_beetles);
}
function f_UnloadClips(clipname, total)
{
   var loc2 = undefined;
   var loc1 = 1;
   while(loc1 <= total)
   {
      loc2 = p_game[clipname + int(loc1)];
      if(loc2)
      {
         unloadMovie(loc2);
      }
      loc1 = loc1 + 1;
   }
}
function f_RemoveLevelClips()
{
   _root.loader.f_RemoveSpecificClips();
   _root.f_RemoveFX();
   _root.f_RemoveCorpses();
   _root.f_RemoveChickens();
   _root.f_RemoveHorses();
   _root.f_RemoveAnimals();
   _root.f_RemoveTowers();
   _root.f_RemoveEnemies();
   _root.f_RemovePlayers();
   _root.f_RemoveMount2();
}
function f_InitCamera(zone)
{
   zone.scale = 100;
   zone.scale_goal = 100;
   zone.scale_mod = 1;
   zone.speed = 1;
   zone.camera_x = undefined;
   zone.camera_y = undefined;
   zone.camera_oldx = undefined;
   zone.camera_oldy = undefined;
   zone.camera_x_goal = undefined;
   zone.camera_y_goal = undefined;
   zone.last_good_player_x = undefined;
   zone.last_good_player_y = undefined;
   zone.last_good_player_groundtype = 0;
   console_version = false;
   zone.focus_things = new Array(5);
   zone.player_move = 0;
   zone.player_x_old = undefined;
   zone.leash_left_x = 0;
   zone.leash_left_y = 0;
   zone.leash_left_locked = false;
   zone.leash_right_locked = false;
   zone.cam_catchup = false;
   zone.cam_catchup_speed = 0;
   zone.leash_right_x = 0;
   zone.leash_right_y = 0;
   zone.rot = 0;
   zone.top = - GAME_HEIGHT;
   zone.bottom = 0;
   zone.left = - HALF_GAME_WIDTH;
   zone.right = HALF_GAME_WIDTH;
   zone.safe_screen_size = EDGE_MARGIN;
   var loc2 = 0;
   zone.safe_screen_size += loc2;
   zone.forced_zoom = false;
   zone.p_cinema_clip = undefined;
   zone.waypoint = 0;
   zone.newwaypoint = 0;
   zone.lastwaypoint = 0;
   zone.n_bottomplayer = 0;
   zone.n_topplayer = 0;
   if(level != 40)
   {
      loader.bg0_c._x = HALF_GAME_WIDTH;
   }
   loader.game._x = HALF_GAME_WIDTH;
   loader.bg1_c._x = HALF_GAME_WIDTH;
   loader.bg2_c._x = HALF_GAME_WIDTH;
   loader.bg3_c._x = HALF_GAME_WIDTH;
   loader.bg4_c._x = HALF_GAME_WIDTH;
   loader.bg0_c._y = GAME_HEIGHT;
   loader.game._y = GAME_HEIGHT;
   loader.bg1_c._y = GAME_HEIGHT;
   loader.bg2_c._y = GAME_HEIGHT;
   loader.bg3_c._y = GAME_HEIGHT;
   loader.bg4_c._y = GAME_HEIGHT;
   zone.shake = 0;
   zone.shake_intensity = 0;
   zone.a_shake = new Array(31);
   zone.a_shake[0] = 0;
   zone.a_shake[1] = 0;
   zone.a_shake[2] = 1;
   zone.a_shake[3] = -1;
   zone.a_shake[4] = 2;
   zone.a_shake[5] = -2;
   zone.a_shake[6] = 2;
   zone.a_shake[7] = -3;
   zone.a_shake[8] = 2;
   zone.a_shake[9] = -3;
   zone.a_shake[10] = 2;
   zone.a_shake[11] = -3;
   zone.a_shake[12] = 3;
   zone.a_shake[13] = -4;
   zone.a_shake[14] = 3;
   zone.a_shake[15] = -4;
   zone.a_shake[16] = 4;
   zone.a_shake[17] = -3;
   zone.a_shake[18] = 4;
   zone.a_shake[19] = -4;
   zone.a_shake[20] = 4;
   zone.a_shake[21] = -4;
   zone.a_shake[22] = 5;
   zone.a_shake[23] = -4;
   zone.a_shake[24] = 4;
   zone.a_shake[25] = -5;
   zone.a_shake[26] = 4;
   zone.a_shake[27] = -5;
   zone.a_shake[28] = 5;
   zone.a_shake[29] = -5;
   zone.a_shake[30] = 5;
}
function f_ResetCamera(zone)
{
   zone.speed = 1;
   zone.waypoint = 0;
   zone.newwaypoint = 0;
   zone.lastwaypoint = 0;
   zone.rot = 0;
   zone.scale = 100;
   rotrad = Math.abs(zone.rot * 0.01745316666666667);
   zone.bumpup = 0;
   f_GetCameraCoords(zone);
   zone.camera_x = zone.camera_x_goal;
   zone.camera_y = zone.camera_y_goal;
   zone.camera_oldx = zone.camera_x_goal;
   zone.camera_oldy = zone.camera_y_goal;
   zone.scale = zone.scale_goal;
   compensated_camera_y = zone.camera_y - 100;
   if(compensated_camera_y < zone.bumpup)
   {
      compensated_camera_y = zone.bumpup;
   }
   if(zone.scale > 100)
   {
      zone.scale = 100;
   }
   else if(zone.scale < MAX_ZOOM)
   {
      zone.scale = MAX_ZOOM;
   }
   zone.scale_mod = 100 / zone.scale;
   zone.top = - (compensated_camera_y + GAME_HEIGHT * zone.scale_mod);
   zone.bottom = - compensated_camera_y;
   zone.right = - (zone.camera_x - HALF_GAME_WIDTH * zone.scale_mod);
   zone.left = - (zone.camera_x + HALF_GAME_WIDTH * zone.scale_mod);
   var loc3 = p_game.edge1;
   var loc2 = 0;
   if(loc3.active)
   {
      loc2 = loc3._y - zone.bottom;
      if(loc2 < 0)
      {
         zone.camera_y -= loc2;
         zone.camera_oldy = zone.camera_y;
         zone.camera_y_goal -= loc2;
         compensated_camera_y -= loc2;
         zone.top = - (compensated_camera_y + GAME_HEIGHT * zone.scale_mod);
         zone.bottom = - compensated_camera_y;
      }
   }
   loc3 = p_game.edge2;
   if(loc3.active)
   {
      loc2 = zone.left - loc3._x;
      if(loc2 < 0)
      {
         zone.camera_x += loc2;
         zone.camera_oldx = zone.camera_x;
         zone.camera_x_goal += loc2;
         zone.right = - (zone.camera_x - HALF_GAME_WIDTH * zone.scale_mod);
         zone.left = - (zone.camera_x + HALF_GAME_WIDTH * zone.scale_mod);
      }
   }
   loc3 = p_game.edge3;
   if(loc3.active)
   {
      loc2 = loc3._x - zone.right;
      if(loc2 < 0)
      {
         zone.camera_x -= loc2;
         zone.camera_oldx = zone.camera_x;
         zone.camera_x_goal -= loc2;
         zone.right = - (zone.camera_x - HALF_GAME_WIDTH * zone.scale_mod);
         zone.left = - (zone.camera_x + HALF_GAME_WIDTH * zone.scale_mod);
      }
   }
   var loc5 = 100 / MAX_ZOOM;
   var loc4 = compensated_camera_y - (zone.scale - MAX_ZOOM) / 100 * HALF_GAME_HEIGHT;
   if(loc4 < zone.bumpup)
   {
      loc4 = zone.bumpup;
   }
   zone.max_top = - (loc4 + GAME_HEIGHT * loc5);
   zone.max_bottom = - loc4;
   zone.max_right = - (zone.camera_x - HALF_GAME_WIDTH * loc5);
   zone.max_left = - (zone.camera_x + HALF_GAME_WIDTH * loc5);
   if(level != 40)
   {
      loader.bg0_c._xscale = zone.scale * 1.5 - 50;
   }
   loader.bg0_c._yscale = zone.scale * 1.5 - 50;
   loader.game._xscale = zone.scale;
   loader.game._yscale = zone.scale;
   loader.bg1_c._xscale = zone.scale * 0.5 + 50;
   loader.bg1_c._yscale = zone.scale * 0.5 + 50;
   loader.bg2_c._xscale = zone.scale * 0.25 + 75;
   loader.bg2_c._yscale = zone.scale * 0.25 + 75;
   loader.bg3_c._xscale = zone.scale * 0.1 + 90;
   loader.bg3_c._yscale = zone.scale * 0.1 + 90;
   if(level != 40)
   {
      loader.bg0_c._rotation = zone.rot;
   }
   loader.game._rotation = zone.rot;
   loader.bg1_c._rotation = zone.rot;
   loader.bg2_c._rotation = zone.rot;
   loader.bg3_c._rotation = zone.rot;
   if(ride_rotation)
   {
      loader.game._rotation = ride_rotation;
   }
   if(level != 40)
   {
      loader.bg0_c.bg0._x = zone.camera_x * 1.5;
   }
   loader.game.game._x = zone.camera_x;
   loader.bg1_c.bg1._x = zone.camera_x * 0.5;
   loader.bg2_c.bg2._x = zone.camera_x * 0.25;
   loader.bg3_c.bg3._x = zone.camera_x * 0.1;
   loader.bg0_c.bg0._y = compensated_camera_y * 1.5;
   loader.game.game._y = compensated_camera_y;
   loader.bg1_c.bg1._y = compensated_camera_y * 0.5;
   loader.bg2_c.bg2._y = compensated_camera_y * 0.25;
   loader.bg3_c.bg3._y = compensated_camera_y * 0.1;
   game_x = loader.game.game._x + loader.game._x;
   game_y = loader.game.game._y + loader.game._y;
   scaled_screen_width = GAME_WIDTH * (100 / zone.scale);
   f_HiFps_CameraReset();
}
function f_SZ_OnScreen(x, y, h)
{
   if(y > main.bottom + 30)
   {
      return false;
   }
   if(y + h < main.top)
   {
      return false;
   }
   if(x < main.left)
   {
      return false;
   }
   if(x > main.right)
   {
      return false;
   }
   return true;
}
function f_SZ_OnScreenMax(zone)
{
   if(zone._y > main.max_bottom)
   {
      return false;
   }
   if(zone._y + zone.n_height < main.max_top)
   {
      return false;
   }
   if(zone._x + zone.n_width / 2 < main.max_left)
   {
      return false;
   }
   if(zone._x - zone.n_width / 2 > main.max_right)
   {
      return false;
   }
   return true;
}
function f_SZ_PlayerWithinSafeScreen(zone, speed)
{
   if(zone.x + speed < main.left + main.safe_screen_size * main.scale_mod)
   {
      return false;
   }
   if(zone.x + speed > main.right - main.safe_screen_size * main.scale_mod)
   {
      return false;
   }
   return true;
}
function f_SZ_PlayerXOnScreenMax(x)
{
   if(x < main.max_left + main.safe_screen_size * 100 / MAX_ZOOM)
   {
      return false;
   }
   if(x > main.max_right - main.safe_screen_size * 100 / MAX_ZOOM)
   {
      return false;
   }
   return true;
}
function f_SZ_PlayerYOnScreenMax(y)
{
   if(y + 10 > main.max_bottom)
   {
      return false;
   }
   if(y - 100 < main.max_top)
   {
      return false;
   }
   return true;
}
function f_SZ_PlayerYDiffMax(zone, speed)
{
   if(speed > 0)
   {
      var loc1 = playerArrayOb["p_pt" + int(main.n_bottomplayer)];
      if(zone == loc1)
      {
         var loc2 = playerArrayOb["p_pt" + int(main.n_topplayer)];
         if(loc1 != loc2)
         {
            var loc4 = loc2.y;
            var loc3 = loc1.y;
            if(!loc2.onscreen)
            {
               if(loc2.onscreenbody)
               {
                  loc4 += loc2.body_y;
               }
            }
            if(!loc1.onscreen)
            {
               if(loc1.onscreenbody)
               {
                  loc3 += loc1.body_y;
               }
            }
            var loc5 = loc3 - loc4;
            if(loc5 > 390)
            {
               return false;
            }
         }
      }
   }
   return true;
}
function f_ScreenShake(intensity, timer, zone)
{
   if(timer < 0)
   {
      timer = 0;
   }
   if(timer > 30)
   {
      timer = 30;
   }
   if(intensity > _root.main.shake_intensity)
   {
      _root.main.shake_intensity = intensity;
   }
   if(timer > _root.main.shake)
   {
      _root.main.shake = timer;
   }
   if(intensity < 0.2)
   {
      var loc5 = 1;
   }
   else if(intensity < 0.3)
   {
      loc5 = 2;
   }
   else
   {
      loc5 = 3;
   }
   if(zone)
   {
      if(zone.port)
      {
         VibrateController(zone.port - 1,loc5,timer / 30);
      }
   }
   else
   {
      var loc2 = 1;
      while(loc2 <= active_players)
      {
         var loc3 = playerArrayOb["p_pt" + int(loc2)];
         if(loc3.alive)
         {
            VibrateController(loc3.hud_pt.port - 1,loc5,timer / 30);
         }
         loc2 = loc2 + 1;
      }
   }
}
function f_StopScreenShake()
{
   _root.main.shake_intensity = 0;
   _root.main.shake = 0;
}
function f_UpdateCamera(zone)
{
   f_UpdateScrollZoom(zone);
   if(zone.shake > 0)
   {
      zone.shake = zone.shake - 1;
      zone.rot = zone.a_shake[zone.shake] * (zone.scale / 100) * zone.shake_intensity;
      if(zone.resetShakeAfterDone && zone.shake == 0) {
         zone.resetShakeAfterDone = false;
         f_StopScreenShake();
      }
   }
}
function f_SetCinematicCamera(zone, letterbox)
{
   _root.main.p_cinema_clip = zone;
   _root.main.hifps_camera_reset = true;
   if(letterbox == undefined)
   {
      letterbox = true;
   }
   if(letterbox and zone)
   {
      _root.cinema_letterbox.active = true;
   }
   else
   {
      _root.cinema_letterbox.active = false;
   }
}
function f_SetLeash(x1, y1, x2, y2)
{
   if(!x1)
   {
      _root.main.leash_right_x = 0;
      _root.main.leash_left_x = 0;
      _root.main.cam_catchup = true;
      _root.main.player_x_old = undefined;
      _root.main.cam_catchup_speed = 0.1;
      _root.main.portals_active = true;
      return undefined;
   }
   if(x2 == undefined)
   {
      x1 += DEFAULT_LEASH_WIDTH / 2;
      x2 = x1 - DEFAULT_LEASH_WIDTH;
      y2 = y1;
   }
   else
   {
      if(x1 < x2)
      {
         var loc4 = x1;
         x1 = x2;
         x2 = loc4;
         loc4 = y1;
         y1 = y2;
         y2 = loc4;
      }
      if(x1 - x2 < GAME_WIDTH)
      {
         x2 = x1 - GAME_WIDTH;
      }
   }
   if(_root.main.right > x1)
   {
      x1 = _root.main.right + 1;
   }
   _root.main.portals_active = false;
   _root.main.cam_cathcup = false;
   _root.main.leash_right_locked = false;
   _root.main.leash_right_x = x1;
   _root.main.leash_right_y = y1;
   _root.main.leash_left_locked = false;
   _root.main.leash_left_x = x2;
   _root.main.leash_left_y = y2;
}
function f_StuckEnemyCheck()
{
   var loc5 = 0;
   if(_root.main.leash_left_x != 0 and _root.main.leash_left_x != undefined)
   {
      var loc4 = true;
      var loc3 = 1;
      while(loc3 <= active_enemies)
      {
         var loc2 = enemyArrayOb["e" + int(loc3)];
         if(loc2.alive)
         {
            if(!(loc2.x < _root.main.leash_left_x or loc2.x > _root.main.leash_right_x))
            {
               loc4 = false;
            }
         }
         loc3 = loc3 + 1;
      }
      if(active_enemies >= 1 && loc4 == true)
      {
         _root.stuck_timer = _root.stuck_timer + 1;
         if(_root.stuck_timer >= STUCK_THRESHOLD)
         {
            loc3 = 1;
            while(loc3 <= active_enemies)
            {
               loc2 = enemyArrayOb["e" + int(loc3)];
               if(loc2.alive)
               {
                  loc2.health = 0;
                  loc2.gotoAndStop("hitground1");
                  _root.kills = _root.kills + 1;
               }
               loc3 = loc3 + 1;
            }
            _root.stuck_timer = 0;
         }
      }
      else
      {
         _root.stuck_timer = 0;
      }
   }
   else
   {
      _root.stuck_timer = 0;
   }
}
function f_UpdateScrollZoom(zone)
{
   var loc15 = Math.abs(zone.rot * 0.01745316666666667);
   var loc12 = zone.camera_x_goal;
   f_GetCameraCoords(zone);
   var loc6 = (zone.scale_goal - zone.scale) / 5;
   if(loc6 > 2)
   {
      loc6 = 2;
   }
   else if(loc6 < -3)
   {
      loc6 = -3;
   }
   if(Math.abs(loc6) > 0.01)
   {
      zone.scale += loc6;
   }
   else
   {
      zone.scale = zone.scale_goal;
   }
   zone.scale_mod = 100 / zone.scale;
   scaled_screen_width = GAME_WIDTH * zone.scale_mod;
   var loc14 = 20;
   if(p_game.edge1.active)
   {
      loc14 = p_game.edge1._y;
   }
   zone.bumpup = 0;
   var loc11 = (GAME_WIDTH - scaled_screen_width) / 2;
   var loc10 = - (zone.leash_left_x - loc11 + HALF_GAME_WIDTH);
   var loc8 = - (zone.leash_right_x + loc11 - HALF_GAME_WIDTH);
   if(zone.leash_left_x)
   {
      if(!zone.leash_left_locked)
      {
         if(zone.camera_x <= loc10)
         {
            zone.leash_left_locked = true;
         }
      }
      if(zone.leash_left_locked && zone.camera_x_goal > loc10)
      {
         zone.camera_x_goal = loc10;
      }
   }
   if(zone.leash_right_x)
   {
      if(!zone.leash_right_locked)
      {
         if(zone.camera_x >= loc8)
         {
            zone.leash_right_locked = true;
         }
      }
      if(zone.leash_right_locked && zone.camera_x_goal < loc8)
      {
         zone.camera_x_goal = loc8;
      }
   }
   if(!zone.p_cinema_clip)
   {
      if(zone.camera_x_goal == undefined)
      {
         zone.camera_x_goal = zone.camera_x;
      }
      if(zone.camera_y_goal == undefined)
      {
         zone.camera_y_goal = zone.camera_y;
      }
      if(p_game.edge1.active and zone.camera_y_goal < 100 - p_game.edge1._y)
      {
         zone.camera_y_goal = 100 - p_game.edge1._y;
      }
      var loc3 = zone.camera_x_goal - zone.camera_x;
      var loc2 = zone.camera_y_goal - zone.camera_y;
      if(zone.cam_catchup)
      {
         if(Math.abs(zone.camera_x_goal - zone.camera_x) < 5)
         {
            zone.cam_catchup = false;
         }
         if(zone.cam_catchup_speed >= 0.6)
         {
            zone.cam_catchup = false;
         }
         else if(zone.player_move)
         {
            if(zone.player_move * (zone.camera_x_goal - zone.camera_x) < 0)
            {
               zone.camera_x_goal = zone.camera_x + loc3 * zone.cam_catchup_speed;
               zone.camera_y_goal = zone.camera_y + loc2 * zone.cam_catchup_speed;
               zone.cam_catchup_speed += 0.02;
            }
            else
            {
               zone.camera_x_goal = loc12;
            }
         }
         else
         {
            zone.camera_x_goal = loc12;
         }
         loc3 = zone.camera_x_goal - zone.camera_x;
         loc2 = zone.camera_y_goal - zone.camera_y;
      }
      var loc5 = Math.sqrt(loc3 * loc3 + loc2 * loc2);
      if(loc5 < 20)
      {
         loc5 = 20;
      }
      if(loc5 < 32)
      {
         loc3 *= 0.5;
         loc2 *= 0.5;
         zone.speed = loc5 * 0.75;
      }
      else
      {
         loc3 /= loc5;
         loc2 /= loc5;
         loc3 *= zone.speed;
         loc2 *= zone.speed;
         if(zone.speed < loc5 * 0.35)
         {
            zone.speed *= 1.1;
         }
         else
         {
            zone.speed *= 0.9;
         }
      }
      zone.camera_x += loc3;
      zone.camera_y += loc2;
      if(!nowaypoints)
      {
         zone.newwaypoint = f_GetClosestWaypoint(- zone.camera_x);
      }
   }
   compensated_camera_y = zone.camera_y - 100;
   zone.top = - (compensated_camera_y + GAME_HEIGHT * zone.scale_mod);
   zone.bottom = - compensated_camera_y;
   zone.right = - (zone.camera_x - HALF_GAME_WIDTH * zone.scale_mod);
   zone.left = - (zone.camera_x + HALF_GAME_WIDTH * zone.scale_mod);
   var loc4 = p_game.edge1;
   if(loc4.active)
   {
      var loc13 = loc4._y - zone.bottom;
      if(loc13 < 0)
      {
         zone.camera_y -= loc13;
         compensated_camera_y -= loc13;
         zone.top = - (compensated_camera_y + GAME_HEIGHT * zone.scale_mod);
         zone.bottom = - compensated_camera_y;
      }
   }
   loc4 = p_game.edge2;
   if(loc4.active)
   {
      loc13 = zone.left - loc4._x;
      if(loc13 < 0)
      {
         zone.camera_x += loc13;
         zone.right = - (zone.camera_x - HALF_GAME_WIDTH * zone.scale_mod);
         zone.left = - (zone.camera_x + HALF_GAME_WIDTH * zone.scale_mod);
      }
   }
   loc4 = p_game.edge3;
   if(loc4.active)
   {
      loc13 = loc4._x - zone.right;
      if(loc13 < 0)
      {
         zone.camera_x -= loc13;
         zone.right = - (zone.camera_x - HALF_GAME_WIDTH * zone.scale_mod);
         zone.left = - (zone.camera_x + HALF_GAME_WIDTH * zone.scale_mod);
      }
   }
   var loc9 = 100 / MAX_ZOOM;
   var loc7 = compensated_camera_y - (zone.scale - MAX_ZOOM) / 100 * HALF_GAME_HEIGHT;
   if(loc7 < zone.bumpup)
   {
      loc7 = zone.bumpup;
   }
   zone.max_top = - (loc7 + GAME_HEIGHT * loc9);
   zone.max_bottom = - loc7;
   zone.max_right = - (zone.camera_x - HALF_GAME_WIDTH * loc9);
   zone.max_left = - (zone.camera_x + HALF_GAME_WIDTH * loc9);
   if(zone.leash_left_x)
   {
      zone.max_left = Math.max(zone.leash_left_x + zone.safe_screen_size,zone.max_left);
   }
   if(zone.leash_right_x)
   {
      zone.max_right = Math.min(zone.leash_right_x - zone.safe_screen_size,zone.max_right);
   }
   if(level != 40)
   {
      loader.bg0_c._xscale = zone.scale * 1.5 - 50;
   }
   loader.bg0_c._yscale = zone.scale * 1.5 - 50;
   loader.game._xscale = zone.scale;
   loader.game._yscale = zone.scale;
   loader.bg1_c._xscale = zone.scale * 0.5 + 50;
   loader.bg1_c._yscale = zone.scale * 0.5 + 50;
   loader.bg2_c._xscale = zone.scale * 0.25 + 75;
   loader.bg2_c._yscale = zone.scale * 0.25 + 75;
   loader.bg3_c._xscale = zone.scale * 0.1 + 90;
   loader.bg3_c._yscale = zone.scale * 0.1 + 90;
   if(level != 40)
   {
      loader.bg0_c._rotation = zone.rot;
   }
   loader.game._rotation = zone.rot;
   loader.bg1_c._rotation = zone.rot;
   loader.bg2_c._rotation = zone.rot;
   loader.bg3_c._rotation = zone.rot;
   if(ride_rotation)
   {
      loader.game._rotation = ride_rotation;
   }
   if(level != 40)
   {
      loader.bg0_c.bg0._x = zone.camera_x * 1.5;
   }
   loader.game.game._x = zone.camera_x;
   loader.bg1_c.bg1._x = zone.camera_x * 0.5;
   loader.bg2_c.bg2._x = zone.camera_x * 0.25;
   loader.bg3_c.bg3._x = zone.camera_x * 0.1;
   loader.bg0_c.bg0._y = compensated_camera_y * 1.5;
   loader.game.game._y = compensated_camera_y;
   loader.bg1_c.bg1._y = compensated_camera_y * 0.5;
   loader.bg2_c.bg2._y = compensated_camera_y * 0.25;
   loader.bg3_c.bg3._y = compensated_camera_y * 0.1;
   game_x = loader.game.game._x + loader.game._x;
   game_y = loader.game.game._y + loader.game._y;
   if(zone.hifps_camera_reset)
   {
      f_HiFps_CameraReset();
      zone.hifps_camera_reset = false;
   }
}
function f_HiFps_CameraReset()
{
   if(!loader)
   {
      return undefined;
   }
   HiFps_Reset(loader);
   if(loader.game)
   {
      HiFps_Reset(loader.game);
      if(loader.game.game)
      {
         HiFps_Reset(loader.game.game);
      }
   }
   var loc2 = 0;
   while(loc2 < 4)
   {
      var loc1 = loader["bg" + loc2 + "_c"];
      if(loc1)
      {
         HiFps_Reset(loc1);
         loc1 = loc1["bg" + loc2];
         if(loc1)
         {
            HiFps_Reset(loc1);
         }
      }
      loc2 = loc2 + 1;
   }
}
function f_GetCameraCoords(zone)
{
   if(zone.p_cinema_clip)
   {
      u_point.x = 0;
      u_point.y = 0;
      f_LocalToGame(zone.p_cinema_clip,u_point);
      zone.camera_x = - u_point.x;
      zone.camera_y = - u_point.y;
      zone.camera_x_goal = zone.camera_x;
      zone.camera_y_goal = zone.camera_y;
   }
   else
   {
      if(zone.camera_x == undefined)
      {
         var loc8 = loader.game.game["door" + int(_root.spawn_portal_num)];
         zone.camera_x = - loc8._x;
         zone.camera_y = - loc8._y;
         zone.camera_x_goal = zone.camera_x;
         zone.camera_y_goal = zone.camera_y;
         zone.last_good_player_x = zone.camera_x;
         zone.last_good_player_y = zone.camera_y;
         zone.scale_goal = 100;
      }
      var loc15 = 9999999;
      var loc16 = -9999999;
      var loc10 = loc15;
      var loc11 = loc16;
      var loc12 = zone.camera_x;
      var loc7 = loc16;
      zone.n_bottomplayer = 0;
      zone.n_topplayer = 0;
      var loc14 = loc15;
      var loc4 = undefined;
      var loc3 = undefined;
      var loc9 = 1;
      while(loc9 <= active_players)
      {
         loc8 = playerArrayOb["p_pt" + int(loc9)];
         if(loc8.alive and !loc8.npc)
         {
            loc4 = loc8.x;
            loc3 = loc8.y;
            if(!loc8.onscreen)
            {
               if(loc8.onscreenbody)
               {
                  if(loc8.body_y_mod)
                  {
                     loc3 += loc8.body_y_mod;
                  }
                  else
                  {
                     loc3 += loc8.body_y;
                  }
               }
               else
               {
                  loc3 += loc8.body_y;
               }
            }
            zone.last_good_player_x = loc4;
            zone.last_good_player_y = loc3;
            zone.last_good_groundtype = loc8.n_groundtype;
            loc10 = Math.min(loc10,loc4);
            loc11 = Math.max(loc11,loc4);
            if(loc3 < loc14)
            {
               zone.n_topplayer = loc9;
               loc14 = loc3;
            }
            if(loc3 > loc7)
            {
               loc7 = loc3;
               zone.n_bottomplayer = loc9;
            }
         }
         loc9 = loc9 + 1;
      }
      var loc13 = zone.focus_things.length;
      loc9 = 0;
      while(loc9 < loc13)
      {
         loc8 = zone.focus_things[loc9];
         if(loc8 == undefined or !loc8.alive)
         {
            loc9;
            zone.focus_things.splice(loc9--,1);
            loc13 = loc13 - 1;
         }
         else if(loc8.x)
         {
            loc10 = Math.min(loc10,loc8.x);
            loc11 = Math.min(loc11,loc8.x);
         }
         loc9 = loc9 + 1;
      }
      if(loc7 == loc16)
      {
         if(zone.n_bottomplayer)
         {
            loc8 = playerArrayOb["p_pt" + int(zone.n_bottomplayer)];
            zone.camera_x_goal = - loc8.x;
            zone.camera_y_goal = - (loc8.y + loc8.body_y / 2);
         }
         else
         {
            zone.camera_x_goal = - zone.last_good_player_x;
            zone.camera_y_goal = - zone.last_good_player_y;
            zone.scale_goal = 100;
         }
      }
      if(loc10 == loc15)
      {
         if(zone.n_bottomplayer)
         {
            loc8 = playerArrayOb["p_pt" + int(zone.n_bottomplayer)];
            zone.camera_x_goal = - loc8.x;
            zone.camera_y_goal = - (loc8.y + loc8.body_y / 2);
         }
      }
      else
      {
         loc12 = (loc10 + loc11) / 2;
         zone.camera_x_goal = - loc12;
         zone.camera_y_goal = - loc7;
      }
      if(!zone.forced_zoom)
      {
         var loc6 = 1;
         var loc5 = 1;
         loc9 = 1;
         while(loc9 <= total_players)
         {
            loc8 = playerArrayOb["p_pt" + int(loc9)];
            if(loc8.alive and !loc8.npc)
            {
               loc4 = loc8.x;
               if(loc8.onscreen)
               {
                  loc3 = loc8.y;
                  loc6 = Math.max(loc6,Math.abs(loc4 - loc12));
                  loc5 = Math.max(loc5,Math.abs(loc3 - loc7));
               }
               else if(loc8.onscreenbody)
               {
                  loc3 = loc8.y + loc8.body_y;
                  loc6 = Math.max(loc6,Math.abs(loc4 - loc12));
                  loc5 = Math.max(loc5,Math.abs(loc3 - loc7));
               }
            }
            loc9 = loc9 + 1;
         }
         loc9 = 0;
         while(loc9 < loc13)
         {
            loc8 = zone.focus_things[loc9];
            if(loc8.x)
            {
               loc6 = Math.max(loc6,Math.abs(loc8.x - loc12));
               loc5 = Math.max(loc5,Math.abs(loc8.y - loc7));
            }
            loc9 = loc9 + 1;
         }
         if(loc5 * GAME_ASPECT_RATIO > loc6)
         {
            zone.scale_goal = 100 * (GAME_HEIGHT / GAME_ASPECT_RATIO / loc5) / 2;
         }
         else
         {
            zone.scale_goal = 100 * (GAME_WIDTH / GAME_ASPECT_RATIO / loc6) / 2;
         }
         m_zoom = MAX_ZOOM;
         zone.scale_goal = Math.max(Math.min(zone.scale_goal,100),m_zoom);
      }
      else
      {
         zone.scale_goal = 80;
      }
      if(zone.player_x_old == undefined)
      {
         zone.player_move = 1;
      }
      else if(loc12 < zone.player_x_old)
      {
         zone.player_move = -1;
      }
      else if(loc12 > zone.player_x_old)
      {
         zone.player_move = 1;
      }
      else
      {
         zone.player_move = 0;
      }
      zone.player_x_old = loc12;
   }
}
function f_SetEdges()
{
   var loc1 = p_game.edge1;
   loc1.active = false;
   loc1 = p_game.edge2;
   loc1.active = false;
   loc1 = p_game.edge3;
   loc1.active = false;
}
function f_SetBottomEdge(active)
{
   p_game.edge1.active = active;
}
function f_SetLeftEdge(active)
{
   p_game.edge2.active = active;
}
function f_SetRightEdge(active)
{
   p_game.edge3.active = active;
}
function f_SetBottomEdgePosition(y)
{
   p_game.edge1._y = y;
   p_game.edge1.active = true;
}
function f_SetLeftEdgePosition(x)
{
   p_game.edge2._x = x;
   p_game.edge2.active = true;
}
function f_SetRightEdgePosition(x)
{
   p_game.edge3._x = x;
   p_game.edge3.active = true;
}
function f_SZ_PlayerYOnScreen(y)
{
   if(y > main.bottom)
   {
      return false;
   }
   if(y - 100 < main.top)
   {
      return false;
   }
   return true;
}
function f_SZ_PlayerXOnScreen(x)
{
   if(x < main.left)
   {
      return false;
   }
   if(x > main.right)
   {
      return false;
   }
   return true;
}
function f_SZ_OnScreenBody(x, y, w, body_y, body_y_mod)
{
   var loc1 = undefined;
   if(body_y_mod)
   {
      loc1 = y + body_y_mod;
   }
   else
   {
      loc1 = y + body_y;
   }
   if(loc1 > main.bottom)
   {
      return false;
   }
   if(loc1 - 100 < main.top)
   {
      return false;
   }
   if(x + w / 2 < main.left)
   {
      return false;
   }
   if(x - w / 2 > main.right)
   {
      return false;
   }
   return true;
}
function f_CenterCinemaCam(zone)
{
   zone._x = _root.main.right - _root.scaled_screen_width / 2;
   zone._y = _root.f_BottomPlayerY();
   if(zone._y > p_game.edge1._y - 100)
   {
      zone._y = p_game.edge1._y - 100;
   }
}
function f_PlayersCenterX()
{
   var loc2 = 1;
   while(loc2 <= active_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc2)];
      if(loc2 == 1)
      {
         var loc3 = loc1.x;
         var loc4 = loc1.x;
      }
      else if(loc1.x > loc4)
      {
         loc4 = loc1.x;
      }
      else if(loc1.x < loc3)
      {
         loc3 = loc1.x;
      }
      loc2 = loc2 + 1;
   }
   return loc3 + (loc4 - loc3) / 2;
}
function f_XBPortalThing(zone)
{
   var loc11 = 999999999999;
   var loc14 = undefined;
   var loc12 = undefined;
   if(!_root.main.portals_active)
   {
      return false;
   }
   var loc2 = 1;
   while(loc2 <= num_portals)
   {
      var loc3 = loader.game.game["door" + int(loc2)];
      var loc10 = _root["portal" + int(loc2)];
      var loc9 = loc3._x;
      var loc6 = loc3._y;
      var loc7 = zone._x;
      var loc5 = zone._y;
      var loc8 = (loc9 - loc7) * (loc9 - loc7) + (loc6 - loc5) * (loc6 - loc5);
      if(loc8 < loc11)
      {
         loc11 = loc8;
         loc14 = loc3;
         loc12 = loc10;
      }
      loc2 = loc2 + 1;
   }
   if(loc12.open)
   {
      var loc4 = 1;
      while(loc4 < 10)
      {
         _root["portal" + int(loc4)].open = false;
         loc4 = loc4 + 1;
      }
      f_func = loc12.fp_activate;
      f_func(zone);
      if(loc12.target_level != undefined and loc12.target_level != "")
      {
         fader.f_FadeOut();
         _root.spawn_portal_num = loc12.spawn_portal_num;
         f_ChangeLevel(loc12.target_level);
      }
      return true;
   }
   return false;
}
function f_SetXY(zone, x, y)
{
   zone.x = x;
   zone.y = y;
   zone._x = x;
   zone._y = y;
   f_Depth(zone,zone.y);
   zone.shadow_pt._x = x;
   zone.shadow_pt._y = y;
}
function f_DeathBoxMCH(zone, speed)
{
   var loc2 = 0;
   if(zone.body._y < 0)
   {
      var loc3 = zone.x;
      var loc5 = zone.y;
      var loc7 = 0;
      var loc4 = f_BSPHitTest(loc3,loc5,loc3 + speed,loc5);
      if(!loc4)
      {
         zone.x += speed;
      }
      else
      {
         loc2 = 0.9 - loc4;
         if(loc2 < 0)
         {
            loc2 = 0;
         }
         zone.x = loc3 + (loc4 + 0.001) * speed;
         zone.n_groundtype = 0;
      }
   }
   else
   {
      f_Damage(zone,2);
      zone.speed_toss_y = - (random(3) + 19);
      zone.speed_toss_x = random(5) + 8;
      f_FX(zone.x,zone.body._y + zone.y,int(zone.y) + 7,"impact1",100,100);
      f_CallJuggle1(zone);
   }
   return loc2;
}
function f_StairsMCH(zone, speed)
{
   var loc3 = zone.x;
   var loc4 = zone.y;
   var loc6 = 0;
   var loc2 = 0;
   var loc5 = f_BSPHitTest(loc3,loc4,loc3 + speed,loc4);
   if(!loc5)
   {
      var loc9 = f_BSPHitTest(loc3,loc4,loc3,loc4 + 800) * 800;
      var loc10 = f_BSPCheckLastHitType();
      if(loc9 and loc10 == 100)
      {
         var loc8 = f_BSPCheckLastHitSlope() * speed;
         loc6 = loc8;
         if(zone.body_y < 0)
         {
            zone.body_y -= loc8;
         }
      }
      zone.x += speed;
   }
   else
   {
      loc2 = 0.9 - loc5;
      if(loc2 < 0)
      {
         loc2 = 0;
      }
      zone.x = loc3 + (loc5 + 0.001) * speed;
      zone.n_groundtype = 0;
   }
   if(loc6 and loc2 == 0)
   {
      f_MoveCharV(zone,loc6,0);
   }
   return loc2;
}
function f_LadderMCH(zone, speed)
{
   var loc3 = zone.x;
   var loc2 = zone.y;
   var loc6 = f_BSPHitTest(loc3,loc2,loc3 + speed,loc2);
   if(loc6)
   {
      var loc4 = loc3 + (loc6 + 0.05) * speed;
      var loc5 = f_BSPHitTest(loc4,loc2,loc4,loc2 + 3990);
      var loc8 = f_BSPCheckLastHitType();
      if(loc5 and Math.floor(loc8 / 100) == 0)
      {
         var loc7 = loc2 + (loc5 + 0.001) * 3990;
         zone.jumped = true;
         zone.jumping = true;
         zone.blocking = false;
         zone.hanging = false;
         zone.ladder = false;
         zone.busy = false;
         zone.jump_attack = true;
         zone.body_y = 0;
         zone.speed_jump = zone.speed_launch * 0.25;
         zone.n_groundtype = 0;
         zone.body_y -= loc7 - zone.y;
         zone.y = loc7;
         f_ShadowSize(zone);
         zone.x = loc4;
         zone.gotoAndStop("jump");
         done = true;
      }
   }
   else
   {
      zone.x += speed;
   }
}
function f_TableMCH(zone, speed)
{
   var loc3 = zone.x;
   var loc5 = zone.y;
   var loc2 = 0;
   var loc4 = f_BSPHitTest(loc3,loc5,loc3 + speed,loc5);
   var loc6 = f_BSPCheckLastHitType();
   if(!loc4)
   {
      zone.x += speed;
   }
   else if(loc6 == 1000)
   {
      loc2 = 0.9 - loc4;
      if(loc2 < 0)
      {
         loc2 = 0;
      }
      zone.x = loc3 + (loc4 + 0.001) * speed;
      if(!zone.jumping)
      {
         zone.jumped = true;
         zone.jumping = true;
         zone.blocking = false;
         zone.hanging = false;
         zone.ladder = false;
         zone.busy = false;
         zone.jump_attack = true;
         zone.speed_jump = zone.speed_launch * 0.15;
         zone.gotoAndStop("jump");
      }
      zone.body_y += zone.body_table_y;
      zone.body_table_y = 0;
      zone.n_groundtype = 0;
      f_ShadowSize(zone);
      zone.shadow.gotoAndStop("off");
   }
   return loc2;
}
function f_Water1MCH(zone, speed)
{
   var loc4 = zone.x;
   var loc6 = zone.y;
   var loc2 = 0;
   var loc3 = f_BSPHitTest(loc4,loc6,loc4 + speed,loc6);
   var loc7 = f_BSPCheckLastHitType();
   if(!loc3)
   {
      f_Ripple(zone,speed);
      zone.x += speed;
   }
   else if(loc7 == 301)
   {
      loc2 = 0.9 - loc3;
      if(loc2 < 0)
      {
         loc2 = 0;
      }
      zone.x = loc4 + (loc3 + 0.001) * speed;
      zone.body_table_y = 15;
      if(zone.n_groundtype == 301)
      {
         one.shadow_pt.gotoAndStop("off");
      }
      else
      {
         zone.shadow_pt.gotoAndStop("on");
      }
      zone.n_groundtype = 301;
      f_ShadowSize(zone);
      zone.waterbox.gotoAndStop(2);
   }
   else if(loc7 == 300)
   {
      loc2 = 0.9 - loc3;
      if(loc2 < 0)
      {
         loc2 = 0;
      }
      zone.x = loc4 + (loc3 + 0.001) * speed;
      zone.n_groundtype = 0;
      f_ShadowSize(zone);
      zone.waterbox.gotoAndStop(1);
   }
   return loc2;
}
function f_Water2MCH(zone, speed)
{
   var loc3 = zone.x;
   var loc5 = zone.y;
   var loc2 = 0;
   var loc4 = f_BSPHitTest(loc3,loc5,loc3 + speed,loc5);
   var loc6 = f_BSPCheckLastHitType();
   if(!loc4)
   {
      f_Ripple(zone,speed);
      zone.x += speed;
   }
   else if(loc6 == 302)
   {
      //trace("f_Water2MCH");
      //Error("No Deep Water");
   }
   else if(loc6 == 301)
   {
      loc2 = 0.9 - loc4;
      if(loc2 < 0)
      {
         loc2 = 0;
      }
      zone.x = loc3 + (loc4 + 0.001) * speed;
      zone.body_table_y = 0;
      zone.n_groundtype = 300;
      f_ShadowSize(zone);
      zone.waterbox.gotoAndStop(1);
   }
   return loc2;
}
function f_InsideMCH(zone, speed)
{
   var loc2 = zone.x;
   var loc5 = zone.y;
   var loc1 = 0;
   var loc3 = f_BSPHitTest(loc2,loc5,loc2 + speed,loc5);
   if(!loc3)
   {
      zone.x += speed;
   }
   else
   {
      loc1 = 0.9 - loc3;
      if(loc1 < 0)
      {
         loc1 = 0;
      }
      zone.x = loc2 + (loc3 + 0.001) * speed;
      zone.n_groundtype = 0;
   }
   return loc1;
}
function f_PlainMCV(zone, speed)
{
   var loc5 = zone.x;
   var loc7 = zone.y;
   var loc6 = 0;
   var loc9 = f_BSPHitTest(loc5,loc7,loc5,loc7 + speed);
   if(!loc9)
   {
      zone.y += speed;
   }
   else
   {
      loc6 = 0.9 - loc9;
      if(loc6 < 0)
      {
         loc6 = 0;
      }
      var loc2 = f_BSPCheckLastHitType();
      var loc15 = f_BSPCheckLastHitIndex();
      var loc3 = loc7 + (loc9 + 0.0001) * speed;
      switch(loc2)
      {
         case 1:
         case 2:
         case 3:
            break;
         case 4:
         case 5:
         case 6:
            HiFps_ResetRecursive(zone);
            if(speed > 0)
            {
               var loc12 = f_BSPHitTest(loc5,loc3,loc5,loc3 + 800);
               if(loc12)
               {
                  if(loc15 != f_BSPCheckLastHitIndex())
                  {
                     var loc4 = loc3 + (loc12 + 0.00001) * 800;
                     loc2 = f_BSPCheckLastHitType();
                     if(loc2 == 500 and loc12 * 800 < 15)
                     {
                        if(zone.body_y == 0)
                        {
                           zone.n_groundtype = loc2;
                           zone.y = loc4;
                           zone.body_y = 0;
                           f_ShadowSize(zone);
                           zone.busy = true;
                           zone.ladder = true;
                           zone.shadow_pt.gotoAndStop("off");
                           zone.gotoAndStop("climb");
                        }
                     }
                     else if(!zone.horse and !zone.hanging)
                     {
                        if(loc2 == 4 or loc2 == 5 or loc2 == 6)
                        {
                           if(!zone.jumping)
                           {
                              zone.jumped = true;
                              zone.jumping = true;
                              zone.blocking = false;
                              zone.jump_attack = true;
                              if(zone.dashing)
                              {
                                 zone.dashjump = true;
                              }
                              else
                              {
                                 zone.dashjump = false;
                              }
                              zone.speed_jump = 0;
                           }
                           zone.body_y -= loc4 - zone.y;
                           zone.y = loc4;
                           zone.gotoAndStop("jump");
                        }
                        else
                        {
                           //Error("f_PlainMCV");
                        }
                     }
                  }
               }
            }
            else
            {
               loc12 = f_BSPHitTest(loc5,loc3,loc5,loc3 - 800);
               if(loc12)
               {
                  var loc10 = (loc12 + 0.0001) * 800;
                  loc4 = loc3 - loc10;
                  loc2 = f_BSPCheckLastHitType();
                  if(loc2 == 500)
                  {
                     if(zone.body_y == 0)
                     {
                        if(loc10 < 25)
                        {
                           zone.pre_ladder_x = zone.x;
                           zone.pre_ladder_y = zone.y;
                           var loc17 = zone.y;
                           zone.y = loc4;
                           zone.gotoAndStop("climb");
                           zone.n_groundtype = loc2;
                           f_Depth(zone,zone.y);
                           zone.shadow_pt.gotoAndStop("off");
                           zone.busy = true;
                           zone.ladder = true;
                        }
                     }
                     else if(loc10 < 25)
                     {
                        var loc11 = f_BSPHitTest(loc5,loc4,loc5,loc4 - 800);
                        if(loc11)
                        {
                           var loc13 = (loc11 + 0.0001) * 800;
                           var loc14 = loc4 - loc13;
                           if(loc14 < loc4 + zone.body_y)
                           {
                              zone.pre_ladder_x = zone.x;
                              zone.pre_ladder_y = zone.y;
                              loc17 = zone.y;
                              zone.y = loc4 + zone.body_y;
                              zone.gotoAndStop("climb");
                              zone.n_groundtype = loc2;
                              f_Depth(zone,zone.y);
                              zone.body_y = 0;
                              f_ShadowSize(zone);
                              zone.busy = true;
                              zone.ladder = true;
                              zone.shadow_pt.gotoAndStop("off");
                           }
                        }
                     }
                  }
                  else if(loc2 == 4 or loc2 == 5 or loc2 == 6)
                  {
                     if(loc7 + zone.body_y < loc4)
                     {
                        zone.body_y -= loc4 - zone.y;
                        zone.y = loc4;
                        f_Depth(zone,zone.y);
                     }
                  }
               }
            }
            break;
         case 100:
         case 101:
            zone.n_groundtype = 100;
            zone.y = loc3;
            break;
         case 200:
            zone.n_groundtype = 200;
            zone.y = loc3;
            break;
         case 300:
            zone.n_groundtype = 300;
            zone.y = loc3;
            break;
         case 400:
            if(zone.human and !zone.npc and !main.leash_right_x)
            {
               zone.n_groundtype = 400;
            }
            else
            {
               zone.y = loc3;
            }
            break;
         case 700:
            if(fp_FunctionLine)
            {
               if(speed > 0)
               {
                  zone.upright = false;
               }
               else
               {
                  zone.upright = true;
               }
               var loc16 = zone.y;
               zone.y = loc3;
               if(!fp_FunctionLine(zone))
               {
                  zone.y = loc16;
               }
            }
            break;
         case 1000:
            if(zone.body._y < -20)
            {
               zone.n_groundtype = 1000;
               zone.y = loc3;
               zone.body_y += 20;
               zone.body_table_y = -20;
               zone.shadow.gotoAndStop("on");
               zone.shadow._y = zone.body_table_y;
            }
            break;
         case 1001:
            break;
         default:
            trace("f_PlainMCV");
            //Error(loc2);
      }
   }
   return loc6;
}
function f_DeathBoxMCV(zone, speed)
{
   var loc2 = 0;
   if(zone.body._y < 0)
   {
      var loc5 = zone.x;
      var loc3 = zone.y;
      var loc7 = 0;
      var loc4 = f_BSPHitTest(loc5,loc3,loc5,loc3 + speed);
      if(!loc4)
      {
         zone.y += speed;
      }
      else
      {
         loc2 = 0.9 - loc4;
         if(loc2 < 0)
         {
            loc2 = 0;
         }
         zone.y = loc3 + (loc4 + 0.001) * speed;
         zone.n_groundtype = 0;
      }
   }
   else
   {
      f_Damage(zone,2);
      zone.speed_toss_y = - (random(3) + 9);
      zone.speed_toss_x = random(5) + 8;
      f_FX(zone.x,zone.body._y + zone.y,int(zone.y) + 7,"impact1",100,100);
      f_CallJuggle1(zone);
   }
   return loc2;
}
function f_TableMCV(zone, speed)
{
   var loc5 = zone.x;
   var loc3 = zone.y;
   var loc2 = 0;
   var loc4 = f_BSPHitTest(loc5,loc3,loc5,loc3 + speed);
   var loc6 = f_BSPCheckLastHitType();
   if(!loc4)
   {
      zone.y += speed;
   }
   else if(loc6 == 1000)
   {
      loc2 = 0.9 - loc4;
      if(loc2 < 0)
      {
         loc2 = 0;
      }
      zone.y = loc3 + (loc4 + 0.001) * speed;
      if(!zone.jumping)
      {
         zone.jumped = true;
         zone.jumping = true;
         zone.blocking = false;
         zone.hanging = false;
         zone.ladder = false;
         zone.busy = false;
         zone.jump_attack = true;
         zone.speed_jump = zone.speed_launch * 0.15;
         zone.gotoAndStop("jump");
      }
      zone.body_y += zone.body_table_y;
      zone.body_table_y = 0;
      zone.n_groundtype = 0;
      f_ShadowSize(zone);
      zone.shadow.gotoAndStop("off");
   }
   return loc2;
}
function f_Water1MCV(zone, speed)
{
   var loc6 = zone.x;
   var loc4 = zone.y;
   var loc2 = 0;
   var loc3 = f_BSPHitTest(loc6,loc4,loc6,loc4 + speed);
   var loc7 = f_BSPCheckLastHitType();
   if(!loc3)
   {
      f_Ripple(zone,speed);
      zone.y += speed;
   }
   else if(loc7 == 301)
   {
      loc2 = 0.9 - loc3;
      if(loc2 < 0)
      {
         loc2 = 0;
      }
      zone.y = loc4 + (loc3 + 0.001) * speed;
      zone.body_table_y = 15;
      zone.n_groundtype = 301;
      f_ShadowSize(zone);
      zone.waterbox.gotoAndStop(2);
   }
   else if(loc7 == 300)
   {
      loc2 = 0.9 - loc3;
      if(loc2 < 0)
      {
         loc2 = 0;
      }
      zone.y = loc4 + (loc3 + 0.001) * speed;
      zone.n_groundtype = 0;
      f_ShadowSize(zone);
      zone.waterbox.gotoAndStop(1);
   }
   return loc2;
}
function f_Water2MCV(zone, speed)
{
   var loc5 = zone.x;
   var loc3 = zone.y;
   var loc2 = 0;
   var loc4 = f_BSPHitTest(loc5,loc3,loc5,loc3 + speed);
   var loc6 = f_BSPCheckLastHitType();
   if(!loc4)
   {
      f_Ripple(zone,speed);
      zone.y += speed;
   }
   else if(loc6 == 302)
   {
      //trace("f_Water2MCV");
      //Error("No Deep Water");
   }
   else if(loc6 == 301)
   {
      loc2 = 0.9 - loc4;
      if(loc2 < 0)
      {
         loc2 = 0;
      }
      zone.y = loc3 + (loc4 + 0.001) * speed;
      zone.body_table_y = 0;
      zone.n_groundtype = 300;
      f_ShadowSize(zone);
      zone.waterbox.gotoAndStop(1);
   }
   return loc2;
}
function f_InsideMCV(zone, speed)
{
   var loc5 = zone.x;
   var loc2 = zone.y;
   var loc1 = 0;
   var loc3 = f_BSPHitTest(loc5,loc2,loc5,loc2 + speed);
   if(!loc3)
   {
      zone.y += speed;
   }
   else
   {
      loc1 = 0.9 - loc3;
      if(loc1 < 0)
      {
         loc1 = 0;
      }
      zone.y = loc2 + (loc3 + 0.001) * speed;
      zone.n_groundtype = 0;
   }
   return loc1;
}
function f_LadderMCV(zone, speed)
{
   var loc2 = zone.x;
   var loc4 = zone.y;
   var loc7 = f_BSPHitTest(loc2,loc4,loc2,loc4 + speed);
   if(!loc7)
   {
      zone.y += speed;
   }
   else
   {
      var loc3 = zone.y + (loc7 + 0.001) * speed;
      if(speed > 0)
      {
         var loc6 = f_BSPHitTest(loc2,loc3,loc2,loc3 + 3990);
         if(loc6)
         {
            var loc8 = loc3 + (loc6 + 0.0001) * 3990;
            zone.jumped = true;
            zone.jumping = true;
            zone.blocking = false;
            zone.hanging = false;
            zone.ladder = false;
            zone.busy = false;
            zone.jump_attack = true;
            zone.body_y = 0;
            zone.speed_jump = 0;
            zone.n_groundtype = 0;
            zone.body_y -= loc8 - zone.y;
            zone.y = loc8;
            f_ShadowSize(zone);
            zone.shadow.gotoAndStop("on");
            zone.gotoAndStop("jump");
         }
      }
      else
      {
         loc6 = f_BSPHitTest(loc2,loc3,loc2,loc3 - 3990);
         if(loc6)
         {
            loc8 = loc3 - (loc6 + 0.0001) * 3990;
            zone.jumped = true;
            zone.jumping = true;
            zone.blocking = false;
            zone.hanging = false;
            zone.ladder = false;
            zone.busy = false;
            zone.jump_attack = true;
            zone.body_y = 0;
            zone.speed_jump = -5;
            zone.n_groundtype = 0;
            zone.y = loc8;
            f_Depth(zone,zone.y);
            zone.shadow.gotoAndStop("on");
            f_ShadowSize(zone);
            zone.gotoAndStop("jump");
         }
      }
   }
}
function f_SideLadderMCV(zone, speed)
{
   zone.y += speed;
   zone.x += zone.ladder_slope * speed;
   var loc2 = 0;
   var loc3 = undefined;
   loc3 = Math.pow(zone.x - zone.ladder_endpt_top._x,2) + Math.pow(zone.y - zone.ladder_endpt_top._y,2);
   if(speed < 0 and loc3 < 625)
   {
      loc2 = 1;
      zone.x = zone.ladder_endpt_top._x;
      zone.y = zone.ladder_endpt_top._y;
   }
   loc3 = Math.pow(zone.x - zone.ladder_endpt_bot._x,2) + Math.pow(zone.y - zone.ladder_endpt_bot._y,2);
   if(speed > 0 and loc3 < 625)
   {
      loc2 = 2;
      zone.x = zone.ladder_endpt_bot._x;
      zone.y = zone.ladder_endpt_bot._y;
   }
   if(loc2)
   {
      zone.body_y = 0;
      zone.body._y = zone.body_y;
      zone.speed_jump = 0;
      zone.jumping = false;
      zone.busy = true;
      zone.jumped = false;
      zone.blocking = false;
      zone.hanging = false;
      zone.ladder = false;
      zone.busy = false;
      zone.jump_attack = true;
      zone.n_groundtype = 0;
      if(loc2 == 1)
      {
         f_DashReset(zone);
         zone.hanging = true;
         zone.gotoAndStop("hanging");
      }
      else
      {
         zone.gotoAndStop("jump");
      }
      zone.shadow_pt.gotoAndStop("on");
      f_ShadowSize(zone);
   }
}
function f_MoveKidH(zone, speed, recurse)
{
   f_MoveCharH(zone,speed,recurse);
}
function f_MoveKidV(zone, speed, recurse)
{
   f_MoveCharV(zone,speed,recurse);
}
function f_ClimbSettings(zone)
{
   zone.walking = false;
   zone.dashing = false;
   zone.cframe = 1;
   zone.max_cframe = 10;
   zone.body.body.gotoAndStop(zone.cframe);
   if(zone.n_groundtype == 600)
   {
      zone.max_cframe = 18;
      if(zone._xscale * zone.ladder_slope > 0)
      {
         f_FlipChar(zone);
      }
   }
}
function f_CharClimb(zone)
{
   var loc2 = zone.cframe;
   var loc3 = false;
   if(Key.isDown(zone.button_left))
   {
      loc3 = true;
      zone.left_timer = zone.left_timer + 1;
   }
   else
   {
      zone.left_timer = 0;
   }
   if(Key.isDown(zone.button_right))
   {
      loc3 = true;
      zone.right_timer = zone.right_timer + 1;
   }
   else
   {
      zone.right_timer = 0;
   }
   if(Key.isDown(zone.button_up))
   {
      loc3 = true;
      zone.up_timer = zone.up_timer + 1;
   }
   else
   {
      zone.up_timer = 0;
   }
   if(Key.isDown(zone.button_down))
   {
      loc3 = true;
      zone.down_timer = zone.down_timer + 1;
   }
   else
   {
      zone.down_timer = 0;
   }
   if(!loc3)
   {
      if(Key.isDown(zone.button_jump))
      {
         var loc4 = zone.x;
         var loc6 = zone.y;
         var loc8 = f_BSPHitTest(loc4,loc6,loc4,loc6 + 3990);
         if(loc8)
         {
            var loc5 = zone.y + (loc8 + 0.001) * 3990;
            var loc7 = f_BSPHitTest(loc4,loc5,loc4,loc5 + 200);
            var loc10 = f_BSPCheckLastHitType();
            if(loc7 and loc10 < 100)
            {
               var loc9 = loc5 + (loc7 + 0.001) * 200;
               zone.jumped = true;
               zone.jumping = true;
               zone.blocking = false;
               zone.hanging = false;
               zone.ladder = false;
               zone.busy = false;
               zone.jump_attack = true;
               zone.body_y = 0;
               zone.speed_jump = zone.speed_launch * 0.25;
               zone.n_groundtype = 0;
               zone.body_y -= loc9 - zone.y;
               zone.y = loc9;
               f_ShadowSize(zone);
               zone.gotoAndStop("jump");
               zone._x = zone.x;
               zone._y = zone.y;
               zone.shadow_pt._x = zone.x;
               zone.shadow_pt._y = zone.y;
            }
         }
      }
   }
   else
   {
      if(zone.left_timer > 0 and zone.left_timer > zone.right_timer)
      {
         f_MoveCharH(zone,(- zone.speed_x) * 0.25,1);
         loc2 = loc2 + 1;
      }
      else if(zone.right_timer > 0 and zone.right_timer > zone.left_timer)
      {
         f_MoveCharH(zone,zone.speed_x * 0.25,1);
         loc2 = loc2 + 1;
      }
      else if(zone.up_timer > 0 and zone.up_timer > zone.down_timer)
      {
         f_MoveCharV(zone,(- zone.speed_x) * 0.65,1);
         loc2 = loc2 + 1;
      }
      else if(zone.down_timer > 0 and zone.down_timer > zone.up_timer)
      {
         f_MoveCharV(zone,zone.speed_x * 0.65,1);
         loc2 = loc2 - 1;
      }
      if(zone.ladder)
      {
         if(loc2 > zone.max_cframe)
         {
            loc2 = 1;
         }
         else if(loc2 < 1)
         {
            loc2 = zone.max_cframe;
         }
         zone.cframe = loc2;
         zone.body.body.gotoAndStop(loc2);
      }
   }
}
function f_CharSideClimb(zone)
{
   var loc2 = zone.cframe;
   var loc3 = false;
   if(Key.isDown(zone.button_left))
   {
      loc3 = true;
      zone.left_timer = zone.left_timer + 1;
   }
   else
   {
      zone.left_timer = 0;
   }
   if(Key.isDown(zone.button_right))
   {
      loc3 = true;
      zone.right_timer = zone.right_timer + 1;
   }
   else
   {
      zone.right_timer = 0;
   }
   if(zone.npc or Key.isDown(zone.button_up))
   {
      loc3 = true;
      zone.up_timer = zone.up_timer + 1;
   }
   else
   {
      zone.up_timer = 0;
   }
   if(Key.isDown(zone.button_down))
   {
      loc3 = true;
      zone.down_timer = zone.down_timer + 1;
   }
   else
   {
      zone.down_timer = 0;
   }
   if(loc3)
   {
      if(zone.left_timer > 0 and zone.left_timer > zone.right_timer or zone.down_timer > 0 and zone.down_timer > zone.up_timer)
      {
         f_MoveCharV(zone,zone.speed_x * Math.abs(Math.cos(3.141592653589793 * loc2 / 18)),1);
         loc2 = loc2 - 1;
      }
      else if(zone.right_timer > 0 and zone.right_timer > zone.left_timer or zone.up_timer > 0 and zone.up_timer > zone.down_timer)
      {
         f_MoveCharV(zone,(- zone.speed_x) * Math.abs(Math.cos(3.141592653589793 * loc2 / 18)),1);
         loc2 = loc2 + 1;
      }
      if(zone.ladder)
      {
         if(loc2 > zone.max_cframe)
         {
            loc2 = 1;
         }
         else if(loc2 < 1)
         {
            loc2 = zone.max_cframe;
         }
         zone.cframe = loc2;
         zone.body.body.gotoAndStop(loc2);
      }
   }
}
function f_Ripple(zone, speed)
{
   if(zone.body_y >= -5)
   {
      var loc2 = false;
      if(speed)
      {
         if(!zone.ripple)
         {
            loc2 = true;
            zone.ripple = 1;
         }
         else
         {
            zone.ripple = zone.ripple + 1;
            if(zone.ripple > 6)
            {
               zone.ripple = 0;
            }
         }
      }
      if(loc2)
      {
         if(level == 32)
         {
            f_FX(zone._x,zone._y,int(zone._y + 1),"wave",100,100);
         }
         else
         {
            var loc3 = f_FX(zone._x,zone._y,int(zone._y + 1),"splash",100,100);
            f_ColorSwap(loc3,water_default);
         }
      }
   }
}
function f_ProjectileMove(zone, speed)
{
   var loc3 = 0;
   var loc5 = zone.n_groundtype;
   var loc2 = 0;
   if(f_ProjectileHitWallH(zone,zone.speed_x))
   {
      loc3 = 1;
   }
   else
   {
      switch(loc5)
      {
         case 0:
         case 0:
            loc2 = f_PlainProjectileMove(zone,speed);
            break;
         case 100:
         case 101:
            loc2 = f_StairsProjectileMove(zone,speed);
            break;
         case 200:
         case 300:
         case 301:
         case 302:
         case 400:
         case 500:
         case 600:
            loc2 = f_InsideProjectileMove(zone,speed);
            break;
         case 1000:
         case 1001:
            loc2 = f_TableProjectileMove(zone,speed);
            break;
         default:
            //Error(loc5);
            loc2 = f_InsideProjectileMove(zone,speed);
      }
   }
   zone._x = zone.x;
   zone.shadow_pt._x = zone.x;
   zone.body._y += zone.speed_y;
   if(zone.gravity > 0)
   {
      zone.body._rotation = zone.speed_y;
      zone.speed_y += zone.gravity;
   }
   if(zone.body._y + zone.h >= 0)
   {
      zone.bounces = zone.bounces + 1;
      if(zone.bounces <= zone.bounces_max)
      {
         zone.body._y = - zone.h;
         zone.speed_y *= -0.5;
      }
      else
      {
         zone.body._y = 0;
         loc3 = 1;
      }
   }
   zone._y = zone.y;
   zone.shadow_pt._y = zone._y;
   f_ShadowSize(zone);
   if(loc2 < 0)
   {
      loc3 = 1;
   }
   else if(loc2 > 0.1 and !loc3)
   {
      loc3 = f_ProjectileMove(zone,speed * loc2);
   }
   return loc3;
}
function f_PlainProjectileMove(zone, speed)
{
   var loc6 = zone.x;
   var loc4 = zone.y;
   var loc8 = 0;
   var loc2 = 0;
   var loc7 = f_BSPHitTest(loc6,loc4,loc6 + speed,loc4);
   if(!loc7)
   {
      zone.x += speed;
      var loc15 = true;
      var loc5 = 0;
      var loc16 = f_BSPHitTest(loc6,loc4,loc6,loc4 + 400) * 400;
      if(loc16)
      {
         loc5 = f_BSPCheckLastHitType();
         if(loc5 == 3 or loc5 == 6)
         {
            var loc14 = f_BSPCheckLastHitSlope();
            var loc17 = loc14 * speed;
            if(loc17 < 0)
            {
               loc8 = loc17;
               loc15 = false;
               zone.body._y -= loc17;
            }
         }
      }
   }
   else
   {
      loc5 = f_BSPCheckLastHitType();
      var loc13 = f_BSPCheckLastHitIndex();
      loc2 = 0.9 - loc7;
      if(loc2 < 0)
      {
         loc2 = 0;
      }
      var loc3 = loc6 + (loc7 + 0.01) * speed;
      switch(loc5)
      {
         case 1:
         case 2:
         case 3:
            zone.x = loc3;
            if(Math.abs(f_BSPCheckLastHitSlope()) > 0.1)
            {
               loc2 = -1;
            }
            break;
         case 4:
         case 5:
         case 6:
            var loc11 = false;
            var loc10 = f_BSPHitTest(loc3,loc4,loc3,loc4 - 3990);
            loc2 = -1;
            if(loc10)
            {
               if(loc13 != f_BSPCheckLastHitIndex())
               {
                  var loc12 = loc4 - (loc10 + 0.0001) * 3990;
                  loc5 = f_BSPCheckLastHitType();
                  if(loc5 != 500 and loc5 != 600)
                  {
                     loc17 = loc4 + zone.body._y - loc12;
                     if(loc17 < 0)
                     {
                        zone.x = loc3;
                        zone.body._y -= loc12 - zone.y;
                        zone.y = loc12;
                        f_Depth(zone,zone.y);
                        loc2 = 0;
                     }
                     loc11 = true;
                  }
               }
            }
            if(!loc11)
            {
               loc10 = f_BSPHitTest(loc3,loc4,loc3,loc4 + 3990);
               if(loc10)
               {
                  if(loc13 != f_BSPCheckLastHitIndex())
                  {
                     loc12 = loc4 + (loc10 + 0.0001) * 3990;
                     loc5 = f_BSPCheckLastHitType();
                     if(loc5 != 500 and loc5 != 600)
                     {
                        zone.x = loc3;
                        zone.body._y -= loc12 - zone.y;
                        zone.y = loc12;
                        f_Depth(zone,zone.y);
                        loc2 = 0;
                     }
                  }
               }
               f_Depth(zone,zone.y);
            }
            break;
         case 100:
         case 101:
            zone.n_groundtype = 100;
            zone.x = loc3;
            break;
         case 200:
            zone.n_groundtype = 200;
            zone.x = loc3;
            break;
         case 300:
            zone.n_groundtype = 300;
            zone.x = loc3;
            break;
         case 400:
            zone.n_groundtype = 400;
            zone.x = loc3;
            break;
         case 500:
         case 600:
            //Error(loc5);
            loc2 = -1;
            break;
         case 700:
            if(fp_FunctionLineProjectile)
            {
               zone.x = loc3;
               if(!fp_FunctionLineProjectile(zone))
               {
                  loc2 = -1;
               }
            }
            else
            {
               loc2 = -1;
            }
            break;
         case 1000:
            if(zone.body._y < -20)
            {
               zone.n_groundtype = 1000;
               zone.x = loc3;
            }
            else
            {
               loc2 = -1;
            }
            break;
         case 1001:
            loc2 = -1;
            break;
         default:
            //Error(loc5);
            loc2 = -1;
      }
   }
   if(loc8 and loc2 == 0)
   {
      f_ProjectileMoveY(zone,loc8);
   }
   return loc2;
}
function f_StairsProjectileMove(zone, speed)
{
   var loc2 = zone.x;
   var loc4 = zone.y;
   var loc7 = 0;
   var loc1 = 0;
   var loc10 = 0;
   var loc6 = 0;
   var loc5 = f_BSPHitTest(loc2,loc4,loc2 + speed,loc4);
   if(!loc5)
   {
      var loc9 = f_BSPHitTest(loc2,loc4,loc2,loc4 + 400) * 400;
      if(loc9 and f_BSPCheckLastHitType() == 100)
      {
         n_slope = f_BSPCheckLastHitSlope();
         loc6 = n_slope * speed;
         loc7 = loc6;
         zone.body._y -= loc6;
      }
      zone.x += speed;
   }
   else
   {
      loc1 = 0.9 - loc5;
      if(loc1 < 0)
      {
         loc1 = 0;
      }
      zone.x = loc2 + (loc5 + 0.001) * speed;
      zone.n_groundtype = 0;
   }
   if(loc7 and loc1 == 0)
   {
      f_ProjectileMoveY(zone,loc7);
   }
   return loc1;
}
function f_InsideProjectileMove(zone, speed)
{
   var loc2 = zone.x;
   var loc5 = zone.y;
   var loc1 = 0;
   var loc3 = f_BSPHitTest(loc2,loc5,loc2 + speed,loc5);
   if(!loc3)
   {
      zone.x += speed;
   }
   else
   {
      loc1 = 0.9 - loc3;
      if(loc1 < 0)
      {
         loc1 = 0;
      }
      zone.x = loc2 + (loc3 + 0.001) * speed;
      zone.n_groundtype = 0;
   }
   return loc1;
}
function f_TableProjectileMove(zone, speed)
{
   var loc3 = zone.x;
   var loc5 = zone.y;
   var loc1 = 0;
   var loc4 = f_BSPHitTest(loc3,loc5,loc3 + speed,loc5);
   var loc6 = f_BSPCheckLastHitType();
   if(!loc4)
   {
      zone.x += speed;
      if(zone.body._y > -20)
      {
         loc1 = -1;
      }
   }
   else if(loc6 == 1000 or loc6 == 1001)
   {
      loc1 = 0.9 - loc4;
      if(loc1 < 0)
      {
         loc1 = 0;
      }
      zone.x = loc3 + (loc4 + 0.001) * speed;
      zone.n_groundtype = 0;
   }
   else
   {
      loc1 = -1;
   }
   return loc1;
}
function f_ProjectileMoveY(zone, speed)
{
   var loc3 = zone.x;
   var loc2 = zone.y;
   var loc5 = f_BSPHitTest(loc3,loc2,loc3,loc2 + speed);
   if(!loc5)
   {
      zone.y += speed;
      f_Depth(zone,zone.y);
   }
   else
   {
      zone.body._y -= speed;
   }
}
function f_MoveCharH(zone, speed, recurse)
{
   if(console_version)
   {
      speed = f_Quantize(speed);
   }
   var loc6 = 0;
   zone.bounds = false;
   var loc7 = zone.n_groundtype;
   if(loc7 == undefined)
   {
      //trace("f_MoveCharH");
      //Error("Undefined Ground type!");
      zone.n_groundtype = 0;
      loc7 = 0;
   }
   if(zone.human and !zone.npc)
   {
      if(!zone.npc)
      {
         f_PlayerCheckPickups(zone);
         if(zone.onscreen)
         {
            if(f_SZ_PlayerXOnScreen(zone.x + speed))
            {
               if(f_SZ_PlayerWithinSafeScreen(zone,speed))
               {
                  zone.bounds = true;
               }
               else if(Math.abs(zone.x + speed + main.camera_x) <= Math.abs(zone.x + main.camera_x))
               {
                  zone.bounds = true;
               }
            }
         }
         else
         {
            zone.bounds = true;
         }
      }
      else
      {
         zone.bounds = true;
      }
   }
   else
   {
      zone.bounds = true;
   }
   if(zone.bounds)
   {
      if(f_HitWallH(zone,speed))
      {
         return false;
      }
      switch(loc7)
      {
         case 0:
         case 0:
            loc6 = f_PlainMCH(zone,speed);
            break;
         case 100:
         case 101:
            loc6 = f_StairsMCH(zone,speed);
            break;
         case 200:
            loc6 = f_DeathBoxMCH(zone,speed);
            break;
         case 300:
            loc6 = f_Water1MCH(zone,speed);
            break;
         case 301:
            loc6 = f_Water2MCH(zone,speed);
            break;
         case 302:
            //trace("f_MoveCharH");
            //Error("No Deep Water");
            break;
         case 400:
            if(!f_XBPortalThing(zone))
            {
               loc6 = f_InsideMCH(zone,speed);
            }
            break;
         case 500:
         case 600:
            f_LadderMCH(zone,speed);
            break;
         case 1000:
         case 1001:
            loc6 = f_TableMCH(zone,speed);
            break;
         default:
            //trace("f_MoveCharH");
            //Error(loc7);
            loc6 = f_InsideMCH(zone,speed);
      }
      zone._x = zone.x;
      zone._y = zone.y;
      f_LargeObjectRanges(zone);
      zone.body._y = zone.body_y + zone.body_table_y;
      zone.shadow_pt._x = zone._x;
      zone.shadow_pt._y = zone._y + zone.body_table_y;
      if(zone.horse)
      {
         f_SetXY(zone.horse,zone.x,zone.y - 1);
      }
      if(loc6 and !recurse)
      {
         f_MoveCharH(zone,speed * loc6,recurse + 1);
      }
      else
      {
         f_Depth(zone,zone.y);
      }
      if(zone.zone)
      {
         if(zone._xscale > 0)
         {
            zone.zone.x = zone.x + zone.zone._x;
         }
         else
         {
            zone.zone.x = zone.x - zone.zone._x;
         }
         zone.zone.y = zone.y + zone.zone._y;
      }
      if(zone.human and !zone.npc and !main.leash_right_x)
      {
         if(exits_total > 0)
         {
            var loc4 = 1;
            while(loc4 <= exits_total)
            {
               u_temp = exits["s" + int(loc4)];
               if(!u_temp.dug)
               {
                  if(Math.abs(u_temp.x - zone._x) <= u_temp.w)
                  {
                     if(Math.abs(u_temp.y - zone._y) <= u_temp.h)
                     {
                        u_temp.dug = true;
                        var loc3 = 1;
                        while(loc3 < 10)
                        {
                           _root["portal" + int(loc3)].open = false;
                           loc3 = loc3 + 1;
                        }
                        fader.f_FadeOut();
                        spawn_portal_num = u_temp.spawn_portal_num;
                        f_func = u_temp.fp_activate;
                        f_func(zone);
                        f_ChangeLevel(u_temp.target_level);
                     }
                  }
               }
               loc4 = loc4 + 1;
            }
         }
      }
      return true;
   }
   return false;
}
function f_PlainMCH(zone, speed)
{
   var loc6 = zone.x;
   var loc2 = zone.y;
   var loc3 = 0;
   var loc5 = 0;
   var loc11 = f_BSPHitTest(loc6,loc2,loc6 + speed,loc2);
   if(!loc11)
   {
      zone.x += speed;
      var loc13 = f_BSPHitTest(loc6,loc2,loc6,loc2 + 400) * 400;
      if(loc13)
      {
         var loc7 = f_BSPCheckLastHitType();
         if(loc7 == 3 or loc7 == 6 or (loc7 == 2 or loc7 == 5) and loc13 < 10)
         {
            n_slope = f_BSPCheckLastHitSlope();
            if(Math.abs(n_slope) > 0.1)
            {
               loc3 = n_slope * speed;
            }
         }
      }
   }
   else
   {
      loc7 = f_BSPCheckLastHitType();
      var loc9 = f_BSPCheckLastHitIndex();
      loc5 = 0.9 - loc11;
      if(loc5 < 0)
      {
         loc5 = 0;
      }
      var loc4 = loc6 + (loc11 + 0.0001) * speed;
      switch(loc7)
      {
         case 1:
            break;
         case 3:
            zone.hitwall_h = true;
         case 2:
            var loc16 = false;
            var loc14 = f_BSPHitTest(loc6,loc2,loc6,loc2 - 400);
            if(loc14)
            {
               if(loc9 == f_BSPCheckLastHitIndex())
               {
                  loc3 = loc14 * 400;
                  if(loc3 < 3)
                  {
                     loc3 = 3;
                  }
                  loc5 = 0;
                  loc16 = true;
               }
            }
            if(!loc16)
            {
               r = f_BSPHitTest(loc6,loc2,loc6,loc2 + 400);
               if(r)
               {
                  if(loc9 == f_BSPCheckLastHitIndex())
                  {
                     loc3 = - r * 400;
                     if(loc3 > -3)
                     {
                        loc3 = -3;
                     }
                     loc5 = 0;
                     loc16 = true;
                  }
               }
            }
            if(!loc16)
            {
               if(loc14 > r)
               {
                  loc3 = -3;
                  loc5 = 0;
               }
               else
               {
                  loc3 = 3;
                  loc5 = 0;
               }
            }
            break;
         case 4:
         case 5:
         case 6:
            loc16 = false;
            var loc12 = 90;
            HiFps_ResetRecursive(zone);
            if(Math.abs(f_BSPCheckLastHitSlope()) <= 0.1)
            {
               loc12 = 0;
            }
            loc14 = f_BSPHitTest(loc4,loc2,loc4,loc2 - 800);
            if(loc14)
            {
               if(loc9 != f_BSPCheckLastHitIndex())
               {
                  var loc8 = loc2 - (loc14 + 0.00001) * 800;
                  loc7 = f_BSPCheckLastHitType();
                  if(Math.abs(f_BSPCheckLastHitSlope()) <= 0.1)
                  {
                     loc12 = 0;
                  }
                  if(loc7 == 4 or loc7 == 5 or loc7 == 6)
                  {
                     var loc17 = loc2 + zone.body_y - loc8;
                     if(loc17 < loc12)
                     {
                        zone.x = loc4;
                        zone.body_y -= loc8 - zone.y;
                        zone.y = loc8;
                        f_Depth(zone,zone.y);
                        loc16 = true;
                        if(loc17 > 0)
                        {
                           zone.body_y = 0;
                           zone.body._y = zone.body_y;
                           zone.speed_jump = 0;
                           zone.jumping = false;
                           if(!zone.beefy)
                           {
                              zone.busy = true;
                              f_DashReset(zone);
                              zone.hanging = true;
                              zone.gotoAndStop("hanging");
                           }
                        }
                     }
                  }
               }
            }
            if(!loc16)
            {
               loc14 = f_BSPHitTest(loc4,loc2,loc4,loc2 + 800);
               if(loc14)
               {
                  if(loc9 != f_BSPCheckLastHitIndex())
                  {
                     loc8 = loc2 + (loc14 + 0.00001) * 800;
                     loc7 = f_BSPCheckLastHitType();
                     if(loc7 == 4 or loc7 == 5 or loc7 == 6)
                     {
                        if(!zone.horse and !zone.hanging)
                        {
                           var loc15 = - (loc8 - zone.y);
                           var loc18 = loc8 - zone.y;
                           if(f_SZ_OnScreenBody(loc4,loc8,zone.n_width,zone.body_y - loc18,loc15))
                           {
                              if(!zone.jumping)
                              {
                                 zone.jumped = true;
                                 zone.jumping = true;
                                 zone.blocking = false;
                                 zone.jump_attack = true;
                                 if(zone.dashing)
                                 {
                                    zone.dashjump = true;
                                 }
                                 else
                                 {
                                    zone.dashjump = false;
                                 }
                                 zone.speed_jump = 0;
                                 zone.gotoAndStop("jump");
                              }
                              zone.x = loc4;
                              zone.body_y_mod = loc15;
                              zone.body_y -= loc18;
                              zone.y = loc8;
                              f_Depth(zone,zone.y);
                           }
                        }
                     }
                  }
               }
               f_Depth(zone,zone.y);
            }
            break;
         case 100:
         case 101:
            zone.n_groundtype = 100;
            zone.x = loc4;
            break;
         case 200:
            zone.n_groundtype = 200;
            zone.x = loc4;
            break;
         case 300:
            zone.n_groundtype = 300;
            zone.x = loc4;
            break;
         case 400:
            if(zone.human and !zone.npc and !main.leash_right_x)
            {
               zone.n_groundtype = 400;
            }
            else
            {
               zone.x = loc4;
            }
            break;
         case 700:
            if(fp_FunctionLine)
            {
               if(speed > 0)
               {
                  zone.upright = true;
               }
               else
               {
                  zone.upright = false;
               }
               loc3 = 0;
               var loc19 = zone.x;
               zone.x = loc4;
               if(!fp_FunctionLine(zone))
               {
                  zone.x = loc19;
               }
            }
            break;
         case 1000:
            if(zone.body._y < -20)
            {
               zone.n_groundtype = 1000;
               zone.x = loc4;
               zone.body_y += 20;
               zone.body_table_y = -20;
               loc3 = 0;
               zone.shadow_pt.gotoAndStop("on");
               zone.shadow_pt._y = zone.body_table_y;
            }
            break;
         case 1001:
            break;
         default:
            //Error("f_PlainMCH");
      }
   }
   if(loc3 and loc5 == 0)
   {
      f_MoveCharV(zone,loc3,0);
   }
   return loc5;
}
function f_MoveCharV(zone, speed, recurse)
{
   if(console_version)
   {
      speed = f_Quantize(speed);
   }
   var loc6 = 0;
   var loc7 = zone.n_groundtype;
   if(loc7 == undefined)
   {
      //trace("f_MoveCharV");
      //Error("Undefined Ground type!");
      zone.n_groundtype = 0;
      loc7 = 0;
   }
   if(zone.human)
   {
      if(!zone.npc)
      {
         f_PlayerCheckPickups(zone);
         var loc8 = false;
         if(zone.onscreen)
         {
            if(f_SZ_PlayerYOnScreen(zone.y + speed))
            {
               loc8 = true;
            }
         }
         else
         {
            loc8 = true;
         }
         if(!f_SZ_PlayerYDiffMax(zone,speed))
         {
            loc8 = false;
         }
      }
      else
      {
         loc8 = true;
      }
   }
   else
   {
      loc8 = true;
   }
   if(loc8)
   {
      if(f_HitWallV(zone,speed))
      {
         return false;
      }
      switch(loc7)
      {
         case 0:
         case 0:
            loc6 = f_PlainMCV(zone,speed);
            break;
         case 100:
         case 101:
            loc6 = f_InsideMCV(zone,speed);
            break;
         case 200:
            loc6 = f_DeathBoxMCV(zone,speed);
            break;
         case 300:
            loc6 = f_Water1MCV(zone,speed);
            break;
         case 301:
            loc6 = f_Water2MCV(zone,speed);
            break;
         case 302:
            //trace("f_MoveCharV");
            //Error("No Deep Water");
            break;
         case 400:
            if(!f_XBPortalThing(zone))
            {
               loc6 = f_InsideMCV(zone,speed);
            }
            break;
         case 500:
            f_LadderMCV(zone,speed);
            break;
         case 600:
            f_SideLadderMCV(zone,speed);
            break;
         case 1000:
         case 1001:
            loc6 = f_TableMCV(zone,speed);
            break;
         default:
            //trace("f_MoveCharV");
            //Error(loc7);
            loc6 = f_InsideMCV(zone,speed);
      }
      zone._x = zone.x;
      zone._y = zone.y;
      zone.zone.y = zone.y + zone.zone._y;
      zone.body._y = zone.body_y + zone.body_table_y;
      zone.shadow_pt._x = zone.x;
      zone.shadow_pt._y = zone.y + zone.body_table_y;
      if(zone.horse)
      {
         f_SetXY(zone.horse,zone.x,zone.y - 1);
      }
      if(loc6 and !recurse)
      {
         f_MoveCharV(zone,speed * loc6,recurse + 1);
      }
      else
      {
         f_Depth(zone,zone.y);
      }
      if(zone.zone)
      {
         if(zone._xscale > 0)
         {
            zone.zone.x = zone.x + zone.zone._x;
         }
         else
         {
            zone.zone.x = zone.x - zone.zone._x;
         }
         zone.zone.y = zone.y + zone.zone._y;
      }
      if(zone.human and !zone.npc and !main.leash_right_x)
      {
         if(exits_total > 0)
         {
            var loc4 = 1;
            while(loc4 <= exits_total)
            {
               u_temp = exits["s" + int(loc4)];
               if(!u_temp.dug)
               {
                  if(Math.abs(u_temp.x - zone._x) <= u_temp.w)
                  {
                     if(Math.abs(u_temp.y - zone._y) <= u_temp.h)
                     {
                        u_temp.dug = true;
                        var loc3 = 1;
                        while(loc3 < 10)
                        {
                           _root["portal" + int(loc3)].open = false;
                           loc3 = loc3 + 1;
                        }
                        fader.f_FadeOut();
                        spawn_portal_num = u_temp.spawn_portal_num;
                        f_func = u_temp.fp_activate;
                        f_func(zone);
                        f_ChangeLevel(u_temp.target_level);
                     }
                  }
               }
               loc4 = loc4 + 1;
            }
         }
      }
      return true;
   }
   return false;
}
function f_SideLadder(zone)
{
   if(!zone.human and !zone.npc)
   {
      return false;
   }
   if(zone.punching or zone.blocking or zone.hanging or zone.beefy)
   {
      return false;
   }
   var loc7 = undefined;
   var loc6 = 999999999;
   var loc9 = false;
   var loc8 = 0;
   var loc5 = 0;
   var loc3 = _root.p_game["sl_top" + loc5];
   if(loc3 == undefined)
   {
      return false;
   }
   var loc4 = undefined;
   while(loc3 != undefined)
   {
      loc4 = Math.sqrt(Math.pow(zone.x - loc3._x,2) + Math.pow(zone.y - loc3._y,2));
      if(loc4 < 100 and loc4 < loc6)
      {
         loc6 = loc4;
         loc7 = loc3;
         loc8 = loc5;
         loc9 = true;
      }
      loc5 = loc5 + 1;
      loc3 = _root.p_game["sl_top" + loc5];
   }
   loc5 = 0;
   loc3 = _root.p_game["sl_bot" + loc5];
   if(loc3 == undefined)
   {
      return false;
   }
   while(loc3 != undefined)
   {
      loc4 = Math.sqrt(Math.pow(zone.x - loc3._x,2) + Math.pow(zone.y - loc3._y,2));
      if(loc4 < 100 and loc4 < loc6)
      {
         loc6 = loc4;
         loc7 = loc3;
         loc8 = loc5;
         loc9 = false;
      }
      loc5 = loc5 + 1;
      loc3 = _root.p_game["sl_bot" + loc5];
   }
   if(loc7 == undefined)
   {
      return false;
   }
   if(loc9)
   {
      var loc11 = zone.y + 10;
      q = f_BSPHitTest(zone.x,loc11,zone.x,loc11 + 1000);
      n_type = f_BSPCheckLastHitType();
      if(!q)
      {
         return false;
      }
      loc11 += (q + 0.0001) * 1000;
      if(!zone.horse)
      {
         var loc13 = - (loc11 - zone.y);
         var loc14 = loc11 - zone.y;
         if(!zone.jumping)
         {
            zone.jumped = true;
            zone.jumping = true;
            zone.blocking = false;
            zone.jump_attack = true;
            if(zone.dashing)
            {
               zone.dashjump = true;
            }
            else
            {
               zone.dashjump = false;
            }
            zone.speed_jump = 0;
            zone.gotoAndStop("jump");
         }
         zone.body_y_mod = loc13;
         zone.body_y -= loc14;
         zone.y = loc11;
         f_Depth(zone,zone.y);
      }
      return true;
   }
   var loc12 = p_game["sl_top" + loc8];
   var loc10 = loc7;
   if(zone.body_y < loc12._y - loc10._y + 40)
   {
      return false;
   }
   if(Math.abs((-30 + zone.body_y) * zone.ladder_slope) >= 40)
   {
      return false;
   }
   zone.ladder_endpt_top = loc12;
   zone.ladder_endpt_bot = loc10;
   zone.ladder_slope = (loc12._x - loc10._x) / (loc12._y - loc10._y);
   zone.y = loc10._y - 30 + zone.body_y;
   zone.x = loc10._x + (-30 + zone.body_y) * zone.ladder_slope;
   zone.body_y = 0;
   zone.gotoAndStop("sideclimb_up");
   zone.n_groundtype = 600;
   f_Depth(zone,zone.y);
   zone.shadow_pt.gotoAndStop("off");
   zone.busy = true;
   zone.ladder = true;
   zone.punching = false;
   zone.jumping = false;
   zone.jumped = false;
   zone.blocking = false;
   zone.hanging = false;
   zone.dashing = false;
   zone.jump_attack = true;
   return true;
}
function f_SideLadderProjectile(zone)
{
   var loc7 = undefined;
   var loc6 = 999999999;
   var loc9 = false;
   var loc8 = 0;
   var loc5 = 0;
   var loc2 = _root.p_game["sl_top" + loc5];
   if(loc2 == undefined)
   {
      return false;
   }
   var loc3 = undefined;
   while(loc2 != undefined)
   {
      loc3 = Math.sqrt(Math.pow(zone.x - loc2._x,2) + Math.pow(zone.y - loc2._y,2));
      if(loc3 < 100 and loc3 < loc6)
      {
         loc6 = loc3;
         loc7 = loc2;
         loc8 = loc5;
         loc9 = true;
      }
      loc5 = loc5 + 1;
      loc2 = _root.p_game["sl_top" + loc5];
   }
   loc5 = 0;
   loc2 = _root.p_game["sl_bot" + loc5];
   if(loc2 == undefined)
   {
      return false;
   }
   while(loc2 != undefined)
   {
      loc3 = Math.sqrt(Math.pow(zone.x - loc2._x,2) + Math.pow(zone.y - loc2._y,2));
      if(loc3 < 100 and loc3 < loc6)
      {
         loc6 = loc3;
         loc7 = loc2;
         loc8 = loc5;
         loc9 = false;
      }
      loc5 = loc5 + 1;
      loc2 = _root.p_game["sl_bot" + loc5];
   }
   if(loc7 == undefined)
   {
      return f_LedgeProjectile(zone);
   }
   if(loc9)
   {
      var loc10 = zone.y + 10;
      q = f_BSPHitTest(zone.x,loc10,zone.x,loc10 + 1000);
      n_type = f_BSPCheckLastHitType();
      if(!q)
      {
         return false;
      }
      loc10 += (q + 0.0001) * 1000;
      var loc12 = loc10 - zone.y;
      zone.body._y -= loc12;
      zone.y = loc10;
      f_Depth(zone,zone.y);
      return true;
   }
   var loc13 = p_game["sl_top" + loc8];
   var loc11 = loc7;
   if(zone.body._y > loc13._y - loc11._y - 20)
   {
      return false;
   }
   loc10 = zone.y - 10;
   q = f_BSPHitTest(zone.x,loc10,zone.x,loc10 - 1000);
   n_type = f_BSPCheckLastHitType();
   if(!q)
   {
      return false;
   }
   loc10 += (q + 0.0001) * -1000;
   loc12 = loc10 - zone.y;
   zone.body._y -= loc12;
   zone.y = loc10;
   f_Depth(zone,zone.y);
   return true;
}
function f_LedgeProjectile(zone)
{
   zone.shadow_pt.gotoAndStop("off");
   return true;
}
function f_CheckInsideBSP(zone)
{
   if(!cinema and !zone.ladder)
   {
      var loc2 = f_BSPHitTest(zone.x,zone.y,zone.x,zone.y - 1000);
      if(!loc2)
      {
         f_WarpIn(zone);
         zone.warp_timer = -30;
         return undefined;
      }
      loc2 = f_BSPHitTest(zone.x,zone.y,zone.x,zone.y + 1000);
      if(!loc2)
      {
         f_WarpIn(zone);
         zone.warp_timer = -30;
      }
   }
}
function f_HudColor(zone)
{
   f_ColorSwap(zone.stats,zone._parent.charcolor);
}
function f_HudSetProfile(zone, u_num, last_up)
{
   zone.profile.gotoAndStop(u_num);
   zone.available = true;
   zone.last_up = last_up;
   var loc2 = undefined;
   var loc1 = 1;
   while(loc1 <= players)
   {
      loc2 = loader.game.game["p" + int(loc1)];
      if(loc2.p_type == u_num and loc2.alive)
      {
         zone.available = false;
      }
      loc1 = loc1 + 1;
   }
   if(!zone.available)
   {
      if(last_up)
      {
         if(u_num < 4)
         {
            f_HudSetProfile(zone,u_num + 1,true);
         }
         else
         {
            f_HudSetProfile(zone,1,true);
         }
      }
      else if(u_num > 1)
      {
         f_HudSetProfile(zone,u_num - 1,false);
      }
      else
      {
         f_HudSetProfile(zone,4,false);
      }
   }
}
function f_HudCheckStart(zone)
{
   if(zone.vy < 0)
   {
      return undefined;
   }
   if(zone.port > 0)
   {
      if(Key.isDown(zone.button_start))
      {
         zone.pressed_start = true;
         zone.gotoAndStop("select");
         f_HudSetProfile(zone,int(zone.player_num),true);
      }
   }
   else if(zone.player_num == next_hud)
   {
      if(Key.isDown(49))
      {
         var loc4 = true;
         var loc3 = 1;
         while(loc3 <= 4)
         {
            if(_root["hud" + int(loc3)].port == 1)
            {
               loc4 = false;
            }
            loc3 = loc3 + 1;
         }
         if(loc4 == true)
         {
            zone.port = 1;
            zone.active = true;
            f_GetButtons(zone);
            next_hud++;
            return undefined;
         }
      }
      if(Key.isDown(50))
      {
         loc4 = true;
         loc3 = 1;
         while(loc3 <= 4)
         {
            if(_root["hud" + int(loc3)].port == 2)
            {
               loc4 = false;
            }
            loc3 = loc3 + 1;
         }
         if(loc4 == true)
         {
            zone.port = 2;
            zone.active = true;
            f_GetButtons(zone);
            next_hud++;
            return undefined;
         }
      }
      if(Key.isDown(51))
      {
         loc4 = true;
         loc3 = 1;
         while(loc3 <= 4)
         {
            if(_root["hud" + int(loc3)].port == 3)
            {
               loc4 = false;
            }
            loc3 = loc3 + 1;
         }
         if(loc4 == true)
         {
            zone.port = 3;
            zone.active = true;
            f_GetButtons(zone);
            next_hud++;
            return undefined;
         }
      }
      if(Key.isDown(52))
      {
         loc4 = true;
         loc3 = 1;
         while(loc3 <= 4)
         {
            if(_root["hud" + int(loc3)].port == 4)
            {
               loc4 = false;
            }
            loc3 = loc3 + 1;
         }
         if(loc4 == true)
         {
            zone.port = 4;
            zone.active = true;
            f_GetButtons(zone);
            next_hud++;
            return undefined;
         }
      }
      if(Key.isDown(133))
      {
         loc4 = true;
         loc3 = 1;
         while(loc3 <= 4)
         {
            if(_root["hud" + int(loc3)].port == 5)
            {
               loc4 = false;
            }
            loc3 = loc3 + 1;
         }
         if(loc4 == true)
         {
            zone.port = 5;
            zone.active = true;
            f_GetButtons(zone);
            next_hud++;
            return undefined;
         }
      }
      if(Key.isDown(155))
      {
         loc4 = true;
         loc3 = 1;
         while(loc3 <= 4)
         {
            if(_root["hud" + int(loc3)].port == 6)
            {
               loc4 = false;
            }
            loc3 = loc3 + 1;
         }
         if(loc4 == true)
         {
            zone.port = 6;
            zone.active = true;
            f_GetButtons(zone);
            next_hud++;
            return undefined;
         }
      }
      if(Key.isDown(177))
      {
         loc4 = true;
         loc3 = 1;
         while(loc3 <= 4)
         {
            if(_root["hud" + int(loc3)].port == 7)
            {
               loc4 = false;
            }
            loc3 = loc3 + 1;
         }
         if(loc4 == true)
         {
            zone.port = 7;
            zone.active = true;
            f_GetButtons(zone);
            next_hud++;
            return undefined;
         }
      }
      if(Key.isDown(199))
      {
         loc4 = true;
         loc3 = 1;
         while(loc3 <= 4)
         {
            if(_root["hud" + int(loc3)].port == 8)
            {
               loc4 = false;
            }
            loc3 = loc3 + 1;
         }
         if(loc4 == true)
         {
            zone.port = 8;
            zone.active = true;
            f_GetButtons(zone);
            next_hud++;
            return undefined;
         }
      }
   }
   if(zone.port > 0)
   {
      if(Key.isDown(zone.button_start))
      {
         zone.pressed_start = true;
         zone.gotoAndStop("select");
         f_HudSetProfile(zone,int(zone.player_num),true);
      }
   }
}
function f_HudPressedSelect(zone)
{
   if(zone.available)
   {
      zone.p_type = zone.profile.player_type;
      if(zone.p_type == 1)
      {
         zone.charcolor = color_green;
      }
      else if(zone.p_type == 2)
      {
         zone.charcolor = color_red;
      }
      else if(zone.p_type == 3)
      {
         zone.charcolor = color_blue;
      }
      else if(zone.p_type == 4)
      {
         zone.charcolor = color_orange;
      }
      else
      {
         zone.charcolor = _root.char_colors[zone.p_type];
      }
      var loc7 = undefined;
      var loc3 = undefined;
      var loc5 = undefined;
      if(main.n_bottomplayer)
      {
         var loc10 = playerArrayOb["p_pt" + int(main.n_bottomplayer)];
         loc3 = loc10.x;
         loc5 = loc10.y;
         loc7 = loc10.n_groundtype;
      }
      else
      {
         loc3 = _root.main.last_good_player_x;
         loc5 = _root.main.last_good_player_y;
         loc7 = _root.main.last_good_groundtype;
      }
      var loc8 = loc3 + 50;
      if(random(2))
      {
         loc8 = loc3 - 50;
      }
      var loc11 = loc8 - loc3;
      var loc9 = _root.f_BSPHitTest(loc3,loc5,loc8,loc5) * 0.8;
      if(!loc9)
      {
         loc9 = 1;
      }
      var loc6 = loc3 + loc9 * loc11;
      var loc4 = loc5;
      if(main.n_bottomplayer and (!f_SZ_PlayerXOnScreenMax(loc6) or !f_SZ_PlayerYOnScreen(loc4)))
      {
         loc6 = loc3;
         loc4 = loc5;
      }
      f_ResetPlayerInfoAndStats(zone);
      if(loc7 == 50)
      {
         f_FX(loc6 - 110,loc4 + 10,loc4 + 15,"ground_slam",100,100);
         zone.player_pt = f_SpawnPlayer(zone.player_num,zone.p_type,loc6,loc4);
         zone.player_pt._y = zone.player_pt.y;
         zone.player_pt.shadow_pt._y = zone.player_pt._y;
         zone.player_pt.body_y = 0;
         zone.player_pt.body_table_y = 0;
         zone.player_pt.body_y_mod = 0;
         zone.player_pt.jumped = false;
         zone.player_pt.jumping = false;
         f_ShadowSize(zone.player_pt);
         zone.player_pt.busy = true;
         zone.player_pt.ladder = true;
         zone.player_pt.n_groundtype = loc7;
         zone.player_pt.gotoAndStop("climb");
         zone.player_pt.body.body.stop();
         f_PlayerArray();
      }
      else
      {
         zone.player_pt = f_SpawnPlayer(zone.player_num,zone.p_type,loc6,loc4);
         zone.player_pt._y = zone.player_pt.y;
         zone.player_pt.shadow_pt._y = zone.player_pt._y;
         zone.player_pt.body_y = 0;
         zone.player_pt.body_table_y = 0;
         zone.player_pt.body_y_mod = 0;
         f_ShadowSize(zone.player_pt);
         zone.player_pt.jumped = false;
         zone.player_pt.jumping = false;
         zone.player_pt.ladder = false;
         zone.player_pt.busy = false;
         zone.player_pt.speed_jump = 10;
         zone.player_pt.n_groundtype = loc7;
         if(level == 23)
         {
            zone.player_pt.fp_StandAnim = f_SwimStand;
            zone.player_pt.fp_WalkAnim = f_SwimWalk;
            if(zone.player_pt.p_type == 33 && zone.player_pt.undead) { // Fixing cyclops dual stand anim causing flicker with standard f_SwimStand
               zone.player_pt.fp_StandAnim = f_StandTypeUndead;
               zone.player_pt.fp_WalkAnim = f_WalkTypeUndead;
            }
            zone.player_pt.body_y = -500;
            zone.player_pt.body._y = -500;
            zone.player_pt.jump_speed_y;
            f_Depth(zone.player_pt,zone.player_pt.y);
            f_JumpAction(zone.player_pt);
            zone.player_pt.speed_jump = 0;
            f_PlayerArray();
         }
         else if(level == 22)
         {
            zone.player_pt.horse = _root.p_game["deer" + zone.player_num];
            zone.player_pt.fp_HorseRide = _root.f_HorseRide;
            zone.player_pt.body_y = - zone.player_pt.horse.h;
            f_SetXY(zone.player_pt,zone.player_pt.horse.x,zone.player_pt.horse._y + 1);
            f_Depth(zone.player_pt,zone.player_pt.y);
            f_PlayerArray();
            if(zone.player_pt.fp_HorseRide)
            {
               zone.player_pt.fp_HorseRide(zone.player_pt);
            }
         }
         else
         {
            zone.player_pt.gotoAndStop("spawn");
         }
      }
      zone.gotoAndStop("stats");
   }
}
function f_HudSelect(zone)
{
   f_HudSetProfile(zone,zone.profile._currentframe,zone.last_up);
   if(Key.isDown(zone.button_right))
   {
      if(!zone.pressed_right)
      {
         zone.pressed_right = true;
         if(zone.profile._currentframe < 4)
         {
            f_HudSetProfile(zone,zone.profile._currentframe + 1,true);
         }
         else
         {
            f_HudSetProfile(zone,1,true);
         }
      }
   }
   else
   {
      zone.pressed_right = false;
   }
   if(Key.isDown(zone.button_left))
   {
      if(!zone.pressed_left)
      {
         zone.pressed_left = true;
         if(zone.profile._currentframe > 1)
         {
            f_HudSetProfile(zone,zone.profile._currentframe - 1,false);
         }
         else
         {
            f_HudSetProfile(zone,4,false);
         }
      }
   }
   else
   {
      zone.pressed_left = false;
   }
   if(Key.isDown(zone.button_accept))
   {
      f_HudPressedSelect(zone);
   }
   else if(Key.isDown(zone.button_start))
   {
      if(!zone.pressed_start)
      {
         zone.pressed_start = true;
         f_HudPressedSelect(zone);
      }
   }
   else
   {
      zone.pressed_start = false;
   }
}
function f_HudSlide(zone)
{
   zone._visible = !GetFlashGlobal("g_bHudHidden") && zone.active;
   if(zone.active)
   {
      var loc4 = GetFlashGlobal("g_nPort" + int(zone.port) + "State");
      if(loc4 == 2)
      {
         zone.was_paused = true;
         f_ClearButtons(zone);
         if(zone.player_pt)
         {
            f_ClearButtons(zone.player_pt);
         }
      }
      else
      {
         if(loc4 == 0)
         {
            zone.dropped = true;
            zone.active = false;
            zone.player_pt.health = 0;
            f_CheckHealth(zone.player_pt);
         }
         else if(loc4 == 3)
         {
            _root.f_ChangeLevel("../map/map.swf");
            SetPortState(int(zone.port),1);
         }
         if(zone.was_paused)
         {
            zone.was_paused = false;
            f_GetButtons(zone);
            if(zone.player_pt)
            {
               f_CopyButtons(zone.player_pt,zone);
            }
         }
      }
      if(zone.player_pt)
      {
         f_UpdateOverlay(zone.player_pt);
      }
   }
   if(zone.vy < 0)
   {
      zone._y += zone.vy;
      zone.vy -= 2;
      if(zone._y < -200)
      {
         zone._y = -200;
      }
   }
   else if(zone.vy > 0)
   {
      if(zone.slideWait > 0)
      {
         zone.slideWait = zone.slideWait - 1;
      }
      else
      {
         zone._y += (_root.hud_start_y - zone._y) / 3;
         if(zone._y > _root.hud_start_y)
         {
            zone.vy = 0;
            zone._y = _root.hud_start_y;
            zone.slideWait = 60;
         }
      }
   }
   if(!zone.active)
   {
      return undefined;
   }
   if(zone.player_pt)
   {
      var loc3 = zone.player_pt.gold;
   }
   else
   {
      loc3 = zone.goldcounter_targ;
   }
   if(zone.goldcounter_targ != loc3)
   {
      if(zone.goldchangetimer == 0 and zone.goldcounter == zone.goldcounter_targ)
      {
         zone.goldchangetimer = 30;
      }
      zone.goldshowtimer = 35;
      zone.goldcounter_targ = loc3;
      zone.stats.goldstats._visible = true;
   }
   if(zone.goldchangetimer)
   {
      zone.goldchangetimer = zone.goldchangetimer - 1;
   }
   if(zone.goldchangetimer == 0)
   {
      if(zone.goldcounter != zone.goldcounter_targ)
      {
         if(zone.goldcounter > zone.goldcounter_targ)
         {
            zone.goldcounter -= 1;
         }
         else
         {
            zone.goldcounter += 1;
         }
         zone.stats.goldstats._xscale = 140;
         zone.stats.goldstats.goldicon.gotoAndPlay(2);
      }
      else if(zone.goldshowtimer)
      {
         zone.goldshowtimer = zone.goldshowtimer - 1;
      }
      else
      {
         zone.stats.goldstats._visible = false;
      }
   }
   if(_root.store)
   {
      zone.stats.goldstats._visible = true;
   }
   if(zone.stats.goldstats)
   {
      zone.stats.goldstats._xscale = Math.max(100,zone.stats.goldstats._xscale - 2);
      zone.stats.goldstats._yscale = zone.stats.goldstats._xscale;
      if(console_version)
      {
         SetTextNumeric(zone.stats.gold.goldtext.gold,zone.goldcounter);
         SetTextNumeric(zone.stats.gold.goldtext.goldbg,zone.goldcounter);
      }
      else
      {
         zone.stats.gold.goldtext.gold.text = zone.goldcounter;
         zone.stats.gold.goldtext.goldbg.text = zone.goldcounter;
      }
   }
}
function f_ResetHudGoldCounters()
{
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc2 = _root["hud" + int(loc3)];
      if(loc2.active)
      {
         loc2.goldcounter = loc2.gold;
         loc2.goldchangetimer = 0;
         loc2.goldshowtimer = 0;
         loc2.goldcounter_targ = loc2.gold;
         loc2.stats.goldstats._visible = false;
      }
      loc3 = loc3 + 1;
   }
}
function f_HideHud(zone)
{
   zone._y = -200;
}
function f_HudInit(zone)
{
   zone.last_up = true;
   zone.vy = -1;
   zone.stats.goldstats._visible = false;
   zone.goldcounter = 0;
   zone.goldshowtimer = 0;
   zone.goldchangetimer = 0;
   zone.goldcounter_targ = 0;
   zone.show_gold = false;
}
function f_PositionHud()
{
   var loc3 = SCREEN_WIDTH / 6;
   var loc4 = (SCREEN_WIDTH - loc3 * 2) / 3;
   var loc2 = 1;
   while(loc2 <= 4)
   {
      _root["hud" + int(loc2)]._x = Math.round(loc3 + loc4 * (loc2 - 1));
      _root["hud" + int(loc2)]._y = -200;
      _root["hud" + int(loc2)].vy = 0;
      _root["hud" + int(loc2)].fp_HudTick = f_HudSlide;
      _root["hud" + int(loc2)].slideWait = 60;
      loc2 = loc2 + 1;
   }
   _root.healthmeter._x = Math.round(SCREEN_WIDTH / 2);
   _root.go_arrow._x = SCREEN_WIDTH - 200;
   _root.vs_cinema._x = HALF_SCREEN_WIDTH;
   if(IsPalMode())
   {
      _root.healthmeter._y += 96;
      _root.vs_cinema._y += 20;
   }
   if(GetWidescreen() == false)
   {
      _root.hud_start_y = 78;
   }
   else
   {
      _root.hud_start_y = 70;
   }
}
function f_InactiveHudOff()
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = this["hud" + loc2];
      if(!loc3.player_pt)
      {
         loc3.gotoAndStop("wait");
      }
      loc2 = loc2 + 1;
   }
}
function f_HudWait()
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = this["hud" + loc2];
      loc3.vy = -1;
      loc2 = loc2 + 1;
   }
}
function f_HudWaitNow()
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = this["hud" + loc2];
      loc3.vy = -1;
      loc3._y = -200;
      loc2 = loc2 + 1;
   }
}
function f_HudWaitAll()
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = this["hud" + loc2];
      loc3.vy = -1;
      loc2 = loc2 + 1;
   }
}
function f_HudWaitEnd(skip)
{
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc2 = this["hud" + loc3];
      if(loc2.player_pt and loc2.player_pt.alive)
      {
         loc2.gotoAndStop("stats");
         if(!skip)
         {
            loc2.player_pt.overlay.gotoAndStop("name");
            loc2.player_pt.overlay.nameoverlay.gotoAndPlay(2);
         }
      }
      else if(loc2._currentframe == 1 or loc2._currentframe == 6)
      {
         if(console_version)
         {
            loc2.gotoAndStop("wait");
         }
         else
         {
            loc2.gotoAndStop("press_start");
         }
      }
      loc2.vy = 1;
      loc3 = loc3 + 1;
   }
}
function f_UnlockAnimalAchievement(zone)
{
   var loc3 = 0;
   var loc2 = 1;
   while(loc2 <= 28)
   {
      if(zone.hud_pt.animal_unlocks[loc2] == true)
      {
         loc3 = loc3 + 1;
      }
      loc2 = loc2 + 1;
   }
   if(loc3 == 28)
   {
      _root.f_UpdateAchievement("AnimalHandler",zone.hud_pt.port,1);
   }
}
function f_UnlockAnimal(zone, item)
{
   if(item == 1)
   {
      UnlockAvatarItem(zone.hud_pt.port - 1,1);
   }
   if(unlock_display._currentframe > 1)
   {
      f_PushUnlockDisplay(f_UnlockAnimal,zone,item);
      return undefined;
   }
   LOGPush(8,item,zone.hud_pt.port);
   unlock_display.frame = 7;
   unlock_display.item = item;
   unlock_display.gamertag = GetLocalGamerTag(zone.hud_pt.port - 1);
   unlock_display.gotoAndPlay(2);
   unlock_display.nurse.gotoAndPlay(2);
}
function f_UnlockCharacter(zone, item)
{
   var loc2 = 2;
   switch(item)
   {
      case 5:
         loc2 = 2;
         break;
      case 6:
         loc2 = 19;
         break;
      case 7:
         loc2 = 10;
         break;
      case 8:
         loc2 = 18;
         break;
      case 9:
         loc2 = 34;
         break;
      case 10:
         loc2 = 27;
         break;
      case 11:
         loc2 = 47;
         break;
      case 12:
         loc2 = 36;
         break;
      case 13:
         loc2 = 12;
         break;
      case 14:
         loc2 = 33;
         break;
      case 15:
         loc2 = 15;
         break;
      case 16:
         loc2 = 15;
         break;
      case 17:
         loc2 = 6;
         break;
      case 18:
         loc2 = 45;
         break;
      case 19:
         loc2 = 26;
         break;
      case 20:
         loc2 = 57;
         break;
      case 21:
         loc2 = 43;
         break;
      case 22:
         loc2 = 20;
         break;
      case 23:
         loc2 = 2;
         break;
      case 24:
         loc2 = 35;
         break;
      case 25:
         loc2 = 31;
         break;
      case 26:
         loc2 = 48;
         break;
      case 27:
         loc2 = 50;
         break;
      case 28:
         loc2 = 68;
         break;
      case 29:
         loc2 = 63;
         break;
      case 30:
         loc2 = 85;
         break;
      case 31:
         loc2 = 84;
   }
   _root.f_SetWeaponUnlocked(zone,int(weapon_offset + loc2),true);
   var loc3 = save_data_info.char_offset + save_data_info.char_size * int(f_GetSaveDataOffset(item));
   WriteStorage(zone.hud_pt.port - 1,loc3,128);
   zone.hud_pt.characterunlock = item;
}
function f_UnlockItem(zone, item)
{
   if(unlock_display._currentframe > 1)
   {
      f_PushUnlockDisplay(f_UnlockItem,zone,item);
      return undefined;
   }
   LOGPush(6,item,zone.hud_pt.port);
   if(item >= weapon_offset)
   {
      _root.f_SetWeaponUnlocked(zone,item,true);
      unlock_display.gamertag = GetLocalGamerTag(zone.hud_pt.port - 1);
      unlock_display.gotoAndPlay(2);
      unlock_display.frame = 9;
      unlock_display.item = item - weapon_offset;
      unlock_display.blacksmith.gotoAndPlay(2);
   }
   else
   {
      zone.hud_pt.item_unlocks[item] = true;
      unlock_display.gamertag = GetLocalGamerTag(zone.hud_pt.port - 1) + " (" + zone.hud_pt.player_num + ")";
      unlock_display.gotoAndPlay(2);
      unlock_display.frame = 10;
      unlock_display.item = item;
      unlock_display.king.gotoAndPlay(2);
      unlock_display.arrow_type = zone.arrow_type;
   }
}
function f_UnlockCombo(zone, level)
{
   if(unlock_display._currentframe > 1)
   {
      f_PushUnlockDisplay(f_UnlockCombo,zone,level);
      return undefined;
   }
   var loc1 = 0;
   switch(level)
   {
      case 2:
         loc1 = 1;
         break;
      case 4:
         loc1 = 2;
         break;
      case 8:
         loc1 = 3;
         break;
      case 16:
         loc1 = 4;
         break;
      case 32:
         loc1 = 5;
         break;
      case 50:
         loc1 = 6;
   }
   if(loc1 > 0)
   {
      unlock_display.frame = loc1;
      var loc2 = GetLocalGamerTag(zone.hud_pt.port - 1) + " (" + zone.hud_pt.player_num + ")";
      unlock_display.gamertag = loc2;
      unlock_display.gotoAndPlay(2);
      unlock_display.king.gotoAndPlay(2);
   }
}
function f_DisplayUnlockMagic(zone, magic_frame)
{
   if(unlock_display._currentframe > 1)
   {
      f_PushUnlockDisplay(f_DisplayUnlockMagic,zone,magic_frame);
      return undefined;
   }
   unlock_display.frame = magic_frame;
   var loc1 = GetLocalGamerTag(zone.port - 1) + " (" + zone.player_num + ")";
   unlock_display.gamertag = loc1;
   unlock_display.gotoAndPlay(2);
   unlock_display.king.gotoAndPlay(2);
}
function f_PushUnlockDisplay(fp_Unlock, zone, item)
{
   var loc1 = 0;
   while(loc1 < 10)
   {
      if(!unlock_display.unlockfunc[loc1])
      {
         unlock_display.unlockfunc[loc1] = fp_Unlock;
         unlock_display.unlockzone[loc1] = zone;
         unlock_display.unlockitem[loc1] = item;
         return undefined;
      }
      loc1 = loc1 + 1;
   }
}
function f_PopUnlockDisplay()
{
   var loc1 = 0;
   while(loc1 < 10)
   {
      if(unlock_display.unlockfunc[loc1])
      {
         var loc2 = unlock_display.unlockfunc[loc1];
         loc2(unlock_display.unlockzone[loc1],unlock_display.unlockitem[loc1]);
         unlock_display.unlockfunc[loc1] = undefined;
         unlock_display.unlockitem[loc1] = undefined;
         unlock_display.unlockzone[loc1] = undefined;
         return undefined;
      }
      loc1 = loc1 + 1;
   }
}
function f_ClearUnlockDisplay()
{
   var loc1 = 0;
   while(loc1 < 10)
   {
      unlock_display.unlockfunc[loc1] = undefined;
      unlock_display.unlockitem[loc1] = undefined;
      unlock_display.unlockzone[loc1] = undefined;
      loc1 = loc1 + 1;
   }
   unlock_display.gotoAndStop(1);
   unlock_display.king.gotoAndStop(1);
   unlock_display.nurse.gotoAndStop(1);
   unlock_display.blacksmith.gotoAndStop(1);
   animals.gotoAndStop("blank");
   player.gotoAndStop("blank");
}
function f_ColorSwap(zone, u_color)
{
   CharacterColor = new Color(zone);
   CharacterColor.setTransform(u_color);
}
function f_NewColor(u_color)
{
   u_color.ra = 100;
   u_color.ga = 100;
   u_color.ba = 100;
   u_color.aa = 100;
   u_color.rb = 0;
   u_color.gb = 0;
   u_color.bb = 0;
   u_color.ab = 0;
}
function f_InitCharColors()
{
   char_colors = new Array(save_data_info.num_characters + 1);
   var loc1 = 0;
   while(loc1 <= save_data_info.num_characters)
   {
      char_colors[loc1] = new Object();
      f_NewColor(char_colors[loc1]);
      loc1 = loc1 + 1;
   }
   char_colors[0] = color_dark;
   char_colors[1].ra = 23.529411764705884;
   char_colors[1].ga = 43.92156862745098;
   char_colors[1].ba = 18.43137254901961;
   char_colors[2].ra = 59.6078431372549;
   char_colors[2].ga = 0.3921568627450981;
   char_colors[2].ba = 0.3921568627450981;
   char_colors[3].ra = 38.03921568627451;
   char_colors[3].ga = 62.352941176470594;
   char_colors[3].ba = 98.82352941176471;
   char_colors[4].ra = 87.84313725490196;
   char_colors[4].ga = 47.84313725490196;
   char_colors[4].ba = 8.627450980392158;
   char_colors[5].ra = 61.568627450980394;
   char_colors[5].ga = 61.568627450980394;
   char_colors[5].ba = 61.568627450980394;
   char_colors[6].ra = 77.64705882352942;
   char_colors[6].ga = 63.92156862745099;
   char_colors[6].ba = 32.54901960784314;
   char_colors[7].ra = 77.64705882352942;
   char_colors[7].ga = 63.92156862745099;
   char_colors[7].ba = 32.54901960784314;
   char_colors[8].ra = 41.568627450980394;
   char_colors[8].ga = 21.568627450980394;
   char_colors[8].ba = 33.72549019607843;
   char_colors[9].ra = 17.647058823529413;
   char_colors[9].ga = 17.647058823529413;
   char_colors[9].ba = 17.647058823529413;
   char_colors[10].ra = 43.92156862745098;
   char_colors[10].ga = 77.64705882352942;
   char_colors[10].ba = 99.6078431372549;
   char_colors[11].ra = 30.196078431372552;
   char_colors[11].ga = 16.862745098039216;
   char_colors[11].ba = 50.196078431372555;
   char_colors[12].ra = 100;
   char_colors[12].ga = 41.568627450980394;
   char_colors[12].ba = 16.862745098039216;
   char_colors[13].ra = 33.333333333333336;
   char_colors[13].ga = 35.294117647058826;
   char_colors[13].ba = 24.705882352941178;
   char_colors[14].ra = 63.92156862745099;
   char_colors[14].ga = 93.33333333333334;
   char_colors[14].ba = 33.333333333333336;
   char_colors[15].ra = 44.70588235294118;
   char_colors[15].ga = 32.54901960784314;
   char_colors[15].ba = 15.294117647058824;
   char_colors[16].ra = 67.45098039215686;
   char_colors[16].ga = 48.62745098039216;
   char_colors[16].ba = 17.647058823529413;
   char_colors[17].ra = 58.82352941176471;
   char_colors[17].ga = 11.372549019607844;
   char_colors[17].ba = 40;
   char_colors[18].ra = 90.58823529411765;
   char_colors[18].ga = 58.03921568627452;
   char_colors[18].ba = 36.07843137254902;
   char_colors[19].ra = 98.43137254901961;
   char_colors[19].ga = 65.09803921568628;
   char_colors[19].ba = 65.09803921568628;
   char_colors[20].ra = 58.82352941176471;
   char_colors[20].ga = 11.372549019607844;
   char_colors[20].ba = 40;
   char_colors[21].ra = 58.82352941176471;
   char_colors[21].ga = 11.372549019607844;
   char_colors[21].ba = 40;
   char_colors[22].ra = 77.64705882352942;
   char_colors[22].ga = 63.92156862745099;
   char_colors[22].ba = 32.54901960784314;
   char_colors[23].ra = 61.568627450980394;
   char_colors[23].ga = 61.568627450980394;
   char_colors[23].ba = 61.568627450980394;
   char_colors[24].ra = 100;
   char_colors[24].ga = 100;
   char_colors[24].ba = 16.862745098039216;
   char_colors[25].ra = 61.568627450980394;
   char_colors[25].ga = 61.568627450980394;
   char_colors[25].ba = 61.568627450980394;
   char_colors[26].ra = 18.03921568627451;
   char_colors[26].ga = 56.078431372549026;
   char_colors[26].ba = 72.15686274509804;
   char_colors[27].ra = 23.529411764705884;
   char_colors[27].ga = 27.84313725490196;
   char_colors[27].ba = 66.66666666666667;
   char_colors[28].ra = 95.68627450980392;
   char_colors[28].ga = 0.7843137254901962;
   char_colors[28].ba = 0.7843137254901962;
   char_colors[29].ra = 94.11764705882354;
   char_colors[29].ga = 48.235294117647065;
   char_colors[29].ba = 60.00000000000001;
   char_colors[30].ra = 41.1764705882353;
   char_colors[30].ga = 23.92156862745098;
   char_colors[30].ba = 38.82352941176471;
   char_colors[31].ra = 57.254901960784316;
   char_colors[31].ga = 2.7450980392156863;
   char_colors[31].ba = 7.058823529411765;

   // barboss
   char_colors[32].ra = 77.64705882352942;
   char_colors[32].ga = 63.92156862745099;
   char_colors[32].ba = 32.54901960784314;

   // cyclops
   char_colors[33].ra = 41.1764705882353;
   char_colors[33].ga = 23.92156862745098;
   char_colors[33].ba = 38.82352941176471;

   // beetle
   /*
   char_colors[34].ra = 44.70588235294118;
   char_colors[34].ga = 32.54901960784314;
   char_colors[34].ba = 15.294117647058824;
   */
}
function f_SoundSwing(power)
{
   _root["s_Swing" + power].start(0,0);
}
function f_PunchSound()
{
   _root["s_MeatyPunch" + (random(6) + 4)].start(0,0);
}
function f_SwordClang()
{
   _root["s_Cling" + (random(3) + 1)].start(0,0);
}
function f_FistPunchSound()
{
   _root["s_FistPunch" + (random(3) + 1)].start(0,0);
}
function f_HardPunchSound()
{
   _root["s_Clang" + (random(8) + 1)].start(0,0);
}
function f_BlockSound()
{
   _root["s_Block" + (random(4) + 1)].start(0,0);
}
function f_SoundX(zone, sound, x, range, loops)
{
   u_temp = sound;
   f_SoundPan(u_temp,x,range);
   u_temp.start(0,loops);
   return u_temp;
}
function f_SoundPan(u_temp, x, range)
{
   percent = (x - main.left) / scaled_screen_width;
   u_pan = 200 * percent - 100;
   if(u_pan > 100)
   {
      if(x < main.right + range)
      {
         var loc3 = 100 * (1 - (x - main.right) / range);
      }
      else
      {
         loc3 = 0;
      }
      u_pan = 100;
   }
   else if(u_pan < -100)
   {
      if(x > main.left - range)
      {
         loc3 = 100 * ((x - (main.left - range)) / range);
      }
      else
      {
         loc3 = 0;
      }
      u_pan = -100;
   }
   else
   {
      loc3 = 100;
   }
   u_temp.setPan(u_pan);
   u_temp.setVolume(loc3);
}
function f_Skew(zone, x, y, scale, rot)
{
   zone._rotation = (x + y) / 2 + 45 + rot;
   var loc2 = x * g_rad;
   var loc1 = y * g_rad;
   zone._xscale = scale * (Math.cos(loc2) + Math.sin(loc1)) / Math.sin(((x + y) / 2 + 45) * g_rad) * g_sin45;
   zone._yscale = scale * (Math.sin(loc2) + Math.cos(loc1)) / Math.sin(((x + y) / 2 + 45) * g_rad) * g_sin45;
}
function f_lerp(points, t)
{
   if(t < 0)
   {
      t = 0;
   }
   if(t > 1)
   {
      t = 1;
   }
   var loc8 = points.x1 + (points.x2 - points.x1) * t;
   var loc6 = points.y1 + (points.y2 - points.y1) * t;
   var loc4 = points.x2 + (points.x3 - points.x2) * t;
   var loc3 = points.y2 + (points.y3 - points.y2) * t;
   var loc10 = points.x3 + (points.x4 - points.x3) * t;
   var loc9 = points.y3 + (points.y4 - points.y3) * t;
   var loc7 = loc8 + (loc4 - loc8) * t;
   var loc5 = loc6 + (loc3 - loc6) * t;
   var loc12 = loc4 + (loc10 - loc4) * t;
   var loc11 = loc3 + (loc9 - loc3) * t;
   points.lerp_x = loc7 + (loc12 - loc7) * t;
   points.lerp_y = loc5 + (loc11 - loc5) * t;
}
function f_utilNormalizeScale(begin, end, val)
{
   if(val < begin)
   {
      return 0;
   }
   if(val > end)
   {
      return 1;
   }
   if(begin == end)
   {
      return 0;
   }
   var loc3 = (val - begin) / (end - begin);
   return loc3;
}
function f_utilLerp(begin, end, t)
{
   return begin + t * (end - begin);
}
function f_rad2deg(radian)
{
   return g_deg * radian;
}
function f_SquaredDist(zone, zone2)
{
   var loc2 = zone._x - zone2._x;
   var loc1 = zone._y - zone2._y;
   return loc2 * loc2 + loc1 * loc1;
}
function f_GetEnemySpawnX()
{
   var loc1 = f_GetEnemySpawnWP();
   var loc2 = -1;
   if(loc1 > 0)
   {
      loc2 = f_GetWPX(loc1);
   }
   return loc2;
}
function f_GetEnemySpawnY()
{
   var loc1 = f_GetEnemySpawnWP();
   var loc2 = -1;
   if(loc1 > 0)
   {
      loc2 = f_GetWPY(loc1);
   }
   return loc2;
}
function f_GetEnemySpawnWP()
{
   var loc2 = _root.main.waypoint + 1;
   while(loc2 < 100)
   {
      if(f_GetWPX(loc2) > _root.main.right)
      {
         return loc2;
      }
      loc2 = loc2 + 1;
   }
   return -1;
}
function f_IsAPlayerClose(zone, dist)
{
   var loc1 = 1;
   while(loc1 <= 4)
   {
      var loc2 = playerArrayOb["p_pt" + int(loc1)];
      if(loc2.alive)
      {
         var loc4 = zone._x - loc2._x;
         var loc3 = zone._y - loc2._y;
         if(Math.sqrt(loc4 * loc4 + loc3 * loc3) < dist)
         {
            loc1 = 5;
            return true;
         }
      }
      loc1 = loc1 + 1;
   }
   return false;
}
function Error(u_temp)
{
   trace(u_temp);
}
function f_NewFriendNum()
{
   var loc1 = 5;
   while(loc1 <= players)
   {
      var loc2 = loader.game.game["p" + loc1];
      if(!loc2.active && loc1 != 11) // 11 is reserved for undead groom
      {
         return loc1;
      }
      loc1 = loc1 + 1;
   }
}
function f_MakeFriend(p_type, x, y)
{
   var loc2 = f_NewFriendNum();
   var loc1 = f_SpawnPlayer(loc2,p_type,x,y);
   loc1.gotoAndStop("stand");
   if(insane_mode == true)
   {
      loc1.health_max *= 10;
      loc1.health = loc1.health_max;
      loc1.attack_pow *= 3;
      loc1.punch_pow_low *= 3;
      loc1.punch_pow_medium *= 3;
      loc1.punch_pow_high *= 3;
      loc1.punch_pow_max *= 3;
      loc1.arrow_pow *= 3;
      loc1.magic_pow *= 3;
   }
   return loc1;
}
function f_InsertFriend(zone)
{
   var loc1 = 5;
   while(loc1 <= players)
   {
      var loc2 = loader.game.game["p" + int(loc1)];
      if(!loc2.active)
      {
         loader.game.game["p" + int(loc1)] = zone;
         return undefined;
      }
      loc1 = loc1 + 1;
   }
}
function f_KillTossEnemies()
{
   var loc1 = 1;
   while(loc1 <= total_enemies)
   {
      var loc2 = loader.game.game["e" + int(loc1)];
      if(loc2.active)
      {
         f_Damage(loc2,100000,DMG_MELEE,DMGFLAG_JUGGLE,random(5),- (random(5) + 6));
      }
      loc1 = loc1 + 1;
   }
}
function f_NewEnemy(name, total_val)
{
   var loc2 = 1;
   while(loc2 <= total_val)
   {
      var loc1 = loader.game.game[name + loc2];
      if(!loc1.active)
      {
         loc1.active = true;
         HiFps_ResetRecursive(loc1);
         return loc1;
      }
      loc2 = loc2 + 1;
   }
   return 0;
}
function f_InsertEnemy(zone)
{
   var loc1 = 1;
   while(loc1 <= total_enemies)
   {
      var loc2 = loader.game.game["e" + int(loc1)];
      if(!loc2.active)
      {
         loader.game.game["e" + int(loc1)] = zone;
         zone.e_pt = loc1;
         return undefined;
      }
      loc1 = loc1 + 1;
   }
}
function f_SpawnEnemy(name, x, y, u_estats, total_val)
{
   var loc2 = f_NewEnemy(name,total_val);
   if(loc2)
   {
      loc2.active = true;
      loc2.x = x;
      loc2.y = y;
      loc2._x = x;
      loc2._y = y;
      if(loc2._xscale < 0)
      {
         loc2._xscale *= -1;
      }
      loc2.combo_unlocks = _root.all_combos_unlocked;
      loc2.shadow_pt = f_NewShadow();
      loc2.shadow_pt._x = x;
      loc2.shadow_pt._y = y;
      f_Depth(loc2,y);
      loc2.alive = true;
      loc2.tossable = true;
      loc2.body_y = 0;
      loc2.body_table_y = 0;
      loc2.n_groundtype = 0;
      loc2.zapping = false;
      loc2.helmet = 1;
      loc2.face_hit1 = 2;
      loc2.face_hit2 = 2;
      loc2.speed = u_estats.speed;
      loc2.health_max = u_estats.health_max;
      if(ez_enemies)
      {
         loc2.health = 1;
      }
      else
      {
         loc2.health = loc2.health_max;
      }
      loc2.arrow_pow = 2;
      loc2.arrow_speed_y = 0;
      loc2.arrow_speed_x = 20;
      loc2.arrow_gravity = 0;
      loc2.shot_timer_default = 120;
      loc2.name = 2;
      loc2.weight = 0;
      loc2.grab = true;
      loc2.lifebar = true;
      loc2.punch_clock = 0;
      loc2.punch_count = 0;
      loc2.poison_timer = 0;
      loc2.fire_timer = 0;
      loc2.beefy = false;
      loc2.rolling = false;
      loc2.magician = false;
      loc2.magic_delay = 90;
      loc2.magic_wait = loc2.magic_delay;
      loc2.magic_chain = 3;
      loc2.magic_air = 9999;
      loc2.magic_splash = 9999;
      loc2.magic_bullet = 9999;
      loc2.magic_pow = 5;
      loc2.magic_timer = 0;
      loc2.hitby = undefined;
      loc2.weapon_type = undefined;
      loc2.item_type = undefined;
      loc2.fp_DeathAction = undefined;
      loc2.arrowplink = false;
      loc2.punch_pow_low = 4;
      loc2.punch_pow_medium = 6;
      loc2.punch_pow_high = 8;
      loc2.punch_pow_max = 10;
      loc2.aggressiveness = 10;
      loc2.grapple_aggression = 0.2;
      loc2.recovery = 12;
      loc2.resists = new Array(5);
      loc2.resists[DMG_MELEE] = 50;
      loc2.resists[DMG_POISON] = 50;
      loc2.resists[DMG_FIRE] = 50;
      loc2.resists[DMG_ELEC] = 50;
      loc2.resists[DMG_ICE] = 50;
      loc2.attack_type = DMG_MELEE;
      loc2.frozen = false;
      loc2.fp_PunchHit = f_EnemyAttack;
      loc2.fp_CharClock = f_EnemyClock;
      loc2.fp_Blocking = f_EnemyBlocking;
      loc2.fp_MidAttack = f_EnemyMelee;
      loc2.fp_WalkAnim = f_WalkType1;
      loc2.fp_StandAnim = f_StandType1;
      loc2.fp_Jab = f_PunchSet100;
      loc2.fp_DieAction = f_Null;
      loc2.fp_hitreaction = undefined;
      f_HumanoidDefaults(loc2);
      f_ClearTimers(loc2);
      loc2.retreater = false;
      loc2.roller = false;
      loc2.tossable = true;
      loc2.anti_air = false;
      loc2.blocks = false;
      loc2.block_odds = 10;
      loc2.full_block_odds = 0;
      loc2.air_block_odds = 0;
      loc2.chases = true;
      f_ColorSwap(loc2,color_default);
      loc2.e_type = undefined;
      loc2.h = 90;
      loc2.w = 40;
      if(loc2.zone)
      {
         loc2.zone.x = loc2.x;
         loc2.zone.w = loc2.w;
      }
      loc2.fp_BlockFunction = f_Null;
      loc2.fp_Ranged = f_Null;
      loc2.npc = false;
      f_FlipChar(loc2);
      f_KidSettings(loc2);
      loc2.gotoAndStop("stand");
      f_InsertEnemy(loc2);
   }
   return loc2;
}
function f_BadDude(u_temp)
{
   u_temp.magician = true;
   u_temp.magic_delay = 90;
   u_temp.magic_wait = 60 + random(60);
   u_temp.aggressiveness = 2;
   u_temp.speed = 8 + random(3);
   u_temp.magic_splash = 2;
   u_temp.magic_air = 2;
   u_temp.health_max += f_SetEnemyHealth(100);
   u_temp.health = u_temp.health_max;
   if(_root.insane_mode)
   {
      u_temp.attack_pow *= 0.5;
      u_temp.punch_pow_low *= 0.5;
      u_temp.punch_pow_medium *= 0.5;
      u_temp.punch_pow_high *= 0.5;
      u_temp.punch_pow_max *= 0.5;
      u_temp.arrow_pow *= 0.5;
      u_temp.magic_pow *= 0.5;
   }
}
function f_SetEnemyHealth(u_temp)
{
   switch(active_players)
   {
      case 1:
         var loc2 = u_temp;
         break;
      case 2:
         loc2 = u_temp * 1.2;
         break;
      case 3:
         loc2 = u_temp * 1.4;
         break;
      case 4:
         loc2 = u_temp * 1.6;
         break;
      default:
         loc2 = u_temp;
   }
   if(insane_mode == true)
   {
      loc2 *= 10;
   }
   return loc2;
}
function f_SetEnemyPow(u_temp)
{
   switch(active_players)
   {
      case 1:
         break;
      case 2:
         u_temp.attack_pow *= 1.2;
         u_temp.punch_pow_low *= 1.2;
         u_temp.punch_pow_medium *= 1.2;
         u_temp.punch_pow_high *= 1.2;
         u_temp.punch_pow_max *= 1.2;
         u_temp.arrow_pow *= 1.2;
         u_temp.magic_pow *= 1.2;
         if(u_temp.aggressiveness > 2)
         {
            u_temp.aggressiveness = u_temp.aggressiveness - 1;
         }
         break;
      case 3:
         u_temp.attack_pow *= 1.4;
         u_temp.punch_pow_low *= 1.4;
         u_temp.punch_pow_medium *= 1.4;
         u_temp.punch_pow_high *= 1.4;
         u_temp.punch_pow_max *= 1.4;
         u_temp.arrow_pow *= 1.4;
         u_temp.magic_pow *= 1.4;
         if(u_temp.aggressiveness > 2)
         {
            u_temp.aggressiveness = u_temp.aggressiveness - 1;
         }
         break;
      case 4:
         u_temp.attack_pow *= 1.5;
         u_temp.punch_pow_low *= 1.5;
         u_temp.punch_pow_medium *= 1.5;
         u_temp.punch_pow_high *= 1.5;
         u_temp.punch_pow_max *= 1.5;
         u_temp.arrow_pow *= 1.5;
         u_temp.magic_pow *= 1.5;
         if(u_temp.aggressiveness > 3)
         {
            u_temp.aggressiveness -= 2;
         }
   }
   if(insane_mode == true)
   {
      u_temp.attack_pow *= 10;
      u_temp.punch_pow_low *= 10;
      u_temp.punch_pow_medium *= 10;
      u_temp.punch_pow_high *= 10;
      u_temp.punch_pow_max *= 10;
      u_temp.arrow_pow *= 10;
      u_temp.magic_pow *= 10;
      if(u_temp.aggressiveness > 3)
      {
         u_temp.aggressiveness -= 2;
      }
      u_temp.speed *= 1.5;
      if(u_temp.speed > 12)
      {
         u_temp.speed = 12;
      }
   }
}
function f_SetBossHealth(u_temp)
{
   if(insane_mode == true)
   {
      u_temp.health_max *= 10;
      u_temp.health = u_temp.health_max;
   }
}
function f_SpawnBarbarian(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(50);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 10;
            break;
         case 1:
            loc1.weapon = 35;
            break;
         case 2:
            loc1.weapon = 26;
            break;
         default:
            loc1.weapon = 19;
      }
      loc1.helmet = 7;
      loc1.emblem = 7;
      loc1.shield = 7;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_ShootArrow;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 12;
      loc1.aggressiveness = 12;
      loc1.hop_timer = random(200);
      loc1.punch_pow_low = 4;
      loc1.punch_pow_medium = 6;
      loc1.punch_pow_high = 8;
      loc1.punch_pow_max = 10;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 2;
      loc1.arrow_gravity = 2;
      loc1.arrow_speed_x = 20;
      loc1.arrow_speed_y = -10;
      loc1.shot_timer_default = 120;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 50;
      loc1.resists[DMG_FIRE] = 40;
      loc1.resists[DMG_ELEC] = 40;
      loc1.resists[DMG_POISON] = 40;
      loc1.resists[DMG_ICE] = 40;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnThief(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 4 + random(10) / 10;
   loc2.health_max = f_SetEnemyHealth(50);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      loc1.weapon = 10;
      loc1.helmet = 8;
      loc1.emblem = 8;
      loc1.shield = 8;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_Character = f_ThiefWalk;
      loc1.fp_Ranged = f_ShootArrow;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 12;
      loc1.aggressiveness = 12;
      loc1.punch_pow_low = 4;
      loc1.punch_pow_medium = 6;
      loc1.punch_pow_high = 8;
      loc1.punch_pow_max = 10;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.archer = true;
      loc1.arrow_pow = 6;
      loc1.shot_timer_default = 45;
      loc1.arrow_speed_y = 0;
      loc1.arrow_speed_x = 25;
      loc1.arrow_gravity = 0;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 50;
      loc1.resists[DMG_FIRE] = 50;
      loc1.resists[DMG_ELEC] = 50;
      loc1.resists[DMG_POISON] = 50;
      loc1.resists[DMG_ICE] = 50;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.arrow_pow *= 3;
         loc1.punch_pow_low *= 2;
         loc1.punch_pow_medium *= 2;
         loc1.punch_pow_high *= 2;
         loc1.punch_pow_max *= 2;
         loc1.aggressiveness = 7;
         loc1.shot_timer_default = 40;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = random(60);
   }
   return loc1;
}
function f_SpawnTroll(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(50);
   var loc1 = f_SpawnEnemy("e_troll",x,y,loc2,total_trolls);
   if(loc1)
   {
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_GeneralWalk;
      loc1.fp_Ranged = f_Taunt1;
      loc1.fp_Jab = f_PunchSet300;
      loc1.fp_Fierce = f_PunchSet300;
      loc1.fp_ExtremeDeath1 = undefined;
      loc1.blocks = false;
      loc1.aggressiveness = 4;
      loc1.hop_timer = random(200);
      loc1.punch_pow_low = 8;
      loc1.punch_pow_medium = 10;
      loc1.punch_pow_high = 13;
      loc1.punch_pow_max = 15;
      loc1.arrow_pow = 2;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 120;
      loc1.resists[DMG_MELEE] = 50;
      loc1.resists[DMG_FIRE] = 30;
      loc1.resists[DMG_ELEC] = 30;
      loc1.resists[DMG_POISON] = 70;
      loc1.resists[DMG_ICE] = 50;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      f_SetEnemyPow(loc1);
      loc1.dash_timer = random(200);
   }
   return loc1;
}
function f_SpawnBear(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(100);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(2));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 29;
            break;
         case 1:
            loc1.weapon = 26;
            break;
         default:
            loc1.weapon = 29;
      }
      loc1.helmet = 20;
      loc1.emblem = 20;
      loc1.shield = 20;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_ShootArrow;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.aggressiveness = 7;
      loc1.blocks = true;
      loc1.block_odds = 11;
      loc1.hop_timer = random(200);
      loc1.punch_pow_low = 10;
      loc1.punch_pow_medium = 12;
      loc1.punch_pow_high = 14;
      loc1.punch_pow_max = 17;
      loc1.arrow_pow = 8;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 100;
      loc1.magic_pow = 8;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 60;
      loc1.resists[DMG_FIRE] = 40;
      loc1.resists[DMG_ELEC] = 40;
      loc1.resists[DMG_POISON] = 60;
      loc1.resists[DMG_ICE] = 70;
      f_WeaponStats(loc1,loc1.weapon);
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.magician = true;
         loc1.magic_delay = 90;
         loc1.magic_wait = 60 + random(60);
         loc1.magic_air = 2;
         loc1.aggressiveness = 8;
         loc1.speed = loc1.speed + 1;
      }
      if(enemy_level > 2)
      {
         loc1.aggressiveness = 6;
         loc1.magic_splash = 2;
         loc1.speed = loc1.speed + 1;
         loc1.health += f_SetEnemyHealth(20);
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnSlime(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(75);
   var loc1 = f_SpawnEnemy("e_slime",x,y,loc2,total_slimes);
   if(loc1)
   {
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_ShootArrow;
      loc1.fp_Hit1 = f_HitSlime;
      loc1.fp_Hit2 = f_HitSlime;
      loc1.fp_Hit3 = f_HitSlime;
      loc1.fp_Juggle = f_HitSlime;
      loc1.fp_ExtremeDeath1 = undefined;
      loc1.dash_timer = random(90);
      loc1.hop_timer = random(90);
      loc1.intro_timer = 0;
      loc1.humanoid = false;
      loc1.dropstuff = false;
      loc1.gravity = 2;
      loc1.nohit = true;
      loc1.gotoAndStop("spawn");
      loc1.resists[DMG_MELEE] = 60;
      loc1.resists[DMG_FIRE] = 60;
      loc1.resists[DMG_ELEC] = 40;
      loc1.resists[DMG_POISON] = 40;
      loc1.resists[DMG_ICE] = 40;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.resists[DMG_MELEE] = 70;
         loc1.health_max = f_SetEnemyHealth(125);
         loc1.health = loc1.health_max;
         loc1.dash_timer = random(70);
         loc1.hop_timer = random(70);
      }
      if(loc1._xscale > 0)
      {
         loc1.zone.x = loc1.x + loc1.zone._x;
      }
      else
      {
         loc1.zone.x = loc1.x - loc1.zone._x;
      }
      loc1.zone.y = loc1.y + loc1.zone._y;
   }
   return loc1;
}
function f_SpawnBee(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(50);
   var loc1 = f_SpawnEnemy("e_bee",x,y,loc2,total_bees);
   if(loc1)
   {
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_Character = f_BeeWalk;
      loc1.fp_Ranged = f_Taunt1;
      loc1.fp_Jab = f_PunchSet300;
      loc1.fp_Fierce = f_PunchSet300;
      loc1.fp_ExtremeDeath1 = undefined;
      loc1.blocks = false;
      loc1.hop_timer = random(200);
      loc1.punch_pow_low = 50;
      loc1.punch_pow_medium = 50;
      loc1.punch_pow_high = 50;
      loc1.punch_pow_max = 50;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 120;
      loc1.dash_timer = random(200);
      loc1.speed_x = 0;
      loc1.speed_y = 0;
      loc1.body_y = -600;
      loc1.fly_timer = random(60);
      loc1.flying = true;
      loc1.grab = false;
      loc1.gotoAndStop("fly");
      loc1.body._y = loc1.body_y;
      f_ShadowSize(loc1);
      if(!enemy_level)
      {
         enemy_level = 1;
      }
   }
   return loc1;
}
function f_SpawnBeekeeper(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(150);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 34;
            break;
         case 1:
            loc1.weapon = 5;
            break;
         case 2:
            loc1.weapon = 45;
            break;
         default:
            loc1.weapon = 5;
      }
      loc1.helmet = 10;
      loc1.emblem = 10;
      loc1.shield = 10;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_EnemyQuickBomb;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 5;
      loc1.aggressiveness = 4;
      loc1.hop_timer = random(200);
      loc1.punch_pow_low = 16;
      loc1.punch_pow_medium = 20;
      loc1.punch_pow_high = 24;
      loc1.punch_pow_max = 28;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 9;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 60;
      loc1.magic_pow = 9;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 50;
      loc1.resists[DMG_FIRE] = 40;
      loc1.resists[DMG_ELEC] = 60;
      loc1.resists[DMG_POISON] = 60;
      loc1.resists[DMG_ICE] = 40;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnConehead(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(170);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 43;
            break;
         case 1:
            loc1.weapon = 43;
            break;
         case 2:
            loc1.weapon = 43;
            break;
         default:
            loc1.weapon = 43;
      }
      loc1.helmet = 22;
      loc1.emblem = 21;
      loc1.shield = 21;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_EnemyQuickBomb;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 5;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 7;
      loc1.punch_pow_low = 13;
      loc1.punch_pow_medium = 17;
      loc1.punch_pow_high = 22;
      loc1.punch_pow_max = 26;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 15;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 60;
      loc1.magic_pow = 11;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 60;
      loc1.resists[DMG_FIRE] = 50;
      loc1.resists[DMG_ELEC] = 40;
      loc1.resists[DMG_POISON] = 40;
      loc1.resists[DMG_ICE] = 50;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.resists[DMG_MELEE] = 65;
         loc1.resists[DMG_FIRE] = 55;
         loc1.resists[DMG_ELEC] = 45;
         loc1.resists[DMG_POISON] = 45;
         loc1.resists[DMG_ICE] = 55;
         loc1.punch_pow_low *= 1.25;
         loc1.punch_pow_medium *= 1.25;
         loc1.punch_pow_high *= 1.25;
         loc1.punch_pow_max *= 1.25;
         loc1.arrow_pow *= 1.25;
         loc1.magic_pow *= 1.25;
         loc1.aggressiveness = 5;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnFireDemon(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(200);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 35;
            break;
         case 1:
            loc1.weapon = 35;
            break;
         case 2:
            loc1.weapon = 20;
            break;
         default:
            loc1.weapon = 20;
      }
      loc1.helmet = 25;
      loc1.emblem = 25;
      loc1.shield = 25;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_ShootFire;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.weightplus = 1;
      loc1.hop_timer = random(90);
      loc1.aggressiveness = 6;
      loc1.punch_pow_low = 20;
      loc1.punch_pow_medium = 23;
      loc1.punch_pow_high = 27;
      loc1.punch_pow_max = 30;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 30;
      loc1.magic_pow = 50;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 55;
      loc1.resists[DMG_FIRE] = 89;
      loc1.resists[DMG_ELEC] = 55;
      loc1.resists[DMG_POISON] = 55;
      loc1.resists[DMG_ICE] = 30;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.magician = true;
         loc1.magic_delay = 30;
         loc1.magic_wait = 40 + random(40);
         loc1.magic_splash = 1;
         loc1.aggressiveness = 6;
         loc1.speed = loc1.speed + 1;
      }
      if(enemy_level > 2)
      {
         loc1.magic_air = 2;
         loc1.speed = loc1.speed + 1;
         loc1.health += f_SetEnemyHealth(40);
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      if(insane_mode == true)
      {
         loc1.magic_pow *= 0.3;
      }
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnSkeleton(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(170);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 10;
            break;
         case 1:
            loc1.weapon = 11;
            break;
         case 2:
            loc1.weapon = 10;
            break;
         default:
            loc1.weapon = 31;
      }
      loc1.helmet = 26;
      loc1.emblem = 26;
      loc1.shield = 26;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_ShootArrow;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 6;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 7;
      loc1.punch_pow_low = 30;
      loc1.punch_pow_medium = 36;
      loc1.punch_pow_high = 42;
      loc1.punch_pow_max = 48;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 15;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.magic_pow = 20;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 50;
      loc1.resists[DMG_FIRE] = 60;
      loc1.resists[DMG_ELEC] = 60;
      loc1.resists[DMG_POISON] = 90;
      loc1.resists[DMG_ICE] = 60;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.resists[DMG_MELEE] = 55;
         loc1.resists[DMG_FIRE] = 65;
         loc1.resists[DMG_ELEC] = 65;
         loc1.resists[DMG_POISON] = 95;
         loc1.resists[DMG_ICE] = 65;
         loc1.punch_pow_low *= 1.75;
         loc1.punch_pow_medium *= 1.75;
         loc1.punch_pow_high *= 1.75;
         loc1.punch_pow_max *= 1.75;
         loc1.arrow_pow *= 2;
         loc1.magic_pow *= 1.75;
         loc1.aggressiveness = 7;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnFencer(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(190);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 18;
            break;
         case 1:
            loc1.weapon = 18;
            break;
         case 2:
            loc1.weapon = 6;
            break;
         default:
            loc1.weapon = 5;
      }
      loc1.helmet = 9;
      loc1.emblem = 9;
      loc1.shield = 9;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_EnemyQuickBomb;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 10;
      loc1.hop_timer = random(100);
      loc1.aggressiveness = 4;
      loc1.punch_pow_low = 32;
      loc1.punch_pow_medium = 35;
      loc1.punch_pow_high = 38;
      loc1.punch_pow_max = 41;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 35;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 60;
      loc1.magic_pow = 35;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 50;
      loc1.resists[DMG_FIRE] = 50;
      loc1.resists[DMG_ELEC] = 70;
      loc1.resists[DMG_POISON] = 50;
      loc1.resists[DMG_ICE] = 50;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.magician = true;
         loc1.magic_delay = 30;
         loc1.magic_wait = 40 + random(40);
         loc1.magic_splash = 4;
         loc1.magic_air = 4;
         loc1.aggressiveness = 5;
         loc1.speed = loc1.speed + 1;
         loc1.health += f_SetEnemyHealth(40);
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnIndustrialist(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(220);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 27;
            break;
         case 1:
            loc1.weapon = 27;
            break;
         case 2:
            loc1.weapon = 62;
            break;
         default:
            loc1.weapon = 27;
      }
      loc1.helmet = 11;
      loc1.emblem = 11;
      loc1.shield = 11;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_EnemyQuickBomb;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 6;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 8;
      loc1.punch_pow_low = 40;
      loc1.punch_pow_medium = 45;
      loc1.punch_pow_high = 50;
      loc1.punch_pow_max = 55;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 25;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 60;
      loc1.magic_pow = 40;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 60;
      loc1.resists[DMG_FIRE] = 60;
      loc1.resists[DMG_ELEC] = 60;
      loc1.resists[DMG_POISON] = 40;
      loc1.resists[DMG_ICE] = 40;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.magician = true;
         loc1.magic_delay = 30;
         loc1.magic_wait = 40 + random(40);
         loc1.magic_splash = 4;
         loc1.magic_air = 4;
         loc1.aggressiveness = 5;
         loc1.speed = loc1.speed + 1;
         loc1.health += f_SetEnemyHealth(40);
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnBrute(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(250);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 12;
            break;
         case 1:
            loc1.weapon = 12;
            break;
         case 2:
            loc1.weapon = 13;
            break;
         default:
            loc1.weapon = 13;
      }
      loc1.helmet = 14;
      loc1.emblem = 14;
      loc1.shield = 14;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_EnemyQuickBomb;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 4;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 7;
      loc1.punch_pow_low = 40;
      loc1.punch_pow_medium = 45;
      loc1.punch_pow_high = 50;
      loc1.punch_pow_max = 55;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 30;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 60;
      loc1.magic_pow = 20;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 80;
      loc1.resists[DMG_FIRE] = 50;
      loc1.resists[DMG_ELEC] = 50;
      loc1.resists[DMG_POISON] = 50;
      loc1.resists[DMG_ICE] = 50;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnNinja(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(150);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      loc1.weapon = 50;
      loc1.helmet = 28;
      loc1.emblem = 28;
      loc1.shield = 28;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_JumpKickInit;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_hitreaction = f_NinjaWarp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 4;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 10;
      loc1.punch_pow_low = 12;
      loc1.punch_pow_medium = 18;
      loc1.punch_pow_high = 24;
      loc1.punch_pow_max = 30;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 25;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.magic_pow = 25;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 50;
      loc1.resists[DMG_FIRE] = 55;
      loc1.resists[DMG_ELEC] = 55;
      loc1.resists[DMG_POISON] = 55;
      loc1.resists[DMG_ICE] = 55;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnBeetle(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(230);
   var loc1 = f_SpawnEnemy("e_beetle",x,y,loc2,total_beetles);
   if(loc1)
   {
      loc1._xscale = random(20) + 90;
      loc1._yscale = random(20) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_Character = f_Beetle;
      loc1.fp_Ranged = undefined;
      loc1.fp_Jab = f_BeetleAttack;
      loc1.fp_Fierce = f_BeetleAttack;
      loc1.fp_ExtremeDeath1 = undefined;
      loc1.fp_PunchHit = f_EnemyAttack;
      loc1.fp_Hit1 = f_HitBeetle;
      loc1.fp_Hit2 = f_HitBeetle;
      loc1.fp_Hit3 = f_HitBeetle;
      loc1.fp_Juggle = f_HitBeetle;
      loc1.arrowhit_function = f_HitBeetle;
      loc1.blocks = false;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 4;
      loc1.punch_pow_low = 18;
      loc1.punch_pow_medium = 24;
      loc1.punch_pow_high = 30;
      loc1.punch_pow_max = 36;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 120;
      loc1.resists[DMG_MELEE] = 50;
      loc1.resists[DMG_POISON] = 50;
      loc1.resists[DMG_FIRE] = 70;
      loc1.resists[DMG_ELEC] = 70;
      loc1.resists[DMG_ICE] = 50;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      f_SetEnemyPow(loc1);
      loc1.mode = 1;
      loc1.mode_timer = 90 + random(60);
      loc1.h = 100;
      loc1.w = 100;
      loc1.humanoid = false;
      loc1.hit_number = 0;
      loc1.grab = false;
      loc1.dash_timer = random(200);
   }
   return loc1;
}
function f_SpawnChainmail(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(220);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      loc1.weapon = 15;
      loc1.helmet = 17;
      loc1.emblem = 17;
      loc1.shield = 17;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_EnemyQuickBomb;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 6;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 7;
      loc1.punch_pow_low = 30;
      loc1.punch_pow_medium = 35;
      loc1.punch_pow_high = 41;
      loc1.punch_pow_max = 45;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 60;
      loc1.magic_pow = 40;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 70;
      loc1.resists[DMG_POISON] = 40;
      loc1.resists[DMG_FIRE] = 40;
      loc1.resists[DMG_ELEC] = 40;
      loc1.resists[DMG_ICE] = 50;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.magician = true;
         loc1.magic_delay = 90;
         loc1.magic_wait = 60 + random(60);
         loc1.magic_splash = 1;
         loc1.speed = loc1.speed + 1;
      }
      if(enemy_level > 2)
      {
         loc1.aggressiveness = 6;
         loc1.magic_air = 2;
         loc1.speed = loc1.speed + 1;
         loc1.health += f_SetEnemyHealth(20);
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnAlien(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = 1;
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      loc1.weapon = 47;
      loc1.helmet = 12;
      loc1.emblem = 12;
      loc1.shield = 12;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_AlienWalk;
      loc1.fp_Ranged = f_ShootAlienGun;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.hop_timer = random(120);
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 8;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 30;
      loc1.magic_pow = 8;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 50;
      loc1.resists[DMG_POISON] = 50;
      loc1.resists[DMG_FIRE] = 50;
      loc1.resists[DMG_ELEC] = 50;
      loc1.resists[DMG_ICE] = 50;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnSaracen(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(190);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      loc1.weapon = 15;
      loc1.helmet = 16;
      loc1.emblem = 16;
      loc1.shield = 16;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_ShootArrow;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 7;
      loc1.hop_timer = random(150);
      loc1.aggressiveness = 5;
      loc1.punch_pow_low = 35;
      loc1.punch_pow_medium = 37;
      loc1.punch_pow_high = 41;
      loc1.punch_pow_max = 45;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 45;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 70;
      loc1.magic_pow = 50;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 60;
      loc1.resists[DMG_POISON] = 60;
      loc1.resists[DMG_FIRE] = 60;
      loc1.resists[DMG_ELEC] = 50;
      loc1.resists[DMG_ICE] = 40;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.magician = true;
         loc1.magic_delay = 90;
         loc1.magic_wait = 60 + random(60);
         loc1.magic_splash = 1;
         loc1.aggressiveness = 8;
         loc1.speed = loc1.speed + 1;
      }
      if(enemy_level > 2)
      {
         loc1.aggressiveness = 5;
         loc1.magic_air = 2;
         loc1.speed = loc1.speed + 1;
         loc1.health += f_SetEnemyHealth(20);
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnSnakey(x, y, enemy_level)
{
   var loc3 = new Object();
   loc3.speed = 2 + random(30) / 10;
   loc3.health_max = f_SetEnemyHealth(250);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc3,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 33;
            break;
         case 1:
            loc1.weapon = 14;
            break;
         case 2:
            loc1.weapon = 8;
            break;
         default:
            loc1.weapon = 33;
      }
      loc1.helmet = 15;
      loc1.emblem = 15;
      loc1.shield = 15;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_ShootArrow;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 8;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 7;
      loc1.punch_pow_low = 36;
      loc1.punch_pow_medium = 39;
      loc1.punch_pow_high = 43;
      loc1.punch_pow_max = 47;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 35;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 80;
      loc1.magic_pow = 50;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 55;
      loc1.resists[DMG_POISON] = 70;
      loc1.resists[DMG_FIRE] = 40;
      loc1.resists[DMG_ELEC] = 60;
      loc1.resists[DMG_ICE] = 50;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.magician = true;
         loc1.magic_delay = 90;
         loc1.magic_wait = 60 + random(60);
         loc1.magic_splash = 1;
         loc1.aggressiveness = 7;
         loc1.magic_chain = 4;
         loc1.speed = loc1.speed + 1;
      }
      if(enemy_level > 2)
      {
         loc1.aggressiveness = 6;
         loc1.magic_air = 2;
         loc1.speed = loc1.speed + 1;
         loc1.health += 20;
      }
      if(enemy_level > 3)
      {
         loc1.resists[DMG_POISON] = 75;
         loc1.resists[DMG_FIRE] = 50;
         loc1.resists[DMG_ELEC] = 70;
         loc1.resists[DMG_ICE] = 60;
      }
      if(enemy_level > 4)
      {
         loc1.aggressiveness = 5;
         loc1.magic_pow = 60;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      loc1.weightplus = 1;
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnFish(x, y, enemy_level)
{
   var loc3 = new Object();
   loc3.speed = 2 + random(30) / 10;
   loc3.health_max = f_SetEnemyHealth(300);
   var loc2 = f_SpawnEnemy("e_fish",x,y,loc3,total_fish);
   if(loc2)
   {
      loc2._xscale = random(15) + 90;
      loc2._yscale = random(15) + 90;
      loc2.fp_StandSettings = f_KidSettings;
      loc2.fp_Character = f_Fish;
      loc2.fp_Ranged = f_FishDive;
      loc2.dash_timer = random(200);
      loc2.fp_PunchHit = f_EnemyAttack;
      loc2.fp_Jab = f_FishAttack;
      loc2.fp_Fierce = f_FishAttack;
      loc2.fp_ExtremeDeath1 = undefined;
      loc2.fp_Hit1 = f_HitFish;
      loc2.fp_Hit2 = f_HitFish;
      loc2.fp_Hit3 = f_HitFish;
      loc2.fp_Juggle = f_HitFish;
      loc2.arrowhit_function = f_HitFish;
      loc2.blocks = false;
      loc2.hop_timer = random(200);
      loc2.punch_pow_low = 45;
      loc2.punch_pow_medium = 45;
      loc2.punch_pow_high = 45;
      loc2.punch_pow_max = 45;
      loc2.arrow_speed_y = -10;
      loc2.arrow_speed_x = 20;
      loc2.arrow_gravity = 2;
      loc2.shot_timer_default = 120;
      loc2.resists[DMG_MELEE] = 60;
      loc2.resists[DMG_POISON] = 50;
      loc2.resists[DMG_FIRE] = 30;
      loc2.resists[DMG_ELEC] = 40;
      loc2.resists[DMG_ICE] = 40;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      loc2.h = 100;
      loc2.w = 100;
      loc2.damage_all = false;
      loc2.tossable = false;
      loc2.humanoid = false;
      loc2.hit_number = 0;
      loc2.haswall = false;
      loc2.grab = false;
      if(level == 3)
      {
         loc2.speed = 7 + random(2);
      }
      else if(level == 32)
      {
         _root.loader.f_SetInWater(loc2);
      }
      if(_root.insane_mode == true)
      {
         loc2.attack_pow *= 5;
         loc2.punch_pow_low *= 5;
         loc2.punch_pow_medium *= 5;
         loc2.punch_pow_high *= 5;
         loc2.punch_pow_max *= 5;
         loc2.arrow_pow *= 5;
         loc2.magic_pow *= 5;
         if(loc2.aggressiveness > 3)
         {
            loc2.aggressiveness -= 2;
         }
         loc2.speed *= 1.25;
         if(loc2.speed > 12)
         {
            loc2.speed = 12;
         }
      }
   }
   return loc2;
}
function f_SpawnStoveFace(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(330);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      var _loc0_ = null;
      if((_loc0_ = loc4) !== 0)
      {
         loc1.weapon = 6;
      }
      else
      {
         loc1.weapon = 7;
      }
      loc1.helmet = 18;
      loc1.emblem = 23;
      loc1.shield = 21;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_ShootArrow;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.block_odds = 4;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 7;
      loc1.punch_pow_low = 50;
      loc1.punch_pow_medium = 56;
      loc1.punch_pow_high = 62;
      loc1.punch_pow_max = 70;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 55;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 80;
      loc1.magic_pow = 40;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 65;
      loc1.resists[DMG_POISON] = 50;
      loc1.resists[DMG_FIRE] = 60;
      loc1.resists[DMG_ELEC] = 50;
      loc1.resists[DMG_ICE] = 60;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.magician = true;
         loc1.magic_delay = 90;
         loc1.magic_wait = 60 + random(60);
         loc1.magic_splash = 1;
         loc1.magic_chain = 4;
         loc1.speed = loc1.speed + 1;
      }
      if(enemy_level > 2)
      {
         loc1.aggressiveness = 6;
         loc1.magic_air = 2;
         loc1.speed = loc1.speed + 1;
         loc1.health += 20;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      if(insane_mode == true)
      {
         loc1.attack_pow *= 0.5;
         loc1.punch_pow_low *= 0.5;
         loc1.punch_pow_medium *= 0.5;
         loc1.punch_pow_high *= 0.5;
         loc1.punch_pow_max *= 0.5;
         loc1.arrow_pow *= 0.5;
         loc1.magic_pow *= 0.5;
      }
      loc1.weightplus = 1;
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnEskimo(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(330);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      var _loc0_ = null;
      if((_loc0_ = loc4) !== 0)
      {
         loc1.weapon = 26;
      }
      else
      {
         loc1.weapon = 48;
      }
      loc1.helmet = 27;
      loc1.emblem = 27;
      loc1.shield = 27;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_ShootArrow;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 5;
      loc1.punch_pow_low = 30;
      loc1.punch_pow_medium = 35;
      loc1.punch_pow_high = 40;
      loc1.punch_pow_max = 45;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 40;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 60;
      loc1.magic_pow = 30;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 60;
      loc1.resists[DMG_POISON] = 50;
      loc1.resists[DMG_FIRE] = 50;
      loc1.resists[DMG_ELEC] = 50;
      loc1.resists[DMG_ICE] = 70;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.magician = true;
         loc1.magic_delay = 30;
         loc1.magic_wait = 60 + random(60);
         loc1.magic_bullet = 1;
         loc1.aggressiveness = 6;
         loc1.speed = loc1.speed + 1;
      }
      if(enemy_level > 2)
      {
         loc1.aggressiveness = 5;
         loc1.magic_air = 4;
         loc1.speed = loc1.speed + 1;
         loc1.health += 50;
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      if(insane_mode == true)
      {
         loc1.attack_pow *= 0.5;
         loc1.punch_pow_low *= 0.5;
         loc1.punch_pow_medium *= 0.5;
         loc1.punch_pow_high *= 0.5;
         loc1.punch_pow_max *= 0.5;
         loc1.arrow_pow *= 0.5;
         loc1.magic_pow *= 0.5;
      }
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnCultist(x, y, enemy_level)
{
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(190);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 68;
            break;
         case 1:
            loc1.weapon = 21;
            break;
         case 2:
            loc1.weapon = 13;
            break;
         default:
            loc1.weapon = 68;
      }
      loc1.helmet = 29;
      loc1.emblem = 29;
      loc1.shield = 29;
      loc1.e_type = loc1.helmet;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_ShootFire;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.blocks = true;
      loc1.hop_timer = random(200);
      loc1.aggressiveness = 6;
      loc1.punch_pow_low = 20;
      loc1.punch_pow_medium = 30;
      loc1.punch_pow_high = 40;
      loc1.punch_pow_max = 50;
      f_WeaponStats(loc1,loc1.weapon);
      loc1.arrow_pow = 30;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 60;
      loc1.magic_pow = 50;
      f_SetPlayerMagic(loc1,loc1.helmet);
      loc1.resists[DMG_MELEE] = 60;
      loc1.resists[DMG_FIRE] = 100;
      loc1.resists[DMG_ELEC] = 100;
      loc1.resists[DMG_POISON] = 100;
      loc1.resists[DMG_ICE] = 100;
      if(!enemy_level)
      {
         enemy_level = 1;
      }
      if(enemy_level > 1)
      {
         loc1.magician = true;
         loc1.magic_delay = 90;
         loc1.magic_wait = 60 + random(60);
         loc1.magic_splash = 1;
         loc1.aggressiveness = 5;
         loc1.speed = loc1.speed + 1;
      }
      if(enemy_level > 2)
      {
         loc1.aggressiveness = 3;
         loc1.magic_air = 2;
         loc1.speed = loc1.speed + 1;
         loc1.health += f_SetEnemyHealth(20);
      }
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      f_SetEnemyPow(loc1);
      if(insane_mode == true)
      {
         loc1.attack_pow *= 0.5;
         loc1.punch_pow_low *= 0.5;
         loc1.punch_pow_medium *= 0.5;
         loc1.punch_pow_high *= 0.5;
         loc1.punch_pow_max *= 0.5;
         loc1.arrow_pow *= 0.5;
         loc1.magic_pow *= 0.5;
      }
      loc1.arrowplink = true;
      loc1.weightplus = 1;
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
   }
   return loc1;
}
function f_SpawnEvilKnight(x, y, enemy_level)
{
   if(!enemy_level)
   {
      enemy_level = 1;
   }
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(50);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_EnemyQuickBomb;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.blocks = true;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.arrowplink = true;
      loc1.shot_timer_default = 60;
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 57;
            break;
         case 1:
            loc1.weapon = 31;
            break;
         case 2:
            loc1.weapon = 35;
            break;
         default:
            loc1.weapon = 57;
      }
      loc1.helmet = 21;
      loc1.emblem = 21;
      loc1.shield = 21;
      loc1.e_type = loc1.helmet;
      loc1.hop_timer = random(200);
      f_SetPlayerMagic(loc1,loc1.helmet);
      f_WeaponStats(loc1,loc1.weapon);
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      loc1.weight = 6;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
      f_SetEnemyPow(loc1);
      if(insane_mode == true)
      {
         loc1.attack_pow *= 0.5;
         loc1.punch_pow_low *= 0.5;
         loc1.punch_pow_medium *= 0.5;
         loc1.punch_pow_high *= 0.5;
         loc1.punch_pow_max *= 0.5;
         loc1.arrow_pow *= 0.5;
         loc1.magic_pow *= 0.5;
      }
   }
   return loc1;
}
function f_SpawnWizard(x, y, enemy_level)
{
   if(!enemy_level)
   {
      enemy_level = 1;
   }
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(50);
   var loc1 = f_SpawnEnemy("e_human",x,y,loc2,total_enemies);
   if(loc1)
   {
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_MidAttack = f_NPCMidJump;
      loc1.fp_Character = f_DasherWalk;
      loc1.fp_Ranged = f_EnemyQuickBomb;
      loc1.fp_GetUpAction = f_EnemyGetUp;
      loc1.blocks = true;
      loc1.fp_BlockFunction = f_EnemyCheckBlock;
      loc1.arrow_speed_y = -10;
      loc1.arrow_speed_x = 20;
      loc1.arrow_gravity = 2;
      loc1.shot_timer_default = 60;
      var loc4 = int(random(4));
      switch(loc4)
      {
         case 0:
            loc1.weapon = 43;
            break;
         case 1:
            loc1.weapon = 43;
            break;
         case 2:
            loc1.weapon = 43;
            break;
         default:
            loc1.weapon = 43;
      }
      loc1.helmet = 22;
      loc1.emblem = 21;
      loc1.shield = 21;
      loc1.e_type = loc1.helmet;
      loc1.hop_timer = random(200);
      f_SetPlayerMagic(loc1,loc1.helmet);
      f_WeaponStats(loc1,loc1.weapon);
      if(enemy_level == 10)
      {
         f_BadDude(loc1);
      }
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.random_dash_jump = 5;
      loc1.random_dash_roll = 6;
      loc1.dash_timer = 1;
      f_SetEnemyPow(loc1);
   }
   return loc1;
}
function f_SpawnTower(x, y, enemy_level)
{
   if(!enemy_level)
   {
      enemy_level = 1;
   }
   var loc2 = 1;
   while(loc2 <= total_towers)
   {
      var loc1 = loader.game.game["e_tower" + loc2];
      if(!loc1.active)
      {
         loc2 = total_towers + 1;
      }
      else
      {
         loc1 = undefined;
      }
      loc2 = loc2 + 1;
   }
   loc1.x = x;
   loc1.y = y;
   loc1._x = x;
   loc1._y = y;
   f_Depth(loc1,y);
   loc1.haswall = true;
   loc1.active = true;
   loc1.alive = true;
   loc1.h = 100;
   loc1.w = 60;
   loc1.health_max = 50;
   loc1.health = loc1.health_max;
   loc1.current_speed = 0;
   f_UnresponsiveDefaults(loc1);
   loc1.fp_Hit1 = f_HitSiegeTower;
   loc1.fp_Hit2 = f_HitSiegeTower;
   loc1.fp_Hit3 = f_HitSiegeTower;
   loc1.fp_Juggle = f_HitSiegeTower;
   loc1.riders = 0;
   loc1.gotoAndStop("walk");
   f_LargeObjectRanges(loc1);
   f_FlipChar(loc1);
   f_InsertEnemy(loc1);
   var loc3 = f_SpawnBarbarian(x - 30,y - 1);
   if(loc3)
   {
      loc3.gotoAndStop("enemy_archer");
      loc3.body_y = -120;
      loc3.body._y = loc3.body_y;
      loc3.vehicle = loc1;
      loc1.rider1 = loc3;
      loc1.riders = loc1.riders + 1;
   }
   return loc1;
}
function f_SpawnBigTroll(x, y, enemy_level)
{
   if(!enemy_level)
   {
      enemy_level = 1;
   }
   var loc3 = new Object();
   loc3.speed = 2 + random(30) / 10;
   loc3.health_max = f_SetEnemyHealth(350);
   var loc2 = f_SpawnEnemy("e_trollx",x,y,loc3,total_bigtrolls);
   if(loc2)
   {
      loc2.fp_StandSettings = f_KidSettings;
      loc2.fp_Character = f_BigTrollWalk;
      loc2.fp_Ranged = undefined;
      loc2.dash_timer = random(200);
      loc2.random_dash_jump = undefined;
      loc2.fp_Jab = undefined;
      loc2.fp_Fierce = undefined;
      loc2.fp_ExtremeDeath1 = undefined;
      loc2.prey = f_PickRandomPlayer();
      loc2.blocks = false;
      loc2.grab = false;
      loc2.fp_Juggle = _root.f_Hit1Reaction;
      loc2.tossable = false;
      loc2.chases = false;
      loc2.skiptarget = true;
      loc2.n_width = 70;
      loc2.n_height = 130;
      loc2.w = 70;
      loc2.h = 130;
      loc2.weight = 15;
      loc2.health_cp = loc2.health_max - 20;
      loc2.birth_timer = 60;
      loc2._xscale = random(15) + 90;
      loc2._yscale = random(15) + 90;
   }
   return loc2;
}
function f_Slime(zone)
{
   zone.nohit = false;
   if(zone.x < zone.prey.x)
   {
      if(zone._xscale < 0)
      {
         zone._xscale *= -1;
      }
   }
   else if(zone._xscale > 0)
   {
      zone._xscale *= -1;
   }
   if(zone.hop_timer <= 0)
   {
      zone.speed_x = 12;
      if(zone._xscale < 0)
      {
         zone.speed_x *= -1;
      }
      zone.speed_y = - (13 + random(5));
      zone.hop_timer = random(90);
      if(Math.abs(zone.y - zone.prey.y) < 10 && zone.prey.humanoid)
      {
         zone.punching = true;
         zone.gotoAndStop("attack");
      }
      else
      {
         if(zone.y < zone.prey.y)
         {
            zone.speed_z = 1;
         }
         else
         {
            zone.speed_z = -1;
         }
         zone.gotoAndStop("jump");
      }
   }
   else
   {
      zone.hop_timer = zone.hop_timer - 1;
   }
}
function f_HitSlime(zone)
{
   zone.punching = false;
   _root["s_SlimeHit" + (random(3) + 1)].start(0,0);
   if(zone.captor)
   {
      zone.captor.hostage = undefined;
      zone.captor.fp_StandAnim(zone.captor);
      zone.captor = undefined;
   }
   var loc4 = 1;
   while(loc4 <= 2)
   {
      var loc2 = f_FX(zone.x + random(25) - 50,zone.y,int(zone.y) + 1,"slime_glob",100,100);
      loc2.speed_x = random(8) - 2;
      loc2.speed_y = - (random(4) + 9);
      loc2.gravity = random(2) + 1;
      loc2.bounces = 0;
      loc2.bounces_max = 1;
      loc2.body._y = zone.body_y - 30;
      loc2.hit_function = f_ShrapnelBounce;
      loc4 = loc4 + 1;
   }
   if(zone._xscale > 0)
   {
      zone.speed_x = - (10 + random(4));
   }
   else
   {
      zone.speed_x = 10 + random(4);
   }
   zone.speed_y = - (10 + random(5));
   if(zone.body_y == 0)
   {
      if(zone.health <= 0)
      {
         zone.gotoAndStop("die");
      }
      else
      {
         zone.hop_timer = random(90);
         zone.gotoAndStop("jump");
      }
   }
   else
   {
      zone.gotoAndStop("hop");
   }
}
function f_SlimeAttack(zone)
{
   var loc3 = 1;
   while(loc3 <= active_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc3)];
      if(loc1.alive)
      {
         if(!loc1.nohit)
         {
            if(loc1.invincible_timer <= 0)
            {
               if(loc1.body_y > -40)
               {
                  if(Math.abs(zone.x - loc1.x) < 50)
                  {
                     if(Math.abs(zone.y - loc1.y) < 10)
                     {
                        if(loc1.hostage)
                        {
                           f_FX(loc1.x,loc1.body_y + loc1.y - 50,int(loc1.y) + 7,"impact1",100,100);
                           f_CallJuggle1(loc1);
                           s_Punch3.start(0,0);
                           f_Damage(loc1,zone.punch_pow_medium,DMG_MELEE,DMGFLAG_JUGGLE,5 + random(3),- (5 + random(3)));
                        }
                        else
                        {
                           zone.body_y = -50;
                           zone.captor = loc1;
                           loc1.hostage = zone;
                           loc1.prev_StandAnim = loc1.fp_StandAnim;
                           loc1.prev_WalkAnim = loc1.fp_WalkAnim;
                           loc1.prev_Character = loc1.fp_Character;
                           loc1.body_y = 0;
                           loc1.magicmode = false;
                           if(loc1.beefy)
                           {
                              loc1.gotoAndStop("beefy_blobbed");
                           }
                           else
                           {
                              loc1.gotoAndStop("blobbed");
                           }
                           zone.shadow_pt.gotoAndStop("off");
                           zone.gotoAndStop("blobbed");
                        }
                     }
                  }
               }
            }
         }
      }
      loc3 = loc3 + 1;
   }
}
function f_SlimeHop(zone)
{
   if(zone.punching)
   {
      zone.punching = false;
      f_SlimeAttack(zone);
   }
   zone.body_y += zone.speed_y;
   if(zone.body_y >= 0)
   {
      zone.body_y = 0;
   }
   zone.body._y = zone.body_y;
   zone.speed_y += zone.gravity;
   _root.f_MoveCharH(zone,zone.speed_x,0);
   _root.f_MoveCharV(zone,zone.speed_z,0);
   f_ShadowSize(zone);
   if(zone.body_y == 0)
   {
      zone.punching = false;
      _root.s_SlimeLand.start(0,0);
      zone.gotoAndStop("stand");
   }
}
function f_Imp(zone)
{
   if(zone.hasloot)
   {
      zone.gotoAndStop("bagrun");
      if(zone._xscale > 0)
      {
         var loc7 = zone.x;
         f_MoveCharH(zone,zone.speed,0);
         if(Math.abs(loc7 - zone.x) < 1)
         {
            zone.x += 5;
            zone._x = zone.x;
            zone.shadow_pt._x = zone.x;
         }
         if(zone.x > _root.main.right + 100)
         {
            f_EnemyDie(zone);
            return undefined;
         }
      }
      else
      {
         loc7 = zone.x;
         f_MoveCharH(zone,- zone.speed,0);
         if(Math.abs(loc7 - zone.x) < 1)
         {
            zone.x -= 5;
            zone._x = zone.x;
            zone.shadow_pt._x = zone.x;
         }
         if(zone.x < _root.main.left - 100)
         {
            f_EnemyDie(zone);
            return undefined;
         }
      }
      return undefined;
   }
   if(zone.loot)
   {
      if(!f_ConfirmPickup(zone.loot))
      {
         zone.loot = undefined;
         zone.nohit = false;
         zone.gotoAndStop("hit1");
         return undefined;
      }
   }
   if(!zone.loot)
   {
      var loc3 = 1;
      while(loc3 <= total_pickups)
      {
         var loc4 = pickupArrayOb["pickup" + int(loc3)];
         if(f_OnScreen(loc4))
         {
            if(loc4.item_type == 8)
            {
               zone.loot = loc4;
               loc3 = total_pickups + 1;
            }
         }
         loc3 = loc3 + 1;
      }
   }
   if(!zone.loot)
   {
      if(zone._xscale > 0)
      {
         zone._xscale *= -1;
      }
      loc7 = zone.x;
      f_MoveCharH(zone,- zone.speed,0);
      if(Math.abs(loc7 - zone.x) < 1)
      {
         zone.x -= 5;
         zone._x = zone.x;
         zone.shadow_pt._x = zone.x;
      }
      if(zone.x < _root.main.left - 100)
      {
         f_EnemyDie(zone);
         return undefined;
      }
   }
   else
   {
      var loc6 = Math.abs(zone.x - zone.loot.x);
      var loc5 = Math.abs(zone.y - zone.loot.y);
      if(loc6 > loc5)
      {
         zone.speed_x = zone.speed;
         zone.speed_y = zone.speed * (loc5 / loc6);
         var loc8 = loc6;
      }
      else
      {
         zone.speed_x = zone.speed * (loc6 / loc5);
         zone.speed_y = zone.speed;
         loc8 = loc5;
      }
      if(zone.x < zone.loot.x)
      {
         if(zone._xscale < 0)
         {
            zone._xscale *= -1;
         }
         f_MoveCharH(zone,zone.speed_x,0);
      }
      else
      {
         if(zone._xscale > 0)
         {
            zone._xscale *= -1;
         }
         f_MoveCharH(zone,- zone.speed_x,0);
      }
      if(zone.y < zone.loot.y)
      {
         f_MoveCharV(zone,zone.speed_y,0);
      }
      else
      {
         f_MoveCharV(zone,- zone.speed_y,0);
      }
      if(Math.abs(zone.x - zone.loot.x) <= zone.speed)
      {
         if(Math.abs(zone.y - zone.loot.y) <= zone.speed)
         {
            zone.hasloot = true;
            zone.nohit = false;
            zone.loot.body.gotoAndStop("pickup");
            f_PickupPop(zone.loot);
            zone.gotoAndStop("grab");
            return undefined;
         }
      }
      if(loc8 < zone.speed * 10)
      {
         zone.nohit = true;
         zone.gotoAndStop("dodge");
      }
   }
}
function f_SpawnImp(x, y, enemy_level)
{
   if(!enemy_level)
   {
      enemy_level = 1;
   }
   var loc2 = new Object();
   loc2.speed = 2 + random(30) / 10;
   loc2.health_max = f_SetEnemyHealth(50);
   var loc1 = f_SpawnEnemy("e_imp",x,y,loc2,total_imps);
   if(loc1)
   {
      loc1.fp_StandSettings = f_KidSettings;
      loc1.fp_Character = f_Imp;
      loc1.fp_Ranged = undefined;
      loc1.fp_Hit1 = f_Hit1Reaction;
      loc1.fp_Hit2 = f_Hit2Reaction;
      loc1.fp_Hit3 = f_Hit3Reaction;
      loc1.fp_FlipHit = f_FlipHit;
      loc1.fp_Juggle = f_Juggle1;
      loc1.intro_timer = 0;
      loc1.loot = undefined;
      loc1.grab = false;
      loc1.hasloot = false;
      loc1.dropstuff = false;
      loc1.fp_ExtremeDeath1 = undefined;
      loc1.gravity = 2;
      loc1.speed = 8;
      loc1._xscale = random(15) + 90;
      loc1._yscale = random(15) + 90;
      loc1.gotoAndStop("walk");
   }
   return loc1;
}
function f_CloseBossHealth(zone)
{
   _root.healthmeter.u_boss = undefined;
   _root.healthmeter.gotoAndStop(1);
}
function f_EnemyDropWeapon(zone)
{
   if(zone.e_type)
   {
      var loc1 = int(zone.e_type - 2);
      switch(loc1)
      {
         case 5:
            return 19;
         case 6:
            return 10;
         case 7:
            return 18;
         case 8:
            return 34;
         case 9:
            return 27;
         case 12:
            return 12;
         case 13:
            return 33;
         case 14:
            return 15;
         case 15:
            return 15;
         case 16:
            return 6;
         case 17:
            return 45;
         case 18:
            return 26;
         case 19:
            return 57;
         case 20:
            return 43;
         case 21:
            return 20;
         case 23:
            return 35;
         case 24:
            return 31;
         case 25:
            return 48;
         case 26:
            return 50;
         case 27:
            return 68;
      }
   }
   return 0;
}
function f_EnemyDie(zone)
{
   if(zone.pet and !zone.human)
   {
      zone.pet.state = 150;
      zone.pet.gotoAndStop("lost");
      zone.pet.owner = undefined;
      zone.pet = undefined;
   }
   zone.fp_DeathAction(zone);
   if(!zone.human and !zone.npc)
   {
      if(zone.humanoid)
      {
         if(zone.weapon_type)
         {
            var loc9 = f_ItemSpawn(zone.x,zone.y,10);
            loc9.weapon_type = zone.weapon_type;
            zone.weapon_type = undefined;
         }
         else if(zone.item_type)
         {
            f_ItemSpawn(zone.x,zone.y,zone.item_type);
            zone.item_type = undefined;
         }
         else
         {
            var loc4 = false;
            if(zone.emblem == 8)
            {
               if(zone.dropstuff)
               {
                  if(f_OnScreen(zone))
                  {
                     var loc5 = 1;
                     while(loc5 <= active_players)
                     {
                        loc9 = playerArrayOb["p_pt" + int(loc5)];
                        if(!loc9.hud_pt.item_unlocks[1])
                        {
                           var loc2 = 1;
                           while(loc2 <= total_pickups)
                           {
                              loc9 = pickupArrayOb["pickup" + int(loc2)];
                              if(loc9.item_type == 11)
                              {
                                 loc4 = true;
                                 loc2 = total_pickups + 1;
                              }
                              loc2 = loc2 + 1;
                           }
                           if(loc4)
                           {
                              loc4 = false;
                           }
                           else
                           {
                              f_ItemSpawn(zone.x,zone.y,11);
                              loc4 = true;
                           }
                        }
                        loc5 = loc5 + 1;
                     }
                  }
               }
            }
            if(zone.dropstuff and !loc4)
            {
               zone.dropstuff = false;
               var loc6 = f_EnemyDropWeapon(zone);
               if(zone.hitby.pet.animal_type == 5)
               {
                  loc9 = 2;
                  var loc8 = 80;
               }
               else
               {
                  loc9 = 6;
                  loc8 = 120;
               }
               if(loc6 and random(loc8) == 0)
               {
                  var loc7 = f_ItemSpawn(zone.x,zone.y,10);
                  loc7.weapon_type = loc6;
               }
               else if(random(loc9) == 0)
               {
                  f_RandomItemSpawn(zone);
               }
               else if(random(10) > 0)
               {
                  loc9 = f_ItemSpawn(zone._x,zone._y,9);
                  loc9.gem_type = 12;
               }
            }
         }
      }
      zone.alive = false;
      zone.active = false;
      _root.loader.game.game["e" + int(zone.e_pt)] = undefined;
      zone.e_pt = undefined;
      zone.gotoAndStop("blank");
      _root.f_RemoveShadow(zone);
      if(zone.hitby)
      {
         if(zone.hitby.human)
         {
            zone.hitby.kills = zone.hitby.kills + 1;
         }
         else if(zone.hitby.owner && zone.hitby.owner.human)
         {
            zone.hitby.owner.kills = zone.hitby.owner.kills + 1;
         }
      }
      _root.kills = _root.kills + 1;
      if(_root.kills >= _root.kills_goal and !_root.boss_fight)
      {
         _root.kills = 0;
         _root.kills_goal = 0;
         _root.f_SetTargets();
         if(_root.fp_SpecialEvent())
         {
            _root.fp_SpecialEvent = undefined;
         }
         else if(_root.fp_SpecialEvent2())
         {
            _root.fp_SpecialEvent2 = undefined;
         }
         else
         {
            _root.fp_SpecialEvent = undefined;
            _root.fp_SpecialEvent2 = undefined;
            _root.f_SetLeash(0,0);
            _root.go_arrow.gotoAndPlay(2);
         }
      }
      else
      {
         _root.f_CheckEQ();
         _root.f_SetTargets();
      }
   }
   else
   {
      f_PlayerArray();
   }
}
function f_EnemyDieStay(zone)
{
   if(!zone.human and !zone.npc)
   {
      zone.alive = false;
      zone.active = false;
      loader.game.game["e" + int(zone.e_pt)] = undefined;
      if(zone.pet)
      {
         zone.pet.gotoAndStop("lost");
         zone.pet.owner = undefined;
         zone.pet = undefined;
      }
      _root.kills = _root.kills + 1;
      if(_root.kills >= _root.kills_goal)
      {
         if(!_root.boss_fight)
         {
            _root.kills = 0;
            _root.kills_goal = 0;
            _root.f_SetTargets();
            _root.f_SetLeash(0,0);
            _root.go_arrow.gotoAndPlay(2);
         }
      }
      else
      {
         _root.f_CheckEQ();
         _root.f_SetTargets();
      }
   }
}
function f_EnemyMelee(zone)
{
   if(!zone.punching)
   {
      if(Math.abs(zone.y - zone.prey.y) <= zone.speed)
      {
         if(zone.magic_timer == 1)
         {
            zone.magic_wait = zone.magic_delay;
            zone.walking = false;
            zone.standing = false;
            zone.magic_timer = 0;
            zone.punching = true;
            if(random(zone.magic_air) == 0)
            {
               f_MagicJump(zone);
               zone.speed_toss_x = 0;
               zone.speed_jump = -25;
               zone.magic_jump = true;
               f_AutoJumpInit(zone);
            }
            else if(random(zone.magic_splash) == 0)
            {
               if(zone.magic_type == 16 or zone.magic_type == 20)
               {
                  zone.gotoAndStop("tornado");
               }
               else
               {
                  zone.fp_MagicMove = f_ShootMagic;
                  zone.gotoAndStop("magic1");
               }
            }
            else
            {
               zone.fp_MagicMove = f_MagicBullet;
               zone.gotoAndStop("magic1");
            }
            return undefined;
         }
         if(zone.prey.alive and zone.prey.health > 0)
         {
            if(Math.abs(zone.x - zone.prey.x) < 100)
            {
               if(!zone.prey.nohit)
               {
                  if(zone.prey.body_y > -100)
                  {
                     zone.walking = false;
                     if(random(zone.aggressiveness) == 0)
                     {
                        zone.lastpunch = 1;
                        zone.fp_Jab(zone);
                     }
                     else
                     {
                        zone.standing = true;
                     }
                  }
                  else if(zone.anti_air)
                  {
                     zone.walking = false;
                     zone.lastpunch = 1;
                     zone.gotoAndStop("punch1_4");
                  }
                  else
                  {
                     zone.walking = false;
                     zone.standing = true;
                  }
               }
            }
            else if(zone.priority == 2)
            {
               if(zone.x + game_x > 50)
               {
                  if(zone.x + game_x < scaled_screen_width - 50)
                  {
                     zone.fp_Ranged(zone);
                  }
               }
            }
            else if(zone.f_BlockFunction)
            {
               zone.f_BlockFunction(zone);
            }
         }
      }
   }
}
function f_UpdateEQ(u_temp)
{
   EnemyQ_Total++;
   this["EnemyQ" + EnemyQ_Total] = u_temp;
}
function f_LaunchEnemies()
{
   var loc2 = 1;
   while(loc2 <= EnemyMax)
   {
      u_temp = this["EnemyQ" + loc2];
      u_temp();
      loc2 = loc2 + 1;
   }
}
function f_CheckEQ()
{
   if(EnemyQ_Current < EnemyQ_Total)
   {
      EnemyQ_Current++;
      u_temp = this["EnemyQ" + EnemyQ_Current];
      u_temp();
   }
}
function f_Unleash()
{
   kills_goal += EnemyQ_Total;
   if(2 + total_players < EnemyQ_Total)
   {
      EnemyMax = 2 + total_players;
   }
   else
   {
      EnemyMax = EnemyQ_Total;
   }
   f_LaunchEnemies();
   EnemyQ_Current = EnemyMax;
}
function f_ClearQ()
{
   EnemyQ_Current = 0;
   EnemyQ_Total = 0;
}
function f_BarbBossHit(zone)
{
   if(zone.body._y < 0)
   {
      return undefined;
   }
   zone.hit_chain = zone.hit_chain + 1;
   if(zone.hit_chain > 3)
   {
      zone.hit_chain = 0;
      zone.gotoAndStop("beefy_block");
      zone.nohit = true;
   }
   else
   {
      zone.gotoAndStop("beefy_hit1");
   }
   zone.body.gotoAndPlay(1);
}
function f_SpawnBarbarianBoss(x, y)
{
   var loc3 = new Object();
   loc3.speed = 2 + random(30) / 10;
   loc3.health_max = 170 + 50 * active_players;
   var loc2 = f_SpawnEnemy("e_human",x,y,loc3,total_enemies);
   if(loc2)
   {
      loc2.fp_StandSettings = f_KidSettings;
      loc2.fp_CharacterDefault = f_BarbarianBossWalk;
      loc2.fp_Character = f_BarbarianBossWalk;
      loc2.fp_WalkAnim = f_WalkType2;
      loc2.fp_StandAnim = f_StandType2;
      loc2.fp_Jab = f_PunchSet201;
      loc2.fp_GetUpAction = f_GetUpPuch201_2;
      loc2.fp_DieAction = f_Level7BossDie;
      loc2.fp_Ranged = undefined;
      loc2.fp_Hit1 = f_BarbBossHit;
      loc2.fp_Hit2 = f_BarbBossHit;
      loc2.fp_Hit3 = f_BarbBossHit;
      loc2.beefy = true;
      loc2.grab = false;
      loc2.enemy_spawn_timer = 0;
      loc2.blocks = false;
      loc2.fp_BlockFunction = undefined;
      loc2.arrow_speed_y = -10;
      loc2.arrow_speed_x = 20;
      loc2.arrow_gravity = 2;
      loc2.weapon = 21;
      loc2.helmet = 7;
      loc2.emblem = 7;
      loc2.shield = 7;
      loc2.e_type = loc2.helmet;
      loc2.hop_timer = random(200);
      f_SetPlayerMagic(loc2,loc2.helmet);
      f_WeaponStats(loc2,loc2.weapon);
      loc2.resists = new Array(5);
      loc2.resists[DMG_MELEE] = 70;
      loc2.resists[DMG_FIRE] = 20;
      loc2.resists[DMG_ELEC] = 60;
      loc2.resists[DMG_POISON] = 70;
      loc2.resists[DMG_ICE] = 95;
      loc2.hit_chain = 0;
      loc2.n_width = 70;
      loc2.n_height = 100;
      loc2.w = 70;
      loc2.h = 100;
      loc2.weight = 15;
      boss_fight = true;
      player_used_magic = false;
      _root.healthmeter.u_boss = loc2;
      _root.healthmeter.gotoAndStop(2);
   }
   return loc2;
}
function f_BeeWalk(zone)
{
   if(zone.flying)
   {
      if(zone.priority % 2 == 0)
      {
         var loc2 = zone.prey.x - zone.priority * 50 + 50;
      }
      else
      {
         loc2 = zone.prey.x + zone.priority * 50;
      }
      if(zone.x < loc2)
      {
         if(zone._xscale < 0)
         {
            zone._xscale *= -1;
         }
         zone.speed_x = zone.speed_x + 1;
         if(zone.speed_x > 15)
         {
            zone.speed_x = 15;
         }
      }
      else if(zone.x > loc2)
      {
         if(zone._xscale > 0)
         {
            zone._xscale *= -1;
         }
         zone.speed_x = zone.speed_x - 1;
         if(zone.speed_x < -15)
         {
            zone.speed_x = -15;
         }
      }
      if(zone.y < zone.prey.y)
      {
         zone.speed_y = zone.speed_y + 1;
         if(zone.speed_y > 6)
         {
            zone.speed_y = 6;
         }
      }
      else if(zone.y > zone.prey.y)
      {
         zone.speed_y = zone.speed_y - 1;
         if(zone.speed_y < -6)
         {
            zone.speed_y = -6;
         }
      }
      f_MoveCharH(zone,zone.speed_x,0);
      f_MoveCharV(zone,zone.speed_y,0);
      zone.fly_timer = zone.fly_timer - 1;
      if(zone.fly_timer <= 0)
      {
         zone.body_y += 4;
         zone.body._y = zone.body_y;
         if(zone.body_y >= 0)
         {
            zone.body_y = 0;
            zone.body._y = 0;
            zone.fly_timer = 30 + random(90);
            zone.flying = false;
            zone.gotoAndStop("walk");
         }
         else
         {
            zone.gotoAndStop("fly");
         }
      }
      else
      {
         target_body_y = -100;
         if(zone.body_y > target_body_y + 4)
         {
            zone.body_y -= 4;
         }
         else if(zone.body_y < target_body_y - 4)
         {
            zone.body_y += 4;
         }
         zone.body._y = zone.body_y;
         zone.gotoAndStop("fly");
      }
      f_ShadowSize(zone);
   }
   else
   {
      zone.fly_timer = zone.fly_timer - 1;
      if(zone.fly_timer <= 0)
      {
         zone.flying = true;
         zone.fly_timer = 60 + random(90);
         zone.gotoAndStop("fly");
      }
      else
      {
         f_GeneralWalk(zone);
      }
   }
}
function f_CreateFish(u_num)
{
   _root.total_fish = u_num;
   var loc3 = 1;
   while(loc3 <= _root.total_fish)
   {
      var loc4 = _root.f_GetDepthModAssignment();
      var loc2 = p_game.attachMovie("invisObject","e_fish" + int(loc3),loc4);
      loadMovie("../efish/efish.swf",loc2);
      loc2.depth_mod = loc4;
      loc2.active = false;
      loc3 = loc3 + 1;
   }
}
function f_HitFish(zone)
{
   zone.body_y = 0;
   if(zone.health > 0)
   {
      zone.hit_number = zone.hit_number + 1;
      if(zone.hit_number > 4)
      {
         zone.hit_number = 1;
      }
      if(zone.hit_number == 1)
      {
         zone.gotoAndStop("hit1");
      }
      else if(zone.hit_number == 2)
      {
         zone.gotoAndStop("hit2");
      }
      else if(zone.hit_number == 3)
      {
         zone.gotoAndStop("hit1");
      }
      else if(zone.hit_number == 4)
      {
         zone.hit_number = 0;
         zone.gotoAndStop("shield");
      }
      zone.body.gotoAndPlay(1);
   }
   else
   {
      zone.alive = false;
      zone.gotoAndStop("die");
   }
}
function f_Fish(zone)
{
   if(zone.health > 0)
   {
      if(_root.active_enemies == 1)
      {
         f_RangedWalkInit(zone);
         f_EnemyRangeAttack(zone);
      }
      else
      {
         f_EnemyWalkInit(zone);
         f_EnemyMelee(zone);
      }
      f_EnemyClose(zone);
      f_EnemyWalk(zone);
   }
   else
   {
      zone.alive = false;
      zone.gotoAndStop("die");
   }
}
function f_FishAttack(zone)
{
   zone.gotoAndStop("punch1_1");
}
function f_FishDive(zone)
{
   if(active_enemies == 1)
   {
      zone.walking = false;
      zone.invincible_timer = 35;
      zone.nohit = true;
      zone.haswall = false;
      _root.f_SetTargets();
      zone.gotoAndStop("punch1_3");
   }
}
function f_CreateBeetles(u_num)
{
   _root.total_beetles = u_num;
   var loc3 = 1;
   while(loc3 <= _root.total_beetles)
   {
      var loc4 = _root.f_GetDepthModAssignment();
      var loc2 = p_game.attachMovie("invisObject","e_beetle" + int(loc3),loc4);
      loadMovie("../ebeetle/ebeetle.swf",loc2);
      loc2.depth_mod = loc4;
      loc2.active = false;
      loc3 = loc3 + 1;
   }
}
function f_HitBeetle(zone)
{
   zone.body_y = 0;
   if(zone.health > 0)
   {
      zone.hit_number = zone.hit_number + 1;
      if(zone.hit_number > 4)
      {
         zone.hit_number = 1;
      }
      var loc3 = int(zone.hit_number);
      switch(loc3)
      {
         case 1:
            zone.gotoAndStop("hit1");
            break;
         case 2:
            zone.gotoAndStop("hit2");
            break;
         case 3:
            zone.gotoAndStop("hit1");
            break;
         case 4:
            zone.alive = false;
            _root.f_SetTargets();
            if(zone._xscale > 0)
            {
               zone.left = false;
            }
            else
            {
               zone.left = true;
            }
            zone.mode_timer -= 30;
            zone.gotoAndStop("fly");
      }
      zone.body.gotoAndPlay(1);
   }
   else
   {
      zone.alive = false;
      f_RemoveShadow(zone);
      zone.gotoAndStop("die");
   }
}
function f_Beetle(zone)
{
   if(zone.health > 0)
   {
      if(zone.mode == 1)
      {
         zone.mode_timer = zone.mode_timer - 1;
         if(zone.mode_timer <= 0)
         {
            var loc6 = 0;
            var loc4 = 1;
            while(loc4 <= active_enemies)
            {
               var loc2 = enemyArrayOb["e" + int(loc4)];
               if(loc2 != zone)
               {
                  if(loc2.mode == 2)
                  {
                     loc6 = loc6 + 1;
                  }
               }
               loc4 = loc4 + 1;
            }
            if(loc6 < 2)
            {
               zone.mode_timer = 240;
               zone.mode = 2;
               zone.speed_x = 1;
               zone.speed_x_max = 20;
               zone.speed_y = 1;
               zone.speed_y_max = 20;
               zone.alive = false;
               _root.f_SetTargets();
               zone.gotoAndStop("punch2_1");
               return undefined;
            }
         }
         f_EnemyWalkInit(zone);
         f_EnemyMelee(zone);
         f_EnemyClose(zone);
         f_EnemyWalk(zone);
      }
      else if(zone.mode == 2)
      {
         zone.mode_timer = zone.mode_timer - 1;
         if(zone.mode_timer <= 0)
         {
            zone.mode_timer = 200 + random(100);
            zone.mode = 1;
            zone.gotoAndStop("punch2_3");
            return undefined;
         }
         var loc7 = 80 + random(20);
         if(zone._xscale > 0)
         {
            f_MoveCharH(zone,zone.speed_x,0);
            if(zone.x > _root.main.right - 200)
            {
               zone.speed_x = zone.speed_x - 1;
            }
            else if(zone.speed_x < zone.speed_x_max)
            {
               zone.speed_x = zone.speed_x + 1;
            }
         }
         else
         {
            loc7 *= -1;
            f_MoveCharH(zone,- zone.speed_x,0);
            if(zone.x < _root.main.left + 200)
            {
               zone.speed_x = zone.speed_x - 1;
            }
            else if(zone.speed_x < zone.speed_x_max)
            {
               zone.speed_x = zone.speed_x + 1;
            }
         }
         if(zone.y > zone.prey.y)
         {
            zone.speed_y = zone.speed_y - 1;
            if(zone.speed_y < - zone.speed_x / 2)
            {
               zone.speed_y = - zone.speed_x / 2;
            }
         }
         else if(zone.y < zone.prey.y)
         {
            zone.speed_y = zone.speed_y + 1;
            if(zone.speed_y > zone.speed_x / 2)
            {
               zone.speed_y = zone.speed_x / 2;
            }
         }
         f_MoveCharV(zone,zone.speed_y,0);
         zone.body._yscale = zone.speed_x / zone.speed_x_max * 100;
         if(zone.speed_x < 1)
         {
            zone._xscale *= -1;
         }
         if(zone.mode_timer % 2 == 0)
         {
            f_FX(zone.x,zone.y + random(8),int(zone.y) + 1,level_dust,loc7,Math.abs(loc7));
         }
         if(zone.body._yscale > 20)
         {
            var loc5 = false;
            loc4 = 1;
            while(loc4 <= active_players)
            {
               loc2 = playerArrayOb["p_pt" + int(loc4)];
               if(loc2.alive and loc2.invincible_timer <= 0)
               {
                  if(Math.abs(loc2.y - zone.y) < 15)
                  {
                     if(Math.abs(loc2.x - zone.x) < 40)
                     {
                        if(loc2.body_y > -6)
                        {
                           if(loc2.toss_clock <= 0)
                           {
                              if(loc2.blocking)
                              {
                                 if(loc2._xscale > 0 and zone._xscale < 0 or loc2._xscale < 0 and zone._xscale > 0)
                                 {
                                    f_BlockSound();
                                    loc2.gotoAndStop("block1");
                                    loc2.body.body.gotoAndPlay(1);
                                    zone._xscale *= -1;
                                    return undefined;
                                 }
                              }
                              loc5 = true;
                              f_FX(loc2.x,loc2.y + loc2.body_y - 30,int(loc2.y + 1),"impact1",100,100);
                              f_Damage(loc2,zone.punch_pow_low / 3,_root.DMG_MELEE,_root.DMGFLAG_JUGGLE,2,- (18 + random(6)));
                           }
                        }
                     }
                  }
               }
               loc4 = loc4 + 1;
            }
            if(loc5)
            {
               f_PunchSound();
            }
         }
      }
   }
   else
   {
      zone.alive = false;
      zone.gotoAndStop("die");
   }
}
function f_BeetleAttack(zone)
{
   zone.gotoAndStop("punch1_1");
}
function f_InitAntlion(u_temp)
{
   u_temp.boomerangexploit = true;
   u_temp.x = u_temp._x;
   u_temp.y = u_temp._y;
   u_temp._x = u_temp.x;
   u_temp._y = u_temp.y;
   u_temp.body_y = 0;
   u_temp.body._y = u_temp.body_y;
   _root.f_Depth(u_temp,u_temp.y);
   u_temp.haswall = true;
   u_temp.active = true;
   u_temp.alive = true;
   u_temp.head_x = 0;
   u_temp.head_y = 0;
   u_temp.speed_x = 0;
   u_temp.speed_y = 0;
   u_temp.h = 150;
   u_temp.w = 50;
   u_temp.health_max = f_SetEnemyHealth(200);
   u_temp.health = u_temp.health_max;
   u_temp.mode = 1;
   u_temp.invincible_timer = 0;
   u_temp.mode_timer = 0;
   u_temp.spawn_timer = 0;
   u_temp.shot_timer = 0;
   u_temp.shot_timer2 = 30;
   f_UnresponsiveDefaults(u_temp);
   u_temp.humanoid = false;
   u_temp.resists = new Array(5);
   u_temp.resists[DMG_MELEE] = 50;
   u_temp.resists[DMG_POISON] = 50;
   u_temp.resists[DMG_FIRE] = 50;
   u_temp.resists[DMG_ELEC] = 50;
   u_temp.resists[DMG_ICE] = 50;
   u_temp.fp_Hit1 = f_HitAntlion;
   u_temp.fp_Hit2 = f_HitAntlion;
   u_temp.fp_Hit3 = f_HitAntlion;
   u_temp.fp_Juggle = f_HitAntlion;
   _root.f_LargeObjectRanges(u_temp);
   _root.f_PushCharsOut(u_temp);
   _root.f_InsertEnemy(u_temp);
   return u_temp;
}
function f_HitAntlion(zone)
{
   if(zone.hitby.x < zone.x)
   {
      if(zone.head_x < 30)
      {
         zone.speed_x = 10;
      }
   }
   else if(zone.head_x > -30)
   {
      zone.speed_x = -10;
   }
}
function f_Antlion(zone)
{
   var loc8 = zone._xscale;
   if(zone.health <= 0)
   {
      if(zone.hostage)
      {
         zone.shot_timer = 90;
         zone.hostage.captor = undefined;
         zone.hostage.speed_jump = 1;
         zone.hostage.jumping = true;
         _root.f_SetXY(zone.hostage,zone.hostage.x,zone.hostage.y + 15);
         zone.hostage.body_y -= 15;
         zone.hostage.gotoAndStop("jump");
         zone.hostage = undefined;
      }
      zone.alive = false;
      f_SetTargets();
      _root.s_AntlionDie.start(0,0);
      zone.gotoAndStop("die");
   }
   else
   {
      if(!zone.hostage)
      {
         var loc3 = f_FaceClosestPlayer(zone);
         var loc6 = Math.abs(zone.x - loc3.x);
         var loc5 = Math.abs(zone.y - loc3.y);
         if(loc6 < 10)
         {
            if(loc3.y < zone.y)
            {
               zone.body.gotoAndStop(7);
            }
            else
            {
               zone.body.gotoAndStop(1);
            }
         }
         else if(loc6 < 20)
         {
            if(loc3.y < zone.y)
            {
               zone.body.gotoAndStop(6);
            }
            else
            {
               zone.body.gotoAndStop(2);
            }
         }
         else if(loc6 < 50)
         {
            if(loc3.y < zone.y)
            {
               zone.body.gotoAndStop(5);
            }
            else
            {
               zone.body.gotoAndStop(3);
            }
         }
         else if(loc3.y < zone.y)
         {
            if(loc5 < 15 or loc6 > 400)
            {
               zone.body.gotoAndStop(4);
            }
            else
            {
               zone.body.gotoAndStop(5);
            }
         }
         else if(loc5 < 15 or loc6 > 400)
         {
            zone.body.gotoAndStop(4);
         }
         else
         {
            zone.body.gotoAndStop(3);
         }
      }
      if(zone.head_x > 5)
      {
         zone.speed_x = zone.speed_x - 1;
      }
      else if(zone.head_x < -5)
      {
         zone.speed_x = zone.speed_x + 1;
      }
      else if(random(2) == 1)
      {
         zone.speed_x = zone.speed_x + 1;
      }
      else
      {
         zone.speed_x = zone.speed_x - 1;
      }
      if(zone.speed_x > 10)
      {
         zone.speed_x = 10;
      }
      else if(zone.speed_x < -10)
      {
         zone.speed_x = -10;
      }
      zone.head_x += zone.speed_x;
      if(zone._xscale < 0)
      {
         zone.body.head._x = - zone.head_x;
         zone.body.head2._x = - zone.head_x;
         zone.body.body._x = (- zone.head_x) / 2;
      }
      else
      {
         zone.body.head._x = zone.head_x;
         zone.body.head2._x = zone.head_x;
         zone.body.body._x = zone.head_x / 2;
      }
      if(zone.body && loc8 * zone._xscale < 0)
      {
         if(zone.body.head)
         {
            HiFps_Reset(zone.body.head);
         }
         if(zone.body.head2)
         {
            HiFps_Reset(zone.body.head2);
         }
         if(zone.body.body)
         {
            HiFps_Reset(zone.body.body);
         }
      }
      if(zone.head_y > -5)
      {
         zone.speed_y = zone.speed_y - 1;
      }
      else if(zone.head_y < -5)
      {
         zone.speed_y = zone.speed_y + 1;
      }
      else if(random(2) == 1)
      {
         zone.speed_y = zone.speed_y + 1;
      }
      else
      {
         zone.speed_y = zone.speed_y - 1;
      }
      zone.head_y += zone.speed_y;
      zone.body.head._y = zone.head_y - 60;
      zone.body.head2._y = zone.head_y - 60;
      zone.body.body._y = zone.head_y / 2 - 45;
      if(!zone.hostage and f_OnScreen(zone))
      {
         zone.shot_timer2 = zone.shot_timer2 - 1;
         if(zone.shot_timer2 <= 0)
         {
            zone.shot_timer2 = 60;
            var loc7 = 20;
            if(_root.insane_mode)
            {
               loc7 *= 10;
            }
            u_temp2 = f_Shoot(zone,"general_projectile",loc7,20,- (3 + random(4)),2);
            u_temp2.projectile_type = 73;
            if(zone._xscale > 0)
            {
               u_temp2.x = zone.x + zone.body._x + zone.body.punch_pt._x;
            }
            else
            {
               u_temp2.x = zone.x - zone.body._x - zone.body.punch_pt._x;
            }
            u_temp2._x = u_temp2.x;
            if(zone.body._currentframe > 4)
            {
               u_temp2.y = zone.y - 5;
            }
            else
            {
               u_temp2.y = zone.y + 5;
            }
            u_temp2._y = u_temp2.y;
            f_Depth(u_temp2,u_temp2.y);
            u_temp2.shadow_pt._x = u_temp2.x;
            u_temp2.shadow_pt._y = u_temp2.y;
            loc6 = Math.abs(u_temp2.x - loc3.x);
            loc5 = Math.abs(u_temp2.y - loc3.y);
            if(loc6 > loc5)
            {
               u_temp2.speed_x = 14;
               u_temp2.speed_z = 14 * (loc5 / loc6);
            }
            else
            {
               u_temp2.speed_x = 14 * (loc6 / loc5);
               u_temp2.speed_z = 14;
            }
            if(u_temp2.x > loc3.x)
            {
               u_temp2._xscale *= -1;
               u_temp2.speed_x *= -1;
            }
            if(u_temp2.y > loc3.y)
            {
               u_temp2.speed_z *= -1;
            }
         }
         if(zone.shot_timer <= 0)
         {
            var loc4 = 1;
            while(loc4 <= active_players)
            {
               loc3 = playerArrayOb["p_pt" + int(loc4)];
               if(loc3.alive)
               {
                  if(Math.abs(loc3.x - (zone.x + zone.head_x)) < 50)
                  {
                     if(Math.abs(loc3.y - zone.y) < 25)
                     {
                        if(!loc3.beefy && loc3.p_type != 32)
                        {
                           zone.hostage = loc3;
                           loc3.captor = zone;
                           loc3.nohit = true;
                           loc3.gotoAndStop("antlion");
                           _root.f_SetXY(loc3,zone.x,zone.y + 1);
                           loc3.body_y = zone.body.head._y + zone.body._y;
                           loc3.body._y = zone.hostage.body_y;
                           s_Chomp.start(0,0);
                           f_FX(zone.x + zone.head_x,zone.body.head._y + zone.body._y + zone.y,int(zone.y) + 1,"impact1",100,100);
                           zone.body.gotoAndStop("punch1_1");
                           return undefined;
                        }
                     }
                  }
               }
               loc4 = loc4 + 1;
            }
         }
         else
         {
            zone.shot_timer = zone.shot_timer - 1;
         }
      }
      else
      {
         zone.hostage.body_y = zone.body.head._y + zone.body._y;
         zone.hostage.body._y = zone.hostage.body_y;
         _root.f_SetXY(zone.hostage,zone.head_x + zone.body._x + zone.x,zone.hostage.y);
      }
   }
}
function f_CreateUFO(u_num)
{
   total_ufo = u_num;
   var loc2 = 1;
   while(loc2 <= total_ufo)
   {
      var loc3 = f_GetDepthModAssignment();
      var loc1 = p_game.attachMovie("invisObject","ufo" + int(loc2),loc3);
      loadMovie("../ufo/ufo.swf",loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc3 = f_GetDepthModAssignment();
      loc1 = p_game.attachMovie("invisObject","ufodust" + int(loc2),loc3);
      loadMovie("../ufodust/ufodust.swf",loc1);
      loc1.depth_mod = loc3;
      loc1.active = false;
      loc2 = loc2 + 1;
   }
}
function f_MakeUFO(x, y)
{
   var loc3 = 1;
   while(loc3 <= total_ufo)
   {
      var loc2 = p_game["ufo" + loc3];
      if(!loc2.active)
      {
         loc2.active = true;
         loc2.alive = true;
         loc2.shadow_pt = p_game["ufodust" + loc3];
         loc2.shadow_pt.gotoAndStop("on");
         f_SetXY(loc2,x,y);
         loc2.gotoAndStop("fly");
         loc2.body_y = -100;
         loc2.body._y = loc2.body_y;
         loc2.haswall = false;
         loc2.h = 175;
         loc2.w = 80;
         loc2.health_max = 300 + 100 * active_players;
         if(_root.insane_mode)
         {
            loc2.health_max *= 10;
         }
         loc2.health = loc2.health_max;
         loc2.resists = new Array(5);
         loc2.resists[DMG_MELEE] = 50;
         loc2.resists[DMG_FIRE] = 50;
         loc2.resists[DMG_ELEC] = 50;
         loc2.resists[DMG_POISON] = 50;
         loc2.resists[DMG_ICE] = 50;
         loc2.onground = false;
         loc2.nohit = false;
         f_UnresponsiveDefaults(loc2);
         f_LargeObjectRanges(loc2);
         loc2.fp_CheckYSpace = f_ObjectCheckYSpace;
         loc2.fp_Hit1 = f_HitUFO;
         loc2.fp_Hit2 = f_HitUFO;
         loc2.fp_Hit3 = f_HitUFO;
         loc2.fp_Juggle = f_HitUFO;
         loc2.speed_x = 0;
         loc2.speed_y = 0;
         loc2.alien_timer = 60;
         loc2.mode = 1;
         loc2.stones = 0;
         loc2.s_Engine = f_SoundX(loc2,s_Engine,loc2.x,300,10000);
         f_InsertEnemy(loc2);
         f_SetActiveEnemies();
         return loc2;
      }
      loc3 = loc3 + 1;
   }
}
function f_UFOCheckDead(zone)
{
   if(zone.health <= 0)
   {
      if(zone.ufostone)
      {
         zone.ufostone.gotoAndStop("ufostonedrop");
         zone.ufostone = undefined;
         s_DarkForce.stop();
      }
      zone.alive = false;
      zone.gotoAndStop("die");
      return true;
   }
   return false;
}
function f_HitUFO(zone)
{
   zone.body.body.gotoAndPlay("hit");
   if(zone.mode != 2)
   {
      if(zone.hitby._xscale > 0)
      {
         zone.speed_x = 10;
      }
      else
      {
         zone.speed_x = -10;
      }
   }
   if(zone.health < zone.health_max * 0.8 and !zone.ufostone)
   {
      if(zone.stones <= 0)
      {
         zone.stones = zone.stones + 1;
         zone.mode = 2;
      }
      else if(zone.health < zone.health_max * 0.6)
      {
         if(zone.stones <= 1)
         {
            zone.stones = zone.stones + 1;
            zone.mode = 2;
         }
      }
   }
   f_UFOCheckDead(zone);
}
function f_UFOFly(zone)
{
   if(!f_UFOCheckDead(zone))
   {
      f_SoundPan(zone.s_Engine,zone.x,300);
      switch(zone.mode)
      {
         case 1:
            var loc6 = zone.speed_x;
            if(zone.x < zone.destin_x - zone.speed_x)
            {
               zone.speed_x = zone.speed_x + 1;
            }
            else if(zone.x > zone.destin_x + zone.speed_x)
            {
               zone.speed_x = zone.speed_x - 1;
            }
            else if(zone.speed_x > 0)
            {
               zone.speed_x = zone.speed_x - 1;
            }
            else if(zone.speed_x < 0)
            {
               zone.speed_x = zone.speed_x + 1;
            }
            if(zone.speed_x > 24)
            {
               zone.speed_x = 24;
            }
            else if(zone.speed_x < -24)
            {
               zone.speed_x = -24;
            }
            if(zone.body_y < -100)
            {
               zone.body_y = zone.body_y + 1;
               zone.body._y = zone.body_y;
            }
            var loc5 = 100 + zone.body_y / 3;
            zone.shadow_pt.body._xscale = loc5;
            zone.shadow_pt.body._yscale = loc5;
            var loc4 = zone.body.body.body.body.thruster._rotation;
            if(loc4 < zone.speed_x * 2)
            {
               loc4 = loc4 + 1;
            }
            else if(loc4 > zone.speed_x * 2)
            {
               loc4 = loc4 - 1;
            }
            zone.body.body.body.body.thruster._rotation = loc4;
            f_MoveCharH(zone,zone.speed_x,0);
            f_LargeObjectRanges(zone);
            if(zone.alien_timer > 0)
            {
               zone.alien_timer = zone.alien_timer - 1;
            }
            else if(active_enemies < 30)
            {
               var loc3 = f_SpawnAlien(zone.x,zone.y + 1);
               if(loc3)
               {
                  s_DarkMagic1.start(0,0);
                  f_FX(zone.x,zone.y + zone.body_y + 30,zone.y + 2,"impact4",60,60);
                  loc3.body_y = zone.body_y + 30;
                  loc3.speed_toss_x = 0;
                  loc3.speed_toss_y = 10;
                  f_Juggle1Setup(loc3);
                  loc3.gotoAndStop("juggle1");
                  _root.kills_goal += 1;
                  _root.f_SetTargets();
               }
               zone.alien_timer = 60;
            }
            break;
         case 2:
            if(zone.x < main.right + 200)
            {
               zone.speed_x = zone.speed_x + 1;
               f_MoveCharH(zone,zone.speed_x,0);
            }
            else
            {
               zone.mode = 3;
            }
            break;
         case 3:
            zone.alien_timer = 60;
            zone.body_y = -220;
            zone.body._y = zone.body_y;
            loc5 = 100 + zone.body_y / 3;
            zone.shadow_pt.body._xscale = loc5;
            zone.shadow_pt.body._yscale = loc5;
            loc3 = f_FX(zone.x,zone.y,zone.y + 1,"ufostone",100,100);
            loc3.body_y = zone.body_y + 60;
            loc3.body._y = loc3.body_y;
            loc3.shadow_pt = f_NewShadow();
            zone.ufostone = loc3;
            zone.mode = 4;
            zone.prey = f_PickRandomPlayer();
            zone.stone_timer = 900;
            s_DarkForce.start(0,2000);
            zone.body.body.body.body.beam.gotoAndStop(2);
            break;
         case 4:
            if(zone.x < zone.prey.x - zone.speed_x)
            {
               zone.speed_x = zone.speed_x + 1;
            }
            else if(zone.x > zone.prey.x + zone.speed_x)
            {
               zone.speed_x = zone.speed_x - 1;
            }
            else if(zone.speed_x > 0)
            {
               zone.speed_x = zone.speed_x - 1;
            }
            else if(zone.speed_x < 0)
            {
               zone.speed_x = zone.speed_x + 1;
            }
            if(zone.speed_x > 24)
            {
               zone.speed_x = 24;
            }
            else if(zone.speed_x < -24)
            {
               zone.speed_x = -24;
            }
            loc4 = zone.body.body.body.body.thruster._rotation;
            if(loc4 < zone.speed_x * 2)
            {
               loc4 = loc4 + 1;
            }
            else if(loc4 > zone.speed_x * 2)
            {
               loc4 = loc4 - 1;
            }
            zone.body.body.body.body.thruster._rotation = loc4;
            f_MoveCharH(zone,zone.speed_x,0);
            if(zone.y < zone.prey.y - 1)
            {
               f_MoveCharV(zone,1,0);
            }
            else if(zone.y > zone.prey.y + 1)
            {
               f_MoveCharV(zone,-1,0);
            }
            f_LargeObjectRanges(zone);
            if(zone.ufostone)
            {
               if(zone.ufostone.x < zone.x - 1)
               {
                  zone.ufostone.x += (zone.x - zone.ufostone.x) / 2;
               }
               else if(zone.ufostone.x > zone.x + 1)
               {
                  zone.ufostone.x += (zone.x - zone.ufostone.x) / 2;
               }
               zone.ufostone.y = zone.y + 1;
               f_SetXY(zone.ufostone,zone.ufostone.x,zone.ufostone.y);
               zone.ufostone.body_y = zone.body_y + 60;
               zone.ufostone.body._y = zone.ufostone.body_y;
            }
            zone.stone_timer = zone.stone_timer - 1;
            if(Math.abs(zone.x - zone.prey.x) < 20 and Math.abs(zone.y - zone.prey.y) < 15 or zone.stone_timer <= 0)
            {
               if(zone.ufostone)
               {
                  zone.ufostone.gotoAndStop("ufostonedrop");
                  zone.ufostone = undefined;
               }
               zone.body.body.body.body.beam.gotoAndStop(1);
               s_DarkForce.stop();
               zone.mode = 1;
               return undefined;
            }
            break;
      }
      if(Math.abs(zone.speed_x) > 6)
      {
         loc3 = _root.f_FX(zone.x - 50 + random(100),zone.y + zone.body_y + random(40),zone.y - 1,"smokefade2",100,100);
         loc3.body1._rotation = random(50) - 25;
         loc3.body1._x = random(40) - 20;
         loc3.body1._y = random(20) - 10;
         loc5 = random(30) + 70;
         loc3.body1._xscale = loc5;
         loc3.body1._yscale = loc5;
         loc3.body2._rotation = random(50) - 25;
         loc3.body2._x = random(40) - 20;
         loc3.body2._y = random(20) - 10;
         loc5 = random(30) + 70;
         loc3.body2._xscale = loc5;
         loc3.body2._yscale = loc5;
         loc3.body3._rotation = random(50) - 25;
         loc3.body3._x = random(40) - 20;
         loc3.body3._y = random(20) - 10;
         loc5 = random(30) + 70;
         loc3.body3._xscale = loc5;
         loc3.body3._yscale = loc5;
      }
   }
}
function f_UFOStoneDrop(zone)
{
   zone.speed_y = zone.speed_y + 1;
   zone.body_y += zone.speed_y;
   if(zone.body_y > 0)
   {
      zone.body_y = 0;
      f_MakeShrapnel(14,zone.x,zone.y,0,100);
      f_MakeShrapnel(15,zone.x - 25,zone.y,-4,-100);
      f_MakeShrapnel(16,zone.x + 25,zone.y,0,100);
      f_MakeShrapnel(14,zone.x - 50,zone.y,-7,-100);
      f_MakeShrapnel(14,zone.x + 100,zone.y,-2,100);
      f_MakeShrapnel(15,zone.x + 50,zone.y,0,100);
      f_MakeShrapnel(15,zone.x - 100,zone.y,-5,-100);
      f_MakeShrapnel(16,zone.x - 75,zone.y,0,100);
      f_MakeShrapnel(16,zone.x + 75,zone.y,-8,100);
      _root.f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,100,100);
      _root.f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,-80,80);
      _root.f_FX(zone.x + 40,zone.y + 1,int(zone.y) + 1,level_dust,80,80);
      _root.f_FX(zone.x - 40,zone.y + 1,int(zone.y) + 1,level_dust,-100,100);
      _root.f_FX(zone.x - 20,zone.y + 10,int(zone.y) + 10,level_dust,100,100);
      _root.f_FX(zone.x + 20,zone.y - 10,int(zone.y) - 10,level_dust,-80,80);
      _root.f_FX(zone.x + 70,zone.y + 5,int(zone.y) + 5,level_dust,80,80);
      _root.f_FX(zone.x - 70,zone.y - 5,int(zone.y) - 5,level_dust,-100,100);
      s_SlamGround.start(0,0);
      f_ScreenShake(0.2,8,0);
      f_RemoveShadow(zone);
      var loc4 = 1;
      while(loc4 <= active_players)
      {
         var loc3 = playerArrayOb["p_pt" + int(loc4)];
         if(loc3.alive)
         {
            if(Math.abs(loc3.x - zone.x) < 50)
            {
               if(Math.abs(loc3.y - zone.y) < 10)
               {
                  if(loc3.y >= zone.y)
                  {
                     f_MoveCharV(loc3,zone.y - loc3.y,0);
                  }
                  f_FX(loc3.x,zone.y,int(zone.y) + 2,"impact1",100,100);
                  s_Punch3.start(0,0);
                  loc3.burried = true;
                  loc3.nohit = true;
                  loc3.body_y = 0;
                  loc3.gotoAndStop("burried");
                  var loc5 = 10;
                  if(_root.insane_mode)
                  {
                     loc5 = 50;
                  }
                  f_Damage(loc3,loc5,DMG_MELEE);
               }
            }
         }
         loc4 = loc4 + 1;
      }
      zone.gotoAndStop("remove");
      return undefined;
   }
   zone.body._y = zone.body_y;
}
function f_BeefyHit(zone)
{
   return undefined;
}
function f_BeefyJuggle(zone)
{
   if(zone.hitby.punch_group == 4)
   {
      if(!zone.hitby.beefy and zone.hitby.humanoid)
      {
         if(zone.hitby.body_y < -30)
         {
            f_Damage(zone.hitby,1,DMG_MELEE,DMGFLAG_JUGGLE,8 + random(4),- (6 + random(6)));
         }
         else
         {
            zone.hitby.speed_toss_x = 12;
            zone.hitby.gotoAndStop("blocked");
            zone.hitby.body.gotoAndPlay(1);
         }
         return undefined;
      }
   }
   f_DropHostage(zone);
   if(zone.thrown)
   {
      zone.thrown = false;
      f_Juggle1Setup(zone);
      zone.gotoAndStop("juggle1");
      zone.body._y = zone.body_y + zone.body_table_y;
      return undefined;
   }
   zone.hit_number = zone.hit_number + 1;
   if(zone.hit_number > 4)
   {
      zone.hit_number = 1;
   }
   var loc2 = int(zone.hit_number);
   switch(loc2)
   {
      case 1:
         zone.gotoAndStop("hit1");
         break;
      case 2:
         zone.gotoAndStop("hit2");
         break;
      case 3:
         zone.gotoAndStop("hit1");
         break;
      default:
         f_Juggle1Setup(zone);
         zone.gotoAndStop("juggle1");
         zone.body._y = zone.body_y + zone.body_table_y;
   }
}
function f_BeefyChain(zone)
{
   if(!zone.human)
   {
      if(zone.hit_number > 0)
      {
         var loc3 = 1;
         while(loc3 <= active_players)
         {
            var loc2 = playerArrayOb["p_pt" + int(loc3)];
            if(loc2.alive and !loc2.nohit and !loc2.beefy && !loc2.noBeefyGrabs)
            {
               if(Math.abs(zone.x - loc2.x) < 100)
               {
                  if(Math.abs(zone.y - loc2.y) < zone.speed)
                  {
                     zone.prev_Character = zone.fp_Character;
                     f_BeefyGrabEnemy(zone,zone.prey);
                     f_SetTargets();
                     zone.fp_Character = f_EnemyWalkToss;
                  }
               }
            }
            loc3 = loc3 + 1;
         }
      }
   }
   zone.hit_number = 0;
}
function f_BeefyEnemyWalk(zone)
{
   if(zone.alive)
   {
      zone.enemy_spawn_timer = zone.enemy_spawn_timer + 1;
      if(!_root.f_BeefyGrapple(zone))
      {
         _root.f_EnemyWalkInit(zone);
         _root.f_EnemyMelee(zone);
         _root.f_EnemyClose(zone);
         _root.f_EnemyWalk(zone);
      }
   }
}
function f_MakeEnemyBeefy(u_temp)
{
   u_temp.fp_CharacterDefault = f_BeefyEnemyWalk;
   u_temp.fp_Character = f_BeefyEnemyWalk;
   u_temp.fp_WalkAnim = f_WalkType2;
   u_temp.fp_StandAnim = f_StandType2;
   u_temp.fp_Jab = f_PunchSet201;
   u_temp.fp_DieAction = f_BeefyEnemyDie;
   u_temp.fp_Ranged = undefined;
   u_temp.fp_Hit1 = f_BeefyHit;
   u_temp.fp_Hit2 = f_BeefyHit;
   u_temp.fp_Hit3 = f_BeefyHit;
   u_temp.fp_Juggle = f_BeefyJuggle;
   u_temp.beefy = true;
   u_temp.grab = false;
   u_temp.blocks = false;
   u_temp.fp_BlockFunction = undefined;
   u_temp.grapple_min = 6;
   u_temp.grapple_mod = 4;
   u_temp.weight = 4;
   u_temp.hit_number = 0;
   u_temp.n_width = 70;
   u_temp.n_height = 100;
}
function f_BeefyEnemyDie(zone)
{
   return true;
}
function f_ImpStealDeath(zone)
{
   zone.dropstuff = false;
   f_ItemSpawn(zone.x,zone.y,8);
   var loc2 = f_SpawnImp(zone.x,zone.y);
   if(loc2)
   {
      f_MoveCharH(loc2,main.right + 75 - zone.x,0);
      kills_goal += 1;
      f_SetTargets();
   }
}
function f_ArrowPlink(zone)
{
   return undefined;
}
function f_InitSaveSystem()
{
   save_data_info = new Object();
   save_data_info.char_offset = 64;
   save_data_info.char_size = 48;
   save_data_info.num_items = 128;
   save_data_info.num_animals = 32;
   save_data_info.num_levels = 64;
   save_data_info.num_relics = 8;
   save_data_info.num_items_expansion = 64;
   save_data_info.num_characters = 33;
   relic_offset = 40;
   weapon_offset = 50;
}
function f_LoadCharacterData(playerNum)
{
   var loc2 = _root["hud" + int(playerNum)];
   var loc4 = loc2.port - 1;
   loc2.animal_unlocks = new Array(int(save_data_info.num_animals));
   loc2.item_unlocks = new Array(int(save_data_info.num_items));
   loc2.item_unlocks_expansion = new Array(int(save_data_info.num_items_expansion));
   loc2.level_unlocks = new Array(int(save_data_info.num_levels));
   loc2.relic_unlocks = new Array(int(save_data_info.num_relics));
   loc2.normal_level_unlocks = new Array(4);
   loc2.insane_level_unlocks = new Array(4);
   if(console_version)
   {
      var loc13 = 8;
      var loc3 = 1;
      while(loc3 < save_data_info.num_animals)
      {
         var loc7 = Math.floor(loc3 / 8);
         var loc5 = loc3 % 8;
         var loc6 = Math.pow(2,loc5);
         var loc8 = ReadStorage(loc4,loc13 + loc7);
         if(loc8 & loc6)
         {
            loc2.animal_unlocks[loc3] = true;
         }
         else
         {
            loc2.animal_unlocks[loc3] = false;
         }
         loc3 = loc3 + 1;
      }
      loc13 = 12;
      loc3 = 1;
      while(loc3 < save_data_info.num_items)
      {
         loc7 = Math.floor(loc3 / 8);
         loc5 = loc3 % 8;
         loc6 = Math.pow(2,loc5);
         loc8 = ReadStorage(loc4,loc13 + loc7);
         if(loc8 & loc6)
         {
            loc2.item_unlocks[loc3] = true;
         }
         else
         {
            loc2.item_unlocks[loc3] = false;
         }
         loc3 = loc3 + 1;
      }
      loc13 = 28;
      loc3 = 0;
      while(loc3 < save_data_info.num_items_expansion)
      {
         loc7 = Math.floor(loc3 / 8);
         loc5 = loc3 % 8;
         loc6 = Math.pow(2,loc5);
         loc8 = ReadStorage(loc4,loc13 + loc7);
         if(loc8 & loc6)
         {
            loc2.item_unlocks_expansion[loc3] = true;
         }
         else
         {
            loc2.item_unlocks_expansion[loc3] = false;
         }
         loc3 = loc3 + 1;
      }
      loc2.item_unlocks[6] = false;
      loc2.item_unlocks[_root.weapon_offset + 3] = true;
      loc2.item_unlocks[_root.weapon_offset + 25] = true;
      loc2.item_unlocks[_root.weapon_offset + 39] = true;
      loc2.item_unlocks[_root.weapon_offset + 56] = true;

      loc13 = save_data_info.char_offset + save_data_info.char_size * int(f_GetSaveDataOffset(loc2.p_type));
      ReadStorage(loc4,loc13);
      loc2.level = ReadStorage(loc4) + 1;
      loc2.exp = ReadStorage(loc4) << 24 | ReadStorage(loc4) << 16 | ReadStorage(loc4) << 8 | ReadStorage(loc4);
      loc2.exp_mod = 190 + 20 * (loc2.level - 1);
      loc2.exp_next = 190 * loc2.level + 10 * (loc2.level * (loc2.level - 1));
      loc2.exp_start = loc2.exp;
      if(loc2.level > 1 and loc2.exp == 0)
      {
         loc2.exp = loc2.exp_next - loc2.exp_mod + 190;
      }
      var loc12 = ReadStorage(loc4);
      loc2.weapon = loc12;
      loc2.default_weapon = f_GetDefaultWeapon(loc2);
      var loc11 = ReadStorage(loc4);
      if(loc11 > 0)
      {
         loc2.animal_type = loc11;
      }
      loc2.strength = ReadStorage(loc4);
      loc2.defense = ReadStorage(loc4);
      loc2.magic = ReadStorage(loc4);
      loc2.agility = ReadStorage(loc4);
      if(loc2.level > 20)
      {
         var loc9 = 42 + (loc2.level - 20);
      }
      else
      {
         loc9 = loc2.level * 2 + 2;
      }
      var loc10 = loc2.strength + loc2.defense + loc2.magic + loc2.agility;
      if(loc10 > 100)
      {
         loc10 = 100;
      }
      if(loc9 > 100)
      {
         loc9 = 100;
      }
      loc2.xpgained = loc9 - loc10;
      loc2.normal_level_unlocks[0] = ReadStorage(loc4);
      loc2.normal_level_unlocks[1] = ReadStorage(loc4);
      loc2.normal_level_unlocks[2] = ReadStorage(loc4);
      loc2.healthpots = ReadStorage(loc4);
      loc2.bombs = ReadStorage(loc4);
      loc2.beefies = ReadStorage(loc4);
      loc8 = ReadStorage(loc4);
      loc3 = 0;
      while(loc3 < save_data_info.num_relics)
      {
         loc7 = Math.floor(loc3 / 8);
         loc5 = loc3 % 8;
         loc6 = Math.pow(2,loc5);
         if(loc8 & loc6)
         {
            loc2.relic_unlocks[int(loc3)] = true;
         }
         else
         {
            loc2.relic_unlocks[int(loc3)] = false;
         }
         loc3 = loc3 + 1;
      }
      loc2.item_unlocks[6] = loc2.relic_unlocks[3];
      loc2.gold = ReadStorage(loc4) << 24 | ReadStorage(loc4) << 16 | ReadStorage(loc4) << 8 | ReadStorage(loc4);
      loc2.gold_start = loc2.gold;
      loc2.insane_mode = ReadStorage(loc4);
      if(loc2.insane_mode > 0)
      {
         loc2.insane_mode = 1;
      }
      loc2.insane_level_unlocks[0] = ReadStorage(loc4);
      loc2.insane_level_unlocks[1] = ReadStorage(loc4);
      loc2.insane_level_unlocks[2] = ReadStorage(loc4);
      f_LoadLevelUnlocks(loc2);
      loc2.health_max = 1000000;
      loc2.health = loc2.health_max;
      loc2.achievement = 0;
      loc2.exp_last = 0;
      if(loc2.port == 1)
      {
         loc2.achievement |= 16;
      }
      else if(loc2.port == 2)
      {
         loc2.achievement |= 32;
      }
      else if(loc2.port == 3)
      {
         loc2.achievement |= 64;
      }
      else if(loc2.port == 4)
      {
         loc2.achievement |= 128;
      }
      if(!loc2.item_unlocks[_root.weapon_offset + 63] and loc2.weapon == 63)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks[_root.weapon_offset + 64] and loc2.weapon == 64)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks[_root.weapon_offset + 65] and loc2.weapon == 65)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks[_root.weapon_offset + 66] and loc2.weapon == 66)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks[_root.weapon_offset + 72] and loc2.weapon == 72)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks_expansion[0] and loc2.weapon == 78)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks_expansion[1] and loc2.weapon == 79)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks_expansion[7] and loc2.weapon == 85)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks[_root.weapon_offset + 71] and loc2.weapon == 71)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks[_root.weapon_offset + 75] and loc2.weapon == 75)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks[_root.weapon_offset + 76] and loc2.weapon == 76)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks[_root.weapon_offset + 77] and loc2.weapon == 77)
      {
         loc2.weapon = 2;
      }
      if(!loc2.item_unlocks_expansion[6] and loc2.weapon == 84)
      {
         loc2.weapon = 2;
      }
   }
   else
   {
      loc2.level = 40;
      loc2.magic = 20;
      loc2.exp = 0;
      loc2.gold = 0;
      loc2.kills = 0;
      loc2.healthpots = 5;
      loc2.bombs = 9;
      loc2.beefies = 9;
      loc2.weapon = 0;
      loc2.health_max = 1000000;
      loc2.health = loc2.health_max;
      loc3 = 0;
      while(loc3 < save_data_info.num_levels)
      {
         loc2.level_unlocks[loc3] = 0;
         loc3 = loc3 + 1;
      }
      loc3 = 0;
      while(loc3 < save_data_info.num_items)
      {
         if(GetCheat(4) or !console_version)
         {
            loc2.item_unlocks[loc3] = true;
         }
         else
         {
            loc2.item_unlocks[loc3] = false;
         }
         loc3 = loc3 + 1;
      }
      loc3 = 0;
      while(loc3 < save_data_info.num_items_expansion)
      {
         if(GetCheat(4) or !console_version)
         {
            loc2.item_unlocks_expansion[loc3] = true;
         }
         else
         {
            loc2.item_unlocks_expansion[loc3] = false;
         }
         loc3 = loc3 + 1;
      }
      loc2.item_unlocks[_root.weapon_offset + 3] = true;
      loc2.item_unlocks[_root.weapon_offset + 4] = true;
      loc2.item_unlocks[_root.weapon_offset + 25] = true;
      loc2.item_unlocks[_root.weapon_offset + 39] = true;
      loc3 = 0;
      while(loc3 < save_data_info.num_animals)
      {
         loc2.animal_unlocks[loc3] = false;
         loc3 = loc3 + 1;
      }
      if(GetCheat(4))
      {
         loc2.item_unlocks[1] = true;
         loc2.item_unlocks[3] = true;
      }
      loc2.achievement = 0;
      loc2.exp_last = 0;
   }
   loc2.loaded = true;
}
function f_FlushSaveData()
{
   if(!_root.IsFullGame())
   {
      return true;
   }
   if(GetGameMode() == 3)
   {
      return true;
   }
   var loc12 = true;
   var loc9 = 1;
   while(loc9 <= 4)
   {
      var loc2 = _root["hud" + int(loc9)];
      if(loc2.active and loc2.loaded == true)
      {
         var loc3 = loc2.port - 1;
         if(loc3 != -1)
         {
            if(IsLocalPlayerInSession(loc2.port - 1))
            {
               var loc11 = 7;
               var loc6 = ReadStorage(loc3,loc11);
               if(loc2.level_unlocks[46])
               {
                  loc6 |= 1;
               }
               if(loc2.level_unlocks[47])
               {
                  loc6 |= 2;
               }
               if(loc2.level_unlocks[48])
               {
                  loc6 |= 4;
               }
               if(loc2.level_unlocks[49])
               {
                  loc6 |= 8;
               }
               WriteStorage(loc3,loc11,loc6);
               loc11 = 8;
               var loc5 = 0;
               var loc4 = 1;
               while(loc4 < save_data_info.num_animals)
               {
                  var loc10 = Math.floor(loc4 / 8);
                  var loc7 = loc4 % 8;
                  var loc8 = Math.pow(2,loc7);
                  if(loc2.animal_unlocks[loc4] == true)
                  {
                     loc5 |= loc8;
                  }
                  if(loc7 == 7)
                  {
                     WriteStorage(loc3,loc11 + loc10,loc5);
                     loc5 = 0;
                  }
                  loc4 = loc4 + 1;
               }
               loc11 = 12;
               loc5 = 0;
               loc4 = 1;
               while(loc4 < save_data_info.num_items)
               {
                  loc10 = Math.floor(loc4 / 8);
                  loc7 = loc4 % 8;
                  loc8 = Math.pow(2,loc7);
                  if(loc2.item_unlocks[loc4] == true)
                  {
                     loc5 |= loc8;
                  }
                  if(loc7 == 7)
                  {
                     WriteStorage(loc3,loc11 + loc10,loc5);
                     loc5 = 0;
                  }
                  loc4 = loc4 + 1;
               }
               loc11 = 28;
               loc5 = 0;
               loc4 = 0;
               while(loc4 < save_data_info.num_items_expansion)
               {
                  loc10 = Math.floor(loc4 / 8);
                  loc7 = loc4 % 8;
                  loc8 = Math.pow(2,loc7);
                  if(loc2.item_unlocks_expansion[loc4] == true)
                  {
                     loc5 |= loc8;
                  }
                  if(loc7 == 7)
                  {
                     WriteStorage(loc3,loc11 + loc10,loc5);
                     loc5 = 0;
                  }
                  loc4 = loc4 + 1;
               }
               if(loc2.p_type)
               {
                  loc11 = save_data_info.char_offset + save_data_info.char_size * int(f_GetSaveDataOffset(loc2.p_type));
                  WriteStorage(loc3, loc11, 128);
                  WriteStorage(loc3,loc2.level - 1);
                  WriteStorage(loc3,loc2.exp >> 24);
                  WriteStorage(loc3,loc2.exp >> 16);
                  WriteStorage(loc3,loc2.exp >> 8);
                  WriteStorage(loc3,loc2.exp & 255);
                  WriteStorage(loc3,loc2.weapon);
                  WriteStorage(loc3,loc2.animal_type);
                  WriteStorage(loc3,loc2.strength);
                  WriteStorage(loc3,loc2.defense);
                  WriteStorage(loc3,loc2.magic);
                  WriteStorage(loc3,loc2.agility);
                  f_SaveLevelUnlocks(loc2);
                  WriteStorage(loc3,loc2.normal_level_unlocks[0]);
                  WriteStorage(loc3,loc2.normal_level_unlocks[1]);
                  WriteStorage(loc3,loc2.normal_level_unlocks[2]);
                  WriteStorage(loc3,loc2.healthpots);
                  WriteStorage(loc3,loc2.bombs);
                  WriteStorage(loc3,loc2.beefies);
                  loc5 = 0;
                  loc4 = 0;
                  while(loc4 < save_data_info.num_relics)
                  {
                     loc10 = Math.floor(loc4 / 8);
                     loc7 = loc4 % 8;
                     loc8 = Math.pow(2,loc7);
                     if(loc2.relic_unlocks[int(loc4)] == true)
                     {
                        loc5 |= loc8;
                     }
                     if(loc4 == 7)
                     {
                        WriteStorage(loc3,loc5);
                        loc5 = 0;
                     }
                     loc4 = loc4 + 1;
                  }
                  WriteStorage(loc3,loc2.gold >> 24);
                  WriteStorage(loc3,loc2.gold >> 16);
                  WriteStorage(loc3,loc2.gold >> 8);
                  WriteStorage(loc3,loc2.gold & 255);
                  if(loc2.insane_mode > 0)
                  {
                     WriteStorage(loc3,1);
                  }
                  else
                  {
                     WriteStorage(loc3,0);
                  }
                  WriteStorage(loc3,loc2.insane_level_unlocks[0]);
                  WriteStorage(loc3,loc2.insane_level_unlocks[1]);
                  WriteStorage(loc3,loc2.insane_level_unlocks[2]);
               }
               if(!WriteSaveGame(loc3))
               {
                  loc12 = false;
               }
            }
         }
      }
      loc9 = loc9 + 1;
   }
   return loc12;
}
function f_GetCharacterLevel(player, player_type)
{
   var loc2 = _root["hud" + player];
   var loc3 = save_data_info.char_offset + save_data_info.char_size * int(f_GetSaveDataOffset(player_type));
   ReadStorage(loc2.port - 1,loc3);
   var loc4 = ReadStorage(loc2.port - 1) + 1;
   return loc4;
}
function f_IsCharacterUnlocked(zone, item)
{
   if(GetCheat(5))
   {
      return true;
   }
   if((item >= 1 && item <= 4) || item > 31)
   {
      return true;
   }
   var loc1 = zone;
   if(loc1.active)
   {
      var loc2 = save_data_info.char_offset + save_data_info.char_size * int(f_GetSaveDataOffset(item));
      var loc3 = ReadStorage(loc1.port - 1,loc2);
      if(loc3 & 128)
      {
         return true;
      }
   }
   return false;
}
function f_SetLevelUnlocked(level)
{
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc2 = _root["hud" + int(loc3)];
      if(loc2.active and loc2.level_unlocks[level] == 0)
      {
         loc2.level_unlocks[level] = 1;
      }
      loc3 = loc3 + 1;
   }
}
function f_GetLevelUnlocked(level)
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = _root["hud" + int(loc2)];
      if(loc3.active and loc3.level_unlocks[level] > 0)
      {
         return true;
      }
      loc2 = loc2 + 1;
   }
   return false;
}
function f_SetLevelVisited(level)
{
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc2 = _root["hud" + int(loc3)];
      if(loc2.active)
      {
         if(loc2.level_unlocks[level] < 3)
         {
            loc2.level_unlocks[level] = 2;
         }
         else if(loc2.level_unlocks[level] < 4)
         {
            loc2.level_unlocks[level] = 4;
         }
      }
      loc3 = loc3 + 1;
   }
}
function f_GetLevelVisited(level)
{
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc2 = _root["hud" + int(loc3)];
      if(loc2.active)
      {
         if(loc2.level_unlocks[level] == 2 or loc2.level_unlocks[level] == 4)
         {
            return true;
         }
      }
      loc3 = loc3 + 1;
   }
   return false;
}
function f_SetLevelCompleted(level)
{
   var loc4 = 1;
   while(loc4 <= 4)
   {
      var loc2 = _root["hud" + int(loc4)];
      if(loc2.active and loc2.level_unlocks[level] < 3)
      {
         switch(level)
         {
            case 46:
            case 47:
            case 48:
            case 49:
               if(!f_IsArenaUnlocked(loc2.port - 1,level - 46))
               {
                  loc2.arenaunlock = level;
               }
         }
         loc2.level_unlocks[level] = 3;
      }
      loc4 = loc4 + 1;
   }
}
function f_GetLevelCompleted(level)
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = _root["hud" + int(loc2)];
      if(loc3.active and loc3.level_unlocks[level] > 2)
      {
         return true;
      }
      loc2 = loc2 + 1;
   }
   return false;
}
function GetCheat(num)
{
   switch(num)
   {
      case 0:
         return true;
      case 1:
         return true;
      case 2:
         return true;
      case 3:
         return true;
      case 4:
         return false;
      case 5:
         return true;
      case 6:
         return false;
      case 7:
         _root.level = 2;
         return true;
      case 8:
         return true;
      case 9:
         return true;
      default:
         return false;
   }
}
function IsFullGame()
{
   return true;
}
function f_LoadLevelUnlocks(c)
{
   var loc2 = 0;
   while(loc2 < save_data_info.num_levels)
   {
      c.level_unlocks[loc2] = 0;
      loc2 = loc2 + 1;
   }
   c.level_unlocks[2] = 1;
   c.level_unlocks[13] = 1;
   if(c.insane_mode > 1)
   {
      level_unlocks = c.insane_level_unlocks[0];
   }
   else
   {
      level_unlocks = c.normal_level_unlocks[0];
   }
   if(level_unlocks & 1)
   {
      c.level_unlocks[2] = 3;
      c.level_unlocks[13] = 3;
      c.level_unlocks[19] = 3;
      c.level_unlocks[14] = 3;
      c.level_unlocks[15] = 3;
      c.level_unlocks[16] = 3;
      c.level_unlocks[24] = 3;
      c.level_unlocks[11] = 1;
   }
   if(level_unlocks & 2)
   {
      c.level_unlocks[11] = 3;
      c.level_unlocks[12] = 3;
      c.level_unlocks[7] = 3;
      c.level_unlocks[18] = 1;
      c.level_unlocks[9] = 1;
   }
   if(level_unlocks & 4)
   {
      c.level_unlocks[18] = 3;
      c.level_unlocks[4] = 3;
      c.level_unlocks[46] = 3;
      c.level_unlocks[5] = 3;
      c.level_unlocks[22] = 1;
   }
   if(level_unlocks & 8)
   {
      c.level_unlocks[22] = 3;
      c.level_unlocks[23] = 3;
      c.level_unlocks[20] = 1;
   }
   if(level_unlocks & 16)
   {
      c.level_unlocks[20] = 3;
      c.level_unlocks[21] = 3;
      c.level_unlocks[28] = 1;
      c.level_unlocks[6] = 1;
   }
   if(level_unlocks & 32)
   {
      c.level_unlocks[28] = 3;
      c.level_unlocks[29] = 3;
      c.level_unlocks[35] = 3;
      c.level_unlocks[27] = 3;
      c.level_unlocks[37] = 1;
   }
   if(level_unlocks & 64)
   {
      c.level_unlocks[37] = 3;
      c.level_unlocks[38] = 3;
      c.level_unlocks[36] = 3;
      c.level_unlocks[26] = 3;
      c.level_unlocks[47] = 3;
      c.level_unlocks[30] = 1;
   }
   if(level_unlocks & 128)
   {
      c.level_unlocks[30] = 3;
   }
   if(c.insane_mode > 1)
   {
      level_unlocks = c.insane_level_unlocks[1];
   }
   else
   {
      level_unlocks = c.normal_level_unlocks[1];
   }
   if(level_unlocks & 1)
   {
      c.level_unlocks[6] = 3;
   }
   if(level_unlocks & 2)
   {
      c.level_unlocks[9] = 3;
      c.level_unlocks[40] = 3;
      c.level_unlocks[41] = 1;
   }
   if(level_unlocks & 4)
   {
      c.level_unlocks[41] = 3;
      c.level_unlocks[1] = 3;
      c.level_unlocks[54] = 3;
      c.level_unlocks[42] = 1;
   }
   if(level_unlocks & 8)
   {
      c.level_unlocks[42] = 3;
      c.level_unlocks[43] = 3;
      c.level_unlocks[45] = 1;
   }
   if(level_unlocks & 16)
   {
      c.level_unlocks[33] = 3;
      c.level_unlocks[10] = 3;
      c.level_unlocks[8] = 3;
      c.level_unlocks[48] = 3;
   }
   if(level_unlocks & 32)
   {
      c.level_unlocks[45] = 3;
      c.level_unlocks[32] = 3;
      c.level_unlocks[3] = 3;
      c.level_unlocks[52] = 3;
      c.level_unlocks[34] = 1;
   }
   if(level_unlocks & 64)
   {
      c.level_unlocks[34] = 3;
      c.level_unlocks[31] = 1;
   }
   if(level_unlocks & 128)
   {
      c.level_unlocks[31] = 3;
      c.level_unlocks[51] = 3;
      c.level_unlocks[57] = 3;
      c.level_unlocks[17] = 3;
      c.level_unlocks[49] = 3;
      c.level_unlocks[25] = 1;
   }
   if(c.insane_mode > 1)
   {
      level_unlocks = c.insane_level_unlocks[2];
   }
   else
   {
      level_unlocks = c.normal_level_unlocks[2];
   }
   if(level_unlocks & 1)
   {
      c.level_unlocks[25] = 3;
      c.level_unlocks[44] = 3;
      c.level_unlocks[53] = 3;
      c.level_unlocks[55] = 3;
      c.level_unlocks[56] = 3;
      c.level_unlocks[50] = 3;
   }
}
function f_SaveLevelUnlocks(c)
{
   var loc1 = 0;
   if(c.level_unlocks[19] >= 3)
   {
      loc1 |= 1;
   }
   if(c.level_unlocks[7] >= 3)
   {
      loc1 |= 2;
   }
   if(c.level_unlocks[4] >= 3)
   {
      loc1 |= 4;
   }
   if(c.level_unlocks[23] >= 3)
   {
      loc1 |= 8;
   }
   if(c.level_unlocks[21] >= 3)
   {
      loc1 |= 16;
   }
   if(c.level_unlocks[35] >= 3)
   {
      loc1 |= 32;
   }
   if(c.level_unlocks[36] >= 3)
   {
      loc1 |= 64;
   }
   if(c.level_unlocks[30] >= 3)
   {
      loc1 |= 128;
   }
   if(c.insane_mode > 1)
   {
      c.insane_level_unlocks[0] = int(loc1);
   }
   else
   {
      c.normal_level_unlocks[0] = int(loc1);
   }
   loc1 = 0;
   if(c.level_unlocks[6] >= 3)
   {
      loc1 |= 1;
   }
   if(c.level_unlocks[40] >= 3)
   {
      loc1 |= 2;
   }
   if(c.level_unlocks[54] >= 3)
   {
      loc1 |= 4;
   }
   if(c.level_unlocks[43] >= 3)
   {
      loc1 |= 8;
   }
   if(c.level_unlocks[10] >= 3)
   {
      loc1 |= 16;
   }
   if(c.level_unlocks[3] >= 3)
   {
      loc1 |= 32;
   }
   if(c.level_unlocks[34] >= 3)
   {
      loc1 |= 64;
   }
   if(c.level_unlocks[51] >= 3)
   {
      loc1 |= 128;
   }
   if(c.insane_mode > 1)
   {
      c.insane_level_unlocks[1] = int(loc1);
   }
   else
   {
      c.normal_level_unlocks[1] = int(loc1);
   }
   loc1 = 0;
   if(c.level_unlocks[50] >= 3)
   {
      loc1 |= 1;
   }
   if(c.insane_mode > 1)
   {
      c.insane_level_unlocks[2] = int(loc1);
   }
   else
   {
      c.normal_level_unlocks[2] = int(loc1);
   }
}
function f_IsArenaUnlocked(port, arena)
{
   var loc2 = 1 << arena;
   var loc1 = ReadStorage(port,7);
   if(loc1 & loc2)
   {
      return true;
   }
   return false;
}
function f_FirstTimeInitPlayers()
{
   next_hud = 1;
   select_players = 0;
   showselections = false;
   i = 1;
   while(i <= 4)
   {
      c = _root["hud" + int(i)];
      c.player_num = int(i);
      c.p_type = 0;
      c.port = 0;
      c.active = false;
      f_ResetPlayerInfoAndStats(c);
      var loc2 = int(GetFlashGlobal("g_nPlayer" + int(i) + "Port"));
      if(loc2 > 0)
      {
         c.active = true;
         c.port = loc2;
         f_GetButtons(c);
         next_hud++;
         select_players++;
      }
      i++;
   }
}
function f_SpawnPlayer(u_num, n_type, x, y)
{
   var loc2 = loader.game.game["p" + int(u_num)];
   loc2.weapon = 0;
   loc2.restore_anim = "";
   HiFps_ResetRecursive(loc2);
   if(u_num >= 5)
   {
      f_SetNPCDefaultInfo(u_num);
   }
   else
   {
      loc2.hud_pt = _root["hud" + int(u_num)];
      loc2.hud_pt.player_pt = loc2;
      loc2.combo_pt = _root["combo" + int(u_num)];
      loc2.combo_pt.player_pt = loc2;
      var loc3 = _root["hud" + int(u_num)];
      loc2.w = loc3.w;
      loc2.h = loc3.h;
      loc2.speed_x = loc3.speed_x;
      loc2.speed_y = loc3.speed_y;
      loc2.speed_jump = loc3.speed_jump;
      loc2.speed_launch = loc3.speed_launch;
      loc2.gravity = loc3.gravity;
      loc2.pusher = loc3.pusher;
      loc2.scroller = loc3.scroller;
      loc2.human = loc3.human;
      f_CopyButtons(loc2,loc3);
      loc2.magic_max = loc3.magic_max;
      loc2.magic_current = loc3.magic_current;
      loc2.magic_regen = loc3.magic_regen;
      loc2.magic_pow = loc3.magic_pow;
      loc2.magic_sustain_pow = loc3.magic_sustain_pow;
      loc2.magic_chain = loc3.magic_chain;
      loc2.shield_pow = loc3.shield_pow;
      loc2.combo_max = loc3.combo_max;
      loc2.combo_current = loc3.combo_current;
      loc2.weapon = loc3.weapon;
      if(loc3.equippeditem)
      {
         loc2.equippeditem = loc3.equippeditem;
      }
      else
      {
         loc2.equippeditem = 1;
      }
      loc2.animal_type = loc3.animal_type;
      if(!(arenabattle and arena_mode > 0))
      {
         if(loc2.animal_type)
         {
            f_AssignAnimal(loc2,loc2.animal_type);
         }
      }
      loc2.healthpots = loc3.healthpots;
      loc2.bombs = loc3.bombs;
      loc2.beefies = loc3.beefies;
      loc2.arrow_pow = loc3.arrow_pow;
      loc2.arrow_speed_y = loc3.arrow_speed_y;
      loc2.arrow_speed_x = loc3.arrow_speed_x;
      loc2.arrow_gravity = loc3.arrow_gravity;
      loc2.arrow_hit_function = loc3.arrow_hit_function;
      loc2.punch_pow_low = loc3.punch_pow_low;
      loc2.punch_pow_medium = loc3.punch_pow_medium;
      loc2.punch_pow_high = loc3.punch_pow_high;
      loc2.punch_pow_max = loc3.punch_pow_max;
      loc2.weight = loc3.weight;
      loc2.rage = loc3.rage;
      loc2.rage_goal = loc3.rage_goal;
      loc2.recovery = loc3.recovery;
      loc2.health_max = loc3.health_max;
      loc2.health = loc3.health;
      loc2.poison_timer = 0;
      loc2.fire_timer = 0;
      loc2.resists = loc3.resists;
      loc2.frozen = false;
      loc2.exp = loc3.exp;
      loc2.exp_mod = loc3.exp_mod;
      loc2.exp_next = loc3.exp_next;
      loc2.level = loc3.level;
      loc2.gold = loc3.gold;
      loc2.exp_start = loc3.exp_start;
      loc2.gold_start = loc3.gold_start;
      loc2.kills = loc3.kills;
      loc2.xpgained = loc3.xpgained;
      loc2.strength = loc3.strength;
      loc2.defense = loc3.defense;
      loc2.magic = loc3.magic;
      loc2.agility = loc3.agility;
      loc2.flag = loc3.flag;
      loc2.inputCooldown = 0;
      loc2.damagesVolcano = false;
      if(n_type == 33) {
         loc2.undead = loc3.undead;
      }
   }
   loc2.active = true;
   loc2.alive = true;
   loc2.spawned = true;
   loc2.player_num = u_num;
   loc2.p_type = n_type;
   loc2.grab = true;
   loc2.body_y = 0;
   loc2.body_y_mod = 0;
   loc2.float_timer = 0;

   loc2.objectDamageMult = 1;

   loc2.n_groundtype = undefined;
   loc2.hanging = false;
   loc2.onscreen = true;
   loc2.onscreenbody = true;
   loc2.face_hit1 = 4;
   loc2.face_hit2 = 17;
   loc2.fp_StandSettings = f_StandSettings;
   loc2.fp_Character = f_Character;
   loc2.fp_StandAnim = f_StandType1;
   loc2.fp_WalkAnim = f_WalkType1;
   loc2.fp_DashAnim = f_DashType1;
   loc2.fp_ThrowAction = f_ThrowEnemy;
   loc2.fp_PunchHit = f_PunchHit;
   loc2.fp_CharClock = f_PlayerClock;
   loc2.fp_Blocking = f_Character;
   loc2.fp_MidAttack = f_JumpAttack;
   loc2.fp_Jab = f_PunchSet1;
   loc2.fp_Fierce = f_PunchSet2;
   loc2.fp_JabFierce = f_Uppercut;
   loc2.fp_Wait = f_Null;
   if(level == 23 or level == 102)
   {
      loc2.fp_DashAnim = undefined;
   }
   else
   {
      loc2.x = x;
      loc2.y = y;
   }
   f_HumanoidDefaults(loc2);
   loc2.weightplus = 1;
   loc2.magic_type = 0;
   if(u_num >= 1 and u_num <= 4)
   {
      if(n_type == 1)
      {
         loc2.magic_type = 1;
         loc2.helmet = 2;
         loc2.shield = 2;
         loc2.arrow_type = 2;
         loc2.charcolor = color_green;
         loc2.u_punch2_2 = 2;
         loc2.emblem = 2;
      }
      else if(n_type == 2)
      {
         loc2.magic_type = 2;
         loc2.helmet = 4;
         loc2.shield = 4;
         loc2.arrow_type = 4;
         loc2.charcolor = color_red;
         loc2.emblem = 4;
      }
      else if(n_type == 3)
      {
         loc2.magic_type = 3;
         loc2.helmet = 3;
         loc2.shield = 3;
         loc2.arrow_type = 3;
         loc2.charcolor = color_blue;
         loc2.emblem = 3;
      }
      else if(n_type == 4)
      {
         loc2.magic_type = 4;
         loc2.helmet = 5;
         loc2.shield = 5;
         loc2.arrow_type = 5;
         loc2.charcolor = color_orange;
         loc2.emblem = 5;
      }
      else
      {
         loc2.helmet = n_type + 1;
         loc2.shield = n_type + 1;
         loc2.charcolor = _root.char_colors[n_type];
         if(n_type + 1 == 23)
         {
            loc2.emblem = 19;
         }
         else if(n_type + 1 == 18)
         {
            loc2.emblem = 23;
            loc2.shield = 21;
         }
         else if(n_type + 1 == 31)
         {
            loc2.emblem = 18;
         }
         else
         {
            loc2.emblem = n_type + 1;
         }
         f_SetPlayerMagic(loc2,n_type + 1,true);
      }
   }
   else
   {
      loc2.magic_type = 6;
      loc2.arrow_type = 6;
      loc2.helmet = n_type;
      loc2.shield = n_type;
      if(n_type == 23)
      {
         loc2.emblem = 19;
      }
      else
      {
         loc2.emblem = n_type;
      }
      loc2.charcolor = color_grey;
      loc2.weapon = 2;
      loc2.npc = true;
      loc2.chases = true;
      loc2.blocks = false;
      loc2.aggressiveness = 12;
      loc2.speed = 2 + random(30) / 10;
      loc2.fp_MidAttack = f_EnemyMelee;
      loc2.fp_Character = f_NPCWalk;
   }
   f_DashReset(loc2);
   f_Depth(loc2,loc2.y);
   loc2.shadow_pt = f_NewShadow();
   loc2.shadow_pt._x = loc2.x;
   loc2.shadow_pt._y = loc2.y;
   f_ShadowSize(loc2);
   loc2._x = loc2.x;
   loc2._y = loc2.y;
   f_UpdatePlayerAttributes(loc2);
   if(loc2.pet)
   {
      loc2.pet.x = loc2.x;
      loc2.pet.y = loc2.y;
      loc2.pet._x = loc2.pet.x;
      loc2.pet._y = loc2.pet.y;
   }
   return loc2;
}
function f_SetPlayerMagic(u_temp, u_type, human)
{
   u_temp.magic_type = u_type;
   u_temp.arrow_type = 6;
   u_temp.face_hit1 = 2;
   u_temp.face_hit2 = 2;
   switch(u_type)
   {
      case 6:
         u_temp.face_hit1 = 4;
         u_temp.face_hit2 = 17;
         break;
      case 13:
         u_temp.arrow_type = 11;
         u_temp.face_hit1 = 4;
         break;
      case 15:
         u_temp.face_hit1 = 4;
         break;
      case 16:
         u_temp.face_hit1 = 4;
         break;
      case 20:
         u_temp.arrow_type = 10;
         u_temp.shield = 19;
         u_temp.face_hit1 = 4;
         u_temp.face_hit2 = 17;
         break;
      case 21:
         u_temp.face_hit1 = 6;
         break;
      case 22:
         u_temp.emblem = 21;
         break;
      case 24:
         u_temp.emblem = 6;
         u_temp.shield = 6;
         break;
      case 26:
         u_temp.arrow_type = 7;
         break;
      case 28:
         u_temp.arrow_type = 12;
         u_temp.face_hit1 = 4;
         break;
      case 29:
         u_temp.arrow_type = 7;
         u_temp.magic_type = 26;
         break;
      case 30:
         u_temp.arrow_type = 13;
         break;
      case 31:
         u_temp.arrow_type = 14;
         break;
      case 32:
         u_temp.arrow_type = 15;
         break;
      case 33: // Barb boss
         u_temp.magic_type = 7;
         f_BarbBossDefaults(u_temp);
         break;
      case 34:
         f_CyclopsBossDefaults(u_temp);
         break;
      case 35:
         u_temp.magic_type = 17;
         f_BeetleDefaults(u_temp);
         break;
   }
}

function f_BarbBossDefaults(zone) {
   f_UnresponsiveDefaults(zone);
   zone.h = 250; // i laughed out loud as i typed this. the mf is as wide as he is tall
   zone.w = 250;
   zone.objectDamageMult = 10;
   zone.powerMult = 10;
   zone.expMult = 10;
   zone.healthMult = 5;
   zone.shadowDefaultScale = 300;
   zone.humanoid = false;
   zone.tossable = false;
   zone.uniquehit = true;
   zone.damagesVolcano = true;
   zone.noBeefyGrabs = true;
   zone.fp_Jab = f_PunchSetBarbBoss1;
   zone.fp_Fierce = f_PunchSetBarbBoss2;
   zone.fp_UniqueHit = f_HitBarbBoss;
}

function f_CyclopsBossDefaults(zone) {
   f_UnresponsiveDefaults(zone);
   zone.h = 190;
   zone.w = 120;
   zone.objectDamageMult = 5;
   zone.powerMult = 10;
   zone.expMult = 5;
   zone.healthMult = 5;
   zone.shadowDefaultScale = 200;
   zone.humanoid = false;
   zone.tossable = false;
   zone.noBeefyGrabs = true;
   zone.damagesVolcano = true;
   f_SetUndead(zone, zone.undead); // Set vars depending on undead status
}

function f_SetUndead(zone, undead) {
   zone.undead = undead;
   if(undead) {
      zone.magic_type = 21;
      zone.fp_StandAnim = f_StandTypeUndead;
      zone.fp_WalkAnim = f_WalkTypeUndead;
      zone.fp_DashAnim = f_WalkTypeUndead;
      zone.fp_Jab = f_PunchSetUndead1;
      zone.fp_Fierce = f_PunchSetUndead2;
   }
   else {
      zone.magic_type = 10;
      zone.fp_StandAnim = f_StandType1;
      zone.fp_WalkAnim = f_WalkType1;
      zone.fp_DashAnim = f_DashType1;
      zone.fp_Jab = f_PunchSetCyclops1;
      zone.fp_Fierce = f_PunchSetCyclops2;
   }
}

function f_BeetleDefaults(zone) {
   f_UnresponsiveDefaults(zone);
   zone.h = 100;
   zone.w = 100;
   zone.powerMult = 5;
   zone.healthMult = 5;
   zone.humanoid = false;
   zone.tossable = false;
   zone.damagesVolcano = true;
   zone.noBeefyGrabs = true;
   zone.fp_Jab = f_PunchSetBeetle1;
   zone.fp_Fierce = f_PunchSetBeetle2;
   zone.fp_Hit1 = zone.fp_Hit2 = zone.fp_Hit3 = zone.fp_Juggle = f_HitPlayerBeetle;
}

function f_UpdatePlayerAgility(zone)
{
   var loc3 = zone.agility + zone.weapon_agility;
   if(zone.pet)
   {
      loc3 += zone.pet.agility;
   }
   if(loc3 < 1)
   {
      loc3 = 1;
   }
   var loc4 = loc3;
   if(loc4 > 25)
   {
      loc4 = 25;
   }
   if(!_root.arenabattle or _root.arena_mode != 1)
   {
      zone.speed_x = loc4 / 10 + 4.5;
      zone.speed_y = zone.speed_x * 0.6;
   }
   else
   {
      zone.speed_x = loc4 / 8 + 4.875;
      zone.speed_y = zone.speed_x - 1.5;
   }
   zone.arrow_pow = 2 + loc3;
   zone.arrow_speed_y = -5;
   zone.arrow_speed_x = 21 + loc3 * 1.15;
   zone.arrow_gravity = 1;
}
function f_UpdatePlayerAttributes(zone)
{
   f_WeaponStats(zone,zone.weapon);
   var loc4 = zone.magic + zone.weapon_magic;
   var loc5 = zone.magic;
   if(zone.pet)
   {
      loc4 += zone.pet.magic;
   }
   if(loc4 < 1)
   {
      loc4 = 1;
   }
   zone.magic_max = 35 + loc4 * 5;
   zone.magic_current = zone.magic_max;
   zone.magic_regen = 0.45 + loc4 * 0.01;
   zone.magic_chain = 1 + Math.floor(0.2 * loc4);
   zone.shield_pow = 3;
   zone.magic_pow = Math.floor(0.1 * zone.level + 2 * loc4);
   zone.magic_sustain_pow = Math.floor(3 + 0.1 * zone.level + loc4 * 0.4);
   zone.magic_unlocks = new Array(5);
   if(_root.GetCheat(9))
   {
      var loc3 = 0;
      while(loc3 < 5)
      {
         zone.magic_unlocks[loc3] = true;
         loc3 = loc3 + 1;
      }
   }
   else
   {
      loc3 = 0;
      while(loc3 < 5)
      {
         zone.magic_unlocks[loc3] = false;
         loc3 = loc3 + 1;
      }
      zone.magic_unlocks[3] = loc5 >= 1;
      zone.magic_unlocks[0] = loc5 >= 5;
      zone.magic_unlocks[4] = loc5 >= 10;
      zone.magic_unlocks[1] = loc5 >= 15;
      zone.magic_unlocks[2] = loc5 >= 20;
   }
   zone.combo_unlocks = new Array(10);
   if(_root.GetCheat(8))
   {
      loc3 = 0;
      while(loc3 < 10)
      {
         zone.combo_unlocks[loc3] = true;
         loc3 = loc3 + 1;
      }
   }
   else
   {
      loc3 = 0;
      while(loc3 < 10)
      {
         zone.combo_unlocks[loc3] = false;
         loc3 = loc3 + 1;
      }
      zone.combo_unlocks[0] = zone.level >= 1;
      zone.combo_unlocks[1] = zone.level >= 2;
      zone.combo_unlocks[2] = zone.level >= 4;
      zone.combo_unlocks[3] = zone.level >= 8;
      zone.combo_unlocks[4] = zone.level >= 16;
      zone.combo_unlocks[5] = zone.level >= 32;
      zone.combo_unlocks[6] = zone.level >= 50;
   }
   loc4 = zone.strength + zone.weapon_strength;
   if(zone.pet)
   {
      loc4 += zone.pet.strength;
   }
   if(loc4 < 1)
   {
      loc4 = 1;
   }
   zone.punch_pow_low = Math.floor(3 + zone.level * 0.1 + loc4);
   zone.punch_pow_medium = Math.floor(5 + zone.level * 0.1 + loc4 * 1.15);
   zone.punch_pow_high = Math.floor(10 + zone.level * 0.1 + loc4 * 1.2);
   zone.punch_pow_max = Math.floor(12 + zone.level * 0.1 + loc4 * 1.25);

   loc4 = zone.defense + zone.weapon_defense;
   if(zone.pet)
   {
      loc4 += zone.pet.defense;
   }
   if(loc4 < 1)
   {
      loc4 = 1;
   }
   zone.recovery = Math.floor(6.75 - loc4 * 0.25);
   if(zone.human)
   {
      zone.health_max = 69 + loc4 * 28 + zone.level * 3;
   }
   zone.resists = new Array(5);
   zone.resists[DMG_MELEE] = 40 + loc4 / 2;
   zone.resists[DMG_FIRE] = 40 + loc4 / 2;
   zone.resists[DMG_ICE] = 40 + loc4 / 2;
   zone.resists[DMG_POISON] = 40 + loc4 / 2;
   zone.resists[DMG_ELEC] = 40 + loc4 / 2;
   f_UpdatePlayerAgility(zone);

   if(zone.powerMult) {
      f_ApplyMultToAllPunchPows(zone, zone.powerMult);
      zone.magic_pow *= zone.powerMult;
   }
   if(zone.healthMult) {
      zone.health_max *= zone.healthMult;
   }
   if(zone.health > zone.health_max) {
      zone.health = zone.health_max;
   }
}
function f_SavePlayerInfoToHudForLevelChange(zone)
{
   var loc1 = zone.hud_pt;
   loc1.w = zone.w;
   loc1.h = zone.h;
   loc1.speed_x = zone.speed_x;
   loc1.speed_y = zone.speed_y;
   loc1.speed_jump = zone.speed_jump;
   loc1.speed_launch = zone.speed_launch;
   loc1.gravity = zone.gravity;
   loc1.pusher = zone.pusher;
   loc1.scroller = zone.scroller;
   loc1.human = zone.human;
   loc1.magic_max = zone.magic_max;
   loc1.magic_current = zone.magic_current;
   loc1.magic_regen = zone.magic_regen;
   loc1.magic_type = zone.magic_type;
   loc1.magic_pow = zone.magic_pow;
   loc1.magic_sustain_pow = zone.magic_sustain_pow;
   loc1.magic_chain = zone.magic_chain;
   loc1.shield_pow = zone.shield_pow;
   loc1.combo_max = zone.combo_max;
   loc1.combo_current = zone.combo_current;
   loc1.equippeditem = zone.equippeditem;
   if(zone.pet)
   {
      loc1.animal_type = zone.pet.animal_type;
   }
   loc1.healthpots = zone.healthpots;
   loc1.bombs = zone.bombs;
   loc1.beefies = zone.beefies;
   loc1.arrow_pow = zone.arrow_pow;
   loc1.arrow_speed_y = zone.arrow_speed_y;
   loc1.arrow_speed_x = zone.arrow_speed_x;
   loc1.arrow_gravity = zone.arrow_gravity;
   loc1.arrow_hit_function = zone.arrow_hit_function;
   loc1.punch_pow_low = zone.punch_pow_low;
   loc1.punch_pow_medium = zone.punch_pow_medium;
   loc1.punch_pow_high = zone.punch_pow_high;
   loc1.punch_pow_max = zone.punch_pow_max;
   loc1.weight = zone.weight;
   loc1.rage = zone.rage;
   loc1.rage_goal = zone.rage_goal;
   loc1.recovery = zone.recovery;
   loc1.health_max = zone.health_max;
   loc1.health = zone.health;
   loc1.level = zone.level;
   loc1.exp = zone.exp;
   loc1.exp_mod = zone.exp_mod;
   loc1.exp_next = zone.exp_next;
   loc1.gold = zone.gold;
   loc1.exp_start = zone.exp_start;
   loc1.gold_start = zone.gold_start;
   loc1.kills = zone.kills;
   loc1.resists = zone.resists;
   loc1.xpgained = zone.xpgained;
   loc1.strength = zone.strength;
   loc1.defense = zone.defense;
   loc1.magic = zone.magic;
   loc1.agility = zone.agility;
   loc1.weapon = zone.weapon;
   if(loc1.p_type == 33) {
      loc1.undead = zone.undead;
   }
}
function f_GetButtons(zone)
{
   switch(zone.port)
   {
      case 1:
         zone.button_start = 49;
         zone.button_accept = 2;
         zone.button_back = 3;
         zone.button_select = 53;
         zone.button_left = 37;
         zone.button_up = 38;
         zone.button_right = 39;
         zone.button_down = 40;
         zone.button_walk_left = 117;
         zone.button_walk_up = 118;
         zone.button_walk_right = 119;
         zone.button_walk_down = 120;
         zone.button_punch1 = 65;
         zone.button_punch2 = 87;
         zone.button_jump = 83;
         zone.button_projectile = 68;
         zone.button_shield = 81;
         zone.button_magic = 69;
         zone.button_l2 = 67;
         zone.button_r2 = 66;
         break;
      case 2:
         zone.button_start = 50;
         zone.button_accept = 4;
         zone.button_back = 5;
         zone.button_select = 54;
         zone.button_left = 8;
         zone.button_up = 9;
         zone.button_right = 12;
         zone.button_down = 13;
         zone.button_walk_left = 121;
         zone.button_walk_up = 122;
         zone.button_walk_right = 123;
         zone.button_walk_down = 124;
         zone.button_punch1 = 16;
         zone.button_punch2 = 20;
         zone.button_jump = 17;
         zone.button_projectile = 18;
         zone.button_shield = 27;
         zone.button_magic = 33;
         zone.button_l2 = 32;
         zone.button_r2 = 34;
         break;
      case 3:
         zone.button_start = 51;
         zone.button_accept = 6;
         zone.button_back = 7;
         zone.button_select = 55;
         zone.button_left = 88;
         zone.button_up = 89;
         zone.button_right = 90;
         zone.button_down = 96;
         zone.button_walk_left = 125;
         zone.button_walk_up = 126;
         zone.button_walk_right = 127;
         zone.button_walk_down = 128;
         zone.button_punch1 = 97;
         zone.button_punch2 = 100;
         zone.button_jump = 98;
         zone.button_projectile = 99;
         zone.button_shield = 101;
         zone.button_magic = 103;
         zone.button_l2 = 102;
         zone.button_r2 = 104;
         break;
      case 4:
         zone.button_start = 52;
         zone.button_accept = 10;
         zone.button_back = 11;
         zone.button_select = 56;
         zone.button_left = 105;
         zone.button_up = 106;
         zone.button_right = 107;
         zone.button_down = 108;
         zone.button_walk_left = 129;
         zone.button_walk_up = 130;
         zone.button_walk_right = 131;
         zone.button_walk_down = 132;
         zone.button_punch1 = 109;
         zone.button_punch2 = 112;
         zone.button_jump = 110;
         zone.button_projectile = 111;
         zone.button_shield = 113;
         zone.button_magic = 115;
         zone.button_l2 = 114;
         zone.button_r2 = 116;
   }
}
function f_CopyButtons(zone, c)
{
   zone.button_start = c.button_start;
   zone.button_accept = c.button_accept;
   zone.button_back = c.button_back;
   zone.button_punch1 = c.button_punch1;
   zone.button_punch2 = c.button_punch2;
   zone.button_jump = c.button_jump;
   zone.button_left = c.button_left;
   zone.button_up = c.button_up;
   zone.button_right = c.button_right;
   zone.button_down = c.button_down;
   zone.button_walk_left = c.button_walk_left;
   zone.button_walk_up = c.button_walk_up;
   zone.button_walk_right = c.button_walk_right;
   zone.button_walk_down = c.button_walk_down;
   zone.button_shield = c.button_shield;
   zone.button_projectile = c.button_projectile;
   zone.button_magic = c.button_magic;
   zone.button_select = c.button_select;
   zone.button_r2 = c.button_r2;
   zone.button_l2 = c.button_l2;
}
function f_ClearButtons(zone)
{
   zone.button_start = 0;
   zone.button_accept = 0;
   zone.button_back = 0;
   zone.button_select = 0;
   zone.button_left = 0;
   zone.button_up = 0;
   zone.button_right = 0;
   zone.button_down = 0;
   zone.button_walk_left = 0;
   zone.button_walk_up = 0;
   zone.button_walk_right = 0;
   zone.button_walk_down = 0;
   zone.button_punch1 = 0;
   zone.button_punch2 = 0;
   zone.button_jump = 0;
   zone.button_projectile = 0;
   zone.button_shield = 0;
   zone.button_magic = 0;
   zone.button_l2 = 0;
   zone.button_r2 = 0;
}
function f_LevelInitSpawnPlayers()
{
   var loc13 = 0;
   var loc5 = 1;
   while(loc5 <= 4)
   {
      var loc2 = _root["hud" + int(loc5)];
      if(loc2.active and loc2.p_type)
      {
         loc13 = loc13 + 1;
      }
      loc5 = loc5 + 1;
   }
   loc5 = 1;
   while(loc5 <= 4)
   {
      loc2 = _root["hud" + int(loc5)];
      if(loc2.active and loc2.p_type)
      {
         if(loc2.p_type == 1)
         {
            loc2.charcolor = _root.color_green;
         }
         else if(loc2.p_type == 2)
         {
            loc2.charcolor = _root.color_red;
         }
         else if(loc2.p_type == 3)
         {
            loc2.charcolor = _root.color_blue;
         }
         else if(loc2.p_type == 4)
         {
            loc2.charcolor = _root.color_orange;
         }
         else
         {
            loc2.charcolor = _root.char_colors[loc2.p_type];
         }
         var loc8 = p_game["door" + int(_root.spawn_portal_num)];
         var loc12 = 0;
         loc2.player_pt = _root.f_SpawnPlayer(int(loc5),loc2.p_type,loc8._x + loc12,loc8._y);
         loc2.player_pt.gotoAndStop("intro");
         loc2.player_pt.pressed_start = loc2.pressed_start;
         loc2.player_pt.punched = loc2.pressed_punch1;
         loc2.gotoAndStop("stats");
         var loc7 = loc2.player_pt.exp_next - loc2.player_pt.exp_mod;
         var loc11 = loc2.player_pt.exp_next - loc7;
         var loc10 = loc2.player_pt.exp - loc7;
         var loc4 = int(loc10 / loc11 * 100);
         if(loc4 < 1)
         {
            loc4 = 1;
         }
         if(loc4 > 100)
         {
            loc4 = 100;
         }
         loc2.stats.xp.gotoAndStop(loc4);
         loc2.pic.pic.gotoAndStop(loc2.player_pt.helmet);
         loc2.pic.picbg.gotoAndStop(loc2.player_pt.helmet);
         loc2.stats.itembg.gotoAndStop(loc2.player_pt.helmet);
         SetTextNumeric(loc2.stats.level,loc2.level);
         if(GetGameMode() == 0)
         {
            loc2.stats.level._visible = true;
         }
         else if(GetGameMode() == 3 and loc13 == 1)
         {
            loc2.stats.level._visible = true;
         }
         else
         {
            loc2.stats.level._visible = false;
         }
         var loc6 = false;
         var loc3 = 1;
         while(loc3 <= 11)
         {
            if(loc2.item_unlocks[loc3])
            {
               loc6 = true;
               break;
            }
            loc3 = loc3 + 1;
         }
         if(loc6)
         {
            var loc9 = loc2.player_pt.equippeditem + 1;
            if(loc9 == 2 and !loc2.item_unlocks[1])
            {
               loc2.player_pt.equippeditem = 1;
               loc2.stats.item.gotoAndStop(1);
            }
            else
            {
               loc2.stats.item.gotoAndStop(loc9);
            }
         }
         else
         {
            loc2.stats.item.gotoAndStop(1);
         }
         if(!loc2.player_pt.alive or loc2.player_pt.health <= 0)
         {
            loc2.player_pt.wasdead = true;
            loc2.wasdead = true;
            loc2.player_pt.health = loc2.player_pt.health_max;
            loc2.health = loc2.health_max;
            loc2.player_pt.magic_current = loc2.player_pt.magic_max;
            loc2.player_pt.alive = true;
         }
         else
         {
            loc2.player_pt.wasdead = false;
            loc2.wasdead = false;
         }
         loc4 = int(101 - loc2.player_pt.health / loc2.player_pt.health_max * 100);
         loc2.stats.health.gotoAndStop(loc4);
      }
      loc5 = loc5 + 1;
   }
   f_ResetHudGoldCounters();
}
function f_ResetPlayerInfoAndStats(zone)
{
   zone.strength = 1;
   zone.magic = 1;
   zone.defense = 1;
   zone.agility = 1;
   zone.xpgained = 0;
   zone.w = 45;
   zone.h = 120 * (u_temp._yscale / 100);
   zone.speed_x = 5.5;
   zone.speed_y = 4;
   zone.speed_jump = 0;
   zone.speed_launch = -20;
   zone.gravity = 2;
   zone.pusher = true;
   zone.scroller = true;
   zone.human = true;
   zone.magic_max = 100;
   zone.magic_current = 100;
   zone.magic_regen = 0.5;
   zone.magic_pow = 5;
   zone.magic_sustain_pow = 2;
   zone.magic_chain = 3;
   zone.shield_pow = 3;
   zone.combo_max = 100;
   zone.combo_current = 0;
   zone.equippeditem = 1;
   zone.animal_type = 0;
   zone.arrow_pow = 3;
   zone.arrow_speed_y = -5;
   zone.arrow_speed_x = 20;
   zone.arrow_gravity = 1;
   zone.arrow_hit_function = f_ProjectileHitSpark;
   zone.punch_pow_low = 4;
   zone.punch_pow_medium = 6;
   zone.punch_pow_high = 12;
   zone.punch_pow_max = 15;
   zone.weight = 0;
   zone.rage = 0;
   zone.rage_goal = 1000;
   zone.recovery = 9;
   zone.health_max = 100;
   zone.health = zone.health_max;
   zone.alive = true;
   zone.resists = new Array(5);
   zone.resists[DMG_MELEE] = 50;
   zone.resists[DMG_FIRE] = 50;
   zone.resists[DMG_ICE] = 50;
   zone.resists[DMG_POISON] = 50;
   zone.resists[DMG_ELEC] = 50;
   zone.level = 1;
   zone.exp = 0;
   zone.exp_mod = 190;
   zone.exp_next = zone.exp_mod;
   zone.gold = 0;
   zone.exp_start = 0;
   zone.gold_start = 0;
   zone.kills = 0;
   zone.wings = 1;
   zone.weapon = 1;
   if(GetGameMode() == 3)
   {
      if(!zone.flag)
      {
         zone.flag = zone.player_num + 1;
      }
   }
   else
   {
      zone.flag = 1;
   }
   zone.undead = false;
}
function f_SetNPCDefaultInfo(num)
{
   var loc1 = loader.game.game["p" + int(num)];
   loc1.w = 45;
   loc1.h = 120 * (loc1._yscale / 100);
   loc1.speed_x = 5.5;
   loc1.speed_y = 4;
   loc1.speed_jump = 0;
   loc1.speed_launch = -20;
   loc1.gravity = 2;
   loc1.pusher = true;
   loc1.scroller = true;
   loc1.magic_max = 100;
   loc1.magic_current = 100;
   loc1.magic_regen = 0.5;
   loc1.magic_type = 0;
   loc1.magic_pow = 5;
   loc1.magic_sustain_pow = 2;
   loc1.magic_chain = 3;
   loc1.shield_pow = 3;
   loc1.combo_max = 100;
   loc1.combo_current = 0;
   loc1.equippeditem = 1;
   loc1.arrow_pow = 3;
   loc1.arrow_speed_y = -5;
   loc1.arrow_speed_x = 20;
   loc1.arrow_gravity = 1;
   loc1.arrow_hit_function = f_ProjectileHitSpark;
   loc1.punch_pow_low = 4;
   loc1.punch_pow_medium = 6;
   loc1.punch_pow_high = 12;
   loc1.punch_pow_max = 15;
   loc1.weight = 0;
   loc1.rage = 0;
   loc1.rage_goal = 1000;
   loc1.resists = new Array(5);
   loc1.resists[DMG_MELEE] = 50;
   loc1.resists[DMG_POISON] = 50;
   loc1.resists[DMG_FIRE] = 50;
   loc1.resists[DMG_ELEC] = 50;
   loc1.resists[DMG_ICE] = 50;
   loc1.recovery = 9;
   loc1.health_max = 100;
   loc1.health = loc1.health_max;
   loc1.alive = true;
   loc1.level = 1;
   loc1.exp = 0;
   loc1.exp_mod = 190;
   loc1.exp_next = loc1.exp_mod;
}
function f_SetAnimalTimer(zone)
{
   zone.fp_timer = f_AnimalTimerNull;
   zone.strength = 0;
   zone.defense = 0;
   zone.agility = 0;
   zone.magic = 0;
   switch(zone.animal_type)
   {
      case 1:
         zone.magic = 2;
         zone.fp_timer = f_CardinalTimer;
         break;
      case 2:
         zone.fp_timer = f_OwletTimer;
         break;
      case 3:
         zone.fp_timer = f_RammyTimer;
         break;
      case 4:
         zone.fp_timer = f_FroggletTimer;
         break;
      case 5:
         break;
      case 6:
         zone.fp_timer = f_PolarBearTimer;
         break;
      case 7:
         zone.timer = 0;
         if(GetGameMode() == 3)
         {
            zone.timer = 150;
         }
         zone.fp_timer = f_BatTimer;
         break;
      case 8:
         zone.strength = 2;
         break;
      case 9:
         zone.fp_timer = f_TrollPetTimer;
         break;
      case 10:
         zone.agility = -2;
         zone.defense = 5;
         break;
      case 11:
         break;
      case 12:
         zone.agility = 2;
         zone.magic = 2;
         break;
      case 13:
         zone.agility = 4;
         break;
      case 14:
         zone.defense = 2;
         zone.fp_timer = f_PazzoTimer;
         break;
      case 15:
         zone.defense = 1;
         zone.strength = 3;
         break;
      case 16:
         zone.fp_timer = f_HawksterTimer;
         break;
      case 17:
         zone.strength = 4;
         break;
      case 18:
         break;
      case 19:
         zone.defense = 4;
         break;
      case 20:
         zone.agility = 2;
         zone.strength = 2;
         break;
      case 21:
         zone.agility = 2;
         break;
      case 22:
         zone.agility = 1;
         zone.defense = 1;
         zone.strength = 1;
         break;
      case 23:
         zone.speed_y = 0;
         zone.gravity = 1;
         zone.pause = false;
         zone.fp_timer = f_InstallBallTimer;
         break;
      case 26:
         zone.fp_timer = f_PelterTimer;
         break;
      case 27:
         zone.fp_timer = f_DragonTimer;
         break;
      case 28:
         zone.magic = 4;
         break;
      case 29:
         zone.fp_timer = f_WhaleTimer;
         zone.timer = 30 * (12 + random(6));
   }
   if(zone.owner.human)
   {
      f_UpdatePlayerAttributes(zone.owner);
   }
}
function f_WeaponStats(zone, num)
{
   zone.weapon_strength = 0;
   zone.weapon_defense = 0;
   zone.weapon_magic = 0;
   zone.weapon_agility = 0;
   zone.weapon_critical = 0;
   zone.weapon_magic_type = 0;
   zone.weapon_magic_chance = 0;
   zone.weapon_level = 1;
   switch(num)
   {
      case 3:
         zone.weapon_agility = 1;
         break;
      case 25:
         zone.weapon_critical = 100;
         break;
      case 39:
         zone.weapon_magic = 1;
         break;
      case 47:
         zone.weapon_magic_type = 4;
         zone.weapon_magic_chance = 100;
         break;
      case 56:
         zone.weapon_strength = 1;
         break;
      case 2:
         zone.weapon_agility = 1;
         zone.weapon_defense = 1;
         zone.weapon_strength = -1;
         break;
      case 19:
         zone.weapon_magic = -1;
         zone.weapon_critical = 100;
         break;
      case 20:
         zone.weapon_agility = -1;
         zone.weapon_strength = 1;
         break;
      case 30:
         zone.weapon_defense = 1;
         zone.weapon_magic = 1;
         zone.weapon_strength = -1;
         break;
      case 37:
         zone.weapon_agility = -1;
         zone.weapon_strength = 2;
         break;
      case 41:
         zone.weapon_defense = -1;
         zone.weapon_magic = 2;
         break;
      case 42:
         zone.weapon_agility = 1;
         zone.weapon_defense = -1;
         zone.weapon_magic = -1;
         break;
      case 45:
         zone.weapon_agility = 2;
         zone.weapon_magic = -1;
         break;
      case 61:
         zone.weapon_strength = -1;
         zone.weapon_magic_type = 2;
         zone.weapon_magic_chance = 100;
         break;
      case 63:
         zone.weapon_agility = 5;
         break;
      case 71:
         zone.weapon_defense = 3;
         break;
      case 84:
         zone.weapon_agility = -1;
         zone.weapon_magic = 3;
         break;
      case 85:
         zone.weapon_agility = -1;
         zone.weapon_strength = 3;
         break;
      case 8:
         zone.weapon_defense = 2;
         zone.weapon_magic = -1;
         zone.weapon_level = 5;
         break;
      case 9:
         zone.weapon_defense = 1;
         zone.weapon_strength = 1;
         zone.weapon_level = 5;
         break;
      case 10:
         zone.weapon_agility = 3;
         zone.weapon_strength = -1;
         zone.weapon_level = 5;
         break;
      case 29:
         zone.weapon_magic = -1;
         zone.weapon_magic_type = 3;
         zone.weapon_magic_chance = 50;
         zone.weapon_level = 5;
         break;
      case 38:
         zone.weapon_magic = 3;
         zone.weapon_strength = -1;
         zone.weapon_level = 5;
         break;
      case 54:
         zone.weapon_agility = 1;
         zone.weapon_strength = -1;
         zone.weapon_critical = 100;
         zone.weapon_level = 5;
         break;
      case 55:
         zone.weapon_defense = 3;
         zone.weapon_strength = -1;
         zone.weapon_level = 5;
         break;
      case 62:
         zone.weapon_magic = -1;
         zone.weapon_strength = 1;
         zone.weapon_critical = 50;
         zone.weapon_level = 5;
         break;
      case 69:
         zone.weapon_agility = 1;
         zone.weapon_defense = -1;
         zone.weapon_magic = 2;
         zone.weapon_level = 5;
         break;
      case 77:
         zone.weapon_agility = -1;
         zone.weapon_defense = 3;
         zone.weapon_level = 5;
         break;
      case 82:
         zone.weapon_strength = 1;
         zone.weapon_agility = 1;
         zone.weapon_level = 5;
         break;
      case 5:
         zone.weapon_defense = 2;
         zone.weapon_magic = -2;
         zone.weapon_strength = 3;
         zone.weapon_level = 10;
         break;
      case 13:
         zone.weapon_agility = -1;
         zone.weapon_defense = 1;
         zone.weapon_magic = 3;
         zone.weapon_level = 10;
         break;
      case 15:
         zone.weapon_defense = 3;
         zone.weapon_strength = 1;
         zone.weapon_level = 10;
         break;
      case 18:
         zone.weapon_agility = 1;
         zone.weapon_magic = 1;
         zone.weapon_strength = 1;
         zone.weapon_level = 10;
         break;
      case 23:
         zone.weapon_defense = 3;
         zone.weapon_magic = 1;
         zone.weapon_strength = -1;
         zone.weapon_level = 10;
         break;
      case 24:
         zone.weapon_agility = 3;
         zone.weapon_magic = -2;
         zone.weapon_strength = 2;
         zone.weapon_level = 10;
         break;
      case 28:
         zone.weapon_agility = 1;
         zone.weapon_defense = 1;
         zone.weapon_strength = 1;
         zone.weapon_level = 10;
         break;
      case 32:
         zone.weapon_agility = -2;
         zone.weapon_strength = 5;
         zone.weapon_level = 10;
         break;
      case 34:
         zone.weapon_defense = 1;
         zone.weapon_strength = 2;
         zone.weapon_level = 10;
         break;
      case 40:
         zone.weapon_agility = 3;
         zone.weapon_defense = -1;
         zone.weapon_magic = 1;
         zone.weapon_level = 10;
         break;
      case 43:
         zone.weapon_agility = 2;
         zone.weapon_magic_type = 2;
         zone.weapon_magic_chance = 50;
         zone.weapon_level = 10;
         break;
      case 44:
         zone.weapon_defense = -2;
         zone.weapon_magic = 5;
         zone.weapon_level = 10;
         break;
      case 53:
         zone.weapon_magic = 1;
         zone.weapon_strength = 1;
         zone.weapon_critical = 100;
         zone.weapon_level = 10;
         break;
      case 80:
         zone.weapon_magic = 3;
         zone.weapon_magic_type = 2;
         zone.weapon_magic_chance = 100;
         zone.weapon_level = 10;
         break;
      case 81:
         zone.weapon_defense = 2;
         zone.weapon_magic = -1;
         zone.weapon_strength = 2;
         zone.weapon_level = 10;
         break;
      case 4:
         zone.weapon_defense = 5;
         zone.weapon_magic = -1;
         zone.weapon_strength = 2;
         zone.weapon_level = 15;
         break;
      case 6:
         zone.weapon_defense = 3;
         zone.weapon_magic = -1;
         zone.weapon_strength = 1;
         zone.weapon_critical = 50;
         zone.weapon_level = 15;
         break;
      case 7:
         zone.weapon_agility = 2;
         zone.weapon_magic = -2;
         zone.weapon_strength = 5;
         zone.weapon_level = 15;
         break;
      case 11:
         zone.weapon_defense = 1;
         zone.weapon_magic = 4;
         zone.weapon_level = 15;
         break;
      case 14:
         zone.weapon_agility = -1;
         zone.weapon_defense = 3;
         zone.weapon_magic = 3;
         zone.weapon_level = 15;
         break;
      case 16:
         zone.weapon_agility = 2;
         zone.weapon_defense = 2;
         zone.weapon_magic = 1;
         zone.weapon_level = 15;
         break;
      case 17:
         zone.weapon_agility = 2;
         zone.weapon_defense = 4;
         zone.weapon_magic = -1;
         zone.weapon_level = 15;
         break;
      case 21:
         zone.weapon_defense = -1;
         zone.weapon_magic = 3;
         zone.weapon_strength = 3;
         zone.weapon_level = 15;
         break;
      case 22:
         zone.weapon_agility = 3;
         zone.weapon_magic = 3;
         zone.weapon_strength = -1;
         zone.weapon_level = 15;
         break;
      case 46:
         zone.weapon_agility = 5;
         zone.weapon_strength = -2;
         zone.weapon_magic_type = 1;
         zone.weapon_magic_chance = 50;
         zone.weapon_level = 15;
         break;
      case 48:
         zone.weapon_agility = -3;
         zone.weapon_magic = 2;
         zone.weapon_strength = 5;
         zone.weapon_level = 15;
         break;
      case 49:
         zone.weapon_agility = -2;
         zone.weapon_defense = 2;
         zone.weapon_strength = 4;
         zone.weapon_level = 15;
         break;
      case 51:
         zone.weapon_defense = 1;
         zone.weapon_magic = 6;
         zone.weapon_strength = -3;
         zone.weapon_level = 15;
         break;
      case 59:
         zone.weapon_magic = 2;
         zone.weapon_strength = -1;
         zone.weapon_magic_type = 4;
         zone.weapon_magic_chance = 33;
         zone.weapon_level = 15;
         break;
      case 60:
         zone.weapon_strength = 1;
         zone.weapon_critical = 33;
         zone.weapon_level = 15;
         break;
      case 67:
         zone.weapon_agility = 5;
         zone.weapon_strength = -2;
         zone.weapon_critical = 50;
         zone.weapon_level = 15;
         break;
      case 78:
         zone.weapon_defense = -2;
         zone.weapon_magic = 3;
         zone.weapon_magic_type = 1;
         zone.weapon_magic_chance = 100;
         zone.weapon_level = 15;
         break;
      case 83:
         zone.weapon_agility = 6;
         zone.weapon_strength = -2;
         zone.weapon_level = 15;
         break;
      case 12:
         zone.weapon_defense = 3;
         zone.weapon_strength = 3;
         zone.weapon_critical = 100;
         zone.weapon_level = 20;
         break;
      case 26:
         zone.weapon_agility = -3;
         zone.weapon_defense = 5;
         zone.weapon_strength = 5;
         zone.weapon_level = 20;
         break;
      case 27:
         zone.weapon_defense = 6;
         zone.weapon_magic = -2;
         zone.weapon_critical = 100;
         zone.weapon_level = 20;
         break;
      case 31:
         zone.weapon_agility = 5;
         zone.weapon_strength = -2;
         zone.weapon_defense = 3;
         zone.weapon_level = 20;
         break;
      case 33:
         zone.weapon_agility = 3;
         zone.weapon_defense = -2;
         zone.weapon_magic = 5;
         zone.weapon_magic_type = 1;
         zone.weapon_magic_chance = 50;
         zone.weapon_level = 20;
         break;
      case 35:
         zone.weapon_defense = 1;
         zone.weapon_magic = 1;
         zone.weapon_strength = -3;
         zone.weapon_critical = 25;
         zone.weapon_level = 20;
         break;
      case 36:
         zone.weapon_defense = 3;
         zone.weapon_magic = 2;
         zone.weapon_strength = 3;
         zone.weapon_level = 20;
         break;
      case 50:
         zone.weapon_agility = 6;
         zone.weapon_defense = -2;
         zone.weapon_critical = 50;
         zone.weapon_level = 20;
         break;
      case 52:
         zone.weapon_agility = 4;
         zone.weapon_magic = -2;
         zone.weapon_strength = 4;
         zone.weapon_level = 20;
         break;
      case 57:
         zone.weapon_defense = 7;
         zone.weapon_magic = 2;
         zone.weapon_level = 20;
         break;
      case 58:
         zone.weapon_magic = 2;
         zone.weapon_magic_type = 3;
         zone.weapon_magic_chance = 33;
         zone.weapon_level = 20;
         break;
      case 68:
         zone.weapon_defense = 5;
         zone.weapon_magic = 5;
         zone.weapon_strength = -4;
         zone.weapon_magic_type = 2;
         zone.weapon_magic_chance = 100;
         zone.weapon_level = 20;
         break;
      case 70:
         zone.weapon_agility = 2;
         zone.weapon_magic = 2;
         zone.weapon_strength = 2;
         zone.weapon_magic_type = 4;
         zone.weapon_magic_chance = 50;
         zone.weapon_level = 20;
         break;
      case 73:
         zone.weapon_agility = 2;
         zone.weapon_defense = 2;
         zone.weapon_strength = 2;
         zone.weapon_level = 20;
         break;
      case 64:
         zone.weapon_strength = 3;
         zone.weapon_critical = 25;
         zone.weapon_level = 30;
         break;
      case 65:
         zone.weapon_agility = -3;
         zone.weapon_magic = 5;
         zone.weapon_strength = 5;
         zone.weapon_level = 30;
         break;
      case 66:
         zone.weapon_defense = 5;
         zone.weapon_critical = 20;
         zone.weapon_level = 30;
         break;
      case 75:
         zone.weapon_agility = -2;
         zone.weapon_defense = 3;
         zone.weapon_strength = 5;
         zone.weapon_level = 30;
         break;
      case 76:
         zone.weapon_defense = -1;
         zone.weapon_magic = 4;
         zone.weapon_magic_type = 2;
         zone.weapon_magic_chance = 33;
         zone.weapon_level = 30;
         break;
      case 79:
         zone.weapon_defense = 4;
         zone.weapon_magic_type = 2;
         zone.weapon_magic_chance = 25;
         zone.weapon_level = 30;
         break;
      case 72:
         zone.weapon_defense = 2;
         zone.weapon_strength = 5;
         zone.weapon_critical = 50;
         zone.weapon_level = 35;
         break;
      case 74:
         zone.weapon_agility = 5;
         zone.weapon_magic = 3;
         zone.weapon_magic_type = 1;
         zone.weapon_magic_chance = 33;
         zone.weapon_level = 35;
   }
}
function f_GetDefaultWeapon(zone)
{
   var loc1 = 0;
   switch(zone.p_type)
   {
      case 1:
         loc1 = 3;
         break;
      case 2:
         loc1 = 25;
         break;
      case 3:
         loc1 = 39;
         break;
      case 4:
         loc1 = 56;
         break;
      case 5:
         loc1 = 2;
         break;
      case 6:
         loc1 = 19;
         break;
      case 7:
         loc1 = 10;
         break;
      case 8:
         loc1 = 18;
         break;
      case 9:
         loc1 = 34;
         break;
      case 10:
         loc1 = 27;
         break;
      case 11:
         loc1 = 47;
         break;
      case 12:
         loc1 = 36;
         break;
      case 13:
         loc1 = 12;
         break;
      case 14:
         loc1 = 33;
         break;
      case 15:
         loc1 = 15;
         break;
      case 16:
         loc1 = 15;
         break;
      case 17:
         loc1 = 6;
         break;
      case 18:
         loc1 = 45;
         break;
      case 19:
         loc1 = 26;
         break;
      case 20:
         loc1 = 57;
         break;
      case 21:
         loc1 = 43;
         break;
      case 22:
         loc1 = 20;
         break;
      case 23:
         loc1 = 2;
         break;
      case 24:
         loc1 = 35;
         break;
      case 25:
         loc1 = 31;
         break;
      case 26:
         loc1 = 48;
         break;
      case 27:
         loc1 = 50;
         break;
      case 28:
         loc1 = 68;
         break;
      case 29:
         loc1 = 63;
         break;
      case 30:
         loc1 = 85;
         break;
      case 31:
         loc1 = 84;
   }
   return loc1;
}
function f_initLoadedAnimalClip(zone)
{
   zone.active = false;
   zone.owner = undefined;
   zone.animal_type = n_type;
   zone.state = 0;
   zone.body_y = 0;
   zone.p_target = undefined;
   zone.timer = random(20);
   var loc2 = zone.getDepth();
   zone.depth_mod = loc2 % 1000;
}
function f_AnimalFollow(zone)
{
   if(!zone.fp_timer(zone))
   {
      if(zone.owner._xscale > 0)
      {
         zone.goal_x = zone.owner.x - 50;
      }
      else
      {
         zone.goal_x = zone.owner.x + 50;
      }
      zone.goal_y = zone.owner.y;
      var loc3 = Math.abs(zone.x - zone.goal_x) / 10;
      var loc2 = Math.abs(zone.y - zone.goal_y) / 10;
      if(zone.y > zone.goal_y + 3)
      {
         loc2 = - loc2;
      }
      else if(zone.y > zone.goal_y - 3)
      {
         loc2 = 0;
      }
      if(zone.x > zone.goal_x + 4)
      {
         if(zone._xscale > 0)
         {
            zone._xscale *= -1;
         }
         loc3 = - loc3;
      }
      else if(zone.x < zone.goal_x - 4)
      {
         if(zone._xscale < 0)
         {
            zone._xscale *= -1;
         }
      }
      else
      {
         loc3 = 0;
      }
      if(zone.carrying)
      {
         if(f_ConfirmPickup(zone.carrying))
         {
            zone.carrying.x = zone.x;
            zone.carrying.y = zone.y;
            zone.carrying._x = zone.x;
            zone.carrying._y = zone.y;
            f_Depth(zone.carrying,zone.carrying.y);
            loc3 /= 3;
            loc2 /= 3;
         }
         else
         {
            zone.carrying = undefined;
         }
      }
      if(zone.animal_type != 23)
      {
         if(zone.body_y > -30)
         {
            zone.body_y = zone.body_y - 1;
         }
         else if(zone.body_y < -30)
         {
            zone.body_y = zone.body_y + 1;
         }
         zone.body._y = zone.body_y;
      }
      zone.x += loc3;
      zone.y += loc2;
      zone._x = zone.x;
      zone._y = zone.y;
      f_Depth(zone,zone.y);
      if(zone.love_timer > 0)
      {
         zone.love_timer = zone.love_timer - 1;
         if(zone.love_timer % 5 == 0)
         {
            if(random(2))
            {
               f_FX(zone.x + random(23) - 11,zone.y + zone.body._y + 1,zone.y - 1,"heart",100,100);
            }
            else
            {
               f_FX(zone.x + random(23) - 11,zone.y + zone.body._y + 1,zone.y - 1,"heart",-100,100);
            }
         }
      }
   }
}
function f_AnimalTimerNull(zone)
{
   return false;
}
function f_AssignAnimal(zone, n_type)
{
   i = 1;
   while(i <= total_animals)
   {
      var loc2 = _root.loader.game.game["animal" + int(i)];
      if(!loc2.active)
      {
         loc2.active = true;
         loc2.owner = zone;
         zone.pet = loc2;
         loc2.x = zone.x - 30;
         loc2.y = zone.y - 5;
         loc2._x = loc2.x;
         loc2._y = loc2.y;
         f_Depth(loc2,loc2.y);
         loc2.animal_type = n_type;
         loc2.state = 0;
         loc2.timer = 0;
         f_SetAnimalTimer(loc2);
         HiFps_ResetRecursive(loc2);
         loc2.gotoAndStop("follow");
         i = total_animals + 1;
         return loc2;
      }
      i++;
   }
   return 0;
}
function f_AttachAnimal(animal, zone)
{
   if(zone.pet)
   {
      f_UnAttachAnimal(zone.pet);
   }
   animal.owner = zone;
   zone.pet = animal;
   if(zone.human)
   {
      LOGPush(13,animal.animal_type,zone.hud_pt.port);
   }
   if(animal.unlock)
   {
      var loc5 = zone.hud_pt.animal_unlocks[animal.animal_type];
      var loc1 = 1;
      while(loc1 <= active_players)
      {
         var loc2 = playerArrayOb["p_pt" + int(loc1)];
         if(loc2.alive)
         {
            loc2.hud_pt.animal_unlocks[animal.animal_type] = true;
         }
         loc1 = loc1 + 1;
      }
      animal.unlock = false;
      if(!loc5)
      {
         f_UnlockAnimal(zone,animal.animal_type);
      }
      f_UnlockAnimalAchievement(zone);
   }
   animal.state = 0;
   animal.timer = 0;
   f_SetAnimalTimer(animal);
   zone.p_target = undefined;
   animal.gotoAndStop("follow");
}
function f_UnAttachAnimal(zone)
{
   zone.owner = undefined;
   zone.gotoAndStop("lost");
   zone.ignore_timer = 51;
   zone.love_timer = 0;
   zone.state = 150;
}
function f_PlaceAnimal(n_type, x, y)
{
   i = 1;
   while(i <= total_animals)
   {
      var loc2 = _root.loader.game.game["animal" + int(i)];
      if(!loc2.active)
      {
         loc2.active = true;
         loc2.owner = 0;
         loc2.x = x;
         loc2.y = y;
         loc2._x = x;
         loc2._y = y;
         f_Depth(loc2,loc2.y);
         loc2.animal_type = n_type;
         loc2.state = 0;
         loc2.p_target = undefined;
         loc2.gotoAndStop("lost");
         loc2.state = 150;
         i = total_animals + 1;
         return loc2;
      }
      i++;
   }
   return 0;
}
function f_AnimalInitLaunch(zone)
{
   var loc3 = zone.p_target.x - zone.x;
   var loc2 = zone.p_target.y - zone.y;
   dist = Math.sqrt(loc3 * loc3 + loc2 * loc2);
   loc3 /= dist;
   loc2 /= dist;
   zone.x1 = loc3 * 8;
   zone.y1 = loc2 * 8;
   zone.p_target = undefined;
}
function f_AnimalLaunch(zone)
{
   var loc2 = f_BSPHitTest(zone.x,zone.y,zone.x + zone.x1,zone.y + zone.y1);
   if(!loc2)
   {
      zone.x += zone.x1;
      zone.y += zone.y1;
      zone._x = zone.x;
      zone._y = zone.y;
      f_Depth(zone,zone.y);
   }
}
function f_AnimalInitHappy(zone)
{
   i = 1;
   while(i <= total_animals)
   {
      var loc2 = _root.loader.game.game["animal" + int(i)];
      if(loc2.active and loc2 != zone)
      {
         if(loc2.p_target)
         {
            if(loc2.p_target == zone.p_target)
            {
               loc2.state = 0;
               loc2.timer = 0;
               loc2.gotoAndStop("launch");
            }
         }
      }
      i++;
   }
}
function f_AnimalInitLost(zone)
{
   zone.owner = undefined;
   zone.p_target = undefined;
   zone.timer = 0;
}
function f_AnimalLost(zone)
{
   switch(zone.state)
   {
      case 0:
         if(zone.x > main.left - 200 and zone.x < main.right + 200)
         {
            var loc9 = random(3);
            if(!loc9)
            {
               zone.state = 10;
            }
            else if(loc9 == 1)
            {
               zone.state = 20;
            }
            else
            {
               zone.p_target = f_GetSomeLove(zone);
               if(zone.p_target)
               {
                  zone.timer = 0;
                  zone.state = 200;
               }
            }
         }
         break;
      case 10:
         var loc3 = - _root.main.camera_x;
         var loc10 = - _root.main.camera_y;
         var loc8 = (loc3 - _root.main.left) / 2;
         if(random(2))
         {
            loc3 = _root.main.left + loc8;
         }
         else
         {
            loc3 = _root.main.left + loc8 * 3;
         }
         zone.x1 = zone.x;
         zone.y1 = zone.y;
         zone.x2 = zone.x + random(200) - 100;
         zone.y2 = zone.y + random(200) - 100;
         zone.x3 = loc3 + random(600) - 300;
         zone.y3 = loc10 + random(400) - 200;
         zone.x4 = loc3 + (- _root.main.camera_x - zone.x3) / 2;
         zone.y4 = loc10;
         zone.timer = 0;
         zone.state = 11;
         break;
      case 11:
         zone.timer = zone.timer + 1;
         if(zone.timer > 50)
         {
            zone.state = 0;
         }
         f_lerp(zone,zone.timer / 60);
         if(zone.lerp_x - zone.x > 0)
         {
            if(zone._xscale < 0)
            {
               zone._xscale *= -1;
            }
         }
         else if(zone._xscale > 0)
         {
            zone._xscale *= -1;
         }
         var loc11 = f_BSPHitTest(zone.x,zone.y,zone.lerp_x,zone.lerp_y);
         if(loc11)
         {
            zone.state = 0;
         }
         else
         {
            zone.x = zone.lerp_x;
            zone.y = zone.lerp_y;
            zone._x = zone.x;
            zone._y = zone.y;
            f_Depth(zone,zone.y);
         }
         break;
      case 20:
         zone.x1 = random(13) - 7;
         zone.y1 = random(13) - 7;
         if(zone.x1 > 0)
         {
            if(zone._xscale < 0)
            {
               zone._xscale *= -1;
            }
         }
         else if(zone._xscale > 0)
         {
            zone._xscale *= -1;
         }
         zone.timer = 2 + random(12);
         zone.state = 31;
         break;
      case 30:
         zone.x1 = random(13) - 7;
         zone.y1 = random(6) + 3;
         if(zone.x1 > 0)
         {
            if(zone._xscale < 0)
            {
               zone._xscale *= -1;
            }
         }
         else if(zone._xscale > 0)
         {
            zone._xscale *= -1;
         }
         zone.timer = 12;
         zone.state = 31;
         break;
      case 31:
         zone.timer = zone.timer - 1;
         loc11 = f_BSPHitTest(zone.x,zone.y,zone.x + zone.x1,zone.y + zone.y1);
         if(loc11)
         {
            zone.state = 0;
            zone.timer = 0;
         }
         else
         {
            zone.x += zone.x1;
            zone.y += zone.y1;
            zone._x = zone.x;
            zone._y = zone.y;
            f_Depth(zone,zone.y);
         }
         if(zone.timer < 0)
         {
            zone.state = 0;
            zone.timer = 0;
         }
         break;
      case 100:
         zone.x1 = zone.x;
         zone.y1 = zone.y;
         if(random(2))
         {
            zone.x2 = zone.x + 50;
         }
         else
         {
            zone.x2 = zone.x - 50;
         }
         zone.y2 = zone.y + 100;
         zone.x4 = zone.barn_x + random(100) - 50;
         zone.y4 = zone.barn_y + random(50) - 25;
         zone.x3 = zone.barn_x;
         zone.y3 = zone.barn_y + 75;
         zone.timer = 0;
         zone.state = 101;
         zone.bubble.gotoAndStop("sleep");
         break;
      case 101:
         zone.timer = zone.timer + 1;
         f_lerp(zone,zone.timer / 40);
         loc11 = f_BSPHitTest(zone.x,zone.y,zone.lerp_x,zone.lerp_y);
         if(!loc11)
         {
            zone.x = zone.lerp_x;
            zone.y = zone.lerp_y;
            zone._x = zone.x;
            zone._y = zone.y;
            f_Depth(zone,zone.y);
         }
         if(zone.timer > 40)
         {
            zone.state = 10;
            zone.timer = 0;
            zone.gotoAndStop("gotosleep");
         }
         break;
      case 150:
         if(zone.body_y > -35)
         {
            zone.body_y -= 2;
            if(zone.body_y < -35)
            {
               zone.body_y = -35;
            }
         }
         else if(zone.body_y < -35)
         {
            zone.body_y += 2;
            if(zone.body_y > -35)
            {
               zone.body_y = -35;
            }
         }
         zone.body._y = zone.body_y;
         var loc5 = f_FaceClosestPlayer(zone);
         if(zone.ignore_timer > 0)
         {
            zone.ignore_timer = zone.ignore_timer - 1;
            if(!(zone.ignore_timer % 15))
            {
               f_FX(zone.x + random(23) - 11,zone.y + zone.body._y + 1,zone.y - 1,"sleep_z",70 + random(30),100);
            }
         }
         else if(Math.abs(loc5.x - zone.x) < 50)
         {
            if(Math.abs(loc5.y - zone.y) < 20)
            {
               if(_root.GetCheat(1) or zone.unlock or loc5.hud_pt.animal_unlocks[zone.animal_type])
               {
                  f_AttachAnimal(zone,loc5);
                  zone.love_timer = 60;
               }
               else
               {
                  zone.gotoAndStop("angry");
               }
            }
         }
         break;
      case 200:
         zone.timer = zone.timer + 1;
         if(!(zone.timer % 5))
         {
            if(random(2))
            {
               f_FX(zone.x + random(23) - 11,zone.y + zone.body._y + 1,zone.y - 1,"heart",100,100);
            }
            else
            {
               f_FX(zone.x + random(23) - 11,zone.y + zone.body._y + 1,zone.y - 1,"heart",-100,100);
            }
         }
         zone.goal_x = zone.p_target.x;
         zone.goal_y = zone.p_target.y;
         loc5 = Math.abs(zone.x - zone.goal_x) / 10;
         var loc4 = Math.abs(zone.y - zone.goal_y) / 10;
         if(loc5 > 5)
         {
            loc5 = 5;
         }
         if(loc4 > 5)
         {
            loc4 = 5;
         }
         if(zone.x > zone.goal_x + 6)
         {
            if(zone._xscale > 0)
            {
               zone._xscale *= -1;
            }
            zone.x1 = - loc5;
         }
         else if(zone.x < zone.goal_x - 6)
         {
            if(zone._xscale < 0)
            {
               zone._xscale *= -1;
            }
            zone.x1 = loc5;
         }
         if(zone.y > zone.goal_y + 3)
         {
            zone.y1 = - loc4;
         }
         else if(zone.y < zone.goal_y - 3)
         {
            zone.y1 = loc4;
         }
         loc11 = f_BSPHitTest(zone.x,zone.y,zone.x + zone.x1,zone.y + zone.y1);
         if(!loc11)
         {
            zone.x += zone.x1;
            zone.y += zone.y1;
            zone._x = zone.x;
            zone._y = zone.y;
            f_Depth(zone,zone.y);
         }
         if(zone.timer > 50)
         {
            if(!zone.p_target.pet)
            {
               var loc7 = zone.p_target.x - zone.x;
               var loc6 = zone.p_target.y - zone.y;
               var loc12 = loc7 * loc7 + loc6 * loc6;
               if(loc12 < 400)
               {
                  f_AttachAnimal(zone,zone.p_target);
                  zone.gotoAndStop("happy");
               }
               else
               {
                  zone.state = 20;
                  zone.timer = 0;
                  zone.p_target = undefined;
               }
            }
            else
            {
               zone.state = 10;
               zone.timer = 0;
               zone.p_target = undefined;
            }
         }
   }
}
function f_AnimalSleep(zone)
{
   if(zone.body_y < 0)
   {
      zone.body_y = zone.body_y + 1;
      zone.body._y = zone.body_y;
   }
   zone.timer = zone.timer + 1;
   if(zone.timer > 20)
   {
      zone.timer = random(20);
      if(f_SZ_OnScreenMax(zone))
      {
         var loc2 = false;
         if(!random(60))
         {
            loc2 = true;
            zone.state = 10;
         }
         else if(f_IsAPlayerClose(zone,60))
         {
            loc2 = true;
            zone.state = 30;
         }
         if(loc2 == true)
         {
            zone.gotoAndStop("wake");
         }
         else if(!random(3))
         {
            zone._xscale *= -1;
         }
      }
   }
}
function f_GetSomeLove(zone)
{
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc2 = _root.loader.game.game["p" + int(loc3)];
      if(loc2.alive and !loc2.pet)
      {
         if(loc2.y > _root.loader.game.game.counter._y)
         {
            var loc5 = loc2.x - zone.x;
            var loc4 = loc2.y - zone.y;
            var loc6 = loc5 * loc5 + loc4 * loc4;
            if(loc6 < 40000)
            {
               loc3 = 5;
               return loc2;
            }
         }
      }
      loc3 = loc3 + 1;
   }
   return undefined;
}
function f_AnimalGoto(zone)
{
   if(f_OnScreen(zone.loot))
   {
      var loc3 = Math.abs(zone.x - zone.loot.x);
      var loc2 = Math.abs(zone.y - zone.loot.y);
      if(loc3 > loc2)
      {
         zone.speed_x = zone.speed;
         zone.speed_y = zone.speed * (loc2 / loc3);
         var loc4 = loc3;
      }
      else
      {
         zone.speed_x = zone.speed * (loc3 / loc2);
         zone.speed_y = zone.speed;
         loc4 = loc2;
      }
      if(zone.x < zone.loot.x)
      {
         if(zone._xscale < 0)
         {
            zone._xscale *= -1;
         }
         zone.x += zone.speed_x;
         zone._x = zone.x;
      }
      else
      {
         if(zone._xscale > 0)
         {
            zone._xscale *= -1;
         }
         zone.x -= zone.speed_x;
         zone._x = zone.x;
      }
      if(zone.y < zone.loot.y)
      {
         zone.y += zone.speed_y;
         zone._y = zone.y;
         f_Depth(zone,zone.y);
      }
      else
      {
         zone.y -= zone.speed_y;
         zone._y = zone.y;
         f_Depth(zone,zone.y);
      }
      if(Math.abs(zone.x - zone.loot.x) <= zone.speed)
      {
         if(Math.abs(zone.y - zone.loot.y) <= zone.speed)
         {
            zone.fp_GotoAction(zone);
            return undefined;
         }
      }
   }
   else
   {
      zone.gotoAndStop("follow");
   }
}
function f_AnimalGotoXY(zone, u_x, u_y)
{
   var loc3 = Math.abs(zone.x - u_x);
   var loc2 = Math.abs(zone.y - u_y);
   if(loc3 > loc2)
   {
      zone.speed_x = 8;
      zone.speed_y = 8 * (loc2 / loc3);
      var loc6 = loc3;
   }
   else
   {
      zone.speed_x = 8 * (loc3 / loc2);
      zone.speed_y = 8;
      loc6 = loc2;
   }
   if(zone.x < u_x)
   {
      if(zone._xscale < 0)
      {
         zone._xscale *= -1;
      }
      zone.x += zone.speed_x;
      zone._x = zone.x;
   }
   else
   {
      if(zone._xscale > 0)
      {
         zone._xscale *= -1;
      }
      zone.x -= zone.speed_x;
      zone._x = zone.x;
   }
   if(zone.y < u_y)
   {
      zone.y += zone.speed_y;
      zone._y = zone.y;
      f_Depth(zone,zone.y);
   }
   else
   {
      zone.y -= zone.speed_y;
      zone._y = zone.y;
      f_Depth(zone,zone.y);
   }
   if(Math.abs(zone.x - u_x) <= 8)
   {
      if(Math.abs(zone.y - u_y) <= 8)
      {
         zone.gotoAndStop("lost");
         zone.ignore_timer = 51;
         zone.love_timer = 0;
         zone.state = 150;
         return undefined;
      }
   }
}
function f_AnimalGrabSecretItem(zone)
{
   var loc2 = f_ItemSpawn(zone.x,zone.y,zone.loot.item_type);
   if(zone.loot.weapon_type)
   {
      loc2.weapon_type = zone.loot.weapon_type;
   }
   loc2.body.gotoAndStop("sit");
   zone.carrying = loc2;
   zone.loot.dug = true;
   zone.loot = undefined;
   zone.gotoAndStop("follow");
}
function f_AnimalGrabFruit(zone)
{
   var loc2 = f_ItemSpawn(zone.x,zone.y,random(5) + 2);
   loc2.body.gotoAndStop("sit");
   zone.carrying = loc2;
   zone.loot.dug = true;
   zone.loot = undefined;
   zone.gotoAndStop("follow");
}
function f_CardinalTimer(zone)
{
   zone.timer = zone.timer + 1;
   if(zone.timer > 30)
   {
      zone.timer = 0;
      var loc2 = 1;
      while(loc2 <= secrets_total)
      {
         u_temp = secrets["s" + int(loc2)];
         if(!u_temp.dug)
         {
            if(f_OnScreen(u_temp))
            {
               if(Math.abs(zone.y - u_temp.y) < 200)
               {
                  zone.loot = u_temp;
                  zone.fp_GotoAction = f_AnimalGrabSecretItem;
                  zone.speed = 6;
                  zone.gotoAndStop("goto");
                  return true;
               }
            }
         }
         loc2 = loc2 + 1;
      }
   }
   return false;
}
function f_AnimalDig(zone)
{
   if(zone.loot.dug or !f_OnScreen(zone.loot))
   {
      zone.loot = undefined;
   }
   if(zone.body._y < 0)
   {
      zone.body._y += 2;
      if(zone.body._y > 0)
      {
         zone.body._y = 0;
      }
      zone.body_y = zone.body._y;
   }
   if(zone.loot)
   {
      zone.gotoAndStop("dig");
   }
   else
   {
      zone.gotoAndStop("follow");
   }
}
function f_AnimalRam(zone)
{
   if(zone._xscale > 0)
   {
      f_MoveCharH(zone,zone.speed,0);
   }
   else
   {
      f_MoveCharH(zone,- zone.speed,0);
   }
   zone.speed -= 2;
   if(zone.speed % 4 == 0)
   {
      if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
      {
         if(_root.level_dust != "dust_snow")
         {
            var loc3 = 80 + random(20);
            var loc4 = f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,loc3,loc3);
         }
      }
   }
   f_AnimalRamHit(zone,5);
   if(zone.speed <= 0)
   {
      zone.gotoAndStop("follow");
   }
}
function f_AnimalRamHit(zone, u_pow)
{
   if(!zone.owner)
   {
      return undefined;
   }
   if(zone.owner.health <= 0)
   {
      return undefined;
   }
   var loc4 = false;
   if(zone.owner.human)
   {
      var loc3 = 1;
      while(loc3 <= active_enemies)
      {
         var loc1 = enemyArrayOb["e" + int(loc3)];
         if(!loc1.nohit and loc1.alive)
         {
            if(Math.abs(loc1.y - zone.y) < 15)
            {
               if(Math.abs(loc1.x - zone.x) < 50)
               {
                  if(loc1.body_y > -30)
                  {
                     if(loc1.tossable)
                     {
                        f_Damage(loc1,u_pow,DMG_MELEE,DMGFLAG_JUGGLE,zone._scale <= 0 ? - random(3) : random(3),- (random(6) + 25));
                        loc4 = true;
                        f_FlipSame(loc1,zone);
                        loc1.body._y = -50;
                     }
                  }
               }
            }
         }
         loc3 = loc3 + 1;
      }
   }
   if(!zone.owner.human or friendly_fire)
   {
      loc3 = 1;
      while(loc3 <= active_players)
      {
         loc1 = playerArrayOb["p_pt" + int(loc3)];
         if(loc1 != zone.owner)
         {
            if(!loc1.nohit and loc1.alive)
            {
               if(Math.abs(loc1.y - zone.y) < 15)
               {
                  if(Math.abs(loc1.x - zone.x) < 50)
                  {
                     if(loc1.body_y > -30)
                     {
                        if(GetGameMode() != 3 or GetGameMode() == 3 and zone.owner.flag != loc1.flag)
                        {
                           f_Damage(loc1,u_pow,DMG_MELEE,DMGFLAG_JUGGLE,zone._scale <= 0 ? - random(3) : random(3),- (random(6) + 25));
                           loc4 = true;
                           f_FlipSame(loc1,zone);
                           loc1.body._y = -50;
                        }
                     }
                  }
               }
            }
         }
         loc3 = loc3 + 1;
      }
   }
   if(loc4)
   {
      f_PunchSound();
      f_FX(zone.x,zone.body._y + zone.y,int(zone.y) + 15,"impact1",100,100);
   }
}
function f_OwletTimer(zone)
{
   zone.timer = zone.timer + 1;
   if(zone.timer > 30)
   {
      zone.timer = 0;
      var loc1 = 1;
      while(loc1 <= trees_total)
      {
         u_temp = trees["s" + int(loc1)];
         if(!u_temp.dug)
         {
            if(f_OnScreen(u_temp))
            {
               zone.loot = u_temp;
               zone.fp_GotoAction = f_AnimalGrabFruit;
               zone.speed = 6;
               zone.gotoAndStop("goto");
               return true;
            }
         }
         loc1 = loc1 + 1;
      }
   }
   return false;
}
function f_PazzoTimer(zone)
{
   zone.timer = zone.timer + 1;
   if(zone.timer > 30)
   {
      zone.timer = 0;
      var loc1 = 1;
      while(loc1 <= shovelspots_total)
      {
         u_temp = shovelspots["s" + int(loc1)];
         if(!u_temp.dug)
         {
            if(f_OnScreen(u_temp))
            {
               zone.loot = u_temp;
               zone.fp_GotoAction = f_AnimalDig;
               zone.speed = 6;
               zone.gotoAndStop("goto");
               return true;
            }
         }
         loc1 = loc1 + 1;
      }
   }
   return false;
}
function f_TrollPetTimer(zone)
{
   zone.timer = zone.timer + 1;
   if(zone.timer > 300)
   {
      zone.timer = 0;
      if(zone.owner.health < zone.owner.health_max - 1)
      {
         if(zone.owner.health > 0 and zone.owner.alive)
         {
            var loc2 = zone.owner.health_max * 0.01;
            f_Heal(zone.owner,loc2);
         }
      }
   }
}
function f_RammyTimer(zone)
{
   zone.timer = zone.timer + 1;
   if(zone.timer > 60 and !cinema)
   {
      zone.timer = 0;
      if(!zone.owner)
      {
         return false;
      }
      if(zone.owner.health <= 0)
      {
         return false;
      }
      if(zone.owner.human)
      {
         var loc3 = 1;
         while(loc3 <= active_enemies)
         {
            var loc2 = enemyArrayOb["e" + int(loc3)];
            if(loc2.alive and loc2.humanoid and !loc2.animalproof)
            {
               if(Math.abs(loc2.y - zone.y) < 10)
               {
                  if(loc2.x > zone.x and zone._xscale > 0 or loc2.x < zone.x and zone._xscale < 0)
                  {
                     zone.speed = 38;
                     zone.gotoAndStop("ram");
                     return true;
                  }
               }
            }
            loc3 = loc3 + 1;
         }
      }
      if(!zone.owner.human or friendly_fire)
      {
         loc3 = 1;
         while(loc3 <= active_players)
         {
            loc2 = playerArrayOb["p_pt" + int(loc3)];
            if(GetGameMode() != 3 or GetGameMode() == 3 and zone.owner.flag != loc2.flag)
            {
               if(Math.abs(loc2.y - zone.y) < 10)
               {
                  if(loc2.x > zone.x and zone._xscale > 0 or loc2.x < zone.x and zone._xscale < 0)
                  {
                     zone.speed = 38;
                     zone.gotoAndStop("ram_intro");
                     return true;
                  }
               }
            }
            loc3 = loc3 + 1;
         }
      }
   }
   f_FlipSame(zone,zone.owner);
   return false;
}
function f_InstallBounce(zone)
{
   zone.body_y += zone.speed_y;
   if(zone.body_y >= 0)
   {
      zone.body_y = 0;
      zone.pause = true;
      zone.speed_y = -10;
      zone.body.body.body.gotoAndPlay(2);
      zone.body._y = zone.body_y;
      return undefined;
   }
   zone.body._y = zone.body_y;
   zone.speed_y += zone.gravity;
}
function f_InstallBallTimer(zone)
{
   if(zone.pause)
   {
      return true;
   }
   f_InstallBounce(zone);
   if(boss_fight and level == 43)
   {
      return false;
   }
   zone.timer = zone.timer + 1;
   var loc4 = 0;
   if(zone.timer > 120 and zone.body_y < -30)
   {
      zone.timer = 0;
      if(!zone.owner)
      {
         return false;
      }
      if(zone.owner.health <= 0)
      {
         return false;
      }
      var loc3 = 1;
      while(loc3 <= active_enemies)
      {
         if(!loc4)
         {
            var loc2 = enemyArrayOb["e" + int(loc3)];
            if(loc2.alive and loc2.humanoid and !loc2.animalproof)
            {
               if(Math.abs(loc2.y - zone.y) < 10)
               {
                  loc4 = enemyArrayOb["e" + int(loc3)];
               }
            }
         }
         loc3 = loc3 + 1;
      }
      if(!loc4 and GetGameMode() == 3)
      {
         loc3 = 1;
         while(loc3 <= active_players)
         {
            if(!loc4)
            {
               loc2 = playerArrayOb["p_pt" + int(loc3)];
               if(loc2.alive and loc2 != zone.owner)
               {
                  if(loc2.flag != zone.owner.flag)
                  {
                     if(Math.abs(loc2.y - zone.y) < 10)
                     {
                        loc4 = playerArrayOb["p_pt" + int(loc3)];
                     }
                  }
               }
            }
            loc3 = loc3 + 1;
         }
      }
   }
   if(loc4)
   {
      s_Photon.start(0,0);
      var loc5 = f_FX(zone.x,zone.y,zone.y + 1,"photon",100,100);
      loc5.n_groundtype = zone.owner.n_groundtype;
      loc5.owner = zone.owner;
      loc5.item_type = "photon";
      loc5.body._y = zone.body_y;
      loc5.speed_x = 18;
      if(loc4.x < zone.x)
      {
         loc5.speed_x = - loc5.speed_x;
      }
      if(loc4.body_y < 0)
      {
         loc5.speed_y = - Math.abs(loc4.body_y) / 18;
      }
      else
      {
         loc5.speed_y = 0;
      }
      loc5.speed_z = 0;
      loc5.gravity = 0;
      loc5.w = 6;
      loc5.shadow_pt = f_NewShadow();
      loc5.shadow_pt._x = loc5._x;
      loc5.shadow_pt._y = loc5._y;
      loc5.shadow_pt._xscale = 50;
      loc5.shadow_pt._yscale = 50;
      loc5.attack_pow = 5;
      loc5.damage_type = DMG_MELEE;
      return true;
   }
   return false;
}
function f_AnimalPeck(zone)
{
   if(zone.loot.onground)
   {
      zone.gotoAndStop("peck");
   }
   else
   {
      zone.loot = undefined;
      zone.gotoAndStop("follow");
   }
}
function f_HawksterTimer(zone)
{
   if(!zone.loot.alive or !zone.loot.onground)
   {
      zone.loot = undefined;
   }
   if(!zone.owner)
   {
      return false;
   }
   if(zone.owner.health <= 0)
   {
      return false;
   }
   if(!zone.loot)
   {
      var loc3 = 1;
      while(loc3 <= active_enemies)
      {
         var loc2 = enemyArrayOb["e" + int(loc3)];
         if(loc2.alive and loc2.onground)
         {
            if(!zone.loot)
            {
               zone.loot = loc2;
            }
            else if(Math.abs(loc2.x - zone.x) < Math.abs(zone.loot.x - zone.x))
            {
               zone.loot = loc2;
            }
         }
         loc3 = loc3 + 1;
      }
   }
   if(!zone.loot)
   {
      if(friendly_fire or GetGameMode() == 3)
      {
         loc3 = 1;
         while(loc3 <= active_players)
         {
            loc2 = playerArrayOb["p_pt" + int(loc3)];
            if(loc2.alive and loc2 != zone.owner and loc2.onground)
            {
               if(GetGameMode() != 3 and loc2.health < 12 or GetGameMode() == 3 and loc2.flag != zone.owner.flag)
               {
                  if(!zone.loot)
                  {
                     zone.loot = loc2;
                  }
                  else if(Math.abs(loc2.x - zone.x) < Math.abs(zone.loot.x - zone.x))
                  {
                     zone.loot = loc2;
                  }
               }
            }
            loc3 = loc3 + 1;
         }
      }
   }
   if(zone.loot and !zone.carrying)
   {
      zone.fp_GotoAction = f_AnimalPeck;
      zone.speed = 10;
      zone.gotoAndStop("goto");
   }
   return false;
}
function f_FrogGrab(zone)
{
   if(zone.body_y < -25)
   {
      zone.body_y += 1;
      if(zone.body_y > 0)
      {
         zone.body_y = 0;
      }
      zone.body._y = zone.body_y;
   }
   zone.tonguelength += zone.tonguespeed;
   zone.body.tongue.gotoAndStop(zone.tonguelength);
   if(zone.carrying)
   {
      if(!f_ConfirmPickup(zone.carrying))
      {
         zone.carrying = undefined;
      }
   }
   else
   {
      if(zone._xscale > 0)
      {
         u_temp = zone.x + zone.tonguelength;
      }
      else
      {
         u_temp = zone.x - zone.tonguelength;
      }
      if(f_ConfirmPickup(zone.loot))
      {
         if(Math.abs(u_temp - zone.loot.x) <= 25)
         {
            zone.carrying = zone.loot;
            zone.tonguespeed *= -1;
            zone.loot = undefined;
         }
      }
      else
      {
         if(zone.tonguespeed > 0)
         {
            zone.tonguespeed *= -1;
         }
         zone.loot = undefined;
      }
   }
   if(zone.tonguespeed < 0)
   {
      if(zone.carrying)
      {
         if(zone._xscale > 0)
         {
            zone.carrying.x += zone.tonguespeed;
         }
         else
         {
            zone.carrying.x -= zone.tonguespeed;
         }
         zone.carrying._x = zone.carrying.x;
         zone.carrying.shadow_pt._x = zone.carrying.x;
         if(Math.abs(zone.carrying.x - zone.owner.x) < 30)
         {
            if(Math.abs(zone.carrying.y - zone.owner.y) < 10)
            {
               f_GetPickup(zone.owner,zone.carrying);
               zone.carrying.body.gotoAndStop("pickup");
               f_PickupPop(zone.carrying);
               zone.carrying = undefined;
               zone.loot = undefined;
            }
         }
      }
      if(zone.tonguelength <= 0)
      {
         zone.gotoAndStop("follow");
      }
   }
}
function f_FroggletTimer(zone)
{
   if(!zone.carrying)
   {
      zone.timer = zone.timer + 1;
      if(zone.timer > 10)
      {
         zone.timer = 0;
         var loc3 = 1;
         while(loc3 <= total_pickups)
         {
            var loc2 = pickupArrayOb["pickup" + int(loc3)];
            if(!loc2.weapon_type)
            {
               if(Math.abs(zone.x - loc2.x) < 300)
               {
                  if(Math.abs(zone.y - loc2.y) < 10)
                  {
                     zone.loot = loc2;
                     zone.tonguelength = 1;
                     zone.tonguespeed = 25;
                     zone.gotoAndStop("tongue");
                  }
               }
            }
            loc3 = loc3 + 1;
         }
      }
   }
}
function f_AnimalMaul(zone)
{
   if(zone.loot.health > 0)
   {
      zone.gotoAndStop("maul");
   }
   else
   {
      zone.loot = undefined;
      zone.gotoAndStop("follow");
   }
}
function f_PolarBearTimer(zone)
{
   if(!zone.loot.alive)
   {
      zone.loot = undefined;
   }
   if(!zone.owner)
   {
      return undefined;
   }
   if(zone.owner.health <= 0)
   {
      return undefined;
   }
   if(!zone.loot and !cinema)
   {
      var loc2 = 1;
      while(loc2 <= active_enemies)
      {
         var loc1 = enemyArrayOb["e" + int(loc2)];
         if(loc1.alive and !loc1.animalproof)
         {
            if(loc1.health / loc1.health_max < 0.08)
            {
               zone.loot = loc1;
               return undefined;
            }
         }
         loc2 = loc2 + 1;
      }
      if(friendly_fire)
      {
         loc2 = 1;
         while(loc2 <= active_players)
         {
            loc1 = playerArrayOb["p_pt" + int(loc2)];
            if(loc1.alive and loc1 != zone.owner)
            {
               if(loc1.health / loc1.health_max < 0.08)
               {
                  zone.loot = loc1;
                  return undefined;
               }
            }
            loc2 = loc2 + 1;
         }
      }
      if(zone.owner.health < 12)
      {
         zone.loot = zone.owner;
         return undefined;
      }
   }
   if(zone.loot)
   {
      zone.fp_GotoAction = f_AnimalMaul;
      zone.speed = 10;
      zone.gotoAndStop("goto");
   }
   return false;
}
function f_BatAttack(zone)
{
   if(zone.loot.health > 0 and zone.loot.humanoid and !cinema and !zone.loot.horse and !zone.loot.beefy and !zone.loot.hostage)
   {
      if(zone.loot.body_y >= 0 and !zone.loot.nohit and !zone.loot.onground)
      {
         if(Math.abs(zone.x - zone.loot.x) < 30)
         {
            if(Math.abs(zone.y - zone.loot.y) < 10)
            {
               zone.loot.prev_StandAnim = zone.loot.fp_StandAnim;
               zone.loot.prev_WalkAnim = zone.loot.fp_WalkAnim;
               zone.loot.prev_Character = zone.loot.fp_Character;
               zone.loot.hostage = zone;
               zone.captor = zone.loot;
               zone.loot.gotoAndStop("bathead");
               zone.loot = undefined;
               zone.gotoAndStop("bat");
               return undefined;
            }
         }
      }
   }
   zone.loot = undefined;
   zone.gotoAndStop("follow");
}
function f_BatTimer(zone)
{
   if(!zone.owner)
   {
      zone.ignore_timer = 51;
      zone.love_timer = 0;
      zone.state = 150;
      zone.gotoAndStop("lost");
      return undefined;
   }
   if(zone.owner.health <= 0)
   {
      return undefined;
   }
   if(!zone.loot.alive)
   {
      zone.loot = undefined;
   }
   if(!zone.loot)
   {
      if(zone.timer <= 0)
      {
         if(!cinema)
         {
            zone.timer = 300;
            var loc3 = 1;
            while(loc3 <= active_enemies)
            {
               var loc1 = enemyArrayOb["e" + int(loc3)];
               if(loc1.alive and loc1.humanoid and !loc1.hostage)
               {
                  if(!loc1.beefy and !loc1.horse and !loc1.animalproof)
                  {
                     if(f_OnScreen(loc1))
                     {
                        zone.loot = loc1;
                        return undefined;
                     }
                  }
               }
               loc3 = loc3 + 1;
            }
            if(GetGameMode() == 3)
            {
               loc3 = 1;
               while(loc3 <= active_players)
               {
                  loc1 = playerArrayOb["p_pt" + int(loc3)];
                  if(loc1.alive and loc1 != zone.owner)
                  {
                     if(!loc1.beefy and !loc1.horse)
                     {
                        if(loc1.flag != zone.owner.flag)
                        {
                           zone.loot = loc1;
                           return undefined;
                        }
                     }
                  }
                  loc3 = loc3 + 1;
               }
            }
         }
      }
      else
      {
         zone.timer = zone.timer - 1;
      }
   }
   if(zone.loot)
   {
      zone.fp_GotoAction = f_BatAttack;
      zone.speed = 10;
      zone.gotoAndStop("goto");
   }
   return false;
}
function f_DragonTimer(zone)
{
   zone.timer = zone.timer + 1;
   var loc4 = 0;
   if(zone.timer > 120)
   {
      zone.timer = 0;
      if(!zone.owner)
      {
         return false;
      }
      if(zone.owner.health <= 0)
      {
         return false;
      }
      var loc3 = 1;
      while(loc3 <= active_enemies)
      {
         if(!loc4)
         {
            var loc2 = enemyArrayOb["e" + int(loc3)];
            if(loc2.alive and loc2.humanoid and !loc2.animalproof)
            {
               if(Math.abs(loc2.y - zone.y) < 10)
               {
                  if(loc2.x > zone.x and zone._xscale > 0 or loc2.x < zone.x and zone._xscale < 0)
                  {
                     loc4 = enemyArrayOb["e" + int(loc3)];
                  }
               }
            }
         }
         loc3 = loc3 + 1;
      }
      if(!loc4 and GetGameMode() == 3)
      {
         loc3 = 1;
         while(loc3 <= active_players)
         {
            if(!loc4)
            {
               loc2 = playerArrayOb["p_pt" + int(loc3)];
               if(loc2.alive and loc2 != zone.owner)
               {
                  if(loc2.flag != zone.owner.flag)
                  {
                     if(Math.abs(loc2.y - zone.y) < 10)
                     {
                        if(loc2.x > zone.x and zone._xscale > 0 or loc2.x < zone.x and zone._xscale < 0)
                        {
                           loc4 = playerArrayOb["p_pt" + int(loc3)];
                        }
                     }
                  }
               }
            }
            loc3 = loc3 + 1;
         }
      }
   }
   if(loc4)
   {
      var loc5 = f_FX(zone.x,zone.y,zone.y + 1,"general_projectile",zone._xscale,100);
      loc5.projectile_type = 25;
      loc5.n_groundtype = zone.owner.n_groundtype;
      loc5.owner = zone.owner;
      loc5.attack_pow = zone.owner.magic_pow / 2;
      loc5.body._y = zone.body_y - 10;
      loc5.speed_x = 18;
      if(loc4.x < zone.x)
      {
         loc5.speed_x = - loc5.speed_x;
      }
      loc5.speed_y = 0;
      loc5.speed_z = 0;
      loc5.gravity = 0;
      loc5.w = 6;
      loc5.shadow_pt = f_NewShadow();
      loc5.shadow_pt._x = loc5._x;
      loc5.shadow_pt._y = loc5._y;
      loc5.shadow_pt._xscale = 50;
      loc5.shadow_pt._yscale = 50;
      return true;
   }
   return false;
}
function f_PelterTimer(zone)
{
   zone.timer = zone.timer + 1;
   var loc4 = 0;
   if(zone.timer > 120)
   {
      zone.timer = 0;
      if(!zone.owner)
      {
         return false;
      }
      if(zone.owner.health <= 0)
      {
         return false;
      }
      var loc3 = 1;
      while(loc3 <= active_enemies)
      {
         if(!loc4)
         {
            var loc2 = enemyArrayOb["e" + int(loc3)];
            if(loc2.alive and loc2.humanoid and !loc2.animalproof)
            {
               if(Math.abs(loc2.y - zone.y) < 10)
               {
                  if(loc2.x > zone.x and zone._xscale > 0 or loc2.x < zone.x and zone._xscale < 0)
                  {
                     loc4 = enemyArrayOb["e" + int(loc3)];
                  }
               }
            }
         }
         loc3 = loc3 + 1;
      }
      if(!loc4 and GetGameMode() == 3)
      {
         loc3 = 1;
         while(loc3 <= active_players)
         {
            if(!loc4)
            {
               loc2 = playerArrayOb["p_pt" + int(loc3)];
               if(loc2.alive and loc2 != zone.owner)
               {
                  if(loc2.flag != zone.owner.flag)
                  {
                     if(Math.abs(loc2.y - zone.y) < 10)
                     {
                        if(loc2.x > zone.x and zone._xscale > 0 or loc2.x < zone.x and zone._xscale < 0)
                        {
                           loc4 = playerArrayOb["p_pt" + int(loc3)];
                        }
                     }
                  }
               }
            }
            loc3 = loc3 + 1;
         }
      }
   }
   if(loc4)
   {
      var loc5 = f_FX(zone.x,zone.y,zone.y + 1,"general_projectile",zone._xscale,100);
      loc5.projectile_type = 27;
      loc5.n_groundtype = zone.owner.n_groundtype;
      loc5.owner = zone.owner;
      loc5.attack_pow = zone.owner.magic_pow;
      loc5.body._y = zone.body_y - 10;
      loc5.speed_x = 12 + random(6);
      if(loc4.x < zone.x)
      {
         loc5.speed_x = - loc5.speed_x;
      }
      loc5.speed_y = - (2 + random(8));
      loc5.speed_z = 0;
      loc5.gravity = 1;
      loc5.w = 6;
      loc5.shadow_pt = f_NewShadow();
      loc5.shadow_pt._x = loc5._x;
      loc5.shadow_pt._y = loc5._y;
      loc5.shadow_pt._xscale = 50;
      loc5.shadow_pt._yscale = 50;
      return true;
   }
   return false;
}
function f_WhaleTimer(zone)
{
   zone.timer = zone.timer - 1;
   if(zone.timer <= 0)
   {
      zone.timer = 30 * (12 + random(6));
      var loc2 = f_ItemSpawn(zone._x,zone._y,9);
      loc2.gem_type = 13;
   }
}
function f_WhaleActive()
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = _root.p_game["p" + int(loc2)];
      if(loc3.alive)
      {
         if(loc3.pet.animal_type == 29)
         {
            if(random(5) == 0)
            {
               return true;
            }
            return false;
         }
      }
      loc2 = loc2 + 1;
   }
   return false;
}
function f_UpdateAchievement(achievement, port, update)
{
   switch(achievement)
   {
      case "KISS":
         if(f_ReceivedAllKisses(port - 1,update))
         {
            UnlockAchievement(port - 1,1);
         }
         break;
      case "Traditional":
         var loc2 = 1;
         while(loc2 <= active_players)
         {
            var loc3 = playerArrayOb["p_pt" + int(loc2)];
            if(loc3.alive)
            {
               var loc1 = loc3.hud_pt;
               if(f_BeatAllLevels(loc1))
               {
                  UnlockAchievement(loc1.port - 1,2);
               }
            }
            loc2 = loc2 + 1;
         }
         break;
      case "TheTraitor":
         loc2 = 1;
         while(loc2 <= active_players)
         {
            loc3 = playerArrayOb["p_pt" + int(loc2)];
            if(loc3.alive)
            {
               loc1 = loc3.hud_pt.p_type;
               switch(level)
               {
                  case 7:
                     if(loc1 == 6)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
                     break;
                  case 23:
                     if(loc1 == 19)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
                     break;
                  case 29:
                     if(loc1 == 21)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
                     break;
                  case 36:
                     if(loc1 == 21)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
                     break;
                  case 30:
                     if(loc1 == 24)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
                     break;
                  case 58:
                     if(loc1 == 10)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
                     break;
                  case 43:
                     if(loc1 == 15)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
                     break;
                  case 3:
                     if(loc1 == 14)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
                     break;
                  case 51:
                     if(loc1 == 26)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
                     break;
                  case 55:
                     if(loc1 == 25)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
                     break;
                  case 50:
                     if(loc1 == 28)
                     {
                        UnlockAchievement(loc3.hud_pt.port - 1,3);
                     }
               }
            }
            loc2 = loc2 + 1;
         }
         break;
      case "DeerTrainer":
         UnlockAchievement(port - 1,4);
         break;
      case "ConscientiousObjector":
         UnlockAchievement(port - 1,5);
         break;
      case "MaximumFirepower":
         UnlockAchievement(port - 1,6);
         break;
      case "AnimalHandler":
         UnlockAchievement(port - 1,7);
         break;
      case "ArenaMaster":
         if(update >= 40)
         {
            UnlockAchievement(port - 1,8);
         }
         break;
      case "Glork":
         if(update >= 20)
         {
            UnlockAchievement(port - 1,9);
         }
         break;
      case "MeleeIsBest":
         if(player_used_magic == false)
         {
            loc2 = 1;
            while(loc2 <= active_players)
            {
               loc3 = playerArrayOb["p_pt" + int(loc2)];
               if(loc3.alive)
               {
                  UnlockAchievement(loc3.hud_pt.port - 1,10);
               }
               loc2 = loc2 + 1;
            }
         }
         break;
      case "TreasureHunter":
         UnlockAchievement(port - 1,11);
         break;
      case "Medic!":
         UnlockAchievement(port - 1,12);
   }
   return false;
}
function f_ReceivedAllKisses(port, update)
{
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc4 = _root["hud" + int(loc3)];
      if(loc4.port - 1 == port)
      {
         var loc5 = int(_root.save_data_info.char_offset + _root.save_data_info.char_size * int(f_GetSaveDataOffset(loc4.p_type)) + 29);
         var loc2 = ReadStorage(port,loc5);
         loc2 |= update;
         WriteStorage(port,loc5,loc2);
         var loc7 = 15;
         if(loc2 == loc7)
         {
            return true;
         }
         return false;
      }
      loc3 = loc3 + 1;
   }
   return false;
}
function f_CheckDigAchievement(zone)
{
   var loc3 = int(_root.save_data_info.char_offset + _root.save_data_info.char_size * int(f_GetSaveDataOffset(zone.p_type)) + 28);
   var loc2 = ReadStorage(zone.hud_pt.port - 1,loc3);
   if(loc2 < 10)
   {
      loc2 = loc2 + 1;
      WriteStorage(zone.hud_pt.port - 1,loc3,loc2);
   }
   if(loc2 >= 10)
   {
      f_UpdateAchievement("TreasureHunter",zone.hud_pt.port,1);
   }
}
function f_CheckMedicAchievement(zone, zone2)
{
   var loc1 = zone2.hud_pt.port;
   if(loc1 == 1)
   {
      zone.hud_pt.achievement |= 16;
   }
   else if(loc1 == 2)
   {
      zone.hud_pt.achievement |= 32;
   }
   else if(loc1 == 3)
   {
      zone.hud_pt.achievement |= 64;
   }
   else if(loc1 == 4)
   {
      zone.hud_pt.achievement |= 128;
   }
   var loc3 = zone.hud_pt.achievement & 240;
   if(loc3 == 240)
   {
      f_UpdateAchievement("Medic!",zone.hud_pt.port,1);
   }
}
function f_FlipChar(zone)
{
   zone._xscale *= -1;
}
function f_FlipSame(zone, zone2)
{
   if(zone._xscale > 0 and zone2._xscale < 0)
   {
      f_FlipChar(zone);
   }
   else if(zone._xscale < 0 and zone2._xscale > 0)
   {
      f_FlipChar(zone);
   }
}
function f_FlipInverse(zone, zone2)
{
   if(zone._xscale > 0 and zone2._xscale > 0)
   {
      f_FlipChar(zone);
   }
   else if(zone._xscale < 0 and zone2._xscale < 0)
   {
      f_FlipChar(zone);
   }
}
function f_ItemSpawn(x, y, item_type)
{
   var loc1 = f_FX(x,y,int(y),"item",100,100);
   loc1.item_type = item_type;
   if(item_type == 9)
   {
      if(f_WhaleActive())
      {
         loc1.gem_type = random(11) + 1;
      }
      else
      {
         loc1.gem_type = random(12) + 1;
      }
   }
   loc1.body.item.gotoAndStop(loc1.item_type);
   loc1.shadow_pt = f_NewShadow();
   loc1.shadow_pt.gotoAndStop("off");
   return loc1;
}
function f_RandomItemSpawn(zone)
{
   var loc1 = random(8) + 2;
   f_ItemSpawn(zone.x,zone.y,loc1);
}
function f_RandomTreeItem(zone)
{
   var loc1 = f_ItemSpawn(zone.x,zone.y,random(5) + 2);
   loc1.body.gotoAndPlay("treefall");
}
function f_RandomGoldSpawn(x, y)
{
   var loc1 = f_FX(x,y,int(y),"item",100,100);
   if(random(3) == 1)
   {
      loc1.item_type = 8;
   }
   else
   {
      loc1.item_type = 9;
      if(f_WhaleActive())
      {
         loc1.gem_type = random(11) + 1;
      }
      else
      {
         loc1.gem_type = random(12) + 1;
      }
   }
   loc1.body.item.gotoAndStop(loc1.item_type);
   return loc1;
}
function f_GoldDrop(x, y)
{
   var loc2 = f_FX(x,y,int(y),"item",100,100);
   if(loc2)
   {
      var loc3 = 3;
      var loc4 = 11;
      switch(_root.level)
      {
         case 7:
            loc3 = 2;
            loc4 = 1;
            break;
         case 21:
            loc3 = 3;
            loc4 = 2;
            break;
         case 36:
            loc3 = 4;
            loc4 = 5;
            break;
         case 51:
            loc3 = 6;
            loc4 = 9;
            break;
         case 53:
            loc3 = 7;
            loc4 = 11;
            break;
         case 55:
            loc3 = 7;
            loc4 = 11;
      }
      if(random(loc3) == 1)
      {
         loc2.item_type = 8;
      }
      else
      {
         loc2.item_type = 9;
         if(random(loc3) == 1 and !f_WhaleActive())
         {
            loc2.gem_type = 12;
         }
         else
         {
            loc2.gem_type = random(loc4) + 1;
         }
      }
      loc2.body.item.gotoAndStop(loc2.item_type);
      loc2.body.gotoAndPlay("fall");
      loc2.shadow_pt = f_NewShadow();
      loc2.shadow_pt.gotoAndStop("off");
   }
}
function f_GoldShoot(zone)
{
   var loc1 = f_FX(zone.x - 60 + random(120),zone.y,int(y + 1),"goldshoot",100,100);
   loc1.body._rotation = -3 + random(6);
   loc1.body.speed_y = - (26 + random(10));
}
function f_KillEnemies()
{
   var loc2 = undefined;
   var loc1 = 1;
   while(loc1 <= total_enemies)
   {
      loc2 = loader.game.game["e" + int(loc1)];
      if(loc2.alive)
      {
         loc2.health = 0;
         loc2.gotoAndStop("hitground1");
      }
      loc1 = loc1 + 1;
   }
}
function f_KillOffscreenEnemies()
{
   var loc1 = undefined;
   var loc2 = 1;
   while(loc2 <= total_enemies)
   {
      loc1 = loader.game.game["e" + int(loc2)];
      if(loc1.alive)
      {
         if(!f_SZ_PlayerXOnScreen(loc1._x) or !f_SZ_PlayerYOnScreen(loc1._y))
         {
            loc1.health = 0;
            loc1.gotoAndStop("hitground1");
         }
      }
      loc2 = loc2 + 1;
   }
}
function f_KidSettings(zone)
{
   zone.nohit = false;
   zone.falling = false;
   zone.dashing = false;
   zone.onground = false;
   zone.onfire = 1;
   zone.bounces = 0;
   zone.damage_chain = 0;
   zone.toss_clock = 0;
   zone.current_weight = zone.weight;
   zone.root = true;
   f_PunchReset(zone);
   zone.horse_move = false;
   zone.ladder = undefined;
   zone.busy = false;
   zone.spinning = false;
   zone.float_timer = 0;
   zone.sheathing = false;
   zone.blocking = false;
   zone.blocked = false;
   if(zone.grappler)
   {
      zone.grappler.grappler = undefined;
      zone.grappler = undefined;
   }
   if(zone.body_y >= 0)
   {
      zone.jumping = false;
   }
   zone.nohit = false;
   zone.onfire = 1;
   zone.onground = false;
   if(zone.health <= 0)
   {
      if(zone.humanoid)
      {
         s_Ground3.start(0,0);
         zone.alive = false;
         zone.gotoAndStop("hitground1");
      }
   }
}
function f_Juggle1Setup(zone)
{
   zone.nohit = true;
   zone.bounces = 0;
   if(level == 23 or level == 102)
   {
      if(zone.human)
      {
         _root.loader.f_KnockOff(zone);
      }
   }
}
function f_ClearHostage(zone)
{
   zone.hostage.captor = undefined;
   zone.hostage = undefined;
   zone.fp_StandAnim = zone.prev_StandAnim;
   zone.fp_WalkAnim = zone.prev_WalkAnim;
   zone.fp_Character = zone.prev_Character;
   zone.throwmove = false;
}
function f_DropHostage(zone)
{
   if(zone.hostage)
   {
      zone.hostage.speed_toss_x = 0;
      zone.hostage.speed_toss_y = -6;
      f_Juggle1Setup(zone.hostage);
      zone.hostage.gotoAndStop("juggle1");
      f_ClearHostage(zone);
   }
}
function f_KnockOffHorse(zone)
{
   if(f_LoseHorse(zone))
   {
      zone.speed_toss_x = 10 + random(10);
      zone.speed_toss_y = -9;
      f_Juggle1Setup(zone);
      zone.gotoAndStop("juggle1");
   }
}
function f_LoseHorse(zone)
{
   if(zone.horse)
   {
      zone.horse.gotoAndStop("wait");
      zone.horse = undefined;
      return true;
   }
   return false;
}
function f_Juggle1(zone)
{
   if(zone.horse)
   {
      zone.horse.gotoAndStop("wait");
      zone.horse = undefined;
   }
   if(zone.vehicle)
   {
      if(zone.vehicle.rider1 == zone)
      {
         zone.vehicle.rider1 = undefined;
      }
      else if(zone.vehicle.rider2 == zone)
      {
         zone.vehicle.rider2 = undefined;
      }
      else if(zone.vehicle.rider3 == zone)
      {
         zone.vehicle.rider3 = undefined;
      }
      else if(zone.vehicle.rider4 == zone)
      {
         zone.vehicle.rider4 = undefined;
      }
      zone.vehicle = undefined;
   }
   f_DropHostage(zone);
   if(zone.beefy)
   {
      if(zone.thrown)
      {
         zone.thrown = false;
         f_Juggle1Setup(zone);
         zone.gotoAndStop("juggle1");
         zone.body._y = zone.body_y + zone.body_table_y;
      }
      else if(zone.health > 0)
      {
         if(zone.skipjuggle < 1)
         {
            zone.skipjuggle = 1;
         }
         else
         {
            zone.skipjuggle = zone.skipjuggle + 1;
         }
         if(zone.skipjuggle > 10 or zone.body_y < 0)
         {
            zone.skipjuggle = 0;
            f_Juggle1Setup(zone);
            zone.gotoAndStop("juggle1");
            zone.body._y = zone.body_y + zone.body_table_y;
         }
         else
         {
            f_BeefyHit(zone);
         }
      }
      else
      {
         zone.alive = false;
         zone.gotoAndStop("beefy_hitground1");
      }
   }
   else
   {
      f_Juggle1Setup(zone);
      zone.gotoAndStop("juggle1");
      zone.body._y = zone.body_y + zone.body_table_y;
   }
}
function f_CallJuggle1(zone)
{
   zone.fp_Juggle(zone);
}
function f_Collide(zone)
{
   if(zone.collide.body_y >= -10)
   {
      if(zone.collide.grab)
      {
         f_FlipSame(zone.collide,zone);
         zone.collide.speed_toss_y = -6;
         zone.collide.speed_toss_x = - random(6) + 10;
         f_CallJuggle1(zone.collide);
         f_PunchSound();
         f_FX(zone.x,zone.body_y + zone.y,int(zone.y) + 15,"impact1",100,100);
      }
      else if(zone.collide.punch)
      {
         zone.collide.punch_function(zone.collide);
      }
      else
      {
         f_PunchSound();
         f_FX(zone.x,zone.body_y + zone.y,int(zone.y) + 15,"impact1",100,100);
      }
   }
}
function f_PushBack(zone)
{
   if(zone.human)
   {
      if(zone._xscale > 0)
      {
         f_MoveCharH(zone,- zone.speed_toss_x,0);
      }
      else
      {
         f_MoveCharH(zone,zone.speed_toss_x,0);
      }
   }
   else if(zone._xscale > 0)
   {
      f_MoveCharH(zone,- zone.speed_toss_x,0);
   }
   else
   {
      f_MoveCharH(zone,zone.speed_toss_x,0);
   }
   zone.speed_toss_x -= 2;
   if(zone.speed_toss_x < 0)
   {
      zone.speed_toss_x = 0;
   }
}
function f_MoveBack(zone)
{
   if(zone.human)
   {
      if(zone._xscale > 0)
      {
         f_MoveCharH(zone,- zone.speed_toss_x,0);
      }
      else
      {
         f_MoveCharH(zone,zone.speed_toss_x,0);
      }
   }
   else if(zone._xscale > 0)
   {
      f_MoveCharH(zone,- zone.speed_toss_x,0);
   }
   else
   {
      f_MoveCharH(zone,zone.speed_toss_x,0);
   }
}
function f_KidToss(zone)
{
   zone.collide = undefined;
   if(zone._xscale > 0)
   {
      f_MoveCharH(zone,- zone.speed_toss_x,0);
   }
   else
   {
      f_MoveCharH(zone,zone.speed_toss_x,0);
   }
   if(zone.hitwall or zone.hitwall_h)
   {
      f_Collide(zone);
      zone.hitwall = false;
      zone.hitwall_h = false;
      f_FlipChar(zone);
      f_Damage(zone,5,DMG_MELEE);
      zone.speed_toss_x *= 0.5;
   }
   if(zone._x < main.left)
   {
      if(zone._xscale > 0)
      {
         f_FlipChar(zone);
         zone.speed_toss_x *= 0.75;
      }
   }
   else if(zone._x > main.right)
   {
      if(zone._xscale < 0)
      {
         f_FlipChar(zone);
         zone.speed_toss_x *= 0.75;
      }
   }
   zone.body_y += zone.speed_toss_y + zone.current_weight;
   zone.body._y = zone.body_y + zone.body_table_y;
   zone.toss_clock = zone.toss_clock + 1;
   if(zone.toss_clock % 10 == 0)
   {
      zone.current_weight += zone.weightplus;
   }
   f_KidHitKids(zone);
   zone.speed_toss_y += gravity;
   if(zone.helmet == 30)
   {
      f_BloodShrapnel2(zone.x,zone.y,zone.body_y + zone.y);
   }
   if(zone.body_y > 0)
   {
      zone.body_y = 0;
      zone.body._y = zone.body_y + zone.body_table_y;
      zone.shadow_pt._xscale = 100;
      zone.shadow_pt._yscale = 100;
      zone.restore_anim = "";
      if(zone.explode)
      {
         f_RemoveShadow(zone);
         s_Explosion6.start(0,0);
         f_Explosion(zone);
         zone.active = false;
         zone.grab = false;
         zone.punch = false;
         f_StaticRange();
         f_SpawnMask(zone);
         zone.gotoAndStop("explode");
      }
      else if(level == 23 or level == 102)
      {
         if(zone._xscale > 0)
         {
            var loc5 = 70;
         }
         else
         {
            loc5 = -70;
         }
         f_FX(zone.x,zone.y,int(zone.y + 1),"big_splash",loc5,70);
         zone.fp_StandAnim(zone);
      }
      else
      {
         zone.bounces = zone.bounces + 1;
         if(zone.bounces == 1)
         {
            if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
            {
               f_FX(zone.x,zone.y + 10,int(zone.y) + 1,level_dust,zone._xscale,100);
            }
            if(!zone.human and zone.helmet != 12)
            {
               if(zone.speed_toss_y > 40)
               {
                  f_Damage(zone,7,DMG_MELEE);
               }
               else if(zone.speed_toss_x > 15)
               {
                  f_Damage(zone,7,DMG_MELEE);
               }
            }
         }
         if(zone.roller and zone.speed_toss_x > 10 and !zone.beefy)
         {
            zone.speed_toss_x += 3;
            s_Ground6.start(0,0);
            zone.nohit = true;
            zone.bounces = 0;
            if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
            {
               f_FX(zone.x,zone.y + 10,int(zone.y) + 1,level_dust,zone._xscale,100);
            }
            zone.gotoAndStop("roller");
         }
         else if(zone.speed_toss_y > 10)
         {
            if(zone.speed_toss_y > 40)
            {
               s_Ground3.start(0,0);
               f_ScreenShake(0.2,8,zone.hitby);
               if(zone.n_groundtype >= 300 and zone.n_groundtype <= 302)
               {
                  var loc2 = f_FX(zone._x,zone._y,int(zone._y + 1),"splash",100,100);
                  loc2.body.gotoAndPlay("s3");
                  f_ColorSwap(loc2,water_default);
               }
               else
               {
                  f_FX(zone.x,zone.y,zone.y - 1,level_shockwave,zone._xscale,100);
               }
            }
            else if(zone.speed_toss_y > 20)
            {
               if(zone.n_groundtype >= 300 and zone.n_groundtype <= 302)
               {
                  loc2 = f_FX(zone._x,zone._y,int(zone._y + 1),"splash",100,100);
                  loc2.body.gotoAndPlay("s3");
                  f_ColorSwap(loc2,water_default);
               }
               s_Ground4.start(0,0);
            }
            else
            {
               if(zone.n_groundtype >= 300 and zone.n_groundtype <= 302)
               {
                  loc2 = f_FX(zone._x,zone._y,int(zone._y + 1),"splash",100,100);
                  loc2.body.gotoAndPlay("s3");
                  f_ColorSwap(loc2,water_default);
               }
               s_Ground5.start(0,0);
            }
            zone.speed_toss_y = int(zone.speed_toss_y * -0.35);
            if(zone.bounces % 2 == 0)
            {
               var loc3 = zone.body.body._rotation;
               zone.gotoAndStop("bounce2");
               zone.body.body._rotation = loc3;
            }
            else
            {
               loc3 = zone.body.body._rotation;
               zone.gotoAndStop("bounce1");
               zone.body.body._rotation = loc3;
            }
         }
         else
         {
            s_Ground6.start(0,0);
            zone.nohit = true;
            zone.toss_clock = 0;
            zone.current_weight = zone.weight;
            zone.bounces = 0;
            if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
            {
               f_FX(zone.x,zone.y + 10,int(zone.y) + 1,level_dust,zone._xscale,100);
            }
            zone.missilemode = false;
            zone.onground = true;
            if(zone.n_groundtype >= 300 and zone.n_groundtype <= 302)
            {
               loc2 = f_FX(zone._x,zone._y,int(zone._y + 1),"splash",100,100);
               loc2.body.gotoAndPlay("s3");
               f_ColorSwap(loc2,water_default);
            }
            zone.gotoAndStop("hitground1");
         }
      }
   }
   else
   {
      if(zone.health > 0)
      {
         if(zone.bounces > 0)
         {
            if(zone.body_y > -10)
            {
               var loc4 = zone.jumping;
               zone.jumping = false;
               if(f_Jump(zone))
               {
                  zone.restore_anim = "";
                  f_FX(zone.x,zone.y,int(zone.y + 1),"impact_block",100,100);
                  s_Swing4.start(0,0);
               }
               else
               {
                  zone.jumping = loc4;
               }
            }
         }
      }
      f_ShadowSize(zone);
   }
}
function f_KidHitKids(zone)
{
   var loc3 = undefined;
   var loc1 = undefined;
   if(zone.speed_toss_y > 40 or zone.speed_toss_x >= 12)
   {
      if(zone.body_y > -100)
      {
         var loc4 = false;
         loc3 = 1;
         while(loc3 <= active_enemies)
         {
            loc1 = enemyArrayOb["e" + int(loc3)];
            if(!loc1.nohit and loc1 != zone and loc1.alive and loc1.invincible_timer <= 0)
            {
               if(Math.abs(loc1.y - zone.y) < 15)
               {
                  if(Math.abs(loc1.x - zone.x) < loc1.w / 2)
                  {
                     if(!loc1.tossable or !loc1.humanoid)
                     {
                        f_Damage(zone,2,DMG_MELEE);
                        f_Damage(loc1,2,DMG_MELEE);
                        if(zone._xscale < 0)
                        {
                           f_MoveCharH(zone,loc1.x - loc1.w / 2 - zone.x,0);
                        }
                        else
                        {
                           f_MoveCharH(zone,loc1.x + loc1.w / 2 - zone.x,0);
                        }
                        zone.speed_toss_x *= 0.5;
                        f_FlipChar(zone);
                        loc4 = true;
                     }
                     else
                     {
                        f_Damage(zone,1,DMG_MELEE);
                        f_Damage(loc1,2,DMG_MELEE,DMGFLAG_JUGGLE,zone.speed_toss_x * 0.75,- (random(10) + 10));
                        loc4 = true;
                        f_FlipSame(loc1,zone);
                        if(!loc1.beefy)
                        {
                           loc1.body_y = -50;
                        }
                     }
                  }
               }
            }
            loc3 = loc3 + 1;
         }
         if(zone.missilemode)
         {
            loc3 = 1;
            while(loc3 <= active_players)
            {
               loc1 = playerArrayOb["p_pt" + int(loc3)];
               if(!loc1.nohit and loc1 != zone and loc1.alive)
               {
                  if(Math.abs(loc1.y - zone.y) < 15)
                  {
                     if(Math.abs(loc1.x - zone.x) < 40)
                     {
                        if(loc1.tossable)
                        {
                           f_Damage(zone,1,DMG_MELEE);
                           f_Damage(loc1,2,DMG_MELEE,DMGFLAG_JUGGLE,zone.speed_toss_x * 0.75,- (random(10) + 10));
                           loc4 = true;
                           f_FlipSame(loc1,zone);
                           if(!loc1.beefy)
                           {
                              loc1.body_y = -50;
                           }
                        }
                     }
                  }
               }
               loc3 = loc3 + 1;
            }
         }
         if(loc4)
         {
            f_PunchSound();
            f_FX(zone.x,zone.body_y + zone.y,int(zone.y) + 15,"impact1",100,100);
         }
      }
   }
}
function f_AutoJump(zone)
{
   f_MoveCharH(zone,zone.speed_toss_x,0);
   zone.body_y += zone.speed_jump;
   zone.body._y = zone.body_y + zone.body_table_y;
   zone.speed_jump += zone.gravity;
   if(zone.body_y >= 0)
   {
      zone.body_y = 0;
      zone.body._y = zone.body_y + zone.body_table_y;
      zone.shadow_pt._xscale = 100;
      zone.shadow_pt._yscale = 100;
      zone.gotoAndStop("land");
   }
   else
   {
      f_ShadowSize(zone);
      if(zone.magic_jump)
      {
         if(zone.speed_jump - gravity <= 0 and zone.speed_jump > 0)
         {
            zone.magic_jump = false;
            zone.fp_MagicMove = f_MagicBulletDown;
            zone.gotoAndStop("magic_air_down");
            return undefined;
         }
      }
      if(!zone.npc and zone.prey.mount_type < 1)
      {
         if(Math.abs(zone.y - zone.prey.y) <= 25)
         {
            if(Math.abs(zone.x - zone.prey.x) < 100 or zone.archer)
            {
               if(zone.archer)
               {
                  if(zone.body_y - zone.speed_jump > zone.prey.body_y - 25 and zone.body_y <= zone.prey.body_y - 25)
                  {
                     zone.fp_Ranged(zone);
                  }
               }
               else if(zone.body_y - zone.speed_jump <= zone.prey.body_y - 60 and zone.body_y > zone.prey.body_y - 60)
               {
                  zone.punching = true;
                  zone.speed_jump = 1;
                  s_Swing4.start(0,0);
                  zone.punch_group = 11;
                  if(random(2) == 1)
                  {
                     zone.punch_num = 2;
                     zone.gotoAndStop("punch11_2");
                  }
                  else
                  {
                     zone.punch_num = 1;
                     zone.gotoAndStop("punch11_1");
                  }
               }
            }
         }
      }
   }
}
function f_AutoJumpInit(zone)
{
   if(!zone.beefy)
   {
      if(zone.horse)
      {
         zone.horse.gotoAndStop("wait");
         zone.horse = undefined;
      }
      zone.jumping = true;
      zone.gotoAndStop("autojump");
   }
}
function f_FX(x, y, u_depth, n_type, u_xscale, u_yscale)
{
   var loc1 = undefined;
   do
   {
      loc1 = loader.game.game["fx" + int(current_fx)];
      current_fx++;
      if(current_fx > total_fx)
      {
         current_fx = 1;
      }
   }
   while(loc1.shadow_pt.active == true);
   
   if(loc1)
   {
      loc1.shadow_pt = undefined;
      loc1.x = x;
      loc1.y = y;
      loc1._x = x;
      loc1._y = y;
      loc1.h = 0;
      loc1.owner = undefined;
      loc1.speed_z = 0;
      loc1.damage_type = DMG_MELEE;
      loc1.magic_type = undefined;
      loc1.splashattack = false;
      loc1.unblockable = false;
      loc1.hit_function = undefined;
      loc1.trail_function = undefined;
      loc1.victim = undefined;
      loc1.attack_pow = undefined;
      loc1.projectile_type = undefined;
      loc1.n_groundtype = 0;
      loc1.nospin = false;
      loc1._xscale = u_xscale;
      loc1._yscale = u_yscale;
      f_Depth(loc1,u_depth);
      f_ColorSwap(loc1,color_default);
      loc1.gotoAndStop("remove");
      loc1.gotoAndStop(n_type);
      HiFps_ResetRecursive(loc1);
   }
   return loc1;
}
function f_ExtraFX(x, y, u_depth, n_type, u_xscale, u_yscale)
{
   var loc1 = loader.game.game["fx" + int(extra_fx_current)];
   if(loc1)
   {
      loc1.x = x;
      loc1.y = y;
      loc1._x = x;
      loc1._y = y;
      loc1._xscale = u_xscale;
      loc1._yscale = u_yscale;
      f_Depth(loc1,u_depth);
      f_ColorSwap(loc1,color_default);
      loc1.gotoAndStop("remove");
      loc1.gotoAndStop(n_type);
      HiFps_ResetRecursive(loc1);
      extra_fx_current++;
   }
   return loc1;
}
function f_CheckUppercut(zone)
{
   return undefined;
}
function f_EnemyEndHit(zone)
{
   zone.stunned = false;
   zone.fp_StandAnim(zone);
   zone.body._y = zone.body_y + zone.body_table_y;
}
function f_EndZap(zone)
{
   if(zone.zapping)
   {
      zone.body.gotoAndPlay(1);
   }
   else if(zone.tossable)
   {
      var loc2 = f_FX(u_temp.x,u_temp.y + u_temp.body._y,u_temp.y + 5,"lightning_strike",100,100);
      if(u_temp._xscale > 0)
      {
         f_FlipChar(loc2);
      }
      u_temp.smoking_timer = 20;
      f_ColorSwap(u_temp,color_dark);
      u_temp.speed_toss_y = -6;
      u_temp.speed_toss_x = 10;
      f_CallJuggle1(u_temp);
   }
   else
   {
      u_zone.fp_StandAnim(zone);
   }
}
function f_LightningLength(zone)
{
   if(zone.lightning_timer % 2 == 0 or zone.lightning_timer == 9)
   {
      var loc6 = zone.magic_chain;
      if(loc6 > 5)
      {
         loc6 = 5;
      }
      var loc5 = 50 + loc6 / 5 * 300;
      var loc4 = loc5;
      var loc2 = f_FX(zone.x,zone.y,zone.y,"inert",100,100);
      loc2.attack_pow = zone.magic_sustain_pow;
      loc2.projectile_type = 3;
      loc2.damage_type = _root.DMG_ELEC;
      loc2.hit_function = f_ProjectileHitGeneral;
      loc2.arrowhit_function = undefined;
      if(zone._xscale > 0)
      {
         loc2.speed_x = loc4 + 70;
         f_ProjectileMove(loc2,loc2.speed_x);
         loc4 = loc2.x - zone.x - 40;
      }
      else
      {
         loc2.speed_x = - loc4 - 70;
         loc2._xscale *= -1;
         f_ProjectileMove(loc2,loc2.speed_x);
         loc4 = zone.x - loc2.x - 40;
      }
      if(loc4 < loc5)
      {
         loc2.gotoAndStop("impact2");
         var loc7 = 60 + random(20);
         loc2.fx._xscale = loc7;
         loc2.fx._yscale = loc7;
         loc2.fx._y = - (30 + random(20));
      }
      else
      {
         if(loc4 > loc5)
         {
            loc4 = loc5;
         }
         loc2.gotoAndStop("remove");
      }
      zone.body.hit_range._xscale = 100 * (loc4 / 290);
   }
}
function f_LightningHit(zone)
{
   if(zone._xscale > 0)
   {
      var loc8 = zone.x;
      var loc7 = zone.x + zone.body.hit_range._width;
   }
   else
   {
      loc7 = zone.x;
      loc8 = zone.x - zone.body.hit_range._width;
   }
   var loc6 = zone.y + zone.body._y + zone.body.hit_range._y;
   var loc4 = false;
   var loc2 = loader.game.game.gate;
   if(loc2)
   {
      if(loc2.active)
      {
         var loc9 = loc2.hitzone;
         if(zone.y <= loc2.zone.y + loc2.zone.h)
         {
            if(zone.y >= loc2.zone.y - loc2.zone.h)
            {
               if(zone.y + zone.body._y <= loc9.y + loc9.h)
               {
                  if(zone.y + zone.body._y >= loc9.y - loc9.h)
                  {
                     if(loc2.x > loc8 and loc2.x < loc7)
                     {
                        if(zone.lightning_timer % 5 == 0)
                        {
                           loc4 = true;
                        }
                     }
                     if(loc4)
                     {
                        loc2.arrow_pt = zone;
                        loc2.hitleft = speed > 0;
                        loc2.hitby = zone.owner;
                        loc2.hitbydamage = zone.attack_pow;
                        if(loc2.punch)
                        {
                           loc2.fx_x = zone.x;
                           loc2.fx_y = zone.y + zone.body._y;
                           loc2.fx_body_y = zone.body._y;
                           if(loc2.uniquehit)
                           {
                              loc2.fx_x = zone.x;
                              loc2.fx_y = zone.y + zone.body._y;
                           }
                           if(!loc2.fp_UniqueHit(loc2,zone.punch_pow_low,zone.attack_type))
                           {
                              if(!loc2.no_wall_damage)
                              {
                                 loc2.punch_function(loc2);
                                 f_Damage(loc2,zone.attack_pow,zone.damage_type);
                              }
                           }
                        }
                        zone.collide = loc2;
                     }
                  }
               }
            }
         }
      }
   }
   var loc10 = undefined;
   var loc5 = 1;
   while(loc5 <= active_enemies)
   {
      loc2 = enemyArrayOb["e" + int(loc5)];
      if(loc2.alive)
      {
         loc4 = false;
         if(Math.abs(loc2.y - zone.y) < 15)
         {
            bod_y = loc2.y + loc2.body_y;
            if(bod_y >= loc6 - 10)
            {
               if(bod_y - loc2.h < loc6 + 10)
               {
                  if(loc2.x > loc8 and loc2.x < loc7)
                  {
                     if(!loc2.nohit)
                     {
                        loc4 = true;
                        if(zone.lightning_timer % 5 == 0)
                        {
                           loc2.zapping = true;
                           loc2.hitby = zone;
                           if(!loc2.fp_UniqueHit(loc2,zone.magic_sustain_pow,_root.DMG_ELEC))
                           {
                              f_Damage(loc2,zone.magic_sustain_pow,_root.DMG_ELEC);
                           }
                        }
                     }
                  }
               }
            }
         }
         if(!loc4)
         {
            loc2.zapping = false;
         }
      }
      loc5 = loc5 + 1;
   }
   if(friendly_fire)
   {
      loc5 = 1;
      while(loc5 <= active_players)
      {
         loc2 = playerArrayOb["p_pt" + int(loc5)];
         if(loc2.alive and loc2 != zone)
         {
            if(f_TeamCheck(zone,loc2))
            {
               loc4 = false;
               if(Math.abs(loc2.y - zone.y) < 15)
               {
                  bod_y = loc2.y + loc2.body_y;
                  if(bod_y >= loc6 - 10)
                  {
                     if(bod_y - loc2.h < loc6 + 10)
                     {
                        if(loc2.x > loc8 and loc2.x < loc7)
                        {
                           if(!loc2.nohit)
                           {
                              if(zone.lightning_timer % 5 == 0)
                              {
                                 loc2.hitby = zone;
                                 f_Damage(loc2,zone.magic_sustain_pow,DMG_ELEC);
                              }
                           }
                        }
                     }
                  }
               }
               if(!loc4)
               {
                  loc2.zapping = false;
               }
            }
         }
         loc5 = loc5 + 1;
      }
   }
}
function f_LightningRelease(zone)
{
   var loc1 = undefined;
   var loc2 = undefined;
   loc2 = 1;
   while(loc2 <= active_enemies)
   {
      loc1 = enemyArrayOb["e" + int(loc2)];
      if(loc1.zapping)
      {
         loc1.zapping = false;
         if(loc1.tossable)
         {
            if(loc1.x > zone.x and loc1._xscale > 0)
            {
               f_FlipChar(loc1);
            }
            else if(loc1.x < zone.x and loc1._xscale < 0)
            {
               f_FlipChar(loc1);
            }
            loc1.hitby = zone;
            loc1.smoking_timer = 20;
            f_ColorSwap(loc1,color_dark);
            loc1.speed_toss_x = 4;
            loc1.speed_toss_y = -9;
            f_CallJuggle1(loc1);
         }
         else
         {
            loc1.fp_StandAnim(loc1);
         }
      }
      loc2 = loc2 + 1;
   }
   if(friendly_fire)
   {
      loc2 = 1;
      while(loc2 <= active_players)
      {
         loc1 = playerArrayOb["p_pt" + int(loc2)];
         if(f_TeamCheck(zone,loc1))
         {
            if(loc1.zapping)
            {
               loc1.zapping = false;
               if(loc1.tossable)
               {
                  if(loc1.x > zone.x and loc1._xscale > 0)
                  {
                     f_FlipChar(loc1);
                  }
                  else if(loc1.x < zone.x and loc1._xscale < 0)
                  {
                     f_FlipChar(loc1);
                  }
                  loc1.hitby = zone.owner;
                  loc1.smoking_timer = 20;
                  f_ColorSwap(loc1,color_dark);
                  loc1.speed_toss_x = 4;
                  loc1.speed_toss_y = -9;
                  f_CallJuggle1(loc1);
               }
               else
               {
                  loc1.fp_StandAnim(loc1);
               }
            }
         }
         loc2 = loc2 + 1;
      }
   }
}
function f_GroundSlamDust(zone)
{
   if(zone._xscale > 0)
   {
      var loc2 = 100;
   }
   else
   {
      loc2 = -100;
   }
   f_FX(zone.x,zone.y,zone.y + 5,"ground_slam",loc2,100);
}
function f_Thrown(zone)
{
   zone.nohit = false;
   var loc2 = undefined;
   var loc1 = undefined;
   if(Key.isDown(zone.hitby.button_up))
   {
      loc1 = -36;
      loc2 = 6;
   }
   else if(Key.isDown(zone.hitby.button_down))
   {
      loc1 = 70;
      loc2 = 6;
   }
   else
   {
      loc1 = -20;
      loc2 = 12;
   }
   f_Damage(zone,zone.hitby.punch_pow_high,DMG_MELEE,DMGFLAG_JUGGLE,loc2,loc1);
}
function f_ThrownBeefy(zone)
{
   zone.thrown = true;
   zone._xscale *= -1;
   if(zone._xscale < 0)
   {
      f_MoveCharH(zone,100,false);
   }
   else
   {
      f_MoveCharH(zone,-100,false);
   }
   zone.body_y = -100;
   f_Damage(zone,zone.hitby.punch_pow_medium,DMG_MELEE,DMGFLAG_JUGGLE,12,-20);
}
function f_BeefyThrown(zone)
{
   f_FlipChar(zone);
   f_SetXY(zone,zone.throw_source_x,zone.throw_source_y);
   f_MoveCharH(zone,zone.throw_x - zone.x,0);
   zone.nohit = false;
   zone.body_y = -75;
   f_Damage(zone,zone.hitby.punch_pow_medium,DMG_MELEE,DMGFLAG_JUGGLE,27,6);
}
function f_ElementalPunch(zone, magic_type)
{
   if(magic_type == 1)
   {
      s_PoisonCloud.start(0,0);
      var loc3 = "elemental_poison";
   }
   else if(magic_type == 2)
   {
      s_MagicLightning.start(0,0);
      loc3 = "elemental_lightning";
   }
   else if(magic_type == 3)
   {
      s_ShootIce.start(0,0);
      loc3 = "elemental_ice";
   }
   else if(magic_type == 4)
   {
      s_ShootFire.start(0,0);
      loc3 = "elemental_fire";
   }
   else if(magic_type == 12)
   {
      s_ShootFire.start(0,0);
      loc3 = "elemental_fire";
   }
   else if(magic_type == 25)
   {
      s_ShootFire.start(0,0);
      loc3 = "elemental_fire";
   }
   else if(magic_type == 27)
   {
      s_ShootIce.start(0,0);
      loc3 = "elemental_ice";
   }
   if(zone._xscale > 0)
   {
      var loc4 = 100;
   }
   else
   {
      loc4 = -100;
   }
   f_FX(zone.x,zone.y + zone.body_y,zone.y + 5,loc3,loc4,100);
}
function f_MeleeImpactSound(zone)
{
   if(zone.hit_impact)
   {
      var loc3 = zone.punch_group;
      var loc1 = zone.punch_num;
      switch(loc3)
      {
         case 1:
            if(loc1 >= 1 and loc1 <= 3)
            {
               f_SwordClang();
            }
            else if(loc1 == 4)
            {
               f_HardPunchSound();
            }
            break;
         case 2:
            if(loc1 == 1 or loc1 == 2 or loc1 == 3)
            {
               f_HardPunchSound();
            }
            else if(loc1 == 20 or loc1 == 21 or loc1 == 22)
            {
               s_Smack1.start(0,0);
            }
            break;
         case 3:
         case 6:
            f_HardPunchSound();
            break;
         case 200:
         case 201:
            f_PunchSound();
            break;
         default:
            f_PunchSound();
      }
      if(zone.jumping)
      {
         if(loc1 <= 3)
         {
            if(!zone.spinning)
            {
               zone.jump_attack = true;
               if(loc3 == 12)
               {
                  if(loc1 == 1)
                  {
                     zone.speed_jump = -15;
                  }
               }
               else
               {
                  f_SetFloat(zone,7);
               }
            }
         }
      }
      if(y1 > zone.hit_y)
      {
         zone.hit_y = y1;
      }
   }
   else if(zone.punch_num >= 2 and zone.punch_group < 3)
   {
      zone.punch_num = 0;
   }
}
function f_FlipHit(zone, u_temp)
{
   if(zone.x < u_temp.x and u_temp._xscale > 0)
   {
      f_FlipChar(u_temp);
   }
   else if(zone.x > u_temp.x and u_temp._xscale < 0)
   {
      f_FlipChar(u_temp);
   }
}
function f_ExtremeDeath1(u_temp)
{
   f_MakeBodyPart(u_temp);
   if(gore)
   {
      u_temp.helmet = 200;
      u_temp.face_hit1 = 2;
      u_temp.face_hit2 = 2;
   }
   u_temp.health = 0;
   if(u_temp.human)
   {
      u_temp.hud_pt.stats.health.gotoAndStop(101);
   }
   u_temp.speed_toss_y = - (10 + random(3));
   u_temp.speed_toss_x = 12 + random(5);
   f_CallJuggle1(u_temp);
}
function f_HumanoidCheckYSpace(u_temp, y1)
{
   return Math.abs(u_temp.y - y1) <= 17;
}
function f_ObjectCheckYSpace(u_temp, y1)
{
   if(y1 <= u_temp.zone.y + u_temp.zone.h)
   {
      if(y1 >= u_temp.zone.y - u_temp.zone.h)
      {
         return true;
      }
   }
   return false;
}
function f_MeleeCheckHit(zone, u_temp, x1, y1, x2, y2, top, bottom, left, right)
{
   if(zone.splashattack)
   {
      if(u_temp.toss_clock > 0)
      {
         return undefined;
      }
   }
   var loc19 = undefined;
   var loc9 = undefined;
   var loc6 = undefined;
   var loc7 = undefined;
   var loc16 = false;
   var loc8 = undefined;
   var loc4 = undefined;
   var loc15 = undefined;
   var loc5 = undefined;
   var loc10 = undefined;
   var loc14 = undefined;
   if(u_temp and u_temp.alive)
   {
      if(u_temp.fp_CheckYSpace(u_temp,y1))
      {
         if(top <= u_temp.body_y + u_temp._y)
         {
            if(bottom >= u_temp.body_y + u_temp._y - u_temp.h)
            {
               loc19 = u_temp.x + u_temp.zone._x * (u_temp._xscale / 100);
               if(loc19 + u_temp.w > left and loc19 - u_temp.w < right or zone.stomping and Math.abs(u_temp.x - zone.x) < 50)
               {
                  if((!u_temp.nohit or zone.hitnohit or zone.stomping and u_temp.onground) and !u_temp.jumping)
                  {
                     zone.hit_impact = true;
                     sleep = false;
                     u_temp.hitby = zone;
                     u_temp.hitbydamage = zone.attack_pow;
                     zone.hit_x = u_temp.x;
                     zone.hit_y = u_temp.y;
                     loc9 = zone.hit_y + 2;
                     if(zone.x < u_temp.x and right < u_temp.x)
                     {
                        loc6 = right;
                     }
                     else if(zone.x > u_temp.x and left > u_temp.x)
                     {
                        loc6 = left;
                     }
                     else
                     {
                        loc6 = u_temp.x;
                     }
                     loc6 = loc6 - 10 + random(20);
                     loc7 = y2 - 5 + random(10);
                     if(u_temp.uniquehit)
                     {
                        u_temp.fx_x = loc6;
                        u_temp.fx_y = loc7;
                     }
                     if(u_temp.fp_UniqueHit(u_temp,zone.attack_pow,zone.attack_type))
                     {
                        return undefined;
                     }
                     if(u_temp.invincible_timer <= 0)
                     {
                        if(u_temp.frozen and zone.splashattack and zone.attack_type == DMG_ICE)
                        {
                           u_temp.fp_FlipHit(zone.owner,u_temp);
                        }
                        else
                        {
                           u_temp.fp_FlipHit(zone,u_temp);
                        }
                        if(zone.body_y < 0)
                        {
                           if(u_temp.air_block_odds > 0)
                           {
                              if(random(u_temp.air_block_odds) == 0)
                              {
                                 u_temp.walking = false;
                                 u_temp.standing = false;
                                 u_temp.blocking = true;
                                 u_temp.block_timer = 30;
                                 u_temp.gotoAndStop("blocking");
                              }
                           }
                        }
                        else if(u_temp.full_block_odds > 0)
                        {
                           if(random(u_temp.full_block_odds) == 0)
                           {
                              u_temp.walking = false;
                              u_temp.standing = false;
                              u_temp.blocking = true;
                              u_temp.block_timer = 30;
                              u_temp.gotoAndStop("blocking");
                           }
                        }
                        if(u_temp.blocking and !u_temp.frozen and !zone.unblockable and (!zone.splashattack or level == 10))
                        {
                           f_BlockSound();
                           loc16 = true;
                           if(u_temp.humanoid)
                           {
                              u_temp.speed_toss_x = 20;
                              u_temp.gotoAndStop("block2");
                              u_temp.punching = false;
                              u_temp.punched = false;
                              u_temp.body.gotoAndPlay(1);
                           }
                           if(zone.punch_group == 4 or u_temp.block_clock < 6)
                           {
                              if(!zone.beefy and zone.humanoid)
                              {
                                 if(zone.body_y < 0)
                                 {
                                    f_Damage(zone,1,DMG_MELEE,DMGFLAG_JUGGLE,8 + random(4),- (6 + random(6)));
                                 }
                                 else
                                 {
                                    zone.speed_toss_x = 12;
                                    zone.gotoAndStop("blocked");
                                    zone.body.gotoAndPlay(1);
                                 }
                              }
                           }
                        }
                        else
                        {
                           loc8 = zone.punch_group;
                           loc4 = zone.punch_num;
                           switch(loc8)
                           {
                              case 1:
                                 if(loc4 == 1)
                                 {
                                    if(!u_temp.frozen and u_temp.blocks and random(u_temp.block_odds) == 0)
                                    {
                                       f_BlockSound();
                                       loc16 = true;
                                       if(u_temp.humanoid)
                                       {
                                          u_temp.speed_toss_x = 20;
                                          u_temp.punching = false;
                                          u_temp.punched = false;
                                          u_temp.gotoAndStop("block2");
                                          u_temp.body.gotoAndPlay(1);
                                       }
                                    }
                                    else
                                    {
                                       u_temp.damage_chain = u_temp.damage_chain + 1;
                                       if(!u_temp.frozen and u_temp.damage_chain > 2 and !u_temp.human and !u_temp.nofight)
                                       {
                                          u_temp.damage_chain = 0;
                                          u_temp.nohit = true;
                                          u_temp.fp_Jab(u_temp);
                                       }
                                       else if(u_temp.health <= zone.punch_pow_low and u_temp.fp_ExtremeDeath1 and (friendly_fire or !u_temp.human))
                                       {
                                          u_temp.fp_ExtremeDeath1(u_temp);
                                       }
                                       else
                                       {
                                          f_Hit1(u_temp);
                                          f_Damage(u_temp,zone.punch_pow_low,zone.attack_type);
                                          u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                       }
                                    }
                                 }
                                 else if(loc4 == 2)
                                 {
                                    f_Hit2(u_temp);
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type);
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                 }
                                 else if(loc4 == 3)
                                 {
                                    f_Hit3(u_temp);
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type);
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                 }
                                 else if(loc4 == 4)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type,DMGFLAG_JUGGLE,4,-9);
                                 }
                                 break;
                              case 2:
                                 if(loc4 == 1)
                                 {
                                    u_temp.damage_chain = u_temp.damage_chain + 1;
                                    if(!u_temp.frozen and u_temp.damage_chain > 2 and !u_temp.human and !u_temp.nofight)
                                    {
                                       u_temp.damage_chain = 0;
                                       u_temp.nohit = true;
                                       u_temp.fp_Jab(u_temp);
                                    }
                                    else
                                    {
                                       f_Hit1(u_temp);
                                       u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                       f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type);
                                    }
                                 }
                                 else if(loc4 == 2)
                                 {
                                    f_Hit2(u_temp);
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type);
                                 }
                                 else if(loc4 == 3)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type,DMGFLAG_JUGGLE,1,70);
                                 }
                                 break;
                              case 3:
                                 if(loc4 == 1)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,0,- (random(10) + 20));
                                 }
                                 else if(loc4 == 2)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,random(3) + 0,100);
                                 }
                                 break;
                              case 4:
                                 if(loc4 == 1)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,random(6) + 10,-8);
                                 }
                                 else if(loc4 == 2)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,10,-26);
                                 }
                                 else if(loc4 == 3)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,10,-16);
                                 }
                                 else if(loc4 == 4)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_high,zone.attack_type,DMGFLAG_JUGGLE,10,-16);
                                 }
                                 break;
                              case 5:
                                 if(loc4 == 1)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type,DMGFLAG_STUN);
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                 }
                                 else if(loc4 == 2)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type,DMGFLAG_JUGGLE,random(2),- (16 + random(5)));
                                 }
                                 break;
                              case 6:
                                 if(loc4 == 1)
                                 {
                                    loc15 = zone.magic_type;
                                    if(zone.magic_type == 1)
                                    {
                                       f_Hit1(u_temp);
                                       u_temp.poison_owner = zone;
                                    }
                                    else if(zone.magic_type == 4 or zone.magic_type == 12 or zone.magic_type == 25)
                                    {
                                       f_Hit1(u_temp);
                                       u_temp.fire_owner = zone;
                                       loc15 = DMG_FIRE;
                                    }
                                    else if(zone.magic_type == 27)
                                    {
                                       loc15 = DMG_ICE;
                                    }
                                    f_Damage(u_temp,zone.punch_pow_low + zone.magic_pow,loc15);
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                 }
                                 else if(loc4 == 3)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_STUN);
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                 }
                                 break;
                              case 7:
                                 if(loc4 == 1)
                                 {
                                    f_Damage(u_temp,zone.shield_pow,zone.attack_type,DMGFLAG_STUN);
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                 }
                                 else if(loc4 == 2)
                                 {
                                    f_Hit2(u_temp);
                                    f_Damage(u_temp,zone.shield_pow,zone.attack_type);
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                 }
                                 else if(loc4 == 3)
                                 {
                                    f_Damage(u_temp,zone.shield_pow + 1,zone.attack_type,DMGFLAG_JUGGLE,random(6) + 12,- (random(3) + 4));
                                 }
                                 break;
                              case 11:
                                 f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,random(2),- (18 + random(3)));
                                 break;
                              case 12:
                                 if(loc4 == 1)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,random(4),60);
                                 }
                                 else
                                 {
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,random(2),- (10 + random(4)));
                                 }
                                 break;
                              case 20:
                                 if(u_temp.health < 5 and u_temp.fp_ExtremeDeath1 and (friendly_fire or !u_temp.human))
                                 {
                                    u_temp.fp_ExtremeDeath1(u_temp);
                                 }
                                 else if(loc4 == 2)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,5 + random(3),- (5 + random(3)));
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                 }
                                 else
                                 {
                                    f_Hit1(u_temp);
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type);
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                 }
                                 break;
                              case 30:
                                 f_Damage(u_temp,1,zone.attack_type,DMGFLAG_JUGGLE,random(2),- (18 + random(3)));
                                 break;
                              case 200:
                              case 201:
                                 if(loc4 == 1)
                                 {
                                    if(!u_temp.frozen and u_temp.damage_chain > 2 and !u_temp.human and !u_temp.nofight)
                                    {
                                       u_temp.damage_chain = 0;
                                       u_temp.nohit = true;
                                       u_temp.fp_Jab(u_temp);
                                    }
                                    else
                                    {
                                       u_temp.damage_chain = u_temp.damage_chain + 1;
                                       f_Hit1(u_temp);
                                       f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type);
                                       u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                    }
                                 }
                                 else if(loc4 == 2)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type,DMGFLAG_JUGGLE,2,-10);
                                 }
                                 else if(loc4 == 3)
                                 {
                                    f_Hit2(u_temp);
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type);
                                    u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                                 }
                                 else if(loc4 == 4)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type,DMGFLAG_JUGGLE,1,70);
                                 }
                                 break;
                              case 300:
                                 f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type,DMGFLAG_JUGGLE,zone.force_x,zone.force_y);
                                 if(zone.fp_SpecialEvent)
                                 {
                                    zone.fp_SpecialEvent(u_temp);
                                 }
                                 if(zone.impact_type == 4)
                                 {
                                    loc5 = 70 + random(30);
                                    _root.f_FX(u_temp.x,u_temp.y + u_temp.body_y,u_temp.y + 10,"impact4",loc5,loc5);
                                 }
                                 else if(zone.impact_type == 1)
                                 {
                                    loc5 = 80 + random(20);
                                    _root.f_FX(u_temp.x,u_temp.y + u_temp.body_y - 30,u_temp.y + 10,"impact1",loc5,loc5);
                                 }
                                 break;
                              case 301:
                                 f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type,DMGFLAG_JUGGLE | DMGFLAG_BLOODY,zone.force_x,zone.force_y);
                                 if(zone.impact_type == 4)
                                 {
                                    loc5 = 70 + random(30);
                                    _root.f_FX(u_temp.x,u_temp.y + u_temp.body_y,u_temp.y + 10,"impact4",loc5,loc5);
                                 }
                                 else if(zone.impact_type == 1)
                                 {
                                    loc5 = 80 + random(20);
                                    _root.f_FX(u_temp.x,u_temp.y + u_temp.body_y - 30,u_temp.y + 10,"impact1",loc5,loc5);
                                 }
                                 break;
                              case 400:
                                 f_Damage(u_temp,zone.attack_pow,zone.attack_type,DMGFLAG_JUGGLE,zone.force_x,zone.force_y);
                                 break;
                              case 500:
                                 f_Damage(u_temp,zone.attack_pow,zone.attack_type,DMGFLAG_SPARKLE_EFFECT | DMGFLAG_STUN,zone.force_x,zone.force_y);
                                 break;
                              default:
                                 zone.punch_group = 1;
                                 zone.punch_num = 1;
                                 f_Hit1(u_temp);
                                 f_Damage(u_temp,zone.punch_pow_low,zone.attack_type);
                                 u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
                           }
                        }
                     }
                     if(loc7 < u_temp.y + u_temp.body_y - u_temp.h)
                     {
                        loc7 = u_temp.y + u_temp.body_y - u_temp.h;
                     }
                     if(!loc16)
                     {
                        loc10 = f_FX(loc6,loc7 + 5,loc9,"impact1",100,100);
                        if(u_temp.humanoid)
                        {
                           f_BloodBathShrapnel(loc6,u_temp.y,loc7);
                        }
                     }
                     loc10.owner = zone;
                  }
                  else if(u_temp.body_y < 0 and zone.invincible_timer <= 0)
                  {
                     if(top <= u_temp.body_y + u_temp._y)
                     {
                        if(bottom >= u_temp.body_y + u_temp._y - u_temp.h)
                        {
                           if(u_temp.uniquehit)
                           {
                              u_temp.fx_x = zone.x;
                              u_temp.fx_y = zone.y + zone.body._y;
                           }
                           if(u_temp.fp_UniqueHit(u_temp,zone.attack_pow,zone.attack_type))
                           {
                              return undefined;
                           }
                           if(u_temp.invincible_timer <= 0)
                           {
                              loc4 = zone.punch_num;
                              loc8 = zone.punch_group;
                              u_temp.hitby = zone;
                              if((loc8 == 200 or loc8 == 201) and loc4 > 1)
                              {
                                 zone.hit_impact = true;
                                 zone.hit_x = u_temp.x;
                                 zone.hit_y = u_temp.y;
                                 loc9 = zone.hit_y + 2;
                                 loc6 = zone.hit_x - 10 + random(20);
                                 loc7 = y2 - 5 + random(10);
                                 if(random(3))
                                 {
                                    loc10 = f_FX(loc6,loc7 + 5,loc9,"impact1",100,100);
                                    loc10.owner = zone;
                                 }
                                 if(x2 > x1 and u_temp._xscale > 0)
                                 {
                                    f_FlipChar(u_temp);
                                 }
                                 else if(x2 < x1 and u_temp._xscale < 0)
                                 {
                                    f_FlipChar(u_temp);
                                 }
                                 if(u_temp.invincible_timer <= 0)
                                 {
                                    if(loc4 == 3)
                                    {
                                       f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type,DMGFLAG_JUGGLE,2,50);
                                    }
                                    else if(loc4 == 2)
                                    {
                                       u_temp.speed_toss_y = -10;
                                       u_temp.speed_toss_x = 2;
                                       f_CallJuggle1(u_temp);
                                    }
                                    else
                                    {
                                       u_temp.spark_timer = 12;
                                       u_temp.spark_owner = zone;
                                       if(zone.y > u_temp.y)
                                       {
                                          loc9 = zone.y + 1;
                                       }
                                       else
                                       {
                                          loc9 = u_temp.y + 1;
                                       }
                                       loc10 = f_FX(loc6,loc7 + 5,loc9,"impact1",200,200);
                                       loc10.owner = zone;
                                       f_Damage(u_temp,zone.punch_pow_medium,zone.attack_type,DMGFLAG_JUGGLE,25,0);
                                    }
                                 }
                              }
                              else if(loc8 == 2 and loc4 == 3)
                              {
                                 zone.hit_impact = true;
                                 zone.hit_x = u_temp.x;
                                 zone.hit_y = u_temp.y;
                                 loc9 = zone.hit_y + 2;
                                 loc6 = zone.hit_x - 10 + random(20);
                                 loc7 = y2 - 5 + random(10);
                                 if(random(3))
                                 {
                                    loc10 = f_FX(loc6,loc7 + 5,loc9,"impact1",100,100);
                                    loc10.owner = zone;
                                 }
                                 if(x2 > x1 and u_temp._xscale > 0)
                                 {
                                    f_FlipChar(u_temp);
                                 }
                                 else if(x2 < x1 and u_temp._xscale < 0)
                                 {
                                    f_FlipChar(u_temp);
                                 }
                                 if(u_temp.invincible_timer <= 0)
                                 {
                                    f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,random(4),60);
                                 }
                              }
                              else if(loc8 == 300)
                              {
                                 zone.hit_impact = true;
                                 var damageFlag = DMGFLAG_JUGGLE;
                                 var forceX = zone.force_x;
                                 var forceY = zone.force_y;

                                 if(zone.impact_type == 4)
                                 {
                                    loc5 = 70 + random(30);
                                    _root.f_FX(u_temp.x,u_temp.y + u_temp.body_y,u_temp.y + 10,"impact4",loc5,loc5);
                                    if(zone.p_type == 33 && zone.unblockable) { // Reducing cyclops slamdown force when hitting an enemy in the air (yes this is STUPID however it's midnight and i'm not writing real code)
                                       forceX = 0;
                                       forceY = 0;
                                    }
                                 }
                                 else if(zone.impact_type == 1)
                                 {
                                    loc5 = 80 + random(20);
                                    _root.f_FX(u_temp.x,u_temp.y + u_temp.body_y - 30,u_temp.y + 10,"impact1",loc5,loc5);
                                 }
                                 if(zone.fp_SpecialEvent)
                                 {
                                    zone.fp_SpecialEvent(u_temp);
                                 }
                                 f_Damage(u_temp, zone.punch_pow_medium, zone.attack_type, damageFlag, forceX, forceY);
                              }
                              else if(loc8 == 400) 
                              {
                                 zone.hit_impact = true;
                                 f_Damage(u_temp,zone.attack_pow,zone.attack_type,DMGFLAG_JUGGLE,zone.force_x,zone.force_y);
                              }
                              else if(loc4 < 3 or loc8 == 4)
                              {
                                 zone.hit_impact = true;
                                 zone.hit_x = u_temp.x;
                                 zone.hit_y = u_temp.y;
                                 loc9 = zone.hit_y + 2;
                                 loc6 = zone.hit_x - 10 + random(20);
                                 loc7 = y2 - 5 + random(10);
                                 if(random(3))
                                 {
                                    loc10 = f_FX(loc6,loc7 + 5,loc9,"impact1",100,100);
                                    loc10.owner = zone;
                                 }
                                 if(x2 > x1 and u_temp._xscale > 0)
                                 {
                                    f_FlipChar(u_temp);
                                 }
                                 else if(x2 < x1 and u_temp._xscale < 0)
                                 {
                                    f_FlipChar(u_temp);
                                 }
                                 if(u_temp.invincible_timer <= 0)
                                 {
                                    if(loc8 == 3)
                                    {
                                       var loc13 = 0;
                                       var loc18 = 0;
                                       if(loc4 == 1)
                                       {
                                          loc13 = - (random(10) + 20);
                                       }
                                       else
                                       {
                                          loc13 = 60;
                                          loc18 = random(4) + 0;
                                       }
                                       f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,loc18,loc13);
                                    }
                                    else if(loc8 == 4)
                                    {
                                       if(loc4 == 2)
                                       {
                                          u_temp.speed_toss_y = - (random(10) + 20);
                                          u_temp.speed_toss_x = random(6) + 7;
                                          f_CallJuggle1(u_temp);
                                       }
                                       else if(loc4 == 3)
                                       {
                                          u_temp.speed_toss_y = -16;
                                          u_temp.speed_toss_x = 10;
                                          f_CallJuggle1(u_temp);
                                       }
                                    }
                                    else if(loc8 == 12)
                                    {
                                       if(loc4 == 1)
                                       {
                                          f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,random(4),60);
                                       }
                                       else
                                       {
                                          f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,random(2),- (10 + random(4)));
                                       }
                                    }
                                    else if(loc8 == 30)
                                    {
                                       loc14 = int(zone.punch_pow_medium * 0.2);
                                       if(loc14 < 1)
                                       {
                                          loc14 = 1;
                                       }
                                       f_Damage(u_temp,loc14,zone.attack_type,DMGFLAG_JUGGLE,random(4) + 6,- (18 + random(3)));
                                    }
                                    else
                                    {
                                       f_Damage(u_temp,zone.punch_pow_low,zone.attack_type,DMGFLAG_JUGGLE,12,-9);
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
function f_PunchHit(zone)
{
   var loc17 = zone.x;
   var loc6 = zone.y;
   u_point.x = 0;
   u_point.y = 0;
   var loc19 = zone.body.punch_pt;
   if(zone.body.frog_tongue)
   {
      loc19 = zone.body.body.punch_pt;
   }
   f_LocalToGame(loc19,u_point);
   var loc16 = u_point.x;
   var loc11 = u_point.y;
   var loc21 = loc19._width / 2 * (Math.abs(zone._xscale) / 100);
   var loc20 = loc19._height / 2 * (Math.abs(zone._yscale) / 100);
   var loc12 = loc11 - loc20;
   var loc7 = loc11 + loc20;
   var loc9 = loc16 - loc21;
   var loc8 = loc16 + loc21;
   zone.hit_impact = false;
   zone.hit_x = loc16;
   zone.hit_y = loc11;
   var loc22 = false;
   if(zone.temp_attack_type)
   {
      zone.attack_type = zone.temp_attack_type;
      zone.temp_attack_type = undefined;
   }
   else if(!zone.attack_type)
   {
      zone.attack_type = DMG_MELEE;
   }
   if(!zone.attack_pow)
   {
      zone.attack_pow = zone.punch_pow_low;
   }
   var loc1 = undefined;
   var loc3 = undefined;
   var loc4 = undefined;
   if(friendly_fire)
   {
      loc4 = 1;
      while(loc4 <= active_players)
      {
         loc1 = playerArrayOb["p_pt" + int(loc4)];
         if(zone.human)
         {
            loc3 = zone;
         }
         else if(zone.rider)
         {
            loc3 = zone.rider;
         }
         else
         {
            loc3 = zone.owner;
         }
         if(loc1 != loc3)
         {
            if(f_TeamCheck(loc3,loc1))
            {
               f_MeleeCheckHit(zone,loc1,loc17,loc6,loc16,loc11,loc12,loc7,loc9,loc8);
            }
         }
         loc4 = loc4 + 1;
      }
   }
   loc4 = 1;
   while(loc4 <= active_enemies)
   {
      loc1 = enemyArrayOb["e" + int(loc4)];
      f_MeleeCheckHit(zone,loc1,loc17,loc6,loc16,loc11,loc12,loc7,loc9,loc8);
      loc4 = loc4 + 1;
   }
   if(zone.hit_impact)
   {
      loc22 = true;
   }
   var loc10 = undefined;
   var loc18 = undefined;
   var loc13 = undefined;
   var loc15 = undefined;
   var loc5 = undefined;
   var loc14 = undefined;
   loc4 = 1;
   while(loc4 <= object_index)
   {
      loc1 = loader.game.game["object" + int(loc4)];
      if(loc1.punch and loc1.active)
      {
         loc3 = loc1.hitzone;
         if(loc1.fp_CheckYSpace(loc1,loc6) or loc6 > loc1.y and loc6 < loc3.y + loc3.h)
         {
            if(loc12 <= loc3.y + loc3.h)
            {
               if(loc7 >= loc3.y - loc3.h)
               {
                  loc10 = 0;
                  if(loc1.angle)
                  {
                     loc18 = (loc1.zone.y - zone.y) * loc1.angle;
                     loc10 = loc18 * g_sin30;
                  }
                  if(loc3.x - loc10 + loc3.w > loc9 and loc3.x - loc10 - loc3.w < loc8)
                  {
                     if(zone.x < loc1.x)
                     {
                        zone.hit_x = loc3.x - loc3.w / 2;
                     }
                     else
                     {
                        zone.hit_x = loc3.x + loc3.w / 2;
                     }
                     zone.hit_y = loc1.y;
                     loc13 = zone.hit_y + 2;
                     loc15 = zone.hit_x - 10 + random(20);
                     loc5 = loc11 - 5 + random(10);
                     if(loc5 < loc1.y + loc1.body_y - loc1.h)
                     {
                        loc5 = loc1.y + loc1.body_y - loc1.h;
                     }
                     loc1.fx_x = zone.x;
                     loc1.fx_y = zone.y;
                     loc1.fx_body_y = loc5 - zone.y;
                     loc1.hitby = zone;
                     loc1.hitbydamage = zone.attack_pow;
                     zone.hit_impact = true;
                     loc1.punch_function(loc1);
                     if(loc1.blocked)
                     {
                        loc14 = f_FX(loc15,loc5,loc13,"impact_block",100,100);
                     }
                     else
                     {
                        loc14 = f_FX(loc15,loc5,loc13,"impact2",100,100);
                        loc14.owner = zone;
                     }
                  }
               }
            }
         }
      }
      loc4 = loc4 + 1;
   }
   loc4 = 1;
   while(loc4 <= grass_total)
   {
      loc1 = grass["g" + int(loc4)];
      if(!loc1.cut)
      {
         if(Math.abs(zone.y - loc1.y) < 20)
         {
            if(loc7 >= loc1.y - 50)
            {
               if(loc1.x + loc1.w > loc9 and loc1.x - loc1.w < loc8)
               {
                  s_GrassCut.start(0,0);
                  loc1.cut = true;
                  if(loc1.item_type)
                  {
                     f_ItemSpawn(loc1.x,loc1.y,loc1.item_type);
                  }
                  else if(random(3) == 1 or zone.pet.animal_type == 12)
                  {
                     loc3 = random(5) + 2;
                     f_ItemSpawn(loc1.x,loc1.y,loc3);
                  }
                  loc1.gotoAndStop(2);
                  loc4 = grass_total + 1;
               }
            }
         }
      }
      loc4 = loc4 + 1;
   }
   // Hitting full moon boulder
   if(zone.p_type > 31) {
      if(level == 34) {
         loc1 = p_game.boss;
         if(loc1.active) {
            if(Math.abs(zone.y - loc1.y) < 20) {
               if(loc7 >= loc1.y - 50) {
                  if(loc1.x + loc1.w > loc9 and loc1.x - loc1.w < loc8) {
                     loc1.speed_x *= -1.5;
                     loc1.speed_jump = -20;
                     s_RockSmash1.start(0,0);
                     zone.hit_impact = true;
                  }
               }
            }
         }
      }
      // Hitting ripoffs
      var _loc2_ = 1;
      while(_loc2_ <= ripoffs_total)
      {
         u_temp = ripoffs["s" + int(_loc2_)];
         if(u_temp.active and !u_temp.busy)
         {
            if(Math.abs(zone.y - u_temp.ripoff.y) < u_temp.ripoff.h)
            {
               if(Math.abs(zone.x - u_temp.ripoff.x) < u_temp.ripoff.w + loc19._width)
               {
                  u_temp.busy = true;
                  s_BeefyDoorRip.start(0,0);
                  u_temp._y = u_temp.y = zone.y + 1;
                  f_Depth(u_temp,u_temp.y);
                  u_temp.active = false;
                  u_temp.gotoAndPlay("die");
                  break;
               }
            }
         }
         _loc2_ += 1;
      }
   }
   f_MeleeImpactSound(zone);
   zone.attack_type = DMG_MELEE;
   return zone.hit_impact;
}
function f_Turn(zone)
{
   if((Key.isDown(zone.button_left) or Key.isDown(zone.button_walk_left)) and zone._xscale > 0)
   {
      f_FlipChar(zone);
   }
   if((Key.isDown(zone.button_right) or Key.isDown(zone.button_walk_right)) and zone._xscale < 0)
   {
      f_FlipChar(zone);
   }
}
function f_DashDive(zone)
{
   f_PunchHit(zone);
   f_MoveCharH(zone,zone.speed_slam,0);
   if(zone.float_timer > 0)
   {
      zone.float_timer = zone.float_timer - 1;
   }
   else
   {
      zone.body_y += zone.speed_jump;
      zone.speed_jump += zone.gravity;
      if(zone.speed_jump > 32)
      {
         zone.speed_jump = 32;
      }
   }
   if(zone.body_y > 0)
   {
      if(zone.float_timer > 6)
      {
         zone.body_y = -1;
         zone.speed_jump = 0;
      }
      else
      {
         zone.body_y = 0;
         zone.end_attack = true;
         f_SetFloat(zone,0);
      }
   }
   zone.body._y = zone.body_y + zone.body_table_y;
}
function f_SetFloat(zone, timer)
{
   zone.float_timer = timer;
}
function f_Jumping(zone)
{
   if(zone.ladder)
   {
      return undefined;
   }
   if(zone.float_timer > 0)
   {
      zone.float_timer = zone.float_timer - 1;
   }
   else
   {
      var loc2 = undefined;
      zone.body_y += zone.speed_jump;
      if(zone.beefy)
      {
         zone.speed_jump += zone.gravity * 2;
      }
      else if(zone.spinning and zone.speed_jump >= 0)
      {
         zone.speed_jump += zone.gravity * 0.3;
      }
      else
      {
         zone.speed_jump += zone.gravity;
      }
      if(zone.speed_jump > 32)
      {
         zone.speed_jump = 32;
      }
      if(zone.body_y > 0)
      {
         zone.body_y = 0;
         zone.speed_jump = 0;
         zone.jumping = false;
         if(level == 32)
         {
            if(random(2) == 1)
            {
               s_Splash1.start(0,0);
            }
            else
            {
               s_Splash2.start(0,0);
            }
            loc2 = f_FX(zone._x,zone._y,int(zone._y + 1),"temple_splash",50,50);
         }
         else if(zone.n_groundtype >= 300 and zone.n_groundtype <= 302)
         {
            if(random(2) == 1)
            {
               s_Splash1.start(0,0);
            }
            else
            {
               s_Splash2.start(0,0);
            }
            loc2 = f_FX(zone._x,zone._y,int(zone._y + 1),"splash",100,100);
            loc2.body.gotoAndPlay("s3");
            f_ColorSwap(loc2,water_default);
         }
         if((level == 23 or level == 102) and !zone.horse)
         {
            if(zone._xscale > 0)
            {
               var loc3 = 70;
            }
            else
            {
               loc3 = -70;
            }
            f_FX(zone.x,zone.y,int(zone.y + 1),"big_splash",loc3,70);
            zone.fp_StandAnim(zone);
         }
         else
         {
            zone.gotoAndStop("land");
         }
         zone.body._y = zone.body_y + zone.body_table_y;
      }
      zone.body._y = zone.body_y + zone.body_table_y;
   }
   f_ShadowSize(zone);
}
function f_TopSpinInit(zone)
{
   if(zone.combo_unlocks[1] and zone.body_y < -75)
   {
      if(p_game.specialmode < 1 or p_game.specialmode > 3)
      {
         zone.punch_num = 1;
         zone.punch_group = 30;
         zone.spinning = true;
         zone.gotoAndStop("topspin");
      }
   }
}
function f_MagicJump(zone)
{
   var loc2 = f_FX(zone.x,zone.y,zone.y + 1,"generaljump",100,100);
   loc2.magic_type = zone.magic_type;
   loc2.owner = zone;
}
function f_JumpAction(zone)
{
   if(zone.horse)
   {
      if(!zone.horse.chasejump)
      {
         zone.horse.gotoAndStop("wait");
         zone.horse = undefined;
      }
   }
   if(!zone.jumping)
   {
      zone.spinning = false;
      if(!zone.jumping)
      {
         if(zone.dashing)
         {
            zone.dashjump = true;
         }
         else
         {
            zone.dashjump = false;
         }
         zone.jumping = true;
         zone.blocking = false;
         if(zone.magicmode and zone.magic_unlocks[2] and zone.magic_current >= 25)
         {
            zone.inputCooldown = 2;
            f_Magic(zone,-25);
            f_MagicJump(zone);
            if(zone.magic_type == 32)
            {
               zone.wings = 2;
               _root.wings_subframe = 1;
            }
            if(zone.pet.animal_type == 25)
            {
               zone.speed_jump = zone.speed_launch * 1.5;
            }
            else
            {
               zone.speed_jump = zone.speed_launch * 1.4;
            }
         }
         else if(zone.pet.animal_type == 25)
         {
            zone.speed_jump = zone.speed_launch * 1.2;
         }
         else
         {
            zone.speed_jump = zone.speed_launch;
         }
         zone.jump_attack = true;
         if(zone.n_groundtype >= 300 and zone.n_groundtype <= 302)
         {
            s_SplashOut.start(0,0);
            if(level == 32)
            {
               var loc3 = f_FX(zone._x,zone._y,int(zone._y + 1),"temple_splash",30,40);
            }
            else
            {
               loc3 = f_FX(zone._x,zone._y - 5,int(zone._y + 1),"splash",100,100);
               loc3.body.gotoAndPlay("s2");
               f_ColorSwap(loc3,water_default);
            }
         }
         zone.gotoAndStop("jump");
      }
   }
   else
   {
      f_TopSpinInit(zone);
   }
}
function f_Jump(zone)
{
   if(Key.isDown(zone.button_jump))
   {
      if(zone.jumped == false)
      {
         zone.jumped = true;
         f_JumpAction(zone);
         return true;
      }
   }
   else
   {
      zone.jumped = false;
   }
   return false;
}
function f_HurtBlock(zone)
{
   if(Key.isDown(zone.button_shield) and !zone.ladder)
   {
      zone.blocking = true;
   }
   else
   {
      zone.blocking = false;
   }
}
function f_EndBlockHit(zone)
{
   if(Key.isDown(zone.button_shield))
   {
      zone.gotoAndStop("blocking");
      zone.blocking = true;
      zone.body.body.gotoAndPlay("hold");
   }
   else
   {
      zone.fp_StandAnim(zone);
   }
}
function f_Block(zone)
{
   if(!zone.jumping)
   {
      if(Key.isDown(zone.button_shield) and !zone.ladder)
      {
         zone.block_clock = zone.block_clock + 1;
         if(zone.blocked == false)
         {
            zone.blocked = true;
            zone.blocking = true;
            f_DashReset(zone);
            zone.gotoAndStop("blocking");
         }
      }
      else
      {
         if(zone.blocking)
         {
            zone.block_clock = 0;
            zone.blocking = false;
            if(!zone.ladder)
            {
               zone.body.body.gotoAndStop("end");
            }
         }
         zone.blocked = false;
      }
   }
   else
   {
      zone.block_clock = 0;
      zone.blocked = false;
   }
}
function f_BeefyBlock(zone)
{
   if(!zone.jumping)
   {
      if(Key.isDown(zone.button_shield))
      {
         zone.block_clock = zone.block_clock + 1;
         if(zone.blocked == false)
         {
            zone.blocked = true;
            zone.blocking = true;
            f_DashReset(zone);
            zone.gotoAndStop("beefy_blocking");
            return true;
         }
      }
      else
      {
         if(zone.blocking)
         {
            zone.block_clock = 0;
            zone.blocking = false;
            zone.fp_StandAnim(zone);
         }
         zone.blocked = false;
      }
   }
   else
   {
      zone.block_clock = 0;
      zone.blocked = false;
   }
}

function f_CheckMagicShield(zone)
{
   if(Key.isDown(zone.button_shield))
   {
      if(Key.isDown(zone.button_magic))
      {
         f_Magic(zone,-1);
         if(zone.magic_current <= 0)
         {
            zone.gotoAndStop("magicshield_end");
         }
      }
      else
      {
         zone.gotoAndStop("magicshield_end");
      }
   }
   else
   {
      zone.gotoAndStop("magicshield_end");
   }
}
function f_Sheath(zone)
{
   if(!zone.jumping)
   {
      if(Key.isDown(zone.button_sheath))
      {
         if(zone.sheathed == false)
         {
            zone.sheathed = true;
            if(zone.weapon == 2)
            {
               zone.weapon = zone.weapon_equipped;
               zone.sheathing = true;
               zone.gotoAndStop("unsheath");
            }
            else
            {
               zone.weapon_equipped = zone.weapon;
               zone.sheathing = true;
               zone.gotoAndStop("sheath");
            }
         }
      }
      else
      {
         zone.sheathed = false;
      }
   }
}
function f_GotoBeefy(zone)
{
   zone.gotoAndStop("gobeefy");
}
function f_MagicMode(zone)
{
   if(Key.isDown(zone.button_magic))
   {
      if(!zone.pressed_magic)
      {
         zone.pressed_magic = true;
         _root.player_used_magic = true;
      }
      if(!(p_game.specialmode == 1 or p_game.specialmode == 2 or p_game.specialmode == 3 or zone.beefy))
      {
         if(zone.magicmode == false)
         {
            zone.magicmode = true;
            zone.magicclock = 0;
         }
      }
   }
   else
   {
      zone.pressed_magic = false;
      zone.magicmode = false;
   }
}
function f_JumpAttack(zone)
{
   zone.freeze = false;
   f_MagicMode(zone);
   if(zone.jumping)
   {
      if(!zone.freeze)
      {
         f_Walk(zone);
      }
      f_Jumping(zone);
      if(zone.jump_attack or zone.float_timer > 0 or zone.body_y < -100)
      {
         f_Punch(zone);
      }
      else if(Key.isDown(zone.button_jump))
      {
         if(!zone.jumped)
         {
            zone.jumped = true;
            f_TopSpinInit(zone);
         }
      }
   }
   else
   {
      f_CharacterSlide(zone);
      f_Punch(zone);
   }
}
function f_NPCMidJump(zone)
{
   if(zone.jumping)
   {
      f_Jumping(zone);
   }
}
function f_BuzzSaw(zone)
{
   zone.punched = true;
   zone.jumping = true;
   if(zone.hit_impact)
   {
      zone.speed_jump = -16;
   }
   else
   {
      zone.speed_jump = -8;
   }
   if(zone.body_y > -50)
   {
      zone.body_y = -50;
   }
   zone.gotoAndStop("buzzsaw");
}
function f_CheckBuzzSaw(zone)
{
   if(Key.isDown(zone.button_punch1))
   {
      if(zone.punched == false)
      {
         f_BuzzSaw(zone);
      }
   }
   else
   {
      zone.punched = false;
   }
   if(Key.isDown(zone.button_punch2))
   {
      if(zone.punched2 == false)
      {
         zone.punched = true;
         zone.jumping = true;
         zone.speed_jump = -16;
         zone.punch_group = 12;
         zone.punch_num = 1;
         zone.jump_attack = true;
         zone.gotoAndStop("slamdown");
      }
   }
   else
   {
      zone.punched2 = false;
   }
}
function f_EndAttack(zone)
{
   zone.freeze = false;
   if(zone.horse and !zone.horse.uniqueride)
   {
      zone.horse_move = false;
      zone.gotoAndStop(zone.horse.anim_ride);
      zone.body.gotoAndPlay(zone.horse.body._currentframe);
   }
   else if(zone.body_y >= 0 or zone.body_y >= 0)
   {
      zone.body_y = 0;
      zone.body._y = zone.body_y + zone.body_table_y;
      zone.fp_StandAnim(zone);
   }
   else
   {
      if(!zone.jumping)
      {
         zone.hanging = false;
         zone.ladder = undefined;
         zone.jumping = true;
         zone.speed_jump = 10;
      }
      zone.body.stop();
   }
}
function f_EndHang(zone)
{
   zone.body_y = 0;
   zone.body._y = 0;
   zone.jumping = true;
   zone.blocking = false;
   zone.hanging = false;
   zone.busy = false;
   zone.speed_jump = zone.speed_launch / 3;
   zone.jump_attack = true;
   zone.gotoAndStop("jump");
}
function f_AlignBody(zone)
{
   zone.body._y = zone.body_y + zone.body_table_y;
}
function f_PunchInit(zone)
{
   zone.blocking = false;
   zone.blocked = false;
   f_AlignBody(zone);
   zone.jump_attack = false;
}
function f_Grab(zone)
{
   return false;
}
function f_Character(zone)
{
   if(!pause)
   {
      if(!zone.busy)
      {
         f_MagicMode(zone);
         f_Jump(zone);
         f_Block(zone);
         if(zone.p_type != 32 || !zone.blocking) {
            f_Walk(zone);
         }
         if(!zone.hanging)
         {
            if(!zone.ladder)
            {
               if(zone.jumping)
               {
                  f_Jumping(zone);
               }
               else if(zone.blocking)
               {
                  if(zone.walking and level != 23 and level != 102 && zone.p_type != 32)
                  {
                     if(zone.reverse)
                     {
                        zone.body.gotoAndStop("retreat");
                        zone.body._y = zone.body_table_y;
                     }
                     else
                     {
                        zone.body.gotoAndStop("walk");
                        zone.body._y = zone.body_table_y;
                     }
                  }
                  else
                  {
                     zone.body.gotoAndStop("stand");
                     zone.body._y = zone.body_table_y;
                  }
               }
               else if(zone.dashing)
               {
                  zone.dashing_timer = zone.dashing_timer + 1;
                  if(zone.dashing_timer == 1 or zone.dashing_timer % 5 == 0)
                  {
                     var loc3 = (80 + random(20)) / 100;
                     if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
                     {
                        var loc2 = f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,zone._xscale * loc3,100 * loc3);
                        loc2._x += random(10) - 5;
                        loc2._y += random(4) - 2;
                     }
                  }
                  if(zone.pet.animal_type == 3 and zone.truespeed)
                  {
                     f_AnimalRamHit(zone.pet,1);
                  }
                  zone.fp_DashAnim(zone);
                  zone.body._y = zone.body_table_y;
               }
               else
               {
                  zone.dashing_timer = 0;
                  if(zone.walking)
                  {
                     zone.fp_WalkAnim(zone);
                     zone.body._y = zone.body_table_y;
                  }
                  else
                  {
                     zone.fp_StandAnim(zone);
                     zone.body._y = zone.body_table_y;
                  }
               }
            }
         }
         if(!zone.busy)
         {
            f_Punch(zone);
         }
      }
   }
}
function f_CharacterBeefy(zone)
{
   if(!pause)
   {
      if(!zone.busy)
      {
         if(f_BeefyGrapple(zone))
         {
            return undefined;
         }
         f_Jump(zone);
         f_BeefyBlock(zone);
         f_Walk(zone);
         if(!zone.hanging)
         {
            if(!zone.ladder)
            {
               if(zone.jumping)
               {
                  f_Jumping(zone);
               }
               else if(zone.blocking)
               {
                  if(zone.walking)
                  {
                     if(zone.reverse)
                     {
                        zone.body.gotoAndStop("retreat");
                        zone.body._y = zone.body_table_y;
                     }
                     else
                     {
                        zone.body.gotoAndStop("walk");
                        zone.body._y = zone.body_table_y;
                     }
                  }
                  else
                  {
                     zone.body.gotoAndStop("stand");
                     zone.body._y = zone.body_table_y;
                  }
               }
               else if(zone.dashing)
               {
                  zone.dashing_timer = zone.dashing_timer + 1;
                  if(zone.dashing_timer == 1 or zone.dashing_timer % 5 == 0)
                  {
                     if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
                     {
                        var loc3 = (80 + random(20)) / 100;
                        var loc2 = f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,zone._xscale * loc3,100 * loc3);
                        loc2._x += random(10) - 5;
                        loc2._y += random(4) - 2;
                     }
                  }
                  zone.fp_DashAnim(zone);
                  zone.body._y = zone.body_table_y;
               }
               else
               {
                  zone.dashing_timer = 0;
                  if(zone.walking)
                  {
                     zone.fp_WalkAnim(zone);
                     zone.body._y = zone.body_table_y;
                  }
                  else
                  {
                     zone.fp_StandAnim(zone);
                     zone.body._y = zone.body_table_y;
                  }
               }
            }
         }
         if(!zone.busy)
         {
            f_Punch(zone);
         }
         f_CheckHealth(zone);
      }
   }
}
function f_CharacterBeefyCarry(zone)
{
   if(!zone.human)
   {
      if(!zone.hostage or !zone.hostage.captor)
      {
         zone.hostage = undefined;
         zone.fp_Character = f_BeefyEnemyWalk;
         zone.fp_WalkAnim = f_WalkType2;
         zone.fp_StandAnim = f_StandType2;
         zone.throwmove = false;
         return undefined;
      }
   }
   if(!pause)
   {
      if(!zone.busy)
      {
         f_Walk(zone);
         if(zone.jumping)
         {
            f_Jumping(zone);
         }
         else if(zone.blocking)
         {
            if(zone.walking)
            {
               if(zone.reverse)
               {
                  zone.body.gotoAndStop("retreat");
                  zone.body._y = zone.body_table_y;
               }
               else
               {
                  zone.body.gotoAndStop("walk");
                  zone.body._y = zone.body_table_y;
               }
            }
            else
            {
               zone.body.gotoAndStop("stand");
               zone.body._y = zone.body_table_y;
            }
         }
         else if(zone.dashing)
         {
            zone.dashing_timer = zone.dashing_timer + 1;
            if(zone.dashing_timer == 1 or zone.dashing_timer % 5 == 0)
            {
               if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
               {
                  var loc3 = (80 + random(20)) / 100;
                  var loc2 = f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,zone._xscale * loc3,100 * loc3);
                  loc2._x += random(10) - 5;
                  loc2._y += random(4) - 2;
               }
            }
            zone.fp_WalkAnim(zone);
            zone.body._y = zone.body_table_y;
         }
         else
         {
            zone.dashing_timer = 0;
            if(zone.walking)
            {
               zone.fp_WalkAnim(zone);
               zone.body._y = zone.body_table_y;
            }
            else
            {
               zone.fp_StandAnim(zone);
               zone.body._y = zone.body_table_y;
            }
         }
         if(!zone.busy)
         {
            f_BeefyThrow(zone);
         }
      }
   }
}
function f_OnScreen(zone)
{
   var loc1 = zone.x + game_x;
   var loc2 = zone._width;
   if(loc1 + loc2 > 0 and loc1 - loc2 < scaled_screen_width)
   {
      return true;
   }
   return false;
}
function f_HitWallGroupV(zone, speed, group_total, group_min, name)
{
   var loc1 = undefined;
   var loc6 = undefined;
   var loc4 = undefined;
   var loc5 = group_min;
   while(loc5 <= group_total)
   {
      loc1 = loader.game.game[name + int(loc5)];
      if(loc1.active)
      {
         if(loc1.angle)
         {
            if(zone.y + speed >= loc1.zone.top and zone.y + speed <= loc1.zone.bottom)
            {
               if(Math.abs(zone.x - loc1.zone.x) <= loc1.zone.w)
               {
                  loc6 = (loc1.zone.right - zone.x) / (loc1.zone.w * 2);
                  loc4 = loc1.zone.bottom - loc1.zone.h * 2 * loc6;
                  if(speed > 0 and zone.y <= loc4 and zone.y + speed >= loc4 or speed < 0 and zone.y >= loc4 and zone.y + speed <= loc4)
                  {
                     zone.collide = loc1;
                     return true;
                  }
               }
            }
         }
         else if(Math.abs(zone.x - loc1.zone.x) < loc1.zone.w)
         {
            if(zone.y < loc1.zone.top and zone.y + speed >= loc1.zone.top)
            {
               return true;
            }
            if(zone.y > loc1.zone.bottom and zone.y + speed <= loc1.zone.bottom)
            {
               return true;
            }
         }
      }
      loc5 = loc5 + 1;
   }
   return false;
}
function f_HitWallGroupH(zone, speed, group_total, group_min, name)
{
   var loc1 = undefined;
   var loc6 = undefined;
   var loc4 = undefined;
   var loc5 = group_min;
   while(loc5 <= group_total)
   {
      loc1 = loader.game.game[name + int(loc5)];
      if(loc1.active and loc1 != zone)
      {
         if(zone.y >= loc1.zone.top and zone.y <= loc1.zone.bottom)
         {
            if(loc1.angle)
            {
               if(zone.x + speed >= loc1.zone.left and zone.x + speed <= loc1.zone.right)
               {
                  loc6 = 1 - (loc1.zone.bottom - zone.y) / (loc1.zone.h * 2);
                  loc4 = loc1.zone.left + loc1.zone.w * 2 * loc6;
                  if(speed > 0 and zone.x <= loc4 and zone.x + speed >= loc4 or speed < 0 and zone.x >= loc4 and zone.x + speed <= loc4)
                  {
                     loc1.wall_x = loc1.zone.x;
                     loc1.wall_y = loc1.zone.y;
                     zone.collide = loc1;
                     return true;
                  }
               }
            }
            else if(zone.x < loc1.zone.x and zone.x + speed >= loc1.zone.left and speed > 0 or zone.x > loc1.zone.x and zone.x + speed <= loc1.zone.right and speed < 0)
            {
               if(zone.body_y > - loc1.hitzone._height)
               {
                  loc1.wall_x = loc1.zone.x;
                  loc1.wall_y = loc1.zone.y;
                  zone.collide = loc1;
                  return true;
               }
            }
         }
      }
      loc5 = loc5 + 1;
   }
   return false;
}
function f_HitWallH(zone, speed)
{
   var loc7 = false;
   if(zone.splashattack)
   {
      return false;
   }
   if(f_HitWallGroupH(zone,speed,object_index,1,"object"))
   {
      loc7 = true;
   }
   else
   {
      var loc1 = undefined;
      var loc9 = undefined;
      var loc8 = undefined;
      var loc5 = undefined;
      var loc4 = undefined;
      var loc3 = 1;
      while(loc3 <= active_walls)
      {
         loc1 = wallArrayOb["w" + int(loc3)];
         loc1.wall_y = loc1._y + loc1.wall._y;
         loc9 = loc1.wall_y - loc1.wall._height / 2;
         if(zone.y >= loc9)
         {
            loc8 = loc1.wall_y + loc1.wall._height / 2;
            if(zone.y <= loc8)
            {
               if(speed > 0)
               {
                  if(loc1._xscale < 0)
                  {
                     loc1.wall_x = loc1._x - loc1.wall._x;
                     loc5 = loc1.wall_x - loc1.wall._width / 2;
                  }
                  else
                  {
                     loc1.wall_x = loc1._x + loc1.wall._x;
                     loc5 = loc1.wall_x - loc1.wall._width / 2;
                  }
                  if(zone.x <= loc5)
                  {
                     if(zone.x + speed >= loc5)
                     {
                        zone.collide = loc1;
                        loc7 = true;
                     }
                  }
               }
               else
               {
                  if(loc1._xscale < 0)
                  {
                     loc1.wall_x = loc1._x - loc1.wall._x;
                     loc4 = loc1.wall_x + loc1.wall._width / 2;
                  }
                  else
                  {
                     loc1.wall_x = loc1._x + loc1.wall._x;
                     loc4 = loc1.wall_x + loc1.wall._width / 2;
                  }
                  if(zone.x >= loc4)
                  {
                     if(zone.x + speed <= loc4)
                     {
                        zone.collide = loc1;
                        loc7 = true;
                     }
                  }
               }
            }
         }
         loc3 = loc3 + 1;
      }
   }
   zone.hitwall = loc7;
   return loc7;
}
function f_HitWallV(zone, speed)
{
   var loc9 = false;
   if(f_HitWallGroupV(zone,speed,object_index,1,"object"))
   {
      loc9 = true;
   }
   else
   {
      var loc1 = undefined;
      var loc8 = undefined;
      var loc6 = undefined;
      var loc7 = undefined;
      var loc4 = undefined;
      var loc3 = 1;
      while(loc3 <= active_walls)
      {
         loc1 = wallArrayOb["w" + int(loc3)];
         loc1.wall_y = loc1._y + loc1.wall._y;
         if(loc1 != zone)
         {
            if(loc1._xscale < 0)
            {
               loc1.wall_x = loc1._x - loc1.wall._x;
               loc8 = loc1.wall_x - loc1.wall._width / 2;
            }
            else
            {
               loc1.wall_x = loc1._x + loc1.wall._x;
               loc8 = loc1.wall_x - loc1.wall._width / 2;
            }
            if(zone.x >= loc8)
            {
               if(loc1._xscale < 0)
               {
                  loc1.wall_x = loc1._x - loc1.wall._x;
                  loc6 = loc1.wall_x + loc1.wall._width / 2;
               }
               else
               {
                  loc1.wall_x = loc1._x + loc1.wall._x;
                  loc6 = loc1.wall_x + loc1.wall._width / 2;
               }
               if(zone.x <= loc6)
               {
                  if(speed > 0)
                  {
                     loc7 = loc1.wall_y - loc1.wall._height / 2;
                     if(zone.y <= loc7)
                     {
                        if(zone.y + speed >= loc7)
                        {
                           zone.collide = loc1;
                           loc9 = true;
                        }
                     }
                  }
                  else
                  {
                     loc4 = loc1.wall_y + loc1.wall._height / 2;
                     if(zone.y >= loc4)
                     {
                        if(zone.y + speed <= loc4)
                        {
                           zone.collide = loc1;
                           loc9 = true;
                        }
                     }
                  }
               }
            }
         }
         loc3 = loc3 + 1;
      }
   }
   zone.hitwall = loc9;
   return loc9;
}
function f_ArrowHitBullseye(zone)
{
   if(zone.hitleft)
   {
      if(zone.arrow_pt.item_type == "arrow")
      {
         zone.arrow_pt.hit_function = f_ProjectileHitStick;
      }
      f_Depth(zone.arrow_pt,zone.y + 2);
      zone.body.gotoAndStop("hit1");
   }
}
function f_ProjectileHitWallH(zone, speed)
{
   var loc11 = false;
   var loc1 = undefined;
   var loc6 = undefined;
   var loc5 = undefined;
   var loc10 = undefined;
   var loc13 = undefined;
   var loc4 = undefined;
   var loc9 = 1;
   while(loc9 <= object_index)
   {
      loc1 = loader.game.game["object" + int(loc9)];
      if(loc1.active)
      {
         loc6 = loc1.hitzone;
         if(zone.y <= loc1.zone.y + loc1.zone.h)
         {
            if(zone.y >= loc1.zone.y - loc1.zone.h)
            {
               if(zone.y + zone.body._y <= loc6.y + loc6.h)
               {
                  if(zone.y + zone.body._y >= loc6.y - loc6.h)
                  {
                     loc5 = 0;
                     loc10 = false;
                     if(loc1.angle)
                     {
                        if(zone.x + speed >= loc1.zone.left and zone.x + speed <= loc1.zone.right)
                        {
                           loc13 = 1 - (loc1.zone.bottom - zone.y) / (loc1.zone.h * 2);
                           loc4 = loc1.zone.left + loc1.zone.w * 2 * loc13;
                           if(speed > 0 and zone.x <= loc4 and zone.x + speed >= loc4 or speed < 0 and zone.x >= loc4 and zone.x + speed <= loc4)
                           {
                              zone.collide = loc1;
                              loc10 = true;
                           }
                        }
                     }
                     else if(zone.x + loc5 < loc1.hitzone.left and zone.x + loc5 + speed >= loc1.hitzone.left or zone.x + loc5 > loc1.hitzone.right and zone.x + loc5 + speed <= loc1.hitzone.right)
                     {
                        loc10 = true;
                     }
                     if(loc10)
                     {
                        loc1.arrow_pt = zone;
                        loc1.hitleft = speed > 0;
                        loc1.hitby = zone.owner;
                        loc1.hitbydamage = zone.attack_pow;
                        if(loc1.punch)
                        {
                           loc1.fx_x = zone.x;
                           loc1.fx_y = zone.y + zone.body._y;
                           loc1.fx_body_y = zone.body._y;
                           if(loc1.uniquehit)
                           {
                              loc1.fx_x = zone.x;
                              loc1.fx_y = zone.y + zone.body._y;
                           }
                           if(!loc1.fp_UniqueHit(loc1,zone.punch_pow_low,zone.attack_type))
                           {
                              if(!loc1.no_wall_damage)
                              {
                                 loc1.punch_function(loc1);
                                 f_Damage(loc1,zone.attack_pow,zone.damage_type);
                              }
                           }
                           if(loc1.angle)
                           {
                              zone.x = loc4;
                              zone._x = zone.x;
                           }
                           else if(loc1.hitleft)
                           {
                              zone.x = loc1.hitzone.left;
                              zone._x = zone.x;
                           }
                           else
                           {
                              zone.x = loc1.hitzone.right;
                              zone._x = zone.x;
                           }
                           loc1.arrowhit_function(loc1);
                        }
                        zone.collide = loc1;
                        loc11 = true;
                     }
                  }
               }
            }
         }
      }
      loc9 = loc9 + 1;
   }
   var loc14 = undefined;
   var loc12 = undefined;
   var loc8 = undefined;
   var loc7 = undefined;
   loc9 = 1;
   while(loc9 <= active_walls)
   {
      loc1 = wallArrayOb["w" + int(loc9)];
      loc14 = loc1._y + loc1.wall._y - loc1.wall._height / 2;
      if(zone.y >= loc14)
      {
         loc12 = loc1._y + loc1.wall._y + loc1.wall._height / 2;
         if(zone.y <= loc12)
         {
            if(zone.y + zone.body._y >= loc1.y - loc1.h)
            {
               if(speed > 0)
               {
                  if(loc1._xscale > 0)
                  {
                     loc8 = loc1._x + loc1.wall._x - loc1.wall._width / 2;
                  }
                  else
                  {
                     loc8 = loc1._x - loc1.wall._x - loc1.wall._width / 2;
                  }
                  if(zone.x <= loc8)
                  {
                     if(zone.x + speed >= loc8)
                     {
                        if(loc1.invincible_timer <= 0 and !loc1.no_wall_damage)
                        {
                           loc1.damage_pow = zone.attack_pow;
                           loc1.damage_type = zone.damage_type;
                           loc1.hitby = zone.owner;
                           loc1.hitbydamage = zone.attack_pow;
                           zone.x = loc8;
                           zone._x = zone.x;
                           loc1.fx_x = zone.x;
                           loc1.fx_y = zone.body._y + zone.y;
                           if(!loc1.uniquehit)
                           {
                              f_Damage(loc1,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE,10,-6);
                           }
                           else
                           {
                              loc1.fp_UniqueHit(loc1,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE,10,-6);
                           }
                           loc1.arrowhit_function(loc1);
                           zone.collide = loc1;
                           loc11 = true;
                        }
                     }
                  }
               }
               else
               {
                  if(loc1._xscale > 0)
                  {
                     loc7 = loc1._x + loc1.wall._x + loc1.wall._width / 2;
                  }
                  else
                  {
                     loc7 = loc1._x - loc1.wall._x + loc1.wall._width / 2;
                  }
                  if(zone.x >= loc7)
                  {
                     if(zone.x + speed <= loc7)
                     {
                        if(loc1.invincible_timer <= 0 and !loc1.no_wall_damage)
                        {
                           loc1.damage_pow = zone.attack_pow;
                           loc1.damage_type = zone.damage_type;
                           loc1.hitby = zone.owner;
                           loc1.hitbydamage = zone.attack_pow;
                           zone.x = loc7;
                           zone._x = zone.x;
                           loc1.fx_x = zone.x;
                           loc1.fx_y = zone.body._y + zone.y;
                           if(!loc1.uniquehit)
                           {
                              f_Damage(loc1,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE,10,-6);
                           }
                           else
                           {
                              loc1.fp_UniqueHit(loc1,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE,10,-6);
                           }
                           loc1.arrowhit_function(loc1);
                           zone.collide = loc1;
                           loc11 = true;
                        }
                     }
                  }
               }
            }
         }
      }
      loc9 = loc9 + 1;
   }
   zone.hitwall = loc11;
   return loc11;
}
function f_DepthVal(u_depth_mod, u_depth)
{
   return 10000000 - Math.abs(u_depth - 200) * 1000 + u_depth_mod;
}
function f_GetDepthModAssignment(zone)
{
   current_depth_mod++;
   if(current_depth_mod > 999)
   {
      trace("* TO MANY DEPTH MODS!!!");
   }
   return current_depth_mod;
}
function f_SetDepths()
{
   return undefined;
}
function f_GetGold(zone, u_gold)
{
   zone.gold += u_gold;
   zone.total_gold_collected += u_gold;
   var loc6 = f_FX(zone.x,zone.y - 100,zone.y + 5,"damage_val",100,100);
   var loc2 = undefined;
   f_ShowVal(loc6,u_gold,color_gold);
   if(_root.p_game.specialmode == 2)
   {
      var loc3 = 1;
      while(loc3 <= active_players)
      {
         loc2 = playerArrayOb["p_pt" + int(loc3)];
         if(loc2.alive and loc2 != zone)
         {
            if(friendly_fire)
            {
               if(f_TeamCheck(zone,loc2))
               {
                  f_Damage(loc2,u_gold,DMG_MELEE);
                  f_CheckHealth(loc2);
               }
            }
            else
            {
               f_Damage(loc2,u_gold,DMG_MELEE);
               f_CheckHealth(loc2);
            }
         }
         loc3 = loc3 + 1;
      }
   }
}
function f_IsWeaponUnlocked(zone, wepId)
{
   var loc3 = _root.save_data_info.num_items;
   var loc2 = 0;
   if(wepId < loc3)
   {
      loc2 = zone.hud_pt.item_unlocks[wepId];
   }
   else
   {
      loc2 = zone.hud_pt.item_unlocks_expansion[wepId - loc3];
   }
   return loc2;
}
function f_SetWeaponUnlocked(zone, wepId, unlocked)
{
   var loc2 = _root.save_data_info.num_items;
   if(wepId < loc2)
   {
      zone.hud_pt.item_unlocks[wepId] = unlocked;
   }
   else
   {
      zone.hud_pt.item_unlocks_expansion[wepId - loc2] = unlocked;
   }
}
function f_GetWeapon(zone, u_temp)
{
   if(!(u_temp == 70 and level == 50))
   {
      var loc6 = f_ItemSpawn(zone._x,zone._y,14);
      loc6.weapon_type = zone.weapon;
      loc6.body_y = 0;
      loc6.body_table_y = 0;
      loc6.body.gotoAndPlay("toss");
      if(zone._xscale > 0)
      {
         loc6.toss_speed_x = -8;
      }
      else
      {
         loc6.toss_speed_x = 8;
      }
   }
   var loc5 = weapon_offset + u_temp;
   if(!f_IsWeaponUnlocked(zone,loc5))
   {
      f_UnlockItem(zone,loc5);
   }
   var loc7 = zone.hud_pt.port - 1;
   var loc3 = undefined;
   var loc2 = 1;
   while(loc2 <= 4)
   {
      loc3 = _root["hud" + int(loc2)];
      if(loc3.active)
      {
         if(IsSameProfile(loc7,loc3.port - 1))
         {
            f_SetWeaponUnlocked(loc3.player_pt,loc5,true);
         }
      }
      loc2 = loc2 + 1;
   }
   zone.weapon = u_temp;
   f_UpdatePlayerAttributes(zone);
   if(zone.body_y >= 0 and zone.alive)
   {
      zone.fp_StandAnim(zone);
   }
   LOGPush(12,u_temp,zone.hud_pt.port);
}
function f_GetRelic(zone, u_temp)
{
   f_ClearTimers(zone);
   if(zone.alive)
   {
      zone.gotoAndStop("getrelic" + u_temp);
   }
   if(_root.insane_mode)
   {
      u_temp += 4;
   }
   if(!zone.hud_pt.relic_unlocks[int(u_temp - 1)])
   {
      zone.hud_pt.relic_unlocks[int(u_temp - 1)] = true;
      zone.hud_pt.item_unlocks[relic_offset + u_temp] = true;
   }
}
function f_ShowVal(u_digit, u_value, u_color, critical)
{
   u_value = Math.abs(u_value);
   var loc3 = u_value / 100;
   loc3 = Math.floor(loc3);
   var loc4 = (u_value - loc3 * 100) / 10;
   loc4 = Math.floor(loc4);
   var loc6 = u_value - loc3 * 100 - loc4 * 10;
   loc6 = Math.floor(loc6);
   u_digit.body.critical = critical;
   var loc1 = u_digit.body.body.body;
   if(loc6 == 0)
   {
      var loc2 = 10;
   }
   else
   {
      loc2 = loc6;
   }
   loc1.one.gotoAndStop(loc2);
   loc1.one.outline.gotoAndStop(loc2);
   f_ColorSwap(loc1.one.outline,u_color);
   if(u_value >= 10)
   {
      if(loc4 == 0)
      {
         loc2 = 10;
      }
      else
      {
         loc2 = loc4;
      }
      loc1.ten.gotoAndStop(loc2);
      loc1.ten.outline.gotoAndStop(loc2);
      f_ColorSwap(loc1.ten.outline,u_color);
      if(u_value >= 100)
      {
         if(loc3 == 0)
         {
            loc2 = 10;
         }
         else
         {
            loc2 = loc3;
         }
         loc1.hundred.gotoAndStop(loc2);
         loc1.hundred.outline.gotoAndStop(loc2);
         f_ColorSwap(loc1.hundred.outline,u_color);
      }
      else
      {
         loc1.hundred.gotoAndStop("blank");
         loc1.one._x = 8;
         loc1.ten._x = -8;
      }
   }
   else
   {
      loc1.ten.gotoAndStop("blank");
      loc1.hundred.gotoAndStop("blank");
      loc1.one._x = 0;
   }
}
function f_Heal(zone, heal_pow)
{
   if(!zone.npc)
   {
      var loc9 = f_FX(zone.x,zone.y + zone.body_y - 100,zone.y + 5,"damage_val",100,100);
      var loc10 = color_green;
      f_ShowVal(loc9,heal_pow,loc10);
   }
   heal_pow = Math.min(heal_pow,zone.health_max - zone.health);
   if(heal_pow > 999)
   {
      heal_pow = 999;
   }
   zone.health += heal_pow;
   if(zone.health > zone.health_max)
   {
      zone.health = zone.health_max;
   }
   if(zone.lifebar)
   {
      var loc4 = undefined;
      var loc6 = false;
      var loc3 = undefined;
      loc3 = 1;
      while(loc3 <= total_huds)
      {
         loc4 = this["hud" + int(loc3)];
         if(loc4.kid_pointer == zone and !loc4.ready)
         {
            f_UpdateHUD(loc4,zone);
            loc6 = true;
            loc3 = total_huds + 1;
         }
         loc3 = loc3 + 1;
      }
      if(!loc6)
      {
         loc3 = 1;
         while(loc3 <= total_huds)
         {
            loc4 = _root["hud" + int(loc3)];
            if(loc4.ready)
            {
               loc4.ready = false;
               loc4.kid_pointer = zone;
               f_UpdateHUD(loc4,zone);
               loc3 = total_huds + 1;
            }
            loc3 = loc3 + 1;
         }
      }
   }
   else if(zone.human)
   {
      if(zone.health > 0)
      {
         var loc8 = int(101 - zone.health / zone.health_max * 100);
      }
      else
      {
         loc8 = 101;
      }
      zone.hud_pt.stats.health.gotoAndStop(loc8);
   }
}
function f_Damage(zone, damage_pow, damage_type, damage_flags, recoil_x, recoil_y)
{
   if(!zone or zone.health == undefined or zone.invincible_timer > 0)
   {
      return undefined;
   }
   if(zone.frozen and zone.hitby.splashattack and damage_type == DMG_ICE)
   {
      return undefined;
   }
   if(zone.health > 0)
   {
      if(zone.hitby)
      {
         if(zone.hitby.human)
         {
            f_Exp(zone.hitby,1);
         }
         else if(zone.hitby.owner.human)
         {
            f_Exp(zone.hitby.owner,1);
         }
      }
   }
   if(damage_type == undefined)
   {
      damage_type = DMG_MELEE;
   }
   if(damage_pow < 0)
   {
      damage_pow = 1;
   }
   if(damage_flags == undefined)
   {
      damage_flags = 0;
   }
   if(damage_type < 0)
   {
      damage_type = DMG_MELEE;
   }
   var loc13 = false;
   if(zone.hitby)
   {
      if(damage_type == DMG_MELEE)
      {
         if(zone.hitby.weapon_critical > 0)
         {
            if(random(zone.hitby.weapon_critical) == 0)
            {
               loc13 = true;
               damage_pow *= 4;
            }
         }
         if(zone.hitby.weapon_magic_type > 0)
         {
            if(random(zone.hitby.weapon_magic_chance) == 0)
            {
               f_ElementalPunch(zone.hitby,zone.hitby.weapon_magic_type);
               switch(zone.hitby.weapon_magic_type)
               {
                  case 1:
                     damage_type = DMG_POISON;
                     break;
                  case 2:
                     damage_type = DMG_ELEC;
                     break;
                  case 3:
                     damage_type = DMG_ICE;
                     break;
                  case 4:
                     damage_type = DMG_FIRE;
               }
            }
         }
      }
   }
   if(damage_type == DMG_OBJECT or damage_type == DMG_MAGIC)
   {
      damage_type = DMG_MELEE;
   }
   var loc9 = undefined;
   if(zone.resists != undefined)
   {
      if(damage_type < zone.resists.length)
      {
         loc9 = zone.resists[damage_type];
      }
   }
   if(damage_flags & DMGFLAG_NORESIST)
   {
      loc9 = 0;
   }
   if(loc9 == undefined)
   {
      loc9 = 0;
   }
   damage_pow = Math.min(Math.max(Math.round(damage_pow * (100 - loc9) / 50),1),999);
   var loc15 = Math.round(loc9 / 25);
   var loc10 = undefined;
   var loc7 = undefined;
   switch(loc15)
   {
      case 0:
         loc10 = 2;
         loc7 = 1.5;
         break;
      case 1:
         loc10 = 1.5;
         loc7 = 1.25;
         break;
      case 2:
         loc10 = 1;
         loc7 = 1;
         break;
      case 3:
         loc10 = 0.5;
         loc7 = 0.5;
         break;
      case 100:
         loc10 = 1;
         loc7 = 1;
         break;
      case 4:
      default:
         loc10 = 0;
         loc7 = loc9 >= 90 ? 0 : 0.5;
   }
   if(recoil_x != undefined)
   {
      recoil_x *= loc10;
      recoil_y *= loc10;
   }
   if(damage_flags & DMGFLAG_NO_ELEM_EFFECT)
   {
      loc7 = 0;
   }
   var loc16 = false;
   if(zone.frozen and (!zone.hitby.splashattack or damage_type != DMG_ICE))
   {
      loc16 = true;
      zone.frozen = false;
      f_IceShatter(zone);
   }
   if(zone.stone)
   {
      f_StoneHeart(zone);
   }
   if(loc7 and zone.humanoid)
   {
      switch(damage_type)
      {
         case DMG_MELEE:
            break;
         case DMG_POISON:
            if(zone.poison_timer <= 0)
            {
               zone.poison_timer = 119 * loc7;
               if(zone.hitby.owner)
               {
                  zone.poison_owner = zone.hitby.owner;
               }
               else if(zone.hitby)
               {
                  zone.poison_owner = zone.hitby;
               }
               f_ColorSwap(zone,color_dark_green);
            }
            break;
         case DMG_FIRE:
            if(zone.fire_timer <= 0)
            {
               zone.fire_timer = 59 * loc7;
               zone.smoking_timer = 60 * loc7;
               f_ColorSwap(zone,color_dark);
               if(zone.hitby.owner)
               {
                  zone.fire_owner = zone.hitby.owner;
               }
               else if(zone.hitby)
               {
                  zone.fire_owner = zone.hitby;
               }
            }
            break;
         case DMG_ELEC:
            if(zone.body_y >= 0)
            {
               zone.gotoAndStop("zapped");
            }
            break;
         case DMG_ICE:
            if(!loc16)
            {
               if(zone.body_y >= 0)
               {
                  recoil_x = recoil_y = 0;
                  if(damage_flags & DMGFLAG_JUGGLE)
                  {
                     damage_flags ^= DMGFLAG_JUGGLE;
                  }
                  if(zone.pet.animal_type != 8)
                  {
                     zone.frozen = true;
                     zone.gotoAndStop("freeze");
                  }
               }
            }
      }
   }
   if(loc15 < 4)
   {
      if(recoil_y != undefined)
      {
         zone.speed_toss_x = recoil_x;
         zone.speed_toss_y = recoil_y;
      }
      if(!zone.nohit and damage_flags & DMGFLAG_JUGGLE)
      {
         f_CallJuggle1(zone);
      }
   }
   if(damage_flags & DMGFLAG_STUN)
   {
      if(zone.horse)
      {
         zone.horse.gotoAndStop("idle");
      }
      if(zone.humanoid)
      {
         if(damage_flags & DMGFLAG_SPARKLE_EFFECT)
         {
            zone.gotoAndStop("pink_stun");
         }
         else
         {
            zone.gotoAndStop("stun");
         }
         zone.body.gotoAndPlay(1);
      }
   }
   if(damage_flags & DMGFLAG_BLOODY)
   {
      zone.blood_timer = 15;
   }
   if(damage_flags & DMGFLAG_SPARKLE_EFFECT)
   {
      zone.sparklefx_timer = 15;
   }
   if(!zone.npc)
   {
      var loc14 = f_FX(zone.x,zone.y + zone.body_y - 100,zone.y + 5,"damage_val",100,100);
      zone.u_digit = loc14;
      if(damage_pow > 0)
      {
         var loc20 = color_red;
      }
      else
      {
         loc20 = color_green;
      }
      f_ShowVal(loc14,damage_pow,loc20,loc13);
   }
   zone.health -= damage_pow;
   if(zone.health > zone.health_max)
   {
      zone.health = zone.health_max;
   }
   else if(zone.health <= 0)
   {
      zone.health = 0;
      f_CheckHealthPots(zone);
   }
   if(zone.lifebar)
   {
      var loc11 = false;
      var loc4 = undefined;
      var loc5 = undefined;
      loc4 = 1;
      while(loc4 <= total_huds)
      {
         loc5 = this["hud" + int(loc4)];
         if(loc5.kid_pointer == zone and !loc5.ready)
         {
            f_UpdateHUD(loc5,zone);
            loc11 = true;
            loc4 = total_huds + 1;
         }
         loc4 = loc4 + 1;
      }
      if(!loc11)
      {
         loc4 = 1;
         while(loc4 <= total_huds)
         {
            loc5 = _root["hud" + int(loc4)];
            if(loc5.ready)
            {
               loc5.ready = false;
               loc5.kid_pointer = zone;
               f_UpdateHUD(loc5,zone);
               loc4 = total_huds + 1;
            }
            loc4 = loc4 + 1;
         }
      }
   }
   else if(zone.human)
   {
      if(zone.health > 0)
      {
         var loc19 = int(101 - zone.health / zone.health_max * 100);
      }
      else
      {
         loc19 = 101;
      }
      zone.hud_pt.stats.health.gotoAndStop(loc19);
   }
   if(zone.hitby.invincible_recover)
   {
      zone.invincible_timer = zone.hitby.invincible_recover;
   }
}
function f_RegisterHit(zone, damage_pow)
{
   zone.got_hit += damage_pow;
}
function f_SlideSwingInit(zone)
{
   zone.body.speed = 12;
   if(zone._xscale < 0)
   {
      zone.body.speed *= -1;
   }
   s_Swing4.start(0,0);
}
function f_SlideDust(zone)
{
   if(zone._xscale > 0)
   {
      var loc2 = zone._x + 35;
   }
   else
   {
      loc2 = zone._x - 35;
   }
   var loc3 = f_FX(loc2,zone.y + 5,int(zone.y) + 5,level_dust,zone._xscale,100);
}
function f_DashSlam(zone)
{
   f_PunchHit(zone);
   f_MoveCharH(zone,zone.speed_slam,0);
   if(zone.speed_slam % 4 == 0)
   {
      var loc2 = f_FX(zone.x,zone.y + 10,int(zone.y) + 4,level_dust,zone._xscale,100);
   }
   if(zone.speed_slam > 0)
   {
      zone.speed_slam -= 1;
      if(zone.speed_slam < 1)
      {
         zone.speed_slam = 1;
      }
   }
   else
   {
      zone.speed_slam += 1;
      if(zone.speed_slam > -1)
      {
         zone.speed_slam = -1;
      }
   }
}
function f_KidInit(zone)
{
   zone.lifebar = true;
   zone.health = zone.health_max;
   zone.alive = true;
   zone.speed_x = random(5) + 5;
   zone.speed_y = random(3) + 3;
   zone.weight = 0;
   if(zone._xscale < 0)
   {
      zone.speed_x *= -1;
   }
   if(random(2) == 1)
   {
      zone.speed_y *= -1;
   }
   zone.speed_x *= 0.5;
   zone.speed_y *= 0.5;
   zone.grab = true;
}
function f_RandomRun(zone)
{
   var loc2 = loader.game.game;
   if(zone.speed_x > 0 and zone._xscale < 0)
   {
      f_FlipChar(zone);
   }
   else if(zone.speed_x < 0 and zone._xscale > 0)
   {
      f_FlipChar(zone);
   }
   if(!f_MoveCharH(zone,zone.speed_x,0))
   {
      zone.speed_x *= -1;
   }
   if(!f_MoveCharV(zone,zone.speed_y,0))
   {
      zone.speed_y *= -1;
   }
   if(zone.y > loc2.limit_bottomright.y and zone.speed_y > 0)
   {
      zone.speed_y *= -1;
   }
   else if(zone.y < loc2.limit_topleft.y and zone.speed_y < 0)
   {
      zone.speed_y *= -1;
   }
   if(zone.x > loc2.limit_bottomright.x and zone.speed_x > 0)
   {
      zone.speed_x *= -1;
   }
   else if(zone.x < loc2.limit_topleft.x and zone.speed_x < 0)
   {
      zone.speed_x *= -1;
   }
}
function f_DashReset(zone)
{
   zone.right_last = 100;
   zone.right_last2 = 0;
   zone.left_last = 100;
   zone.left_last2 = 0;
}
function f_PunchReset(zone)
{
   if(zone.human)
   {
      zone.punch_group = 0;
      zone.punch_num = 0;
   }
   zone.punching = false;
}
function f_StandSettings(zone)
{
   f_PunchReset(zone);
   zone.busy = false;
   zone.spinning = false;
   zone.rolling = false;
   zone.damage_chain = 0;
   zone.float_timer = 0;
   zone.dashing = false;
   zone.sheathing = false;
   zone.blocking = false;
   zone.blocked = false;
   zone.horse_move = false;
   zone.toss_clock = 0;
   if(zone.grappler)
   {
      zone.grappler.grappler = undefined;
      zone.grappler = undefined;
   }
   zone.stunned = false;
   if(zone.body_y >= 0)
   {
      zone.jumping = false;
   }
   zone.hitby = undefined;
   zone.hitbydamage = undefined;
   zone.cpr = undefined;
   zone.ladder = undefined;
   zone.nohit = false;
   zone.onfire = 1;
   zone.onground = false;
   zone.current_weight = zone.weight;
   if(zone.thrusting)
   {
      zone.thrusting = false;
      if(zone.prev_fp_UniqueHit)
      {
         zone.fp_UniqueHit = zone.prev_fp_UniqueHit;
         zone.prev_fp_UniqueHit = undefined;
      }
      else
      {
         zone.uniquehit = false;
         zone.fp_UniqueHit = undefined;
      }
   }
   f_CheckHealth(zone);
   if(!zone.jumping)
   {
      zone.body._y = zone.body_table_y;
   }
   else
   {
      zone.body._y = zone.body_y + zone.body_table_y;
   }
}
function f_ThrowEnemy(zone, u_temp)
{
   if(!u_temp.beefy)
   {
      zone.throwmove = true;
      zone.victim = u_temp;
      u_temp.hitby = zone;
      f_MoveCharH(u_temp,zone.x - u_temp.x,0);
      f_MoveCharV(u_temp,zone.y - u_temp.y + 1,0);
      if(zone.body_y)
      {
         u_temp.body_y = zone.body_y;
      }
      u_temp.nohit = true;
      f_FlipInverse(u_temp,zone);
      u_temp.gotoAndStop("thrown");
      u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
      zone.gotoAndStop("throw");
   }
}
function f_HostageGrabbed(zone, u_temp)
{
   if(zone.body_y)
   {
      u_temp.body_y = zone.body_y;
   }
   u_temp.gotoAndStop("hostage");
   u_temp.body._y = u_temp.body_y + u_temp.body_table_y;
}
function f_BeefyGrabEnemy(zone, u_temp)
{
   zone.throwmove = true;
   zone.hostage = u_temp;
   u_temp.captor = zone;
   u_temp.gotoAndStop("hit2");
   f_BeefyCarryEnemy(zone);
   f_FlipInverse(u_temp,zone);
   if(zone.fp_StandAnim != f_StandTypeBeefyHostage)
   {
      zone.prev_StandAnim = zone.fp_StandAnim;
   }
   if(zone.fp_WalkAnim != f_WalkTypeBeefyHostage)
   {
      zone.prev_WalkAnim = zone.fp_WalkAnim;
   }
   zone.fp_StandAnim = f_StandTypeBeefyHostage;
   zone.fp_WalkAnim = f_WalkTypeBeefyHostage;
   if(zone.human)
   {
      if(zone.fp_Character != f_CharacterBeefyCarry)
      {
         zone.prev_Character = zone.fp_Character;
      }
      zone.fp_Character = f_CharacterBeefyCarry;
   }
   else
   {
      if(zone.fp_Character != f_BeefyThrowAction)
      {
         zone.prev_Character = zone.fp_Character;
      }
      zone.fp_Character = f_BeefyThrowAction;
   }
   zone.gotoAndStop("beefy_grab");
}
function f_BeefyCarryEnemy(zone)
{
   if(zone._xscale > 0)
   {
      f_SetXY(zone.hostage,zone.x + 70,zone.y + 1);
   }
   else
   {
      f_SetXY(zone.hostage,zone.x - 70,zone.y + 1);
   }
   f_FlipSame(zone.hostage,zone);
}
function f_StompRange(zone)
{
   var loc8 = false;
   var loc7 = false;
   zone.throwmove = false;
   var loc2 = undefined;
   var loc5 = undefined;
   var loc4 = undefined;
   var loc6 = undefined;
   loc4 = 1;
   while(loc4 <= active_enemies)
   {
      loc2 = enemyArrayOb["e" + int(loc4)];
      if(loc2.alive)
      {
         if(Math.abs(loc2.x - zone.x) < 60)
         {
            if(Math.abs(loc2.y - zone.y) < 20)
            {
               if(loc2.onground)
               {
                  if(zone.body_y >= 0)
                  {
                     loc7 = true;
                  }
               }
               else if(!loc2.nohit or loc2.body_y < 0)
               {
                  if(loc2.grab and !loc2.beefy)
                  {
                     if(Math.abs(loc2.x - zone.x) < 30)
                     {
                        if(zone.body_y > loc2.body_y - 20)
                        {
                           if(zone.body_y < loc2.body_y + 60)
                           {
                              if(!(_root.boss_fight and _root.level == 43))
                              {
                                 zone.fp_ThrowAction(zone,loc2);
                                 return false;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      loc4 = loc4 + 1;
   }
   if(friendly_fire)
   {
      loc4 = 1;
      while(loc4 <= active_players)
      {
         loc2 = playerArrayOb["p_pt" + int(loc4)];
         if(loc2.alive and loc2 != zone)
         {
            if(f_TeamCheck(zone,loc2))
            {
               if(Math.abs(loc2.x - zone.x) < 60)
               {
                  if(Math.abs(loc2.y - zone.y) < 20)
                  {
                     if(loc2.onground)
                     {
                        if(zone.body_y >= 0)
                        {
                           loc7 = true;
                        }
                     }
                     else if(!loc2.nohit)
                     {
                        if(loc2.grab and !loc2.beefy)
                        {
                           if(Math.abs(loc2.x - zone.x) < 30)
                           {
                              if(zone.body_y > loc2.body_y - 20)
                              {
                                 if(zone.body_y < loc2.body_y + 60)
                                 {
                                    zone.fp_ThrowAction(zone,loc2);
                                    return false;
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         loc4 = loc4 + 1;
      }
   }
   else if(zone.human)
   {
      loc4 = 1;
      while(loc4 <= 4)
      {
         loc2 = p_game["p" + int(loc4)];
         if(loc2.active and loc2 != zone and loc2.hud_pt and loc2.hud_pt.active)
         {
            if(!loc2.alive and loc2.health <= 0)
            {
               if(Math.abs(zone.x - loc2.x) < 60)
               {
                  if(Math.abs(zone.y - loc2.y) < 20)
                  {
                     if(zone.body_y >= 0)
                     {
                        loc6 = 1;
                        while(loc6 <= 4)
                        {
                           loc5 = p_game["p" + int(loc6)];
                           if(loc5 != zone)
                           {
                              if(loc5.cpr == loc2 and loc5.alive)
                              {
                                 return false;
                              }
                           }
                           loc6 = loc6 + 1;
                        }
                        zone.throwmove = true;
                        var xoffset = 20;
                        if(loc2.p_type == 32) {
                           xoffset = -20;
                        }
                        if(loc2._xscale > 0)
                        {
                           f_SetXY(zone,loc2.x,loc2.y);
                           f_MoveCharH(zone,- xoffset,0);
                        }
                        else
                        {
                           f_SetXY(zone,loc2.x,loc2.y);
                           f_MoveCharH(zone,xoffset,0);
                        }
                        f_Depth(zone,zone.y + 1);
                        f_FlipSame(zone,loc2);
                        zone.gotoAndStop("cpr");
                        zone.blocking = false;
                        zone.cpr = loc2;
                        if(loc2.p_type == 33) { // cyclops dual death thing
                           if(loc2.undead) {
                              loc2.gotoAndStop("undead_die");
                           }
                           else {
                              loc2.gotoAndStop("swim");
                           }
                        }
                        else {
                           loc2.gotoAndStop("die");
                        }
                        loc2.body.gotoAndPlay("cpr");
                        return false;
                     }
                  }
               }
            }
         }
         loc4 = loc4 + 1;
      }
   }
   if(loc8 == false and loc7)
   {
      return true;
   }
   return false;
}
function f_ShieldBash(zone)
{
   if(zone.punch_group != 7)
   {
      zone.punch_group = 7;
      zone.punch_num = 1;
   }
   else
   {
      zone.punch_num = zone.punch_num + 1;
      if(zone.punch_num > 3)
      {
         zone.punch_num = 1;
      }
   }
   zone.gotoAndStop("shieldbash" + int(zone.punch_num));
}
function f_Uppercut(zone)
{
   if(zone.body_y > -275)
   {
      s_Swing3.start(0,0);
      if(zone.jumping)
      {
         f_SetFloat(zone,9);
      }
      zone.punch_group = 3;
      zone.punch_num = 1;
      zone.gotoAndStop("uppercut");
   }
   else if(zone.body_y > -325)
   {
      zone.punch_group = 3;
      zone.punch_num = 1;
      f_BuzzSaw(zone);
   }
   else
   {
      zone.punching = true;
      zone.punch_group = 1;
      zone.punch_num = 1;
      zone.jumping = true;
      zone.gotoAndStop("punch1_1");
   }
}
function f_BeefyJabFierce(zone)
{
   zone.punching = true;
   zone.punch_group = 200;
   zone.punch_num = 1;
   zone.gotoAndStop("punch200_1");
}
function f_ResetCombo(zone)
{
   zone.punch_group = 0;
   zone.punch_num = 0;
}
function f_PunchSet1(zone)
{
   zone.punching = true;
   var loc2 = zone.punch_group;
   var loc3 = zone.punch_num;
   if(zone.dashing and zone.truespeed and zone.body_y == 0 and zone.combo_unlocks[2])
   {
      if(zone._xscale > 0)
      {
         zone.speed_slam = 15;
      }
      else
      {
         zone.speed_slam = -15;
      }
      zone.punch_group = 4;
      zone.punch_num = 1;
      f_DashReset(zone);
      zone.dashing = false;
      zone.gotoAndStop("dashpunch");
   }
   else if(zone.body_y < 0)
   {
      if(loc2 == 11)
      {
         if(loc3 == 1)
         {
            zone.punch_num = 2;
            s_Swing2.start(0,0);
            zone.gotoAndStop("punch11_2");
            zone.body.gotoAndPlay(1);
         }
         else
         {
            zone.punch_num = 1;
            s_Swing5.start(0,0);
            zone.gotoAndStop("punch11_1");
            zone.body.gotoAndPlay(1);
         }
      }
      else
      {
         zone.punch_group = 11;
         zone.punch_num = 1;
         s_Swing5.start(0,0);
         zone.gotoAndStop("punch11_1");
         zone.body.gotoAndPlay(1);
      }
   }
   else if(loc2 == 6 and loc3 == 1)
   {
      zone.punch_group = 6;
      zone.punch_num = 3;
      zone.gotoAndStop("punch6_3");
   }
   else if(loc2 == 6 and loc3 == 3 and zone.combo_unlocks[6])
   {
      zone.punch_group = 6;
      zone.punch_num = 4;
      zone.gotoAndStop("punch6_4");
   }
   else if(loc2 == 1)
   {
      if(zone.punch_num == 1)
      {
         s_Swing4.start(0,0);
         zone.gotoAndStop("punch1_2");
         zone.punch_num = 2;
      }
      else if(zone.punch_num == 2 and zone.combo_unlocks[0])
      {
         s_Swing4.start(0,0);
         zone.punch_num = 3;
         zone.gotoAndStop("punch1_3");
      }
      else if(zone.punch_num == 3)
      {
         s_Swing2.start(0,0);
         zone.gotoAndStop("punch1_4");
         zone.punch_num = 4;
      }
      else
      {
         s_Swing5.start(0,0);
         zone.punch_num = 1;
         zone.gotoAndStop("punch1_1");
      }
   }
   else
   {
      s_Swing5.start(0,0);
      zone.punch_group = 1;
      zone.punch_num = 1;
      zone.gotoAndStop("punch1_1");
   }
}
function f_PunchSet2(zone)
{
   zone.punching = true;
   var loc3 = zone.punch_group;
   var loc2 = zone.punch_num;
   if(zone.magicmode)
   {
      if(zone.body_y < -5)
      {
         if(zone.magic_unlocks[4])
         {
            if(zone.jumping)
            {
               zone.freeze = true;
               f_SetFloat(zone,10);
            }
            if(zone.magic_type == 3)
            {
               var loc4 = int(zone.magic_max * 0.5);
               if(loc4 < 25)
               {
                  loc4 = 25;
               }
            }
            else
            {
               loc4 = 25;
            }
            if(zone.magic_current >= loc4)
            {
               f_Magic(zone,- loc4);
               if(zone.magic_type == 16 or zone.magic_type == 20)
               {
                  zone.gotoAndStop("tornado");
               }
               else
               {
                  zone.fp_MagicMove = f_MagicBulletDown;
                  zone.jump_attack = false;
                  zone.gotoAndStop("magic_air_down");
                  f_PunchInit(zone);
                  zone.body.gotoAndPlay(1);
               }
            }
            else
            {
               zone.gotoAndStop("magic0");
            }
         }
         return undefined;
      }
      if(zone.magic_unlocks[3])
      {
         if(zone.jumping)
         {
            zone.freeze = true;
            f_SetFloat(zone,10);
         }
         if(zone.jumping)
         {
            zone.freeze = true;
            f_SetFloat(zone,11);
         }
         if(zone.magic_type == 3 or zone.magic_type == 27 or zone.magic_type == 30)
         {
            loc4 = int(zone.magic_max * 0.5);
            if(loc4 < 25)
            {
               loc4 = 25;
            }
         }
         else
         {
            loc4 = 25;
         }
         if(zone.magic_current >= loc4)
         {
            f_Magic(zone,- loc4);
            if(zone.magic_type == 2)
            {
               zone.lightning_timer = 9;
               zone.gotoAndStop("magic2");
            }
            else if(zone.magic_type == 16 or zone.magic_type == 20)
            {
               zone.gotoAndStop("tornado");
            }
            else if(zone.magic_type == 30)
            {
               zone.fp_MagicMove = f_ShootMagic;
               zone.gotoAndStop("pink_cast");
            }
            else
            {
               zone.fp_MagicMove = f_ShootMagic;
               zone.gotoAndStop("magic1");
            }
         }
         else
         {
            zone.gotoAndStop("magic0");
         }
         return undefined;
      }
   }
   if(zone.body_y < 0)
   {
      if(loc3 == 11 and loc2 == 1 and zone.combo_unlocks[3])
      {
         f_Uppercut(zone);
      }
      else if(loc3 == 12 and loc2 == 1)
      {
         zone.punch_num = 2;
         if(zone.u_punch2_2 == 2)
         {
            zone.gotoAndStop("punch2_2b");
         }
         else
         {
            zone.gotoAndStop("punch2_2");
         }
      }
      else if(loc3 == 12 and loc2 == 2)
      {
         zone.punch_group = 13;
         zone.punch_num = 1;
         zone.gotoAndStop("punch11_1");
      }
      else if(loc3 == 13)
      {
         if(zone.punch_num == 1)
         {
            zone.punch_num = 2;
            zone.gotoAndStop("punch11_2");
         }
         else
         {
            zone.punch_num = 1;
            zone.gotoAndStop("punch11_1");
         }
      }
      else
      {
         zone.speed_jump = 0;
         zone.punch_group = 12;
         zone.punch_num = 1;
         zone.gotoAndStop("slamdown");
      }
   }
   else if(zone.dashing and zone.truespeed and zone.body_y == 0 and zone.combo_unlocks[2])
   {
      if(zone._xscale > 0)
      {
         zone.speed_slam = 18;
      }
      else
      {
         zone.speed_slam = -18;
      }
      zone.punch_group = 4;
      zone.punch_num = 2;
      f_DashReset(zone);
      zone.dashing = false;
      zone.jumping = true;
      zone.speed_jump = 4;
      if(zone.body_y > 0)
      {
         zone.body_y = 0;
      }
      zone.body_y = zone.body_y - 1;
      zone.body._y = zone.body_y;
      f_SetFloat(zone,10);
      zone.gotoAndStop("dashslam");
   }
   else if(f_StompRange(zone))
   {
      zone.gotoAndStop("stomp");
   }
   else if(zone.throwmove)
   {
      zone.throwmove = false;
   }
   else if(loc3 == 1 and loc2 == 1 and zone.combo_unlocks[3])
   {
      f_Uppercut(zone);
   }
   else if(loc3 == 1 and loc2 == 2 and zone.combo_unlocks[4])
   {
      zone.punch_group = 5;
      zone.punch_num = 1;
      zone.gotoAndStop("punch5_1");
   }
   else if(loc3 == 1 and loc2 == 3 and zone.magic_unlocks[1])
   {
      zone.punch_group = 6;
      zone.punch_num = 1;
      zone.gotoAndStop("punch6_1");
   }
   else if(loc3 == 6 and loc2 == 1 and zone.combo_unlocks[6])
   {
      zone.punch_group = 4;
      zone.punch_num = 4;
      if(zone._xscale > 0)
      {
         zone.speed_slam = 20;
      }
      else
      {
         zone.speed_slam = -20;
      }
      zone.gotoAndStop("punch4_4");
   }
   else if(loc3 == 5 and loc2 == 1 and zone.combo_unlocks[5])
   {
      zone.punch_group = 5;
      zone.punch_num = 2;
      zone.gotoAndStop("punch5_2");
   }
   else if(loc3 == 4 and loc2 == 2)
   {
      zone.punch_group = 2;
      zone.punch_num = 2;
      if(zone.u_punch2_2 == 2)
      {
         zone.gotoAndStop("punch2_2b");
      }
      else
      {
         zone.gotoAndStop("punch2_2");
      }
      zone.body.gotoAndPlay(1);
   }
   else
   {
      zone.punch_group = 2;
      if(loc2 == 1)
      {
         zone.punch_num = 2;
         if(zone.u_punch2_2 == 2)
         {
            zone.gotoAndStop("punch2_2b");
         }
         else
         {
            zone.gotoAndStop("punch2_2");
         }
      }
      else if(loc2 == 2 and zone.body_y >= 0)
      {
         zone.punch_num = 3;
         zone.gotoAndStop("punch2_3");
      }
      else
      {
         zone.punch_num = 1;
         zone.gotoAndStop("punch2_1");
      }
   }
}
function f_PunchSet100(zone)
{
   zone.punching = true;
   if(zone.dashing and zone.truespeed and zone.body_y == 0)
   {
      if(zone._xscale > 0)
      {
         zone.speed_slam = 15;
      }
      else
      {
         zone.speed_slam = -15;
      }
      zone.punch_group = 4;
      zone.punch_num = 1;
      f_DashReset(zone);
      zone.dashing = false;
      zone.gotoAndStop("dashpunch");
   }
   else if(zone.body_y < 0)
   {
      if(zone.punch_group == 11)
      {
         if(zone.punch_num == 1)
         {
            zone.punch_num = 2;
            s_Swing2.start(0,0);
            zone.gotoAndStop("punch11_2");
            zone.body.gotoAndPlay(1);
         }
         else
         {
            zone.punch_num = 1;
            s_Swing5.start(0,0);
            zone.gotoAndStop("punch11_1");
            zone.body.gotoAndPlay(1);
         }
      }
      else
      {
         zone.punch_group = 11;
         zone.punch_num = 1;
         s_Swing5.start(0,0);
         zone.gotoAndStop("punch11_1");
         zone.body.gotoAndPlay(1);
      }
   }
   else if(zone.punch_group == 100)
   {
      if(zone.punch_num == 1)
      {
         s_Swing4.start(0,0);
         zone.punch_num = 2;
         zone.gotoAndStop("punch100_2");
      }
      else if(zone.punch_num == 2)
      {
         s_Swing4.start(0,0);
         zone.punch_num = 3;
         zone.gotoAndStop("punch100_3");
      }
      else
      {
         s_Swing5.start(0,0);
         zone.punch_num = 1;
         zone.gotoAndStop("punch100_1");
      }
   }
   else
   {
      s_Swing5.start(0,0);
      zone.punch_group = 100;
      zone.punch_num = random(3) + 1;
      zone.gotoAndStop("punch100_" + zone.punch_num);
   }
}
function f_PunchSet101(zone)
{
   zone.punching = true;
   if(zone.dashing and zone.truespeed and zone.body_y == 0)
   {
      if(zone._xscale > 0)
      {
         zone.speed_slam = 15;
      }
      else
      {
         zone.speed_slam = -15;
      }
      zone.punch_group = 4;
      zone.punch_num = 1;
      f_DashReset(zone);
      zone.dashing = false;
      zone.gotoAndStop("dashpunch");
   }
   else if(zone.body_y < 0)
   {
      if(zone.punch_group == 11)
      {
         if(zone.punch_num == 1)
         {
            zone.punch_num = 2;
            s_Swing2.start(0,0);
            zone.gotoAndStop("punch11_2");
            zone.body.gotoAndPlay(1);
         }
         else
         {
            zone.punch_num = 1;
            s_Swing5.start(0,0);
            zone.gotoAndStop("punch11_1");
            zone.body.gotoAndPlay(1);
         }
      }
      else
      {
         zone.punch_group = 11;
         zone.punch_num = 1;
         s_Swing5.start(0,0);
         zone.gotoAndStop("punch11_1");
         zone.body.gotoAndPlay(1);
      }
   }
   else if(zone.punch_group == 1)
   {
      if(zone.punch_num == 1)
      {
         s_Swing3.start(0,0);
         zone.punch_group = 3;
         zone.punch_num = 1;
         zone.gotoAndStop("uppercut");
      }
      else
      {
         s_Swing5.start(0,0);
         zone.punch_num = 1;
         zone.gotoAndStop("punch1_1");
      }
   }
   else
   {
      s_Swing5.start(0,0);
      zone.punch_group = 1;
      zone.punch_num = 1;
      zone.gotoAndStop("punch1_1");
   }
}
function f_PunchSet200(zone)
{
   zone.punching = true;
   if(zone.body_y >= 0)
   {
      if(zone.throwmove)
      {
         zone.throwmove = false;
         return undefined;
      }
      var loc2 = 1;
      while(loc2 <= ripoffs_total)
      {
         u_temp = ripoffs["s" + int(loc2)];
         if(u_temp.active and !u_temp.busy)
         {
            if(Math.abs(zone.y - u_temp.ripoff.y) < u_temp.ripoff.h)
            {
               if(Math.abs(zone.x - u_temp.ripoff.x) < u_temp.ripoff.w)
               {
                  if(zone.x < u_temp.ripoff.x and zone._xscale > 0 or zone.x > u_temp.ripoff.x and zone._xscale < 0)
                  {
                     u_temp.busy = true;
                     u_temp.captor = zone;
                     zone.hostage = u_temp;
                     zone.prev_StandAnim = zone.fp_StandAnim;
                     zone.prev_WalkAnim = zone.fp_WalkAnim;
                     zone.prev_Character = zone.fp_Character;
                     u_temp.gotoAndStop("pull");
                     zone.gotoAndStop("ripoff");
                     return undefined;
                  }
               }
            }
         }
         loc2 = loc2 + 1;
      }
   }
   if(zone.dashing and zone.truespeed or zone.jumping)
   {
      if(zone._xscale > 0)
      {
         zone.speed_slam = 15;
      }
      else
      {
         zone.speed_slam = -15;
      }
      zone.punch_group = 200;
      zone.punch_num = 2;
      if(zone.speed_jump < 0)
      {
         zone.speed_jump = 0;
      }
      zone.speed_toss_x = 8;
      zone.propeller_timer = 9;
      zone.gotoAndStop("propeller");
   }
   else
   {
      if(zone.body_y < 0)
      {
         return undefined;
      }
      if(f_StompRange(zone))
      {
         zone.gotoAndStop("stomp");
      }
      else if(zone.punch_group == 200)
      {
         if(zone.punch_num == 1)
         {
            s_Swing4.start(0,0);
            zone.punch_num = 2;
            zone.gotoAndStop("punch200_2");
         }
         else if(zone.punch_num == 2)
         {
            s_Swing4.start(0,0);
            zone.punch_num = 3;
            zone.gotoAndStop("punch200_3");
         }
         else if(zone.punch_num == 3)
         {
            s_Swing4.start(0,0);
            zone.punch_num = 4;
            zone.gotoAndStop("punch200_4");
         }
         else
         {
            s_Swing5.start(0,0);
            zone.punch_num = 1;
            zone.gotoAndStop("punch200_1");
         }
      }
      else
      {
         s_Swing5.start(0,0);
         zone.punch_group = 200;
         zone.punch_num = 1;
         zone.gotoAndStop("punch200_1");
      }
   }
}
function f_PunchSet201(zone)
{
   zone.punching = true;
   if(zone.dashing and zone.truespeed and zone.body_y == 0)
   {
      if(zone._xscale > 0)
      {
         zone.speed_slam = 15;
      }
      else
      {
         zone.speed_slam = -15;
      }
      zone.punch_group = 201;
      zone.punch_num = 2;
      f_DashReset(zone);
      zone.dashing = false;
      zone.gotoAndStop("beefy_dashpunch");
   }
   else if(zone.body_y < 0)
   {
      if(zone.punch_group == 11)
      {
         if(zone.punch_num == 1)
         {
            zone.punch_num = 2;
            s_Swing2.start(0,0);
            zone.gotoAndStop("punch11_2");
            zone.body.gotoAndPlay(1);
         }
         else
         {
            zone.punch_num = 1;
            s_Swing5.start(0,0);
            zone.gotoAndStop("punch11_1");
            zone.body.gotoAndPlay(1);
         }
      }
      else
      {
         zone.punch_group = 11;
         zone.punch_num = 1;
         s_Swing5.start(0,0);
         zone.gotoAndStop("punch11_1");
         zone.body.gotoAndPlay(1);
      }
   }
   else if(zone.punch_group == 201)
   {
      if(zone.punch_num == 1)
      {
         s_Swing4.start(0,0);
         zone.punch_num = 2;
         zone.gotoAndStop("punch201_2");
      }
      else if(zone.punch_num == 2)
      {
         s_Swing4.start(0,0);
         zone.punch_num = 3;
         zone.gotoAndStop("punch201_3");
      }
      else if(zone.punch_num == 3)
      {
         s_Swing4.start(0,0);
         zone.punch_num = 4;
         zone.gotoAndStop("punch201_4");
      }
      else
      {
         s_Swing5.start(0,0);
         zone.punch_num = 1;
         zone.gotoAndStop("punch201_1");
      }
   }
   else
   {
      s_Swing5.start(0,0);
      zone.punch_group = 201;
      zone.punch_num = 1;
      zone.gotoAndStop("punch201_1");
   }
}
function f_PunchSetSlam(zone)
{
   zone.punching = true;
   zone.gotoAndStop("beefy_slam");
}
function f_PunchSet300(zone)
{
   zone.punching = true;
   s_Swing5.start(0,0);
   zone.punch_group = 1;
   zone.punch_num = 1;
   zone.gotoAndStop("punch1_1");
}
function f_EnemyAttackHit(zone)
{
   var loc1 = loader.game.game.p1;
   if(Math.abs(zone.x - loc1.x) < 101)
   {
      if(Math.abs(zone.y - loc1.y) <= 10)
      {
         if(loc1.health > 0)
         {
            if(loc1.x < zone.x and loc1._xscale > 0)
            {
               var loc3 = true;
            }
            else if(loc1.x > zone.x and loc1._xscale < 0)
            {
               loc3 = true;
            }
            else
            {
               loc3 = false;
            }
            if(loc1.blocking and !loc1.ladder and loc3)
            {
               f_BlockSound();
               if(loc1.humanoid)
               {
                  loc1.gotoAndStop("block1");
                  loc1.body.body.gotoAndPlay(1);
                  loc1.punching = false;
                  loc1.punched = false;
               }
               zone.speed_toss_x = 10;
               zone.gotoAndStop("blocked");
            }
            else
            {
               f_Damage(loc1,10,DMG_MELEE,DMGFLAG_JUGGLE,random(8) + 12,- (random(10) + 10));
               if(loc1.x < zone.x and loc1._xscale < 0 or loc1.x >= zone.x and loc1._xscale > 0)
               {
                  f_FlipChar(loc1);
               }
               loc1.speed_toss_y = - (random(10) + 10);
               loc1.speed_toss_x = random(8) + 12;
               f_FX(loc1.x,loc1.body_y + loc1.y,int(loc1.y) + 7,"impact1",100,100);
               f_CallJuggle1(loc1);
               s_Punch3.start(0,0);
            }
         }
      }
   }
}
function f_EnemyAttack(zone)
{
   var loc7 = zone.x;
   var loc6 = zone.y;
   u_point.x = 0;
   u_point.y = 0;
   f_LocalToGame(zone.body.punch_pt,u_point);
   var loc5 = u_point.x;
   var loc4 = u_point.y;
   var loc13 = zone.body.punch_pt._width / 2 * (Math.abs(zone._xscale) / 100);
   var loc12 = zone.body.punch_pt._height / 2 * (Math.abs(zone._yscale) / 100);
   var loc10 = loc4 - loc12;
   var loc8 = loc4 + loc12;
   var loc11 = loc5 - loc13;
   var loc9 = loc5 + loc13;
   zone.hit_impact = false;
   if(!zone.attack_pow)
   {
      zone.attack_pow = zone.punch_pow_low;
   }
   var loc3 = undefined;
   var loc1 = undefined;
   loc1 = 1;
   while(loc1 <= total_players)
   {
      loc3 = playerArrayOb["p_pt" + int(loc1)];
      f_MeleeCheckHit(zone,loc3,loc7,loc6,loc5,loc4,loc10,loc8,loc11,loc9);
      loc1 = loc1 + 1;
   }
   if(zone.damage_all)
   {
      loc1 = 1;
      while(loc1 <= total_enemies)
      {
         loc3 = enemyArrayOb["e" + int(loc1)];
         if(loc3 != zone)
         {
            f_MeleeCheckHit(zone,loc3,loc7,loc6,loc5,loc4,loc10,loc8,loc11,loc9);
         }
         loc1 = loc1 + 1;
      }
   }
   f_MeleeImpactSound(zone);
   return zone.hit_impact;
}
function f_EnemyAttackEmbed(zone, punch_pt)
{
   var loc7 = zone.x;
   var loc6 = zone.y;
   u_point.x = 0;
   u_point.y = 0;
   f_LocalToGame(punch_pt,u_point);
   var loc5 = u_point.x;
   var loc4 = u_point.y;
   var loc13 = punch_pt._width / 2 * (Math.abs(zone._xscale) / 100);
   var loc12 = punch_pt._height / 2 * (Math.abs(zone._yscale) / 100);
   var loc10 = loc4 - loc12;
   var loc8 = loc4 + loc12;
   var loc11 = loc5 - loc13;
   var loc9 = loc5 + loc13;
   zone.hit_impact = false;
   if(!zone.attack_pow)
   {
      zone.attack_pow = zone.punch_pow_low;
   }
   var loc3 = undefined;
   var loc1 = 1;
   while(loc1 <= total_players)
   {
      loc3 = playerArrayOb["p_pt" + int(loc1)];
      f_MeleeCheckHit(zone,loc3,loc7,loc6,loc5,loc4,loc10,loc8,loc11,loc9);
      loc1 = loc1 + 1;
   }
   f_MeleeImpactSound(zone);
   return zone.hit_impact;
}
function f_FireClock(zone)
{
   if(zone.fire_timer > 0)
   {
      if(zone.health > 0 and zone.fire_timer % 30 == 0)
      {
         if(zone.fire_owner)
         {
            f_Damage(zone,zone.fire_owner.magic_sustain_pow,DMG_FIRE);
         }
         else
         {
            f_Damage(zone,1,DMG_FIRE);
         }
         f_CheckHealth(zone);
      }
      if(zone.fire_timer % 9 == 0)
      {
         f_RandomOverlay(zone,"fire_fx2");
      }
      if(zone.fire_timer % 3 == 0)
      {
         var loc2 = random(40) + 80;
         if(random(6) == 1)
         {
            var loc3 = zone.y + 1;
         }
         else
         {
            loc3 = zone.y - 1;
         }
         f_FX(zone.x + random(zone.w / 2) - zone.w / 4,zone.y + zone.body_y - random(zone.h),loc3,"fire",loc2,loc2);
      }
      if(zone.fire_timer % 15 == 0)
      {
         if(zone.body_y >= 0)
         {
            f_FX(zone.x - 20 + random(40),zone.y,zone.y + 1,"temp_flame",random(20) + 80,random(60) + 40);
         }
      }
      zone.fire_timer = zone.fire_timer - 1;
      if(zone.fire_timer <= 0)
      {
         f_ColorSwap(zone,color_default);
      }
   }
}
function f_SmokingClock(zone)
{
   if(zone.smoking_timer > 0)
   {
      if(zone.smoking_timer % 2 == 0)
      {
         var loc2 = 70 + random(30);
         var loc3 = f_FX(zone.x,zone.y + zone.body_y - 20,zone.y - 1,"smokefade",loc2,loc2);
         f_SmokeFade(loc3);
      }
      zone.smoking_timer = zone.smoking_timer - 1;
      if(zone.smoking_timer <= 0)
      {
         f_ColorSwap(zone,color_default);
      }
   }
}
function f_PaintClock(zone)
{
   if(zone.paint_timer > 0)
   {
      if(zone.paint_timer % 3 == 0)
      {
         var loc2 = 70 + random(30);
         var loc3 = f_FX(zone.x - 15 + random(30),zone.y + zone.body_y - (20 + random(10)),zone.y - 1,"paintswirl2",loc2,loc2);
         loc3.body.body.body.body.gotoAndStop(zone.paint_type);
      }
      zone.paint_timer = zone.paint_timer - 1;
   }
}
function f_BloodClock(zone)
{
   if(zone.blood_timer > 0)
   {
      f_BloodBathShrapnel(zone.x,zone.y,zone.body_y);
      zone.blood_timer = zone.blood_timer - 1;
   }
}
function f_SparkClock(zone)
{
   if(zone.spark_timer > 0)
   {
      if(zone.spark_timer % 2 == 0)
      {
         var loc2 = zone.y + 1;
         var loc3 = f_FX(zone.x,zone.y,loc2,level_dust,zone._xscale,100);
      }
      zone.spark_timer = zone.spark_timer - 1;
   }
}
function f_SparkleEffectClock(zone)
{
   if(zone.sparklefx_timer > 0)
   {
      if(zone.sparklefx_timer % 4 == 0)
      {
         f_RandomOverlay(zone,"sparkleblast_fx");
      }
      zone.sparklefx_timer = zone.sparklefx_timer - 1;
   }
}
function f_RandomOverlay(zone, name)
{
   var loc2 = random(40) + 80;
   if(random(3) == 1)
   {
      var loc3 = zone.y - 1;
   }
   else
   {
      loc3 = zone.y + 1;
   }
   if(zone.h)
   {
      var loc4 = zone.h;
   }
   else
   {
      loc4 = zone._height;
   }
   f_FX(zone.x + random(zone.w) - zone.w / 2,zone.y + zone.body_y - random(loc4),loc3,name,loc2,loc2);
}
function f_BeefyClock(zone)
{
   if(zone.beefy_timer > 0)
   {
      if(!zone.frozen)
      {
         zone.beefy_timer = zone.beefy_timer - 1;
         if(zone.beefy_timer % 30 == 0)
         {
            var loc3 = f_FX(zone.x,zone.y - 150,zone.y + 5,"beefycount",100,100);
            f_ShowVal(loc3,zone.beefy_timer / 30,color_gold);
            if(zone.beefy_timer / 30 == 1)
            {
               zone.beefy_smoke_timer = 60;
            }
         }
         if(zone.beefy_timer <= 0)
         {
            f_GoDefault(zone);
         }
      }
   }
   if(zone.beefy_smoke_timer > 0)
   {
      if(zone.beefy_smoke_timer % 2 == 0)
      {
         var loc2 = 80 + random(30);
         var loc4 = f_FX(zone.x - 40 + random(80),zone.y + zone.body_y + zone.body_table_y - random(60),zone.y + 2,"beefysmoke",loc2,loc2);
      }
      zone.beefy_smoke_timer = zone.beefy_smoke_timer - 1;
   }
}
function f_PoisonClock(zone)
{
   if(zone.poison_timer > 0)
   {
      if(zone.health > 0 and zone.poison_timer % 30 == 0)
      {
         if(zone.poison_owner)
         {
            f_Damage(zone,zone.poison_owner.magic_sustain_pow,DMG_POISON);
         }
         else
         {
            f_Damage(zone,1,DMG_POISON);
         }
         f_CheckHealth(zone);
      }
      if(zone.poison_timer % 12 == 0)
      {
         f_RandomOverlay(zone,"poison_fx2");
         f_RandomOverlay(zone,"poison_fx4");
      }
      else if(zone.poison_timer % 8 == 0)
      {
         f_RandomOverlay(zone,"poison_fx1");
         f_RandomOverlay(zone,"poison_fx2");
         f_RandomOverlay(zone,"poison_fx3");
      }
      else if(zone.poison_timer % 4 == 0)
      {
         f_RandomOverlay(zone,"poison_fx2");
      }
      zone.poison_timer = zone.poison_timer - 1;
      if(zone.poison_timer <= 0)
      {
         f_ColorSwap(zone,color_default);
      }
   }
}
function f_MagicClock(zone)
{
   var loc3 = random(40) + 80;
   var loc2 = f_FX(zone.x,zone.y,zone.y - 6,"glowset",loc3,loc3);
   loc2.magic_type = zone.magic_type;
   loc2.body._y = zone.body_y - 40;
}
function f_EnemyClock(zone)
{
   zone.punch_clock = zone.punch_clock + 1;
   if(zone.shot_timer > 0)
   {
      zone.shot_timer = zone.shot_timer - 1;
   }
   if(zone.invincible_timer > 0)
   {
      zone.invincible_timer = zone.invincible_timer - 1;
   }
   f_EnemyMagicClock(zone);
   f_PoisonClock(zone);
   f_FireClock(zone);
   f_BloodClock(zone);
   f_SmokingClock(zone);
   f_SparkClock(zone);
   f_SparkleEffectClock(zone);
}
function f_EnemyMagicClock(zone)
{
   if(zone.magic_timer > 0)
   {
      zone.magicclock = zone.magicclock + 1;
      if(zone.magic_timer >= 1)
      {
         if(zone.magicclock % 2 == 0)
         {
            var loc3 = random(40) + 80;
            var loc2 = f_FX(zone.x,zone.y,zone.y - 6,"glowset",loc3,loc3);
            loc2.magic_type = zone.magic_type;
            loc2.body._y = zone.body_y - 40;
         }
         if(zone.magic_timer > 1)
         {
            zone.magic_timer = zone.magic_timer - 1;
         }
      }
   }
}
function f_SparkShrapnel(x, y, body_y)
{
   var loc2 = random(20) + 40;
   var loc1 = f_FX(x,y,y,"spark",loc2,loc2);
   loc1.speed_x = random(10) - 5;
   loc1.speed_y = - (random(10) + 50);
   loc1.gravity = random(2) + 8;
   loc1.body._y = body_y;
   loc1.hit_function = f_ShrapnelVanish;
}
function f_StoneWallShrapnel(x, y, body_y, left)
{
   var loc2 = random(40) + 60;
   var loc1 = f_FX(x,y,y,"stonewall_shrapnel",loc2,loc2);
   loc1.speed_x = random(10);
   if(left)
   {
      loc1.speed_x *= -1;
   }
   loc1.speed_y = - (random(20) + 10);
   loc1.gravity = 8;
   loc1.body._y = body_y;
   loc1.bounces = 0;
   loc1.bounces_max = 1 + random(2);
   loc1.hit_function = f_RubbleBounce;
}
function f_DoorShrapnel(x, y, body_y, left)
{
   var loc2 = random(60) + 80;
   var loc1 = f_FX(x,y,y,"door_shrapnel",loc2,loc2);
   loc1.speed_x = random(10);
   if(left)
   {
      loc1.speed_x *= -1;
   }
   loc1.speed_y = - (random(20) + 10);
   loc1.gravity = 8;
   loc1.body._y = body_y;
   loc1.bounces = 0;
   loc1.bounces_max = 1 + random(2);
   loc1.hit_function = f_RubbleBounce;
}
function f_CannonBallBombExplode(zone)
{
   if(random(2) == 1)
   {
      s_Explosion3.start(0,0);
   }
   else
   {
      s_Explosion4.start(0,0);
   }
   f_FX(zone.x,zone.y,zone.y + 1,"area_fire",100,100);
   f_FX(zone.x,zone.y,zone.y + 1,"area_fire",-100,100);
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_SmokeFade(u_temp)
{
   u_temp.body1._rotation = random(50) - 25;
   u_temp.body1._x = random(40) - 20;
   u_temp.body1._y = random(20) - 10;
   var loc2 = random(30) + 70;
   u_temp.body1._xscale = loc2;
   u_temp.body1._yscale = loc2;
   u_temp.body2._rotation = random(50) - 25;
   u_temp.body2._x = random(40) - 20;
   u_temp.body2._y = random(20) - 10;
   loc2 = random(30) + 70;
   u_temp.body2._xscale = loc2;
   u_temp.body2._yscale = loc2;
   u_temp.body3._rotation = random(50) - 25;
   u_temp.body3._x = random(40) - 20;
   u_temp.body3._y = random(20) - 10;
   loc2 = random(30) + 70;
   u_temp.body3._xscale = loc2;
   u_temp.body3._yscale = loc2;
   u_temp.body4._rotation = random(50) - 25;
   u_temp.body4._x = random(40) - 20;
   u_temp.body4._y = random(20) - 10;
   loc2 = random(30) + 70;
   u_temp.body4._xscale = loc2;
   u_temp.body4._yscale = loc2;
}
function f_CannonBallTrail(zone)
{
   if(_root.level == 29)
   {
      zone.trail_timer = zone.trail_timer + 1;
      if(zone.trail_timer % 3 == 0)
      {
         var loc4 = random(30) + 70;
         var loc3 = f_FX(zone.x,zone.y + zone.body._y,zone.y - 1,"smokefade",100,100);
         f_SmokeFade(loc3);
      }
   }
   else
   {
      loc3 = f_FX(zone.x,zone.y + zone.body._y,zone.y - 1,"smokefade",100,100);
      f_SmokeFade(loc3);
   }
   return loc3;
}
function f_CannonBallBomb(x, y, body_y, left)
{
   var loc2 = 100;
   var loc1 = f_FX(x,y,y,"cannonball_bomb",loc2,loc2);
   loc1.speed_x = 20;
   if(left)
   {
      f_FlipChar(loc1);
      loc1.speed_x *= -1;
   }
   loc1.speed_y = -20;
   loc1.gravity = 5;
   loc1.body._y = body_y;
   loc1.bounces = 0;
   loc1.bounces_max = 0;
   loc1.hit_function = f_CannonBallBombExplode;
   return loc1;
}
function f_CannonBallExplode(zone)
{
   if(random(2) == 1)
   {
      s_Explosion3.start(0,0);
   }
   else
   {
      s_Explosion4.start(0,0);
   }
   f_ScreenShake(0.2,8,0);
   if(zone.crosshair)
   {
      f_RemoveShadow(zone.crosshair);
      zone.crosshair.gotoAndStop("remove");
      zone.crosshair = undefined;
   }
   zone.shadow_pt._xscale = 1;
   zone.shadow_pt._yscale = 1;
   zone.victim = undefined;
   zone.gotoAndStop("explosion3");
   if(_root.level == 29)
   {
      if(p_game.pillar18.active and Math.abs(zone.x - p_game.pillar18._x) < 40 and Math.abs(zone.y - p_game.pillar18._y) < 40)
      {
         p_game.pillar18.active = false;
         p_game.pillar18.gotoAndPlay(2);
      }
      if(p_game.table.active and Math.abs(zone.x - p_game.table._x) < 40 and Math.abs(zone.y - p_game.table._y) < 40)
      {
         p_game.table.active = false;
         p_game.table.gotoAndStop("die");
      }
      if(p_game.table2.active and Math.abs(zone.x - p_game.table2._x) < 40 and Math.abs(zone.y - p_game.table2._y) < 40)
      {
         p_game.table2.active = false;
         p_game.table2.gotoAndStop("die");
      }
   }
}
function f_SkeletonShrapnel(zone)
{
   if(zone.hitby.x > zone.x)
   {
      var loc5 = -1;
   }
   else
   {
      loc5 = 1;
   }
   if(zone._xscale > 0)
   {
      var loc8 = 1;
      var loc7 = -50;
   }
   else
   {
      loc8 = -1;
      loc7 = 50;
   }
   var loc4 = zone.x;
   var loc2 = zone.y;
   var loc3 = zone.body_y;
   var loc1 = f_FX(loc4,loc2,loc2 + 1,"skull",100 * loc8,100);
   loc1.speed_x = (1 + random(2)) * loc5;
   loc1.speed_y = - (2 + random(2));
   loc1.gravity = 0.5;
   loc1.body._y = loc3 - (65 + random(7));
   loc1.bounces = 0;
   loc1.bounces_max = 1;
   loc1.hit_function = f_ShrapnelBounce;
   loc1 = f_FX(loc4,loc2,loc2,"ribs",100 * loc8,100);
   loc1.speed_x = 0.5 * loc5;
   loc1.speed_y = 0;
   loc1.gravity = 0.1;
   loc1.body._y = loc3 - 30;
   loc1.bounces = 0;
   loc1.bounces_max = 1;
   loc1.hit_function = f_ShrapnelBounce;
   loc1 = f_FX(loc4 + 20,loc2,loc2,"armbone",100,100);
   loc1.speed_x = 3 * loc5;
   loc1.speed_y = -2;
   loc1.gravity = 0.4;
   loc1.body._y = loc3 - 30;
   loc1.bounces = 0;
   loc1.bounces_max = 2;
   loc1.hit_function = f_ShrapnelBounce;
   loc1 = f_FX(loc4 - 20,loc2,loc2,"armbone",100,100);
   loc1.speed_x = 2 * loc5;
   loc1.speed_y = -1;
   loc1.gravity = 0.4;
   loc1.body._y = loc3 - 30;
   loc1.bounces = 0;
   loc1.bounces_max = 2;
   loc1.hit_function = f_ShrapnelBounce;
   loc1 = f_FX(loc4 + 10,loc2,loc2,"legbone",100,100);
   loc1.speed_x = 0.1 * loc5;
   loc1.speed_y = 0;
   loc1.gravity = 0.1;
   loc1.body._y = loc3;
   loc1.bounces = 0;
   loc1.bounces_max = 10;
   loc1.hit_function = f_ShrapnelBounce;
   loc1 = f_FX(loc4 - 10,loc2,loc2,"legbone",100,100);
   loc1.speed_x = 0.1 * loc5;
   loc1.speed_y = 0;
   loc1.gravity = 0.1;
   loc1.body._y = loc3;
   loc1.bounces = 0;
   loc1.bounces_max = 10;
   loc1.hit_function = f_ShrapnelBounce;
   loc1 = f_FX(loc4 + loc7,loc2,loc2,"smallgib1",100,100);
   loc1.speed_x = 6 * loc5;
   loc1.speed_y = -8;
   loc1.gravity = 1;
   loc1.body._y = loc3 - 50;
   loc1.bounces = 0;
   loc1.bounces_max = 2;
   loc1.hit_function = f_ShrapnelBounce;
   loc1 = f_FX(loc4 + loc7,loc2,loc2,"smallgib2",100,100);
   loc1.speed_x = 8 * loc5;
   loc1.speed_y = -7;
   loc1.gravity = 1;
   loc1.body._y = loc3 - 20;
   loc1.bounces = 0;
   loc1.bounces_max = 2;
   loc1.hit_function = f_ShrapnelBounce;
   loc1 = f_FX(loc4 + loc7,loc2,loc2,"smallgib3",100,100);
   loc1.speed_x = 6 * loc5;
   loc1.speed_y = -6;
   loc1.gravity = 1;
   loc1.body._y = loc3 - 30;
   loc1.bounces = 0;
   loc1.bounces_max = 2;
   loc1.hit_function = f_ShrapnelBounce;
   loc1 = f_FX(loc4 + loc7,loc2,loc2,"smallgib4",100,100);
   loc1.speed_x = 5 * loc5;
   loc1.speed_y = -5;
   loc1.gravity = 1;
   loc1.body._y = loc3;
   loc1.bounces = 0;
   loc1.bounces_max = 2;
   loc1.hit_function = f_ShrapnelBounce;
   f_BloodBathShrapnel(loc4,loc2,loc3);
}
function f_BloodShrapnel(x, y, body_y)
{
   var loc3 = x + random(20) - 10;
   var loc2 = random(40) + 60;
   var loc1 = f_FX(loc3,y,y,"blood_drop",loc2,loc2);
   loc1.nospin = true;
   loc1.speed_x = random(30) - 15;
   loc1.speed_y = - (random(10) + 20);
   loc1.gravity = random(2) + 2;
   loc1.body._y = body_y - y + random(10) - 5;
   loc1.hit_function = f_ShrapnelVanish;
}
function f_BloodShrapnel2(x, y, body_y, noblood)
{
   var loc3 = x + random(20) - 10;
   var loc2 = random(40) + 60;
   var loc1 = f_FX(loc3,y,y,"blood_drop",loc2,loc2);
   loc1.nospin = true;
   loc1.speed_x = random(12) - 6;
   loc1.speed_y = - (random(10) + 5);
   loc1.gravity = 1;
   if(noblood)
   {
      loc1.noblood = true;
   }
   loc1.body._y = body_y - y + random(10) - 5;
   loc1.hit_function = f_ShrapnelVanish;
}
function f_GeneralShrapnel(u_temp2, x, y, body_y, u_size)
{
   var loc1 = f_FX(x,y,y,u_temp2,u_size,100);
   loc1.nospin = true;
   loc1.speed_x = random(4) + 4;
   loc1.speed_y = - (random(7) + 7);
   loc1.gravity = 2;
   loc1.body._y = body_y;
   loc1.hit_function = f_ShrapnelVanish;
   return loc1;
}
function f_MakeShrapnel(shrapnel_type, x, y, body_y, u_size)
{
   var loc1 = f_FX(x,y,y,"general_shrapnel",u_size,100);
   loc1.shrapnel_type = shrapnel_type;
   loc1.nospin = false;
   loc1.speed_x = random(6) + 4;
   if(u_size < 0)
   {
      loc1.speed_x *= -1;
   }
   loc1.speed_y = - (random(7) + 12);
   loc1.gravity = 2;
   loc1.body._y = body_y;
   loc1.bounces = 0;
   loc1.bounces_max = 2;
   loc1.hit_function = f_ShrapnelBounce;
   return loc1;
}
function f_BloodBathShrapnel(x, y, body_y, noblood)
{
   if(!noblood)
   {
      noblood = false;
   }
   f_BloodShrapnel2(x,y,body_y,noblood);
   f_BloodShrapnel2(x,y,body_y,noblood);
   f_BloodShrapnel2(x,y,body_y,noblood);
}
function f_SmokeTrail(zone)
{
   if(zone.trail_timer % 2 == 0)
   {
      var loc3 = random(30) + 30;
      var loc1 = f_FX(zone.x,zone.y,zone.y - 1,"embersmoke",100,100);
      loc1.body._xscale = loc3;
      loc1.body._yscale = loc3;
      loc1.body._rotation = random(180);
      loc1.body._y = zone.body._y;
   }
   zone.trail_timer = zone.trail_timer + 1;
}
function f_EmberBounce(zone)
{
   zone.body._xscale *= 0.6;
   zone.body._yscale *= 0.6;
   f_ShrapnelBounce(zone);
}
function f_EmberShrapnel(x, y, body_y)
{
   var loc1 = f_FX(x,y,y,"ember_shrapnel",100,100);
   loc1.nospin = true;
   loc1.speed_x = random(24) - 12;
   loc1.speed_y = - (random(16) + 10);
   loc1.trail_timer = 2;
   loc1.gravity = random(2) + 1;
   loc1.body._y = body_y;
   loc1.bounces = 0;
   loc1.bounces_max = 1;
   loc1.hit_function = f_EmberBounce;
   return loc1;
}
function f_HattyGemShrapnel(x, y, body_y, left)
{
   var loc2 = random(20) + 80;
   var loc1 = f_FX(x,y,y,"hatty_gem_shards",loc2,loc2);
   loc1.speed_x = random(15);
   if(left)
   {
      loc1.speed_x *= -1;
   }
   loc1.speed_y = - (random(10) + 30);
   loc1.gravity = random(2) + 6;
   loc1.body._y = body_y;
   loc1.bounces = 0;
   loc1.bounces_max = 1;
   loc1.hit_function = f_IceBounce;
}
function f_IceShrapnel(x, y, body_y, left)
{
   var loc2 = random(20) + 80;
   var loc1 = f_FX(x,y,y,"ice_shrapnel",loc2,loc2);
   loc1.speed_x = random(15);
   if(left)
   {
      loc1.speed_x *= -1;
   }
   loc1.speed_y = - (random(10) + 30);
   loc1.gravity = random(2) + 6;
   loc1.body._y = body_y;
   loc1.bounces = 0;
   loc1.bounces_max = 1;
   loc1.hit_function = f_IceBounce;
}
function f_EndFrozen(zone)
{
   zone.frozen = false;
   f_IceShatter(zone);
   if(zone.fp_Character == f_EnemyWalkingAwayLeft or zone.fp_Character == f_EnemyWalkingAwayRight)
   {
      zone.gotoAndStop("runscared");
   }
   else
   {
      zone.fp_StandAnim(zone);
   }
}
function f_IceShatter(zone)
{
   s_IceShatter.start(0,0);
   f_IceShrapnel(zone.x - 30,zone.y,-5,true);
   f_IceShrapnel(zone.x - 25,zone.y,-10,false);
   f_IceShrapnel(zone.x - 25,zone.y,-25,true);
   f_IceShrapnel(zone.x - 30,zone.y,-20,false);
   f_IceShrapnel(zone.x - 30,zone.y,-40,true);
   f_IceShrapnel(zone.x - 25,zone.y,-45,false);
}
function f_IceBounce(zone)
{
   zone.bounces = zone.bounces + 1;
   if(zone.bounces <= zone.bounces_max)
   {
      zone.speed_y *= -0.5;
      zone._xscale *= 0.5;
      zone._yscale *= 0.5;
   }
   else
   {
      f_ShrapnelVanish(zone);
   }
}
function f_RubbleBounce(zone)
{
   zone.bounces = zone.bounces + 1;
   if(zone.bounces <= zone.bounces_max)
   {
      zone.speed_y *= -0.5;
   }
   else
   {
      zone.speed_y = 0;
      zone.speed_x = 0;
   }
}
function f_GeneralBounce(zone)
{
   zone.bounces = zone.bounces + 1;
   if(zone.bounces <= zone.bounces_max)
   {
      zone.speed_y *= -0.5;
   }
   else
   {
      f_ShrapnelVanish(zone);
   }
}
function f_BarrelShrapnel(zone, u_temp2)
{
   var loc4 = zone.x + random(20) - 10;
   var loc3 = random(20) + 80;
   var loc2 = loc3;
   if(random(2) == 1)
   {
      loc2 *= -1;
   }
   var loc1 = f_FX(loc4,zone.y,zone.y + 2,u_temp2,loc2,loc3);
   loc1.speed_x = random(10) - 5;
   loc1.speed_y = - (random(10) + 16);
   loc1.gravity = random(2) + 3;
   loc1.bounces = 0;
   loc1.bounces_max = 1;
   loc1.body._y = - random(60);
   loc1.hit_function = f_ShrapnelBounce;
}
function f_PlankShrapnel(zone)
{
   var loc4 = zone.x + random(30) - 15;
   var loc3 = random(20) + 80;
   var loc2 = loc3;
   if(random(2) == 1)
   {
      loc2 *= -1;
   }
   var loc1 = f_FX(loc4,zone.y,zone.y + 2,"plank_shrapnel",loc2,loc3);
   loc1.speed_x = random(20) - 10;
   loc1.speed_y = - (random(10) + 25);
   loc1.gravity = random(2) + 3;
   loc1.bounces = 0;
   loc1.bounces_max = 1;
   loc1.body._y = - random(60);
   loc1.hit_function = f_ShrapnelBounce;
}
function f_MushroomShrapnelL(zone)
{
   var loc1 = f_FX(zone.x - 25,zone.y,zone.y,"mushroom1",100,100);
   loc1.speed_x = - (random(4) + 3);
   loc1.speed_y = - (random(10) + 14);
   loc1.gravity = random(2) + 2;
   loc1.bounces = 0;
   loc1.bounces_max = 1;
   loc1.hit_function = f_ShrapnelBounce;
}
function f_MushroomShrapnelR(zone)
{
   var loc1 = f_FX(zone.x + 25,zone.y,zone.y,"mushroom2",100,100);
   loc1.speed_x = random(4) + 3;
   loc1.speed_y = - (random(10) + 14);
   loc1.gravity = random(2) + 2;
   loc1.bounces = 0;
   loc1.bounces_max = 1;
   loc1.hit_function = f_ShrapnelBounce;
}
function f_StoneHeart(zone)
{
   _root.s_IceShatter.start(0,0);
   f_ScreenShake(0.2,8,zone);
   var loc3 = f_FX(zone.x - 25,zone.y,int(zone.y) + 1,"stoneheart",100,100);
   loc3.body._y -= 30;
   loc3.speed_x = - (random(4) + 3);
   loc3.speed_y = - (random(5) + 19);
   loc3.gravity = 2;
   loc3.bounces = 0;
   loc3.bounces_max = 1;
   loc3.hit_function = f_ShrapnelBounce;
   loc3 = f_FX(zone.x - 25,zone.y,int(zone.y) + 1,"stoneheart",100,100);
   loc3.body._y -= 30;
   loc3.speed_x = random(4) + 3;
   loc3.speed_y = - (random(5) + 21);
   loc3.gravity = 3;
   loc3.bounces = 0;
   loc3.bounces_max = 1;
   loc3.hit_function = f_ShrapnelBounce;
   f_MakeShrapnel(random(3) + 7,zone.x - 25 + random(50),zone.y,- random(zone.h),100);
   f_MakeShrapnel(random(3) + 7,zone.x - 25 + random(50),zone.y,- random(zone.h),-100);
   f_MakeShrapnel(random(3) + 7,zone.x - 25 + random(50),zone.y,- random(zone.h),100);
   f_MakeShrapnel(random(3) + 7,zone.x - 25 + random(50),zone.y,- random(zone.h),-100);
   zone.stone = false;
}
function f_GrassShrapnel(zone)
{
   var loc3 = zone.x + random(20) - 10;
   var loc2 = random(20) + 80;
   var loc4 = "grass" + (random(2) + 1);
   var loc1 = f_FX(loc3,zone.y,zone.y,loc4,loc2,loc2);
   loc1.speed_x = random(10) - 5;
   loc1.speed_y = - (random(10) + 8);
   loc1.gravity = random(2) + 1;
   loc1.body._y = - random(50);
   loc1.hit_function = f_ShrapnelVanish;
}
function f_ShrapnelPermaBounce(zone)
{
   zone.bounces = zone.bounces + 1;
   if(zone.bounces <= zone.bounces_max)
   {
      zone.speed_y *= -0.5;
   }
   else
   {
      zone.speed_y = 0;
      zone.body_y = 0;
      zone.body._y = 0;
   }
}
function f_ShrapnelBounce(zone)
{
   zone.bounces = zone.bounces + 1;
   if(zone.bounces <= zone.bounces_max)
   {
      zone.speed_y *= -0.5;
   }
   else
   {
      f_ShrapnelVanish(zone);
   }
}
function f_ShrapnelVanish(zone)
{
   zone.gotoAndStop("remove");
}
function f_BeeBounce(zone)
{
   zone.bounces = zone.bounces + 1;
   if(zone.bounces <= zone.bounces_max)
   {
      zone.speed_y *= -0.5;
   }
   else
   {
      f_FX(zone.x,zone.y,zone.y,"deadbee",zone._xscale,100);
      f_ShrapnelVanish(zone);
   }
}
function f_EndHit(zone)
{
   zone.stunned = false;
   if(zone.body_y < -5)
   {
      zone.speed_toss_y = -9;
      zone.speed_toss_x = 0;
      f_CallJuggle1(zone);
   }
   else
   {
      zone.fp_StandAnim(zone);
   }
}
function f_ProjectileHit(zone)
{
   var loc8 = false;
   var loc3 = undefined;
   if(zone.owner.human)
   {
      var loc4 = 1;
      while(loc4 <= active_enemies)
      {
         loc3 = enemyArrayOb["e" + int(loc4)];
         if(loc3.alive)
         {
            if(loc3.fp_CheckYSpace(loc3,zone.y))
            {
               if(zone._xscale > 0)
               {
                  if(zone.x + zone._width / 2 > loc3.zone.x - loc3.zone.w and zone.x - zone._width / 2 < loc3.zone.x + loc3.zone.w)
                  {
                     var loc9 = true;
                  }
                  else
                  {
                     loc9 = false;
                  }
               }
               else if(zone.x - zone._width / 2 < loc3.zone.x + loc3.zone.w and zone.x + zone._width / 2 > loc3.zone.x - loc3.zone.w)
               {
                  loc9 = true;
               }
               else
               {
                  loc9 = false;
               }
               if(loc9)
               {
                  var loc7 = zone.body._y + zone._y;
                  var loc6 = loc3.body_y + loc3._y;
                  if(loc7 - zone.h <= loc6)
                  {
                     if(loc7 + zone.h >= loc6 - loc3.h)
                     {
                        if(!loc3.nohit or zone.hitnohit or loc3.body_y < 0)
                        {
                           if(!(zone.splashattack and loc3.toss_clock > 0))
                           {
                              if(zone.hit_function != _root.f_ProjectileHitBoomerang)
                              {
                                 if(zone.x > loc3.zone.x)
                                 {
                                    f_SetXY(zone,loc3.zone.x + loc3.zone.w,zone.y);
                                 }
                                 else
                                 {
                                    f_SetXY(zone,loc3.zone.x - loc3.zone.w,zone.y);
                                 }
                              }
                              loc8 = true;
                              zone.victim = undefined;
                              var loc10 = loc3.directionaless_blocking or (zone.speed_x >= 0 and loc3._xscale < 0 or zone.speed_x <= 0 and loc3._xscale > 0);
                              if(!loc3.frozen and !zone.unblockable and loc3.blocking and loc10)
                              {
                                 if(loc3.humanoid)
                                 {
                                    loc3.speed_toss_x = 10;
                                    loc3.gotoAndStop("blocked");
                                    loc3.body.gotoAndPlay(1);
                                 }
                              }
                              else
                              {
                                 zone.victim = loc3;
                                 loc3.hitby = zone.owner;
                                 if(zone.speed_y > 0)
                                 {
                                    loc3.hitdown = true;
                                 }
                                 loc3.hitbydamage = zone.attack_pow;
                                 if(loc3.humanoid)
                                 {
                                    if(zone.speed_x > 0 and loc3._xscale > 0)
                                    {
                                       f_FlipChar(loc3);
                                    }
                                    else if(zone.speed_x < 0 and loc3._xscale < 0)
                                    {
                                       f_FlipChar(loc3);
                                    }
                                 }
                                 loc3.body._y = loc3.body_y + loc3.body_table_y;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         loc4 = loc4 + 1;
      }
   }
   if(!zone.owner.human or friendly_fire)
   {
      loc4 = 1;
      while(loc4 <= total_players)
      {
         loc3 = playerArrayOb["p_pt" + int(loc4)];
         if(loc3.alive and loc3 != zone.owner)
         {
            if(f_TeamCheck(zone.owner,loc3))
            {
               if(Math.abs(loc3.y - zone.y) < 10)
               {
                  if(Math.abs(loc3.x - zone.x) < zone._width / 2)
                  {
                     loc7 = zone.body._y + zone._y;
                     loc6 = loc3.body_y + loc3._y;
                     if(loc7 - zone.h <= loc6)
                     {
                        if(loc7 >= loc6 - loc3.h)
                        {
                           if(!loc3.nohit or zone.hitnohit)
                           {
                              if(!(zone.splashattack and loc3.toss_clock > 0))
                              {
                                 loc8 = true;
                                 zone.victim = undefined;
                                 var loc5 = false;
                                 if(!loc3.frozen and loc3.blocking and !zone.unblockable)
                                 {
                                    if(zone.speed_x <= 0 and loc3._xscale > 0)
                                    {
                                       loc5 = true;
                                    }
                                    else if(zone.speed_x >= 0 and loc3._xscale < 0)
                                    {
                                       loc5 = true;
                                    }
                                 }
                                 if(!loc5)
                                 {
                                    zone.victim = loc3;
                                    if(zone.hit_function != _root.f_ProjectileHitBoomerang)
                                    {
                                       if(zone.speed_x > 0 and loc3._xscale > 0)
                                       {
                                          f_FlipChar(loc3);
                                       }
                                       else if(zone.speed_x < 0 and loc3._xscale < 0)
                                       {
                                          f_FlipChar(loc3);
                                       }
                                    }
                                 }
                                 else
                                 {
                                    f_BlockSound();
                                    loc3.punching = false;
                                    loc3.punched = false;
                                    loc3.gotoAndStop("block1");
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         loc4 = loc4 + 1;
      }
   }
   return loc8;
}
function f_ProjectileHitStick(zone)
{
   _root["s_ArrowHit" + (random(3) + 1)].start(0,0);
   zone.body_y = zone.body._y;
   zone.body_r = zone.body._rotation;
   zone.gotoAndStop("arrow_stuck");
   zone.body._rotation = zone.body_r;
   zone.body._y = zone.body_y + (random(6) - 3);
   zone.body._x += random(4) - 2;
   f_RemoveShadow(zone);
}
function f_ProjectileHitStickFall(zone)
{
   s_arrowHit.start(0,0);
   var loc2 = f_FX(zone.x,zone.y + zone.body._y,zone.y + 5,"impact2",50,50);
   loc2.owner = zone.owner;
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_ProjectileHitSpark(zone)
{
   s_arrowHit.start(0,0);
   var loc2 = f_FX(zone.x,zone.y + zone.body._y,zone.y + 5,"impact2",50,50);
   loc2.owner = zone.owner;
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_ProjectileHitBoomerang(zone)
{
   if(!zone.victim.stunned)
   {
      var loc2 = f_FX(zone.x,zone.y + zone.body._y,zone.y + 5,"impact2",50,50);
      loc2.owner = zone.owner;
      if(zone.victim.humanoid)
      {
         zone.victim.stunned = true;
         if(zone.victim.horse)
         {
            zone.victim.horse.gotoAndStop("idle");
         }
         zone.victim.gotoAndStop("stun");
      }
   }
}
function f_ProjectileHitPenguin(zone)
{
   var loc3 = 100;
   if(zone._xscale < 0)
   {
      var loc4 = - loc3;
   }
   else
   {
      loc4 = loc3;
   }
   var loc2 = f_FX(zone._x,zone._y,zone._y + 5,"penguin_explode",loc4,loc3);
   loc2.body._y = zone.body._y;
   loc2.projectile_type = zone.projectile_type;
   loc2.owner = zone.owner;
   loc2.attack_pow = zone.attack_pow;
   loc2.victim = zone.victim;
   if(zone.victim)
   {
      loc2 = zone.victim;
      loc2.hitby = zone.owner;
      if(!loc2.uniquehit)
      {
         f_Damage(zone.victim,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE | DMGFLAG_SPARKLE_EFFECT,10,-6);
      }
      else
      {
         loc2.fx_x = zone.x;
         loc2.fx_y = zone.y + zone.body._y;
         loc2.fx_body_y = zone.body._y;
         zone.victim.fp_UniqueHit(zone.victim,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE | DMGFLAG_SPARKLE_EFFECT,10,-6);
      }
   }
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_ProjectileHitGeneral(zone)
{
   var loc3 = 100;
   if(zone._xscale < 0)
   {
      var loc4 = - loc3;
   }
   else
   {
      loc4 = loc3;
   }
   var loc2 = f_FX(zone._x,zone._y,zone._y + 5,"impact_general",loc4,loc3);
   loc2.body._y = zone.body._y;
   loc2.projectile_type = zone.projectile_type;
   loc2.owner = zone.owner;
   loc2.attack_pow = zone.attack_pow;
   loc2.victim = zone.victim;
   if(zone.victim)
   {
      loc2 = zone.victim;
      loc2.hitby = zone.owner;
      if(!loc2.uniquehit)
      {
         f_Damage(zone.victim,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE,10,-6);
      }
      else
      {
         loc2.fx_x = zone.x;
         loc2.fx_y = zone.y + zone.body._y;
         loc2.fx_body_y = zone.body._y;
         zone.victim.fp_UniqueHit(zone.victim,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE,10,-6);
      }
   }
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_ProjectileHitHattyGem(zone)
{
   var loc3 = 100;
   if(zone._xscale < 0)
   {
      var loc4 = - loc3;
   }
   else
   {
      loc4 = loc3;
   }
   var loc2 = f_FX(zone._x,zone._y,zone._y + 5,"impact_gem",loc4,loc3);
   loc2.body._y = zone.body._y;
   loc2.projectile_type = zone.projectile_type;
   loc2.owner = zone.owner;
   loc2.attack_pow = zone.attack_pow;
   loc2.victim = zone.victim;
   if(zone.victim)
   {
      loc2 = zone.victim;
      loc2.hitby = zone.owner;
      if(!loc2.uniquehit)
      {
         f_Damage(zone.victim,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE,10,-6);
      }
      else
      {
         loc2.fx_x = zone.x;
         loc2.fx_y = zone.y + zone.body._y;
         loc2.fx_body_y = zone.body._y;
         zone.victim.fp_UniqueHit(zone.victim,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE,10,-6);
      }
   }
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_Explosion(zone)
{
   if(!zone.owner.human or friendly_fire)
   {
      var loc1 = 1;
      while(loc1 <= players)
      {
         var loc2 = loader.game.game["p" + int(loc1)];
         if(loc2.alive)
         {
            if(f_TeamCheck(zone.owner,loc2))
            {
               f_ExplosionCheckHit(zone,loc2);
            }
         }
         loc1 = loc1 + 1;
      }
   }
   loc1 = 1;
   while(loc1 <= active_enemies)
   {
      loc2 = enemyArrayOb["e" + int(loc1)];
      if(loc2.alive)
      {
         f_ExplosionCheckHit(zone,loc2);
      }
      loc1 = loc1 + 1;
   }
}
function f_MagicExplosionCheckHit(zone, u_temp, damage_type)
{
   var loc3 = false;
   if(Math.abs(u_temp.y - zone.y) < 30)
   {
      if(Math.abs(zone.x - u_temp.x) < 60)
      {
         if(u_temp.body_y > -100 and !u_temp.nohit)
         {
            loc3 = true;
            f_Damage(u_temp,zone.magic_pow,damage_type,DMGFLAG_JUGGLE,random(16) + 1,- (random(10) + 20));
            if(zone.damage_type == DMG_POISON and u_temp.poison_timer <= 0)
            {
               u_temp.poison_owner = zone;
            }
            if(zone.damage_type == DMG_FIRE and u_temp.fire_timer <= 0)
            {
               u_temp.fire_owner = zone;
            }
         }
      }
   }
   return loc3;
}
function f_MagicExplosion(zone, damage_type)
{
   var loc4 = false;
   if(zone.human)
   {
      var loc2 = 1;
      while(loc2 <= active_enemies)
      {
         var loc1 = enemyArrayOb["e" + int(loc2)];
         if(loc1.alive)
         {
            if(f_MagicExplosionCheckHit(zone,loc1,damage_type))
            {
               loc4 = true;
            }
         }
         loc2 = loc2 + 1;
      }
   }
   if(friendly_fire or !zone.human)
   {
      loc2 = 1;
      while(loc2 <= active_players)
      {
         loc1 = playerArrayOb["p_pt" + int(loc2)];
         if(loc1.alive and loc1 != zone)
         {
            if(f_TeamCheck(zone,loc1))
            {
               if(f_MagicExplosionCheckHit(zone,loc1,damage_type))
               {
                  loc4 = true;
               }
            }
         }
         loc2 = loc2 + 1;
      }
   }
}
function f_StompCheckHit(zone, u_temp)
{
   var loc2 = false;
   if(Math.abs(u_temp.y - zone.y) < 20)
   {
      if(Math.abs(zone.x - u_temp.x) < 60)
      {
         loc2 = true;
         u_temp.nohit = false;
         f_Damage(u_temp,zone.punch_pow_medium,DMG_MELEE,DMGFLAG_JUGGLE,random(5) + 8,- (random(3) + 9));
         f_FlipInverse(u_temp,zone);
         if(u_temp._xscale < 0)
         {
            if(u_temp.x > main.right - 50)
            {
               f_FlipChar(u_temp);
            }
         }
         else if(u_temp.x < main.left + 50)
         {
            f_FlipChar(u_temp);
         }
         f_FX(u_temp.x,u_temp.body._y + u_temp.y,int(u_temp.y) + 7,"impact1",100,100);
      }
   }
   return loc2;
}
function f_StompHit(zone)
{
   var loc4 = false;
   var loc2 = 1;
   while(loc2 <= active_enemies)
   {
      var loc1 = enemyArrayOb["e" + int(loc2)];
      if(loc1.alive)
      {
         if(f_StompCheckHit(zone,loc1))
         {
            loc4 = true;
         }
      }
      loc2 = loc2 + 1;
   }
   if(friendly_fire)
   {
      loc2 = 1;
      while(loc2 <= active_players)
      {
         loc1 = playerArrayOb["p_pt" + int(loc2)];
         if(loc1.alive and loc1 != zone)
         {
            if(f_TeamCheck(zone,loc1))
            {
               if(f_StompCheckHit(zone,loc1))
               {
                  loc4 = true;
               }
            }
         }
         loc2 = loc2 + 1;
      }
   }
   if(loc4)
   {
      f_ScreenShake(0.2,8,0);
      s_Punch3.start(0,0);
   }
   else
   {
      s_Ground3.start(0,0);
   }
}
function f_FireBallTrail(zone)
{
   var loc2 = random(30) + 30;
   var loc3 = f_FX(zone.x,zone.y + zone.body._y - 10 + random(20),zone.y - 1,"smokeblast",loc2,loc2);
   loc3.body._rotation = random(180);
}
function f_PoisonBallTrail(zone)
{
   zone.trail_timer = zone.trail_timer + 1;
   if(zone.trail_timer % 2 == 0)
   {
      var loc2 = random(30) + 70;
      var loc3 = f_FX(zone.x,zone.y + zone.body._y - 10 + random(20),zone.y - 1,"poison_trail",loc2,loc2);
      loc3.body._rotation = random(360);
   }
}
function f_SpitTrail(zone)
{
   zone.trail_timer = zone.trail_timer + 1;
   if(zone.trail_timer % 3 == 0)
   {
      var loc2 = random(20) + 80;
      var loc3 = f_FX(zone.x,zone.y + zone.body._y - 10 + random(20),zone.y - 1,"spit_trail",loc2,loc2);
   }
}
function f_LightningBallTrail(zone)
{
   zone.trail_timer = zone.trail_timer + 1;
   if(zone.trail_timer % 2 == 0)
   {
      var loc2 = f_FX(zone.x,zone.y + zone.body._y,zone.y - 1,"lightning_trail",100,100);
      if(zone.trail_timer % 4 == 0)
      {
         loc2.body._yscale = -100;
      }
      if(zone._xscale < 0)
      {
         loc2._xscale = -100;
      }
   }
}
function f_BoomerangTrail(zone)
{
   zone.trail_timer = zone.trail_timer + 1;
   if(zone.trail_timer % 2 == 0)
   {
      var loc2 = f_FX(zone.x,zone._y + zone.body._y - 10 + random(20),zone._y - 1,"boomerangtrail",zone._xscale,100);
      if(zone.body._currentframe == 9)
      {
         loc2.body.body.gotoAndStop(1);
      }
      else
      {
         loc2.body.body.gotoAndStop(zone.body._currentframe);
      }
   }
}
function f_PenguinTrail(zone)
{
   zone.trail_timer = zone.trail_timer + 1;
   if(zone.trail_timer % 2 == 0)
   {
      var loc2 = f_FX(zone.x,zone._y + zone.body._y - 10 + random(20),zone._y - 1,"penguintrail",zone._xscale,100);
   }
}
function f_HattyTearTrail(zone)
{
   zone.trail_timer = zone.trail_timer + 1;
   if(zone.trail_timer % 4 == 0)
   {
      var loc2 = f_FX(zone.x,zone._y + zone.body._y - 10 + random(20),zone._y - 1,"hattyteartrail",zone._xscale,100);
   }
}
function f_DaggerTrail(zone)
{
   zone.trail_timer = zone.trail_timer + 1;
   if(zone.trail_timer % 2 == 0)
   {
      var loc2 = f_FX(zone.x,zone._y + zone.body._y - 10 + random(20),zone._y - 1,"daggertrail",zone._xscale,100);
      if(zone.body._currentframe == 10)
      {
         loc2.body.body.gotoAndStop(1);
      }
      else
      {
         loc2.body.body.gotoAndStop(zone.body._currentframe);
      }
   }
}
function f_CyclopsFireTrail(zone)
{
   zone.trail_timer = zone.trail_timer + 1;
   if(zone.trail_timer % 5 == 0)
   {
      var loc2 = f_FX(zone.x,zone._y + zone.body._y - 10 + random(20),zone._y - 1,"cyclopsfiretrail",zone._xscale,100);
   }
}
function f_GeneralTrail(zone)
{
   zone.trail_timer = zone.trail_timer + 1;
   if(zone.trail_timer % zone.trail_interval == 0)
   {
      var loc2 = f_FX(zone.x,zone._y + zone.body._y - 10 + random(20),zone._y - 1,"generaltrail",zone._xscale,100);
      loc2.projectile_type = zone.projectile_type;
   }
}
function f_BlackMagicTrail(zone)
{
   zone.trail_timer = zone.trail_timer + 1;
   if(zone.trail_timer % 3 == 0)
   {
      var loc2 = f_FX(zone.x,zone._y + zone.body._y - 10 + random(20),zone._y - 1,"blackmagictrail",zone._xscale,100);
   }
}
function f_ProjectileHitExplode(zone)
{
   if(random(2) == 1)
   {
      s_Explosion3.start(0,0);
   }
   else
   {
      s_Explosion4.start(0,0);
   }
   f_FX(zone.x,zone.y + zone.body._y,zone.y + 5,"explosion1",100,100);
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_ProjectileHitArrow(zone)
{
   s_arrowHit.start(0,0);
   var loc2 = f_FX(zone.x,zone.y + zone.body._y,zone.y + 5,"impact2",50,50);
   loc2.owner = zone.owner;
   if(zone.victim)
   {
      loc2 = zone.victim;
      loc2.fx_x = zone.x;
      loc2.fx_y = zone.y + zone.body._y;
      if(loc2.uniquehit)
      {
         loc2.fx_x = zone.x;
         loc2.fx_y = zone.y + zone.body._y;
      }
      if(!loc2.fp_UniqueHit(loc2,zone.attack_pow,zone.damage_type))
      {
         if(zone.victim.arrowplink)
         {
            f_Damage(zone.victim,zone.attack_pow,zone.damage_type);
         }
         else
         {
            f_Damage(zone.victim,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE,random(10) + 2,- (random(10) + 5));
         }
      }
   }
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_ProjectileHitPhoton(zone)
{
   var loc2 = f_FX(zone.x,zone.y + zone.body._y,zone.y + 5,"photon_hit",100,100);
   loc2.owner = zone.owner;
   loc2 = zone.victim;
   if(!loc2.blocking)
   {
      if(loc2.uniquehit)
      {
         loc2.fx_x = zone.x;
         loc2.fx_y = zone.y + zone.body._y;
      }
      if(!loc2.fp_UniqueHit(loc2,zone.attack_pow,zone.damage_type))
      {
         s_PhotonHit.start(0,0);
         f_Hit1(zone.victim);
         zone.victim.body._y = zone.victim.body_y + zone.victim.body_table_y;
         f_Damage(zone.victim,zone.attack_pow,zone.damage_type);
      }
   }
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_ProjectileHitSpit(zone)
{
   s_arrowHit.start(0,0);
   var loc2 = f_FX(zone.x,zone.y + zone.body._y,zone.y + 5,"spit_hit",100,100);
   loc2.owner = zone.owner;
   loc2 = zone.victim;
   if(!loc2.blocking)
   {
      if(loc2.uniquehit)
      {
         loc2.fx_x = zone.x;
         loc2.fx_y = zone.y + zone.body._y;
      }
      if(!zone.victim.fp_UniqueHit(zone.victim,zone.attack_pow,zone.damage_type))
      {
         f_Damage(zone.victim,zone.attack_pow,zone.damage_type,DMGFLAG_JUGGLE,random(10) + 2,- (random(10) + 5));
      }
   }
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_ProjectileHitAcid(zone)
{
   f_FX(zone.x,zone.y + zone.body._y,zone.y + 5,"acid_splash",100,100);
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_Projectile(zone)
{
   zone.trail_function(zone);
   if(f_ProjectileMove(zone,zone.speed_x) == 1)
   {
      if(level == 32 and zone.body._y == 0)
      {
         if(zone.projectile_type == 70)
         {
            zone.bounces = 1;
            zone.bounces_max = 100;
         }
         else
         {
            if(random(2) == 1)
            {
               s_Splash1.start(0,0);
            }
            else
            {
               s_Splash2.start(0,0);
            }
            f_FX(zone._x,zone._y,int(zone._y + 1),"temple_splash",50,50);
            f_RemoveShadow(zone);
            zone.shadow_pt = undefined;
            zone.gotoAndStop("remove");
         }
      }
      else if((level == 23 or level == 102) and zone.body._y == 0)
      {
         if(zone._xscale > 0)
         {
            var loc2 = -60;
         }
         else
         {
            loc2 = 60;
         }
         f_FX(zone.x,zone.y,int(zone.y + 1),"big_splash",loc2,70);
         f_RemoveShadow(zone);
         zone.shadow_pt = undefined;
         zone.gotoAndStop("remove");
      }
      else
      {
         zone.hit_function(zone);
      }
   }
   else if(zone.x + game_x > scaled_screen_width + 100 and zone.speed_x > 0 and zone.gravity <= 0)
   {
      f_RemoveShadow(zone);
      zone.shadow_pt = undefined;
      zone.gotoAndStop("remove");
   }
   else if(zone.x + game_x < -100 and zone.speed_x < 0 and zone.gravity <= 0)
   {
      f_RemoveShadow(zone);
      zone.shadow_pt = undefined;
      zone.gotoAndStop("remove");
   }
   else if(f_ProjectileHit(zone))
   {
      zone.hit_function(zone);
   }
}
function f_ProjectileBoomerang(zone)
{
   var loc3 = zone.x;
   zone.trail_function(zone);
   if(f_ProjectileMove(zone,zone.speed_x) == 1)
   {
      zone.hit_function(zone);
   }
   else if(f_ProjectileHit(zone))
   {
      zone.hit_function(zone);
   }
   var loc4 = false;
   if(zone.victim)
   {
      loc4 = zone.victim.boomerangexploit;
   }
   if(_root.boss_fight or loc4)
   {
      if(zone.speed_x > 0)
      {
         if(zone.x - zone.speed_x < loc3)
         {
            zone.x += zone.speed_x;
         }
      }
      else if(zone.speed_x < 0)
      {
         if(zone.x - zone.speed_x > loc3)
         {
            zone.x += zone.speed_x;
         }
      }
      else if(zone.x == loc3)
      {
         zone.x += zone.speed_x;
      }
   }
   if(zone.x == loc3)
   {
      if(zone.speed_return < 0 and zone.speed_x > 0)
      {
         zone.speed_x = -1;
      }
      else if(zone.speed_return > 0 and zone.speed_x < 0)
      {
         zone.speed_x = 1;
      }
   }
   var loc5 = zone.owner.y - zone.prev_y;
   zone.y += loc5;
   zone._y = zone.y;
   zone.shadow_pt._y += loc5;
   zone.prev_y = zone.owner.y;
   zone.speed_x += zone.speed_return;
   f_ObjectCheckPickups(zone);
   if(zone.x < zone.owner.x)
   {
      if(zone.speed_return < 0)
      {
         zone.owner.boomeranged = false;
         f_RemoveShadow(zone);
         zone.gotoAndStop("remove");
      }
   }
   else if(zone.x > zone.owner.x)
   {
      if(zone.speed_return > 0)
      {
         zone.owner.boomeranged = false;
         f_RemoveShadow(zone);
         zone.gotoAndStop("remove");
      }
   }
}
function f_ThrowBoomerang(zone, u_temp2)
{
   var loc1 = f_Shoot(zone,"boomerang",0,u_temp2,0,0);
   loc1.prev_y = zone.y;
   if(zone._xscale > 0)
   {
      loc1.speed_return = -1;
   }
   else
   {
      loc1.speed_return = 1;
   }
   zone.boomeranged = true;
}
function f_ArrowColor(zone)
{
   if(zone.owner)
   {
      zone.body.gotoAndStop(zone.owner.arrow_type);
   }
}
function f_ArrowColorOLD_REMOVE(zone)
{
   if(zone.owner.helmet < 5)
   {
      zone.body.gotoAndStop(zone.owner.helmet);
      return undefined;
   }
   var _loc0_ = null;
   if((_loc0_ = zone.owner.helmet) !== 26)
   {
      zone.body.gotoAndStop(6);
   }
   else
   {
      zone.body.gotoAndStop(7);
   }
}
function f_Shoot(zone, item_type, attack_pow, u_speed_x, u_speed_y, u_gravity)
{
   var loc4 = zone.body.punch_pt._y + zone.body._y + zone._y;
   if(zone._xscale > 0)
   {
      var loc3 = 100;
   }
   else
   {
      u_speed_x *= -1;
      loc3 = -100;
   }
   var loc1 = f_FX(zone.x,zone.y,zone.y + 1,item_type,loc3,100);
   loc1.n_groundtype = zone.n_groundtype;
   loc1.owner = zone;
   loc1.unblockable = false;
   loc1.attack_pow = attack_pow;
   loc1.item_type = item_type;
   loc1.body._y = loc4 - loc1._y;
   loc1.body_y = loc1.body._y;
   loc1.bounces = 0;
   loc1.bounces_max = 0;
   loc1.speed_x = u_speed_x;
   loc1.speed_y = u_speed_y;
   loc1.speed_z = 0;
   loc1.gravity = u_gravity;
   loc1.w = loc1.body._width / 2;
   loc1.shadow_pt = f_NewShadow();
   loc1.shadow_pt._x = loc1._x;
   loc1.shadow_pt._y = loc1._y;
   f_ShadowSize(loc1);
   loc1.damage_type = DMG_OBJECT;
   return loc1;
}
function f_CamelSpit(zone)
{
   var loc4 = zone.body.punch_pt._y + zone.body._y + zone._y;
   if(zone._xscale > 0)
   {
      var loc3 = 100;
      var loc5 = zone.x + 100;
      if(!zone.rider.human)
      {
         var loc6 = random(4) + 14;
      }
      else if(Key.isDown(zone.rider.button_right) or Key.isDown(zone.rider.button_walk_right))
      {
         loc6 = random(6) + 16;
      }
      else
      {
         loc6 = random(6) + 9;
      }
   }
   else
   {
      loc3 = -100;
      loc5 = zone.x - 100;
      if(!zone.rider.human)
      {
         loc6 = - (random(4) + 14);
      }
      else if(Key.isDown(zone.rider.button_left) or Key.isDown(zone.rider.button_walk_left))
      {
         loc6 = - (random(6) + 16);
      }
      else
      {
         loc6 = - (random(6) + 9);
      }
   }
   var loc1 = f_FX(loc5,zone.y,zone.y + 1,"spit",loc3,100);
   loc1.n_groundtype = zone.n_groundtype;
   loc1.owner = zone.rider;
   loc1.attack_pow = 5;
   loc1.item_type = "spit";
   loc1.body._y = loc4 - loc1._y;
   loc1.speed_x = loc6;
   loc1.speed_y = - random(4);
   loc1.speed_z = 0;
   loc1.gravity = 2;
   loc1.w = 10;
   loc1.shadow_pt = f_NewShadow();
   loc1.shadow_pt._x = loc1._x;
   loc1.shadow_pt._y = loc1._y;
   loc1.shadow_pt.shadow._xscale = 50;
   loc1.damage_type = DMG_MELEE;
   return loc1;
}
function f_FrogMagicBurp(zone)
{
   if(zone._xscale > 0)
   {
      var loc6 = -50;
      var loc5 = 100;
   }
   else
   {
      loc6 = 50;
      loc5 = -100;
   }
   var loc1 = f_FX(zone.x + loc6,zone.y,zone.y,"area_frogburp",loc5,100);
   if(zone.magic_chain > 6)
   {
      zone.magic_chain = 6;
   }
   var loc4 = f_utilNormalizeScale(1,6,zone.magic_chain);
   var loc3 = f_utilLerp(35,100,loc4);
   loc1.body.body._xscale = loc3;
   loc1.body_y = 0;
   loc1.body_table_y = 0;
   loc1.splashattack = true;
   loc1.n_groundtype = zone.n_groundtype;
   loc1.owner = zone;
   loc1.attack_pow = zone.magic_pow / 2;
   if(zone.human or zone.npc)
   {
      loc1.fp_PunchHit = f_PunchHit;
   }
   else
   {
      loc1.fp_PunchHit = f_EnemyAttack;
   }
   loc1.magic_chain = zone.magic_chain;
   loc1.current_chain = 1;
}
function f_AreaGeneral(zone, u_type)
{
   if(zone._xscale > 0)
   {
      var loc4 = 40;
      var loc3 = 100;
   }
   else
   {
      loc4 = -40;
      loc3 = -100;
   }
   var loc1 = f_FX(zone.x,zone.y,zone.y + 4,u_type,loc3,100);
   loc1.body_y = 0;
   loc1.body_table_y = 0;
   loc1.splashattack = true;
   loc1.n_groundtype = zone.n_groundtype;
   f_MoveCharH(loc1,loc4,0);
   loc1.owner = zone;
   loc1.attack_pow = zone.magic_pow / 2;
   if(zone.human or zone.npc)
   {
      loc1.fp_PunchHit = f_PunchHit;
   }
   else
   {
      loc1.fp_PunchHit = f_EnemyAttack;
   }
   loc1.magic_chain = zone.magic_chain;
   loc1.current_chain = 1;
}
function f_AreaRainbow(zone)
{
   if(zone._xscale > 0)
   {
      var loc4 = 40;
      var loc3 = 100;
   }
   else
   {
      loc4 = -40;
      loc3 = -100;
   }
   var loc1 = f_FX(zone.x,zone.y,zone.y - 6,"area_rainbow",loc3,100);
   loc1.body_y = 0;
   loc1.body_table_y = 0;
   loc1.splashattack = true;
   loc1.n_groundtype = zone.n_groundtype;
   f_MoveCharH(loc1,loc4,0);
   f_Depth(loc1,zone.y - 6);
   loc1.owner = zone;
   loc1.attack_pow = zone.magic_pow / 2;
   if(zone.human or zone.npc)
   {
      loc1.fp_PunchHit = f_PunchHit;
   }
   else
   {
      loc1.fp_PunchHit = f_EnemyAttack;
   }
   loc1.magic_chain = Math.min(zone.magic_chain,4);
   loc1.current_chain = 1;
}
function f_InitSplashChild(zone, u_temp)
{
   u_temp.splashattack = true;
   u_temp.n_groundtype = zone.n_groundtype;
   u_temp.fp_PunchHit = zone.fp_PunchHit;
   u_temp.body_y = 0;
   u_temp.body_table_y = 0;
   u_temp.owner = zone.owner;
   u_temp.current_chain = zone.current_chain + 1;
   u_temp.magic_chain = zone.magic_chain;
   u_temp.attack_type = zone.attack_type;
   u_temp.attack_pow = zone.attack_pow;
}
function f_ShootMagic(zone)
{
   if(zone.magic_type == 1)
   {
      s_AreaPoison.start(0,0);
      f_AreaGeneral(zone,"area_poison1");
   }
   else if(zone.magic_type == 2)
   {
      f_ShootLightning(zone);
   }
   else if(zone.magic_type == 3 or zone.magic_type == 27)
   {
      s_AreaIce.start(0,0);
      f_AreaGeneral(zone,"area_ice");
   }
   else if(zone.magic_type == 4)
   {
      s_AreaFire.start(0,0);
      f_AreaGeneral(zone,"area_fire1");
   }
   else if(zone.magic_type == 7)
   {
      s_AreaBarb.start(0,0);
      f_AreaGeneral(zone,"area_barb");
   }
   else if(zone.magic_type == 9 or zone.magic_type == 11)
   {
      s_AreaSawblade.start(0,0);
      f_AreaGeneral(zone,"area_buzzsaw");
   }
   else if(zone.magic_type == 10)
   {
      f_AreaGeneral(zone,"area_bees");
   }
   else if(zone.magic_type == 12)
   {
      var loc2 = f_Shoot(zone,"general_projectile",zone.magic_pow,20,0,0);
      loc2.projectile_type = 70;
      loc2.splashattack = true;
      if(zone._xscale > 0)
      {
         if(f_ProjectileMove(loc2,60) == 1)
         {
            loc2.hit_function(loc2);
         }
      }
      else if(f_ProjectileMove(loc2,-60) == 1)
      {
         loc2.hit_function(loc2);
      }
   }
   else if(zone.magic_type == 13)
   {
      s_AreaKing.start(0,0);
      loc2 = f_FX(zone.x,zone.y,zone.y + 4,"area_heal",zone._xscale,100);
      loc2.owner = zone;
   }
   else if(zone.magic_type == 14 or zone.magic_type == 15)
   {
      s_AreaEarth.start(0,0);
      f_AreaGeneral(zone,"area_earth");
   }
   else if(zone.magic_type == 21)
   {
      s_AreaNecro.start(0,0);
      f_AreaGeneral(zone,"area_skeleton");
   }
   else if(zone.magic_type == 25)
   {
      s_AreaFire.start(0,0);
      f_AreaGeneral(zone,"area_hellfire");
   }
   else if(zone.magic_type == 26)
   {
      s_AreaDark.start(0,0);
      f_AreaGeneral(zone,"area_blackmagic");
   }
   else if(zone.magic_type == 28)
   {
      s_AreaNinja.start(0,0);
      f_AreaGeneral(zone,"area_ninjasmoke");
   }
   else if(zone.magic_type == 30)
   {
      s_PinkSplashMagic.start(0,0);
      f_AreaRainbow(zone);
   }
   else if(zone.magic_type == 31)
   {
      s_PurpleSplashMagic.start(0,0);
      f_FrogMagicBurp(zone);
   }
   else if(zone.magic_type == 32)
   {
      s_HattySplashMagic.start(0,0);
      loc2 = f_FX(zone.x,zone.y,zone.y + 4,"area_whale",zone._xscale,100);
      loc2.owner = zone;
      f_AreaGeneral(zone,"area_golddrop");
   }
   else
   {
      s_AreaThief.start(0,0);
      f_AreaGeneral(zone,"area_arrows");
   }
}
function f_MagicBullet(zone)
{
   zone.jump_attack = true;
   var loc2 = undefined;
   if(zone.magic_type == 16)
   {
      s_MagicWind.start(0,0);
      f_AreaGeneral(zone,"saracenwind");
   }
   else if(zone.magic_type == 32)
   {
      loc2 = f_Shoot(zone,"hatty_tears",zone.magic_pow,20,0,0);
      loc2.projectile_type = zone.magic_type;
   }
   else
   {
      if(zone.magic_type == 12)
      {
         loc2 = f_Shoot(zone,"general_projectile",zone.magic_pow / 1.5,20,0,0);
      }
      else
      {
         loc2 = f_Shoot(zone,"general_projectile",zone.magic_pow,20,0,0);
      }
      loc2.projectile_type = zone.magic_type;
   }
}
function f_MagicBulletDown(zone)
{
   zone.jump_attack = true;
   if(zone.magic_type == 3)
   {
      s_ShootIce.start(0,0);
      f_AreaGeneral(zone,"area_ice");
   }
   else if(zone.magic_type == 31)
   {
      s_PurpleSplashMagic.start(0,0);
      f_FrogMagicBurp(zone);
   }
   else
   {
      u_temp = f_Shoot(zone,"general_projectile",zone.magic_pow,13,9,0);
      u_temp.projectile_type = zone.magic_type;
      if(zone.magic_type != 21)
      {
         u_temp.body._rotation = 45;
      }
      u_temp.body._y += 25;
   }
}
function f_CheckLightning(zone)
{
   if(Key.isDown(zone.button_punch2))
   {
      f_Magic(zone,-2);
      if(zone.magic_current > 0)
      {
         if(zone.jumping)
         {
            zone.float_timer = zone.float_timer + 1;
         }
         zone.lightning_timer = zone.lightning_timer + 1;
         zone.body.gotoAndPlay("shoot");
      }
      else
      {
         f_LightningRelease(zone);
      }
   }
   else
   {
      f_LightningRelease(zone);
   }
}
function f_GameOver()
{
   var loc2 = 1;
   while(loc2 <= total_enemies)
   {
      var loc1 = loader.game.game["e" + int(loc2)];
      if(loc1)
      {
         loc1.active = false;
         loc1.gotoAndStop("blank");
      }
      loc2 = loc2 + 1;
   }
   gotoAndStop("gameover");
}
function f_CheckHealth(zone)
{
   if(zone.health <= 0)
   {
      if(!zone.rolling)
      {
         if(zone.horse)
         {
            zone.horse.gotoAndStop("wait");
            zone.horse = undefined;
         }
         zone.alive = false;
         zone.nohit = true;
         f_DropHostage(zone);
         if(zone.beefy)
         {
            zone.gotoAndStop("beefy_die");
         }
         else if(zone.body_y < 0)
         {
            f_Juggle1Setup(zone);
            zone.gotoAndStop("juggle1");
         }
         else
         {
            s_Ground3.start(0,0);
            if(zone.p_type > 31) {
               zone.gotoAndStop("die");
            }
            else {
               zone.gotoAndStop("hitground1");
            }
         }
      }
   }
}
function f_CheckHealthPots(zone)
{
   if(zone.hud_pt)
   {
      var loc3 = GetFlashGlobal("g_nPort" + int(zone.hud_pt.port) + "State");
   }
   if(loc3 != 0 and !_root.vs_fight and zone.healthpots > 0)
   {
      zone.healthpots = zone.healthpots - 1;
      _root.f_Heal(zone,zone.health_max - zone.health);
      LOGPush(11,9,zone.hud_pt.port);
      zone.overlay.gotoAndStop("itemselect");
      zone.overlay.itemselect.gotoAndPlay(2);
      zone.overlay.itemselect.icon2.gotoAndPlay(1);
      zone.overlay.itemselect.icon.gotoAndStop(9);
      zone.overlay.itemselect.icon.healthpots.text = zone.healthpots;
      zone.alive = true;
      zone.active = true;
      _root.f_PlayerArray();
      if(!zone.healthpots)
      {
         zone.equippeditem = 0;
         zone.hud_pt.stats.item.gotoAndStop(1);
      }
      return true;
   }
   return false;
}
function f_CheckDead(zone)
{
   if(zone.health <= 0)
   {
      if(!f_CheckHealthPots(zone))
      {
         if(zone.horse)
         {
            zone.horse.gotoAndStop("wait");
            zone.horse = undefined;
         }
         zone.alive = false;
         f_PlayerArray();
         zone.nohit = true;
         if(zone.beefy)
         {
            f_DropHostage(zone);
            zone.gotoAndStop("beefy_die");
         }
         else if(zone.body_y < 0)
         {
            if(zone.speed_toss_x == undefined)
            {
               zone.hostage.speed_toss_x = 0;
            }
            if(zone.speed_toss_y == undefined)
            {
               zone.hostage.speed_toss_y = 0;
            }
            f_DropHostage(zone);
            f_Juggle1Setup(zone);
            zone.gotoAndStop("juggle1");
         }
         else
         {
            f_DropHostage(zone);
            zone.gotoAndStop("die");
         }
      }
   }
}
function f_RemoveChar(zone)
{
   if(zone)
   {
      zone.swapDepths(int(1048575 - removechar_mod));
      removechar_mod++;
      if(removechar_mod > 90)
      {
         removechar_mod = 0;
      }
      zone.removeMovieClip();
   }
}
function f_HitDummy(zone)
{
   f_PunchSound();
   zone.gotoAndStop("hit_front");
   zone.body.gotoAndPlay(1);
}
function f_ArrowHitDummy(zone)
{
   if(zone.arrow_pt.item_type == "arrow")
   {
      zone.arrow_pt.hit_function = f_ProjectileHitStick;
   }
   f_Depth(zone.arrow_pt,zone.y + 1);
}
function f_SetDummy(zone)
{
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = true;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.punch_function = f_HitDummy;
   zone.arrowhit_function = f_ArrowHitDummy;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_HitGeneral(zone)
{
   f_PunchSound();
   var dmg = 1;
   if(zone.hitby.human) {
      dmg *= zone.hitby.objectDamageMult;
   }
   zone.health -= dmg;
   if(zone.health <= 0)
   {
      zone.active = false;
      if(!zone.treasurechest)
      {
         if(zone.weapon_type)
         {
            u_temp = f_ItemSpawn(zone.x,zone.y,10);
            u_temp.weapon_type = zone.weapon_type;
         }
         else if(zone.gem_type)
         {
            u_temp = f_ItemSpawn(zone.x,zone.y,9);
            u_temp.gem_type = zone.gem_type;
         }
         else if(zone.item_type)
         {
            f_ItemSpawn(zone.x,zone.y,zone.item_type);
         }
      }
      zone.gotoAndStop("die");
   }
   else
   {
      zone.gotoAndStop("hit");
      zone.body.gotoAndPlay(1);
   }
}
function f_SetGeneral(zone, u_temp)
{
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 0;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.uniquehit = true;
   zone.fp_UniqueHit = f_UniqueTrue;
   zone.punch_function = f_HitGeneral;
   zone.arrowhit_function = f_HitGeneral;
   zone.fp_CheckYSpace = f_HumanoidCheckYSpace;
   zone.fp_Juggle = undefined;
   zone.health_max = u_temp;
   zone.health = zone.health_max;
}
function f_SetChest(zone)
{
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.uniquehit = true;
   zone.treasurechest = true;
   zone.fp_UniqueHit = f_UniqueTrue;
   zone.punch_function = f_HitGeneral;
   zone.arrowhit_function = f_HitGeneral;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
   zone.fp_Juggle = undefined;
   zone.health_max = 3;
   zone.health = zone.health_max;
}
function f_UniqueTrue(zone, attack_pow, attack_type)
{
   return true;
}
function f_HitBarrel(zone)
{
   f_PunchSound();
   var dmg = 1;
   if(zone.hitby.human) {
      dmg *= zone.hitby.objectDamageMult;
   }
   zone.health -= dmg;
   if(zone.health <= 0)
   {
      f_RemoveShadow(zone);
      f_PlankShrapnel(zone);
      f_PlankShrapnel(zone);
      f_BarrelShrapnel(zone,"barrel3");
      f_BarrelShrapnel(zone,"barrel2");
      f_BarrelShrapnel(zone,"barrel1");
      if(zone.item_type)
      {
         f_ItemSpawn(zone.x,zone.y - 1,zone.item_type);
      }
      else
      {
         var loc2 = random(5) + 2;
         f_ItemSpawn(zone.x,zone.y - 1,loc2);
      }
      zone.active = false;
      zone.gotoAndStop("die");
   }
   else
   {
      f_BarrelShrapnel(zone,"barrel3");
      zone.gotoAndStop("hit");
      zone.body.gotoAndPlay(1);
   }
}
function f_SetBarrel(zone)
{
   zone.health = 3;
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = true;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.uniquehit = true;
   zone.fp_UniqueHit = f_UniqueTrue;
   zone.punch_function = f_HitBarrel;
   zone.arrowhit_function = f_HitBarrel;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_HitRoundTable(zone)
{
   f_PunchSound();
   var dmg = 1;
   if(zone.hitby.human) {
      dmg *= zone.hitby.objectDamageMult;
   }
   zone.health -= dmg;
   if(zone.health <= 0)
   {
      if(zone.weapon_type)
      {
         u_temp = f_ItemSpawn(zone.x,zone.y,10);
         u_temp.weapon_type = zone.weapon_type;
      }
      else if(zone.item_type)
      {
         f_ItemSpawn(zone.x,zone.y,zone.item_type);
      }
      f_BarrelShrapnel(zone,"chair_shrapnel2");
      f_BarrelShrapnel(zone,"chair_shrapnel2");
      f_BarrelShrapnel(zone,"chair_shrapnel3");
      f_BarrelShrapnel(zone,"chair_shrapnel3");
      zone.active = false;
      zone.gotoAndStop("die");
   }
   else
   {
      f_BarrelShrapnel(zone,"chair_shrapnel3");
      zone.gotoAndStop("hit");
      zone.body.gotoAndPlay(1);
   }
}
function f_SetRoundTable(zone)
{
   zone.health = 3;
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.uniquehit = true;
   zone.fp_UniqueHit = f_UniqueTrue;
   zone.punch_function = f_HitRoundTable;
   zone.arrowhit_function = f_HitRoundTable;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_HitTombstone(zone)
{
   f_PunchSound();
   var dmg = 1;
   if(zone.hitby.human) {
      dmg *= zone.hitby.objectDamageMult;
   }
   zone.health -= dmg;
   if(zone.health <= 0)
   {
      f_MakeShrapnel(random(3) + 4,zone.x - 30 + random(60),zone.y,- random(zone._height),100);
      f_MakeShrapnel(random(3) + 4,zone.x - 30 + random(60),zone.y,- random(zone._height),-100);
      f_MakeShrapnel(random(3) + 4,zone.x - 30 + random(60),zone.y,- random(zone._height),100);
      f_MakeShrapnel(random(3) + 4,zone.x - 30 + random(60),zone.y,- random(zone._height),-100);
      zone.active = false;
      zone.gotoAndStop("die");
   }
   else
   {
      if(zone.hitby.x < zone.x)
      {
         f_MakeShrapnel(random(3) + 4,zone.x - 30 + random(60),zone.y,- random(zone._height),-100);
      }
      else
      {
         f_MakeShrapnel(random(3) + 4,zone.x - 30 + random(60),zone.y,- random(zone._height),100);
      }
      zone.gotoAndStop("hit");
      zone.body.gotoAndPlay(1);
   }
}
function f_SetTombstone(zone)
{
   zone.health = 3;
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.uniquehit = true;
   zone.fp_UniqueHit = f_UniqueTrue;
   zone.punch_function = f_HitTombstone;
   zone.arrowhit_function = f_HitTombstone;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_HitGenerator(zone)
{
   f_PunchSound();
   zone.health = zone.health - 1;
   if(zone.health < zone.health_max * 0.25)
   {
      if(zone.current != 4 and zone.boss)
      {
         p_game.magic.gotoAndPlay("s2");
      }
      zone.current = 4;
   }
   else if(zone.health < zone.health_max * 0.5)
   {
      if(zone.current != 3 and zone.boss)
      {
         p_game.magic.gotoAndPlay("s1");
      }
      zone.current = 3;
   }
   else if(zone.health < zone.health_max * 0.75)
   {
      zone.current = 2;
   }
   else
   {
      zone.current = 1;
   }
   if(zone.health <= 0)
   {
      if(zone.current != 5 and zone.boss)
      {
         p_game.magic.gotoAndPlay("s3");
      }
      zone.current = 5;
      f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),100);
      f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),-100);
      f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),100);
      f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),-100);
      f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),100);
      f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),-100);
      if(zone.boss)
      {
         f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),100);
         f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),-100);
         f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),100);
         f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),-100);
         f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),100);
         f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),-100);
         f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),100);
         f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),-100);
      }
      _root.s_Glass1.start(0,0);
      zone.active = false;
      zone.gotoAndStop("die");
   }
   else
   {
      if(zone.hitby.x < zone.x)
      {
         f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),-100);
      }
      else
      {
         f_MakeShrapnel(random(3) + 1,zone.x,zone.y,- random(zone._height),100);
      }
      zone.gotoAndStop("hit");
      zone.body.gotoAndPlay(1);
   }
}
function f_SetGenerator(zone, health_max)
{
   zone.health_max = health_max * active_players;
   zone.health = zone.health_max;
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.uniquehit = true;
   zone.fp_UniqueHit = f_UniqueTrue;
   zone.punch_function = f_HitGenerator;
   zone.arrowhit_function = f_HitGenerator;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_HitHayCart(zone)
{
   f_PunchSound();
   zone.health = zone.health - 1;
   if(zone.health <= 0)
   {
      f_BarrelShrapnel(zone,"hay1");
      f_BarrelShrapnel(zone,"hay2");
      f_BarrelShrapnel(zone,"hay3");
      f_BarrelShrapnel(zone,"hay4");
      f_BarrelShrapnel(zone,"hay5");
      zone.active = false;
      zone.gotoAndStop("die");
   }
   else
   {
      f_BarrelShrapnel(zone,"hay1");
      f_BarrelShrapnel(zone,"hay2");
      zone.gotoAndStop("hit");
      zone.body.gotoAndPlay(1);
   }
}
function f_SetHayCart(zone)
{
   zone.health = 4;
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = true;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.uniquehit = true;
   zone.fp_UniqueHit = f_UniqueTrue;
   zone.punch_function = f_HitHayCart;
   zone.arrowhit_function = f_HitHayCart;
   zone.fp_Juggle = undefined;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_HitPurpleTower(zone)
{
   f_PunchSound();
   zone.health = zone.health - 1;
   zone.body.gotoAndStop(100 - zone.health / zone.health_max * 100);
   if(zone.health <= 0)
   {
      f_BarrelShrapnel(zone,"purplerock2");
      f_BarrelShrapnel(zone,"purplerock1");
      f_BarrelShrapnel(zone,"purplerock1");
      zone.active = false;
      zone.gotoAndStop("die");
   }
   else
   {
      if(random(3) == 1)
      {
         f_BarrelShrapnel(zone,"purplerock2");
      }
      else
      {
         f_BarrelShrapnel(zone,"purplerock1");
      }
      zone.gotoAndPlay("hit");
   }
}
function f_SetPurpleTower(zone)
{
   zone.health = 10;
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = true;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.uniquehit = true;
   zone.fp_UniqueHit = f_UniqueTrue;
   zone.punch_function = f_HitPurpleTower;
   zone.arrowhit_function = undefined;
   zone.fp_Juggle = undefined;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_HitTree(zone)
{
   f_PunchSound();
   var dmg = 1;
   if(zone.hitby.human) {
      dmg *= zone.hitby.objectDamageMult;
   }
   zone.health -= dmg;
   if(zone.health <= 0)
   {
      zone.body.gotoAndStop(2);
      if(zone.health == 0)
      {
         u_temp = f_RandomTreeItem(zone);
      }
      else
      {
         zone.health = -1;
      }
      zone.gotoAndPlay("hit");
   }
   else
   {
      zone.gotoAndPlay("hit");
   }
}
function f_SetTree(zone)
{
   zone.health = 3;
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = true;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.uniquehit = true;
   zone.fp_UniqueHit = f_UniqueTrue;
   zone.punch_function = f_HitTree;
   zone.arrowhit_function = f_HitTree;
   zone.fp_Juggle = f_HitTree;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_HitRoundTableChair(zone)
{
   f_PunchSound();
   var dmg = 1;
   if(zone.hitby.human) {
      dmg *= zone.hitby.objectDamageMult;
   }
   zone.health -= dmg;
   if(zone.health <= 0)
   {
      f_RemoveShadow(zone);
      f_BarrelShrapnel(zone,"chair_shrapnel1");
      f_BarrelShrapnel(zone,"chair_shrapnel2");
      f_BarrelShrapnel(zone,"chair_shrapnel2");
      f_BarrelShrapnel(zone,"chair_shrapnel3");
      f_BarrelShrapnel(zone,"chair_shrapnel3");
      zone.active = false;
      zone.gotoAndStop("die");
   }
   else
   {
      f_BarrelShrapnel(zone,"chair_shrapnel3");
      zone.gotoAndStop("hit");
      zone.body.gotoAndPlay(1);
   }
}
function f_SetRoundTableChair(zone)
{
   zone.health = 3;
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = true;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.punch_function = f_HitRoundTableChair;
   zone.arrowhit_function = undefined;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_HitSiegeTower(zone)
{
   if(zone.hitby.punch_group == 4)
   {
      zone.hitby.speed_toss_x = 6;
      zone.hitby.gotoAndStop("blocked");
      zone.hitby.body.gotoAndPlay(1);
   }
   var loc4 = zone.x + random(60) - 30;
   var loc3 = random(60) + 80;
   var loc1 = f_FX(loc4,zone.y + 10,zone.y + 10,"door_shrapnel",loc3,loc3);
   loc1.speed_x = random(5) + 5;
   if(random(2) == 1)
   {
      loc1.speed_x *= -1;
   }
   loc1.speed_y = - (random(20) + 10);
   loc1.gravity = 8;
   loc1.body._y = - random(50);
   loc1.bounces = 0;
   loc1.bounces_max = 1 + random(2);
   loc1.hit_function = f_GeneralBounce;
   f_CheckDead(zone);
}
function f_HitGuardTower(zone)
{
   f_PunchSound();
   zone.gotoAndStop("hit1");
   zone.body.gotoAndPlay(1);
}
function f_SetGuardTower(zone)
{
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.health_max = 20;
   zone.health = zone.health_max;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.punch_function = f_HitGuardTower;
   zone.arrowhit_function = f_HitGuardTower;
}
function f_HitStoneWall(zone)
{
   f_PunchSound();
   var dmg = 7;
   if(zone.hitby.human) {
      dmg *= zone.hitby.objectDamageMult;
   }
   zone.n_health -= dmg;
   if(zone.n_health < 0)
   {
      zone.door.gotoAndStop(6);
      f_UnSetDoor(zone);
      zone.fp_SmashAction();
   }
   else if(zone.n_health < zone.n_health_max * 0.25)
   {
      zone.door.gotoAndStop(5);
   }
   else if(zone.n_health < zone.n_health_max * 0.5)
   {
      zone.door.gotoAndStop(4);
   }
   else if(zone.n_health < zone.n_health_max * 0.75)
   {
      zone.door.gotoAndStop(3);
   }
   else if(zone.n_health < zone.n_health_max * 0.9)
   {
      zone.door.gotoAndStop(2);
   }
   zone.gotoAndPlay("doorsmack");
}
function f_HitDoor(zone)
{
   f_PunchSound();
   var dmg = 7;
   if(zone.hitby.human) {
      dmg *= zone.hitby.objectDamageMult;
   }
   zone.n_health -= dmg;
   var loc2 = zone.hitby.y;
   if(zone.n_health < 0)
   {
      zone.door.gotoAndStop(6);
      f_UnSetDoor(zone);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
      zone.fp_SmashAction();
   }
   else if(zone.n_health < zone.n_health_max * 0.25)
   {
      zone.door.gotoAndStop(5);
      loc2 = zone.fx_y - zone.fx_body_y - 20 + random(40);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
   }
   else if(zone.n_health < zone.n_health_max * 0.5)
   {
      zone.door.gotoAndStop(4);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
   }
   else if(zone.n_health < zone.n_health_max * 0.75)
   {
      zone.door.gotoAndStop(3);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
   }
   else if(zone.n_health < zone.n_health_max * 0.9)
   {
      zone.door.gotoAndStop(2);
      f_DoorShrapnel(zone.x,loc2,zone.fx_body_y,true);
   }
   zone.gotoAndPlay("doorsmack");
}
function f_HitLavarockDoor(zone)
{
   f_PunchSound();
   zone.n_health -= 7;
   if(zone.n_health < 0)
   {
      zone.door.gotoAndStop(4);
      f_UnSetDoor(zone);
   }
   else if(zone.n_health < zone.n_health_max * 0.3)
   {
      zone.door.gotoAndStop(3);
   }
   else if(zone.n_health < zone.n_health_max * 0.7)
   {
      zone.door.gotoAndStop(2);
   }
   zone.gotoAndPlay("doorsmack");
}
function f_ArrowHitDoor(zone)
{
   if(zone.arrow_pt.item_type == "arrow")
   {
      zone.arrow_pt.hit_function = f_ProjectileHitStickFall;
   }
   zone.arrow_pt.door_pt = zone;
   f_Depth(zone.arrow_pt,zone.y + 1);
   zone.n_health = zone.n_health - 1;
}
function f_ArrowCheckFall(zone)
{
   if(zone.door_pt.shake == true)
   {
      zone.door_pt = undefined;
      zone.speed_y = - random(8);
      zone.speed_x = random(8);
      if(zone._xscale > 0)
      {
         zone.speed_x *= -1;
      }
      zone.gotoAndStop("arrow_fall");
      zone.body._y = zone.body_y;
   }
}
function f_ArrowFall(zone)
{
   zone.x += zone.speed_x;
   zone._x = zone.x;
   zone.shadow_pt._x = zone.x;
   zone.body_y += zone.speed_y;
   zone.body._y = zone.body_y;
   zone.speed_y += zone.gravity;
   f_ShadowSize(zone);
   if(zone.body_y > 0)
   {
      zone.body_y = 0;
      zone.body._y = 0;
      zone.hit_function(zone);
   }
}
function f_SetBossDoor(zone)
{
   zone.punch = false;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.punch_function = f_Null;
   zone.arrowhit_function = f_Null;
}
function f_SetDoor(zone, n_health)
{
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.punch_function = f_HitStoneWall;
   zone.arrowhit_function = f_ArrowHitDoor;
   zone.n_health = n_health;
   zone.n_health_max = n_health;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_SetWoodDoor(zone, n_health)
{
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.punch_function = f_HitDoor;
   zone.arrowhit_function = f_ArrowHitDoor;
   zone.n_health = n_health;
   zone.n_health_max = n_health;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_HitPadlockDoor(zone)
{
   f_PunchSound();
   if(zone.hitby.weapon == 22)
   {
      if(zone.locked)
      {
         zone.locked = false;
         zone.gotoAndPlay("die");
      }
   }
   else
   {
      zone.gotoAndPlay("doorsmack");
   }
}
function f_SetPadlockDoor(zone, n_health)
{
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.locked = true;
   zone.punch_function = f_HitPadlockDoor;
   zone.arrowhit_function = f_HitPadlockDoor;
   zone.health_max = health;
   zone.health = health;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_SetLavarockDoor(zone, n_health)
{
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.closed = true;
   zone.punch_function = f_HitLavarockDoor;
   zone.arrowhit_function = f_HitLavarockDoor;
   zone.n_health_max = n_health;
   zone.n_health = n_health;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
}
function f_UnSetDoor(zone)
{
   zone.punch = false;
   zone.grab = false;
   zone.has_shadow = false;
   zone.bounces = 0;
   zone.weight = 2;
   zone.explode = false;
   zone.active = false;
   zone.closed = false;
   zone.punch_function = f_Null;
   zone.arrowhit_function = f_Null;
   zone.n_health = 0;
}
function f_ExplosionCheckHit(zone, zone2)
{
   if(zone.body._y < -60)
   {
      return false;
   }
   var loc3 = false;
   if(zone.magic_type)
   {
      var loc4 = zone.magic_type;
   }
   else
   {
      loc4 = 4;
   }
   if(zone.attack_pow)
   {
      var loc5 = zone.attack_pow;
   }
   else
   {
      loc5 = 4;
   }
   if(Math.abs(zone2.y - zone.y) < zone.explosion_range_y * zone._yscale / 100)
   {
      if(Math.abs(zone.x - zone2.x) < zone.explosion_range_x * zone._xscale / 100)
      {
         if(zone2.body_y > -80)
         {
            if(!zone2.nohit and zone2.invincible_timer <= 0 and zone2 != zone.owner and zone2 != zone.victim)
            {
               loc3 = true;
               zone2.fp_FlipHit(zone,zone2);
               f_Damage(zone2,loc5,loc4,DMGFLAG_JUGGLE,random(16) + 1,- (random(15) + 25));
               f_FX(zone2.x,zone2.body._y + zone2.y,int(zone2.y) + 7,"impact1",100,100);
            }
         }
      }
   }
   return loc3;
}
function f_LevelUpAttack(zone)
{
   zone.explosion_range_x = 150;
   zone.explosion_range_y = 30;
   var loc1 = 1;
   while(loc1 <= active_enemies)
   {
      var loc2 = enemyArrayOb["e" + int(loc1)];
      if(loc2.alive)
      {
         f_ExplosionCheckHit(zone,loc2);
      }
      loc1 = loc1 + 1;
   }
}
function f_Magic(zone, u_change)
{
   if(zone.magicmode)
   {
      f_MagicClock(zone);
   }
   zone.magic_current += u_change;
   if(zone.magic_current > zone.magic_max)
   {
      zone.magic_current = zone.magic_max;
   }
   else if(zone.magic_current < 0)
   {
      zone.magic_current = 0;
   }
   var loc2 = int(101 - zone.magic_current / zone.magic_max * 100);
   zone.hud_pt.stats.magic.gotoAndStop(loc2);
}
function f_Exp(zone, u_change)
{
   if(!arenabattle)
   {
      if(boss_fight and level == 43)
      {
         return undefined;
      }
      if(zone.health <= 0)
      {
         return undefined;
      }
      var mult = 0;
      if(zone.pet.animal_type == 11)
      {
         mult += 0.1;
      }
      if(zone.expMult) {
         mult += zone.expMult; // For NPCs with buffed damage values
      }
      u_change += u_change * mult;
      if(!_root.IsFullGame() and zone.level >= 5)
      {
         return undefined;
      }
      zone.exp += u_change;
      if(zone.level >= 99)
      {
         return undefined;
      }
      if(zone.human)
      {
         if(zone.exp > zone.exp_next)
         {
            s_LevelUp.start(0,0);
            zone.exp_mod += 20;
            zone.exp_next += zone.exp_mod;
            zone.level = zone.level + 1;
            zone.levelup_timer = 60;
            zone.levelup.gotoAndPlay("go");
            if(zone.level <= 20)
            {
               zone.xpgained += 2;
            }
            else if(zone.level < 79)
            {
               zone.xpgained += 1;
            }
            SetTextNumeric(zone.hud_pt.stats.level,zone.level);
            f_UpdatePlayerAttributes(zone);
            if(zone.hud_pt)
            {
               SetRichPresence(6,zone.level,zone.hud_pt.port - 1);
            }
            if(zone.health > 0)
            {
               zone.health = zone.health_max;
               zone.magic_current = zone.magic_max;
            }
            var loc3 = int(101 - zone.health / zone.health_max * 100);
            zone.hud_pt.stats.health.gotoAndStop(loc3);
            f_UnlockCombo(zone,zone.level);
         }
         var loc4 = zone.exp_next - zone.exp_mod;
         var loc6 = zone.exp_next - loc4;
         var loc5 = zone.exp - loc4;
         loc3 = int(loc5 / loc6 * 100);
         if(loc3 < 1)
         {
            loc3 = 1;
         }
         if(loc3 > 100)
         {
            loc3 = 100;
         }
         zone.hud_pt.stats.xp.gotoAndStop(loc3);
      }
   }
}
function f_PlayerClock(zone)
{
   if(!zone.npc)
   {
      if(zone.alive)
      {
         f_ItemToggle(zone);
         if(zone.equippeditem == 9)
         {
            if(Key.isDown(zone.button_projectile))
            {
               if(!zone.pressed_projectile and !Key.isDown(zone.button_magic))
               {
                  zone.pressed_projectile = true;
                  if(zone.healthpots > 0 and zone.health < zone.health_max)
                  {
                     if(zone.health > 0)
                     {
                        zone.healthpots = zone.healthpots - 1;
                        f_Heal(zone,zone.health_max - zone.health);
                        LOGPush(11,9,zone.hud_pt.port);
                     }
                  }
                  zone.overlay.gotoAndStop("itemselect");
                  var loc3 = zone.overlay.itemselect;
                  loc3.gotoAndPlay(2);
                  loc3.icon2.gotoAndPlay(1);
                  loc3.icon.gotoAndStop(zone.equippeditem);
                  if(!zone.healthpots)
                  {
                     zone.equippeditem = 0;
                     zone.hud_pt.stats.item.gotoAndStop(1);
                  }
                  if(console_version)
                  {
                     SetTextNumeric(loc3.icon.healthpots,zone.healthpots);
                  }
                  else
                  {
                     loc3.icon.healthpots.text = zone.healthpots;
                  }
               }
            }
            else
            {
               zone.pressed_projectile = false;
            }
         }
      }
      zone.bsp_timer = zone.bsp_timer + 1;
      if(zone.bsp_timer >= 120)
      {
         f_CheckInsideBSP(zone);
         zone.bsp_timer = 0;
      }
      if(f_SZ_OnScreen(zone._x,zone._y,zone.n_height))
      {
         zone.onscreenbody = true;
         zone.onscreen = true;
         zone.warp_timer = 0;
      }
      else if(f_SZ_OnScreenBody(zone._x,zone._y,zone.n_width,zone.body_y,zone.body_y_mod))
      {
         zone.onscreenbody = true;
         zone.onscreen = false;
         zone.warp_timer = 0;
      }
      else if(!cinema)
      {
         zone.onscreenbody = false;
         zone.onscreen = false;
         if(zone.alive)
         {
            zone.warp_timer = zone.warp_timer + 1;
            if(zone.warp_timer > 30)
            {
               f_WarpIn(zone);
               zone.warp_timer = -30;
            }
         }
      }
   }
   if(zone.n_groundtype == 600)
   {
      zone.gotoAndStop("sideclimb_up");
      zone.busy = true;
      zone.ladder = true;
      zone.punching = false;
      zone.jumping = false;
      zone.jumped = false;
      zone.blocking = false;
      zone.hanging = false;
      zone.dashing = false;
      zone.jump_attack = true;
   }
   if(zone.body_y > zone.body_y_mod)
   {
      zone.body_y_mod = 0;
   }
   if(zone.invincible_timer > 0)
   {
      zone.invincible_timer = zone.invincible_timer - 1;
   }
   if(zone.inputCooldown > 0)
   {
      zone.inputCooldown--;
   }
   if(zone.dashing and zone.body_y >= 0 and !zone.punching)
   {
      zone.truespeed_timer = zone.truespeed_timer + 1;
   }
   else
   {
      zone.truespeed_timer = 0;
   }
   if(zone.truespeed_timer >= 30)
   {
      if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
      {
         if(zone.truespeed_timer == 30)
         {
            f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,zone._xscale * 1.5,150);
         }
         else if(zone.truespeed_timer == 32)
         {
            f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,zone._xscale * 1.75,175);
         }
      }
      zone.truespeed = true;
   }
   else
   {
      zone.truespeed = false;
   }
   if(zone.levelup_timer > 0)
   {
      if(zone.levelup_timer % 5 == 0)
      {
         var loc2 = zone.levelup_timer / 60 * 100;
         if(loc2 >= 30)
         {
            loc3 = f_FX(zone.x,zone.y + zone.body_y + zone.body_table_y,int(zone.y) - 1,"levelup",loc2,loc2);
            loc3.body._rotation = -20 + random(40);
            LOGPush(0,zone.level,zone.hud_pt.port);
         }
      }
      zone.levelup_timer = zone.levelup_timer - 1;
   }
   f_PoisonClock(zone);
   f_FireClock(zone);
   f_BloodClock(zone);
   f_SmokingClock(zone);
   f_PaintClock(zone);
   f_SparkClock(zone);
   f_Magic(zone,zone.magic_regen);
   f_BeefyClock(zone);
   f_SparkleEffectClock(zone);
   if(fp_Wait)
   {
      fp_Wait(zone);
   }
   /*
   if(Key.isDown(zone.button_l2) && Key.isDown(zone.button_r2)) {
      if(!zone.pressed_debug) {
         zone.pressed_debug = true;
         if(zone.p_type == 33) {
            f_SetUndead(zone, !zone.undead);
         }
         else {
            f_KillEnemies();
         }
      }
   }
   else {
      zone.pressed_debug = false;
   }
   */
}
function f_WarpIn(zone)
{
   var loc5 = undefined;
   var loc3 = undefined;
   var loc6 = undefined;
   if(_root.active_players == 1)
   {
      zone.x = f_GetWPX(f_GetClosestWaypoint(zone.x));
      zone._x = zone.x;
      zone.y = f_GetWPY(f_GetClosestWaypoint(zone.x));
      zone._y = zone.y;
      zone.shadow_pt._x = loc5;
      zone.shadow_pt._y = loc3;
      zone.body_y = -500;
      zone.body_table_y = 0;
      f_ShadowSize(zone);
      zone.body._y = zone.body_y;
      zone.jumped = true;
      zone.jumping = true;
      zone.ladder = false;
      zone.busy = false;
      zone.speed_jump = 10;
      zone.n_groundtype = 0;
      zone.gotoAndStop("jump");
      zone.body.gotoAndStop("mid");
   }
   var loc4 = undefined;
   var loc7 = undefined;
   var loc9 = undefined;
   var loc10 = undefined;
   var loc8 = undefined;
   if(zone.player_num == _root.main.n_bottomplayer)
   {
      if(main.n_topplayer and zone.player_num != main.n_top_player)
      {
         loc6 = playerArrayOb["p_pt" + int(main.n_topplayer)];
         loc4 = loc6.x;
         loc7 = loc6.y;
         loc9 = loc4 + 50;
         if(random(2))
         {
            loc9 = loc4 + 50;
         }
         loc10 = loc9 - loc4;
         loc8 = _root.f_BSPHitTest(loc4,loc7,loc9,loc7) * 0.8;
         if(!loc8)
         {
            loc8 = 1;
         }
         loc5 = loc4 + loc8 * loc10;
         loc3 = loc7;
      }
   }
   else
   {
      loc6 = playerArrayOb["p_pt" + int(main.n_bottomplayer)];
      loc4 = loc6.x;
      loc7 = loc6.y;
      loc9 = _root.main.left + 200;
      loc10 = loc9 - loc4;
      loc8 = _root.f_BSPHitTest(loc4,loc7,loc9,loc7) * 0.8;
      if(!loc8)
      {
         loc8 = 1;
      }
      loc5 = loc4 + loc8 * loc10;
      loc3 = loc7;
   }
   if(loc6)
   {
      var loc11 = loc6.n_groundtype;
      if(loc11 == 50)
      {
         f_FX(loc5 - 110,loc3 + 10,loc3 + 15,"ground_slam",100,100);
         zone.x = loc5;
         zone._x = loc5;
         zone.y = loc3;
         zone._y = loc3;
         zone.shadow_pt._x = loc5;
         zone.shadow_pt._y = loc3;
         zone.body_y = 0;
         zone.body_table_y = 0;
         f_ShadowSize(zone);
         zone.body._y = zone.body_y;
         zone.jumped = false;
         zone.jumping = false;
         zone.busy = true;
         zone.ladder = true;
         zone.n_groundtype = loc11;
         zone.gotoAndStop("climb");
         zone.body.body.stop();
      }
      else
      {
         zone.x = loc5;
         zone._x = loc5;
         zone.y = loc3;
         zone._y = loc3;
         zone.shadow_pt._x = loc5;
         zone.shadow_pt._y = loc3;
         zone.body_y = -500;
         zone.body_table_y = 0;
         f_ShadowSize(zone);
         zone.body._y = zone.body_y;
         zone.jumped = true;
         zone.jumping = true;
         zone.ladder = false;
         zone.busy = false;
         zone.speed_jump = 10;
         zone.n_groundtype = loc11;
         zone.gotoAndStop("jump");
         zone.body.gotoAndStop("mid");
      }
   }
}
function f_HumanoidDefaults(zone)
{
   zone.n_width = 60;
   zone.n_height = 75;
   zone.w = 60;
   zone.h = 75;
   zone.zone.x = zone.x;
   zone.zone.w = zone.w;
   zone.gravity = 2;
   zone.weight = 0;
   zone.weightplus = 0;
   zone.fp_Hit1 = f_Hit1Reaction;
   zone.fp_Hit2 = f_Hit2Reaction;
   zone.fp_Hit3 = f_Hit3Reaction;
   zone.fp_FlipHit = f_FlipHit;
   zone.fp_Juggle = f_Juggle1;
   zone.fp_ExtremeDeath1 = f_ExtremeDeath1;
   zone.fp_CheckYSpace = f_HumanoidCheckYSpace;
   zone.dropstuff = true;
   zone.tossable = true;
   zone.humanoid = true;
}
function f_UnresponsiveDefaults(zone)
{
   zone.fp_Hit1 = undefined;
   zone.fp_Hit2 = undefined;
   zone.fp_Hit3 = undefined;
   zone.fp_FlipHit = undefined;
   zone.fp_Juggle = undefined;
   zone.fp_ExtremeDeath1 = undefined;
   zone.fp_CheckYSpace = f_ObjectCheckYSpace;
   zone.nofight = true;
}
function f_LargeObjectRanges(zone)
{
   var loc3 = Math.abs(zone._xscale) / 100;
   var loc2 = Math.abs(zone._yscale) / 100;
   if(zone._xscale > 0)
   {
      zone.zone.x = zone.x + zone.zone._x;
   }
   else
   {
      zone.zone.x = zone.x - zone.zone._x;
   }
   zone.zone.y = zone.y + zone.zone._y;
   zone.zone.h = zone.zone._height / 2 * loc2;
   zone.zone.w = zone.zone._width / 2 * loc3;
   zone.zone.top = zone.zone.y - zone.zone.h;
   zone.zone.bottom = zone.zone.y + zone.zone.h;
   zone.zone.right = zone.zone.x + zone.zone.w;
   zone.zone.left = zone.zone.x - zone.zone.w;
}
function f_ShadowSize(zone)
{
   var shadow_x_default = 100;
   if(zone.shadowDefaultScale) {
      shadow_x_default = zone.shadowDefaultScale;
   }
   var loc1 = shadow_x_default + zone.body._y * 0.25;
   if(loc1 < 35)
   {
      loc1 = 35;
   }
   zone.shadow_pt._xscale = loc1;
   zone.shadow_pt._yscale = loc1;
}
function f_EnemyRoll(zone)
{
   if(zone._xscale > 0)
   {
      f_MoveCharH(zone,- zone.speed_toss_x,0);
   }
   else
   {
      f_MoveCharH(zone,zone.speed_toss_x,0);
   }
   zone.speed_toss_x -= 0.5;
   if(zone.speed_toss_x < 0)
   {
      zone.gotoAndStop("hitground1");
   }
   else if(zone.bounds)
   {
      f_FlipChar(zone);
   }
}
function f_Roll_UNUSED(zone)
{
   if(zone.speed_toss_x > 0)
   {
      if(zone._xscale > 0)
      {
         f_MoveCharH(zone,- zone.speed_toss_x,0);
      }
      else
      {
         f_MoveCharH(zone,zone.speed_toss_x,0);
      }
      zone.body.body._rotation -= zone.speed_toss_x;
      if(zone.bounds)
      {
         f_FlipChar(zone);
      }
      zone.body._y += zone.speed_toss_y;
      if(zone.body._y > 0)
      {
         zone.body._y = 0;
         zone.shadow_pt._xscale = 100;
         zone.shadow_pt._yscale = 100;
         if(zone.speed_toss_y > 3)
         {
            zone.speed_toss_y = int(zone.speed_toss_y * -0.35);
         }
      }
      else
      {
         var loc2 = 100 + zone.body._y * 0.25;
         if(loc2 < 10)
         {
            loc2 = 10;
         }
         zone.shadow_pt._xscale = loc2;
         zone.shadow_pt._yscale = loc2;
      }
      zone.speed_toss_x -= 0.5;
      zone.speed_toss_y = zone.speed_toss_y + 1;
   }
   else
   {
      zone.nextFrame();
   }
}
function f_StaticRange()
{
   var loc4 = static_index;
   var loc3 = 1;
   var loc1 = 1;
   while(loc1 <= static_index)
   {
      var loc2 = loader.game.game["static" + int(loc1)];
      if(loc2.x > loader.game.game.limit_topleft.x)
      {
         if(loc2.x < loader.game.game.limit_bottomright.x)
         {
            if(loc1 < loc4)
            {
               loc4 = loc1;
            }
            if(loc1 > loc3)
            {
               loc3 = loc1;
            }
         }
      }
      loc1 = loc1 + 1;
   }
   statics_min = loc4;
   total_statics = loc3;
   loc4 = object_index;
   total_objects = 0;
   loc1 = 1;
   while(loc1 <= object_index)
   {
      loc2 = loader.game.game["object" + int(loc1)];
      if(loc2._x > loader.game.game.limit_topleft.x)
      {
         if(loc2._x < loader.game.game.limit_bottomright.x)
         {
            if(loc2.active)
            {
               total_objects++;
               loader.game.game["object_pt" + int(total_objects)] = loc2;
            }
         }
      }
      loc1 = loc1 + 1;
   }
   loc4 = 1;
   loc3 = hills_total;
   loc1 = 1;
   while(loc1 <= hills_total)
   {
      loc2 = hills["hillx" + int(loc1)];
      if(loc2 < loader.game.game.limit_topleft.x)
      {
         if(loc1 > loc4)
         {
            loc4 = loc1;
         }
      }
      else if(loc2 > loader.game.game.limit_bottomright.x)
      {
         if(loc1 < loc3)
         {
            loc3 = loc1;
         }
      }
      loc1 = loc1 + 1;
   }
   if(loc3 < 2)
   {
      loc3 = 2;
   }
   hills_min = loc4;
   hills_max = loc3;
}
function f_ArrayInsert(a_theArray, cl_data)
{
   var loc1 = a_theArray.length;
   i = 0;
   while(i < loc1)
   {
      if(a_theArray[i] == undefined)
      {
         a_theArray[i] = cl_data;
         i = loc1;
      }
      i++;
   }
   if(i == loc1 - 1)
   {
      //Error("f_ArrayInsert");
   }
}
function f_ArraySplice(a_theArray, cl_data)
{
   var loc1 = a_theArray.length;
   i = 0;
   while(i < loc1)
   {
      if(a_theArray[i] == cl_data)
      {
         a_theArray[i] = undefined;
         i = loc1;
      }
      i++;
   }
   if(i < loc1)
   {
      //Error("f_ArraySplice");
   }
}
function f_ArrayNumItems(a_theArray)
{
   var loc1 = 0;
   var loc3 = a_theArray.length;
   i = 0;
   while(i < u_size)
   {
      if(a_theArray[i] != undefined)
      {
         loc1 = loc1 + 1;
      }
      i++;
   }
   return loc1;
}
function f_ArrayClear(a_theArray)
{
   var loc1 = a_theArray.length;
   i = 0;
   while(i < loc1)
   {
      a_theArray[i] = undefined;
      i++;
   }
}
function f_PickupPush(zone)
{
   total_pickups++;
   pickupArrayOb["pickup" + int(total_pickups)] = zone;
}
function f_PickupPop(zone)
{
   f_RemoveShadow(zone);
   var loc1 = 1;
   while(loc1 <= total_pickups)
   {
      var loc2 = pickupArrayOb["pickup" + int(loc1)];
      if(loc2 == zone)
      {
         if(loc1 == total_pickups)
         {
            pickupArrayOb["pickup" + int(loc1)] = undefined;
         }
         else
         {
            pickupArrayOb["pickup" + int(loc1)] = pickupArrayOb["pickup" + int(total_pickups)];
         }
         total_pickups--;
         return undefined;
      }
      loc1 = loc1 + 1;
   }
}
function f_CreatePickupArray()
{
   pickupArrayOb = undefined;
   pickupArrayOb = new Object();
   total_pickups = 0;
}
function f_ConfirmPickup(zone)
{
   var loc1 = 1;
   while(loc1 <= total_pickups)
   {
      var loc2 = pickupArrayOb["pickup" + int(loc1)];
      if(loc2 == zone)
      {
         return true;
      }
      loc1 = loc1 + 1;
   }
   return false;
}
function f_GetPickup(zone, u_temp)
{
   if(u_temp.item_type >= 2 and u_temp.item_type <= 7 or u_temp.item_type >= 15 and u_temp.item_type <= 28)
   {
      if(u_temp.item_type == 7)
      {
         if(zone.pet.animal_type == 18)
         {
            var loc6 = zone.health_max * 0.8;
            s_Pig2.start(0,0);
         }
         else
         {
            loc6 = zone.health_max * 0.5;
            s_Eat.start(0,0);
         }
      }
      else if(u_temp.item_type == 20 or u_temp.item_type == 21)
      {
         if(zone.pet.animal_type == 18)
         {
            loc6 = zone.health_max * 0.75;
            if(random(2) == 1)
            {
               s_Pig2.start(0,0);
            }
            else
            {
               s_Pig1.start(0,0);
            }
         }
         else
         {
            loc6 = zone.health_max * 0.5;
            s_Eat.start(0,0);
         }
      }
      else if(u_temp.item_type >= 15 and u_temp.item_type <= 17)
      {
         loc6 = 1;
         s_Eat.start(0,0);
      }
      else if(zone.pet.animal_type == 18)
      {
         loc6 = zone.health_max * 0.2;
         if(random(2) == 1)
         {
            s_Pig2.start(0,0);
         }
         else
         {
            s_Pig1.start(0,0);
         }
      }
      else
      {
         loc6 = zone.health_max * 0.1;
         s_Eat.start(0,0);
      }
      f_Heal(zone,loc6);
   }
   else if(u_temp.item_type == 8 or u_temp.item_type == 9 or u_temp.item_type == 13)
   {
      if(u_temp.item_type == 8)
      {
         var loc7 = 5;
      }
      else if(u_temp.item_type == 13)
      {
         loc7 = 1;
      }
      else if(u_temp.gem_type >= 12)
      {
         loc7 = 1;
      }
      else
      {
         loc7 = 5 + u_temp.gem_type;
      }
      if(!(zone.hud_pt && GetFlashGlobal("g_bHudHidden")))
      {
         var loc4 = f_FX(u_temp.x,u_temp.y,u_temp.y - 1,"item",100,100);
         loc4.targ_hud = zone.hud_pt;
         loc4.pos = new Object();
         loc4.pos.x = u_temp.x;
         loc4.pos.y = u_temp.y;
         loc4.item_type = u_temp.item_type;
         loc4.gem_type = u_temp.gem_type;
         u_temp._parent.localToGlobal(loc4.pos);
         loc4.targ_hud.stats.globalToLocal(loc4.pos);
         loc4.body.gotoAndStop("flytohud");
         loc4.body.item.gotoAndStop(u_temp.item_type);
         loc4.t = 0;
         zone.hud_pt.show_gold = true;
      }
      f_GetGold(zone,loc7);
      if(random(2) == 1)
      {
         s_Coin1.start(0,0);
      }
      else
      {
         s_Coin2.start(0,0);
      }
   }
   else if(u_temp.item_type == 10 or u_temp.item_type == 14)
   {
      if(!u_temp.weapon_type)
      {
         return false;
      }
      if(u_temp.item_type == 14)
      {
         if(!Key.isDown(zone.button_punch1))
         {
            u_temp.body.marker.gotoAndStop("on");
            _root.f_DisplayWeaponBonus(u_temp.weapon_type,u_temp.body.marker);
            return false;
         }
      }
      s_GetWeapon.start(0,0);
      var loc5 = weapon_offset + u_temp.weapon_type;
      if(zone.hud_pt.p_type != 11)
      {
         f_WeaponStats(u_temp,u_temp.weapon_type);
         if(zone.level >= u_temp.weapon_level or zone.hud_pt.default_weapon == u_temp.weapon_type)
         {
            f_GetWeapon(zone,u_temp.weapon_type);
         }
         else if(!f_IsWeaponUnlocked(zone,loc5))
         {
            f_UnlockItem(zone,loc5);
         }
      }
      else if(!f_IsWeaponUnlocked(zone,loc5))
      {
         f_UnlockItem(zone,loc5);
      }
   }
   else if(u_temp.item_type == 11)
   {
      if(!zone.hud_pt.item_unlocks[1])
      {
         zone.hud_pt.item_unlocks[1] = true;
         zone.equippeditem = 1;
         zone.overlay.gotoAndStop("itemselect");
         zone.overlay.itemselect.gotoAndPlay(2);
         zone.overlay.itemselect.icon2.gotoAndPlay(1);
         zone.overlay.itemselect.icon.gotoAndStop(u_temp.equippeditem);
         zone.overlay.itemselect.buttonpress.gotoAndStop(2);
         zone.hud_pt.stats.item.gotoAndStop(zone.equippeditem + 1);
         f_UnlockItem(zone,1);
      }
      s_GetWeapon.start(0,0);
   }
   else if(u_temp.item_type == 12 && zone.p_type != 32)
   {
      if(zone.beefies >= 9)
      {
         zone.equippeditem = 11;
         zone.overlay.gotoAndStop("itemselect");
         zone.overlay.itemselect.gotoAndPlay(2);
         zone.overlay.itemselect.icon2.gotoAndPlay(1);
         zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
         zone.hud_pt.stats.item.gotoAndStop(zone.equippeditem + 1);
         return false;
      }
      zone.beefies = zone.beefies + 1;
      if(!zone.hud_pt.item_unlocks[11])
      {
         zone.hud_pt.item_unlocks[11] = true;
      }
      zone.equippeditem = 11;
      zone.overlay.gotoAndStop("itemselect");
      zone.overlay.itemselect.gotoAndPlay(2);
      zone.overlay.itemselect.icon2.gotoAndPlay(1);
      zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
      zone.hud_pt.stats.item.gotoAndStop(zone.equippeditem + 1);
      if(console_version)
      {
         SetTextNumeric(zone.overlay.itemselect.icon.beefies,zone.beefies);
      }
      else
      {
         zone.overlay.itemselect.icon.beefies.text = zone.beefies;
      }
      s_GetWeapon.start(0,0);
   }
   else if(u_temp.item_type == 29)
   {
      if(!zone.hud_pt.item_unlocks[3])
      {
         zone.hud_pt.item_unlocks[3] = true;
         f_UnlockItem(zone,3);
      }
      zone.equippeditem = 3;
      zone.overlay.gotoAndStop("itemselect");
      zone.overlay.itemselect.gotoAndPlay(2);
      zone.overlay.itemselect.icon2.gotoAndPlay(1);
      zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
      zone.overlay.itemselect.buttonpress.gotoAndStop(2);
      zone.hud_pt.stats.item.gotoAndStop(zone.equippeditem + 1);
      s_GetWeapon.start(0,0);
   }
   else if(u_temp.item_type == 30)
   {
      if(zone.healthpots >= 5)
      {
         return false;
      }
      zone.healthpots = zone.healthpots + 1;
      zone.overlay.gotoAndStop("itemselect");
      zone.overlay.itemselect.gotoAndPlay(2);
      zone.overlay.itemselect.icon2.gotoAndPlay(1);
      zone.overlay.itemselect.icon.gotoAndStop(9);
      if(console_version)
      {
         SetTextNumeric(zone.overlay.itemselect.icon.healthpots,zone.healthpots);
      }
      else
      {
         zone.overlay.itemselect.icon.healthpots.text = zone.healthpots;
      }
   }
   else if(u_temp.item_type == 100)
   {
      zone.agility = zone.agility + 1;
      if(zone.agility > 25)
      {
         zone.agility = 25;
      }
      f_UpdatePlayerAgility(zone);
      _root.s_GetWeapon.start(0,0);
   }
   return true;
}
function f_ObjectCheckPickups(zone)
{
   var loc2 = 1;
   while(loc2 <= total_pickups)
   {
      var loc1 = pickupArrayOb["pickup" + int(loc2)];
      if(Math.abs(loc1.x - zone.x) < 50)
      {
         if(Math.abs(loc1.y - zone.y) < 20)
         {
            if(f_GetPickup(zone.owner,loc1))
            {
               loc1.body.gotoAndStop("pickup");
               f_PickupPop(loc1);
            }
         }
      }
      loc2 = loc2 + 1;
   }
}
function f_PlayerCheckPickups(zone)
{
   if(zone.body_y > -30 or zone.horse)
   {
      var loc2 = 1;
      while(loc2 <= total_pickups)
      {
         var loc1 = pickupArrayOb["pickup" + int(loc2)];
         if(Math.abs(loc1.x - zone.x) < 50)
         {
            if(Math.abs(loc1.y - zone.y) < 20)
            {
               if(zone.human or loc1.item_type < 10)
               {
                  if(f_GetPickup(zone,loc1))
                  {
                     loc1.body.gotoAndStop("pickup");
                     f_PickupPop(loc1);
                  }
               }
            }
         }
         loc2 = loc2 + 1;
      }
   }
}
function f_PlayerGetsPickups(zone)
{
   var loc2 = 1;
   while(loc2 <= total_pickups)
   {
      var loc1 = pickupArrayOb["pickup" + int(loc2)];
      if(f_OnScreen(loc1))
      {
         f_GetPickup(zone,loc1);
         loc1.body.gotoAndStop("pickup");
         f_PickupPop(loc1);
      }
      loc2 = loc2 + 1;
   }
   f_CreatePickupArray();
}
function f_PickupItem(zone)
{
   var loc3 = 1;
   while(loc3 <= total_players)
   {
      var loc2 = playerArrayOb["p_pt" + int(loc3)];
      if(loc2.alive)
      {
         if(Math.abs(loc2.x - zone.x) < 50)
         {
            if(Math.abs(loc2.y - zone.y) < 20)
            {
               if(loc2.body_y > -30 or loc2.horse)
               {
                  if(zone.item_type > 1 and zone.item_type < 8)
                  {
                     var loc4 = random(7) + 4;
                     f_Heal(loc2,loc4);
                     s_Eat.start(0,0);
                     zone.body.gotoAndStop("pickup");
                  }
                  else if(zone.item_type == 8 or zone.item_type == 10)
                  {
                     var loc5 = 50 + random(200);
                     f_GetGold(zone,loc5);
                     if(random(2) == 1)
                     {
                        s_Coin1.start(0,0);
                     }
                     else
                     {
                        s_Coin2.start(0,0);
                     }
                     zone.body.gotoAndStop("pickup");
                  }
                  else if(zone.item_type == 9)
                  {
                     if(loc2.weapon_type)
                     {
                        if(loc2.hud_pt.p_type != 11)
                        {
                           if(!f_IsWeaponUnlocked(loc2,weapon_offset + zone.weapon_type))
                           {
                              f_GetWeapon(loc2,zone.weapon_type);
                              s_GetWeapon.start(0,0);
                              zone.body.gotoAndStop("pickup");
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      loc3 = loc3 + 1;
   }
}
function f_HorseBowAdjust(zone)
{
   var loc2 = zone.horse.body._currentframe;
   switch(loc2)
   {
      case 1:
         zone.body._y = zone.body_y;
         break;
      case 2:
         zone.body._y = zone.body_y - 2;
         break;
      case 3:
         zone.body._y = zone.body_y - 4;
         break;
      case 4:
         zone.body._y = zone.body_y - 6;
         break;
      case 5:
         zone.body._y = zone.body_y - 8;
         break;
      case 6:
         zone.body._y = zone.body_y - 10;
         break;
      case 7:
         zone.body._y = zone.body_y - 7;
         break;
      case 8:
         zone.body._y = zone.body_y - 3;
         break;
      case 9:
         zone.body._y = zone.body_y - 1;
         break;
      case 10:
         zone.body._y = zone.body_y;
   }
}
function f_HorseAttack(zone)
{
   if(Key.isDown(zone.button_punch1))
   {
      if(!zone.punched and !zone.punching)
      {
         zone.punched = true;
         zone.punching = true;
         zone.horse_move = true;
         if(zone.punch_group == 20 and zone.punch_num == 1)
         {
            zone.punch_num = 2;
            s_Swing4.start(0,0);
            zone.gotoAndStop("horse_punch1_2");
         }
         else
         {
            zone.punch_group = 20;
            zone.punch_num = 1;
            s_Swing5.start(0,0);
            zone.gotoAndStop("horse_punch1_1");
         }
         zone.body.gotoAndPlay(1);
      }
   }
   else
   {
      zone.punched = false;
   }
   if(Key.isDown(zone.button_punch2))
   {
      if(!zone.punched2 and !zone.punching)
      {
         if(zone.horse.mount_type == 2 or zone.horse.mount_type == 4)
         {
            if(zone.horse.body.head._currentframe == 1)
            {
               zone.horse.punch_group = 11;
               zone.horse.punch_num = 1;
               zone.horse.body.head.gotoAndPlay("bite");
            }
         }
         else
         {
            zone.punched2 = true;
            zone.punching = true;
            zone.punch_group = 20;
            zone.punch_num = 1;
            zone.horse_move = true;
            s_Swing5.start(0,0);
            zone.gotoAndStop("horse_punch1_1");
            zone.body.gotoAndPlay(1);
         }
      }
   }
   else
   {
      zone.punched2 = false;
   }
   if(Key.isDown(zone.button_projectile))
   {
      if(!zone.pressed_projectile and !zone.punching)
      {
         zone.pressed_projectile = true;
         switch(zone.equippeditem)
         {
            case 1:
               if(zone.hud_pt.item_unlocks[1] or GetGameMode() == 3)
               {
                  zone.punching = true;
                  zone.horse_move = true;
                  zone.gotoAndStop("horse_bow");
               }
               break;
            case 2:
               zone.overlay.gotoAndStop("itemselect");
               zone.overlay.itemselect.gotoAndPlay(2);
               zone.overlay.itemselect.icon2.gotoAndPlay(1);
               zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
               break;
            case 3:
               zone.overlay.gotoAndStop("itemselect");
               zone.overlay.itemselect.gotoAndPlay(2);
               zone.overlay.itemselect.icon2.gotoAndPlay(1);
               zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
               break;
            case 6:
               zone.overlay.gotoAndStop("itemselect");
               zone.overlay.itemselect.gotoAndPlay(2);
               zone.overlay.itemselect.icon2.gotoAndPlay(1);
               zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
               break;
            case 8:
               if(zone.bombs > 0)
               {
                  zone.bombs = zone.bombs - 1;
                  if(zone.punch_pow_high > zone.magic_pow)
                  {
                     var loc2 = zone.punch_pow_high * 2;
                  }
                  else
                  {
                     loc2 = zone.magic_pow * 2;
                  }
                  u_temp = f_Shoot(zone,"general_projectile",loc2,20,0,0);
                  u_temp.projectile_type = 74;
                  u_temp.body_y = zone.body_y + zone.body_table_y - 50;
                  u_temp.body._y = u_temp.body_y;
                  u_temp.speed_x = 0;
                  u_temp.bounces = 0;
                  u_temp.bounces_max = 1;
                  u_temp.speed_y = -20;
                  u_temp.gravity = 3;
                  LOGPush(11,8,zone.hud_pt.port);
               }
               zone.overlay.gotoAndStop("itemselect");
               zone.overlay.itemselect.gotoAndPlay(2);
               zone.overlay.itemselect.icon2.gotoAndPlay(1);
               zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
               if(!zone.bombs)
               {
                  zone.equippeditem = 0;
                  zone.hud_pt.stats.item.gotoAndStop(1);
               }
               if(console_version)
               {
                  SetTextNumeric(zone.overlay.itemselect.icon.bombs,zone.bombs);
               }
               else
               {
                  zone.overlay.itemselect.icon.bombs.text = zone.bombs;
               }
               break;
            case 9:
               if(zone.healthpots > 0 and zone.health < zone.health_max)
               {
                  if(zone.health > 0)
                  {
                     zone.healthpots = zone.healthpots - 1;
                     f_Heal(zone,zone.health_max - zone.health);
                     LOGPush(11,9,zone.hud_pt.port);
                  }
               }
               zone.overlay.gotoAndStop("itemselect");
               zone.overlay.itemselect.gotoAndPlay(2);
               zone.overlay.itemselect.icon2.gotoAndPlay(1);
               zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
               if(!zone.healthpots)
               {
                  zone.equippeditem = 0;
                  zone.hud_pt.stats.item.gotoAndStop(1);
               }
               if(console_version)
               {
                  SetTextNumeric(zone.overlay.itemselect.icon.healthpots,zone.healthpots);
               }
               else
               {
                  zone.overlay.itemselect.icon.healthpots.text = zone.healthpots;
               }
               zone.punching = false;
               break;
            case 11:
               zone.overlay.gotoAndStop("itemselect");
               zone.overlay.itemselect.gotoAndPlay(2);
               zone.overlay.itemselect.icon2.gotoAndPlay(1);
               zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
         }
      }
   }
   else
   {
      zone.pressed_projectile = false;
   }
}
function f_HorseWaitCheck(zone, u_temp)
{
   if(u_temp.alive)
   {
      if(Math.abs(u_temp.x - zone.x) < 50)
      {
         if(Math.abs(u_temp.y - zone.y) < 20)
         {
            if(u_temp.body_y > -30)
            {
               if(u_temp.jumping)
               {
                  if(u_temp.speed_jump > 0 and !u_temp.beefy and !u_temp.oncatapult)
                  {
                     if(u_temp.p_type > 31) {
                        s_Fart1.start(0,0);
                        zone._yscale /= 7;
                        zone.body._y = - zone.h / 7;
                        zone.alive = false;
                     }
                     else {
                        u_temp.gotoAndStop("horse_idle");
                        u_temp.body_y = - zone.h;
                        u_temp.jumping = false;
                        u_temp.blocking = false;
                        u_temp.dashing_timer = 0;
                        u_temp.punching = false;
                        f_SetXY(u_temp,zone.x,zone.y + 1);
                        zone.fp_PunchHit = u_temp.fp_PunchHit;
                        u_temp.horse = zone;
                        if(u_temp.fp_StandAnim == f_Wait)
                        {
                           u_temp.fp_PrevHorseRide = f_HorseRide;
                           u_temp.fp_HorseRide = f_Wait;
                        }
                        else
                        {
                           u_temp.fp_HorseRide = f_HorseRide;
                        }
                        u_temp.magicmode = false;
                        zone.rider = u_temp;
                        f_SetTargets();
                        zone.gotoAndStop("idle");
                        return true;
                     }
                  }
               }
            }
         }
      }
   }
   return false;
}
function f_HorseWait(zone)
{
   if(zone.alive) {
      var loc2 = 1;
      while(loc2 <= total_players)
      {
         var loc1 = playerArrayOb["p_pt" + int(loc2)];
         if(f_HorseWaitCheck(zone,loc1))
         {
            return undefined;
         }
         loc2 = loc2 + 1;
      }
      loc2 = 1;
      while(loc2 <= active_enemies)
      {
         loc1 = enemyArrayOb["e" + int(loc2)];
         if(f_HorseWaitCheck(zone,loc1))
         {
            return undefined;
         }
         if(zone._x > main.left)
         {
            if(loc1.alive)
            {
               if(loc1.humanoid and !loc1.beefy and !loc1.horse)
               {
                  loc1.prey = zone;
                  return undefined;
               }
            }
         }
         loc2 = loc2 + 1;
      }
   }
}
function f_HorseFlee()
{
   var loc2 = 1;
   while(loc2 <= total_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc2)];
      if(loc1.horse)
      {
         loc1.horse.gotoAndStop("escape");
         loc1.horse = undefined;
         f_JumpAction(loc1);
      }
      loc2 = loc2 + 1;
   }
}
function f_HorseEscape(zone)
{
   if(zone._xscale > 0)
   {
      zone._xscale *= -1;
   }
   zone._x -= 20;
   if(zone._x < main.left - 100)
   {
      zone.active = false;
      zone.gotoAndStop("remove");
   }
}
function f_HorseJump(zone)
{
   if(zone.human)
   {
      f_Walk(zone);
      if(zone._xscale < 0)
      {
         f_FlipChar(zone);
      }
      zone.body._y = -60;
      f_SetXY(zone.horse,zone.x,zone.y - 1);
   }
}
function f_HorseRide(zone)
{
   if(zone.horse)
   {
      zone.shadow_pt._xscale = 1;
      zone.shadow_pt._yscale = 1;
      if(zone.human)
      {
         f_HorseAttack(zone);
         f_Walk(zone);
      }
      else if(zone.wait)
      {
         zone.walking = false;
      }
      else if(zone.peaceful or zone.follow)
      {
         zone.dashing = false;
         f_FollowWalkInit(zone);
         f_EnemyClose(zone);
         f_NPCWalking(zone);
      }
      else
      {
         if(zone.horse.mount_type == 4)
         {
            f_RangedWalkInit(zone);
         }
         else
         {
            f_EnemyWalkInit(zone);
         }
         f_EnemyHorseMelee(zone);
         f_EnemyClose(zone);
         f_EnemyWalk(zone);
      }
      if(zone.walking or AutoRun)
      {
         zone.dashing_timer = zone.dashing_timer + 1;
         if(zone.dashing_timer == 1 or zone.dashing_timer % 5 == 0)
         {
            if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
            {
               var loc4 = (80 + random(20)) / 100;
               var loc3 = f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,zone._xscale * loc4,100 * loc4);
               loc3._x += random(10) - 5;
               loc3._y += random(4) - 2;
            }
            if(zone.dashing_timer == 99)
            {
               zone.dashing_timer = 0;
            }
         }
         if(zone.human)
         {
            f_HorseRam(zone,1);
         }
         if(zone.horse.mount_type == 2 or zone.horse.mount_type == 4)
         {
            var loc2 = zone.horse.body.head._currentframe;
            zone.horse.gotoAndStop(zone.horse.anim_walk);
            if(loc2 > 2 and loc2 < 19 and zone.horse.body.head._currentframe == 1)
            {
               zone.horse.body.head.gotoAndPlay(loc2 + 1);
            }
         }
         else
         {
            zone.horse.gotoAndStop(zone.horse.anim_walk);
         }
         if(!zone.horse_move)
         {
            zone.gotoAndStop(zone.horse.anim_ride);
         }
      }
      else
      {
         zone.dashing_timer = 0;
         f_SetXY(zone.horse,zone.x,zone.y - 1);
         if(zone.horse.mount_type == 2 or zone.horse.mount_type == 4)
         {
            loc2 = zone.horse.body.head._currentframe;
            zone.horse.gotoAndStop("idle");
            if(loc2 > 2 and loc2 < 19 and zone.horse.body.head._currentframe == 1)
            {
               zone.horse.body.head.gotoAndPlay(loc2);
            }
         }
         else
         {
            zone.horse.gotoAndStop("idle");
         }
         if(!zone.horse_move)
         {
            zone.gotoAndStop("horse_idle");
         }
      }
      if(AutoRun)
      {
         if(zone._xscale < 0)
         {
            f_FlipChar(zone);
         }
         if(zone.horse._xscale < 0)
         {
            f_FlipChar(zone.horse);
         }
      }
      else if(zone._xscale > 0)
      {
         if(zone.horse._xscale < 0)
         {
            zone.horse._xscale *= -1;
         }
      }
      else if(zone.horse._xscale > 0)
      {
         zone.horse._xscale *= -1;
      }
      zone.body_y = - zone.horse.h;
      zone.body._y = zone.body_y;
      if(!AutoRun and zone.human)
      {
         f_Jump(zone);
      }
      else if(AutoRun)
      {
         if(zone.horse.jumper)
         {
            if(Key.isDown(zone.button_jump))
            {
               if(zone.jumped == false)
               {
                  zone.jumped = true;
                  zone.jumping = true;
                  s_DeerJump.start(0,0);
                  zone.horse.gotoAndStop("jump");
                  zone.gotoAndStop("horsejump");
                  return undefined;
               }
            }
            else
            {
               zone.jumped = false;
               return undefined;
            }
         }
      }
   }
}
function f_HorseRam(zone, u_pow)
{
   var loc4 = false;
   var loc2 = 1;
   while(loc2 <= active_enemies)
   {
      var loc1 = enemyArrayOb["e" + int(loc2)];
      if(!loc1.nohit and loc1.alive)
      {
         if(Math.abs(loc1.y - zone.y) < 15)
         {
            if(Math.abs(loc1.x - zone.x) < 50)
            {
               if(loc1.body_y > -100)
               {
                  if(!(!loc1.tossable and !loc1.scorpion))
                  {
                     if(!(loc1.scorpion and loc1.speed_toss_y < 0))
                     {
                        f_Damage(loc1,u_pow,DMG_MELEE,DMGFLAG_JUGGLE,zone._scale <= 0 ? - random(3) : random(3),- (random(6) + 25));
                        loc4 = true;
                        f_FlipSame(loc1,zone);
                     }
                  }
               }
            }
         }
      }
      loc2 = loc2 + 1;
   }
   if(loc4)
   {
      f_PunchSound();
      f_FX(zone.x,zone.body._y + zone.y,int(zone.y) + 15,"impact1",100,100);
   }
}
function f_LogRide(zone)
{
   return undefined;
}
function f_ProjectileColor(zone)
{
   f_ColorSwap(zone,zone._parent._parent.owner.charcolor);
}
function f_Legs(zone)
{
   if(zone.body_y < 0)
   {
      zone.body.legs.gotoAndStop("jump");
   }
   else
   {
      zone.body.legs.gotoAndStop("idle");
   }
}
function f_Prioritize(zone, prey)
{
   if(zone.prey == prey)
   {
      var loc2 = 1;
      while(loc2 <= active_enemies)
      {
         var loc1 = enemyArrayOb["e" + int(loc2)];
         if(loc1 != zone)
         {
            if(loc1.prey == prey)
            {
               if(loc1.priority < zone.priority)
               {
                  loc1.priority = loc1.priority + 1;
               }
            }
         }
         loc2 = loc2 + 1;
      }
      zone.priority = 1;
   }
}
function f_PickRandomPlayer()
{
   var loc1 = playerArrayOb["p_pt" + (random(active_players) + 1)];
   return loc1;
}
function f_PlayerArray()
{
   playerArrayOb = undefined;
   playerArrayOb = new Object();
   total_players = 0;
   active_players = 0;
   var loc1 = 1;
   while(loc1 <= players)
   {
      var loc2 = loader.game.game["p" + int(loc1)];
      if(loc2.alive)
      {
         total_players++;
         if(loc1 <= 4)
         {
            active_players++;
         }
         playerArrayOb["p_pt" + int(total_players)] = loc2;
      }
      loc1 = loc1 + 1;
   }
   f_SetTargets();
}
function f_SetTargets()
{
   var loc3 = 1;
   while(loc3 <= total_players)
   {
      playerArrayOb["u_priority" + int(loc3)] = 1;
      loc3 = loc3 + 1;
   }
   var loc5 = int(random(total_players));
   if(!loc5)
   {
      loc5 = 0;
   }
   switch(loc5)
   {
      case 0:
         orderArray[1] = 1;
         orderArray[2] = 2;
         orderArray[3] = 3;
         orderArray[4] = 4;
         break;
      case 1:
         orderArray[1] = 2;
         orderArray[2] = 1;
         orderArray[3] = 3;
         orderArray[4] = 4;
         break;
      case 2:
         orderArray[1] = 3;
         orderArray[2] = 2;
         orderArray[3] = 1;
         orderArray[4] = 4;
         break;
      case 3:
         orderArray[1] = 4;
         orderArray[2] = 3;
         orderArray[3] = 2;
         orderArray[4] = 1;
   }
   var loc2 = 1;
   enemyArrayOb = undefined;
   enemyArrayOb = new Object();
   wallArrayOb = undefined;
   wallArrayOb = new Object();
   active_enemies = 0;
   active_walls = 0;
   var loc4 = 1;
   while(loc4 <= total_enemies)
   {
      var loc1 = loader.game.game["e" + int(loc4)];
      if(loc1.alive)
      {
         active_enemies++;
         enemyArrayOb["e" + int(active_enemies)] = loc1;
         if(loc1.haswall)
         {
            active_walls++;
            wallArrayOb["w" + int(active_walls)] = loc1;
         }
         if(!loc1.skiptarget)
         {
            loc1.prey = playerArrayOb["p_pt" + orderArray[int(loc2)]];
            loc1.priority = playerArrayOb["u_priority" + orderArray[int(loc2)]];
            if(loc1.priority == 1)
            {
               loc1.u_mod = 90;
            }
            else if(loc1.priority == 2)
            {
               loc1.u_mod = 150;
            }
            else if(loc1.priority == 3)
            {
               loc1.u_mod = 250;
            }
            else
            {
               loc1.u_mod = 1;
            }
            if(loc1.chases)
            {
               if(playerArrayOb["u_priority" + orderArray[int(loc2)]] == 1)
               {
                  loc1.prey.hunter = loc1;
                  if(loc1.prey.npc)
                  {
                     loc1.prey.prey = loc1;
                     loc1.prey.priority = 1;
                     loc1.prey.peaceful = false;
                     loc1.prey.dashing = false;
                     loc1.prey.follow = false;
                  }
               }
               playerArrayOb["u_priority" + orderArray[int(loc2)]]++;
               u_priority++;
            }
            loc2 = loc2 + 1;
            if(loc2 > total_players)
            {
               loc2 = 1;
            }
         }
      }
      loc4 = loc4 + 1;
   }
   loc2 = 1;
   loc4 = 1;
   while(loc4 <= total_players)
   {
      loc1 = playerArrayOb["p_pt" + int(loc4)];
      if(loc1.npc)
      {
         loc1.u_mod = 90;
         if(!loc1.hunter.alive)
         {
            if(active_enemies > 0)
            {
               loc1.prey = enemyArrayOb["e" + (random(active_enemies) + 1)];
               loc1.priority = 1;
               loc1.follow = false;
            }
            else
            {
               loc1.fp_taskcomplete(loc1);
            }
         }
      }
      loc4 = loc4 + 1;
   }
}
function f_SetActiveEnemies()
{
   enemyArrayOb = undefined;
   enemyArrayOb = new Object();
   wallArrayOb = undefined;
   wallArrayOb = new Object();
   active_enemies = 0;
   active_walls = 0;
   var loc1 = 1;
   while(loc1 <= total_enemies)
   {
      var loc2 = loader.game.game["e" + int(loc1)];
      if(loc2.alive)
      {
         active_enemies++;
         enemyArrayOb["e" + int(active_enemies)] = loc2;
      }
      loc1 = loc1 + 1;
   }
}
function f_NPCFollowTarget(u_temp)
{
   u_temp.prey = playerArrayOb["p_pt" + int(i - 1)];
   u_temp.prey_num = int(i - 1);
   u_temp.peaceful = true;
}
function f_NPCPickPlayer(u_temp)
{
   if(active_players > 0)
   {
      u_temp2 = (u_temp.player_num - 4) % active_players;
      if(u_temp2 < 1)
      {
         u_temp2 = active_players;
      }
      u_temp.follow_order = Math.ceil((u_temp.player_num - 4) / active_players);
      u_temp.prey = playerArrayOb["p_pt" + u_temp2];
      u_temp.follow = true;
   }
}
function f_Guard(zone)
{
   if(zone._xscale < 0)
   {
      zone._xscale *= -1;
   }
   zone.gotoAndStop("guard");
}
function f_NPCGuard()
{
   var loc3 = 1;
   var loc2 = 1;
   while(loc2 <= total_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc2)];
      if(loc1.npc)
      {
         if(loc1.alive)
         {
            loc1.alive = false;
            loc1.prey = loader.game.game["guard" + loc3];
            loc1.prey.x = loc1.prey._x;
            loc1.prey.y = loc1.prey._y;
            loc3 = loc3 + 1;
            loc1.fp_Character = f_GoalWalk;
            loc1.fp_Goal = f_Guard;
         }
      }
      loc2 = loc2 + 1;
   }
   f_PlayerArray();
}
function f_RangedWalkInit(zone)
{
   var loc2 = zone.prey;
   var loc3 = zone.prey.hunter;
   if(zone.x < loc2.x)
   {
      if(zone._xscale < 0)
      {
         f_FlipChar(zone);
      }
   }
   else if(zone._xscale > 0)
   {
      f_FlipChar(zone);
   }
   if(zone.priority == 1)
   {
      if(zone.x < loc2.x)
      {
         zone.target_x = loc2.x - 250;
      }
      else
      {
         zone.target_x = loc2.x + 250;
      }
   }
   else if(loc3.target_x < loc2.x)
   {
      zone.target_x = loc3.target_x + zone.u_mod;
   }
   else
   {
      zone.target_x = loc3.target_x - zone.u_mod;
   }
   if(zone.target_x < main.left + 50)
   {
      zone.target_x = main.left + 50;
   }
   if(zone.target_x > main.right - 50)
   {
      zone.target_x = main.right - 50;
   }
   zone.target_y = loc2.y - 2;
   if(zone.priority > 3)
   {
      if(!zone.wander)
      {
         zone.wander = true;
         zone.temp_speed_x = zone.speed - 1 + random(3);
         zone.temp_speed_y = zone.speed - 1 + random(3);
         if(random(2) == 1 and zone.x > main.left + 50 or zone.x > main.right - 50)
         {
            zone.temp_speed_x *= -1;
         }
         if(random(2) == 1)
         {
            zone.temp_speed_y *= -1;
         }
         zone.wander_timer = random(90) + 30;
      }
      else
      {
         zone.wander_timer = zone.wander_timer - 1;
         if(zone.wander_timer <= 0)
         {
            zone.wander_timer = random(90) + 30;
            if(zone.x > main.right or zone.x < main.left)
            {
               zone.wait_timer = 0;
            }
            else
            {
               zone.wait_timer = random(90);
            }
            zone.walking = false;
            zone.fp_Wait = f_WaitTimer;
            zone.gotoAndStop("wait");
            return undefined;
         }
      }
   }
   else
   {
      if(zone.priority > 1)
      {
         var loc4 = Math.abs(zone.x - loc2.x);
         if(loc4 < 200)
         {
            zone.target_y = loc2.y - (50 - loc4 / 4);
         }
         if(zone.priority == 2)
         {
            if(loc3.x < loc2.x)
            {
               zone.target_x = loc2.x + zone.u_mod;
            }
            else
            {
               zone.target_x = loc2.x - zone.u_mod;
            }
         }
      }
      x1 = zone.x - zone.target_x;
      y1 = zone.y - zone.target_y;
      loc2 = (- zone.speed) / Math.sqrt(x1 * x1 + y1 * y1);
      zone.temp_speed_x = loc2 * x1;
      zone.temp_speed_y = loc2 * y1;
   }
   zone.walking = true;
   zone.standing = false;
   zone.busy = false;
}
function f_EnemyWalkInit(zone)
{
   var loc3 = zone.prey;
   var loc5 = zone.prey.hunter;
   if(zone.x < loc3.x)
   {
      zone.target_x = loc3.x - zone.u_mod;
      if(zone._xscale < 0)
      {
         f_FlipChar(zone);
      }
   }
   else
   {
      zone.target_x = loc3.x + zone.u_mod;
      if(zone._xscale > 0)
      {
         f_FlipChar(zone);
      }
   }
   zone.target_y = loc3.y - 1;
   if(zone.collide_h)
   {
      if(zone.target_y > zone.y)
      {
         zone.target_y = zone.y - 50;
      }
      else
      {
         zone.target_y = zone.y + 50;
      }
   }
   if(zone.collide_v)
   {
      if(zone.target_x > zone.x)
      {
         zone.target_x = zone.x - 50;
      }
      else
      {
         zone.target_x = zone.x + 50;
      }
   }
   zone.collide_v = false;
   zone.collide_h = false;
   zone.walking = true;
   zone.standing = false;
   zone.busy = false;
   if(zone.priority > 3)
   {
      if(!zone.wander)
      {
         zone.wander = true;
         zone.temp_speed_x = zone.speed - 1 + random(3);
         zone.temp_speed_y = zone.speed - 1 + random(3);
         if(random(2) == 1 and zone.x > main.left + 50 or zone.x > main.right - 50)
         {
            zone.temp_speed_x *= -1;
         }
         if(random(2) == 1)
         {
            zone.temp_speed_y *= -1;
         }
         if(zone.y > _root.main.bottom - 10)
         {
            if(zone.temp_speed_y > 0)
            {
               zone.temp_speed_y *= -1;
            }
         }
         zone.wander_timer = random(90) + 30;
      }
      else
      {
         zone.wander_timer = zone.wander_timer - 1;
         if(zone.wander_timer <= 0)
         {
            zone.wander_timer = random(90) + 30;
            if(zone.x > main.right or zone.x < main.left or zone.y > main.bottom)
            {
               zone.wait_timer = 0;
            }
            else
            {
               zone.wait_timer = random(90);
            }
            zone.walking = false;
            zone.fp_Wait = f_WaitTimer;
            zone.gotoAndStop("wait");
            return undefined;
         }
      }
   }
   else
   {
      if(zone.priority > 1)
      {
         var loc4 = Math.abs(zone.x - loc3.x);
         if(loc4 < 200)
         {
            zone.target_y = loc3.y - (100 - loc4 / 2);
         }
         if(zone.priority == 2)
         {
            if(loc5.x < loc3.x)
            {
               zone.target_x = loc3.x + zone.u_mod;
            }
            else
            {
               zone.target_x = loc3.x - zone.u_mod;
            }
         }
      }
      x1 = zone.x - zone.target_x;
      y1 = zone.y - zone.target_y;
      scale = (- zone.speed) / Math.sqrt(x1 * x1 + y1 * y1);
      zone.temp_speed_x = scale * x1;
      zone.temp_speed_y = scale * y1;
      if(zone.priority != 1)
      {
         zone.temp_speed_x *= 0.7;
         zone.temp_speed_y *= 0.7;
      }
   }
}
function f_EnemyWalkInit_EXPERIMENT(zone)
{
   var loc2 = f_GetClosestWaypoint(zone.x);
   if(f_GetWPX(loc2) < zone.x)
   {
      var loc3 = loc2;
      var loc4 = loc2 + 1;
   }
   else
   {
      loc3 = loc2 - 1;
      loc4 = loc2;
   }
   if(zone.x < zone.prey.x)
   {
      if(zone._xscale < 0)
      {
         f_FlipChar(zone);
      }
      if(f_GetWPX(loc4) - zone.x < zone.prey.x - zone.x)
      {
         zone.target_x = f_GetWPX(loc4) + zone.speed;
         zone.target_y = f_GetWPY(loc4);
      }
      else
      {
         zone.target_x = zone.prey.x;
         zone.target_y = zone.prey.y;
      }
   }
   else
   {
      if(zone._xscale > 0)
      {
         f_FlipChar(zone);
      }
      if(zone.x - f_GetWPX(loc3) > zone.x - zone.prey.x)
      {
         zone.target_x = f_GetWPX(loc3) - zone.speed;
         zone.target_y = f_GetWPY(loc3);
      }
      else
      {
         zone.target_x = zone.prey.x;
         zone.target_y = zone.prey.y;
      }
   }
   x1 = zone.x - zone.target_x;
   y1 = zone.y - zone.target_y;
   scale = (- zone.speed) / Math.sqrt(x1 * x1 + y1 * y1);
   zone.temp_speed_x = scale * x1;
   zone.temp_speed_y = scale * y1;
   zone.last_x = zone.temp_speed_x;
   zone.last_y = zone.temp_speed_y;
   zone.walking = true;
   zone.standing = false;
   zone.busy = false;
}
function f_RemoveNPC(zone)
{
   zone.alive = false;
   zone.active = false;
   if(zone.pet)
   {
      zone.pet.gotoAndStop("lost");
      zone.pet.owner = undefined;
      zone.pet = undefined;
   }
   zone.gotoAndStop("blank");
   f_RemoveShadow(zone);
   f_PlayerArray();
   f_SetTargets();
}
function f_EnemyWalkingAwayLeft(zone)
{
   zone.nohit = false;
   zone.onground = false;
   zone.fp_WalkAnim(zone);
   if(zone._xscale > 0)
   {
      f_FlipChar(zone);
   }
   f_MoveCharH(zone,- zone.speed,0);
   f_RemovalLeft(zone);
}
function f_RemovalLeft(zone)
{
   if(zone.x < main.left - zone._width - 50)
   {
      if(!zone.npc)
      {
         f_EnemyDie(zone);
         f_RemovePlayer(zone);
      }
      else
      {
         f_RemoveNPC(zone);
      }
      return true;
   }
   return false;
}
function f_EnemyWalkAwayLeft(zone)
{
   zone.fp_Character = f_EnemyWalkingAwayLeft;
   zone.fp_StandAnim = f_WalkType1;
   if(zone._xscale > 0)
   {
      f_FlipChar(zone);
   }
   zone.gotoAndStop("walk");
}
function f_EnemyRunAwayLeft(zone)
{
   zone.speed = 7 + random(3);
   zone.fp_Character = f_EnemyWalkingAwayLeft;
   zone.fp_StandAnim = f_WalkType1;
   if(zone._xscale > 0)
   {
      f_FlipChar(zone);
   }
   zone.gotoAndStop("dash");
}
function f_EnemyWalkingAwayRight(zone)
{
   zone.nohit = false;
   zone.onground = false;
   zone.fp_WalkAnim(zone);
   if(zone._xscale < 0)
   {
      f_FlipChar(zone);
   }
   f_MoveCharH(zone,zone.speed,0);
   f_RemovalRight(zone);
}
function f_RemovalRight(zone)
{
   if(zone.x > main.right + zone._width + 50)
   {
      if(!zone.npc)
      {
         f_EnemyDie(zone);
         f_RemovePlayer(zone);
      }
      else
      {
         f_RemoveNPC(zone);
      }
      return true;
   }
   return false;
}
function f_EnemyWalkAwayRight(zone)
{
   zone.fp_Character = f_EnemyWalkingAwayRight;
   zone.fp_StandAnim = f_WalkType1;
   if(zone._xscale < 0)
   {
      f_FlipChar(zone);
   }
   zone.gotoAndStop("walk");
}
function f_EnemyRunAwayRight(zone)
{
   zone.speed = 7 + random(3);
   zone.fp_Character = f_EnemyWalkingAwayRight;
   zone.fp_StandAnim = f_WalkType1;
   if(zone._xscale < 0)
   {
      f_FlipChar(zone);
   }
   zone.gotoAndStop("dash");
}
function f_WalkType1(zone)
{
   zone.gotoAndStop("walk");
}
function f_WalkType2(zone)
{
   zone.gotoAndStop("beefy_walk");
}
function f_WalkTypeHide(zone)
{
   zone.gotoAndStop("hiding_walk");
}
function f_WalkTypeRunScared(zone)
{
   zone.gotoAndStop("runscared");
}
function f_DashType1(zone)
{
   zone.gotoAndStop("dash");
}
function f_StandType1(zone)
{
   if(zone.horse)
   {
      zone.gotoAndStop("horse_idle");
   }
   else
   {
      zone.gotoAndStop("stand");
   }
}
function f_StandType2(zone)
{
   zone.gotoAndStop("beefy_stand");
}
function f_StandTypeHide(zone)
{
   zone.gotoAndStop("hiding_stand");
}
function f_StandTypeBeefyHostage(zone)
{
   zone.hostage.gotoAndStop("hostage");
   zone.gotoAndStop("beefy_stand_hostage");
}
function f_WalkTypeBeefyHostage(zone)
{
   zone.hostage.gotoAndStop("hostage_walk");
   zone.gotoAndStop("beefy_walk_hostage");
}
function f_EnemyWalk(zone)
{
   if(total_players > 0)
   {
      if(zone.walking)
      {
         var loc3 = zone.x;
         var loc2 = zone.y;
         zone.prev_x = zone.x;
         zone.prev_y = zone.y;
         f_MoveCharH(zone,zone.temp_speed_x,0);
         if(zone.y == loc2 or Math.abs(zone.temp_speed_x) < 0.5)
         {
            f_MoveCharV(zone,zone.temp_speed_y,0);
         }
         if(zone.wander)
         {
            if(loc3 == zone.x or loc2 == zone.y)
            {
               zone.wander = false;
            }
            else if(zone.x > main.right)
            {
               if(zone.temp_speed_x > 0)
               {
                  zone.temp_speed_x *= -1;
               }
            }
            else if(zone.x < main.left)
            {
               if(zone.temp_speed_x < 0)
               {
                  zone.temp_speed_x *= -1;
               }
            }
         }
         if(!zone.horse)
         {
            zone.fp_WalkAnim(zone);
         }
         zone.body._y = zone.body_table_y;
         zone.zone.x = zone.x;
         zone.zone.w = zone.w;
      }
      else if(zone.standing)
      {
         if(!zone.horse)
         {
            zone.fp_StandAnim(zone);
         }
         zone.body._y = zone.body_table_y;
      }
   }
   else if(zone.wait_timer > 0)
   {
      if(!zone.horse)
      {
         zone.gotoAndStop("wait");
      }
      zone.body._y = zone.body_table_y;
   }
   else
   {
      zone.walking = false;
      if(!zone.horse)
      {
         zone.fp_StandAnim(zone);
      }
      zone.body._y = zone.body_table_y;
   }
}
function f_NPCWalking(zone)
{
   zone.dashing = false;
   if(total_players > 0)
   {
      if(zone.walking or zone.ladder)
      {
         zone.prev_x = zone.x;
         zone.prev_y = zone.y;
         if(zone.prey.dashing)
         {
            zone.dashing = true;
            var loc3 = zone.temp_speed_x * 2;
            var loc2 = zone.temp_speed_y * 1.75;
         }
         else
         {
            loc3 = zone.temp_speed_x;
            loc2 = zone.temp_speed_y * 0.75;
         }
         zone.success_x = f_MoveCharH(zone,loc3,0);
         zone.success_y = f_MoveCharV(zone,loc2,0);
         if(!zone.success_x)
         {
            zone.success_x = f_MoveCharH(zone,loc3,0);
            if(!zone.success_y)
            {
               zone.success_y = f_MoveCharV(zone,loc2,0);
            }
         }
         if(!zone.jumping and !zone.ladder and !zone.horse)
         {
            if(Math.abs(zone.x - zone.prev_x) < 0.5 and Math.abs(zone.y - zone.prev_y) < 0.5)
            {
               zone.fp_StandAnim(zone);
            }
            else
            {
               zone.fp_WalkAnim(zone);
            }
            zone.body._y = zone.body_table_y;
         }
      }
      else if(zone.standing)
      {
         if(!zone.jumping and !zone.ladder and !zone.horse)
         {
            zone.fp_StandAnim(zone);
            zone.body._y = zone.body_table_y;
         }
      }
   }
   else if(!zone.jumping and !zone.ladder and !zone.horse)
   {
      zone.fp_StandAnim(zone);
      zone.body._y = zone.body_table_y;
   }
}
function f_EnemyDashCheck(zone)
{
   if(zone.dash_timer <= 0)
   {
      return_val = true;
      zone.dash_timer = 120 + random(300);
      f_EnemyDashInit(zone);
      return true;
   }
   zone.dash_timer = zone.dash_timer - 1;
   return false;
}
function f_EnemyDashSpeed(zone)
{
   if(zone.y > zone.prey.y + 100)
   {
      zone.dash_speed_y = -4;
   }
   else if(zone.y < zone.prey.y - 100)
   {
      zone.dash_speed_y = 4;
   }
   else
   {
      zone.dash_speed_y = random(8) - 4;
   }
   if(zone.x > zone.prey.x)
   {
      zone.dash_speed_x = - (7 + random(4));
      if(zone._xscale > 0)
      {
         zone._xscale *= -1;
      }
   }
   else
   {
      zone.dash_speed_x = 7 + random(4);
      if(zone._xscale < 0)
      {
         zone._xscale *= -1;
      }
   }
}
function f_EnemyDashing(zone)
{
   f_MoveCharH(zone,zone.dash_speed_x,0);
   f_MoveCharV(zone,zone.dash_speed_y,0);
   if(zone.dash_length % 5 == 0)
   {
      if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
      {
         var loc3 = (60 + random(20)) / 100;
         var loc2 = f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,zone._xscale * loc3,100 * loc3);
         loc2._x += random(10) - 5;
         loc2._y += random(4) - 2;
      }
   }
   zone.dash_length = zone.dash_length - 1;
   if(zone.dash_length < 0)
   {
      zone.dashing = false;
      if(zone.random_dash_jump and random(zone.random_dash_jump) == 0)
      {
         if(zone.dash_speed_x > 0 and zone.x < zone.prey.x or zone.dash_speed_x < 0 and zone.x > zone.prey.x)
         {
            zone.speed_toss_x = zone.dash_speed_x / 2;
            zone.speed_jump = - (14 + random(7));
            zone.body_y = zone.speed_jump;
            f_AutoJumpInit(zone);
            return undefined;
         }
      }
      zone.fp_StandAnim(zone);
   }
}
function f_EnemyDashInit(zone)
{
   f_EnemyDashSpeed(zone);
   if(zone.x > main.right or zone.x < main.left)
   {
      zone.dash_length = random(30) + 10;
   }
   else
   {
      zone.dash_length = random(15) + 10;
   }
   zone.dashing = true;
   if(random(zone.random_dash_roll) == 0 and !zone.beefy)
   {
      zone.dash_length *= 0.5;
      zone.invincible_timer = zone.dash_length;
      zone.dash_speed_x *= 2;
      zone.dash_speed_y = 0;
      zone.gotoAndStop("roll");
   }
   else
   {
      zone.gotoAndStop("dash");
   }
}
function f_EnemyGetUp(zone)
{
   if(zone.random_dash_roll > 0 and !zone.beefy)
   {
      if((zone.x < main.left + 75 or zone.x > main.right - 75) and random_dash_roll / 2 == 0 or random(zone.random_dash_roll * 2) == 0)
      {
         if(Math.abs(zone.x - main.right) < Math.abs(zone.x - main.left))
         {
            zone.dash_speed_x = - (14 + random(6));
            if(zone._xscale > 0)
            {
               zone._xscale *= -1;
            }
         }
         else
         {
            zone.dash_speed_x = 14 + random(6);
            if(zone._xscale < 0)
            {
               zone._xscale *= -1;
            }
         }
         zone.dash_length = random(10) + 10;
         zone.dashing = true;
         zone.invincible_timer = zone.dash_length;
         zone.dash_speed_y = 0;
         zone.gotoAndStop("roll");
         return undefined;
      }
   }
   zone.fp_StandAnim(zone);
}
function f_EnemyHopSpeed(zone)
{
   if(zone.y > zone.prey.y)
   {
      zone.hop_speed_y = -6;
   }
   else
   {
      zone.hop_speed_y = 6;
   }
   if(zone.x > zone.prey.x)
   {
      zone.hop_speed_x = - (12 + random(4));
      if(zone._xscale > 0)
      {
         zone._xscale *= -1;
      }
   }
   else
   {
      zone.hop_speed_x = 12 + random(4);
      if(zone._xscale < 0)
      {
         zone._xscale *= -1;
      }
   }
}
function f_EnemyHop(zone)
{
   f_MoveCharH(zone,zone.hop_speed_x,0);
   f_MoveCharV(zone,zone.hop_speed_y,0);
}
function f_EnemyHopInit(zone)
{
   zone.hops = random(3) + 1;
   f_EnemyHopSpeed(zone);
   zone.gotoAndStop("hop");
}
function f_EnemyHopEnd(zone)
{
   zone.hops = zone.hops - 1;
   if(zone.hops > 0)
   {
      f_EnemyHopSpeed(zone);
      zone.body.gotoAndPlay(1);
   }
   else
   {
      zone.fp_StandAnim(zone);
   }
}
function f_EnemyHopCheck(zone)
{
   if(zone.hop_timer <= 0)
   {
      zone.hop_timer = 120;
      f_EnemyHopInit(zone);
      return true;
   }
   zone.hop_timer = zone.hop_timer - 1;
   return false;
}
function f_TossBomb(zone)
{
   if(zone.shot_timer <= 0)
   {
      zone.shot_timer = 120;
      zone.walking = false;
      zone.gotoAndStop("bomb");
   }
}
function f_EnemyQuickBomb(zone)
{
   if(zone.shot_timer <= 0)
   {
      var loc3 = 15 + random(4);
      if(zone._xscale > 0)
      {
         var loc4 = 100;
      }
      else
      {
         loc3 *= -1;
         loc4 = -100;
      }
      var loc1 = f_FX(zone.x,zone.y,zone.y + 1,"general_projectile",loc4,100);
      loc1.n_groundtype = zone.n_groundtype;
      loc1.owner = zone;
      loc1.projectile_type = 22;
      loc1.unblockable = false;
      loc1.attack_pow = zone.arrow_pow;
      loc1.body._y = loc1.body_y - 40;
      loc1.body_y = loc1.body._y;
      loc1.bounces = 0;
      loc1.bounces_max = 0;
      loc1.speed_x = loc3;
      loc1.speed_y = - (18 + random(8));
      loc1.speed_z = 0;
      loc1.gravity = 2;
      loc1.w = loc1.body._width / 2;
      loc1.shadow_pt = f_NewShadow();
      loc1.shadow_pt._x = loc1._x;
      loc1.shadow_pt._y = loc1._y;
      loc1.damage_type = DMG_OBJECT;
      zone.shot_timer = zone.shot_timer_default;
   }
}
function f_ShootArrow(zone)
{
   if(zone.shot_timer <= 0)
   {
      if(zone.jumping)
      {
         zone.freeze = true;
         f_SetFloat(zone,11);
      }
      zone.shot_timer = zone.shot_timer_default;
      zone.walking = false;
      zone.gotoAndStop("bow");
   }
}
function f_ShootAlienGun(zone)
{
   if(zone.shot_timer <= 0)
   {
      if(zone.jumping)
      {
         zone.freeze = true;
         f_SetFloat(zone,11);
      }
      zone.shot_timer = zone.shot_timer_default;
      zone.walking = false;
      zone.fp_MagicMove = f_MagicBullet;
      zone.gotoAndStop("gunshoot");
   }
}
function f_ShootFire(zone)
{
   if(zone.shot_timer <= 0)
   {
      if(zone.jumping)
      {
         zone.freeze = true;
         f_SetFloat(zone,11);
      }
      zone.shot_timer = zone.shot_timer_default;
      zone.walking = false;
      zone.fp_MagicMove = f_MagicBullet;
      zone.gotoAndStop("magic1");
   }
}
function f_EnemyEndBlocked(zone)
{
   zone.blocking = false;
   zone.fp_StandAnim(zone);
}
function f_EnemyBlocking(zone)
{
   if(zone.block_timer > 0)
   {
      zone.block_timer = zone.block_timer - 1;
   }
   else
   {
      var loc2 = true;
      if(Math.abs(zone.y - zone.prey.y) < 10)
      {
         if(zone.prey.dashing)
         {
            if(zone.prey.x > zone.x and zone.prey._xscale < 0 or zone.prey.x < zone.x and zone.prey._xscale > 0)
            {
               loc2 = false;
            }
         }
      }
      if(loc2)
      {
         zone.blocking = false;
         zone.fp_StandAnim(zone);
      }
   }
}
function f_EnemyCheckBlock(zone)
{
   if(zone.prey.dashing)
   {
      if(zone.prey.x > zone.x and zone.prey._xscale < 0 or zone.prey.x < zone.x and zone.prey._xscale > 0)
      {
         zone.walking = false;
         zone.standing = false;
         zone.blocking = true;
         zone.block_timer = 30;
         zone.gotoAndStop("blocking");
      }
   }
}
function f_EnemyBeefyGrab(zone)
{
   if(zone.prey.beefy or zone.prey.nohit)
   {
      zone.fp_Character = zone.prev_Character;
   }
   else if(!zone.punching)
   {
      if(Math.abs(zone.y - zone.prey.y) <= zone.speed)
      {
         if(Math.abs(zone.x - zone.prey.x) < 100)
         {
            if(!zone.prey.nohit and !zone.beefy)
            {
               if(zone.prey.body_y > -100)
               {
                  zone.fp_Character = zone.prev_Character;
                  f_BeefyGrabEnemy(zone,zone.prey);
                  f_SetTargets();
                  zone.fp_Character = f_EnemyWalkToss;
                  return true;
               }
            }
         }
      }
   }
   return false;
}
function f_EnemyRangeAttack(zone)
{
   if(!zone.punching)
   {
      if(Math.abs(zone.y - zone.prey.y) <= zone.speed)
      {
         if(Math.abs(zone.x - zone.prey.x) < 70)
         {
            if(!zone.prey.nohit)
            {
               if(zone.prey.body_y > -100)
               {
                  zone.walking = false;
                  if(random(zone.aggressiveness) == 0)
                  {
                     f_PunchSet1(zone);
                  }
               }
               else
               {
                  zone.standing = true;
               }
            }
            else
            {
               zone.walking = false;
               zone.standing = true;
            }
         }
         else if(zone.x > main.left + 50)
         {
            if(zone.x < main.right - 50)
            {
               if(random(zone.aggressiveness) == 0)
               {
                  if(zone.prey.horse)
                  {
                     zone.speed_toss_x = 0;
                     zone.speed_jump = -16;
                     zone.walking = false;
                     zone.standing = false;
                     f_AutoJumpInit(zone);
                  }
                  else
                  {
                     zone.fp_Ranged(zone);
                  }
               }
            }
         }
      }
   }
}
function f_EnemyClose(zone)
{
   if(zone.walking and zone.standing == false)
   {
      if(Math.abs(zone.x - zone.target_x) <= zone.speed / 2)
      {
         if(Math.abs(zone.y - zone.target_y) <= zone.speed / 2)
         {
            zone.walking = false;
            zone.standing = true;
            if(zone.priority > 3)
            {
               zone.wander = false;
            }
            return true;
         }
      }
   }
   return false;
}
function f_PlayersInFront(zone, distance_x, distance_y)
{
   var loc3 = 1;
   while(loc3 <= total_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc3)];
      if(loc1.alive)
      {
         if(Math.abs(loc1.y - zone.y) <= distance_y)
         {
            if(zone._xscale > 0)
            {
               if(loc1.x >= zone.x)
               {
                  if(loc1.x < zone.x + distance_x)
                  {
                     return true;
                  }
               }
            }
            else if(loc1.x <= zone.x)
            {
               if(loc1.x > zone.x - distance_x)
               {
                  return true;
               }
            }
         }
      }
      loc3 = loc3 + 1;
   }
   return false;
}
function f_FollowWalkInit(zone)
{
   if(zone.x < zone.prey.x)
   {
      if(zone._xscale < 0)
      {
         if(zone.success_y)
         {
            f_FlipChar(zone);
         }
      }
   }
   else if(zone._xscale > 0)
   {
      if(zone.success_y)
      {
         f_FlipChar(zone);
      }
   }
   if(zone.success_x)
   {
      if(zone.y < zone.prey.y)
      {
         if(zone.north)
         {
            zone.north = false;
         }
      }
      else if(!zone.north)
      {
         zone.north = true;
      }
   }
   switch(zone.follow_order)
   {
      case 1:
         var loc2 = 0;
         var loc4 = 10;
         break;
      case 2:
         loc2 = 100;
         loc4 = 0;
         break;
      case 3:
         loc2 = 30;
         loc4 = -20;
         break;
      case 4:
         loc2 = 70;
         loc4 = 30;
         break;
      case 5:
         loc2 = 140;
         loc4 = -25;
         break;
      case 6:
         loc2 = 160;
         loc4 = 25;
   }
   if(zone.success_y == false)
   {
      if(zone._xscale > 0)
      {
         zone.target_x = zone.prey.x + (250 + loc2);
      }
      else
      {
         zone.target_x = zone.prey.x - (250 + loc2);
      }
   }
   else if(zone.prey._xscale > 0)
   {
      zone.target_x = zone.prey.x - (60 + loc2);
   }
   else
   {
      zone.target_x = zone.prey.x + (60 + loc2);
   }
   if(zone.success_x == false)
   {
      zone.target_y = zone.prey.y - 300;
   }
   else
   {
      zone.target_y = zone.prey.y - 2 - loc4;
   }
   x1 = zone.x - zone.target_x;
   y1 = zone.y - zone.target_y;
   scale = -1 / Math.sqrt(x1 * x1 + y1 * y1);
   if(zone.prey.horse)
   {
      zone.temp_speed_x = zone.prey.horse.speed_x * scale * x1;
      zone.temp_speed_y = zone.prey.horse.speed_y * scale * y1;
   }
   else
   {
      zone.temp_speed_x = zone.prey.speed_x * scale * x1;
      zone.temp_speed_y = zone.prey.speed_y * scale * y1;
   }
   if(random(2) == 1)
   {
      var loc3 = (60 + random(40)) * 0.01;
      zone.temp_speed_x *= loc3;
      zone.temp_speed_y *= loc3;
   }
   zone.last_x = zone.temp_speed_x;
   zone.last_y = zone.temp_speed_y;
   if(Math.abs(zone.x - zone.target_x) < zone.prey.speed_x and Math.abs(zone.y - zone.target_y) < zone.prey.speed_y)
   {
      zone.walking = false;
      zone.standing = true;
   }
   else
   {
      zone.walking = true;
      zone.standing = false;
   }
   zone.busy = false;
}
function f_EnemyMagician(zone)
{
   if(zone.magician)
   {
      if(zone.magic_timer <= 0)
      {
         if(zone.magic_wait <= 0)
         {
            zone.magic_timer = 60;
            zone.magicclock = 0;
         }
         else
         {
            zone.magic_wait = zone.magic_wait - 1;
         }
      }
   }
}
function f_DasherWalk(zone)
{
   if(zone.jumping)
   {
      f_Jumping(zone);
   }
   else if(!f_EnemyDashCheck(zone))
   {
      if(zone.dashing)
      {
         f_EnemyDashing(zone);
      }
      else if(zone.prey.mount_type > 0)
      {
         zone.speed_toss_x = 0;
         zone.speed_jump = -16;
         f_WalkToInit(zone,zone.prey._x,zone.prey._y,f_AutoJumpInit,true);
      }
      else
      {
         f_EnemyMagician(zone);
         f_EnemyWalkInit(zone);
         f_EnemyMelee(zone);
         f_EnemyClose(zone);
         f_NPCMidJump(zone);
         if(!zone.walking and zone.x > main.right)
         {
            zone.speed_toss_x = - (9 + random(6));
            zone.speed_jump = - (15 + random(6));
            if(zone.speed_jump)
            {
               zone.body_y = zone.speed_jump;
            }
            f_AutoJumpInit(zone);
         }
         else if(!zone.walking and zone.x < main.left)
         {
            zone.speed_toss_x = 9 + random(6);
            zone.speed_jump = - (24 + random(6));
            if(zone.speed_jump)
            {
               zone.body_y = zone.speed_jump;
            }
            f_AutoJumpInit(zone);
         }
         else
         {
            f_EnemyWalk(zone);
         }
      }
   }
}
function f_BigTrollWalk(zone)
{
   if(zone.dashing)
   {
      f_EnemyDashing(zone);
   }
   else
   {
      f_EnemyWalkInit(zone);
      f_EnemyClose(zone);
      f_EnemyWalk(zone);
   }
}
function f_GoblinWalk(zone)
{
   if(!f_EnemyHopCheck(zone))
   {
      f_EnemyWalkInit(zone);
      f_EnemyMelee(zone);
      f_EnemyClose(zone);
      f_NPCMidJump(zone);
      f_EnemyWalk(zone);
   }
}
function f_ThiefWalk(zone)
{
   if(zone.prey.mount_type > 0)
   {
      zone.speed_toss_x = 0;
      zone.speed_jump = -16;
      f_WalkToInit(zone,zone.prey._x,zone.prey._y,f_AutoJumpInit,true);
   }
   else
   {
      f_RangedWalkInit(zone);
      f_EnemyRangeAttack(zone);
      f_EnemyClose(zone);
      f_NPCMidJump(zone);
      f_EnemyWalk(zone);
      f_PlayerCheckPickups(zone);
   }
}
function f_AlienWalk(zone)
{
   if(zone.prey.mount_type > 0)
   {
      zone.speed_toss_x = 0;
      zone.speed_jump = -16;
      f_WalkToInit(zone,zone.prey._x,zone.prey._y,f_AutoJumpInit,true);
   }
   else
   {
      f_RangedWalkInit(zone);
      f_EnemyRangeAttack(zone);
      f_EnemyClose(zone);
      f_NPCMidJump(zone);
      f_EnemyWalk(zone);
   }
}
function f_GeneralWalk(zone)
{
   if(zone.alive)
   {
      if(zone.prey.mount_type > 0)
      {
         zone.speed_toss_x = 0;
         zone.speed_jump = -16;
         f_WalkToInit(zone,zone.prey._x,zone.prey._y,f_AutoJumpInit,true);
      }
      else
      {
         f_EnemyWalkInit(zone);
         f_EnemyMelee(zone);
         f_EnemyClose(zone);
         f_NPCMidJump(zone);
         f_EnemyWalk(zone);
      }
   }
}
function f_BarbarianBossWalk(zone)
{
   if(zone.alive)
   {
      zone.enemy_spawn_timer = zone.enemy_spawn_timer + 1;
      if(zone.enemy_spawn_timer >= 60)
      {
         if(active_enemies < 3)
         {
            zone.enemy_spawn_timer = 0;
            f_SpawnMeleeBarb(p_game.barbarians._x - p_game.barbarians._width / 2 + random(p_game.barbarians._width),p_game.barbarians._y + 10,20);
            f_SetTargets();
         }
         else
         {
            zone.enemy_spawn_timer = -60;
            if(f_EnemyTargetCloseEnemy(zone))
            {
               zone.prev_Character = zone.fp_Character;
               zone.fp_Character = f_BossGrabEnemy;
            }
         }
      }
      f_EnemyWalkInit(zone);
      f_EnemyMelee(zone);
      f_EnemyClose(zone);
      f_EnemyWalk(zone);
   }
}
function f_Level7BossDie(zone)
{
   if(!level7die)
   {
      level7die = true;
      f_KillEnemies();
   }
   if(!zone.u_boss.active)
   {
      _root.spawn_portal_num = 1;
      zone.u_boss = undefined;
      _root.healthmeter.gotoAndStop(1);
      boss_fight = false;
      _root.spawn_portal_num = 1;
      _root.fader.f_FadeOut();
      _root.f_ChangeLevel("../map/map.swf");
   }
}
function f_BossGrabEnemy(zone)
{
   f_EnemyWalkInit(zone);
   zone.temp_speed_x *= 2;
   zone.temp_speed_x *= 2;
   f_EnemyWalk(zone);
   f_EnemyBeefyGrab(zone);
}
function f_EnemyWalkToss(zone)
{
   f_EnemyWalkInit(zone);
   f_EnemyWalk(zone);
   f_EnemyBeefyThrow(zone);
}
function f_GoalWalk(zone)
{
   f_EnemyWalkInit(zone);
   f_EnemyMelee(zone);
   f_EnemyClose(zone);
   if(zone.standing)
   {
      zone.fp_Goal(zone);
   }
   else
   {
      f_EnemyWalk(zone);
   }
}
function f_NPCWalk(zone)
{
   if(!zone.prey)
   {
      f_NPCPickPlayer(zone);
   }
   if(zone.peaceful or zone.follow)
   {
      zone.dashing = false;
      f_FollowWalkInit(zone);
      f_EnemyClose(zone);
      f_NPCMidJump(zone);
      f_NPCWalking(zone);
   }
   else
   {
      f_EnemyWalkInit(zone);
      f_EnemyMelee(zone);
      f_EnemyClose(zone);
      f_NPCMidJump(zone);
      f_EnemyWalk(zone);
   }
}
function f_EnemyDashEnd(zone)
{
   f_SlideDust(zone);
   zone.gotoAndStop("shoulderslide");
   if(zone._xscale > 0)
   {
      zone.body.speed = 24;
   }
   else
   {
      zone.body.speed = -24;
   }
}
function f_EnemyDash(zone)
{
   zone.success_x = f_MoveCharH(zone,zone.dash_speed,0);
   if(f_EnemyAttack(zone))
   {
      f_EnemyDashEnd(zone);
   }
   else if(!zone.success_x)
   {
      zone.fp_StandAnim(zone);
   }
   else if(zone.dash_speed < 0)
   {
      if(zone.x < zone.prey.x - 50)
      {
         f_EnemyDashEnd(zone);
      }
   }
   else if(zone.x > zone.prey.x + 50)
   {
      f_EnemyDashEnd(zone);
   }
}
function f_EnemyDashRange(zone)
{
   if(Math.abs(zone.y - zone.prey.y) < 6)
   {
      if(Math.abs(zone.x - zone.prey.x) > 200)
      {
         if(zone.x > zone.prey.x)
         {
            if(zone._xscale > 0)
            {
               f_FlipChar(zone);
            }
            zone.dash_speed = -12;
         }
         else
         {
            if(zone._xscale < 0)
            {
               f_FlipChar(zone);
            }
            zone.dash_speed = 12;
         }
         zone.attack_type = 1;
         zone.gotoAndStop("shoulder");
         return true;
      }
   }
   return false;
}
function f_OrcWalk(zone)
{
   if(!f_EnemyDashRange(zone))
   {
      f_EnemyWalkInit(zone);
      f_EnemyMelee(zone);
      f_EnemyClose(zone);
      f_EnemyWalk(zone);
   }
}
function f_FrogJump(zone)
{
   if(zone._xscale > 0)
   {
      zone._x += 9;
      if(zone._x + game_x > scaled_screen_width + 100)
      {
         zone.gotoAndStop("remove");
      }
   }
   else
   {
      zone._x -= 9;
      if(zone._x + game_x < -100)
      {
         zone.gotoAndStop("remove");
      }
   }
   zone._y = zone.y;
}
function f_MegaSlam()
{
   var loc2 = 1;
   while(loc2 <= total_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc2)];
      if(loc1.alive)
      {
         if(loc1.body_y >= 0)
         {
            loc1.speed_toss_y = - (random(6) + 6);
            loc1.speed_toss_x = random(5) + 3;
            f_CallJuggle1(loc1);
         }
      }
      loc2 = loc2 + 1;
   }
}
function f_OrcDust(zone)
{
   s_SlamGround.start(0,0);
   var loc1 = zone.y - 6;
   if(zone._xscale > 0)
   {
      var loc3 = zone.x + 75;
   }
   else
   {
      loc3 = zone.x - 75;
   }
   f_FX(loc3,loc1,loc1,"shockwave2",100,100);
}
function f_WraithRise(zone)
{
   if(zone.body._y > -200 and !zone.casted)
   {
      zone.body._y -= 8;
   }
   else
   {
      if(!zone.casted)
      {
         zone.casted = true;
         zone.pause_timer = 60;
         f_FX(zone.prey.x,zone.prey.y,zone.prey.y,"spell_bolt",100,100);
      }
      if(zone.pause_timer > 0)
      {
         zone.pause_timer = zone.pause_timer - 1;
      }
      else if(zone.body._y < 0)
      {
         zone.body._y += 8;
         if(zone.body._y >= 0)
         {
            zone.body._y = 0;
            zone.pattern = 1;
            zone.fp_StandAnim(zone);
         }
      }
   }
   zone.body_y = zone.body._y;
   f_ShadowSize(zone);
}
function f_WraithWalk(zone)
{
   if(zone.pattern == 1)
   {
      if(zone.x + game_x > scaled_screen_width / 2)
      {
         zone.goleft = true;
         zone.spawnleft = false;
      }
      else
      {
         zone.goleft = false;
         zone.spawnleft = true;
      }
      zone.go_up = true;
      zone.loops = 5;
      zone.loop_speed = 6;
      zone.pattern = 2;
   }
   else if(zone.pattern == 2)
   {
      if(zone.go_up)
      {
         zone.body._y -= 1;
         if(zone.body._y < -20)
         {
            zone.go_up = false;
         }
      }
      else
      {
         zone.body._y += 1;
         if(zone.body._y >= 0)
         {
            zone.go_up = true;
         }
      }
      f_ShadowSize(zone);
      var loc3 = scaled_screen_width / 2;
      var loc6 = scaled_screen_width * 0.4;
      var loc4 = Math.abs(zone.x + game_x - loc3);
      if(loc4 > loc3)
      {
         loc4 = loc3;
      }
      var loc5 = 1 - loc4 / loc6;
      var loc2 = (loc3 + 100 - loc4) / zone.loop_speed;
      if(loc2 < 1)
      {
         loc2 = 1;
      }
      if(zone.goleft)
      {
         f_MoveCharH(zone,- loc2,0);
         var loc7 = zone.prey.y - 60 * loc5 - zone.y;
         f_MoveCharV(zone,loc7);
         if(zone.x + game_x < scaled_screen_width * 0.1)
         {
            zone.loops = zone.loops - 1;
            if(zone.loops <= 0 and !zone.spawnleft)
            {
               zone.pattern = 3;
               zone.casted = false;
            }
            zone.goleft = false;
            zone.loop_speed += 2;
         }
      }
      else
      {
         f_MoveCharH(zone,loc2,0);
         loc7 = zone.prey.y + 60 * loc5 - zone.y;
         f_MoveCharV(zone,loc7,0);
         if(zone.x + game_x > scaled_screen_width * 0.9)
         {
            zone.loops = zone.loops - 1;
            if(zone.loops <= 0 and zone.spawnleft)
            {
               zone.pattern = 3;
               zone.casted = false;
            }
            zone.goleft = true;
            zone.loop_speed += 2;
         }
      }
   }
   else if(zone.pattern == 3)
   {
      f_WraithRise(zone);
   }
   if(zone.x > zone.prey.x)
   {
      if(zone._xscale > 0)
      {
         f_FlipChar(zone);
      }
   }
   else if(zone._xscale < 0)
   {
      f_FlipChar(zone);
   }
}
function f_ArcherWalk(zone)
{
   if(zone._xscale < 0)
   {
      f_MoveCharH(zone,(- zone.speed) * 2,0);
   }
   else
   {
      f_MoveCharH(zone,zone.speed * 2,0);
   }
   var loc2 = true;
   if(zone.shot_timer > 0)
   {
      zone.shot_timer = zone.shot_timer - 1;
   }
   else if(!zone.tookshot)
   {
      if(zone.x + game_x < scaled_screen_width * 0.75 and zone._xscale < 0)
      {
         loc2 = false;
         zone.tookshot = true;
         zone.gotoAndStop("arrow");
         zone.body._y = zone.body_table_y;
      }
      else if(zone.x + game_x > scaled_screen_width * 0.25 and zone._xscale > 0)
      {
         loc2 = false;
         zone.tookshot = true;
         zone.gotoAndStop("arrow");
         zone.body._y = zone.body_table_y;
      }
   }
   else
   {
      if(zone.x + game_x > scaled_screen_width + 200)
      {
         loc2 = false;
         f_EnemyDie(zone);
         return undefined;
      }
      if(zone.x + game_x < -200)
      {
         loc2 = false;
         f_EnemyDie(zone);
         return undefined;
      }
   }
   if(loc2)
   {
      zone.gotoAndStop("walk");
      zone.body._y = zone.body_table_y;
   }
}
function f_RemovePlayer(zone)
{
   f_RemoveShadow(zone);
   zone.active = false;
   zone.gotoAndStop("blank");
   if(console_version)
   {
      if(zone.human and zone.hud_pt)
      {
         LOGPush(10,0,zone.hud_pt.port);
      }
      zone.hud_pt.gotoAndStop("wait");
      var loc5 = false;
      var loc2 = 1;
      while(loc2 <= active_players)
      {
         var loc3 = playerArrayOb["p_pt" + int(loc2)];
         if(loc3.alive)
         {
            loc5 = true;
            break;
         }
         loc2 = loc2 + 1;
      }
      if(!loc5)
      {
         _root.f_ChangeLevel("../map/map.swf");
      }
   }
   else
   {
      zone.hud_pt.gotoAndStop("press_start");
      zone.hud_pt.p_type = 0;
      zone.hud_pt.player_pt = undefined;
   }
}
function f_CharFallDie(zone)
{
   zone.body_y += zone.speed_jump;
   zone.speed_jump += zone.gravity;
   zone.body._y = zone.body_y + zone.body_table_y;
   if(!f_SZ_PlayerYOnScreenMax(zone.y + zone.body_y - 200))
   {
      zone.alive = false;
      f_RemovePlayer(zone);
   }
}
function f_Spell_Skeleton(zone)
{
   if(active_enemies < 3 + total_players)
   {
      f_SpawnSkeleton(zone.x,zone.y);
      kills_goal += 1;
      f_SetTargets();
   }
}
function f_Ember(zone)
{
   zone._y -= zone.speed;
   zone.timer = zone.timer - 1;
   if(zone.timer < 0)
   {
      zone.gotoAndStop("remove");
   }
   else if(zone.body._xscale > 10)
   {
      zone.body._xscale -= 2;
      zone.body._yscale -= 2;
   }
}
function f_WaitUntilClose(zone, u_frame)
{
   var loc1 = 1;
   while(loc1 <= total_players)
   {
      var loc2 = playerArrayOb["p_pt" + int(loc1)];
      if(loc2.x > zone.x - 150)
      {
         zone.gotoAndStop("cinema_butt2");
         loc1 = total_players + 1;
      }
      loc1 = loc1 + 1;
   }
}
function f_OpenPortal()
{
   var loc2 = scaled_screen_width / 2 - game_x;
   var loc1 = 100 - game_y;
   f_FX(loc2,loc1,loader.game.game.limit_topleft.y,"portal",100,100);
}
function f_FireBurnHit(zone, u_temp)
{
   if(u_temp.health > 0)
   {
      if(Math.abs(zone.y - u_temp.y) < 10)
      {
         if(u_temp.x > zone.x - zone.zone._width / 2)
         {
            if(u_temp.x < zone.x + zone.zone._width / 2)
            {
               if(u_temp.fire_timer <= 0)
               {
                  s_FireHit.start(0,0);
                  var loc4 = 5;
                  if(_root.insane_mode == true)
                  {
                     loc4 = 20;
                  }
                  if(zone.geyser)
                  {
                     f_Damage(u_temp,loc4,DMG_FIRE,DMGFLAG_JUGGLE,2 + random(2),- (40 + random(6)));
                     u_temp.speed_toss_x = 2 + random(2);
                     u_temp.speed_toss_y = - (40 + random(6));
                     u_temp.fire_timer = 59;
                     u_temp.smoking_timer = 60;
                     f_ColorSwap(u_temp,color_dark);
                     f_CallJuggle1(u_temp);
                  }
                  else
                  {
                     f_Damage(u_temp,loc4,DMG_FIRE);
                  }
                  f_CheckHealth(u_temp);
               }
            }
         }
      }
   }
}
function f_FireBurn(zone)
{
   if(f_OnScreen(zone))
   {
      var loc1 = 1;
      while(loc1 <= total_players)
      {
         f_FireBurnHit(zone,playerArrayOb["p_pt" + int(loc1)]);
         loc1 = loc1 + 1;
      }
      loc1 = 1;
      while(loc1 <= active_enemies)
      {
         f_FireBurnHit(zone,enemyArrayOb["e" + int(loc1)]);
         loc1 = loc1 + 1;
      }
   }
}
function f_FireWallBurnHit(zone, u_temp)
{
   if(u_temp.x > zone.x + zone.top._x)
   {
      if(u_temp.y < zone.x + zone.bottom._x)
      {
         var loc5 = (u_temp.y - (zone.top._y + zone._y)) / (zone.bottom._y - zone.top._y);
         var loc6 = zone.x + zone.top._x + (zone.bottom._x - zone.top._x) * loc5;
         if(Math.abs(u_temp.x - loc6) < 20)
         {
            if(u_temp.fire_timer <= 0)
            {
               s_FireHit.start(0,0);
               if(u_temp._xscale < 0)
               {
                  u_temp._xscale *= -1;
               }
               var loc4 = 5;
               if(_root.insane_mode == true)
               {
                  loc4 = 20;
               }
               f_Damage(u_temp,loc4,DMG_FIRE,DMGFLAG_JUGGLE,5 + random(3),- (20 + random(6)));
            }
         }
      }
   }
}
function f_FireWallBurn(zone)
{
   if(f_OnScreen(zone))
   {
      var loc1 = 1;
      while(loc1 <= total_players)
      {
         f_FireWallBurnHit(zone,playerArrayOb["p_pt" + int(loc1)]);
         loc1 = loc1 + 1;
      }
      loc1 = 1;
      while(loc1 <= active_enemies)
      {
         f_FireWallBurnHit(zone,enemyArrayOb["e" + int(loc1)]);
         loc1 = loc1 + 1;
      }
   }
}
function f_EmberGenerator(zone)
{
   if(zone.ember_timer < 0)
   {
      zone.ember_timer = 120;
   }
   else
   {
      zone.ember_timer = zone.ember_timer - 1;
      if(zone.ember_timer % 3 == 0)
      {
         var loc6 = zone.x - 30 + random(60);
         var loc5 = zone.y - random(zone.zone._height);
         var loc2 = 80 + random(20);
         if(random(2) == 1)
         {
            var loc4 = loc2 * -1;
         }
         else
         {
            loc4 = loc2;
         }
         var loc3 = f_FX(loc6,loc5,zone.y,"ember",loc4,loc2);
         loc3.speed = 2 + random(5);
         loc3.timer = 20 + random(20);
      }
   }
}
function f_EvilSmokeRise(zone)
{
   zone._y -= zone.speed_y;
}
function f_BlackKnightSmoke(zone)
{
   if(zone.timer <= 0)
   {
      zone.timer = 100;
   }
   else
   {
      zone.timer = zone.timer - 1;
      if(zone.timer % 3 == 0)
      {
         var loc7 = zone._x + zone.bk._x - 25 + random(50);
         if(random(3) == 1)
         {
            var loc2 = random(30) + 40;
            var loc3 = zone._y + 1;
            var loc6 = zone._y - random(20);
            var loc5 = random(2);
         }
         else
         {
            loc2 = random(40) + 50;
            loc3 = zone._y - 1;
            loc6 = zone._y - 30 - random(100);
            loc5 = random(4) + 1;
         }
         var loc4 = f_FX(loc7,loc6,loc3,"evilsmoke",loc2,loc2);
         loc4.speed_y = loc5;
      }
   }
}
function f_NewShadow()
{
   var loc2 = 1;
   while(loc2 <= total_shadows)
   {
      var loc1 = loader.game.game["s" + loc2];
      if(!loc1.active)
      {
         loc1.gotoAndStop("on");
         loc1._xscale = 100;
         loc1._yscale = 100;
         loc1.active = true;
         HiFps_Reset(loc1);
         return loc1;
      }
      loc2 = loc2 + 1;
   }
}
function f_RemoveShadow(zone)
{
   zone.shadow_pt.active = false;
   zone.shadow_pt.gotoAndStop("off");
   zone.shadow_pt = undefined;
}
function f_IntroDashInit1(zone)
{
   var loc4 = zone.barbarians._x + zone._x;
   var loc2 = zone.barbarians._y + zone._y;
   var loc1 = f_SpawnBarbarian(loc4,loc2);
   loc1.speed = 14;
   loc1.intro_timer = 160;
   loc1.gotoAndStop("introdash");
   loc1 = f_SpawnBarbarian(loc4 + 100,loc2 - 30);
   loc1.speed = 18;
   loc1.intro_timer = 160;
   loc1.gotoAndStop("introdash");
}
function f_IntroDashInit2(zone)
{
   var loc4 = zone.barbarians._x + zone._x;
   var loc2 = zone.barbarians._y + zone._y;
   var loc1 = f_SpawnBarbarian(loc4 + 50,loc2 - 60);
   loc1.speed = 16;
   loc1.intro_timer = 160;
   loc1.gotoAndStop("introdash");
   loc1 = f_SpawnBarbarian(loc4 + 200,loc2 - 50);
   loc1.speed = 18;
   loc1.intro_timer = 160;
   loc1.gotoAndStop("introdash");
}
function f_IntroDashInit3(zone)
{
   var loc4 = zone.barbarians._x + zone._x;
   var loc2 = zone.barbarians._y + zone._y;
   var loc1 = f_SpawnBarbarian(loc4 + 400,loc2 - 20);
   loc1.speed = 16;
   loc1.intro_timer = 160;
   loc1.gotoAndStop("introdash");
   loc1 = f_SpawnBarbarian(loc4 + 300,loc2 - 60);
   loc1.speed = 16;
   loc1.intro_timer = 160;
   loc1.gotoAndStop("introdash");
}
function f_IntroDashInit4(zone)
{
   var loc4 = zone.barbarians._x + zone._x;
   var loc2 = zone.barbarians._y + zone._y;
   var loc1 = f_SpawnBarbarian(loc4 + 500,loc2 - 50);
   loc1.speed = 18;
   loc1.intro_timer = 160;
   loc1.gotoAndStop("introdash");
   loc1 = f_SpawnBarbarian(loc4 + 350,loc2 - 30);
   loc1.speed = 18;
   loc1.intro_timer = 160;
   loc1.gotoAndStop("introdash");
}
function f_IntroDashInit5(zone)
{
   var loc4 = zone.barbarians._x + zone._x;
   var loc2 = zone.barbarians._y + zone._y;
   var loc1 = f_SpawnBarbarian(loc4 + 150,loc2 - 20);
   loc1.speed = 16;
   loc1.intro_timer = 160;
   loc1.gotoAndStop("introdash");
   loc1 = f_SpawnBarbarian(loc4 + 250,loc2);
   loc1.speed = 14;
   loc1.intro_timer = 160;
   loc1.gotoAndStop("introdash");
}
function f_IntroDash(zone)
{
   zone._x -= zone.speed;
   zone.intro_timer = zone.intro_timer - 1;
   if(zone.intro_timer <= 0)
   {
      f_EnemyDie(zone);
   }
}
function f_ActivatePlayers()
{
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc2 = _root.loader.game.game["p" + int(loc3)];
      loc2.n_groundtype = 0;
      if(loc2.alive)
      {
         loc2.shadow_pt.gotoAndStop("on");
         if(level == 23 or level == 102)
         {
            loc2.fp_StandAnim = f_SwimStand;
            loc2.fp_WalkAnim = f_SwimWalk;
            if(loc2.p_type == 33 && loc2.undead) { // Fixing cyclops dual stand anim causing flicker with standard f_SwimStand
               loc2.fp_StandAnim = f_StandTypeUndead;
               loc2.fp_WalkAnim = f_WalkTypeUndead;
            }
            loc2.body_y = -500;
            loc2.body._y = -500;
            loc2.jump_speed_y;
            f_JumpAction(loc2);
            loc2.speed_jump = 0;
         }
         else
         {
            loc2.fp_StandAnim(loc2);
         }
      }
      loc3 = loc3 + 1;
   }
}
function f_PlayersEnter()
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = _root.loader.game.game["p" + int(loc2)];
      var loc4 = undefined;
      if(loc3.alive)
      {
         if(spawn_portal_num != 1)
         {
            loc4 = _root.loader.game.game["p" + loc2 + "_start" + spawn_portal_num];
         }
         else
         {
            loc4 = _root.loader.game.game["p" + loc2 + "_start"];
         }
         _root.f_WalkToInit(loc3,loc4._x,loc4._y,loc3.fp_StandAnim,true);
      }
      loc2 = loc2 + 1;
   }
}
function f_MakeHorse(x, y)
{
   i = 1;
   while(i <= total_horses)
   {
      var loc2 = _root.loader.game.game["horse" + int(i)];
      if(!loc2.active)
      {
         loc2.active = true;
         loc2.alive = true;
         loc2.x = x;
         loc2.y = y;
         loc2._x = x;
         loc2._y = y;
         loc2.h = 56;
         loc2.mount_type = 1;
         f_Depth(loc2,loc2.y);
         loc2.gotoAndStop("wait");
         return loc2;
      }
      i++;
   }
   return 0;
}
function f_MakeMount2(x, y)
{
   i = 1;
   while(i <= total_mount2)
   {
      var loc2 = _root.loader.game.game["mount2" + int(i)];
      if(!loc2.active)
      {
         loc2.active = true;
         loc2.alive = true;
         loc2.x = x;
         loc2.y = y;
         loc2._x = x;
         loc2._y = y;
         loc2.h = 44;
         loc2.mount_type = 2;
         loc2.fp_PunchHit = f_PunchHit;
         loc2.punch_pow_low = 10;
         loc2.punch_pow_medium = 10;
         loc2.punch_pow_high = 10;
         loc2.punch_pow_max = 10;
         f_Depth(loc2,loc2.y);
         loc2.gotoAndStop("wait");
         return loc2;
      }
      i++;
   }
   return 0;
}
function f_MakeMount3(x, y)
{
   i = 1;
   while(i <= total_mount3)
   {
      var loc2 = _root.loader.game.game["mount3" + int(i)];
      if(!loc2.active)
      {
         loc2.active = true;
         loc2.alive = true;
         loc2.x = x;
         loc2.y = y;
         loc2._x = x;
         loc2._y = y;
         loc2.h = 44;
         loc2.mount_type = 3;
         loc2.fp_PunchHit = f_PunchHit;
         loc2.punch_pow_low = 10;
         loc2.punch_pow_medium = 10;
         loc2.punch_pow_high = 10;
         loc2.punch_pow_max = 10;
         f_Depth(loc2,loc2.y);
         loc2.gotoAndStop("wait");
         return loc2;
      }
      i++;
   }
   return 0;
}
function f_MakeMount4(x, y)
{
   i = 1;
   while(i <= total_mount4)
   {
      var loc2 = _root.loader.game.game["mount4" + int(i)];
      if(!loc2.active)
      {
         loc2.active = true;
         loc2.alive = true;
         loc2.x = x;
         loc2.y = y;
         loc2._x = x;
         loc2._y = y;
         loc2.h = 75;
         loc2.mount_type = 4;
         loc2.fp_PunchHit = f_PunchHit;
         loc2.punch_pow_low = 10;
         loc2.punch_pow_medium = 10;
         loc2.punch_pow_high = 10;
         loc2.punch_pow_max = 10;
         f_Depth(loc2,loc2.y);
         loc2.gotoAndStop("wait");
         return loc2;
      }
      i++;
   }
   return 0;
}
function f_ChickenWalk(zone)
{
   zone.walk_timer = zone.walk_timer - 1;
   if(zone.walk_timer <= 0)
   {
      if(zone.hunted)
      {
         zone.idle_timer = random(20);
      }
      else
      {
         zone.idle_timer = random(20) + 20;
      }
      zone.gotoAndStop("idle");
   }
   else
   {
      var loc2 = zone.x;
      f_MoveCharH(zone,zone.speed_x,0);
      zone.bounds = false;
      var loc3 = zone.y;
      f_MoveCharV(zone,zone.speed_y,0);
      if(!zone.hunted and zone._x < main.left or zone.x == loc2)
      {
         if(zone._xscale < 0)
         {
            zone.speed_x *= -1;
            f_FlipChar(zone);
         }
      }
      else if(!zone.hunted and zone._x > main.right or zone.x == loc2)
      {
         if(zone._xscale > 0)
         {
            zone.speed_x *= -1;
            f_FlipChar(zone);
         }
      }
      if(zone.y == loc3)
      {
         zone.speed_y *= -1;
      }
   }
}
function f_ChickenIdle(zone)
{
   zone.idle_timer = zone.idle_timer - 1;
   if(zone.idle_timer <= 0)
   {
      if(zone.hunted)
      {
         zone.walk_timer = random(20) + 5;
         if(random(2) == 1)
         {
            zone.speed_x = - (random(3) + 7);
            if(zone._xscale > 0)
            {
               f_FlipChar(zone);
            }
         }
         else
         {
            zone.speed_x = random(3) + 7;
            if(zone._xscale < 0)
            {
               f_FlipChar(zone);
            }
         }
         if(zone.x < main.left and zone.speed_x < 0 or zone.x > main.right and zone.speed_x > 0)
         {
            zone.speed_x *= -1;
            f_FlipChar(zone);
            zone.walk_timer = random(20) + 30;
         }
         zone.speed_y = random(3) + 7;
         if(random(2) == 1)
         {
            zone.speed_y *= -1;
         }
         zone.gotoAndStop("walk");
         zone.body._y = zone.body_table_y;
         return undefined;
      }
      zone.walk_timer = random(50) + 30;
      if(random(2) == 1)
      {
         zone.speed_x = - (random(3) + 4);
         if(zone._xscale > 0)
         {
            f_FlipChar(zone);
         }
      }
      else
      {
         zone.speed_x = random(3) + 4;
         if(zone._xscale < 0)
         {
            f_FlipChar(zone);
         }
      }
      zone.speed_y = random(3) + 4;
      if(random(2) == 1)
      {
         zone.speed_y *= -1;
      }
      zone.gotoAndStop("walk");
      zone.body._y = zone.body_table_y;
   }
}
function f_MakeChicken(x, y)
{
   i = 1;
   while(i <= total_chickens)
   {
      var loc2 = _root.loader.game.game["chicken" + int(i)];
      if(!loc2.active)
      {
         loc2.active = true;
         loc2.x = x;
         loc2.y = y;
         loc2._x = x;
         loc2._y = y;
         f_Depth(loc2,y);
         loc2.idle_timer = 1;
         loc2.gotoAndStop("idle");
         return loc2;
      }
      i++;
   }
   return 0;
}
function f_StopChickens()
{
   i = 1;
   while(i <= total_chickens)
   {
      var loc2 = _root.loader.game.game["chicken" + int(i)];
      if(loc2.active)
      {
         loc2.gotoAndStop("sleep");
      }
      i++;
   }
}
function f_MakeBodyPart(u_parent)
{
   i = 1;
   while(i <= 10)
   {
      var loc2 = _root.loader.game.game["e_bodyparts" + int(i)];
      if(!loc2.active)
      {
         loc2.active;
         loc2.x = u_parent.x;
         loc2.y = u_parent.y;
         loc2._x = loc2.x;
         loc2._y = loc2.y;
         f_Depth(loc2,loc2._y);
         if(gore)
         {
            loc2.helmet = u_parent.helmet;
         }
         else
         {
            loc2.helmet = 100;
         }
         loc2.gotoAndStop("head");
         loc2.body._y = -75;
         loc2.speed_x = 5 - random(10);
         loc2.speed_y = - (random(10) + 30);
         loc2.gravity = random(2) + 6;
         loc2.bounces = 0;
         loc2.bounces_max = 2;
         loc2.hit_function = f_GeneralBounce;
         return loc2;
      }
      i++;
   }
   return 0;
}
function f_BodyPartFall(zone)
{
   if(zone.speed_y > 0)
   {
      f_BloodBathShrapnel(zone._x,zone._y,zone.body._y + zone._y,!_root.gore);
   }
}
function f_GoTimer(zone)
{
   zone.go_timer = zone.go_timer - 1;
   if(zone.go_timer <= 0)
   {
      zone.body.gotoAndPlay("go");
   }
}
function f_RespawnFX(zone)
{
   f_LevelUpAttack(zone);
   if(zone.helmet == 3)
   {
      s_IceShatter.start(0,0);
      f_IceShrapnel(zone.x - 30,zone.y,0,true);
      f_IceShrapnel(zone.x + 25,zone.y,0,false);
      f_IceShrapnel(zone.x - 25,zone.y,-15,true);
      f_IceShrapnel(zone.x + 30,zone.y,-10,false);
      f_IceShrapnel(zone.x - 10,zone.y,-20,true);
      f_IceShrapnel(zone.x + 10,zone.y,-25,false);
   }
   else
   {
      f_MagicJump(zone);
   }
}
function f_Tour(zone)
{
   if(Key.isDown(65))
   {
      var loc1 = 100;
   }
   else
   {
      loc1 = 15;
   }
   if(Key.isDown(39))
   {
      zone._x += loc1;
   }
   if(Key.isDown(37))
   {
      zone._x -= loc1;
   }
   if(Key.isDown(40))
   {
      zone._y += loc1;
   }
   if(Key.isDown(38))
   {
      zone._y -= loc1;
   }
}
function f_HitRecoverInit(zone)
{
   zone.recover_timer = zone.recovery;
   if(zone.fp_hitreaction)
   {
      zone.fp_hitreaction(zone);
   }
}
function f_HitRecover(zone)
{
   zone.recover_timer = zone.recover_timer - 1;
   if(zone.recover_timer <= 0)
   {
      f_EndHit(zone);
   }
}
function f_HitRecoverGo(zone)
{
   zone.recover_timer = zone.recover_timer - 1;
   if(zone.recover_timer <= 0)
   {
      zone.body.gotoAndPlay("go");
   }
}
function f_WalkToInit(zone, x, y, u_action, u_thru)
{
   zone.walkto_x = x;
   zone.walkto_y = y;
   zone.WalkToAction = u_action;
   zone.u_thru = u_thru;
   zone.dashing_timer = 5;
   x1 = zone.x - zone.walkto_x;
   y1 = zone.y - zone.walkto_y;
   if(zone.walkto_speed)
   {
      scale = (- zone.walkto_speed) / Math.sqrt(x1 * x1 + y1 * y1);
   }
   else
   {
      scale = -10 / Math.sqrt(x1 * x1 + y1 * y1);
   }
   zone.temp_speed_x = scale * x1;
   zone.temp_speed_y = scale * y1;
   if(zone.temp_speed_x > 0)
   {
      if(zone._xscale < 0)
      {
         f_FlipChar(zone);
      }
   }
   else if(zone._xscale > 0)
   {
      f_FlipChar(zone);
   }
   if(zone.horse)
   {
      zone.shadow_pt._xscale = 1;
      zone.shadow_pt._yscale = 1;
      if(zone._xscale > 0)
      {
         if(zone.horse._xscale < 0)
         {
            zone.horse._xscale *= -1;
         }
      }
      else if(zone.horse._xscale > 0)
      {
         zone.horse._xscale *= -1;
      }
      zone.horse.gotoAndStop(zone.horse.anim_walk);
      zone.gotoAndStop("horse_walkto");
   }
   else if(u_thru)
   {
      zone.magicmode = false;
      if(zone.beefy)
      {
         zone.gotoAndStop("beefy_walkthru");
      }
      else
      {
         zone.gotoAndStop("walkthru");
      }
      zone.body._y = zone.body_y + zone.body_table_y;
   }
   else
   {
      zone.magicmode = false;
      if(zone.beefy)
      {
         zone.gotoAndStop("beefy_walkto");
      }
      else
      {
         zone.gotoAndStop("walkto");
      }
      zone.body._y = zone.body_y + zone.body_table_y;
   }
}
function f_WalkTo(zone)
{
   zone.body._y = zone.body_y + zone.body_table_y;
   zone.prev_x = zone.x;
   zone.prev_y = zone.y;
   var loc2 = true;
   if(zone.temp_speed_x > 0)
   {
      if(zone.x < zone.walkto_x)
      {
         loc2 = false;
         f_MoveCharH(zone,zone.temp_speed_x,0);
      }
   }
   else if(zone.x > zone.walkto_x)
   {
      loc2 = false;
      f_MoveCharH(zone,zone.temp_speed_x,0);
   }
   if(zone.temp_speed_y > 0)
   {
      if(zone.y < zone.walkto_y)
      {
         loc2 = false;
         f_MoveCharV(zone,zone.temp_speed_y,0);
      }
   }
   else if(zone.y > zone.walkto_y)
   {
      loc2 = false;
      f_MoveCharV(zone,zone.temp_speed_y,0);
   }
   if(loc2 or zone.prev_x == zone.x and zone.prev_y == zone.y)
   {
      zone.WalkToAction(zone);
   }
}
function f_HorseStandAnim(zone)
{
   zone.horse.gotoAndStop("idle");
   zone.gotoAndStop("horse_idle");
}
function f_HorseWalkTo(zone)
{
   if(zone.u_thru)
   {
      f_WalkThru(zone);
   }
   else
   {
      f_WalkTo(zone);
   }
   f_SetXY(zone.horse,zone.x,zone.y - 1);
}
function f_WalkThru(zone)
{
   zone.body._y = zone.body_y + zone.body_table_y;
   if(zone.dashing_timer % 5 == 0)
   {
      if(zone.n_groundtype < 300 or zone.n_groundtype > 302)
      {
         var loc4 = (80 + random(20)) / 100;
         var loc3 = f_FX(zone.x,zone.y + 1,int(zone.y) + 1,level_dust,zone._xscale * loc4,100 * loc4);
         loc3._x += random(10) - 5;
         loc3._y += random(4) - 2;
      }
      else if(level == 32)
      {
         f_FX(zone._x,zone._y,int(zone._y + 1),"wave",100,100);
      }
   }
   zone.dashing_timer = zone.dashing_timer + 1;
   var loc2 = true;
   if(zone.temp_speed_x > 0)
   {
      if(zone.x + zone.temp_speed_x >= zone.walkto_x)
      {
         zone.x = zone.walkto_x;
      }
      else
      {
         zone.x += zone.temp_speed_x;
         loc2 = false;
      }
   }
   else if(zone.x + zone.temp_speed_x <= zone.walkto_x)
   {
      zone.x = zone.walkto_x;
   }
   else
   {
      zone.x += zone.temp_speed_x;
      loc2 = false;
   }
   if(zone.temp_speed_y > 0)
   {
      if(zone.y + zone.temp_speed_y >= zone.walkto_y)
      {
         zone.y = zone.walkto_y;
      }
      else
      {
         zone.y += zone.temp_speed_y;
         loc2 = false;
      }
   }
   else if(zone.y + zone.temp_speed_y <= zone.walkto_y)
   {
      zone.y = zone.walkto_y;
   }
   else
   {
      zone.y += zone.temp_speed_y;
      loc2 = false;
   }
   zone._x = zone.x;
   zone._y = zone.y;
   f_Depth(zone,zone.y);
   zone.shadow_pt._x = zone.x;
   zone.shadow_pt._y = zone.y;
   if(zone.zone)
   {
      if(zone._xscale > 0)
      {
         zone.zone.x = zone.x + zone.zone._x;
      }
      else
      {
         zone.zone.x = zone.x - zone.zone._x;
      }
      zone.zone.y = zone.y + zone.zone._y;
   }
   if(loc2)
   {
      zone.WalkToAction(zone);
   }
}
function f_PlayersClose(zone)
{
   var loc3 = 1;
   while(loc3 <= total_players)
   {
      var loc2 = playerArrayOb["p_pt" + int(loc3)];
      if(loc2.alive)
      {
         if(Math.abs(loc2.x - zone.x) < 150)
         {
            if(Math.abs(loc2.y - zone.y) < 20)
            {
               if(loc2.x > zone.x)
               {
                  if(zone._xscale < 0)
                  {
                     f_FlipChar(zone);
                  }
               }
               else if(zone._xscale > 0)
               {
                  f_FlipChar(zone);
               }
               return true;
            }
         }
      }
      loc3 = loc3 + 1;
   }
   return false;
}
function f_EnemyTargetCloseEnemy(zone)
{
   var loc4 = undefined;
   var loc5 = undefined;
   var loc3 = 1;
   while(loc3 <= active_enemies)
   {
      var loc1 = enemyArrayOb["e" + int(loc3)];
      if(loc1 != zone)
      {
         if(loc1.alive)
         {
            if(!loc1.nohit)
            {
               if(loc4 == undefined)
               {
                  loc4 = loc1;
                  loc5 = Math.abs(zone.x - loc1.y) + Math.abs(zone.y - loc1.y);
               }
               else if(Math.abs(zone.x - loc1.y) + Math.abs(zone.y - loc1.y) < loc5)
               {
                  loc4 = loc1;
                  loc5 = Math.abs(zone.x - loc1.y) + Math.abs(zone.y - loc1.y);
               }
            }
         }
      }
      loc3 = loc3 + 1;
   }
   if(loc4 == undefined)
   {
      return false;
   }
   zone.prey = loc4;
   return true;
}
function f_GetUpPuch201_2(zone)
{
   if(f_PlayersClose(zone))
   {
      s_Swing4.start(0,0);
      zone.punching = true;
      zone.punch_group = 201;
      zone.punch_num = 2;
      zone.gotoAndStop("punch201_2");
   }
   else
   {
      zone.fp_StandAnim(zone);
   }
}
function f_GetUp(zone)
{
   if(zone.fp_GetUpAction)
   {
      zone.fp_GetUpAction(zone);
   }
   else
   {
      zone.fp_StandAnim(zone);
   }
}
function f_HitReactionSwordLock(zone, attack_pow, attack_type, damage_flags, recoil_x, recoil_y)
{
   var loc2 = false;
   if(zone.horse or !zone.humanoid or !zone.hitby.humanoid or level == 43)
   {
      loc2 = false;
   }
   else if(zone.hitby.attack_type == DMG_MELEE)
   {
      if(zone.hitby.beefy or zone.beefy or zone.attack_type != DMG_MELEE)
      {
         loc2 = false;
      }
      else if(Math.abs(zone.x - zone.hitby.x) > 150)
      {
         loc2 = false;
      }
      else if(Math.abs(zone.y - zone.hitby.y) > 30)
      {
         loc2 = false;
      }
      else if(zone.body_y < 0 or zone.hitby.body_y < 0)
      {
         loc2 = false;
      }
      else if(zone.x >= zone.hitby.x)
      {
         if(zone._xscale > 0)
         {
            loc2 = false;
         }
         else
         {
            if(zone.hitby._xscale < 0)
            {
               zone.hitby._xscale *= -1;
            }
            if(f_MoveCharH(zone,zone.hitby.x + 100 - zone.x,0))
            {
               loc2 = true;
            }
         }
      }
      else if(zone._xscale < 0)
      {
         loc2 = false;
      }
      else
      {
         if(zone.hitby._xscale > 0)
         {
            zone.hitby._xscale *= -1;
         }
         if(f_MoveCharH(zone,zone.hitby.x - 100 - zone.x,0))
         {
            loc2 = true;
         }
      }
   }
   if(loc2)
   {
      if(zone.prev_fp_UniqueHit)
      {
         zone.fp_UniqueHit = zone.prev_fp_UniqueHit;
         zone.prev_fp_UniqueHit = undefined;
      }
      else
      {
         zone.uniquehit = false;
         zone.fp_UniqueHit = undefined;
      }
      f_MoveCharV(zone,zone.hitby.y - 1 - zone.y,0);
      zone.grappler = zone.hitby;
      zone.hitby.grappler = zone;
      zone.nohit = true;
      zone.hitby.nohit = true;
      zone.hitby.gotoAndStop("swordlock");
      zone.gotoAndStop("swordlock");
      return true;
   }
   f_Damage(zone,1,attack_type,damage_flags,recoil_x,recoil_y);
   return false;
}
function f_Hit1Reaction(zone)
{
   if(!zone.beefy)
   {
      if(zone.horse)
      {
         f_KnockOffHorse(zone);
      }
      else
      {
         f_DropHostage(zone);
         zone.gotoAndStop("hit1");
         zone.body.gotoAndPlay(1);
      }
   }
   else
   {
      f_DropHostage(zone);
      zone.gotoAndStop("beefy_hit1");
      zone.body.gotoAndPlay(1);
   }
}
function f_Hit1(zone)
{
   zone.fp_Hit1(zone);
}
function f_Hit2Reaction(zone)
{
   if(!zone.beefy)
   {
      f_KnockOffHorse(zone);
      f_DropHostage(zone);
      zone.gotoAndStop("hit2");
      zone.body.gotoAndPlay(1);
   }
}
function f_Hit2(zone)
{
   zone.fp_Hit2(zone);
}
function f_Hit3Reaction(zone)
{
   if(!zone.beefy)
   {
      f_KnockOffHorse(zone);
      f_DropHostage(zone);
      zone.gotoAndStop("hit3");
      zone.body.gotoAndPlay(1);
   }
}
function f_Hit3(zone)
{
   zone.fp_Hit3(zone);
}
function f_BeefyThrowAction(zone)
{
   f_BeefyCarryEnemy(zone);
   zone.hostage.throw_x = zone.hostage.x;
   zone.hostage.hitby = zone;
   zone.hostage.throw_source_x = zone.x;
   zone.hostage.throw_source_y = zone.y;
   zone.hostage.gotoAndStop("hostage_thrown");
   zone.gotoAndStop("beefy_throw");
}
function f_BeefyThrow(zone)
{
   if(Key.isDown(zone.button_punch1))
   {
      if(!zone.punched and !zone.punching)
      {
         zone.punched = true;
         f_BeefyThrowAction(zone);
      }
   }
   else
   {
      zone.punched = false;
   }
   if(Key.isDown(zone.button_punch2))
   {
      if(!zone.punched2 and !zone.punching)
      {
         zone.punched2 = true;
         f_BeefyThrowAction(zone);
      }
   }
   else
   {
      zone.punched2 = false;
   }
}
function f_EnemyBeefyThrow(zone)
{
   if(Math.abs(zone.y - zone.prey.y) <= zone.speed)
   {
      if(zone.x > zone.prey.x)
      {
         if(zone._xscale > 0)
         {
            f_FlipChar(zone);
         }
      }
      else if(zone._xscale < 0)
      {
         f_FlipChar(zone);
      }
      zone.hostage.missilemode = true;
      f_BeefyThrowAction(zone);
   }
}
function f_GoDefault(zone)
{
   if(zone.beefy)
   {
      s_DarkFly.start(0,0);
      zone.throwmove = false;
      f_DropHostage(zone);
      if(zone.grappler)
      {
         var loc2 = zone.grappler;
         zone.grappler.grappler = undefined;
         zone.grappler = undefined;
         f_BeefyGrabEnemy(loc2,zone);
      }
   }
   zone.fp_Character = f_Character;
   zone.fp_StandAnim = f_StandType1;
   zone.fp_WalkAnim = f_WalkType1;
   zone.fp_DashAnim = f_DashType1;
   zone.fp_ThrowAction = f_ThrowEnemy;
   zone.fp_Jab = f_PunchSet1;
   zone.fp_Fierce = f_PunchSet2;
   zone.fp_JabFierce = f_Uppercut;
   zone.shadow_pt._xscale = 100;
   zone.nohit = false;
   zone.invincible_timer = 0;
   if(zone.restore_anim != "" and zone.beefy)
   {
      zone.beefy = false;
      var loc3 = zone.restore_anim;
      zone.restore_anim = "";
      zone.gotoAndStop(loc3);
   }
   else if(zone.body_y < 0 and zone.beefy)
   {
      zone.beefy = false;
      zone.speed_jump = -8;
      f_JumpAction(zone);
   }
   else
   {
      zone.beefy = false;
      zone.fp_StandAnim(zone);
   }
}
function f_GoBeefy(zone)
{
   zone.wings = 1;
   zone.beefy = true;
   zone.invincible_timer = 1;
   zone.fp_Character = f_CharacterBeefy;
   zone.fp_StandAnim = f_StandType2;
   zone.prev_StandAnim = zone.fp_StandAnim;
   zone.fp_WalkAnim = f_WalkType2;
   zone.fp_DashAnim = f_WalkType2;
   zone.fp_ThrowAction = f_BeefyGrabEnemy;
   zone.fp_Jab = f_PunchSet200;
   zone.fp_Fierce = f_PunchSet200;
   zone.fp_JabFierce = f_BeefyJabFierce;
   zone.magicmode = false;
   zone.throwmove = false;
   zone.shadow_pt._xscale = 200;
   zone.gotoAndStop("transform");
}
function f_TransformBeefy(zone)
{
   if(Key.isDown(zone.button_magic))
   {
      if(!zone.pressed_magic)
      {
         zone.magic_gap = 0;
         zone.pressed_magic = true;
         var loc2 = zone.body._currentframe + 10;
         zone.body.gotoAndStop(loc2);
         if(zone.body._currentframe >= 60)
         {
            f_FX(zone.x,zone.y,zone.y - 1,level_shockwave,100,100);
            f_GoBeefy(zone);
            zone.fp_StandAnim(zone);
            return undefined;
         }
      }
      else
      {
         zone.magic_gap = zone.magic_gap + 1;
         if(zone.magic_gap > 10)
         {
            var loc3 = zone.body._currentframe - 5;
         }
         else if(zone.magic_gap > 5)
         {
            loc3 = zone.body._currentframe - 2;
         }
         else
         {
            loc3 = zone.body._currentframe - 1;
         }
         zone.body.gotoAndStop(loc3);
      }
   }
   else
   {
      zone.pressed_magic = false;
      zone.magic_gap = zone.magic_gap + 1;
      if(zone.magic_gap > 10)
      {
         loc3 = zone.body._currentframe - 5;
      }
      else if(zone.magic_gap > 5)
      {
         loc3 = zone.body._currentframe - 2;
      }
      else
      {
         loc3 = zone.body._currentframe - 1;
      }
      zone.body.gotoAndStop(loc3);
   }
   if(zone.body._currentframe < 10)
   {
      f_GoDefault(zone);
      zone.fp_StandAnim(zone);
   }
}
function f_bosshealthbar(zone)
{
   var loc1 = zone.u_boss.health;
   if(loc1 < 0)
   {
      loc1 = 0;
   }
   var loc2 = 101 - int(loc1 / zone.u_boss.health_max * 100);
   if(loc1 == 0)
   {
      loc2 = 101;
   }
   else if(loc1 > 0 && loc2 == 101)
   {
      loc2 = 100;
   }
   zone.body.bar.gotoAndStop(loc2);
   if(loc1 <= 0)
   {
      zone.body.face.gotoAndStop("die");
      zone.u_boss.fp_DieAction(zone);
   }
}
function f_PlayersWalkToPoint(zone)
{
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc2 = _root.loader.game.game["p" + int(loc3)];
      if(loc2.alive)
      {
         var loc5 = zone._x;
         var loc4 = zone._y;
         _root.f_WalkToInit(loc2,loc5,loc4,loc2.fp_StandAnim,false);
      }
      loc3 = loc3 + 1;
   }
}
function f_ClearTimers(zone)
{
   if(zone.poison_timer > 0)
   {
      zone.poison_timer = 1;
      f_PoisonClock(zone);
   }
   if(zone.fire_timer > 0)
   {
      zone.fire_timer = 1;
      f_FireClock(zone);
   }
   zone.dashing = false;
   zone.truespeed_timer = 0;
   zone.ember_timer = 0;
   zone.invincible_timer = 0;
   zone.smoking_timer = 0;
   zone.levelup_timer = 0;
}
function f_Wait(zone)
{
   f_ClearTimers(zone);
   if(zone.horse)
   {
      zone.gotoAndStop("horse_wait");
      zone.horse.gotoAndStop("idle");
   }
   else
   {
      zone.gotoAndStop("wait");
   }
}
function f_ClearVsTrueskill()
{
   vs_time = 0;
   var loc2 = 0;
   while(loc2 < 4)
   {
      _root["hud" + (loc2 + 1)].death_time = 999999999999;
      SetScores(loc2,0,0,0);
      loc2 = loc2 + 1;
   }
}
function f_SetVsTrueskill()
{
   var loc5 = 1;
   while(loc5 <= 4)
   {
      var loc4 = _root["hud" + loc5];
      var loc6 = 0;
      if(loc4.active)
      {
         var loc2 = 1;
         while(loc2 <= 4)
         {
            var loc3 = _root["hud" + loc2];
            if(loc3.active)
            {
               if(!(loc5 != loc2 && loc4.death_time < loc3.death_time))
               {
                  loc6 = loc6 + 1;
               }
            }
            loc2 = loc2 + 1;
         }
         if(loc4.port > 0)
         {
            SetScores(loc4.port - 1,-1,-1,loc6);
         }
      }
      loc5 = loc5 + 1;
   }
}
function f_GoDance(zone)
{
   f_ClearTimers(zone);
   if(zone.beefy)
   {
      zone.gotoAndStop("beefylaugh");
   }
   else
   {
      zone.gotoAndStop("dance" + (random(4) + 1));
   }
}
function f_PlayersGoDance()
{
   if(GetGameMode() == 3)
   {
      var loc6 = 0;
      var loc5 = 1;
      while(loc5 <= 4)
      {
         var loc2 = _root.loader.game.game["p" + int(loc5)];
         if(loc2)
         {
            if(loc2.health > 0)
            {
               loc6 = loc2.flag;
               loc5 = 5;
            }
         }
         loc5 = loc5 + 1;
      }
      if(IsNetGame())
      {
         var loc8 = 0;
         loc5 = 1;
         while(loc5 <= 4)
         {
            loc2 = _root.loader.game.game["p" + int(loc5)];
            if(loc2)
            {
               if(loc2.hud_pt.port > 0)
               {
                  if(loc2.flag != loc6)
                  {
                     loc8 = loc8 + 1;
                  }
               }
            }
            loc5 = loc5 + 1;
         }
         SetFlashGlobal("g_nArenaPoints",loc8);
         f_SetVsTrueskill();
      }
   }
   loc5 = 1;
   while(loc5 <= 4)
   {
      loc2 = _root.loader.game.game["p" + int(loc5)];
      if(loc2)
      {
         if(GetGameMode() == 3)
         {
            if(loc2.hud_pt.port > 0)
            {
               if(IsNetGame())
               {
                  if(loc2.flag == loc6)
                  {
                     SetScores(loc2.hud_pt.port - 1,1,0,-1);
                  }
                  else
                  {
                     SetScores(loc2.hud_pt.port - 1,0,1,-1);
                  }
               }
               if(loc2.flag == loc6)
               {
                  _root["player" + int(loc2.player_num) + "wins"] += 1;
                  if(IsNetGame())
                  {
                     var loc4 = 0;
                     var loc7 = int(_root.save_data_info.char_offset + _root.save_data_info.char_size * int(f_GetSaveDataOffset(loc2.p_type)) + 29);
                     ReadStorage(loc2.hud_pt.port - 1,loc7);
                     var loc3 = 0;
                     while(loc3 < 4)
                     {
                        loc4 += ReadStorage(loc2.hud_pt.port - 1) << 8 | ReadStorage(loc2.hud_pt.port - 1);
                        loc3 = loc3 + 1;
                     }
                     _root.f_UpdateAchievement("ArenaMaster",loc2.hud_pt.port,loc4);
                  }
               }
            }
         }
         if(loc2.health > 0)
         {
            if(loc2.horse)
            {
               f_PlayerStop(loc2);
            }
            if(GetGameMode() == 3)
            {
               _root["player" + int(loc2.player_num) + "winner"] = 1;
            }
            if(loc2.fp_StandAnim != f_GoDance)
            {
               loc2.fp_PrevStandAnim = loc2.fp_StandAnim;
               loc2.fp_PrevWalkAnim = loc2.fp_WalkAnim;
               loc2.fp_PrevDashAnim = loc2.fp_DashAnim;
               loc2.fp_StandAnim = f_GoDance;
               loc2.fp_WalkAnim = f_GoDance;
               loc2.fp_DashAnim = f_GoDance;
               loc2.fp_HorseRide = f_GoDance;
               loc2.fp_ThrowAction = f_GoDance;
               loc2.fp_Jab = f_GoDance;
               loc2.fp_Fierce = f_GoDance;
               loc2.fp_JabFierce = f_GoDance;
            }
            if(loc2.blocking)
            {
               loc2.blocking = false;
               loc2.fp_StandAnim(loc2);
            }
         }
      }
      loc5 = loc5 + 1;
   }
}
function f_PlayerStop(c)
{
   if(c.fp_StandAnim != f_Wait)
   {
      f_ClearTimers(c);
      c.fp_PrevStandAnim = c.fp_StandAnim;
      c.fp_PrevWalkAnim = c.fp_WalkAnim;
      c.fp_PrevDashAnim = c.fp_DashAnim;
      c.fp_PrevCharacter = c.fp_Character;
      c.fp_PrevHorseRide = c.fp_HorseRide;
      c.fp_StandAnim = f_Wait;
      c.fp_WalkAnim = f_Wait;
      c.fp_DashAnim = f_Wait;
      c.fp_Character = f_Wait;
      c.fp_HorseRide = f_Wait;
      if(c.blocking)
      {
         c.blocking = false;
         c.fp_StandAnim(c);
      }
   }
}
function f_PlayersStop()
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = _root.loader.game.game["p" + int(loc2)];
      f_PlayerStop(loc3);
      loc2 = loc2 + 1;
   }
}
function f_PlayerGo(c)
{
   if(c.fp_StandAnim == f_Wait)
   {
      f_ClearTimers(c);
      c.fp_StandAnim = c.fp_PrevStandAnim;
      c.fp_WalkAnim = c.fp_PrevWalkAnim;
      c.fp_DashAnim = c.fp_PrevDashAnim;
      c.fp_Character = c.fp_PrevCharacter;
      c.fp_HorseRide = c.fp_PrevHorseRide;
      c.fp_StandAnim(c);
   }
}
function f_PlayersGo()
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = _root.loader.game.game["p" + int(loc2)];
      f_PlayerGo(loc3);
      loc2 = loc2 + 1;
   }
}
function f_AllPlayersGo()
{
   var loc1 = 1;
   while(loc1 <= total_players)
   {
      var loc2 = playerArrayOb["p_pt" + int(loc1)];
      f_PlayerGo(loc2);
      loc1 = loc1 + 1;
   }
}
function f_EnemiesGo()
{
   var loc1 = 1;
   while(loc1 <= active_enemies)
   {
      var loc2 = enemyArrayOb["e" + int(loc1)];
      f_PlayerGo(loc2);
      loc1 = loc1 + 1;
   }
}
function f_EnemiesStop()
{
   var loc1 = 1;
   while(loc1 <= active_enemies)
   {
      var loc2 = enemyArrayOb["e" + int(loc1)];
      f_PlayerStop(loc2);
      loc1 = loc1 + 1;
   }
}
function f_PlayersBlank()
{
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = _root.loader.game.game["p" + int(loc2)];
      loc3.gotoAndStop("blank");
      loc2 = loc2 + 1;
   }
}
function f_HorseScroll(zone)
{
   zone.guide._x += zone.speed;
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc2 = _root.loader.game.game["p" + int(loc3)];
      if(loc2.alive)
      {
         f_MoveCharH(loc2,zone.speed,0);
         f_SetXY(loc2.horse,loc2.x,loc2.y - 1);
      }
      loc3 = loc3 + 1;
   }
}
function f_CannonBallBombAttack()
{
   var loc4 = p_game.p1.x + 550;
   var loc3 = p_game.p1.y;
   var loc2 = -300;
   var loc1 = f_CannonBallBomb(loc4,loc3,loc2,true);
   loc1.speed_x = -20;
   loc1.speed_y = 0;
}
function f_HorseHeadJuggle(zone)
{
   zone.speed_toss_y = - (10 + random(6));
   zone.speed_toss_x = 3 + random(5);
   f_CallJuggle1(zone);
}
function f_SetHorseHead(zone)
{
   zone.punch = true;
   zone.grab = false;
   zone.has_shadow = true;
   zone.bounces = 2;
   zone.weight = 2;
   zone.explode = false;
   zone.active = true;
   zone.alive = true;
   zone.shadow_pt = f_NewShadow();
   zone.shadow_pt._x = zone._x;
   zone.shadow_pt._y = zone._y;
   zone.health_max = 1000;
   zone.health = zone.health_max;
   zone.nofight = true;
   zone.h = 60;
   zone.w = 50;
}
function f_HorseHeadIdle(zone)
{
   zone.gotoAndStop("splat");
}
function f_NPCHorseExit(zone)
{
   var loc2 = zone.player_num - 4;
   f_WalkToInit(p_game["p" + loc2],p_game["horse" + loc2]._x,p_game["horse" + loc2]._y,f_ExitOnHorse,true);
   zone.horse.gotoAndStop("wait");
   zone.horse = undefined;
   zone.body_y = 0;
   f_WalkToInit(zone,zone._x - 1000,zone._y,f_Wait,false);
}
function f_ExitOnHorse(zone)
{
   zone.horse = p_game["horse" + zone.player_num];
   zone.body_y = -56;
   zone.fp_HorseRide = f_HorseRide;
   f_WalkToInit(zone,zone._x + 500,zone._y,f_Wait,false);
}
function f_VillagersOnHorseback()
{
   f_ClearQ();
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc4 = playerArrayOb["p_pt" + int(loc3)];
      if(loc4.alive)
      {
         var loc2 = f_MakeFriend(6,p_game.door2._x + loc3 * 30,p_game.door2._y + 75 - loc3 * 30);
         loc2.horse = p_game["horse" + loc3];
         loc2.body_y = -56;
         loc2.fp_HorseRide = f_HorseRide;
         var loc6 = loc2._x - 300;
         var loc5 = loc2._y;
         f_PlayersStop();
         f_WalkToInit(loc2,loc6,loc5,_root.f_NPCHorseExit,true);
      }
      loc3 = loc3 + 1;
   }
   f_PlayerArray();
}
function f_SlideSlice(zone)
{
   if(zone.body_y >= 0)
   {
      f_MoveCharH(zone,zone.body.speed,0);
      if(zone.body.speed > 0)
      {
         zone.body.speed -= 2;
         if(zone.body.speed < 1)
         {
            zone.body.speed = 1;
         }
      }
      else
      {
         zone.body.speed += 2;
         if(zone.body.speed > -1)
         {
            zone.body.speed = -1;
         }
      }
   }
}
function f_PlayersNuked()
{
   var loc3 = 1;
   while(loc3 <= 4)
   {
      var loc2 = _root.loader.game.game["p" + int(loc3)];
      if(loc2.alive)
      {
         if(loc2.horse)
         {
            loc2.horse.gotoAndStop("splat");
            var loc4 = p_game["horseblood" + loc3];
            loc4._x = loc2.horse.x;
            loc4._y = loc2.horse.y;
            loc4.gotoAndStop(2);
            f_SetXY(loc2.horse,loc2.horse._x + 20,loc2.y + 1);
            loc2.horse.fp_StandAnim = f_HorseHeadIdle;
            f_SetHorseHead(loc2.horse);
            f_InsertEnemy(loc2.horse);
            loc2.horse.speed_toss_x = -0.5;
            loc2.horse.speed_toss_y = -94;
            f_Juggle1Setup(loc2.horse);
            loc2.horse.gotoAndStop("juggle1");
            loc2.horse = undefined;
         }
         loc2.fire_timer = 119;
         f_ColorSwap(loc2,color_dark);
         loc2.speed_toss_x = 0;
         loc2.speed_toss_y = -100;
         f_Juggle1Setup(loc2);
         loc2.gotoAndStop("juggle1");
      }
      loc3 = loc3 + 1;
   }
   f_PlayerArray();
}
function f_ItemToggle(zone)
{
   if(GetGameMode() == 3)
   {
      return undefined;
   }
   if(zone.alive and zone.health > 0)
   {
      if(Key.isDown(zone.button_l2))
      {
         if(!zone.pressed_button_l2)
         {
            zone.pressed_button_l2 = true;
            if(zone.healthpots > 0)
            {
               zone.hud_pt.item_unlocks[9] = true;
            }
            else
            {
               zone.hud_pt.item_unlocks[9] = false;
            }
            if(zone.bombs > 0)
            {
               zone.hud_pt.item_unlocks[8] = true;
            }
            else
            {
               zone.hud_pt.item_unlocks[8] = false;
            }
            if(zone.beefies > 0 && level != 23 && level != 102 && zone.p_type != 32)
            {
               zone.hud_pt.item_unlocks[11] = true;
            }
            else
            {
               zone.hud_pt.item_unlocks[11] = false;
            }
            var loc3 = false;
            var loc2 = 1;
            while(loc2 <= 11)
            {
               if(zone.hud_pt.item_unlocks[loc2])
               {
                  loc3 = true;
                  break;
               }
               loc2 = loc2 + 1;
            }
            if(!loc3)
            {
               return undefined;
            }
            if(!zone.equippeditem)
            {
               zone.equippeditem = 1;
            }
            do
            {
               zone.equippeditem = zone.equippeditem - 1;
               if(zone.equippeditem < 1)
               {
                  zone.equippeditem = 11;
               }
            }
            while(!zone.hud_pt.item_unlocks[zone.equippeditem]);
            
            zone.hud_pt.stats.item.gotoAndStop(zone.equippeditem + 1);
            zone.overlay.gotoAndStop("itemselect");
            zone.overlay.itemselect.gotoAndPlay(2);
            zone.overlay.itemselect.icon2.gotoAndPlay(1);
            zone.overlay.gotoAndStop("itemselect");
            zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
         }
      }
      else
      {
         zone.pressed_button_l2 = false;
      }
      if(Key.isDown(zone.button_r2))
      {
         if(!zone.pressed_button_r2)
         {
            zone.pressed_button_r2 = true;
            if(zone.healthpots > 0)
            {
               zone.hud_pt.item_unlocks[9] = true;
            }
            else
            {
               zone.hud_pt.item_unlocks[9] = false;
            }
            if(zone.bombs > 0)
            {
               zone.hud_pt.item_unlocks[8] = true;
            }
            else
            {
               zone.hud_pt.item_unlocks[8] = false;
            }
            if(zone.beefies > 0 && level != 23 && level != 102 && zone.p_type != 32)
            {
               zone.hud_pt.item_unlocks[11] = true;
            }
            else
            {
               zone.hud_pt.item_unlocks[11] = false;
            }
            loc3 = false;
            loc2 = 1;
            while(loc2 <= 11)
            {
               if(zone.hud_pt.item_unlocks[loc2])
               {
                  loc3 = true;
                  break;
               }
               loc2 = loc2 + 1;
            }
            if(!loc3)
            {
               return undefined;
            }
            do
            {
               zone.equippeditem = zone.equippeditem + 1;
               if(zone.equippeditem > 11)
               {
                  zone.equippeditem = 1;
               }
            }
            while(!zone.hud_pt.item_unlocks[zone.equippeditem]);
            
            zone.hud_pt.stats.item.gotoAndStop(zone.equippeditem + 1);
            zone.overlay.gotoAndStop("itemselect");
            zone.overlay.itemselect.gotoAndPlay(2);
            zone.overlay.itemselect.icon2.gotoAndPlay(1);
            zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
         }
      }
      else
      {
         zone.pressed_button_r2 = false;
      }
   }
}
function f_ExitAutoRight(zone)
{
   var loc4 = zone._x + 200;
   var loc3 = zone._y;
   _root.f_WalkToInit(zone,loc4,loc3,zone.fp_StandAnim,true);
   zone.fp_WalkAnim = undefined;
   zone.fp_DashAnim = undefined;
   zone.fp_StandAnim = undefined;
}
function f_ExitAutoLeft(zone)
{
   var loc4 = zone._x - 200;
   var loc3 = zone._y;
   _root.f_WalkToInit(zone,loc4,loc3,zone.fp_StandAnim,true);
   zone.fp_WalkAnim = undefined;
   zone.fp_DashAnim = undefined;
   zone.fp_StandAnim = undefined;
}
function f_DefaultExit(zone)
{
   f_PlayerGetsPickups(zone);
}
function f_UpdateOverlay(zone)
{
   zone.overlay._y = zone.overlay.initOverlayY + zone.body_y + zone.body_table_y;
   zone.overlay._xscale = zone._xscale <= 0 ? -100 : 100;
}
function f_CheckPushCharH(zone, u_temp, speed)
{
   if(zone == u_temp) {
      return;
   }
   if(u_temp.y > zone.u_wall_top)
   {
      if(u_temp.y < zone.u_wall_bottom)
      {
         if(speed == 0)
         {
            if(u_temp.x <= zone.u_wall_right)
            {
               if(u_temp.x >= zone.u_wall_left)
               {
                  if(u_temp.x > zone.u_wall_center_h)
                  {
                     f_MoveCharH(u_temp,zone.u_wall_right - u_temp.x,0);
                  }
                  else
                  {
                     f_MoveCharH(u_temp,zone.u_wall_left - u_temp.x,0);
                  }
               }
            }
         }
         else if(speed < 0)
         {
            if(u_temp.x < zone.u_wall_right)
            {
               if(u_temp.x > zone.u_wall_left + speed)
               {
                  f_MoveCharH(u_temp,zone.u_wall_left + speed - u_temp.x,0);
               }
            }
         }
         else if(u_temp.x > zone.u_wall_left)
         {
            if(u_temp.x < zone.u_wall_right + speed)
            {
               f_MoveCharH(u_temp,zone.u_wall_right + speed - u_temp.x,0);
            }
         }
      }
   }
}
function f_CheckPushCharV(zone, u_temp, speed)
{
   if(zone == u_temp) {
      return;
   }
   if(u_temp.x > zone.u_wall_left)
   {
      if(u_temp.x < zone.u_wall_right)
      {
         if(speed < 0)
         {
            if(u_temp.y < zone.u_wall_bottom)
            {
               if(u_temp.y > zone.u_wall_top + speed)
               {
                  f_MoveCharV(u_temp,zone.u_wall_top + speed - u_temp.y,0);
               }
            }
         }
         else if(u_temp.y > zone.u_wall_top)
         {
            if(u_temp.y < zone.u_wall_bottom + speed)
            {
               f_MoveCharV(u_temp,zone.u_wall_bottom + speed - u_temp.y,0);
            }
         }
      }
   }
}
function f_CheckPushCharOut(zone, u_temp)
{
   if(zone == u_temp) {
      return;
   }
   if(!u_temp.burried)
   {
      if(u_temp.x > zone.u_wall_left)
      {
         if(u_temp.x < zone.u_wall_right)
         {
            if(u_temp.y < zone.u_wall_bottom)
            {
               if(u_temp.y > zone.u_wall_top)
               {
                  if(u_temp.x < zone.u_wall_center_h)
                  {
                     var loc4 = zone.u_wall_left - u_temp.x;
                  }
                  else
                  {
                     loc4 = zone.u_wall_right - u_temp.x;
                  }
                  if(u_temp.y < zone.u_wall_center_v)
                  {
                     var loc3 = zone.u_wall_top - u_temp.y;
                  }
                  else
                  {
                     loc3 = zone.u_wall_bottom - u_temp.y;
                  }
                  if(Math.abs(loc4) < Math.abs(loc3))
                  {
                     if(zone.smasher)
                     {
                        if(u_temp.y >= zone.y)
                        {
                           f_MoveCharV(u_temp,zone.y - u_temp.y,0);
                        }
                        f_FX(u_temp.x,zone.y - 10,int(zone.y) + 2,"impact1",100,100);
                        s_Punch3.start(0,0);
                        if(f_EnemyUsesPlayerSwf(u_temp))
                        {
                           u_temp.body_y = 0;
                           u_temp.burried = true;
                           u_temp.nohit = true;
                           u_temp.gotoAndStop("burried");
                        }
                        if(zone.smash_pow)
                        {
                           f_Damage(u_temp,zone.smash_pow,DMG_MELEE);
                        }
                        else
                        {
                           f_Damage(u_temp,10,DMG_MELEE);
                        }
                     }
                     else
                     {
                        f_MoveCharH(u_temp,loc4,0);
                        if(zone.ram)
                        {
                           if(!u_temp.nohit and u_temp.invincible_timer <= 0)
                           {
                              s_Punch3.start(0,0);
                              if(zone.smash_pow)
                              {
                                 var loc5 = zone.smash_pow;
                              }
                              else
                              {
                                 loc5 = 2;
                              }
                              if(zone.force_x)
                              {
                                 f_Damage(u_temp,loc5,DMG_MELEE,DMGFLAG_JUGGLE,zone.force_x,zone.force_y);
                              }
                              else
                              {
                                 f_Damage(u_temp,loc5,DMG_MELEE,DMGFLAG_JUGGLE,random(6) + 10,- (random(10) + 10));
                              }
                           }
                        }
                     }
                     return true;
                  }
                  if(zone.smasher)
                  {
                     if(u_temp.y >= zone.y)
                     {
                        f_MoveCharV(u_temp,zone.y - u_temp.y,0);
                     }
                     f_FX(u_temp.x,zone.y - 10,int(zone.y) + 2,"impact1",100,100);
                     s_Punch3.start(0,0);
                     if(f_EnemyUsesPlayerSwf(u_temp))
                     {
                        u_temp.burried = true;
                        u_temp.nohit = true;
                        u_temp.body_y = 0;
                        u_temp.gotoAndStop("burried");
                     }
                     var dmg = 5;
                     if(zone.smash_pow) {
                        dmg = zone.smash_pow;
                     }
                     f_Damage(u_temp,dmg,DMG_MELEE);
                  }
                  else
                  {
                     f_MoveCharV(u_temp,loc3,0);
                     if(zone.ram)
                     {
                        if(!u_temp.nohit and u_temp.invincible_timer <= 0)
                        {
                           s_Punch3.start(0,0);
                           var dmg = 2;
                           if(zone.smash_pow)
                           {
                              dmg = zone.smash_pow;
                           }
                           
                           if(zone.force_x)
                           {
                              f_Damage(u_temp,dmg,DMG_MELEE,DMGFLAG_JUGGLE,zone.force_x,zone.force_y);
                           }
                           else
                           {
                              f_Damage(u_temp,dmg,DMG_MELEE,DMGFLAG_JUGGLE,random(6) + 6,- (random(10) + 10));
                           }
                        }
                     }
                  }
                  return true;
               }
            }
         }
      }
   }
}
function f_PushCharsH(zone, speed)
{
   if(zone._xscale > 0)
   {
      zone.u_wall_left = zone._x + zone.wall._x - zone.wall._width / 2;
      zone.u_wall_right = zone._x + zone.wall._x + zone.wall._width / 2;
      zone.u_wall_center_h = zone._x + zone.wall._x;
   }
   else
   {
      zone.u_wall_left = zone._x - zone.wall._x - zone.wall._width / 2;
      zone.u_wall_right = zone._x - zone.wall._x + zone.wall._width / 2;
      zone.u_wall_center_h = zone._x - zone.wall._x;
   }
   zone.u_wall_top = zone._y + zone.wall._y - zone.wall._height / 2;
   zone.u_wall_bottom = zone._y + zone.wall._y + zone.wall._height / 2;
   zone.u_wall_center_v = zone._y + zone.wall._y;
   var loc2 = 1;
   while(loc2 <= total_players)
   {
      var loc3 = playerArrayOb["p_pt" + int(loc2)];
      f_CheckPushCharH(zone,loc3,speed);
      loc2 = loc2 + 1;
   }
   loc2 = 1;
   while(loc2 <= active_enemies)
   {
      loc3 = enemyArrayOb["e" + int(loc2)];
      if(loc3 != zone)
      {
         f_CheckPushCharH(zone,loc3,speed);
      }
      loc2 = loc2 + 1;
   }
}
function f_PushCharsV(zone, speed)
{
   if(zone._xscale > 0)
   {
      zone.u_wall_left = zone._x + zone.wall._x - zone.wall._width / 2;
      zone.u_wall_right = zone._x + zone.wall._x + zone.wall._width / 2;
   }
   else
   {
      zone.u_wall_left = zone._x - zone.wall._x - zone.wall._width / 2;
      zone.u_wall_right = zone._x - zone.wall._x + zone.wall._width / 2;
   }
   zone.u_wall_center_h = zone._x + zone.wall._x;
   zone.u_wall_top = zone._y + zone.wall._y - zone.wall._height / 2;
   zone.u_wall_bottom = zone._y + zone.wall._y + zone.wall._height / 2;
   zone.u_wall_center_v = zone._y + zone.wall._y;
   var loc2 = 1;
   while(loc2 <= total_players)
   {
      var loc3 = playerArrayOb["p_pt" + int(loc2)];
      f_CheckPushCharV(zone,loc3,speed);
      loc2 = loc2 + 1;
   }
   loc2 = 1;
   while(loc2 <= active_enemies)
   {
      loc3 = enemyArrayOb["e" + int(loc2)];
      if(loc3 != zone)
      {
         f_CheckPushCharV(zone,loc3,speed);
      }
      loc2 = loc2 + 1;
   }
}
function f_PushCharsOut(zone)
{
   var loc4 = false;
   if(zone._xscale > 0)
   {
      zone.u_wall_left = zone._x + zone.wall._x - zone.wall._width / 2;
      zone.u_wall_right = zone._x + zone.wall._x + zone.wall._width / 2;
   }
   else
   {
      zone.u_wall_left = zone._x - zone.wall._x - zone.wall._width / 2;
      zone.u_wall_right = zone._x - zone.wall._x + zone.wall._width / 2;
   }
   zone.u_wall_center_h = zone._x + zone.wall._x;
   zone.u_wall_top = zone._y + zone.wall._y - zone.wall._height / 2;
   zone.u_wall_bottom = zone._y + zone.wall._y + zone.wall._height / 2;
   zone.u_wall_center_v = zone._y + zone.wall._y;
   var loc2 = 1;
   if(!zone.human) 
   {
      while(loc2 <= total_players)
      {
         var loc3 = playerArrayOb["p_pt" + int(loc2)];
         if(f_CheckPushCharOut(zone,loc3))
         {
            loc4 = true;
         }
         loc2 = loc2 + 1;
      }
   }
   loc2 = 1;
   while(loc2 <= active_enemies)
   {
      loc3 = enemyArrayOb["e" + int(loc2)];
      if(loc3 != zone)
      {
         if(f_CheckPushCharOut(zone,loc3)) {
            loc4 = true;
         }
      }
      loc2 = loc2 + 1;
   }
   return loc4;
}
function f_StarInit(zone)
{
   zone.hrange = 3 + random(6);
   zone.h = random(628.3185307179587) / 100;
   zone.yrate = 4 + random(200) / 100;
   zone.scale = 10;
   zone.scalerate = zone.yrate * 4;
   zone._xscale = 0;
   zone._yscale = 0;
   zone._parent._rotation = random(90) - 45;
}
function f_StarUpdate(zone)
{
   zone.h += random(30) / 100;
   zone._x = Math.sin(zone.h) * zone.hrange;
   zone._y -= zone.yrate;
   zone.scale += zone.scalerate;
   if(zone.scale > 200)
   {
      zone.scale = 200;
      zone.scalerate *= -0.5;
   }
   else if(zone.scale < 0)
   {
      zone.scale = 0;
   }
   if(zone.scalerate < 0)
   {
      zone._alpha = zone.scale / 2;
   }
   if(zone.scale > 100)
   {
      zone._xscale = 100;
      zone._yscale = 100;
   }
   else
   {
      zone._xscale = zone.scale;
      zone._yscale = zone.scale;
   }
}
function f_WaitOffscreen(zone)
{
   if(zone.x > main.left + 20)
   {
      if(zone.x < main.right - 20)
      {
         zone.fp_StandAnim(zone);
      }
   }
}
function f_WaitTimer(zone)
{
   zone.wait_timer = zone.wait_timer - 1;
   if(zone.wait_timer <= 0)
   {
      zone.fp_WaitTimer = _root.f_Null;
      zone.fp_Wait = _root.f_Null;
      zone.fp_StandAnim(zone);
   }
}
function f_NPCWalkLeft(zone)
{
   var loc2 = zone.x;
   f_MoveCharH(zone,- zone.speed,0);
   if(zone.x == loc2)
   {
      f_FlipChar(zone);
      zone.fp_Character = f_NPCWalkRight;
   }
   else if(zone.x < main.left - zone._width)
   {
      zone.gotoAndStop("remove");
   }
}
function f_NPCWalkRight(zone)
{
   var loc2 = zone.x;
   f_MoveCharH(zone,zone.speed,0);
   if(zone.x == loc2)
   {
      f_FlipChar(zone);
      zone.fp_Character = f_NPCWalkLeft;
   }
   else if(zone.x > main.right + zone._width)
   {
      zone.gotoAndStop("remove");
   }
}
function f_Overlay(zone)
{
   if(zone.owner.body_y < 0)
   {
      zone.owner.fp_StandAnim = f_StandType1;
      zone.owner.fp_WalkAnim = f_WalkType1;
      zone.gotoAndStop("die");
   }
   else if(zone._x != zone.owner._x or zone._y != zone.owner._y)
   {
      zone.x = zone.owner.x;
      zone.y = zone.owner._y;
      zone.hitzone.x = zone.x + zone.hitzone._x;
      zone.hitzone.y = zone.y + zone.hitzone._y;
      zone._x = zone.x;
      zone._y = zone.y;
      f_Depth(zone,zone._y + 3);
      zone.gotoAndStop("walk");
   }
   else
   {
      zone.gotoAndStop("overlay");
   }
}
function f_CinemaPan(zone)
{
   u_point.x = 0;
   u_point.y = 0;
   f_LocalToGame(zone,u_point);
   var loc1 = - u_point.x;
   if(main.camera_x_goal < loc1)
   {
      main.camera_x_goal += 30;
      return true;
   }
   return false;
}
function f_CheckCenter(zone)
{
   if(zone.x + _root.loader.game.game._x <= GAME_WIDTH / 2)
   {
      return true;
   }
   return false;
}
function f_Taunt1(zone)
{
   if(zone.shot_timer <= 0)
   {
      zone.shot_timer = zone.shot_timer_default;
      zone.walking = false;
      zone.gotoAndStop("taunt1");
   }
}
function f_EnemyHorseMelee(zone)
{
   if(zone.horse.mount_type == 4)
   {
      var loc3 = 260;
   }
   else
   {
      loc3 = 100;
   }
   if(!zone.punching)
   {
      if(Math.abs(zone.y - zone.prey.y) <= zone.speed)
      {
         if(Math.abs(zone.x - zone.prey.x) < loc3)
         {
            if(!zone.prey.nohit)
            {
               if(zone.prey.body_y > -100)
               {
                  zone.walking = false;
                  if(zone.horse.mount_type == 2 or zone.horse.mount_type == 4)
                  {
                     if(zone.horse.body.head._currentframe == 1)
                     {
                        if(zone.shot_timer <= 0)
                        {
                           zone.shot_timer = 120;
                           zone.horse.force_x = 4 + random(5);
                           zone.horse.force_y = - (12 + random(5));
                           zone.horse.attack_type = _root.DMG_MELEE;
                           zone.horse.punch_group = 300;
                           zone.horse.punch_num = 1;
                           zone.horse.body.head.gotoAndPlay("bite");
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
function f_FaceClosestPlayer(zone, noflip)
{
   var loc6 = 10000;
   var loc2 = 1;
   while(loc2 <= active_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc2)];
      if(loc1.alive)
      {
         var loc3 = Math.abs(zone.x - loc1.x) + Math.abs(zone.y - loc1.y);
         if(loc3 < loc6)
         {
            loc6 = loc3;
            var loc5 = loc1;
         }
      }
      loc2 = loc2 + 1;
   }
   if(!noflip)
   {
      if(loc5.x > zone.x)
      {
         if(zone._xscale < 0)
         {
            zone._xscale *= -1;
         }
      }
      else if(zone._xscale > 0)
      {
         zone._xscale *= -1;
      }
   }
   return loc5;
}
function f_FaceClosestPlayerInRange(zone)
{
   var loc5 = 10000;
   var loc6 = undefined;
   var loc2 = 1;
   while(loc2 <= active_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc2)];
      if(loc1.alive)
      {
         if(Math.abs(zone.y - loc1.y) < 15)
         {
            var loc3 = Math.abs(zone.x - loc1.x);
            if(loc3 < loc5)
            {
               loc5 = loc3;
               loc6 = loc1;
            }
         }
      }
      loc2 = loc2 + 1;
   }
   if(loc6)
   {
      if(loc6.x > zone.x)
      {
         if(zone._xscale < 0)
         {
            zone._xscale *= -1;
         }
      }
      else if(zone._xscale > 0)
      {
         zone._xscale *= -1;
      }
   }
   return loc6;
}
function f_KissClosestPlayer(zone, u_temp)
{
   if(active_players < 1 or active_players == 1 and playerArrayOb.p_pt1.health <= 0)
   {
      if(level == 59)
      {
         zone.gotoAndStop("kiss");
      }
      else
      {
         f_ScoreTally();
      }
   }
   else if(Math.abs(zone.y - u_temp.y) < 10)
   {
      if(Math.abs(zone.x - u_temp.x) < 40)
      {
         if(u_temp.body_y >= -5)
         {
            if(zone._xscale > 0)
            {
               if(u_temp._xscale > 0)
               {
                  u_temp._xscale *= -1;
               }
            }
            else if(u_temp._xscale < 0)
            {
               u_temp._xscale *= -1;
            }
            if(u_temp._xscale > 0)
            {
               f_SetXY(u_temp,zone.x - 52,zone.y + 1);
            }
            else
            {
               f_SetXY(u_temp,zone.x + 52,zone.y + 1);
            }
            zone.prey = u_temp;
            u_temp.magicmode = false;
            f_ClearTimers(u_temp);
            u_temp.gotoAndStop("kiss");
            zone.gotoAndStop("kiss");
         }
      }
   }
}
function f_VSPrep()
{
   if(active_players > 1 or arenabattle)
   {
      friendly_fire = true;
      vs_fight = true;
      var loc2 = 1;
      while(loc2 <= active_players)
      {
         var loc1 = playerArrayOb["p_pt" + int(loc2)];
         if(loc1.alive)
         {
            var loc3 = p_game["vs" + loc2]._x;
            loc1.temp_speed_x = (loc3 - loc1.x) / 11;
            loc1.temp_speed_y = (p_game["vs" + loc2]._y - loc1.y) / 11;
            if(loc3 > p_game.vs_center._x)
            {
               if(loc1._xscale > 0)
               {
                  loc1._xscale *= -1;
               }
            }
            else if(loc1._xscale < 0)
            {
               loc1._xscale *= -1;
            }
            loc1.body_y = 0;
            if(p_game.specialmode == 3)
            {
               loc1.wait_timer = 80;
               loc1.fp_Wait = f_WaitTimer;
               loc1.gotoAndStop("wait");
            }
            else
            {
               loc1.gotoAndStop("vs_intro");
            }
         }
         loc2 = loc2 + 1;
      }
      vs_cinema.gotoAndPlay(2);
   }
}
function f_VSJump(zone)
{
   f_SetXY(zone,zone.x + zone.temp_speed_x,zone.y + zone.temp_speed_y);
}
function fpsLimiter()
{
   newT = getTimer();
   while(Math.abs(newT - oldT) < maxF)
   {
      newT = getTimer();
   }
   oldT = getTimer();
}
function f_BeefyGrappleTarget(zone)
{
   if(_root.boss_fight and _root.level == 43)
   {
      return false;
   }
   if(zone.body_y > -10)
   {
      if(zone.human)
      {
         var loc4 = 1;
         while(loc4 <= active_enemies)
         {
            var loc2 = enemyArrayOb["e" + int(loc4)];
            if(loc2.alive)
            {
               if(Math.abs(zone.y - loc2.y) <= 10)
               {
                  if(Math.abs(zone.x - loc2.x) < 85)
                  {
                     if(!loc2.nohit and loc2.invincible_timer <= 0)
                     {
                        if(loc2.body_y > -10)
                        {
                           if(loc2.beefy)
                           {
                              zone.grappler = loc2;
                              return true;
                           }
                        }
                     }
                  }
               }
            }
            loc4 = loc4 + 1;
         }
      }
      if(friendly_fire or !zone.human)
      {
         loc4 = 1;
         while(loc4 <= active_players)
         {
            loc2 = playerArrayOb["p_pt" + int(loc4)];
            if(loc2 != zone)
            {
               if(loc2.alive)
               {
                  if(f_TeamCheck(zone,loc2))
                  {
                     if(Math.abs(zone.y - loc2.y) <= 10)
                     {
                        if(Math.abs(zone.x - loc2.x) < 85)
                        {
                           if(!loc2.nohit and loc2.invincible_timer <= 0)
                           {
                              if(loc2.body_y > -10)
                              {
                                 if(loc2.beefy)
                                 {
                                    zone.grappler = loc2;
                                    return true;
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            loc4 = loc4 + 1;
         }
      }
   }
   return false;
}
function f_BeefyGrapple(zone)
{
   if(!zone.punching)
   {
      if(f_BeefyGrappleTarget(zone))
      {
         if(zone.grappler.x > zone.x)
         {
            f_MoveCharH(zone.grappler,zone.x + 110 - zone.grappler.x,false);
            if(zone.grappler.x != zone.x + 110)
            {
               f_MoveCharH(zone,zone.grappler.x - 110 - zone.x,false);
            }
            if(zone.grappler._xscale > 0)
            {
               zone.grappler._xscale *= -1;
            }
            if(zone._xscale < 0)
            {
               zone._xscale *= -1;
            }
         }
         else
         {
            f_MoveCharH(zone.grappler,zone.x - 110 - zone.grappler.x,false);
            if(zone.grappler.x != zone.x - 110)
            {
               f_MoveCharH(zone,zone.grappler.x + 110 - zone.x,false);
            }
            if(zone.grappler._xscale < 0)
            {
               zone.grappler._xscale *= -1;
            }
            if(zone._xscale > 0)
            {
               zone._xscale *= -1;
            }
         }
         f_MoveCharV(zone,zone.grappler.y - zone.y,false);
         zone.nohit = true;
         zone.grappler.nohit = true;
         zone.punching = true;
         zone.grappler.punching = true;
         zone.grappler.grappler = zone;
         zone.grappler.gotoAndStop("grapple");
         zone.gotoAndStop("grapple");
         return true;
      }
   }
   return false;
}
function f_GrappleMash(zone)
{
   if(f_AnyButtonPressed(zone))
   {
      zone.grapple_score = zone.grapple_score + 1;
      zone.grapple_timer = 0;
   }
   if(zone.grapple_score > zone.grappler.grapple_score + 5 or zone.grapple_score > zone.grappler.grapple_score + 1 and zone.grapple_score > 10 or zone.grapple_score > 15)
   {
      f_MoveCharH(zone.grappler,zone.x - zone.grappler.x,false);
      f_MoveCharV(zone.grappler,zone.y + 1 - zone.grappler.y,false);
      zone.nohit = false;
      zone.grappler.nohit = false;
      zone.punching = false;
      zone.grappler.punching = false;
      zone.grappler.speed_toss_x = 12;
      zone.grappler.speed_toss_y = -20;
      zone.grappler._xscale *= -1;
      zone.grappler.hitby = zone;
      zone.grappler.gotoAndStop("beefythrown");
      zone.grappler.grappler = undefined;
      zone.grappler = undefined;
      zone.punching = true;
      zone.gotoAndStop("beefythrowbeefy");
   }
   else if(zone.grapple_score > zone.grappler.grapple_score + 1)
   {
      if(zone.y <= zone.grappler.y)
      {
         f_MoveCharV(zone,zone.grappler.y + 1 - zone.y,false);
      }
      zone.torso.torso.gotoAndStop("winning");
      zone.grappler.torso.torso.gotoAndStop("losing");
   }
   else if(zone.grapple_score < zone.grappler.grapple_score - 1)
   {
      if(zone.y > zone.grappler.y)
      {
         f_MoveCharV(zone,zone.grappler.y - 1 - zone.y,false);
      }
      zone.torso.torso.gotoAndStop("losing");
      zone.grappler.torso.torso.gotoAndStop("winning");
   }
   else
   {
      zone.torso.torso.gotoAndStop("draw");
      zone.grappler.torso.torso.gotoAndStop("draw");
   }
}
function f_EnemyGrappleMash(zone)
{
   zone.grapple_score += zone.grapple_aggression;
   if(zone.grapple_score > zone.grappler.grapple_score + 5 or zone.grapple_score > zone.grappler.grapple_score + 1 and zone.grapple_score > 10 or zone.grapple_score > 15)
   {
      f_MoveCharH(zone.grappler,zone.x - zone.grappler.x,false);
      f_MoveCharV(zone.grappler,zone.y + 1 - zone.grappler.y,false);
      zone.grappler.speed_toss_x = 12;
      zone.grappler.speed_toss_y = -20;
      zone.grappler._xscale *= -1;
      zone.grappler.hitby = zone;
      zone.grappler.nohit = false;
      zone.grappler.gotoAndStop("beefythrown");
      zone.grappler.grappler = undefined;
      zone.grappler = undefined;
      zone.gotoAndStop("beefythrowbeefy");
   }
}
function f_SwordLockMash(zone)
{
   if(!zone.grappler)
   {
      zone.fp_StandAnim(zone);
   }
   else if(zone.grappler.frozen)
   {
      zone.grappler.grappler = undefined;
      zone.grappler = undefined;
      zone.fp_StandAnim(zone);
   }
   else
   {
      if(f_AnyButtonPressed(zone))
      {
         zone.grapple_score = zone.grapple_score + 1;
      }
      if(zone.grapple_score > zone.grappler.grapple_score + 4 or zone.grapple_score >= 10)
      {
         zone.nohit = false;
         zone.grappler.nohit = false;
         zone.punching = true;
         zone.grappler.punching = false;
         zone.grappler.grapple_score = 0;
         zone.grappler.gotoAndStop("hit1");
         zone.grappler.grappler = undefined;
         zone.grappler = undefined;
         zone.punch_group = 300;
         zone.punch_num = 1;
         zone.force_x = 13;
         zone.force_y = -16;
         s_Smack2.start(0,0);
         if(zone._xscale > 0)
         {
            f_FX(zone.x + 50,zone.y - 40,int(zone.y) + 1,"impact1",100,100);
         }
         else
         {
            f_FX(zone.x - 50,zone.y - 40,int(zone.y) + 1,"impact1",100,100);
         }
         zone.gotoAndStop("punch5_2");
      }
   }
}
function f_EnemySwordLockMash(zone)
{
   if(!zone.grappler)
   {
      zone.fp_StandAnim(zone);
   }
   else
   {
      zone.grapple_score += zone.grapple_aggression;
      if(zone.grapple_score > zone.grappler.grapple_score + 4 or zone.grapple_score >= 10)
      {
         zone.nohit = false;
         zone.grappler.nohit = false;
         zone.punching = true;
         zone.grappler.punching = false;
         zone.grappler.grapple_score = 0;
         zone.grappler.gotoAndStop("hit1");
         zone.grappler.grappler = undefined;
         zone.grappler = undefined;
         zone.punch_group = 300;
         zone.punch_num = 1;
         zone.force_x = 15;
         zone.force_y = -20;
         s_Smack2.start(0,0);
         if(zone._xscale > 0)
         {
            f_FX(zone.x + 50,zone.y - 40,int(zone.y) + 1,"impact1",100,100);
         }
         else
         {
            f_FX(zone.x - 50,zone.y - 40,int(zone.y) + 1,"impact1",100,100);
         }
         zone.gotoAndStop("punch5_2");
      }
   }
}
function f_ScoreTally()
{
   StopMusic();
   PlayMusic(4,true);
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc1 = p_game["p" + int(loc2)];
      if(loc1.spawned or loc1.alive or loc1.exp > 0 or loc1.kills > 0 or loc1.gold > 0)
      {
         loc1.hud_pt.score_exp = loc1.exp - loc1.exp_start;
         loc1.hud_pt.score_kills = loc1.kills;
         loc1.hud_pt.score_gold = loc1.gold - loc1.gold_start;
         loc1.hud_pt.tally.active = true;
         loc1.hud_pt.tally.gotoAndPlay("tally");
      }
      loc2 = loc2 + 1;
   }
}
function f_ScoreTallyEnd(zone)
{
   zone.tally.active = false;
   zone.player_pt.exp_start = zone.player_pt.exp;
   zone.player_pt.gold_start = zone.player_pt.gold;
   zone.player_pt.kills = 0;
   var loc2 = 1;
   while(loc2 <= 4)
   {
      var loc3 = _root["hud" + int(loc2)];
      if(loc3.tally.active)
      {
         return undefined;
      }
      loc2 = loc2 + 1;
   }
   loc2 = 1;
   while(loc2 <= 4)
   {
      loc3 = _root["hud" + int(loc2)];
      loc3.tally.gotoAndStop(1);
      loc2 = loc2 + 1;
   }
   boss_fight = false;
   friendly_fire = false;
   vs_fight = false;
   zone.tally.gotoAndStop(1);
   switch(level)
   {
      case 6:
      case 58:
         f_SetLevelCompleted(6);
         f_SetLevelVisited(6);
         break;
      case 7:
         _root.level = 101;
         break;
      case 23:
         _root.level = 102;
         break;
      default:
         break;
      case 21:
         f_PlayersGo();
         f_SetLeash(0,0);
         go_arrow.gotoAndPlay(2);
         f_WalkToInit(loader.king,p_game.door6._x + 200,p_game.door6._y,loader.king.fp_StandAnim,true);
         p_game.catapult1.walkto_speed = 5;
         p_game.catapult1.npc = true;
         p_game.catapult2.walkto_speed = 6;
         p_game.catapult2.npc = false;
         _root.f_WalkToInit(p_game.catapult1,p_game.door6._x + 200,p_game.catapult1._y,p_game.catapult1.fp_StandAnim,false);
         _root.f_WalkToInit(p_game.catapult2,p_game.door6._x + 200,p_game.catapult2._y,p_game.catapult2.fp_StandAnim,false);
         return undefined;
      case 30:
         f_SetLevelCompleted(30);
         f_SetLevelVisited(30);
         f_HudWait();
         spawn_portal_num = 3;
         fader.f_FadeOut();
         f_ChangeLevel("../level36/level36.swf");
         return undefined;
   }
   spawn_portal_num = 1;
   fader.f_FadeOut();
   f_ChangeLevel("../map/map.swf");
}
function f_SwimStand(zone)
{
   zone.gotoAndStop("swim_stand");
}
function f_SwimWalk(zone)
{
   zone.gotoAndStop("swim_walk");
}
function f_Swim(zone)
{
   f_Walk(zone);
   if(f_Jump(zone))
   {
      if(zone._xscale > 0)
      {
         var loc2 = -60;
      }
      else
      {
         loc2 = 60;
      }
      f_FX(zone.x,zone.y,int(zone.y + 1),"big_splish",loc2,60);
      return undefined;
   }
   if(zone.walking)
   {
      zone.gotoAndStop("swim_walk");
   }
   else
   {
      zone.gotoAndStop("swim_stand");
   }
}
function f_DiagonalCollision(zone, u_temp, left_x, right_x)
{
   var loc2 = zone._y + zone.hitzone._y - zone.hitzone._height / 2;
   var loc5 = zone._y + zone.hitzone._y + zone.hitzone._height / 2;
   if(u_temp.y > loc2)
   {
      if(u_temp.y < loc5)
      {
         var loc6 = (u_temp.y - loc2) / (loc5 - loc2);
         var loc4 = zone._x + zone.hitzone._x - zone.hitzone._width / 2 + zone.hitzone._width * loc6;
         if(u_temp.x >= loc4 + left_x)
         {
            if(u_temp.x < loc4 + right_x)
            {
               zone.hit_x = loc4;
               return true;
            }
         }
      }
   }
   return false;
}
function f_ShovelCheck(zone)
{
   var loc2 = 1;
   while(loc2 <= shovelspots_total)
   {
      u_temp = shovelspots["s" + int(loc2)];
      if(!u_temp.dug)
      {
         if(Math.abs(zone.y - u_temp.y) < 10)
         {
            if(zone._xscale > 0)
            {
               if(u_temp.x > zone.x)
               {
                  if(u_temp.x < zone.x + 40)
                  {
                     zone.prey = u_temp;
                     return true;
                  }
               }
            }
            else if(u_temp.x < zone.x)
            {
               if(u_temp.x > zone.x - 40)
               {
                  zone.prey = u_temp;
                  return true;
               }
            }
         }
      }
      loc2 = loc2 + 1;
   }
   return false;
}
function f_ShovelMash(zone)
{
   if(f_AnyButtonPressed(zone))
   {
      zone.body.nextFrame();
   }
   return undefined;
}
function f_Walk(zone)
{
   var loc3 = undefined;
   zone.walking = false;
   zone.dashing = false;
   if(console_version)
   {
      if(Key.isDown(zone.button_left))
      {
         zone.left_timer = 1;
         zone.right_timer = 0;
         zone.left_last = g_dash_timer - 1;
         zone.left_last2 = g_dash_timer - 1;
      }
      else if(Key.isDown(zone.button_walk_left))
      {
         zone.left_timer = 1;
         zone.right_timer = 0;
         zone.left_last = g_dash_timer + 1;
         zone.left_last2 = g_dash_timer + 1;
      }
      else
      {
         zone.left_timer = 0;
      }
      if(Key.isDown(zone.button_right))
      {
         zone.left_timer = 0;
         zone.right_timer = 1;
         zone.right_last = g_dash_timer - 1;
         zone.right_last2 = g_dash_timer - 1;
      }
      else if(Key.isDown(zone.button_walk_right))
      {
         zone.left_timer = 0;
         zone.right_timer = 1;
         zone.right_last = g_dash_timer + 1;
         zone.right_last2 = g_dash_timer + 1;
      }
      else
      {
         zone.right_timer = 0;
      }
      if(Key.isDown(zone.button_up))
      {
         zone.up_timer = 1;
         zone.down_timer = 0;
         zone.up_last = g_dash_timer - 1;
         zone.up_last2 = g_dash_timer - 1;
      }
      else if(Key.isDown(zone.button_walk_up))
      {
         zone.up_timer = 1;
         zone.down_timer = 0;
         zone.up_last = g_dash_timer + 1;
         zone.up_last2 = g_dash_timer + 1;
      }
      else
      {
         zone.up_timer = 0;
      }
      if(Key.isDown(zone.button_down))
      {
         zone.up_timer = 0;
         zone.down_timer = 1;
         zone.down_last = g_dash_timer - 1;
         zone.down_last2 = g_dash_timer - 1;
      }
      else if(Key.isDown(zone.button_walk_down))
      {
         zone.up_timer = 0;
         zone.down_timer = 1;
         zone.down_last = g_dash_timer + 1;
         zone.down_last2 = g_dash_timer + 1;
      }
      else
      {
         zone.down_timer = 0;
      }
   }
   else
   {
      if(Key.isDown(zone.button_left))
      {
         zone.right_last = g_dash_timer + 1;
         zone.right_last2 = g_dash_timer + 1;
         if(zone.left_timer <= 0)
         {
            zone.left_last2 = zone.left_timer;
            zone.left_timer = 1;
         }
         else
         {
            zone.left_timer = zone.left_timer + 1;
         }
      }
      else if(zone.left_timer > 0)
      {
         zone.left_last = zone.left_timer;
         zone.left_timer = 0;
      }
      else
      {
         zone.left_timer = zone.left_timer - 1;
      }
      if(Key.isDown(zone.button_right))
      {
         zone.left_last = g_dash_timer + 1;
         zone.left_last2 = g_dash_timer + 1;
         if(zone.right_timer <= 0)
         {
            zone.right_last2 = zone.right_timer;
            zone.right_timer = 1;
         }
         else
         {
            zone.right_timer = zone.right_timer + 1;
         }
      }
      else if(zone.right_timer > 0)
      {
         zone.right_last = zone.right_timer;
         zone.right_timer = 0;
      }
      else
      {
         zone.right_timer = zone.right_timer - 1;
      }
      if(Key.isDown(zone.button_down))
      {
         zone.up_last = g_dash_timer + 1;
         zone.up_last2 = g_dash_timer + 1;
         if(zone.down_timer <= 0)
         {
            zone.down_last2 = zone.down_timer;
            zone.down_timer = 1;
         }
         else
         {
            zone.down_timer = zone.down_timer + 1;
         }
      }
      else if(zone.down_timer > 0)
      {
         zone.down_last = zone.down_timer;
         zone.down_timer = 0;
      }
      else
      {
         zone.down_timer = zone.down_timer - 1;
      }
      if(Key.isDown(zone.button_up))
      {
         zone.down_last = g_dash_timer + 1;
         zone.down_last2 = g_dash_timer + 1;
         if(zone.up_timer <= 0)
         {
            zone.up_last2 = zone.up_timer;
            zone.up_timer = 1;
         }
         else
         {
            zone.up_timer = zone.up_timer + 1;
         }
      }
      else if(zone.up_timer > 0)
      {
         zone.up_last = zone.up_timer;
         zone.up_timer = 0;
      }
      else
      {
         zone.up_timer = zone.up_timer - 1;
      }
   }
   if(level == 23 or level == 102)
   {
      var loc5 = 1;
   }
   else if(level == 51 or level == 49 or level == 57)
   {
      loc5 = 0.3;
   }
   else
   {
      loc5 = 0;
   }
   if(zone.left_timer > 0 and zone.left_timer > zone.right_timer)
   {
      if(zone._xscale > 0)
      {
         if(zone.blocking)
         {
            zone.reverse = true;
         }
         else
         {
            zone.reverse = false;
            f_FlipChar(zone);
         }
      }
      else
      {
         zone.reverse = false;
      }
      if(zone.blocking)
      {
         loc3 = zone.speed_x / 2;
      }
      else if(zone.left_last < g_dash_timer and zone.left_last2 < g_dash_timer and zone.fp_DashAnim)
      {
         if(zone.jumping and !zone.dashjump)
         {
            loc3 = zone.speed_x;
         }
         else
         {
            if(zone.truespeed)
            {
               loc3 = zone.speed_x * 2.2;
            }
            else
            {
               loc3 = zone.speed_x * 1.8;
            }
            zone.dashing = true;
         }
      }
      else
      {
         loc3 = zone.speed_x;
      }
      if(zone.horse)
      {
         if(zone.dashing)
         {
            loc3 = zone.horse.speed_x;
         }
         else
         {
            loc3 = zone.horse.speed_x;
         }
      }
      else if(level == 23 or level == 102)
      {
         if(zone.pet.animal_type == 21)
         {
            loc3 = zone.speed_x;
         }
         else
         {
            loc3 *= 0.6;
         }
      }
      if(zone.body_y >= 0)
      {
         if(level == 32 or zone.n_groundtype >= 300 and zone.n_groundtype <= 302)
         {
            if(zone.pet.animal_type != 21)
            {
               if(level == 32)
               {
                  loc3 *= 0.4;
               }
               else
               {
                  loc3 *= 0.5;
               }
            }
         }
      }
      if(loc5)
      {
         if(!zone.speed_x_slide)
         {
            zone.speed_x_slide = - loc5;
         }
         else
         {
            zone.speed_x_slide -= loc5;
            if(zone.speed_x_slide < - loc3)
            {
               zone.speed_x_slide = - loc3;
            }
         }
      }
      else
      {
         f_MoveCharH(zone,- loc3,0);
      }
      if(ladders_total > 0)
      {
         if(!Key.isDown(zone.button_up) and !Key.isDown(zone.button_walk_up))
         {
            if(!zone.beefy and !zone.horse and zone.body_y >= 0)
            {
               var loc4 = 1;
               while(loc4 <= ladders_total)
               {
                  u_temp = ladders["s" + int(loc4)];
                  if(u_temp.side)
                  {
                     if(Math.abs(u_temp.x - zone._x) <= u_temp.w)
                     {
                        if(zone.y < u_temp.y and zone.y > u_temp.y - (u_temp.h + 15))
                        {
                           zone.walking = false;
                           zone.dashing = false;
                           zone.blocking = false;
                           zone.ladder = u_temp;
                           zone.body_y = - (u_temp.h * 2 - 50);
                           zone.body._y = zone.body_y;
                           _root.f_SetXY(zone,u_temp.x,u_temp.y + u_temp.h);
                           if(zone._xscale > 0 and u_temp.scale < 0 or zone._xscale < 0 and u_temp.scale > 0)
                           {
                              zone._xscale *= -1;
                           }
                           zone.gotoAndStop("ladderclimb_sidedown");
                           return undefined;
                        }
                     }
                  }
                  loc4 = loc4 + 1;
               }
            }
         }
      }
      zone.walking = true;
   }
   else if(loc5)
   {
      if(zone.speed_x_slide < 0)
      {
         zone.speed_x_slide += loc5;
         if(zone.speed_x_slide > 0)
         {
            zone.speed_x_slide = 0;
         }
      }
   }
   if(zone.right_timer > 0 and zone.right_timer > zone.left_timer)
   {
      if(zone._xscale < 0)
      {
         if(zone.blocking)
         {
            zone.reverse = true;
         }
         else
         {
            zone.reverse = false;
            f_FlipChar(zone);
         }
      }
      else
      {
         zone.reverse = false;
      }
      if(zone.blocking)
      {
         loc3 = zone.speed_x / 2;
      }
      else if(zone.right_last < g_dash_timer and zone.right_last2 < g_dash_timer and zone.fp_DashAnim)
      {
         if(zone.jumping and !zone.dashjump)
         {
            loc3 = zone.speed_x;
         }
         else
         {
            if(zone.truespeed)
            {
               loc3 = zone.speed_x * 2.2;
            }
            else
            {
               loc3 = zone.speed_x * 1.8;
            }
            zone.dashing = true;
         }
      }
      else
      {
         loc3 = zone.speed_x;
      }
      if(zone.horse)
      {
         if(zone.dashing)
         {
            loc3 = zone.horse.speed_x;
         }
         else
         {
            loc3 = zone.horse.speed_x;
         }
      }
      else if(level == 23 or level == 102)
      {
         if(zone.pet.animal_type == 21)
         {
            loc3 = zone.speed_x;
         }
         else
         {
            loc3 *= 0.6;
         }
      }
      if(zone.body_y >= 0)
      {
         if(level == 32 or zone.n_groundtype >= 300 and zone.n_groundtype <= 302)
         {
            if(zone.pet.animal_type != 21)
            {
               if(level == 32)
               {
                  loc3 *= 0.4;
               }
               else
               {
                  loc3 *= 0.5;
               }
            }
         }
      }
      if(loc5)
      {
         if(!zone.speed_x_slide)
         {
            zone.speed_x_slide = loc5;
         }
         else
         {
            zone.speed_x_slide += loc5;
            if(zone.speed_x_slide > loc3)
            {
               zone.speed_x_slide = loc3;
            }
         }
      }
      else
      {
         f_MoveCharH(zone,loc3,0);
      }
      if(ladders_total > 0)
      {
         if(!Key.isDown(zone.button_down) and !Key.isDown(zone.button_walk_down))
         {
            if(!zone.beefy and !zone.horse)
            {
               loc4 = 1;
               while(loc4 <= ladders_total)
               {
                  u_temp = ladders["s" + int(loc4)];
                  if(u_temp.side)
                  {
                     if(Math.abs(u_temp.x - zone._x) <= u_temp.w)
                     {
                        if(zone.y > u_temp.y and zone.y < u_temp.y + (u_temp.h + 15))
                        {
                           zone.walking = false;
                           zone.dashing = false;
                           zone.blocking = false;
                           zone.ladder = u_temp;
                           _root.f_SetXY(zone,u_temp.x,zone.y);
                           if(zone._xscale > 0 and u_temp.scale < 0 or zone._xscale < 0 and u_temp.scale > 0)
                           {
                              zone._xscale *= -1;
                           }
                           zone.gotoAndStop("ladderclimb_sideup");
                           return undefined;
                        }
                     }
                  }
                  loc4 = loc4 + 1;
               }
            }
         }
      }
      zone.walking = true;
   }
   else if(loc5)
   {
      if(zone.speed_x_slide > 0)
      {
         zone.speed_x_slide -= loc5;
         if(zone.speed_x_slide < 0)
         {
            zone.speed_x_slide = 0;
         }
      }
   }
   if(loc5)
   {
      if(zone.speed_x_slide != 0)
      {
         f_MoveCharH(zone,zone.speed_x_slide,0);
      }
   }
   if(!zone.busy)
   {
      if(zone.up_timer > 0 and zone.up_timer > zone.down_timer)
      {
         if(zone.blocking)
         {
            loc3 = zone.speed_y / 2;
         }
         else if(zone.up_last < g_dash_timer and zone.up_last2 < g_dash_timer and zone.fp_DashAnim)
         {
            if(zone.jumping and !zone.dashjump)
            {
               loc3 = zone.speed_y;
            }
            else
            {
               if(zone.truespeed)
               {
                  loc3 = zone.speed_y * 2.2;
               }
               else
               {
                  loc3 = zone.speed_y * 1.8;
               }
               zone.dashing = true;
            }
         }
         else
         {
            loc3 = zone.speed_y;
         }
         if((level == 23 or level == 102) and !zone.horse)
         {
            if(zone.pet.animal_type == 21)
            {
               loc3 = zone.speed_y;
            }
            else
            {
               loc3 *= 0.6;
            }
         }
         if(zone.body_y >= 0)
         {
            if(level == 32 or zone.n_groundtype >= 300 and zone.n_groundtype <= 302)
            {
               if(zone.pet.animal_type != 21)
               {
                  if(level == 32)
                  {
                     loc3 *= 0.4;
                  }
                  else
                  {
                     loc3 *= 0.5;
                  }
               }
            }
         }
         if(loc5)
         {
            if(!zone.speed_y_slide)
            {
               zone.speed_y_slide = - loc5;
            }
            else
            {
               zone.speed_y_slide -= loc5;
               if(zone.speed_y_slide < - loc3)
               {
                  zone.speed_y_slide = - loc3;
               }
            }
         }
         else
         {
            f_MoveCharV(zone,- loc3,0);
         }
         zone.walking = true;
         if(ladders_total > 0)
         {
            if(!zone.beefy and !zone.horse)
            {
               loc4 = 1;
               while(loc4 <= ladders_total)
               {
                  u_temp = ladders["s" + int(loc4)];
                  if(Math.abs(u_temp.x - zone._x) <= u_temp.w)
                  {
                     if(zone.y > u_temp.y and zone.y < u_temp.y + u_temp.h)
                     {
                        if(u_temp.side)
                        {
                           if(!Key.isDown(zone.button_left) and !Key.isDown(zone.button_walk_left))
                           {
                              _root.f_SetXY(zone,u_temp.x,zone.y);
                              if(zone._xscale > 0 and u_temp.scale < 0 or zone._xscale < 0 and u_temp.scale > 0)
                              {
                                 zone._xscale *= -1;
                              }
                              zone.walking = false;
                              zone.dashing = false;
                              zone.blocking = false;
                              zone.ladder = u_temp;
                              zone.gotoAndStop("ladderclimb_sideup");
                           }
                        }
                        else
                        {
                           zone.walking = false;
                           zone.dashing = false;
                           zone.blocking = false;
                           zone.ladder = u_temp;
                           zone.gotoAndStop("ladderclimb");
                        }
                        return undefined;
                     }
                  }
                  loc4 = loc4 + 1;
               }
            }
         }
      }
      else if(loc5)
      {
         if(zone.speed_y_slide < 0)
         {
            zone.speed_y_slide += loc5;
            if(zone.speed_y_slide > 0)
            {
               zone.speed_y_slide = 0;
            }
         }
      }
      if(zone.down_timer > 0 and zone.down_timer > zone.up_timer)
      {
         if(zone.blocking)
         {
            loc3 = zone.speed_y / 2;
         }
         else if(zone.down_last < g_dash_timer and zone.down_last2 < g_dash_timer and zone.fp_DashAnim)
         {
            if(zone.jumping and !zone.dashjump)
            {
               loc3 = zone.speed_y;
            }
            else
            {
               if(zone.truespeed)
               {
                  loc3 = zone.speed_y * 2.2;
               }
               else
               {
                  loc3 = zone.speed_y * 1.8;
               }
               zone.dashing = true;
            }
         }
         else
         {
            loc3 = zone.speed_y;
         }
         if((level == 23 or level == 102) and !zone.horse)
         {
            if(zone.pet.animal_type == 21)
            {
               loc3 = zone.speed_y;
            }
            else
            {
               loc3 *= 0.6;
            }
         }
         if(zone.body_y >= 0)
         {
            if(level == 32 or zone.n_groundtype >= 300 and zone.n_groundtype <= 302)
            {
               if(zone.pet.animal_type != 21)
               {
                  if(level == 32)
                  {
                     loc3 *= 0.4;
                  }
                  else
                  {
                     loc3 *= 0.5;
                  }
               }
            }
         }
         if(loc5)
         {
            if(!zone.speed_y_slide)
            {
               zone.speed_y_slide = loc5;
            }
            else
            {
               zone.speed_y_slide += loc5;
               if(zone.speed_y_slide > loc3)
               {
                  zone.speed_y_slide = loc3;
               }
            }
         }
         else
         {
            f_MoveCharV(zone,loc3,0);
         }
         zone.walking = true;
         if(ladders_total > 0)
         {
            if(!zone.beefy and !zone.horse)
            {
               if(zone.body_y >= 0)
               {
                  loc4 = 1;
                  while(loc4 <= ladders_total)
                  {
                     u_temp = ladders["s" + int(loc4)];
                     if(Math.abs(u_temp.x - zone._x) <= u_temp.w)
                     {
                        if(zone.y < u_temp.y and zone.y > u_temp.y - u_temp.h)
                        {
                           if(u_temp.side)
                           {
                              if(!Key.isDown(zone.button_right) and !Key.isDown(zone.button_walk_right))
                              {
                                 zone.walking = false;
                                 zone.dashing = false;
                                 zone.blocking = false;
                                 zone.ladder = u_temp;
                                 zone.body_y = - (u_temp.h * 2 - 50);
                                 zone.body._y = zone.body_y;
                                 _root.f_SetXY(zone,u_temp.x,u_temp.y + u_temp.h);
                                 if(zone._xscale > 0 and u_temp.scale < 0 or zone._xscale < 0 and u_temp.scale > 0)
                                 {
                                    zone._xscale *= -1;
                                 }
                                 zone.gotoAndStop("ladderclimb_sidedown");
                              }
                           }
                           else
                           {
                              zone.walking = false;
                              zone.dashing = false;
                              zone.blocking = false;
                              zone.ladder = u_temp;
                              zone.body_y = - (u_temp.h * 2 - 50);
                              zone.body._y = zone.body_y;
                              _root.f_SetXY(zone,zone.x,u_temp.y + u_temp.h);
                              zone.gotoAndStop("ladderclimb");
                           }
                           return undefined;
                        }
                     }
                     loc4 = loc4 + 1;
                  }
               }
            }
         }
      }
      else if(loc5)
      {
         if(zone.speed_y_slide > 0)
         {
            zone.speed_y_slide -= loc5;
            if(zone.speed_y_slide < 0)
            {
               zone.speed_y_slide = 0;
            }
         }
      }
      if(loc5)
      {
         if(zone.speed_y_slide != 0)
         {
            f_MoveCharV(zone,zone.speed_y_slide,0);
         }
      }
   }
}
function f_Depth(zone, u_depth)
{
   if(zone)
   {
      if(zone.depth_mod == undefined)
      {
         if(!console_version)
         {
            trace("NO DEPTH: " + zone + " tried to move to: " + u_depth);
         }
      }
      if(loader.game.game.abs_bottom)
      {
         if(loader.game.game.abs_top)
         {
            zone.current_depth = 1000000 - (int(Math.abs(loader.game.game.abs_bottom._y - u_depth) / 2) * 1000 + zone.depth_mod);
         }
         else
         {
            zone.current_depth = 1000000 - (int(Math.abs(loader.game.game.abs_bottom._y - u_depth)) * 1000 + zone.depth_mod);
         }
      }
      else
      {
         zone.current_depth = int(10000000 - Math.abs(u_depth - 200) * 1000 + zone.depth_mod);
      }
      zone.swapDepths(int(zone.current_depth));
   }
   else
   {
      trace("NO DEPTH and zone is undefined.");
   }
}
function f_Punch(zone)
{
   if(p_game.specialmode == 1)
   {
      if(Key.isDown(zone.button_punch1))
      {
         if(!zone.punched and !zone.punching)
         {
            zone.punched = true;
            zone.punching = true;
            if(f_StompRange(zone))
            {
               zone.gotoAndStop("stomp");
            }
            else
            {
               if(zone.throwmove)
               {
                  zone.throwmove = false;
                  return undefined;
               }
               if(zone.jumping)
               {
                  zone.freeze = true;
                  f_SetFloat(zone,11);
               }
               zone.gotoAndStop("bow");
            }
         }
      }
      else
      {
         zone.punched = false;
      }
      if(Key.isDown(zone.button_punch2))
      {
         if(!zone.punched2 and !zone.punching)
         {
            zone.punched2 = true;
            zone.punching = true;
            if(f_StompRange(zone))
            {
               zone.gotoAndStop("stomp");
            }
            else
            {
               if(zone.throwmove)
               {
                  zone.throwmove = false;
                  return undefined;
               }
               if(zone.jumping)
               {
                  zone.freeze = true;
                  f_SetFloat(zone,11);
               }
               zone.gotoAndStop("bow");
            }
         }
      }
      else
      {
         zone.punched2 = false;
      }
      if(Key.isDown(zone.button_projectile))
      {
         if(!zone.pressed_projectile and !zone.punching)
         {
            zone.pressed_projectile = true;
            zone.punching = true;
            if(f_StompRange(zone))
            {
               zone.gotoAndStop("stomp");
            }
            else
            {
               if(zone.throwmove)
               {
                  zone.throwmove = false;
                  return undefined;
               }
               if(zone.jumping)
               {
                  zone.freeze = true;
                  f_SetFloat(zone,11);
               }
               zone.gotoAndStop("bow");
            }
         }
      }
      else
      {
         zone.pressed_projectile = false;
      }
   }
   else if(p_game.specialmode == 2 and !zone.beefy)
   {
      if(Key.isDown(zone.button_punch1))
      {
         if(!zone.punched and !zone.punching)
         {
            if(zone.jumping)
            {
               return undefined;
            }
            zone.punched = true;
            zone.punching = true;
            zone.gotoAndStop("dig");
         }
      }
      else
      {
         zone.punched = false;
      }
      if(Key.isDown(zone.button_punch2))
      {
         if(!zone.punched2 and !zone.punching)
         {
            if(zone.jumping)
            {
               return undefined;
            }
            zone.punched2 = true;
            zone.punching = true;
            zone.gotoAndStop("dig");
         }
      }
      else
      {
         zone.punched2 = false;
      }
      if(Key.isDown(zone.button_projectile))
      {
         if(!zone.pressed_projectile and !zone.punching)
         {
            if(zone.jumping)
            {
               return undefined;
            }
            zone.pressed_projectile = true;
            zone.punching = true;
            zone.gotoAndStop("dig");
         }
      }
      else
      {
         zone.pressed_projectile = false;
      }
   }
   else if(p_game.specialmode == 3 and !zone.beefy)
   {
      if(Key.isDown(zone.button_punch1))
      {
         if(!zone.punched and !zone.punching)
         {
            if(zone.jumping)
            {
               return undefined;
            }
            zone.punched = true;
            zone.punching = true;
            zone.gotoAndStop("reach");
         }
      }
      else
      {
         zone.punched = false;
      }
      if(Key.isDown(zone.button_punch2))
      {
         if(!zone.punched2 and !zone.punching)
         {
            if(zone.jumping)
            {
               return undefined;
            }
            zone.punched2 = true;
            zone.punching = true;
            zone.gotoAndStop("reach");
         }
      }
      else
      {
         zone.punched2 = false;
      }
      if(Key.isDown(zone.button_projectile))
      {
         if(!zone.pressed_projectile and !zone.punching)
         {
            if(zone.jumping)
            {
               return undefined;
            }
            zone.pressed_projectile = true;
            zone.punching = true;
            zone.gotoAndStop("reach");
         }
      }
      else
      {
         zone.pressed_projectile = false;
      }
   }
   else
   {
      var loc3 = zone.fp_StandAnim != f_Wait;
      if(loc3 && Key.isDown(zone.button_punch1))
      {
         if(!zone.punched and !zone.punching)
         {
            zone.punched = true;
            zone.fp_Jab(zone);
         }
      }
      else
      {
         zone.punched = false;
      }
      if(loc3 && Key.isDown(zone.button_punch2))
      {
         if(!zone.punched2 and !zone.punching)
         {
            zone.punched2 = true;
            zone.fp_Fierce(zone);
         }
      }
      else
      {
         zone.punched2 = false;
      }
      if(loc3 && Key.isDown(zone.button_projectile))
      {
         if(!zone.beefy)
         {
            zone.pressed_projectile_timer = zone.pressed_projectile_timer + 1;
            if(!zone.pressed_projectile and zone.pressed_projectile_timer <= 1 and !zone.punching and (zone.equippeditem != 9 or zone.magicmode and zone.magic_unlocks[0]))
            {
               zone.pressed_projectile = true;
               if(zone.magicmode and zone.magic_unlocks[0])
               {
                  zone.punching = true;
                  var manaCost = 25;
                  if(zone.magic_current >= manaCost)
                  {
                     f_Magic(zone,- manaCost);
                     zone.fp_MagicMove = f_MagicBullet;
                     if(zone.p_type == 32) {
                        zone.magicmode = false;
                        zone.gotoAndStop("warmachinethrow");
                     }
                     else if(zone.p_type == 33) {
                        if(zone.undead) {
                           zone.gotoAndStop("undead_coffinshotgun");
                        }
                        else {
                           zone.gotoAndStop("laserbeam");
                        }
                        f_AlignBody(zone);
                     }
                     else if(zone.body_y < 0)
                     {
                        if(zone.magic_type == 32)
                        {
                           zone.gotoAndStop("hattymagair1");
                        }
                        else
                        {
                           zone.gotoAndStop("magic_air");
                        }
                        f_PunchInit(zone);
                        zone.body.gotoAndPlay(1);
                     }
                     else if(zone.magic_type == 32)
                     {
                        zone.gotoAndStop("hatty_cast");
                     }
                     else
                     {
                        zone.gotoAndStop("magic1");
                     }
                  }
                  else
                  {
                     zone.gotoAndStop("magic0");
                  }
               }
               else
               {
                  if(zone.p_type > 31 && (int(zone.equippeditem) < 8 || int(zone.equippeditem) > 9)) { // Boss taunt
                     zone.gotoAndStop("taunt1");
                     f_AlignBody(zone);
                     return;
                  }
                  else {
                     switch(int(zone.equippeditem))
                     {
                        case 1:
                           if(zone.hud_pt.item_unlocks[1] or GetGameMode() == 3)
                           {
                              zone.punching = true;
                              if(zone.jumping)
                              {
                                 zone.freeze = true;
                                 f_SetFloat(zone,11);
                              }
                              zone.gotoAndStop("bow");
                           }
                           break;
                        case 2:
                           if(zone.body_y >= -1)
                           {
                              zone.punching = true;
                              zone.gotoAndStop("dig");
                           }
                           break;
                        case 3:
                           if(!zone.boomeranged)
                           {
                              zone.punching = true;
                              if(zone.jumping)
                              {
                                 zone.freeze = true;
                                 f_SetFloat(zone,11);
                              }
                              zone.gotoAndStop("boomerang");
                           }
                           break;
                        case 6:
                           if(zone.body_y == 0)
                           {
                              zone.punching = true;
                              zone.gotoAndStop("horn");
                           }
                           break;
                        case 8:
                           if(zone.bombs > 0)
                           {
                              zone.bombs = zone.bombs - 1;
                              if(zone.punch_pow_high > zone.magic_pow)
                              {
                                 var loc4 = zone.punch_pow_high * 2;
                              }
                              else
                              {
                                 loc4 = zone.magic_pow * 2;
                              }
                              loc2 = f_Shoot(zone,"general_projectile",loc4,20,0,0);
                              loc2.projectile_type = 74;
                              loc2.body_y = zone.body_y + zone.body_table_y - 50;
                              loc2.body._y = loc2.body_y;
                              loc2.speed_x = 0;
                              loc2.bounces = 0;
                              loc2.bounces_max = 1;
                              loc2.speed_y = -20;
                              loc2.gravity = 3;
                              LOGPush(11,8,zone.hud_pt.port);
                           }
                           zone.overlay.gotoAndStop("itemselect");
                           zone.overlay.itemselect.gotoAndPlay(2);
                           zone.overlay.itemselect.icon2.gotoAndPlay(1);
                           zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
                           if(console_version)
                           {
                              SetTextNumeric(zone.overlay.itemselect.icon.bombs,zone.bombs);
                           }
                           else
                           {
                              zone.overlay.itemselect.icon.bombs.text = zone.bombs;
                           }
                           if(!zone.bombs)
                           {
                              zone.equippeditem = 0;
                              zone.hud_pt.stats.item.gotoAndStop(1);
                           }
                           zone.punching = false;
                           break;
                        case 9:
                           if(zone.healthpots > 0 and zone.health < zone.health_max)
                           {
                              if(zone.health > 0)
                              {
                                 zone.healthpots = zone.healthpots - 1;
                                 f_Heal(zone,zone.health_max - zone.health);
                                 LOGPush(11,9,zone.hud_pt.port);
                              }
                           }
                           zone.overlay.gotoAndStop("itemselect");
                           zone.overlay.itemselect.gotoAndPlay(2);
                           zone.overlay.itemselect.icon2.gotoAndPlay(1);
                           zone.overlay.itemselect.icon.gotoAndStop(zone.equippeditem);
                           if(console_version)
                           {
                              SetTextNumeric(zone.overlay.itemselect.icon.healthpots,zone.healthpots);
                           }
                           else
                           {
                              zone.overlay.itemselect.icon.healthpots.text = zone.healthpots;
                           }
                           if(!zone.healthpots)
                           {
                              zone.equippeditem = 0;
                              zone.hud_pt.stats.item.gotoAndStop(1);
                           }
                           zone.punching = false;
                           break;
                        case 11:
                           if(zone.beefies > 0 and !zone.beefy)
                           {
                              zone.beefies = zone.beefies - 1;
                              zone.beefy_timer = 301;
                              f_GoBeefy(zone);
                              LOGPush(11,11,zone.hud_pt.port);
                           }
                           zone.overlay.gotoAndStop(1);
                           if(!zone.beefies)
                           {
                              zone.equippeditem = 0;
                              zone.hud_pt.stats.item.gotoAndStop(1);
                           }
                           zone.punching = false;
                     }
                  }
               }
            }
         }
      }
      else
      {
         zone.pressed_projectile_timer = 0;
         zone.pressed_projectile = false;
      }
   }
}
function f_Shrapnel(zone)
{
   zone.x += zone.speed_x;
   zone._x = zone.x;
   if(!zone.nospin)
   {
      if(zone._xscale > 0)
      {
         zone.body._rotation += zone.speed_x * 4;
      }
      else
      {
         zone.body._rotation += zone.speed_x * -4;
      }
   }
   zone.body._y += zone.speed_y;
   zone.speed_y += zone.gravity;
   zone._y = zone.y;
   if(zone.body._y + zone.h > 0)
   {
      zone.body._y = - zone.h;
      zone.hit_function(zone);
   }
}
function f_GetPlayerClip(zone)
{
   var loc1 = zone._parent;
   var loc2 = 0;
   while(loc2 < 7)
   {
      if(loc1._parent.container)
      {
         return loc1;
      }
      loc1 = loc1._parent;
      loc2 = loc2 + 1;
   }
   return undefined;
}
function f_Helmet(zone)
{
   var loc1 = f_GetPlayerClip(zone);
   if(loc1)
   {
      zone.gotoAndStop(loc1.helmet);
   }
}
function f_Weapon(zone)
{
   var loc1 = f_GetPlayerClip(zone);
   if(loc1)
   {
      zone.gotoAndStop(loc1.weapon);
   }
}
function f_Shield(zone)
{
   var loc1 = f_GetPlayerClip(zone);
   zone.gotoAndStop(loc1.shield);
}
function f_Emblem(zone)
{
   var loc1 = f_GetPlayerClip(zone);
   zone.gotoAndStop(loc1.emblem);
}
function f_Belt(zone)
{
   var loc1 = f_GetPlayerClip(zone);
   zone.gotoAndStop(loc1.emblem);
}
function f_Flag(zone)
{
   var loc1 = f_GetPlayerClip(zone);
   zone.gotoAndStop(loc1.flag);
}
function f_Wings(zone)
{
   var loc1 = f_GetPlayerClip(zone);
   zone.gotoAndStop(loc1.wings);
}
function f_GetButtonArt(zone, u_temp)
{
   switch(u_temp)
   {
      case 1:
         zone.gotoAndStop(1);
         break;
      case 2:
         zone.gotoAndStop(2);
         break;
      case 3:
         zone.gotoAndStop(3);
         break;
      case 4:
         zone.gotoAndStop(4);
         break;
      default:
         zone.gotoAndStop(5);
   }
}
function f_InitFlyingMonster(zone)
{
   zone.monster_h = 130;
   zone.monster_body_h = 70;
   zone.monster_speed_x_max = 10;
   zone.monster_speed_y_max = 6;
   zone.monster_speed_x = 0;
   zone.monster_speed_y = 0;
}
function f_FlyingMonster(zone)
{
   if(Key.isDown(zone.button_up))
   {
      zone.monster_speed_y -= 2;
      if(zone.monster_speed_y < - zone.monster_speed_y_max)
      {
         zone.monster_speed_y = - zone.monster_speed_y_max;
      }
   }
   else if(!Key.isDown(zone.button_down))
   {
      if(zone.monster_speed_y < 0)
      {
         zone.monster_speed_y += 2;
         if(zone.monster_speed_y > 0)
         {
            zone.monster_speed_y = 0;
         }
      }
   }
   if(Key.isDown(zone.button_down))
   {
      zone.monster_speed_y += 2;
      if(zone.monster_speed_y > zone.monster_speed_y_max)
      {
         zone.monster_speed_y = zone.monster_speed_y_max;
      }
   }
   else if(!Key.isDown(zone.button_up))
   {
      if(zone.monster_speed_y > 0)
      {
         zone.monster_speed_y -= 2;
         if(zone.monster_speed_y < 0)
         {
            zone.monster_speed_y = 0;
         }
      }
   }
   if(Key.isDown(zone.button_left))
   {
      zone.monster_speed_x -= 2;
      if(zone.monster_speed_x < - zone.monster_speed_x_max)
      {
         zone.monster_speed_x = - zone.monster_speed_x_max;
      }
   }
   else if(!Key.isDown(zone.button_right))
   {
      if(zone.monster_speed_x < 0)
      {
         zone.monster_speed_x += 2;
         if(zone.monster_speed_x > 0)
         {
            zone.monster_speed_x = 0;
         }
      }
   }
   if(Key.isDown(zone.button_right))
   {
      zone.monster_speed_x += 2;
      if(zone.monster_speed_x > zone.monster_speed_x_max)
      {
         zone.monster_speed_x = zone.monster_speed_x_max;
      }
   }
   else if(!Key.isDown(zone.button_left))
   {
      if(zone.monster_speed_x > 0)
      {
         zone.monster_speed_x -= 2;
         if(zone.monster_speed_x < 0)
         {
            zone.monster_speed_x = 0;
         }
      }
   }
   if(!v_fly_lock)
   {
      if(zone.monster_speed_y < 0)
      {
         if(zone.body_y + zone.y + zone.monster_speed_y - zone.monster_body_h > main.top)
         {
            zone.body_y += zone.monster_speed_y;
            zone.body._y = zone.body_y;
         }
      }
      else
      {
         if(zone.body_y + zone.y + zone.monster_speed_y < main.bottom)
         {
            zone.body_y += zone.monster_speed_y;
            zone.body._y = zone.body_y;
         }
         if(zone.body_y > 0)
         {
            zone.body_y = 0;
            zone.body._y = 0;
         }
      }
   }
   if(zone.monster_speed_x < 0)
   {
      if(zone.x + zone.monster_speed_x > main.left)
      {
         zone.x += zone.monster_speed_x;
         zone._x = zone.x;
      }
   }
   else if(zone.x + zone.monster_speed_x < main.right)
   {
      zone.x += zone.monster_speed_x;
      zone._x = zone.x;
   }
   zone.shadow_pt._x = zone.x;
   if(zone.body_y < -70)
   {
      var loc3 = 30;
   }
   else
   {
      loc3 = 100 + zone.body_y;
   }
   zone.shadow_pt._xscale = loc3;
   zone.shadow_pt._yscale = loc3;
   if(Key.isDown(zone.button_punch1))
   {
      if(!zone.punched)
      {
         zone.punched = true;
         s_ShootFire.start(0,0);
         var loc2 = f_Shoot(zone,"shooter_fireball",zone.magic_pow,20,0,0);
         loc2.damage_type = DMG_FIRE;
         loc2.body._y -= 30;
         loc2.body_y = loc2.body._y;
         loc2.x += 30;
         loc2._x = loc2.x;
      }
   }
   else
   {
      zone.punched = false;
   }
}
function f_BottomPlayerY()
{
   var loc3 = undefined;
   var loc2 = 1;
   while(loc2 <= active_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc2)];
      if(loc1.alive)
      {
         if(loc3 == undefined)
         {
            loc3 = loc1.y;
         }
         else if(loc1.y > loc3)
         {
            loc3 = loc1.y;
         }
      }
      loc2 = loc2 + 1;
   }
   return loc3;
}
function f_BottomPlayerBodyY()
{
   var loc3 = undefined;
   var loc2 = 1;
   while(loc2 <= active_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc2)];
      if(loc1.alive)
      {
         if(loc3 == undefined)
         {
            loc3 = loc1.body_y;
         }
         else if(loc1.body_y > loc3)
         {
            loc3 = loc1.body_y;
         }
      }
      loc2 = loc2 + 1;
   }
   return loc3;
}
function f_MidPlayerX()
{
   u_left = undefined;
   var loc2 = 1;
   while(loc2 <= active_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc2)];
      if(loc1.alive)
      {
         if(u_left == undefined)
         {
            u_left = loc1.x;
            u_right = loc1.x;
         }
         else if(loc1.x > u_right)
         {
            u_right = loc1.x;
         }
         else if(loc1.x < u_left)
         {
            u_left = loc1.x;
         }
      }
      loc2 = loc2 + 1;
   }
   return u_left + (u_right - u_left) / 2;
}
function f_ShooterProjectileMove(zone)
{
   zone.x += zone.speed_x;
   zone._x = zone.x;
   zone.shadow_pt._x = zone.x;
   zone.body._y += zone.speed_y;
   zone.body_y = zone.body._y;
   f_ShadowSize(zone);
}
function f_ShooterProjectile(zone)
{
   zone.trail_function(zone);
   f_ShooterProjectileMove(zone);
   if(zone.x > main.right + 100 and zone.speed_x > 0)
   {
      f_RemoveShadow(zone);
      zone.shadow_pt = undefined;
      zone.gotoAndStop("remove");
   }
   else if(zone.x < main.left - 100 and zone.speed_x < 0)
   {
      f_RemoveShadow(zone);
      zone.shadow_pt = undefined;
      zone.gotoAndStop("remove");
   }
   else if(f_ProjectileHit(zone))
   {
      zone.hit_function(zone);
   }
}
function f_JumpKickInit(zone)
{
   zone.speed_jump = -18;
   zone.force_x = 20;
   zone.force_y = -10;
   zone.attack_type = _root.DMG_MELEE;
   zone.invincible_recover = 10;
   zone.punch_group = 300;
   zone.punch_num = 1;
   zone.walking = false;
   zone.gotoAndStop("jumpkick");
}
function f_JumpKick(zone)
{
   zone.body_y += zone.speed_jump;
   zone.body._y = zone.body_y;
   if(zone._xscale > 0)
   {
      f_MoveCharH(zone,14,0);
   }
   else
   {
      f_MoveCharH(zone,-14,0);
   }
   if(zone.speed_jump == 4)
   {
      s_MagicNinja.start(0,0);
      zone.body.gotoAndPlay("kick");
   }
   zone.speed_jump += 2;
   if(zone.body_y > 0)
   {
      zone.body_y = 0;
      zone.gotoAndStop("land");
   }
}
function f_NinjaWarp(zone)
{
   s_AreaNinja.start(0,0);
   var loc2 = _root.f_FX(zone.x,zone.y,int(zone.y),"area_ninjasmoke",100,100);
   loc2.owner = zone;
   loc2.attack_pow = 0;
   loc2.fp_PunchHit = undefined;
   loc2.magic_chain = 1;
   loc2.current_chain = 1;
   loc2 = _root.f_FX(zone.x,zone.y,int(zone.y - 1),"ninjerlog",100,100);
   loc2.body_y = -40;
   loc2.body._y = loc2.body_y;
   loc2.speed_x = 0;
   loc2.speed_y = -5;
   loc2.gravity = 2;
   loc2.bounces = 0;
   loc2.bounces_max = 1;
   loc2.hit_function = f_ShrapnelPermaBounce;
   zone.nohit = true;
   zone.shadow_pt.gotoAndStop("off");
   zone.gotoAndStop("jumpkickwarp");
}
function f_CreateScorpions(u_num)
{
   _root.total_scorpions = u_num;
   var loc3 = 1;
   while(loc3 <= _root.total_scorpions)
   {
      var loc4 = _root.f_GetDepthModAssignment();
      var loc2 = p_game.attachMovie("invisObject","e_scorpion" + int(loc3),loc4);
      loadMovie("../escorp/escorp.swf",loc2);
      loc2.depth_mod = loc4;
      loc2.active = false;
      loc3 = loc3 + 1;
   }
}
function f_ScorpionsInit()
{
   _root.loader.scorpions = true;
   var loc2 = 1;
   while(loc2 <= _root.total_scorpions)
   {
      var loc3 = p_game["e_scorpion" + loc2];
      if(!loc3.alive)
      {
         _root.f_ScorpionReset(loc3);
      }
      loc2 = loc2 + 1;
   }
   return false;
}
function f_ScorpionReset(zone)
{
   if(_root.loader.scorpions)
   {
      var loc3 = p_game.scorp_top._y + random(p_game.scorp_bottom._y - p_game.scorp_top._y);
      if(!zone.shadow_pt)
      {
         zone.shadow_pt = f_NewShadow();
      }
      zone.shadow_pt.gotoAndStop("on");
      HiFps_Reset(zone.shadow_pt);
      if(random(2) == 1)
      {
         if(zone._xscale > 0)
         {
            zone._xscale *= -1;
         }
         f_SetXY(zone,main.right + 100,loc3);
      }
      else
      {
         if(zone._xscale < 0)
         {
            zone._xscale *= -1;
         }
         f_SetXY(zone,main.left - 100,loc3);
      }
      if(zone.hitby)
      {
         zone.hitby.kills = zone.hitby.kills + 1;
         zone.hitby = undefined;
      }
      zone.weight = 1.5 + 1 / random(10);
      if(!zone.active)
      {
         zone.fp_PunchHit = f_EnemyAttack;
         zone.punch_pow_low = 4;
         zone.punch_pow_medium = 6;
         zone.punch_pow_high = 8;
         zone.punch_pow_max = 10;
         if(_root.insane_mode)
         {
            zone.punch_pow_low *= 10;
            zone.punch_pow_medium *= 10;
            zone.punch_pow_high *= 10;
            zone.punch_pow_max *= 10;
         }
         zone.force_x = 22;
         zone.force_y = -5;
         zone.scorpion = true;
         zone.n_groundtype = 0;
         zone.attack_type = DMG_MELEE;
         zone.resists = new Array(5);
         zone.resists[_root.DMG_MELEE] = 50;
         zone.resists[_root.DMG_FIRE] = 50;
         zone.resists[_root.DMG_ELEC] = 50;
         zone.resists[_root.DMG_POISON] = 50;
         zone.resists[_root.DMG_ICE] = 50;
         zone.punch_group = 300;
         zone.punch_num = 1;
         zone.haswall = false;
         zone.h = 50;
         zone.w = 60;
         f_UnresponsiveDefaults(zone);
         f_LargeObjectRanges(zone);
         zone.fp_CheckYSpace = f_HumanoidCheckYSpace;
         zone.fp_Hit1 = f_HitScorpion;
         zone.fp_Hit2 = f_HitScorpion;
         zone.fp_Hit3 = f_HitScorpion;
         zone.fp_Juggle = f_HitScorpion;
         zone.alive = true;
         zone.active = true;
         if(zone.e_pt)
         {
            _root.loader.game.game["e" + int(zone.e_pt)] = undefined;
         }
         zone.e_pt = undefined;
         f_InsertEnemy(zone);
      }
      zone.body_y = 0;
      zone.onground = false;
      zone.nohit = false;
      zone.shadow_pt.gotoAndStop("on");
      zone.alive = true;
      zone.health_max = 1;
      zone.health = zone.health_max;
      f_SetActiveEnemies();
      zone.speed = 3 + random(3);
      zone.gotoAndStop("walk");
      HiFps_ResetRecursive(zone);
   }
   else
   {
      zone.alive = false;
      f_SetActiveEnemies();
      zone.shadow_pt.gotoAndStop("off");
      zone.gotoAndStop("blank");
   }
}
function f_ScorpionWalk(zone)
{
   if(zone.invincible_timer > 0)
   {
      zone.invincible_timer = zone.invincible_timer - 1;
   }
   if(zone.health <= 0)
   {
      f_HitScorpion(zone);
   }
   else
   {
      if(zone._xscale > 0)
      {
         f_SetXY(zone,zone.x + zone.speed,zone.y);
         if(zone.x > main.right + 100 + random(200))
         {
            f_ScorpionReset(zone);
            return undefined;
         }
         if(zone.x < main.left - 600)
         {
            f_ScorpionReset(zone);
            return undefined;
         }
      }
      else
      {
         f_SetXY(zone,zone.x - zone.speed,zone.y);
         if(zone.x < main.left - 100 - random(200))
         {
            zone.alive = false;
            f_ScorpionReset(zone);
            return undefined;
         }
         if(zone.x > main.right + 600)
         {
            zone.alive = false;
            f_ScorpionReset(zone);
            return undefined;
         }
      }
      f_LargeObjectRanges(zone);
      if(f_OnScreen(zone))
      {
         if(!cinema)
         {
            var loc3 = 1;
            while(loc3 <= active_players)
            {
               var loc2 = playerArrayOb["p_pt" + int(loc3)];
               if(!loc2.nohit and loc2.alive)
               {
                  if(Math.abs(loc2.y - zone.y) < 15)
                  {
                     if(zone.x > loc2.x)
                     {
                        if(zone._xscale < 0)
                        {
                           if(zone.x < loc2.x + 100)
                           {
                              zone.gotoAndStop("attack");
                              return undefined;
                           }
                        }
                     }
                     else if(zone._xscale > 0)
                     {
                        if(zone.x > loc2.x - 100)
                        {
                           zone.gotoAndStop("attack");
                           return undefined;
                        }
                     }
                  }
               }
               loc3 = loc3 + 1;
            }
         }
      }
   }
}
function f_ScorpionToss(zone)
{
   zone.owner = zone.hitby;
   _root.f_MoveCharH(zone,zone.speed_toss_x,0);
   if(zone._xscale > 0)
   {
      zone.body.body._rotation += zone.speed_toss_x * 2;
   }
   else
   {
      zone.body.body._rotation -= zone.speed_toss_x * 2;
   }
   zone.body_y += zone.speed_toss_y;
   zone.speed_toss_y += zone.weight;
   if(zone.body_y > 0)
   {
      zone.body_y = 0;
   }
   zone.body._y = zone.body_y;
   if(zone.body_y >= 0)
   {
      if(zone.health > 0)
      {
         zone.gotoAndStop("walk");
      }
      else
      {
         zone.alive = false;
         _root.f_FX(zone.x,zone.y + 1,int(zone.y) + 1,_root.level_dust,zone._xscale,100);
         zone.gotoAndStop("die");
      }
   }
}
function f_HitScorpion(zone)
{
   if(zone.hitdown)
   {
      zone.hitdown = false;
      zone.speed_toss_y = 0;
   }
   else
   {
      zone.speed_toss_y = - (15 + random(10));
   }
   zone.speed_toss_x = 6 + random(5);
   if(zone.hitby.x > zone.x)
   {
      f_MakeShrapnel(13,zone.x,zone.y,zone.body_y,-100);
      zone.speed_toss_x *= -1;
   }
   else
   {
      f_MakeShrapnel(13,zone.x,zone.y,zone.body_y,100);
   }
   zone.gotoAndStop("toss");
}
function f_ShootArrowArched(zone)
{
   zone.gotoAndStop("bowup");
}
function f_CheckBombSpots(zone)
{
   var loc1 = 1;
   while(loc1 <= bombspots_total)
   {
      u_temp = bombspots["s" + int(loc1)];
      if(Math.abs(zone.y - u_temp.bomb_pt_y) < 25)
      {
         if(zone.x > u_temp.bomb_pt_x - u_temp.bomb_pt_w)
         {
            if(zone.x < u_temp.bomb_pt_x + u_temp.bomb_pt_w)
            {
               u_temp.nextFrame();
            }
         }
      }
      loc1 = loc1 + 1;
   }
}
function f_PlayerBombExplosion(zone)
{
   if(friendly_fire)
   {
      var loc3 = 1;
      while(loc3 <= players)
      {
         var loc1 = loader.game.game["p" + int(loc3)];
         if(loc1.alive and loc1 != zone.owner)
         {
            if(f_TeamCheck(zone,loc1))
            {
               f_ExplosionCheckHit(zone,loc1);
            }
         }
         loc3 = loc3 + 1;
      }
   }
   loc3 = 1;
   while(loc3 <= active_enemies)
   {
      loc1 = enemyArrayOb["e" + int(loc3)];
      if(loc1.alive)
      {
         f_ExplosionCheckHit(zone,loc1);
      }
      loc3 = loc3 + 1;
   }
   loc3 = 1;
   while(loc3 <= bombspots_total)
   {
      loc1 = bombspots["s" + int(loc3)];
      if(Math.abs(zone.y - loc1.bomb_pt_y) < 20)
      {
         if(zone.x > loc1.bomb_pt_x - loc1.bomb_pt_w)
         {
            if(zone.x < loc1.bomb_pt_x + loc1.bomb_pt_w)
            {
               loc1.nextFrame();
            }
         }
      }
      loc3 = loc3 + 1;
   }
   if(random(2) == 1)
   {
      s_Explosion3.start(0,0);
   }
   else
   {
      s_Explosion4.start(0,0);
   }
   f_FX(zone.x,zone.y + zone.body._y,zone.y + 5,"playerbombexplode",100,100);
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}
function f_ChestOpen(zone)
{
   if(!zone.item_type)
   {
      f_RandomGoldSpawn(zone.x,zone.y);
   }
   else
   {
      u_temp = f_ItemSpawn(zone.x,zone.y,zone.item_type);
      if(zone.weapon_type)
      {
         u_temp.weapon_type = zone.weapon_type;
      }
   }
}
function f_SlideGoldToHud(zone)
{
   zone.t += 0.033;
   if(zone.t >= 1)
   {
      zone.targ_hud = undefined;
      zone.gotoAndStop("remove");
      zone.pos = undefined;
      return undefined;
   }
   var loc3 = zone.pos;
   if(zone.t < 0.5)
   {
      u_temp2 = zone.t * zone.t * zone.t * 4;
   }
   else
   {
      u_temp2 = 1 - (1 - zone.t) * (1 - zone.t) * (1 - zone.t) * 4;
   }
   zone._xscale = zone._yscale = (1 - zone.t) * 90 + 10;
   if(zone.targ_hud)
   {
      var loc2 = new Object();
      loc2.x = loc3.x + (zone.targ_hud.stats.goldstats._x - 20 - loc3.x) * u_temp2;
      loc2.y = loc3.y + (zone.targ_hud.stats.goldstats._y - loc3.y) * u_temp2;
      zone.targ_hud.stats.localToGlobal(loc2);
      zone._parent.globalToLocal(loc2);
      zone._x = loc2.x;
      zone._y = loc2.y;
      loc2 = undefined;
   }
}
function f_AnyButtonPressed(zone)
{
   var loc2 = false;
   if(Key.isDown(zone.button_punch1))
   {
      if(zone.punched == false)
      {
         zone.punched = true;
         loc2 = true;
      }
   }
   else
   {
      zone.punched = false;
   }
   if(Key.isDown(zone.button_punch2))
   {
      if(zone.punched2 == false)
      {
         zone.punched2 = true;
         loc2 = true;
      }
   }
   else
   {
      zone.punched2 = false;
   }
   if(Key.isDown(zone.button_jump))
   {
      if(zone.jumped == false)
      {
         zone.jumped = true;
         loc2 = true;
      }
   }
   else
   {
      zone.jumped = false;
   }
   if(Key.isDown(zone.button_projectile))
   {
      if(zone.pressed_projectile == false)
      {
         zone.pressed_projectile = true;
         loc2 = true;
      }
   }
   else
   {
      zone.pressed_projectile = false;
   }
   return loc2;
}
function f_TornadoMagic(zone)
{
   var loc3 = false;
   f_Magic(zone,- (zone.magic_regen + 0.5));
   if(!zone.human)
   {
      zone.tornado_timer = zone.tornado_timer - 1;
      if(zone.tornado_timer > 0)
      {
         loc3 = true;
         var loc6 = zone.x;
         var loc5 = zone.y;
         _root.f_MoveCharH(zone,zone.speed_x,0);
         _root.f_MoveCharV(zone,zone.speed_y,0);
         if(Math.abs(zone.x - loc6) != Math.abs(zone.speed_x))
         {
            zone.speed_x *= -1;
         }
         else if(zone.x > main.right and zone.speed_x > 0)
         {
            zone.speed_x *= -1;
         }
         else if(zone.x < main.left and zone.speed_x < 0)
         {
            zone.speed_x *= -1;
         }
         if(Math.abs(zone.y - loc5) < Math.abs(zone.speed_y))
         {
            zone.speed_y *= -1;
         }
      }
   }
   else if(Key.isDown(zone.button_magic) and zone.magic_current > 0)
   {
      if(Key.isDown(zone.button_punch2))
      {
         loc3 = true;
         if(zone.body_y < 0)
         {
            zone.body_y += zone.speed_jump;
            if(zone.body_y > 0)
            {
               zone.body_y = 0;
            }
            zone.body._y = zone.body_y + zone.body_table_y;
            zone.speed_jump += zone.gravity;
         }
         if(Key.isDown(zone.button_right) or Key.isDown(zone.button_walk_right))
         {
            zone.speed_x_slide += 0.5;
            if(zone.speed_x_slide > 5)
            {
               zone.speed_x_slide = 5;
            }
         }
         else if(Key.isDown(zone.button_left) or Key.isDown(zone.button_walk_left))
         {
            zone.speed_x_slide -= 0.5;
            if(zone.speed_x_slide < -5)
            {
               zone.speed_x_slide = -5;
            }
         }
         else if(zone.speed_x_slide > 0)
         {
            zone.speed_x_slide -= 0.5;
         }
         else if(zone.speed_x_slide < 0)
         {
            zone.speed_x_slide += 0.5;
         }
         _root.f_MoveCharH(zone,zone.speed_x_slide,0);
         if(Key.isDown(zone.button_down) or Key.isDown(zone.button_walk_down))
         {
            zone.speed_y_slide += 0.5;
            if(zone.speed_y_slide > 5)
            {
               zone.speed_y_slide = 5;
            }
         }
         else if(Key.isDown(zone.button_up) or Key.isDown(zone.button_walk_up))
         {
            zone.speed_y_slide -= 0.5;
            if(zone.speed_y_slide < -5)
            {
               zone.speed_y_slide = -5;
            }
         }
         else if(zone.speed_y_slide > 0)
         {
            zone.speed_y_slide -= 0.5;
         }
         else if(zone.speed_y_slide < 0)
         {
            zone.speed_y_slide += 0.5;
         }
         _root.f_MoveCharV(zone,zone.speed_y_slide,0);
      }
   }
   if(!loc3)
   {
      zone.inputCooldown = 2;
      zone.attack_pow = zone.old_attack_pow;
      zone.punching = false;
      zone.speed_x_slide = 0;
      zone.speed_y_slide = 0;
      var loc4 = f_FX(zone.x,zone.y,zone.y + 1,"tornadodone",100,100);
      loc4.body._y = zone.body_y;
      if(zone.helmet == 20)
      {
         loc4.body.gotoAndStop(1);
      }
      else
      {
         loc4.body.gotoAndStop(2);
      }
      zone.fp_StandAnim(zone);
      zone.fp_Character(zone);
   }
}
function f_CharacterSlide(zone)
{
   if(zone.speed_x_slide != 0)
   {
      f_MoveCharH(zone,zone.speed_x_slide,0);
      if(zone.speed_x_slide > 0)
      {
         zone.speed_x_slide -= 0.5;
         if(zone.speed_x_slide < 0)
         {
            zone.speed_x_slide = 0;
         }
      }
      else if(zone.speed_x_slide < 0)
      {
         zone.speed_x_slide += 0.5;
         if(zone.speed_x_slide > 0)
         {
            zone.speed_x_slide = 0;
         }
      }
   }
   if(zone.speed_y_slide != 0)
   {
      f_MoveCharV(zone,zone.speed_y_slide,0);
      if(zone.speed_y_slide > 0)
      {
         zone.speed_y_slide -= 0.5;
         if(zone.speed_y_slide < 0)
         {
            zone.speed_y_slide = 0;
         }
      }
      else if(zone.speed_y_slide < 0)
      {
         zone.speed_y_slide += 0.5;
         if(zone.speed_y_slide > 0)
         {
            zone.speed_y_slide = 0;
         }
      }
   }
}
function f_AutoLadderClimb(zone)
{
   if(zone.y + zone.body_y < zone.ladder_goal)
   {
      if(zone.ladder.side)
      {
         zone.body_y += zone.body.body.speed_y;
      }
      else
      {
         zone.body_y += 6;
      }
      zone.body._y = zone.body_y;
      if(zone.body_y >= 0)
      {
         zone.body_y = 0;
         zone.body._y = zone.body_y;
         zone.ladder = undefined;
         zone.fp_StandAnim(zone);
      }
   }
   else if(zone.y + zone.body_y > zone.ladder_goal)
   {
      if(zone.ladder.side)
      {
         zone.body_y -= zone.body.body.speed_y;
      }
      else
      {
         zone.body_y -= 6;
      }
      zone.body._y = zone.body_y;
      if(zone.body_y + zone.y < zone.ladder.y - zone.ladder.h + 50)
      {
         f_SetXY(zone,zone.x,zone.ladder.y - zone.ladder.h);
         zone.body_y = 0;
         zone.body._y = zone.body_y;
         if(zone.ladder.side)
         {
            if(zone._xscale > 0)
            {
               f_SetXY(zone,zone.x + 40,zone.y);
            }
            else
            {
               f_SetXY(zone,zone.x - 40,zone.y);
            }
            zone.ladder = undefined;
            zone.gotoAndStop("sideclimb_finish");
         }
         else
         {
            zone.ladder = undefined;
            zone.fp_StandAnim(zone);
         }
      }
   }
   _root.f_ShadowSize(zone);
}
function f_LadderClimb(zone)
{
   zone.magicmode = false;
   if(Key.isDown(zone.button_down) or Key.isDown(zone.button_walk_down) or zone.ladder.side and (Key.isDown(zone.button_left) or Key.isDown(zone.button_walk_left)))
   {
      if(zone.ladder.side)
      {
         zone.body_y += zone.body.body.speed_y;
      }
      else
      {
         zone.body_y += 5;
      }
      zone.body._y = zone.body_y;
      if(zone.body_y >= 0)
      {
         zone.body_y = 0;
         zone.body._y = zone.body_y;
         zone.ladder = undefined;
         zone.fp_StandAnim(zone);
      }
      else
      {
         zone.body.body.play();
      }
   }
   else if(Key.isDown(zone.button_up) or Key.isDown(zone.button_walk_up) or zone.ladder.side and (Key.isDown(zone.button_right) or Key.isDown(zone.button_walk_right)))
   {
      if(zone.ladder.side)
      {
         zone.body_y -= zone.body.body.speed_y;
      }
      else
      {
         zone.body_y -= 5;
      }
      var yoffset = 50;
      zone.body._y = zone.body_y;
      if(zone.body_y + zone.y < zone.ladder.y - zone.ladder.h + yoffset)
      {
         f_SetXY(zone,zone.x,zone.ladder.y - zone.ladder.h);
         zone.body_y = 0;
         zone.body._y = zone.body_y;
         if(zone.ladder.side)
         {
            var xoffset = 40;
            if(zone._xscale > 0)
            {
               f_SetXY(zone,zone.x + xoffset,zone.y);
            }
            else
            {
               f_SetXY(zone,zone.x - xoffset,zone.y);
            }
            zone.ladder = undefined;
            zone.gotoAndStop("sideclimb_finish");
         }
         else
         {
            zone.speed_jump = -5;
            zone.jumping = true;
            zone.ladder = undefined;
            zone.gotoAndStop("jump");
         }
      }
      else
      {
         zone.body.body.play();
      }
   }
   else
   {
      zone.body.body.stop();
   }
   _root.f_ShadowSize(zone);
}
function f_LocalToGame(zone, u_point)
{
   if(zone)
   {
      zone.localToGlobal(u_point);
      p_game.globalToLocal(u_point);
   }
}
function f_BeatAllLevels(c)
{
   var loc1 = c.level_unlocks[7];
   if(loc1 > 2)
   {
      loc1 = c.level_unlocks[11];
      if(loc1 > 2)
      {
         loc1 = c.level_unlocks[4];
         if(loc1 > 2)
         {
            loc1 = c.level_unlocks[23];
            if(loc1 > 2)
            {
               loc1 = c.level_unlocks[21];
               if(loc1 > 2)
               {
                  loc1 = c.level_unlocks[29];
                  if(loc1 > 2)
                  {
                     loc1 = c.level_unlocks[36];
                     if(loc1 > 2)
                     {
                        loc1 = c.level_unlocks[30];
                        if(loc1 > 2)
                        {
                           loc1 = c.level_unlocks[6];
                           if(loc1 > 2)
                           {
                              loc1 = c.level_unlocks[1];
                              if(loc1 > 2)
                              {
                                 loc1 = c.level_unlocks[43];
                                 if(loc1 > 2)
                                 {
                                    loc1 = c.level_unlocks[10];
                                    if(loc1 > 2)
                                    {
                                       loc1 = c.level_unlocks[3];
                                       if(loc1 > 2)
                                       {
                                          loc1 = c.level_unlocks[51];
                                          if(loc1 > 2)
                                          {
                                             loc1 = c.level_unlocks[53];
                                             if(loc1 > 2)
                                             {
                                                loc1 = c.level_unlocks[55];
                                                if(loc1 > 2)
                                                {
                                                   return true;
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
   return false;
}
function f_ArenaGates(zone)
{
   if(_root.active_enemies <= 0)
   {
      if(!zone.door2.open)
      {
         var loc2 = undefined;
         var loc5 = undefined;
         var loc3 = 1;
         while(loc3 <= _root.total_enemies)
         {
            loc2 = _root.loader.game.game["e" + int(loc3)];
            if(loc2.active)
            {
               loc2.body.gotoAndPlay("finish");
            }
            loc3 = loc3 + 1;
         }
         zone.wave = zone.wave + 1;
         if(level == 24)
         {
            loc5 = 10;
         }
         else if(level == 46)
         {
            loc5 = 10;
         }
         else if(level == 47)
         {
            loc5 = 10;
         }
         else if(level == 48)
         {
            loc5 = 10;
         }
         else if(level == 49)
         {
            loc5 = 10;
         }
         else
         {
            loc5 = 10;
         }
         if(zone.wave > loc5)
         {
            f_PlayersStop();
            loc3 = 1;
            while(loc3 <= active_players)
            {
               loc2 = playerArrayOb["p_pt" + int(loc3)];
               if(loc2.alive)
               {
                  loc2.gotoAndStop("dance" + (random(4) + 1));
               }
               if(GetGameMode() != 3)
               {
                  if(level == 24)
                  {
                     if(!_root.f_IsCharacterUnlocked(loc2.hud_pt,6))
                     {
                        _root.f_UnlockCharacter(loc2,6);
                     }
                  }
                  else if(level == 46)
                  {
                     if(!_root.f_IsCharacterUnlocked(loc2.hud_pt,7))
                     {
                        _root.f_UnlockCharacter(loc2,7);
                     }
                  }
                  else if(level == 47)
                  {
                     if(!_root.f_IsCharacterUnlocked(loc2.hud_pt,21))
                     {
                        _root.f_UnlockCharacter(loc2,21);
                     }
                  }
                  else if(level == 48)
                  {
                     if(!_root.f_IsCharacterUnlocked(loc2.hud_pt,18))
                     {
                        _root.f_UnlockCharacter(loc2,18);
                     }
                  }
                  else if(level == 49)
                  {
                     if(!_root.f_IsCharacterUnlocked(loc2.hud_pt,26))
                     {
                        _root.f_UnlockCharacter(loc2,26);
                     }
                  }
               }
               loc3 = loc3 + 1;
            }
            _root.loader.fog.gotoAndPlay("go");
            StopMusic();
            PlayMusic(4,true);
            zone.gotoAndStop(1);
            return undefined;
         }
         zone.total = zone.total + 1;
         if(zone.total > 20)
         {
            zone.total = 20;
         }
         if(zone.wave % 10 == 0)
         {
            zone.level = zone.level + 1;
            if(zone.level > 4)
            {
               zone.level = 4;
            }
            else
            {
               zone.total = 2;
            }
         }
         if(zone.total > 5)
         {
            zone.door1.open = true;
            zone.door1.gotoAndPlay("go");
            zone.door3.open = true;
            zone.door3.gotoAndPlay("go");
         }
         zone.door2.open = true;
         zone.door2.gotoAndPlay("go");
      }
   }
}
function f_Propeller(zone)
{
   zone.propeller_timer = zone.propeller_timer - 1;
   if(zone.propeller_timer >= 0)
   {
      if(zone.human)
      {
         if(Key.isDown(zone.button_left) or Key.isDown(zone.button_walk_left))
         {
            if(zone._xscale > 0)
            {
               zone._xscale *= -1;
            }
            f_MoveCharH(zone,- zone.speed_x,0);
         }
         if(Key.isDown(zone.button_right) or Key.isDown(zone.button_walk_right))
         {
            if(zone._xscale < 0)
            {
               zone._xscale *= -1;
            }
            f_MoveCharH(zone,zone.speed_x,0);
         }
      }
      else if(zone._xscale > 0)
      {
         f_MoveCharH(zone,zone.speed_toss_x,0);
      }
      else
      {
         f_MoveCharH(zone,- zone.speed_toss_x,0);
      }
      zone.body_y += zone.speed_jump;
      zone.body._y = zone.body_y + zone.body_table_y;
      zone.speed_jump += zone.gravity;
      if(zone.body_y >= 0)
      {
         zone.body_y = 0;
         zone.body._y = zone.body_y + zone.body_table_y;
         zone.shadow_pt._xscale = 100;
         zone.shadow_pt._yscale = 100;
      }
      else
      {
         f_ShadowSize(zone);
      }
   }
   else
   {
      zone.punching = false;
      if(zone.body_y < 0)
      {
         zone.jumping = true;
         zone.gotoAndStop("beefy_jump");
      }
      else
      {
         zone.fp_StandAnim(zone);
      }
   }
}
function f_TeamCheck(player, zone)
{
   if(GetGameMode() == 3)
   {
      var loc1 = player.human and zone.human;
      if(loc1 and friendly_fire and arenabattle and player.flag == zone.flag)
      {
         return false;
      }
   }
   else if(friendly_fire and arenabattle)
   {
      return true;
   }
   return true;
}
function f_RestrictPlayerSandwiches()
{
   var loc3 = 1;
   while(loc3 <= active_players)
   {
      var loc1 = playerArrayOb["p_pt" + int(loc3)];
      if(loc1.alive && loc1.equippeditem == 11)
      {
         if(loc1.healthpots > 0)
         {
            loc1.hud_pt.item_unlocks[9] = true;
         }
         else
         {
            loc1.hud_pt.item_unlocks[9] = false;
         }
         if(loc1.bombs > 0)
         {
            loc1.hud_pt.item_unlocks[8] = true;
         }
         else
         {
            loc1.hud_pt.item_unlocks[8] = false;
         }
         loc1.equippeditem = 0;
         var loc2 = 1;
         while(loc2 < 11)
         {
            if(loc1.hud_pt.item_unlocks[loc2])
            {
               loc1.equippeditem = loc2;
               break;
            }
            loc2 = loc2 + 1;
         }
         loc1.hud_pt.stats.item.gotoAndStop(loc1.equippeditem + 1);
      }
      loc3 = loc3 + 1;
   }
}
function f_DisplayWeaponBonus(weapon, zone)
{
   zone.stat1.gotoAndStop("blank");
   zone.stat2.gotoAndStop("blank");
   zone.stat3.gotoAndStop("blank");
   zone.stat4.gotoAndStop("blank");
   _root.f_WeaponStats(zone,weapon);
   if(zone.level)
   {
      SetTextNumeric(zone.level,zone.weapon_level);
   }
   var loc4 = 1;
   var loc2 = zone.stat1;
   if(zone.weapon_strength > 0)
   {
      loc2.gotoAndStop("strength");
      if(loc2.text1)
      {
         SetTextNumeric(loc2.text1,zone.weapon_strength);
      }
      loc4 = loc4 + 1;
   }
   else if(zone.weapon_strength < 0)
   {
      loc2.gotoAndStop("strength");
      if(loc2.text1)
      {
         SetTextNumeric(loc2.text1,- zone.weapon_strength);
      }
      loc2.plusminus.gotoAndStop(2);
      loc4 = loc4 + 1;
   }
   loc2 = zone["stat" + int(loc4)];
   if(zone.weapon_magic > 0)
   {
      loc2.gotoAndStop("magic");
      if(loc2.text1)
      {
         SetTextNumeric(loc2.text1,zone.weapon_magic);
      }
      loc4 = loc4 + 1;
   }
   else if(zone.weapon_magic < 0)
   {
      loc2.gotoAndStop("magic");
      if(loc2.text1)
      {
         SetTextNumeric(loc2.text1,- zone.weapon_magic);
      }
      loc2.plusminus.gotoAndStop(2);
      loc4 = loc4 + 1;
   }
   loc2 = zone["stat" + int(loc4)];
   if(zone.weapon_defense > 0)
   {
      loc2.gotoAndStop("defense");
      if(loc2.text1)
      {
         SetTextNumeric(loc2.text1,zone.weapon_defense);
      }
      loc4 = loc4 + 1;
   }
   else if(zone.weapon_defense < 0)
   {
      loc2.gotoAndStop("defense");
      if(loc2.text1)
      {
         SetTextNumeric(loc2.text1,- zone.weapon_defense);
      }
      loc2.plusminus.gotoAndStop(2);
      loc4 = loc4 + 1;
   }
   loc2 = zone["stat" + int(loc4)];
   if(zone.weapon_agility > 0)
   {
      loc2.gotoAndStop("agility");
      if(loc2.text1)
      {
         SetTextNumeric(loc2.text1,zone.weapon_agility);
      }
      loc4 = loc4 + 1;
   }
   else if(zone.weapon_agility < 0)
   {
      loc2.gotoAndStop("agility");
      if(loc2.text1)
      {
         SetTextNumeric(loc2.text1,- zone.weapon_agility);
      }
      loc2.plusminus.gotoAndStop(2);
      loc4 = loc4 + 1;
   }
   loc2 = zone.stat4;
   if(zone.weapon_critical > 0)
   {
      loc2.gotoAndStop("critical");
   }
   else if(zone.weapon_magic_type > 0)
   {
      switch(zone.weapon_magic_type)
      {
         case 1:
            loc2.gotoAndStop("poison");
            break;
         case 2:
            loc2.gotoAndStop("lightning");
            break;
         case 3:
            loc2.gotoAndStop("ice");
            break;
         case 4:
            loc2.gotoAndStop("fire");
      }
   }
   else if(loc4 == 1)
   {
      zone.stat1.gotoAndStop("strength");
      if(zone.stat1.text1)
      {
         SetTextNumeric(zone.stat1.text1,zone.weapon_strength);
      }
   }
}

function f_CheckLoadGlitch() {
   if(_root.loader.b_loaded && _root.main.fp_Main == _root.loader.f_Init) {
      var LOAD_FRAME = 3; // Consistent for all (i think) levels
      var DUMMY_FRAME = 30; // a dummy load state to allow asset load time progression without other loading stuff happening

      if(main.n_state == LOAD_FRAME) {
         main.n_state = DUMMY_FRAME; // Set loading state to 30 to allow for full asset loads
      }
      else if(main.n_state == extraLoadTime + DUMMY_FRAME) { // The allotted extra load time has passed
         main.n_state = LOAD_FRAME + 1;
      }
   }
}

function f_GetSaveDataOffset(p_type)
{
   var offset = undefined;
   switch(p_type) {
      case 32: // barboss
         offset = 5; // Barbarian
         break;
      case 33: // cyclops
         offset = 20; // Conehead
         break;
      case 34: // Beetle
         offset = 15;// Royal guard
         break;
      default:
         offset = p_type - 1;
   }
   return offset;
}

function f_PunchSetBarbBoss1(zone) {
   zone.punching = true;
   if(zone.blocking && zone.body.body._currentframe == 14) { // Extending spike from board while blocking
      zone.punch_group = 300;
      zone.force_x = 35;
      zone.force_y = -10;
      zone.gotoAndStop("spikes");
      zone.body.gotoAndPlay(17);
   }
   else if(zone.magicmode && zone.inputCooldown == 0) {
      zone.punch_group = 300;
      zone.force_x = 35;
      zone.force_y = -10;
      zone.blocking = true;
      zone.gotoAndStop("spikes");
   }
   else {
      zone.punch_group = 300;
      zone.force_x = 10;
      zone.force_y = -27;
      zone.gotoAndStop("punch");
   }
}

function f_PunchSetBarbBoss2(zone) {
   zone.punching = true;
   if(zone.magicmode) {
      zone.gotoAndStop("fire");
   }
   else {
      zone.gotoAndStop("slam");
   }
}

function f_ApplyMultToAllPunchPows(zone, mult) {
   zone.punch_pow_low *= mult;
   zone.punch_pow_medium *= mult;
   zone.punch_pow_high *= mult;
   zone.punch_pow_max *= mult;
}

function f_JugDrop(zone)
{
   if(zone._xscale > 0)
   {
      var loc3 = _root.f_FX(zone.x + 150,zone.y,zone.y + 1,"jug",100,100);
      loc3.speed_x = random(3) + 3;
   }
   else
   {
      loc3 = _root.f_FX(zone.x - 150,zone.y,zone.y + 1,"jug",100,100);
      loc3.speed_x = 0 - (random(3) + 3);
   }
   loc3.body._y = -150;
   loc3.speed_y = 0 - (random(5) + 14);
   loc3.gravity = 2;
   loc3.bounces = 0;
   loc3.bounces_max = 2;
   loc3.hit_function = _root.f_CannonBallExplode;
}


// Writes data from hud slot to the main hud if slot exists, otherwise returns false
// Should be called on exiting lobby, if func retuns false will do the usual f_LoadCharacterData
function f_LoadCharacterDataFromHudSlot(hudNum)
{
   var hud = _root["hud" + int(hudNum)];
   var hudSlot = hud["slot" + int(hud.p_type)];
   if(hudSlot != undefined) {
      f_TransferHudData(hud,hudSlot);
      return true;
   }
   return false;
}

// Writes currently held hud data to a new/existing hud slot
// Should be called on entering lobby
function f_WriteCharacterDataToHudSlot(hudNum)
{
   var hud = _root["hud" + int(hudNum)];
   var hudSlot = hud["slot" + int(hud.p_type)];
   if(hudSlot == undefined) {
      var newslot = new Object();
      hud["slot" + int(hud.p_type)] = newslot;
   }
   f_TransferHudData(hud["slot" + int(hud.p_type)],hud);
}

function f_TransferHudData(hud1, hud2)
{
   hud1.level = hud2.level;
   hud1.exp = hud2.exp;
   hud1.exp_mod = hud2.exp_mod;
   hud1.exp_next = hud2.exp_next;
   hud1.exp_start = hud2.exp_start;

   var statpts;
   if(hud2.level > 20)
   {
      statpts = 42 + (hud2.level - 20);
   }
   else
   {
      statpts = hud2.level * 2 + 2;
   }
   var curstats = hud2.strength + hud2.defense + hud2.magic + hud2.agility;
   if(curstats > 100) {
      curstats = 100;
   }
   if(statpts > 100) {
      statpts = 100;
   }
   hud1.xpgained = statpts - curstats;
   
   hud1.strength = hud2.strength;
   hud1.magic = hud2.magic;
   hud1.defense = hud2.defense;
   hud1.agility = hud2.agility;
   hud1.weapon = hud2.weapon;
   if(hud2.animal_type) {
      hud1.animal_type = hud2.animal_type;
   }
   hud1.healthpots = hud2.healthpots;
   hud1.beefies = hud2.beefies;
   hud1.bombs = hud2.bombs;
   hud1.gold = hud2.gold;
   hud1.gold_start = hud2.gold;
   hud1.insane_mode = hud2.insane_mode;
   hud1.achievement = 0;
   hud1.exp_last = 0;
   hud1.health_max = hud1.health = 10000;
   if(hud2.port == 1)
   {
      hud1.achievement |= 16;
   }
   else if(hud2.port == 2)
   {
      hud1.achievement |= 32;
   }
   else if(hud2.port == 3)
   {
      hud1.achievement |= 64;
   }
   else if(hud2.port == 4)
   {
      hud1.achievement |= 128;
   }
   f_WriteLevelUnlocks(hud1,hud2);
   f_LoadLevelUnlocks(hud1);
   f_WriteOtherUnlocks(hud1,hud2);
}

function f_WriteLevelUnlocks(hud1, hud2)
{
   hud1.normal_level_unlocks = new Array(4);
   hud1.insane_level_unlocks = new Array(4);
   hud.level_unlocks = new Array(save_data_info.num_levels);
   var levels = hud2.normal_level_unlocks.length;
   var i = 0;
   while(i < levels) {
      hud1.normal_level_unlocks[i] = hud2.normal_level_unlocks[i];
      hud1.insane_level_unlocks[i] = hud2.insane_level_unlocks[i];
      i++;
   }
}
function f_WriteOtherUnlocks(hud1, hud2)
{
   hud1.animal_unlocks = new Array(int(save_data_info.num_animals));
   hud1.item_unlocks = new Array(int(save_data_info.num_items));
   hud1.item_unlocks_expansion = new Array(int(save_data_info.num_items_expansion));
   hud1.relic_unlocks = new Array(int(save_data_info.num_relics));
   var loc3 = 0;
   while(loc3 < save_data_info.num_animals)
   {
      hud1.animal_unlocks[loc3] = hud2.animal_unlocks[loc3];
      loc3 = loc3 + 1;
   }
   loc3 = 0;
   while(loc3 < save_data_info.num_items)
   {
      hud1.item_unlocks[loc3] = hud2.item_unlocks[loc3];
      loc3 = loc3 + 1;
   }
   loc3 = 0;
   while(loc3 < save_data_info.num_items_expansion)
   {
      hud1.item_unlocks_expansion[loc3] = hud2.item_unlocks_expansion[loc3];
      loc3 = loc3 + 1;
   }
   loc3 = 0;
   while(loc3 < save_data_info.num_relics)
   {
      hud1.relic_unlocks[loc3] = hud2.relic_unlocks[loc3];
      loc3 = loc3 + 1;
   }
}


function f_HitBarbBoss(zone) {
   if(zone.blocking && zone.hitby._xscale > 0 && zone._xscale < 0 || zone.hitby._xscale < 0 && zone._xscale > 0) {
      var loc8;
      if(zone._xscale > 0)
      {
         loc8 = zone.x + 140 + random(40);
      }
      else
      {
         loc8 = zone.x - (140 + random(40));
      }
      var loc9 = random(60) + 80;
      var loc10 = f_FX(loc8,zone.y - 1,zone.y - 1,"door_shrapnel",loc9,loc9);
      loc10.speed_y = 0 - (random(6) + 15);
      loc10.gravity = 8;
      loc10.body._y = zone.fx_y - zone.y;
      loc10.bounces = 0;
      loc10.bounces_max = 1 + random(2);
      loc10.hit_function = _root.f_GeneralBounce;
      if(zone._xscale > 0)
      {
         loc10.speed_x = random(4) + 7;
      }
      else
      {
         loc10.speed_x = 0 - (random(4) + 7);
      }
      _root.f_FX(zone.fx_x,zone.fx_y,zone.y - 1,"impact_block",100,100);
   }
   f_CheckDead(zone);
   return false; // don't skip rest of regular hit function
}

function f_BarbBossCheckReturnToBlockAnim(zone) {
   if(Key.isDown(zone.button_shield)) {
      zone.punching = false;
      zone.gotoAndStop("blocking");
      zone.body.body.gotoAndPlay(13);
   }
}

function f_ProjectileHitWarMachine(zone)
{
   if(zone.victim) {
      zone.victim = undefined;
      return;
   }
   s_Explosion4.start(0,0);
   f_ScreenShake(2, 12, zone.owner);
   var fx = f_FX(zone.x,zone.y + zone.body._y,zone.y + 5,"explosion4",400,400);
   fx.attack_pow = zone.attack_pow;
   fx.owner = zone.owner;
   f_RemoveShadow(zone);
   zone.gotoAndStop("remove");
}

function f_PunchSetCyclops1(zone) {
   zone.punching = true;
   if(zone.magicmode) {
      f_CyclopsTransformInit(zone);
   }
   else {
      zone.gotoAndStop("punch1_1");
   }
   f_AlignBody(zone);
}

function f_PunchSetCyclops2(zone) {
   zone.punching = true;
   zone.gotoAndStop("punch1_2");
   f_AlignBody(zone);
}

function f_PunchSetBeetle1(zone) {
   zone.punching = true;
   zone.gotoAndStop("punch1_1");
   f_AlignBody(zone);
}

function f_PunchSetBeetle2(zone) {
   // Initiating burrow attack
   if(zone.magicmode) {
      zone.burrow_speed_x = 0;
      zone.burrow_speed_x_max = 20;
      zone.burrow_speed_y = 0;
      zone.burrow_speed_y_max = 20;
      zone.burrowTimer = 0;
      zone.punch_group = 400;
      zone.punch_num = 1;
      zone.attack_pow = zone.arrow_pow;
      zone.force_x = 2;
      zone.force_y = - (18 + random(6)); // should probably update this more often lol
      zone.hitnohit = true;
      zone.invincible_timer = 999;
      zone.gotoAndStop("punch2_1");
   }
   else {
      zone.punching = true;
      zone.force_x = 2 + random(3);
      zone.force_y = -20;
      zone.punch_group = 300;
      zone.punch_num = 1;
      zone.attack_type = DMG_MELEE;
      zone.gotoAndStop("punch1_2");
   }
   f_AlignBody(zone);
}

function f_HitPlayerBeetle(zone) {
   if(zone.health > 0)
   {
      zone.hit_number++;
      if(zone.hit_number > 4)
      {
         zone.hit_number = 1;
      }
      var loc3 = int(zone.hit_number);
      switch(loc3)
      {
         case 1:
            zone.gotoAndStop("hit1");
            break;
         case 2:
            zone.gotoAndStop("hit2");
            break;
         case 3:
            zone.gotoAndStop("hit1");
            break;
         case 4:
            zone.left = zone._xscale < 0;
            zone.gotoAndStop("fly");
      }
      zone.body.gotoAndPlay(1);
   }
   else
   {
      zone.alive = false;
      f_RemoveShadow(zone);
      zone.gotoAndStop("die");
   }
}

// Character function for burrowing
function f_BeetleBurrow(zone) {
   var exit = false;

   var burrowCost = 0;
   if(zone.magic_current > burrowCost) {
      var ACCEL_RATE_X = 2;
      var ACCEL_RATE_Y = 1;

      zone.burrowTimer++;
      zone.invincible_timer = 2; // Always set to invincible during burrowing

      // Checking for exit burrow input
      if(Key.isDown(zone.button_punch2)) {
         if(!zone.pressed_punch2) {
            zone.pressed_punch2 = true;
            exit = true;
         }
      }
      else {
         zone.pressed_punch2 = false;
      }
      // Use magic
      f_Magic(zone, - burrowCost);
      // Check magicmode
      f_MagicMode(zone);

      // Accel right
      if(Key.isDown(zone.button_walk_right) || Key.isDown(zone.button_right)) {
         zone.burrow_speed_x += ACCEL_RATE_X;
         if(zone.burrow_speed_x > zone.burrow_speed_x_max) {
            zone.burrow_speed_x = zone.burrow_speed_x_max;
         }
      }
      // Accel left
      if(Key.isDown(zone.button_walk_left) || Key.isDown(zone.button_left)) {
         zone.burrow_speed_x -= ACCEL_RATE_X;
         if(zone.burrow_speed_x < -zone.burrow_speed_x_max) {
            zone.burrow_speed_x = -zone.burrow_speed_x_max;
         }
      }
      // Accel up
      if(Key.isDown(zone.button_walk_up) || Key.isDown(zone.button_up)) {
         zone.burrow_speed_y = -zone.speed_y;
         /*zone.burrow_speed_y -= ACCEL_RATE_Y;
         if(zone.burrow_speed_y < -zone.burrow_speed_y_max) {
            zone.burrow_speed_y = -zone.burrow_speed_y_max;
         }*/
      }
      // Accel down
      else if(Key.isDown(zone.button_walk_down) || Key.isDown(zone.button_down)) {
         zone.burrow_speed_y = zone.speed_y;
         /*zone.burrow_speed_y += ACCEL_RATE_Y;
         if(zone.burrow_speed_y > zone.burrow_speed_y_max) {
            zone.burrow_speed_y = zone.burrow_speed_y_max;
         }*/
      }
      else {
         zone.burrow_speed_y = 0;
      }
      // Moving
      f_MoveCharH(zone, zone.burrow_speed_x, 0);
      f_MoveCharV(zone, zone.burrow_speed_y, 0);
      // Updating body scale
      zone.body._yscale = Math.abs(zone.burrow_speed_x) / zone.burrow_speed_x_max * 100;

      // Dust FX
      if(zone.burrowTimer % 2 == 0) {
         var dustScale = 80 + random(20) * sign(zone._xscale);
         f_FX(zone.x, zone.y + random(8), int(zone.y) + 1, level_dust, dustScale, Math.abs(dustScale));
      }
   }
   else {
      exit = true;
   }

   if(exit) {
      zone.hitnohit = false;
      zone.burrow_speed_x_max = zone.burrow_speed_y_max = undefined
      zone.burrowTimer = undefined;
      zone.gotoAndStop("punch2_3");
   }
}

// Returns -1, 0, || 1 depending on the sign of the given value
function sign(val) {
   if(val > 0) {
      return 1;
   }
   else if(val < 0) {
      return -1;
   }
   else {
      return 0;
   }
}

function f_StandTypeUndead(zone) {
   zone.gotoAndStop("undead_stand");
}

function f_WalkTypeUndead(zone) {
   zone.gotoAndStop("undead_walk");
}

function f_PunchSetUndead1(zone) {
   zone.punching = true;
   if(zone.magicmode) {
      f_CyclopsTransformInit(zone);
   }
   else {
      zone.gotoAndStop("undead_punch1_1");
   }
   f_AlignBody(zone);
}

function f_PunchSetUndead2(zone) {
   zone.punching = true;
   if(zone.magicmode) {
      zone.dashing = true; // Making you move quickly if you didn't start the attack while running
      zone.gotoAndStop("undead_punch2_1");
   }
   else {
      zone.gotoAndStop("undead_punch1_2");
   }
   f_AlignBody(zone);
}

// Control func for hopping around in coffin
function f_CyclopsCoffin(zone) {
   var exit = false;

   var manaCost = zone.magic_regen + 1.5;
   if(zone.magic_current > manaCost) {
      // Use magic
      f_Magic(zone, - manaCost);

      // Checking for exit input
      if(Key.isDown(zone.button_punch2)) {
         if(!zone.pressed_punch2) {
            zone.pressed_punch2 = true;
            exit = true;
         }
      }
      else {
         zone.pressed_punch2 = false;
      }

      // Bouncing
      zone.body_y = zone.body.body._y + 30;
      zone.body._y = zone.body_y;
      f_ShadowSize(zone);

      // Allow moving
      f_Walk(zone);
      f_LargeObjectRanges(zone);
   }
   else {
      exit = true;
   }

   if(exit) {
      // Making undead groom start exploding
      if(zone.buddy) {
         zone.buddy.mode = 3;
      }

      // Get down from coffin
      zone.body_y = 0;
      zone.gotoAndStop("undead_punch2_3");
   }
}

function f_CyclopsTransformInit(zone) {
   s_CyclopsScreamCrop.start(0,0);
   zone.transformTimer = 30;
   f_ScreenShake(0.05, zone.transformTimer, zone);
   zone.gotoAndStop("transform");
}

function f_CyclopsTransform(zone, undead) {
   if(Key.isDown(zone.button_magic) && Key.isDown(zone.button_punch1)) {
      zone.transformTimer--;
      main.shake_intensity += 0.025;
      if(main.shake_intensity > 0.75) {
         main.shake_intensity = 0.75;
      }
      if(zone.transformTimer == 0) {
         s_Explosion4.start(0,0);

         f_ScreenShake(5, 12, zone);
         main.resetShakeAfterDone = true; // prevent screen shake values from carrying over

         var fx = f_FX(zone.x, zone.y + zone.body._y, zone.y + 5, "playerbombexplode", 200, 200);
         fx.body._y = fx.body_y = zone.body_y / 2 + 15; // set so it looks on-ground (+ 15 is bc the sprite has a bit of an offset) (/2 is because of the doubled scale)
         fx.attack_pow = zone.magic_pow / 10;
         fx.owner = zone.owner;

         f_SetUndead(zone, undead);
         f_Magic(zone, zone.magic_max); // Refill mana
         zone.punching = false;
         zone.fp_StandAnim(zone);
         zone.transformTimer = undefined;
      }
   }
   else {
      s_CyclopsScreamCrop.stop();
      main.resetShakeAfterDone = true;
      zone.fp_StandAnim(zone);
   }
}

function f_CyclopsLaserBeam(zone) {
   var manaCost = zone.magic_regen + 1.75;
   if(zone.magic_current > manaCost && Key.isDown(zone.button_projectile) && Key.isDown(zone.button_magic)) {
      // Use magic
      if(zone.body._currentframe > 9) { // Beam is firing
         f_Magic(zone, - manaCost);
      }
   }
   else {
      _root.s_TrollLazerCrop.stop();
      zone.fp_StandAnim(zone);
   }
}

// Undead Groom NPC

function f_SpawnUndeadGroomNPC(x, y, spawner) {
   var u_temp = f_SpawnPlayer(11, 1, x, y); // NPC slot 11 is reserved for this bozo
   u_temp.haswall = false;
   u_temp.active = true;
   u_temp.alive = false;
   u_temp.h = 100;
   u_temp.w = 40;
   u_temp.health_max = 1000;
   u_temp.health = u_temp.health_max;
   u_temp.invincible_timer = 100;
   _root.f_UnresponsiveDefaults(u_temp);
   u_temp.humanoid = false;
   u_temp.fp_Hit1 = undefined;
   u_temp.fp_Hit2 = undefined;
   u_temp.fp_Hit3 = undefined;
   u_temp.fp_Juggle = undefined;
   u_temp.fp_Character = f_UndeadGroom;
   u_temp.parentCyclops = spawner;
   spawner.buddy = u_temp;
   u_temp.fp_StandAnim = f_UndeadGroomWalk;
   u_temp.fp_WalkAnim = f_UndeadGroomWalk;
   u_temp.fp_WalkAnim(u_temp);
   return u_temp;
}

function f_UndeadGroomWalk(zone) {
   zone.gotoAndStop("undeadgroom_walk");
}

function f_UndeadGroom(zone) {
   if(zone.prey.burried) {
      if(friendly_fire) {
         zone.prey = f_PickRandomPlayer();
      }
      else {
         zone.prey = f_PickRandomEnemy();
      }
   }
   switch(zone.mode)
   {
      case 1:
         zone.mode_timer -= 1;
         if(zone.mode_timer > 0)
         {
            zone.speed = zone.parentCyclops.magic_sustain_pow / 5 + 3;
            zone.target_x = zone.prey.x;
            zone.target_y = zone.prey.y;
         }
         else
         {
            zone.mode = 2;
            zone.mode_timer = 15;
            zone.mode_half = zone.mode_timer / 2;
            zone.target_x = zone.prey.x;
            zone.target_y = zone.prey.y;
         }
         break;
      case 2:
         zone.mode_timer -= 1;
         if(zone.mode_timer > zone.mode_half)
         {
            zone.speed_x *= 1.1;
            zone.speed_y *= 1.1;
         }
         else if(zone.mode_timer > 0)
         {
            zone.speed_x *= 0.9;
            zone.speed_y *= 0.9;
         }
         else
         {
            zone.mode_timer = 60;
            zone.mode = 1;
            zone.speed = 3;
            zone.target_x = zone.prey.x;
            zone.target_y = zone.prey.y;
         }
         break;
      case 3: // Exploding
         zone.mode_timer += 1;
         zone.gotoAndStop("undeadgroom_explode");
         break;
   }
   if(zone.mode == 1 or zone.mode == 3 or zone.mode == 4)
   {
      var loc3 = Math.abs(zone.x - zone.target_x);
      var loc4 = Math.abs(zone.y - zone.target_y);
      if(loc3 > loc4)
      {
         zone.speed_x = zone.speed;
         zone.speed_y = zone.speed * (loc4 / loc3);
         var loc5 = loc3;
      }
      else
      {
         zone.speed_x = zone.speed * (loc3 / loc4);
         zone.speed_y = zone.speed;
         loc5 = loc4;
      }
      if(zone.x > zone.target_x)
      {
         zone.speed_x *= -1;
      }
      if(zone.y > zone.target_y)
      {
         zone.speed_y *= -1;
      }
   }
   if(zone.speed_x > 0 and zone._xscale < 0)
   {
      zone._xscale *= -1;
   }
   else if(zone.speed_x < 0 and zone._xscale > 0)
   {
      zone._xscale *= -1;
   }
   if(Math.abs(zone.speed_x) > 10 or Math.abs(zone.speed_y) > 10)
   {
      var loc6 = 1;
   }
   else if(Math.abs(zone.speed_x) > 6 or Math.abs(zone.speed_y) > 6)
   {
      loc6 = 2;
   }
   else
   {
      loc6 = 5;
   }
   if(zone.mode_timer % loc6 == 0)
   {
      if(zone.mode_timer % (loc6 * 9) == 0)
      {
         _root["s_OrganDead" + (random(4) + 1)].start(0,0);
      }
      var loc7 = 80 + random(20);
      var loc8 = _root.f_FX(zone.x,zone.y - (20 + random(60)),int(zone.y) + 1,"evilmusic",loc7,loc7);
      loc8.body._rotation += -20 + random(40);
   }
   var loc9 = zone.x;
   _root.f_MoveCharH(zone,zone.speed_x,0);
   var loc10 = zone.y;
   _root.f_MoveCharV(zone,zone.speed_y,0);
   if(zone.mode == 2)
   {
      if(zone.x == loc9 and zone.speed_x != 0 or zone.y == loc10 and zone.speed_y != 0)
      {
         zone.mode = 1;
      }
   }

   var hit = false;
   // Hitting players
   if(friendly_fire) {
      var loc12 = 1;
      while(loc12 <= active_players)
      {
         loc8 = playerArrayOb["p_pt" + int(loc12)];
         if(loc8.alive and !loc8.nohit)
         {
            if(Math.abs(loc8.y - zone.y) < 15)
            {
               if(Math.abs(loc8.x - zone.x) < 40)
               {
                  if(loc8.body_y > -80 and !loc8.burried and loc8.toss_clock <= 0)
                  {
                     hit = true;
                     loc8.hitby = zone;
                     _root.f_PunchSound();
                     _root.f_FX(loc8.x,loc8.body_y + loc8.y,int(loc8.y) + 15,"impact1",100,100);
                     var loc13 = zone.parentCyclops.magic_pow / 2;
                     _root.f_Damage(loc8,loc13,_root.DMG_MELEE,_root.DMGFLAG_JUGGLE,8 + random(4),0 - (15 + random(6)));
                     if(loc8 == zone.prey and zone.mode == 1)
                     {
                        zone.mode_timer = 0;
                     }
                     loc7 = 80 + random(20);
                     loc8 = _root.f_FX(loc8.x + 10,loc8.y + loc8.body_y - (20 + random(60)),int(zone.y) + 1,"evilmusic",loc7,loc7);
                     loc8.body._rotation += -20 + random(40);
                     loc7 = 80 + random(20);
                     loc8 = _root.f_FX(loc8.x - 10,loc8.y + loc8.body_y - (20 + random(60)),int(zone.y) + 1,"evilmusic",loc7,loc7);
                     loc8.body._rotation += -20 + random(40);
                  }
                  else if(loc8 == zone.prey and zone.mode == 1)
                  {
                     zone.mode_timer = 0;
                  }
               }
            }
         }
         loc12 += 1;
      }
   }
   // Hitting enemies
   var loc12 = 1;
   while(loc12 <= active_enemies)
   {
      loc8 = enemyArrayOb["e" + int(loc12)];
      if(loc8.alive and !loc8.nohit)
      {
         if(Math.abs(loc8.y - zone.y) < 15)
         {
            if(Math.abs(loc8.x - zone.x) < 40)
            {
               if(loc8.body_y > -80 and !loc8.burried and loc8.toss_clock <= 0)
               {
                  hit = true;
                  loc8.hitby = zone;
                  _root.f_PunchSound();
                  _root.f_FX(loc8.x,loc8.body_y + loc8.y,int(loc8.y) + 15,"impact1",100,100);
                  var loc13 = zone.parentCyclops.magic_pow / 2;
                  _root.f_Damage(loc8,loc13,_root.DMG_MELEE,_root.DMGFLAG_JUGGLE,8 + random(4),0 - (15 + random(6)));
                  if(loc8 == zone.prey and zone.mode == 1)
                  {
                     zone.mode_timer = 0;
                  }
                  loc7 = 80 + random(20);
                  loc8 = _root.f_FX(loc8.x + 10,loc8.y + loc8.body_y - (20 + random(60)),int(zone.y) + 1,"evilmusic",loc7,loc7);
                  loc8.body._rotation += -20 + random(40);
                  loc7 = 80 + random(20);
                  loc8 = _root.f_FX(loc8.x - 10,loc8.y + loc8.body_y - (20 + random(60)),int(zone.y) + 1,"evilmusic",loc7,loc7);
                  loc8.body._rotation += -20 + random(40);
               }
               else if(loc8 == zone.prey and zone.mode == 1)
               {
                  zone.mode_timer = 0;
               }
            }
         }
      }
      loc12 += 1;
   }

   if(hit) {
      if(friendly_fire) {
         zone.prey = f_PickRandomPlayer();
      }
      else {
         zone.prey = f_PickRandomEnemy();
      }
   }
}

function f_PickRandomEnemy() {
   return enemyArrayOb["e" + (random(active_enemies) + 1)];
}

function f_EnemyUsesPlayerSwf(e) {
   return e.e_type != undefined;
}

package
{
   import fl.containers.ScrollPane;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.system.System;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   [Embed(source="/_assets/assets.swf", symbol="Menu")]
   public class Menu extends MovieClip
   {
       
      
      public var $class:InfoBox;
      
      public var $status:InfoBox;
      
      public var _logo1:Logo_LogoBox2;
      
      public var _logo2:Logo_LogoBox2;
      
      public var ach0:MovieClip;
      
      public var ach1:MovieClip;
      
      public var ach10:MovieClip;
      
      public var ach11:MovieClip;
      
      public var ach12:MovieClip;
      
      public var ach13:MovieClip;
      
      public var ach14:MovieClip;
      
      public var ach15:MovieClip;
      
      public var ach16:MovieClip;
      
      public var ach17:MovieClip;
      
      public var ach18:MovieClip;
      
      public var ach19:MovieClip;
      
      public var ach2:MovieClip;
      
      public var ach20:MovieClip;
      
      public var ach3:MovieClip;
      
      public var ach4:MovieClip;
      
      public var ach5:MovieClip;
      
      public var ach6:MovieClip;
      
      public var ach7:MovieClip;
      
      public var ach8:MovieClip;
      
      public var ach9:MovieClip;
      
      public var aggro:InfoBox;
      
      public var aim:InfoBox;
      
      public var bg:MovieClip;
      
      public var box_left:MovieClip;
      
      public var box_mission:MovieClip;
      
      public var box_right:MovieClip;
      
      public var bt_akq:SimpleButton;
      
      public var bt_akqboth:MovieClip;
      
      public var bt_akqhero:SimpleButton;
      
      public var bt_app:SimpleButton;
      
      public var bt_back:SimpleButton;
      
      public var bt_bloody:SimpleButton;
      
      public var bt_credits:SimpleButton;
      
      public var bt_custom:SimpleButton;
      
      public var bt_daily:SimpleButton;
      
      public var bt_delete:SimpleButton;
      
      public var bt_deleteno:SimpleButton;
      
      public var bt_deleteyes:SimpleButton;
      
      public var bt_eff:SimpleButton;
      
      public var bt_facebook:SimpleButton;
      
      public var bt_glow:SimpleButton;
      
      public var bt_gore:SimpleButton;
      
      public var bt_heroes:SimpleButton;
      
      public var bt_inventory:SimpleButton;
      
      public var bt_ipad:SimpleButton;
      
      public var bt_iphone:SimpleButton;
      
      public var bt_medals:SimpleButton;
      
      public var bt_missions:SimpleButton;
      
      public var bt_money:SimpleButton;
      
      public var bt_music:SimpleButton;
      
      public var bt_new:SimpleButton;
      
      public var bt_options:SimpleButton;
      
      public var bt_play:SimpleButton;
      
      public var bt_qual:SimpleButton;
      
      public var bt_right:SimpleButton;
      
      public var bt_shake:SimpleButton;
      
      public var bt_slots:SimpleButton;
      
      public var bt_sound:SimpleButton;
      
      public var bt_start:SimpleButton;
      
      public var bt_store:SimpleButton;
      
      public var bt_tips:SimpleButton;
      
      public var bt_twitter:SimpleButton;
      
      public var bt_unlock:SimpleButton;
      
      public var bt_voice:SimpleButton;
      
      public var bt_workshop:SimpleButton;
      
      public var bt_youtube:SimpleButton;
      
      public var char:MovieClip;
      
      public var char0:MovieClip;
      
      public var char1:MovieClip;
      
      public var char2:MovieClip;
      
      public var char3:MovieClip;
      
      public var char4:MovieClip;
      
      public var cont:MovieClip;
      
      public var contbox:MovieClip;
      
      public var critical:InfoBox;
      
      public var getitem:GetItem;
      
      public var health:InfoBox;
      
      public var heroCont:MovieClip;
      
      public var heroes:InfoBox;
      
      public var hover:MovieClip;
      
      public var info0:MovieClip;
      
      public var info1:MovieClip;
      
      public var info2:MovieClip;
      
      public var info3:MovieClip;
      
      public var info4:MovieClip;
      
      public var inv0:MovieClip;
      
      public var inv1:MovieClip;
      
      public var inv10:MovieClip;
      
      public var inv11:MovieClip;
      
      public var inv12:MovieClip;
      
      public var inv2:MovieClip;
      
      public var inv3:MovieClip;
      
      public var inv4:MovieClip;
      
      public var inv5:MovieClip;
      
      public var inv6:MovieClip;
      
      public var inv7:MovieClip;
      
      public var inv8:MovieClip;
      
      public var inv9:MovieClip;
      
      public var inventory:InfoBox;
      
      public var logo1:Logo_LogoBox;
      
      public var logo2:Logo_LogoBox;
      
      public var mc_daily:MovieClip;
      
      public var mc_squadcode:MovieClip;
      
      public var mc_Psquadcode:MovieClip;
      
      public var mc_status:MovieClip;
      
      public var missions:InfoBox;
      
      public var mobility:InfoBox;
      
      public var scrollbox:MovieClip;
      
      public var scrollpane:ScrollPane;
      
      public var slotmachine:SlotMachine;
      
      public var store:InfoBox;
      
      public var tutorial:MovieClip;
      
      public var txt_agi:TextField;
      
      public var txt_bloody:TextField;
      
      public var txt_day:TextField;
      
      public var txt_delete:TextField;
      
      public var txt_deleteno:TextField;
      
      public var txt_deleteyes:TextField;
      
      public var txt_eff:TextField;
      
      public var txt_funds:TextField;
      
      public var txt_glow:TextField;
      
      public var txt_gore:TextField;
      
      public var txt_music:TextField;
      
      public var txt_qual:TextField;
      
      public var txt_right:TextField;
      
      public var txt_shake:TextField;
      
      public var txt_slotDesc:TextField;
      
      public var txt_slotPrice:TextField;
      
      public var txt_sound:TextField;
      
      public var txt_voice:TextField;
      
      public var unequip:MovieClip;
      
      public var upgradebox:MovieClip;
      
      public var upgradedisplay:MovieClip;
      
      public var weap0:InfoBox;
      
      public var weap1:InfoBox;
      
      public var weap10:InfoBox;
      
      public var weap11:InfoBox;
      
      public var weap12:InfoBox;
      
      public var weap2:InfoBox;
      
      public var weap3:InfoBox;
      
      public var weap4:InfoBox;
      
      public var weap5:InfoBox;
      
      public var weap6:InfoBox;
      
      public var weap7:InfoBox;
      
      public var weap8:InfoBox;
      
      public var weap9:InfoBox;
      
      public var weapon:ItemBox;
      
      public var weaponbox:SimpleButton;
      
      public var workshop:InfoBox;
      
      public var __setPropDict:Dictionary;
      
      public var __lastFrameProp:int = -1;
      
      private var fc:uint = 0;
      
      private var main:Main;
      
      private var infoBoxes:Array;
      
      private var selItemCat:uint;
      
      private var tempAr:Array;
      
      private var tempOb:Object;
      
      private var tempMc:MovieClip;
      
      private var tempSt:String;
      
      private var tempPo:Point;
      
      private var tempNu:Number;
      
      private var tempGu:GunInfo;
      
      private var tempBo:Boolean;
      
      private var bgSpot:String;
      
      private var curInfo:String;
      
      private var curFrame:String;
      
      private var mainButtons:Array;
      
      private var unitInfo:UnitInfo;
      
      private var unitClass:Stats_Classes;
      
      private var heroContPage:Array;
      
      private var heroContPageNum:int = 0;
      
      public function Menu(_main:Main, _extra:Object)
      {
         this.__setPropDict = new Dictionary(true);
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11,15,this.frame16,20,this.frame21,25,this.frame26,30,this.frame31,35,this.frame36,40,this.frame41,50,this.frame51,54,this.frame55,59,this.frame60);
         this.main = _main;
         this.selItemCat = 0;
         Stats_Misc.buildModList();
         this.mainButtons = ["missions","heroes","inventory","store","workshop","options","medals","tips","credits"];
         SH.playMusic(M_Menu);
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("levelmax")) != -1)
         {
            AGI.submitQuest("lvl30");
         }
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("insane")) != -1)
         {
            AGI.submitQuest("sfh");
         }
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("upgrade")) != -1)
         {
            AGI.submitQuest("upgrade");
         }
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("sell")) != -1)
         {
            AGI.submitQuest("sell");
         }
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("enemies")) != -1)
         {
            AGI.submitQuest("enemies");
         }
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("sni")) != -1)
         {
            AGI.submitQuest("headshot");
         }
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("classes")) != -1)
         {
            AGI.submitQuest("classes");
         }
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("secret1")) != -1 && SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("secret2")) != -1 && SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("secret3")) != -1)
         {
            AGI.submitQuest("secret");
         }
         this.goto("missions");
         addEventListener(Event.FRAME_CONSTRUCTED,this.studyVacuousLunch,false,0,true);
      }
      
      public function Init(param1:int = 0) : void
      {
         var _loc2_:Number = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:ChallengeDot = null;
         var _loc7_:Stats_Missions = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:* = undefined;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:MovieClip = null;
         var _loc14_:Number = 0;
         var _loc15_:int = 0;
         var _loc16_:ItemBox = null;
         var _loc17_:MovieClip = null;
         var _loc18_:int = 0;
         var _loc19_:Object = null;
         var _loc20_:* = 0;
         this.infoBoxes = [];
         _loc2_ = 0;
         while(_loc2_ < numChildren)
         {
            if(getChildAt(_loc2_) is InfoBox)
            {
               this.infoBoxes.push(getChildAt(_loc2_));
            }
            _loc2_++;
         }
         this.curInfo = "";
         this.setFunds();
         this.txt_day.text = "" + UT.addNumCommas(SD.day);
         _loc2_ = 0;
         while(_loc2_ < this.mainButtons.length)
         {
            UT.resetMcColor(this["bt_" + this.mainButtons[_loc2_]]);
            _loc2_++;
         }
         if(this.curFrame == "heroesInv")
         {
            UT.setMcColor(this["bt_heroes"],16763904);
         }
         else if(this.curFrame == "workshopInv")
         {
            UT.setMcColor(this["bt_workshop"],16763904);
         }
         else if(this.curFrame == "deploy")
         {
            UT.setMcColor(this["bt_missions"],16763904);
         }
         else
         {
            UT.setMcColor(this["bt_" + this.curFrame],16763904);
         }
         this.tutorial.visible = false;
         if(SD.stages.length <= 3)
         {
            this.bt_missions.visible = false;
            this.bt_heroes.visible = false;
            this.bt_workshop.visible = false;
            this.bt_inventory.visible = false;
            this.bt_store.visible = false;
            this.bt_medals.visible = false;
            this.bt_tips.visible = false;
            this.bt_credits.visible = false;
         }
         if(SD.stages.length == 2)
         {
            this.bt_missions.visible = true;
            this.bt_heroes.visible = true;
         }
         if(SD.stages.length == 3)
         {
            this.bt_missions.visible = true;
            this.bt_heroes.visible = true;
            this.bt_workshop.visible = true;
         }
         this.unitInfo = SD.heroes[SD.selHero];
         this.unitClass = Stats_Classes.itemOb[this.unitInfo.cls];
         this.getitem.InitItem();
         if(this.curFrame.substring(0,8) != "workshop")
         {
            this.tempGu = null;
         }
         trace("[Frame]",this.curFrame);
         if(!param1)
         {
            SD.saveGame();
         }
         switch(this.curFrame)
         {
            case "missions":
               this.bgSpot = this.curFrame;
               _loc3_ = false;
               if(SD.mapItem.length)
               {
                  this.getitem.InitItem(SD.mapItem[0],"mapItem");
               }
               else
               {
                  if(SD.stages.length <= 3)
                  {
                     this.bt_custom.visible = false;
                     this.bt_daily.visible = false;
                     this.mc_daily.visible = false;
                     _loc3_ = true;
                     this.bt_akq.visible = false;
                     this.bt_akqhero.visible = false;
                  }
                  if(SD.stages.length == 1)
                  {
                     this.tutorial.gotoAndStop(1);
                     this.tutorial.visible = true;
                  }
                  if(SD.stages.length == 2 && SD.heroes.length == 1)
                  {
                     this.tutorial.gotoAndStop(2);
                     this.tutorial.visible = true;
                     this.bt_play.visible = false;
                  }
                  if(SD.stages.length == 3 && SD.bpBuilt.length == 11)
                  {
                     this.tutorial.gotoAndStop(4);
                     this.tutorial.visible = true;
                     this.bt_play.visible = false;
                  }
                  if(SD.autoShowAd)
                  {
                     SH.playSound(S_Powerup);
                     this.goto("appstore");
                     SD.autoShowAd = false;
                  }
               }
               if(SD.gotAkq)
               {
                  this.bt_akqhero.visible = false;
               }
               if(!param1)
               {
                  this.box_mission.x = 800;
               }
               if(AGI.enabled)
               {
                  this.txt_agi.visible = true;
                  if(AGI.isConnected())
                  {
                     this.txt_agi.text = "Logged in as " + AGI.getUsername() + "\nOnline Save Enabled";
                     this.txt_agi.textColor = 10092441;
                  }
                  else
                  {
                     this.txt_agi.text = "Offline Mode\nLog in to save Online";
                     this.txt_agi.textColor = 16737843;
                  }
               }
               else
               {
                  this.txt_agi.visible = false;
               }
               this.tempPo = new Point(0,0);
               this.tempAr = [];
               SplineMethod.setResolution(10);
               _loc2_ = 0;
               while(_loc2_ < this.cont.numChildren)
               {
                  if(this.cont.getChildAt(_loc2_) is MissionDot)
                  {
                     this.tempAr.push(this.cont.getChildAt(_loc2_));
                  }
                  _loc2_++;
               }
               if(!param1)
               {
                  this.cont.linecont.graphics.lineStyle(8,16777215,0.6);
                  this.cont.linecont.graphics.moveTo(this.tempAr[0].x,this.tempAr[0].y);
                  _loc2_ = 0;
                  while(_loc2_ < this.tempAr.length)
                  {
                     if(_loc2_ >= SD.stages.length - 1)
                     {
                        this.cont.linecont.graphics.lineStyle(6,16777215,0.4 - (_loc2_ - SD.stages.length) * 0.05);
                     }
                     if(_loc2_ < this.tempAr.length - 1 && !param1)
                     {
                        SplineMethod.drawSpline(this.cont.linecont.graphics,this.tempAr[_loc2_],this.tempAr[_loc2_ + 1],this.tempAr[_loc2_ - 1],this.tempAr[_loc2_ + 2]);
                     }
                     _loc2_++;
                  }
               }
               _loc2_ = 0;
               while(_loc2_ < this.cont.numChildren)
               {
                  if(this.cont.getChildAt(_loc2_) is ChallengeDot)
                  {
                     _loc6_ = ChallengeDot(this.cont.getChildAt(_loc2_));
                     this.tempAr.splice(parseInt(_loc6_.name.substring(1)) - 1,0,_loc6_);
                  }
                  _loc2_++;
               }
               _loc2_ = 0;
               while(_loc2_ < this.tempAr.length)
               {
                  if(_loc2_ < SD.stages.length)
                  {
                     this.tempAr[_loc2_].gotoAndStop(1);
                     this.tempAr[_loc2_].mc_beat.scaleX = this.tempAr[_loc2_].mc_beat.scaleY = 0.3;
                     this.tempAr[_loc2_].mc_beat.y = -7;
                     this.tempAr[_loc2_].mc_beat.alpha = 0.7;
                     if(SD.curStage == _loc2_ && MatchSettings.matchType == 0)
                     {
                        this.tempAr[_loc2_].gotoAndStop(2);
                        this.tempAr[_loc2_].mc_beat.alpha = 1;
                        this.tempPo = new Point(-this.tempAr[_loc2_].x + 275,0);
                        if(this.tempPo.x > 0)
                        {
                           this.tempPo.x = 1;
                        }
                        if(this.tempPo.x < -this.cont.sizebox.width + 800)
                        {
                           this.tempPo.x = -this.cont.sizebox.width + 800;
                        }
                     }
                     if(this.tempAr[_loc2_].mc_beat)
                     {
                        this.tempAr[_loc2_].mc_beat.gotoAndStop(SD.stages[_loc2_] + 1);
                        this.tempAr[_loc2_].mc_beat.mouseEnabled = false;
                     }
                     if(this.tempAr[_loc2_].name.charAt(0) == "_" && !param1)
                     {
                        this.cont.linecont.graphics.lineStyle(8,16750848,0.4);
                        this.cont.linecont.graphics.moveTo(this.tempAr[_loc2_].x,this.tempAr[_loc2_].y);
                        this.cont.linecont.graphics.lineTo(this.tempAr[_loc2_ - 1].x,this.tempAr[_loc2_ - 1].y);
                     }
                  }
                  else
                  {
                     this.tempAr[_loc2_].gotoAndStop(3);
                  }
                  if(_loc2_ == SD.stages.length - 1)
                  {
                     this.cont.fog.x = this.tempAr[_loc2_].x + 40;
                  }
                  if(_loc2_ >= SD.stages.length - 1)
                  {
                     this.tempAr[_loc2_].alpha = 1 - (_loc2_ - SD.stages.length) * 0.5;
                  }
                  _loc2_++;
               }
               this.cont.fog.width = this.cont.sizebox.width - this.cont.fog.x + 150;
               this.mc_daily.gotoAndStop(SD.checkDaily() ? 6 : 5);
               switch(MatchSettings.matchType)
               {
                  case 0:
                     _loc7_ = Stats_Missions.itemAr[SD.curStage];
                     this.box_mission.gotoAndStop(1);
                     if(_loc7_.challenge)
                     {
                        this.box_mission.txt_mission.text = _loc7_.challenge;
                        this.box_mission.txt_mission.textColor = 16737792;
                     }
                     else
                     {
                        this.box_mission.txt_mission.text = "Mission " + (_loc7_.num + 1);
                        this.box_mission.txt_mission.textColor = 16763904;
                     }
                     this.box_mission.txt_special.text = _loc7_.desc;
                     this.box_mission.txt_mode.text = Stats_Misc.getGameMode(_loc7_.mode).name;
                     this.box_mission.mc_mode.gotoAndStop(_loc7_.mode);
                     this.box_mission.txt_map.text = Stats_Maps.getMap(_loc7_.map).name;
                     this.box_mission.mc_map.gotoAndStop(_loc7_.map);
                     if(!Stats_Misc.getGameMode(_loc7_.mode).teams)
                     {
                        this.box_mission.txt_teams.text = "Free for all";
                     }
                     else
                     {
                        this.box_mission.txt_teams.text = _loc7_.team1 + " v " + _loc7_.team2;
                     }
                     this.box_mission.mc_beatshield.gotoAndStop(SD.stages[SD.curStage] + 1);
                     if(Stats_Misc.getLevelReq(SD.curStage,SD.curDiff) == 0)
                     {
                        this.box_mission.txt_level.text = "(Levels disabled)";
                     }
                     else
                     {
                        this.box_mission.txt_level.text = "" + (Stats_Misc.getLevelReq(SD.curStage,SD.curDiff) + (!!_loc7_.extra.raiseLvl ? _loc7_.extra.raiseLvl : 0));
                     }
                     this.box_mission.txt_diff.text = ["FUN","NORMAL","HARD","INSANE"][SD.curDiff];
                     this.box_mission.txt_diff.textColor = [6750105,16777215,16763904,13382400][SD.curDiff];
                     this.box_mission.mc_diffshield.gotoAndStop(SD.curDiff + 1);
                     if(SD.curDiff == 0)
                     {
                        this.box_mission.item.gotoAndStop("none");
                     }
                     else if(SD.stages[SD.curStage] >= SD.curDiff)
                     {
                        this.box_mission.item.gotoAndStop("random");
                     }
                     else
                     {
                        _loc10_ = Stats_Missions.itemAr[SD.curStage].rewards[SD.curDiff - 1];
                        if(_loc10_ is String && _loc10_.charAt(0) == "$")
                        {
                           this.box_mission.item.gotoAndStop("class3");
                           this.box_mission.item.classicon.gotoAndStop(_loc10_.substring(1));
                        }
                        else if(_loc10_ == "random2")
                        {
                           this.box_mission.item.gotoAndStop("random2");
                        }
                        else if(_loc10_ == "features")
                        {
                           this.box_mission.item.gotoAndStop("features");
                        }
                        else if(_loc10_ is Number)
                        {
                           this.box_mission.item.gotoAndStop("gold");
                        }
                        else if(Stats_Classes.itemOb[_loc10_])
                        {
                           this.box_mission.item.gotoAndStop("class2");
                           this.box_mission.item.classicon.gotoAndStop(_loc10_);
                        }
                        else if(_loc10_ is GunInfo)
                        {
                           this.box_mission.item.gotoAndStop("gun");
                           this.box_mission.item.gun.gotoAndStop(_loc10_.id);
                           if(_loc10_.rarity <= 3)
                           {
                              this.box_mission.item.gun.gotoAndStop(this.box_mission.item.gun.currentFrame + _loc10_.rarity);
                           }
                           Main.STAGE.invalidate();
                           this.box_mission.item.gun.x = -this.box_mission.item.gun.reg_menu.x * this.box_mission.item.gun.scaleX * this.box_mission.item.scaleX;
                           this.box_mission.item.gun.y = -this.box_mission.item.gun.reg_menu.y * this.box_mission.item.gun.scaleY * this.box_mission.item.scaleY;
                           if(this.box_mission.item.gun.clip)
                           {
                              this.box_mission.item.gun.clip.gotoAndStop(_loc10_.id);
                           }
                           if(this.box_mission.item.gun.part)
                           {
                              this.box_mission.item.gun.part.gotoAndStop(_loc10_.id);
                           }
                        }
                        else if(_loc10_ is String)
                        {
                           this.box_mission.item.gotoAndStop("blueprint");
                           this.box_mission.item.gun.gotoAndStop(_loc10_);
                           this.box_mission.item.txt_title.text = "BLUEPRINT " + Stats_Guns.itemOb[_loc10_].i;
                           Main.STAGE.invalidate();
                           this.box_mission.item.gun.x = -this.box_mission.item.gun.reg_menu.x * this.box_mission.item.gun.scaleX * this.box_mission.item.scaleX;
                           this.box_mission.item.gun.y = -this.box_mission.item.gun.reg_menu.y * this.box_mission.item.gun.scaleY * this.box_mission.item.scaleY;
                           if(this.box_mission.item.gun.clip)
                           {
                              this.box_mission.item.gun.clip.gotoAndStop(_loc10_);
                           }
                           if(this.box_mission.item.gun.part)
                           {
                              this.box_mission.item.gun.part.gotoAndStop(_loc10_);
                           }
                        }
                     }
                     this.box_mission.bt_prev.visible = true;
                     this.box_mission.bt_next.visible = true;
                     this.box_mission.txt_diff.visible = true;
                     this.box_mission.mc_diffshield.visible = true;
                     this.box_mission.txt_difftext.text = "DIFFICULTY";
                     this.box_mission.txt_difftext.textColor = 16777215;
                     break;
                  case 2:
                     this.box_mission.gotoAndStop(1);
                     this.box_mission.bt_prev.visible = false;
                     this.box_mission.bt_next.visible = false;
                     this.box_mission.txt_diff.visible = false;
                     this.box_mission.mc_diffshield.visible = false;
                     this.box_mission.txt_difftext.text = SD.checkDaily() ? "Already completed." : "+10x Better reward chance!";
                     this.box_mission.txt_difftext.textColor = SD.checkDaily() ? 13421772 : 16763904;
                     this.box_mission.mc_beatshield.gotoAndStop(SD.checkDaily() ? 6 : 5);
                     _loc7_ = Stats_Missions.daily;
                     this.box_mission.txt_mission.text = "Daily Mission";
                     this.box_mission.txt_mission.textColor = 16763904;
                     this.box_mission.txt_special.text = _loc7_.desc;
                     this.box_mission.txt_mode.text = Stats_Misc.getGameMode(_loc7_.mode).name;
                     this.box_mission.txt_map.text = Stats_Maps.getMap(_loc7_.map).name;
                     this.box_mission.mc_map.gotoAndStop(_loc7_.map);
                     this.box_mission.mc_mode.gotoAndStop(_loc7_.mode);
                     if(_loc7_.team1 == 1)
                     {
                        this.box_mission.txt_teams.text = "1 Hero";
                     }
                     else
                     {
                        this.box_mission.txt_teams.text = _loc7_.team1 + " v " + _loc7_.team2;
                     }
                     this.box_mission.txt_level.text = SD.getHighestLevel();
                     this.box_mission.item.gotoAndStop(SD.checkDaily() ? "none" : "random2");
                     break;
                  case 1:
                     this.box_mission.gotoAndStop(MatchSettings.qmAiBots ? 2 : 3);
                     _loc8_ = Stats_Misc.getGameMode(MatchSettings.qmMode);
                     this.box_mission.txt_mode.text = _loc8_.name;
                     this.box_mission.mc_mode.gotoAndStop(MatchSettings.qmMode);
                     this.box_mission.txt_map.text = Stats_Maps.getMap(MatchSettings.qmMap).name;
                     this.box_mission.mc_map.gotoAndStop(MatchSettings.qmMap);
                     this.box_mission.txt_modedesc.text = _loc8_.desc;
                     this.box_mission.txt_scorename.text = _loc8_.scoretype;
                     this.box_mission.txt_score.text = MatchSettings.qmScore + "";
                     _loc9_ = Stats_Misc.getMod(MatchSettings.qmMod);
                     this.box_mission.txt_mod.text = _loc9_.name;
                     this.box_mission.txt_moddesc.text = _loc9_.desc;
                     if(_loc9_.expmod != 1)
                     {
                        if(_loc9_.expmod == 0.7)
                        {
                           this.box_mission.txt_modexp.text = "-30% EXP";
                        }
                        else
                        {
                           this.box_mission.txt_modexp.text = "-" + (1 - _loc9_.expmod) * 100 + "% EXP";
                        }
                     }
                     else
                     {
                        this.box_mission.txt_modexp.text = "";
                     }
                     if(MatchSettings.qmAiBots)
                     {
                        this.box_mission.txt_enemy.text = MatchSettings.qmEnemies + "";
                        this.box_mission.txt_diff.text = ["Very Easy","Easy","Medium","Hard","Very Hard","Insane"][MatchSettings.qmDiff - 1];
                        MatchSettings.qmLevel = UT.getLinearRange(MatchSettings.qmDiff,6,1,Stats_Misc.maxLvl);
                        _loc11_ = MatchSettings.qmLevel + 1;
                        _loc12_ = MatchSettings.qmLevel - 1;
                        if(_loc11_ > Stats_Misc.maxLvl + 1)
                        {
                           _loc11_ = Stats_Misc.maxLvl + 1;
                        }
                        if(_loc12_ < 1)
                        {
                           _loc12_ = 1;
                        }
                        this.box_mission.txt_level.text = _loc12_ + " - " + _loc11_;
                     }
                     else if(this.tempBo)
                     {
                        this.tempBo = false;
                        this.box_mission.txt_codedesc.text = "ERROR: This squad code is invalid. Make sure it was copied correctly and not modified.[Patched Squad Code Reader]";
                        this.box_mission.txt_codedesc.textColor = 16724787;
                     }
                     else
                     {
                        this.box_mission.txt_codedesc.text = "Copy and paste a friend’s squad code below to play against their team. Find your code on the Select Squad screen.";
                        this.box_mission.txt_codedesc.textColor = 10066329;
                     }
                     this.box_mission.bt_prev.visible = true;
                     this.box_mission.bt_next.visible = true;
               }
               if(_loc3_)
               {
                  this.box_mission.bt_prev.visible = false;
                  this.box_mission.bt_next.visible = false;
               }
               break;
            case "heroes":
               this.heroCont.bt_prev.visible = SD.heroes.length > 14 ? true : false;
               this.heroCont.bt_next.visible = SD.heroes.length > 14 ? true : false;
               if(SD.heroes.length >= 15)
               {
                  AGI.submitQuest("team");
               }
               this.bgSpot = this.curFrame;
               if(!param1)
               {
                  this.tempOb = {};
                  this.tempOb.health = 0;
                  this.tempOb.crit = 0;
                  this.tempOb.aim = 0;
                  this.tempOb.mobile = 0;
                  this.tempOb.aggro = 0;
               }
               trace(1);
               if(!param1)
               {
                  this.box_left.x = -235;
               }
               if(!param1)
               {
                  this.box_right.x = 1050;
               }
               if(SD.stages.length == 2 && SD.heroes.length == 1)
               {
                  this.tutorial.gotoAndStop(3);
                  this.tutorial.visible = true;
               }
               if(SD.stages.length == 3 && SD.bpBuilt.length == 11)
               {
                  this.tutorial.gotoAndStop(4);
                  this.tutorial.visible = true;
               }
               trace(2);
               this.box_left.txt_name.text = this.unitInfo.name;
               this.box_left.txt_name.restrict = "A-Z a-z 0-9";
               this.box_left.txt_level.text = "Lv " + this.unitInfo.level;
               this.box_left.txt_class.text = this.unitClass.name;
               this.box_left.mc_class.gotoAndStop(this.unitClass.id);
               this.box_left.bar.width = this.unitInfo.exp / Stats_Classes.getNextExp(this.unitInfo.level) * 215;
               _loc2_ = 1;
               while(_loc2_ <= 6)
               {
                  this.box_left["col" + _loc2_].gotoAndStop(_loc2_);
                  this.box_left["col" + _loc2_].alpha = 0.5;
                  this.box_left["col" + _loc2_].bt.visible = true;
                  _loc2_++;
               }
               this.box_left["col" + this.unitInfo.color].alpha = 1;
               this.box_left["col" + this.unitInfo.color].bt.visible = false;
               trace(3);
               var loc21:* = 3.15 * this.unitClass.size;
               this.char.scaleY = 3.15 * this.unitClass.size;
               this.char.scaleX = loc21;
               this.mc_status.visible = this.unitInfo.status <= 300;
               Stats_Classes.setActiveStatus(this.mc_status.txt_status,this.unitInfo,null,this.char);
               _loc4_ = SD.justHired;
               if(param1 != 2)
               {
                  this.heroContPageNum = SD.selHero > 14 ? (SD.selHero > 29 ? 2 : 1) : 0;
               }
               this.heroContPage = [0];
               if(SD.heroes.length > 14)
               {
                  this.heroContPage.push(1);
                  if(SD.heroes.length > 29)
                  {
                     this.heroContPage.push(2);
                  }
               }
               this.heroCont.gotoAndStop(1);
               _loc2_ = 0;
               while(_loc2_ < 15)
               {
                  _loc13_ = this.heroCont["hero_" + (_loc2_ + 1)];
                  _loc13_.gotoAndStop(1);
                  _loc13_.selected.visible = false;
                  _loc13_.bt.visible = true;
                  _loc13_.visible = true;
                  if(_loc2_ + 15 * this.heroContPage[this.heroContPageNum] < SD.heroes.length)
                  {
                     Stats_Classes.setSkin(_loc13_,SD.heroes[_loc2_ + 15 * this.heroContPage[this.heroContPageNum]],true);
                     _loc13_.mc_class.gotoAndStop(SD.heroes[_loc2_ + 15 * this.heroContPage[this.heroContPageNum]].cls);
                     _loc13_.newskill.visible = SD.heroes[_loc2_ + 15 * this.heroContPage[this.heroContPageNum]].hasUpgrade >= 0 || SD.heroes[_loc2_ + 15 * this.heroContPage[this.heroContPageNum]].hasLevel;
                     _loc13_.gotoAndStop(Math.ceil(SD.heroes[_loc2_ + 15 * this.heroContPage[this.heroContPageNum]].status / 100));
                  }
                  else if(_loc2_ + 15 * this.heroContPage[this.heroContPageNum] < 45 && !_loc4_)
                  {
                     _loc4_ = true;
                     _loc13_.gotoAndStop(5);
                  }
                  else
                  {
                     _loc13_.visible = false;
                  }
                  _loc2_++;
               }
               this.heroCont["hero_" + (SD.selHero + 1 - 15 * this.heroContPage[this.heroContPageNum])].selected.visible = true;
               this.heroCont["hero_" + (SD.selHero + 1 - 15 * this.heroContPage[this.heroContPageNum])].bt.visible = false;
               trace(4);
               Stats_Classes.setSkin(this.char,this.unitInfo);
               this.box_right.primary.InitGun(this.unitInfo.primary,true);
               this.box_right.secondary.InitGun(this.unitInfo.secondary,true);
               this.box_right.primarybox.buttonMode = true;
               this.box_right.secondarybox.buttonMode = true;
               this.box_right.gun.InitPerk(this.unitInfo.weaponMod,true);
               this.box_right.gunbox.buttonMode = true;
               this.box_right.armor.armorPerk = true;
               this.box_right.armor.InitPerk(this.unitInfo.armorMod,true,-40);
               this.box_right.armorbox.buttonMode = true;
               trace(5);
               this.tempAr = ["trait","flaw","streak","perk00","perk01","perk10","perk11","perk20","perk21"];
               this.box_left.trait.InitPerk(this.unitInfo.trait,true,50,0.9);
               this.box_left.flaw.InitPerk(this.unitInfo.flaw,true,-1,0.9);
               this.box_left.streak.InitPerk(this.unitInfo.streak,true,-1,0.9);
               this.box_left.perk00.InitPerk(this.unitInfo.level < 5 ? "lock0" : this.unitInfo.perks[0][0],true,50,0.9);
               this.box_left.perk01.InitPerk(this.unitInfo.level < 5 ? "lock0" : this.unitInfo.perks[0][1],true,50,0.9);
               this.box_left.perk10.InitPerk(this.unitInfo.level < 10 ? "lock1" : this.unitInfo.perks[1][0],true,-1,0.9);
               this.box_left.perk11.InitPerk(this.unitInfo.level < 10 ? "lock1" : this.unitInfo.perks[1][1],true,-1,0.9);
               this.box_left.perk20.InitPerk(this.unitInfo.level < 15 ? "lock2" : this.unitInfo.perks[2][0],true,-1,0.9);
               this.box_left.perk21.InitPerk(this.unitInfo.level < 15 ? "lock2" : this.unitInfo.perks[2][1],true,-1,0.9);
               trace(6);
               _loc2_ = 0;
               while(_loc2_ < 3)
               {
                  _loc14_ = 0;
                  while(_loc14_ < 2)
                  {
                     this.box_left["perk" + _loc2_ + _loc14_].sel.visible = false;
                     this.box_left["perk" + _loc2_ + _loc14_ + "box"].buttonMode = this.unitInfo.level >= (_loc2_ + 1) * 5;
                     _loc14_++;
                  }
                  if(this.unitInfo.perks[_loc2_][2] > 0)
                  {
                     this.box_left["perk" + _loc2_ + (this.unitInfo.perks[_loc2_][2] - 1)].sel.visible = true;
                     this.box_left["perk" + _loc2_ + (this.unitInfo.perks[_loc2_][2] - 1) + "box"].buttonMode = false;
                  }
                  _loc2_++;
               }
               trace(7);
               this.box_left.txt_newskill.visible = this.unitInfo.hasUpgrade >= 0;
               this.box_left.newskill.visible = this.unitInfo.hasUpgrade >= 0;
               this.box_right.bt_dismiss.visible = SD.heroes.length > 1;
               if(SD.stages.length <= 3)
               {
                  this.box_right.bt_dismiss.visible = false;
               }
               break;
            case "deploy":
               if(SD.stages.length <= 3)
               {
                  this.mc_squadcode.visible = false;
                  this.mc_Psquadcode.visible = false;
               }
               if(SD.stages.length == 2 && (SD.squad.length < 2 || SD.squad[1] == -1) && SD.curStage == 1)
               {
                  this.tutorial.gotoAndStop(6);
                  this.tutorial.visible = true;
               }
               this.heroContPage = [0];
               if(SD.heroes.length > 14)
               {
                  this.heroContPage.push(1);
                  if(SD.heroes.length > 29)
                  {
                     this.heroContPage.push(2);
                  }
               }
               _loc2_ = 0;
               while(_loc2_ < SD.squad.length)
               {
                  if(SD.squad[_loc2_] >= SD.heroes.length)
                  {
                     SD.squad[_loc2_] = -1;
                  }
                  _loc2_++;
               }
               switch(MatchSettings.matchType)
               {
                  case 0:
                     _loc7_ = Stats_Missions.itemAr[SD.curStage];
                     while(SD.squad.length > _loc7_.team1)
                     {
                        SD.squad.pop();
                     }
                     while(SD.squad.length < _loc7_.team1)
                     {
                        SD.squad.push(-1);
                     }
                     break;
                  case 1:
                     while(!MatchSettings.qmTeams && SD.squad.length > 1)
                     {
                        SD.squad.pop();
                     }
                     while(MatchSettings.qmTeams && SD.squad.length < 5)
                     {
                        SD.squad.push(-1);
                     }
                     break;
                  case 2:
                     while(!Stats_Misc.getGameMode(Stats_Missions.daily.mode).teams && SD.squad.length > 1)
                     {
                        SD.squad.pop();
                     }
                     while(Stats_Misc.getGameMode(Stats_Missions.daily.mode).teams && SD.squad.length < 5)
                     {
                        SD.squad.push(-1);
                     }
                     break;
                  default:
                     break;
               }
               this.mc_Psquadcode.PSC.filters = [new GlowFilter(0,1,5,5,5)];
               SD.createSquadCode();
               SD.createPSquadCode();
               this.mc_squadcode.txt_code.text = SD.squadCode;
               this.mc_Psquadcode.Ptxt_code.text = SD.PsquadCode;
               this.bgSpot = this.curFrame;
               if(!param1)
               {
                  this.tempPo = new Point(-1,-1);
               }
               this.heroCont.gotoAndStop(2);
               _loc2_ = 0;
               while(_loc2_ < 15)
               {
                  _loc13_ = this.heroCont["hero_" + (_loc2_ + 1)];
                  _loc13_.gotoAndStop(1);
                  _loc13_.selected.visible = false;
                  _loc13_.bt.visible = true;
                  _loc13_.alpha = 1;
                  _loc13_.visible = true;
                  if(SD.squad.indexOf(_loc2_) != -1)
                  {
                     _loc13_.alpha = 0.3;
                     _loc13_.bt.visible = false;
                  }
                  if(_loc2_ + 15 * this.heroContPage[this.heroContPageNum] < SD.heroes.length)
                  {
                     Stats_Classes.setSkin(_loc13_,SD.heroes[_loc2_ + 15 * this.heroContPage[this.heroContPageNum]],true);
                     _loc13_.mc_class.gotoAndStop(SD.heroes[_loc2_ + 15 * this.heroContPage[this.heroContPageNum]].cls);
                     _loc13_.newskill.visible = SD.heroes[_loc2_ + 15 * this.heroContPage[this.heroContPageNum]].hasUpgrade >= 0 || SD.heroes[_loc2_ + 15 * this.heroContPage[this.heroContPageNum]].hasLevel;
                     _loc13_.gotoAndStop(Math.ceil(SD.heroes[_loc2_ + 15 * this.heroContPage[this.heroContPageNum]].status / 100));
                  }
                  else
                  {
                     _loc13_.visible = false;
                  }
                  _loc2_++;
               }
               if(this.tempPo.x != -1 && SD.squad[this.tempPo.x] != -1)
               {
                  this.heroCont["hero_" + (SD.squad[this.tempPo.x] + 1)].selected.visible = true;
                  this.heroCont["hero_" + (SD.squad[this.tempPo.x] + 1)].alpha = 1;
                  this.heroCont["hero_" + (SD.squad[this.tempPo.x] + 1)].bt.visible = false;
               }
               _loc2_ = 0;
               while(_loc2_ < 5)
               {
                  if(_loc2_ > SD.squad.length - 1)
                  {
                     this["info" + _loc2_].visible = false;
                     this["char" + _loc2_].visible = false;
                  }
                  else
                  {
                     this["info" + _loc2_].visible = true;
                     this["char" + _loc2_].visible = true;
                     UT.resetMcColor(this["char" + _loc2_]);
                     this["info" + _loc2_].alpha = 1;
                     this["char" + _loc2_].blendMode = "normal";
                     this["char" + _loc2_].filters = [];
                     if(this.tempPo.x != -1 && _loc2_ != this.tempPo.x)
                     {
                        this["info" + _loc2_].alpha = 0.5;
                        UT.setMcTransform(this["char" + _loc2_],0.5,0.5,0.5);
                     }
                     if(SD.squad[_loc2_] == -1 && (this.tempPo.x != _loc2_ || this.tempPo.y == -1))
                     {
                        this["char" + _loc2_].visible = false;
                        this["info" + _loc2_].gotoAndStop(_loc2_ == 0 ? "captain" : "hero");
                     }
                     else
                     {
                        _loc15_ = int(SD.squad[_loc2_]);
                        if(this.tempPo.x == _loc2_ && this.tempPo.y != -1)
                        {
                           _loc15_ = this.tempPo.y;
                           UT.setMcTransform(this["char" + _loc2_],1,1,3,0.7);
                           this["char" + _loc2_].blendMode = "layer";
                           this["char" + _loc2_].filters = [new GlowFilter(39372,1,10,10,2,1),new GlowFilter(39372,1,15,15,1,1,true)];
                        }
                        if(!param1)
                        {
                           this["char" + _loc2_].gotoAndPlay(UT.irand(1,25));
                        }
                        this["info" + _loc2_].gotoAndStop(_loc2_ == this.tempPo.x ? "select" : "idle");
                        this["info" + _loc2_].txt_name.text = SD.heroes[_loc15_].name;
                        if(SD.heroes[_loc15_].primary)
                        {
                           this["info" + _loc2_].txt_primary.text = SD.heroes[_loc15_].primary.name;
                           this["info" + _loc2_].mc_primary.gotoAndStop("gun" + SD.heroes[_loc15_].primary.stats.type);
                           this["info" + _loc2_].mc_primary.visible = true;
                        }
                        else
                        {
                           this["info" + _loc2_].txt_primary.text = "Default";
                           this["info" + _loc2_].mc_primary.visible = false;
                        }
                        if(SD.heroes[_loc15_].secondary)
                        {
                           this["info" + _loc2_].txt_secondary.text = SD.heroes[_loc15_].secondary.name;
                           this["info" + _loc2_].mc_secondary.gotoAndStop("gun" + SD.heroes[_loc15_].secondary.stats.type);
                           this["info" + _loc2_].mc_secondary.visible = true;
                        }
                        else
                        {
                           this["info" + _loc2_].txt_secondary.text = "Default";
                           this["info" + _loc2_].mc_secondary.visible = false;
                        }
                        this["info" + _loc2_].txt_lvl.text = "Lv " + SD.heroes[_loc15_].level;
                        if(_loc2_ == 0)
                        {
                           this["info" + _loc2_].txt_bonus.text = "Captain: +15% Stats";
                        }
                        else
                        {
                           this["info" + _loc2_].txt_bonus.text = "";
                        }
                        this["info" + _loc2_].bar.width = SD.heroes[_loc15_].exp / Stats_Classes.getNextExp(SD.heroes[_loc15_].level) * 130.45;
                        Stats_Classes.setActiveStatus(this["info" + _loc2_].txt_status,SD.heroes[_loc15_],this["info" + _loc2_].txt_bonus,this["char" + _loc2_]);
                        Stats_Classes.setSkin(this["char" + _loc2_],SD.heroes[_loc15_]);
                     }
                  }
                  _loc2_++;
               }
               break;
            case "heroesInv":
               if(!param1)
               {
                  this.cont.x = 805;
               }
               this.bgSpot = "heroes";
               _loc2_ = 0;
               while(_loc2_ < 13)
               {
                  this["inv" + _loc2_].mc_icon.gotoAndStop("gun" + _loc2_);
                  this["inv" + _loc2_].txt_type.text = Stats_Guns.getGunType(_loc2_) + (_loc2_ != 12 ? "s" : "");
                  this["inv" + _loc2_].txt_type.mouseEnabled = false;
                  this["inv" + _loc2_].gotoAndStop(_loc2_ == this.selItemCat ? 2 : 1);
                  this["inv" + _loc2_].bt.visible = this.selItemCat != _loc2_;
                  if(this.selItemCat <= 10 && this.unitClass[this.tempSt].indexOf(_loc2_) == -1 || this.selItemCat >= 11 && this.selItemCat != _loc2_)
                  {
                     this["inv" + _loc2_].bt.visible = false;
                     this["inv" + _loc2_].alpha = 0.1;
                  }
                  _loc2_++;
               }
               this.unequip.mc_icon.gotoAndStop("gun13");
               this.unequip.txt_type.text = "Unequip";
               this.unequip.txt_type.mouseEnabled = false;
               this.unequip.gotoAndStop(1);
               if(SD.items[this.selItemCat].length >= 24)
               {
                  this.unequip.txt_type.text = "Inventory Full";
                  this.unequip.txt_type.textColor = 16750848;
                  this.unequip.bt.visible = false;
                  this.unequip.alpha = 0.7;
               }
               _loc2_ = 0;
               while(_loc2_ < 24)
               {
                  _loc16_ = this.cont["item" + _loc2_];
                  _loc17_ = this.cont["hitbox" + _loc2_];
                  _loc16_.x = _loc17_.x;
                  _loc16_.y = _loc17_.y;
                  _loc17_.buttonMode = true;
                  if(_loc2_ < SD.items[this.selItemCat].length)
                  {
                     _loc16_.armorPerk = true;
                     _loc16_.Init(SD.items[this.selItemCat][_loc2_],false,_loc2_,-1,SD.heroes[SD.selHero].level);
                     _loc16_.visible = true;
                     _loc17_.visible = true;
                  }
                  else
                  {
                     _loc16_.Init(null);
                     _loc16_.visible = false;
                     _loc17_.visible = false;
                  }
                  _loc2_++;
               }
               break;
            case "workshopInv":
               if(!param1)
               {
                  this.cont.x = 805;
               }
               this.bgSpot = "workshop";
               if(this.selItemCat > 10)
               {
                  this.selItemCat = 0;
               }
               _loc2_ = 0;
               while(_loc2_ < 13)
               {
                  this["inv" + _loc2_].mc_icon.gotoAndStop("gun" + _loc2_);
                  this["inv" + _loc2_].txt_type.text = Stats_Guns.getGunType(_loc2_) + (_loc2_ != 12 ? "s" : "");
                  this["inv" + _loc2_].txt_type.mouseEnabled = false;
                  this["inv" + _loc2_].gotoAndStop(_loc2_ == this.selItemCat ? 2 : 1);
                  this["inv" + _loc2_].bt.visible = _loc2_ != this.selItemCat;
                  this["inv" + _loc2_].alpha = 1;
                  if(_loc2_ > 10)
                  {
                     this["inv" + _loc2_].bt.visible = false;
                     this["inv" + _loc2_].alpha = 0.1;
                  }
                  _loc2_++;
               }
               _loc2_ = 0;
               while(_loc2_ < 24)
               {
                  _loc16_ = this.cont["item" + _loc2_];
                  _loc17_ = this.cont["hitbox" + _loc2_];
                  _loc16_.x = _loc17_.x;
                  _loc16_.y = _loc17_.y;
                  _loc17_.buttonMode = true;
                  if(_loc2_ < SD.items[this.selItemCat].length)
                  {
                     _loc16_.Init(SD.items[this.selItemCat][_loc2_],false,_loc2_);
                     _loc16_.visible = true;
                     _loc17_.visible = true;
                  }
                  else
                  {
                     _loc16_.Init(null);
                     _loc16_.visible = false;
                     _loc17_.visible = false;
                  }
                  _loc2_++;
               }
               break;
            case "inventory":
               if(!param1)
               {
                  this.cont.x = 805;
               }
               this.bgSpot = this.curFrame;
               this.tempSt = "";
               _loc2_ = 0;
               while(_loc2_ < 13)
               {
                  this["inv" + _loc2_].mc_icon.gotoAndStop("gun" + _loc2_);
                  this["inv" + _loc2_].txt_type.text = Stats_Guns.getGunType(_loc2_) + (_loc2_ != 12 ? "s" : "");
                  this["inv" + _loc2_].txt_type.mouseEnabled = false;
                  this["inv" + _loc2_].gotoAndStop(_loc2_ == this.selItemCat ? 2 : 1);
                  this["inv" + _loc2_].bt.visible = _loc2_ != this.selItemCat;
                  this["inv" + _loc2_].alpha = 1;
                  _loc2_++;
               }
               _loc2_ = 0;
               while(_loc2_ < 24)
               {
                  _loc16_ = this.cont["item" + _loc2_];
                  _loc17_ = this.cont["hitbox" + _loc2_];
                  _loc16_.x = _loc17_.x;
                  _loc16_.y = _loc17_.y;
                  _loc17_.buttonMode = true;
                  if(_loc2_ < SD.items[this.selItemCat].length)
                  {
                     _loc16_.armorPerk = true;
                     _loc16_.Init(SD.items[this.selItemCat][_loc2_],false,_loc2_);
                     _loc16_.visible = true;
                     _loc17_.visible = true;
                  }
                  else
                  {
                     _loc16_.visible = false;
                     _loc17_.visible = false;
                  }
                  _loc2_++;
               }
               break;
            case "store":
               if(!param1)
               {
                  this.cont.x = 805;
               }
               this.bgSpot = this.curFrame;
               if(SD.storeItem)
               {
                  this.getitem.InitItem(SD.storeItem,"storeItem");
               }
               this.slotmachine.setText();
               _loc2_ = 0;
               while(_loc2_ < 12)
               {
                  _loc16_ = this.cont["item" + _loc2_];
                  _loc17_ = this.cont["hitbox" + _loc2_];
                  _loc16_.x = _loc17_.x;
                  _loc16_.y = _loc17_.y;
                  _loc17_.buttonMode = true;
                  if(_loc2_ < SD.storeItems.length)
                  {
                     _loc16_.armorPerk = true;
                     _loc16_.Init(SD.storeItems[_loc2_],false,_loc2_ * 2 - (_loc2_ % 2 == 0 ? 0 : -1));
                     _loc16_.setStorePrice();
                     _loc16_.visible = true;
                     _loc17_.visible = true;
                  }
                  else
                  {
                     _loc16_.visible = false;
                     _loc17_.visible = false;
                  }
                  _loc2_++;
               }
               break;
            case "workshop":
               if(!param1)
               {
                  this.scrollpane.x = 805;
                  SD.bpOwned.sort(Array.NUMERIC);
                  SD.bpBuilt.sort(Array.NUMERIC);
                  SD.bpOther = [];
                  _loc2_ = 0;
                  while(_loc2_ < Stats_Guns.itemAr.length)
                  {
                     if(SD.bpOwned.indexOf(_loc2_) == -1)
                     {
                        if(SD.bpBuilt.indexOf(_loc2_) == -1)
                        {
                           SD.bpOther.push(_loc2_);
                        }
                     }
                     _loc2_++;
                  }
               }
               this.bgSpot = this.curFrame;
               if(SD.stages.length == 3 && SD.bpBuilt.length == 11)
               {
                  this.tutorial.gotoAndStop(5);
                  this.tutorial.visible = true;
               }
               this.weapon.InitGun(this.tempGu,true);
               this.weapon.keepOpen();
               if(!this.tempGu)
               {
                  this.upgradebox.gotoAndStop(2);
                  this.weapon.visible = false;
               }
               else
               {
                  _loc18_ = Stats_Guns.getUpgradeCost(this.tempGu);
                  this.weapon.visible = true;
                  if(this.tempGu.upgradeAmt == 5)
                  {
                     this.upgradebox.gotoAndStop(3);
                  }
                  else if(SD.funds < _loc18_)
                  {
                     this.upgradebox.gotoAndStop(1);
                     this.upgradebox.mc_stars.gotoAndStop(this.tempGu.upgradeAmt + 1);
                     this.upgradebox.mc_stars.mouseEnabled = false;
                     this.upgradebox.txt_updesc.text = "Low Funds";
                     this.upgradebox.txt_updesc.textColor = 16724736;
                     this.upgradebox.txt_updesc.mouseEnabled = false;
                     this.upgradebox.txt_cost.text = "$" + _loc18_;
                     this.upgradebox.txt_cost.mouseEnabled = false;
                     this.upgradebox.bt.visible = false;
                  }
                  else
                  {
                     this.upgradebox.gotoAndStop(1);
                     this.upgradebox.mc_stars.gotoAndStop(this.tempGu.upgradeAmt + 1);
                     this.upgradebox.mc_stars.mouseEnabled = false;
                     this.upgradebox.txt_updesc.text = Stats_Guns.getUpgradeChance(this.tempGu.upgradeAmt) * 100 + "% odds";
                     this.upgradebox.txt_updesc.textColor = 16763904;
                     this.upgradebox.txt_updesc.mouseEnabled = false;
                     this.upgradebox.txt_cost.text = "$" + _loc18_;
                     this.upgradebox.txt_cost.mouseEnabled = false;
                     this.upgradebox.bt.visible = true;
                  }
               }
               if(SD.stages.length <= 3)
               {
                  this.weaponbox.visible = false;
                  this.upgradebox.gotoAndStop(4);
               }
               if(SD.workshopItem)
               {
                  this.getitem.InitItem(SD.workshopItem,"workshopItem");
               }
               this.scrollpane.source = new Sprite();
               _loc5_ = 0;
               _loc2_ = 0;
               while(_loc2_ < SD.bpOwned.length)
               {
                  this.scrollpane.source.addChild(this.rhymeMereDesire(SD.bpOwned[_loc2_],1,_loc5_));
                  _loc2_++;
                  _loc5_++;
               }
               _loc2_ = 0;
               while(_loc2_ < SD.bpBuilt.length)
               {
                  this.scrollpane.source.addChild(this.rhymeMereDesire(SD.bpBuilt[_loc2_],2,_loc5_));
                  _loc2_++;
                  _loc5_++;
               }
               _loc2_ = 0;
               while(_loc2_ < SD.bpOther.length)
               {
                  this.scrollpane.source.addChild(this.rhymeMereDesire(SD.bpOther[_loc2_],0,_loc5_));
                  _loc2_++;
                  _loc5_++;
               }
               this.scrollpane.update();
               break;
            case "options":
               if(SD.stages.length <= 1)
               {
                  gotoAndStop("optionsTut");
               }
               this.tempAr = ["qual","eff","glow","music","sound","voice","shake","bloody","gore","right"];
               this.txt_qual.text = ["Low","Medium","High"][SD.graphQual];
               this.txt_eff.text = ["Low","Medium","High"][SD.graphPart];
               this.txt_glow.text = SD.graphLights ? "On" : "Off";
               this.txt_music.text = SD.music ? "On" : "Off";
               this.txt_sound.text = SD.sound ? "On" : "Off";
               this.txt_voice.text = SD.voices ? "On" : "Off";
               this.txt_shake.text = SD.screenShake ? "On" : "Off";
               this.txt_bloody.text = SD.screenBlood ? "On" : "Off";
               this.txt_gore.text = ["Low","Medium","High"][SD.blood];
               this.txt_right.text = ["Reload","Killstreak","Swap Gun"][SD.rightclick];
               this.txt_deleteyes.visible = this.txt_deleteno.visible = false;
               this.bt_deleteyes.visible = this.bt_deleteno.visible = false;
               this.txt_delete.visible = true;
               this.bt_delete.visible = true;
               break;
            case "medals":
               _loc2_ = 0;
               while(_loc2_ < Stats_Achievements.achOrder.length)
               {
                  _loc19_ = Stats_Achievements.getAchievementNum(_loc2_);
                  this["ach" + _loc2_].icon.gotoAndStop(_loc19_.sprite);
                  this["ach" + _loc2_].txt_name.text = _loc19_.name;
                  this["ach" + _loc2_].txt_desc.text = _loc19_.desc;
                  if(Stats_Achievements.getAchievementNum(_loc2_).unlock)
                  {
                     this["ach" + _loc2_].txt_unlock.text = "Unlocks " + _loc19_.unlock + " mod";
                  }
                  else
                  {
                     this["ach" + _loc2_].txt_unlock.text = "";
                  }
                  if(SD.achievements.indexOf(_loc2_) != -1)
                  {
                     this["ach" + _loc2_].gotoAndStop(1);
                  }
                  else
                  {
                     this["ach" + _loc2_].gotoAndStop(2);
                     if(_loc19_.unlock)
                     {
                        this["ach" + _loc2_].txt_desc.text = "Secret Medal";
                     }
                  }
                  if(_loc19_.progress)
                  {
                     this["ach" + _loc2_].txt_unlock.text = UT.replaceString(_loc19_.progress,"@",UT.addNumCommas(SD.achOb[_loc19_.id]));
                     _loc20_ = SD.achOb[_loc19_.id] == undefined ? 0 : int(SD.achOb[_loc19_.id]);
                     this["ach" + _loc2_].mc_bar.width = Math.min(_loc20_ / _loc19_.max * 150,150);
                  }
                  else
                  {
                     this["ach" + _loc2_].mc_backbar.visible = false;
                     this["ach" + _loc2_].mc_bar.visible = false;
                  }
                  _loc2_++;
               }
               break;
            default:
               break;
         }
      }
      
      public function EnterFrame() : void
      {
         var _loc2_:Number = 0;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:ItemBox = null;
         var _loc6_:MovieClip = null;
         ++this.fc;
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < this.infoBoxes.length)
         {
            if(this.htRaw(this.infoBoxes[_loc2_]))
            {
               _loc3_ = Stats_Info.itemOb[this.infoBoxes[_loc2_].name];
               _loc1_ = true;
               if(this.hover.alpha < 1)
               {
                  this.hover.alpha += 0.1;
               }
               if(this.curInfo != this.infoBoxes[_loc2_].name)
               {
                  this.curInfo = this.infoBoxes[_loc2_].name;
                  this.hover.gotoAndStop(_loc3_.frame);
                  this.hover.x = this.infoBoxes[_loc2_].x + this.infoBoxes[_loc2_].width * _loc3_.x;
                  this.hover.y = this.infoBoxes[_loc2_].y + this.infoBoxes[_loc2_].height * _loc3_.y;
                  this.hover.txt_title.text = _loc3_.title;
                  this.hover.txt_desc.text = _loc3_.desc;
                  if(this.infoBoxes[_loc2_].name.charAt(0) == "$")
                  {
                     _loc4_ = String(this.infoBoxes[_loc2_].name.substring(1));
                     switch(_loc4_)
                     {
                        case "class":
                           this.hover.txt_title.text = Stats_Classes.itemOb[SD.heroes[SD.selHero].cls].name;
                           this.hover.txt_desc.text = Stats_Classes.itemOb[SD.heroes[SD.selHero].cls].desc;
                           break;
                        case "status":
                           _loc3_ = Stats_Info.itemOb[this.box_left.txt_status.text.toLowerCase()];
                           this.hover.txt_title.text = _loc3_.title;
                           this.hover.txt_desc.text = _loc3_.desc;
                     }
                  }
                  this.hover.mouseEnabled = false;
                  this.hover.box.mouseEnabled = false;
                  this.hover.txt_title.mouseEnabled = false;
                  this.hover.txt_desc.mouseEnabled = false;
                  this.hover.box.height = this.hover.txt_desc.numLines * 17 + 6;
               }
            }
            _loc2_++;
         }
         if(!_loc1_ && this.hover.alpha > -1.3)
         {
            this.hover.alpha -= 0.3;
         }
         this.bg.x += (-this.bg[this.bgSpot].x - this.bg.x) * 0.5;
         switch(this.curFrame)
         {
            case "missions":
               if(this.getitem.visible)
               {
                  return;
               }
               this.box_mission.x += (521 - this.box_mission.x) * 0.3;
               if(this.tempPo.y)
               {
                  this.tempPo.x += (mouseX - this.tempPo.y - this.tempPo.x) * 0.5;
               }
               if(this.tempPo.x > this.contbox.x)
               {
                  this.tempPo.x += (this.contbox.x - this.tempPo.x) * 0.7;
               }
               if(this.tempPo.x < this.contbox.x - (this.cont.sizebox.width - this.contbox.width))
               {
                  this.tempPo.x += (this.contbox.x - (this.cont.sizebox.width - this.contbox.width) - this.tempPo.x) * 0.7;
               }
               if(this.tempPo.x)
               {
                  this.cont.x += (this.tempPo.x - this.cont.x) * 0.3;
               }
               this.scrollbox.x = this.contbox.x + this.cont.x / (this.contbox.x - (this.cont.sizebox.width - this.contbox.width)) * (this.contbox.width - this.scrollbox.width);
               if(this.scrollbox.x < this.contbox.x)
               {
                  this.scrollbox.x = this.contbox.x;
               }
               if(this.scrollbox.x > this.contbox.x + this.contbox.width - this.scrollbox.width)
               {
                  this.scrollbox.x = this.contbox.x + this.contbox.width - this.scrollbox.width;
               }
               this.scrollbox.alpha = Math.abs(this.tempPo.x - this.cont.x) * 0.1;
               if(MatchSettings.matchType == 0)
               {
                  this.tempAr[SD.curStage].mc_beat.scaleX += (0.6 - this.tempAr[SD.curStage].mc_beat.scaleX) * 0.3;
                  this.tempAr[SD.curStage].mc_beat.scaleY = this.tempAr[SD.curStage].mc_beat.scaleX;
                  UT.setDate();
                  this.tempAr[SD.curStage].mc_beat.y = -7 + UT.getOscillation(1,3);
               }
               break;
            case "heroes":
               if(mouseY > 500)
               {
                  this.heroCont.y += (515 - this.heroCont.y) * 0.3;
               }
               else
               {
                  this.heroCont.y += (572 - this.heroCont.y) * 0.3;
               }
               this.heroCont.visible = this.heroCont.y < 590;
               this.box_left.x += (0 - this.box_left.x) * 0.3;
               this.box_right.x += (800 - this.box_right.x) * 0.3;
               this.setStat(this.unitInfo.level,"health",this.unitClass);
               this.setStat(this.unitInfo.level,"crit",this.unitClass);
               this.setStat(this.unitInfo.level,"aim",this.unitClass);
               this.setStat(this.unitInfo.level,"mobile",this.unitClass);
               this.setStat(this.unitInfo.level,"aggro",this.unitClass);
               this.setBar(this.unitInfo.level,"health",300,this.unitClass);
               this.setBar(this.unitInfo.level,"crit",100,this.unitClass);
               this.setBar(this.unitInfo.level,"aim",10,this.unitClass);
               this.setBar(this.unitInfo.level,"mobile",10,this.unitClass);
               this.setBar(this.unitInfo.level,"aggro",10,this.unitClass);
               if(this.getitem.visible)
               {
                  return;
               }
               this.unitInfo.name = this.box_left.txt_name.text;
               _loc2_ = 0;
               while(_loc2_ < this.tempAr.length)
               {
                  this.box_left[this.tempAr[_loc2_]].setOpen(this.htRaw(this.box_left[this.tempAr[_loc2_] + "box"]));
                  if(this.htRaw(this.box_left[this.tempAr[_loc2_] + "box"]) && !this.getitem.visible)
                  {
                     this.box_left.setChildIndex(this.box_left[this.tempAr[_loc2_]],this.box_left.numChildren - 1);
                     this.box_left.setChildIndex(this.box_left[this.tempAr[_loc2_] + "box"],this.box_left.numChildren - 1);
                  }
                  this.box_left[this.tempAr[_loc2_]].EnterFrame();
                  _loc2_++;
               }
               this.box_right.primary.setOpen(this.htRaw(this.box_right.primarybox) && !this.getitem.visible);
               if(this.htRaw(this.box_right.primarybox))
               {
                  this.box_right.setChildIndex(this.box_right.primary,this.box_right.numChildren - 1);
                  this.box_right.setChildIndex(this.box_right.primarybox,this.box_right.numChildren - 1);
               }
               this.box_right.secondary.setOpen(this.htRaw(this.box_right.secondarybox) && !this.getitem.visible);
               if(this.htRaw(this.box_right.secondarybox))
               {
                  this.box_right.setChildIndex(this.box_right.secondary,this.box_right.numChildren - 1);
                  this.box_right.setChildIndex(this.box_right.secondarybox,this.box_right.numChildren - 1);
               }
               this.box_right.gun.setOpen(this.htRaw(this.box_right.gunbox) && !this.getitem.visible);
               if(this.htRaw(this.box_right.gunbox))
               {
                  this.box_right.setChildIndex(this.box_right.gun,this.box_right.numChildren - 1);
                  this.box_right.setChildIndex(this.box_right.gunbox,this.box_right.numChildren - 1);
               }
               this.box_right.armor.setOpen(this.htRaw(this.box_right.armorbox) && !this.getitem.visible);
               if(this.htRaw(this.box_right.armorbox))
               {
                  this.box_right.setChildIndex(this.box_right.armor,this.box_right.numChildren - 1);
                  this.box_right.setChildIndex(this.box_right.armorbox,this.box_right.numChildren - 1);
               }
               this.box_right.armor.EnterFrame();
               break;
            case "deploy":
               this.bt_start.visible = SD.squad[0] != -1;
               if(SD.stages.length == 2 && (SD.squad.length < 2 || SD.squad[1] == -1))
               {
                  this.bt_start.visible = false;
               }
               if(this.tempPo.x == -1)
               {
                  _loc2_ = 0;
                  while(_loc2_ < 5)
                  {
                     this["info" + _loc2_].y += (415 - this["info" + _loc2_].y) * 0.3;
                     _loc2_++;
                  }
                  this.bt_start.y += (532 - this.bt_start.y) * 0.3;
                  this.heroCont.y += (605 - this.heroCont.y) * 0.3;
               }
               else
               {
                  _loc2_ = 0;
                  while(_loc2_ < 5)
                  {
                     this["info" + _loc2_].y += (395 - this["info" + _loc2_].y) * 0.3;
                     if(this["char" + _loc2_].alpha < 1)
                     {
                        this["char" + _loc2_].alpha = UT.rand(0.7,0.8);
                        if(Math.random() < 0.03)
                        {
                           this["char" + _loc2_].alpha *= 0.6;
                        }
                     }
                     _loc2_++;
                  }
                  this.bt_start.y += (607 - this.bt_start.y) * 0.3;
                  this.heroCont.y += (515 - this.heroCont.y) * 0.3;
               }
               if(this.tempPo.x != -1)
               {
                  _loc2_ = 0;
                  while(_loc2_ < 15)
                  {
                     if(this.htBut(this.heroCont["hero_" + (_loc2_ + 1)]))
                     {
                        if(this.tempPo.y != _loc2_ + 15 * this.heroContPage[this.heroContPageNum])
                        {
                           this.tempPo.y = _loc2_ + 15 * this.heroContPage[this.heroContPageNum];
                           this.Init(1);
                           break;
                        }
                     }
                     _loc2_++;
                  }
                  if(mouseY < this.heroCont.y - 10)
                  {
                     if(this.tempPo.y != -1)
                     {
                        this.tempPo.y = -1;
                        this.Init(1);
                     }
                  }
               }
               break;
            case "heroesInv":
            case "workshopInv":
            case "inventory":
               this.cont.x += (207 - this.cont.x) * 0.3;
               if(this.getitem.visible)
               {
                  return;
               }
               _loc2_ = 0;
               while(_loc2_ < 24)
               {
                  _loc5_ = this.cont["item" + _loc2_];
                  _loc6_ = this.cont["hitbox" + _loc2_];
                  if(_loc2_ < SD.items[this.selItemCat].length)
                  {
                     _loc5_.setOpen(this.htRaw(_loc6_) && !this.getitem.visible,!!this.tempSt ? this.unitInfo[this.tempSt] : null);
                     if(this.htRaw(_loc6_))
                     {
                        this.cont.setChildIndex(_loc5_,this.cont.numChildren - 1);
                        this.cont.setChildIndex(_loc6_,this.cont.numChildren - 1);
                     }
                  }
                  _loc5_.EnterFrame();
                  _loc2_++;
               }
               break;
            case "store":
               this.cont.x += (503 - this.cont.x) * 0.3;
               if(this.slotmachine.visible)
               {
                  SlotMachine(this.slotmachine).EnterFrame();
                  return;
               }
               if(this.getitem.visible)
               {
                  return;
               }
               _loc2_ = 0;
               while(_loc2_ < 12)
               {
                  _loc5_ = this.cont["item" + _loc2_];
                  _loc6_ = this.cont["hitbox" + _loc2_];
                  if(_loc2_ < SD.storeItems.length)
                  {
                     _loc5_.setOpen(this.htRaw(_loc6_) && !this.getitem.visible,null);
                     if(this.htRaw(_loc6_))
                     {
                        this.cont.setChildIndex(_loc5_,this.cont.numChildren - 1);
                        this.cont.setChildIndex(_loc6_,this.cont.numChildren - 1);
                     }
                  }
                  _loc5_.EnterFrame();
                  _loc2_++;
               }
               break;
            case "workshop":
               this.scrollpane.x += (607 - this.scrollpane.x) * 0.3;
         }
      }
      
      public function MouseDown() : void
      {
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:ItemBox = null;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         if(this.slotmachine && this.slotmachine.visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.mainButtons.length)
         {
            if(this.htRaw(this["bt_" + this.mainButtons[_loc1_]]))
            {
               SH.playSound(S_Empty);
               this.goto(this.mainButtons[_loc1_]);
            }
            _loc1_++;
         }
         if(this.getitem.visible)
         {
            this.getitem.MouseDown();
            return;
         }
         if(this.htRaw(this.bt_youtube))
         {
            SH.playSound(S_Click);
            SD.urlYoutube();
         }
         if(this.htRaw(this.bt_facebook))
         {
            SH.playSound(S_Click);
            SD.urlFacebook();
         }
         if(this.htRaw(this.bt_twitter))
         {
            SH.playSound(S_Click);
            SD.urlTwitter();
         }
         switch(this.curFrame)
         {
            case "missions":
               if(SD.stages.length == 50)
               {
                  SD.stages.push(0);
               }
               trace(SD.stages.length);
               if(Main.DEBUGMODE)
               {
                  if(this.htRaw(this.bt_new))
                  {
                     SD.selHero = 0;
                     SD.newGame();
                     SD.saveGame();
                     break;
                  }
                  if(this.htRaw(this.bt_unlock))
                  {
                     SD.stages = [0];
                     _loc1_ = 0;
                     while(_loc1_ < Stats_Misc.maxMission - 1)
                     {
                        SD.stages.push(0);
                        _loc1_++;
                     }
                     SD.saveGame();
                     break;
                  }
                  if(this.htRaw(this.bt_money))
                  {
                     this.setFunds(1000);
                     break;
                  }
               }
               if(this.htRaw(this.bt_app))
               {
                  SH.playSound(S_Powerup);
                  this.goto("appstore");
               }
               if(this.htRaw(this.bt_akq))
               {
                  SD.urlAkq();
               }
               if(this.htRaw(this.bt_akqhero))
               {
                  if(!SD.gotAkq)
                  {
                     SD.gotAkq = true;
                     SD.mapItem.push("$akq");
                     this.bt_akqhero.visible = false;
                     this.Init(1);
                     return;
                  }
               }
               if(this.htRaw(this.bt_akqboth))
               {
                  SD.urlAkq();
                  if(!SD.gotAkq)
                  {
                     SD.gotAkq = true;
                     SD.mapItem.push("$akq");
                     this.bt_akqboth.gotoAndStop(2);
                     this.Init(1);
                     return;
                  }
               }
               switch(MatchSettings.matchType)
               {
                  case 0:
                     if(this.htRaw(this.box_mission.bt_prev))
                     {
                        SH.playSound(S_Click);
                        --SD.curDiff;
                        if(SD.curDiff < 1)
                        {
                           SD.curDiff = 3;
                        }
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_next))
                     {
                        SH.playSound(S_Click);
                        ++SD.curDiff;
                        if(SD.curDiff > 3)
                        {
                           SD.curDiff = 1;
                        }
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.bt_play))
                     {
                        SH.playSound(S_Ammo);
                        this.goto("deploy");
                     }
                     break;
                  case 2:
                     if(this.htRaw(this.box_mission.bt_prev))
                     {
                        SH.playSound(S_Click);
                        --SD.curDiff;
                        if(SD.curDiff < 0)
                        {
                           SD.curDiff = 3;
                        }
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_next))
                     {
                        SH.playSound(S_Click);
                        ++SD.curDiff;
                        if(SD.curDiff > 3)
                        {
                           SD.curDiff = 0;
                        }
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.bt_play))
                     {
                        SH.playSound(S_Ammo);
                        this.goto("deploy");
                     }
                     break;
                  case 1:
                     if(this.htRaw(this.box_mission.bt_modeprev))
                     {
                        SH.playSound(S_Click);
                        MatchSettings.qmMode = UT.getNextEl(MatchSettings.qmMode,false,Stats_Misc.gameModes);
                        MatchSettings.qmScore = Stats_Misc.getGameMode(MatchSettings.qmMode).startscore;
                        MatchSettings.qmTeams = Stats_Misc.getGameMode(MatchSettings.qmMode).teams;
                        if(MatchSettings.qmTeams)
                        {
                           MatchSettings.qmEnemies = 5;
                        }
                        else
                        {
                           MatchSettings.qmEnemies = 9;
                        }
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_modenext))
                     {
                        SH.playSound(S_Click);
                        MatchSettings.qmMode = UT.getNextEl(MatchSettings.qmMode,true,Stats_Misc.gameModes);
                        MatchSettings.qmScore = Stats_Misc.getGameMode(MatchSettings.qmMode).startscore;
                        MatchSettings.qmTeams = Stats_Misc.getGameMode(MatchSettings.qmMode).teams;
                        if(MatchSettings.qmTeams)
                        {
                           MatchSettings.qmEnemies = 5;
                        }
                        else
                        {
                           MatchSettings.qmEnemies = 9;
                        }
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_scoreprev))
                     {
                        SH.playSound(S_Click);
                        MatchSettings.qmScore = UT.getNextEl(MatchSettings.qmScore,false,Stats_Misc.getGameMode(MatchSettings.qmMode).scorelist);
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_scorenext))
                     {
                        SH.playSound(S_Click);
                        MatchSettings.qmScore = UT.getNextEl(MatchSettings.qmScore,true,Stats_Misc.getGameMode(MatchSettings.qmMode).scorelist);
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_modprev))
                     {
                        SH.playSound(S_Click);
                        MatchSettings.qmMod = UT.getNextEl(MatchSettings.qmMod,false,Stats_Misc.mods);
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_modnext))
                     {
                        SH.playSound(S_Click);
                        MatchSettings.qmMod = UT.getNextEl(MatchSettings.qmMod,true,Stats_Misc.mods);
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_squad))
                     {
                        SH.playSound(S_Click);
                        MatchSettings.qmAiBots = false;
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_bots))
                     {
                        SH.playSound(S_Click);
                        MatchSettings.qmAiBots = true;
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_prev))
                     {
                        SH.playSound(S_Click);
                        MatchSettings.qmMap = UT.getNextEl(MatchSettings.qmMap,false,Stats_Maps.mapOrder);
                        this.Init(1);
                        break;
                     }
                     if(this.htRaw(this.box_mission.bt_next))
                     {
                        SH.playSound(S_Click);
                        MatchSettings.qmMap = UT.getNextEl(MatchSettings.qmMap,true,Stats_Maps.mapOrder);
                        this.Init(1);
                        break;
                     }
                     if(MatchSettings.qmAiBots)
                     {
                        if(this.htRaw(this.box_mission.bt_enemyprev))
                        {
                           SH.playSound(S_Click);
                           --MatchSettings.qmEnemies;
                           if(MatchSettings.qmEnemies < 1)
                           {
                              MatchSettings.qmEnemies = !!Stats_Misc.getGameMode(MatchSettings.qmMode).teams ? 5 : 9;
                           }
                           this.Init(1);
                           break;
                        }
                        if(this.htRaw(this.box_mission.bt_enemynext))
                        {
                           SH.playSound(S_Click);
                           ++MatchSettings.qmEnemies;
                           if(MatchSettings.qmEnemies > (!!Stats_Misc.getGameMode(MatchSettings.qmMode).teams ? 5 : 9))
                           {
                              MatchSettings.qmEnemies = 1;
                           }
                           this.Init(1);
                           break;
                        }
                        if(this.htRaw(this.box_mission.bt_diffprev))
                        {
                           SH.playSound(S_Click);
                           --MatchSettings.qmDiff;
                           if(MatchSettings.qmDiff < 1)
                           {
                              MatchSettings.qmDiff = 6;
                           }
                           this.Init(1);
                           break;
                        }
                        if(this.htRaw(this.box_mission.bt_diffnext))
                        {
                           SH.playSound(S_Click);
                           ++MatchSettings.qmDiff;
                           if(MatchSettings.qmDiff > 6)
                           {
                              MatchSettings.qmDiff = 1;
                           }
                           this.Init(1);
                           break;
                        }
                        if(this.htRaw(this.bt_play))
                        {
                           SH.playSound(S_Ammo);
                           this.goto("deploy");
                           break;
                        }
                     }
                     if(this.htRaw(this.bt_play))
                     {
                        if(!SD.loadAGI(this.box_mission.txt_squadcode.text))
                        {
                           SH.playSound(S_Error);
                           this.tempBo = true;
                           this.Init(1);
                           break;
                        }
                        SH.playSound(S_Ammo);
                        this.tempBo = false;
                        this.goto("deploy");
                     }
                     break;
               }
               if(mouseX > this.box_mission.x)
               {
                  break;
               }
               _loc1_ = 0;
               while(_loc1_ < this.tempAr.length)
               {
                  if(this.htBut(this.tempAr[_loc1_]))
                  {
                     SH.playSound(S_Click);
                     MatchSettings.matchType = 0;
                     SD.curStage = _loc1_;
                     this.Init(1);
                     return;
                  }
                  _loc1_++;
               }
               if(this.htRaw(this.bt_custom))
               {
                  SH.playSound(S_Click);
                  MatchSettings.matchType = 1;
                  this.Init(1);
                  break;
               }
               if(this.htRaw(this.bt_daily))
               {
                  SH.playSound(S_Click);
                  MatchSettings.matchType = 2;
                  this.Init(1);
                  break;
               }
               if(this.htRaw(this.contbox))
               {
                  this.tempPo.y = mouseX - this.cont.x;
               }
               break;
            case "heroes":
               if(this.htRaw(this.heroCont.bt_prev))
               {
                  this.heroContPageNum = this.heroContPage.indexOf(UT.getNextEl(this.heroContPageNum,false,this.heroContPage));
                  SH.playSound(S_Click);
                  this.Init(2);
               }
               if(this.htRaw(this.heroCont.bt_next))
               {
                  this.heroContPageNum = this.heroContPage.indexOf(UT.getNextEl(this.heroContPageNum,true,this.heroContPage));
                  SH.playSound(S_Click);
                  this.Init(2);
               }
               _loc1_ = 0;
               while(_loc1_ < 15)
               {
                  if(this.htBut(this.heroCont["hero_" + (_loc1_ + 1)]))
                  {
                     SH.playSound(S_Empty);
                     if(this.heroCont["hero_" + (_loc1_ + 1)].currentFrame == 5)
                     {
                        this.getitem.InitHire();
                     }
                     else
                     {
                        SD.selHero = _loc1_ + 15 * this.heroContPage[this.heroContPageNum];
                        this.Init(1);
                     }
                  }
                  _loc1_++;
               }
               _loc1_ = 1;
               while(_loc1_ <= 6)
               {
                  if(this.htBut(this.box_left["col" + _loc1_]))
                  {
                     SH.playSound(S_Click);
                     this.unitInfo.color = _loc1_;
                     this.Init(1);
                     break;
                  }
                  _loc1_++;
               }
               _loc1_ = 0;
               while(_loc1_ < 3)
               {
                  _loc2_ = 0;
                  while(_loc2_ < 2)
                  {
                     if(this.htRaw(this.box_left["perk" + _loc1_ + _loc2_ + "box"],true))
                     {
                        SH.playSound(S_Click);
                        this.unitInfo.perks[_loc1_][2] = _loc2_ + 1;
                        if(this.unitInfo.hasUpgrade == _loc1_)
                        {
                           this.unitInfo.hasUpgrade = -1;
                        }
                        this.resetPerkSize();
                     }
                     _loc2_++;
                  }
                  _loc1_++;
               }
               if(this.htRaw(this.box_right.primarybox))
               {
                  SH.playSound(S_Click);
                  this.tempSt = "primary";
                  if(this.unitInfo.primary)
                  {
                     this.selItemCat = this.unitInfo.primary.stats.type;
                  }
                  else
                  {
                     this.selItemCat = this.unitClass[this.tempSt][0];
                  }
                  this.goto("heroesInv");
                  break;
               }
               if(this.htRaw(this.box_right.secondarybox))
               {
                  SH.playSound(S_Click);
                  this.tempSt = "secondary";
                  if(this.unitInfo.secondary)
                  {
                     this.selItemCat = this.unitInfo.secondary.stats.type;
                  }
                  else
                  {
                     this.selItemCat = this.unitClass[this.tempSt][0];
                  }
                  this.goto("heroesInv");
                  break;
               }
               if(this.htRaw(this.box_right.gunbox))
               {
                  SH.playSound(S_Click);
                  this.tempSt = "weaponMod";
                  this.selItemCat = 11;
                  this.goto("heroesInv");
                  break;
               }
               if(this.htRaw(this.box_right.armorbox))
               {
                  SH.playSound(S_Click);
                  this.tempSt = "armorMod";
                  this.selItemCat = 12;
                  this.goto("heroesInv");
                  break;
               }
               if(this.htRaw(this.box_right.bt_dismiss))
               {
                  SH.playSound(S_Click);
                  this.getitem.InitFire();
               }
               break;
            case "deploy":
               if(this.htRaw(this.heroCont.bt_prev))
               {
                  this.heroContPageNum = this.heroContPage.indexOf(UT.getNextEl(this.heroContPageNum,false,this.heroContPage));
                  SH.playSound(S_Click);
                  this.Init(2);
               }
               if(this.htRaw(this.heroCont.bt_next))
               {
                  this.heroContPageNum = this.heroContPage.indexOf(UT.getNextEl(this.heroContPageNum,true,this.heroContPage));
                  SH.playSound(S_Click);
                  this.Init(2);
               }
               if(this.htRaw(this.bt_back))
               {
                  SH.playSound(S_Empty);
                  this.goto("missions");
                  break;
               }
               if(this.htRaw(this.mc_squadcode.bt_copy))
               {
                  System.setClipboard(SD.squadCode);
                  break;
               }
               if(this.htRaw(this.mc_Psquadcode.Pbt_copy))
               {
                  System.setClipboard(SD.PsquadCode);
                  break;
               }
               _loc1_ = 0;
               while(_loc1_ < 5)
               {
                  if(this["info" + _loc1_].visible && this.htRaw(this["info" + _loc1_].bt_remove))
                  {
                     SH.playSound(S_Die6);
                     SD.squad[_loc1_] = -1;
                     this.Init(1);
                     break;
                  }
                  if(this["info" + _loc1_].visible && this.htRaw(this["info" + _loc1_].bt_change))
                  {
                     SH.playSound(S_Click);
                     if(this.tempPo.x != _loc1_)
                     {
                        this.tempPo.x = _loc1_;
                     }
                     else
                     {
                        this.tempPo.x = -1;
                     }
                     this.Init(1);
                     break;
                  }
                  _loc1_++;
               }
               if(this.tempPo.x != -1)
               {
                  _loc1_ = 0;
                  while(_loc1_ < 15)
                  {
                     if(this.htBut(this.heroCont["hero_" + (_loc1_ + 1)]))
                     {
                        SH.playSound(S_Empty);
                        SD.squad[this.tempPo.x] = _loc1_ + 15 * this.heroContPage[this.heroContPageNum];
                        this.tempPo.x = -1;
                        SD.selHero = _loc1_ + 15 * this.heroContPage[this.heroContPageNum];
                        this.Init(1);
                        return;
                     }
                     _loc1_++;
                  }
                  break;
               }
               if(this.htRaw(this.bt_start))
               {
                  SH.playSound(S_Shot);
                  MatchSettings.setupMatch();
                  this.main.startClass(Game);
               }
               break;
            case "heroesInv":
               if(this.htRaw(this.bt_back))
               {
                  SH.playSound(S_Click);
                  this.goto("heroes");
                  break;
               }
               _loc1_ = 0;
               while(_loc1_ < 13)
               {
                  this["inv" + _loc1_].txt_type.text = Stats_Guns.getGunType(_loc1_) + (_loc1_ != 12 ? "s" : "");
                  if(this.htBut(this["inv" + _loc1_]))
                  {
                     SH.playSound(S_Click);
                     this.selItemCat = _loc1_;
                     this.Init(1);
                  }
                  _loc1_++;
               }
               _loc1_ = 0;
               for(; _loc1_ < 24; _loc1_++)
               {
                  _loc3_ = this.cont["item" + _loc1_];
                  _loc4_ = this.cont["hitbox" + _loc1_];
                  if(this.htRaw(_loc4_))
                  {
                     if(_loc3_.gunInfo)
                     {
                        if(_loc3_.cantEquip)
                        {
                           SH.playSound(S_Error);
                           continue;
                        }
                        SH.playSound(S_Equip);
                        if(this.unitInfo[this.tempSt])
                        {
                           if(SD.items[this.unitInfo[this.tempSt].stats.type].length == 24 && this.unitInfo[this.tempSt].stats.type != _loc3_.gunInfo.stats.type)
                           {
                              this.getitem.InitFullInventory(this.unitInfo[this.tempSt].stats.type);
                              continue;
                           }
                           SD.items[this.unitInfo[this.tempSt].stats.type].push(this.unitInfo[this.tempSt]);
                        }
                        this.unitInfo[this.tempSt] = _loc3_.gunInfo;
                        SD.items[this.selItemCat].splice(SD.items[this.selItemCat].indexOf(_loc3_.gunInfo),1);
                     }
                     else
                     {
                        if(this.unitInfo[this.tempSt])
                        {
                           SD.items[this.selItemCat].push(this.unitInfo[this.tempSt]);
                        }
                        this.unitInfo[this.tempSt] = _loc3_.perkInfo.id;
                        SD.items[this.selItemCat].splice(SD.items[this.selItemCat].indexOf(_loc3_.perkInfo.id),1);
                        SH.playSound(S_Equip);
                     }
                     this.goto("heroes");
                     break;
                  }
               }
               if(this.htBut(this.unequip))
               {
                  SH.playSound(S_Equip);
                  if(this.tempSt == "primary" || this.tempSt == "secondary")
                  {
                     if(this.unitInfo[this.tempSt])
                     {
                        if(SD.items[this.unitInfo[this.tempSt].stats.type].length == 24)
                        {
                           this.getitem.InitFullInventory(this.unitInfo[this.tempSt].stats.type);
                           break;
                        }
                        SD.items[this.unitInfo[this.tempSt].stats.type].push(this.unitInfo[this.tempSt]);
                     }
                     this.unitInfo[this.tempSt] = null;
                  }
                  else
                  {
                     if(this.unitInfo[this.tempSt])
                     {
                        SD.items[this.selItemCat].push(this.unitInfo[this.tempSt]);
                     }
                     this.unitInfo[this.tempSt] = "";
                  }
                  this.goto("heroes");
               }
               break;
            case "workshopInv":
               if(this.htRaw(this.bt_back))
               {
                  SH.playSound(S_Click);
                  this.goto("workshop");
                  break;
               }
               _loc1_ = 0;
               while(_loc1_ < 13)
               {
                  this["inv" + _loc1_].txt_type.text = Stats_Guns.getGunType(_loc1_) + (_loc1_ != 12 ? "s" : "");
                  if(this.htBut(this["inv" + _loc1_]))
                  {
                     SH.playSound(S_Click);
                     this.selItemCat = _loc1_;
                     this.Init(1);
                  }
                  _loc1_++;
               }
               _loc1_ = 0;
               while(true)
               {
                  if(_loc1_ >= 24)
                  {
                     break;
                  }
                  _loc3_ = this.cont["item" + _loc1_];
                  _loc4_ = this.cont["hitbox" + _loc1_];
                  if(this.htRaw(_loc4_))
                  {
                     SH.playSound(S_Empty);
                     this.tempGu = _loc3_.gunInfo;
                     this.goto("workshop");
                     break;
                  }
                  _loc1_++;
               }
               break;
            case "inventory":
               _loc1_ = 0;
               while(_loc1_ < 13)
               {
                  this["inv" + _loc1_].txt_type.text = Stats_Guns.getGunType(_loc1_) + (_loc1_ != 12 ? "s" : "");
                  if(this.htBut(this["inv" + _loc1_]))
                  {
                     SH.playSound(S_Click);
                     this.selItemCat = _loc1_;
                     this.Init(1);
                  }
                  _loc1_++;
               }
               _loc1_ = 0;
               while(true)
               {
                  if(_loc1_ >= 24)
                  {
                     break;
                  }
                  _loc3_ = this.cont["item" + _loc1_];
                  _loc4_ = this.cont["hitbox" + _loc1_];
                  if(this.htRaw(_loc4_))
                  {
                     SH.playSound(S_Click);
                     if(_loc3_.gunInfo)
                     {
                        this.getitem.InitItem(_loc3_.gunInfo,"","sell");
                        break;
                     }
                     this.getitem.InitItem(_loc3_.perkInfo.id,"","sell");
                     break;
                  }
                  _loc1_++;
               }
               break;
            case "store":
               if(this.htRaw(this.bt_slots))
               {
                  this.slotmachine.Init();
               }
               _loc1_ = 0;
               while(true)
               {
                  if(_loc1_ >= 12)
                  {
                     break;
                  }
                  _loc3_ = this.cont["item" + _loc1_];
                  _loc4_ = this.cont["hitbox" + _loc1_];
                  if(this.htRaw(_loc4_))
                  {
                     SH.playSound(S_Click);
                     if(_loc3_.gunInfo)
                     {
                        this.getitem.InitItem(_loc3_.gunInfo,"","buy");
                        break;
                     }
                     this.getitem.InitItem(_loc3_.perkInfo.id,"","buy");
                     break;
                  }
                  _loc1_++;
               }
               break;
            case "workshop":
               if(this.htRaw(this.weaponbox))
               {
                  SH.playSound(S_Click);
                  this.goto("workshopInv");
                  break;
               }
               if(this.htBut(this.upgradebox))
               {
                  _loc5_ = Stats_Guns.getUpgradeCost(this.tempGu);
                  this.setFunds(-_loc5_);
                  Stats_Achievements.checkAchVariable("buy",_loc5_);
                  if(Stats_Guns.upgradeGun(this.tempGu))
                  {
                     this.upgradedisplay.gotoAndPlay("success");
                     trace("Upgrade success!");
                     SH.playSound(S_Skill);
                  }
                  else
                  {
                     this.upgradedisplay.gotoAndPlay("fail");
                     trace("Upgrade failed!");
                     SH.playSound(S_Error);
                  }
                  this.Init(1);
               }
               _loc1_ = 0;
               while(_loc1_ < SD.bpOwned.length)
               {
                  if(this.htBut(this.scrollpane.source.getChildAt(_loc1_)))
                  {
                     SH.playSound(S_Click);
                     this.getitem.InitBuild(SD.bpOwned[_loc1_]);
                  }
                  _loc1_++;
               }
               break;
            case "options":
               _loc1_ = 0;
               while(true)
               {
                  if(_loc1_ >= this.tempAr.length)
                  {
                     break;
                  }
                  if(this["bt_" + this.tempAr[_loc1_]].hitTestPoint(mouseX,mouseY,false))
                  {
                     SH.playSound(S_Click);
                     switch(this.tempAr[_loc1_])
                     {
                        case "qual":
                           SD.graphQual = ++SD.graphQual % 3;
                           Main.STAGE.quality = ["low","medium","high"][SD.graphQual];
                           break;
                        case "eff":
                           SD.graphPart = ++SD.graphPart % 3;
                           break;
                        case "glow":
                           SD.graphLights = !SD.graphLights;
                           break;
                        case "music":
                           SD.music = !SD.music;
                           break;
                        case "sound":
                           SD.sound = !SD.sound;
                           break;
                        case "voice":
                           SD.voices = !SD.voices;
                           break;
                        case "shake":
                           SD.screenShake = !SD.screenShake;
                           break;
                        case "bloody":
                           SD.screenBlood = !SD.screenBlood;
                           break;
                        case "gore":
                           SD.blood = ++SD.blood % 3;
                           break;
                        case "right":
                           SD.rightclick = ++SD.rightclick % 3;
                     }
                     this.Init(1);
                     break;
                  }
                  if(this.htRaw(this.bt_back))
                  {
                     SH.playSound(S_Click);
                     this.goto("missions");
                  }
                  if(this.htRaw(this.bt_delete))
                  {
                     SH.playSound(S_Click);
                     this.txt_deleteyes.visible = this.txt_deleteno.visible = true;
                     this.bt_deleteyes.visible = this.bt_deleteno.visible = true;
                     this.txt_delete.visible = false;
                     this.bt_delete.visible = false;
                     break;
                  }
                  if(this.htRaw(this.bt_deleteno))
                  {
                     SH.playSound(S_Click);
                     this.txt_deleteyes.visible = this.txt_deleteno.visible = false;
                     this.bt_deleteyes.visible = this.bt_deleteno.visible = false;
                     this.txt_delete.visible = true;
                     this.bt_delete.visible = true;
                     break;
                  }
                  if(this.htRaw(this.bt_deleteyes))
                  {
                     SH.playSound(S_Die1);
                     SD.selHero = 0;
                     SD.newGame();
                     SD.saveGame();
                     this.main.startClass(Logo_Splash);
                     break;
                  }
                  _loc1_++;
               }
               break;
            case "appstore":
               if(this.htRaw(this.bt_iphone))
               {
                  SH.playSound(S_Ammo);
                  SD.urlPhone();
               }
               if(this.htRaw(this.bt_ipad))
               {
                  SH.playSound(S_Ammo);
                  SD.urlPad();
               }
         }
      }
      
      private function resetPerkSize() : void
      {
         var i:Number = 0;
         var j:Number = 0;
         i = 0;
         while(i < 3)
         {
            j = 0;
            while(j < 2)
            {
               this.box_left["perk" + i + j].resetSize();
               j++;
            }
            i++;
         }
         this.Init(1);
      }
      
      public function hiredHero() : void
      {
         if(SD.heroes[SD.selHero].cls == "gun")
         {
            this.char.gotoAndPlay("hire_akimbo");
         }
         else
         {
            this.char.gotoAndPlay("hire");
         }
         Stats_Classes.setSkin(this.char,SD.heroes[SD.selHero]);
      }
      
      public function setFunds(amt:int = 0) : void
      {
         SD.funds = UT.clamp(SD.funds + amt,0,999999);
         this.txt_funds.text = "$" + UT.addNumCommas(SD.funds);
      }
      
      public function setStat(lvl:uint, val:String, unitClass:Stats_Classes) : void
      {
         this.tempOb[val] += (UT.getLinearRange(lvl,Stats_Misc.maxLvl,unitClass[val][0],unitClass[val][1]) - this.tempOb[val]) * 0.3;
         this.box_left["txt_" + val].text = Math.round(this.tempOb[val]);
      }
      
      public function setBar(lvl:uint, val:String, max:Number, unitClass:Stats_Classes) : void
      {
         var min:Number = UT.getLinearRange(lvl,Stats_Misc.maxLvl,unitClass[val][0],unitClass[val][1]);
         this.box_left["bar1_" + val].width += (min / max * 150 - this.box_left["bar1_" + val].width) * 0.3;
         this.box_left["bar2_" + val].width += (unitClass[val][1] / max * 150 - this.box_left["bar2_" + val].width) * 0.3;
      }
      
      private function rhymeMereDesire(i:int, mode:int, _y:int) : ItemContainer
      {
         var item:ItemContainer = new ItemContainer();
         item.name = "bp" + i;
         item.x = 75;
         item.y = 33;
         switch(mode)
         {
            case 1:
               item.gotoAndStop("blueprint1");
               item.gun.gotoAndStop(Stats_Guns.itemAr[i].sprite);
               item.gun.x = -item.gun.reg_menu.x * item.gun.scaleX;
               item.gun.y = -item.gun.reg_menu.y * item.gun.scaleY;
               if(item.gun.clip)
               {
                  item.gun.clip.gotoAndStop(Stats_Guns.itemAr[i].sprite);
               }
               if(item.gun.part)
               {
                  item.gun.part.gotoAndStop(Stats_Guns.itemAr[i].sprite);
               }
               item.txt_title.text = "BLUEPRINT " + (i + 1);
               break;
            case 2:
               item.gotoAndStop("blueprint2");
               item.gun.gotoAndStop(Stats_Guns.itemAr[i].sprite);
               Main.STAGE.invalidate();
               item.gun.x = -item.gun.reg_menu.x * item.gun.scaleX;
               item.gun.y = -item.gun.reg_menu.y * item.gun.scaleY;
               if(item.gun.clip)
               {
                  item.gun.clip.gotoAndStop(Stats_Guns.itemAr[i].sprite);
               }
               if(item.gun.part)
               {
                  item.gun.part.gotoAndStop(Stats_Guns.itemAr[i].sprite);
               }
               item.txt_title.text = "BLUEPRINT " + (i + 1);
               break;
            case 0:
               item.gotoAndStop("blueprint3");
               item.txt_title.text = "BLUEPRINT " + (i + 1) + "\nNOT FOUND";
         }
         item.x += 5;
         item.y += _y * 75 + 5;
         return item;
      }
      
      public function FixWeapon() : void
      {
         Stats_Classes.setSkin(this.char,this.unitInfo);
      }
      
      public function MouseUp() : void
      {
         switch(this.curFrame)
         {
            case "missions":
               this.tempPo.y = 0;
         }
      }
      
      public function goto(frame:String) : void
      {
         this.curFrame = frame;
         gotoAndStop(frame);
      }
      
      public function KeyUp(e:int) : void
      {
      }
      
      public function flashActivate() : void
      {
      }
      
      public function flashDeactivate() : void
      {
      }
      
      public function MouseWheel(e:int) : void
      {
      }
      
      public function RightMouseDown() : void
      {
      }
      
      public function RightMouseUp() : void
      {
      }
      
      public function KeyDown(e:int) : void
      {
         if(e != 32 || !Main.DEBUGMODE)
         {
            return;
         }
         switch(this.curFrame)
         {
            case "heroes":
               this.unitInfo.levelUp();
               this.unitInfo.addExp(Stats_Classes.getNextExp(this.unitInfo.level) - 1);
               this.Init(1);
               break;
            case "store":
               SD.nextStoreRow();
               this.Init(1);
         }
      }
      
      public function ht(MC:*, ignoreButtonMode:Boolean = false) : Boolean
      {
         if(!MC)
         {
            return false;
         }
         return (ignoreButtonMode || MC.buttonMode) && MC.hitbox.hitTestPoint(mouseX,mouseY,false);
      }
      
      public function htRaw(MC:*, needButMode:Boolean = false) : Boolean
      {
         if(!MC)
         {
            return false;
         }
         if(!MC.visible)
         {
            return false;
         }
         if(needButMode && !MC.buttonMode)
         {
            return false;
         }
         return MC.hitTestPoint(mouseX,mouseY,false);
      }
      
      public function htBut(MC:*) : Boolean
      {
         if(!MC)
         {
            return false;
         }
         if(!MC.visible)
         {
            return false;
         }
         if(!MC.bt)
         {
            return false;
         }
         if(!MC.bt.visible)
         {
            return false;
         }
         return MC.bt.hitTestPoint(mouseX,mouseY,false);
      }
      
      internal function normalizeDispensableRollJailNextLevel3(curFrame:int) : *
      {
         if(this.scrollpane != null && curFrame >= 31 && curFrame <= 35 && (this.__setPropDict[this.scrollpane] == undefined || !(int(this.__setPropDict[this.scrollpane]) >= 31 && int(this.__setPropDict[this.scrollpane]) <= 35)))
         {
            this.__setPropDict[this.scrollpane] = curFrame;
            try
            {
               this.scrollpane["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.scrollpane.enabled = true;
            this.scrollpane.horizontalLineScrollSize = 0;
            this.scrollpane.horizontalPageScrollSize = 0;
            this.scrollpane.horizontalScrollPolicy = "off";
            this.scrollpane.scrollDrag = false;
            this.scrollpane.source = "";
            this.scrollpane.verticalLineScrollSize = 4;
            this.scrollpane.verticalPageScrollSize = 0;
            this.scrollpane.verticalScrollPolicy = "on";
            this.scrollpane.visible = true;
            try
            {
               this.scrollpane["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function studyVacuousLunch(e:Object) : *
      {
         var curFrame:int = currentFrame;
         if(this.__lastFrameProp == curFrame)
         {
            return;
         }
         this.__lastFrameProp = curFrame;
         this.normalizeDispensableRollJailNextLevel3(curFrame);
      }
      
      internal function frame1() : *
      {
         this.Init();
      }
      
      internal function frame6() : *
      {
         this.Init();
      }
      
      internal function frame11() : *
      {
         this.Init();
      }
      
      internal function frame16() : *
      {
         this.Init();
         stop();
      }
      
      internal function frame21() : *
      {
         this.Init();
      }
      
      internal function frame26() : *
      {
         this.Init();
      }
      
      internal function frame31() : *
      {
         this.Init();
      }
      
      internal function frame36() : *
      {
         this.Init();
      }
      
      internal function frame41() : *
      {
         this.Init();
      }
      
      internal function frame51() : *
      {
         this.Init();
      }
      
      internal function frame55() : *
      {
         this.Init();
      }
      
      internal function frame60() : *
      {
         this.Init();
      }
   }
}

import flash.display.Graphics;
import flash.display.MovieClip;
import flash.geom.Point;

class SplineMethod
{
   
   private static var hermiteValues:Array = [0,0,1,0];
    
   
   public function SplineMethod()
   {
      super();
   }
   
   public static function setResolution(value:int) : void
   {
      var t:* = NaN;
      var h00:Number = NaN;
      var h10:Number = NaN;
      var h01:Number = NaN;
      var h11:Number = NaN;
      var resolution:Number = 1 / value;
      hermiteValues = [];
      t = resolution;
      while(t <= 1)
      {
         h00 = (1 + 2 * t) * (1 - t) * (1 - t);
         h10 = t * (1 - t) * (1 - t);
         h01 = t * t * (3 - 2 * t);
         h11 = t * t * (t - 1);
         hermiteValues.push(h00,h10,h01,h11);
         t += resolution;
      }
   }
   
   public static function drawSpline(target:Graphics, segmentStart:MovieClip, segmentEnd:MovieClip, prevSegmentEnd:MovieClip = null, nextSegmentStart:MovieClip = null) : void
   {
      var i:int = 0;
      var h00:Number = NaN;
      var h10:Number = NaN;
      var h01:Number = NaN;
      var h11:Number = NaN;
      var px:Number = NaN;
      var py:Number = NaN;
      if(!prevSegmentEnd)
      {
         prevSegmentEnd = segmentStart;
      }
      if(!nextSegmentStart)
      {
         nextSegmentStart = segmentEnd;
      }
      var m1:Point = new Point((segmentEnd.x - prevSegmentEnd.x) / 2,(segmentEnd.y - prevSegmentEnd.y) / 2);
      var m2:Point = new Point((nextSegmentStart.x - segmentStart.x) / 2,(nextSegmentStart.y - segmentStart.y) / 2);
      var n:int = int(hermiteValues.length);
      i = 0;
      while(i < n)
      {
         h00 = Number(hermiteValues[i]);
         h10 = Number(hermiteValues[i + 1]);
         h01 = Number(hermiteValues[i + 2]);
         h11 = Number(hermiteValues[i + 3]);
         px = h00 * segmentStart.x + h10 * m1.x + h01 * segmentEnd.x + h11 * m2.x;
         py = h00 * segmentStart.y + h10 * m1.y + h01 * segmentEnd.y + h11 * m2.y;
         target.lineTo(px,py);
         i += 4;
      }
   }
}

class DefenceDialog {
idd = 5000;
movingEnable = true;
objects[] = {};
controlsBackground[]={Fon1,Fon2};
controls[]= {mtex,crbox};


class Fon1 : RscText {
colorBackground[] = {0,0.0,0,0.2};
x = 0.25; y = 0.4; w = 0.5; h = 0.15;
text = "";
};
class mtex : RscText {
colorBackground[] = {0.6,0.6,0.6,0};
colorText[] = {1,1,1,1};
x = 0.26; y = 0.4; w = 0.5; h = 0.05;
text = $STR_WF_PC_construct;
};
class Fon2 : RscText {
colorBackground[] = {0,0.0,0,0.4};
x = 0.26; y = 0.45; w = 0.48; h = 0.09;
text = "";
};

class crbox : MyRscCombo {
idc = 5100;
colorBackground[] = {0.6,0.6,0.6,1};
x = 0.27; y = 0.48; w = 0.46; h = 0.05;
onLBSelChanged = "[_this select 1] spawn DefenceCreate; closedialog 0;";
};

}; 
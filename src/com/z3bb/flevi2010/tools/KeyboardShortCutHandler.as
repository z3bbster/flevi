package com.z3bb.flevi2010.tools {
	
	import flash.events.KeyboardEvent;
	
	public class KeyboardShortCutHandler{
		
		//Constructor
		public function KeyboardShortCutHandler(e:KeyboardEvent){
		
		};
		
		private function numToChar(num:int):String {
        if (num > 47 && num < 58) {
            var strNums:String = "0123456789";
            return strNums.charAt(num - 48);
        } else if (num > 64 && num < 91) {
            var strCaps:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            return strCaps.charAt(num - 65);
        } else if (num > 96 && num < 123) {
            var strLow:String = "abcdefghijklmnopqrstuvwxyz";
            return strLow.charAt(num - 97);
        } else {
            return num.toString();
        }
    }

	}
}
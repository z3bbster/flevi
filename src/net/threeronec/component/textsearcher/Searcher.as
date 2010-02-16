package net.threeronec.component.textsearcher
{
	import mx.controls.Alert;
	import flash.events.EventDispatcher;
	
	[Event(name="textNotFoundReachedBeginningFind", type="net.threeronec.component.textsearcher.TextSearchEvent")]
	[Event(name="textNotFoundReachedEndFind", type="net.threeronec.component.textsearcher.TextSearchEvent")]
	[Event(name="textNotFoundReachedBeginningReplace", type="net.threeronec.component.textsearcher.TextSearchEvent")]
	[Event(name="textNotFoundReachedEndReplace", type="net.threeronec.component.textsearcher.TextSearchEvent")]
	[Event(name="doesNotExist", type="net.threeronec.component.textsearcher.TextSearchEvent")]
	
	
	/**
	 * This class is used as a utility to search and/or replace terms in some sort of a text field (UITextField, TextField, TextInput, TextArea etc...)
	 * You access the public methods to search previous next replace previous next, and replace all terms in a text field
	 * you can easily change the term you're searching or even the field you're searching at runtime
	 * it allows for you to search from the beginning or the end of fields so you can loop when you've reached the beginning or end of a search
	 * it also has several events to subscribe to that convieniently tell you if you've reached the beginning or the end, or if the term doesn't exist at all
	 * @author Eric Cancil
	 * 
	 */	
	public class Searcher extends EventDispatcher
	{
		
		private var _string:String;
		private var _field:Object;
		
		private var index:Number = 0;
		
		public function Searcher(field:Object){
			if(!field.hasOwnProperty("text")){
				throw new Error("Must pass a text field of some sort");
			}else{
				_field = field;
			}
		}
		
		public function set string(val:String):void{
			_string = val;
		}
		
		public function get string():String{
			return _string;
		}
		
		public function set field(val:Object):void{
			_field = val;
		}
		
		public function get field():Object{
			return _field;
		}
		
		
		/**
		 * method to search for next term in string
		 * @param startAtBeginning whether to search from the beginning of the text or not - defaults to false
		 * 
		 */		
		public function next(startAtBeginning:Boolean = false):void{
			if(String(_field.text).split(_string).length == 1){
				constructAndDispatchEvent(TextSearchEvent.DOES_NOT_EXIST);
				return;
			}
			if(startAtBeginning)index = -1;
			var str:String = String(_field.text);
			var at:int = str.indexOf(_string, index);
			index = at + _string.length;
			if(at != -1){
				index -=1 ;
				_field.setFocus();
				_field.setSelection(at, at + _string.length);
			}else{
				constructAndDispatchEvent(TextSearchEvent.TEXT_NOT_FOUND_REACHED_END_FIND)
				return;
				//next(true);
			}
		}
		
		/**
		 * method to search for previous term in string
		 * @param searchFromEnd whether to search from the end of the text or not - defaults to false
		 * 
		 */		
		public function previous(searchFromEnd:Boolean = false):void{
			if(String(_field.text).split(_string).length == 1){
				constructAndDispatchEvent(TextSearchEvent.DOES_NOT_EXIST);
				return;
			}			
			if(searchFromEnd)index = _field.text.length + 1;
			var str:String = String(_field.text).substring(-1, index);
			var at:int = str.lastIndexOf(_string);
			index = at;
			if(index != -1){
				index += 1;
				_field.setFocus();
				_field.setSelection(at, at + _string.length);
			}else{
				constructAndDispatchEvent(TextSearchEvent.TEXT_NOT_FOUND_REACHED_BEGINNING_FIND)
				return;
				//index = _field.text.length + 1;
				//previous();
			}
		}
		
		
		/**
		 * method to replace all terms in a string
		 * @param toReplace the term to replace
		 * @param replaceWith the term to replace with
		 * 
		 */		
		public function replaceAll(toReplace:String, replaceWith:String):void{
			//checks if the term exists at all to avoid stack overflows on a search from beginning
			if(String(_field.text).split(toReplace).length == 1){
				constructAndDispatchEvent(TextSearchEvent.DOES_NOT_EXIST);
				return;
			}
			//join and set
			_field.text = String(_field.text).split(toReplace).join(replaceWith);
		}
		
		
		/**
		 * method to replace the next occurence of the term in a string
		 * @param toReplace the term to replace
		 * @param replaceWith the term to replace with
		 * @param searchFromEnd whether to search from the beginning of the text or not - defaults to false
		 * 
		 */	
		public function replaceNext(toReplace:String, replaceWith:String, startAtBeginning:Boolean = false):void{
			if(startAtBeginning)index = -1;
			//checks if the term exists at all to avoid stack overflows on a search from beginning
			if(String(_field.text).split(toReplace).length == 1){
				constructAndDispatchEvent(TextSearchEvent.DOES_NOT_EXIST);
				return;
			}
			var str:String = String(_field.text);
			var at:int = str.indexOf(toReplace, index);
			//if you've reached the end dispatch an event
			if(at == -1){
				constructAndDispatchEvent(TextSearchEvent.TEXT_NOT_FOUND_REACHED_END_REPLACE)
				return;
			} 
			index = at + _string.length - 1;
			//create array
			var arr:Array = new Array();
			//first part
			arr.push(str.substring(0, at));
			//do replace
			arr.push(replaceWith);
			//last part
			arr.push(str.substring(at + toReplace.length, _field.text.length + 1));
			//join and set
			_field.text = arr.join("");
		}
		
		/**
		 * method to replace the previous term in a string
		 * @param toReplace the term to replace
		 * @param replaceWith the term to replace with
		 * @param searchFromEnd whether to search from the end of the text or not - defaults to false
		 * 
		 */		
		public function replacePrevious(toReplace:String, replaceWith:String, searchFromEnd:Boolean = false):void{
			//checks if the term exists at all to avoid stack overflows on a search from end
			if(String(_field.text).split(toReplace).length == 1){
				constructAndDispatchEvent(TextSearchEvent.DOES_NOT_EXIST);
				return;
			}
			if(searchFromEnd)index = _field.text.length + 1;
			var str:String = String(_field.text).substring(-1, index);
			//if(searchFromEnd)Alert.show(str);
			var at:int = str.lastIndexOf(toReplace);
			//if you've reached the beginning dispatch an event
			if(at == -1) {
				constructAndDispatchEvent(TextSearchEvent.TEXT_NOT_FOUND_REACHED_BEGINNING_REPLACE) 
				return;
			}
			//create an array
			var arr:Array = new Array();
			//get the first part
			arr.push(str.substring(0, at));
			//do the replace
			arr.push(replaceWith);
			//get the last part
			arr.push(_field.text.substring(at + _string.length, _field.text.length + 1));
			//join and set text
			_field.text = arr.join("");
			index = at;
		}
		
		/**
		 * creates an event and dispatches it
		 * @param type type of event
		 * 
		 */		
		private function constructAndDispatchEvent(type:String):void{
			var e:TextSearchEvent = new TextSearchEvent(type);
			dispatchEvent(e);
		}
	}
}
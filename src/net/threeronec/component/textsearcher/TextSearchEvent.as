package net.threeronec.component.textsearcher
{
	import flash.events.Event;

	public class TextSearchEvent extends Event
	{
		
		public static const TEXT_NOT_FOUND_REACHED_BEGINNING_FIND:String = "textNotFoundReachedBeginningFind";
		public static const TEXT_NOT_FOUND_REACHED_END_FIND:String = "textNotFoundReachedEndFind";
		public static const TEXT_NOT_FOUND_REACHED_BEGINNING_REPLACE:String = "textNotFoundReachedBeginningReplace";
		public static const TEXT_NOT_FOUND_REACHED_END_REPLACE:String = "textNotFoundReachedEndReplace";
		public static const DOES_NOT_EXIST:String = "doesNotExist";
		
		
		public function TextSearchEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			var e:TextSearchEvent = new TextSearchEvent(type, bubbles, cancelable);
			
			return e;
		}
		
	}
}
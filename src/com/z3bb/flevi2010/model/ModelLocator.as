package com.z3bb.flevi2010.model{
	
	import com.adobe.cairngorm.model.IModelLocator;
	
	import mx.collections.*;
	import mx.controls.TextArea;
	
	[Bindable]
	public class ModelLocator implements IModelLocator {
		
		// Single Instance of Our ModelLocator
		private static var instance:ModelLocator;
		
		public function ModelLocator(enforcer:SingletonEnforcer) {
		if (enforcer == null) {
				throw new Error( "You Can Only Have One ModelLocator" );
			}
		};
		
		// Returns the Single Instance
		public static function getInstance() : ModelLocator {
			if (instance == null) {
				instance = new ModelLocator( new SingletonEnforcer );
			}
			return instance;
		};
		
		//DEFINE YOUR VARIABLES HERE
		public var workflowState:uint = 0;
		public var FollowersList:ArrayCollection = new ArrayCollection();
		public var HashtagList:ArrayCollection = new ArrayCollection();

		public var project_types:ArrayCollection = new ArrayCollection(
                [ {label:"Is.gd", data:0}, 
                  {label:"R.im", data:1}, 
                  {label:"Su.pr", data:2}, 
                  {label:"Bit.ly", data:3},
                  
                  {label:"ow.ly", data:4} ]);
		
		public var snippetLib:ArrayCollection = new ArrayCollection(
			                [ {label:"MXML Library", data:1}, 
			                  {label:"Actionscript Library", data:2}, 
			                  {label:"CSS Library", data:3},
			                  {label:"HTML Library", data:4},
			                  {label:"XML Library", data:5},
			                  
			                 ]);
		private var snippetXMLData:XML; // The external XML data
		public var snippetTreeCollection:XMLListCollection; //Dataprovider for Tree
		public var selectedNode:XML; //current selected item in Tree	                 
		//DEFINE VIEW CONSTANTS
		public static const LOGIN_SCREEN:uint = 0;
		public static const HOME_SCREEN:uint = 1;
		public static const OPTION_SCREEN:uint = 2;
		
		public var _currentCodeTextArea:TextArea;
		public var dataChanged:Boolean = false; // Whether the text data has changed (and should be saved)
	
	}
}
// Utility Class to Deny Access to Constructor
class SingletonEnforcer {}
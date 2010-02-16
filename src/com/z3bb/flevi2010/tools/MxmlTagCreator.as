package com.z3bb.flevi2010.tools{
	
	import mx.controls.*;
	
	public class MxmlTagCreator{
		
		private var _namespace:String;
		private var _nodename:String;

		
		//Constructor
		public function MxmlTagCreator(name_space:String){
			_namespace = name_space;
		};
		
		public function makeNode( nodename:String, isdoublenode:Boolean, id:String, width:String, height:String, x:String, y:String, stylename:String):String {
			var part1:String = '<' + _namespace + ':' + nodename;
			var part2_single:String = '/>\n';
			var part2_double:String = '>\n</'+_namespace+':'+nodename+'>';
			var id_part:String = ' id="'+ id +'"';
			var width_part:String = ' width="'+ width +'"';
			var height_part:String = ' height="'+ height +'"';
			var x_part:String = ' x="'+ x +'"';
			var y_part:String = ' y="'+ y +'"';
			var style_part:String = ' styleName="'+ stylename +'"';
			//Check if we need to make a single or double node
			if (isdoublenode) {
				var total:String = part1;// + id_part + width_part + height_part + x_part + y_part + style_part;
				if (!id == '' ) total = part1+ id_part;
				if (!width =='') total = total + width_part;
				if (!height =='') total = total + height_part;
				if (!x =='') total = total + x_part;
				if (!y =='') total = total + y_part;
				if (!stylename =='') total = total + style_part;
				return total + part2_double;
			} else {
				var total1:String = part1; //+ id_part + width_part + height_part + x_part + y_part + style_part;
				if (!id == '') total1= total1 + id_part;
				if (!width =='') total1 = total1+ width_part;
				if (!height =='') total1 = total1 + height_part;
				if (!x =='' ) total1 = total1 + x_part;
				if (!y =='' ) total1 = total1 + y_part;
				if (!stylename =='') total1 = total1 + style_part;
				return total1 + part2_single;
			}
		};

	}
}
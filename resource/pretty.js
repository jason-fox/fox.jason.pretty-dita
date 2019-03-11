var Prettify={};


Prettify.doctypes = {
	concept: 'PUBLIC "-//OASIS//DTD DITA Concept//EN" "concept.dtd"',
	ditabase: 'PUBLIC "-//OASIS//DTD DITA Composite//EN" "ditabase.dtd"',
	glossentry: 'PUBLIC "-//OASIS//DTD DITA Glossary Entry//EN" "glossentry.dtd"',
	glossary: 'PUBLIC "-//OASIS//DTD DITA Glossary//EN" "glossary.dtd"',
	reference: 'PUBLIC "-//OASIS//DTD DITA Reference//EN" "reference.dtd"',
	task: 'PUBLIC "-//OASIS//DTD DITA Task//EN" "task.dtd"',
	generaltask: 'PUBLIC "-//OASIS//DTD DITA General Task//EN" "generalTask.dtd"',
	topic: 'PUBLIC "-//OASIS//DTD DITA Topic//EN" "topic.dtd"',
	basetopic: 'PUBLIC "-//OASIS//DTD DITA Base Topic//EN" "basetopic.dtd"',
	machinerytask: 'PUBLIC "-//OASIS//DTD DITA Machinery Task//EN" "machineryTask.dtd"',
	learningassessment: 'PUBLIC "-//OASIS//DTD DITA Learning Assessment//EN" "learningAssessment.dtd"',
	learningcontent: 'PUBLIC "-//OASIS//DTD DITA Learning Content//EN" "learningContent.dtd"',
	learningoverview: 'PUBLIC "-//OASIS//DTD DITA Learning Overview//EN" "learningOverview.dtd"',
	learningplan: 'PUBLIC "-//OASIS//DTD DITA Learning Plan//EN" "learningPlan.dtd"',
	learningsummary: 'PUBLIC "-//OASIS//DTD DITA Learning Summary//EN" "learningSummary.dtd"',
	map: 'PUBLIC "-//OASIS//DTD DITA Map//EN" "map.dtd"',
	basemap: 'PUBLIC "-//OASIS//DTD DITA Base Map//EN" "basemap.dtd"',
	bookmap: 'PUBLIC "-//OASIS//DTD DITA BookMap//EN" "bookmap.dtd"',
	subjectscheme: 'PUBLIC "-//OASIS//DTD DITA Subject Scheme Map//EN" "subjectScheme.dtd"',
	classifymap: 'PUBLIC "-//OASIS//DTD DITA Classification Map//EN" "classifyMap.dtd"',
	learningbookmap: 'PUBLIC "-//OASIS//DTD DITA Learning BookMap//EN" "learningBookmap.dtd"',
	learningmap: 'PUBLIC "-//OASIS//DTD DITA Learning Map//EN" "learningMap.dtd"',
	ditaval: 'PUBLIC "-//OASIS//DTD DITA DITAVAL//EN" "ditaval.dtd"'
};

Prettify.writeDITA = function(file, dita){

	var task = project.createTask("echo"); 
	task.setFile(new java.io.File(file)); 
	task.setMessage(dita);
	task.perform();
}

Prettify.analyseDITA = function(dita) {

	var codeblock= false;
	var p;
	var li;

	var lines = dita.split('\n');
	var text =[];
	var str = [];
	var doctype = null;



	

	var splitAtSpace = function (text){
		var space = text.lastIndexOf(' ', 80);
		if(space < 1 ){
			space = text.indexOf(' ', 80);
		}  
		if(space < 1 ){
		  	return -1;
		} 

		var closeClose = text.indexOf('</', space);

		if(closeClose === -1 ){
		  	return space;
		} 
		return closeClose > 100 ? space:  text.indexOf(' ',text.indexOf('>', closeClose));
	}

	var splitText = function(str, indent){
		var text = str.join(' ');
		var split = 0;
		var arr =[];
		var spaces = new Array(indent + 4).join(' ');

		while (split > -1){
		  var split = splitAtSpace(text);
		  
		  arr.push(split === -1 ? text: text.substring(0,split));
		  text = text.substring(split);
		}

		var newText = arr.join('\n' + spaces);
		var first = newText.indexOf('>') + 1;
		var last = newText.lastIndexOf('<');

		return newText.substring(0, first) + '\n ' + spaces + newText.substring(first, last) + '\n' +
			 new Array(indent).join(' ') + newText.substring(last).trim();		
	}


	for (var i = 0; i < lines.length; i++){


		if (!doctype && lines[i].match(/^<\w/)){
			doctype = lines[i].substring(lines[i].indexOf('<') + 1, lines[i].indexOf('>'));

			if (doctype.contains(' ')) {
				doctype = doctype.substring(0,doctype.indexOf(' '));
			}

			text.push('<!DOCTYPE ' + doctype + ' ' +  Prettify.doctypes[doctype.toLowerCase()] + '>');

		}

		if (lines[i].match(/^\s+<codeblock(>| )/) && lines[i].endsWith('</codeblock>') ){
			// Nothing
		} else if (lines[i].trim().startsWith('<codeblock')){
			codeblock = true;
		} else if (lines[i].endsWith('/codeblock>')){
			codeblock = false;
		} 
		if(!codeblock){
			if (lines[i].match(/^\s+<p(>| )/) && !lines[i].endsWith('</p>') ){
				p = lines[i].indexOf('<');
				str.push(lines[i]);
			} else if (lines[i].match(/^\s+<li(>| )/) && !lines[i].endsWith('</li>') ){
				li= lines[i].indexOf('<');
				str.push(lines[i]);
			} else if (p || li){
				str.push(lines[i].trim());
			} else if (!p && !li){
				text.push(lines[i])
			}

			if (p && lines[i].endsWith('</p>')  ){
				text.push(splitText(str, p));
				p = 0;
				str =[];
			}
			if (li && lines[i].endsWith('</li>')  ){
				text.push(splitText(str, li));
				li = 0;
				str =[];
			}  
		} else {
			text.push(lines[i]);
		}
	}

	return text.join('\n');
}






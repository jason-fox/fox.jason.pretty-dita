/*
 *  This file is part of the DITA-OT Pretty DITA Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

var Prettify = {};

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

Prettify.writeDITA = function(file, dita) {
  var task = project.createTask('echo');
  task.setFile(new java.io.File(file));
  task.setMessage(dita);
  task.perform();
};

Prettify.analyseDITA = function(dita, style, printWidth, addPragma, hasPragma) {
  var codeblock = false;
  var closeCodeblock = false;

  var lines = dita.split('\n');
  var text = [];
  var str = [];
  var doctype = null;
  var blockEl = false;
  var indent = 0;
  var indentStyle = style === 'tabs' ? '\t' : ' ';

  var reStart = /^\s+<(codeblock|lines|msgblock|pre)(>| )/;
  var reEnd = /<\/(codeblock|lines|msgblock|pre)>/;

  var splitAtSpace = function(text) {
    var space = text.lastIndexOf(' ', printWidth);
    if (space < 1) {
      space = text.indexOf(' ', printWidth);
    }
    if (space < 1) {
      return -1;
    }

    var closeClose = text.indexOf('</', space);

    if (closeClose === -1) {
      return space;
    }
    return closeClose > Number(printWidth) + 20 ? space : text.indexOf(' ', text.indexOf('>', closeClose));
  };

  var splitText = function(str, indent) {
    var text = str.join(' ');
    var split = 0;
    var arr = [];
    var spaces = new Array(indent).join(indentStyle);

    while (split > -1) {
      var split = splitAtSpace(text);

      if (split !== -1) {
        arr.push(text.substring(0, split));
      } else if (arr.length > 0) {
        arr[arr.length - 1] = arr[arr.length - 1] + text;
      } else {
        arr.push(text);
      }

      text = text.substring(split);
    }

    return spaces + ' ' + arr.join('\n' + spaces);
  };

  for (var i = 0; i < lines.length; i++) {
    if (!doctype && lines[i].match(/^<\w/)) {
      doctype = lines[i].substring(lines[i].indexOf('<') + 1, lines[i].indexOf('>'));

      if (doctype.contains(' ')) {
        doctype = doctype.substring(0, doctype.indexOf(' '));
      }

      text.push('<!DOCTYPE ' + doctype + ' ' + Prettify.doctypes[doctype.toLowerCase()] + '>');

      if (addPragma === 'true' && hasPragma === 'false') {
        text.push('<!-- @format -->');
      }
    }

    if (lines[i].match(reStart) && lines[i].match(reEnd)) {
      // Nothing
    } else if (lines[i].match(reStart)) {
      codeblock = true;
    } else if (lines[i].match(reEnd)) {
      closeCodeblock = true;
      codeblock = false;
    }

    if (closeCodeblock) {
      text.push(lines[i]);
      closeCodeblock = false;
    } else if (codeblock) {
      text.push(lines[i]);
    } else {
      blockEl = lines[i].match(/^\s*<.*>$/) && (lines[i] + ' ').split('<').length < 4;

      if (blockEl) {
        if (str.length > 0) {
          text.push(splitText(str, indent + 2));
        }
        text.push(lines[i]);

        indent = lines[i].indexOf('<');
        str = [];
      } else {
        var line = lines[i].trim();
        if (line.length > 0) {
          str.push(line);
        }
      }
    }
  }
  return text.join('\n');
};

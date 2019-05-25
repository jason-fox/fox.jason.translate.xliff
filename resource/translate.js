/*
 *  This file is part of the DITA-OT Translate Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

var Translate = {};

Translate.doctypes = {
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

Translate.writeDITA = function(file, dita) {
  var task = project.createTask('echo');
  task.setFile(new java.io.File(file));
  task.setMessage(dita);
  task.perform();
};

Translate.addDoctype = function(dita) {

  var lines = dita.split('\n');
  var text = [];
  var doctype = null;

  for (var i = 0; i < lines.length; i++) {
    if (!doctype && lines[i].match(/^<\w/)) {
      doctype = lines[i].substring(lines[i].indexOf('<') + 1, lines[i].indexOf('>'));

      if (doctype.contains(' ')) {
        doctype = doctype.substring(0, doctype.indexOf(' '));
      }
      text.push('<!DOCTYPE ' + doctype + ' ' + Translate.doctypes[doctype.toLowerCase()] + '>');
    }
    if (lines[i].length > 0) {
      text.push(lines[i]);
    }
  }
  return text.join('\n');
};

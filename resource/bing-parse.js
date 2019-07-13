/*
 *  This file is part of the DITA-OT Translate Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

// Microsoft Translation. Copies text translated by Azure cloud services to a file
//
//	@param file - The name of a file holding the input text
//	@param out - The output file

var text = attributes.get("text");
var outproperty = attributes.get("outproperty");
var json = JSON.parse(text);
var trans = json[0].translations[0].text;
trans = trans.replace('\\"', '"');
trans = trans.replace('class="notranslate"', 'translate="no"');
project.setProperty(outproperty, trans);

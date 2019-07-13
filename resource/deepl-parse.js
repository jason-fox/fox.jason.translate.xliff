/*
 *  This file is part of the DITA-OT Translate Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

// 	Watson Translation. Parses the response and extracts the translated text
//
//	@param text - The response from Deepl
//	@param outproperty - The property to output to
//

var text = attributes.get("text");
var outproperty = attributes.get("outproperty");
var json = JSON.parse(text);
var trans = json.translations[0].text;
trans = trans.replace(/\\"/g, '"');
project.setProperty(outproperty, trans);

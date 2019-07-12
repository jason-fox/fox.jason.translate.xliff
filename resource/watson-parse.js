/*
 *  This file is part of the DITA-OT Translate Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

// 	Watson Translation. Parses the response and extracts the translated text
//
//	@param text - The response from IBM cloud services
//	@param outproperty - The property to output to
//

var text = attributes.get("text");
var outproperty = attributes.get("outproperty");
var json = JSON.parse(text);
project.setProperty(outproperty, json.translations[0].translation);
